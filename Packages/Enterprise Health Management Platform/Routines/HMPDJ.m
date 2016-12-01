HMPDJ ;SLC/MKB,ASMR/RRB,CK -- Serve VistA data as JSON via RPC;May 15, 2016 14:15
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**1**;May 15, 2016;Build 4
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DPT                         10035
 ; MPIF001                       2701
 ; XLFDT                        10103
 ; XLFSTR                       10104
 ; XUPARAM                       2541
 ;
 ; DE2818/RRB - SQA findings 1st 3 lines of code.
 ;
 Q
GET(HMP,FILTER) ; -- Return search results as JSON in @HMP@(n)
 ; RPC = HMP GET PATIENT DATA JSON
 ; where FILTER("patientId") = DFN or DFN;ICN
 ;       FILTER("domain")    = name of desired data type  (see HMPDJ0)
 ;       FILTER("text")      = boolean, to include document text [opt]
 ;       FILTER("start")     = start date.time of search         [opt]
 ;       FILTER("stop")      = stop date.time of search          [opt]
 ;       FILTER("max")       = maximum number of items to return [opt]
 ;       FILTER("id")        = single item id to return          [opt]
 ;       FILTER("uid")       = single record uid to return       [opt]
 ;       FILTER("noHead")    = flag, to omit header and commas   [opt]
 ;
 N ICN,DFN,HMPI,HMPSYS,HMPTYPE,HMPSTART,HMPSTOP,HMPMAX,HMPID,HMPTEXT,HMPP,TYPE,HMPTN,HMPERR
 S HMP=$NA(^TMP("HMP",$J)),HMPI=0 K @HMP
 S HMPSYS=$$SYS^HMPUTILS
 S DT=$$DT^XLFDT             ;for crossing midnight boundary
 ;
 ; parse & validate input parameters
 I $G(FILTER("uid"))'="" D SEPUID(.FILTER)
 ;
 S DFN=$G(FILTER("patientId"))
 ;
 S ICN=+$P($G(DFN),";",2),DFN=+$G(DFN)
 I DFN<1,ICN S DFN=+$$GETDFN^MPIF001(ICN)
 ;
 S HMPTYPE=$G(FILTER("domain")) S:HMPTYPE="" HMPTYPE=$$ALL
 I $D(ZTQUEUED) S HMP=$NA(^XTMP(HMPBATCH,HMPFZTSK,HMPTYPE)) K @HMP
 I HMPTYPE'="new",DFN<1!'$D(^DPT(DFN)) S HMPERR=$$ERR(1,DFN) G GTQ ;ICR 10035 DE2818 ASF 11/2/15
 ;
 ; -- initialize chunking if from DOMPT^HMPDJFSP ; i.e. HMPCHNK defined *S68-JCH*
 D CHNKINIT^HMPDJFSP(.HMP,.HMPI) ; *S68-JCH*
 ;
 S HMPSTART=+$G(FILTER("start"),1410102)
 S HMPSTOP=+$G(FILTER("stop"),4141015)
 S HMPMAX=+$G(FILTER("max"),999999)
 I HMPSTART,HMPSTOP,HMPSTOP<HMPSTART D
 . N X S X=HMPSTART,HMPSTART=HMPSTOP,HMPSTOP=X
 I HMPSTOP,$L(HMPSTOP,".")<2 S HMPSTOP=HMPSTOP_".24"
 ;
 S HMPID=$G(FILTER("id"))
 S HMPTEXT=+$G(FILTER("text"),1) ;default = true/text
 ;
 ;set error trap
 K ^TMP($J,"HMP ERROR")
 ;
 ; extract data
 I HMPTYPE="new",$L($T(EN^HMPDJX)),'$G(^XTMP("HMP-off","GET")) D EN^HMPDJX(HMPID,HMPMAX) Q  ;data updates
 F HMPP=1:1:$L(HMPTYPE,";") S TYPE=$P(HMPTYPE,";",HMPP) I $L(TYPE) D
 . S HMPTN=$$TAG(TYPE)_"^HMPDJ0" Q:'$L($T(@HMPTN))  ;D ERR(2) Q
 . N $ES,$ET,ERRPAT,ERRMSG
 . S $ET="D ERRHDLR^HMPDERRH",ERRMSG="A problem occurred when trying to load patient data from an API."
 . D @HMPTN
 ;
GTQ ; add item count and terminating characters
 N ERROR I $D(^TMP($J,"HMP ERROR"))>0 D BUILDERR(.ERROR)
 I +$G(FILTER("noHead"))=1 D  Q
 .S @HMP@("total")=+$G(HMPI)
 .I $L($G(ERROR(1)))>1 S @HMP@("error")=ERROR(1)
 S @HMP@(.5)="{""apiVersion"":""1.01"",""params"":{"_$$SYS_"},"
 I $D(HMPERR) S @HMP@(1)="""error"":{""message"":"""_HMPERR_"""}}" Q
 I '$D(@HMP)!'$G(HMPI) D  Q
 . I '$D(ERROR) S @HMP@(1)="""data"":{""totalItems"":0,""items"":[]}}" Q
 . S @HMP@(1)="""data"":{""totalItems"":0,""items"":[]},"
 . S @HMP@(2,1)=ERROR(1)_"}"
 ;
 S @HMP@(.6)="""data"":{""updated"":"""_$$HL7NOW_""",""totalItems"":"_HMPI_",""items"":["
 S HMPI=HMPI+1,@HMP@(HMPI)=$S($D(ERROR):"]}",1:"]}}")
 I $D(ERROR)>0 S HMPI=HMPI+1,@HMP@(HMPI,.3)=",",@HMP@(HMPI,1)=ERROR(1)_"}"
 K ^TMP($J,"HMP ERROR"),^TMP("HMPTEXT",$J)
 Q
 ;
SEPUID(FILTER) ; -- separate uid into FILTER pieces
 N UID
 S UID=$G(FILTER("uid")) K FILTER("uid") Q:UID=""
 I $P(UID,":",4)'=HMPSYS Q
 S FILTER("patientId")=$P(UID,":",5)
 S FILTER("domain")=$P(UID,":",3)
 S FILTER("id")=$P(UID,":",6)
 Q
 ;
SYS() ; -- return system info for JSON header
 Q """domain"":"""_$$KSP^XUPARAM("WHERE")_""",""systemId"":"""_HMPSYS_""""
 ;
BUILDERR(RESULT,DFN) ; -- build error array
 N COUNT,MESSAGE,MSGCNT
 S COUNT=$G(^TMP($J,"HMP ERROR","# of Errors"))
 S MESSAGE="A mumps error occurred when extracting patient data. A total of "_COUNT_" occurred.\n\r"
 S MSGCNT=0 F  S MSGCNT=$O(^TMP($J,"HMP ERROR","ERROR MESSAGE",MSGCNT)) Q:MSGCNT'>0  D
 . S MESSAGE=MESSAGE_$G(^TMP($J,"HMP ERROR","ERROR MESSAGE",MSGCNT))_"\n\r"
 S RESULT(1)="""error"":{""message"":"""_MESSAGE_"""}"
 Q
 ;
TAG(X) ; -- Return linetag in HMPDJ0 routine for clinical domain X
 N Y S X=$G(X,"Z")
 S Y=$E($$UP^XLFSTR(X),1,8)
 S:'$L($T(@(Y_"^HMPDJ0"))) Y="HMP"
 Q Y
 ;
ALL() ; -- return string for all types of data
 Q "patient;problem;allergy;consult;vital;lab;procedure;obs;order;treatment;med;ptf;factor;immunization;exam;cpt;education;pov;skin;image;appointment;surgery;document;visit;mh"
 ;
ERR(X,VAL) ; -- return error message
 N MSG  S MSG="Error"
 I X=1  S MSG="Patient with dfn '"_$G(VAL)_"' not found"
 I X=2  S MSG="Domain type '"_$G(VAL)_"' not recognized"
 I X=3  S MSG="UID '"_$G(VAL)_"' not found"
 I X=4  S MSG="Unable to create new object"
 I X=99 S MSG="Unknown request"
 Q MSG
 ;
HL7NOW() ; -- Return current time in HL7 format
 Q $P($$FMTHL7^XLFDT($$NOW^XLFDT),"-")
 ;
ADD(ITEM,COLL) ; -- add ITEM to results
 I $D(HMPCRC),$D(COLL) D ONE^HMPDCRC(ITEM,COLL) Q  ;checksum
 ; -- add ITEM to @HMP@(HMPI) to return JSON
 N HMPY,HMPERR
 D ENCODE^HMPJSON(ITEM,"HMPY","HMPERR")
 I $D(HMPERR) D  ;return ERRor instead of ITEM
 . N HMPTMP,HMPTXT,HMPITM
 . M HMPITM=@ITEM K HMPY
 . S HMPTXT(1)="Problem encoding json output."
 . D SETERROR^HMPUTILS(.HMPTMP,.HMPERR,.HMPTXT,.HMPITM)
 . K HMPERR D ENCODE^HMPJSON("HMPTMP","HMPY","HMPERR")
 I $D(HMPY) D
 . S HMPI=HMPI+1
 . I HMPI>1 S @HMP@(HMPI,.3)=","
 . M @HMP@(HMPI)=HMPY
 . ;
 . ; -- chunk data if from DOMPT^HMPDJFSP ; i.e. HMPCHNK defined ; *S68-JCH*
 . D CHNKCHK^HMPDJFSP(.HMP,.HMPI) ; *S68-JCH*
 Q
 ;
TEST(DFN,TYPE,ID,TEXT,IN) ; -- test GET, write results to screen
 N OUT,IDX S U="^"
 S:'$D(IN("systemID")) IN("systemID")=$$SYS^HMPUTILS
 S IN("patientId")=+$G(DFN)
 S IN("domain")=$G(TYPE)
 S:$D(ID) IN("id")=ID
 S:$D(TEXT) IN("text")=TEXT
 D GET(.OUT,.IN)
 ;
 S IDX=OUT
 F  S IDX=$Q(@IDX) Q:IDX'?1"^TMP(""HMP"","1.N.E  Q:+$P(IDX,",",2)'=$J  W !,@IDX
 Q
 ;
