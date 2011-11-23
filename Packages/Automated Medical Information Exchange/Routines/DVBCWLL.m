DVBCWLL ;ALB/JEH LIVER, GALL BLADDER AND PANCREAS WKS ;19 FEBRUARY 1999
 ;;2.7;AMIE;**74**;Jul 22, 2004
 ;
 ; IOM - cpl (characters per line)
EN ;
 N DVBAX,ROU,DIF,XCNP,X,PG,TT,TNAM
 D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 S DVBAX="Compensation and Pension Examination",TT=IOM-$L(DVBAX)\2
 W !?TT,DVBAX
 S TNAM="LIVER, GALL BLADDER, AND PANCREAS"
 S DVBAX=TNAM,TT=IOM-$L(DVBAX)\2,PG=1
 W !?TT,DVBAX
 S DVBAX="# 0305 Worksheet",TT=IOM-$L(DVBAX)\2 W !?TT,DVBAX,!!
 W "Name: ",NAME,?45,"SSN: ",SSN,!!,"Date of Exam: ____________________",?45,"C-number: ",CNUM,!!,"Place of Exam: ___________________",!!
 S DIF="^TMP($J,""DVBAW"",",XCNP=0
 K ^TMP($J,"DVBAW")
 F ROU="DVBCWLL1","DVBCWLL2" S X=ROU X ^%ZOSF("LOAD")
 K DIF,XCNP,ROU
 N LP,TEXT,STOP
 S LP=0,STOP=0
 F  S LP=$O(^TMP($J,"DVBAW",LP)) Q:(LP="")!(STOP)  D
 .S TEXT=^TMP($J,"DVBAW",LP,0)
 .I (TEXT'[";;")!(TEXT[";AMIE;") Q
 .;I TEXT["TOF" D HD2
 .I TEXT["END" S STOP=1 Q
 .W:TEXT'["TOF" $P(TEXT,";;",2),! I $Y>55 D HD2
 K ^TMP($J,"DVBAW"),TEXT,STOP,LP,PG,DVBAX,X
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!?7,"Compensation and Pension Exam for "_NAME,!!
 W ?4,TNAM,!!!
 Q
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
