DVBCADCK ;ALB/GTS-557/THM-AUDIO EXAM ; 5/10/91  9:13 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs"
 S HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 1305 Worksheet" S HD7="AUDIO",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,! I '$D(CMBN) W "Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:"
 W ?13,"When only pure tone results should be used to evaluate",!?13,"hearing loss, the Chief of the Audiology Clinic should",!?13,"certify that language difficulties or other problems make",!
 W ?13,"the use of both pure tone average and speech discrimination",!?13,"inappropriate.",!! I '$D(CMBN) W "A. Audiological history:",!!!!!!!!!!
 W $S($D(CMBN):"A. ",1:"B. ") W "Pure tone thresholds at indicated frequencies (air conduction):",!!?16,"dB",?49,"dB",!," ========== RIGHT EAR ========== + ========== LEFT EAR ===========",!
 W "   A*   B    C    D    E            A*   B    C    D    E",!
 W "+------------------------------**+------------------------------**+",!
 W "| 500|1000|2000|3000|4000|Average| 500|1000|2000|3000|4000|Average|",!,"+--------------------------------+--------------------------------+",!
 W "|    |    |    |    |    |       |    |    |    |    |    |       |",!,"+----+----+----+----+----+-------+----+----+----+----+----+-------+",!!
 W "* The pure tone threshold at 500 Hz is not currently used for evaluation",!,"purposes but is used in determining whether or not a ratable hearing",!,"loss exists.",!!,"** - average of B, C, D, and E"
 W !!!!,$S($D(CMBN):"B. ",1:"C. ") W "Speech recognition score:",!!,"   1. Maryland CNC word list _______ % right ear  _______ % left ear",!!
 W "   2.         W-22 word list _______ % right ear  _______ % left ear",!!,"      (Only if specifically requested by the regional office)",!!!! I $Y>58 D HD2
 W $S($D(CMBN):"C. ",1:"D. "),"Note whether tinnitus is present and if so, indicate the following:",!!!! S X1=0
 F X="Date/circumstance of onset","Unilateral vs bilateral","Constant vs periodic (indicate frequency)","Severity and effect on daily life","Veteran account of loudness/pitch" S X1=X1+1 W ?5,X1,". ",X," -",!!!! I $Y>58 D HD2
 K X1,X
 W $S($D(CMBN):"D. ",1:"E. "),"Note whether audiologic results indicate an ear or hearing problem",!,"that requires medical follow-up or a problem, which, if treated, may",!,"cause a change in hearing threshold levels -",!!!!!!!
 W $S($D(CMBN):"E. ",1:"F. "),"Summary of audiologic test results:",!!!!!!!!
 W $S($D(CMBN):"F. ",1:"G. "),"Recommendations/remarks:",!!!!!!!!
 W ?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 W !!?22,"Adequated by: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for "_NAME,!,HD8,!!!
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
