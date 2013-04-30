EDPLAB ;SLC/MKB - EDIS lab result utilities ;4/25/12 12:51pm
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
EN(EDPRES,PARAM) ; -- Return lab results as XML in EDPRES
 ; Required:  "patient" identifier (DFN)
 ; Optional:  "start"-"stop" date range
 ;            "total" - total number of accessions
 ;            "list" - 1 for list of testID's only
 ;            "testID"s for result history of test(s)
 ;
 K @EDPRES
 ;D ADD^EDPHIST("<results>")
 ;N ARRAY,EDPARR S ARRAY=$NA(EDPARR("results",1))
 N ARRAY,EDPARR S ARRAY=$NA(^TMP("EDPLAB",$J,"results",1)) K @ARRAY
 ;
 ;
 ; validate input parameters
 N DFN,TEST,TESTIDS,BEG,END,MAX,X,I,LIST
 S DFN=+$$VAL("patient") I DFN<1 D  G ENQ
 . ;D XML^EDPX("<error msg='Missing or invalid patient identifier' />")
 . S @ARRAY@("error",1,"msg")="Missing or invalid patient identifier"
 ;S I=0 F  S I=$O(PARAM("testID",I)) Q:I<1  S X=+PARAM("testID",I),TEST(X)=""
 S TESTIDS=$$VAL("testID")
 I $L(TESTIDS) D
 .F I=1:1 S X=$P(TESTIDS,U,I) Q:'X  D
 ..I X S TEST(X)=""
 ;
 ; get optional date range, max# accessions
 S BEG=$$VAL("start"),END=$$VAL("stop"),MAX=$$VAL("total"),LIST=$$VAL("list")
 I BEG,END,END<BEG N X S X=BEG,BEG=END,END=X  ;switch
 I END,$L(END,".")<2 S END=END_".24"
 ; search Lab for results
 N ACNT,ICNT,DONE,SUB,IDT,SEQ,MORE
 K ^TMP("LRRR",$J) D RR^LR7OR1(DFN,,BEG,END)
 S (ACNT,ICNT,DONE)=0
 S SUB="" F  S SUB=$O(^TMP("LRRR",$J,DFN,SUB)) G:SUB="" ENQ  D
 .; BWF 2/2/2012 - for now we are only returning CH (chemistry)
 .Q:SUB'="CH"
 .S IDT=0 F  S IDT=$O(^TMP("LRRR",$J,DFN,SUB,IDT)) Q:IDT<1  D  Q:DONE
 .. I $D(TEST) Q:'$D(TEST(IDT))
 .. S (MORE,SEQ)=0
 .. F  S SEQ=$O(^TMP("LRRR",$J,DFN,SUB,IDT,SEQ)) Q:SEQ<1  S X=$G(^(SEQ)) D
 ... K EDPX
 ... I '$G(LIST) S EDPX("id")=SUB_";"_IDT_";"_SEQ
 ... S MORE=1
 ... D TMP(.EDPX,DFN,SUB,IDT,SEQ,LIST) ;parse into EDPX("att")=value
 ... S ICNT=ICNT+1 M @ARRAY@("item",ICNT)=EDPX
 ... ;D ADDA^EDPHIST("item",.EDPX)
 .. S:MORE ACNT=ACNT+1 I $G(MAX),ACNT'<MAX S DONE=1
 Q
 ;
ENQ ;end
 D TOXMLG^EDPXML(ARRAY,EDPRES)
 Q
 ;
ORD(EDPRES,PARAM) ; -- Return results history for lab orders
 K EDPRES ;D ADD^EDPHIST("<results>")
 D ADD^EDPHIST("<results>")
 N ARRAY,EDPARR S ARRAY=$NA(EDPARR("results",1))
 ;
 ; validate input parameters
 N DFN,LOG,IN,MAX
 S DFN=+$$VAL("patient") I DFN<1 D  G ORQ
 . S @ARRAY@("error",1,"msg")="Missing or invalid patient identifier"
 S LOG=+$O(^EDP(230,"APA",DFN,0)),IN=$P($G(^EDP(230,LOG,0)),U,8)
 S MAX=$$VAL("total")
 ;
 K ^TMP("LRRR",$J) D RR^LR7OR1(DFN)
 ;
 ; get results for tests in each order
 N EDPI,ORIFN,EDPY,EDPTST,ORPK,SUB,IDT,SEQ,EDPX,X
 S EDPI=0 F  S EDPI=$O(PARAM("order",EDPI)) Q:EDPI<1  D
 . ; add order info
 . S ORIFN=+$G(PARAM("order",EDPI)) Q:ORIFN<1  K EDPX
 . S EDPX("id")=ORIFN,X=$$GET1^DIQ(100,ORIFN_",",5,"I")
 . S EDPX("statusId")=X,EDPX("statusName")=$$STATUS(X,ORIFN)
 . S X=$P($$OI^ORX8(ORIFN),U,2),EDPX("name")=$$ESC(X) ;if null?
 . S X=$P($G(^OR(100,ORIFN,0)),U,8) S:'X X=$P($G(^(0)),U,7)
 . S EDPX("collectedTS")=X,EDPX("ack")=$$ACK^EDPHIST(ORIFN)
 . M @ARRAY@("order",1)=EDPX
 . ;
 . ; add order results from visit
 . S ORPK=$$PKGID^ORX8(ORIFN) Q:$L(ORPK,";")'>3  ;no results
 . S SUB=$P(ORPK,";",4),IDT=$P(ORPK,";",5) K EDPTST
 . S SEQ=0 F  S SEQ=$O(^TMP("LRRR",$J,DFN,SUB,IDT,SEQ)) Q:SEQ<1  D
 .. K EDPX S EDPX("id")=SUB_";"_IDT_";"_SEQ
 .. D TMP^EDPLAB(.EDPX,DFN,SUB,IDT,SEQ) ;parse into EDPX("att")=value
 .. M @ARRAY@("visit",1,"item",1)=EDPX
 .. S X=$G(EDPX("testID")) S:X EDPTST(X)=""
 . ;
 . ; add prior results of same tests [up to MAX# collections]
 . N ACNT,ICNT,DONE,MATCH S (ACNT,ICNT,DONE)=0
 . F  S IDT=$O(^TMP("LRRR",$J,DFN,SUB,IDT)) Q:IDT<1  D  Q:DONE
 .. S SEQ=0,MATCH=0
 .. F  S SEQ=$O(^TMP("LRRR",$J,DFN,SUB,IDT,SEQ)) Q:SEQ<1  S X=$G(^(SEQ)) D
 ... Q:'$D(EDPTST(+X))  ;not a matching test
 ... K EDPX S EDPX("id")=SUB_";"_IDT_";"_SEQ,MATCH=1
 ... ;K EDPX S EDPX("id")="CH;"_IDT_";"_SEQ,MATCH=1
 ... ;D TMP^EDPLAB(.EDPX,DFN,"CH",IDT,SEQ) ;parse into EDPX("att")=value
 ... D TMP^EDPLAB(.EDPX,DFN,SUB,IDT,SEQ) ;parse into EDPX("att")=value
 ... S ICNT=ICNT+1 M @ARRAY@("history",1,"item",ICNT)=EDPX
 .. S:MATCH ACNT=ACNT+1 I $G(MAX),ACNT'<MAX S DONE=1
ORQ ; end
 ;D ADD("</results>")
 D TOXML^EDPXML(.EDPARR,.EDPRES)
 Q
 ;
VAL(X) Q $G(PARAM(X,1))
 ;
ESC(X)  ; -- escape outgoing XML
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
STATUS(STS,ORDER) ; -- Return result status for ORDER status
 N Y,X
 S STS=+$G(STS),ORDER=+$G(ORDER)
 I STS=1 S Y="Order discontinued" D:ORDER  ;look for reason
 . S X=$$GET1^DIQ(100,ORDER_",",65) S:'$L(X) X=$$GET1^DIQ(100,ORDER_",",64)
 . I $L(X) S Y=Y_" ("_X_")"
 I STS=2 S Y="Results"_$S($$ACKD^EDPHIST(ORDER):" acknowledged",1:" available")
 I STS=3 S Y="On hold"
 I STS=5 S Y="Order pending"
 I STS=6 S Y="Specimen in lab" ;"Active"
 I STS=7 S Y="Order expired"
 I STS=8 S Y="Scheduled"
 I STS=9 S Y="Partial results available"
 I STS=10!(STS=11) S Y="Order not released"
 I STS=12 S Y="Order discontinued (changed)"
 I STS=13 S Y="Order cancelled"
 I STS=14 S Y="Order discontinued (lapsed)"
 I STS=15 S Y="Order renewed"
 Q Y
 ;
TMP(Y,DFN,SUB,IDT,SEQ,LIST) ; -- Return ^TMP("LRRR",$J,DFN,SUB,IDT,SEQ) data
 ;  in Y("attribute")=value
 ; I SUB = MI or BB ??
 N X0,X,XC,FAC,ACK
 S X0=$G(^TMP("LRRR",$J,DFN,SUB,IDT,SEQ))
 ;
 ; BWF 2/2/2012 - Due to errors occuring on the client side when too much data
 ; is retrieved from this call, an initial call can now be made that will return
 ; a list of the available labs. The client side will then be able to call back in
 ; with a list of labs being requested in smaller chunks. 
 ; If LIST is passed as '1', only pass back the list of testID's and collected date
 I $G(LIST) S Y("testID")=IDT Q
 ;
 S Y("subscript")=SUB,Y("accession")=SUB_";"_IDT
 ;S Y("collectedTS")=$$FMTHL7^XLFDT(9999999-IDT)
 S Y("collectedTS")=(9999999-IDT)
 S Y("testID")=+X0,Y("testName")=$P($G(^LAB(60,+X0,0)),U),X=+$P($G(^(.1)),U,6)
 S Y("printOrder")=$S(X:+X,1:SEQ/1000000)
 S:$L($P(X0,U,2)) Y("result")=$P(X0,U,2)
 I $G(Y("result"))'="" D
 .I Y("result")["<" S Y("result")=$$ESC(Y("result"))
 .I Y("result")[">" S Y("result")=$$ESC(Y("result"))
 S:$L($P(X0,U,4)) Y("units")=$$ESC($P(X0,U,4))
 S:$L($P(X0,U,3)) Y("deviation")=$$ESC($P(X0,U,3))
 S X=$P(X0,U,5) I $L(X),X["-" S Y("low")=$$ESC($P(X,"-")),Y("high")=$$ESC($P(X,"-",2))
 S Y("printName")=$$ESC($P(X0,U,15))
 S Y("number")=$P(X0,U,16)
 S X=+$P(X0,U,19) D  ;sample & specimen
 . N SPC,CS,LRDFN
 . S:X<1 LRDFN=+$G(^DPT(DFN,"LR")),X=+$P($G(^LR(LRDFN,SUB,IDT,0)),U,5)
 . S SPC=$G(^LAB(61,X,0)) Q:'$L(SPC)
 . S Y("specimen")=$P(SPC,U),CS=+$P(SPC,U,6)
 . S:CS Y("sample")=$P($G(^LAB(62,CS,0)),U)
 S X=+$P(X0,U,17),XC=$Q(^LRO(69,"C",X))
 I $P(XC,",",1,3)=("^LRO(69,""C"","_X) D  ;get Lab Order info
 . N LRO,LR3
 . S LRO=$G(^LRO(69,+$P(XC,",",4),1,+$P(XC,",",5),0)),LR3=$G(^(3))
 . ;S X=+$P(LRO,U,6) S:X Y("provider")=X_U_$P($G(^VA(200,X,0)),U)
 . S X=+$P(LRO,U,11) ;S:X Y("order")=X
 . S ACK=$$ACK^EDPHIST(X,1)
 . ;S Y("ack")=$P(ACK,U),Y("ackdt")=$P(ACK,U,2)
 . ;S X=$P(LR3,U,2) S:X Y("resultedTS")=$$FMTHL7^XLFDT(X)
 . S X=$P(LR3,U,2) S:X Y("resultedTS")=(X)
 S FAC=$$SITE^VASITE S:FAC Y("stnNum")=$P(FAC,U,3),Y("stnName")=$P(FAC,U,2)
 ; bwf 12/21/2011 removed setting of 'comments' to bypass errors occuring with the parser on client side
 ;I $D(^TMP("LRRR",$J,DFN,SUB,IDT,"N")) D  ;M Y("comment")=^("N")
 ;. N I S I=1,X=$G(^TMP("LRRR",$J,DFN,SUB,IDT,"N",I))
 ;. F  S I=$O(^TMP("LRRR",$J,DFN,SUB,IDT,"N",I)) Q:I<1  S X=X_$C(13,10)_^(I)
 ;. S Y("comment")=$$ESC(X)
 Q
