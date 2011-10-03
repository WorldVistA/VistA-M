IBARXMP ;LL/ELZ - PHARMCAY COPAY CAP PUSH TRANSACTION ;26-APR-2001
 ;;2.0;INTEGRATED BILLING;**150,158**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
PUSH ; this entry point will allow the user to select one or all transactions
 ; and transmit them to other treating facilities.  This is used to try
 ; to resolve untransmitted transactions.  First IRM should verify the
 ; HL7 link is working properly.
 ;
 N DIR,X,Y,DIRUT,DTOUT,DUOUT,DIROUT,IBER
 ;
 W !!,"This option will attempt to transmit un-transmitted copay cap transactions.",!,"You can select to send all un-transmitted transactions or selected"
 W !,"individual transactions.  If you choose All, it could tie up your terminal",!,"session for some time.",!
 S DIR(0)="S^A:All;I:Individual",DIR("A")="Do you want to transmit All or Individual transactions" D ^DIR Q:$D(DIRUT)
 ;
 D @Y
 Q
I ; transmits selected individual transactions
 N DIC,X,Y,IBZ,IBX,%,%Y,IBTFL,DFN,IBY,IBS,IBONE
 ;
 S DIC="^IBAM(354.71,",DIC(0)="AEMNQZ",IBS=+$P($$SITE^IBARXMU,"^",3),DIC("S")="I $E(^(0),1,3)=IBS" D ^DIC Q:Y<1
 S IBX=+Y,IBZ=Y(0),DFN=$P(IBZ,"^",2),IBTFL=$$TFL^IBARXMU(DFN,.IBTFL),IBY=1
 ;
 I IBTFL,($P(IBZ,"^",5)="C"!($P(IBZ,"^",5)="X")) W !!,"This transaction appears to already be transmitted.",!,"Do you want to transmit again" S %=2 D YN^DICN G:%'=1 I S IBONE=1
 ;
 I 'IBTFL W !!,"The patient for this transaction has no treating facilities to transmit to." D STATUS^IBARXMA(.IBY,IBX,0) G I
 ;
 D FOUND^IBARXMA(.IBY,IBX)
 ;
 U IO
 I '$D(IBER) W !,"Transmission Successful !!",!
 I $D(IBER) S X=0 F  S X=$O(IBER(X)) Q:'X  W !,"Error: ",X,"=",IBER(X)
 W ! K IBER
 ;
 G I
A ; transmits all un-transmitted transactions
 N IBX,IBS
 ;
 I '$D(^IBAM(354.71,"AC","P")),'$D(^("Y")) W !!,"No Un-transmitted records to send.",!! Q
 ;
 F IBS="P","Y" S IBX=0 F  S IBX=$O(^IBAM(354.71,"AC",IBS,IBX)) Q:IBX<1  D
 . N IBER,IBY,IBZ,DFN
 . S IBY=1,IBZ=^IBAM(354.71,IBX,0),DFN=$P(IBZ,"^",2)
 . W !,"Now transmitting ",$P(IBZ,"^")
 . D FOUND^IBARXMA(.IBY,IBX)
 . U IO
 . I '$D(IBER) W !,"Transmission Successful !!",! Q
 . I $D(IBER) S X=0 F  S X=$O(IBER(X)) Q:'X  W !,"Error: ",IBER(X)
 . W ! K IBER
 Q
