EDPHIST ;SLC/MKB - Return results history as XML ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
LAB(XML,PARAM) ; -- Return results history for lab orders
 K XML D ADD("<results>")
 ;
 ; validate input parameters
 N DFN,LOG,IN,MAX
 S DFN=+$$VAL("patient") I DFN<1   D ERR(1) G LQ
 S LOG=+$O(^EDP(230,"APA",DFN,0)),IN=$P($G(^EDP(230,LOG,0)),U,8)
 S MAX=$$VAL("total")
 ;
 K ^TMP("LRRR",$J) D RR^LR7OR1(DFN)
 ;
 ; get results for tests in each order
 N EDPI,ORIFN,NAME,STS,START,EDPY,EDPTST,ORPK,SUB,IDT,SEQ,EDPX,X
 S EDPI=0 F  S EDPI=$O(PARAM("order",EDPI)) Q:EDPI<1  D
 . S ORIFN=+$G(PARAM("order",EDPI)) Q:ORIFN<1
 . S NAME=$P($$OI^ORX8(ORIFN),U,2) ;get order text if null?
 . S STS=$$GET1^DIQ(100,ORIFN_",",5,"I")
 . S START=$P($G(^OR(100,ORIFN,0)),U,8) S:'START START=$P($G(^(0)),U,7)
 . S EDPY="<order id="""_ORIFN_""" name="""_$$ESC(NAME)_""" ack="""_$$ACK(ORIFN)_""" statusId="""_STS_""" statusName="""_$$STATUS(STS,"L",ORIFN)_""" collectedTS="""_START_""">"
 . D ADD(EDPY) K EDPY,EDPTST
 . ; add order results from visit
 . S ORPK=$$PKGID^ORX8(ORIFN) I $L(ORPK,";")'>3 G L1 ;no results
 . S SUB=$P(ORPK,";",4),IDT=$P(ORPK,";",5)
 . D ADD("<visit>")
 . S SEQ=0 F  S SEQ=$O(^TMP("LRRR",$J,DFN,SUB,IDT,SEQ)) Q:SEQ<1  D
 .. K EDPX S EDPX("id")=SUB_";"_IDT_";"_SEQ
 .. D TMP^EDPLAB(.EDPX,DFN,SUB,IDT,SEQ) ;parse into EDPX("att")=value
 .. D ADDA("item",.EDPX)
 .. S X=$G(EDPX("testID")) S:X EDPTST(X)=""
 . D ADD("</visit>")
 . ;
 . ; add prior results of all included tests [up to MAX# collections]
 . N CNT,DONE,MORE
 . D ADD("<history>") S (CNT,DONE)=0
 . F  S IDT=$O(^TMP("LRRR",$J,DFN,SUB,IDT)) Q:IDT<1  D  Q:DONE
 .. S SEQ=0,MORE=0
 .. F  S SEQ=$O(^TMP("LRRR",$J,DFN,SUB,IDT,SEQ)) Q:SEQ<1  S X=$G(^(SEQ)) D
 ... Q:'$D(EDPTST(+X))  ;not a matching test
 ... K EDPX S EDPX("id")="CH;"_IDT_";"_SEQ,MORE=1
 ... D TMP^EDPLAB(.EDPX,DFN,"CH",IDT,SEQ) ;parse into EDPX("att")=value
 ... D ADDA("item",.EDPX)
 .. S:MORE CNT=CNT+1 I $G(MAX),CNT'<MAX S DONE=1
 . D ADD("</history>")
L1 . D ADD("</order>")
 ;
LQ ; end
 D ADD("</results>")
 Q
 ;
ACK(ORDER,RETDATE) ; -- Return [first] user that ack'd order
 ; INPUT
 ;       ORDER   - Order IEN
 ;       RETDATE - (optional) 1 if ack date is to be returned, otherwise do not return ack date 
 N IFN,X,Y,Y1 S Y="false",Y1=""
 S RETDATE=$G(RETDATE,"")
 S IFN=0 F  S IFN=+$O(^ORA(102.4,"B",+$G(ORDER),IFN)) Q:IFN<1  D  Q:Y'="false"
 . S X=$G(^ORA(102.4,IFN,0))
 . I $P(X,U,3) S X=+$P(X,U,2),Y=$$GET1^DIQ(200,X_",",1),Y1=$P(X,U,3) ;Y=initials, Y1=date/time
 I RETDATE Q Y_U_Y1
 Q Y
 ;
MED(XML,PARAM) ; -- Return dose & lab history for med
 K XML D ADD("<results>")
 ;
 ; validate input parameters
 N DFN,ORD,ORIT,ORVP,ORIDT,ORIFN,EDPLST,EDPX
 S DFN=+$$VAL("patient") I DFN<1 D ERR(1) G MQ
 S ORD=+$$VAL("order") I ORD<1 D ERR(4) G MQ
 S ORIT=+$$OI^ORX8(ORD) I ORIT<1 D ERR(5) G MQ
 S ORVP=DFN_";DPT("
 ;
 ; search Pharmacy for history of medication
 S ORIDT=0 F  S ORIDT=$O(^OR(100,"AOI",ORIT,ORVP,ORIDT)) Q:ORIDT<1  D
 . S ORIFN=0 F  S ORIFN=$O(^OR(100,"AOI",ORIT,ORVP,ORIDT,ORIFN)) Q:ORIFN<1  I ORIFN'=ORD S EDPLST(ORIFN)=""
 K ^TMP("PS",$J) I $O(EDPLST(0)) D
 . D ADD("<meds>")
 . S ORIFN=0 F  S ORIFN=$O(EDPLST(ORIFN)) Q:ORIFN<1  D
 .. K EDPX D OEL^EDPMED(.EDPX,DFN,ORIFN,ORIDT)
 .. D ADDA("med",.EDPX)
 . D ADD("</meds>") K ^TMP("PS",$J)
 ;
 ; search Lab for result history of TEST
 N DRUG,TEST K ^TMP("LRRR",$J)
 S DRUG=+$$VALUE^ORCSAVE2(ORIFN,"DRUG")
 S TEST=$$GET1^DIQ(50,DRUG_",",17.2,"I") I TEST<1 G MQ
 D RR^LR7OR1(DFN,,,,,TEST) I $D(^TMP("LRRR",$J)) D
 . N SUB,IDT,SEQ
 . D ADD("<labs>")
 . S SUB=$O(^TMP("LRRR",$J,DFN,"")) Q:SUB=""
 . S IDT=0 F  S IDT=$O(^TMP("LRRR",$J,DFN,SUB,IDT)) Q:IDT<1  D
 .. S SEQ=0 F  S SEQ=$O(^TMP("LRRR",$J,DFN,SUB,IDT,SEQ)) Q:SEQ<1  D
 ... K EDPX ;S EDPX("id")=SUB_";"_IDT_";"_SEQ ??
 ... D TMP^EDPLAB(.EDPX,DFN,SUB,IDT,SEQ) ;parse into EDPX("att")=value
 ... D ADDA("lab",.EDPX)
 . D ADD("</labs>") K ^TMP("LRRR",$J)
 ;
 ; search for Clinical Events on ORIT/TEST
 I $D(^EDP(234,"AL",DFN,ORIT,TEST)) D
 . D ADD("<events>")
 . N EDPDT,DA,X0,X1,X2,EDPV S EDPDT=0
 . F  S EDPDT=$O(^EDP(234,"AL",DFN,ORIT,TEST,EDPDT)) Q:EDPDT<1  S DA=+$O(^(EDPDT,0)) D
 .. S X0=$G(^EDP(234,DA,0)),X1=$G(^(1)),X2=$G(^(2)) K EDPV
 .. S EDPV("eventTS")=+X0,EDPV("title")=X1,EDPV("text")=X2
 .. S X=+$P(X0,U,3),EDPV("userID")=X,EDPV("id")=DA
 .. S EDPV("userName")=$P($G(^VA(200,X,0)),U)
 .. D ADDA("event",.EDPV)
 . D ADD("</events>")
 ;
MQ ;end
 D ADD("</results>")
 Q
 ;
VAL(X) Q $G(PARAM(X,1))
 ;
STATUS(STS,TYPE,ORDER) ; -- Return result status for ORDER status
 N Y,X
 S Y=""
 S STS=+$G(STS),TYPE=$E($$UP^XLFSTR($G(TYPE))),ORDER=+$G(ORDER)
 I STS=1 S Y="Order discontinued" D:ORDER  ;look for reason
 . S X=$$GET1^DIQ(100,ORDER_",",65) S:'$L(X) X=$$GET1^DIQ(100,ORDER_",",64)
 . I $L(X) S Y=Y_" ("_X_")"
 I STS=2 S Y=$S(TYPE="R":"Report",1:"Results")_$S($$ACKD(ORDER):" acknowledged",1:" available")
 I STS=3 S Y="On hold"
 I STS=5 S Y="Order pending"
 I STS=6 S Y=$S(TYPE="L":"Specimen in lab",TYPE="R":"In Process",1:"Active")
 I STS=7 S Y="Order expired"
 I STS=8 S Y=$S(TYPE="R":"Exam scheduled",1:"Scheduled")
 I STS=9 S Y="Partial results available"
 I STS=10!(STS=11) S Y="Order not released"
 I STS=12 S Y="Order discontinued (changed)"
 I STS=13 S Y="Order cancelled"
 I STS=14 S Y="Order discontinued (lapsed)"
 I STS=15 S Y="Order renewed"
 Q Y
 ;
ACKD(ORDER) ; -- Returns 1 or 0, if ORDER has been acknowledged
 N Y,X,IFN S Y=0
 S IFN=0 F  S IFN=$O(^ORA(102.4,"B",+$G(ORDER),IFN)) Q:IFN<1  D  Q:Y
 . S X=$G(^ORA(102.4,IFN,0)) I $P(X,U,3) S Y=1 Q
 Q Y
 ;
RANGE(VAL,BEG,END,MAX) ; -- Return BEG,END,MAX
 S BEG=$G(VAL("start",1)),END=$G(VAL("stop",1)),MAX=$G(VAL("total",1))
 S:BEG BEG=$$HL7TFM^XLFDT(BEG)
 S:END END=$$HL7TFM^XLFDT(END)
 I BEG,END,END<BEG N X S X=BEG,BEG=END,END=X  ;switch
 I END,$L(END,".")<2 S END=END_".24"
 Q
 ;
ERR(X) ; -- return error message
 N MSG
 I X=1  S MSG="Missing or invalid patient identifier"
 I X=2  S MSG="Missing or invalid data type"
 I X=3  S MSG="Missing or invalid observation identifier"
 I X=4  S MSG="Missing or invalid order number"
 I X=5  S MSG="Missing or invalid orderable item"
 ; X=?  S MSG="others"
 I X=99 S MSG="Unknown request"
 D XML^EDPX("<error msg='"_MSG_"' />")
 Q
 ;
UES(X) ; -- unescape incoming XML
 ; bwf: 12/19/2011 commented following line due to SAC. Need to figure out why this is here.
 ;Q $ZCONVERT(X,"I","HTML")
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
ADD(X) ; Add a line to XML(n)
 S XML=$G(XML)+1
 S XML(XML)=X
 Q
 ;
ADDA(TAG,ATT) ; Add ATTribute list to XML(n)
 ;   as <TAG att1="a" att2="b"... />
 N NODE,X,MULT,N,I
 S NODE="<"_TAG_" ",N=0
 S X="" F  S X=$O(ATT(X)) Q:X=""  D
 . I X="text",$L($G(ATT(X))) S N=N+1,MULT(N)="<"_X_" xml:space=""preserve"">"_$$ESC(ATT(X))_"</"_X_">" Q
 . I $L($G(ATT(X))) S NODE=NODE_X_"="""_$$ESC(ATT(X))_""" " Q
 . S N=N+1,MULT(N)="<"_X_"s>"
 . S I=0 F  S I=$O(ATT(X,I)) Q:I<1  D
 .. I $L($G(ATT(X,I))) S N=N+1,MULT(N)="<"_X_$S(X="text":" xml:space=""preserve"">",1:">")_$$ESC(ATT(X,I))_"</"_X_">" Q
 .. N SUB,TXT,Y S Y="<"_X_" ",(TXT,SUB)=""
 .. F  S SUB=$O(ATT(X,I,SUB)) Q:SUB=""  D
 ... I SUB="text",$L($G(ATT(X,I,SUB))) S TXT="<text xml:space=""preserve"">"_$$ESC(ATT(X,I,SUB))_"</text>" Q
 ... I $L($G(ATT(X,I,SUB))) S Y=Y_SUB_"="""_$$ESC(ATT(X,I,SUB))_""" "
 .. S N=N+1,MULT(N)=Y_$S($L(TXT):">",1:"/>")
 .. S:$L(TXT) N=N+1,MULT(N)=TXT,N=N+1,MULT(N)="</"_X_">"
 . S N=N+1,MULT(N)="</"_X_"s>"
 S NODE=NODE_$S(N:"",1:"/")_">" D ADD(NODE)
 I N D
 . S I=0 F  S I=$O(MULT(I)) Q:I<1  S X=MULT(I) D ADD(X)
 . S X="</"_TAG_">" D ADD(X)
 Q
 ;
ADDE(ELMT) ; Add ELeMenT list to XML(n)
 N X,NODE
 S X="" F  S X=$O(ELMT(X)) Q:X=""  D
 . S NODE="<"_X_">"_$$ESC(ELMT(X))_"</"_X_">"
 . D ADD(NODE)
 Q
