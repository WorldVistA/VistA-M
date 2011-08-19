PSDERD ;BIR/JPW-CS Error Log Edit ; 20 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S OK=$S($D(^XUSEC("PSDMGR",DUZ)):1,$D(^XUSEC("PSD ERROR",DUZ)):2,1:0)
 I 'OK W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to",!,?12,"the pending Controlled Substances error log.",!!,"PSDMGR or PSD ERROR security key required.",! K OK Q
 S PSDUZ=DUZ
 K LN S $P(LN,"-",30)=""
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4) G:$P(PSDSITE,U,5) EDIT
ASKD ;ask disp location
 W !!!,"You may select a Dispensing Site at the prompt.",!
 W ! K DIC,DA S DIC=58.8,DIC(0)="QEAZ"
 S DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0)"
 S DIC("A")="Select Dispensing Site: ",DIC("B")=PSDSN
 D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,PSDSN=$P(Y,"^",2),$P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
EDIT ;edit entry
 K DA,DIC S DIC=58.89,DIC("S")="I $P(^(0),""^"",6)=PSDS",DIC("A")="Select Error Log Number: ",DIC(0)="QEAZ"
 D ^DIC K DIC G:Y<0 END  S PSD=+Y,NODE=Y(0)
 S PSDA=+$P(NODE,"^",2),PSDATE=$P(NODE,"^",3) I PSDATE S Y=PSDATE X ^DD("DD") S PSDATE=Y
 ;transaction to edit
 I '$D(^PSD(58.81,PSDA,0)) W !!,"Transaction unavailable for editing.",!! G END
 W !!,"Accessing transaction now..."
 S NODE1=^PSD(58.81,PSDA,0),NODE9=$G(^PSD(58.81,PSDA,9))
 S PSDR=+$P(NODE1,"^",5),PSDRN=$P($G(^PSDRUG(PSDR,0)),"^"),PSDQTY=+$P(NODE1,"^",6)
 S PSDTYP=+$P(NODE1,"^",2),PSDTYP=$P($G(^PSD(58.84,PSDTYP,0)),"^")
 S PSD1=$S(+$P(NODE9,"^",2):+$P(NODE9,"^",2),+$P(NODE9,"^",8):+$P(NODE9,"^",8),+$P(NODE9,"^",11):+$P(NODE9,"^",11),1:"UNKNOWN")
 S:PSD1 PSD1=$P($G(^VA(200,PSD1,0)),"^")
 S PSD2=$S(+$P(NODE9,"^",6):+$P(NODE9,"^",6),+$P(NODE9,"^",9):+$P(NODE9,"^",9),+$P(NODE9,"^",12):+$P(NODE9,"^",12),1:"")
 S:PSD2 PSD2=$P($G(^VA(200,PSD2,0)),"^")
 D DISPLAY
DIE ;
 D NOW^%DTC S PSDT=+$E(%,1,12)
 W !!,"Enter your resolution.",!
 K DA,DIE,DR S DIE=58.89,DA=PSD,DR="5;4////"_PSDT_";3////"_PSDUZ D ^DIE K DA,DIE,DR
END ;
 K %,%DT,%H,%I,%ZIS,ALL,CNT,DA,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,LN,NODE,NODE1,NODE9
 K PG,PHARM,PHARMN,POP,PSD,PSD1,PSD2,PSDA,PSDATE,PSDED,PSDEV,PSDN,PSDOUT,PSDQTY,PSDR,PSDRG,PSDRN,PSDS,PSDSD,PSDSN,PSDT,PSDTYP,PSDUZ
 K QTY,RPDT,X,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 Q
DISPLAY ;display info
 W !!,"Transaction Information",!,LN,!
 W !,PSDRN,!,"Transaction Type: ",PSDTYP,!,"Date Entered: ",PSDATE,?50,"Quantity: ",PSDQTY,!,"Entered By: ",PSD1,! W:PSD2]"" "Witnessed By: ",PSD2,!
 Q
