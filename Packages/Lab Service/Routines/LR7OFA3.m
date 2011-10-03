LR7OFA3 ;slc/dcm - Process OBR messages from OE/RR for AP ;8/11/97
 ;;5.2;LAB SERVICE;**121,187**;Sep 27, 1994
 ;
OBR ;Process OBR part of MSG array
 ;TEST= Ptr to test in file 60
 ;TESTN= Test Name
 ;TYPE= Collection Sample Type
 ;SAMP= Ptr to Collection sample in file 62
 ;URG= Urgency
 I '$O(LRXMSG(0)) D
 . S TEST=+$P($P(LRXMSG,"|",5),"^",4),TESTN=$P($P(LRXMSG,"|",5),"^",6),TYPE=$$LRACTCOD^LR7OU0($P(LRXMSG,"|",12)),SPEC=$S($P($P($P(LRXMSG,"|",5),"^",4),"~",2):$P($P($P(LRXMSG,"|",5),"^",4),"~",2),1:$$LRSPEC^LR7OU0($P(LRXMSG,"|",16)))
 . S URG=$$LRURG^LR7OU0($P($P(LRXMSG,"|",28),"^",6))
 I $O(LRXMSG(0)) D
 . N I,J,X1,CTR
 . F CTR=1:1:$L(LRXMSG,"|") S X1(CTR)=$P(LRXMSG,"|",CTR)
 . S J=0 F  S J=$O(LRXMSG(J)) Q:J<1  D
 .. S I=1 I $E(LRXMSG(J))'="|" S X1(CTR)=X1(CTR)_$P(LRXMSG,"|"),I=I+1
 .. F I=I:1:$L(LRXMSG(J),"|") S CTR=CTR+1,X1(CTR)=$P(LRXMSG(J),"|",I)
 . S TEST=$P(X1(5),"^",4),TESTN=$P(X1(5),"^",6),TYPE=$$LRACTCOD^LR7OU0(X1(12)),SPEC=$S($P($P(X1(5),"^",4),"~",2):$P($P(X1(5),"^",4),"~",2),1:$$LRSPEC^LR7OU0(X1(16)))
 . S URG=$$LRURG^LR7OU0($P(X1(28),"^",6))
 I '$L(TEST) D ACK^LR7OF0("DE",LRXORC,"TEST pointer not sent in message") S LREND=1 Q
 I '$L(TESTN) D ACK^LR7OF0("DE",LRXORC,"Test Name not sent in message") S LREND=1 Q
 I '$L(TYPE) D ACK^LR7OF0("DE",LRXORC,"Collection type not sent in message") S LREND=1 Q
 I '$L(SAMP) D ACK^LR7OF0("DE",LRXORC,"Sample pointer not sent in message") S LREND=1 Q
 I '$L(URG) D ACK^LR7OF0("DE",LRXORC,"Urgency not sent in message") S LREND=1 Q
 I LRXTYPE="NW" D ST Q  ;New order request
 Q
ST S LRSX=LRSX+1 I $D(^TMP("OR",$J,"LROT",STARTDT,TYPE,SAMP,LRSX)) G ST
 S ^TMP("OR",$J,"LROT",STARTDT,TYPE,SAMP,0)=ORIFN
 S ^TMP("OR",$J,"LROT",STARTDT,TYPE,SAMP,LRSX)=TEST
 S ^TMP("OR",$J,"LROT",STARTDT,TYPE,SAMP,LRSX,1)=URG
 Q
