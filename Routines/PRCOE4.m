PRCOE4 ;WISC/DJM-IFCAP SEGMENTS AC ;7/28/96  16:17
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
AC(A,A1,VAR1,VAR2) ;ACCOUNTING INFORMATION SEGMENT
 N A23,B,D,DDS,DIS,E,ES,FOB,G,GBL,NET,PC,Q,X,X1,X2,X2D,X2M,X2Y
 S FOB=$S($P(A1,U,6)]"":$P(A1,U,6),1:"D")
 S B="AC^^"_FOB_"^^"
 ;
 S ES=$P(A,U,13),ES=$$VDEC^PRCOEDI(ES,2)
 S GBL=$G(^PRC(442,VAR1,12))
 I FOB="O",$P(GBL,U,7)="" S $P(B,U,2)=ES
 ;
 S Q=$P($G(^PRC(442,VAR1,5,0)),U,4)
 I Q'>0 S B=B_"^30^N^" G AC1
 ;
 S A23=$G(^PRC(442,VAR1,23))
 I $P(A23,U,11)'="P",+A1>0,Q'>0 I $D(^PRC(440,+A1,3)),$P(^(3),U,2)="Y" S VAR2="NPPT" Q
 S (D,E)=""
 F  S D=$O(^PRC(442,VAR1,5,D)) Q:D=""  D
 . S DIS(D)=$G(^PRC(442,VAR1,5,D,0))
 . I +$P(DIS(D),U)=$P(DIS(D),U) S E=$S(E]"":E_"^"_D,1:D)
 I E]"" D  G AC1
 . S G=$P(E,U),PC=$P(DIS(G),U)*100
 . S:$L(PC)=1 PC="0"_PC
 . S B=B_PC_"^"
 . D AC2
 . S B=B_DDS_"^^"
 ;
 S B=B_"^" D AC2 S B=B_DDS_"^N^"
 ;
AC1 S NET=$P(A,U,16)
 I NET=""!($P($G(^PRC(442,VAR1,7)),"^",1)+0=45) S NET=0
 S NET=$TR($J(NET,10,2)," .","0")
 S B=B_NET_"^"_$E($P($P(A,U,4),"."),4,99)_"^^^"_$P(A,U,5)_"^"_$P($P(A,U,3)," ")_"^^^^^^|"
 S ^TMP($J,"STRING",6)=B
 Q
 ;
AC2 I E]"" S DDS=DIS(G)
 I E="" S DDS=$O(DIS(0)),DDS=DIS(DDS)
 S DDS=$P(DDS,U,2) S:DDS="" DDS=30 Q:+DDS=DDS
 I '$G(DT) D NOW^%DTC K %,%I,%H
 S DDS=+DDS
 S X2=$S($G(DT):DT,1:X),X2Y=$E(X2,1,3),X2M=$E(X2,4,5),X2D=$E(X2,6,7)
 I DDS>X2D S X1=X2Y_X2M_DDS G AC3
 S X2M=X2M+1 S:X2M>12 X2M=1,X2Y=X2Y+1 S X1=X2Y_X2M_DDS
AC3 D ^%DTC S DDS=X K %Y,X Q
