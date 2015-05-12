FBAAMPG1 ;AISC/DMK/CMR-PURGE TRANSMITTED MRA'S ;5/24/1999
 ;;3.5;FEE BASIS;**18,123**;JAN 30, 1995;Build 51
 ;;Per VA Directive 6402, this routine should not be modified.
 S:'$D(DTIME) DTIME=999 I '$D(DT) S %DT="",X=T D ^%DT S DT=Y K X,Y
 I '$D(^FBAA(161.25,"AD")),'$D(^FBAA(161.26,"AD")),'$D(^FBAA(161.96,"AD")) G END
 S (CNT,MCNT,ICNT)=0
 F I=0:0 S I=$O(^FBAA(161.26,"AD",I)) Q:I'>0!(I>DT)  F J=0:0 S J=$O(^FBAA(161.26,"AD",I,J)) Q:J'>0  I $D(^FBAA(161.26,J,0)) S DA=J D DELVET S CNT=CNT+1
 F I=0:0 S I=$O(^FBAA(161.96,"AD",I)) Q:I'>0!(I>DT)  F J=0:0 S J=$O(^FBAA(161.96,"AD",I,J)) Q:J'>0  I $D(^FBAA(161.96,J,0)) S DA=J D DELIA S ICNT=ICNT+1
 F I=0:0 S I=$O(^FBAA(161.25,"AD",I)) Q:I'>0!(I>DT)  F J="O","P" F K=0:0 S K=$O(^FBAA(161.25,"AD",I,J,K)) Q:K'>0  I $D(^FBAA(161.25,K,0)),($S($P(^(0),"^",3)="C":0,$P(^(0),"^",2)="C":0,$P(^(0),"^",3)="N":0,$P(^(0),"^",2)="N":0,1:1)) D
 .S DA=K D DELVEN S MCNT=MCNT+1
 F I="O","P" F J=0:0 S J=$O(^FBAA(161.25,"AE",I,J)) Q:'J  I $D(^FBAA(161.25,J,0)),'$D(^FBAAV(J,0)) S DA=J D DELVEN S MCNT=MCNT+1
 F I=0:0 S I=$O(^FBAA(161.26,"AC","P",I)) Q:'I  I $D(^FBAA(161.26,I,0)) S J=+$P(^(0),"^",3) I '$D(^FBAAA(+^FBAA(161.26,I,0),1,J,0)) S DA=I D DELVET S CNT=CNT+1
 ;
 ; check pending IPAC MRAs and remove any records that have bad IPAC vendor agreement pointers
 F I=0:0 S I=$O(^FBAA(161.96,"AS","P",I)) Q:'I  D
 . N IVA
 . S IVA=+$P($G(^FBAA(161.96,I,0)),U,2)   ; IPAC vendor agreement ptr
 . I $D(^FBAA(161.95,IVA,0)) Q            ; its OK so quit
 . S DA=I D DELIA S ICNT=ICNT+1           ; kill it
 . Q
 ;
BULLET S XMB(1)=CNT,XMB(2)=MCNT,XMB(3)=ICNT,XMB="FBAA PURGE TRANSMITTED MRA'S",XMDUZ=$S($G(DUZ):DUZ,1:.5) D ^XMB
END K F,I,J,K,CNT,MCNT,FBAAPD,X,Y,ICNT Q
 ;
DELVET S DIK="^FBAA(161.26," D ^DIK Q
DELVEN S DIK="^FBAA(161.25," D ^DIK Q
DELIA S DIK="^FBAA(161.96," D ^DIK Q
