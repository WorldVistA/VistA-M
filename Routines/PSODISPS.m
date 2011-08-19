PSODISPS ;BIR/SAB-CONTINUATION OF RELEASE FUNCTION ;3/2/93
 ;;7.0;OUTPATIENT PHARMACY;**15,13,9,27,67,71,156,118,148,247,200**;DEC 1997;Build 7
 ;External reference ^PS(59.7 supported by DBIA 694
 ;External reference to ^PSDRUG("AQ" supported by DBIA 3165
 ;External reference ^XTMP("PSA" supported by DBIA 1036
 ;External reference $$SERV^IBARX1 supported by DBIA 2245
 ;External reference ^PSDRUG( supported by DBIA 221
 ;Reference to ^DIC(19.2 supported by DBIA 1064
 ;
QTY ; Refill Release
 S PSOCPN=$P(^PSRX(RXP,0),"^",2),QDRUG=$P(^PSRX(RXP,0),"^",6) K LBLP
 F YY=0:0 S YY=$O(^PSRX(RXP,XTYPE,YY)) Q:'YY  D:$P($G(^PSRX(RXP,XTYPE,YY,0)),"^")'<PSIN  K ISUF,LBLP
 .S RXFD=$E($P(^PSRX(RXP,XTYPE,YY,0),"^"),1,7),SUPN=$O(^PS(52.5,"B",RXP,0)) I SUPN,$D(^PS(52.5,"C",RXFD,SUPN)),$G(^PS(52.5,SUPN,"P"))'=1,$G(XTYPE) S ISUF=1 Q
 .I XTYPE=1,($D(^PSDRUG("AQ",QDRUG))) K CMOP D RREL^PSOCMOPB(RXP,YY) K CMOP Q:$G(ISUF)
 .I $P(^PSRX(RXP,XTYPE,YY,0),"^",$S($G(XTYPE):18,1:19))]""!($P(^(0),"^",16)) K IFN Q
 .;
 .F LBL=0:0 S LBL=$O(^PSRX(RXP,"L",LBL)) Q:'LBL  I $P(^PSRX(RXP,"L",LBL,0),"^",2)=$S('XTYPE:(99-YY),1:YY) S LBLP=1
 .Q:'$G(LBLP)
 .D CHKADDR(RXP)
 .;
 .; - Checking for OPEN/UNRESOLVED 3rd. Party Payer Rejects / NDC Editing
 .I XTYPE,$$MANREL^PSOBPSUT(RXP,YY,$G(PSOPID))="^" K LBLP Q
 .;
 .S IFN=YY S:$G(^PSDRUG(QDRUG,660.1))]"" QTY=$P(^PSRX(RXP,XTYPE,YY,0),"^",4),^PSDRUG(QDRUG,660.1)=^PSDRUG(QDRUG,660.1)-QTY
 .K DA,DR,DIE D NOW^%DTC S DIE="^PSRX("_RXP_","""_XTYPE_""",",DA(1)=RXP
 .S DA=YY,DR=$S(XTYPE:17,1:8)_"///"_%_";"_$S(XTYPE:4,1:.05)_"////"_PSRH
 .S PSODT=% D ^DIE K DIE,DR,DA
 .;
 .; - Notifying IB through ECME of the Rx being released
 .I XTYPE D IBSEND^PSOBPSUT(RXP,YY)
 .;
 .K PSODISPP S:$G(XTYPE)="P" PSODISPP=1 D EN^PSOHLSN1(RXP,"ZD") K PSODISPP
 .K:XTYPE ^PSRX("ACP",$P($G(^PSRX(RXP,0)),"^",2),$P($G(^PSRX(RXP,1,YY,0)),"^"),YY,RXP)
 .I XTYPE,$G(IFN),'$G(ISUF) S PSOCPRX=$P(^PSRX(RXP,0),"^") D CP^PSOCP
 .;if appropriate update ^XTMP("PSA", for Drug Acct.
 .I $G(PSODA),$G(PSODA(1)),'$D(^PSRX("AR",+PSODT,+RXP,YY)) D
 ..S ^XTMP("PSA",+PSOSITE,+QDRUG,DT)=$G(^XTMP("PSA",+PSOSITE,+QDRUG,DT))+$P($G(^PSRX(RXP,XTYPE,YY,0)),"^",4)
 .;initialize bingo board variables
 .I $G(IFN),$P($G(^PSRX(RXP,XTYPE,IFN,0)),"^",2)["W" S BINGRPR="W",BNGPDV=$P(^PSRX(RXP,XTYPE,IFN,0),"^",9),BINGNAM=$P($G(^PSRX(RXP,0)),"^",2)
 W:$G(IFN) !?7,"Prescription Number "_$P(^PSRX(RXP,0),"^")_$S('$G(XTYPE):" Partial Fill",1:" Refill(s)")_" Released" I $G(SPEED) G XMIT
 W:'$G(IFN) !?7,"No "_$S($G(XTYPE):"Refill(s)",1:"Partial(s)")_" to be Released"
XMIT I $G(PSODISP)=2.4 D  ;build an send HL7 v2.4 messages to dispense system
 . F I=0:0 S SUB=$O(^PSRX(RXP,"A",I)) Q:'I  I $P(^PSRX(RXP,"A",I,0),"^",2)="N" D
 .. D NOW^%DTC S PSODTM=% K ^UTILITY($J,"PSOHL")
 .. S IDGN=$P(^PSRX(+RXP,0),"^",6),FP=$S(XTYPE=1:"R",1:"P")
 .. S ^UTILITY($J,"PSOHL",1)=+RXP_"^"_IDGN_"^"_PSODTM_"^"_+$G(PDUZ)_"^0^^PSO DISP^^^"_FP_"^"_IFN
 .. S ZTRTN="INIT^PSORELDT",ZTDESC="EXTERNAL INTERFACE FOR RELEASE DATE/TIME",ZTIO="",ZTDTH=$H,ZTSAVE("^UTILITY($J,""PSOHL"",")="",ZTSAVE("PSOSITE")="",ZTSAVE("RXP")="" D ^%ZTLOAD K ^UTILITY($J,"PSOHL")
 K IFN
 Q
STAT S RX0=^PSRX(RXP,0),$P(RX0,"^",15)=+^("STA"),RX2=^PSRX(RXP,2),J=RXP D ^PSOFUNC
 W !!?5,$C(7),$C(7),"Rx# "_$P(^PSRX(RXP,0),"^")_" has a status of "_ST_" and is not eligible for",!?5,"release."_$S('$D(^XUSEC("PSORPH",DUZ)):"  Please check with a Pharmacist!",1:"")
 K RX0,ST
 Q
OERR I '$D(PSOPAR) D ^PSOLSET I '$D(PSOPAR) W $C(7),!!,?5,"Site Parameters must be defined to use the Release option!",! S VALMBCK="" Q
 S VALMBCK="Q",Y=$G(^PS(59,PSOSITE,"IB")),PSOIBSS=$$SERV^IBARX1(+Y) I 'PSOIBSS D IBSSR^PSOUTL I 'PSOIBFL D  S VALMBCK="" G EX
 .W $C(7),!!,"The IB SERVICE/SECTION defined in your site parameter file is not valid.",!,"You will not be able to release any medication until this is corrected!",!
 W !! S PSIN=+$P($G(^PS(59.7,1,49.99)),"^",2),RXP=$P(PSOLST($P(PSLST,",",ORD)),"^",2)
 S DIC("S")="I $D(^XUSEC(""PSORPH"",+Y))",DIC("A")="Enter PHARMACIST: ",DIC="^VA(200,",DIC(0)="QEAM" D ^DIC G:"^"[X EX K DIC G:$D(DTOUT)!($D(DUOUT))!($D(DIRUT))!(Y=-1) EX S PSRH=+Y
 ;check for Drug Acct background job K8 & K7.1
 S X="PSA IV ALL LOCATIONS",DIC(0)="MZ",DIC=19.2 D ^DIC I Y=-1 K DIC,X,Y G DOIT
 I $P($G(Y(0)),U,2)>DT S PSODA=1 S:'$P($G(^XTMP("PSA",0)),U,2) $P(^(0),U,2)=DT G DOIT
 S X="PSA IV ALL LOCATIONS",DIC(0)="MZ",DIC=19 D ^DIC K DIC,X G:Y=-1 DOIT
 K DIQ,PSA S DA=+Y,DIC=19,DIQ="PSA",DR=200,DIQ(0)="IN" D EN^DIQ1
 I '$D(PSA(19,DA,200,"I")) K DIC,DA,X,Y,DIQ G DOIT
 I PSA(19,DA,200,"I")>DT S PSODA=1 S:'$P($G(^XTMP("PSA",0)),U,2) $P(^(0),U,2)=DT
 K PSA,DIC,DA,X,Y,DIQ
 ;
DOIT S POERR=1 D FULL^VALM1,BC1^PSODISP
 I $D(DISGROUP),$D(BINGNAM),($D(BINGDIV)!$D(BNGPDV)!$D(BNGRDV)),($D(BINGRO)!$D(BINGRPR)) N TM,TM1 D REL^PSOBING1 K BINGNAM,BINGDIV,BINGRO,BINGRPR,BNGPDV,BNGRDV
EX ;
 K OUT,RX2,RXFD,RESK,ISUF,SUPN,%,DIC,IFN,J,DA,DR,DIE,X,X1,X2,Y,RXP,CX,PX,REC,DIR,YDT,REC,RDUZ,DIRUT,PSOCPN,PSOCPRX,PSOIBSS,PSOIBFL,PSOIBLP,PSOIBST,YY,QDRUG,QTY,TYPE,XTYPE,DUOUT,PSRH,XX,Y,PSIN,POERR,SUB
 K DIR S DIR("A",1)=" ",DIR("A")="Press Return to Continue",DIR(0)="E" D ^DIR K DIRUT,DUOUT,DTOUT,DIR S VALMBCK="R"
 S PSORXED=1 D ^PSOBUILD,ACT^PSOORNE2 K PSORXED
 Q
 ;
CHKADDR(RXP) ;
 N PSOTXT,PSOBADR,PSOTEMP,LBL
 S LBL=$O(^PSRX(RXP,"L",99999),-1) I LBL>0 D
 .S PSOTXT=$G(^PSRX(RXP,"L",LBL,0)) I PSOTXT'["(BAD ADDRESS)" Q
 .S PSOBADR=$$CHKRX^PSOBAI(RXP)
 .I '$G(PSOBADR) D SETLBL(LBL,"NO BAD ADDRESS INDICATOR AT RELEASE") Q
 .I $P(PSOBADR,"^",2) D SETLBL(LBL,"ACTIVE TEMPORARY ADDRESS AT RELEASE")
 Q
 ;
SETLBL(LBL,PSOMSG) ;
 N PSOTXT
 S PSOTXT=$G(^PSRX(RXP,"L",LBL,0)),$P(PSOTXT,"^",3)=PSOMSG
 S LBL=LBL+1,^PSRX(RXP,"L",0)="^52.032DA^"_LBL_"^"_LBL
 S ^PSRX(RXP,"L",LBL,0)=PSOTXT
 Q
