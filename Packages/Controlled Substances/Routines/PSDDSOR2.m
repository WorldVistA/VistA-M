PSDDSOR2 ;BIR/MHA-Digitally Signed OP Released Rx Report; 05/09/03
 ;;3.0; CONTROLLED SUBSTANCES ;**40,42,45**;13 Feb 97
 ;Ref. ^PSD(58.8 supp. by IA 2711
 ;Ref. ^PSD(58.81 supp. by IA 2808
 ;Ref. ^PSRX( supp. by IA 1977
 ;Ref. ^PS(59 supp. by IA 2621
 ;Ref. ^PSDRUG( supp. by IA 2621
BEG I '$D(PSDSITE) D ^PSDSET G:'$D(PSDSITE) END
 N PSDV,PSDL,PSDLN,PSDB,PSDS,PSDE,PSDRG,DRG
 D DT^DICRW
 S PSDL=$P(PSDSITE,U,3),PSDLN=$P(PSDSITE,U,4)
 S DIC="^PSD(58.8,",DIC(0)="AEQ",DIC("A")="Select Dispensing Site: "
 S DIC("S")="I $P($G(^(0)),U,3)=+PSDSITE,$S($P($G(^(0)),U,2)[""M"":1,$P($G(^(0)),U,2)[""S"":1,1:0),($S('$D(^(""I"")):1,+^(""I"")>DT:1,'^(""I""):1,1:0))"
 S DIC("B")=$P(PSDSITE,U,4)
 W ! D ^DIC K DIC G:Y<0 END
 S $P(PSDSITE,U,3)=+Y,PSDL=+Y,$P(PSDSITE,U,4)=$P(Y,U,2),PSDLN=$P(Y,U,2),PSDV=PSDSITE
 W ! K %DT S %DT(0)=-DT,%DT="AEP",%DT("A")="Start Date: " D ^%DT
 G:Y<0 END
 S (%DT(0),PSDB)=Y,%DT("A")="End Date: "
 W ! D ^%DT G:Y<0 END
 S PSDE=Y,PSDS=PSDB-.000001
D ;ask drug(s)
 W !!,?5,"You may select a single drug, several drugs,",!,?5,"or enter ^ALL to select all drugs.",!!
 K DRG,DIC S PSDRG=0,DIC="^PSD(58.8,PSDL,1,",DIC(0)="AEQM"
 S DIC("A")="Please Select "_PSDLN_"'s Drug: ",DIC("S")="I $S($G(^(""I"")):$G(^(""I""))>DT,1:1)"
 F  D ^DIC Q:Y<0  D
 .I '$O(^PSD(58.81,"F",+Y,0)) W !!,"There have been no transactions for this drug.",!! Q
 .S DRG(+Y)=""
 K DIC I X="^ALL" S PSDRG=1 G DEV
 G:$D(DTOUT)!($D(DUOUT)) END
 I '$D(DRG)&(Y<0) G D
DEV K %ZIS,IOP,POP,ZTSK S PSDIO=ION,%ZIS="QM" D ^%ZIS K %ZIS
 I POP S IOP=PSDIO D ^%ZIS K IOP,PSDIO W !,"Please try later!" G END
 K PSDIO I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK D  G END
 .S ZTRTN="EN^PSDDSOR2",ZTDESC="Digitally Signed OP Released Rx Report"
 .F G="PSDL","PSDLN","PSDV","PSDS","PSDB","PSDE","PSDRG" S:$D(@G) ZTSAVE(G)=""
 .S:$D(DRG) ZTSAVE("DRG(")=""
 .D ^%ZTLOAD W:$D(ZTSK) !,"Report is Queued to print !!" K ZTSK
EN ;
 K ^TMP($J)
 N RX,RX0,RX2,ORD,DR,TDT,BDT,EDT,DFN,PL,PL1,P1,P2,PG,AC,S1,S2,S5,S6,Y0,Y1,Y2,Y3,Y4,Y5,Y6
 N ST,STD,PR,DRN,DV,DVD,I,J,Z,RC
 F  S PSDS=$O(^PSRX("AL",PSDS)) Q:'PSDS!(PSDS>(PSDE_".99999"))  D
 .S RX=0 F  S RX=$O(^PSRX("AL",PSDS,RX)) Q:'RX  I $D(^PSRX(RX,"PKI")),$O(^PSD(58.81,"AOP",RX,0)) D
 ..S RC=$O(^PSD(58.81,"AOP",RX,0)) Q:'$D(^PSD(58.81,RC))
 ..Q:RX'=$P(^PSD(58.81,RC,6),U)
 ..Q:PSDL'=$P(^PSD(58.81,RC,0),U,3)
 ..Q:'$D(^PSRX(RX,0))  S RX0=^(0),DR=$P(RX0,U,6)
 ..Q:DR'=$P(^PSD(58.81,RC,0),U,5)
 ..D:$G(PSDRG)!($D(DRG(DR))) GD
 D NOW^%DTC S TDT=$E(%,4,5)_"/"_$E(%,6,7)_"/"_$E(%,2,3)_"@"_$E(%,9,10)_":"_$E(%,11,12)
 S AC=0,$E(P1,42)="",$E(P2,12)="",PG=1,Y=PSDB D D^DIQ S BDT=Y,Y=PSDE D D^DIQ S EDT=Y
 U IO D HD I '$D(^TMP($J)) W !!,"**********    NO DATA TO PRINT   **********",!! G END
 D PRD
END ;
 W ! D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K ^TMP($J)
 Q
GD ;
 S DFN=$P(RX0,U,2),RX2=^PSRX(RX,2),PR=$P(RX0,U,4),ORD=$P($G(^("OR1")),U,2),ST=+$P($G(^("STA")),U) Q:'$D(^("PKI"))
 Q:'DFN!('PR)!('DR)!('ORD)
 S DRN=$P($G(^PSDRUG(DR,0)),U),DRN=$S(DRN]"":DRN,1:"UNKNOWN DRUG")
 S STD=$P("ERROR^ACTIVE^NON-VERIFIED^REFILL FILL^HOLD^NON-VERIFIED^SUSPENDED^^^^^DONE^EXPIRED^DISCONTINUED^DISCONTINUED^DISCONTINUED^DISCONTINUED(EDIT)^HOLD^","^",ST+2)
 S ST=ST_";"_STD D ADD^VADPT
 S ^TMP($J,PSDS,DRN,RX,0)="1"_U_ORD_U_U_ST_U_$P(RX2,U)
 S ^TMP($J,PSDS,DRN,RX,1)=$P(^DPT(DFN,0),U)_U_VAPA(1)_U_VAPA(2)_U_VAPA(3)_U_VAPA(4)_U_$P(VAPA(5),U,2)_U_VAPA(6)
 S ^TMP($J,PSDS,DRN,RX,2)=DRN_U_DR_U_$P(RX0,U,7)_U_U_$P($G(^PSDRUG(DR,0)),U,3)
 S ^TMP($J,PSDS,DRN,RX,3)=""
 S ^TMP($J,PSDS,DRN,RX,4)=$P($G(^VA(200,PR,0)),U)_U_PR_U_$$DEA^XUSER(,PR)
 S DV=+$P(RX2,U,9),DVD=$G(^PS(59,DV,0))
 S ^TMP($J,PSDS,DRN,RX,5)=$P(DVD,U,1,2)_U_U_$P(DVD,U,7)_U_$P(^DIC(5,+$P(DVD,U,8),0),U)_U_$P(DVD,U,5)
 Q
PRD S S1=0 F  S S1=$O(^TMP($J,S1)) Q:'S1  D  Q:$D(DIRUT)
 .S S2="" F  S S2=$O(^TMP($J,S1,S2)) Q:S2=""  D  Q:$D(DIRUT)
 ..S S5=0 F  S S5=$O(^TMP($J,S1,S2,S5)) Q:'S5  D PR  Q:$D(DIRUT)
 Q
PR K Y0,Y1,Y2,Y3,Y4,Y5,Y6 S S6=""
 F  S S6=$O(^TMP($J,S1,S2,S5,S6)) Q:S6=""  S Z="Y"_S6,@Z=^TMP($J,S1,S2,S5,S6)
 D:($Y+4)>IOSL HD Q:$D(DIRUT)  S Y6="" D PRT^PSDDSOR1
 Q
HD D HD1 Q:$D(DIRUT)
 W @IOF,!?2,"Digitally Signed OP Released Rx Report for Vault "_PSDLN,?70,"Page: ",PG
 W !,?8,"Date Range: "_BDT_" - "_EDT,?53,"Printed on: "_TDT,!
 S PG=PG+1
 Q
HD1 I PG>1,$E(IOST)="C" K DIR S DIR(0)="E",DIR("A")=" Press Return to Continue or ^ to Exit" D ^DIR K DIR
 Q
