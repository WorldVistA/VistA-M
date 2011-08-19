SCENIA2 ;ALB/SCK - INCOMPLETE ENCOUNTER ERROR DISPLAY PROTOCOLS, CONT. ; OCT 21, 1998
 ;;5.3;Scheduling;**66,132,158**;AUG 13, 1993
 ;
EVT1(SDXMT,INF) ; Returns ifn for ^SC(clinic,"S",date,1,ifn)
 N SINDX,SDDA
 ;
 S SINDX=0 F  S SINDX=$O(^SC(INF("CLINIC"),"S",INF("ENCOUNTER"),1,SINDX))  Q:'SINDX>0  D  Q:$D(SDDA)
 . I +^SC(INF("CLINIC"),"S",INF("ENCOUNTER"),1,SINDX,0)=INF("DFN") S SDDA=SINDX
 Q $G(SDDA)
 ;
EI ; Entry point for the SCENI ENCOUNTER INFORMATION protocol
 I '$D(SD53P158) N SD53P158 S SD53P158="LM" ; Called via LM.
 I '$D(^XUSEC("SCENI ENCOUNTER EDIT",DUZ)) D  Q
 . W !,$C(7),"You do not have this security key, contact your supervisor."
 ;
 N SDATA,SCEN,SDXMT,SCXER,SDOE,SCINF,SCSTAT,SDEVT,SDHDL,SDDA,SCELAP,SCSTPLC,OLDSC,SDQUIT,SDLOG
 ;
 K PARENT,VISIT
 D HDLKILL^SDAMEVT
 S SDXMT=$G(^TMP("SCENI XMT",$J,0)) Q:'SDXMT
 S SCSTAT=$$OPENC^SCUTIE1(SDXMT,"SCINF")
 I SCSTAT<0 D  G EIQ
 . W !!,$C(7),"Entry "_$P(^SD(409.73,SDXMT,0),U),?5,$G(SCINF("ERROR"))
 . D PAUSE^VALM1
 ;
 I SCSTAT>0 D  G EIQ
 . W !!,$C(7),"This is a deleted entry.  Encounter information cannot be changed."
 . D PAUSE^VALM1
 ;
 S DFN=SCINF("DFN")
 S SDOE=$P(^SD(409.73,SDXMT,0),U,2)
 S SDHDL=$$HANDLE^SDAMEVT($P($G(^SCE(SDOE,0)),U,8)),SDDA=$$EVT1(SDXMT,.SCINF)
 Q:SDHDL']""
 ;
 S SDATA=SDDA_"^"_DFN_"^"_SCINF("ENCOUNTER")_"^"_SCINF("CLINIC")
 S SDQUIT=0
 ;
 L +^SCE(SDOE):0 I '$T D  G EIQ
 . W !?5,$CHAR(7),"Another user is editing this entry"
 I SD53P158="LM" D FULL^VALM1
 K DIRUT
 W !
 D BEFORE^SDAMEVT(.SDATA,DFN,SCINF("ENCOUNTER"),SCINF("CLINIC"),SDDA,SDHDL)
 ;
 K OLDSC S OLDSC=+$P($G(^SCE(SDOE,0)),U,3)
 S DIR(0)="409.68,.03",DA=SDOE
 D ^DIR K DIR G:$D(DIRUT)!(Y="") EIQ
 S $P(SCSTPLC,U)=+Y
 D SET(+Y,.03,SDOE)
 ;
 S DIR(0)="409.68,.11",DA=SDOE
 D ^DIR K DIR G:$D(DIRUT)!(Y="") A1
 S $P(SCSTPLC,U,2)=+Y
 D SET(+Y,.11,SDOE)
 ;
 ; ** Display current Appt. Type and Elig. Codes
 N SD1 S SD1=$P($G(^SCE(SDOE,0)),U,10)
 W !!!,$C(7),"Current Appointment Type for Encounter: "_$S($G(SD1):$P(^SD(409.1,SD1,0),U),1:"")
 K SD1 S SD1=$P($G(^SCE(SDOE,0)),U,13)
 W !,"Current Eligibility for Encounter: "_$S($G(SD1):$P(^DIC(8,SD1,0),U),1:""),!
 ;
 S DIR(0)="YA",DIR("B")="NO",DIR("A")="Change Eligibility/Appointment type? " D ^DIR K DIR G:$D(DIRUT)!(Y=0) A1
 ; 
 W !,"The following are system defaults only.",!
 ;
 S SCELAP=$$ELAP^SDPCE(DFN,SCINF("CLINIC"))
 ;
 N SDPRIM
 S SDPRIM=$$ONEELIG
 ;if only a primary ask if they want to change to it and change
 I SDPRIM,+SDPRIM'=SD1 DO
 .N DIR
 .S DIR(0)="YA",DIR("B")="YES"
 .S DIR("A",1)="There is only a primary eligibility for this patient: "_$P(SDPRIM,U,2)
 .S DIR("A")="Do you wish to change the encounter to this? "
 .S DIR("?")="No other Eligibilities are selectable."
 .S DIR("?",1)="YES will result in the current primary Eligibility being used for the encounter."
 .S DIR("?",2)="NO will result in the encounter's Eligibility being left the same."
 .D ^DIR
 .I Y=1 S $P(SCELAP,U,1)=+SDPRIM,$P(SCELAP,U,2)=$P(SDPRIM,U,2)
 .E  S $P(SCELAP,U,1)=SD1,$P(SCELAP,U,2)=$P($G(^DIC(8,+SD1,0)),U,1)
 .Q
 ;
 D SET(+SCELAP,.13,SDOE)
 D SET(+$P(SCELAP,U,3),.1,SDOE)
A1 D RESYNC(SCSTPLC,$G(SCELAP),SDOE,OLDSC,DFN)
 D LOGDATA^SDAPIAP(SDOE,.SDLOG)
 D AFTER^SDAMEVT(.SDATA,DFN,SCINF("ENCOUNTER"),SCINF("CLINIC"),SDDA,SDHDL)
 ;
 D EVT^SDAMEVT(.SDATA,5,0,SDHDL)
 I '$D(SDOK) D  I $G(RTN)<0 G EIQ
 . S RTN=$$VALIDATE^SCMSVUT2(SDXMT)
 . I RTN<0 D ERMSG^SCENIA1(5) Q
 . S RTN=$$SETRFLG^SCENIA1(SDXMT)
 . I RTN<0 D ERMSG^SCENIA1(3) Q
 I $D(SDOK) S SDOK=1
 L -^SCE(SDOE):0
EIQ K OLDSC
 Q
 ;
SET(SDVAL,SDFLD,DA) ; Set updated entry into file #409.68.
 ;
 S ^TMP("SCENI EDIN",$J,409.68,DA_",",SDFLD)=SDVAL
 D FILE^DIE("K","^TMP(""SCENI EDIN"",$J)")
 I $D(^TMP("DIERR",$J,1)) W !!,"???"
 K ^TMP("SCENI EDIN",$J),^TMP("DIERR",$J)
 Q
 ;
UPDENC ;  Update Outpatient Encounter Option entry point
 N SDOE,SDXMT,DFN,SDOK
 N SD53P158 S SD53P158="OPT" ;Entered via menu option.
 ;
 S SDOK=0
 K ^TMP("SCENI XMT",$J)
 S DIR(0)="PA^409.68:EMQ",DIR("S")="I $D(^SD(409.73,""AENC"",Y))"
 S DIR("A")="Select Encounter to update: "
 S DIR("?")="Enter partial name, last four, or date of encounter."
 S DIR("??")="^S %DT=""PX"" D HELP^%DTC"
 D ^DIR K DIR G UPDQ:$D(DIRUT)
 ;
 S SDOE=+Y
 S SDXMT=$O(^SD(409.73,"AENC",SDOE,0))
 S ^TMP("SCENI XMT",$J,0)=SDXMT
 D EI
UPDQ ;
 K DFN
 Q
 ;
RESYNC(STPL,SCELP,SDOE,SCOLD,SDFN) ;
 N SDOEC,SDCDT
 ;
 ; ** Update any child encounters and for each child encounter, search for
 ;    any entries in the Scheduling Visits File, #409.5.  If there is a 
 ;    match, update then entry in #409.5
 ;
 ;everthing else
 S SDOEC=""
 F  S SDOEC=$O(^SCE("APAR",SDOE,SDOEC)) Q:'SDOEC  D
 . I +$P($G(^SCE(SDOE,0)),U,13)>0 D SET(+$P($G(^SCE(SDOE,0)),U,13),.13,SDOEC)
 . I +$P($G(^SCE(SDOE,0)),U,10)>0 D SET(+$P($G(^SCE(SDOE,0)),U,10),.1,SDOEC)
 . I +$P($G(^SCE(SDOE,0)),U,11)>0 D SET(+$P($G(^SCE(SDOE,0)),U,11),.11,SDOEC)
 . I "2"[+$P($G(^SCE(SDOEC,0)),U,8),($P($G(^SCE(SDOEC,0)),U,3)=SCOLD) D SET(+$P($G(^SCE(SDOE,0)),U,3),.03,SDOEC)
 ;
 ; ** Update the entry in the Clinic Appointment multiple for the encounter
 S SDOEDT=$P($G(^SCE(SDOE,0)),U),SDCLN=$P($G(^(0)),U,4)
 S SDN1=0  F  S SDN1=$O(^SC(SDCLN,"S",SDOEDT,1,SDN1)) Q:'SDN1  D
 . I $P($G(^SC(SDCLN,"S",SDOEDT,1,SDN1,0)),U)=SDFN D
 .. S DIE="^SC(SDCLN,""S"",SDOEDT,1,",DA(2)=SDCLN,DA(1)=SDOEDT,DA=SDN1
 .. S DR="30////"_$P(SCELP,U)
 .. L +^SC(SDCLN,"S",SDOEDT,1,SDN1)
 .. D ^DIE K DIE,DR,DA
 .. L -^SC(SDCLN,"S",SDOEDT,1,SDN1)
 ;
 ; ** Update the entry in the Patient Appointment multiple for the encounter.
 I $D(^DPT(SDFN,"S",SDOEDT,0)),($P(^(0),U,20)=SDOE) D
 . S DIE="^DPT(SDFN,""S"",",DA(1)=SDFN,DA=SDOEDT
 . S DR="9.5////"_$P(SCELP,U,3)
 . L +^DPT(SDFN,"S",SDOEDT)
 . D ^DIE K DIE,DR,DA
 . L -^DPT(SDFN,"S",SDOEDT)
 ;
 W !,"Updating Completed."
 Q
 ;
ONEELIG() ;
 ;tests for and returns the primary if that is the only eligibility
 ;
 N VAEL
 D ELIG^VADPT
 Q $S($O(VAEL(1,0)):0,1:VAEL(1))
 ;
