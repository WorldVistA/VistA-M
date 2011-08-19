PRCH7B ;WISC/PLT/CR-PURCHASE CARD PROSTHETICS ORDER INTERFACE ;05/18/1998 @ 10:33
V ;;5.1;IFCAP;**18**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
 ;.prca passing ^1= station #, ^2=ri of 440 (vendor)
 ;.prca return variable  ^1=ri of 442, ^2=p.o. order # without station #
 ;            ^3=card #
 ; or "^" for quit
ADD(PRCA) ;add new order
 N PRCHPC,PRCPROST,PRCRI
 N DA,A,B,X,Y
 D DUZ^PRCFSITE
 S PRCRI(420)=+PRCA,PRC("SITE")=$P(PRCA,"^"),PRCRI(440)=$P(PRCA,"^",2)
 S X="" S:$D(PRC("SITE")) PRC("PARAM")=^PRC(411,PRC("SITE"),0)
 S (PRCPROST,PRCHPC)=1
 D ENPO^PRCHUTL G:'$D(PRCHPO) ADDEX D LCK1^PRCHE G:'$G(DA) ADDEX D ^PRCHNPO L -^PRC(442,DA)
ADDEX S PRCA="" I PRCPROST=1.9 S PRCA=+DA,A=$P(^PRC(442,PRCA,0),"^"),$P(PRCA,"^",2)=$P(A,"-",2),$P(PRCA,"^",3)=$P($G(^(23)),"^",16)
 I PRCA="" D:$G(DA) CANIC(+DA) S PRCA="^"
 D
 . N PRCA D Q^PRCHNPO4
 . QUIT
 QUIT
 ;
EDITIC(PRCA,PRCB) ;edit order, prca=ri of prostheic order, prcb=ri of file 442
 N PRCPROST,PRCHPC,PRCRI,DA,A,B,X,Y
 N FLG1 S FLG1=1
 S PRCPROST=2,PRCHPC=1
 D DUZ^PRCFSITE S PRC("SITE")=$P(^PRC(442,PRCB,0),"-")
 S:$D(PRC("SITE")) PRC("PARAM")=^PRC(411,PRC("SITE"),0)
 S PRCRI(442)=+PRCB,DA=+PRCB D LCK1^PRCHE S PRCHPO=PRCRI(442) D ^PRCHNPO L -^PRC(442,PRCRI(442))
 QUIT
 ;
 ;.X = "^" if abort
OBL(X,PRCA,PRCB,PRCC) ;obligate order, prca=ri of prosthetic order, prcb=ri of file 442, prcc=total cost
 N PRCPROST,PRCHPC,PRCRI,A,B,Y,DIE
 N PRCHPO,PRCHTOT,PRCHBOCC,PRCHBOC1,PRCHN
 D DUZ^PRCFSITE
 S PRCPROST=3,PRCHPC=1
 S PRCRI(442)=PRCB
 S PRCHPO=PRCRI(442),PRCHTOT=PRCC
 S A=^PRC(440.5,$P(^PRC(442,PRCRI(442),23),"^",8),0),PRCHBOC1=$P(A,U,4)
 S DIE="^PRC(442,",DA=PRCHPO,DR="60////"_PRCHTOT_";91////"_PRCHTOT_";65////RMPR" D ^DIE K DR
 S PRCHN("SFC")=+$P(^PRC(442,PRCRI(442),0),U,19)
 S:'$D(^PRC(442,PRCHPO,2,0)) $P(^PRC(442,PRCHPO,2,0),U,2)=$P(^DD(442,40,0),U,2)
 S DA(1)=PRCHPO,DIE="^PRC(442,"_DA(1)_",2,",DA=1
 S DR=".01///^S X=1;1///Prosthetic Order;2///^S X=1;3///^S X=""EA"";5////^S X=PRCHTOT;3.1///^S X=1;9.7///^S X=1;9///^S X="""";8///^S X=9999;K PRCHBOCC;"
 S DR(1,442.01,1)="I PRCHN(""SFC"")=2 S PRCHBOCC=2696;I '$G(PRCHBOCC) S Y=""@87"";"
 S DR(1,442.01,2)="S PRCHBOCC=$P($G(^PRCD(420.2,PRCHBOCC,0)),U);3.5////^S X=PRCHBOCC;S Y=""@89"";@87;3.5////^S X=PRCHBOC1;@89;K PRCHBOCC"
 D ^DIE
 ;S DIE="^PRC(442,",DA=PRCHPO,DR=20 D ^DIE
 I '$D(Y) D PROS^PRCHNPO
 S X="" I PRCPROST=3 D CANIC(PRCRI(442)) S X="^"
 QUIT
 ;
CANIC(PRCA) ;cancel order, prca=ri of prosthetic order, prcb=ri file 442
 N PRCPROST,PRCHPC,A,B,X,Y
 S PRCPROST=99,PRCHPC=1
 D EDIT^PRC0B(.X,"442;^PRC(442,;"_PRCA,".5///^S X=45")
 S DA=PRCA D C2237^PRCH442A K DA,%A,%B,%
 QUIT
 ;
 ;.x return variable ="^" if abort
 ; prca = ri of prosthetic order, prcb = ri of file 442, prcc=zero amount
 ; flag RMPRPRCH is used to notify RMPR when order cancellation is not
 ; allowed.
CAN(X,PRCA,PRCB,PRCC) ;cancel prosthetic order
 N PRC,PRCRI,PRCPROST,PRCHAUTH
 N Y
 N PRCF,RETURN,PRCHAM,PRCHPO,PRCHNEW,OUT,CAN,PRCHAU,PRCHER,PRCHON,NOCAN
 N A,B,ER,FL,FIS,DELIVER,PRCHAMDA,PRCHAV,PRCHL1,PRCHLN,PRCHRET,LCNT
 N PRCHX,PRCHIMP,PRCHNRQ,PRCHP,PRCHPO,REPO,PRCHNORE,%,%A,%B,D0,D1,J
 N PRCHL2,ROU,DIC,I,PRCHAMT,PRCHAREC,PRCHEDI,PRCHN,PRCHO,SFUND
 D DUZ^PRCFSITE
 S PRCHNEW="",PRCHNORE=1,CAN=1,RMPRPRCH=0,PRCHSTOP=""
 S PRCHAUTH=1,PRCPROST=90
 S PRCRI(442)=+PRCB,PRCHPO=PRCRI(442)
 S A=$P(^PRC(442,PRCRI(442),0),"^"),PRC("SITE")=$P(A,"-")
 I '$$VERIFY^PRCHES5(PRCHPO) W !!,?5,"This purchase order has been tampered with.",!,?5,"Please notify IFCAP APPLICATION COORDINATOR.",! G CANEX
 ; S B=5 D ICLOCK^PRC0B("^PRC(442,"_PRCHPO_",",.B)
 ; check if payment has been made, set flag RMPRPRCH and quit.
 I $D(^PRC(442,PRCHPO,7)) D  Q:$G(RMPRPRCH)=1
 . S PRCHSTOP=$P($G(^PRC(442,PRCHPO,7)),U)
 . I $P($G(^PRCD(442.3,PRCHSTOP,0)),"(")="Paid " S RMPRPRCH=1
 . I $P($G(^PRCD(442.3,PRCHSTOP,0)),"(")="Partial Payment " S RMPRPRCH=1
 . I RMPRPRCH=1 S X="^" W !,$C(7),?5,"A PAYMENT HAS BEEN MADE FOR THIS PURCHASE CARD ORDER, CANNOT CANCEL!" H 3
 ; D AMENDNO^PRCHAMU D DCLOCK^PRC0B("^PRC(442,"_PRCHPO_",") G:'$G(PRCHAM) CANEX
 ; check if entry is available.
 S PRCENTRY=PRCHPO
 L +^PRC(442,PRCHPO):0 E  W !,"Someone else is editing this entry, try later." G CANEX
 ;
 ; check for any pending amendment for the order before creating another
 ; amendment.
 I $D(^PRC(443.6,PRCHPO,0)) D  G:%'=1 CANEX
 . W @IOF,"*** You already have one pending amendment for this order. ***",!,$C(7)
 . W !,"    If you proceed, your previous amendment will be DELETED."
 . W !
 . S %=2,%B="",%A="    DO YOU REALLY WANT TO CONTINUE" D ^PRCFYN W !
 . Q:%'=1
 . W !," ...DELETING previous amendment..."
 . S Y=PRCHPO D DEL^PRCHAMU H 5 W "...DONE!" W !
 . W !," ...Preparing to cancel the order..." H 3 W !
 . S %=2,%B="",%A="    Continue with CANCELLATION" D ^PRCFYN W ! Q:%'=1
 ;
 D AMENDNO^PRCHAMU G:'$G(PRCHAM) CANEX
 S PRCHAMT=0,FL=0 D INFO^PRCHAMU G:$D(PRCHAV)!ER CANEX
 S X=$P($G(^PRC(443.6,PRCHPO,0)),U,16) D EN2^PRCHAMXB
 I PRCHNEW="" S DA(1)=PRCHPO,DA=PRCHAM,PRCHX=X,X=0,PRCHAMDA=34 D EN8^PRCHAMXB S X=PRCHX
 I $P(^PRC(443.6,PRCHPO,6,PRCHAM,0),U,4)=5!($P(^(0),U,4)=15) S CAN=1
 I $G(CAN)>0 D ENC^PRCHMA G:ER CANEX I $G(NOCAN)=0 S DA(1)=PRCHPO,DA=PRCHAM,PRCHAMDA=34,PRCHX=X,X=0 D EN8^PRCHAMXB S X=PRCHX D CAN1^PRCHMA
 K FIS,REPO,DEL
CANEX S X="" I PRCPROST=90 S X="^"
 QUIT
