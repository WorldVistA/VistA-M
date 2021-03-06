MCARBSA ;WISC/TJK,RCH-COMPUTE BODY SURFACE AREA .001*71.84*((WT/2.2)**.425*(HT*2.5)**.725) ;5/2/96  13:53
 ;;2.3;Medicine;;09/13/1996
 N BS
 Q:'$D(^MCAR(691,DA,13))  S BS=^(13),WT=$P(BS,U,1),HT=$P(BS,U,2)
 Q:(WT="")!(HT="")  D COMPUTE S $P(BS,U,3)=X,^MCAR(691,DA,13)=BS
A I $D(DJDN) S V(7)=X,DJVV=7 D EN^MCARDNJ1 K DJVV
 Q
CATH S BS=^MCAR(691.1,DA,0),WT=$P(BS,U,7),HT=$P(BS,U,8)
 Q:(WT="")!(HT="")  D COMPUTE S $P(BS,U,9)=X,^MCAR(691.1,DA,0)=BS K BS
B I $D(DJDN) S V(8)=X,DJVV=8 D EN^MCARDNJ1 K DJVV
 Q
RISK S BS=^MCAR(694.5,DA,0),WT=$P(BS,U,7),HT=$P(BS,U,5)
 D RISK1:(WT="")!(HT="")
 Q:(WT="")!(HT="")  D COMPUTE S $P(BS,U,9)=X,^MCAR(694.5,DA,0)=BS K BS
 Q
RISK1 I '$P(BS,U,5),$P(BS,U,6) S HT=$P(BS,U,6)/2.5,$P(BS,U,5)=HT
 I '$P(BS,U,7),$P(BS,U,8) S WT=$P(BS,U,8)*2.2,$P(BS,U,7)=WT
 Q
COMPUTE ;
 S MCARX=WT/2.2 D LN S MCARX=MCARR*0.425 D EXP S MCARW=MCARR
 S MCARX=HT*2.5 D LN S MCARX=MCARR*0.725 D EXP
 S X=(0.0001)*(71.84)*(MCARW*MCARR),X=$J(X,4,2) K MCARR,MCARW,MCARX,WT,HT
 Q
LN ;
 S F=MCARX,(LN,D)=0 Q:MCARX'>0
LN2 I F'<1 S F=.5*F,D=D+1 G LN2
LN3 I F<.5 S F=2*F,D=D-1 G LN3
 S F=(F-.707107)/(F+.707107),LN=F*F
 S LN=(((.598979*LN+.961471)*LN+2.88539)*F+D-.5)*.693147
 S MCARR=LN K LN,D,F Q
EXP ;
 S X=MCARX,E=0,B=1.4427*X\1+1 Q:B>90
 S E=.693147*B-X,A=.00132988-(.000141316*E)
 S A=((A*E-.00830136)*E+.0416574)*E
 S E=(((A-.166665)*E+.5)*E-1)*E+1,A=2
 I B'>0 S A=.5,B=-B
 F I=1:1:B S E=A*E
 S MCARR=+E K A,B,I,E,X Q
