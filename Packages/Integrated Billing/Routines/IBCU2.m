IBCU2 ;ALB/MRL - BILLING UTILITY ROUTINE (CONTINUED) ;01 JUN 88 12:00
 ;;2.0;INTEGRATED BILLING;**137,287**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;MAP TO DGCRU2
 ;
TC D TCL
 N DA,X,Y
 F DGJ=0:0 S DGJ=$O(^DD(399,201,1,DGJ)) Q:'DGJ  I $D(^DD(399,201,1,DGJ,DGXRF)) S DA=DGI(1),X=DGTCX1 X ^(DGXRF)
 K DGI,DGJ,DGXRF,DGTCX,DGTCX1,DGTCX2
 Q
 ;
TCL S (DGTCX,DGTCX2)=0 F DGTCX1=0:0 S DGTCX1=$O(^DGCR(399,DA(1),"RC",DGTCX1)) Q:'DGTCX1  I $D(^DGCR(399,DA(1),"RC",DGTCX1,0)),DGTCX1'=DA S DGTCX=DGTCX+$P(^(0),"^",4)
 I DGXRF=1 S DGTCX1=DGTCX+X
 E  S DGTCX1=DGTCX
 S $P(^DGCR(399,DA(1),"U1"),"^",1)=DGTCX1,DGI=DA,DGI(1)=DA(1),DGTCX=X
 Q
 ;
TC1 F DGJ1=0:0 S DGJ1=$O(^DD(399.042,.04,1,DGJ1)) Q:'DGJ1  I $D(^DD(399.042,.04,1,DGJ1,DGXRF1)) S X=DGTCX11 X ^(DGXRF1)
 S X=DGTCX11 K DGJ1,DGXRF11,DGTCX11
 Q
 ;
FY ;S DGTCX1=$S($D(^DGCR(399,DA,"U1")):^("U1"),1:0) I +X>+DGTCX1 W !?4,*7,"Exceeds 'Total Charges' for this bill." K X Q
 ;W !?4,"Edit revenue codes/from-to dates if appropriate." K X Q
 Q
 ;
21 ;set logic for CHARGES subfield x-ref (399.042;.02)
 I $P(^DGCR(399,DA(1),"RC",DA,0),"^",3)="" S $P(^DGCR(399,DA(1),"RC",DA,0),"^",3)=$S($P(^DGCR(399,DA(1),0),"^",5)<3:$P(^("U"),"^",15),$D(^DGCR(399,DA(1),"OP",0)):$P(^(0),"^",4),1:1)
 S Z=X,Z1=$P(^DGCR(399,DA(1),"RC",DA,0),"^",3) S DGTCX11=Z*Z1,$P(^(0),"^",4)=DGTCX11,DGXRF1=1 D TC1
 Q
 ;
22 ;kill logic for CHARGES subfield x-ref (399.042;.02)
 S Z=X,Z1=$P(^DGCR(399,DA(1),"RC",DA,0),"^",3) S DGTCX11=Z*Z1,$P(^(0),"^",4)=DGTCX11,DGXRF1=2 D TC1
 Q
 ;
31 ;set logic for UNITS OF SERVICE subfield x-ref (399.042;.03)
 S Z=X,Z1=$P(^DGCR(399,DA(1),"RC",DA,0),"^",2) S DGTCX11=Z*Z1,$P(^(0),"^",4)=DGTCX11,DGXRF1=1 D TC1
 Q
 ;
32 ;kill logic for UNITS OF SERVICE subfield x-ref (399.042;.03)
 S Z=X,Z1=$P(^DGCR(399,DA(1),"RC",DA,0),"^",2) S DGTCX11=Z*Z1,$P(^(0),"^",4)=DGTCX11,DGXRF1=2 D TC1
 Q
 ;
FMDATES(PROMPT) ; ask for date range
 N %DT,X,Y,DT1,DT2,IB1,IB2  S DT1="",IB1="START WITH DATE ENTERED: ",IB2="GO TO DATE ENTERED: "
 I $G(PROMPT)'="" S IB1="START WITH "_PROMPT_": ",IB2="GO TO "_PROMPT_": "
 S %DT="AEX",%DT("A")=IB1 D ^%DT K %DT I Y<0!($P(Y,".",1)'?7N) G FMDQ
 S (%DT(0),DT2)=$P(Y,".",1) I DT2'>DT S %DT("B")="TODAY"
 S %DT="AEX",%DT("A")=IB2 D ^%DT K %DT I Y<0!($P(Y,".",1)'?7N) G FMDQ
 S DT1=DT2_"^"_$P(Y,".",1)
FMDQ Q DT1
 ;
