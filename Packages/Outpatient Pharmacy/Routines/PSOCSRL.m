PSOCSRL ;BIR/BHW-release interface for control substance pkg ;7/22/94
 ;;7.0;OUTPATIENT PHARMACY;**27,71,118,148,247**;DEC 1997;Build 18
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External reference to ^PS(55 supported by DBIA 2228
 ;External reference to ^PS(59.7 supported by DBIA 694
 ;External reference to $$SERV^IBARX1 supported by DBIA 2245
EN(RXP,XTYPE,PSRH) ;
 N NCPDP
 I '$D(PSOPAR) D  G:'$D(PSOPAR) EX
 .D ^PSOLSET I '$D(PSOPAR) W $C(7),!!,?5,"Site Parameters must be defined to use the Release option!",! Q
 .S PSOCSUB=1
 K XFLAG D CS^PSOCMOPB(RXP) I $G(XFLAG) K XFLAG Q
 S Y=$G(^PS(59,PSOSITE,"IB")),PSOIBSS=$$SERV^IBARX1(+Y) I 'PSOIBSS D IBSSR^PSOUTL I 'PSOIBFL D  G EX
 .W $C(7),!!,"The IB SERVICE/SECTION defined in your site parameter file is not valid.",!,"You will not be able to release any medication until this is corrected!",!
 W !! S PSIN=+$P($G(^PS(59.7,1,49.99)),"^",2)
 Q:'$D(^XUSEC("PSORPH",PSRH))
 I '$D(^PSRX(+$G(RXP),0))!($G(RXP)']"") W !?7,$C(7),$C(7),$C(7),"   NON-EXISTENT PRESCRIPTION" G EX
 D:$P($G(^PS(55,+$P(^PSRX(+RXP,0),"^",2),0)),"^",6)'=2 EN^PSOHLUP($P(^PSRX(+RXP,0),"^",2))
 I +$P($G(^PSRX(+RXP,"STA")),"^")=13!+$P($G(^PSRX(+RXP,0)),"^",2)=0 W !?7,$C(7),$C(7),"    PRESCRIPTION IS A DELETED PERSCRIPTION NUMBER" G EX
 I +$P($G(^PSRX(+RXP,"STA")),"^"),$S($P(^("STA"),"^")=2:0,$P(^("STA"),"^")=5:0,$P(^("STA"),"^")=11:0,$P(^("STA"),"^")=12:0,1:1) G EX
 G:$G(XTYPE)]"" REF
ORI ;orig
 K LBLP,ISUF I $P(^PSRX(RXP,2),"^",13) S Y=$P(^PSRX(RXP,2),"^",13) X ^DD("DD") W !!?7,$C(7),$C(7),"ORIGINAL PRESCRIPTION WAS LAST RELEASED ON "_Y,! G EX
 I $P(^PSRX(RXP,2),"^",15) S RESK=$P(^(2),"^",15)  W !,"Original Fill returned to stock on "_$E(RESK,4,5)_"/"_$E(RESK,6,7)_"/"_$E(RESK,2,3),! G EX
 S PSOCPN=$P(^PSRX(RXP,0),"^",2),QTY=$P($G(^PSRX(RXP,0)),"^",7),QDRUG=$P(^PSRX(RXP,0),"^",6)
 I '$P($G(^PSRX(RXP,2)),"^",13),+$P($G(^(2)),"^",2)'<PSIN S RXFD=$P(^(2),"^",2) D  G:$G(PSOUT) EX D:$G(LBLP) UPDATE I $G(ISUF) D UPDATE
 .S SUPN=$O(^PS(52.5,"B",RXP,0)) I SUPN,$D(^PS(52.5,"C",RXFD,SUPN)),$G(^PS(52.5,SUPN,"P"))'=1 S ISUF=1 Q
 .;
 .F LBL=0:0 S LBL=$O(^PSRX(RXP,"L",LBL)) Q:'LBL  I '+$P(^PSRX(RXP,"L",LBL,0),"^",2),'$P(^(0),"^",5) S LBLP=1
 .Q:'$G(LBLP)  D ASK Q:$G(PSOUT)
 .;
 .; - Checking for OPEN/UNRESOLVED 3rd. Party Payer Rejects / NDC Editing
 .I $$MANREL^PSOBPSUT(RXP,0)="^" K LBLP Q
 .;
 .S:$D(^PSDRUG(QDRUG,660.1)) ^PSDRUG(QDRUG,660.1)=^PSDRUG(QDRUG,660.1)-QTY
 .Q:$P($G(^PSRX(RXP,2)),"^",13)
 .D NOW^%DTC S DIE="^PSRX(",DA=RXP,DR="31///"_%_";23///"_PSRH
 .D ^DIE K DIE,DR,DA,LBL
 .D EN^PSOHLSN1(RXP,"ZD")
 .; ECME - 3rd Party Billing
 .;
 .; - Notifying IB through ECME of the Rx being released
 .D IBSEND^PSOBPSUT(RXP,0)
 G EX
REF ;release ref or par
 K LBLP,ISUF,IFN D QTY S:($P($G(XTYPE),"^")="P") $P(^PSRX(RXP,"TYPE"),"^")=0
EX K OUT,RX2,RXFD,RESK,ISUF,SUPN,%,DIC,IFN,J,DA,DR,DIE,X,Y,RXP,REC,DIRUT,PSOCPN,PSOCPRX,PSOIBSS,PSOIBFL,PSOIBLP,PSOIBST,QDRUG,QTY,XTYPE,PSRH,Y,PSIN
 K DIR,DUOUT,DTOUT,LBL,LBLP,PSOUT
 Q
UPDATE I $G(ISUF) W $C(7),!!?7,$S($P(XTYPE,"^")=1:"RE",$P(XTYPE,"^")="P":"PARTIAL ",1:"ORIGINAL")_"FILL ON SUSPENSE !",!,$C(7) Q
 S PSOCPRX=$P(^PSRX(RXP,0),"^") D CP^PSOCP
 W !?7,"PRESCRIPTION NUMBER "_$P(^PSRX(RXP,0),"^")_" RELEASED"
 Q
QTY S PSOCPN=$P(^PSRX(RXP,0),"^",2),QDRUG=$P(^PSRX(RXP,0),"^",6) K LBLP
 D:$P($G(^PSRX(RXP,$P(XTYPE,"^"),$P(XTYPE,"^",2),0)),"^")'<PSIN  K ISUF,LBLP G:$G(PSOUT) EX
 .S RXFD=$E($P(^PSRX(RXP,$P(XTYPE,"^"),$P(XTYPE,"^",2),0),"^"),1,7),SUPN=$O(^PS(52.5,"B",RXP,0)) I SUPN,$D(^PS(52.5,"C",RXFD,SUPN)),$G(^PS(52.5,SUPN,"P"))'=1 S ISUF=1 D UPDATE Q
 .I $P(^PSRX(RXP,$P(XTYPE,"^"),$P(XTYPE,"^",2),0),"^",$S($P($G(XTYPE),"^"):18,1:19))]""!($P(^(0),"^",16)) K IFN Q
 .;
 .F LBL=0:0 S LBL=$O(^PSRX(RXP,"L",LBL)) Q:'LBL  I $P(^PSRX(RXP,"L",LBL,0),"^",2)=$S('$P(XTYPE,"^"):(99-$P(XTYPE,"^",2)),1:$P(XTYPE,"^",2)) S LBLP=1
 .Q:'$G(LBLP)  D ASK Q:$G(PSOUT)
 .;
 .; - Checking for OPEN/UNRESOLVED 3rd. Party Payer Rejects / NDC Editing
 .I XTYPE,$$MANREL^PSOBPSUT(RXP,$P(XTYPE,"^",2))="^" K LBLP Q
 .;
 .S IFN=$P(XTYPE,"^",2) S:$G(^PSDRUG(QDRUG,660.1))]"" QTY=$P(^PSRX(RXP,$P(XTYPE,"^"),$P(XTYPE,"^",2),0),"^",4),^PSDRUG(QDRUG,660.1)=^PSDRUG(QDRUG,660.1)-QTY
 .D NOW^%DTC S DIE="^PSRX("_RXP_","""_$P(XTYPE,"^")_""","
 .S DA(1)=RXP,DA=$P(XTYPE,"^",2)
 .S DR=$S(+XTYPE:17,1:8)_"///"_%_";"_$S(+XTYPE:4,1:.05)_"////"_PSRH
 .D ^DIE K DIE,DR,DA
 .K PSODISPP S:'$P($G(XTYPE),"^") PSODISPP=1 D EN^PSOHLSN1(RXP,"ZD") K PSODISPP
 .;
 .; - Notifying IB through ECME of the Rx being released
 .I XTYPE D IBSEND^PSOBPSUT(RXP,$P(XTYPE,"^",2))
 .;
 .K:+XTYPE ^PSRX("ACP",$P($G(^PSRX(RXP,0)),"^",2),$P($G(^PSRX(RXP,1,$P(XTYPE,"^",2),0)),"^"),$P(XTYPE,"^",2),RXP)
 .I +XTYPE,$G(IFN),'$G(ISUF) S PSOCPRX=$P(^PSRX(RXP,0),"^"),YY=$P(XTYPE,"^",2) D CP^PSOCP
 W:$G(IFN) !!?7,"PRESCRIPTION NUMBER "_$P(^PSRX(RXP,0),"^")_$S('+$G(XTYPE):" Partial Fill",1:" REFILL")_" #"_$P(XTYPE,"^",2)_" RELEASED"
 W:'$G(IFN) !!?7,$S(+$G(XTYPE):"REFILL",1:"PARTIAL")_" #"_$P(XTYPE,"^",2)_" NOT RELEASED"
 K IFN
 Q
ASK ;confirm
 W ! K DIR S DIR(0)="SA^1:YES;0:NO",DIR("B")="Yes",DIR("A",1)="Are You sure you want to release "_$S($G(XTYPE)']"":"Original ",$P(XTYPE,"^")=1:"Re",1:"Partial ")_"fill"_$S($P(XTYPE,"^",2):" #"_$P(XTYPE,"^",2),1:"")
 S DIR("A")="for Prescription #"_$P(^PSRX(RXP,0),"^")_": " D ^DIR K DIR
 S:'Y!($D(DIRUT)) PSOUT=1
 ;bingo board call
 I Y,$G(XTYPE)="",$P(^PSRX(RXP,0),"^",11)["W" S BINGRO="W",BINGNAM=$P(^PSRX(RXP,0),"^",2),BINGDIV=$P(^PSRX(RXP,2),"^",9)
 I Y,$G(XTYPE)["P",$P($G(^PSRX(RXP,"P",$P(XTYPE,"^",2),0)),"^",2)["W" S BINGRPR="W",BNGPDV=$P(^PSRX(RXP,"P",$P(XTYPE,"^",2),0),"^",9),BINGNAM=$P($G(^PSRX(RXP,0)),"^",2)
 I Y,+$G(XTYPE)=1,$P($G(^PSRX(RXP,1,$P(XTYPE,"^",2),0)),"^",2)["W" S BINGRPR="W",BNGRDV=$P(^PSRX(RXP,1,$P(XTYPE,"^",2),0),"^",9),BINGNAM=$P($G(^PSRX(RXP,0)),"^",2)
 I $D(DISGROUP),($D(BINGDIV)!$D(BNGPDV)!$D(BNGRDV)),($D(BINGRO)!$D(BINGRPR)) D REL^PSOBING1 K BINGNAM,BINGDIV,BINGRO,BINGRPR,BNGPDV,BNGRDV
 Q
