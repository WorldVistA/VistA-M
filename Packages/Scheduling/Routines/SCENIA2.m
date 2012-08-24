SCENIA2 ;ALB/SCK - INCOMPLETE ENCOUNTER ERROR DISPLAY PROTOCOLS, CONT. ; OCT 21, 1998
 ;;5.3;Scheduling;**66,132,158,560**;AUG 13, 1993;Build 8
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
 N SDFLAG,SDVST S SDFLAG=0,SDVST=""  ;SD*560
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
 S:'SDDA SDFLAG=1  ;SD*5.3*560 encounter not associated w/sched appt
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
 K OLDSC,SDEDT S OLDSC=+$P($G(^SCE(SDOE,0)),U,3),SDEDT=$P(^(0),U,1)
EI1 S DIR(0)="409.68,.03",DA=SDOE
 D ^DIR K DIR G:$D(DIRUT)!(Y="") EIQ
 ;SD*560 do not allow if Inactive at time of encounter
 I $P(^DIC(40.7,+Y,0),U,3)'="" I $P(^(0),U,3)'>SDEDT D  G EI1
 .W !!,"Sorry, that Stop Code was INACTIVE at the time of the selected encounter.",!
 ;SD*560 do not allow if Restriction Type is "S"
 I $P(^DIC(40.7,+Y,0),U,6)="S" I $P(^(0),U,7)'>SDEDT D  G EI1
 .W !!,"Sorry, the Restriction Type for that Stop Code is 'S' (secondary only).",!,"You cannot select this stop code.",!
 S $P(SCSTPLC,U)=+Y
 D SET(+Y,.03,SDOE)
 I SDFLAG I OLDSC'=+Y D SET1(+Y,SDOE,1)  ;SD*560 set Visit & Trans flag
 ;
 K OLDDV S OLDDV=+$P($G(^SCE(SDOE,0)),U,11)  ;SD*560 get current Division
 S DIR(0)="409.68,.11",DA=SDOE
 D ^DIR K DIR G:$D(DIRUT)!(Y="") A1
 S $P(SCSTPLC,U,2)=+Y
 D SET(+Y,.11,SDOE)
 I OLDDV'=+Y D SETDV(+Y,SDOE)  ;SD*560 set Visit & Trans flag
 K OLDDV
 ;
 ; ** Display current Appt. Type and Elig. Codes
 N SD1,OLDAT S (SD1,OLDAT)=$P($G(^SCE(SDOE,0)),U,10)  ;SD*560 add OLDAT
 W !!!,$C(7),"Current Appointment Type for Encounter: "_$S($G(SD1):$P(^SD(409.1,SD1,0),U),1:"")
 K SD1,OLDELG S (SD1,OLDELG)=$P($G(^SCE(SDOE,0)),U,13)  ;sD*560 add OLDELG
 W !,"Current Eligibility for Encounter: "_$S($G(SD1):$P(^DIC(8,SD1,0),U),1:""),!
 ;
 S DIR(0)="YA",DIR("B")="NO",DIR("A")="Change Eligibility/Appointment type? " D ^DIR K DIR G:$D(DIRUT)!(Y=0) A1
 ;
 ;SD*560 if SC Indicator in Visit equals 1 (Service Connected) do not allow edit of Appt Type or Eligibility
 I $P(^SCE(SDOE,0),U,10)'=10 S SDVST=$P(^SCE(SDOE,0),U,5) I $D(^AUPNVSIT(SDVST,800)) I +$G(^(800))=1 D  G A1
 .W !!,"The Visit associated with the selected encounter is SERVICE CONNECTED."
 .W !,"You cannot edit the Appointment Type or Eligibility for this encounter.",!
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
 ;SD*560 if Elig edited on non-appt encounter, update Visit & Trans flag
 I SDFLAG I OLDELG'=+SCELAP D SET1(+SCELAP,SDOE,2)
 D SET(+$P(SCELAP,U,3),.1,SDOE)
 ;
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
 ;SD*560 if appt type edited, check if it was allowed and changed
 I $D(SCELAP) I OLDAT'=+$P(SCELAP,U,3) S POP=0 D
 .I OLDAT=10 I +$P(SCELAP,U,3)=11 D  Q:POP
 ..I +$P(^SCE(SDOE,0),U,10)'=11 I $D(^AUPNVSIT($P(^SCE(SDOE,0),U,5),800)) I +$G(^(800),"")=0 D A1WRT,A2WRT S POP=1 Q
 .I OLDAT=10 I +$P(SCELAP,U,3)'=11 D  Q:POP
 ..I +$P(^SCE(SDOE,0),U,10)=11 I $D(^AUPNVSIT($P(^SCE(SDOE,0),U,5),800)) I +$G(^(800),"")=1 D A1WRT1,A2WRT S POP=1 Q
 .Q:OLDAT'=$P(^SCE(SDOE,0),U,10)
 .I OLDAT'=11 I $P(SCELAP,U,3)=11 D A1WRT Q
 K POP
 ;SD*560 if Appt Type edit accepted on non-appt encounter set encounter to retrans
 I SDFLAG I $D(SCELAP) I OLDAT'=+$P(SCELAP,U,3) D
 .S XMIT="",XMIT=$$FINDXMIT^SCDXFU01(SDOE)  ;get IEN for file 409.73
 .D:XMIT STREEVNT^SCDXFU01(XMIT,2)  ;set trans event to edit
 .D:XMIT XMITFLAG^SCDXFU01(XMIT)  ;set flag for trans to Yes
 .K XMIT,OLDAT
 I $D(SDOK) S SDOK=1
 W !,"Updating Completed."  ;SD*560 moved from RESYNC
 L -^SCE(SDOE):0
EIQ K OLDSC,OLDAT,OLDELG,SDFLAG K:$D(POP) POP
 Q
 ;
A1WRT ;SD*560 write warning message, if applicable
 W !!,"The Visit entry associated with the selected encounter is NOT SERVICE CONNECTED."
 W !,"You cannot change the Appointment Type to SERVICE CONNECTED.",!
 Q
 ;
A1WRT1 ;SD*560 write warning message if Service Connected
 W !!,"The Visit entry associated with the selected encounter is SERVICE CONNECTED."
 W !,"You cannot change the Appointment Type to non-SERVICE CONNECTED."
 Q
 ;
A2WRT ;SD*560 display current Appointment Type per update.
 W !,"Appointment Type has been updated to ",$P(^SD(409.1,$P(^SCE(SDOE,0),U,10),0),U,1),".",!
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
SET1(SDVAL,SDOE,SEDT)  ;SD*560 set Visit & Trans Flag for non-appt encounter
 ;SEDT=1 primary stop code edit
 ;SEDT=2 eligibility edit
 N SDVST,VDT,SDCVST
 S SDVST=$P(^SCE(SDOE,0),U,5) Q:'SDVST
 S VDT=$$NOW^XLFDT
 S DA=SDVST,DIE="^AUPNVSIT("
 I SEDT=1 S DR=".08////^S X=SDVAL;.13////^S X=VDT" D ^DIE
 I SEDT=2 S DR=".21////^S X=SDVAL;.13////^S X=VDT" D ^DIE
 ;check for credit Visit and update, if applicable
 I $O(^AUPNVSIT("AD",SDVST,"")) S SDCVST=$O(^AUPNVSIT("AD",SDVST,"")) D
 .Q:SEDT=1   ;do not update if primary stop code edit
 .K DA,DR
 .S DA=SDCVST
 .S DR=".21////^S X=SDVAL;.13////^S X=VDT" D ^DIE
 S XMIT="",XMIT=$$FINDXMIT^SCDXFU01(SDOE)  ;get IEN for file 409.73
 D:XMIT STREEVNT^SCDXFU01(XMIT,2)  ;set trans event to edit
 D:XMIT XMITFLAG^SCDXFU01(XMIT)  ;set flag for trans required to Yes
 K XMIT,DA,DR,X,DIE
 Q
 ;
SETDV(SDVAL,SDOE)  ;SD*560 set Visit & Trans Flag when Division edited
 N SDVST,VDT,SDNDV,SDCVST
 S SDVST=$P(^SCE(SDOE,0),U,5) Q:'SDVST
 S SDNDV=+$P($G(^DG(40.8,SDVAL,0)),U,7)  ;get pointer to Institution file
 S VDT=$$NOW^XLFDT
 S DA=SDVST,DIE="^AUPNVSIT("
 S DR=".06////^S X=SDNDV;.13////^S X=VDT" D ^DIE
 ;check for credit Visit and update, if applicable
 I $O(^AUPNVSIT("AD",SDVST,"")) S SDCVST=$O(^AUPNVSIT("AD",SDVST,"")) D
 .K DA,DR
 .S DA=SDCVST
 .S DR=".06////^S X=SDNDV;.13////^S X=VDT" D ^DIE
 S XMIT="",XMIT=$$FINDXMIT^SCDXFU01(SDOE)  ;get IEN for file 409.73
 D:XMIT STREEVNT^SCDXFU01(XMIT,2)  ;set trans event to edit
 D:XMIT XMITFLAG^SCDXFU01(XMIT)  ;set flag for trans required to Yes
 K DA,DR,DIE,SD408,XMIT
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
 .. L +^SC(SDCLN,"S",SDOEDT,1,SDN1):$S($G(DILOCKTM)>0:DILOCKTM,1:5)  ;SD*560 added required timeout
 .. D ^DIE K DIE,DR,DA
 .. L -^SC(SDCLN,"S",SDOEDT,1,SDN1)
 ;
 ; ** Update the entry in the Patient Appointment multiple for the encounter.
 I $D(^DPT(SDFN,"S",SDOEDT,0)),($P(^(0),U,20)=SDOE) D
 . S DIE="^DPT(SDFN,""S"",",DA(1)=SDFN,DA=SDOEDT
 . S DR="9.5////"_$P(SCELP,U,3)
 . L +^DPT(SDFN,"S",SDOEDT):$S($G(DILOCKTM)>0:DILOCKTM,1:5)  ;SD*560 added required timeout
 . D ^DIE K DIE,DR,DA
 . L -^DPT(SDFN,"S",SDOEDT)
 ;
 Q
 ;
ONEELIG() ;
 ;tests for and returns the primary if that is the only eligibility
 ;
 N VAEL
 D ELIG^VADPT
 Q $S($O(VAEL(1,0)):0,1:VAEL(1))
 ;
