DVBCWSM ;ALB/CMM RESPIRATORY MISC DISEASES WKS ; 10 Oct 2000
 ;;2.7;AMIE;**34**;Apr 10, 1995
 ;
 ; IOM represents cpl (characters per line) depending on print. select"
 ; The header will be centered for any print out.
 ;
EN N XX D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 S DVBAX="Compensation and Pension Examination",TT=IOM-$L(DVBAX)\2
 W !?TT,DVBAX,!
 S DVBAX(1)="RESPIRATORY DISEASES, MISCELLANEOUS",PG=1
 S DVBAX(2)="(PVD, Neoplasms, Bacterial Infections,"
 S DVBAX(3)="Mycotic Lung Disease, Sarcoidosis, and Sleep Apnea)"
 F XX=1:1:3 S TT=IOM-$L(DVBAX(XX))\2 D
 .W !,?TT,DVBAX(XX)
 ; $L("# XXXX Worksheet")=16 for all worksheets
 ;
 W !?(IOM-16\2),"# 1520 Worksheet",!!
 W "Name: ",NAME,?45,"SSN: ",SSN,!
 W !,"Date of Exam: ____________________",?45,"C-number: ",CNUM
 W !!,"Place of Exam: ___________________",!!
 S DIF="^TMP($J,""DVBAW"",",XCNP=0
 K ^TMP($J,"DVBAW")
 F ROU="DVBCWSM1" S X=ROU X ^%ZOSF("LOAD")
 K DIF,XCNP,ROU
 N LP,TEXT
 S LP=0,STOP=0
 F  S LP=$O(^TMP($J,"DVBAW",LP)) Q:(LP="")!(STOP)  D
 .S TEXT=^TMP($J,"DVBAW",LP,0)
 .I (TEXT'[";;")!(TEXT[";AMIE;") Q
 .;I TEXT["TOF" D HD2
 .I TEXT["END" S STOP=1 Q
 .I $Y>55 D HD2
 .W:TEXT'["TOF" $P(TEXT,";;",2),!
 K ^TMP($J,"DVBAW"),TEXT,STOP,LP,PG,DVBAX,X
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!?10,"Compensation and Pension Exam for "_NAME,!!
 W "RESPIRATORY DISEASES, MISCELLANEOUS",!!!
 Q
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
