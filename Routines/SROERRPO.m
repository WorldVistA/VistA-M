SROERRPO ;B'HAM ISC/ADM - ORDER ENTRY ROUTINE ; 8 JULY 1992  10:00 am
 ;;3.0; Surgery ;;24 Jun 93
 S SRSOUT=0 W @IOF,!,"Move Surgical Cases into the ORDER file",!!!
 I '$D(^ORD(100.99)) W "OE/RR package has not been installed." D RET G END
 W "This option is used to 'back fill' the ORDER file with existing Surgical cases.",!!,"NOTE: Upon the completion of the running of this process, this option will",!,?6,"be deleted from your system."
 W !! K DIR S DIR("A")="Are you sure you want to continue ",DIR("B")="NO",DIR(0)="Y" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) G END
 I 'Y G END
DAYS W !!!,"Add Surgical cases for the last how many days ? " R X:DTIME I '$T!(X["^") G END
 I X'?1.2N!(X<1)!(X>90) W !!,"Enter a number between 1 and 90, inclusive.  This is the number of days in the",!,"past for which Surgical cases should be added to the ORDER file (100) for the",!,"OE/RR package." G DAYS
 S SRD=X,X="T-"_SRD D ^%DT S SRST=Y D DD^%DT W !!,"Surgical cases since ",Y," will now be added to the ORDER file (100)."
 S SRDT=SRST-.0001,X=$O(^DIC(19,"B","SR SURGERY REQUEST",0)),SRPCL=X_";DIC(19,",CNT=0
 F  S SRDT=$O(^SRF("AC",SRDT)) Q:'SRDT  S SRTN=0 F  S SRTN=$O(^SRF("AC",SRDT,SRTN)) Q:'SRTN  S SROERR=SRTN,ORPCL=SRPCL D ORD I SRSOUT D RET G END
 W !,CNT," surgical cases have been added to the ORDER file.",!! D REMOVE
END W @IOF K ORIFN,ORPCL,SROERR,SRTN D ^SRSKILL
 Q
ORD I '$D(^SRF(SRTN,0)) K ^SRF(SRTN),^SRF("AC",SRDT,SRTN) Q
 Q:$P(^SRF(SRTN,0),"^",14)  I $P($G(^SRF(SRTN,"NON")),"^")="Y" D NON
 D STATUS^SROERR0 S SRSOP=$P($G(^SRF(SRTN,"OP")),"^"),ORVP=$P(^(0),"^")_";DPT(" S:'$D(ORNP) ORNP=$P($G(^SRF(SRTN,.1)),"^",4) Q:'ORNP!(SRSOP="")
 S ORTX=SRSOP_"|>> Case #"_SROERR_" "_SRSTATUS,ORSTRT=SRDT,ORPK=SRTN S:'$D(ORL) ORL=""
 D FILE^ORX I 'ORIFN W !!,"Unable to add Surgical cases to ORDER file.  Please check ORDER PARAMETERS file." S SRSOUT=1 Q
 K DIE,DA,DR S DA=SRTN,DIE=130,DR="100////"_ORIFN D ^DIE
 I ORIFN S CNT=CNT+1 W:'(CNT#10) "."
 Q
NON S SRL=$P(^SRF(SRTN,"NON"),"^",2),ORL=$S(SRL:SRL_";SC(",1:"")
 S ORNP=$P(^SRF(SRTN,"NON"),"^",6)
 Q
REMOVE ; remove option from option file
 S SRMENU=$O(^DIC(19,"B","SRO PACKAGE MANAGEMENT",0)) I 'SRMENU D RET Q
 S SROPT=$O(^DIC(19,"B","SROERR BACKFILL",0)) I 'SROPT D RET Q
 S INT=$O(^DIC(19,SRMENU,10,"B",SROPT,0)) I 'INT D RET Q
 W !!,"This option will now be removed from your system..."
 K DA,DIK S DA(1)=SRMENU,DA=INT,DIK="^DIC(19,"_DA(1)_",10," D ^DIK K DA,DIK S DA=SROPT,DIK="^DIC(19," D ^DIK
RET W !!,"Press RETURN to continue  " R X:DTIME
 Q
