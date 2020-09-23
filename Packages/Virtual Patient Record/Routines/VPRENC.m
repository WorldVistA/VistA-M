VPRENC ;SLC/MKB -- VistA Encounter updates ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**19,20**;Sep 01, 2011;Build 9
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Collect all visit changes in (NOW = time last modified):
 ;^XTMP("VPRPX",0) = DT+2 ^ DT ^ VPR ENCOUNTERS
 ;^XTMP("VPRPX", visit~dfn) =  NOW ^ id ^ 1 if new during session
 ;^XTMP("VPRPX", visit~dfn, "SUB", ien) = 1 if new during session
 ;^XTMP("VPRPX", "DOC", ien) = NOW ^ id ^ @ if removed
 ;^XTMP("VPRPX", "AVST"/"ADOC", NOW, ien) = ""
 ;
PX ; -- PXK VISIT DATA EVENT protocol listener
 Q:'$P($G(^VPR(1,0)),U,2)  ;monitoring disabled
 N VST,PX0A,PX0B,DFN,VSTX,X,NOW,NEW,ID,SUB,DA,VADMVT
 S VST=+$O(^TMP("PXKCO",$J,0)) Q:VST<1
 S PX0A=$G(^TMP("PXKCO",$J,VST,"VST",VST,0,"AFTER")),PX0B=$G(^("BEFORE"))
 S DFN=$S($L(PX0A):+$P(PX0A,U,5),1:+$P(PX0B,U,5))
 Q:DFN<1  ;Q:'$$VALID^VPRHS(DFN)
 S VSTX=VST_"~"_DFN ;visit id for XTMP
 ;
 ; get or set up ^XTMP
 S VPRPX=$NA(^XTMP("VPRPX"))
 L +@VPRPX@(VSTX):5 ;I'$T
 ;
 ; Visit file
 S X=$G(@VPRPX@(VSTX)),NOW=+X,ID=$P(X,U,2),NEW=$P(X,U,3)
 K:NOW @VPRPX@("AVST",NOW,VSTX) ;reset clock
 I ID="" D
 . I $P(PX0A,U,7)="H" D         ;find admission movement
 .. N VAINDT S VAINDT=+PX0A D ADM^VADPT2
 . S ID=$S($G(VADMVT):VADMVT_"~"_VST_";405",1:VST_";9000010")
 S NOW=$$NOW^XLFDT,@VPRPX@("AVST",NOW,VSTX)=""
 S:PX0B="" NEW=1
 S @VPRPX@(VSTX)=NOW_U_ID_U_NEW
 ;
 ; V-files
 F SUB="IMM","XAM","POV","HF" D  ;"PED","SK","CPT"
 . S DA=0 F  S DA=$O(^TMP("PXKCO",$J,VST,SUB,DA)) Q:DA<1  D
 .. Q:'$$DIFF(.NEW)                 ;not changed
 .. I SUB="HF" Q:$$NAME(SUB,DA)=""  ;not Hx
 .. S @VPRPX@(VSTX,SUB,DA)=$G(NEW)
PXQ ; done
 L -@VPRPX@(VSTX)
 I '$G(@VPRPX@("ZTSK")) D QUE(7)
 Q
 ;
DIFF(ACT) ; -- returns 1 or 0 if changed, ACT=1 if new
 N NODE,AFTER,BEFORE,DIFF
 S DIFF=0,ACT=$G(@VPRPX@(VSTX,SUB,DA))
 F NODE=0,12,13,811 D  Q:DIFF
 . S AFTER=$G(^TMP("PXKCO",$J,VST,SUB,DA,NODE,"AFTER")),BEFORE=$G(^("BEFORE"))
 . I BEFORE'=AFTER S DIFF=1 S:(NODE=0)&(BEFORE="") ACT=1 ;new
 Q DIFF
 ;
EDP(IEN) ; -- EDP Log file #230 AVPR index
 Q:'$P($G(^VPR(1,0)),U,2)  ;monitoring disabled
 N EDP0,VST,DFN,VSTX,VPRPX,X,NOW,ID,NEW
 S IEN=+$G(IEN) Q:IEN<1
 S EDP0=$G(^EDP(230,IEN,0)),VST=+$P(EDP0,U,12) Q:VST<1
 S DFN=+$P(EDP0,U,6) Q:DFN<1
 S VSTX=VST_"~"_DFN ;visit id for XTMP
 ;
 ; get or set up ^XTMP
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
 I '$G(@VPRPX@("ZTSK")) D QUE(7)
 Q
 ;
QUE(M) ; -- begin tasking to post encounters, documents
 N ZTRTN,ZTDTH,ZTDESC,ZTIO,ZTSAVE,ZTUCI,ZTCPU,ZTPRI,ZTKIL,ZTSYNC,ZTSK
 S ZTRTN="TASK^VPRENC",ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,,,M)
 S ZTDESC="VPR Encounters",ZTIO=""
 S ^XTMP("VPRPX",0)=$$FMADD^XLFDT(DT,2)_U_DT_"^Encounters for HealthShare"
 D ^%ZTLOAD
 S ^XTMP("VPRPX","ZTSK")=$G(ZTSK)
 Q
 ;
TIU(IEN,ACT) ; -- TIU Document file #8925 [from TIU^VPREVNT]
 ; add to ^XTMP("VPRPX") list w/encounters
 N VPRPX,NOW
 S VPRPX=$NA(^XTMP("VPRPX")),IEN=+$G(IEN),ACT=$G(ACT)
 L +@VPRPX@("DOC",IEN):5 ;I'$T
 ;
 S NOW=+$G(@VPRPX@("DOC",IEN)) K:NOW @VPRPX@("ADOC",NOW,IEN)
 I NOW,ACT="@" K @VPRPX@("DOC",IEN) L -@VPRPX@("DOC",IEN) Q
 ;
 S NOW=$$NOW^XLFDT,@VPRPX@("ADOC",NOW,IEN)=""
 S @VPRPX@("DOC",IEN)=NOW_U_IEN_";8925"_U_ACT
 L -@VPRPX@("DOC",IEN)
 I '$G(@VPRPX@("ZTSK")) D QUE(7)
 Q
 ;
 ;
TASK ; -- post an encounter update
 N VPRPX,VPRDT,VPRI,VSTX,VST,X0,DFN,V0,VNM,VFL,VDA,VID,ACT
 S ZTREQ="@" Q:'$P($G(^VPR(1,0)),U,2)       ;monitoring disabled
 S VPRPX=$NA(^XTMP("VPRPX")),VPRDT=$$FMADD^XLFDT($$NOW^XLFDT,,,-5)
 ; post visits that have been stable for at least 5 minutes
 S VPRI=0 F  S VPRI=$O(@VPRPX@("AVST",VPRI)) Q:VPRI<1  Q:VPRI>VPRDT  D
 . S VSTX="" F  S VSTX=$O(@VPRPX@("AVST",VPRI,VSTX)) Q:VSTX=""  D
 .. I '$D(@VPRPX@(VSTX)) K @VPRPX@("AVST",VPRI,VSTX) Q
 .. L +@VPRPX@(VSTX):5 Q:'$T                ;will requeue
 .. S X0=$G(@VPRPX@(VSTX)),VST=+VSTX,DFN=+$P(VSTX,"~",2)
 .. S V0=$G(^AUPNVSIT(VST,0))
 .. I V0=""!($P(V0,U,5)'=DFN) D  Q          ;deleted or replaced:
 ... I $P(X0,U,3) D KILL Q                  ; not in HS, just kill XTMP
 ... D DELALL                               ; else send delete to HS
 .. S VID=$P(X0,U,2) S:VID="" VID=VST_";9000010"
 .. D POST^VPRHS(DFN,"Encounter",VID)
TV .. ; post related v-file records next
 .. S VFL="" F  S VFL=$O(@VPRPX@(VSTX,VFL)) Q:VFL=""  D
 ... S VDA=0 F  S VDA=$O(@VPRPX@(VSTX,VFL,VDA)) Q:VDA<1  D
 .... S VNM=$$NAME(VFL,VDA) Q:VNM=""        ;not tracked
 .... S V0=$$ZERO(VFL,VDA),VID=VDA_";"_$P(VNM,U,2)
 .... ; if exists & is valid send to HS, else quit/delete
 .... I V0,$P(V0,U,2)=DFN,$P(V0,U,3)=VST D POST^VPRHS(DFN,$P(VNM,U),VID,,VST) Q
 .... Q:$G(@VPRPX@(VSTX,VFL,VDA))           ;new item (don't send)
 .... S VID=VDA_"~"_VST_";"_$P(VNM,U,2)     ;ID=DA~VST for delete
 .... D POST^VPRHS(DFN,$P(VNM,U),VID,"@",VST)
 .. D KILL ;delete XTMP, unlock
TVD .. ; post related documents
 .. S VDA=0 F  S VDA=$O(^TIU(8925,"V",+VST,VDA)) Q:VDA<1  D
 ... S X0=$G(@VPRPX@("DOC",VDA)) Q:X0=""
 ... S VID=$P(X0,U,2) I VID="" S VID=VDA_";8925"
 ... D POST^VPRHS(DFN,"Document",VID,$P(X0,U,3),VST)
 ... K @VPRPX@("DOC",VDA),@VPRPX@("ADOC",+X0,VDA)
 ... I $P(X0,U,3)="" D PROC ;skip if @
TD ; look for waiting documents w/o visit
 S VPRI=0 F  S VPRI=$O(@VPRPX@("ADOC",VPRI)) Q:VPRI<1  Q:VPRI>VPRDT  D
 . S VDA=0 F  S VDA=$O(@VPRPX@("ADOC",VPRI,VDA)) Q:VDA<1  D
 .. I '$D(@VPRPX@("DOC",VDA)) K @VPRPX@("ADOC",VPRI,VDA) Q
 .. L +@VPRPX@("DOC",VDA):5 Q:'$T  ;will requeue
 .. N VPRTIU S ACT=$G(@VPRPX@("DOC",VDA))
 .. D EXTRACT^TIULQ(VDA,"VPRTIU",,".02;.03",,1,"I")
 .. S VST=$G(VPRTIU(VDA,.03,"I")),DFN=$G(VPRTIU(VDA,.02,"I"))
 .. ; quit if has visit, still in ^XTMP (send w/visit)
 .. I VST,$G(@VPRPX@(VST_"~"_DFN)) L -@VPRPX@("DOC",VDA) Q
 .. ; else post to HS
 .. S VID=$P(ACT,U,2) I VID="" S VID=VDA_";8925"
 .. D POST^VPRHS(DFN,"Document",VID,$P(ACT,U,3),VST)
 .. K @VPRPX@("DOC",VDA),@VPRPX@("ADOC",VPRI,VDA)
 .. L -@VPRPX@("DOC",VDA)
 .. I VST,$P(ACT,U,3)="" D PROC ;skip if @
TQ ; re-task if more data
 S X=$O(@VPRPX@(0)) I $L(X),X'="ZTSK" D QUE(7) Q
 K @VPRPX
 Q
 ;
DELALL ; -- delete visit + vfiles from HS [from TASK]
 S VFL="" F  S VFL=$O(@VPRPX@(VSTX,VFL)) Q:VFL=""  D
 . S VDA=0 F  S VDA=$O(@VPRPX@(VSTX,VFL,VDA)) Q:VDA<1  D
 .. S VNM=$$NAME(VFL,VDA) I VNM="" Q   ;not tracked in HS
 .. I $G(@VPRPX@(VSTX,VFL,VDA)) Q  ;never sent to HS
 .. S VID=VDA_"~"_VST_";"_$P(VNM,U,2)
 .. D POST^VPRHS(DFN,$P(VNM,U),VID,"@",VST)
 D POST^VPRHS(DFN,"Encounter",VST_";9000010","@")
KILL ; clean up
 K @VPRPX@(VSTX),@VPRPX@("AVST",VPRI,VSTX)
 L -@VPRPX@(VSTX)
 Q
 ;
PROC ; -- look for consult/procedure [from TASK]
 N PROC,I
 D EXTRACT^TIULQ(VDA,"VPRTIU",,1405,,1,"I")
 S PROC=$G(VPRTIU(VDA,1405,"I")) Q:'PROC  Q:'VST
 I PROC["SRF" D POST^VPRHS(DFN,"Procedure",+PROC_";130",,VST) Q
 I PROC["GMR",$$GET1^DIQ(123,+PROC,1.01,"I") D  ;CP
 . N VPRC,ID D FIND^DIC(702,,"@","Q",+PROC,,"ACON",,,"VPRC")
 . S I=0 F  S I=$O(VPRC("DILIST",2,I)) Q:I<1  D
 .. S ID=+$G(VPRC("DILIST",2,I))
 .. D POST^VPRHS(DFN,"Procedure",ID_";702",,VST)
 Q
 ;
NAME(X,DA) ; -- return container name for V-files
 N Y S Y=""
 I X="HF" D
 . N NM S NM=$$GET1^DIQ(9000010.23,+$G(DA),.01)
 . I $$FHX(NM) S Y="FamilyHistory^9000010.23" Q
 . I $$SHX(NM) S Y="SocialHistory^9000010.23" Q
 . ;S Y="HealthConcern^9000010.23"
 I X="IMM" S Y="Vaccination^9000010.11"
 I X="XAM" S Y="PhysicalExam^9000010.13"
 I X="POV" S Y="Diagnosis^9000010.07"
 ; X="CPT" S Y="Procedure^9000010.18"
 ; X="PED" S Y="education^9000010.16"
 ; X="SK"  S Y="Procedure^9000010.12"
 I X="DOC" S Y="Document^8925"
 Q Y
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
ZERO(X,DA) ; -- return zero node
 N GBL,Y S Y=""
 S GBL="^AUPNV"_X,Y=$G(@GBL@(DA,0))
 Q Y
