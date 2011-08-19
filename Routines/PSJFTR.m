PSJFTR ;BIR/JCH-INPATIENT MEDS FREE TEXT DOSAGE REPORT ;15 Nov 01 / 9:45 AM
 ;;5.0; INPATIENT MEDICATIONS ;**65,73,76,111**;16 Dec 97
 ;
 ; Reference to ^PSDRUG is supported by DBIA 2192.
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; Reference to ^PSSORPH is supported by DBIA 3234.
 ; 
 ;List IP orders that have free text dosages for a given date range.
 ;Report is sorted by drug and physician.
 ;
BEG ;Begin
 N BEGDT,ENDT
 W !,"This report searches for Free Text Dosages in Inpatient Unit Dose Orders"
 W !,"for a range of dates. Orders with Stop Dates that fall within the range"
 W !,"are included in the report."
 W ! K %DT S %DT("A")="Beginning Date: ",%DT="APE"
 D ^%DT G:Y<0!($D(DTOUT)) EXIT S (%DT(0),BEGDT)=Y
 W ! S %DT("A")="Ending Date: "
 D ^%DT G:Y<0!($D(DTOUT)) EXIT S ENDT=Y D:+$E(Y,6,7)=0 DTC
 K %DT(0)
 ;
DEV ;Device
 K %ZIS,IOP,POP,ZTSK S PSJION=$I,%ZIS="QM"
 D ^%ZIS K %ZIS
 I POP S IOP=PSJION D ^%ZIS K IOP,PSJION W !,"Please try later!" G EXIT
 K PSJION I $D(IO("Q")) D  G EXIT
 .S ZTDESC="Rx free text dosage report",ZTRTN="START^PSJFTR"
 .F G="BEGDT","ENDT" S:$D(@G) ZTSAVE(G)=""
 .K IO("Q") D ^%ZTLOAD W:$D(ZTSK) !,"Report is Queued to print!" K ZTSK
START ;Start processing date range
 N PSGND0,PSGDT,PSGORD,PSJDOSE,PSGDRG,PSJDRN,PSJPR,PSJCNT
 N PSJL,PSJY,PSJC,STOPDT,DRGNODE,STDT
 K ^TMP("PSJFTR",$J)
 S Q=0 W:$E(IOST)="C" !!!,"Working - please wait.."
UD ;
ST1 ;
 S PSGDFN=0,STOPDT=ENDT_".99999"
 F  S PSGDFN=$O(^PS(55,PSGDFN)) Q:'PSGDFN!$D(DIRUT)  D
 .S STDT=BEGDT-.0001
 .F  S STDT=$O(^PS(55,PSGDFN,5,"AUS",STDT)) Q:'STDT!(STDT>STOPDT)!$D(DIRUT)  D
 ..S PSGORD="" I PSGDFN=740 S JCH=$G(JCH)+1
 ..F  S PSGORD=$O(^PS(55,PSGDFN,5,"AUS",STDT,PSGORD)) Q:PSGORD=""!$D(DIRUT)  D
 ...Q:'$D(^PS(55,PSGDFN,5,PSGORD,1,0))
 ...S PSGDCNT=0 F  S PSGDCNT=$O(^PS(55,PSGDFN,5,PSGORD,1,PSGDCNT)) Q:'PSGDCNT  D
 ....N PKG,LOCNOD,ORDOSE,FMDOSE,FMUNIT,NOTXT,NXT,DARRAY,POSDOSE,LOCDOSE
 ....S NOTXT=0
 ....S PSGDRG=+$G(^PS(55,PSGDFN,5,PSGORD,1,PSGDCNT,0))
 ....Q:'$D(^PSDRUG(PSGDRG))!'PSGDRG
 ....S DRGNODE=$G(^PS(55,PSGDFN,5,PSGORD,.2)),PSGND0=^PS(55,PSGDFN,5,PSGORD,0)
 ....S FMDOSE=$P(DRGNODE,"^",5),FMUNIT=$P(DRGNODE,"^",6)
 ....I FMDOSE]"",FMUNIT]"" Q
 ....S ORDOSE=$P(DRGNODE,"^",2) Q:ORDOSE=""   ; Nothing there?
 ....I $E(IOST)="C" S Q=Q+1 W:'(Q#50) "."
 ....K DARRAY S DARRAY="" D DOSE^PSSORPH(.DARRAY,PSGDRG,"U")
 ....I '$G(DARRAY(1)) D CHKLOC  ; check local doses
 ....I $G(DARRAY(1)) D CHKPOS   ; check possible doses
 ....Q:NOTXT  ; Not free text
 ....D PRD
 U IO S PSJPG=1,PSJCNT=0 D HD
 I '$D(^TMP("PSJFTR",$J,"B")) W !!,"***** No Records were found for this period *****",!! G EXIT
DET ;
 S J="" F  S J=$O(^TMP("PSJFTR",$J,"B",J)) Q:J=""  D  Q:$D(DIRUT)
 .S L="",Q=0,Q2=0
 .F  S L=$O(^TMP("PSJFTR",$J,"B",J,L)) Q:L=""  D  Q:$D(DIRUT)
 ..S PSGDRG=$O(^TMP("PSJFTR",$J,"B",J,L,0))
 ..Q:'PSGDRG
 ..S Y=^TMP("PSJFTR",$J,"B",J,L,PSGDRG,0)
 ..W:'Q !,$E(J,1,30)_" ("_PSGDRG_")"
 ..W:Q2'=Q !,$E(J,1,30)_" ("_PSGDRG_")"," - (Continued)",!
 ..W:$L(L)>35 ?40,$E(L,1,35),!,?40,$E(L,36,99) W:$L(L)'>35 ?40,L
 ..W ?75,+Y,!,"    "
 ..S Q=Q+1,Q2=Q
 ..S PR=0 F  S PR=$O(^TMP("PSJFTR",$J,"B",J,L,PSGDRG,PR)) Q:'PR  D
 ...S Y=^TMP("PSJFTR",$J,"B",J,L,PSGDRG,PR),T=$S(PR=.1:"PROVIDER NOT FOUND",1:$P(^VA(200,+PR,0),"^"))
 ...S T=T_":"_Y_"  "
 ...W:($X+$L(T))>74 !?4
 ...W T
 ..W ! I ($Y+5)>IOSL D HD S Q2=0
EXIT W ! D ^%ZISC K DIR,DTOUT,DUOUT,DIROUT,DIRUT,^TMP("PSJFTR",$J),I,X,T,J,L,Q,Y
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
PRD ;
 S PSJDRN=$P(^PSDRUG(PSGDRG,0),"^"),PSJPR=+$P(PSGND0,"^",2)
 I 'PSJPR S PSJPR=.1
 I '$D(^TMP("PSJFTR",$J,"B",PSJDRN,ORDOSE,PSGDRG,PSJPR)) D  Q
 .S ^TMP("PSJFTR",$J,"B",PSJDRN,ORDOSE,PSGDRG,PSJPR)=1
 .S ^TMP("PSJFTR",$J,"B",PSJDRN,ORDOSE,PSGDRG,0)=$G(^TMP("PSJFTR",$J,"B",PSJDRN,ORDOSE,PSGDRG,0))+1
 I $D(^TMP("PSJFTR",$J,"B",PSJDRN,ORDOSE,PSGDRG,PSJPR)) D  Q
 .S Y=^TMP("PSJFTR",$J,"B",PSJDRN,ORDOSE,PSGDRG,PSJPR)
 .S Y=Y+1,^TMP("PSJFTR",$J,"B",PSJDRN,ORDOSE,PSGDRG,PSJPR)=Y
 .S X=^TMP("PSJFTR",$J,"B",PSJDRN,ORDOSE,PSGDRG,0)
 .S X=X+1,^TMP("PSJFTR",$J,"B",PSJDRN,ORDOSE,PSGDRG,0)=X
 Q
 ;
CHKPOS ; Check for possible doses
 S NOTXT=0
 S NXT="" F  S NXT=$O(DARRAY(NXT)) Q:'NXT!NOTXT  D
 .Q:$P($G(^PSDRUG(PSGDRG,"DOS1",NXT,0)),"^",3)'["I"
 .S POSDOSE=$P(DARRAY(NXT),"^",1)_$P(DARRAY(NXT),"^",2) I POSDOSE=ORDOSE S NOTXT=1
 Q
 ;
CHKLOC ; Check for local doses
 S NOTXT=0
 S NXT="" F  S NXT=$O(DARRAY(NXT)) Q:'NXT!NOTXT  D
 .Q:$P($G(^PSDRUG(PSGDRG,"DOS2",NXT,0)),"^",2)'["I"
 .S LOCDOSE=$P(DARRAY(NXT),"^",3) I LOCDOSE=ORDOSE S NOTXT=1
 Q
 ;
HD ;
 I PSJPG>1,$E(IOST)="C" S DIR(0)="E",DIR("A")=" Press Return to Continue or ^ to Exit" D ^DIR K DIR
 Q:$D(DIRUT)
 N FMTDT
 I PSJPG=1,$E(IOST)="C" W @IOF
 I PSJPG>1 W @IOF W "Run Date: " S FMTDT=$$FMTE^XLFDT(DT) W FMTDT
 W ?72,"Page "_PSJPG S PSJPG=PSJPG+1
 W !,?15,"Inpatient Free Text Dosage Entry Report",!,?17,"Period: "
 S FMTDT=$$FMTE^XLFDT(BEGDT) W FMTDT W " to "
 S FMTDT=$$FMTE^XLFDT(ENDT) W FMTDT
 W !,"Drug",?40,"Free Text Entry",?74,"Count",!,"    Provider:Count"
 W ! F Y=1:1:79 W "-"
 W ! Q
DTC ;
 N DD,MM S DD=31,MM=+$E(Y,4,5) I MM'=12 S MM=MM+1,MM=$S(MM<10:"0",1:"")_MM,X2=Y,X1=$E(Y,1,3)_MM_"00" D ^%DTC S DD=X
 S ENDT=Y+DD
 Q
