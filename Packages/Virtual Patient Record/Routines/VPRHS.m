VPRHS ;SLC/MKB -- HealthShare utilities ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**8,10,15,16,17,19**;Sep 01, 2011;Build 5
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DDE                          7014
 ; ^DGS(41.1                     3796
 ; ^DPT                         10035
 ; %ZTLOAD                      10063
 ; DDE                           7008
 ; DIC                           2051
 ; DIQ                           2056
 ; MPIF001                       2701
 ; SDAMA301                      4433
 ; TIULQ                         2693
 ; VADPT                         3744
 ; XLFDT                        10103
 ; XUPROD                        4440
 ;
 Q
 ;
ON() ; -- return 1 or 0, if monitoring is on
 Q $P($G(^VPR(1,0)),U,2)
 ;
EN(DFN) ; -- subscribe a patient for data event monitoring
 Q:'$G(DFN)  Q:$D(^VPR(1,2,+DFN,0))
 S ^VPR(1,2,+DFN,0)=+DFN,^VPR(1,2,"B",+DFN,+DFN)=""
 Q
 ;
UN(DFN) ; -- unsubscribe
 Q:'$G(DFN)  Q:'$D(^VPR(1,2,+DFN,0))
 K ^VPR(1,2,+DFN,0),^VPR(1,2,"B",+DFN,+DFN)
 Q
 ;
SUBS(DFN) ; -- return 1 or 0, if patient is subscribed or not
 Q $D(^VPR(1,2,+$G(DFN),0))
 ;
QUE(DFN) ; -- create task to POST a Patient update
 Q:'$P($G(^VPR(1,0)),U,2)       ;monitoring disabled
 Q:DFN<1  Q:'$$SUBS(DFN)        ;not subscribed
 Q:$P($G(^VPR(1,2,DFN,0)),U,2)  ;task exists
 ; create task
 N ZTRTN,ZTDTH,ZTDESC,ZTIO,ZTSAVE,ZTUCI,ZTCPU,ZTPRI,ZTKIL,ZTSYNC,ZTSK
 S ZTRTN="PAT^VPRHS",ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,,,10)
 S ZTDESC="Task single VPR SDA Patient Container update"
 S ZTIO="",ZTSAVE("DFN")="" D ^%ZTLOAD
 S:$G(ZTSK)>0 $P(^VPR(1,2,DFN,0),U,2)=ZTSK
 Q
 ;
PAT ; -- post Patient update [TASK]
 Q:'$P($G(^VPR(1,0)),U,2)                ;monitoring disabled
 S DFN=+$G(DFN) Q:DFN<1  Q:'$$SUBS(DFN)  ;not subscribed
 D POST(DFN,"Patient",DFN_";2")
 S $P(^VPR(1,2,DFN,0),U,2)="",ZTREQ="@"  ;clear task
 Q
 ;
PX ; -- post an encounter update [TASK - moving to HS^VPRENC]
 N VST,VPRPX,VPRDT,X0,X,VFL,VDA S ZTREQ="@"
 Q:'$P($G(^VPR(1,0)),U,2)  ;monitoring disabled
 S DFN=+$G(DFN) Q:DFN<1
 S VPRPX=$NA(^XTMP("VPRPX"_DFN)),VPRDT=$$FMADD^XLFDT($$NOW^XLFDT,,,-10)
 L +@VPRPX@(0):5 I '$T G PXQ
 ; post visits that have been stable for at least 10 minutes
 S VST=0 F  S VST=$O(@VPRPX@(VST)) Q:VST<1  D
 . S X0=$G(@VPRPX@(VST)) Q:+X0>VPRDT   ;still waiting
 . D POST(DFN,"Encounter",$P(X0,U,2),$P(X0,U,3))
 . ; post related v-file records next
 . S VFL="" F  S VFL=$O(@VPRPX@(VST,VFL)) Q:VFL=""  D
 .. S VDA=0 F  S VDA=$O(@VPRPX@(VST,VFL,VDA)) Q:VDA<1  D
 ... S X=$$NAME(VFL,VDA) I X="" K @VPRPX@(VST,VFL) Q
 ... S ACT=$G(@VPRPX@(VST,VFL,VDA))
 ... D POST(DFN,$P(X,U),(VDA_";"_$P(X,U,2)),ACT,VST)
 ... ;I VFL="HF",X["History" D POST(DFN,"HealthConcern",(VDA_";9000010.23"),ACT,VST)
 . K @VPRPX@(VST)
PXD ; look for waiting documents
 S VDA=0 F  S VDA=$O(@VPRPX@("DOC",VDA)) Q:VDA<1  D
 . N VPRTIU,PROC,I
 . S ACT=$G(@VPRPX@("DOC",VDA))        ;ACT=#tries[^@]
 . D EXTRACT^TIULQ(VDA,"VPRTIU",,".03;1405",,1,"I")
 . S VST=$G(VPRTIU(VDA,.03,"I"))
 . ; Quit if no visit yet, or still in ^XTMP
 . I (VST&$G(@VPRPX@(+VST)))!((VST<1)&(+ACT<5)) D  Q
 .. N X S X=+ACT,$P(ACT,U)=(X+1)
 .. S @VPRPX@("DOC",VDA)=ACT
 . D POST(DFN,"Document",VDA_";8925",$P(ACT,U,2),VST)
 . K @VPRPX@("DOC",VDA)
 . S PROC=$G(VPRTIU(VDA,1405,"I")) Q:'PROC  Q:'VST
 . I PROC["SRF" D POST(DFN,"Procedure",+PROC_";130",,VST) Q
 . I PROC["GMR",$$GET1^DIQ(123,+PROC,1.01,"I") D  ;CP
 .. N VPRC,ID D FIND^DIC(702,,"@","Q",+PROC,,"ACON",,,"VPRC")
 .. S I=0 F  S I=$O(VPRC("DILIST",2,I)) Q:I<1  D
 ... S ID=+$G(VPRC("DILIST",2,I))
 ... D POST(DFN,"Procedure",ID_";702",,VST)
 L -@VPRPX@(0)
PXQ ; re-task if not done
 I $O(@VPRPX@(0))="" K @VPRPX Q
 D QUE^VPREVNT(DFN,5)
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
VALID(PAT) ; -- return 1 or 0, if valid patient for HealthShare
 I $G(^DPT(PAT,.35)) Q 0                   ;death date
 I $$TESTPAT^VADPT(PAT),$$PROD^XUPROD Q 0  ;no test pats in prod
 I $$MERGED(PAT) Q 0                       ;no merged-from pats
 I '$G(^DPT(DFN,"MPI")) Q 0                ;no ICN
 Q 1
 ;
POST(DFN,TYPE,ID,ACT,VST) ; -- post an update to
 ;  ^VPR(1,2,DFN,"AVPR",TYPE,ID) = seq# ^ U/D ^ VISIT#
 ;  ^VPR("AVPR",seq#,DFN) = ICN ^ TYPE ^ ID ^ U/D ^ VISIT#
 Q:'$P($G(^VPR(1,0)),U,2)                   ;monitoring disabled
 S DFN=+$G(DFN),TYPE=$G(TYPE),ID=$G(ID)
 Q:DFN<1  Q:TYPE=""                         ;incomplete request
 I $$TESTPAT^VADPT(DFN),$$PROD^XUPROD Q     ;no test pats in prod
 I $$MERGED(DFN) Q                          ;no merged-from pats
 N ICN S ICN=$$GETICN^MPIF001(DFN) Q:ICN<0  ;ICN required
 ; add to ^VPR if not subscribed, not dead
 I '$$SUBS(DFN),'$G(^DPT(DFN,.35)) D NEW(DFN,ICN) Q
 S ACT=$S($G(ACT)="@":"D",1:"U")
P1 ;may enter here from VPRHSX manual update option
 N SEQ S SEQ=$$NUM
 S ^VPR("AVPR",SEQ,DFN)=ICN_U_$G(TYPE)_U_$G(ID)_U_$G(ACT)_U_$G(VST)
 ; use * for subscript (whole container) if ID is null
 S ^VPR(1,2,DFN,"AVPR",TYPE,$S($G(ID)="":"*",1:ID))=SEQ_U_$G(ACT)_U_$G(VST)
 Q
 ;
NUM() ; -- return existing SEQ of record, or increment
 ; SAC EXEMPTION 2019-04-29 : Use of $I
 N X,Y S X=$S(ID="":"*",1:ID)
 S Y=+$G(^VPR(1,2,DFN,"AVPR",TYPE,X)) I '$D(^VPR("AVPR",Y,DFN)) S Y=0
 I Y'>0 S Y=$I(^VPR(1,1))
 Q Y
 ;
NEW(DFN,ICN) ; -- post a new patient to 
 ; ^VPR(1,2,DFN,"ANEW")  = seq#
 ; ^VPR("ANEW",seq#,DFN) = ICN
 Q:$G(DFN)<1  Q:$G(^VPR(1,2,DFN,"ANEW"))
 I $G(ICN)<1 S ICN=$$GETICN^MPIF001(DFN) Q:ICN<0
 N SEQ S SEQ=$I(^VPR(1,1))
 S ^VPR("ANEW",SEQ,DFN)=ICN,^VPR(1,2,DFN,"ANEW")=SEQ
 Q
 ;
DEL(LIST,SEQ) ; -- remove ^VPR(LIST,SEQ) nodes
 N DFN,DATA,TYPE,ID
 S LIST=$G(LIST),SEQ=+$G(SEQ) Q:LIST=""  Q:SEQ<1
 S DFN=+$O(^VPR(LIST,SEQ,0)) I DFN<1 Q
 I LIST="ANEW" K ^VPR("ANEW",SEQ,DFN),^VPR(1,2,DFN,"ANEW") Q
 S DATA=$G(^VPR(LIST,SEQ,DFN)) K ^VPR("AVPR",SEQ,DFN)
 S TYPE=$P(DATA,U,2) Q:TYPE=""  ;error
 S ID=$P(DATA,U,3) S:ID="" ID="*"
 K ^VPR(1,2,DFN,"AVPR",TYPE,ID)
 Q
 ;
MERGED(DFN) ; -- return 1 or 0, if patient is being merged
 I $P($G(^DPT(+$G(DFN),0)),U)["MERGING INTO" Q 1
 I $G(^DPT(+$G(DFN),-9)) Q 1
 Q 0
 ;
GET(DFN,NAME,ID,VPRQ,MTYPE,VPRY,VPRR) ; -- return VistA data in @VPRY@(#)
 N ICN,VPRNM,VPRFN,VPRE,VPRI,VPRJ,VPRN,VPRX,VPRZ,VPRMAX
 ;
 ; define default return arrays
 S VPRY=$G(VPRY,$NA(^TMP("VPR GET",$J))),VPRI=0 K @VPRY
 S VPRR=$G(VPRR,$NA(^TMP("VPR ERR",$J))),VPRJ=0 K @VPRR
 ;
 ; validate/set up input parameters
 S DFN=$G(DFN),ICN=$P(DFN,";",2),DFN=+DFN
 I DFN<1!'$D(^DPT(DFN)) D ERROR("Invalid patient DFN") G GTQ
 I $P($G(^DPT(DFN,0)),U)["MERGING INTO" D ERROR($P($G(^DPT(DFN,0)),U)) G GTQ
 I $G(^DPT(DFN,-9)) D ERROR("MERGED INTO `"_$G(^DPT(DFN,-9))) G GTQ
 S VPRQ("patient")=DFN
 ;
 S VPRNM=$G(NAME) I VPRNM="" D ERROR("Undefined container") G GTQ
 S ID=$G(ID),MTYPE=$G(MTYPE,1) ;XML
 I VPRNM="Patient",'ID&DFN S ID=DFN_";2"
 I VPRNM'="Patient",$G(VPRQ("patch"))'="" S VPRNM=VPRNM_VPRQ("patch")
 I $G(VPRQ("max")) S VPRMAX=VPRQ("max")
 ;
GT1 ; update one record for ECR
 I ID'="" D  G GTQ
 . S VPRFN=$P(ID,";",2),ID=$P(ID,";")
 . S VPRE=+$O(^DDE("SDA",VPRNM,VPRFN,0))
 . I 'VPRE D ERROR("Missing Entity for "_VPRNM_" file #"_VPRFN) Q
 . S VPRI=VPRI+1,@VPRY@(VPRI)=$$GET1^DDE(VPRE,ID,.VPRQ,MTYPE,.VPRR)
 . S VPRJ=+$O(@VPRR@("A"),-1) ;#errors
 ;
 ; pre-load of whole container for patient
 S VPRX=$NA(^TMP("VPRHS",$J)),VPRZ=$NA(^TMP("VPRHS ERR",$J))
 S VPRFN=0 F  S VPRFN=$O(^DDE("SDA",VPRNM,VPRFN)) Q:VPRFN<1  D
 . S VPRE=$O(^DDE("SDA",VPRNM,VPRFN,0)) K @VPRX,@VPRZ
 . I 'VPRE D ERROR("Missing Entity for "_VPRNM_" file #"_VPRFN) Q
 . D GET^DDE(VPRE,,.VPRQ,MTYPE,.VPRMAX,.VPRX,.VPRZ)
 . S VPRN=0 F  S VPRN=$O(@VPRX@(VPRN)) Q:VPRN<1  S VPRI=VPRI+1,@VPRY@(VPRI)=@VPRX@(VPRN)
 . S VPRN=0 F  S VPRN=$O(@VPRZ@(VPRN)) Q:VPRN<1  S VPRJ=VPRJ+1,@VPRR@(VPRJ)=@VPRZ@(VPRN)
 K @VPRX,@VPRZ
 ;
GTQ ; return data and exit
 S @VPRY@(0)=VPRI,@VPRR@(0)=VPRJ
 Q
 ;
ERROR(MSG) ; -- return error MSG
 S VPRJ=+$G(VPRJ)+1
 S @VPRR@(VPRJ)=$G(MSG)
 Q
 ;
 ;
ACTIVE ; -- find currently non-deceased, active patients
 N DFN S DFN=0
 F  S DFN=$O(^DPT(DFN)) Q:DFN<1  I '$G(^DPT(DFN,.35)) D
 . I $G(^DPT(DFN,.105)) D POST(DFN,"*") Q
 . I $O(^DPT(DFN,"S",DT)) D POST(DFN,"*")
 Q
 ;
APPTS(BEG,END,VPRY) ; -- return patients w/appointments
 N VPRX,VPRN,DFN,VPRDT,VPRI,VPRA
 S VPRY=$G(VPRY,$NA(^TMP("VPR PATS",$J))) K @VPRY
 I '$G(BEG) D   ;default = tomorrow, if not passed in
 . S BEG=$$FMADD^XLFDT(DT,1),END=BEG
 ; find patients with appointments
 S END=$G(END,BEG),VPRX(1)=BEG_";"_END
 S VPRX("SORT")="P",VPRX("FLDS")=1,VPRX(3)="R;I;NT"
 S VPRI=$$SDAPI^SDAMA301(.VPRX),VPRN=0 K VPRX
 S DFN=0 F  S DFN=$O(^TMP($J,"SDAMA301",DFN)) Q:DFN<1  S VPRX(DFN)=""
 ; find patients scheduled for admission
 S VPRDT=0 F  S VPRDT=$O(^DGS(41.1,"C",VPRDT)) Q:VPRDT<1!(VPRDT>END)  D
 . S VPRI=0 F  S VPRI=$O(^DGS(41.1,"C",VPRDT,VPRI)) Q:VPRI<1  D
 .. S VPRA=$G(^DGS(41.1,VPRI))
 .. Q:$P(VPRA,U,13)  Q:$P(VPRA,U,17)  ;cancelled or admitted
 .. S DFN=+VPRA S:DFN VPRX(DFN)=""
 ; build return array
 S (DFN,VPRN)=0
 F  S DFN=$O(VPRX(DFN)) Q:DFN<1  S VPRN=VPRN+1,@VPRY@(VPRN)=DFN
 S @VPRY@(0)=VPRN
 K ^TMP($J,"SDAMA301")
 Q
 ;
INPTS(VPRY) ; -- return current inpatients
 N DGPM,DFN,VPRN
 S VPRY=$G(VPRY,$NA(^TMP("VPR PATS",$J))),VPRN=0 K @VPRY
 S DGPM=0 F  S DGPM=$O(^DPT("ACA",DGPM)) Q:DGPM<1  D
 . S DFN=0 F  S DFN=$O(^DPT("ACA",DGPM,DFN)) Q:DFN<1  S VPRN=VPRN+1,@VPRY@(VPRN)=DFN
 S @VPRY@(0)=VPRN
 Q
