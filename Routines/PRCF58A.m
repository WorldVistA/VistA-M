PRCF58A ;WISC@ALTOONA/CTB-PROCESS 1358 ADJUSTMENT ;5-29-91/14:10
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 S %F="B" D ^PRCFSITE Q:'%  S DIC=410,DIC(0)="AEMNZ"
 S PRCFA(1358)="",FSO=$O(^PRCD(442.3,"AC",10,0)),DIC("S")="S PRCFX=^(0) I $P($P(PRCFX,U),""-"",1,2)=PRCF(""SIFY""),$P(PRCFX,U,4)=1,$D(^(10)),$P(^(10),U,4)=FSO"
 D ^PRCSDIC K PRCFX,DIC("S"),FSO G:Y<0 OUT S (DA,PRCFA("TRDA"))=+Y
 K TRNODE F I=0,3,4,10 S TRNODE(I)=$S($D(^PRCS(410,DA,I)):^(I),1:"")
 ;VERIFY THAT ENTRY IN 442 AND 424 EXIST
 S (X,X1)=$P(TRNODE(4),"^",5),X=$O(^PRC(442,"B",PRC("SITE")_"-"_X,0))
 I X="" W !,"Unable to Process due to lack of Obligation Number." G OUT
 S $P(^PRCS(410,PRCFA("TRDA"),10),"^",3)=X,PRCFA("PODA")=X
 F I=0,8 S PO(I)=$S($D(^PRC(442,PRCFA("PODA"),I)):^(I),1:"")
 ;IF AMOUNT IS <0 & BALANCE - AMOUNT <0  INADEQUATE BALANCE
 K % S NOGO="" I $P(TRNODE(4),"^")<0,$P(PO(0),"^",15)-$P(PO(0),"^",17)<0 S NOGO=1
 ; S %A="Insufficient balance in obligation to post adjustment.",%A(1)="OK to Post anyway",%B="",%=2 D ^PRCFYN
 I $D(%) G RETURN:%=1,OUT:%<1 S %=2,%A="Posting will cause a negative balance to exist for this 1358.  ARE YOU SURE",%B="" D ^PRCFYN G RETURN:%=2,OUT:%<0
 W:$D(IOF) @IOF W !,"PROCESS 1358 ADJUSTMENT",?40,"Obligation #: ",$P(PO(0),"^")
 W !!,"     Service Balance: $ ",$J(+$P(PO(8),"^"),10,2)
 W !,"      Fiscal Balance: $ ",$J($P(PO(8),"^",2),10,2)
 W !,"Amount of Adjustment: $ ",$J($P(TRNODE(4),"^",8),10,2)
 W !!?20,"ORIGINAL",?45,"ADJUSTMENT",!!,"  COST CENTER: ",?21,+$P(PO(0),"^",5),?48,+$P(TRNODE(3),"^",3) I +$P(PO(0),"^",5)'=+$P(TRNODE(3),"^",3) S NOGO=NOGO_3 W $C(7),?60,"*****"
 W !!,"BOC #1:",?22,$P($P(PO(0),"^",6)," "),?49,$P($P(TRNODE(3),"^",6)," ") I +$P(PO(0),"^",6)'=+$P(TRNODE(3),"^",6) W $C(7),?60,"*****" S NOGO=NOGO_2
 I +$P(PO(0),"^",8)>0!(+$P(TRNODE(3),"^",8)>0) W !,"BOC #2:",?22,$P($P(PO(0),"^",8)," "),?49,$P($P(TRNODE(3),"^",8)," ") I +$P(PO(0),"^",8)'=+$P(TRNODE(3),"^",8) W $C(7),?60,"*****" S NOGO=NOGO_2
 K % I NOGO[1 S %A="Insufficient balance in obligation to post adjustment.",%A(1)="OK to Post anyway",%B="",%=2 D ^PRCFYN
 I $D(%) G RETURN:%=1,OUT:%<1 S %=2,%A="Posting will cause a negative balance to exits for this 1358.  ARE YOU SURE",%B="" D ^PRCFYN G RETURN:%=2,OUT:%<0
 I NOGO[2 S %A="BOCs are not the same as the original order.",%A(1)="Do you wish to edit the S/A",%B="",%=1 D ^PRCFYN G RETURN:%'=1 D SAEDIT S I=4
 S %A="OK to Continue",%B="",%=1 D ^PRCFYN G:%=1 ^PRCF58A1
 S X="<No Action Taken>*" D MSG^PRCFQ
OUT K %,A,AMT,C,CS,CEILING,DA,DEL,DIK,DIC,I,J,N1,N2,OLDTT,PO,PRCF,PRCFA,IOINORM,IOINHI,IOINLOW,TMP,TRNODE,X,X1,Y,Z Q
RETURN D OUT G V
SAEDIT W !!,"The current values are:",!,?10,"BOC #1: ",$P(PO(0),"^",6),!?10,"BOC #2:",$P(PO(0),"^",8),!!,"Please enter the corrected values.",!!
 S DA=PRCFA("TRDA"),DIE="^PRCS(410,",DR="17;18" D ^DIE S TRNODE(3)=^PRCS(410,DA,3) Q
