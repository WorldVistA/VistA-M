IBAUTL1 ;ALB/AAS - IB UTILITY ROUTINE FOR MEDICARE RATES ; 30-AUG-91
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
RATE ;  - Calculates the Medicare rate for a CPT code.
 ;  - Input  X = visit date ^ division ^ ifn of cpt code
 ;  - Output Y = charge
 ;
 S IBX=X N X S X=IBX
 S IBRG=$O(^IBE(350.4,"AIVDT",+$P(X,"^",3),-($P(X,"^")+1))) I IBRG S IBRG=$O(^(+IBRG,0)) ;determine current ib action type for code
 I $S('IBRG:1,'$D(^IBE(350.4,+IBRG,0)):1,'$P(^(0),"^",3):1,1:0) S Y=-1 G RATEQ
 S IBRG=+$P(^IBE(350.4,IBRG,0),"^",3)
 S DA=$O(^IBE(350.2,"AIVDT",IBRG,-($P(X,"^")+1))) I DA S DA=$O(^(+DA,0)) ; determine current ib action charge for rate group
 I $S('DA:1,'$D(^IBE(350.2,DA,10)):1,1:0) S Y=-1 G RATEQ
 X ^IBE(350.2,DA,10)
RATEQ K IBRG,IBX
 Q
 ;
VAR ;  -Called by entries in 350.2 to get variables
 ;  -input x=visit date^division ifn
 ;        da=internal number from 350.2
 ;  -output y=wage%^non-wage%^locality multiplier
 ;
 S IBLOC=$O(^IBE(350.5,"AIVDT",+$P(X,"^",2),-($P(X,"^")+1))) I IBLOC S IBLOC=$O(^(+IBLOC,0))
 I $S('IBLOC:1,'$D(^IBE(350.5,+IBLOC,0)):1,'$P(^(0),"^",7):1,1:0) S Y=-1 G VARQ
 S Y=$P(^IBE(350.5,IBLOC,0),"^",5,7)
VARQ K IBLOC,IBWAG Q
 ;
TEST S DA=14,X=DT_"^1^10141" D RATE ;X ^IBE(350.2,DA,10) W X," ",Y
