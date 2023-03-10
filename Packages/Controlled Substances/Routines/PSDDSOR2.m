PSDDSOR2 ;BIR/MHA-Digitally Signed OP Released Rx Report ;02/02/2021
 ;;3.0;CONTROLLED SUBSTANCES;**40,42,45,73,89**;Feb 13,1997;Build 18
 ;Ref. ^PSD(58.8 supp. by IA 2711
 ;Ref. ^PSD(58.81 supp. by IA 2808
 ;Ref. ^PSRX( supp. by IA 1977
 ;Ref. ^PS(59 supp. by IA 2621
 ;Ref. ^PSDRUG( supp. by IA 2621
 ;Ref. to ^PSOERXU9 supported by ICR/IA 7222
 ;
BEG ;
 I '$D(PSDSITE) D ^PSDSET G:'$D(PSDSITE) END
 N PSDV,PSDL,PSDLN,PSDB,PSDS,PSDE,PSDRG,DRG,PSDRXSRC,G,DTOUT,DUOUT,DIRUT
 D DT^DICRW
 S PSDL=$P(PSDSITE,U,3) ;location (vault) ien
 S PSDLN=$P(PSDSITE,U,4) ;location (vault) name
 S DIC="^PSD(58.8,"
 S DIC(0)="AEQ"
 S DIC("A")="Select Dispensing Site: "
 ; screen - piece 3 - primary disp site, piece 2 - M=master vault, S=satellite vault, checks vault inactive date
 S DIC("S")="I $P($G(^(0)),U,3)=+PSDSITE,$S($P($G(^(0)),U,2)[""M"":1,$P($G(^(0)),U,2)[""S"":1,1:0),($S('$D(^(""I"")):1,+^(""I"")>DT:1,'^(""I""):1,1:0))"
 S DIC("B")=$P(PSDSITE,U,4)
 W !
 D ^DIC
 K DIC
 G:Y<0 END
 S $P(PSDSITE,U,3)=+Y ;selected vault ien
 S PSDL=+Y
 S $P(PSDSITE,U,4)=$P(Y,U,2) ;selected vault name
 S PSDLN=$P(Y,U,2)
 S PSDV=PSDSITE
 W !
 K %DT
 S %DT(0)=-DT,%DT="AEP",%DT("A")="Start Date: " D ^%DT
 G:Y<0 END
 S (%DT(0),PSDB)=Y
 S %DT("A")="End Date: "
 W ! D ^%DT G:Y<0 END
 S PSDE=Y
 S PSDS=PSDB-.000001
 ;
 ; Prescription Source Filter Prompts - PSD-89
 K DIR S DIR(0)="S^C:CPRS (Internal);E:eRx (External - Inbound);B:Electronically Signed (CPRS+eRx);W:Written (Backdoor Pharmacy);A:ALL"
 S DIR("B")="A"
 S DIR("?")="Select the source of the CS prescription"
 S DIR("A")="Prescription Source"
 D ^DIR
 I $D(DIRUT)!$D(DTOUT) Q
 S PSDRXSRC=Y
 ;
D ;ask schedule(s)
 W !!,"Select a schedule(s)"
 K DIR
 S DIR(0)="S^1:SCHEDULE II;2:SCHEDULES III - V;3:SCHEDULES II - V"
 S DIR("A")="Select Schedule(s)"
 S DIR("B")=3
 D ^DIR
 I $D(DTOUT)!($D(DUOUT))!($D(DIRUT)) Q
 K SCH
 S I=$S(Y=2:3,1:2)
 S J=$S(Y=1:2,1:5)
 F K=I:1:J S SCH(K)=""  ;schedule nbr array
 W !
 K DIR,X,Y,I,J,K
DEV K %ZIS,IOP,POP,ZTSK S PSDIO=ION,%ZIS="QM" D ^%ZIS K %ZIS
 I POP S IOP=PSDIO D ^%ZIS K IOP,PSDIO W !,"Please try later!" G END
 K PSDIO I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK D  G END
 .S ZTRTN="EN^PSDDSOR2",ZTDESC="Digitally Signed OP Released Rx Report"
 .F G="PSDL","PSDLN","PSDV","PSDS","PSDB","PSDE","PSDRG","PSDRXSRC" S:$D(@G) ZTSAVE(G)="" S ZTSAVE("SCH(")=""
 .S:$D(DRG) ZTSAVE("DRG(")=""
 .D ^%ZTLOAD W:$D(ZTSK) !,"Report is Queued to print !!" K ZTSK
EN ;
 K ^TMP("PSDDSOR","PSDDSOR",$J)
 N RX,RX0,RX2,ORD,DR,TDT,BDT,EDT,DFN,PL,PL1,P1,P2,PG,AC,S1,S2,S5,S6,Y0,Y1,Y2,Y3,Y4,Y5,Y6
 N ST,STD,PR,DRN,DV,DVD,I,J,Z,RC,DEA,TRXTYPE,NODE6,FILL,DDR
 ;
 S TRXTYPE=+$O(^PSD(58.84,"B","OUTPATIENT RX",0)) ;drug accountability transaction type
 F  S PSDS=$O(^PSD(58.81,"AF",PSDS)) Q:'PSDS!(PSDS>(PSDE_".99999"))  D
 . S RC=0
 . F  S RC=$O(^PSD(58.81,"AF",PSDS,+PSDL,TRXTYPE,RC)) Q:'RC  D
 . . S NODE6=$G(^PSD(58.81,RC,6))
 . . S RX=+$P(NODE6,"^",1) ;pointer to Rx (52)
 . . S FILL=+$P(NODE6,"^",2) ;refill nbr
 . . Q:'$G(RX)  ;QUIT if no Rx
 . . I '$$RXRLDT^PSOBPSUT(RX,FILL) Q  ;QUIT if no release date
 . . S RX0=$G(^PSRX(RX,0)) ;Rx file node 0
 . . S DR=$P(RX0,"^",6) ;drug ien
 . . Q:DR'=$P(^PSD(58.81,RC,0),U,5)  ;QUIT if Rx drug is not in this accountability record
 . . S DEA=+$P($G(^PSDRUG(DR,0)),"^",3) ;drug dea schedule #
 . . S DDR=$P($G(^PSDRUG(DR,0)),"^") ;drug generic name from drug file
 . . S ORD=$P($G(^PSRX(RX,"OR1")),"^",2)
 . . I '$$CSDS^PSOSIGDS(DR) Q
 . . I PSDRXSRC="E"!(PSDRXSRC="W"),$P($G(^PSRX(RX,"PKI")),"^",1) Q
 . . I PSDRXSRC="C"!(PSDRXSRC="W"),$$ERXIEN^PSOERXU9(RX) Q
 . . I PSDRXSRC'="W",PSDRXSRC'="A",'$P($G(^PSRX(RX,"PKI")),"^",1),'$$ERXIEN^PSOERXU9(RX) Q
 . . D:$D(SCH(DEA)) GD  ;do GD if drug is in requested schedule array
 ;
 N %
 D NOW^%DTC
 S TDT=$E(%,4,5)_"/"_$E(%,6,7)_"/"_$E(%,2,3)_"@"_$E(%,9,10)_":"_$E(%,11,12)
 S AC=0,$E(P1,42)="",$E(P2,12)="",PG=1,Y=PSDB D D^DIQ S BDT=Y,Y=PSDE D D^DIQ S EDT=Y
 U IO D HD I '$D(^TMP("PSDDSOR",$J)) W !!,"**********    NO DATA TO PRINT   **********",!! G END
 D PRD
END ;
 W ! D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K ^TMP("PSDDSOR",$J)
 Q
GD ;
 S DFN=$P(RX0,U,2) ;patient dfn
 S RX2=^PSRX(RX,2) ;Rx record node 2
 S PR=$P(RX0,U,4) ;Rx record provider
 S ORD=$P($G(^PSRX(RX,"OR1")),U,2) ;Rx placer order nbr
 S ST=+$P($G(^PSRX(RX,"STA")),U) ;Rx status
 Q:'DFN!('PR)!('DR)!('ORD)  ;QUIT if dfn, provider, drug, or order is missing
 S STD=$P("ERROR^ACTIVE^NON-VERIFIED^REFILL FILL^HOLD^NON-VERIFIED^SUSPENDED^^^^^DONE^EXPIRED^DISCONTINUED^DISCONTINUED^DISCONTINUED^DISCONTINUED(EDIT)^HOLD^","^",ST+2)
 S ST=ST_";"_STD
 S DRN=$S($G(DDR)'="":DDR,1:"UNKNOWN DRUG") ;drug generic name
 N ERXIEN S ERXIEN=+$$CHKERX^PSOERXU9(ORD)
 N NATURE S NATURE=$S($$ERXIEN^PSOERXU9(RX):"ELECTRONICALLY RECEIVED",1:$P($$NATURE^ORUTL3(ORD),"^",3)) ;PSD-89
 I 'ERXIEN D  ;PSD-89
 . D ADD^VADPT  ;get patient address
 . S ^TMP("PSDDSOR",$J,PSDS,DRN,RX,0)="1"_U_ORD_U_NATURE_U_ST_U_$P(RX2,U)_U_U_U_U_U_U_U_"R" ;1^order#^^status^rx entered date^^^^^^R
 . S ^TMP("PSDDSOR",$J,PSDS,DRN,RX,1)=$P(^DPT(DFN,0),U)_U_VAPA(1)_U_VAPA(2)_U_VAPA(3)_U_VAPA(4)_U_$P(VAPA(5),U,2)_U_VAPA(6) ;patient data
 . S ^TMP("PSDDSOR",$J,PSDS,DRN,RX,2)=DRN_U_DR_U_$P(RX0,U,7)_U_U_$P($G(^PSDRUG(DR,0)),U,3) ;drug name^drug ien^quant^^dea sched
 . S ^TMP("PSDDSOR",$J,PSDS,DRN,RX,3)=""
 . S ^TMP("PSDDSOR",$J,PSDS,DRN,RX,4)=$P($G(^VA(200,PR,0)),U)_U_PR_U_$$DEA^XUSER(0,PR)_U_$$DETOX^XUSER(PR) ;provider data
 . S DV=+$P(RX2,U,9) ;division ien, pointer to outpatient site (59)
 . S DVD=$G(^PS(59,DV,0)) ;outpatient site node 0
 . N ZIP S ZIP=$P(DVD,"^",5),ZIP=$S(ZIP["-":ZIP,1:$E(ZIP,1,5)_$S($E(ZIP,6,9)]"":"-"_$E(ZIP,6,9),1:"")) ;format zip code
 . S ^TMP("PSDDSOR",$J,PSDS,DRN,RX,5)=$P(DVD,U,1,2)_U_U_$P(DVD,U,7)_U_$P(^DIC(5,+$P(DVD,U,8),0),U)_U_ZIP
 E  D
 . N ERXDATA
 . D ERXDATA^PSOERXU9(.ERXDATA,ERXIEN)  ; get eRx data
 . S ^TMP("PSDDSOR",$J,PSDS,DRN,RX,0)="1"_U_ORD_U_NATURE_U_ST_U_$P(RX2,U)_U_U_U_U_U_U_U_"R"  ;1^order#^^status^rx entered date^^^^^^R
 . S ^TMP("PSDDSOR",$J,PSDS,DRN,RX,1)=$P(ERXDATA(4),U,1)_U_ERXDATA(5) ;patient data - name, address
 . N DRUGNM S DRUGNM=$P(ERXDATA(1),U,3)
 . N DRUGQTY S DRUGQTY=$P(ERXDATA(1),U,6)
 . N DRUGDEA S DRUGDEA=$P(ERXDATA(1),U,5)
 . N HUBID S HUBID=$P(ERXDATA(1),U,8)
 . S ^TMP("PSDDSOR",$J,PSDS,DRN,RX,2)=DRUGNM_U_U_DRUGQTY_U_U_DRUGDEA_U_HUBID
 . S ^TMP("PSDDSOR",$J,PSDS,DRN,RX,3)="" ;SIG is handled by print sub-routine
 . N PRVNM S PRVNM=$P(ERXDATA(2),U,3)
 . N PRVDEA S PRVDEA=$P(ERXDATA(2),U,1)
 . N PRVDTX S PRVDTX=$P(ERXDATA(2),U,2)
 . S ^TMP("PSDDSOR",$J,PSDS,DRN,RX,4)=PRVNM_U_U_PRVDEA_U_PRVDTX
 . N SITENM S SITENM=$P(ERXDATA(3),U,1)
 . N SITESTR S SITESTR=$P(ERXDATA(3),U,2)
 . N SITECITY S SITECITY=$P(ERXDATA(3),U,3)
 . N SITEST S SITEST=$P(ERXDATA(3),U,4)
 . N SITEZIP S SITEZIP=$P(ERXDATA(3),U,5)
 . S SITEZIP=$S(SITEZIP["-":SITEZIP,1:$E(SITEZIP,1,5)_$S($E(SITEZIP,6,9)]"":"-"_$E(SITEZIP,6,9),1:"")) ;format zip code
 . S ^TMP("PSDDSOR",$J,PSDS,DRN,RX,5)=SITENM_U_SITESTR_U_SITECITY_U_SITEST_U_SITEZIP
 Q
PRD ;
 S S1=0 F  S S1=$O(^TMP("PSDDSOR",$J,S1)) Q:'S1  D  Q:$D(DIRUT)
 .S S2="" F  S S2=$O(^TMP("PSDDSOR",$J,S1,S2)) Q:S2=""  D  Q:$D(DIRUT)
 ..S S5=0 F  S S5=$O(^TMP("PSDDSOR",$J,S1,S2,S5)) Q:'S5  D PR  Q:$D(DIRUT)
 Q
PR K Y0,Y1,Y2,Y3,Y4,Y5,Y6 S S6=""
 F  S S6=$O(^TMP("PSDDSOR",$J,S1,S2,S5,S6)) Q:S6=""  S Z="Y"_S6,@Z=^TMP("PSDDSOR",$J,S1,S2,S5,S6)
 D:($Y+4)>IOSL HD Q:$D(DIRUT)  S Y6="" D PRT^PSDDSOR1
 Q
HD D HD1 Q:$D(DIRUT)
 W @IOF,!,"OP "_$S(PSDRXSRC'="W"&(PSDRXSRC'="A"):"Digitally Signed ",1:"")_"Released Rx Report for Vault "_$E(PSDLN,1,21),?71,"Page: ",$J(PG,3)
 W !,"Date Range: "_$$FMTE^XLFDT(PSDB,"2Y")_" - "_$$FMTE^XLFDT(PSDE,"2Y")
 W ?33,"Source: ",$S(PSDRXSRC="C":"CPRS",PSDRXSRC="E":"eRx",PSDRXSRC="B":"CPRS+eRx",PSDRXSRC="W":"WRITTEN",1:"ALL")
 W ?54,"Printed on: "_TDT,!
 S PG=PG+1
 Q
HD1 I PG>1,$E(IOST)="C" K DIR S DIR(0)="E",DIR("A")=" Press Return to Continue or ^ to Exit" D ^DIR K DIR
 Q
