# MANUS-BIMS production-readiness continuation

## Approach
Extend the existing PHP/MySQL/XAMPP application in place. Preserve PDO prepared statements, session auth, CSRF protection, role permissions, escaped output, and the current responsive civic-service UI.

## Deliverables
- Protected attachment viewer/downloader for document requests and blotter reports, with original filename, upload date, MIME type, size, authorization checks, non-public execution protection, and attachment-access audit events.
- Live dashboard/navigation counts instead of hard-coded queue badges and date copy.
- Barangay profile/settings storage and an administrator-facing settings page used by official print templates.
- Announcement create/edit, draft/publish/unpublish, archive, and audit actions.
- Forgot-password OTP reset, authenticated password change, password history/reuse prevention, rate limiting, and audit events.
- Backup/restore runbook documenting encrypted backup decryption, isolated import verification, configuration switch, and failed-import recovery; no destructive one-click restore.
- Database migration additions, route manifest, and smoke tests for new behavior.

## Design direction
**Movement:** calm civic-service editorial UI. **Principles:** trustworthy hierarchy, operational clarity, restrained warmth, and visible accountability. **Palette:** deep ink and civic blue communicate institutional reliability, mint/amber/violet provide status meaning without decorative noise. **Layout:** information-dense two-column workspaces with a persistent navigation rail and focused detail panels. **Signature elements:** compact eyebrow labels, status pills, and document-style metadata panels. **Interaction:** every mutation is explicit, CSRF-protected, and followed by a flash message; destructive actions are replaced by archive/suspend controls. **Animation:** minimal, limited to focus and status transitions. **Typography:** existing system sans for the app, serif for official document printouts. **Brand:** “A clear, accountable front desk for every barangay service.” Personality: dependable, human, precise. Voice: direct and reassuring; “Keep the record clear.” / “Every request has a trace.” **Wordmark:** existing two-bar civic mark retained. **Ownable color:** civic blue #1769aa.

## Project structure
- Root PHP routes: authenticated staff, resident, public verification, and recovery pages.
- `includes/`: shared session, authorization, audit, notifications, upload, and settings helpers.
- `config/`: database and mail environment-backed configuration.
- `assets/`: stylesheet and protected attachment storage.
- `database.sql`: fresh-install schema plus additive migrations for existing databases.
- `tests/run.sh`: syntax, route, schema, and security smoke checks.
