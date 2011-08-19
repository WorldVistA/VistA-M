PSDMFG ;BIR/JPW-Enter/Edit Drug Mfg/Lot #/Exp. Dates ; 8 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 W !!,"Enter Manufacturer, Lot #, and/or Expiration Dates for Stock Drugs"
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
 I $P(PSDSITE,U,5) S PSDOUT=0 W !!,"Dispensing Site: ",PSDSN,! D DIE G END
MFG ;
 S PSDOUT=0 K DA,DIC S DIC("B")=$P(PSDSITE,U,4)
SEL ;select disp site
 W ! S DIC=58.8,DIC(0)="QEA",DIC("A")="Select Dispensing Site: ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)=""M"":1,$P(^(0),""^"",2)=""S"":1,1:0)"
 D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,$P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=$P(Y,U,2)
 D DIE G:PSDOUT END
 G SEL
END K DA,DIC,DIE,DR,DTOUT,DUOUT,PSDOUT,PSDS,PSDSN,PSDR,SITE,X,Y
 Q
DIE ;edit mfg/lot#/exp. date
 I '$D(^PSD(58.8,PSDS,1,0)) W !!,"There are no stocked drugs for this Dispensing Site!!",!! Q
 W ! K DA,DIC S DIC("W")="W:$P(^PSDRUG(Y,0),""^"",9) ""   N/F"" I $P(^PSD(58.8,PSDS,1,Y,0),""^"",14)]"""",$P(^(0),""^"",14)'>DT W $C(7),""   *** INACTIVE ***"""
 S DA(1)=+PSDS,DIC(0)="QEAMZ",DIC="^PSD(58.8,"_PSDS_",1," D ^DIC K DIC I $D(DTOUT)!($D(DUOUT)) S PSDOUT=1 Q
 Q:Y<0
 S PSDR=+Y W !!,"STOCKED DRUG: "_Y(0,0) I $P($G(^PSD(58.8,PSDS,1,PSDR,0)),"^",14)]"",$P(^(0),"^",14)'>DT W ?45,"   *** INACTIVE ***"
 K DA,DIE,DR S DIE="^PSD(58.8,"_PSDS_",1,",DA(1)=+PSDS,DA=+PSDR,DR="9;10;11" D ^DIE K DA,DIE,DR
 G DIE
