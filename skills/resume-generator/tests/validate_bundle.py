"""Contract and RenderCV smoke tests for the resume-generator skill bundle."""

from __future__ import annotations

import subprocess
import tempfile
import unittest
from pathlib import Path

from ruamel.yaml import YAML


REPOSITORY_ROOT = Path(__file__).resolve().parents[4]
SKILL_ROOT = Path(__file__).resolve().parents[1]
FIXTURES = SKILL_ROOT / "tests" / "fixtures"
YAML_PARSER = YAML(typ="safe")


class ResumeGeneratorBundleTests(unittest.TestCase):
    def require_file(self, path: Path) -> str:
        self.assertTrue(path.is_file(), f"missing required bundle file: {path}")
        return path.read_text(encoding="utf-8")

    def test_required_bundle_files_exist(self) -> None:
        for relative_path in (
            "SKILL.md",
            "reference-resume.yaml",
            "references/fit-rubric.md",
            "tests/fixtures/career.yaml",
            "tests/fixtures/workflow-cases.yaml",
        ):
            self.assertTrue(
                (SKILL_ROOT / relative_path).is_file(),
                f"missing required bundle file: {relative_path}",
            )

    def test_fixture_career_schema_and_employer_references(self) -> None:
        fixture = SKILL_ROOT / "tests" / "fixtures" / "career.yaml"
        content = self.require_file(fixture)
        data = YAML_PARSER.load(content)
        required_keys = {
            "name",
            "email",
            "website",
            "social_networks",
            "summary",
            "skills",
            "education",
            "employers",
            "work_projects",
            "personal_projects",
            "certifications",
        }
        self.assertTrue(required_keys.issubset(data), "fixture lacks canonical career fields")
        for project in data["work_projects"]:
            self.assertIn(project["employer_id"], data["employers"])

    def test_reference_resume_has_rendercv_structure(self) -> None:
        reference = SKILL_ROOT / "reference-resume.yaml"
        data = YAML_PARSER.load(self.require_file(reference))
        self.assertTrue({"cv", "design", "locale"}.issubset(data))
        sections = data["cv"]["sections"]
        self.assertTrue(
            {"summary", "skills", "experience", "education", "certificates"}.issubset(
                sections
            )
        )

    def test_rubric_has_required_weights_and_safeguards(self) -> None:
        rubric = self.require_file(SKILL_ROOT / "references" / "fit-rubric.md")
        for required_text in (
            "Requirements match | 40",
            "Relevant impact | 25",
            "Seniority and scope | 20",
            "Evidence strength | 15",
            "missing must-have",
            "not a prediction",
            "keyword stuffing",
        ):
            self.assertIn(required_text, rubric)

    def test_workflow_cases_cover_required_gates(self) -> None:
        cases = YAML_PARSER.load(
            self.require_file(FIXTURES / "workflow-cases.yaml")
        )
        expected_cases = {
            "inaccessible_job_url",
            "invalid_career_yaml",
            "unresolved_employer",
            "fit_below_threshold",
            "fit_above_threshold_without_approval",
            "existing_destination",
            "rendercv_unavailable",
            "approved_success",
        }
        self.assertEqual(expected_cases, set(cases))

    def test_skill_workflow_has_required_inputs_and_gates(self) -> None:
        skill = self.require_file(SKILL_ROOT / "SKILL.md")
        for required_text in (
            "RenderCV",
            "career.yaml",
            "pasted job description",
            "90/100",
            "explicit approval",
            "resumes/<company-name>-<role>/<yyyy-mm-dd>/",
            "read-only",
        ):
            self.assertIn(required_text, skill)

    def test_skill_workflow_covers_career_schema_safeguards(self) -> None:
        skill = self.require_file(SKILL_ROOT / "SKILL.md")
        for required_text in (
            "employer_id",
            "personal_projects",
            "date overlap",
            "expired certifications",
            "duplicate project names",
            "source citation",
        ):
            self.assertIn(required_text, skill)

    def test_readme_documents_local_skill_validation(self) -> None:
        readme = self.require_file(REPOSITORY_ROOT / "README.md")
        for required_text in (
            "resume-generator",
            "unittest discover",
            "python -m rendercv render",
        ):
            self.assertIn(required_text, readme)

    def test_reference_resume_renders_to_nonempty_pdf(self) -> None:
        reference = SKILL_ROOT / "reference-resume.yaml"
        self.require_file(reference)
        with tempfile.TemporaryDirectory() as temporary_directory:
            output_pdf = Path(temporary_directory) / "reference-resume.pdf"
            result = subprocess.run(
                [
                    str(REPOSITORY_ROOT / ".venv" / "bin" / "python"),
                    "-m",
                    "rendercv",
                    "render",
                    str(reference),
                    "--pdf-path",
                    str(output_pdf),
                    "--output-folder",
                    temporary_directory,
                ],
                capture_output=True,
                text=True,
                check=False,
            )
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertTrue(output_pdf.is_file())
            self.assertGreater(output_pdf.stat().st_size, 0)


if __name__ == "__main__":
    unittest.main()
