SDC1 ;ALB/GRR - PRINT CLINIC PRE-CANCELLATION LIST ; 6/30/05 10:15am
 ;;5.3;Scheduling;**379,398,439,478,545**;Aug 13, 1993;Build 8
 K ^TMP("SDC1",$J) S DGVAR="SD^SC^SDTIME",DGPGM="START^SDC1" D ZIS^DGUTQ Q:POP
START U IO S SDCNT=0 K DUOUT,DTOUT N SDBADD,SNODE S SDBADD=0,SNODE=""
 ; sd*5.3*439 FOR loop changed to exclude if different clinic
 F J=SD:0 S J=$O(^SC(SC,"S",J)) Q:J=""!(J\1-SD)!$D(DTOUT)!$D(DUOUT)  D
 . S J2=0 F  S J2=$O(^SC(SC,"S",J,1,J2)) Q:J2=""!$D(DTOUT)!$D(DUOUT)  D
 .. I '$D(^SC(SC,"S",J,1,J2,0)) I $D(^("C")) D DELETE Q   ;SD*545 if corrupt node delete
 .. I '+$G(^SC(SC,"S",J,1,J2,0)) D DELETE Q   ;SD*545 if DFN missing delete record
 .. S DFN=+^SC(SC,"S",J,1,J2,0),SDLE=$P(^(0),U,2)
 .. Q:'$D(^DPT(DFN,"S",J,0))  S SNODE=^(0)
 .. Q:$P(SNODE,U,1)'=SC&($P(SNODE,U,14)'=SDTIME)
 .. I $P(SNODE,U,2)'["C"!($P(SNODE,U,14)=SDTIME) D PLST Q:$D(DTOUT)!$D(DUOUT)
 G:$D(DUOUT)!$D(DTOUT) EXIT  I SDCNT=0 S NOAP=1 W !,"NO APPOINTMENTS SCHEDULED"
 I SDBADD D
 . W !!,"* THIS PATIENT HAS BEEN FLAGGED WITH A BAD ADDRESS INDICATOR, NO LETTER"
 . W !,"WILL BE PRINTED."
 I $E(IOST,1,2)'="C-" W @IOF
EXIT K DUOUT,DTOUT,I,J,J2,X,DFN,SNODE,SDLE,SDCNT,^TMP("SDC1",$J) W !! D CLOSE^DGUTQ Q  ; sd*5.3*439 added local vars to kill
PLST I SDCNT=0!($Y+2>IOSL) S DIR(0)="E" D:$E(IOST,1,2)="C-" ^DIR K DIR Q:$D(DTOUT)!$D(DUOUT)  D HED
 ;
 ;CHECK FOR DUPLICATE ENTRY IN FILE 44 - SD*5.3*379
 ;
 I $D(^TMP("SDC1",$J,J,DFN)) Q
 S ^TMP("SDC1",$J,J,DFN)=""
 ;
 N VA D PID^VADPT6
 N CSLNK S CSLNK=$P($G(^SC(SC,"S",J,1,J2,"CONS")),U) ;SD/478
 W ! I $$BADADR^DGUTL3(+DFN) W "*" S SDBADD=1
 W $P(^DPT(DFN,0),"^",1),?30,VA("PID") S X=J D TM^SDROUT0 W ?43,$J(X,8),?52,$S(CSLNK'="":"CONS",1:""),?58,SDLE W:$D(^DPT(DFN,.13)) ?64,$P(^(.13),"^",1) ;SD/478
 S SDCNT=SDCNT+1 Q
HED W @IOF,!,$P(^SC(SC,0),"^",1)," Clinic Pre-cancellation list",!,"PATIENT NAME",?34,"ID",?43,"APPT TIME",?56,"LENGTH",?64,"TELEPHONE"
 W ! F I=1:1:79 W "-"
 Q
 ;
DELETE ;SD*5.3*545 when applicable, delete corrupt appt sub-record
 S DA(2)=SC,DA(1)=J,DA=J2
 S DIK="^SC("_DA(2)_",""S"","_DA(1)_",1," D ^DIK
 K DA,DIK
 Q
