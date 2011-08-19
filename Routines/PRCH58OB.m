PRCH58OB ;WISC/CLH-OBLIGATE,ADJUST 1358 ;11/28/94  15:06
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
COB(DA,TRNODE,PO,OB,X) ; 
 ;enter transaction information onto PO
 ;kills TMP("NEWDATE"),TMP("NEWACC")
 N DATE,FLAG,I,J,PRCBBFY,SUBSTA,X
 S $P(PO(0),"^",3,9)=$P(TRNODE(3),"^",1,3)_"^"_$P(TRNODE(3),"^",6,9)
 S X=$P(PO(0),"^",7)+$P(PO(0),"^",9)
 S $P(PO(0),"^",11,12)=X_"^"_OB
 S $P(PO(0),"^",15)=$P(TRNODE(4),"^")
 F I=6,8 S $P(PO(0),"^",I)=+$P(PO(0),"^",I)
 S PO(1)=$P(TRNODE(3),"^",4,5)
 ;
 L +^PRC(442,DA)
 S ^PRC(442,DA,0)=PO(0)
 S $P(^PRC(442,DA,1),"^",1,2)=$P(PO(1),"^",1,2)
 S:$P(PO(0),"^",3)]"" ^PRC(442,"E",$P($P(PO(0),"^",3)," "),DA)=""
 S:$P(PO(1),"^")]"" ^PRC(442,"D",$P(PO(1),"^"),DA)=""
 I $D(PRCFA("RETRAN")),'PRCFA("RETRAN") D NODE22^PRCFFU5
 S PRCBBFY=$P(TRNODE(3),U,11)
 S SUBSTA=$P(TRNODE(0),"^",10)
 S:'$D(TMP("NEWDATE")) TMP("NEWDATE")=""
 S:'$D(TMP("NEWACC")) TMP("NEWACC")="0^NO"
 S DATE=$P(TMP("NEWDATE"),U)
 S FLAG=$P(TMP("NEWACC"),U)
 S DIE=442
 S DR="26///^S X=PRCBBFY;29///^S X=DATE;30///^S X=FLAG;31///^S X=SUBSTA"
 D ^DIE
 K DIE,DR
 K TMP("NEWDATE")
 K TMP("NEWACC")
 I $P($G(^PRC(442,DA,12)),"^",2)]"" D
 . D REMOVE^PRCHES5(DA),ENCODE^PRCHES5(DA,$P(^PRC(442,DA,1),"^",10))
 . QUIT
 L -^PRC(442,DA)
 Q
 ;
PAT(DA,PODA,PO,PATNUM) ;get pat info, kill PRCHPO
 S (PO,PODA)=DA
 S PO(0)=$G(^PRC(442,PODA,0))
 S PATNUM=$P(PO(0),U)
 K PRCHPO
 Q
 ;
ADJ(DIC,PRC,DA) ;
 S DIC("A")="Select OBLIGATION NUMBER: "
 S DIC(0)="AEQZ"
 S D="D"
 S DIC("S")="I $P(^(0),U,2)=""O"",$P(^(0),U,4)=1,PRC(""SITE"")=+^(0),+PRC(""CP"")=+$P($P(^(0),U),""-"",4)"
 D IX^DIC
 Q
 ;
VER(PRC,X) ;verify entry
 S X=$O(^PRC(442,"B",PRC("SITE")_"-"_X,0))
 Q
 ;
PO(DA,PO) ;PO data for adjustments
 N I
 F I=0,1,7,8 S PO(I)=$G(^PRC(442,DA,I))
 Q
 ;
OLDTT(DA,X) ;old code sheet info
 S X=$E($G(^PRC(442,DA,10,1,0)),1,6)
 Q
 ;
POADJ(PO,PODA,TRNODE,AMT) ;set adjustments in 442
 N DIE,DR,DA,X,X1
 S X1=AMT
 S:AMT<0 AMT=-AMT
 S DIE="^PRC(442,"
 S DA=PODA
 S DR="92///^S X=$S($P(PO(0),U,16)]"""":$P(PO(0),U,16),1:$P(PO(0),U,15))+X1;91///^S X=$P(PO(0),U,15)+X1;7.2///^S X=AMT;3.4///^S X=$P(PO(0),U,7)+$P(TRNODE(3),U,7);94///^S X=$P(PO(8),U,1)+X1"
 S:$P(PO(0),U,9) DR=DR_";4.4///^S X=$P(PO(0),U,9)+$P(TRNODE(3),U,9)"
 D ^DIE
 S PO(0)=^PRC(442,PODA,0)
 S X=100
 S DA=PODA
 D ENF^PRCHSTAT
 S:X1'=AMT AMT=X1
 Q
 ;
OBLK(PODA,PRCA) ;look up obligation number
 N DIC,Y
 S DIC="^PRC(442,"
 S DIC(0)="AEMNQZ"
 S DIC("A")="Select OBLIGATION NUMBER: "
 S DIC("S")="I $P(^(0),U,2)=21"
 S:$G(PRCA) DIC("S")=DIC("S")_","_"+$P(^(0),U,3)=PRCA"
 D ^DIC
 I +Y<0 S PODA=0 Q
 S PODA=+Y
 S PODA(0)=Y(0)
 S PODA(1)=$P(Y,U,2)
 S PODA(2)=$P(Y(0),U,3)
 Q
 ;
BAL(PODA,AMT) ;set the 8th node equal to obligation amount
 S ^PRC(442,PODA,8)=AMT_"^0^0"
 Q
 ;
KILL(PO) ;if 1358 obligation not completed, set dollar amounts on PAT to 0
 ;delete 'PRIMARY 2237' field, set status to 'CANCELLED ORDER'
 ;and delete references to pat number on original request.
 N ZZX,XXZ,DIE,DR,X,Y,TRDA,DA
 D WAIT^PRCFYN
 S ZZX=^PRC(442,PO,0)
 S $P(ZZX,U,15,16)="0^0"
 F XXZ=7,9 S $P(ZZX,U,XXZ)=0 S $P(ZZX,U,12)=""
 S ^PRC(442,PO,0)=ZZX
 K XXZ,^(9)
 S DA=+$P(ZZX,U,12)
 I $D(^PRCS(410,DA,0)) S DIE="^PRCS(410,",DR="52///@;24///@" D ^DIE K DIE,DA,DR,ZZX
 S (X,Y)=45,DA=PO
 D UPD^PRCHSTAT
 K DIE,DA,DR,X,Y
 S X="PAT Number "_PATNUM_" has been cancelled."
 D MSG^PRCFQ W !
 S X="Status on 1358 remains 'Pending Fiscal Action'.*"
 D MSG^PRCFQ
 S TRDA=+$P(ZZX,U,12)
 I $D(^PRCS(410,TRDA,0)) D KILL^PRCS58OB(TRDA)
 Q
 ;
BAL1(PODA,AMT) ;Set liquidation balance
 S:$G(^PRC(442,+PODA,8)) $P(^(8),"^",2)=AMT
 Q
