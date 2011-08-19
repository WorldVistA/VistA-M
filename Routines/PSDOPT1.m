PSDOPT1 ;BIR/JPW,LTL - Outpatient Rx Entry (cont'd) ;20 July 94
 ;;3.0;CONTROLLED SUBSTANCES;**30,66,71**;13 Feb 97;Build 29
 ;Reference to PS(52.5 supported by DBIA #786
 ;References to ^PSD(58.8 are covered by DBIA #2711
 ;References to file 58.81 are covered by DBIA #2808
 ;Reference to PSRX( supported by DBIA #986
 ;Reference to routine PSOCSRL supported by DBIA #983
UPDATE W !!,"Creating an Outpatient Transaction..."
 F  L +^PSD(58.8,+PSDS,1,PSDR,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 D NOW^%DTC S PSDT=+% S BAL=+$P(^PSD(58.8,+PSDS,1,PSDR,0),"^",4),$P(^(0),"^",4)=$P(^(0),"^",4)-QTY
 L -^PSD(58.8,+PSDS,1,PSDR,0)
 W "updating..."
 F  L +^PSD(58.81,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
FIND S PSDA=$P(^PSD(58.81,0),"^",3)+1 I $D(^PSD(58.81,PSDA)) S $P(^PSD(58.81,0),"^",3)=PSDA G FIND
 K DA,DIC,DLAYGO S (DIC,DLAYGO)=58.81,DIC(0)="L",(X,DINUM)=PSDA D ^DIC K DIC,DLAYGO
 L -^PSD(58.81,0)
ADD ;set trans
 S ^PSD(58.81,PSDA,0)=PSDA_"^6^"_+PSDS_"^"_PSDT_"^"_PSDR_"^"_QTY_"^"_PSDUZ_"^^^"_BAL
 S ^PSD(58.81,PSDA,6)=PSDRX_"^"_$S($G(NEW(1)):NEW(1),1:"")_"^"_DAT_"^"_$S($G(NEW(2)):NEW(2),1:"")_"^"_RXNUM_"^"_PSDRPH
 S ^PSD(58.81,PSDA,"CS")=1
 S DIK="^PSD(58.81,",DA=PSDA D IX^DIK K DA,DIK
 W "vault activity..."
DIE I '$D(^PSD(58.8,+PSDS,1,PSDR,4,0)) S ^(0)="^58.800119PA^^"
 K DA,DIC,DD,DO S DA(1)=PSDR,DA(2)=+PSDS,(X,DINUM)=PSDA,DIC(0)="L",DIC="^PSD(58.8,"_+PSDS_",1,"_PSDR_",4," D FILE^DICN K DIC,DINUM
 ;monthly activity
 I '$D(^PSD(58.8,+PSDS,1,PSDR,5,0)) S ^(0)="^58.801A^^"
 I '$D(^PSD(58.8,+PSDS,1,PSDR,5,$E(DT,1,5)*100,0)) K DA,DIC S DIC="^PSD(58.8,"_+PSDS_",1,"_PSDR_",5,",DIC(0)="LM",DLAYGO=58.8,(X,DINUM)=$E(DT,1,5)*100,DA(2)=+PSDS,DA(1)=PSDR D ^DIC K DA,DIC,DINUM,DLAYGO
 K DA,DIE,DR S DIE="^PSD(58.8,"_+PSDS_",1,"_PSDR_",5,",DA(2)=+PSDS,DA(1)=PSDR,DA=$E(DT,1,5)*100,DR="9////^S X=$P($G(^(0)),""^"",6)+QTY" D ^DIE K DA,DIE,DR
 W "done."
 ;check if user has access to release
 D CHKEY^PSDOPT I $G(PSDOUT) Q
 ;PSD*3*30 (Dave B) Check for already released
 I $G(PSDREL)'="" Q
 I $G(PSDRTS)=1 K PSDRTS Q
PSDREL S X="PSOCSRL" X ^%ZOSF("TEST") I $T S XTYPE=$S($G(NEW(2)):"P"_U_NEW(2),$G(NEW(1)):1_U_NEW(1),1:"") D EN^PSOCSRL(PSDRX,XTYPE,PSDRPH)
 Q
 ;
PSDRTS ;Returned to stock continued
 W !,"Updating balances"
 F  L +^PSD(58.8,+PSDS,1,PSDR,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 D NOW^%DTC S PSDT=+%,BAL=+$P(^PSD(58.8,+PSDS,1,PSDR,0),"^",4),$P(^PSD(58.8,+PSDS,1,PSDR,0),"^",4)=$P(^PSD(58.8,+PSDS,1,PSDR,0),"^",4)+PSDQTY
 L -^PSD(58.8,+PSDS,1,PSDR,0) W "."
 F  L +^PSD(58.81,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
FIND1 S PSDA=$P(^PSD(58.81,0),"^",3)+1 I $D(^PSD(58.81,PSDA)) S $P(^PSD(58.81,0),"^",3)=PSDA G FIND1
 K DA,DIC,DLAYGO S (DIC,DLAYGO)=58.81,DIC(0)="L",(X,DINUM)=PSDA D ^DIC K DIC,DLAYGO
 L -^PSD(58.81,0)
 S ^PSD(58.81,PSDA,0)=PSDA_"^3^"_+PSDS_"^"_PSDT_"^"_PSDR_"^"_PSDQTY_"^"_PSDUZ_"^^^"_BAL
 S ^PSD(58.81,PSDA,3)=PSDT_"^"_PSDQTY_"^"_"Returned by Outpatient"
 S ^PSD(58.81,PSDA,"CS")=1
 S ^PSD(58.81,PSDA,6)=PSDRX_"^"_$S($G(PSDFILL)="R":PSDNUM1,1:"")_"^"_DAT_"^"_$S($G(PSDFILL)="P":PSDNUM1,1:"")_"^"_RXNUM_"^"_PSDRPH
 S PSDRTS=1,QTY=-PSDQTY D DIE
 Q
 ;
PSDORIG ;Check original labels
 ;Check for suspense
 I +$P($G(^PSRX(PSDRX,2)),U,2)'<PSDOIN S PSDRXFD=$P(^(2),U,2) D
 .S PSDSUPN=$O(^PS(52.5,"B",PSDRX,0))
 .I PSDSUPN,$D(^PS(52.5,"C",PSDRXFD,PSDSUPN)),$G(^PS(52.5,PSDSUPN,"P"))'=1 W !!,"Original suspended." S PSDRX(1)="" Q
 .K PSDLBL D VER^PSDOPT
 .I $G(PSOVR) F PSDLBL=0:0 S PSDLBL=$O(^PSRX(PSDRX,"L",PSDLBL)) Q:'PSDLBL  I '+$P($G(^PSRX(PSDRX,"L",PSDLBL,0)),"^",2),'$P($G(^(0)),"^",5) S PSDLBL(1)=1
 .I '$G(PSOVR) F PSDLBL=0:0 S PSDLBL=$O(^PSRX(PSDRX,"L",PSDLBL)) Q:'PSDLBL  I '+$P($G(^PSRX(PSDRX,"L",PSDLBL,0)),"^",2),$P($G(^(0)),"^",5)'["INTERACTION" S PSDLBL(1)=1
 .K PSOVR,PSDERR,PSDSTA,PSDRXIN I '$G(PSDLBL(1)) S PSDRX(1)="",PSDOUT=1 W !!,"Original label not printed." Q
 Q
PSDRFL ;Check refill labels
 I $D(^PSRX(PSDRX,1,PSDFLNO,0)),'$P(^(0),U,16),$P($G(^(0)),U)'<PSDOIN D
 .F PSDLBL=0:0 S PSDLBL=$O(^PSRX(PSDRX,"L",PSDLBL)) Q:'PSDLBL  I $P(^PSRX(PSDRX,"L",PSDLBL,0),U,2)=PSDFLNO S PSDLBL(1)=1
 .I '$G(PSDLBL(1)) W !!,"Refill #",PSDFLNO," label not printed." S PSDOUT=1,PSDRX(1)="" Q
 Q
PSDPRTL ;Chec partial labels
 I $D(^PSRX(PSDRX,"P",PSDFLNO,0)),'$P(^(0),U,16),$P($G(^(0)),U)'<PSDOIN D
 .F PSDLBL=0:0 S PSDLBL=$O(^PSRX(PSDRX,"L",PSDLBL)) Q:'PSDLBL  I $P(^PSRX(PSDRX,"L",0),U,2)=99-PSDFLNO S PSDLBL(1)=1
 .I '$G(PSDLBL(1)) W !!,"Partial #",PSDFLNO," label not printed." S PSDOUT=1,PSDRX(1)="" Q
 Q
RTSMUL ; Setup local array of refills in reverse order
 S PSD1=0 F  S PSD1=$O(^PSD(58.81,"AOP",PSDRX,PSD1)) Q:PSD1'>0  S DATA6=$G(^PSD(58.81,PSD1,6)) D
 .S PSDXXX=PSD1
 .S PSD1MUL=PSD1*-1
 .S PSDMUL(PSD1MUL)=$P(DATA6,"^",2)
 Q
