SDCO1 ;ALB/RMO - Appointment - Check Out;Apr 23 1999  ; 12/11/08 5:30pm  ; Compiled December 12, 2008 13:01:34
 ;;5.3;Scheduling;**27,132,149,193,250,296,446,538**;08/13/93;Build 5
 ;
 ;check out if sd/369 is released before 446!!!
 ;
EN ;Entry point for SDCO APPT CHECK OUT protocol
 N SDCOALBF,SDCOAP,SDCOBG,SDCODT,VALMY
 S VALMBCK=""
 D EN^VALM2(XQORNOD(0))
 D FULL^VALM1
 S SDCOAP=0 D NOW^%DTC S SDCODT=$P(%,".")_"."_$E($P(%,".",2)_"0000",1,4)
 F  S SDCOAP=$O(VALMY(SDCOAP)) Q:'SDCOAP  D
 .I $D(^TMP("SDAMIDX",$J,SDCOAP)) K SDAT S SDAT=^(SDCOAP) D
 ..W !!,^TMP("SDAM",$J,+SDAT,0)
 ..I $$CHK^SDCOU(SDCOAP) D CO(+$P(SDAT,"^",2),+$P(SDAT,"^",3),+$P(SDAT,"^",4),+$P(SDAT,"^",5),0,SDCODT,"CO",+SDAT,.SDCOALBF)
 I $G(SDCOALBF) S SDCOBG=VALMBG W ! D BLD^SDAM S:$D(@VALMAR@(SDCOBG,0)) VALMBG=SDCOBG
 S VALMBCK="R"
 K SDAT
 Q
 ;
CO(DFN,SDT,SDCL,SDDA,SDASK,SDCODT,SDCOACT,SDLNE,SDCOALBF) ;Appt Check Out
 ; Input  -- DFN      Patient file IEN
 ;           SDT      Appointment Date/Time
 ;           SDCL     Hospital Location file IEN for Appt
 ;           SDDA     IEN in ^SC multiple or null [Optional]
 ;           SDASK    Ask Check Out Date/Time     [Optional]
 ;           SDCODT   Date/Time of Check Out      [Optional]
 ;           SDCOACT  Appt Mgmt Check Out Action  [Optional]
 ;           SDLNE    Appt Mgmt Line Number       [Optional]
 ; Output -- SDCOALBF Re-build Appt Mgmt List
 I $D(XRTL) D T0^%ZOSV
 N SDCOQUIT,SDOE,SDATA
 S:'SDDA SDDA=$$FIND^SDAM2(DFN,SDT,SDCL)
 I 'SDDA W !!,*7,">>> You cannot check out this appointment." D PAUSE^VALM1 G COQ
 S SDATA=$G(^DPT(DFN,"S",SDT,0))
 ; ** MT Blocking removed
 ;S X="EASMTCHK" X ^%ZOSF("TEST") I $T,$G(EASACT)'="W",$$MT^EASMTCHK(DFN,$P($G(SDATA),U,16),"C",$G(SDT)) D PAUSE^VALM1 G COQ
 ;
 ;-- if new encounter, pass to PCE
 I $$NEW^SDPCE(SDT) D  S VALMBCK="R",SDCOALBF=1 G COQ
 . N SDCOED
 . S SDOE=$$GETAPT^SDVSIT2(DFN,SDT,SDCL)
 . ;
 . ; -- has appt already been checked out
 . S SDCOED=$$CHK($TR($$STATUS^SDAM1(DFN,SDT,SDCL,SDATA,SDDA),";","^"))
 . ;
 . ; -- if not checked out then do interview process
 . IF '$$CODT^SDCOU(DFN,SDT,SDCL) D
 . . N SDCOMKF,SDTRES
 . . ;
 . . ; -- first, check if should make follow-up appt
 . . IF $G(SDCOACT)="CO",'SDCOED D
 . . . N SDCOMKF
 . . . D MC^SDCO5(SDOE,1,.SDCOMKF,.SDCOQUIT) Q:$D(SDCOQUIT)
 . . . ;
 . . . ; -- Set flag to re-build appointment list
 . . . IF $G(SDCOMKF) S SDCOALBF=1
 . . ;
 . . ; -- c/o interview if user didn't quit
 . . I '$D(SDCOQUIT),'SDCOED D
 . . . N SDAPTYP
 . . . S SDTRES=$$INTV^PXAPI("INTV","SD","PIMS",$P($G(^SCE(+SDOE,0)),U,5),$P($G(^SCE(+SDOE,0)),U,4),DFN)
 . . . Q:SDTRES<0
 . . . ;
 . . . ; -- ask user if they want to see c/o screen
 . . . S SDGAFC=$$ASK^SDCO6
 . . . I 'SDGAFC D
 . . . .N SDELIG
 . . . .S SDELIG=$$ELSTAT^SDUTL2(DFN)
 . . . .I $$MHCLIN^SDUTL2(SDCL),'($$COLLAT^SDUTL2(SDELIG)!$P(SDATA,U,11)) D
 . . . . .I $$NEWGAF^SDUTL2(DFN) D
 . . . . . .I '$$GAFCM^SDUTL2() S SDGAFC=1
 . . .I SDGAFC D EN^SDCO(SDOE,,1)
 . ;
 . ; -- if already checked out then show c/o screen
 . E  D EN^SDCO(SDOE,,1)
 ;
 ; -- view if old encounters
 S SDOE=$$GETAPT^SDVSIT2(DFN,SDT,SDCL)
 D EN^SDCO(SDOE,,1)
 ;
COQ K % D EWLCHK Q
 Q
EWLCHK ;check if patient has any open EWL entries (SD/372)
 ;get appointment
 ;
 K ^TMP($J,"SDAMA301"),^TMP($J,"APPT")
 W:$D(IOF) @IOF D APPT^SDWLEVAL(DFN,SDT,SDCL)
 Q:'$D(^TMP($J,"APPT"))
 N SDEV D EN^SDWLEVAL(DFN,.SDEV) I SDEV,$L(SDEV(1))>0 D
 .K ^TMP("SDWLPL",$J),^TMP($J,"SDWLPL")
 .D INIT^SDWLPL(DFN,"M")
 .Q:'$D(^TMP($J,"SDWLPL"))
 .D LIST^SDWLPL("M",DFN)
 .F  Q:'$D(^TMP($J,"SDWLPL"))  N SDR D ANSW^SDWLEVAL(1,.SDR) I 'SDR D LIST^SDWLPL("M",DFN) D
 ..F  N SDR  D ANSW^SDWLEVAL(0,.SDR) Q:'$D(^TMP($J,"SDWLPL"))  I 'SDR W !!,"MUST ACCEPT OR ENTER A REASON NOT TO DISPOSITION MATCHED EWL ENTRY",!
 ..Q
 .Q
 Q
 ;
BEFORE(SDATA,DFN,SDT,SDCL,SDDA,SDHDL) ; -- event driver before ; not used
 S SDATA=SDDA_"^"_DFN_"^"_SDT_"^"_SDCL,SDHDL=$$HANDLE^SDAMEVT(1)
 D BEFORE^SDAMEVT(.SDATA,DFN,SDT,SDCL,SDDA,SDHDL)
 Q
 ;
AFTER(SDATA,DFN,SDT,SDCL,SDDA,SDHDL,SDLNE) ; -- event driver after ; not used
 D AFTER^SDAMEVT(.SDATA,DFN,SDT,SDCL,SDDA,SDHDL)
 D:$G(SDLNE) UPD(DFN,SDT,SDCL,SDLNE,SDATA("BEFORE","STATUS"),SDATA("AFTER","STATUS"))
 D EVT^SDAMEVT(.SDATA,5,0,SDHDL)
 Q
 ;
UPD(DFN,SDT,SDCL,SDLNE,SDSTB,SDSTA) ; -- update appt mgmt screen ; used by AFTER but AFTER is not used
 N SDAMBOLD
 I $P(SDSTB,"^",3)'=$P(SDSTA,"^",3) D UPD^SDAM2($$LOWER^VALM1($P(SDSTA,"^",3)),"STAT",SDLNE),UPD^SDAM2("","TIME",SDLNE) S SDAMBOLD(DFN,SDT,SDCL)=""
 I $P(SDSTA,"^",3)["CHECKED OUT",$P($P(SDSTA,"^",5),".")=DT D UPD^SDAM2($$TIME^SDAM1($P($P(SDSTA,"^",5),".",2)),"TIME",SDLNE)
 Q
 ;
ELIG(DFN,SDT,SDCL,SDDA) ; -- update elig if blank
 N X,DR
 I $P(^SC(SDCL,"S",SDT,1,SDDA,0),U,10)="" D
 .S X=+$G(^DPT(DFN,.36)),X=$S('$D(^DIC(8,X,0)):"",$P(^(0),U,4)=6:"",1:X)
 .I X]"" S DR="30////^S X="_X D DIE(SDCL,SDT,SDDA,DR)
 Q
 ;
CHK(SDSTB) ; -- is appointment checked out
 N Y
 I "^2^8^12^"[("^"_+SDSTB_"^"),$P(SDSTB,"^",3)["CHECKED OUT" S Y=1
 Q +$G(Y)
 ;
DT(DFN,SDT,SDCL,SDDA,SDASK,SDCODT,SDCOQUIT) ;Update Check Out Date
 N %DT,DR,SDCIDT,X
 S:'$D(^SC(SDCL,"S",0)) ^(0)="^44.001DA^^"
 S DR="",SDCIDT=$P($G(^SC(SDCL,"S",SDT,1,SDDA,"C")),"^"),X=$P($G(^("C")),"^",3)
 I X G DTQ:'SDASK  S DR="303R"
 I DR="",$P(^SC(SDCL,0),U,24),$$REQ^SDM1A(SDT)="CO" S DR="303R//"_$S($G(SDCODT):$$FTIME^VALM1($S(SDCODT<SDCIDT:SDCIDT,1:SDCODT)),1:"NOW")
 I DR="" S DR="303R///"_$S($G(SDCODT):"/"_$S(SDCODT<SDCIDT:SDCIDT,1:SDCODT),1:"NOW")
 S DR="S SDCOQUIT="""";"_DR_";K SDCOQUIT"
 D DIE(SDCL,SDT,SDDA,DR)
DTQ Q
 ;
DIE(SDCL,SDT,SDDA,DR) ; -- update appt data in ^SC
 N DA,DIE
 S DA(2)=SDCL,DA(1)=SDT,DA=SDDA,DIE="^SC("_DA(2)_",""S"","_DA(1)_",1,"
 D ^DIE K DQ,DE
DIEQ Q
