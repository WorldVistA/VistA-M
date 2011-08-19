DVBCPWC2 ;ALB ISC/THM-POW PROTOCOL MENTAL DISORDER EXAM ; 5/6/91  9:40 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9="Full Exam Worksheet"
EN W @IOF,!?25,HD91,!?22,"Compensation and Pension Examination",! S HD7="MENTAL DISORDERS - POW PROTOCOL",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!,"Physician's Guide Reference:  Chapter 14, 17, 20",!!,"Narrative:  "
 W !!,"A. Medical and occupational history:",!!
 W ?8,"1. Immediate pre-military events -",!!!!!!!!!?8,"2. Events as a POW -",!!!!!!!!!?8,"3. Post-active service events (to present) -",!!!!!!!!!
 W ?8,"4. Employment history prior to and following",!?11,"active service -" D HD2
 W "B. Subjective complaints (include the veteran's history of unusually ",!?27,"traumatic events as a POW, if not elsewhere",!?27,"indicated) -",!!!!!!!!!!!!!!! W "C. Objective findings:",! D HD2
 W "D. Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!
 S LX="TXT1" F I=1:1 S LY=$T(@LX+I) Q:LY["$END"  W $P(LY,";;",2),!
 W !!!!!!!!!!!!,"E. Diagnosis:",!!!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 G ^DVBCPWC3
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for ",HD7,!,"for ",NAME,!!!
 Q
TXT1 ;
 ;;   1.  State if the veteran is capable of managing his/her benefit
 ;;       payments in the individual's own best interests without restriction
 ;;       (a physical disability which prevents the veteran from attending
 ;;       to financial matters in person is not a proper basis for a finding
 ;;       of incompetency unless the veteran is, by reason of that disability,
 ;;       incapable of directing someone else in handling the individual's
 ;;       his financial affairs) -
 ;;$END
