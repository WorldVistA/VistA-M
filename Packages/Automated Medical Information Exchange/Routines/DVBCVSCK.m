DVBCVSCK ;ALB/GTS-557/THM-VISUAL EXAM ; 6/27/91  2:11 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 1330 Worksheet" S HD7="VISUAL",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W "Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:  "
 S LX="TXT" F I=1:1 S LY=$T(@LX+I) Q:LY["END"  W $P(LY,";;",2),!
 W !!,"A. Medical history:",!!!!!!!!!
 W !!,"B. Visual Acuity:",!!?44,"Near",?55,"Far",!?43,"______",?54,"______",!
 W ?13,"Right Eye",?28,"Uncorrected",?42,"|______",?49,"|",?53,"|______",?60,"|",!!?43,"______",?54,"______",!?30,"Corrected",?42,"|______",?49,"|",?53,"|______",?60,"|",!!!
 W ?44,"Near",?55,"Far",!?43,"______",?54,"______",!?13," Left Eye",?28,"Uncorrected",?42,"|______",?49,"|",?53,"|______",?60,"|",!!?43,"______",?54,"______",!?30,"Corrected",?42,"|______",?49,"|",?53,"|______",?60,"|",!!!
 D HD2 S LX="TXT" D ^DVBCVSC1 W !!!!!
 W "F. Diagnostic/clinical test results (other than visual acuity,visual fields",!,?4,"or diplopia):",!!!!!!!!!!,"G. Diagnosis:",!!!!!!!!!!
 W ?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 ;S LN22="Attachment - Visual Exam" W @IOF,!!?(80-$L(LN22)\2),LN22,!!! D ^DVBCVSC2 W !
 K LN,LN1,LN22
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Examination",!,HD8," for ",NAME,!!!
 Q
 ;
TXT ;
 ;;For visual acuity worse than 5/200 in either or both eyes, report
 ;;            the distance in feet/inches (or meters/centimeters) from the face
 ;;            at which the veteran can count fingers/detect hand motion/read the
 ;;            largest line on the chart.  If the veteran cannot detect hand motion
 ;;            or count fingers at any distance, state whether he/she has light
 ;;            perception.
 ;;END
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
