SD53103A ;ALB/MJK - Unique Visit ID Clean Up ; March 10,1997
 ;;5.3;Scheduling;**103**;AUG 13, 1993
 ;
 Q
 ;
ONE ; -- entry point to select a single -1 encounter and resync
 N DIC,Y,SDOE,SDPKG,SDTALK,SDEXIT
 IF '$$INIT^SD53103B() G ONEQ
 S SDTALK=1,SDEXIT=0
 D HDR^SD53103B("Single") W !
 F  D  IF SDEXIT G ONEQ
 . S DIC="^SCE(",DIC("S")="N SDOE0 S SDOE0=^(0) IF $$SCREEN^SD53103A(SDOE0)",DIC(0)="AEMQ" D ^DIC
 . IF +Y<1 S SDEXIT=1 Q
 . ; -- display record
 . S SDOE=+Y D OE^SD53103B(SDOE)
 . IF $$OK^SD53103B() D
 . . N SDX
 . . S SDX=$$MSG(SDOE,$$RESYNC(SDOE))
 . . IF $P(SDX,U)["RE-LINKED" D
 . . . W "Re-Linked successfully:"
 . . . D OE^SD53103B(SDOE)
 . . ELSE  D
 . . . W $C(7),"Error has occurred.",!,"Please make a note of the following: ",!?10,SDX,!
ONEQ Q
 ;
SCAN ; -- entry point to scan encounter file for -1's to either
 ;    'count only' or 'count and fix'
 N SDBEG,SDEND,SDMODE,SDPKG,SDTALK
 ;
 ; -- init global locals
 IF '$$INIT^SD53103B() G SCANQ
 D HDR^SD53103B("Date Range")
 ;
 ; -- get date range
 IF '$$RANGE^SD53103B(.SDBEG,.SDEND) G SCANQ
 ;
 ; -- ask which mode
 S SDMODE=$$MODE^SD53103B() IF 'SDMODE G SCANQ
 ;
 ; -- ask if ok to continue
 IF '$$OK^SD53103B() G SCANQ
 ; -- queue process
 D QUEUE
SCANQ Q
 ;
QUEUE ; queue job
 N I,ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK
 W !
 S ZTIO="",ZTDESC="Fix -1 Outpatient Encounters",ZTRTN="DQ^SD53103A"
 F I="SDTALK","SDMODE","SDBEG","SDEND","SDPKG" S ZTSAVE(I)=""
 D ^%ZTLOAD
 I $G(ZTSK) W !!,"Task queued:  #",ZTSK
 Q
 ;
 ;
DQ ; -- dequeue point...collect results and generate message.
 N SDOE,SDOE0,SDDT,SDCNT,SDRT
 ; -- set up and scan records
 S SDDT=SDBEG,SDCNT=0,SDRT=$NA(^TMP("SDVISIT FIX",$J)) K @SDRT
 F  S SDDT=$O(^SCE("B",SDDT)) Q:'SDDT!(SDDT>SDEND)  D  Q:$$S^%ZTLOAD
 . S SDOE=""
 . F  S SDOE=$O(^SCE("B",SDDT,SDOE)) Q:'SDOE  D
 . . S SDOE0=$G(^SCE(SDOE,0)) Q:SDOE0=""
 . . ; -- use only -1's
 . . IF $$SCREEN(.SDOE0) D
 . . . S SDCNT=SDCNT+1
 . . . IF SDMODE=1 S @SDRT@(SDCNT)=$$MSG(SDOE,"COUNT ONLY")
 . . . IF SDMODE=2 S @SDRT@(SDCNT)=$$MSG(SDOE,$$RESYNC(SDOE))
 ;
 D RESULTS^SD53103B(.SDMODE,.SDBEG,.SDEND,.SDRT,.SDCNT)
 K @SDRT
 Q
 ;
SCREEN(SDOE0) ; -- process screen for -1's and null ID's
 N SDOK
 ; -- don't use if before 10/1/96
 IF +SDOE0,+SDOE0<2961001 Q 0
 ; -- use if -1 id
 IF $P(SDOE0,U,20)=-1 Q 1
 ; -- use if id null and (has a completion date OR action req status)
 IF $P(SDOE0,U,20)="",$P(SDOE0,U,7)!($P(SDOE0,U,12)=14) Q 1
 ; -- use if id nul and visit exists
 IF $P(SDOE0,U,20)="",$P(SDOE0,U,5) Q 1
 Q 0
 ;
MSG(SDOE,STATUS) ; -- build display text
 N SDOE0,SDMSG
 S SDOE0=$G(^SCE(+$G(SDOE),0))
 IF SDOE0="" S SDMSG="Bad encounter entry passed"_U_+$G(SDOE)_U G MSGQ
 S SDMSG=$S(STATUS["ERROR":">> ",1:"   ")_STATUS
 S SDMSG=SDMSG_U_SDOE_U_$P(SDOE0,U,6)_U_$P(SDOE0,U,5)
 S SDMSG=SDMSG_U_$P($G(^DPT(+$P(SDOE0,U,2),0),"Unknown Patient"),U)
 S SDMSG=SDMSG_U_$$FMTE^XLFDT(+SDOE0)
 S SDMSG=SDMSG_U_$P($G(^SC(+$P(SDOE0,U,4),0),"Unknown Clinic"),U)
MSGQ Q SDMSG
 ;
RESYNC(SDOE) ; -- resync sd and pce data
 N SDOE0,SDVST,SDOK,SDOEC,SDCNT
 S SDOK=0
 S SDOE0=$G(^SCE(SDOE,0))
 IF SDOE0="" G RESYNCQ
 ;
 ; -- get visit
 S SDVST=$$VSIT(SDOE)
 IF 'SDVST G RESYNCQ
 D DOT
 ;
 ; -- set oe visit field
 D OESET(SDOE,SDVST)
 ;
 ; -- quit if child
 IF $P(SDOE0,U,6) D  G RESYNCQ
 . S SDOK=1
 ;
 ; -- set oe visit field for children of parent
 S SDOEC=0
 F  S SDOEC=$O(^SCE("APAR",SDOE,SDOEC)) Q:'SDOEC  D OESET(SDOEC,SDVST)
 ;
 ; -- send data to pce for parent
 S SDOK=$$DATA2PCE(SDOE)
 ;
RESYNCQ Q $S(SDOK:"RE-LINKED",1:"ERROR OCCURRED")
 ;
OESET(SDOE,SDVST) ; -- set oe visit field
 N DA,DR,DIE
 ;
 ; -- if id = -1 reset id
 IF $P($G(^AUPNVSIT(+SDVST,150)),U)=-1 D
 . N ID
 . S ID=$$GETVID^VSITVID()
 . K ^AUPNVSIT("VID",-1,+SDVST)
 . S $P(^AUPNVSIT(+SDVST,150),U)=ID
 . S ^AUPNVSIT("VID",ID,+SDVST)=""
 ;
 S DIE="^SCE(",DR=".05////"_SDVST,DA=SDOE D ^DIE
 D DOT
 Q
 ;
VSIT(SDOE) ; -- get/find visit
 N SDOE0,SDVST,VSIT,DFN,DIE,DIC,DR,DA,X,VSITPKG,SDOEP
 S SDVST=0
 S SDOE0=$G(^SCE(+$G(SDOE),0))
 IF SDOE0="" G VSITQ
 ;
 ; -- if entry already has visit, use it
 IF $P(SDOE0,U,5) S SDVST=$P(SDOE0,U,5) G VSITQ
 ;
 ; -- if parent has pointer to visit, use it
 S SDOEP=$P(SDOE0,U,6)
 IF SDOEP D  IF SDVST G VSITQ
 . S SDVST=$P($G(^SCE(SDOEP,0)),U,5)
 ;
 ; -- call api to get visit entry
 S VSIT(0)="ENMD1"
 S VSIT=+SDOE0
 S DFN=+$P(SDOE0,U,2)
 S VSITPKG="SD"
 S VSIT("CLN")=$P(SDOE0,U,3)
 S VSIT("SVC")=$S($$INP^SDAM2(DFN,VSIT)="I":"I",1:"A")
 S VSIT("INS")=$P($G(^DG(40.8,+$P(SDOE0,U,11),0)),U,7)
 S VSIT("ELG")=$S($P(SDOE0,U,13):$P(SDOE0,U,13),1:+$G(^DPT(DFN,.36)))
 IF $P(SDOE0,U,4) S VSIT("LOC")=$P(SDOE0,U,4)
 IF $P(SDOE0,U,6) S X=$G(^SCE($P(SDOE0,U,6),0)) IF X]"" S VSIT=+X I $P(X,U,5) S VSIT("LNK")=$P(X,U,5)
 IF '$P(SDOE0,U,6) D
 . S VSIT("PRI")="P"
 E  D
 . IF $P(SDOE0,U,8)=4 D
 . . S VSIT("PRI")="C",VSIT("SVC")=$S($$INP^SDAM2(DFN,VSIT)="I":"D",1:"X")
 . E  D
 . . S VSIT("PRI")="S"
 ;
 ; -- do checks
 I 'VSIT,'DFN,'VSIT("ELG")!('VSIT("INS"))!('VSIT("CLN")) G VSITQ
 ;
 ; -- add/find visit
 ;
 ; -- change call if orinating process is a disposition.
 I $P(SDOE0,U,8)=3 D
 .; -- must be valid disposition clinic
 . IF $O(^PX(815,1,"DHL","B",+$P(SDOE0,U,4),0)) D DISPVSIT^PXAPI Q
 .; -- if interactive mode, ok to get visit
 . IF SDTALK D
 . . D DISPVSIT^PXAPI
 . .; -- visit created and loc defined; re-set oe location field
 . . IF +$G(VSIT("IEN"))>0,VSIT("LOC") D
 . . . S $P(^SCE(SDOE,0),U,4)=VSIT("LOC")
 . . .; -- re-set children oe location field
 . . . N SDOEC S SDOEC=0
 . . . F  S SDOEC=$O(^SCE("APAR",SDOE,SDOEC)) Q:'SDOEC  D
 . . . . S $P(^SCE(SDOEC,0),U,4)=VSIT("LOC")
 ;
 IF $P(SDOE0,U,8)'=3 D
 .; -- quit if parent is a disposition and bad location; parent will fix
 . IF $P($G(^SCE(+$P(SDOE0,U,6),0)),U,8)=3,'$O(^PX(815,1,"DHL","B",+$P(SDOE0,U,4),0)) Q
 . D ^VSIT
 ;
 IF +$G(VSIT("IEN"))>0 S SDVST=+VSIT("IEN")
VSITQ Q SDVST
 ;
DATA2PCE(SDOE) ; -- send data to pce
 N SDOE0,X,SDVST,SDPRV,SDIAG,SDCLS,SDPROC,SDPCE,SDOK,SDOEC
 S SDOK=0
 ;
 ; -- gather needed data
 S SDOE0=$G(^SCE(SDOE,0)) G DATAQ:SDOE0=""
 S SDVST=$P(SDOE0,U,5) G DATAQ:'SDVST
 ;
 ; -- if visit has v-file data quit
 IF $O(^AUPNVCPT("AD",SDVST,0))!($O(^AUPNVPRV("AD",SDVST,0)))!($O(^AUPNVPOV("AD",SDVST,0))) S SDOK=1 G DATAQ
 ;
 ; -- get data from parent
 D SET(SDOE,"SDPRV",409.44),DOT
 D SET(SDOE,"SDIAG",409.43),DOT
 D SET(SDOE,"SDCLS",409.42),DOT
 D PROC^SCDXUTL0(SDOE,"SDPROC"),DOT ; -- gets both parent & children data
 ;
 ; -- get data from children
 S SDOEC=0
 F  S SDOEC=$O(^SCE("APAR",SDOE,SDOEC)) Q:'SDOEC  D
 . D SET(SDOEC,"SDPRV",409.44),DOT
 . D SET(SDOEC,"SDIAG",409.43),DOT
 . D SET(SDOEC,"SDCLS",409.42),DOT
 ;
 ; ---build pce data array
 D BUILD("SDPRV","SDIAG","SDCLS","SDPROC","SDPCE")
 ;
 ; -- call pce api to file data
 IF $$DATA2PCE^PXAPI("SDPCE",SDPKG,"SD TO PCE RESYNC",SDVST)=1 D
 . S SDOK=1
DATAQ Q SDOK
 ;
BUILD(SDPROV,SDDX,SDCLASS,SDCPT,SDATA) ; -- build pce data array
 N X,SDI,SDIEN,SDCNT
 S SDI=0 F  S SDI=$O(@SDCLASS@(SDI)) Q:'SDI  D
 . S X=@SDCLASS@(SDI)
 . S @SDATA@("ENCOUNTER",1,$P("AO^IR^SC^EC",U,+X))=$P(X,U,3)
 ;
 ; -- set provider info
 IF $O(@SDPROV@(0)) D
 . S (SDCNT,SDIEN)=0
 . F  S SDIEN=$O(@SDPROV@(SDIEN)) Q:'SDIEN  D
 . . S X=@SDPROV@(SDIEN)
 . . S SDCNT=SDCNT+1
 . . S @SDATA@("PROVIDER",SDCNT,"NAME")=+X
 ;
 ; -- set dx info
 IF $O(@SDDX@(0)) D
 . S (SDCNT,SDIEN)=0
 . F  S SDIEN=$O(@SDDX@(SDIEN)) Q:'SDIEN  D
 . . S X=@SDDX@(SDIEN)
 . . S SDCNT=SDCNT+1
 . . S @SDATA@("DX/PL",SDCNT,"DIAGNOSIS")=+X
 . . S @SDATA@("DX/PL",SDCNT,"PRIMARY")=+$P(X,U,3)
 ;
 ; -- set cpt info
 IF $O(@SDCPT@(0)) D
 . ; -- count times performed
 . N SDX
 . S (SDCNT,SDIEN)=0
 . F  S SDIEN=$O(@SDCPT@(SDIEN)) Q:'SDIEN  D
 . . S X=@SDCPT@(SDIEN)
 . . S SDX(+X)=$G(SDX(+X))+1
 . ;
 . ; -- build nodes
 . S (SDCNT,SDIEN)=0
 . F  S SDIEN=$O(SDX(SDIEN)) Q:'SDIEN  D
 . . S X=SDX(SDIEN)
 . . S SDCNT=SDCNT+1
 . . S @SDATA@("PROCEDURE",SDCNT,"PROCEDURE")=SDIEN
 . . S @SDATA@("PROCEDURE",SDCNT,"QTY")=+X
BUILDQ Q
 ;
SET(SDOE,ARRAY,FILE) ;Set-up Array for Outpatient Encounter
 ; Input  -- SDOE      Outpatient Encounter IEN
 ; Output -- ARRAY     Provider or dx Array Subscripted by a ien
 ;
 N SDIEN
 S SDIEN=0
 F  S SDIEN=$O(^SDD(FILE,"OE",SDOE,SDIEN)) Q:'SDIEN  D
 . S X=$G(^SDD(FILE,SDIEN,0)) Q:X=""
 . S @ARRAY@(SDIEN)=X
SETQ Q
 ;
DOT ; -- write '.' if ok to talk
 IF SDTALK D
 . W "."
 Q
 ;
