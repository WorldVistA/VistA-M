VPRENC ;SLC/MKB -- VistA Encounter updates ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**19,20,26,25,27,28,29**;Sep 01, 2011;Build 11
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Collect all visit changes in (NOW = time last modified):
 ;^XTMP("VPRPX",0) = DT+2 ^ DT ^ VPR ENCOUNTERS
 ;^XTMP("VPRPX", visit~dfn) =  NOW ^ ID ^ NEW ^ VTYP
 ;^XTMP("VPRPX", visit~dfn, "SUB", ien) = NEW
 ;^XTMP("VPRPX", visit~dfn, "SUB", ien, 0) = BEFORE 0-node, if deleted
 ;^XTMP("VPRPX", "DOC", ien) = NOW ^ id [^ visit ^ @/1, if amended]
 ;^XTMP("VPRPX", "DOC", ien, 0) = BEFORE 0-node, if deleted
 ;^XTMP("VPRPX", "AVST"/"ADOC", NOW, ien) = ""
 ;
 ; where:
 ; NOW  = time last modified
 ; ID   = record id as 'ien;file#'
 ; NEW  = 1 if new during session
 ; VTYP = 1 if visit type in V CPT was deleted (else null)
 ;
PX ; -- PXK VISIT DATA EVENT protocol listener
 Q:'$P($G(^VPR(1,0)),U,2)  ;monitoring disabled
 N VST,PX0A,PX0B,DFN,VSTX,VPRPX,X,NOW,NEW,ID,SUB,DA,ACT,VTYP
 S VST=+$O(^TMP("PXKCO",$J,0)) Q:VST<1
 S PX0A=$G(^TMP("PXKCO",$J,VST,"VST",VST,0,"AFTER")),PX0B=$G(^("BEFORE"))
 S DFN=$S($L(PX0A):+$P(PX0A,U,5),1:+$P(PX0B,U,5)) Q:DFN<1
 S VSTX=VST_"~"_DFN ;visit id for XTMP
 ;
 ; get or set up ^XTMP
 S VPRPX=$NA(^XTMP("VPRPX"))
 L +@VPRPX@(VSTX):5 ;I'$T
 ;
 ; Visit file
 S X=$G(@VPRPX@(VSTX)),NOW=+X,ID=$P(X,U,2),NEW=$P(X,U,3),VTYP=$P(X,U,4)
 K:NOW @VPRPX@("AVST",NOW,VSTX)      ;reset clock
 I ID="" S ID=VST_";9000010"
 S NOW=$$NOW^XLFDT,@VPRPX@("AVST",NOW,VSTX)=""
 S:PX0B="" NEW=1
 S @VPRPX@(VSTX)=NOW_U_ID_U_NEW_U_VTYP
 ;
 ; V-files
 F SUB="IMM","ICR","XAM","POV","HF","CPT" D  ;"PED","SK"
 . S DA=0 F  S DA=$O(^TMP("PXKCO",$J,VST,SUB,DA)) Q:DA<1  D
 .. S ACT=$$DIFF(SUB,DA) Q:'ACT      ;not changed
 .. I SUB="HF" Q:$$NAME(SUB,DA)=""   ;not Hx
 .. I SUB="CPT" D  Q:$$DUP(DA)       ;duplicate code
 ... Q:$P($G(^TMP("PXKCO",$J,VST,SUB,DA,0,"BEFORE")),U)'?1"992"2N
 ... S:ACT<1 $P(@VPRPX@(VSTX),U,4)=1 ;visit type deleted
 .. S NEW=$G(@VPRPX@(VSTX,SUB,DA)) S:ACT=2 NEW=1
 .. S @VPRPX@(VSTX,SUB,DA)=NEW       ;new flag
 .. S X=$G(^TMP("PXKCO",$J,VST,SUB,DA,0,"AFTER")) S:'X X=$G(^("BEFORE"))
 .. S:$L(X) @VPRPX@(VSTX,SUB,DA,0)=X
PXQ ; done
 L -@VPRPX@(VSTX)
 I '$G(@VPRPX@("ZTSK")) D NEWTSK
 Q
 ;
DIFF(NM,IEN) ; -- returns 0/1 if un/changed, 2 if new, -1 if deleted
 N NODE,AFTER,BEFORE,DIFF
 S DIFF=0 F NODE=0,12,13,811 D  Q:DIFF
 . S AFTER=$G(^TMP("PXKCO",$J,VST,NM,IEN,NODE,"AFTER")),BEFORE=$G(^("BEFORE"))
 . Q:BEFORE=AFTER  S DIFF=1
 . S:(NODE=0)&(BEFORE="") DIFF=2     ;new
 . S:(NODE=0)&(AFTER="") DIFF=-1     ;deleted
 Q DIFF
 ;
EDP(IEN) ; -- EDP Log file #230 AVPR index
 Q:'$P($G(^VPR(1,0)),U,2)  ;monitoring disabled
 N EDP0,VST,DFN,VSTX,VPRPX,X,NOW,ID,NEW
 S IEN=+$G(IEN) Q:IEN<1
 S EDP0=$G(^EDP(230,IEN,0)),VST=+$P(EDP0,U,12) Q:VST<1
 S DFN=+$P(EDP0,U,6) Q:DFN<1
 ; non-PCE event so post immediately for BMS
 D POST^VPRHS(DFN,"Encounter",VST_";9000010")
 Q
 ; get or set up ^XTMP [old]
 S VSTX=VST_"~"_DFN ;visit id for XTMP
 S VPRPX=$NA(^XTMP("VPRPX"))
 L +@VPRPX@(VSTX):5 ;I'$T
 ;
 ; Visit file
 S X=$G(@VPRPX@(VSTX)),NOW=+X,ID=$P(X,U,2),NEW=$P(X,U,3)
 K:NOW @VPRPX@("AVST",NOW,VSTX) ;reset clock
 I ID="" S ID=VST_";9000010"
 S NOW=$$NOW^XLFDT,@VPRPX@("AVST",NOW,VSTX)=""
 S @VPRPX@(VSTX)=NOW_U_ID_U_NEW
 ;
 L -@VPRPX@(VSTX)
 I '$G(@VPRPX@("ZTSK")) D NEWTSK
 Q
 ;
TIU(IEN,ACT,VST) ; -- TIU Document file #8925 [from TIU/R^VPREVNT]
 ; add to ^XTMP("VPRPX") list w/encounters
 N VPRPX,X0,NOW,NEW
 S VPRPX=$NA(^XTMP("VPRPX")),IEN=+$G(IEN)
 L +@VPRPX@("DOC",IEN):5 ;I'$T
 ;
 S X0=$G(@VPRPX@("DOC",IEN)),NOW=+X0 K:NOW @VPRPX@("ADOC",NOW,IEN)
 S VST=$G(VST,$P(X0,U,3)),NEW=$P(X0,U,4) ;VST passed in if retracted
 ; ACT=1 for new amendment, if aborted (@) kill XTMP and quit
 I NEW,$G(ACT)="@" K @VPRPX@("DOC",IEN) L -@VPRPX@("DOC",IEN) Q
 ;
 S NOW=$$NOW^XLFDT,@VPRPX@("ADOC",NOW,IEN)="" S:$L($G(ACT)) NEW=ACT
 S @VPRPX@("DOC",IEN)=NOW_U_IEN_";8925"_U_VST_U_NEW
 S:NEW="@" @VPRPX@("DOC",IEN,0)=$$NODE("TIU(8925,",IEN,0)
 L -@VPRPX@("DOC",IEN)
 I '$G(@VPRPX@("ZTSK")) D NEWTSK
 Q
 ;
NEWTSK ; -- start new task
 L +^XTMP("VPRPX","ZTSK"):3 Q:'$T  ;will try again
 ; if no competing process got there first, create task
 I '$G(^XTMP("VPRPX","ZTSK")) D QUE(5)
 L -^XTMP("VPRPX","ZTSK")
 Q
 ;
QUE(M) ; -- create task to post encounters, documents to HS
 N ZTRTN,ZTDTH,ZTDESC,ZTIO,ZTSAVE,ZTUCI,ZTCPU,ZTPRI,ZTKIL,ZTSYNC,ZTSK
 S ZTRTN="TASK^VPRENC",ZTDESC="VPR Encounters",ZTIO=""
 S M=+$G(M,5),ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,,,M)
 D ^%ZTLOAD
 S ^XTMP("VPRPX","ZTSK")=$G(ZTSK)
 S ^XTMP("VPRPX",0)=$$FMADD^XLFDT(DT,2)_U_DT_"^Encounters for HealthShare"
 Q
 ;
TASK ; -- post an encounter update
 S ZTREQ="@" Q:'$P($G(^VPR(1,0)),U,2)   ;monitoring disabled
 N VPRPX,VPRDT,VPRI,VSTX,VST,X0,DFN,V0,VNM,VFL,VDA,VID,ACT,X,VPRD14,VPRSQ
 S VPRPX=$NA(^XTMP("VPRPX")),VPRDT=$$FMADD^XLFDT($$NOW^XLFDT,,,-2)
 S VPRD14=$$FMADD^XLFDT(DT,14)
 ; post visits that have been stable for at least 5 minutes
 S VPRI=0 F  S VPRI=$O(@VPRPX@("AVST",VPRI)) Q:VPRI<1  Q:VPRI>VPRDT  D
 . S VSTX="" F  S VSTX=$O(@VPRPX@("AVST",VPRI,VSTX)) Q:VSTX=""  D
 .. I '$D(@VPRPX@(VSTX)) K @VPRPX@("AVST",VPRI,VSTX) Q
 .. L +@VPRPX@(VSTX):5 Q:'$T            ;will requeue
 .. S X0=$G(@VPRPX@(VSTX)),VST=+VSTX,DFN=+$P(VSTX,"~",2)
 .. S V0=$G(^AUPNVSIT(VST,0))
 .. I V0=""!($P(V0,U,5)'=DFN) D  Q      ;deleted or replaced:
 ... I $P(X0,U,3) D KILL Q              ; not in HS, just kill XTMP
 ... D DELALL                           ; else send delete to HS
 .. ; post Encounter to HS
 .. S VID=$P(X0,U,2) S:VID="" VID=VST_";9000010"
 .. K VPRSQ D POST^VPRHS(DFN,"Encounter",VID,,,.VPRSQ)
 .. I $G(VPRSQ),$P(X0,U,4) D SAVST(VPRSQ,"U",1) ;VType deleted
TV .. ; post related v-file records next
 .. S VFL="" F  S VFL=$O(@VPRPX@(VSTX,VFL)) Q:VFL=""  D
 ... S VDA=0 F  S VDA=$O(@VPRPX@(VSTX,VFL,VDA)) Q:VDA<1  D
 .... S VNM=$$NAME(VFL,VDA) Q:VNM=""    ;not tracked
 .... S V0=$$ZERO(VFL,VDA),VID=VDA_";"_$P(VNM,U,2)
 .... ; if exists & is valid send to HS, else quit/delete
 .... I V0,$P(V0,U,2)=DFN,$P(V0,U,3)=VST D POST^VPRHS(DFN,$P(VNM,U),VID,,VST) Q
 .... Q:$G(@VPRPX@(VSTX,VFL,VDA))       ;new, backed out (don't send)
 .... K VPRSQ ;S VID=VDA_"~"_VST_";"_$P(VNM,U,2)
 .... D POST^VPRHS(DFN,$P(VNM,U),VID,"@",VST,.VPRSQ)
 .... I $G(VPRSQ) D SAVE(VPRSQ,VDA)
 .. D KILL ;delete XTMP, unlock
 .. ; post related documents
 .. S VDA=0 F  S VDA=$O(^TIU(8925,"V",+VST,VDA)) Q:VDA<1  I $G(@VPRPX@("DOC",VDA)) D DOC
TD ; look for waiting documents w/o visit [yet]
 S VPRI=0 F  S VPRI=$O(@VPRPX@("ADOC",VPRI)) Q:VPRI<1  Q:VPRI>VPRDT  D
 . S VDA=0 F  S VDA=$O(@VPRPX@("ADOC",VPRI,VDA)) Q:VDA<1  D
 .. I '$G(@VPRPX@("DOC",VDA)) K @VPRPX@("ADOC",VPRI,VDA) Q  ;bad xref
 .. D DOC
TQ ; re-task if more data
 S X=$O(@VPRPX@(0)) I $L(X),X'="ZTSK" D QUE(5) Q
 K @VPRPX@("ZTSK")
 Q
 ;
DELALL ; -- delete visit + vfiles from HS [from TASK]
 S VFL="" F  S VFL=$O(@VPRPX@(VSTX,VFL)) Q:VFL=""  D
 . S VDA=0 F  S VDA=$O(@VPRPX@(VSTX,VFL,VDA)) Q:VDA<1  D
 .. S VNM=$$NAME(VFL,VDA) I VNM="" Q   ;not tracked in HS
 .. I $G(@VPRPX@(VSTX,VFL,VDA)) Q      ;never sent to HS
 .. K VPRSQ S VID=VDA_";"_$P(VNM,U,2)  ;_"~"_VST
 .. D POST^VPRHS(DFN,$P(VNM,U),VID,"@",VST,.VPRSQ)
 .. I $G(VPRSQ) D SAVE(VPRSQ,VDA)
 K VPRSQ D POST^VPRHS(DFN,"Encounter",VST_";9000010","@",,.VPRSQ)
 I $G(VPRSQ) D SAVST(VPRSQ)
KILL ; clean up ^XTMP
 K @VPRPX@(VSTX),@VPRPX@("AVST",VPRI,VSTX)
 L -@VPRPX@(VSTX)
 Q
 ;
SAVE(NUM,DA) ; -- save data for V-file record [from TV,DELALL] in
 ; ^XTMP("VPR-"_NUM, 0) = DT+14 ^ DT ^ Deleted records
 ; ^XTMP("VPR-"_NUM,DA) = DFN ^ TYPE ^ ID ^ U/D ^ VISIT#
 ; ^XTMP("VPR-"_NUM,DA,0) = DATA
 Q:'$G(NUM)  Q:'$G(DA)
 S:'$G(VPRD14) VPRD14=$$FMADD^XLFDT(DT,14)
 S ^XTMP("VPR-"_NUM,0)=VPRD14_U_DT_"^Deleted record for AVPR"
 S ^XTMP("VPR-"_NUM,DA)=DFN_U_$P(VNM,U)_U_VID_"^D^"_VST
 S X=$G(@VPRPX@(VSTX,VFL,DA,0)) S:$L(X) ^XTMP("VPR-"_NUM,DA,0)=X
 Q
SAVST(NUM,ACT,TYP) ; -- save visit in ^XTMP [from TASK,DELALL]
 Q:'$G(NUM)  Q:'$G(VST)  S ACT=$G(ACT,"D")
 S:'$G(VPRD14) VPRD14=$$FMADD^XLFDT(DT,14)
 S ^XTMP("VPR-"_NUM,0)=VPRD14_U_DT_"^Deleted visit for AVPR"
 S ^XTMP("VPR-"_NUM,VST)=DFN_"^Encounter^"_VST_";9000010^"_ACT_U_U_$G(TYP)
 Q
 ;
DOC ; -- process Document VDA [from TASK]
 L +@VPRPX@("DOC",VDA):5 Q:'$T  ;will requeue
 N VPRTIU,STS,ACT,CLS,VPRSQ
 S X0=$G(@VPRPX@("DOC",VDA)) D EXTRACT(VDA)
 S VST=$G(VPRTIU(.03)),DFN=$G(VPRTIU(.02))
 ; quit if has visit, still in ^XTMP (send w/visit)
 I VST,$G(@VPRPX@(VST_"~"_DFN)) L -@VPRPX@("DOC",VDA) Q
 ; else post to HS
 S VID=$P(X0,U,2) I VID="" S VID=VDA_";8925"
 S STS=$G(VPRTIU(.05)),ACT=$S($P(X0,U,4)="@":"@",STS>13:"@",1:"")
 I ACT="@",'VST S VST=$P(X0,U,3) ;amended
 D POST^VPRHS(DFN,"Document",VID,ACT,VST,.VPRSQ)
 I ACT="@",$G(VPRSQ) D  ;save to preserve visit#
 . S ^XTMP("VPR-"_VPRSQ,VDA)=DFN_"^Document^"_VID_"^D^"_VST
 . S X=+$G(VPRTIU(.01)),^XTMP("VPR-"_VPRSQ,VDA,0)=X_U_DFN_U_VST
 . S ^XTMP("VPR-"_VPRSQ,0)=$$FMADD^XLFDT(DT,14)_U_DT_"^Deleted record for AVPR"
 ; update alert containers if CLS is CWD
 S CLS=$G(VPRTIU(.04))
 D:CLS=27 POST^VPRHS(DFN,"AdvanceDirective",VID,ACT)
 D:CLS=30!(CLS=31) POST^VPRHS(DFN,"Alert",VID,ACT)
DQ ; clean up array, unlock
 K @VPRPX@("DOC",VDA),@VPRPX@("ADOC",+X0,VDA)
 L -@VPRPX@("DOC",VDA)
 ;
 I VST D  ;add/update Surgery when report completed
 . N PROC S PROC=$G(VPRTIU(1405)) Q:'PROC
 . I PROC["SRF" D POST^VPRHS(DFN,"Procedure",+PROC_";130",,VST) Q
 Q
 ;
EXTRACT(DA) ; -- return data in VPRTIU(FLD)
 N I,DR,DIC,DIQ,VPRQ Q:'$G(DA)
 I $P(X0,U,4)="@" D  Q
 . N X1 S X1=$G(@VPRPX@("DOC",VDA,0))
 . F I=1:1:5 S VPRTIU(".0"_I)=$P(X1,U,I)
 S DIC=8925,DIQ="VPRQ",DIQ(0)="I",DR=".01:.05;1405" D EN^DIQ1
 F I=.01,.02,.03,.04,.05,1405 S VPRTIU(I)=$G(VPRQ(8925,DA,I,"I"))
 Q
 ;
NAME(X,DA) ; -- return container name for V-files
 N Y S Y=""
 I X="HF" D
 . N NM S DA=+$G(DA),NM=$P($G(^AUTTHF($$HF(DA),0)),U)
 . I $$FHX(NM) S Y="FamilyHistory^9000010.23" Q
 . I $$SHX(NM) S Y="SocialHistory^9000010.23" Q
 . I $$C19(NM) S Y="Vaccination^9000010.23" Q
 . ;S Y="HealthConcern^9000010.23"
 I X="IMM" S Y="Vaccination^9000010.11"
 I X="ICR" S Y="Vaccination^9000010.707"
 I X="XAM" S Y="PhysicalExam^9000010.13"
 I X="POV" S Y="Diagnosis^9000010.07"
 I X="CPT" S Y="Procedure^9000010.18"
 ; X="SK"  S Y="Procedure^9000010.12"
 ; X="PED" S Y="education^9000010.16"
 I X="DOC" S Y="Document^8925"
 Q Y
 ;
HF(IEN) ; -- return AUTTHF ptr, expects VST & VSTX
 N X S IEN=+$G(IEN)
 I $G(VST),$D(^TMP("PXKCO",$J,VST)) D  Q +X
 . S X=$G(^TMP("PXKCO",$J,VST,"HF",IEN,0,"BEFORE")) S:'X X=$G(^("AFTER"))
 I $D(VPRPX),$G(VSTX) S X=$G(@VPRPX@(VSTX,"HF",IEN,0)) I X Q +X
 S X=$$ZERO("HF",IEN) I X Q +X
 Q 0
 ;
FHX(X) ; -- return 1 or 0, if HF name is for FamilyHistory
 I X["FAMILY HISTORY" Q 1
 I X["FAMILY HX" Q 1
 Q 0
 ;
SHX(X) ; -- return 1 or 0, if HF name is for SocialHistory
 I (X["TOBACCO")!(X["SMOK") Q 1
 ; (X["LIVES")!(X["LIVING") Q 1
 ; (X["RELIGIO")!(X["SPIRIT") Q 1
 Q 0
 ;
C19(X) ; -- return 1 or 0, if HF name is for COVID imm refusal
 I X?1"VA-SARS-COV-2 VACCINE REFUSAL".E Q 1
 I X?1"VA-SARS-COV-2 IMM REFUSAL".E Q 1
 Q 0
 ;
ZERO(X,DA) ; -- return zero node
 N GBL,Y S Y="",DA=+$G(DA)
 S GBL="^AUPNV"_$G(X),Y=$G(@GBL@(DA,0))
 Q Y
 ;
NODE(NAME,DA,NUM) ; -- return global node
 N GBL,Y S Y="",DA=+$G(DA)
 S GBL=U_NAME_DA_")"
 S Y=$G(@GBL@(NUM))
 Q Y
 ;
DUP(DA) ; -- duplicate CPT record?
 N VCPT,NODE,CPT,PKG,Y,IEN,GBL,IMM,SYS
 M VCPT=^TMP("PXKCO",$J,VST,SUB,DA)
 S NODE=$S($G(VCPT(0,"AFTER")):"AFTER",1:"BEFORE")
 ; skip eval/mgt codes
 S CPT=$P($G(VCPT(0,NODE)),U) I CPT>99200,CPT<99500 Q 1
 ; skip Surgery (duplicates)
 S PKG=+$P($G(VCPT(812,NODE)),U,2) I PKG,$P($G(^DIC(9.4,PKG,0)),U,2)="SR" Q 1
 ; skip V IMMUNIZATIONS codes
 S GBL="^AUTTIMM",(Y,IEN)=0
 F  S IEN=$O(^TMP("PXKCO",$J,VST,"IMM",IEN)) Q:IEN<1  D  Q:Y
 . S NODE=$S($G(^TMP("PXKCO",$J,VST,"IMM",IEN,0,"AFTER")):"AFTER",1:"BEFORE")
 . S IMM=+$G(^TMP("PXKCO",$J,VST,"IMM",IEN,0,NODE))
 . S SYS=+$O(@GBL@(IMM,3,"B","CPT",0))
 . S:SYS Y=+$O(@GBL@(IMM,3,SYS,1,"B",CPT,0))
 I Y Q 1
 ; else ok/not dup
 Q 0
