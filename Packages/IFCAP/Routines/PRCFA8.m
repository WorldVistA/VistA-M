PRCFA8 ;WISC/CTB-PROCESS RECEIVING REPORTS ;2/2/96  13:30
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN8 ;PROCESSING OF RECEIVING REPORT
 S (PRCFA("SYS"),PRCFASYS)="FMS",PRCF("X")="AS"
 D ^PRCFSITE G:'% OUT K DIC("A")
 S D="C",DIC("S")="I +$P(^(0),U,1)=PRC(""SITE""),$D(^(7)),+^(7)>0 S FSO=$P(^PRCD(442.3,+^(7),0),U,3) I FSO>29&(FSO<40)!(FSO=26!(FSO=41)&$$ONE2PROC^PRCFA8) I '$P($G(^PRC(442,+Y,24)),U)"
 S DIC("A")="Select Purchase Order Number: ",DIC=442,DIC(0)="AEQZ"
 D IX^DIC K DIC("S"),DIC("A"),FSO G:+Y<0 OUT
 S PO(0)=Y(0),(D0,PRCFA("PODA"))=+Y,PO=Y
 S %A="Do want to review the Purchase Order and Receiving Report"
 I $P($G(^PRC(442,D0,11,0)),U,4)>1 S %A=%A_"s"
 S %B="",%=2 D ^PRCFYN G OUT:%<0 I %=1 D ^PRCHDP1
PPT N FED,PPT,I S PPT="",(FED,I)=0
 N P7 S P7=$P($G(^PRC(442,PRCFA("PODA"),1)),U,7)
 I P7]"","13578"[P7 S FED=2
 ;I 'FED N PPR F  S I=$O(^PRC(442,PRCFA("PODA"),5,I)) Q:+I'=I  S PPR=$G(^(I,0)) D
 ;. Q:PPR=""  I $P(PPR,U,1)="NET",$P(PPR,U,5)]"" S PPT=$P(PPR,U,5)
 ;. I PPT="" S PPT=$P(PPR,U,5)
 ;. Q
 S PPT=$P($G(^PRC(442,PRCFA("PODA"),12)),U,15)
 I 'FED,PPT="" D  I $D(DTOUT)!$D(DUOUT)!$D(Y) G OUT
 . W !!,"This P.O. does not have PROMPT PAYMENT TYPE information.",!,"PLease enter the information now."
 . S DIE="^PRC(442,",DA=PRCFA("PODA"),DR=97_"//^S X=""A""" D ^DIE K DIE,DR,DA
 . S PPT=$P($G(^PRC(442,PRCFA("PODA"),12)),U,15)
 . QUIT
ACC I '$D(^PRC(442,PRCFA("PODA"),22)) D  G OUT
 . S X="This P.O. has no FMS accounting lines - Cannot process.*"
 . D MSG^PRCFQ
 . Q
PAR S DIC("A")="Partial Number to PROCESS: ",DIC="^PRC(442,"_+PO_",11,"
 S DIC("S")="I $P(^(0),U,19)="""""
 S DIC(0)="AEQMNZ" D ^DIC K DIC("A")
 G:Y<0 OUT S PO(11)=Y(0),PRCFA("PARTIAL")=+Y
 ; Convert IFCAP Partial # ==> FMS Partial #
 N PNO S PNO="" D ALPHA^PRCFPAR(PRCFA("PARTIAL"),.PNO)
 I PNO<0 D  G PAR
 . S X="Partial # is out of limits - FMS will not process.*"
 . D MSG^PRCFQ
 . Q
 N ACTION S ACTION="E"
 S X=$P($G(^PRC(442,PRCFA("PODA"),11,PRCFA("PARTIAL"),1)),U,16)
 I X?1.N D
 . S X="This partial #"_PRCFA("PARTIAL")_" is an Adjustment to partial #"_X
 . D MSG^PRCFQ
 . S ACTION="M"
 I $P(PO(11),U,6)="Y" W $C(7) D  I %'=1 G OUT
 . S %A="Fiscal Service has already processed this partial."
 . S %A(1)="Do you want to enter a MODIFICATION to the original Receiving Report"
 . S %B="",%=2 D ^PRCFYN I %'=1 K P,DIC,Y
 . Q
 S PO(2)=$P(PO(11),"^")\1 ;I $P(PO(0),"^",19)=2!($P(PO(0),"^",19)=3) G X
 S DA(1)=PRCFA("PODA"),DA=PRCFA("PARTIAL")
 S DIE="^PRC(442,"_PRCFA("PODA")_",11,",DR="23R//^S X=$P(""JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC"",U,+$E(DT,4,5))_"" ""_($E(DT,1,3)+1700)"
 D ^DIE K DA,DIE,DR G OUT8:$D(DTOUT)!$D(DUOUT)!$D(Y)
C N SC,DOCTYPE S (SC,DOCTYPE)="N"
 S PRCFPO=PRCFA("PODA"),PRCFPR=PRCFA("PARTIAL"),PRCFA8=1
 D EN^PRCFARR I $G(LCKFLG) G OUT8
 D:$D(^TMP("PRCFARR",$J)) ^PRCFARRD
 W:'$D(^TMP("PRCFARR",$J)) @IOF,!,"Error: Receiver Records could not be built!",!!
 S PO=+PO
EN82 ;
X W !,"LIQUIDATION CODE: " R X:DTIME G OUT8:'$T,OUT8:X["^"
 I "PCF"'[$E(X)!(X="") W ! S X="Enter a (P)artial, (F)inal, or (C)omplete only.*" D MSG^PRCFQ G X
 S PRCFA("LIQ")=$E(X)
 S MESSAGE="" D ESIG^PRCUESIG(DUZ,.MESSAGE)
 I MESSAGE'=1 S X="<No Further Action Taken.>" D MSG^PRCFQ G OUT
 I $G(PRCFA("PODA"))>0 D
 . D EN72^PRCFAC1
 . N XA,XB,XC,XD,GECSFMS,POESIG S GECSFMS("DA")=""
 . S GECSFMS("DOC")="^^RR^"_$TR($P(PO(0),U),"-")_PNO
 . K PRCFA("TT") S POESIG=1,XA="RR",XB=$S($G(ACTION)="M":1,1:0)
 . S XC=$P(^PRC(442,PRCFA("PODA"),11,PRCFA("PARTIAL"),0),U)
 . S XD=$P($P(PO(0),"^"),"-",2)
 . D EN7^PRCFFU41(XA,XB,XC,XD)
 . D LOAD^PRCFARRQ
OUT8 K PRCFA("PODA"),PRCFA("REC"),PRCFA("PARTIAL"),%A,%B,DTOUT,DUOUT,PO,PRCF,PRCFASYS,PRCFPO,PRCFPR
 G EN8
OUT K %,%A,%B,%Y,B,D0,DA,DG,DIC,DIE,DIG,DIH,DIK,DIR,DIU,DIV,DIW,DLAYGO,DR,DTOUT,DUOUT,FSO,J,K,MESSAGE,P,PO,PRCF,PRCFA,PRCFASYS,PRCFPO,PRCFPR,Q,Q1,S,X,Y
 K ^TMP("PRCFARR",$J)
 Q
ONE2PROC() ;Check if unsent receivers
 N X,Z S X=0,Z=0
 F  S Z=$O(^PRC(442,Y,11,Z)) Q:Z'?1.N  D  Q:X
 . Q:$D(^PRC(442,Y,11,Z,0))#10'=1
 . S:$P(^PRC(442,Y,11,Z,0),U,19)="" X=1
 Q X
