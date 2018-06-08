PSOSDP ;BHAM ISC/SAB - poly pharmacy report attached to action/info profile ;12/13/93 8:24
 ;;7.0;OUTPATIENT PHARMACY;**2,17,19,107,110,155,176,233,258,326,500**;DEC 1997;Build 9
 ;called from PSOSD
 Q:+$G(^TMP($J,DFN))<PSONUM!($G(DOD(DFN))]"")  S DRG="",P=0,PSOPOLP=0 D HD K SGY
 F  S DRG=$O(^TMP($J,DFN,DRG)) Q:DRG=""  F  S P=$O(^TMP($J,DFN,DRG,P)) Q:'P  I $G(^PSRX(P,0))]"" S RX0=^PSRX(P,0),RX2=$G(^(2)),RX3=$G(^(3)) D  K SGY
 .I $Y+6>IOSL D FT,HD
 .S SIG=$P($G(^PSRX(P,"SIG")),"^") W !?10,"* "_$E(DRG,1,40),?52 D SIG W $G(BSIG(1)),?79,"*"
 .I $O(BSIG(1)) F PSREV=1:0 S PSREV=$O(BSIG(PSREV)) Q:'PSREV  W !?10,"*",?52,$G(BSIG(PSREV)),?79,"*" I $Y+4>IOSL,$O(BSIG(PSREV)) D FT,HD
 .K BSIG,PSREV
 D FT K PSOGY
 Q
SIG K FSIG,BSIG I $P($G(^PSRX(P,"SIG")),"^",2) D FSIG^PSOUTLA("R",P,26) F PSREV=1:1 Q:'$D(FSIG(PSREV))  S BSIG(PSREV)=FSIG(PSREV)
 K FSIG,PSREV I '$P($G(^PSRX(P,"SIG")),"^",2) D EN3^PSOUTLA1(P,26)
 Q
HD S FN=DFN
 D ELIG^PSOSD1,DEM^VADPT,INP^VADPT,ADD^VADPT,PID^VADPT S PSSN=VA("PID"),ADDRFL=$S(+VAPA(9):"Temporary ",1:"")
 S PSNAME=$E(VADM(1),1,28),PSDOB=$P(VADM(3),"^",2)
 W @IOF,!,"Polypharmacy Rx Profile Review",?47,"Run Date: " S Y=DT D DT^DIO2 W ?71,"Page: "_PAGE S PAGE=PAGE+1,X=$$SITE^VASITE
 W !,"Sorted by drug name for Rx's currently active",@$S(PSORM:"?70",1:"!"),"Site: VAMC "_$P(X,"^",2)_"( "_$P(X,"^",3)_")",!,$E(LINE,1,$S('PSORM:80,1:IOM)-1)
 I $D(CLINICX) W !?1,"Clinic: ",$E(CLINICX,1,28),?45,"Date/Time: " S Y=CLDT D DT^DIO2
 W !?1,"Name  : ",PSNAME,?30 W ?58,"Review Date: ________" W !?1,"DOB   : "_PSDOB
 W:ADDRFL]"" ?30,ADDRFL,! W ?30,"Address  :"
 I ADDRFL="" D CHECKBAI^PSOSD1
 W ?41,VAPA(1) W:VAPA(2)]"" !?41,VAPA(2) W:VAPA(3)]"" !?41,VAPA(3) W !?41,VAPA(4)_", "_$P(VAPA(5),"^",2)_"  "_VAPA(6),!?30,"Phone    : "_VAPA(8)
 S PSOBAR2=PSOBAR0,PSOBAR3=PSOBAR1
 S PSOBAR4=$G(PSOBAR3)]""&($G(PSOBAR2)]"")&(+$P($G(PSOPAR),"^"))
 I PSOBAR4 S X="S",X2=PSSN W @$S('PSORM:"!?30",1:"?$X+5") S X1=$X W @PSOBAR3,X2,@PSOBAR2,$C(13) S $X=0
 F GMRVSTR="WT","HT" S VM=GMRVSTR D EN6^GMRVUTL S @VM=X,$P(@VM,"^")=$E($P(@VM,"^"),4,5)_"/"_$E($P(@VM,"^"),6,7)_"/"_($E($P(@VM,"^"),1,3)+1700)
 S X=$P(WT,"^",8),Y=$J(X/2.2046226,0,2),WT=WT_"^"_Y,X=$P(HT,"^",8),Y=$J(2.54*X,0,2),HT=HT_"^"_Y
 W !?1,"WEIGHT(Kg): " W:+$P(WT,"^",8) $P(WT,"^",9)_" ("_$P(WT,"^")_")" W ?41,"HEIGHT(cm): " W:$P(HT,"^",8) $P(HT,"^",9)_" ("_$P(HT,"^")_")" K VM,WT,HT
 W !,$E(LINE,1,$S('PSORM:80,1:IOM)-1),!!!?10 F I=1:1:70 W "*"
 W !?10,"*",?35,"POLYPHARMACY REVIEW",?79,"*",!?10,"*",?79,"*",!?10,"* Patient:  "_PSNAME,?50,"(ID#: "_VA("BID")_")",?79,"*"
 W !?10,"* is identified as having "_PSONUM_" or more active prescriptions",?79,"*",!?10,"* for drugs (excluding supplies).  To avoid unnecessary",?79,"*"
 W !?10,"* medications, please review these to ensure that each one",?79,"*",!?10,"* is essential.  Unnecessary medications may be discontinued on",?79,"*"
 W !?10,"* the attached Action Profile.",?79,"*",!?10,"*",?79,"*",!?10,"* I have reviewed the medications below and have taken",?79,"*",!?10,"* actions to discontinue those that are no longer required.",?79,"*"
 F I=1:1:3 W !?10,"*",?79,"*"
 W !?10,"*",?25 F I=1:1:35 W "_"
 W ?79,"*",!?10,"*",?25,"(Signature)",?79,"*" F I=1:1:2 W !?10,"*",?79,"*"
 W !?10,"*",?25,"Drugs ("_^TMP($J,DFN)_")",?60,"SIG",?79,"*"
 W !?10,"* " F I=1:1:30 W "-"
 W ?52 F I=1:1:20 W "-"
 W ?79,"*"
 Q
FT W !?10 F I=1:1:70 W "*"
 Q
CLSG ;clinic group sort and print
 S CLSP=1,DIC("A")="Select Clinic Sort Group: "
 S DIC="^PS(59.8,",DIC(0)="AEQM" D ^DIC G:"^"[X EXIT^PSOSD G:Y<0 CLSG
 S CLSG=+Y
 I '$O(^PS(59.8,CLSG,1,0)) W !!,$C(7),"There are no clinics defined for this Clinic Group!",!,$C(7) G CLSG
 S %DT="AEFX",%DT("A")="FOR DATE: " D ^%DT G:"^"[X EXIT^PSOSD G CLSG:Y<0 S (APCLDT,CLDT)=Y,$P(LINE,"-",132)="-"
 D DAYS^PSOSD1 G:$D(DIRUT) EXIT S X1=DT,X2=-PSDAYS D C^%DTC S PSDATE=X S PSTYPE=$S($D(PSTYPE):PSTYPE,1:0)
 K %DT,%ZIS,IOP,ZTSK,ZTQUEUED S PSOION=ION,%ZIS="QM",%ZIS("B")="",%ZIS("A")=$S(PSTYPE:"Select a Printer: ",1:"DEVICE: ")
 S %ZIS("S")=$S(PSTYPE:"I $E($G(^%ZIS(2,+$G(^(""SUBTYPE"")),0)),1)=""P""",1:"")
 N PSOBARS,PSOBAR0,PSOBAR1
 D ^%ZIS I POP S IOP=PSOION K PSOION G EXIT
 S APRT=ION ;D ^%ZISC
 K DTOUT,DIR,DIRUT
 W ! I $G(IO("Q")) D  W:$D(ZTSK) !,"Report Queued to Print !!",!! G EXIT
 .S %DT="ERXAFS",%DT("A")="Request Start Time: ",%DT("B")="NOW",%DT(0)="NOW" D ^%DT W ! Q:$D(DIRUT)!(X["^")  S APTM=Y
 .F G="LINE","CLDT","CLSG","PSOPOL","PSOSYS","PSOINST","PSOBAR3","PSOBAR4","PSOBAR2","PSOPAR","PSOPAR7","PRF","PSDAYS","PSDATE","PSTYPE","PSOSITE","PSDATE","PSDAY","PSONUM","PSORM" S:$D(@G) ZTSAVE(G)=""
 .S ZTSAVE("APCLDT")="",ZTDTH=APTM,ZTDESC="Clinic Sort Group Action Profile (Outpatient Pharmacy).",ZTSAVE("ZTREQ")="@",ZTSAVE("APRT")="",ZTIO=APRT,ZTRTN="EN^PSOSDP" D ^%ZTLOAD
 ;
EN ;
 S APIFLDS="1;2;3;4;5;6;7;8;9;10;11;12",ALL=1
 S CLN=0 ;S PSOIOS=IOS D DEVBAR^PSOBMST
 F  S CLN=$O(^PS(59.8,CLSG,1,CLN)) Q:'CLN  S FR=CLN_","_CLDT,PSOT=CLDT,TO=CLN_","_CLDT_".2359" D CLIN1^PSOSDRAP S CLDT=APCLDT
 D ^%ZISC
 ;
EXIT K ADDRFL,CAN,CLDT,CLINICX,CLSG,CLSP,CNT,CS,DFN,G,PAGE,PCLASS,PRF,PSDATE
 K PSDAY,PSDAYS,PSDT,PIIX,PSNAME,PSONUM,PSOT,PSSN,PSTYPE,RF,RFS,RXNO
 K RXNODE,PSORM,PSOUT,PSOION,ZTDESC,DQTIME,F,O,W,CLN,APQUE,APTM,APRT
 K APCLDT D KVA^VADPT,EXIT^PSOSD
 G:'$D(ZTQUEUED) ^PSOSD
 Q
 ;
COS I $P($G(^PSRX(J,3)),"^",3),$D(^VA(200,+$P($G(^(3)),"^",3),0)) W !?99,"COSIGNER: "_$P($G(^VA(200,$P(^PSRX(J,3),"^",3),0)),"^")
 Q
