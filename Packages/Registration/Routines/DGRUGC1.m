DGRUGC1 ;ALB/MLI - CREATE A PAI CONTINUED ; 26 JULY 88
 ;;5.3;Registration;**89**;Aug 13, 1993
SELECT S (J,DGCT,DGFL,DGFT)=0 F I=1:1:DGNO F J=0:0 S J=$O(^UTILITY($J,"DTS",I,J)) Q:J'>0  S K=$O(^UTILITY($J,"DTS",I,J,0)) W !,?5,I,")",?12 S DGCT=DGCT+1,Y=K D DT^DIQ W:$P(^(K),U,3)="*" " -- ADMISSION DATE" D:'(DGCT#5) PRT5 G:DGFL!$D(DGD) QUIT
 S DGFT=1
PRT5 W !!,"CHOOSE 1-",DGCT,!,"'^' TO EXIT" W:DGCT<DGNO !,"RETURN FOR MORE CHOICES" R ": ",X:DTIME S:X="^"!'$T DGFL=1 Q:DGFL!(X=""&'DGFT)  G:+X'=X!(X<1)!(X>DGCT) PRT5 S J=$O(^UTILITY($J,"DTS",X,0)),K=$O(^UTILITY($J,"DTS",X,J,0)),DGD=K,DGI=^(K)
QUIT Q
ASD I '$D(DGD) S DGD=$G(X)
 S DFN=+^DG(45.9,DA,0) I $D(^DG(45.9,"AD",DFN,X))&($P(^DG(45.9,DA,0),U,2)'=X) K X W !,"There is already a PAF entry for that date."
 I $D(X),$D(DGSEMI) S DGAD=$E(X,4,7) I $S(DGAD<301:1,DGAD>1130:1,DGAD>500&(DGAD<901):1,1:0) W !,*7,"Assessment date must be within a month of the semi-annual census date" K X
 I $D(X),X<$P(DGD,".",1) K X W !!,"The assessment date must not be before the date of admission/transfer in."
 S DGCNV=$S($D(^DG(43,1,"RUG")):+$P(^("RUG"),"^",2),1:0) I 'DGCNV!'$D(X) K DGAD,DGCNV Q
 S DGAD=$P(^DG(45.9,DA,0),"^",2) I DGAD,(DGAD<DGCNV),(X'<DGCNV) K X W !!,"Assessment date can not be changed to after the RUG17 conversion date.  Must remain before " S Y=DGCNV X ^DD("DD") W Y
 I $D(X),(DGAD'<DGCNV),(X<DGCNV) K X W !!,"Assessment date can not be changed to prior to conversion.  Date must be on or after " S Y=DGCNV X ^DD("DD") W Y
 K DGAD,DGCNV Q
HM S DGMINIM=$S($L(X)<3:X,$L(X)=3:$E(X,2,3),1:$E(X,3,4)) I DGMINIM>59 W !,*7,"Can not have more than 59 minutes of therapy" K X
 K DGMINIM Q
