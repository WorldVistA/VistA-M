VPRDLRO ;SLC/MKB -- Lab extract by order/panel ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**2,5,7,11**;Sep 01, 2011;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DPT                         10035
 ; ^LAB(60                      10054
 ; ^LR                            525
 ; ^ORD(100.98)                   873
 ; ^VA(200)                     10060
 ; DIQ                           2056
 ; LR7OR1,^TMP("LRRR",$J)        2503
 ; LR7OU1                        2955
 ; LRPXAPIU                      4246
 ; ORQ1,^TMP("ORR",$J)           3154
 ; ORQ12,^TMP("ORGOTIT",$J)      5704
 ; ORX8                     2467,3071
 ; XUAF4                         2171
 ;
 ; ------------ Get data from VistA ------------
 ;
EN(DFN,BEG,END,MAX,IFN) ; -- find a patient's lab orders
 N ORLIST,ORDG,ORFLG,ORIGVIEW,ORDER,VPRN,VPRITM,VPRCNT,LRDFN,LRSUB,CDT
 S DFN=+$G(DFN) Q:DFN<1  ;invalid patient
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 S LRDFN=$G(^DPT(DFN,"LR")),LRSUB=$G(FILTER("type"),"CH")
 ;
 ; get one lab order's results
 I $G(IFN) D  G ENQ
 . N ORLST S ORLST=0,ORLIST=$H
 . S ORIGVIEW=2 ;get original view of order
 . D GET^ORQ12(+IFN,ORLIST,1) S VPRN=ORLST
 . D EN1(VPRN,.VPRITM),XML(.VPRITM)
 . K ^TMP("ORGOTIT",$J)
 ;
 ; get [all] lab orders with results
 S ORDG=+$O(^ORD(100.98,"B","LAB",0))
 S ORFLG=6    ;search by Released Orders, check collection time in loop
 S ORIGVIEW=2 ;get original view of order
 D EN^ORQ1(DFN_";DPT(",ORDG,ORFLG,,(BEG-20000),(END+20000),1) S VPRCNT=0
 S VPRN=0 F  S VPRN=$O(^TMP("ORR",$J,ORLIST,VPRN)) Q:VPRN<1  S ORDER=$G(^(VPRN)) D  Q:VPRCNT'<MAX
 . I $P($P(ORDER,U),";",2)>1 Q       ;skip order actions
 . I $P(ORDER,U,7)'="comp" Q         ;completed only -- want results
 . I $G(^OR(100,+ORDER,4))'[LRSUB Q  ;apply type filter
 . S CDT=$P(ORDER,U,4) I (CDT<BEG)!(CDT>END) Q
 . K VPRITM D EN1(VPRN,.VPRITM) Q:'$D(VPRITM)
 . D XML(.VPRITM) S VPRCNT=VPRCNT+1
ENQ ; end
 K ^TMP("ORR",$J),^TMP("VPRTEXT",$J),^TMP("LRRR",$J,DFN)
 Q
 ;
EN1(NUM,ORD) ; -- return an order in ORD("attribute")=value
 ;  from EN: expects ^TMP("ORR",$J,ORLIST,VPRN),LRDFN
 N ORPK,X0,IFN,OI,VPRSUB,VPRIDT,LR0,X,I,VPRL,VPRT
 K ORD,^TMP("VPRTEXT",$J)
 S X0=$G(^TMP("ORR",$J,ORLIST,NUM)),IFN=+X0
 S ORPK=$$PKGID^ORX8(+IFN) Q:'ORPK
 S ORD("id")=IFN,ORD("labOrderID")=ORPK
 S OI=$$OI^ORX8(+IFN),ORD("name")=$P(OI,U,2)
 S ORD("order")=+IFN_U_$P(OI,U,2)
 S ORD("ordered")=$P(X0,U,3)
 ;
 K ^TMP("LRRR",$J,DFN) D RR^LR7OR1(DFN,ORPK)
 S VPRSUB=$P(ORPK,";",4) Q:VPRSUB=""  Q:"CH^MI"'[VPRSUB
 S VPRIDT=$P(ORPK,";",5) Q:VPRIDT<1  Q:'$O(^TMP("LRRR",$J,DFN,VPRSUB,VPRIDT,0))
 ; I $G(ID),$P(ID,";",1,3)'=$P($P(X,U,3),";",1,3) Q  ;single order/specimen
 S ORD("type")=VPRSUB,ORD("status")="completed"
 S ORD("collected")=9999999-VPRIDT
 S LR0=$G(^LR(LRDFN,VPRSUB,VPRIDT,0))
 S X=$P(LR0,U,3) I VPRSUB="MI",'X S ORD("status")="incomplete"
 S ORD("resulted")=X,X=+$P(LR0,U,5) I X D  ;specimen
 . N IENS,VPRY S IENS=X_","
 . D GETS^DIQ(61,IENS,".01:2",,"VPRY")
 . S ORD("specimen")=$G(VPRY(61,IENS,2))_U_$G(VPRY(61,IENS,.01)) ;SNOMED^name
 . S ORD("sample")=$$GET1^DIQ(61,X_",",4.1) ;name
 S ORD("groupName")=$P(LR0,U,6),X=+$P(LR0,U,14)
 S:X ORD("facility")=$$STA^XUAF4(X)_U_$P($$NS^XUAF4(X),U)
 I 'X S ORD("facility")=$$FAC^VPRD ;local stn#^name
 S I=$S(VPRSUB="CH":10,1:7),X=+$P(LR0,U,I)
 S:X ORD("provider")=X_U_$P($G(^VA(200,X,0)),U)_U_$$PROVSPC^VPRD(X)
 ;
 K VPRT D EXPAND^LR7OU1(+$P(OI,U,3),.VPRT) ;get individual tests
 S VPRL=0 F  S VPRL=$O(^TMP("LRRR",$J,DFN,VPRSUB,VPRIDT,VPRL)) Q:VPRL<1  S X=$G(^(VPRL)) D
 . Q:'$D(VPRT(+X))  ;test not in order/panel
 . S:VPRSUB="CH" ORD("value",VPRL)=$$CH(X)
 . S:VPRSUB="MI" ORD("value",VPRL)=$$MI(X)
 I $D(^TMP("LRRR",$J,DFN,VPRSUB,VPRIDT,"N")) K CMMT M CMMT=^("N") S ORD("comment")=$$STRING^VPRD(.CMMT)
 Q
 ;
CH(X0) ; -- return a Chemistry result as:
 ;   id^test^result^interpretation^units^low^high^loinc^vuid^performingLab
 ;   Expects X0=^TMP("LRRR",$J,DFN,"CH",VPRIDT,VPRL),LRDFN
 N P,X,Y,NODE,LOINC
 S P=$$LRDN^LRPXAPIU(+X0) ;get LR node# for test
 S NODE=$G(^LR(LRDFN,"CH",VPRIDT,P))
 S X=$P($G(^LAB(60,+X0,0)),U)
 S Y="CH;"_VPRIDT_";"_P_U_X_U_$P(X0,U,2,4)
 S X=$P(X0,U,5) I $L(X),X["-" S X=$TR(X,"- ","^"),$P(Y,U,6,7)=X
 S X=$P($P(NODE,U,3),"!",3) S:X LOINC=$$GET1^DIQ(95.3,X_",",.01)
 S:$G(LOINC) $P(Y,U,8,9)=LOINC_U_$$VUID^VPRD(+LOINC,95.3)
 S X=+$P(NODE,U,9) S:X $P(Y,U,10)=$$NAME^XUAF4(X) ;performing lab
 Q Y
 ;
MI(X0) ; -- return a Microbiology result as:
 ;   id^test^result^interpretation^units
 ;   Expects X0=^TMP("LRRR",$J,DFN,"MI",VPRIDT,VPRL)
 N Y S Y=""
 S:$L($P(X0,U))>1 Y="MI;"_VPRIDT_";"_VPRL_U_$P(X0,U,1,4)
 Q Y
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(LAB) ; -- Return result as XML in @VPR@(#)
 N ATT,X,Y,I,J,P,NAMES,TAG
 D ADD("<panel>") S VPRTOTL=$G(VPRTOTL)+1
 S ATT="" F  S ATT=$O(LAB(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . I $O(LAB(ATT,0)) D  S Y="" Q
 .. D ADD("<"_ATT_"s>")
 .. I ATT="value" S NAMES="id^test^result^interpretation^units^low^high^loinc^vuid^performingLab^Z"
 .. E  S NAMES="code^name^Z"
 .. S I=0 F  S I=$O(LAB(ATT,I)) Q:I<1  D
 ... S X=$G(LAB(ATT,I)),Y="<"_ATT_" "_$$LOOP_"/>" D ADD(Y)
 .. D ADD("</"_ATT_"s>")
 . S X=$G(LAB(ATT)),Y="" Q:'$L(X)
 . I ATT="comment" S Y="<"_ATT_" xml:space='preserve'>"_$$ESC^VPRD(X)_"</"_ATT_">" Q
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^VPRD(X)_"' />" Q
 . S NAMES="code^name"_$S(ATT="provider":U_$$PROVTAGS^VPRD,1:"")_"^Z"
 . I $L(X)>1 S Y="<"_ATT_" "_$$LOOP_"/>"
 D ADD("</panel>")
 Q
 ;
LOOP() ; -- build sub-items string from NAMES and X
 N STR,P,TAG S STR=""
 F P=1:1 S TAG=$P(NAMES,U,P) Q:TAG="Z"  I $L($P(X,U,P)) S STR=STR_TAG_"='"_$$ESC^VPRD($P(X,U,P))_"' "
 Q STR
 ;
ADD(X) ; -- Add a line @VPR@(n)=X
 S VPRI=$G(VPRI)+1
 S @VPR@(VPRI)=X
 Q
