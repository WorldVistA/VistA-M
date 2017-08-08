HMPEF ;SLC/MKB,ASMR/BL,RRB,JD,SRG,CK - Serve VistA operational data as JSON via RPC;Aug 29, 2016 20:06:27
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**1,2,3**;May 15, 2016;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; DE2818 - SQA findings. Newed L42 and L44 in LOC+1.  RRB - 10/30/2015
 ;
 ; DE6652 - JD - 9/1/16: Removed code behind synching sign-symptom domain for operational data.
 ;                       SIGNS tag.
 ;
 ; ^SC references - IA 10040, HOSPITAL LOCATION file (#44)
 ; ^DIC(42) references - IA #10039, WARD LOCATION file
 Q
 ;
 ; The following variables can not be newed or killed because they are used
 ; from upstream by scope (NOT as input parameters):
 ;      HMPBATCH, HMPFADOM, HMPFLDON, HMPFZTSK, HMPMETA, HMPSTMP, LEX("LIST", and ZTQUEUED.
GET(HMP,FILTER) ; -- Return search results as JSON in @HMP@(n)
 ; RPC = HMP GET OPERATIONAL DATA
 ; where FILTER("domain")  = name of desired data type (see $$TAG)
 ;       FILTER("limit")   = maximum number of items to return [opt]
 ;       FILTER("start")   = ien to start search from          [opt]
 ;       FILTER("id")      = single item id to return          [opt]
 ;
 ; HMPLAST - last record processed
 N HMPSYS,TYPE,HMPMAX,HMPI,HMPID,HMPERR,HMPTN,HMPLAST,HMPCNT,HMPFINI
 S HMP=$NA(^TMP("HMP",$J)),HMPI=0 K @HMP
 S HMPSYS=$$SYS^HMPUTILS ;DE4463 - CK - 4/22/2016
 ;
 ; parse & validate input parameters
 S TYPE=$P($G(FILTER("domain")),"#") ;,TYPE=$$LOW^XLFSTR(TYPE)
 S HMPMAX=+$G(FILTER("limit")),HMPCNT=0
 S HMPLAST=+$G(FILTER("start"))
 S HMPID=$G(FILTER("id"))
 ;
 K ^TMP($J,"HMP ERROR")
 ;
 ; extract data
 I TYPE="" S HMPERR="Missing or invalid reference type" G GTQ
 ; *** convert code below to use $$HANDLE^XUSRB4 for zero node in ^XTMP, IA 4770***
 I $D(ZTQUEUED) S HMP=$NA(^XTMP(HMPBATCH,HMPFZTSK,FILTER("domain"))) K @HMP
 I TYPE="new",$L($T(EN^HMPEFX)) D EN^HMPEFX(HMPID,HMPMAX) Q
 S HMPTN=$$TAG(TYPE) Q:'$L(HMPTN)  ;D ERR(2) Q
 D @HMPTN
 ;
GTQ ; add item count and terminating characters
 N ERROR I $D(^TMP($J,"HMP ERROR"))>0 D BUILDERR(.ERROR) S ERROR(1)=ERROR(1)_"}"
 I +$G(FILTER("noHead"))=1 D  Q
 .S @HMP@("total")=+$G(HMPI)
 .S @HMP@("last")=HMPLAST
 .S @HMP@("finished")=+$G(HMPFINI)
 .I $L($G(ERROR(1)))>1 S @HMP@("error")=ERROR(1)
 I '$D(@HMP)!'$G(HMPI) D  Q
 .I '$D(^TMP($J,"HMP ERROR")) S @HMP@(1)="""data"":{""totalItems"":0,""items"":[]}}" Q
 .S @HMP@(1)="""data"":{""totalItems"":0,""items"":[]},"
 .M @HMP@(2)=ERROR
 ;
 I $D(@HMP),$G(HMPI) D
 . S @HMP@(.5)="{""apiVersion"":""1.01"",""data"":{""updated"":"""_$$HL7NOW_""",""currentItemCount"":"_HMPI
 . S:$G(HMPCNT) @HMP@(.5)=@HMP@(.5)_",""totalItems"":"_HMPCNT
 . S:$G(HMPLAST) @HMP@(.5)=@HMP@(.5)_",""last"":"_HMPLAST
 . S @HMP@(.5)=@HMP@(.5)_",""items"":["
 . S HMPI=HMPI+1,@HMP@(HMPI)=$S($D(^TMP($J,"HMP ERROR"))>0:"]}",1:"]}}")
 I $D(^TMP($J,"HMP ERROR"))>0 S HMPI=HMPI+1,@HMP@(HMPI,.3)="," M @HMP@(HMPI)=ERROR ;S HMPI=HMPI+1,@HMP@(HMPI)="}"
 K ^TMP($J,"HMP ERROR")
 Q
 ;
BUILDERR(RESULT) ;  error array
 N CNT,COUNT,DOM,DOMCNT,ERRMSG,ERROR,FIELD,MESSAGE,MSG,MSGCNT,T,TEMP
 S COUNT=$G(^TMP($J,"HMP ERROR","# of Errors"))
 S MESSAGE="A mumps error occurred when extracting data. A total of "_COUNT_" occurred.\n\r"
 S CNT=1,ERROR("error","message","\",CNT)="A mumps error occurred when extracting patient data. A total of "_COUNT_" occurred.\n\r"
 S MSGCNT=0 F  S MSGCNT=$O(^TMP($J,"HMP ERROR","ERROR MESSAGE",MSGCNT)) Q:MSGCNT'>0  D
 . S CNT=CNT+1,MESSAGE=MESSAGE_$G(^TMP($J,"HMP ERROR","ERROR MESSAGE",MSGCNT))_"\n\r"
 S RESULT(1)="""error"":{""message"":"_""""_MESSAGE_""""_"}"
 Q
 ;
TAG(X) ; -- linetag for reference domain X
 N Y S Y="HMP",X=$G(X)
 ; default = HMP Object (various types)
 I X="location"      S Y="LOC"
 I X="pt-select"     S Y="PAT"
 I X="person"        S Y="NP"
 I X="user"          S Y="NP"
 I X="labgroup"      S Y="LABGRP"
 I X="labpanel"      S Y="LABPNL"
 I X["orderable"     S Y="OI"
 I X["schedule"      S Y="SCHEDULE"
 I X["route"         S Y="ROUTE"
 I X["quick"         S Y="QO"
 I X="displayGroup"  S Y="ODG"
 I X["asu-"          S Y="ASU"
 I X["doc-"          S Y="ASU"
 I X="immunization"    S Y="IMMTYPE"
 I X="allergy-list"         S Y="ALLTYPE"
 ;I X="problem-list"        S Y="PROB"
 I X="vital-type"      S Y="VTYPE"
 I X="vital-qualifier"  S Y="VQUAL"
 I X="vital-category"   S Y="VCAT"
 I X["clioterm"      S Y="MDTERMS"
 Q Y
 ;
ERR(X,VAL) ;  return error message
 N MSG  S MSG="Error"
 I X=2  S MSG="Domain type '"_$G(VAL)_"' not recognized"
 I X=3  S MSG="UID '"_$G(VAL)_"' not found"
 I X=99 S MSG="Unknown request"
 Q MSG
 ;
ERRMSG(X,VAL) ; -- return error message
 N Y S Y="A MUMPS error occurred while extracting "_X_" data"
 S:$G(VAL) Y=Y_", ien "_VAL
 Q Y
 ;
ERRQ ; -- Quit on error
 Q
 ;
HL7NOW() ; -- Return current time in HL7 format
 Q $$FMTHL7^HMPSTMP($$NOW^XLFDT)  ; DE5016
 ;
ALL() ;
 Q "location;patient;person;orderable;schedule;route;quick;displayGroup;asu-class;asu-rule;asu-role;doc-action;doc-status;clioterm;immunization;allergy-list;sign-symptom;vital-type;vital-qualifier;vital-category"
 ;
ADD(ITEM) ; -- add ITEM to @HMP@(HMPI)
 N HMPY,HMPERR
 I $G(HMPSTMP)]"" S @ITEM@("stampTime")=HMPSTMP ; US6734
 E  S @ITEM@("stampTime")=$$EN^HMPSTMP("NOW") ; DE2616 - must add stampTime to receive OPD freshness update from ADHOC^HMPUTIL1
 D ENCODE^HMPJSON(ITEM,"HMPY","HMPERR")
 I $D(HMPERR) D  ;return ERRor instead of ITEM
 . N HMPTMP,HMPTXT,HMPITM
 . M HMPITM=@ITEM K HMPY
 . S HMPTXT(1)="Problem encoding json output."
 . D SETERROR^HMPUTILS(.HMPTMP,.HMPERR,.HMPTXT,.HMPITM)
 . K HMPERR D ENCODE^HMPJSON("HMPTMP","HMPY","HMPERR")
 I $D(HMPY) D
 . Q:'$D(@ITEM@("uid"))
 . I $G(HMPMETA) D ADD^HMPMETA($P(HMPFADOM,"#"),@ITEM@("uid"),HMPSTMP) Q:HMPMETA=1  ;US6734,US11019
 . I HMPI D COMMA(HMPI)
 . ;I HMPI,'$G(FILTER("noHead")) D COMMA(HMPI)
 . S HMPI=HMPI+1 M @HMP@(HMPI)=HMPY
 Q
 ;
COMMA(I) ; -- add comma between items
 I $D(ZTQUEUED) Q
 N J S J=+$O(@HMP@(I,"A"),-1) ;last sub-node for item I
 S J=J+1,@HMP@(I,J)=","
 Q
 ;
TOTAL(ROOT) ; -- Return total #items in @ROOT@(n)
 Q $P($G(@ROOT@(0)),U,4)
 ;
TEST(TYPE,ID,IN) ; -- test GET, write results to screen
 N OUT,IDX
 S U="^"
 S IN("domain")=$G(TYPE)
 S:$D(ID) IN("id")=ID
 D GET(.OUT,.IN)
 ;
 S IDX=OUT
 F  S IDX=$Q(@IDX) Q:IDX'?1"^TMP(""HMP"","1.N.E  Q:+$P(IDX,",",2)'=$J  W !,@IDX
 Q
 ;
 ; ** Reference file searches, using FILTER("parameter")
 ;
PAT ;Patients
 N DFN,PAT,HMPPOPD
 S HMPPOPD=1
 S HMPCNT=$$TOTAL("^DPT")
 I $G(HMPID) S DFN=+HMPID D LKUP^HMPDJ00 Q
 N ERRMSG S ERRMSG="A mumps error occurred while extracting patients."
 S DFN=+$G(HMPLAST) F  S DFN=$O(^DPT(DFN)) Q:'(DFN>0)  D  I HMPMAX>0,HMPI'<HMPMAX Q  ;DE4496 19 August 2016
 . N $ES,$ET
 . S $ET="D ERRHDLR^HMPDERRH"
 . I $P($G(^DPT(DFN,0)),U)="" D LOGDPT^HMPLOG(DFN) Q  ;DE4496 19 August 2016
 . S ERRMSG=$$ERRMSG("Patient",DFN)
 . K PAT D LKUP^HMPDJ00
 . S HMPLAST=DFN
 I '(DFN>0) S HMPFINI=1  ;DE4496 19 August 2016
 Q
LOC ; Hospital Location (#44) and Ward Location (#42)  /DE2818
 D LOC^HMPEF1(.HMPFINI,.HMPFLDON,$G(HMPMETA))
 Q
 ;
ACTWRD(IEN) ;Boolean TRUE if active WARD LOCATION
 ; IEN - IEN in file 42
 S D0=IEN D WIN^DGPMDDCF Q 'X  ; SRG: need DBIA
 ;
ACTLOC(LOC) ;Boolean TRUE if active hospital location
 ; ^SC - IA 10040
 N D0,X I +$G(^SC(LOC,"OOS")) Q 0                ; screen out OOS entry
 S D0=+$G(^SC(LOC,42)) I D0 D WIN^DGPMDDCF Q 'X  ; chk out of svc wards
 S X=$G(^SC(LOC,"I")) I +X=0 Q 1                 ; no inactivate date
 I DT>$P(X,U)&($P(X,U,2)=""!(DT<$P(X,U,2))) Q 0  ; chk reactivate date
 Q 1                                             ; must still be active
 ;
NP ;New Persons
 D NP^HMPEF1
 Q
 ;
KEYS(IEN) ;user's keys
 N HMPKEY,IENS,X,CNT
 D GETS^DIQ(200,IEN_",","51*","IE","HMPKEY") S CNT=0
 S IENS="" F  S IENS=$O(HMPKEY(200.051,IENS)) Q:IENS=""  D
 . S X=$G(HMPKEY(200.051,IENS,.01,"E")),CNT=CNT+1
 . S USER("vistaKeys",CNT,"name")=X
 . S X=$G(HMPKEY(200.051,IENS,3,"I"))
 . S:X USER("vistaKeys",CNT,"reviewDate")=$$JSONDT^HMPUTILS(X)
 Q
 ;
ODG ;
 D ADDODG^HMPCORD4
 Q
 ;
OI ;
 D OI^HMPCORD4("PS^RAP^LRT")
 Q
 ;
PROB ;get problem list OPD store
 D PROB^HMPEF1(.HMPFINI,LEX)
 Q
 ;
QO ;
 D QO^HMPCORD4
 Q
 ;
SCHEDULE ;
 N RESULT
 D ADDSCH^HMPCORD4
 Q
 ;
ROUTE ;
 N RESULT
 D ADDROUTE^HMPCORD4
 Q
 ;
HMP ; HMP Objects
 N IEN
 S HMPCNT=$$TOTAL("^HMP(800000.11)")
 I $L(HMPID) D  Q
 . I HMPID=+HMPID S IEN=HMPID
 . E  S IEN=+$O(^HMP(800000.11,"B",HMPID,0))
 . S ERRMSG=$$ERRMSG("HMP Object",IEN)
 . D:IEN HMP1^HMPDJ02(800000.11,IEN)
 S IEN=+$G(HMPLAST) F  S IEN=$O(^HMP(800000.11,"C",TYPE,IEN)) Q:IEN<1  D  I HMPMAX>0,HMPI'<HMPMAX Q
 . S ERRMSG=$$ERRMSG("HMP Object",IEN)
 . D HMP1^HMPDJ02(800000.11,IEN) S HMPLAST=IEN
 I IEN<1 S HMPFINI=1
 Q
 ;
SOURCE(SRC) ;
 N X S X=""
 I SRC["SC("        S X="clinic"
 I SRC["DPT("       S X="patient"
 I SRC["DIC(42"     S X="ward"
 I SRC["SCTM"       S X="pcmm"
 I SRC["OR(100.21"  S X="cprs"
 I SRC["DIC(45.7"   S X="specialty"
 I SRC["VA(200"     S X="provider"
 I SRC["PXRM(810.4" S X="pxrm"
 Q X
 ;
ASU ; ASU files
 N X,RTN S X=$P($G(TYPE),"-",2)
 S RTN=$$UP^XLFSTR(X)_"^HMPEASU"
 I X'="",$L($T(@RTN)) D @RTN
 Q
 ;
MDTERMS ; CP Terminology
 D:$L($T(TERM^HMPMDUTL)) TERM^HMPMDUTL
 Q
LABGRP ;
 D SHWCUMR2^HMPELAB
 Q
LABPNL ;
 D SHWORPNL^HMPELAB
 Q
 ;
 ;DE2818, changed reference to ^VA(201) to a FileMan call
ISPROXY(IEN) ; Boolean function, is NEW PERSON entry an APPLICATION PROXY?
 N APP,HMPMSG,HMPUCLS,T,V
 ; APP - returned value
 ; HMPUCLS - user class array
 ; HMPMSG - FileMan message array
 ;
 D GETS^DIQ(200,IEN_",","9.5*","E","HMPUCLS","HMPMSG")  ; get external format
 S APP=0,T="APPLICATION PROXY",V="HMPUCLS"
 ; search returned array for value equal to T
 F  S V=$Q(@V) Q:V=""!APP  S:@V=T APP=1
 Q APP
 ;
IMMTYPE ;immunization types
 D IMMTYPE^HMPCORD5
 Q
 ;
ALLTYPE ;allergy-list types
 ;BL;REMOVE FROM ODS
 ;D ALLTYPE^HMPCORD5
 Q
 ;
VTYPE ;vital types
 D VTYPE^HMPCORD5
 Q
 ;
VQUAL ;vital qualifiers
 D VQUAL^HMPCORD5
 Q
 ;
VCAT ;vital categories
 D VCAT^HMPCORD5
 Q
 ;
FILENAME ; text of filenames for search treeview
 ;;VA Allergies File
 ;;VA Allergies File (Synonyms)  SPACER ONLY - NOT DISPLAYED
 ;;National Drug File - Generic Drug Name
 ;;National Drug file - Trade Name
 ;;Local Drug File
 ;;Local Drug File (Synonyms)  SPACER ONLY - NOT DISPLAYED
 ;;Drug Ingredients File
 ;;VA Drug Class File
 ;;
