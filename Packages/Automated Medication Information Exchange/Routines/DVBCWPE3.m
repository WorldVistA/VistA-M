DVBCWPE3 ;BP-CIOFO/MM - REVIEW EXAM PTSD;3/27/2002
 ;;2.7;AMIE;**43**;Apr 10, 1995
 ;
 ; IOM represents cpl (characters per line) depending on print. select"
 ; The header will be centered for any print out.
 ;
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 S DVBAX="Compensation and Pension Examination",TT=IOM-$L(DVBAX)\2
 W !?TT,DVBAX
 S DVBAX="REVIEW EXAMINATION FOR POST-TRAUMATIC STRESS DISORDER (PTSD)",TT=IOM-$L(DVBAX)\2,PG=1
 ; $L("# XXXX Worksheet")=16 for all worksheets
 ;
 W !!?TT,DVBAX,!?(IOM-16\2),"# 0920 Worksheet",!!
 W "Name: ",NAME,?45,"SSN: ",SSN
 W !!,"Date of Exam: ____________________",?45,"C-number: ",CNUM
 W !!,"Place of Exam: ___________________",!!
 S DIF="^TMP($J,""DVBAW"",",XCNP=0
 K ^TMP($J,"DVBAW")
 F ROU="DVBCWPE4","DVBCWPE5" S X=ROU X ^%ZOSF("LOAD")
 K DIF,XCNP,ROU
 N LP,TEXT
 S LP=0,STOP=0
 F  S LP=$O(^TMP($J,"DVBAW",LP)) Q:(LP="")!(STOP)  D
 .S TEXT=^TMP($J,"DVBAW",LP,0)
 .I (TEXT'[";;")!(TEXT[";AMIE;") Q
 .I TEXT["TOF" D HD2
 .I TEXT["END" S STOP=1 Q
 .W:TEXT'["TOF" $P(TEXT,";;",2),! I $Y>55 D HD2
 K ^TMP($J,"DVBAW"),TEXT,STOP,LP,PG,DVBAX,X,TT
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!?10,"Compensation and Pension Exam for "_NAME,!!
 W "REVIEW EXAMINATION FOR POST-TRAUMATIC STRESS DISORDER (PTSD)",!!!
 Q
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
