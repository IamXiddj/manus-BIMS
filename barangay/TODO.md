# Remaining implementation outcomes

- **Evidence access:** Staff can view and download evidence for document requests and blotter reports; the UI shows original filename, upload date, file type, and size; access is authorization-checked and audit-logged.
- **Official identity and templates:** Authorized staff can maintain the actual barangay name, municipality, province, logo/seal URL, official address, contact details, Punong Barangay name, signatory names, official wording, and payment instructions; official printouts use these values.
- **Live dashboard and permissions:** Dashboard queue values and navigation badges come from live database counts; fee management remains limited to administrator, records officer, or treasurer.
- **Announcement lifecycle:** Staff can edit announcements, save drafts, publish/unpublish with confirmation, archive announcements, and review audit events.
- **Password recovery:** Users can request a password reset using an email OTP/token, change a password while signed in, and cannot reuse recent password history; administrator recovery remains email-controlled.
- **Backup continuity:** The UI and documentation explain decrypting encrypted backups, importing into a separate database, verifying data, switching application configuration, and recovering from failed imports; no destructive one-click restore exists.
- **Security and audit coverage:** Uploads are non-public and non-executable, secrets are environment-backed, and login, OTP, document issuance, fee changes, status changes, staff changes, backup creation, attachment access, and report exports are audit events.
