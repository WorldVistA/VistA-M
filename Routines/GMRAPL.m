GMRAPL ;HIRMFO/WAA- PRINT ALLERGY LIST BY LOCATION ;5/2/97  14:13
 ;;4.0;Adverse Reaction Tracking;**7,33**;Mar 29, 1996;Build 5
EN1 ; This routine will loop through the GMRA patient allergy file
 ; to find all patient within the date range that meet the criteria
 ; and then display all the data for those patients first by location
 ; then by date/time range of the reaction.
 ; First select a starting date.
 ; then select an end date.
 ; then select a print device.
 ; GMAST = START DATE
 ; GMAEN = END DATE
 ;
 S GMRAOUT=0
 D DT G:GMRAOUT EXIT
 S GMAPG=1
 D DEVICE
 D EXIT
 Q
GET ; This sub routine is to find all the reaction with in this observed 
 ; date range.
 K ^TMP($J,"GMRAPL")
 N GMADT S GMADT=GMAST-.0001
 F  S GMADT=$O(^GMR(120.8,"AODT",GMADT)) Q:GMADT<1  Q:GMADT>GMAEN  D
 .N GMRAPA S GMRAPA=0
 .F  S GMRAPA=$O(^GMR(120.8,"AODT",GMADT,GMRAPA)) Q:GMRAPA<1  D
 ..S GMRAPA(0)=$G(^GMR(120.8,GMRAPA,0))
 ..; Stop if it is not Signed or if is E/E
 ..Q:GMRAPA(0)=""  ; Bad Zero node 
 ..Q:'$P(GMRAPA(0),U,12)  ; Not signed off
 ..Q:$P($G(^GMR(120.8,GMRAPA,"ER")),U)  ; Entered in error
 ..; Get patient name and location.
 ..S GMRATYP=$P(GMRAPA(0),U,20) ; Get the reaction types FDO
 ..S (GMRANAM,GMRALOC,GMRAVIP)=""
 ..Q:'$$PRDTST^GMRAUTL1($P($G(GMRAPA(0)),U))  ;GMRA*4*33 Exclude test patient from report if production or legacy environment
 ..D VAD^GMRAUTL1($P(GMRAPA(0),U),$P(GMRAPA(0),U,4),.GMRALOC,.GMRANAM,"","","","",.GMRAVIP)
 ..I GMRALOC'="",+$G(^DIC(42,GMRALOC,44)) S GMRALOC=$P($G(^SC(+$G(^DIC(42,GMRALOC,44)),0)),U)
 ..I GMRALOC="" S GMRALOC="Out Patients"
 ..;Data format is as follows....
 ..;^TMP($J,"GMRAPL",Ward location,Patient,PID,Reaction Type(FDO),Reaction)
 ..S ^TMP($J,"GMRAPL",$E(GMRALOC,1,30),$E(GMRANAM,1,30),GMRAVIP,GMRATYP,GMRAPA)=""
 ..Q
 .Q
 Q
PRINT ; Print data in the reaction global
 I $E(IOST,1)="C" W !,"One moment please...",!
 D GET
 S GMRALOC="" F  S GMRALOC=$O(^TMP($J,"GMRAPL",GMRALOC)) Q:GMRALOC=""  D  Q:GMRAOUT
 .D HEAD Q:GMRAOUT
 .S GMRANAM="" F  S GMRANAM=$O(^TMP($J,"GMRAPL",GMRALOC,GMRANAM)) Q:GMRANAM=""  D  Q:GMRAOUT
 ..S GMRAVIP="" F  S GMRAVIP=$O(^TMP($J,"GMRAPL",GMRALOC,GMRANAM,GMRAVIP)) Q:GMRAVIP=""  D  Q:GMRAOUT
 ...I $Y>(IOSL-4) D HEAD Q:GMRAOUT
 ...W !,?10,"Patient: ",GMRANAM," (",GMRAVIP,")"
 ...S GMRATYP="" F  S GMRATYP=$O(^TMP($J,"GMRAPL",GMRALOC,GMRANAM,GMRAVIP,GMRATYP)) W:GMRATYP="" ! Q:GMRATYP=""  D  Q:GMRAOUT
 ....S GMRAPA=0 F  S GMRAPA=$O(^TMP($J,"GMRAPL",GMRALOC,GMRANAM,GMRAVIP,GMRATYP,GMRAPA)) Q:GMRAPA<1  D  Q:GMRAOUT
 .....S GMRAPA(0)=$G(^GMR(120.8,GMRAPA,0)) Q:GMRAPA(0)=""
 .....W !,$$FMTE^XLFDT($P(GMRAPA(0),U,4),"1") ;When It was entered
 .....W ?20,$S($P(GMRAPA(0),U,5)'="":$E($P(^VA(200,$P(GMRAPA(0),U,5),0),U),1,25),1:"<None>") ;Who Entered it
 .....W ?46,GMRATYP ;Type of reaction
 .....W ?50,$E($P(GMRAPA(0),U,2),1,30) ;Reaction
 .....I $Y>(IOSL-4) D HEAD
 .....Q
 ....Q
 ...Q
 ..Q
 .Q
 Q
HEAD ; Header
 I $E(IOST,1)="C" D  Q:GMRAOUT
 .I GMAPG=1 W @IOF Q
 .I GMAPG'=1 D  Q:GMRAOUT
 ..N DIR S DIR(0)="E" D ^DIR I 'Y S GMRAOUT=1
 ..K Y
 ..Q
 .Q
 I GMAPG'=1 W @IOF
 W $$FMTE^XLFDT(GMRAPDT,"1"),?70,"Page: ",GMAPG S GMAPG=GMAPG+1
 W !,?11,"List all Signed Patient Reactions for",$S(GMRALOC'="Out Patients":" Ward Location ",1:" "),GMRALOC
 W !,?15,"From ",$$FMTE^XLFDT(GMAST,"1")," to ",$$FMTE^XLFDT(GMAEN,"1")
 W !,"Date",?20,"Originator",?45,"Type",?50,"Causative Agent"
 W !,$$REPEAT^XLFSTR("-",79)
 Q
DEVICE ; Select a device to print on
 D NOW^%DTC S GMRAPDT=X
 W ! K GMRAZIS D DEV^GMRAUTL I POP W !,"PLEASE TRY LATER" S GMRAOUT=1 Q
 I $D(IO("Q")) D  Q
 . S ZTRTN="PRINT^GMRAPL",(ZTSAVE("GMAST"),ZTSAVE("GMAEN"),ZTSAVE("GMRAOUT"),ZTSAVE("GMRAPDT"),ZTSAVE("GMAPG"))=""
 . S ZTDESC="List of Reactions by Ward Location within a date range." D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Request queued...",1:"Request NOT queued please try  Later.")
 . Q
 U IO D PRINT U IO(0)
 D CLOSE^GMRAUTL
 D EXIT
 Q
DT ; Get dates
 S GMAST=$$DATE("Enter Start Date: ") I GMAST<1 S GMRAOUT=1 Q
 S GMAEN=$$DATE("Enter Ending Date: ",GMAST) I GMAEN<1 S GMRAOUT=1 Q
 S GMAEN=GMAEN_".24" ;Gives results through entire day when 'T' is selected
 Q
DATE(PROMPT,GMADATE) ; Date sub routine
 S GMADATE=$G(GMADATE)
 S DATE=""
 N DIR
 S DIR(0)="DAO^"_GMADATE_"::AEP",DIR("A")=PROMPT
 D ^DIR I $D(DIRUT) S DATE="" Q DATE
 S DATE=Y
 Q DATE
EXIT ;EXIT ROUTINE DATA
 K ^TMP($J,"GMRAPL")
 D KILL^XUSCLEAN
 Q
