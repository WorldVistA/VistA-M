DVBCEDCK ;ALB/GTS-557/THM-AUDIO-EAR DISEASE ; 6/27/91  7:21 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs"
 S HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 1306 Worksheet" S HD7="AUDIO-EAR DISEASE",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:"
 W ?13,"If, in the course of audiometric testing, there is any",!?13,"indication of ear disease, the veteran should be referred to",!?13,"a physician for additional exam.  Examination should include"
 W !?13,"inspection of the auricle, the external canal, and tympanic",!?13,"membranes.  Abnormalities in size, shape, or form of the",!?13,"structure should be noted.",!!
 I '$D(CMBN) W "A. Medical history:",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings:",! D HD2
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!?8,"1. Auricle -",!!!!!?8,"2. External canal -",!!!!!
 W ?8,"3. Tympanic membrane -",!!!!!?8,"4. The tympanum -",!!!!!?8,"5. The mastoid -",!!!!! D:$D(CMBN) HD2
 W ?8,"5. State if an active ear disease is present -",!!!!!?8,"6. State if an infectious disease of the middle or inner",!?11,"ear is present -"
 W !!!!!?8,"7. State whether ear disease is affecting any function other",!?11,"than hearing, such as balance, or is associated with any",!?11,"upper respiratory disease -",!!!!! D:'$D(CMBN) HD2
 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!!!,$S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for ",HD7,!,"for ",NAME,!!!
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
