DVBCEXML ;ALB/GTS-557/THM-PRINT EXAM CHECKLIST FOR RO ; 5/16/91  1:52 PM
 ;;2.7;AMIE; **12**;Apr 10, 1995
 ;
 K ^TMP($J) D HOME^%ZIS
 W @IOF,!!,"Print Exam Checklist for the Regional Office",!!!
DEV S %ZIS="AEQ",%ZIS("A")="Output device: ",%ZIS("B")="0;P-OTHER" D ^%ZIS K %ZIS G:POP EXIT
 I IOM<132 D ^%ZISC U 0 W *7,!!,"A margin of 132 is required for this printout",!! H 2 G DEV
 I $D(IO("Q")) S ZTRTN="GO^DVBCEXML",ZTIO=ION,ZTDESC="Print Exam check list",ZTSAVE="" D ^%ZTLOAD W !!,"Request queued",!! H 2 G EXIT
 ;
GO ;
 U IO
 S PG=1
 S HD="VA Regional Office - "_$$SITE^DVBCUTL4 W !?(IOM-$L(HD)\2),HD
 S HD="Compensation and Pension Examination Request Worksheet"
 W !?(IOM-$L(HD)\2),HD
 D HDR
 D DRIVE
 W !!?13,"** Remarks:",!
 ;
EXIT D:$D(ZTQUEUED) KILL^%ZTLOAD
 K AA,NAME,ZTSK,H,DVBCX,A,OLDEXM,HD G KILL^DVBCUTIL
 Q
 ;
HDR W !!?15,"Veteran's Name: _________________________________________________",?90,"VAMC: __________________________"
 W !!?21,"C-Number: ____________________",?91,"SSN: __________________________"
 W !!?13,"Telephone-Day: _______________________  Night:_______________________    Power of Attorney: _________________"
 W !!?18,"Date Ordered: ____________________________",?92,"By: __________________________"
 W !!?14,"Priority of Exam:  _________________________         (    ) Insufficient Exam Dated: _______________________"
 W !?14,"                                                                                     (See Remarks)"
 W !!?14,"(    ) General Medical Examination                   (    ) Review of Pertinent Medical Records in"
 W !?14,"                                                            Claims Folder is Required Prior to Examination",!!
 Q
DRIVE ;
 S DIF="^TMP($J,""DVBAR"",",XCNP=0
 K ^TMP($J,"DVBAR")
 F ROU="DVBCEXM1" S X=ROU X ^%ZOSF("LOAD")
 K DIF,XCNP,ROU
 N LP,TEXT
 S LP=0,STOP=0
 F  S LP=$O(^TMP($J,"DVBAR",LP)) Q:(LP="")!(STOP)  D
 .S TEXT=^TMP($J,"DVBAR",LP,0)
 .I (TEXT'[";;")!(TEXT[";AMIE;") Q
 .I TEXT["TOF" D HD2
 .I TEXT["END" S STOP=1 Q
 .W:TEXT'["TOF" ?5,$P(TEXT,";;",2),! I $Y>55 D HD2
 K ^TMP($J,"DVBAR"),TEXT,STOP,LP,PG,DVBAX,X
 Q
 ;
HD2 S PG=PG+1 W @IOF,!?15,"Page: ",PG,!!?15,"Compensation and Pension Examination Request Worksheet, Cont.",!!!
 Q
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
