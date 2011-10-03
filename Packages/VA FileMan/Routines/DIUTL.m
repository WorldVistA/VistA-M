DIUTL ;GFT;01:02 PM  8 Apr 2001
 ;;22.0;VA FileMan;**76**;Mar 30, 1999
 ;
WP(DIRF,DIWL,DIWR) ;Write out WP field (if any) stored at DIRF
 N DIWF,Z,A1,D,X,DIW,DIWT,DN,I
 K ^UTILITY($J,"W")
 S DIWF="W|" S:'$G(IOM) IOM=80 S:'$G(DIWR) DIWR=IOM S:'$G(DIWL) DIWL=1
 S A1=$P($G(@DIRF@(0)),U,3) F D=0:0 S D=$O(@DIRF@(D)) Q:D>A1&A1!'D  S X=^(D,0) D ^DIWP G QWP:$G(DN)=0
 D ^DIWW
QWP I $G(DN)'=0 Q 1
 K DIOEND Q 0
 ;
IJ(N) ;build I & J arrays given subfile number N
 N A K I,J
 S J(0)=N,N=0
0 I $D(^DIC(J(0),0,"GL")) S I(0)=^("GL") Q
 S A=$G(^DD(J(0),0,"UP")) Q:A=""
 S I=$O(^DD(A,"SB",J(0),0)) Q:'I
 S I=$P($P($G(^DD(A,I,0)),U,4),";") Q:I=""
 I +I'=I S I=""""_I_""""
 F J=N:-1:0 S J(J+1)=J(J) S:J I(J+1)=I(J)
 S J(0)=A,I(1)=I,N=N+1 G 0
 ;
 ;
DIVR(DI,DIFLD) ;verify
 N DIVZ,S,A,DA,DICL,V,Z,DDC,DR,N,Y,I,J,Q,W,V,T,DQI
 K ^UTILITY("DIVR",$J),^DD(U,$J)
 D IJ(DI)
 I '$O(@(I(0)_"0)")) Q  ;File must have some entries!
 S S=";",Q="""",V=$O(J(""),-1),A=DI,DA=DIFLD
 S DR=$P(^DD(DI,DIFLD,0),U,2),Z=$P(^(0),U,3),$P(Y(0),U,4)=$P(^(0),U,4),DDC=$P(^(0),U,5,999)
 Q:DR["W"!(DR["C")
 F T="N","S","V","P","K","F" Q:DR[T
 W !!,"SINCE YOU HAVE CHANGED THE FIELD DEFINITION,",!,"EXISTING '",$P(^(0),U),"' DATA WILL NOW BE CHECKED FOR INCONSISTENCIES",!,"OK"
 S %=1 D YN^DICN Q:%-1
 ;D ^%ZIS Q:POP
 ;U IO   WON'T WORK BECAUSE Q+3^DIVR ASKS TO STORE IN TEMPLATE
 D ^DIVR
 ;D ^%ZISC
 Q
