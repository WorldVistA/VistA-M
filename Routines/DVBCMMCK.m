DVBCMMCK ;ALB/GTS-557/THM-MAMMARY EXAM ; 12/7/90  9:01 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 0710 Worksheet" S HD7="MAMMARY",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:  NONE",!!
 I '$D(CMBN) W "A. Medical history (note history of augmentation mammoplasty with",!?20,"prosthetic implant or reduction mammoplasty):",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!! W "C. Objective findings:",!!!!!!!!!! D HD2
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!
 W ?8,"1. Axillary glands removal -",!!!!!!?8,"2. Size of scar -",!!!!!!
 W ?8,"3. Fixation of scar -",!!!!!!?8,"4. Contour of scar -",!!!!!!?8,"5. Muscle loss -",!!!!!!?8,"6. Tenderness of scar -",!!!!!! D:$D(CMBN) HD2 W ?8,"7. Nerve damage -",!!!!!! D:'$D(CMBN) HD2
 W ?8,"8. Presence of aching, pain or limited use of upper extremeties -",!!!!!!
 W ?8,"9. Note whether active malignant process is present -",!!!!!!?8,"10. If malignancy is inactive, state date of last surgical, radiation",!?12,"or chemical treatment -",!!!!!!
 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!!! D:$Y>50 HD2 W $S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for "_NAME,!,HD8,!!!
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
