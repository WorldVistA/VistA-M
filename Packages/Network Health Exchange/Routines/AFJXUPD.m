AFJXUPD ;CIOFO-SF/AAA ;UPDATED FILE #537015 ;081299
 ;;5.1;Network Health Exchange;**16**;Aug'99
 N DIC,DD,D0
 K ^AFJ(537015)
 S ^AFJ(537015,0)="VAMC NETWORK HEALTH TYPES^537015^0^0"
 S DIC="^AFJ(537015,",DIC(0)="L"
 F I=1:1 S TEX=$T(LABEL22+I) Q:TEX=""  D
 .S X=$P(TEX,";;",2)
 .Q:$D(^AFJ(537015,"B",X))
 .D ADD
 K DIC,D0,DD,X,I,TEX
 Q
ADD K DD,D0 
 D FILE^DICN
 Q
LABEL22 ;;
 ;;Demographics
 ;;Admission/Discharge
 ;;Discharges
 ;;Disabilities
 ;;ICD Procedures
 ;;ICD Surgeries
 ;;Fut Clinic Visits
 ;;Past Clinic Visits
 ;;Adv React/Allerg
 ;;Dietetics
 ;;Vital Signs
 ;;Progress Notes
 ;;Outpatient Pharmacy
 ;;IV Pharmacy
 ;;Unit Dose Pharmacy
 ;;Blood Transfusions
 ;;Chem & Hematology
 ;;Microbiology
 ;;Surgical Pathology
 ;;Cytopathology
 ;;Med (1 line) Summary
 ;;Imaging Profile
 ;;Imaging Status
 ;;Surgery Rpt (OR/NON)
 ;;Clinical Warnings
 ;;Crisis Notes
 ;;Discharge Summary
 ;;Current Orders
 ;;Comp. & Pen. Exams
 ;;NON OR Procedures
