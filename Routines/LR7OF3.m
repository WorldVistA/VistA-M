LR7OF3 ;slc/dcm - Process OBR messages from OE/RR ;8/11/97
 ;;5.2;LAB SERVICE;**121,187,223,256**;Sep 27, 1994
 ;
OBR ;Process OBR part of MSG array
 ;TEST= Ptr to test in file 60
 ;TESTN= Test Name
 ;TYPE= Collection Sample Type
 ;SAMP= Ptr to Collection sample in file 62
 ;SPEC= Ptr to Specimen in file 61
 ;URG= Urgency
 I '$O(LRXMSG(0)) D
 . S TEST=+$P($P(LRXMSG,"|",5),"^",4),TESTN=$P($P(LRXMSG,"|",5),"^",6),TYPE=$$LRACTCOD^LR7OU0($P(LRXMSG,"|",12))
 . S SPEC=$S($P($P($P(LRXMSG,"|",5),"^",4),"~",2):$P($P($P(LRXMSG,"|",5),"^",4),"~",2),1:$$LRSPEC^LR7OU0($P(LRXMSG,"|",16)))
 . S URG=$$LRURG^LR7OU0($P($P(LRXMSG,"|",28),"^",6)),SAMP=$$LRSAMP^LR7OU0($P(LRXMSG,"|",16))
 I $O(LRXMSG(0)) D
 . N I,J,X1,CTR
 . F CTR=1:1:$L(LRXMSG,"|") S X1(CTR)=$P(LRXMSG,"|",CTR)
 . S J=0 F  S J=$O(LRXMSG(J)) Q:J<1  D
 .. S I=1 I $E(LRXMSG(J))'="|" S X1(CTR)=X1(CTR)_$P(LRXMSG,"|"),I=I+1
 .. F I=I:1:$L(LRXMSG(J),"|") S CTR=CTR+1,X1(CTR)=$P(LRXMSG(J),"|",I)
 . S TEST=$P(X1(5),"^",4),TESTN=$P(X1(5),"^",6),TYPE=$$LRACTCOD^LR7OU0(X1(12))
 . S SPEC=$S($P($P(X1(5),"^",4),"~",2):$P($P(X1(5),"^",4),"~",2),1:$$LRSPEC^LR7OU0(X1(16)))
 . S URG=$$LRURG^LR7OU0($P(X1(28),"^",6)),SAMP=$$LRSAMP^LR7OU0(X1(16))
 I '$L(TEST) D ACK^LR7OF0("DE",LRXORC,"TEST pointer not sent in message") S LREND=1 Q
 I '$L($G(^LAB(60,+TEST,0))) D ACK^LR7OF0("DE",LRXORC,"Invalid Lab test pointer sent from CPRS: "_TEST) S LREND=1 Q
 I '$L(TESTN) D ACK^LR7OF0("DE",LRXORC,"Test Name not sent in message") S LREND=1 Q
 I '$L(TYPE) D ACK^LR7OF0("DE",LRXORC,"Collection type not sent in message") S LREND=1 Q
 I '$L(SAMP) D ACK^LR7OF0("DE",LRXORC,"Sample pointer not sent in message") S LREND=1 Q
 I '$L(SPEC) D ACK^LR7OF0("DE",LRXORC,"Specimen not set in file 62: "_SAMP) S LREND=1 Q
 I '$L(URG) D ACK^LR7OF0("DE",LRXORC,"Urgency not sent in message") S LREND=1 Q
 I LRXTYPE="XO" D  Q  ;Change order request
 . D GET^LR7OF2(.LRXORC,LRXORC)
 . Q:'$G(LRORD) 
 . N TST,FLAG
 . S FLAG=0
 . I 'LRVERZ F  S LRODT=$O(^LRO(69,"C",LRORD,LRODT)) Q:LRODT<1  S LRSN=0 F  S LRSN=$O(^LRO(69,"C",LRORD,LRODT,LRSN)) Q:LRSN<1  I $P(^LRO(69,LRODT,1,LRSN,0),"^",3)=SAMP S FLAG=1 D JAB
 . I LRVERZ,$D(^LRO(69,LRODT,1,LRSN,0)),$P(^(0),"^",3)=SAMP S FLAG=1 D JAB
 . I FLAG=0 D ACK^LR7OF0("XO",LRXORC,"Specimen not found") S LREND=1 Q
 I LRXTYPE="NW" D ST Q  ;New order request
 Q
JAB ;Cancel or Add test
 I TYPE=3,$D(^LRO(69,LRODT,1,LRSN,2,"B",+TEST)) D DOIT^LR7OF2(LRODT,LRSN,TEST,LRXORC,$G(LRDUZ),$G(REASON)) Q
 I TYPE="A",'$D(^LRO(69,LRODT,1,LRSN,2,"B",+TEST)) D  Q
 . I $O(^LRO(69,LRODT,1,LRSN,2,0)),$P(^($O(^(0)),0),"^",3) S LREND=1 D ACK^LR7OF0("UX",LRXORC,"Orders have been accessioned, call lab to add tests to the same order.") Q
 . S I=$O(^LRO(69,LRODT,1,LRSN,2,99999),-1)+1,^LRO(69,LRODT,1,LRSN,2,I,0)=TEST_"^"_URG,^LRO(69,LRODT,1,LRSN,2,"B",+TEST,I)=""
 Q
ST S LRSX=LRSX+1
 I $D(^TMP("OR",$J,"LROT",STARTDT,TYPE,SAMP,SPEC,LRSX)) G ST
 S ^TMP("OR",$J,"LROT",STARTDT,TYPE,SAMP,SPEC,0)=ORIFN ;_"^"_$S($P($G(^LAB(60,TEST,0)),"^",4)'="CH":1,1:0) ;Setting 2nd piece forces unique order number
 S ^TMP("OR",$J,"LROT",STARTDT,TYPE,SAMP,SPEC,LRSX)=TEST_"^"_QUANT
 S ^TMP("OR",$J,"LROT",STARTDT,TYPE,SAMP,SPEC,LRSX,1)=URG
 Q
