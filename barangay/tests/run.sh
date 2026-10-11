#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
find "$ROOT" -name '*.php' -not -path '*/vendor/*' -print0 | xargs -0 -n1 php -l >/dev/null
for file in database.sql login.php verify_otp.php staff_accounts.php audit.php notifications.php privacy.php privacy_admin.php issue_document.php verify.php backup.php backup_cron.php; do test -s "$ROOT/$file"; done
grep -q 'CREATE TABLE IF NOT EXISTS audit_logs' "$ROOT/database.sql"
grep -q 'CREATE TABLE IF NOT EXISTS login_challenges' "$ROOT/database.sql"
grep -q 'CREATE TABLE IF NOT EXISTS document_verifications' "$ROOT/database.sql"
grep -q 'No residents, staff' "$ROOT/retention.php"
echo "Barangay capstone smoke tests passed"
grep -q 'name="from"' "$ROOT/reports.php"
grep -q 'format=pdf' "$ROOT/reports.php"
grep -q 'application/pdf' "$ROOT/report_export.php"
grep -q 'application/msword' "$ROOT/report_export.php"
grep -q 'print_document.php?id=' "$ROOT/documents.php"
grep -q 'onclick="return confirm' "$ROOT/partials/header.php"
grep -q 'overflow-y:auto' "$ROOT/assets/app.css"

grep -q 'document_fee_settings' "$ROOT/database.sql"
grep -q 'Document fees' "$ROOT/partials/header.php"
test -s "$ROOT/fees.php"
grep -q 'report_export.php?format=pdf' "$ROOT/reports.php"
grep -q 'Document requests by type' "$ROOT/report_export.php"

grep -q 'elected_officials' "$ROOT/database.sql"
test -s "$ROOT/elected_officials.php"
grep -q 'official-sidebar' "$ROOT/partials/header.php"
grep -q 'archived' "$ROOT/staff_accounts.php"
grep -q 'from' "$ROOT/reports.php"
grep -q 'report_exported' "$ROOT/report_export.php"
python3 -m json.tool "$ROOT/manus-routes.json" >/dev/null
echo "Archive, officials, and ranged reports smoke tests passed"
grep -q 'blotter-layout' "$ROOT/blotters.php"
grep -q 'selected-row' "$ROOT/blotters.php"
grep -q 'form_action.*archive' "$ROOT/staff_accounts.php"
grep -q 'Mark as archived' "$ROOT/staff_accounts.php"
grep -q 'Mark as archived' "$ROOT/elected_officials.php"
! grep -R -n -E 'DELETE FROM (users|elected_officials)' "$ROOT/staff_accounts.php" "$ROOT/elected_officials.php"
echo "Blotter UI and archive-only smoke tests passed"
