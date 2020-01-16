VPRENC ;SLC/MKB -- VistA Encounter updates ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**19**;Sep 01, 2011;Build 5
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
 I X="" D  ;new visit - get ID
 . I $P(PX0A,U,7)="H" D  ;find admission movement
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
 I '$G(@VPRPX@("ZTSK")) D QUE(12)
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
QUE(M) ; -- begin tasking to post encounters, documents
 N ZTRTN,ZTDTH,ZTDESC,ZTIO,ZTSAVE,ZTUCI,ZTCPU,ZTPRI,ZTKIL,ZTSYNC,ZTSK
 S ZTRTN="TASK^VPRENC",ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,,,M)
 S ZTDESC="VPR Encounters",ZTIO=""
 S ^XTMP("VPRPX",0)=$$FMADD^XLFDT(DT,2)_U_DT_"^Encounters for HealthShare"
 D ^%ZTLOAD
 S ^XTMP("VPRPX","ZTSK")=$G(ZTSK)
 Q
 ;
SDAM ; -- SDAM APPOINTMENT EVENTS protocol listener
 N DFN,DATE,ACT,SDOE,VST,VSTX Q:'$G(SDATA)
 Q:$G(SDAMEVT)>5  ;only track make, cancel, no show, check in/out
 ; quit if status has not changed
 Q:$G(SDATA("BEFORE","STATUS"))=$G(SDATA("AFTER","STATUS"))
 S DFN=+$P(SDATA,U,2) Q:DFN<1
 S DATE=+$P(SDATA,U,3),ACT=$S(SDAMEVT=2:"@",1:"")
 I SDAMEVT<5 D POST^VPRHS(DFN,"Appointment",(DATE_","_DFN_";2.98"),ACT) Q
 ; 5 = Check-out:
 S SDOE=$P($G(^TMP("SDEVT",$J,+$G(SDHDL),1,"DPT",0,"AFTER")),U,20)
 S VST=$P($G(^TMP("SDEVT",$J,+$G(SDHDL),1,"SDOE",+SDOE,0,"AFTER")),U,5)
 I VST D  Q  ; delete first, if adding encounter#
 . N VPRPX,NOW,ID S ID=DATE_","_DFN
 . D POST^VPRHS(DFN,"Appointment",(ID_";2.98"),"@")
 . S VPRPX=$NA(^XTMP("VPRPX")),NOW=$$NOW^XLFDT,VSTX=VST_"~"_DFN
 . L +@VPRPX@(VSTX):5 ;I'$T
 . I '$G(@VPRPX@(VSTX)) S @VPRPX@(VSTX)=NOW_U_VST_";9000010",@VPRPX@("AVST",NOW,VSTX)=""
 . S @VPRPX@(VSTX,"APT",ID)=""
 . L -@VPRPX@(VSTX)
 . I '$G(@VPRPX@("ZTSK")) D QUE(12)
 D POST^VPRHS(DFN,"Appointment",(DATE_","_DFN_";2.98"))
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
 I '$G(@VPRPX@("ZTSK")) D QUE(12)
 Q
 ;
 ;
TASK ; -- post an encounter update
 N VPRPX,VPRDT,VPRI,VSTX,VST,X0,DFN,V0,X,VFL,VDA,ACT S ZTREQ="@"
 Q:'$P($G(^VPR(1,0)),U,2)  ;monitoring disabled
 S VPRPX=$NA(^XTMP("VPRPX")),VPRDT=$$FMADD^XLFDT($$NOW^XLFDT,,,-10)
 ; post visits that have been stable for at least 10 minutes
 S VPRI=0 F  S VPRI=$O(@VPRPX@("AVST",VPRI)) Q:VPRI<1  Q:VPRI>VPRDT  D
 . S VSTX="" F  S VSTX=$O(@VPRPX@("AVST",VPRI,VSTX)) Q:VSTX=""  D
 .. L +@VPRPX@(VSTX):5 Q:'$T                ;will requeue
 .. S X0=$G(@VPRPX@(VSTX)),VST=+VSTX,DFN=+$P(VSTX,"~",2)
 .. S V0=$G(^AUPNVSIT(VST,0)) I V0="" D  Q  ;deleted
 ... I '$P(X0,U,3) D DELALL Q
 ... K @VPRPX@(VSTX) L -@VPRPX@(VSTX)
 .. I $P(V0,U,5)'=DFN D DELALL Q            ;replaced
 .. D POST^VPRHS(DFN,"Encounter",$P(X0,U,2))
TV .. ; post related v-file records next
 .. S VFL="" F  S VFL=$O(@VPRPX@(VSTX,VFL)) Q:VFL=""  D
 ... S VDA=0 F  S VDA=$O(@VPRPX@(VSTX,VFL,VDA)) Q:VDA<1  D
 .... S X=$$NAME(VFL,VDA) Q:X=""            ;not tracked
 .... I VFL="APT" D POST^VPRHS(DFN,$P(X,U),(VDA_";"_$P(X,U,2)),,VST) Q
 .... S V0=$$ZERO(VFL,VDA)                  ;"" if deleted
 .... I V0="",$G(@VPRPX@(VSTX,VFL,VDA)) Q   ;new item (don't send)
 .... ; update if exists for patient/visit, else delete (send)
 .... S ACT="@" I V0,$P(V0,U,2)=DFN,$P(V0,U,3)=VST S ACT=""
 .... D POST^VPRHS(DFN,$P(X,U),(VDA_";"_$P(X,U,2)),ACT,VST)
 .. K @VPRPX@(VSTX),@VPRPX@("AVST",VPRI,VSTX)
 .. L -@VPRPX@(VSTX)
 .. ; post related documents
 .. S VDA=0 F  S VDA=$O(^TIU(8925,"V",+VST,VDA)) Q:VDA<1  D
 ... S X0=$G(@VPRPX@("DOC",VDA)) Q:X0=""
 ... D POST^VPRHS(DFN,"Document",$P(X0,U,2),$P(X0,U,3),+VST)
 ... K @VPRPX@("DOC",VDA),@VPRPX@("ADOC",+X0,VDA)
 ... D PROC
TD ; look for waiting documents w/o visit
 S VPRI=0 F  S VPRI=$O(@VPRPX@("ADOC",VPRI)) Q:VPRI<1  Q:VPRI>VPRDT  D
 . S VDA=0 F  S VDA=$O(@VPRPX@("ADOC",VPRI,VDA)) Q:VDA<1  D
 .. L +@VPRPX@("DOC",VDA):5 Q:'$T  ;will requeue
 .. N VPRTIU
 .. S ACT=$G(@VPRPX@("DOC",VDA))
 .. D EXTRACT^TIULQ(VDA,"VPRTIU",,".02;.03",,1,"I")
 .. S VST=$G(VPRTIU(VDA,.03,"I")),DFN=$G(VPRTIU(VDA,.02,"I"))
 .. ; quit if has visit, still in ^XTMP (send w/visit)
 .. I VST,$G(@VPRPX@(VST_"~"_DFN)) L -@VPRPX@("DOC",VDA) Q
 .. ; else post to HS
 .. D POST^VPRHS(DFN,"Document",$P(ACT,U,2),$P(ACT,U,3),VST)
 .. K @VPRPX@("DOC",VDA),@VPRPX@("ADOC",VPRI,VDA)
 .. L -@VPRPX@("DOC",VDA)
 .. D:VST PROC
TQ ; re-task if more data
 S X=$O(@VPRPX@(0)) I $L(X),X'="ZTSK" D QUE(12) Q
 K @VPRPX
 Q
 ;
DELALL ; -- delete visit + vfiles from HS [from TASK]
 D POST^VPRHS(DFN,"Encounter",VST_";9000010","@")
 S VFL="" F  S VFL=$O(@VPRPX@(VSTX,VFL)) Q:VFL=""  D
 . S VDA=0 F  S VDA=$O(@VPRPX@(VSTX,VFL,VDA)) Q:VDA<1  D
 .. S X=$$NAME(VFL,VDA) I X="" K @VPRPX@(VSTX,VFL,VDA) Q  ;not tracked
 .. I $G(@VPRPX@(VSTX)) K @VPRPX@(VSTX,VFL,VDA) Q         ;new item
 .. D POST^VPRHS(DFN,$P(X,U),(VDA_";"_$P(X,U,2)),"@",VST)
 ; clean up
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
 I X="APT" S Y="Appointment^2.98"
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
