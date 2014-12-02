LR7OF2 ;slc/dcm - Process messages from OE/RR ;8/11/97
 ;;5.2;LAB SERVICE;**121,187,440**;Sep 27, 1994;Build 2
 ;
NEW ;Process New orders from OE/RR
 ;LRXMSG=Message with linking identifiers
 ;LRXORC=Current ORC message value - for communicating back to OE/RR
 D GET(.LRXMSG,LRXORC) Q:LREND
 I '$L(STARTDT) D ACK^LR7OF0("DE",LRXORC,"Start date not passed in message") S LREND=1 Q
 I '$L(LRDUZ) D ACK^LR7OF0("DE",LRXORC,"Entered By person not passed in message") S LREND=1 Q
 I '$L(PROV) D ACK^LR7OF0("DE",LRXORC,"Provider not passed in message") S LREND=1 Q
 Q
CANC ;Process Canceled orders from OE/RR
 N TST,X,LRODT,LRSN,LRORD,LRORIFN,STARTDT,LRDUZ,PROV,REASON,QUANT
 D GET(.LRXORC,LRXORC) Q:LREND
 I 'LRVERZ S LRODT=0 F  S LRODT=$O(^LRO(69,"C",LRORD,LRODT)) Q:LRODT<1  S LRSN=0 F  S LRSN=$O(^LRO(69,"C",LRORD,LRODT,LRSN)) Q:LRSN<1  D  Q
 . S X=$P($P(LRXMSG,"|",5),"^",4) I X S TST=$O(^LRO(69,LRODT,1,LRSN,2,"B",X,0)) I TST D DOIT(LRODT,LRSN,TST,LRXORC,LRDUZ,REASON) Q:LREND
 I LRVERZ,$D(^LRO(69,LRODT,1,LRSN,0)) D  Q:LREND
 . S X=$P($P(LRXMSG,"|",5),"^",4),TST=""
 . I X S TST=$O(^LRO(69,LRODT,1,LRSN,2,"B",X,0))
 . I TST D DOIT(LRODT,LRSN,TST,LRXORC,LRDUZ,REASON),CHKCOMB(LRODT,LRSN,TST,LRXORC,LRDUZ,REASON)
 D ACK^LR7OF0("CR",LRXORC)
 Q
XO ;Process order changes from OE/RR
 D GET(.LRXMSG,LRXORC) Q:LREND
 D ACK^LR7OF0("XR",LRXORC)
 Q
DOIT(LRODT,LRSN,TST,LRXORC,LRDUZ,REASON) ;Clean it out
 N LRAA,LRAD,LRAN,X,LRTSN,LRUSNM
 ;I $D(^LRO(69,LRODT,1,LRSN,3)),$P(^(3),"^",2) S LREND=1 D ACK^LR7OF0("UC",LRXORC,"Tests already verified") Q  ;Tests already verified
 S X=+^LRO(69,LRODT,1,LRSN,2,TST,0),LRTSN=+X,LRAD=+$P(X,"^",3),LRAA=+$P(X,"^",4),LRAN=+$P(X,"^",5)
 I LRAD,LRAA,LRAN,$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) S LREND=1 D ACK^LR7OF0("UC",LRXORC,"Tests already accessioned, contact lab to cancel") Q
 S $P(^LRO(69,LRODT,1,LRSN,2,TST,0),"^",3,6)="^^^",$P(^(0),"^",9,11)="CA^W^"_LRDUZ
 I $L($P(REASON,"^",5)) S:'$D(^LRO(69,LRODT,1,LRSN,2,TST,1.1,0)) ^(0)="^^^^"_DT S X=1+$O(^(9999),-1),$P(^LRO(69,LRODT,1,LRSN,2,TST,1.1,0),"^",3,4)=X_"^"_X,^(X,0)=$P(REASON,"^",5)
 Q
CHKCOMB(LRODT,LRSN,LRIN,LRXORC,LRDUZ,REASON)  ;
 ; check for other entries that have combined this test
 N LR60,LRI,LRORD,LRX,LRY
 ;
 ; retrieve list of merged orders
 S LRX=$P($G(^LRO(69,LRODT,1,LRSN,1)),"^",7) Q:LRX=""
 ;
 S LR60=$P(^LRO(69,LRODT,1,LRSN,2,LRIN,0),"^")
 S LRY=LRODT_";"_LRSN_";"_LRIN
 ;
 ; scan the merged order # (LRX) and check corresponding orders/seq (LRSN)
 ; for matching (#20) COMBINED FROM [14F] and update if match
 F LRI=1:1 S LRORD=$P(LRX,"/",LRI) Q:LRORD=""  D
 . S LRODT=0
 . F  S LRODT=$O(^LRO(69,"C",LRORD,LRODT)) Q:LRODT<1  D
 . . S LRSN=0
 . . F  S LRSN=$O(^LRO(69,"C",LRORD,LRODT,LRSN)) Q:LRSN<1  D
 . . . S LRIN=$O(^LRO(69,LRODT,1,LRSN,2,"B",LR60,0))
 . . . I LRIN,$P(^LRO(69,LRODT,1,LRSN,2,LRIN,0),"^",14)=LRY D DOIT(LRODT,LRSN,LRIN,LRXORC,LRDUZ,REASON)
 ;
 Q
NUM ;Process Return of OE/RR Order number
 N LRODT,LRSN,LRORD,ORIFN,STARTDT,LRDUZ,PROV,REASON,QUANT
 D GET(.LRXMSG,LRXORC) Q:LREND
 I 'LRVERZ,LRORD S LRODT=0 F  S LRODT=$O(^LRO(69,"C",LRORD,LRODT)) Q:LRODT<1  S LRSN=0 F  S LRSN=$O(^LRO(69,"C",LRORD,LRODT,LRSN)) Q:LRSN<1  I $D(^LRO(69,LRODT,1,LRSN,0)) S $P(^(0),"^",11)=ORIFN
 I LRVERZ,$D(^LRO(69,LRODT,1,LRSN,0)) S $P(^(0),"^",11)=ORIFN
 Q
NA ;Set ORIFN at test level
 N I,X,LRODT,LRSN,LRORD,ORIFN,STARTDT,LRDUZ,PROV,REASON,QUANT
 D GET(.LRXORC,LRXORC) Q:LREND
 S I=0
 S X=$P($P(LRXMSG,"|",5),"^",4) I X S I=$O(^LRO(69,LRODT,1,LRSN,2,"B",X,0)) I I S $P(^LRO(69,LRODT,1,LRSN,2,I,0),"^",7)=ORIFN
 Q
GET(XMSG,XORC) ;Get identification data from message
 ;ORIFN= OE/RR order number
 ;STARTDT= Start D/T of order
 ;LRDUZ= Entered by Person (ptr to file 200)
 ;PROV= Ordering Provider
 ;REASON= Order control reason (e.g. inadequate specimen)
 ;QUANT= Quantity ordered
 ;LRORD=Lab Order #
 ;LRODT=Order date
 ;LRSN=Specimen Number
 ;LRVERZ=0 if only LRORD, 1 if LRODT,LRSN exists. Used to maintain backward compatibility at Tuscaloosa when only LRORD was used.
 N X,X1,I,J,CTR
 S X=$P(XMSG,"|",4),LRORD=+X,LRODT=+$P(X,";",2),LRSN=+$P(X,";",3),LRVERZ=$S(LRODT&LRSN:1,1:0)
 S LRPLACR=$P(XMSG,"|",3),ORIFN=+LRPLACR
 I 'ORIFN D ACK^LR7OF0("DE",XORC,"OE/RR order number not passed") S LREND=1 Q
 I '$O(XMSG(0)) S STARTDT=$$FMDATE^LR7OU0($P($P(XMSG,"|",8),"^",4)),LRDUZ=$P(XMSG,"|",11),PROV=$P(XMSG,"|",13),REASON=$P(XMSG,"|",17),QUANT=$P($P(XMSG,"|",8),"^") Q
 F CTR=1:1:$L(XMSG,"|") S X1(CTR)=$P(XMSG,"|",CTR)
 S J=0 F  S J=$O(XMSG(J)) Q:J<1  D
 . S I=1 I $E(XMSG(J))'="|" S X1(CTR)=X1(CTR)_$P(XMSG(J),"|"),I=I+1
 . F I=I:1:$L(XMSG(J),"|") S CTR=CTR+1,X1(CTR)=$P(XMSG(J),"|",I)
 S STARTDT=$$FMDATE^LR7OU0($P(X1(8),"^",4))
 S QUANT=$P(X1(8),"^")
 S LRDUZ=X1(11),PROV=X1(13),REASON=X1(17)
 Q
NTE ;Process Order comments from OE/RR
 ;MSG(i)="NTE|1|P|comment..."
 ;MSG(i,c)="...more comments..."
 N X,I,LINES
 S X=$D(STARTDT)&($D(TYPE))&($D(SAMP))&($D(SPEC))&($D(LRSX))
 I 'X Q  ;Trying to add comments to undefined test array in ^TMP
 I '$D(^TMP("OR",$J,"LROT",STARTDT,TYPE,SAMP,SPEC,LRSX)) Q  ;Trying to add comments to undefined test array in ^TMP
 S:'$D(^TMP("OR",$J,"COM",STARTDT,TYPE,SAMP,SPEC,LRSX)) ^(LRSX)=0 S LINES=^(LRSX)
 I $L($P(LRXMSG,"|",4)) D N1($P(LRXMSG,"|",4))
 S I=0 F  S I=$O(MSG(LINE,I)) Q:I<1  I $L(MSG(LINE,I)) D N1(MSG(LINE,I))
 Q
N1(X) ;
 S LINES=LINES+1,^TMP("OR",$J,"COM",STARTDT,TYPE,SAMP,SPEC,LRSX,LINES)=X,^TMP("OR",$J,"COM",STARTDT,TYPE,SAMP,SPEC,LRSX)=LINES
 Q
