DVBCWNS4 ;VMP/JER - SPINE WKS ; 12/04/03 2:00pm
 ;;2.7;AMIE;**60**;Apr 10, 1995
 ;Per VHA Directive 10-92-142, this routine should not be modified
 ;
 ; IOM represents cpl (char per line) dependinf on printing selection
 ; The header will be centered for any print out
 ;
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 S DVBAX="Compensation and Pension Examination",TT=IOM-$L(DVBAX)\2
 W !?TT,DVBAX
 S DVBAX="SPINE",PG=1
 S TT=IOM-$L(DVBAX)\2
 W !!?TT,DVBAX,!?(IOM-16\2),"# 1440 Worksheet"
 W !!,"Name: ",NAME,?45,"SSN: ",SSN,!
 W !,"Date of Exam: ____________________",?45,"C-number: ",CNUM
 W !!,"Place of Exam: ___________________",!!
 S DIF="^TMP($J,""DVBAW"",",XCNP=0
 K ^TMP($J,"DVBAW")
 ;F ROU="DVBCWNS5","DVBCWNS6","DVBCWNS7","DVBCWNS8" S X=ROU X ^%ZOSF("LOAD")
 S X="DVBCWNS5" X ^%ZOSF("LOAD")
 K DIF,XCNP
 N LP,TEXT
 S LP=0,STOP=0
 F  S LP=$O(^TMP($J,"DVBAW",LP)) Q:(LP="")!(STOP)  D
 .S TEXT=^TMP($J,"DVBAW",LP,0)
 .I (TEXT'[";;")!(TEXT[";AMIE;") Q
 .I TEXT["TOF" D HD2
 .I TEXT["END" S STOP=1 Q
 .W:TEXT'["TOF" $P(TEXT,";;",2),! I $Y>55 D HD2
 K ^TMP($J,"DVBAW"),TEXT,STOP,LP,PG,DVBAX,X
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!?10,"Compensation and Pension Exam for "_NAME,!!
 W "SPINE",!!!
 Q
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
