HMPDGMPL ;SLC/MKB,ASMR/RRB - Problem extract;8/2/11  15:29
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^AUPNPROB                     5703
 ; ^DPT                         10035
 ; ^VA(200                      10060
 ; ^WV(790.05                    5772
 ; %DT                          10003
 ; DIQ                           2056
 ; GMPLUTL2                      2741
 ; SDUTL3                        1252
 ; XLFDT                        10103
 ; XUAF4                         2171
 Q
 ; ------------ Get problems from VistA ------------
 ;
EN(DFN,BEG,END,MAX,IFN) ; -- find patient's problems
 N HMPSTS,HMPPROB,HMPN,HMPITM,HMPCNT,X
 ;
 ; get one problem
 I $G(IFN)="WV" D WV(.HMPITM,1),XML(.HMPITM):$D(HMPITM) Q
 I $G(IFN) D EN1(IFN,.HMPITM),XML(.HMPITM) Q
 ;
 ; get all patient problems
 S DFN=+$G(DFN) Q:DFN<1
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999),HMPCNT=0
 S HMPSTS=$G(FILTER("status")) ;default = all problems
 D LIST^GMPLUTL2(.HMPPROB,DFN,HMPSTS)
 S HMPN=0 F  S HMPN=$O(HMPPROB(HMPN)) Q:(HMPN<1)!(HMPCNT'<MAX)  D
 . S X=$P(HMPPROB(HMPN),U,5) I X,(X<BEG)!(X>END) Q  ;onset
 . S X=+HMPPROB(HMPN) K HMPITM ;ien
 . D EN1(X,.HMPITM),XML(.HMPITM)
 . S HMPCNT=HMPCNT+1
 I $P($G(^DPT(DFN,0)),U,2)="F" D WV(.HMPITM),XML(.HMPITM):$D(HMPITM) ;ICR 10035 DE2818 ASF 11/2/15
 Q
 ;
EN1(ID,PROB) ; -- return a problem in PROB("attribute")=value
 N HMPL,X,I,J K PROB
 S ID=+$G(ID) Q:ID<1  ;invalid ien
 D DETAIL^GMPLUTL2(ID,.HMPL) Q:'$D(HMPL)  ;doesn't exist
 S PROB("id")=ID ;,PROB("lexiconID")=+X1 ;SNOMED?
 S PROB("name")=$G(HMPL("NARRATIVE"))
 S X=$G(HMPL("MODIFIED")) S:$L(X) PROB("updated")=$$DATE(X)
 S PROB("icd")=$G(HMPL("DIAGNOSIS"))
 S X=$G(HMPL("STATUS")) S:$L(X) PROB("status")=$E(X)_U_X
 S X=$G(HMPL("HISTORY"))  S:$L(X) PROB("history")=$E(X)_U_X
 S X=$G(HMPL("PRIORITY")) S:$L(X) PROB("acuity")=$E(X)_U_X
 S X=$G(HMPL("ONSET")) S:$L(X) PROB("onset")=$$DATE(X)
 S X=$$GET1^DIQ(9000011,ID_",",1.07,"I") S:X PROB("resolved")=X
 S X=$P($G(HMPL("ENTERED")),U)  S:$L(X) PROB("entered")=$$DATE(X)
 S X=$$GET1^DIQ(9000011,ID_",",1.02,"I")
 S:X="P" PROB("unverified")=0,PROB("removed")=0
 S:X="T" PROB("unverified")=1,PROB("removed")=0
 S:X="H" PROB("unverified")=0,PROB("removed")=1
 S X=$G(HMPL("SC")),X=$S(X="YES":1,X="NO":0,1:"")
 S:$L(X) PROB("sc")=X I $G(HMPL("EXPOSURE")) D   ;ao^rad^pgulf^hnc^mst^cv
 . S I=0 F  S I=$O(HMPL("EXPOSURE",I)) Q:I<1  D
 .. S X=$G(HMPL("EXPOSURE",I))
 .. S PROB("exposure",I)=$$EXP(X)
 S X=$G(HMPL("PROVIDER")) S:$L(X) PROB("provider")=$$GET1^DIQ(9000011,ID_",",1.05,"I")_U_X
 S X=$$GET1^DIQ(9000011,ID_",",1.06) S:$L(X) PROB("service")=X
 S X=$G(HMPL("CLINIC")) S:$L(X) PROB("location")=X
 S X=+$$GET1^DIQ(9000011,ID_",",.06,"I")
 S:X PROB("facility")=$$STA^XUAF4(X)_U_$P($$NS^XUAF4(X),U)
 I 'X S PROB("facility")=$$FAC^HMPD ;local stn#^name
CMT ; comments
 Q:'$G(HMPL("COMMENT"))
 S I=0 F  S I=$O(HMPL("COMMENT",I)) Q:I<1  D
 . S X=$G(HMPL("COMMENT",I))
 . S PROB("comment",I)=$$DATE($P(X,U))_U_$P(X,U,2,3)
 . ; = date ^ name of author ^ text
 Q
 ;
WV(PROB,UPD) ; -- return a pregnancy log entry in PROB("attribute")=value
 N I,X0,Y K PROB
 S I=$O(^WV(790.05,"C",DFN,""),-1) Q:'I    ;last entry ICR 5772 DE2818 ASF 11/23/15
 S X0=$G(^WV(790.05,I,0)),Y=0
 ; status=YES, future due date (allow past 14 days)
 I $P(X0,U,3),$P(X0,U,4)'<$$FMADD^XLFDT(DT,-14) S Y=1
 I 'Y,'$G(UPD) Q
 ; continue if pregnant, or update requested
 S PROB("id")="WV",PROB("entered")=+X0
 S PROB("name")="Pregnancy",PROB("icd")="V22.2"
 ; PROB("problemType")=64572001            ;HITSP/Condition
 S PROB("status")=$S(Y:"A^ACTIVE",1:"I^INACTIVE")
 S PROB("resolved")=$P(X0,U,4)             ;due date
 S PROB("provider")=$$OUTPTPR^SDUTL3(DFN)  ;primary care
 S PROB("facility")=$$FAC^HMPD
 Q
 ;
DATE(X) ; -- Return internal form of date X
 N %DT,Y
 S %DT="" D ^%DT S:Y<1 Y=X
 Q Y
 ;
VA200(X) ; -- Return ien of New Person X
 N Y S Y=$S($L($G(X)):+$O(^VA(200,"B",X,0)),1:"") ;ICR 10060 DE2818 ASF 11/23/15
 Q Y
 ;
EXP(X) ; -- Return code for exposure name X
 N Y S Y="",X=$E($G(X))
 I X="A" S Y="AO"  ;agent orange
 I X="R" S Y="IR"  ;ionizing radiation
 I X="E" S Y="PG"  ;persian gulf
 I X="H" S Y="HNC" ;head/neck cancer
 I X="M" S Y="MST" ;military sexual trauma
 I X="C" S Y="CV"  ;combat vet
 I X="S" S Y="SHAD"
 Q Y
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(PROB) ; -- Return patient problem as XML in @HMP@(I)
 N ATT,I,X,Y,P,TAG
 D ADD("<problem>") S HMPTOTL=$G(HMPTOTL)+1
 S ATT="" F  S ATT=$O(PROB(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . I ATT="exposure" D  S Y="" Q
 .. S Y="<exposures>" D ADD(Y)
 .. S I=0 F  S I=$O(PROB(ATT,I)) Q:I<1  S X=$G(PROB(ATT,I)) S:$L(X) Y="<exposure value='"_X_"' />" D ADD(Y)
 .. D ADD("</exposures>")
 . I ATT="comment" D  S Y="" Q
 .. D ADD("<comments>")
 .. S I=0 F  S I=$O(PROB(ATT,I)) Q:I<1  S X=$G(PROB(ATT,I)) D
 ... S Y="<comment id='"_I
 ... S:$L($P(X,U,1)) Y=Y_"' entered='"_$P(X,U)
 ... S:$L($P(X,U,2)) Y=Y_"' enteredBy='"_$$ESC^HMPD($P(X,U,2))
 ... S:$L($P(X,U,3)) Y=Y_"' commentText='"_$$ESC^HMPD($P(X,U,3))
 ... S Y=Y_"' />" D ADD(Y)
 .. D ADD("</comments>")
 . S X=$G(PROB(ATT)),Y="" Q:'$L(X)
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^HMPD(X)_"' />" Q
 . I $L(X)>1 D  S Y=""
 .. S Y="<"_ATT_" "
 .. F P=1:1 S TAG=$P("code^name^Z",U,P) Q:TAG="Z"  I $L($P(X,U,P)) S Y=Y_TAG_"='"_$$ESC^HMPD($P(X,U,P))_"' "
 .. S Y=Y_"/>" D ADD(Y)
 D ADD("</problem>")
 Q
 ;
ADD(X) ; Add a line @HMP@(n)=X
 S HMPI=$G(HMPI)+1
 S @HMP@(HMPI)=X
 Q
