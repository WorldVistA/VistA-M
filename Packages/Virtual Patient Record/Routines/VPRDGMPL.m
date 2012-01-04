VPRDGMPL ;SLC/MKB -- Problem extract ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;;Sep 01, 2011;Build 12
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^AUPNPROB                     5703
 ; ^VA(200                      10060
 ; %DT                          10003
 ; DIQ                           2056
 ; GMPLUTL2                      2741
 ; XUAF4                         2171
 ;
 ; ------------ Get problems from VistA ------------
 ;
EN(DFN,BEG,END,MAX,IFN) ; -- find patient's problems
 N VPRPROB,VPRN,VPRITM,VPRCNT,X
 ;
 ; get one problem
 I $G(IFN) D EN1(IFN,.VPRITM),XML(.VPRITM) Q
 ;
 ; get all patient problems
 S DFN=+$G(DFN) Q:DFN<1
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999),VPRCNT=0
 D LIST^GMPLUTL2(.VPRPROB,DFN,"") ;all problems
 S VPRN=0 F  S VPRN=$O(VPRPROB(VPRN)) Q:(VPRN<1)!(VPRCNT'<MAX)  D
 . S X=$P(VPRPROB(VPRN),U,5) I X,(X<BEG)!(X>END) Q  ;onset
 . S X=+VPRPROB(VPRN) K VPRITM ;ien
 . D EN1(X,.VPRITM),XML(.VPRITM)
 . S VPRCNT=VPRCNT+1
 Q
 ;
EN1(ID,PROB) ; -- return a problem in PROB("attribute")=value
 N VPRL,X,I,J K PROB
 S ID=+$G(ID) Q:ID<1  ;invalid ien
 D DETAIL^GMPLUTL2(ID,.VPRL) Q:'$D(VPRL)  ;doesn't exist
 S PROB("id")=ID ;,PROB("lexiconID")=+X1 ;SNOMED?
 S PROB("name")=$G(VPRL("NARRATIVE"))
 S X=$G(VPRL("MODIFIED")) S:$L(X) PROB("updated")=$$DATE(X)
 S PROB("icd")=$G(VPRL("DIAGNOSIS"))
 S X=$G(VPRL("STATUS")) S:$L(X) PROB("status")=$E(X)_U_X
 S X=$G(VPRL("HISTORY"))  S:$L(X) PROB("history")=$E(X)_U_X
 S X=$G(VPRL("PRIORITY")) S:$L(X) PROB("acuity")=$E(X)_U_X
 S X=$G(VPRL("ONSET")) S:$L(X) PROB("onset")=$$DATE(X)
 S X=$$GET1^DIQ(9000011,ID_",",1.07,"I") S:X PROB("resolved")=X
 S X=$P($G(VPRL("ENTERED")),U)  S:$L(X) PROB("entered")=$$DATE(X)
 S X=$$GET1^DIQ(9000011,ID_",",1.02,"I")
 S:X="P" PROB("unverified")=0,PROB("removed")=0
 S:X="T" PROB("unverified")=1,PROB("removed")=0
 S:X="H" PROB("unverified")=0,PROB("removed")=1
 S X=$G(VPRL("SC")),X=$S(X="YES":1,X="NO":0,1:"")
 S:$L(X) PROB("sc")=X I $G(VPRL("EXPOSURE")) D   ;ao^rad^pgulf^hnc^mst^cv
 . S I=0 F  S I=$O(VPRL("EXPOSURE",I)) Q:I<1  D
 .. S X=$G(VPRL("EXPOSURE",I))
 .. S PROB("exposure",I)=$$EXP(X)
 S X=$G(VPRL("PROVIDER")) S:$L(X) PROB("provider")=$$VA200(X)_U_X
 S X=$$GET1^DIQ(9000011,ID_",",1.06) S:$L(X) PROB("service")=X
 S X=$G(VPRL("CLINIC")) S:$L(X) PROB("location")=X
 S X=+$$GET1^DIQ(9000011,ID_",",.06,"I")
 S:X PROB("facility")=$$STA^XUAF4(X)_U_$P($$NS^XUAF4(X),U)
 I 'X S PROB("facility")=$$FAC^VPRD ;local stn#^name
CMT ; comments
 Q:'$G(VPRL("COMMENT"))
 S I=0 F  S I=$O(VPRL("COMMENT",I)) Q:I<1  D
 . S X=$G(VPRL("COMMENT",I))
 . S PROB("comment",I)=$$DATE($P(X,U))_U_$P(X,U,2,3)
 . ; = date ^ name of author ^ text
 Q
 ;
DATE(X) ; -- Return internal form of date X
 N %DT,Y
 S %DT="" D ^%DT S:Y<1 Y=X
 Q Y
 ;
VA200(X) ; -- Return ien of New Person X
 N Y S Y=$S($L($G(X)):+$O(^VA(200,"B",X,0)),1:"")
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
XML(PROB) ; -- Return patient problem as XML in @VPR@(I)
 N ATT,I,X,Y,P,TAG
 D ADD("<problem>") S VPRTOTL=$G(VPRTOTL)+1
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
 ... S:$L($P(X,U,2)) Y=Y_"' enteredBy='"_$$ESC^VPRD($P(X,U,2))
 ... S:$L($P(X,U,3)) Y=Y_"' commentText='"_$$ESC^VPRD($P(X,U,3))
 ... S Y=Y_"' />" D ADD(Y)
 .. D ADD("</comments>")
 . S X=$G(PROB(ATT)),Y="" Q:'$L(X)
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^VPRD(X)_"' />" Q
 . I $L(X)>1 D  S Y=""
 .. S Y="<"_ATT_" "
 .. F P=1:1 S TAG=$P("code^name^Z",U,P) Q:TAG="Z"  I $L($P(X,U,P)) S Y=Y_TAG_"='"_$$ESC^VPRD($P(X,U,P))_"' "
 .. S Y=Y_"/>" D ADD(Y)
 D ADD("</problem>")
 Q
 ;
ADD(X) ; Add a line @VPR@(n)=X
 S VPRI=$G(VPRI)+1
 S @VPR@(VPRI)=X
 Q
