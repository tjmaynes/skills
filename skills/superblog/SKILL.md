---
name: superblog
description: Generate a complete blog post with cross-platform social media copy, all organized in a dated directory structure. Use this skill whenever someone wants to write a blog post, create blog content, draft an article for their blog, or needs social media copy to promote a blog post. Also trigger when the user mentions writing for LinkedIn or X/Twitter to promote written content, or when they want to brainstorm and then publish a post.
license: MIT
metadata:
  generated-at: "2026-04-01T00:00:00Z"
  group: "content"
  category: "blogging"
  difficulty: "beginner"
  step-count: "4"
---

# Superblog

## What You'll Do
- Brainstorm and refine a blog post idea with the writer, exploring angles, audience, and tone
- Draft a complete, publish-ready blog post in Markdown
- Generate tailored social media copy for LinkedIn and X to promote the post
- Organize everything into a clean directory structure: `{blog-name}/posts/{YYYY-mm-dd}-{post-title}/`

---

## Phase 1 · Brainstorm & Ideate

The goal here is to help the writer move from a vague idea to a focused concept worth writing about. Good brainstorming uncovers the *angle* — the specific take that makes a post worth reading rather than just another article on the topic.

1. **Understand the idea**
   - Ask what the writer wants to write about. This could be anything from a single word ("observability") to a detailed pitch.
   - If they already have a clear concept, skip ahead to clarifying the angle. If it's fuzzy, help them explore.

2. **Explore angles**
   - Suggest 2–3 distinct angles the post could take. For example, a post about "developer onboarding" could be:
     - A personal story about a painful onboarding experience
     - A how-to guide for improving onboarding at a startup
     - An opinion piece arguing that most onboarding is broken
   - Ask which resonates or if they want to riff on a combination.

3. **Identify audience and tone**
   - Who is this for? Fellow engineers, hiring managers, general tech readers?
   - What tone fits? Conversational, authoritative, vulnerable, humorous?
   - Understanding the audience shapes everything — vocabulary, depth, examples.

4. **Nail down the details**
   - Confirm the blog name (this becomes the top-level directory).
   - Confirm the post title (used in the directory name and file frontmatter).
   - Ask about any must-include points, links, or references.
   - Ask about target length — a quick 500-word take, a thorough 1500-word guide, or something longer.

> **Outcome:** A clear post concept with a working title, defined audience, chosen tone, and any constraints or must-haves noted.

---

## Phase 2 · Draft the Blog Post

Now turn the brainstorm into a full, publish-ready post. The writer should be able to copy-paste this into their CMS with minimal edits.

1. **Plan the structure**
   - Outline 3–5 main sections before writing. Share this outline with the writer for a quick gut-check.
   - A strong post typically has: a hook that earns attention, a body that delivers on the hook's promise, and a closing that leaves the reader with something to do or think about.

2. **Write the draft**
   - Write in the agreed-upon tone. Match the writer's voice if prior posts exist — ask if they'd like you to read an older post for reference.
   - Use concrete examples, not abstractions. "We reduced deploy time from 45 minutes to 8" beats "We significantly improved deploy times."
   - Keep paragraphs short (2–4 sentences). Blog readers scan.
   - Use subheadings to break up the piece — they serve as an outline for scanners and give focused readers natural pause points.

3. **Add frontmatter**
   - Include YAML frontmatter with: `title`, `date`, `author`, `tags`, and `description` (a 1–2 sentence summary for SEO/previews).

4. **Review with the writer**
   - Present the full draft and ask for feedback before moving on. This is the most important review — the social copy in Phase 3 flows from the final post.

> **Checklist:** Post has a compelling title, clear structure, concrete examples, YAML frontmatter, and the writer has approved the draft.

---

## Phase 3 · Generate Social Media Copy

Social copy isn't just a shorter version of the post — each platform has its own culture and format. The goal is to make the writer look native on each platform, not like they pasted the same blurb everywhere.

1. **LinkedIn post**
   - **Format:** 1,300 characters max (LinkedIn truncates at ~210 characters with a "see more" fold). Front-load the hook above the fold.
   - **Tone:** Professional but personable. LinkedIn rewards vulnerability and lessons learned. First-person works well.
   - **Structure that works:**
     - Opening hook (1–2 lines that earn the "see more" click)
     - 3–5 short paragraphs or a numbered list with key takeaways
     - A closing question or call-to-action to drive comments
     - Link to the full post (place at the end — LinkedIn deprioritizes posts with links, so earn engagement first)
   - **Hashtags:** 3–5 relevant hashtags at the bottom. Mix broad (#SoftwareEngineering) with niche (#DevOnboarding).

2. **X (Twitter) post**
   - **Format:** 280 characters per tweet. Draft both a single-tweet version and a thread option (3–5 tweets).
   - **Single tweet:** Distill the post's core insight into one punchy line. Include the link. No hashtags needed unless they add real discoverability.
   - **Thread option:**
     - Tweet 1: Hook — the most surprising or contrarian claim from the post. No link yet.
     - Tweets 2–4: One key point per tweet. Use short sentences. Line breaks for readability.
     - Final tweet: The takeaway + link to the full post.
   - **Tone:** Direct, casual, confident. X rewards strong opinions and concise phrasing.

3. **Review social copy**
   - Present both platform versions and ask the writer to review. Social copy is personal — they may want to adjust the voice or emphasis.

> **Checklist:** LinkedIn post with hook above the fold, X single-tweet and thread versions, all within platform character limits, links included, writer has reviewed.

---

## Phase 4 · Assemble & Deliver

1. **Create directory structure**
   - Confirm the target location with the writer (share `pwd` so they know where files will land).
   - Create the directory: `{blog-name}/posts/{YYYY-mm-dd}-{post-title}/`
     - `blog-name`: the blog's name, kebab-cased (e.g., `my-tech-blog`)
     - `YYYY-mm-dd`: today's date
     - `post-title`: the post title, kebab-cased (e.g., `why-onboarding-is-broken`)
   - Example: `my-tech-blog/posts/2026-04-01-why-onboarding-is-broken/`

2. **Write files**
   - `post.md` — the full blog post with YAML frontmatter
   - `social.md` — the social media copy, organized by platform:
     ```markdown
     # Social Media Copy

     ## LinkedIn
     {linkedin post}

     ## X (Twitter)

     ### Single Tweet
     {single tweet}

     ### Thread
     {thread}
     ```

3. **Avoid overwrites**
   - If the directory already exists, confirm with the writer before overwriting. Offer to append a suffix (e.g., `-v2`) if they want to keep both versions.

4. **Publishing reminders**
   - After delivering the files, give the writer practical suggestions for getting the social posts out into the world. People often write great copy and then let it sit — a gentle nudge with specifics helps.
   - **LinkedIn:**
     - Suggest posting Tuesday–Thursday mornings (8–10am in the writer's timezone) when engagement tends to peak for professional content.
     - Remind them to post the text natively (not just a link) — LinkedIn's algorithm favors text-first posts. The link can go in the first comment or at the end of the post.
     - Suggest engaging with the first few comments quickly — the algorithm rewards early conversation.
   - **X (Twitter):**
     - Suggest posting the single tweet first and the thread a day or two later to get two bites at the apple.
     - Remind them to pin the thread to their profile if it performs well.
     - If the post is time-sensitive or tied to a trending conversation, flag that and suggest posting sooner rather than waiting for an "optimal" time.
   - **General tips:**
     - If the writer has a newsletter or RSS feed, remind them to cross-post or link there too.
     - Suggest resharing the LinkedIn post and X thread 1–2 weeks later with a fresh angle or follow-up thought — most of their audience won't have seen it the first time.

5. **Final summary**
   - Share the file paths for both `post.md` and `social.md`.
   - Offer to revise any section based on final feedback.
   - Suggest next steps: publish the post, schedule the social copy, or iterate further.

> **Checklist:** Directory created in the correct location, `post.md` and `social.md` written, publishing suggestions shared, no accidental overwrites, writer has the file paths and knows what to do next.

---

## Reference Templates

### post.md
```markdown
---
title: "Why Developer Onboarding Is Broken"
date: 2026-04-01
author: Your Name
tags: [onboarding, engineering-culture, developer-experience]
description: Most onboarding programs dump information on new hires instead of building context. Here's a better approach.
---

# Why Developer Onboarding Is Broken

Your opening hook goes here — a story, a bold claim, or a question that makes the reader want to keep going.

## The Problem
...

## A Better Approach
...

## What I'd Do Differently
...

## Wrapping Up
A closing thought and call to action.
```

### social.md
```markdown
# Social Media Copy

## LinkedIn

Most developer onboarding is just a checklist of tools to install and docs to read.

But the real onboarding — understanding *why* things are built a certain way — takes months of osmosis.

What if we designed for that from day one?

Here's what I learned after watching 20+ engineers struggle through their first sprint:

1. Context beats documentation
2. Pair programming > Confluence pages
3. The first PR should ship on day one

Full post: [link]

#DeveloperExperience #Onboarding #EngineeringCulture

## X (Twitter)

### Single Tweet
Most onboarding is broken because it teaches tools, not context. What if new engineers shipped their first PR on day one? [link]

### Thread
1/ Most developer onboarding is broken.

Not because companies don't try — but because they optimize for information transfer instead of context building.

2/ The typical onboarding:
- Install these 14 tools
- Read these 8 docs
- Shadow someone for a week
- Good luck

The problem? None of this builds understanding of *why* things work the way they do.

3/ What works better:
- Ship a real (small) PR on day one
- Pair with someone who explains the *why*, not just the *how*
- Replace docs with guided exploration

4/ Full post with the details and what I'd do differently: [link]
```

Use these templates as starting points — adapt the structure and voice to match each writer's style and topic.
