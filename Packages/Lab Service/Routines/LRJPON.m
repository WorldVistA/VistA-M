LRJPON ;ALB/JLC - OBSOLETE PENDING ORDERS;08/25/2010 12:32:47
 ;;5.2;LAB SERVICE;**425**;Sep 27, 1994;Build 30
 ;
 ;
 ; Reference to ^OR(100 supported by IA #3582
 ; Reference to STATUS^ORCSAVE2 supported by IA #5903
 ;
EN ;search for pending orders older than the obsolete (lapse) timeframe
 N LRORD,LRDATE,LRSN,LRLAPSE,LRDATE,%,X1,X2,X,LRT,LRCANC,A1,A2,LRDUZ,X,DT,A,LRIFN,LRSTOP
 S A1=$$GET^XPAR("SYS","LRJ OBSOLETE PENDING ORDERS",1,"I")
 S A2=$P($G(^LAB(69.9,1,0)),"^",9)
 I A1="",A2="" D MSG(1) Q
 I A1="",A2]"" S X2=A2 D MSG(2,A2)
 I A2="",A1]"" S X2=A1 D MSG(3,A1)
 I A1]"",A2]"" I A1'<A2 D MSG(4,A1)
 I A1]"",A2]"" S X2=$S(A1<A2:A1,A2<A1:A2,1:A1)
 S X2="-"_X2,LRDUZ=$$PRXYUSR^LRUTIL3("HL",1)
 D NOW^%DTC S (DT,X1)=$P(%,".") D C^%DTC S LRLAPSE=X
 L +^LRJPON:$G(DILOCKTM,5) E  Q
 S LRDATE=0
 F  S LRDATE=$O(^LRO(69,LRDATE)) Q:'LRDATE  Q:LRDATE>LRLAPSE  D  I $$REQ2STOP() S ZSTOP=1 Q
 . S LRSN=0
 . F  S LRSN=$O(^LRO(69,LRDATE,1,LRSN)) Q:'LRSN  D  I $$REQ2STOP() Q
 .. S A=$G(^LRO(69,LRDATE,1,LRSN,0)) I A="" Q
 .. I $P(A,"^")="" Q
 .. I $P($G(^LRO(69,LRDATE,1,LRSN,1)),"^")]"" Q
 .. S (LRT,LRSTOP)=0
 .. F  S LRT=$O(^LRO(69,LRDATE,1,LRSN,2,LRT)) Q:'LRT  D
 ... S A=$G(^LRO(69,LRDATE,1,LRSN,2,LRT,0)) I $P(A,"^",9)="CA" Q
 ... I $P(A,"^",6)]""!($P(A,"^",14)]"") S LRSTOP=$$CHECK(A,LRDATE,LRSN)
 ... S $P(^LRO(69,LRDATE,1,LRSN,2,LRT,0),"^",3,6)="^^^",$P(^(0),"^",9,11)="CA^L^"_LRDUZ
 ... I '$D(^LRO(69,LRDATE,1,LRSN,2,LRT,1.1,0)) S ^(0)="^^^^"_DT
 ... S X=1+$O(^LRO(69,LRDATE,1,LRSN,2,LRT,1.1,9999),-1)
 ... S $P(^LRO(69,LRDATE,1,LRSN,2,LRT,1.1,0),"^",3,4)=X_"^"_X,^(X,0)="Obsolete Order"
 ... I 'LRSTOP S LRIFN=$P($G(^LRO(69,LRDATE,1,LRSN,2,LRT,0)),"^",7) I LRIFN]"" D STATUS^ORCSAVE2(LRIFN,14)
 .. D NEW^LR7OB1(LRDATE,LRSN,"Z@")
 S $P(^LAB(69.9,1,64.9104),"^")=$P($$NOW^XLFDT,".")
 L -^LRJPON
 Q
 ;
CHECK(PREV,LDATE,LSN) ;
 N B,LRCOM,ORIFN
 S ORIFN=$P(PREV,"^",7) I ORIFN="" Q 1
 I $P($G(^OR(100,ORIFN,3)),"^",3)'=5 Q 1
 S B=$G(^OR(100,ORIFN,4)) I LDATE'=$P(B,";",2)!(LSN'=$P(B,";",3)) Q 1
 Q 0
REQ2STOP() ;
 ; Check for task stop request
 ; Returns 1 if stop request made.
 N STATUS,X
 S STATUS=0
 I '$D(ZTQUEUED) Q 0
 S X=$$S^%ZTLOAD()
 I X D  ;
 . S (STATUS,ZTSTOP)=1
 . S X=$$S^%ZTLOAD("Received shutdown request")
 ;
 I $Q Q STATUS
 Q
 ;
MSG(ERR,DAYS) ;send mail message
 K XMY N XMDUZ,XMSUB,XMTEXT,A
 S XMDUZ="ORDERS, OBSOLETE",XMY("G.LMI")="",XMSUB="OBSOLETE ORDER PARAMETER(S) ISSUE"
 I ERR=1 D
 . S A(1)="Both the GRACE PERIOD FOR ORDERS field in file 69.9 and the LRJ OBSOLETE"
 . S A(2)="PENDING ORDERS parameter are blank."
 . S A(3)=" "
 . S A(4)="One of these fields must be populated in order for the process to obsolete"
 . S A(5)="pending orders to run."
 I ERR=2!(ERR=3) D
 . S A(1)="The "_$S(ERR=2:"LRJ OBSOLETE PENDING ORDERS parameter",1:"GRACE PERIOD FOR ORDERS field")_" is blank."
 . S A(2)=" "
 . S A(3)="The value: "_DAYS_" days was used for determining the 'obsolete' date."
 I ERR=4 D
 . S A(1)="The LRJ OBSOLETE PENDING ORDERS parameter is currently set to "_DAYS_"."
 . S A(2)=" "
 . S A(3)="This is either the same or greater than the GRACE PERIOD FOR ORDERS field in"
 . S A(4)="file 69.9. LRJ OBSOLETE PENDING ORDERS should always be less."
 . S A(5)=" "
 . S A(6)="Please correct these settings. You may have to contact IRM for help changing"
 . S A(7)="the parameter."
 S XMTEXT="A(" D ^XMD
 Q
