DVBCPWC3 ;ALB ISC/THM-POW PROTOCOL SOCIAL WORK SURVEY ; 5/5/91  1:40 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9="Full Exam Worksheet"
EN W @IOF,!?25,HD91,!?22,"Compensation and Pension Examination",! S HD7="SOCIAL WORK SURVEY - POW PROTOCOL",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!,"Physician's Guide Reference:  Chapter 17",!!
 W !!,"A. Describe the veteran's personal appearance -",!!!!!!!!!!
 W "B. Describe the veteran's personal health -",!!!!!!!!!!,"C. Describe the veteran's family adjustment -",! D HD2
 W "D. Describe the veteran's community adjustment -",!!!!!!!!!!,"E. Describe the veteran's economic adjustment -",!!!!!!!!!!
 W "E. Evaluation:",!!!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for ",HD7,!,"for ",NAME,!!!
 Q
