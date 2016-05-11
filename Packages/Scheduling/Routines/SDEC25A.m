SDEC25A ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
CO(DFN,SDT,SDCL,SDDA,SDASK,SDCODT,SDCOACT,SDLNE,SDCOALBF,SDECAPTID,SDQUIET,VPRV,APIERR) ;Appt Check Out
 ; Input  -- DFN      Patient file IEN
 ;           SDT      Appointment Date/Time
 ;           SDCL     Hospital Location file IEN for Appt
 ;           SDDA     IEN in ^SC multiple or null [Optional]
 ;           SDASK    Ask Check Out Date/Time     [Optional]
 ;           SDCODT   Date/Time of Check Out      [Optional]
 ;           SDCOACT  Appt Mgmt Check Out Action  [Optional]
 ;           SDLNE    Appt Mgmt Line Number       [Optional]
 ; Output -- SDCOALBF Re-build Appt Mgmt List
 ; Input  -- SDECAPTID Appointment ID
 ;           SDQUIET  No Terminal output 0=allow display 1=do not allow
 ;           VPRV     V Provider IEN - pointer to V PROVIDER file
 N SDCOQUIT,SDOE,SDATA
 N VALMBCK
 S:'SDDA SDDA=$$FIND^SDAM2(DFN,SDT,SDCL)
 I 'SDDA D  Q  ; RETURN ERROR IF SDQUIET
 . S APIERR=$G(APIERR)+1 S APIERR(APIERR)="SDCO1: Cannot check out this appointment - Hospital Location not identified."
 . G COQ
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
 . D CO^SDEC25B(SDOE,DFN,SDT,SDCL,SDCODT,SDECAPTID,SDQUIET,VPRV,.APIERR) Q
 ;
COQ K % Q
 ;
 ;
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
