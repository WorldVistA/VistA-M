PSDDSOR2 ;BIR/MHA-Digitally Signed OP Released Rx Report; 05/09/03
 ;;3.0;CONTROLLED SUBSTANCES;**40,42,45,73**;Feb 13,1997;Build 8
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
D ;ask schedule(s)
 W !!,"Select a schedule(s)"
 K DIR
 S DIR(0)="S^1:SCHEDULE II;2:SCHEDULES III - V;3:SCHEDULES II - V",DIR("A")="Select Schedule(s)",DIR("B")=3
 D ^DIR I $D(DTOUT)!($D(DUOUT))!($D(DIRUT)) Q
 K SCH S I=$S(Y=2:3,1:2),J=$S(Y=1:2,1:5) F K=I:1:J S SCH(K)=""
 W ! K DIR,X,Y,I,J,K
DEV K %ZIS,IOP,POP,ZTSK S PSDIO=ION,%ZIS="QM" D ^%ZIS K %ZIS
 I POP S IOP=PSDIO D ^%ZIS K IOP,PSDIO W !,"Please try later!" G END
 K PSDIO I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK D  G END
 .S ZTRTN="EN^PSDDSOR2",ZTDESC="Digitally Signed OP Released Rx Report"
 .F G="PSDL","PSDLN","PSDV","PSDS","PSDB","PSDE","PSDRG" S:$D(@G) ZTSAVE(G)="" S ZTSAVE("SCH(")=""
 .S:$D(DRG) ZTSAVE("DRG(")=""
 .D ^%ZTLOAD W:$D(ZTSK) !,"Report is Queued to print !!" K ZTSK
EN ;
 K ^TMP($J)
 N RX,RX0,RX2,ORD,DR,TDT,BDT,EDT,DFN,PL,PL1,P1,P2,PG,AC,S1,S2,S5,S6,Y0,Y1,Y2,Y3,Y4,Y5,Y6
 N ST,STD,PR,DRN,DV,DVD,I,J,Z,RC,DEA,TRXTYPE,NODE6,FILL,DDR
 ;
 S TRXTYPE=+$O(^PSD(58.84,"B","OUTPATIENT RX",0)),RC=0
 F  S PSDS=$O(^PSD(58.81,"AF",PSDS)) Q:'PSDS!(PSDS>(PSDE_".99999"))  D
 . S RC=0 F  S RC=$O(^PSD(58.81,"AF",PSDS,+PSDL,TRXTYPE,RC)) Q:'RC  D
 . . S NODE6=$G(^PSD(58.81,RC,6)),RX=+$P(NODE6,"^",1),FILL=+$P(NODE6,"^",2)
 . . I '$G(RX)!'$P($G(^PSRX(RX,"PKI")),"^") Q
 . . I '$$RXRLDT^PSOBPSUT(RX,FILL) Q
 . . S RX0=$G(^PSRX(RX,0)),DR=$P(RX0,"^",6)
 . . Q:DR'=$P(^PSD(58.81,RC,0),U,5)  S DEA=+$P($G(^PSDRUG(DR,0)),"^",3),DDR=$P($G(^PSDRUG(DR,0)),"^")
 . . D:$D(SCH(DEA)) GD
 ;
 D NOW^%DTC S TDT=$E(%,4,5)_"/"_$E(%,6,7)_"/"_$E(%,2,3)_"@"_$E(%,9,10)_":"_$E(%,11,12)
 S AC=0,$E(P1,42)="",$E(P2,12)="",PG=1,Y=PSDB D D^DIQ S BDT=Y,Y=PSDE D D^DIQ S EDT=Y
 U IO D HD I '$D(^TMP($J)) W !!,"**********    NO DATA TO PRINT   **********",!! G END
 D PRD
END ;
 W ! D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K ^TMP($J)
 Q
GD ;
 S DFN=$P(RX0,U,2),RX2=^PSRX(RX,2),PR=$P(RX0,U,4),ORD=$P($G(^("OR1")),U,2),ST=+$P($G(^("STA")),U) Q:'+$P($G(^("PKI")),U)
 Q:'DFN!('PR)!('DR)!('ORD)
 S STD=$P("ERROR^ACTIVE^NON-VERIFIED^REFILL FILL^HOLD^NON-VERIFIED^SUSPENDED^^^^^DONE^EXPIRED^DISCONTINUED^DISCONTINUED^DISCONTINUED^DISCONTINUED(EDIT)^HOLD^","^",ST+2)
 S ST=ST_";"_STD
 ;D ARCHIVE^ORDEA(ORD)
 ;I $D(^TMP($J,"ORDEA")) D  Q
 ;.F I=1:1:5 S TMP(I)=$G(^TMP($J,"ORDEA",ORD,I))
 ;.S DRN=$S($P(TMP(1),"^",3)'="":$P(TMP(1),"^",3),$G(DDR)'="":DDR,1:"UNKNOWN DRUG")
 ;.S ^TMP($J,PSDS,DRN,RX,0)="1"_U_ORD_U_U_ST_U_$P(TMP(1),U,2)_U_U_U_U_U_U_U_"R"
 ;.S ^TMP($J,PSDS,DRN,RX,1)=$P(TMP(4),U)_U_TMP(5)
 ;.S ^TMP($J,PSDS,DRN,RX,2)=DRN_U_DR_U_$P(TMP(1),U,4)_U_U_$P($G(^PSDRUG(DR,0)),U,3)
 ;.S ^TMP($J,PSDS,DRN,RX,3)=""
 ;.S ^TMP($J,PSDS,DRN,RX,4)=$P(TMP(2),U,3)_U_PR_U_$P(TMP(2),U,1,2)
 ;.S ^TMP($J,PSDS,DRN,RX,5)=TMP(5)
 S DRN=$S($G(DDR)'="":DDR,1:"UNKNOWN DRUG")
 D ADD^VADPT
 S ^TMP($J,PSDS,DRN,RX,0)="1"_U_ORD_U_U_ST_U_$P(RX2,U)_U_U_U_U_U_U_U_"R"
 S ^TMP($J,PSDS,DRN,RX,1)=$P(^DPT(DFN,0),U)_U_VAPA(1)_U_VAPA(2)_U_VAPA(3)_U_VAPA(4)_U_$P(VAPA(5),U,2)_U_VAPA(6)
 S ^TMP($J,PSDS,DRN,RX,2)=DRN_U_DR_U_$P(RX0,U,7)_U_U_$P($G(^PSDRUG(DR,0)),U,3)
 S ^TMP($J,PSDS,DRN,RX,3)=""
 S ^TMP($J,PSDS,DRN,RX,4)=$P($G(^VA(200,PR,0)),U)_U_PR_U_$$DEA^XUSER(0,PR)_U_$$DETOX^XUSER(PR)
 S DV=+$P(RX2,U,9),DVD=$G(^PS(59,DV,0))
 N ZIP S ZIP=$P(DVD,"^",5),ZIP=$S(ZIP["-":ZIP,1:$E(ZIP,1,5)_$S($E(ZIP,6,9)]"":"-"_$E(ZIP,6,9),1:""))
 S ^TMP($J,PSDS,DRN,RX,5)=$P(DVD,U,1,2)_U_U_$P(DVD,U,7)_U_$P(^DIC(5,+$P(DVD,U,8),0),U)_U_ZIP
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
 W @IOF,!,"Digitally Signed OP Released Rx Report for Vault "_$E(PSDLN,1,21),?71,"Page: ",PG
 W !,?8,"Date Range: "_BDT_" - "_EDT,?53,"Printed on: "_TDT,!
 S PG=PG+1
 Q
HD1 I PG>1,$E(IOST)="C" K DIR S DIR(0)="E",DIR("A")=" Press Return to Continue or ^ to Exit" D ^DIR K DIR
 Q
