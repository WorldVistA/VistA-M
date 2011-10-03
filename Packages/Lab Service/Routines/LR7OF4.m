LR7OF4 ;slc/dcm - Process messages from OE/RR ;8/11/97
 ;;5.2;LAB SERVICE;**121,187**;Sep 27, 1994
PURG ;Process Purge request for OBR Segment
 N TST,X,LRODT,LRSN,LRORD,LRORIFN,STARTDT,LRDUZ,PROV,REASON,QUANT,LREND
 S LREND=0
 D GET^LR7OF2(.LRXORC,LRXORC) Q:LREND
 I 'LRVERZ S LRODT=0 F  S LRODT=$O(^LRO(69,"C",LRORD,LRODT)) Q:LRODT<1  S LRSN=0 F  S LRSN=$O(^LRO(69,"C",LRORD,LRODT,LRSN)) Q:LRSN<1  D  Q
 . S X=$P($P(LRXMSG,"|",5),"^",4) I X S TST=$O(^LRO(69,LRODT,1,LRSN,2,"B",X,0)) I TST D P1(LRODT,LRSN,TST) Q:LREND
 I LRVERZ,$D(^LRO(69,LRODT,1,LRSN,0)) S X=$P($P(LRXMSG,"|",5),"^",4) I X S TST=$O(^LRO(69,LRODT,1,LRSN,2,"B",X,0)) I TST D P1(LRODT,LRSN,TST) Q:LREND
 I LREND D ACK^LR7OF0("ZU",LRXORC) Q
 D ACK^LR7OF0("ZR",LRXORC)
 Q
P1(LRODT,LRSN,TST) ;Check to purge
 N X
 I '$D(^LRO(69,LRODT,1,LRSN,0)) Q
 S X=+^LRO(69,LRODT,1,LRSN,0) I $D(^LR(X,0)),$P(X,"^",2)'=2 G P2
 I '$D(^LRO(69,LRODT,1,LRSN,1)) S LREND=1 Q
 I $D(^LRO(69,LRODT,1,LRSN,3)),'$L($P(^(3),"^",2)) S LREND=1 Q
P2 S:$D(^LRO(69,LRODT,1,LRSN,2,TST,0)) $P(^(0),"^",7)="P" ;P=flag for purged
 Q
PURG1 ;Process Purge request for ORC Segment
 N X,I,STOP S X=$P(LRXORC,"|",4),STOP=0
 S I=LINE F  S I=$O(MSG(I)) Q:I<1  I $P(MSG(I),"|")="OBR" S STOP=1 Q
 Q:STOP
 I $L(X,"^")>5 D ACK^LR7OF0("ZR",LRXORC) Q  ;Old unreleased 2.5 order
 I +X#1 D ACK^LR7OF0("ZR",LRXORC) Q  ;Old ORGY 2.5
 I +X,$P(X,"^",2),$P(X,"^",3) D ACK^LR7OF0("ZR",LRXORC) Q  ;Old unconverted 2.5
 I +X,$P(X,"^",2)="LRCH" D PURG Q  ;3.0 order with no tests (early tuscaloosa days)
 I 'X D ACK^LR7OF0("ZR",LRXORC) Q  ;Order with no lab pointers
 D ACK^LR7OF0("DE",LRXORC,"Unrecognized ID's :"_$P(LRXORC,"|",4))
 Q
