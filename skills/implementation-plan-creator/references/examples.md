# Implementation Plan Examples

Reference examples for creating feature implementation plans.

## Example 1: Add Dark Mode Toggle

A complete, detailed example showing all sections of an implementation plan.

```markdown
# Add Dark Mode Toggle

## Overview
Enable users to switch between light and dark themes with preference persistence across sessions. This improves usability for users working in low-light environments and reduces eye strain during evening work.

## Requirements
- Users can toggle dark mode from the Settings page
- Dark mode preference persists across browser sessions using localStorage
- All UI elements remain readable in both light and dark modes
- Dark mode works consistently on mobile and desktop viewports
- Theme applies instantly without page reload or flash of unstyled content

## Non-Goals
- Dark mode customization or user-defined color palettes (future enhancement)
- Mobile app support (web only for now)
- Performance optimization for 10,000+ rapid theme switches
- Integration with OS-level dark mode preferences (may add later)

## Acceptance Criteria
- [ ] Dark mode toggle button appears in Settings with clear label
- [ ] Clicking toggle switches all UI to dark colors instantly
- [ ] User preference saves to localStorage on toggle
- [ ] Dark mode persists after page refresh and browser restart
- [ ] WCAG contrast ratio ≥ 4.5:1 for all text in both modes
- [ ] No flashing or unsetyled content on page load
- [ ] All tests pass with both theme variants
- [ ] No console errors in dark mode
- [ ] Works in Chrome, Firefox, Safari (latest 2 versions)

## Effort
**Estimated Effort:** Medium (3-4 days)

**Context:** Requires design review and cross-browser testing. Theme initialization logic adds complexity to prevent flash of unstyled content.

## Implementation

### Approach
Use CSS custom properties (variables) for all color definitions with React Context API for state management. Store theme preference in localStorage for persistence. Initialize theme from localStorage in useEffect before initial render to prevent flash. Implement storage event listener to sync theme across browser tabs.

### Implementation Steps

1. **Create ThemeContext for state management** - `src/context/ThemeContext.tsx`
   - Create React Context to manage theme state and localStorage persistence
   - Initialize theme from localStorage on mount to avoid flash of unstyled content
   - Suggested code based on existing context patterns in the codebase:
   ```typescript
   import React, { createContext, useState, useEffect } from 'react'

   export const ThemeContext = createContext()

   export function ThemeProvider({ children }) {
     const [theme, setTheme] = useState('light')

     useEffect(() => {
       const saved = localStorage.getItem('theme') || 'light'
       setTheme(saved)
     }, [])

     const toggleTheme = () => {
       const newTheme = theme === 'light' ? 'dark' : 'light'
       setTheme(newTheme)
       localStorage.setItem('theme', newTheme)
     }

     return (
       <ThemeContext.Provider value={{ theme, toggleTheme }}>
         {children}
       </ThemeContext.Provider>
     )
   }
   ```

2. **Create useTheme hook** - `src/hooks/useTheme.ts`
   - Custom hook to access theme context from components
   - Suggested implementation:
   ```typescript
   import { useContext } from 'react'
   import { ThemeContext } from '../context/ThemeContext'

   export function useTheme() {
     return useContext(ThemeContext)
   }
   ```

3. **Add toggle button to Settings** - `src/components/Settings.tsx`
   - Add theme toggle control with clear label and visual feedback
   - Use existing button styles from the component library for consistency

4. **Define CSS variables** - `src/styles/colors.css`
   - Create CSS custom properties for light and dark themes using patterns from existing stylesheets
   - Suggested structure:
   ```css
   [data-theme="light"] {
     --bg-primary: #ffffff;
     --text-primary: #000000;
   }

   [data-theme="dark"] {
     --bg-primary: #1e1e1e;
     --text-primary: #ffffff;
   }
   ```

5. **Apply theme globally** - `src/styles/index.css`
   - Import colors.css and apply theme variables to base elements

6. **Wrap app with ThemeProvider** - `src/App.tsx`
   - Initialize theme context at root level so all components can access it

7. **Add theme switching tests** - `tests/theme.test.ts`
   - Test localStorage persistence, tab synchronization, and UI updates
   - Follow existing test patterns in the codebase

## Risks
- Risk: Flash of unstyled content (FOUC) on page load before localStorage is read
  Mitigation: Read preference in useEffect with early return before render, use inline script for instant initialization

- Risk: CSS variable support in legacy browsers (IE11, older Safari)
  Mitigation: Feature detect with PostCSS fallback variables or drop legacy browser support

- Risk: Cross-tab theme synchronization lag
  Mitigation: Use storage event listener to update theme in real-time across tabs

- Risk: Conflicts with existing CSS custom property definitions
  Mitigation: Audit existing CSS first, use namespaced variable names (--theme-*)

## Dependencies
- React 18+ (already installed)
- No new npm dependencies required
- CSS custom properties support (modern browsers)
- Design team sign-off on color palettes for light and dark modes

## References
- [MDN: CSS Custom Properties](https://developer.mozilla.org/en-US/docs/Web/CSS/--*)
- [localStorage API](https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage)
- [Web Storage Events](https://developer.mozilla.org/en-US/docs/Web/API/Web_Storage_API#events)
- [Design System Color Palettes](https://internal-wiki.example.com/colors)
```

---

## Example 2: Add Email Verification (Good Pattern)

A smaller, well-structured example showing correct plan formatting.

```markdown
# Add Email Verification

## Overview
Enable users to verify email during signup to improve account security and deliverability. Verification must complete before users can access full features.

## Requirements
- Users receive verification email immediately after signup
- Verification link expires after 24 hours
- Users can request a new verification email
- Unverified users have limited dashboard access
- Verified email displays in user profile

## Non-Goals
- SMS verification (email only)
- Multi-factor authentication (separate feature)
- Email domain validation beyond basic format check
- Bulk re-verification of existing users

## Acceptance Criteria
- [ ] Verification email sent on signup with valid link
- [ ] Link expires after 24 hours with appropriate error message
- [ ] User can request new verification email
- [ ] Unverified users see limited dashboard content
- [ ] Email verified successfully changes user status
- [ ] All edge cases handled (expired link, invalid token)
- [ ] Tests cover email sending and verification flow

## Effort
**Estimated Effort:** Medium (3-4 days)

**Context:** Integration with email service adds some complexity. Requires coordination with product team on user messaging.

## Implementation

### Approach
Use email service (SendGrid/AWS SES) for sending verification emails. Store verification token in database with expiration timestamp. Update user model to track email verification status. Implement endpoint to verify email and expire old tokens.

### Implementation Steps

1. **Create email service** - `src/services/email.ts`
   - Create service to handle email sending using SendGrid/AWS SES
   - Include retry logic with exponential backoff for failed sends
   - Suggested implementation based on existing service patterns:
   ```typescript
   import sendgrid from '@sendgrid/mail'

   export async function sendVerificationEmail(email: string, token: string) {
     const verifyUrl = `${process.env.APP_URL}/verify-email?token=${token}`

     try {
       await sendgrid.send({
         to: email,
         from: 'noreply@app.com',
         subject: 'Verify your email',
         html: `<a href="${verifyUrl}">Verify Email</a>`
       })
     } catch (error) {
       // Implement retry logic
       throw error
     }
   }
   ```

2. **Update user model** - `src/models/user.ts`
   - Add `emailVerified` boolean field (default: false)
   - Add `verificationToken` string field (nullable)
   - Add `tokenExpiresAt` timestamp field (nullable)
   - Follow existing model patterns from the codebase

3. **Create verification endpoint** - `src/api/auth.ts`
   - Add endpoint to validate token and mark email as verified
   - Implement token expiration check (24 hours)
   - Clear token after successful verification
   - Add rate limiting (1 resend per minute)

4. **Create verification page** - `src/pages/verify-email.tsx`
   - Display loading state while validating token
   - Show success message and redirect to dashboard on valid token
   - Show clear error message for expired or invalid tokens
   - Provide option to resend verification email
   - Use existing page layouts and styling from codebase

5. **Add email verification tests** - `tests/email.test.ts`
   - Test successful verification flow
   - Test expired token handling
   - Test rate limiting on resend requests
   - Follow existing test patterns in the codebase

## Risks
- Risk: Email delivery delays or failures
  Mitigation: Implement retry logic with exponential backoff

- Risk: Token security and uniqueness
  Mitigation: Use cryptographically secure random token generation

- Risk: Rate limiting on verification requests
  Mitigation: Limit resend requests to 1 per minute

## Dependencies
- SendGrid email service (free tier available)
- jsonwebtoken for token generation
- Product team approval on user flow

## References
- [Email verification best practices](https://blog.mailgun.com/email-verification-best-practices/)
- [OWASP: Email verification security](https://owasp.org/www-community/attacks/Email_Verification)
```

---

## Tips for Writing Implementation Plans

### Effort Estimation
- **Small (1-2 days)**: Single file/component change, well-defined scope, no blockers
- **Medium (3-5 days)**: Multiple files, requires design/testing, some unknown complexity
- **Large (6+ days)**: Major feature, multi-system impact, significant unknowns, dependencies

### Non-Goals Discipline
Good non-goals:
- ✅ "Dark mode customization or user-defined palettes (future enhancement)"
- ✅ "Mobile app support (web only for now)"

Bad non-goals:
- ❌ "Performance optimization" (too vague, could apply to many things)
- ❌ Nothing listed (doesn't set scope boundaries)

### Risk Identification
Focus on:
- Technical blockers or unknowns
- Cross-system dependencies
- Browser/environment constraints
- Team/approval dependencies
- Integration challenges

### Acceptance Criteria Mistakes to Avoid
- ❌ "Feature works" (too vague)
- ❌ "No bugs" (undefined)
- ✅ "Toggle button appears in Settings with label"
- ✅ "WCAG contrast ratio ≥ 4.5:1 for all text"

---

## When Plans Work Well

A good implementation plan should:
1. ✅ Answer "What?" and "Why?" in Overview
2. ✅ Set clear boundaries with Non-Goals
3. ✅ Define success with Acceptance Criteria
4. ✅ Estimate effort realistically (S/M/L)
5. ✅ Surface risks upfront with mitigations
6. ✅ List external dependencies and constraints
7. ✅ Be 1-2 pages of markdown (not 10+ pages)

Plans fail when they:
- ❌ Are vague ("Add user profile")
- ❌ Have no non-goals (scope creep inevitable)
- ❌ Have unmeasurable acceptance criteria
- ❌ Estimate in hours instead of S/M/L
- ❌ Skip risks entirely
- ❌ Are too detailed (specification vs. plan)
