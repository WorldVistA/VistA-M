PRCHMA1 ;WISC/AKS/DWA-Amendments to purchase orders and requisitions ;6/8/96  13:42
 ;;5.1;IFCAP;**22,40,79**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN4 ;Line Item edit
 ;
 ;MOP=Method of Processing
 ;SSO=Supply Status Order
 ;
 N DIC,DIE,DA,DR,PRCHSTN,PRCHI,PRCHI1,PRCHO,PRCHEDI,PRCHSTN,PRCHPONO,DIE,DR,PRCHN,PRCHAREC,MOP,SSO
 S MOP=$P($G(^PRC(442,PRCHPO,0)),U,2),SSO=$P($G(^PRC(442,PRCHPO,7)),U,2)
 I ".27.28.33.25.26.30.31.40.41.32.34.37.38.46.47.48.49.96.97."[("."_SSO_".") D
 . I MOP=25,$P(^PRC(442,PRCHPO,23),U,15)'="Y" Q
 . I ".2.4.7.26."[("."_MOP_".") Q
 . W !!
 . W !,?15,"****************** TAKE NOTE!! ********************"
 . W !,?15,"*                                                 *"
 . W !,?15,"*  This order has a Receiving Report previously   *"
 . W !,?15,"*  processed.  If this amendment will alter the   *"
 . W !,?15,"*  Total Cost of any line item on the order       *"
 . W !,?15,"*  remember to back out the previous Receiving    *"
 . W !,?15,"*  Report with an Adjustment Voucher, process     *"
 . W !,?15,"*  the amendment, and rerun the Receiving         *"
 . W !,?15,"*  Report.                                        *"
 . W !,?15,"*                                                 *"
 . W !,?15,"***************************************************"
 . W !!
 . Q
 K MOP,SSO
 D MV^PRCHMA0 I $G(PRCPROST)=6 S PRCHI=$O(^PRC(443.6,PRCRI(443.6),2,0)),PRCHI1=PRCHI,X=1,$P(PRCHI,U,2)=$P(^(PRCHI,0),U) G EN4A
 S DA(1)=PRCHPO,DIC="^PRC(443.6,"_DA(1)_",2,",DIC(0)="AEQZ" D ^DIC Q:Y<0  S PRCHI=Y,PRCHI1=$P(Y,U,2)
EN4A ;Called from routine PRCHMA2B for chenge vendor amendments to enable
 ;line item edits for vendor specific information.
 S PRCHO=+$G(^PRC(443.6,PRCHPO,2,+PRCHI,2))
 S PRCHEDI=$G(^PRC(440,$P(^PRC(443.6,PRCHPO,1),U),3)) S:PRCHEDI]"" PRCHEDI=$P(PRCHEDI,U,2)
 S PRCHSTN=$P($P(^PRC(443.6,PRCHPO,0),U),"-")
 S PRCHPONO=$P(^PRC(443.6,PRCHPO,0),U)
 I $G(PRCPROST)=6 D  G EN4B
 . N X
 . S PRCRI(443.61)=$O(^PRC(443.6,PRCRI(443.6),2,0))
 . I PRCRI(443.61) D EDIT^PRC0B(.X,"443.6;^PRC(443.6,;"_PRCRI(443.6)_"~443.61;^PRC(443.6,"_PRCRI(443.6)_",2,;"_PRCRI(443.61),"5///"_PRCPAMT)
 . QUIT
 S DIE="^PRC(443.6,",DA=PRCHPO
 S DR=$S($D(PRCHREQ):"[PRCHRQITM]",1:"[PRCHLINE]"),DIE("NO^")="BACK"
 ;I $G(PRCHVFLG)>0 S DR=$S($D(PRCHREQ):"[PRCH CHNGVEND RQ",1:"[PRCH CHNGVEND PO]"),DIE("NO^")="BACK"
 I $G(PRCHAUTH)=1 S DR="[PRCH PURCHASE CARD AMEND]"
 I $G(PRCHAUTH)=2 S DR="[PRCH DELIVERY ORDER AMEND]"
 D ^DIE K DIE
EN4B ;Called from routine PRCHMA2C for change vendor amendments to enable
 ;line item edits if required information is missing.
 S PRCHN=+$G(^PRC(443.6,PRCHPO,2,+PRCHI,2))
 I PRCHO'=PRCHN S PRCHAMT=PRCHAMT+(PRCHN-PRCHO)
 I $D(^PRC(443.6,PRCHPO,2,+PRCHI,2)),$P(^(2),U,6)>0 S PRCHAREC=1
 I $P($G(^PRC(443.6,PRCHPO,2,+PRCHI,0)),U,2)'>$P($G(^(2)),U,8) D
 .S PRCHX($P(PRCHI,U,2),"@")="^PRC(442,PRCHPO,2,""C"",X,"_+PRCHI_")"
 E  S PRCHX($P(PRCHI,U,2),$P(PRCHI,U,2))="^PRC(442,PRCHPO,2,""C"",X,"_+PRCHI_")"
 S DELIVER=1 W !
 D ERCHK,EN0^PRCHAMXH
 K PRCHI
 QUIT
EN5 ;Source Code edit
 N DIE,DR
 S DIC="^PRCD(420.8,",DIC(0)="AEQ"
 S:$D(PRCHREQ) DIC("S")="I ""134590""[$E(^(0))"
 S:$P($G(^PRC(443.6,PRCHPO,1)),U,7)>0 DIC("B")=$P(^PRCD(420.8,$P(^(1),U,7),0),"^")
 D ^DIC K DIC Q:Y<0
 S DIE="^PRC(443.6,",DA=PRCHPO,DR="8////"_+Y D ^DIE K DIE W !
 QUIT
EN6 ;Edit Mail Invoice to
 N DA,DIE,DR
 S DA=PRCHPO,DIE="^PRC(443.6,",DR=.04 D ^DIE W !
 QUIT
EN7 ;Edit Method of Payment
 N DA,DIE,DR
 S DA=PRCHPO,DIE="^PRC(443.6,",DR=.02 D ^DIE W !
 QUIT
EN8 ;Administrative Certification add
 N DIE,DA,DR,DLAYGO
 D MVADM S DA(1)=PRCHPO
 S DIC="^PRC(443.6,"_DA(1)_",15,",DIC(0)="AEQL",DLAYGO=443.6 D ^DIC K DIC
 W !
 QUIT
EN9 ;Administrative Certification delete
 N DIE,DA,DR
 D MVADM S DA(1)=PRCHPO
 S DIC="^PRC(443.6,"_DA(1)_",15,",DIC(0)="AEQ" D ^DIC K DIC
 S DIE="^PRC(443.6,"_DA(1)_",15,",DA=+Y,DR=".01////@" D ^DIE K DIE
 QUIT
EN13 ;Replace P.O. Number
 N X,I,PRCH0,PRCHO,PRCHNRQ,PRCHN,ER,OK,P2237
 S (I,ER)=0,X=""
 ;F  S I=$O(^PRC(442,PRCHPO,11,I)) Q:'I  I $D(^(I,0)) S X=$P(^(0),U,8) Q:X]""
 D CAN^PRCHMA3
 I $G(NOCAN)=1 W !?5,$S($D(PRCHREQ):"REQUISITION",1:"PURCHASE ORDER")_" HAS BEEN RECEIVED, CANNOT CANCEL !",$C(7) Q
 I $G(PRCHAUTH)=1 D PAID^PRCHINQ I $G(PAID)=1 D  Q
 . W !,?5,"THERE HAS BEEN PAYMENT MADE FOR THIS PURCHASE CARD ORDER, CANNOT CANCEL !",$C(7)
 I $P($G(^PRC(443.6,PRCHPO,6,PRCHAM,3,0)),U,4)>2 D ERR Q
 I $P($G(^PRC(443.6,PRCHPO,6,PRCHAM,3,0)),U,4)=2 I $P($G(^PRC(443.6,PRCHPO,6,PRCHAM,3,2,0)),U,2)'=34 D ERR Q
 S P2237=$P(^PRC(443.6,PRCHPO,0),U,12),OK=1 D:P2237>0  Q:OK=0
 .I '$$VERIFY^PRCSC2(P2237) W !!,?5,"This purchase order has been tampered with.",!,?5,"Please notify IFCAP APPLICATION COORDINATOR.",! S OK=0
 I $D(PRCHREQ) S PRCHNRQ=PRCHREQ
 S PRCH0=$G(^PRC(443.6,PRCHPO,0))
 S PRCHO=$P(PRCH0,U),PRCH=PRCHPO D
 .I $D(PRCHNRQ) S PRCHP("A")="REQUISITION NUMBER",PRCHP("T")=8,PRCHP("S")=1 D EN^PRCHPAT Q
 .I $D(PRCHIMP) S PRCHP("A")="IMPREST FUND P.O.NO.: ",PRCHP("T")=7,PRCHP("S")=3 D EN^PRCHPAT Q
 .D ENPO^PRCHUTL Q
 I '$D(PRCHPO) S PRCHPO=PRCH Q
 S PRCHN=$P(^PRC(442,PRCHPO,0),U),NDOC=$P(^(18),U,3)
 N %X,%Y,DIE,DR,DA
 S %X="^PRC(442,PRCH,",%Y="^PRC(443.6,PRCHPO," D %XY^%RCR
 F I=6,10,11 K ^PRC(443.6,PRCHPO,I)
 S DIE="^PRC(443.6,",DA=PRCHPO
 S DR=".01///^S X=PRCHN;27///^S X=PRCHO;102///^S X=NDOC"
 D ^DIE K DIE,DA,DR,NDOC
 S DIE="^PRC(443.6,",DA=PRCH,DR="28///^S X=PRCHN" D ^DIE K DIE,DA,DR
 S X=0,PRCHPO=PRCH D EN4^PRCHAMXB
 S DA(1)=PRCH,DIE="^PRC(443.6,"_DA(1)_",6,",DA=PRCHAM,DR="9////^S X=$O(^PRCD(442.3,""C"",45,0))"
 D ^DIE
 S DELIVER=1,REPO=1,PRCHPO=PRCH,CAN=1 W !
 QUIT
MVADM ;Move Administrative Certifications from file 442
 Q:$D(^PRC(443.6,PRCHPO,15,0))&($P($G(^(0)),U,4)>0)  D WAIT^DICD
 N %X,%Y
 S %X="^PRC(442,PRCHPO,15,",%Y="^PRC(443.6,PRCHPO,15," D %XY^%RCR
 S $P(^PRC(443.6,PRCHPO,15,0),U,2)=$P(^DD(443.6,24,0),U,2)
 QUIT
ERCHK N NODE0
 S ERROR=0,NODE0=^PRC(443.6,PRCHPO,2,+PRCHI,0)
 I '$O(^PRC(443.6,PRCHPO,2,+PRCHI,1,0)) W !,"Line item ",+NODE0," is missing its description!",! S ERROR=1
 I $P(NODE0,U,4)="" W !,"Line item ",+NODE0," is missing BOC !",! S ERROR=1
 I $G(PRCHAUTH)'=1,$D(PRCHREQ),$P(NODE0,U,13)="" W !,"Line item ",+NODE0," is missing NSN !",! S ERROR=1
 I '$D(^PRC(443.6,PRCHPO,2,+PRCHI,2)) W !,"Line item ",+NODE0," is incomplete !",! S ERROR=1
 I $P($G(^PRC(442,PRCHPO,23)),U,11)="D",$P($G(^PRC(443.6,PRCHPO,2,+PRCHI,2)),U,2)="" W !,"Line item ",+NODE0," does contain contract number.",! S ERROR=1
 ;W:ERROR !,"Editing of the line item is required !",!
 Q
KILL ;Kill
 K PRCF,RETURN,PRCHAM,PRCHPO,PRCHNEW,OUT,A,B,ER,FL,FIS,DELIVER,PRCHAMDA
 K PRCHAV,PRCHL1,PRCHL2,ROU,DIC,I,PRCHAMT,PRCHAREC,PRCHEDI,X,Y,PRCHN
 K PRCHO,PRCHX,PRCHIMP,PRCHNRQ,PRCHP,PRCHPO,REPO,PRCHNORE,%,%A,%B,D0,D1
 K PRCHU,PRCHER,PRCHLN,PRCHRET,PRCHQ,AA,PRCHVN
 Q
ERR W !!?5,"To "_$S($D(PRCHREQ):$P(^PRCD(441.6,32,0),U,2),1:$P(^PRCD(442.2,32,0),U,2))_" it must be the ONLY change you",!?5,"are making on the amendment."
 Q
 ;
PCD ;PRC*5.1*79 - Check line items of Detailed PC orders with source code=6
 ;for missing contract number, called from PRCHMA.
 I $P($G(^PRC(442,PRCHPO,23)),U,11)="P",$P($G(^PRC(442,PRCHPO,1)),U,7)=6,$P($G(^PRC(443.6,PRCHPO,2,PRCH,2)),U,2)="" D:LCNT>END TOP^PRCHMA W !!,?5,"Line item ",+$P(PRCHLN,U)," is missing a required contract number.",$C(7) S PRCHER="",LNCT=LCNT+2
 Q 
