DVBCSIS ;ALB/JEH SOCIAL AND INDUSTRIAL SURVEY ; 5 MARCH 1997
 ;;2.7;AMIE;**70,80**;Apr 10, 1995
 ;
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 S DVBAX="SOCIAL AND INDUSTRIAL SURVEY",PG=1
 W !?22,"VETERANS HEALTH ADMINISTRATION",!,?(IOM-$L(DVBAX)\2),DVBAX,!?19,"COMPENSATION AND PENSION EXAMINATION #1790",!!!
 W "Social Worker's Name & Title:",!
 W "Date 2507/Consult Received:",!
 W "Originating VARO:",!!
 W !?28,"EXAM INFORMATION",!?28,"----------------",!!
 W "Name: ",NAME,?45,"SSN: ",SSN,!!,"DOB: ___________",?45,"C#: ",CNUM,!!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!
 W "ADDRESS: ______________________________________",!?9,"Street or P.O. Box",!?9,"______________________________________",!?9,"City,State,Zip Code",!!
 W "PHONE: ________________________________________",!?7,"(Home,work or message-phone,if available)",!!
 S DIF="^TMP($J,""DVBAW"",",XCNP=0
 K ^TMP($J,"DVBAW")
 F ROU="DVBCST1","DVBCST2" S X=ROU X ^%ZOSF("LOAD")
 K DIF,XCNP,ROU
 N LP,TEXT
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
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for "_NAME,!
 W "For SOCIAL AND INDUSTRIAL SURVEY",!!!
 Q
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
