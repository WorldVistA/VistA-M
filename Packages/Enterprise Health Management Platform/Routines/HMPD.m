HMPD ;SLC/MKB,ASMR/RRB - Serve VistA data as XML via RPC ;8/2/11  15:29
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DPT                         10035
 ; ^SC                          10040
 ; DIQ                           2056
 ; MPIF001                       2701
 ; VASITE                       10112
 ; XLFDT                        10103
 ; XLFSTR                       10104
 ; XUAF4                         2171
 ;
 Q
 ;
GET(HMP,DFN,TYPE,START,STOP,MAX,ID,FILTER) ; -- Return search results as XML in @HMP@(n) 
 ; RPC = HMP GET PATIENT DATA
 N ICN,HMPI,HMPTOTL,HMPTEXT
 S HMP=$NA(^TMP("HMP",$J)) K @HMP
 S HMPTEXT=+$G(FILTER("text")) ;include report/document text?
 ;
 ; parse & validate input parameters
 S ICN=+$P($G(DFN),";",2),DFN=+$G(DFN),ID=$G(ID)
 I DFN<1,ICN S DFN=+$$GETDFN^MPIF001(ICN)
 S TYPE=$$LOW^XLFSTR($G(TYPE)) I TYPE="" S TYPE=$$ALL
 I TYPE'="new",DFN<1!'$D(^DPT(DFN)) D ERR(1,DFN) G GTQ ;ICR 10035 ASF 11/2/15 DE2818
 S:'$G(START) START=1410102 S:'$G(STOP) STOP=4141015 S:'$G(MAX) MAX=9999
 I START,STOP,STOP<START N X S X=START,START=STOP,STOP=X  ;switch
 I STOP,$L(STOP,".")<2 S STOP=STOP_".24"
 I ID="",$D(FILTER("id")) S ID=FILTER("id")
 ;
 ; extract data
 N HMPTYPE,HMPP,HMPHDR,HMPTAG,HMPTN
 S HMPTYPE=TYPE D ADD("<results version='1.1' timeZone='"_$$TZ^XLFDT_"' >")
 F HMPP=1:1:$L(HMPTYPE,";") S HMPTAG=$P(HMPTYPE,";",HMPP) I $L(HMPTAG) D
 . S HMPTN="EN^"_$$RTN(.HMPTAG) Q:'$L($T(@HMPTN))  ;D ERR(2) Q
 . D ADD("<"_HMPTAG) S HMPHDR=HMPI,HMPTOTL=0
 . D @(HMPTN_"(DFN,START,STOP,MAX,ID)")
 . S @HMP@(HMPHDR)=@HMP@(HMPHDR)_" total='"_+$G(HMPTOTL)_"' >" D ADD("</"_HMPTAG_">")
 D ADD("</results>")
 ;
GTQ ; end
 Q
 ;
RTN(X) ; -- Return name of HMPDxxxx routine for clinical domain X
 ;  X is also enforced as expected group tag name, if passed by ref
 N Y S Y="HMPD",X=$G(X) I X="" Q Y
 I X["accession"    S Y="HMPDLRA",X="accessions"
 I X["allerg"       S Y="HMPDGMRA",X="reactions"
 I X["appointment"  S Y="HMPDSDAM",X="appointments"
 I X["clinicalProc" S Y="HMPDMC",X="clinicalProcedures"
 I X["consult"      S Y="HMPDGMRC",X="consults"
 I X["demograph"    S Y="HMPDPT",X="demographics"
 I X["document"     S Y="HMPDTIU",X="documents"
 I X["factor"       S Y="HMPDPXHF",X="healthFactors"
 I X["flag"         S Y="HMPDGPF",X="flags"
 I X["immunization" S Y="HMPDPXIM",X="immunizations"
 I X["skin"         S Y="HMPDPXSK",X="skinTests"
 I X?1"exam".E      S Y="HMPDPXAM",X="exams"
 I X["educat"       S Y="HMPDPXED",X="educationTopics"
 I X["insur"        S Y="HMPDIB",X="insurancePolicies"
 I X["polic"        S Y="HMPDIB",X="insurancePolicies"
 I X["lab"          S Y="HMPDLR",X="labs"
 I X["panel"        S Y="HMPDLRO",X="panels"
 I X["med"          S Y="HMPDPS",X="meds"
 I X["pharm"        S Y="HMPDPSOR",X="meds"
 I X["observ"       S Y="HMPDMDC",X="observations"
 I X["order"        S Y="HMPDOR",X="orders"
 I X["patient"      S Y="HMPDPT",X="demographics"
 I X["problem"      S Y="HMPDGMPL",X="problems"
 I X["procedure"    S Y="HMPDPROC",X="procedures"
 I X["reaction"     S Y="HMPDGMRA",X="reactions"
 I X["surg"         S Y="HMPDSR",X="surgeries"
 I X["visit"        S Y="HMPDVSIT",X="visits"
 I X["vital"        S Y="HMPDGMV",X="vitals"
 I X["rad"          S Y="HMPDRA",X="radiologyExams"
 I X["xray"         S Y="HMPDRA",X="radiologyExams"
 I X["new"          S Y="HMPDX",X="patients"
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
 Q "demographics;reactions;problems;vitals;labs;meds;immunizations;observation;visits;appointments;documents;procedures;consults;flags;factors;skinTests;exams;education;insurance"
 ;
ERR(X,VAL) ; -- return error message
 N MSG  S MSG="Error"
 I X=1  S MSG="Patient with dfn '"_$G(VAL)_"' not found"
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
ADD(X) ; Add a line @HMP@(n)=X
 S HMPI=$G(HMPI)+1
 S @HMP@(HMPI)=X
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
 S HLOC=$G(^SC(+$G(X),0)),FAC=$P(HLOC,U,4) ;ICR 10040 DE2818 ASF 11/5/15
 ; Get P:4 via Med Ctr Div, if not directly linked
 I 'FAC,$P(HLOC,U,15) S FAC=$$GET1^DIQ(44,+$G(X)_",","3.5:.07","I")
 S Y0=$S(FAC:$$NS^XUAF4(FAC),1:$P($$SITE^VASITE,U,2,3)) ;name^stn#
 S:$L(Y0) Y=$P(Y0,U,2)_U_$P(Y0,U) ;switch to stn#^name
 I $L(Y),'Y S $P(Y,U)=FAC
 Q Y
 ;
VUID(IEN,FILE) ; -- Return VUID for item
 Q $$GET1^DIQ(FILE,IEN_",",99.99)
 ;
VERSION(RET) ; -- Return current version of data extracts
 S RET="1.01"
 Q
