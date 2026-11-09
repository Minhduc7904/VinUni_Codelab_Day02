# Rebuild the deterministic workflow figure without external packages.
Add-Type -AssemblyName System.Drawing
$diagramRoot = Split-Path -Parent $PSScriptRoot
$diagramPath = Join-Path $diagramRoot '04-workflow-diagram.png'
$bitmap = [System.Drawing.Bitmap]::new(1600, 1760)
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
$graphics.Clear([System.Drawing.ColorTranslator]::FromHtml('#F1F5F9'))
$titleFont = [System.Drawing.Font]::new('Segoe UI', 32, [System.Drawing.FontStyle]::Bold)
$stepFont = [System.Drawing.Font]::new('Segoe UI', 23, [System.Drawing.FontStyle]::Bold)
$bodyFont = [System.Drawing.Font]::new('Segoe UI', 19)
$smallFont = [System.Drawing.Font]::new('Segoe UI', 16)
$ink = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml('#0F172A'))
$muted = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml('#475569'))
$blue = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml('#1D4ED8'))
$red = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml('#B91C1C'))
$white = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
$arrowPen = [System.Drawing.Pen]::new([System.Drawing.ColorTranslator]::FromHtml('#64748B'), 4)
$arrowPen.EndCap = [System.Drawing.Drawing2D.LineCap]::ArrowAnchor
$graphics.DrawString('VINFAST | QUY TRÌNH TIẾP NHẬN BẢO HÀNH', $titleFont, $ink, 70, 38)
$graphics.DrawString('CURRENT STATE · Minh · Phạm vi: tiếp nhận – phân loại – đề xuất điều phối', $bodyFont, $muted, 74, 105)
$steps = @(
    @{title='1. Tiếp nhận khiếu nại'; minutes='3 phút'; actor='CSKH · App/Hotline và CRM'; input='Mô tả của khách hàng'; output='Ticket ban đầu'; handoff='Khách hàng → CSKH → CRM'; slow=$false},
    @{title='2. Tra cứu thông tin xe và lịch sử'; minutes='10 phút'; actor='CSKH · CRM / DMS / dữ liệu được cấp quyền'; input='Thông tin định danh xe đã xác minh'; output='Hồ sơ, lịch sử và dữ liệu còn thiếu'; handoff='CSKH ↔ CRM / DMS'; slow=$true},
    @{title='3. Phân loại sơ bộ, hỏi bổ sung'; minutes='15 phút'; actor='CSKH phối hợp cố vấn kỹ thuật'; input='Mô tả triệu chứng và lịch sử liên quan'; output='Nhóm khiếu nại, dấu hiệu cần ưu tiên kiểm tra'; handoff='CSKH ↔ Khách hàng / Cố vấn kỹ thuật'; slow=$true},
    @{title='4. Đối chiếu và đề xuất xưởng'; minutes='7 phút'; actor='CSKH phối hợp xưởng · Danh mục năng lực / lịch tiếp nhận'; input='Nhóm khiếu nại, địa điểm và điều kiện tiếp nhận'; output='Xưởng đề xuất, trạng thái tiếp nhận đã xác minh'; handoff='CSKH ↔ Cố vấn dịch vụ / Xưởng'; slow=$false},
    @{title='5. Kiểm tra và gửi phản hồi'; minutes='5 phút'; actor='CSKH · CRM và mẫu phản hồi'; input='Kết quả đối chiếu với xưởng'; output='Phản hồi đã duyệt, cập nhật CRM'; handoff='CSKH → Khách hàng; cập nhật CRM'; slow=$false}
)
for ($diagramIndex = 0; $diagramIndex -lt $steps.Count; $diagramIndex++) {
    $step = $steps[$diagramIndex]
    $boxY = 190 + $diagramIndex * 266
    $fillColor = if ($step.slow) { '#FEF2F2' } else { '#FFFFFF' }
    $boxBrush = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml($fillColor))
    $graphics.FillRectangle($boxBrush, 75, $boxY, 1450, 202)
    $graphics.FillRectangle($(if ($step.slow) { $red } else { $blue }), 75, $boxY, 9, 202)
    $graphics.DrawString($step.title, $stepFont, $ink, 105, ($boxY + 13))
    $timeLabel = $step.minutes + $(if ($step.slow) { ' | BOTTLENECK' } else { '' })
    $graphics.DrawString($timeLabel, $bodyFont, $(if ($step.slow) { $red } else { $blue }), 1100, ($boxY + 20))
    $graphics.DrawString($step.actor, $bodyFont, $muted, 105, ($boxY + 62))
    $graphics.DrawString(('Đầu vào: ' + $step.input), $bodyFont, $ink, 105, ($boxY + 108))
    $graphics.DrawString(('Đầu ra: ' + $step.output), $bodyFont, $ink, 105, ($boxY + 151))
    $graphics.DrawString(('HANDOFF: ' + $step.handoff), $smallFont, $blue, 100, ($boxY + 214))
    if ($diagramIndex -lt 4) { $graphics.DrawLine($arrowPen, 800, ($boxY + 207), 800, ($boxY + 256)) }
    $boxBrush.Dispose()
}
$graphics.DrawString('TỔNG: 40 PHÚT/TICKET  |  BOTTLENECK: 25/40 PHÚT (62,5%)', $stepFont, $ink, 75, 1550)
$graphics.DrawString('Đỏ: bước tốn thời gian · HANDOFF: điểm chuyển giao thông tin.', $bodyFont, $muted, 75, 1610)
$graphics.DrawString('Thời gian và công cụ là giả định thiết kế; cần xác minh với VinFast.', $bodyFont, $muted, 75, 1650)
$graphics.DrawString('Chỉ tính thao tác; không gồm chờ khách/xưởng, kiểm định, sửa chữa hoặc đóng khiếu nại.', $smallFont, $muted, 75, 1695)
$bitmap.Save($diagramPath, [System.Drawing.Imaging.ImageFormat]::Png)
$graphics.Dispose()
$bitmap.Dispose()
foreach ($item in @($titleFont, $stepFont, $bodyFont, $smallFont, $ink, $muted, $blue, $red, $white, $arrowPen)) { $item.Dispose() }
Write-Output $diagramPath
