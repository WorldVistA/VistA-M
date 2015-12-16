VPRD ;SLC/MKB -- Serve VistA data as XML via RPC ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**1,2,4,5**;Sep 01, 2011;Build 21
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DPT                         10035
 ; ^SC                          10040
 ; ^USC(8932.1)                  4984
 ; DIQ                           2056
 ; MPIF001                       2701
 ; VASITE                       10112
 ; XLFDT                        10103
 ; XLFSTR                       10104
 ; XPAR                          2263
 ; XUAF4                         2171
 ; XUSTAX                        4911
 ;
GET(VPR,DFN,TYPE,START,STOP,MAX,ID,FILTER) ; -- Return search results as XML in @VPR@(n)
 ; RPC = VPR GET PATIENT DATA
 N ICN,VPRI,VPRTOTL,VPRTEXT
 S VPR=$NA(^TMP("VPR",$J)) K @VPR
 S VPRTEXT=+$G(FILTER("text")) ;include report/document text?
 ;
 ; parse & validate input parameters
 S ICN=+$P($G(DFN),";",2),DFN=+$G(DFN),ID=$G(ID)
 I DFN<1,ICN S DFN=+$$GETDFN^MPIF001(ICN)
 I DFN<1!'$D(^DPT(DFN)) D ERR(1,DFN) G GTQ
 S TYPE=$$LOW^XLFSTR($G(TYPE)) I TYPE="" S TYPE=$$ALL
 S:'$G(START) START=1410102 S:'$G(STOP) STOP=4141015 S:'$G(MAX) MAX=9999
 I START,STOP,STOP<START N X S X=START,START=STOP,STOP=X  ;switch
 I STOP,$L(STOP,".")<2 S STOP=STOP_".24"
 I ID="",$D(FILTER("id")) S ID=FILTER("id")
 ;
 ; extract data
 N VPRTYPE,VPRP,VPRHDR,VPRTAG,VPRTN
 D ADD("<results version='"_$$GET^XPAR("ALL","VPR VERSION")_"' timeZone='"_$$TZ^XLFDT_"' >")
 S VPRTYPE=TYPE
 F VPRP=1:1:$L(VPRTYPE,";") S VPRTAG=$P(VPRTYPE,";",VPRP) I $L(VPRTAG) D
 . S VPRTN="EN^"_$$RTN(.VPRTAG) Q:'$L($T(@VPRTN))  ;D ERR(2) Q
 . D ADD("<"_VPRTAG) S VPRHDR=VPRI,VPRTOTL=0
 . D @(VPRTN_"(DFN,START,STOP,MAX,ID)")
 . S @VPR@(VPRHDR)=@VPR@(VPRHDR)_" total='"_+$G(VPRTOTL)_"' >" D ADD("</"_VPRTAG_">")
 D ADD("</results>")
 ;
GTQ ; end
 K ^TMP("VPRD",$J)
 Q
 ;
RTN(X) ; -- Return name of VPRDxxxx routine for clinical domain X
 ;  X is also enforced as expected group tag name, if passed by ref
 N Y S Y="VPRD",X=$G(X) I X="" Q Y
 I X["accession"    S Y="VPRDLRA",X="accessions"
 I X["allerg"       S Y="VPRDGMRA",X="reactions"
 I X["appointment"  S Y="VPRDSDAM",X="appointments"
 I X["clinicalproc" S Y="VPRDMC",X="clinicalProcedures"
 I X["consult"      S Y="VPRDGMRC",X="consults"
 I X["demograph"    S Y="VPRDPT",X="demographics"
 I X["document"     S Y="VPRDTIU",X="documents"
 I X["factor"       S Y="VPRDPXHF",X="healthFactors"
 I X["flag"         S Y="VPRDGPF",X="flags"
 I X["function"     S Y="VPRDRMIM",X="functionalMeasurements"
 I X="fim"          S Y="VPRDRMIM",X="functionalMeasurements"
 I X["immunization" S Y="VPRDPXIM",X="immunizations"
 I X["skin"         S Y="VPRDPXSK",X="skinTests"
 I X?1"exam".E      S Y="VPRDPXAM",X="exams"
 I X["educat"       S Y="VPRDPXED",X="educationTopics"
 I X["insur"        S Y="VPRDIB",X="insurancePolicies"
 I X["polic"        S Y="VPRDIB",X="insurancePolicies"
 I X["lab"          S Y="VPRDLR",X="labs"
 I X["panel"        S Y="VPRDLRO",X="panels"
 I X["med"          S Y="VPRDPS",X="meds"
 I X["pharm"        S Y="VPRDPSOR",X="meds"
 I X["observ"       S Y="VPRDMDC",X="observations"
 I X["order"        S Y="VPRDOR",X="orders"
 I X["patient"      S Y="VPRDPT",X="demographics"
 I X["problem"      S Y="VPRDGMPL",X="problems"
 I X?1"procedure".E S Y="VPRDPROC",X="procedures"
 I X["reaction"     S Y="VPRDGMRA",X="reactions"
 I X["reminder"     S Y="VPRDPXRM",X="reminders"
 I X["surg"         S Y="VPRDSR",X="surgeries"
 I X["visit"        S Y="VPRDVSIT",X="visits"
 I X["vital"        S Y="VPRDGMV",X="vitals"
 I X["rad"          S Y="VPRDRA",X="radiologyExams"
 I X["xray"         S Y="VPRDRA",X="radiologyExams"
 Q Y
 ;
TAG(X) ; -- return plural name for group tags
 N Y S:X'?1.L X=$$LOW^XLFSTR(X)
 I $E(X,$L(X))="s" S Y=X
 I $E(X,$L(X))="y" S Y=$E(X,1,$L(X)-1)_"ies"
 E  S Y=X_"s"
 Q Y
 ;
ALL() ; -- return string for all types of data
 Q "demographics;reactions;problems;vitals;labs;meds;immunizations;observations;visits;appointments;documents;procedures;consults;flags;factors;skinTests;exams;education;insurance;reminders"
 ;
ERR(X,VAL) ; -- return error message
 N MSG  S MSG="Error"
 I X=1  S MSG="Patient with DFN '"_$G(VAL)_"' not found"
 I X=2  S MSG="Requested domain type '"_$G(VAL)_"' not recognized"
 I X=99 S MSG="Unknown request"
 ;
 D ADD("<error>")
 D ADD("<message>"_MSG_"</message>")
 D ADD("</error>")
 Q
 ;
ESC(X) ; -- escape outgoing XML
 ; Q $ZCONVERT(X,"O","HTML")  ; uncomment for fastest performance on Cache
 ;
 N I,Y,QOT S QOT=""""
 S Y=$P(X,"&") F I=2:1:$L(X,"&") S Y=Y_"&amp;"_$P(X,"&",I)
 S X=Y,Y=$P(X,"<") F I=2:1:$L(X,"<") S Y=Y_"&lt;"_$P(X,"<",I)
 S X=Y,Y=$P(X,">") F I=2:1:$L(X,">") S Y=Y_"&gt;"_$P(X,">",I)
 S X=Y,Y=$P(X,"'") F I=2:1:$L(X,"'") S Y=Y_"&apos;"_$P(X,"'",I)
 S X=Y,Y=$P(X,QOT) F I=2:1:$L(X,QOT) S Y=Y_"&quot;"_$P(X,QOT,I)
 Q Y
 ;
ADD(X) ; Add a line @VPR@(n)=X
 S VPRI=$G(VPRI)+1
 S @VPR@(VPRI)=X
 Q
 ;
STRING(ARRAY) ; -- Return text in ARRAY(n) or ARRAY(n,0) as a string
 N I,X,Y S Y=""
 S I=+$O(ARRAY("")) I I=0 S I=+$O(ARRAY(0))
 S Y=$S($D(ARRAY(I,0)):ARRAY(I,0),1:$G(ARRAY(I)))
 F  S I=$O(ARRAY(I)) Q:I<1  D
 . S X=$S($D(ARRAY(I,0)):ARRAY(I,0),1:ARRAY(I))
 . I $E(X)=" " S Y=Y_$C(13,10)_X Q
 . S Y=Y_$S($E(Y,$L(Y))=" ":"",1:" ")_X
 Q Y
 ;
FAC(X) ; -- return Institution file station# for location X
 N HLOC,FAC,Y0,Y S Y=""
 S HLOC=$G(^SC(+$G(X),0)),FAC=$P(HLOC,U,4)
 ; Get P:4 via Med Ctr Div, if not directly linked
 I 'FAC,$P(HLOC,U,15) S FAC=$$GET1^DIQ(44,+$G(X)_",","3.5:.07","I")
 S Y0=$S(FAC:$$NS^XUAF4(FAC),1:$P($$SITE^VASITE,U,2,3)) ;name^stn#
 S:$L(Y0) Y=$P(Y0,U,2)_U_$P(Y0,U) ;switch to stn#^name
 I $L(Y),'Y S $P(Y,U)=FAC
 Q Y
 ;
PROVTAGS() ; -- Return attribute tags for provider info as built below
 Q "officePhone^analogPager^fax^email^taxonomyCode^providerType^classification^specialization^service"
 ;
PROVSPC(NP) ; -- Return contact & specialty info for provider NP
 ; save strings in ^TMP("VPRD",$J,NP) for efficiency
 N X,Y,I,CLS,RES,X13,X15 S NP=+$G(NP) ;protect I for calling routine
 S RES=$G(^TMP("VPRD",$J,NP)) I $L(RES) Q RES
 S X13=$G(^VA(200,NP,.13)),X15=$G(^(.15))
 S RES=$P(X13,U,2)_U_$P(X13,U,7)_U_$P(X13,U,6)_U_$P(X15,U)_U
 S X=$$TAXIND^XUSTAX(NP) I $P(X,U,2) D  ;= X12 code ^ #8932.1 ien
 . S CLS=$G(^USC(8932.1,$P(X,U,2),0)) Q:CLS=""
 . S RES=RES_$P(X,U)_U_$P(CLS,U,1,3) ;X12^type^class^specialization
 S $P(RES,U,9)=$$GET1^DIQ(200,NP_",",29)
 S ^TMP("VPRD",$J,NP)=RES
 Q RES
 ;
VUID(IEN,FILE) ; -- Return VUID for item
 Q $$GET1^DIQ(FILE,IEN_",",99.99)
 ;
VERSION(RET) ; -- Return current version of data extracts
 S RET=$$GET^XPAR("ALL","VPR VERSION")
 Q
 ;
TEST(DFN,TYPE,ID,START,STOP,MAX,TEXT,IN) ; -- test GET, write results to screen
 N OUT,IDX S U="^"
 S DFN=+$G(DFN) Q:DFN<1
 S TYPE=$G(TYPE) Q:TYPE=""
 D GET(.OUT,DFN,TYPE,$G(START),$G(STOP),$G(MAX),$G(ID),.IN)
 ;
 S IDX=OUT
 F  S IDX=$Q(@IDX) Q:IDX'?1"^TMP(""VPR"","1.N.E  Q:+$P(IDX,",",2)'=$J  W !,@IDX
 Q
