PRCEADJ2 ;WISC/CLH/CTB-PRCEADJ1 CONT ; 21 Apr 93  8:32 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 N TI,PRCFASYS,IOINLOW,IOINHI,IOINORM,DIR,AMT,OLDTT,CS,HASH,DIE,DR,LAUTH,LBAL,TAUTH,TBAL,DLAYGO
 D SCREEN S DIR("A")="Ok to continue",DIR("B")="Yes",DIR(0)="Y",DIR("?")="Press <RETURN> to continue processing" D ^DIR I 'Y G OUT
 S AMT=$P(TRNODE(4),U,8)
 D OLDTT^PRCH58OB(PODA,.X) S OLDTT=X
 K PRCFA("TT") I X="921.60" S PRCFA("TT")=$S(AMT<0:"921.33",1:"921.31") G K
 I X="921.10" S PRCFA("TT")=$S(AMT<0:"921.32",1:"921.30") G K
 I X="921.71" S PRCFA("TT")=$S(AMT<0:"921.73",1:"921.72")
K S PRCFA("REF")=$P($P(PO(0),"^"),"-",2),PRCFA("SYS")="CLM" D TT^PRCFAC G:'% OUT D NEWCS^PRCFAC G:'$D(DA) OUT
 S PRC("CP")=$P(TRNODE(0),"-",4),CS=$S($D(^PRCF(423,PRCFA("CSDA"),1)):^(1),1:""),$P(CS,"^")="..",$P(CS,"^",5,7)=PRC("CP")_"^"_+$P(PO(0),"^",5)_"^^"
 F I=7,9 S AMT(I)=$P(TRNODE(3),"^",I) S:AMT(I)<0 AMT(I)=-AMT(I) S AMT(I)=AMT(I)*100
 S $P(CS,"^",16)="$",$P(CS,"^",8,11)=+$P(TRNODE(3),"^",6)_"^"_AMT(7)_"^$^" I OLDTT'="921.60",+$P(TRNODE(3),"^",8)>0,AMT(9)>0 S $P(CS,"^",10,11)=$P(TRNODE(3),"^",8)_"^"_AMT(9)
 S ^PRCF(423,PRCFA("CSDA"),1)=CS
Y D ^PRCFA921,^PRCFACXM I $D(PRCFDEL)!($D(PRCFA("CSHOLD"))) K PRCFDEL,PRCFA("CSHOLD") S X=" Code Sheet not Processed, No Further Action Taken.*" D MSG^PRCFQ G OUT
 W !!,"Updating Obligation balances.  Please hold...",!!
X D POADJ^PRCH58OB(.PO,PODA,.TRNODE,AMT)
 D POADJ^PRCS58OB(.PRC,PODA,TRDA,AMT)
 D:AMT>0 BULC^PRCH58(PODA)
Z S (X,Z)=$P(PO(0),U),%=1 D EN1^PRCSUT3 S DLAYGO=424,DIC="^PRC(424,",DIC(0)="L" D FILE^DICN I Y<0 W !,"ERROR IN CREATING 424 RECORD",$C(7),!! Q
 S DIE="^PRC(424,",DA(1358)=+Y D NOW^%DTC S TI=%,DA=DA(1358),DR=".02///^S X=PODA;.03///^S X=""A"";.06///^S X=$P(TRNODE(4),U,8);.07///^S X=TI;.08////^S X=DUZ;1.1////^S X=""ADJUSTMENT OBLIGATION"";.15////^S X=TRDA"
 D ^DIE S X="  ----Adjustment Completed ----*" D MSG^PRCFQ G OUT
 Q
SCREEN ;COMPARISON SCREEN
 N CEILING,LAUTH,TAUTH,TBAL,LBAL,IOINHI,IOINLOW,IOINORM
 D HILO^PRCFQ S CEILING=$P(PO(8),U) W @IOF,IOINLOW,"Adjustment Transaction # ",IOINHI,$P(TRNODE(0),"^"),IOINLOW,"     1358 # ",IOINHI,$P(PO(0),"^")
 W !!,IOINLOW,"Current amount obligated on 1358: ",IOINHI,"  $ ",$FN(CEILING,"P,",2)
 S TBAL=$P(PO(8),U,3),TAUTH=CEILING-TBAL W !!,IOINLOW," Total Authorizations: ",IOINHI," $ ",$J($FN(TAUTH,"P,",2),12)
 S LBAL=$P(PO(8),U,2),LAUTH=CEILING-LBAL W ?40,IOINLOW," Total Liquidations: ",IOINHI," $ ",$J($FN(LAUTH,",P",2),12)
 W !,IOINLOW,"Authorization Balance: ",IOINHI," $ ",$J($FN(TBAL,"P,",2),12),?40,IOINLOW,"Liquidation Balance: ",IOINHI," $ ",$J($FN(LBAL,"P,",2),12),!!
 W IOINLOW,"Amount of Adjustment: ",IOINHI,$J($P(TRNODE(4),"^",8),0,2),!!,IOINORM
 Q
OUT K DIRUT,DTOUT,DUOUT,DIROUT Q
