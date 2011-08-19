DVBCMSCK ;ALB/GTS-557/THM-MUSCLE EXAM ; 5/21/91  9:35 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 1435 Worksheet" S HD7="MUSCLES (ORTHOPEDIC)",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:"
 F AW=0:1 S AX=$T(TXT+AW) S AY=$P(AX,";;",2) W:AY="$END" !! Q:AY="$END"  W ?13,AY,!
 I '$D(CMBN) W "A. Medical history:",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings:",! D HD2
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!!!
 W ?8,"1. Tissue loss comparison -",!!!!!?8,"2. Muscles penetrated -",!!!!!?8,"3. Scar formation measurement (sensitiveness, tenderness) -",!!!!!
 W ?8,"4. Adhesions -",!!!!!?8,"5. Damage to tendons -",!!!!!?8,"6. Damage to bones, joints, nerves -",!!!!! D:$D(CMBN) HD2 W ?8,"7. Strength -",!!!!!?8,"8. Evidence of pain -",!!!!!?8,"9. Evidence of muscle hernia -",!!!!!
 D:'$D(CMBN) HD2 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!!! D:$Y>50 HD2
 W $S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for ",HD7,!,"for "_NAME,!!!
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
 ;
TXT ;;In conducting examinations of muscle damage and functional
 ;;impairment the muscles affected by tissue loss, penetrating
 ;;injuries, scar formation, adhesions, damage to tendons, or
 ;;other factors should be identified individually by the
 ;;pathological locations and by motions affected in strength
 ;;excursion, and diminished capacity for prolonged use.
 ;;
 ;;The standard muscle grading system should be used and
 ;;is as follows:
 ;;
 ;;Normal - through full range against normal resistance
 ;;  Good - full range, less than normal resistance
 ;;  Fair - full range, gravity only resistance
 ;;  Poor - full range, gravity and all resistance eliminated
 ;;$END
