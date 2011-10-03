FBAARMRA ;AISC/DMK-RETRANSMIT MRS's FOR A DATE ;25OCT89
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
ASK W !! S %DT("A")="Re-transmit MRA's for which date: ",%DT="AEXP",%DT(0)=-DT D ^%DT K %DT(0),%DT("A") G END:X="^"!(X=""),ASK:Y<0 S FBAATD=Y
 I '$D(^FBAA(161.25,"AD",FBAATD)),'$D(^FBAA(161.26,"AD",FBAATD)) W !!,*7,"No MRA's were transmitted on that date!" G ASK
 D VEND:$D(^FBAA(161.25,"AD",FBAATD)),VET:$D(^FBAA(161.26,"AD",FBAATD))
 D RTRAN^FBAAV0
END K D0,FBAATD,OCTD,J,K,XCNP,VAT Q
VEND F J="O","P" F K=0:0 S K=$O(^FBAA(161.25,"AD",FBAATD,J,K)) Q:K'>0  I $D(^FBAA(161.25,K)) S $P(^(K,0),"^",5)="",^FBAA(161.25,"AE",J,K)="" K ^FBAA(161.25,"AD",FBAATD,J,K)
 Q
VET W !!,?20,"Re-Transmitting",! F K=0:0 S K=$O(^FBAA(161.26,"AD",FBAATD,K)) Q:K'>0  I $D(^FBAA(161.26,K)) S $P(^(K,0),"^",5)="",$P(^(0),"^",2)="P",^FBAA(161.26,"AC","P",K)="" K ^FBAA(161.26,"AD",FBAATD,K),^FBAA(161.26,"AC","T",K)
 Q
