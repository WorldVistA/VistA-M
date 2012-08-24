PSOSD1 ;BHAM ISC/SAB/JMB - action or informational profile cont. ; 10/30/07 10:39am
 ;;7.0;OUTPATIENT PHARMACY;**2,17,19,22,40,49,66,107,110,132,233,258,240,320,326,360**;DEC 1997;Build 3
 ;External reference to ^PS(59.7 is supported by DBIA 694
 ;
INIT N PSOPTLK
 S PRF="" F PSOI=0:0 S DIC(0)="QEAM" D EN^PSOPATLK S Y=PSOPTLK Q:Y<1  D
 .S PRF=PRF_+Y_",",DFN=+Y D DEM^VADPT I +VADM(6) W !,"Patient Expired on "_$P(VADM(6),"^",2),! S DOD(DFN)=$P(VADM(6),"^",2) K DFN
 .I $L(PRF)>240 W !,$C(7),"MAX NUMBER OF PATIENTS HAS BEEN REACHED" Q
 Q:'$L(PRF)  D DAYS G:$D(DUOUT)!($D(DTOUT)) EXIT^PSOSD
DEV N PSOBARS,PSOBAR0,PSOBAR1 K %ZIS,IOP,ZTSK,ZTQUEUED S PSOION=ION,%ZIS="QM",%ZIS("B")="",%ZIS("A")=$S(PSTYPE:"Select a Printer: ",1:"DEVICE: ") D ^%ZIS K %ZIS I POP S IOP=PSOION D ^%ZIS K IOP,PSOION G EXIT
 I $E(IOST)["C",PSTYPE D ^%ZISC W $C(7),!!,"Action Profiles MUST BE SENT TO A PRINTER !!",!,"ONLY INFORMATIONAL PROFILES ARE ALLOWED TO PRINT TO SCREEN !!",! G DEV
 S PSOIOS=IOS D DEVBAR^PSOBMST S PSOBAR2=PSOBAR0,PSOBAR3=PSOBAR1
 S PSOBAR4=$G(PSOBAR3)]""&($G(PSOBAR2)]"")&(+$P($G(PSOPAR),"^"))
 K PSOION I $D(IO("Q")) S ZTDESC="Outpatient Pharmacy Action Profile",ZTRTN="START^PSOSD1",ZTSAVE("ZTREQ")="@" D  D EXIT Q:$G(LM)  G ^PSOSD
 .F G="PSORM","PSOPOL","PSONUM","PSOSYS","PSOINST","PSOBAR3","PSOBAR4","PSOBAR2","PSOPAR","PSOPAR7","PRF","PSDAYS","PSDATE","PSTYPE","PSOSITE","PSDATE","PSDAY" S:$D(@G) ZTSAVE(G)=""
 .S ZTSAVE("DOD*")="",ZTSAVE("PSOBAR*")="" D ^%ZTLOAD W:$D(ZTSK) !,"Report Queued to Print !!",! K:'$G(LM) ZTSK,IO("Q")
 D START G:'$G(LM) ^PSOSD
 Q
START U IO S PSTYPE=$S($D(PSTYPE):PSTYPE,1:0),LINE="",$P(LINE,"-",132)="-"
 F PSIX=1:1 S DFN=$P(PRF,",",PSIX) G:DFN']"" EXIT D ELIG S PAGE=1 D  G:$G(PSQFLG)!($D(DTOUT))!($D(DUOUT)) EXIT
 .D PAT^PSOSD Q:$D(DTOUT)!($D(DUOUT))  D  Q:PSQFLG  D RXPAD:PSTYPE D ENSTUFF^PSODACT
 ..Q:$D(DUOUT)!($D(DTOUT))  S PSQFLG=0 D ^PSOSD3,NVA^PSOSD3,EN^PSORMRXP(DFN)
EXIT I '$D(PSONOPG) W ! D ^%ZISC K DFN
 W:$D(PSONOPG)&('$D(ORVP)) @IOF
 K ^TMP($J,"PRF"),^("ACT"),ADDR,ADDRFL,CLASS,CNDT,CNT,DRUG,CLAPP,HDFL,I,II,J,L,LINE,P,PAGE,PSDOB,PSIIX,PSNAME,PSOI,PSQFLG,PSSN,DFN,PSIX,PAGE,PGM,LINE,PRF,PSTYPE,PSDATE,PSDAYS,VAL,VAR,RX,RX0,RX3,RX2,ST,ST0,PSDAY,RF,RFS,PSOBAR3,PSOBAR4,PSOBAR2
 D KVA^VADPT K DOD,FILL,DIC,PSCNT,PSDT,PCLASS,PHYS,ZCLASS,PSOPRINT,RXNODE,DIR,X1,X2,PSONUM,PSOPOLP,PSSN4
 Q
 ; 
DAYS K DIR S DIR("A")="Profile Expiration/Discontinued Cutoff",DIR("B")=120,DIR(0)="N^0:9999:0",DIR("?",1)="Enter the number of days which will cut discontinued and expired Rx's from",DIR("?")="the profile."
 D ^DIR Q:$D(DTOUT)!($D(DUOUT))  S PSDAYS=X K DIR S X1=DT,X2=-PSDAYS D C^%DTC S (PSDATE,PSDAY)=X
 Q
 ;
DFN S:'$D(PSORM) PSORM=1
 S PSOIOS=IOS D DEVBAR^PSOBMST S PSOBAR2=PSOBAR0,PSOBAR3=PSOBAR1
 S PSOBAR4=$G(PSOBAR3)]""&($G(PSOBAR2)]"")&(+$P($G(PSOPAR),"^"))
 W:$D(PSONOPG)&($G(PSONOPG)'=2) @IOF I '$G(PSOSITE) S PSOSITE=$O(^PS(59,0))
 S PRF=DFN_"," D:'$G(PSDAYS)  G START
 .S PSDAYS=120,X1=DT,X2=-PSDAYS D C^%DTC S (PSDATE,PSDAY)=X
 Q
 ;
ELIG S PSOPRINT=""
 D ELIG^VADPT
 Q:'$D(VAEL(4))
 Q:+VAEL(4)'=1
 I $D(VAEL(3)),+VAEL(3)=1,($P(VAEL(3),"^",2)<50) S PSOPRINT="SC NSC"
 D KVAR^VADPT
 Q
 ;
RXPAD N K Q:$G(DOD(DFN))]""  D HD F CNT=1:1:4 S LF="!?45" D  Q:$Y+14>IOSL
 .W !?4,"Name: "_PSNAME,?58,"DOB: "_PSDOB
 .W !!,CNT,?4,"Medication: ",LN,$E(LN,1,11),!!?4,"Outpatient Directions: ",LN,!?4
 .W $E(LN,1,3),"SC",$E(LN,1,3),"NSC","  Quantity: _____    Days Supply _____   "
 .W:'$G(PSORM) @LF W "Refills: 0 1 2 3 4 5 6 7 8 9 10 11"
 .W !!?4,$E(LN,1,35)," ",$E(LN,1,14)," ",$E(LN,1,24)
 .W !?4,"Provider's Signature",?40,"DEA #",?55,"Date/Time",!!,$E(LINE,1,$S('PSORM:80,1:IOM))
 K LF Q
 ;
HD S FN=DFN S:'$D(PSORM) PSORM=1
 D ELIG^PSOSD1,DEM^VADPT,INP^VADPT,ADD^VADPT,PID^VADPT S PSSN=VA("PID"),PSSN4="",ADDRFL=$S(+VAPA(9):"Temporary ",1:"")
 I +VADM(6) S DOD(DFN)=$P(VADM(6),"^",2)
 S PSNAME=$E(VADM(1),1,28),PSDOB=$P(VADM(3),"^",2) I $D(IOF),$G(PAGE)'=1 W @IOF
 W "Action Rx Profile",?47,"Run Date: " S Y=DT D DT^DIO2 W ?71,"Page: "_PAGE S PAGE=PAGE+1,X=$$SITE^VASITE
 W !,"Sorted by drug classification for Rx's currently active"_$S('PSDAYS:" only.",1:"") W:PSDAYS !,"and for those Rx's that have been inactive less than "_PSDAYS_" days."
 W @$S(PSORM:"?70",1:"!"),"Site: VAMC "_$P(X,"^",2)_" ("_$P(X,"^",3)_")",!,$E(LINE,1,$S('PSORM:80,1:IOM)-1)
 I $P(VAIN(4),"^",2)]"",+$P($G(^PS(59.7,1,40.1)),"^") W !,"Outpatient prescriptions are discontinued 72 hours after admission.",!
 W !?1,"Name  : ",PSNAME W ?58,"Action Date: ________" W !?1,"DOB   : "_PSDOB
 W:ADDRFL]"" ?30,ADDRFL,! W ?30,"Address  :"
 I $G(ADDRFL)="" D CHECKBAI
 W ?41,VAPA(1) W:VAPA(2)]"" !?41,VAPA(2) W:VAPA(3)]"" !?41,VAPA(3) W !?41,VAPA(4)_", "_$P(VAPA(5),"^",2)_"  "_$S(VAPA(11)]"":$P(VAPA(11),"^",2),1:VAPA(6)),!?30,"Phone    : "_VAPA(8)
 I PSOBAR4 S X="S",X2=PSSN W @$S('PSORM:"!?30",1:"?$X+5") S X1=$X W @PSOBAR3,X2,@PSOBAR2,$C(13) S $X=0
 S (WT,HT)="",X="GMRVUTL" X ^%ZOSF("TEST") I $T D
 .F GMRVSTR="WT","HT" S VM=GMRVSTR D EN6^GMRVUTL S @VM=X,$P(@VM,"^")=$E($P(@VM,"^"),4,5)_"/"_$E($P(@VM,"^"),6,7)_"/"_($E($P(@VM,"^"),1,3)+1700)
 .S X=$P(WT,"^",8),Y=$J(X/2.2,0,2),$P(WT,"^",9)=Y,X=$P(HT,"^",8),Y=$J(2.54*X,0,2),$P(HT,"^",9)=Y
 W !!,"WEIGHT(Kg): " W:+$P(WT,"^",8) $P(WT,"^",9)_" ("_$P(WT,"^")_")" W ?41,"HEIGHT(cm): " W:$P(HT,"^",8) $P(HT,"^",9)_" ("_$P(HT,"^")_")" K VM,WT,HT
 D GMRA^PSODEM W !,$E(LINE,1,$S('PSORM:80,1:IOM)-1),!,"Instructions to the provider:",!,"A prescription blank (VA FORM 10-2577f) must be used for All Class II NARCOTICS."
 S (ELN,LN,LINE)="",$P(LN,"_",53)="",$P(LINE,"-",132)=""
 W !,$E(LINE,1,$S('PSORM:80,1:IOM)-1),!?4,"OTHER MEDICATIONS:",!
 Q
LM ;prints AP from listamn action
 S X=$$SITE^VASITE,PSOINST=$P(X,"^",3) K X
 K DIR S DIR("A")="Action or Informational (A or I): ",DIR("?",1)="Enter 'A' for action profile",DIR("?",2)="      'I' for informational profile",DIR("?")="      'E' to EXIT process",DIR("B")="A",DIR(0)="SAM^1:Action;0:Informational;E:Exit"
 D ^DIR K DIR Q:Y="E"!($D(DIRUT))  S PSTYPE=Y,LM=1
 I '$P($G(PSOSYS),"^",6) S PSOPOL=0 G ASK
 K DIR S DIR("A")="Do you want generate a Polypharmacy report?: ",DIR("?",1)="Enter 'Y' to generate report",DIR("?",2)="      'N' if you do not want the report",DIR("?")="      'E' to EXIT process",DIR("B")="NO",DIR(0)="SA^1:YES;0:NO;E:Exit"
 D ^DIR S PSOPOL=$S(Y:1,1:0) G:Y="E"!($D(DIRUT)) EXIT G:'PSOPOL ASK
 K DIR S DIR("A")="Minimum Number of Active Prescriptions",DIR("B")=7,DIR(0)="N^1:100:0" D ^DIR S PSONUM=Y G:$D(DIRUT) EXIT
 K DIR,DTOUT,DIRUT,DUOUT S DIR("A")="Do you want this Profile to print in 132 columns or 80 columns: ",DIR("B")="132",DIR(0)="SAM^1:132;8:80;E:Exit"
 D ^DIR G:Y="E"!($D(DUOUT))!($D(DIRUT)) EXIT S PSORM=$S(Y=1:1,1:0) K DIR,X,Y
 ;PSO*7*240 Go to exit if DUOUT or DTOUT
ASK D DAYS G:($D(DUOUT))!($D(DTOUT)) EXIT S PRF=PSODFN_"," D DEV I $D(ZTSK) S VALMSG="Action Profile Queued to Printer."
 D EXIT K LM
 Q
 ;
CHECKBAI ;
 N PSOBADR
 S PSOBADR=$$BADADR^DGUTL3(DFN)
 I 'PSOBADR W " " Q
 W ?40,"** BAD ADDRESS INDICATED **",!
 Q
 ;
