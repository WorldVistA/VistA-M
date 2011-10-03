SPNADR1 ;HISC/DAD-AD HOC REPORTS: INTERFACE FOR THE SCD (SPINAL CORD) REGISTRY FILE (#154) ;08/23/96  14:47
 ;;2.0;Spinal Cord Dysfunction;**11,12,13,14,15,19**;01/02/1997
 ;;2.0;QM Integration Module;;Apr 06, 1994
MENU ; *** Build the menu array
 F SP=1:1 S X=$P($T(TEXT+SP),";",3,99) Q:X=""  D
 . S SPNMENU(SPNMENU)=X,SPNMENU=SPNMENU+1
 . Q
 Q
TEXT ;;*** Sort Yes/No ^ Menu Text ^ ~Field # ^ DIR(0)
 ;;1^Extent of SCI^~6.09;"Extent of SCI"^SAOM^C:COMPLETE;I:INCOMPLETE;^D SET^SPNAHOC2
 ;;1^Annual Eval Offered^7,~.01;"Annual Rehab Eval Offered"^DAO^::AETS^D DATE^SPNAHOC2
 ;;1^Annual Eval Received^7,~1;"Annual Rehab Eval Received"^DAO^::AETS^D DATE^SPNAHOC2
 ;;1^Next Annual Eval Due^7,~2;"Next Annual Rehab Eval Due"^DAO^::AETS^D DATE^SPNAHOC2
 ;;1^Last Annual Eval Offered^~999.06;"Last Annual Rehab Eval Offered"^DAO^::AETS^D DATE^SPNAHOC2
 ;;1^Last Annual Eval Received^~999.07;"Last Annual Rehab Eval Rcd"^DAO^::AETS^D DATE^SPNAHOC2
 ;;1^Last Annual Eval Due^~999.08;"Last Annual Rehab Eval Due"^DAO^::AETS^D DATE^SPNAHOC2
 ;;1^Primary Care Provider^~8.1;"Primary Care Provider"^PAO^200:AEMNQZ^D POINTER^SPNAHOC2
 ;;1^SCD-Registry Coordinator^~8.2;"SCD-Registry Coordinator"^PAO^200:AEMNQZ^D POINTER^SPNAHOC2
 ;;1^Referral Source^~8.3;"Referral Source"^SAOM^1:OTHER VA;2:COMMUNITY HOSPITAL;3:NURSING HOME;4:PVA;5:SELF;6:DEPARTMENT OF DEFENSE;7:NON-VA CARE;8:OTHER;^D SET^SPNAHOC2
 ;;1^Referral VA^~8.4;"Referral VA"^PAO^4:AEMNQZ^D POINTER^SPNAHOC2
 ;;1^Initial Rehab Site^~8.6;"Initial Rehab Site"^SAOM^1:COMMUNITY HOSPITAL;2:VA FACILITY WITH SCI CENTER;3:VA FACILITY WITHOUT SCI CENTER;4:OTHER;^D SET^SPNAHOC2
 ;;1^Init Rehab Discharge Date^~8.8;"Init Rehab Discharge Date"^DAO^::AETS^D DATE^SPNAHOC2
 ;;1^Bowel Care Reimbursement^~10.1;"Bowel Care Reimbursement"^SAOM^1:YES;0:NO;^D SET^SPNAHOC2
 ;;1^BCR Date Certified^~10.2;"BCR Date Certified"^DAO^::AETS^D DATE^SPNAHOC2
 ;;0^BCR Provider^~10.3;"BCR Provider"^FAO^3:30^
 ;;0^Sensory/Motor Loss^~999.03;"Sensory/Motor Loss"^FAO^1:60^
 ;;1^Class of Paralysis^~999.04;"Classification of Paralysis"^FAO^1:60^
 ;;1^Type of Injury^~999.05;"Type Of Injury"^FAO^1:60^
 ;;1^Enrollment Priority^~999.095;"Enrollment Priority"^FAO^1:8^
