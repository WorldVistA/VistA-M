NHINVLRO ;SLC/MKB -- Laboratory extract by order/panel
 ;;1.0;NHIN;**1**;Oct 25, 2010;Build 11
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DPT                         10035
 ; ^LAB(60                67,91,10054
 ; ^LRO(69                       2407
 ; ^LR                            525
 ; DIQ                           2056
 ; LR7OR1,^TMP("LRRR",$J)        2503
 ; XUAF4                         2171
 ;
 ; ------------ Get results from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's lab results
 N NHSUB,NHIDT,NHI,NHT,NHITM,CMMT,LRDFN,LR0,X
 S DFN=+$G(DFN) Q:$G(DFN)<1
 S BEG=$G(BEG,1410101),END=$G(END,9999998),MAX=$G(MAX,999999)
 S LRDFN=$G(^DPT(DFN,"LR")),NHSUB="CH"
 K ^TMP("LRRR",$J,DFN)
 ;
 ; get result(s)
 I $G(ID)  D RR^LR7OR1(DFN,ID)
 I '$G(ID) D  ;no id, or accession format (no lab order)
 . S:$G(ID)'="" NHSUB=$P(ID,";"),(BEG,END)=9999999-$P(ID,";",2)
 . D RR^LR7OR1(DFN,,BEG,END,NHSUB,,,MAX)
 ;
 S NHSUB="" F  S NHSUB=$O(^TMP("LRRR",$J,DFN,NHSUB)) Q:NHSUB=""  D
 . S NHIDT=0 F  S NHIDT=$O(^TMP("LRRR",$J,DFN,NHSUB,NHIDT)) Q:NHIDT<1  I $O(^(NHIDT,0)) D
 .. I "CH^MI"'[NHSUB Q
 .. D SORT ;group accession by lab orders > NHLRO(panel,NHI)=data node
 .. S NHT="" F  S NHT=$O(NHLRO(NHT)) Q:NHT=""  D
 ... K NHITM,CMMT S X=$G(NHLRO(NHT))
 ... I $G(ID),ID'=$P(X,U,3) Q  ;single order only
 ... S NHITM("id")=$P(X,U,3),NHITM("order")=$P(X,U,1,2)
 ... S NHITM("type")=NHSUB,NHITM("status")="completed"
 ... S NHITM("collected")=9999999-NHIDT
 ... S LR0=$G(^LR(LRDFN,NHSUB,NHIDT,0))
 ... S NHITM("resulted")=$P(LR0,U,3),X=+$P(LR0,U,5) I X D  ;specimen
 .... N IENS,NHY S IENS=X_","
 .... D GETS^DIQ(61,IENS,".01:2",,"NHY")
 .... S NHITM("specimen")=$G(NHY(61,IENS,2))_U_$G(NHY(61,IENS,.01)) ;SNOMED^name
 .... S NHITM("sample")=$$GET1^DIQ(61,X_",",4.1) ;name
 ... S NHITM("groupName")=$P(LR0,U,6),X=+$P(LR0,U,14)
 ... S:X NHITM("facility")=$$STA^XUAF4(X)_U_$P($$NS^XUAF4(X),U)
 ... I 'X S NHITM("facility")=$$FAC^NHINV ;local stn#^name
 ... S NHI=0 F  S NHI=$O(NHLRO(NHT,NHI)) Q:NHI<1  D
 .... S X=$G(NHLRO(NHT,NHI))
 .... S:NHSUB="CH" NHITM("value",NHI)=$$CH(X)
 .... S:NHSUB="MI" NHITM("value",NHI)=$$MI(X)
 ... I $D(^TMP("LRRR",$J,DFN,NHSUB,NHIDT,"N")) M CMMT=^("N") S NHITM("comment")=$$STRING^NHINV(.CMMT)
 ... D XML(.NHITM)
 K ^TMP("LRRR",$J,DFN)
 Q
 ;
SORT ; -- return NHLRO(PANEL) = CPRS order# ^ panel/test name ^ Lab Order string
 ;               NHLRO(PANEL,NHI) = result node
 N X0,NUM,ORD,ODT,SN,T,T0,I,NHY,NHLRT K NHLRO
 S NHI=$O(^TMP("LRRR",$J,DFN,NHSUB,NHIDT,0)),X0=$G(^(NHI)) ;first
 S NUM=$P(X0,U,16),ORD=$P(X0,U,17),ODT=+$P(9999999-NHIDT,".")
 ; - build NHLRT list of result nodes for each test/panel
 I ORD S SN=0 F  S SN=$O(^LRO(69,"C",ORD,ODT,SN)) Q:SN<1  D  Q:$D(NHLRT)
 . I $G(ID),$P(ID,";",3)'=SN Q
 . S T=0 F  S T=+$O(^LRO(69,ODT,1,SN,2,T)) Q:T<1  D
 .. I $G(ID),T'=$P(ID,";",4) Q
 .. S T0=$G(^LRO(69,ODT,1,SN,2,T,0))
 .. ; is test/panel part of same accession?
 .. Q:$P(T0,U,5)'=+$P(NUM," ",3)
 .. Q:$$GET1^DIQ(68,$P(T0,U,4)_",",.09)'=$P(NUM," ")
 .. ; expand panel into unit tests
 .. K NHY D EXPAND(+T0,.NHY)
 .. S I=0 F  S I=$O(NHY(I)) Q:I<1  S NHLRT(I,+T0)="" ;NHLRT(test,panel)=""
 .. S NHLRO(+T0)=$P(T0,U,7)_U_$P($G(^LAB(60,+T0,0)),U)_U_ORD_";"_ODT_";"_SN_";"_T
 S:'$D(NHLRO) NHLRO(0)=$S(NHSUB="MI":"^MICROBIOLOGY^MI;",1:"^ACCESSION^CH;")_NHIDT ;no Lab Order
 ; - build NHLRO(panel#,NHI) = ^TMP node
 S NHI=0 F  S NHI=$O(^TMP("LRRR",$J,DFN,"CH",NHIDT,NHI)) Q:NHI<1  S X0=$G(^(NHI)) D
 . I '$D(NHLRT(+X0)) S NHLRO(0,NHI)=X0 Q  ;no Lab Order
 . S T=0 F  S T=$O(NHLRT(+X0,T)) Q:T<1  S NHLRO(T,NHI)=X0
 Q
 ;
EXPAND(TEST,ARAY) ;Expand a lab test panel [LR7OU1]
 ;TEST=Test ptr to file 60
 ;Expanded panel returned in ARAY(TEST)
 N INARAY
 D EX(TEST)
 M ARAY=INARAY
 Q
EX(TST) ;
 N J,X,SUB
 Q:'$D(^LAB(60,TST,0))  S SUB=$P(^(0),"^",5)
 I $L(SUB) S:'$D(INARAY(+TST)) INARAY(+TST)="" Q
 S J=0 F  S J=$O(^LAB(60,+TST,2,J)) Q:J<1  S X=^(J,0) D EX(+X)
 Q
 ;
ACC(NUM,ODT,SN) ; -- Return 1 or 0, if Specimen entry matches accession
 N T,T0,Y S Y=0
 S T=+$O(^LRO(69,ODT,1,SN,2,0)),T0=$G(^(T,0))
 I $P(T0,U,5)=+$P(NUM," ",3),$$GET1^DIQ(68,$P(T0,U,4)_",",.09)=$P(NUM," ") S Y=1
 Q Y
 ;
CH(X0) ; -- return a Chemistry result as:
 ;   id^test^result^interpretation^units^low^high^loinc^vuid
 ;   Expects X0=^TMP("LRRR",$J,DFN,"CH",NHIDT,NHI),LRDFN
 N X,Y,NODE,LOINC
 S NODE=$G(^LR(LRDFN,"CH",NHIDT,NHI))
 S X=$P($G(^LAB(60,+X0,0)),U)
 S Y="CH;"_NHIDT_";"_NHI_U_X_U_$P(X0,U,2,4)
 S X=$P(X0,U,5) I $L(X),X["-" S X=$TR(X,"- ","^"),$P(Y,U,6,7)=X
 S X=$P($P(NODE,U,3),"!",3) S:X LOINC=$$GET1^DIQ(95.3,X_",",.01)
 I '$G(LOINC) S X=+$P(X0,U,19) S:X LOINC=$$LOINC(+X0,X)
 S $P(Y,U,8,9)=$G(LOINC)_U_$$VUID^NHINV(+$G(LOINC),95.3)
 Q Y
 ;
LOINC(TEST,SPEC) ; -- Look up LOINC code, if not mapped
 N Y,LAM,NHIN,IENS S Y=""
 S TEST=+$G(TEST),SPEC=+$G(SPEC)
 S LAM=$G(^LAB(60,TEST,64)),LAM=$S($P(LAM,U,2):$P(LAM,U,2),1:+LAM)
 D GETS^DIQ(64.01,SPEC_","_LAM_",","30*",,"NHIN")
 S IENS=$O(NHIN(64.02,"")) S:IENS Y=$G(NHIN(64.02,IENS,4))
 S:'Y Y=$$GET1^DIQ(60.01,SPEC_","_TEST_",",95.3)
 Q Y
 ;
MI(X0) ; -- return a Microbiology result as:
 ;   id^test^result^interpretation^units
 ;   Expects X0=^TMP("LRRR",$J,DFN,"MI",NHIDT,NHI)
 N Y S Y=""
 S:$L($P(X0,U))>1 Y="MI;"_NHIDT_";"_NHI_U_$P(X0,U,1,4)
 Q Y
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(LAB) ; -- Return result as XML in @NHIN@(#)
 N ATT,X,Y,I,J,P,NAMES,TAG
 D ADD("<panel>") S NHINTOTL=$G(NHINTOTL)+1
 S ATT="" F  S ATT=$O(LAB(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . I $O(LAB(ATT,0)) D  S Y="" Q
 .. D ADD("<"_ATT_"s>")
 .. I ATT="value" S NAMES="id^test^result^interpretation^units^low^high^loinc^vuid^Z"
 .. E  S NAMES="code^name^Z"
 .. S I=0 F  S I=$O(LAB(ATT,I)) Q:I<1  D
 ... S X=$G(LAB(ATT,I)),Y="<"_ATT_" "_$$LOOP_"/>" D ADD(Y)
 .. D ADD("</"_ATT_"s>")
 . S X=$G(LAB(ATT)),Y="" Q:'$L(X)
 . I ATT="comment" S Y="<"_ATT_" xml:space='preserve'>"_$$ESC^NHINV(X)_"</"_ATT_">" Q
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^NHINV(X)_"' />" Q
 . I $L(X)>1 S NAMES="code^name^Z",Y="<"_ATT_" "_$$LOOP_"/>"
 D ADD("</panel>")
 Q
 ;
LOOP() ; -- build sub-items string from NAMES and X
 N STR,P,TAG S STR=""
 F P=1:1 S TAG=$P(NAMES,U,P) Q:TAG="Z"  I $L($P(X,U,P)) S STR=STR_TAG_"='"_$$ESC^NHINV($P(X,U,P))_"' "
 Q STR
 ;
ADD(X) ; -- Add a line @NHIN@(n)=X
 S NHINI=$G(NHINI)+1
 S @NHIN@(NHINI)=X
 Q
