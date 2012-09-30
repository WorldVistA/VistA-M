PRSNRMM1 ;WOIFO-JAH - POC Record and Timecard Mismatches;07/31/09
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
NURSE ;Nurse view their own mismatch data entry point
 N PRSIEN,SSN,X
 S PRSIEN="",SSN=$P($G(^VA(200,DUZ,1)),"^",9)
 I SSN'="" S PRSIEN=$O(^PRSPC("SSN",SSN,0))
 I 'PRSIEN D  Q
 .  W !!,*7
 .  W "Your SSN was not found in both the New Person & Employee File!"
 ;
 ; if not in 450 as a nurse then explain and quit
 I +$$ISNURSE^PRSNUT01(PRSIEN)'>0 D NOTNRSDX  Q
 ;
 ; get pay period and report mismatches
 D MAIN(PRSIEN)
 Q
 ;
NOTNRSDX ;
 N X
 W !!,*7
 W ?5,"Your PAID-ETA parameters for your current log on do not reflect"
 W !,?5,"the parameters required for Nursing Point of Care Data.",!
 S X=$$ASK^PRSLIB00(1)
 Q
COORD ;VANOD Site Coordinator entry point
 ; Coordinator has no access limits so let them pick any nurse
 N DIC,X,Y,DUOUT,DTOUT,PRSIEN
 S DIC="^PRSPC(",DIC(0)="AEQMZ",DIC("S")="I $$ISNURSE^PRSNUT01(Y)"
 D ^DIC
 Q:Y'>0!$D(DTOUT)!$D(DUOUT)
 S PRSIEN=$P(Y,U)
 D MAIN(PRSIEN)
 Q
 ;
DAP ; POC data approval personnel entry point
 N GROUP,VALUE,PRSIEN
 ; prompt DEP to select a group to report on.  They must have
 ; access to the group.
 ;
 D ACCESS^PRSNUT02(.GROUP,"A",DT,0)
 ;
 ; quit if any error during group selection
 I $P($G(GROUP(0)),U,2)="E" W !!!,?4,$P(GROUP(0),U,3) S X=$$ASK^PRSLIB00(1) Q
 S VALUE=+GROUP($O(GROUP(0)))
 Q:VALUE'>0
 S PRSIEN=+$$PICKNURS^PRSNUT03($P(GROUP(0),U,2),VALUE)
 Q:PRSIEN'>0
 D MAIN(PRSIEN)
 Q
 ;
DEP ; Entry point for mismatches for Data Entry Personnel.
 ;
 N GROUP,VALUE,PRSIEN
 ; prompt DEP to select a group to report on.  They must have
 ; access to the group.
 ;
 D ACCESS^PRSNUT02(.GROUP,"E",DT,0)
 ;
 ; quit if any error during group selection
 I $P($G(GROUP(0)),U,2)="E" W !!!,?4,$P(GROUP(0),U,3) S X=$$ASK^PRSLIB00(1) Q
 S VALUE=+GROUP($O(GROUP(0)))
 Q:VALUE'>0
 S PRSIEN=+$$PICKNURS^PRSNUT03($P(GROUP(0),U,2),VALUE)
 Q:PRSIEN'>0
 D MAIN(PRSIEN)
 Q
 ;
 ;= = = = = = = = = = = = = = = = = =
 ;
MAIN(PRSIEN) ;
 ;
 N DIC,X,Y,DUOUT,DTOUT,PPI
MAIN1 ;
 S DIC="^PRSN(451,",DIC(0)="AEQMZ"
 S DIC("A")="Select a Pay Period: "
 D ^DIC
 Q:$D(DUOUT)!$D(DTOUT)
 I $G(Y)'>0 W $C(7),"  Invalid Pay Period" G MAIN1
 S PPI=+Y
 N %ZIS,POP,IOP
 S %ZIS="MQ"
 D ^%ZIS
 Q:POP
 I $D(IO("Q")) D
 . K IO("Q")
 . N ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTUCI,ZTCPU,ZTPRI,ZTKIL,ZTSYNC
 . S ZTDESC="PRSN POC/ETA MISMATCH REPORT"
 . S ZTRTN="REP^PRSNRMM1"
 . S ZTSAVE("PRSIEN")=""
 . S ZTSAVE("PPI")=""
 . D ^%ZTLOAD
 . I $D(ZTSK) S ZTREQ="@" W !,"Request "_ZTSK_" Queued."
 E  D
 . D REP
 Q
 ;
REP ;
 U IO
 D PPMM^PRSNRMM(PRSIEN,PPI)
 W !!,"End of Report"
 D ^%ZISC
 Q
 ;
TL ;Entry point for T&L Unit report
 ; Report has no access limits so let them pick any T&L group
 N GROUP
 D PIKGROUP^PRSNUT04(.GROUP,"T",1)
 ; quit if any error during group selection
 I $P($G(GROUP(0)),U,2)="E" D  Q
 .W !,$P(GROUP(0),U,3)
 D TLMAIN
 Q
 ;
TLMAIN ;
 ;
 N DIC,X,Y,DUOUT,DTOUT,PPI
TLMAIN1 ;
 S DIC="^PRSN(451,",DIC(0)="AEQMZ"
 S DIC("A")="Select a Pay Period: "
 D ^DIC
 Q:$D(DUOUT)!$D(DTOUT)
 I $G(Y)'>0 W $C(7),"  Invalid Pay Period" G TLMAIN1
 S PPI=+Y
 N %ZIS,POP,IOP
 S %ZIS="MQ"
 D ^%ZIS
 Q:POP
 I $D(IO("Q")) D
 . K IO("Q")
 . N ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTUCI,ZTCPU,ZTPRI,ZTKIL,ZTSYNC
 . S ZTDESC="PRSN POC/ETA MISMATCH REPORT"
 . S ZTRTN="MMREP^PRSNRMM1"
 . S ZTSAVE("GROUP(")=""
 . S ZTSAVE("PPI")=""
 . D ^%ZTLOAD
 . I $D(ZTSK) S ZTREQ="@" W !,"Request "_ZTSK_" Queued."
 E  D
 . D MMREP
 Q
 ;
MMREP ;
 N PRSIEN,PRSNG,PRSNARY,PRSNTL,PICK,PG,STOP
 K ^TMP($J,"PRSNRMM")
 U IO
 S (PICK,PG,STOP)=0
 F  S PICK=$O(GROUP(PICK)) Q:PICK=""!STOP  D
 . S PRSNG=GROUP(0)_"^"_PICK_"^"_GROUP(PICK)
 . S PRSIEN=0
 . F  S PRSIEN=$O(^PRSN(451,PPI,"E",PRSIEN)) Q:PRSIEN'>0!STOP  D
 .. S PRSNARY=$G(^PRSPC(PRSIEN,0))
 .. S PRSNAME=$P(PRSNARY,U)              ;Nurse Name
 .. S PRSNTL=$P(PRSNARY,U,8)             ;Nurse T&L
 .. Q:PRSNTL'=PICK
 .. S ^TMP($J,"PRSNRMM",PICK,PRSNAME,PRSIEN)=""
 ;
 S PICK=0
 F  S PICK=$O(^TMP($J,"PRSNRMM",PICK)) Q:PICK=""!STOP  D
 . W !!,"T&L UNIT: ",PICK
 . S PRSNAME=""
 . F  S PRSNAME=$O(^TMP($J,"PRSNRMM",PICK,PRSNAME)) Q:PRSNAME=""!STOP  D
 .. S PRSIEN=$O(^TMP($J,"PRSNRMM",PICK,PRSNAME,PRSIEN)) Q:PRSIEN=""!STOP  D
 ... D PPMM^PRSNRMM(PRSIEN,PPI,.PG,.STOP)
 ;
 W !!,"End of Report"
 D ^%ZISC
 K ^TMP($J,"PRSNRMM")
 Q
 ;
