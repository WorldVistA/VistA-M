VPRDIB ;SLC/MKB -- Integrated Billing (insurance) ;3/14/12  09:01
 ;;1.0;VIRTUAL PATIENT RECORD;**1,5**;Sep 01,2011;Build 21
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ;   IBBAPI                      4419
 ;
 ;
 ; ------------ Get data from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's insurance data
 ; [END,ID not currently used]
 N X,I,VPRX,VPRITM,VPRCNT,VPRINS,VPRDT,VPRSTS
 S DFN=+$G(DFN) Q:DFN<1
 S MAX=$G(MAX,9999),VPRDT=DT
 ; $G(BEG),BEG>2000000 S VPRDT=BEG
 S VPRSTS=$G(FILTER("status"),"RB")
 I VPRSTS["A" S VPRDT="" ;no date if requesting inactive policies
 ;
 ; get one policy
 ;I $G(ID) D EN1(ID,.VPRITM),XML(.VPRITM) Q
 ;
 ; get all policies
 S X=$$INSUR^IBBAPI(DFN,VPRDT,VPRSTS,.VPRX,"*") Q:X<1
 S (I,VPRCNT)=0 F  S I=$O(VPRX("IBBAPI","INSUR",I)) Q:I<1  D  Q:VPRCNT'<MAX
 . M VPRINS=VPRX("IBBAPI","INSUR",I) K VPRITM
 . I $G(ID),DFN'=+ID!(+VPRINS(1)'=$P(ID,";",2))!(+VPRINS(8)'=$P(ID,";",3)) Q
 . S VPRITM("id")=DFN_";"_+VPRINS(1)_";"_+VPRINS(8) ; = DFN;COMPANY;POLICY
 . S VPRITM("company")=VPRINS(1),X=VPRINS(2)
 . F J=23,24,3,4,5 S X=X_U_VPRINS(J)
 . S VPRITM("company","address")=X
 . S X=VPRINS(6) S:$L(X) VPRITM("company","telecom")=$$FORMAT(X)
 . S VPRITM("effectiveDate")=VPRINS(10)
 . S VPRITM("expirationDate")=VPRINS(11)
 . S VPRITM("groupName")=$P(VPRINS(8),U,2)
 . S VPRITM("groupNumber")=VPRINS(18)
 . S X=VPRINS(21),VPRITM("insuranceType")=X
 . ; VPRITM("insuranceType")=$$GET^XPAR(355.1,+X_",",.03) ;Maj Catg
 . S VPRITM("relationship")=$P(VPRINS(19),U,2)
 . S VPRITM("subscriber")=VPRINS(14)_U_VPRINS(13)
 . ; VPRITM("subscriber","address")
 . ; VPRITM("subscriber","telecom")
 . ; VPRITM("memberID")
 . S VPRITM("facility")=$$FAC^VPRD ;local stn#^name
 . D XML(.VPRITM) S VPRCNT=VPRCNT+1
 Q
 ;
FORMAT(X) ; -- enforce (xxx)xxx-xxxx phone format
 S X=$G(X) I X?1"("3N1")"3N1"-"4N.E Q X
 N P,N,I,Y S P=""
 F I=1:1:$L(X) S N=$E(X,I) I N=+N S P=P_N
 S:$L(P)<10 P=$E("0000000000",1,10-$L(P))_P
 S Y=$S(P:"("_$E(P,1,3)_")"_$E(P,4,6)_"-"_$E(P,7,10),1:"")
 Q Y
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(ITEM) ; -- Return patient data as XML in @VPR@(n)
 ; as <element code='123' displayName='ABC' />
 N ATT,X,Y,I,SUB
 D ADD("<insurancePolicy>") S VPRTOTL=$G(VPRTOTL)+1
 S ATT="" F  S ATT=$O(ITEM(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . S X=$G(ITEM(ATT)),Y="" Q:'$L(X)
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^VPRD(X)
 . I $L(X,"^")>1 S Y="<"_ATT_" code='"_$P(X,U)_"' name='"_$$ESC^VPRD($P(X,U,2))
 . S SUB=$O(ITEM(ATT,"")) I SUB="" S Y=Y_"' />" Q
 . S Y=Y_"' >" D ADD(Y) S X=$G(ITEM(ATT,SUB))
 . I SUB="address" D ADDR(X)
 . I SUB="telecom" D PHONE(X)
 . S Y="</"_ATT_">"
 D ADD("</insurancePolicy>")
 Q
 ;
ADDR(X) ; -- XML address node from X=street1^st2^st3^city^state^zip
 N I,Y Q:$L(X)'>5  ;no data
 S Y="<address"
 F I=1,2,3 I $L($P(X,U,I)) S Y=Y_" streetLine"_I_"='"_$$ESC^VPRD($P(X,U,I))_"'"
 I $L($P(X,U,4)) S Y=Y_" city='"_$$ESC^VPRD($P(X,U,4))_"'"
 I $L($P(X,U,5)) S Y=Y_" stateProvince='"_$P(X,U,5)_"'"
 I $L($P(X,U,6)) S Y=Y_" postalCode='"_$P(X,U,6)_"'"
 S Y=Y_" />" D ADD(Y)
 Q
 ;
PHONE(X) ; -- XML telecom node from X=home^cell^work numbers
 N I,Y Q:$L(X)'>2  ;no data
 D ADD("<telecomList>")
 I $L($P(X,U,1)) S Y="<telecom usageType='H' value='"_$P(X,U,1)_"' />" D ADD(Y)
 I $L($P(X,U,2)) S Y="<telecom usageType='MC' value='"_$P(X,U,2)_"' />" D ADD(Y)
 I $L($P(X,U,3)) S Y="<telecom usageType='WP' value='"_$P(X,U,3)_"' />" D ADD(Y)
 D ADD("</telecomList>")
 Q
 ;
ADD(X) ; Add a line @VPR@(n)=X
 S VPRI=$G(VPRI)+1
 S @VPR@(VPRI)=X
 Q
