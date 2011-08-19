DGRPDD1 ;ALB/JDS - INPUT SYNTAX CHECKS - FORMERLY DGINP ; 9/23/04 6:04pm
 ;;5.3;Registration;**72,136,244,621**;AUG 13, 1993
 ;
 ;  NOTE: THIS USED TO BE NAMED 'DGINP'
 ;                               -----
 ;
INPUT ; from 7.5 node to massage input before input transform
 I X?.N1"/"1N.ANP D BCDFN^RTDPA Q  ; check for RT label scan
 Q
 ;
SSN I X'?.AN F %=1:1:$L(X) I $E(X,%)?1P S X=$E(X,0,%-1)_$E(X,%+1,999),%=%-1
 I X="P"!(X="p") D PSEU S X=L K L W:'$D(ZTQUEUED) "  ",X G SSNQ
 I X["P",'$D(DPTZNV) D PSEU I X'=L K X,L W:'$D(ZTQUEUED) *7,"  Invalid pseudo SSN.",!,"Type 'P' for the valid one" Q
 I X["P",$D(DPTZNV) D PSEU I X'=L S X=L W:'$D(ZTQUEUED) !!,$C(7),"Pseudo SSN adjusted to match edited name value ==> ",X,!
 G SSNQ:X["P" I X'?9N K X Q
 I $G(DIUTIL)'="VERIFY FIELDS" S DGY=$O(^DPT("SSN",X,0)) I DGY>0,$D(^DPT(DGY,0)) W:'$D(ZTQUEUED) *7,"  Already used by patient '",$P(^(0),"^",1),"'." K X Q
 I $D(X) S L=$E(X,1) I L=9 W:'$D(ZTQUEUED) *7,!,"  The SSN must not begin with 9." K X Q
 I $D(X),$E(X,1,3)="000",$E(X,1,5)'="00000" W:'$D(ZTQUEUED) *7,!,"   First three digits cannot be zeros." K X Q
 I $D(X) S L=$E(X,1,3) I (L>699)&(L<729) W:'$D(ZTQUEUED) !,*7,!,"      Note: This is a RR Retirement SSN."
 I $D(X),$E(X,1,5)="00000" W:'$D(ZTQUEUED) !,*7,!,"      Note: This is a Test Patient SSN."
SSNQ D:$D(X) S^DGPATN Q
C I $D(X) S L=$P(^DPT(DA,0),U,9) I $L(L)=9,X'=L S Y=L_"00" D COL
 K L Q:'$D(X)  Q:X'?11N!(X["P")  S L=0 F Y=0:0 S Y=$O(^DPT("BS",$E(X,6,9),Y)) Q:Y'>0  I Y-DA,$D(^DPT(Y,0)),$P(^(0),U,9)=$E(X,1,9) S L=1 Q
 I L W:'$D(ZTQUEUED) " Collateral of ",$P(^DPT(Y,0),U,1) K L Q
 W:'$D(ZTQUEUED) !,"Must have same SSN to be collateral" K X,L Q
PSEU I $D(DPTIDS(.03)),$D(DPTX) S NAM=DPTX,DOB=DPTIDS(.03)
 E  S L=^DPT(DA,0),DOB=$P(L,"^",3),NAM=$P(L,"^",1)
 ; DG*5.3*621
 I DOB="" S DOB=2000000
 S L1=$E($P(NAM," ",2),1),L3=$E(NAM,1),NAM=$P(NAM,",",2),L2=$E(NAM,1)
 S Z=L1 D CON S L1=Z,Z=L2 D CON S L2=Z,Z=L3 D CON S L3=Z S L=L2_L1_L3_$E(DOB,4,7)_$E(DOB,2,3)_"P"
 K L1,L2,L3,Z,DOB,NAM Q
COL S Y=$O(^DPT("SSN",Y)) Q:$E(Y,1,9)'=L  I $L(Y)=11,$E(Y,1,9)=L S Z=$O(^(Y,0)) I $D(^DPT(Z,0)) W:'$D(ZTQUEUED) !,"Has collateral ",$P(^(0),U,1)," be sure to change SSN" K Z G COL
 Q
CON S Z=$A(Z)-65\3+1 S:Z<0 Z=0 Q
 ;
CAT S L=^DPT(DA,0),DOB=+$P(L,"^",3),AGE=DT-DOB\10000,X1=^DIC(45.82,+Y,0),EDB=+$P(X1,U,4),LDB=+$P(X1,U,5),EAG=+$P(X1,U,6)
 I EDB>0,DOB<EDB W:'$D(ZTQUEUED) !!,"The date of birth is too early for the selected category of beneficiary",!,"Make another selection or correct the date of birth.",!!,*7 K X G CATQ
 I LDB>0,DOB>LDB W:'$D(ZTQUEUED) !!,"The date of birth is too late for the selected category of beneficiary.",!,"Make another selection or correct the date of birth.",!!,*7 K X G CATQ
 I EAG>0,AGE<EAG W:'$D(ZTQUEUED) !!,"The patient's age is too young for the selected category of beneficiary.",!,"Make another selection or correct the date of birth.",!!,*7 K X G CATQ
CATQ K EAG,AGE,DOB,LDB,EDB,X1 Q
 ;
VIET Q
POS S L=^DPT(DA,0),Y=+$P(L,"^",3) I X-Y\10000<15 X ^DD("DD") W:'$D(ZTQUEUED) !!,"This service entry date would make the patient too young for service.",!,"DOB ",Y,!,*7 K X G POSQ
 G POSQ:SD1=1!'$D(^DPT(DA,.32)) S L1=^(.32) I $P(L1,"^",SD1-1*5+1)="" W:'$D(ZTQUEUED) !?5,"Previous service entry date is not on file",*7 G POSQ
 S Y=$P(L1,U,6) I SD1=2,X'<Y X ^DD("DD") W:'$D(ZTQUEUED) !!,"This service entry date must be before than the first service entry date ",Y,!!,*7 K X G POSQ
 S Y=$P(L1,U,11) I SD1=3,X'<Y X ^DD("DD") W:'$D(ZTQUEUED) !!,"This service entry date must be less than the second service entry date ",Y,!!,*7 K X G POSQ
POSQ K L1,L,DOB,AGE,SD1 Q
 ;
PS S L1=$S($D(^DPT(DA,.32)):^(.32),1:"") G PS2:SD1=2,PS3:SD1=3 S Y=$P(L1,U,6) I X'>Y X ^DD("DD") W:'$D(ZTQUEUED) !!,"The service separation date must be after the entry date ",Y,!!,*7 K X G PSQ
 ;
 G PSQ
PS2 S Y=$P(L1,U,11) I X'>Y X ^DD("DD") W:'$D(ZTQUEUED) !!,"The service separation date must be after the service entry date ",Y,!!,*7 K X G PSQ
 S Y=$P(L1,U,6) I Y,X'<Y X ^DD("DD") W:'$D(ZTQUEUED) !!,"This service separation date must be before the next service entry date ",Y,!!,*7 K X G PSQ
 G PSQ
PS3 S Y=$P(L1,U,16) I X'>Y X ^DD("DD") W:'$D(ZTQUEUED) !!,"The service separation date must be after the service entry date ",Y,!!,*7 K X G PSQ
 S Y=$P(L1,U,11) I X'<Y X ^DD("DD") W:'$D(ZTQUEUED) !!,"The service separation date must be before the next service entry date ",Y,!!,*7 K X G POSQ
PSQ K L1,SD1 Q
CAT1 S DDA=DA,DA=+^DGPT(DA,0) D CAT S DA=DDA K DDA Q
