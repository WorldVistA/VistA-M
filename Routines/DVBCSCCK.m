DVBCSCCK ;ALB/GTS-557/THM-SCAR EXAM ; 12/27/90  1:52 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 1445 Worksheet" S HD7="SCARS, OTHER THAN BURNS (ORTHOPEDIC/DISFIGUREMENT)",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:"
 W ?13,"The type of injury or infection causing the wound or scar,",!?13,"its date, the treatment used and the response to such",!?13,"treatment should be described.  Point of entrance and exit of",!?13,"missiles are important "
 W "in evaluating injuries of nerves, vessels,",!?13,"and muscles.  Photographs, if indicated, (see Physician's Guide,",!?13,"Paragraph 1.19) should be submitted.",!!!
 I '$D(CMBN) W "A. Medical history:",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings:",! D HD2
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!,?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!
 W ?8,"1. Position, shape, texture, length, width, color, depth -",!!!!!?8,"2. Keloid formation, adherance, herniation -",!!!!!?8,"3. Inflammation, swelling, depression, vascular supply, ulceration -",!!!!!
 W ?8,"4. Tender and painful on objective demonstration -",!!!!!?8,"5. Cosmetic effects (submit photographs of all facial",!?29,"and other significant scars) -",!!!!!?8,"6. Limitation of function of part affected -",!!!!! D:$D(CMBN) HD2
 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!!! D:'$D(CMBN) HD2 W $S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for ",!,HD7,!!,"for "_NAME,!!!
 Q
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
