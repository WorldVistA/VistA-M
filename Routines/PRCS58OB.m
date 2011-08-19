PRCS58OB ;WISC/CLH-OBLIGATION PROCESSING ;07/21/93
V ;;5.1;IFCAP;**148**;Oct 20, 2000;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
OB(DA) ;Obligation edits
SC N DIE,DR
 S DIE="^PRCS(410,",DIE("NO^")=""
 S DR="15.5;S NEWCC=X;W !;17;S NEWBOC=X" D ^DIE
 ;S DR="15.5;W !;17;@1;S AMT=$P(^PRCS(410,DA,4),U);17.5;S S1AMT=X;W !;18;18.5;I X+S1AMT'=+AMT W !,$C(7),?5,""Amounts out of balance"" K AMT,S1AMT S Y=""@1""" D ^DIE
 Q
OB1(OB,DA) ;set obligation number in 410
 N DIE,DR,Z
 S Z=DA,DA=OB,DIE="^PRCS(410,",DR="52///^S X=Z" D ^DIE
 Q
CS(OB,AMT,TIME,PATNUM,PODA,DEL,X,PRC) ;set code sheet information in 410
 N Y
 ; Change ESIG processing:
 S Y=$S($D(^PRCS(410,OB,4)):^(4),1:""),$P(Y,"^",3,5)=AMT_"^"_TIME_"^"_$P(PATNUM,"-",2),$P(Y,"^",8)=AMT,^(4)=Y
 S MESSAGE=""
 D ENCODE^PRCSC2(OB,DUZ,.MESSAGE)
 K MESSAGE
 S $P(^PRCS(410,OB,10),"^",3,4)=PODA_"^" S:$D(DEL) $P(^(9),"^",2)=DEL S ^PRCS(410,"D",$P(PATNUM,"-",2),OB)=""
 Q
 ;End of first ESIG mod for this routine . . .
PODT(DA,A) ; post P.O. Date onto 442 record
 N DIE,DR
 S DIE="^PRC(442,",DR=".1////"_A D ^DIE
 Q
ADJ(DIC,DA,PRCSIP,X4) ;enter adjustment on transaction
 N DIE,DR
 S DIC(0)="AEMQ",DIE=DIC,DR="3///1"_$S($D(PRCSIP):";4////"_PRCSIP,1:""),X4=1 D ^DIE
 Q
ADJ1(DA,X,Y) N DIE,DR,Z
 S Z=Y,DIE="^PRCS(410,",DR="1///^S X=""A"";3///^S X=1;24///^S X=$P(^PRCS(410,+Z,4),U,5);52////^S X=$G(PRC442)" D ^DIE
 Q
ADJ2(PRC,X,DA) ;mark the transaction as an adjustment
 N PRCX442 S PRCX442=X,PRCX442=$$UPPER^PRCFFU5(PRCX442) D OBL^PRCSES2 S X=PRCX442
 N X1,X2
ENA2 S DIC(0)="AEMQ",DIE="^PRCS(410,",DR="[PRCE 1358 ADJUSTMENT]" D ^DIE
 I $D(Y)#10 D YN^PRC0A(.X,.Y,"Delete this NEW entry","","No") I Y=1 D  QUIT:X=1
 . D DELETE^PRC0B1(.X,"410;^PRCS(410,;"_DA)
 . D EN^DDIOL(" **** NEW ENTRY IS "_$S(X=1:"",1:"NOT ")_"DELETED ****")
 . QUIT
 I DA S X=$P($G(^PRCS(410,DA,4)),U,6) D:X TRANK^PRCSEZ
 I $G(PRC410),$G(PRC442),$$EN1^PRCE0A(PRC410,PRC442,1) G ENA2
 I $D(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)),$P(^(0),U,12)>0 G ENA3
 I $D(^PRCS(410,DA,4)) S X=$P(^(4),U,6),X2=^(3),X1=$P(X2,U,7)+$P(X2,U,9) I $J(X,0,2)'=$J(X1,0,2)!('X)!('X1) W $C(7),!,"Adjustment $ Amount does not equal the BOC $ Amount.",!,"Please correct the error.",! G ENA2
ENA3 D:$O(^PRCS(410,DA,12,0)) SCPC0^PRCSED D W1^PRCSEB I $D(PRCS2),+^PRCS(410,DA,0) D W6^PRCSEB
 Q
NODE(DA,TRNODE) ;get transaction node information from 410
 K TRNODE F I=0,1,2,3,4,7,10,11,14 S TRNODE(I)="" S:$D(^PRCS(410,DA,I)) TRNODE(I)=^(I)
 S:$P(TRNODE(3),"^",11)="" $P(TRNODE(3),"^",11)=$P(TRNODE(0),"-",2)+200_"0000"
 S I=0 F  S I=$O(^PRCS(410,DA,8,I)) Q:'I  S:$D(^(I,0)) TRNODE(8,I)=^(0)
 Q
LU(Y,PRC,PRCF) N DIC,FSO,PRCFA,PX
 ;look up transaction
 S DIC=410,DIC(0)="AEMNZ"
 S PRCFA(1358)="",FSO=$O(^PRCD(442.3,"AC",10,0)),DIC("S")="S PX=^(0) I $P($P(PX,U),""-"",1,2)=PRCF(""SIFY""),$P(PX,U,4)=1,$D(^(10)),$P(^(10),U,4)=FSO"
 D ^PRCSDIC
 Q
SAEDIT(PO,DA) N DIE,DR
 I '$D(PRCFA("TRDA")),$G(DA)]"" S PRCFA("TRDA")=$G(DA)
 W !!,"The current values are:",!,?10,"BOC #1: ",$P(PO(0),"^",6),!?10,"BOC #2:",$P(PO(0),"^",8),!!,"Please enter the corrected values.",!!
 S DA=PRCFA("TRDA"),DIE="^PRCS(410,",DR="17;18" D ^DIE S TRNODE(3)=^PRCS(410,DA,3)
 Q
POADJ(PRC,PODA,TRDA,AMT) ;set adjustments obligations in 410
 ;This code modified for new ESIG:
 N DA,TIME,X
 S DA=TRDA
 D NOW^PRCFQ S TIME=X K %,%X
 S $P(^PRCS(410,DA,10),U,3,4)=PRCFA("PODA")_U
 S X=^PRCS(410,DA,4),$P(X,"^",3,5)=AMT_"^"_TIME_"^"_$P($P(^PRC(442,PRCFA("PODA"),0),"^"),"-",2),$P(X,"^",8)=AMT,^PRCS(410,DA,4)=X,X=AMT
 S MESSAGE=""
 D ENCODE^PRCSC2(DA,DUZ,.MESSAGE)
 K MESSAGE
 S PRCHOBL="" D TRANK^PRCSES,TRANS^PRCSES K PRCHOBL D TRANS1^PRCSES
 Q
 ;End of ESIG mods.
OROBL(DIC,PRC,DA) ;lookup obligation number on original 1358 request
 S DIC("A")="Select OBLIGATION NUMBER: ",DIC(0)="AEQZ",D="D",DIC("S")="I $P(^(0),U,2)=""O"",$P(^(0),U,4)=1,PRC(""SITE"")=+^(0)" I $D(PRC("CP")) S DIC("S")=DIC("S")_",+PRC(""CP"")=+$P($P(^(0),U),""-"",4)"
 D IX^DIC
 I X=" " D
 .N TRDAIEN
 .S TRDAIEN=Y,%X="Y(",%Y="TRDAIEN(" D %XY^%RCR K %X,%Y
 .K PRCTMP(410,+TRDAIEN,52)
 .D GENDIQ^PRCFFU7(410,+TRDAIEN,52,"IEN","")
 .S X=$P($G(PRCTMP(410,+TRDAIEN,52,"E")),"-",2)
 .K PRCTMP(410,+TRDAIEN,52)
 .S Y=TRDAIEN,%X="TRDAIEN(",%Y="Y(" D %XY^%RCR K %X,%Y
 .Q 
 Q
RTN(DA) ;return request to service
 N DIE,DR,AMT,X
 S DIE="^PRCS(410,",DR="61" D ^DIE I $D(Y) S X="No action taken*" D MSG^PRCFQ Q
 S AMT=$P(^PRCS(410,DA,4),"^",8),X=AMT D TRANK^PRCSES S $P(^PRCS(410,DA,7),"^",5,7)="^^",$P(^PRCS(410,DA,10),"^",4)=$O(^PRCD(442.3,"AC",9,0))
 Q
KILL(TRDA) ;kill obligation transaction when obligation data killed
 S $P(^PRCS(410,TRDA,10),"^",4)=$O(^PRCD(442.3,"AC",10,0))
 Q
