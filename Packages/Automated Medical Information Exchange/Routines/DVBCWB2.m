DVBCWB2 ;ALB/RLC BONES WKS ; 12 FEB 2007
 ;;2.7;AMIE;**121**;Apr 10, 1995;Build 9
 ;
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 S DVBAX="For BONES (Fractures and Bone Disease)",PG=1
 W !?22,"Compensation and Pension Examination",!,?(IOM-$L(DVBAX)\2),DVBAX,!?33,"# 1410 Worksheet",!!
 W "Name: ",NAME,?45,"SSN: ",SSN,!,?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!
 S DIF="^TMP($J,""DVBAW"",",XCNP=0
 K ^TMP($J,"DVBAW")
 F ROU="DVBCWB3" S X=ROU X ^%ZOSF("LOAD")
 K DIF,XCNP,ROU
 N LP,TEXT
 S LP=0,STOP=0
 F  S LP=$O(^TMP($J,"DVBAW",LP)) Q:(LP="")!(STOP)  D
 .S TEXT=^TMP($J,"DVBAW",LP,0)
 .I (TEXT'[";;")!(TEXT[";AMIE;") Q
 .;I TEXT["TOF" D HD2
 .I TEXT["END" S STOP=1 Q
 .W:TEXT'["TOF" $P(TEXT,";;",2),! I $Y>58 D HD2
 K ^TMP($J,"DVBAW"),TEXT,STOP,LP,PG,DVBAX,X
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for "_NAME,!
 W "BONES (Fractures and Bone Disease)",!!!
 Q
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
