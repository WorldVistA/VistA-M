FBAAMPRG ;AISC/DMK-PURGE TRANSMITTED MRA'S ;5/24/1999
 ;;3.5;FEE BASIS;**18,123**;JAN 30, 1995;Build 51
 ;;Per VA Directive 6402, this routine should not be modified.
ASK W !! S %DT("A")="Purge Veteran, IPAC and Vendor MRA's transmitted PRIOR to: ",%DT="AEXP",%DT(0)=-DT D ^%DT K %DT G END:X="^"!(X=""),ASK:Y<0 S FBAAPD=Y
 N DA,DIK
 I '$D(^FBAA(161.25,"AD")),'$D(^FBAA(161.26,"AD")),'$D(^FBAA(161.96,"AD")) W !!,*7,"No transmitted MRA's currently on file!",! G END
 S (CNT,MCNT,ICNT)=0 W !,?25,"Deleting....",!
 F I=0:0 S I=$O(^FBAA(161.26,"AD",I)) Q:I'>0!(I>FBAAPD)  F J=0:0 S J=$O(^FBAA(161.26,"AD",I,J)) Q:J'>0  I $D(^FBAA(161.26,J,0)) S DA=J D DELVET S CNT=CNT+1
 F I=0:0 S I=$O(^FBAA(161.96,"AD",I)) Q:I'>0!(I>FBAAPD)  F J=0:0 S J=$O(^FBAA(161.96,"AD",I,J)) Q:J'>0  I $D(^FBAA(161.96,J,0)) S DA=J D DELIPAC S ICNT=ICNT+1
 F I=0:0 S I=$O(^FBAA(161.25,"AD",I)) Q:I'>0!(I>FBAAPD)  F J="O","P" F K=0:0 S K=$O(^FBAA(161.25,"AD",I,J,K)) Q:K'>0  I $D(^FBAA(161.25,K,0)),($S($P(^(0),"^",3)="C":0,$P(^(0),"^",2)="C":0,$P(^(0),"^",3)="N":0,$P(^(0),"^",2)="N":0,1:1)) D
 .S DA=K D DELVEN S MCNT=MCNT+1
 F I="O","P" F J=0:0 S J=$O(^FBAA(161.25,"AE",I,J)) Q:'J  I $D(^FBAA(161.25,J,0)),'$D(^FBAAV(J,0)) S DA=J D DELVEN S MCNT=MCNT+1
 F I=0:0 S I=$O(^FBAA(161.26,"AC","P",I)) Q:'I  I $D(^FBAA(161.26,I,0)) S J=+$P(^(0),"^",3) I '$D(^FBAAA(+^FBAA(161.26,I,0),1,J,0)) S DA=I D DELVET S CNT=CNT+1
 ;
 ; check pending IPAC MRAs and remove any records that have bad IPAC vendor agreement pointers
 F I=0:0 S I=$O(^FBAA(161.96,"AS","P",I)) Q:'I  D
 . N IVA
 . S IVA=$P($G(^FBAA(161.96,I,0)),U,2)          ; IPAC vendor agreement ptr
 . Q:IVA=""                                     ; MRA record for a delete
 . I $D(^FBAA(161.95,IVA,0)) Q            ; its OK so quit
 . S DA=I D DELIPAC S ICNT=ICNT+1         ; kill it
 . Q
 ;
 W !!,?16,"Total Veteran MRA's deleted: ",CNT,!,?16,"Total Vendor MRA's deleted: ",MCNT,!,?16,"Total IPAC MRA's deleted: ",ICNT,!
END K F,I,J,K,CNT,MCNT,FBAAPD,X,Y,ICNT Q
 ;
DELVET S DIK="^FBAA(161.26," D ^DIK Q
DELVEN S DIK="^FBAA(161.25," D ^DIK Q
DELIPAC S DIK="^FBAA(161.96," D ^DIK Q
