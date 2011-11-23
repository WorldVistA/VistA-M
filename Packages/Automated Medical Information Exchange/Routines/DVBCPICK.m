DVBCPICK ;ALB/GTS-557/THM-NON TB DISEASES/INJURIES ; 6/27/91  12:56 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 1505 Worksheet" S HD7="NON-TUBERCULOUS DISEASES AND INJURIES OF THE RESPIRATORY SYSTEM",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:"
 F I=1:1 S LY=$T(TXT+I) Q:LY["END"  W ?13,$P(LY,";;",2),! I $Y>55 D HD2
 W !! I '$D(CMBN) W "A. Medical history:",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings:",! D HD2
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!
 W ?8,"1. State if active malignant process is present.  If so, nothing",!?11,"further is needed -",!!!!!!
 W ?8,"2. If malignancy is inactive, report date/place of last",!?11,"surgery, radiation or chemical therapy -",!!!!!!
 W ?8,"3. For non-malignant diseases, injuries, residuals of inactive or",!?11,"cured malignancies  -",!!?11,"a.  Report structural changes to the lungs -",!!!!! D:$D(CMBN) HD2
 W ?11,"b.  Provide pulmonary function studies -",!!!!!
 W ?11,"c.  Schedule additional special studies as necessary to evaluate",!?15,"any extra-pulmonary manifestations that may be detected -",!!!!!!
 W ?11,"d.  State whether the disease is in remission or demonstrably",!?15,"active -",!!!!!!
 D:'$D(CMBN) HD2 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!!!,$S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for ",!,HD7,!!,"for "_NAME,!!!
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
 ;
TXT ;
 ;;In reporting structural changes to the lungs for the Regional
 ;;Office disability evaluations, the residuals are critical
 ;;(e.g., fibrosis, scarring, absent or resected parts, limitation
 ;;of expansion of the chest or excursion of diaphragm, presence
 ;;of bullet or missile in lung, granuloma).
 ;;
 ;;The Rating Schedule requires a pulmonary function test (PFT) in
 ;;certain lung diseases.  In the majority of the cases, PFTs and a
 ;;thorough description of the veteran's exercise tolerance will be
 ;;sufficient for rating evaluation purposes.  If such tests are, in
 ;;the examiner's opinion, not needed or medically contraindicated,
 ;;the examiner should explain why.  Generally, PFTs need not be
 ;;repeated if recent studies (within the past six months) are of
 ;;record. If the examiner feels that an arterial blood gas test is
 ;;appropriate for diagnostic purposes, the results should be reported
 ;;in paragraph E below.
 ;;END
