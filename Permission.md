# Menu & Action Permission

เอกสารนี้ใช้เป็นรายการอ้างอิงกลางของหน้า Permission ว่าระบบมีเมนูและปุ่ม action อะไรบ้าง

สำคัญ: หากอนาคตมีการเพิ่มเมนูใหม่ หรือเพิ่มปุ่ม action ใหม่ในระบบ ให้ update ไฟล์ `Permission.md` นี้ทุกครั้ง พร้อมกับ update mapping ในหน้า Permission และ logic สิทธิ์ที่เกี่ยวข้อง

## Menu Permission

ถ้าไม่ติ๊กเมนูใด ผู้ใช้คนนั้นจะไม่เห็นเมนูนั้นใน sidebar

| Key | Menu |
| --- | --- |
| `dashboard` | Dashboard |
| `inventory` | Inventory |
| `suppliers` | Suppliers |
| `purchase` | Purchase |
| `purchaseBom` | BOM |
| `purchasePr` | Requisition (PR) |
| `purchasePo` | Order List (PO) |
| `purchaseGr` | Goods Receipt (GR) |
| `wim` | WIM |
| `wimRequest` | WIM Request |
| `wimStoreReview` | Store Review |
| `wimHistory` | WIM History |
| `reservation` | Reservation |
| `borrow` | Borrow / Return |
| `equipment` | Equipment Tracking |
| `budget` | Project Budget |
| `convert` | Convert |
| `convertRequest` | Convert Request |
| `convertHistory` | Convert History |
| `history` | History |

## Action Permission

Action Permission อยู่ใต้ Menu Permission ตามหมวดของตัวเอง ต้องเปิด modal Permission ของ user แล้วกดเปิด Action Permission ในเมนูนั้นก่อนจึงจะติ๊กได้

### BOM

| Key | Action |
| --- | --- |
| `bomCreate` | BOM Create |
| `bomUpdate` | BOM Update |
| `bomDelete` | BOM Delete |

### Requisition (PR)

| Key | Action |
| --- | --- |
| `prCreate` | PR Create |
| `prUpdate` | PR Update |
| `prSubmit` | PR Submit |
| `prDelete` | PR Delete |
| `prCancel` | PR Cancel |
| `prConvert` | PR Convert |

### WIM Request

| Key | Action |
| --- | --- |
| `wimCreate` | WIM Create |
| `wimUpdate` | WIM Update |

### Store Review

| Key | Action |
| --- | --- |
| `wimReview` | WIM Store Review |

### Order List (PO)

| Key | Action |
| --- | --- |
| `poUpdate` | PO Update |
| `poRequestReview` | PO Request Review |
| `poConfirmReview` | PO Confirm Review |
| `poSplit` | PO Split |
| `poApprove` | PO Approve |
| `poReject` | PO Reject |
| `poSendGr` | PO Send GR |

### Goods Receipt (GR)

| Key | Action |
| --- | --- |
| `grUpdate` | GR Update |
| `grReceive` | GR Receive |
| `grClose` | GR Close |

### Reservation

| Key | Action |
| --- | --- |
| `issueCreate` | Reservation Create |
| `issueApprove` | Reservation Approve |
| `issueWithdraw` | Reservation Withdraw |
| `issueCancel` | Reservation Cancel |

## Current Implementation Notes

- Permission page เห็นได้เฉพาะ `ADMIN`
- `Menu Permission` ใช้ซ่อนหรือแสดงเมนูใน sidebar
- `Action Permission` ใช้ควบคุมปุ่มและ API action ภายในหมวดที่เกี่ยวข้อง
- `PO Approve` มีฟิลด์วงเงินอนุมัติ `Approve Amount Range` รูปแบบ `min - max` เช่น `1 - 10,000`; หากกำหนดไว้ ระบบจะอนุญาตให้ approve เฉพาะใบ PO ที่ยอดรวมสุทธิอยู่ในช่วงนั้น
- ค่า permission ถูกเก็บใน table `UserPermission`
- ถ้า user ยังไม่มี permission row ระบบจะ default ให้เห็นเมนูและ action ทั้งหมด
- หากแก้ permission ของ account ที่กำลัง login อยู่ ระบบจะ reload เพื่อ refresh sidebar

## When Adding New Menu Or Action

เมื่อเพิ่มเมนูหรือ action ใหม่ ให้ทำครบตาม checklist นี้

1. เพิ่ม key ใน `Permission.md`
2. เพิ่ม key ใน backend permission normalize/default logic
3. เพิ่มเมนูหรือ action ในหน้า Permission modal
4. เพิ่ม sidebar visibility mapping ถ้าเป็นเมนูใหม่
5. เพิ่ม frontend action guard ถ้าเป็นปุ่ม action ใหม่
6. เพิ่ม backend permission guard ถ้าเป็น API action ใหม่
7. ทดสอบด้วย user ที่ติ๊กและไม่ติ๊ก permission นั้น
