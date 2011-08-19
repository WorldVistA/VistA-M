SCDXSUP1 ;RENO/KEITH ALB/SCK - Supervisory Options for Ambulatory Care Reporting; 2/26/97
 ;;5.3;Scheduling;**104,127,132**;Aug 13,1993
 Q
 ;
APPTY ; Edit Appointment type for Add/Edit
 N DIC,DTOUT,DUTOUT,SCDFN,SCI,SCG,SCOUT,SCDT,DIR,DIRUT
 ;
 S SCBD=$$ASKDT("Beginning") G:SCBD<0 APPQ
APP1 S SCED=$$ASKDT("Ending") G:SCED<0 APPQ
 I SCED<SCBD D  G APP1
 . W !!,"Ending date cannot be earlier than the beginning date!"
 ;
ASK S DIC="^DPT(",DIC(0)="AEMQ"
 D ^DIC K DIC
 G:$D(DTOUT)!$D(DUOUT) APPQ
 G:Y'>0 EXIT
 S SCDFN=+Y
 ;
 I '$D(^SCE("C",SCDFN)) D  G ASK
 . W !!,"This patient has no outpatient encounters on file!",!!
 ;
 K ^TMP("SCEA",$J)
 S (SCI,SCG,SCOUT)=0
 ;
 D WAIT^DICD
 W !
 S SCDT=SCED+.999999
 F  S SCDT=$O(^SCE("ADFN",SCDFN,SCDT),-1) Q:'SCDT!(SCOUT)!(SCDT<SCBD)  D
 . S SCI=SCI+1
 . S SCDT=$P(SCDT,".") ; -- reset to stop processing date
 . S ^TMP("SCEA",$J,1,SCI)=SCDT
 . W !,SCI,?5,$$FMTE^XLFDT(SCDT,"1P")
 . I SCI#5=0 D GET(SCI)
 ;
 I SCI'>0 D  G ASK
 . W !!,"No encounters on file for this patient during this date range.",!
 ;
 I SCI#5'=0 D GET(SCI)
 D:SCG SCED
 G ASK
APPQ ;
 K DIE,DR,DTOUT,DUOUT
 Q
 ;
EXIT ;
 Q
 ;
GET(SCN) ;  Select appointment from list
 N DIR,DIRUT,DUOUT,DTOUT
 K DIR
 W !
 S DIR(0)="NO^1:"_SCN,DIR("A")="Select number, or ENTER to continue"
 S DIR("?",1)="Select entry to edit appointment type for from the list above"
 S DIR("?")="Press ENTER to continue."
 D ^DIR K DIR
 I $D(DUOUT)!($D(DTOUT)) S SCOUT=1 Q
 I $D(DIRUT) Q
 I Y S SCG=Y,SCOUT=1
 Q
 ;
SCED ; Select stop code
 N DIC,DIR,DIE,DR,SCK,DA,SCY,SCLINE,SUCCESS,SCDT,SCDATE,SCE,SCE0,SDLOG
 ;
 S SCDATE=^TMP("SCEA",$J,1,SCG)
 ;
 S SCDT=SCDATE
 F  S SCDT=$O(^SCE("ADFN",SCDFN,SCDT)) Q:'SCDT!($P(SCDT,".")'=SCDATE)  D
 . S SCE=0
 . F  S SCE=$O(^SCE("ADFN",SCDFN,SCDT,SCE)) Q:'SCE  D
 . . S SCE0=$G(^SCE(SCE,0))
 . . I $P($G(^SC(+$P(SCE0,U,4),"OOS")),U),$G(^SCE(SCE,"CG")) D SET
 ;
 I '$D(SCK) D  Q
 . W !!,"No occasion-of-service add/edits for this patient/date.",!
 ;
 I $D(SCK) D
 . W !!,"Appt. DT",?24,"Location",?60,"Appt. Type"
 . S SCLINE="",$P(SCLINE,"-",(IOM-1))="" W !,SCLINE
 ;
 S SCE=0
 F  S SCE=$O(SCK(SCE)) Q:'SCE  D  W !!
 . S Y=$P(SCK(SCE),U) X ^DD("DD")
 . W !,Y,?24,$E($P(SCK(SCE),U,2),1,30),?60,$E($P(SCK(SCE),U,3),1,18)
 ;
 K DIC
 S DIC="^SD(409.1,",DIC(0)="AEMQ"
 S DIC("A")="Select new appointment type for these encounters: "
 S DIC("B")="COMPUTER GENERATED"
 D ^DIC K DIC
 Q:$D(DTOUT)!$D(DUOUT)
 Q:Y<1
 S SCY=$P(Y,U)
 ;
 K DIR
 S DIR(0)="Y",DIR("A")="OK to change to "_$P(Y,U,2),DIR("B")="YES"
 D ^DIR K DIR
 Q:$D(DTOUT)!$D(DUOUT)
 Q:'Y
 ;
 K DIE,DR
 S DA=0
 F  S DA=$O(SCK(DA)) Q:'DA  D
 . K SUCCESS
 . L +^SCE(DA):5 S SUCCESS=$S(($T):1,1:0)
 . I SUCCESS D
 .. S DIE="^SCE(",DR=".1////^S X=SCY"
 .. D ^DIE K DIE
 .. D LOGDATA^SDAPIAP(DA,.SDLOG)
 . E  D
 .. W !,"Outpatient Encounter entry: "_DA_" for "_$P($G(^DPT(SCDFN,0)),U)_" is in use, cannot edit."
 . L -^SCE(DA)
 ;
 W !,"Done."
 Q
 ;
SET ;
 N SCDT,SCCL,SCTY
 ;
 S SCDT=+SCE0
 S SCCL=$P(^SC($P(SCE0,U,4),0),U)
 S SCTY=$P($G(^SD(409.1,+$P(SCE0,U,10),0)),U)
 S:SCDT SCK(SCE)=SCDT_U_SCCL_U_SCTY
 Q
 ;
ASKDT(TXT) ; Enter beginning date for searching outpatient encounter file
 S DIR(0)="DA^2961001:NOW:EXP",DIR("A")="Enter "_TXT_" date for search: "
 S DIR("?")="^D HELP^%DTC"
 S DIR("B")=$$FMTE^XLFDT($$DT^XLFDT())
 D ^DIR K DIR
 S:$D(DIRUT) Y=-1
 K DIRUT
 Q Y
