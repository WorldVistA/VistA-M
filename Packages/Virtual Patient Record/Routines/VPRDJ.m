VPRDJ ;SLC/MKB -- Serve VistA data as JSON via RPC ;10/18/12 6:26pm
 ;;1.0;VIRTUAL PATIENT RECORD;**2**;Sep 01, 2011;Build 317
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DPT                         10035
 ; MPIF001                       2701
 ; XLFDT                        10103
 ; XLFSTR                       10104
 ; XUPARAM                       2541
 ;
GET(VPR,FILTER) ; -- Return search results as JSON in @VPR@(n)
 ; RPC = VPR GET PATIENT DATA JSON
 ; where FILTER("patientId") = DFN or DFN;ICN
 ;       FILTER("domain")    = name of desired data type  (see VPRDJ0)
 ;       FILTER("text")      = boolean, to include document text [opt]
 ;       FILTER("start")     = start date.time of search         [opt]
 ;       FILTER("stop")      = stop date.time of search          [opt]
 ;       FILTER("max")       = maximum number of items to return [opt]
 ;       FILTER("id")        = single item id to return          [opt]
 ;       FILTER("uid")       = single record uid to return       [opt]
 ;
 N ICN,DFN,VPRSYS,VPRTYPE,VPRSTART,VPRSTOP,VPRMAX,VPRI,VPRID,VPRTEXT,VPRP,VPRTN,VPRERR
 S VPR=$NA(^TMP("VPR",$J)),VPRI=0 K @VPR
 S VPRSYS=$$GET^XPAR("SYS","VPR SYSTEM NAME")
 S DT=$$DT^XLFDT             ;for crossing midnight boundary
 ;
 I $G(FILTER("uid"))'="" D SEPUID(.FILTER)
 ; parse & validate input parameters
 S DFN=$G(FILTER("patientId"))
 S ICN=+$P($G(DFN),";",2),DFN=+$G(DFN)
 I DFN<1,ICN S DFN=+$$GETDFN^MPIF001(ICN)
 ;
 S VPRTYPE=$G(FILTER("domain")) S:VPRTYPE="" VPRTYPE=$$ALL
 I $D(ZTQUEUED) S VPR=$NA(^XTMP(VPRBATCH,DFN,VPRTYPE)) K @VPR
 I VPRTYPE'="new",DFN<1!'$D(^DPT(DFN)) S VPRERR=$$ERR(1,DFN) G GTQ
 ;
 S VPRSTART=+$G(FILTER("start"),1410102)
 S VPRSTOP=+$G(FILTER("stop"),4141015)
 S VPRMAX=+$G(FILTER("max"),9999)
 I VPRSTART,VPRSTOP,VPRSTOP<VPRSTART D
 . N X S X=VPRSTART,VPRSTART=VPRSTOP,VPRSTOP=X
 I VPRSTOP,$L(VPRSTOP,".")<2 S VPRSTOP=VPRSTOP_".24"
 ;
 S VPRID=$G(FILTER("id"))
 S VPRTEXT=+$G(FILTER("text"),1) ;default = true/text
 ;
 ; extract data
 I VPRTYPE="new",$L($T(EN^VPRDJX)) D EN^VPRDJX(VPRID,VPRMAX) Q  ;data updates
 F VPRP=1:1:$L(VPRTYPE,";") S TYPE=$P(VPRTYPE,";",VPRP) I $L(TYPE) D
 . S VPRTN=$$TAG(TYPE)_"^VPRDJ0" Q:'$L($T(@VPRTN))
 . D @VPRTN
 ;
GTQ ; add item count and terminating characters
 S @VPR@(.5)="{""apiVersion"":""1.01"",""params"":{"_$$SYS_"},"
 I $D(VPRERR) S @VPR@(1)="""error"":{""message"":"""_VPRERR_"""}}" Q
 I '$D(@VPR)!'$G(VPRI) S @VPR@(1)="""data"":{""totalItems"":0,""items"":[]}}" Q
 ;
 S @VPR@(.6)="""data"":{""updated"":"""_$$HL7NOW_""",""totalItems"":"_VPRI_",""items"":["
 S VPRI=VPRI+1,@VPR@(VPRI)="]}}"
 K ^TMP("VPRTEXT",$J)
 Q
 ;
SEPUID(FILTER) ; -- separate uid into FILTER pieces
 N UID
 S UID=$G(FILTER("uid")) K FILTER("uid") Q:UID=""
 I $P(UID,":",4)'=VPRSYS Q
 S FILTER("patientId")=$P(UID,":",5)
 S FILTER("domain")=$P(UID,":",3)
 S FILTER("id")=$P(UID,":",6)
 Q
 ;
SYS() ; -- return system info for JSON header
 Q """domain"":"""_$$KSP^XUPARAM("WHERE")_""",""systemId"":"""_VPRSYS_""""
 ;
TAG(X) ; -- Return linetag in VPRDJ0 routine for clinical domain X
 N Y S X=$G(X,"Z")
 S Y=$E($$UP^XLFSTR(X),1,8)
 S:'$L($T(@(Y_"^VPRDJ0"))) Y="VPR"
 Q Y
 ;
ALL() ; -- return string for all types of data
 Q "patient;problem;allergy;consult;vital;lab;procedure;obs;order;treatment;med;ptf;factor;immunization;exam;cpt;education;pov;skin;image;appointment;surgery;document;visit"
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
 I $D(VPRCRC),$D(COLL) D ONE^VPRDCRC(ITEM,COLL) Q  ;checksum
 ; -- add ITEM to @VPR@(VPRI) to return JSON
 N VPRY,VPRERR
 D ENCODE^VPRJSON(ITEM,"VPRY","VPRERR")
 I $D(VPRERR) D  ;return ERRor instead of ITEM
 . N VPRTMP,VPRTXT,VPRITM
 . M VPRITM=@ITEM K VPRY
 . S VPRTXT(1)="Problem encoding json output."
 . D SETERROR^VPRUTILS(.VPRTMP,.VPRERR,.VPRTXT,.VPRITM)
 . K VPRERR D ENCODE^VPRJSON("VPRTMP","VPRY","VPRERR")
 I $D(VPRY) D
 . S VPRI=VPRI+1 S:VPRI>1 @VPR@(VPRI,.3)=","
 . M @VPR@(VPRI)=VPRY
 Q
 ;
TEST(DFN,TYPE,ID,TEXT,IN) ; -- test GET, write results to screen
 N OUT,IDX
 S U="^"
 S:'$D(IN("systemID")) IN("systemID")=$$GET^XPAR("SYS","VPR SYSTEM NAME")
 S IN("patientId")=+$G(DFN)
 S IN("domain")=$G(TYPE)
 S:$D(ID) IN("id")=ID
 S:$D(TEXT) IN("text")=TEXT
 D GET(.OUT,.IN)
 ;
 S IDX=OUT
 F  S IDX=$Q(@IDX) Q:IDX'?1"^TMP(""VPR"","1.N.E  Q:+$P(IDX,",",2)'=$J  W !,@IDX
 Q
