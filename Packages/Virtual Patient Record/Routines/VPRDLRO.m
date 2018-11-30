VPRDLRO ;SLC/MKB -- Laboratory extract by order/panel ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**2,5**;Sep 01, 2011;Build 21
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DPT                         10035
 ; ^LAB(60                      10054
 ; ^LAB(61                        524
 ; ^LRO(69                       2407
 ; ^LR                            525
 ; ^PXRMINDX                     4290
 ; DIQ                           2056
 ; LR7OR1,^TMP("LRRR",$J)        2503
 ; LR7OU1                        2955
 ; LRPXAPIU                      4246
 ; ORX8                          3071
 ; XUAF4                         2171
 ;
 ; ------------ Get results from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's lab results
 N VPRSUB,VPRIDT,VPRN,VPRLRO,VPRT,VPRITM,CMMT,LRDFN,LR0,X,I,VPRPL
 S DFN=+$G(DFN) Q:$G(DFN)<1
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 S LRDFN=$G(^DPT(DFN,"LR")),VPRSUB=$G(FILTER("type"),"CH")
 K ^TMP("LRRR",$J,DFN)
 ;
 ; get result(s)
 I $G(ID)  D RR^LR7OR1(DFN,ID)
 I '$G(ID) D  ;no id, or accession format (no lab order)
 . S:$G(ID)'="" VPRSUB=$P(ID,";"),(BEG,END)=9999999-$P(ID,";",2)
 . D RR^LR7OR1(DFN,,BEG,END,VPRSUB,,,MAX)
 ;
 S VPRSUB="" F  S VPRSUB=$O(^TMP("LRRR",$J,DFN,VPRSUB)) Q:VPRSUB=""  D
 . S VPRIDT=0 F  S VPRIDT=$O(^TMP("LRRR",$J,DFN,VPRSUB,VPRIDT)) Q:VPRIDT<1  I $O(^(VPRIDT,0)) D
 .. I "CH^MI"'[VPRSUB Q
 .. ;group accession by lab orders > VPRLRO(panel,VPRN)=data node
 .. D SORT:VPRSUB="CH",PXRM:VPRSUB="MI"
 .. S VPRT="" F  S VPRT=$O(VPRLRO(VPRT)) Q:VPRT=""  D
 ... K VPRITM,CMMT,VPRPL S X=$G(VPRLRO(VPRT))
 ... I $G(ID),$P(ID,";",1,3)'=$P($P(X,U,3),";",1,3) Q  ;single order/specimen
 ... S VPRITM("id")=$P(X,U,3),VPRITM("order")=$P(X,U,1,2)
 ... S VPRITM("type")=VPRSUB,VPRITM("status")="completed"
 ... S VPRITM("collected")=9999999-VPRIDT
 ... S LR0=$G(^LR(LRDFN,VPRSUB,VPRIDT,0))
 ... S X=$P(LR0,U,3) I VPRSUB="MI",'X S VPRITM("status")="incomplete"
 ... S VPRITM("resulted")=X,X=+$P(LR0,U,5) I X D  ;specimen
 .... N IENS,VPRY S IENS=X_","
 .... D GETS^DIQ(61,IENS,".01:2",,"VPRY")
 .... S VPRITM("specimen")=$G(VPRY(61,IENS,2))_U_$G(VPRY(61,IENS,.01)) ;SNOMED^name
 .... S VPRITM("sample")=$$GET1^DIQ(61,X_",",4.1) ;name
 ... S VPRITM("groupName")=$P(LR0,U,6),X=+$P(LR0,U,14)
 ... S:X VPRITM("facility")=$$STA^XUAF4(X)_U_$P($$NS^XUAF4(X),U)
 ... I 'X S VPRITM("facility")=$$FAC^VPRD ;local stn#^name
 ... S I=$S(VPRSUB="CH":10,1:7),X=+$P(LR0,U,I)
 ... S:X VPRITM("provider")=X_U_$P($G(^VA(200,X,0)),U)_U_$$PROVSPC^VPRD(X)
 ... S VPRN=0 F  S VPRN=$O(VPRLRO(VPRT,VPRN)) Q:VPRN<1  D
 .... S X=$G(VPRLRO(VPRT,VPRN))
 .... S:VPRSUB="CH" VPRITM("value",VPRN)=$$CH(X)
 .... S:VPRSUB="MI" VPRITM("value",VPRN)=$$MI(X)
 ... I $D(^TMP("LRRR",$J,DFN,VPRSUB,VPRIDT,"N")) M CMMT=^("N") S VPRITM("comment")=$$STRING^VPRD(.CMMT)
 ... D XML(.VPRITM)
 K ^TMP("LRRR",$J,DFN)
 Q
 ;
SORT ; -- return VPRLRO(PANEL) = CPRS order# ^ panel/test name ^ Lab Order string
 ;               VPRLRO(PANEL,VPRN) = result node
 N VPRP,X0,NUM,ORD,ODT,SN,T,T0,ORIFN,I,VPRY,VPRLRT K VPRLRO
 S VPRP=$O(^TMP("LRRR",$J,DFN,VPRSUB,VPRIDT,0)),X0=$G(^(VPRP)) ;first
 S NUM=$P(X0,U,16),ORD=$P(X0,U,17),ODT=+$P(9999999-VPRIDT,".")
 ; - build VPRLRT list of result nodes for each test/panel
 I ORD S SN=0 F  S SN=$O(^LRO(69,"C",ORD,ODT,SN)) Q:SN<1  D  Q:$D(VPRLRT)
 . I $G(ID),$P(ID,";",3)'=SN Q
 . S T=0 F  S T=+$O(^LRO(69,ODT,1,SN,2,T)) Q:T<1  D
 .. I $G(ID),$P(ID,";",4),T'=$P(ID,";",4) Q
 .. S T0=$G(^LRO(69,ODT,1,SN,2,T,0))
 .. ; is test/panel part of same accession?
 .. S ORIFN=+$P(T0,U,7)
 .. Q:VPRIDT'=$P($$PKGID^ORX8(ORIFN),";",5)
 .. ; expand panel into unit tests
 .. K VPRY D EXPAND^LR7OU1(+T0,.VPRY)
 .. S I=0 F  S I=$O(VPRY(I)) Q:I<1  S VPRLRT(I,+T0)="" ;VPRLRT(test,panel)=""
 .. S VPRLRO(+T0)=$P(T0,U,7)_U_$P($G(^LAB(60,+T0,0)),U)_U_ORD_";"_ODT_";"_SN_";"_T
 S:'$D(VPRLRO) VPRLRO(0)=$S(VPRSUB="MI":"^MICROBIOLOGY^MI;",1:"^ACCESSION^CH;")_VPRIDT ;no Lab Order
 ; - build VPRLRO(panel#,VPRN) = ^TMP node
 S VPRP=0 F  S VPRP=$O(^TMP("LRRR",$J,DFN,"CH",VPRIDT,VPRP)) Q:VPRP<1  S X0=$G(^(VPRP)) D
 . S VPRN=$$LRDN^LRPXAPIU(+X0)
 . I '$D(VPRLRT(+X0)) S VPRLRO(0,VPRN)=X0 Q  ;no Lab Order
 . S T=0 F  S T=$O(VPRLRT(+X0,T)) Q:T<1  S VPRLRO(T,VPRN)=X0
 Q
 ;
PXRM ; -- ck Rem Index for MI ordered test >> VPRLRO(0)=^test^MI;invdate
 N CDT,PXI,DA,LRT K VPRLRO
 S CDT=9999999-VPRIDT,PXI=$O(^PXRMINDX(63,"PDI",DFN,CDT,"M;T;0"))
 I PXI?1"M;T;"1.N S DA=+$P(PXI,";",3),LRT=$P($G(^LAB(60,DA,0)),U)
 S VPRLRO(0)=U_$S($L($G(LRT)):LRT,1:"MICROBIOLOGY")_"^MI;"_VPRIDT
 Q
 ;
CH(X0) ; -- return a Chemistry result as:
 ;   id^test^result^interpretation^units^low^high^loinc^vuid^performingLab
 ;   Expects X0=^TMP("LRRR",$J,DFN,"CH",VPRIDT,VPRP),VPRN,LRDFN
 N X,Y,NODE,LOINC
 S NODE=$G(^LR(LRDFN,"CH",VPRIDT,VPRN))
 S X=$P($G(^LAB(60,+X0,0)),U)
 S Y="CH;"_VPRIDT_";"_VPRN_U_X_U_$P(X0,U,2,4)
 S X=$P(X0,U,5) I $L(X),X["-" S X=$TR(X,"- ","^"),$P(Y,U,6,7)=X
 S X=$P($P(NODE,U,3),"!",3) S:X LOINC=$$GET1^DIQ(95.3,X_",",.01)
 S:$G(LOINC) $P(Y,U,8,9)=LOINC_U_$$VUID^VPRD(+LOINC,95.3)
 S X=+$P(NODE,U,9) S:X $P(Y,U,10)=$$NAME^XUAF4(X) ;performing lab
 Q Y
 ;
MI(X0) ; -- return a Microbiology result as:
 ;   id^test^result^interpretation^units
 ;   Expects X0=^TMP("LRRR",$J,DFN,"MI",VPRIDT,VPRP)
 N Y S Y=""
 S:$L($P(X0,U))>1 Y="MI;"_VPRIDT_";"_VPRN_U_$P(X0,U,1,4)
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
