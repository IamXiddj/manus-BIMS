<?php
require_once __DIR__ . '/includes/auth.php';
require_permission('fees');
$pdo=db();
if($_SERVER['REQUEST_METHOD']==='POST'){
 verify_csrf();
 foreach(($_POST['fees']??[]) as $type=>$value){
  $fee=max(0,(float)$value);
  $stmt=$pdo->prepare('UPDATE document_fee_settings SET fee=?,updated_by=? WHERE document_type=?');
  $stmt->execute([$fee,current_user()['id'],$type]);
 }
 audit_action('document_fees_updated','document_fee_settings',null,'Updated official document fee schedule');
 flash('success','Document fees updated. New requests will use the new schedule; existing requests keep their recorded fee.');
 redirect('fees.php');
}
$fees=$pdo->query('SELECT * FROM document_fee_settings ORDER BY id')->fetchAll();
$pageTitle='Document fees';$activePage='fees';require __DIR__.'/partials/header.php';
?><section class="section-heading"><div><div class="eyebrow">Administration / Service pricing</div><h1>Document fees</h1><p>Maintain the official manual fee schedule used for new document requests.</p></div><a class="secondary-button" href="documents.php">Back to document desk</a></section><div class="priority-banner"><span class="priority-icon">₱</span><div><strong>Manual payment only</strong><small>The system records the fee for staff reference. Payment and official receipt issuance remain with the barangay treasurer.</small></div></div><section class="panel form-panel"><div class="card-header"><div><div class="eyebrow">Fee schedule</div><h2>Current document fees</h2></div><span class="muted">Applied to new requests</span></div><form method="post" class="form-grid single-form"><input type="hidden" name="csrf" value="<?= h(csrf_token()) ?>"><?php foreach($fees as $item): ?><label><?= h($item['document_type']) ?><div class="fee-input"><span>₱</span><input type="number" min="0" step="0.01" name="fees[<?= h($item['document_type']) ?>]" value="<?= h(number_format((float)$item['fee'],2,'.','')) ?>" required></div><small class="field-help">Last updated <?= h(date('M d, Y h:i A',strtotime($item['updated_at']))) ?></small></label><?php endforeach; ?><div class="form-actions"><button class="primary-button">Save fee schedule</button></div></form></section><section class="panel form-panel"><div class="eyebrow">Record policy</div><h2>Historical fees are preserved</h2><p class="login-copy">Changing a fee does not alter existing document requests. Every request stores the fee that applied when it was submitted, supporting accurate reports and audit review.</p></section><?php require __DIR__.'/partials/footer.php'; ?>
