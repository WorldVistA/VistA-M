LR7OB1 ;slc/dcm - Build message, backdoor Lab from file 69 ;8/11/97
 ;;5.2;LAB SERVICE;**121,187,238**;Sep 27, 1994
 ;
NEW(ODT,SN,CONTROL,NAT,TESTS,LRSTATI) ;Set-up order message
 ;Need ODT & SN of entry in ^LRO(69,ODT,1,SN)
 ;CONTROL=Order Control (SN=new order)
 ;NAT=Nature of order
 ;TESTS=Array of tests to be updated (optional). If this array is not included then all tests for the LRSN entry will be updated/included
 ;LRSTATI=Status of order (ptr to ^ORD(100.01,IFN))
 Q:'$L($T(MSG^XQOR))
 Q:'$D(^LRO(69,$G(ODT),1,$G(SN),0))  N LRX0 S LRX0=^(0)
 I $$VER^LR7OU1>2.5,'$G(^ORD(100.99,1,"CONV")) N Y,DFN,LRDPF S Y=$G(^LR(+LRX0,0)),DFN=$P(Y,"^",3),LRDPF=$P(Y,"^",2)_$G(^DIC(+$P(Y,"^",2),0,"GL")) D
 . Q:'$D(^ORD(100.99,1,"PTCONV",DFN))
 . S $P(^LRO(69,ODT,1,SN,0),"^",11)=1 ;Keeps this order from being converted
 . D EN^LR7OV2(DFN_";"_$P(LRDPF,"^",2),1)
 Q:$P($G(^LR(+LRX0,0)),"^",2)'=2  ;Only allow messages for patients (file 2)
 N MSG,ORCHMSG,ORBBMSG,ORAPMSG,I,LRNIFN,LRTMPO
 K ^TMP("LRAP",$J),^TMP("LRCH",$J),^TMP("LRBB",$J)
 D ORD1(ODT,SN,.TESTS)
 I '$D(LRTMPO("LRIFN")) D EN1^LR7OB0(ODT,SN,CONTROL,$G(NAT)),CALL(CONTROL) K ^TMP("LRAP",$J),^TMP("LRCH",$J),^TMP("LRBB",$J) Q
 S LRNIFN=0 F  S LRNIFN=$O(LRTMPO("LRIFN",LRNIFN)) Q:LRNIFN<1  S X=LRTMPO("LRIFN",LRNIFN) D
 . I $P(X,"^",7)="P" Q  ;Test purged from CPRS
 . I $L($P(X,"^",14)) N ODT,SN D  Q
 .. S ODT=+$P(X,"^",14),SN=$P($P(X,"^",14),";",2)
 .. I $D(^LRO(69,+ODT,1,+SN,0)) S:CONTROL="RE" LRSTATI=2 D EN1^LR7OB0(ODT,SN,CONTROL,$G(NAT)),CALL(CONTROL) K ^TMP("LRAP",$J),^TMP("LRCH",$J),^TMP("LRBB",$J)
 . D EN1^LR7OB0(ODT,SN,CONTROL,$G(NAT)),CALL(CONTROL) K ^TMP("LRAP",$J),^TMP("LRCH",$J),^TMP("LRBB",$J)
 Q
CALL(CNTRL) ;Make protocol calls
 Q:'$L($T(MSG^XQOR))
 S:'$D(CNTRL) CNTRL=""
 I $D(^TMP("LRCH",$J)) S ORCHMSG="^TMP(""LRCH"",$J)" D MSG^XQOR("LR7O CH EVSEND OR",.ORCHMSG),RESULTS(ORCHMSG,CNTRL) ;Message from lab
 I $D(^TMP("LRBB",$J)) S ORBBMSG="^TMP(""LRBB"",$J)" D MSG^XQOR("LR7O BB EVSEND OR",.ORBBMSG),RESULTS(ORBBMSG,CNTRL) ;New order from Blood bank
 I $D(^TMP("LRAP",$J)) S ORAPMSG="^TMP(""LRAP"",$J)" D MSG^XQOR("LR7O AP EVSEND OR",.ORAPMSG),RESULTS(ORAPMSG,CNTRL) ;New order from Anatomic Path
 Q
RESULTS(OREMSG,CNTRL) ;Results only protocol
 Q:$G(CNTRL)'="RE"  Q:'$D(OREMSG)
 D MSG^XQOR("LR7O ALL EVSEND RESULTS",.OREMSG)
 Q
ACC(AC,ACDT,ACN,CONTROL,NAT) ;Set-up order message for BB,SP,EM,CY,AU accessions
 ;ACC=Accession area ptr
 ;ACDT=Accession Date
 ;ACN=Accession #
 Q:'$L($T(MSG^XQOR))
 N MSG,CHMSG,BBMSG,APMSG
 K ^TMP("LRAP",$J),^TMP("LRCH",$J),^TMP("LRBB",$J)
 D EN2^LR7OB0(AC,ACDT,ACN,CONTROL,.CHMSG,.BBMSG,.APMSG,$G(NAT))
 D CALL(CONTROL)
 K ^TMP("LRAP",$J),^TMP("LRCH",$J),^TMP("LRBB",$J)
 Q
ORD(ORD) ;Set test nodes in LRTMPO("LRIFN" for given Lab #
 ;ORD=Lab order #
 Q:'$G(ORD)  I $D(LRTMPO("LRIFN")) K LRTMPO("LRIFN")
 N IFN,ODT,SN,X
 S (CTR,ODT)=0
 F  S ODT=$O(^LRO(69,"C",ORD,ODT)) Q:ODT<1  S SN=0 F  S SN=$O(^LRO(69,"C",ORD,ODT,SN)) Q:SN<1  S IFN=0 F  S IFN=$O(^LRO(69,ODT,1,SN,2,IFN)) Q:IFN<1  S X=$G(^(IFN,0)) I X D
 . S CTR=CTR+1,LRTMPO("LRIFN",CTR)=X
 Q
ORD1(ODT,SN,TST) ;Set test nodes in LRTMPO("LRIFN"  for given LRODT & LRSN (includes combined tests)
 ;ODT=LRODT
 ;SN=LRSN
 ; TST=Array of tests to be included (optional).  If TST is not passed, then all tests for a given LRSN will be included
 ; Screen out orders with ORIFN if CONTROL=SN (new order)
 Q:'$G(ODT)  Q:'$G(SN)  I $D(LRTMPO("LRIFN")) K LRTMPO("LRIFN")
 N IFN,X,CTR
 S (CTR,IFN)=0
 F  S IFN=$O(^LRO(69,ODT,1,SN,2,IFN)) Q:IFN<1  S X=$G(^(IFN,0)) I X D
 . I CONTROL="SN",$P(X,"^",7) S LRTMPO("LRIFN")="" Q  ;Don't send a SN for existing order
 . I $S($O(TST(0)):$D(TST(+X)),1:1) S CTR=CTR+1,LRTMPO("LRIFN",CTR)=X D  Q
 .. I $P(X,"^",14) S X=$P(X,"^",14) D
 ... I $D(^LRO(69,+X,1,+$P(X,";",2),2,+$P(X,";",3),0)) S X=^(0),CTR=CTR+1,LRTMPO("LRIFN",CTR)=X
 Q
