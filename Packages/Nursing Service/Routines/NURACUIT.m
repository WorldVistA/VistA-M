NURACUIT ;HIRMFO/MD-ROUTINE TO REPAIR FUTURE ACUITY DATA FROM ERRONEOUS BATCH RUN
 ;;4.0;NURSING SERVICE;;Apr 25, 1997
 ; This routine should be run in the event the Nursing AMIS Acuity
 ; Separation/Activation batch job erroneously creates future data
 ; entries in the NURS AMIS Daily Exception Report (#213.5), NURS AMIS
 ; 1106 Manhours (#213.4) and NURS Parameters (#213.9) files.
 ; 
 D EN1,EN2,EN3
 W !,"Done"
KILL ;
 K DA,DIK,NURSX,RUNDATE,X,Y
 Q
EN1 ; Remove future date entries from the unclassified report (#213.5) file.
 ; There should be no unclassified report file entries later than T-1.
 ;
 W !,"Removing future date entries from the NURS AMIS Daily Exception Report",!,"(#213.5) file"
 S X="T-1" D ^%DT S RUNDATE=Y
 I +$G(RUNDATE) S NURSX=0,DIK="^NURSA(213.5," F  S NURSX=$O(^NURSA(213.5,"B",NURSX)) Q:NURSX'>0  I NURSX>RUNDATE S DA=0 F  S DA=$O(^NURSA(213.5,"B",NURSX,DA)) Q:'DA  D ^DIK W "."
 G KILL
EN2 ; Remove acuity data from future date entries in manhours file (#213.4).
 ;
 W !,"Removing acuity data from future date entries in the NURS AMIS 1106 Manhours",!,"file (#213.4)"
 S NURSX=DT_"A"
 I $G(NURSX)'="" F  S NURSX=$O(^NURSA(213.4,"B",NURSX)) Q:NURSX=""  S DA(1)=0 F  S DA(1)=$O(^NURSA(213.4,"B",NURSX,DA(1))) Q:DA(1)'>0  D
 .S DA=0 F  S DA=$O(^NURSA(213.4,DA(1),1,DA)) Q:DA'>0  D
 ..S DIK="^NURSA(213.4,DA(1),1,"
 ..D ^DIK W "."
 ..Q
 .Q
 G KILL
EN3 ; Reset Date node in site parameter file to current date if date is
 ; in the future.
 ;
 W !,"Resetting ^DIC(213.9,1,""DATE"") to today's date if it is a future date."
 I +$G(^DIC(213.9,1,"DATE"))>DT S $P(^DIC(213.9,1,"DATE"),"^")=DT
 G KILL
