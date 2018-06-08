PSOSD2 ;BHAM ISC/SAB - action or informational profile cont. ;3/24/93
 ;;7.0;OUTPATIENT PHARMACY;**2,19,107,110,176,233,258,326,500**;DEC 1997;Build 9
 ;External reference to ^PS(59.7 is supported by DBIA 694
 ;
1 W !,$E(LINE,1,$S('PSORM:80,1:IOM)-1),!
 W !,"Instructions to the provider:"
 W !,"   A. A prescription blank (VA FORM 10-2577f) must be used for the"
 W !,"      following: 1) any new medication"
 W !,"                 2) any changes in dosage, direction or quantity"
 W !,"                 3) all class II narcotics."
 W !,"   B. To continue a medication as printed:"
 W !,"      1.  If ""Remaining Refills"" are sufficient to complete"
 W !,"          therapy or last until next scheduled clinic appointment,"
 W !,"          no action is required."
 W !,"      2.  If ""Remaining Refills"" are not sufficient to complete"
 W !,"          therapy or last until next scheduled clinic appointment,"
 W !,"          sign ""RENEW/MD"" line, enter VA# and date, and circle"
 W !,"          total number of refills needed.  This action creates a"
 W !,"          new prescription with refills as indicated."
 W !,"   C. To discontinue a medication, sign DISCONTINUE/MD line and enter VA# and",@$S(PSORM:"?$X+1",1:"!?6"),"date."
 W !,"   D. Any medications not acted upon will continue to be available"
 W !,"      to the patient until all refills are used or until expiration."
 W !!,"  NOTE: '(R)' indicates a fill was returned to stock."
 Q
 ;
HD S:'$D(PSORM) PSORM=1 N K S FN=DFN
 D ELIG^PSOSD1,DEM^VADPT,INP^VADPT,ADD^VADPT,PID^VADPT S PSSN=VA("PID"),ADDRFL=$S(+VAPA(9):"Temporary ",1:"")
 I $G(^TMP($J,DFN)),$D(CLINICX) D ^PSOSDP
 S PSNAME=$E(VADM(1),1,28),PSDOB=$P(VADM(3),"^",2)
 I '$D(PSOBAR0)!('$D(PSOBAR1)) S PSOIOS=IOS D DEVBAR^PSOBMST
 S PSOBAR2=PSOBAR0,PSOBAR3=PSOBAR1
 S PSOBAR4=$G(PSOBAR3)]""&($G(PSOBAR2)]"")&(+$P($G(PSOPAR),"^"))
HD1 S RXCNT=0 I $E(IOST)="C",'PSTYPE K DIR S DIR(0)="E",DIR("A")="Press Return to Continue or ""^"" to Exit" D ^DIR Q:$D(DTOUT)!($D(DUOUT))
 I $D(IOF) W @IOF
 U IO
 W $S(PSTYPE:"Action",1:"Informational")_" Rx Profile",?47,"Run Date: " S Y=DT D DT^DIO2 W ?71,"Page: "_PAGE
 W !,"Sorted by drug classification for Rx's currently active"_$S('PSDAYS:" only.",1:"") W:PSDAYS !,"and for those Rx's that have been inactive less than "_PSDAYS_" days."
 S X=$$SITE^VASITE
 W @$S(PSORM:"?70",1:"!"),"Site: VAMC "_$P(X,"^",2)_" ("_$P(X,"^",3)_")",!,$E(LINE,1,$S('PSORM:80,1:IOM)-1)
 I $P(VAIN(4),"^",2)]"",+$P($G(^PS(59.7,1,40.1)),"^") W !,"Outpatient prescriptions are discontinued 72 hours after admission.",!
 I $D(CLINICX) W !?1,"Clinic: ",$E(CLINICX,1,28),?45,"Date/Time: " S Y=CLDT D DT^DIO2
 W !?1,"Name  : ",PSNAME W:PSTYPE ?58,"Action Date: ________" W !?1,"DOB   : "_PSDOB
 W:ADDRFL]"" ?30,ADDRFL,! W ?30,"Address  :"
 I $G(ADDRFL)="" D CHECKBAI^PSOSD1
 W ?41,VAPA(1) W:VAPA(2)]"" !?41,VAPA(2) W:VAPA(3)]"" !?41,VAPA(3)
 W !?41,VAPA(4)_", "_$P(VAPA(5),"^",2)_"  "_$S(VAPA(11)]"":$P(VAPA(11),"^",2),1:VAPA(6)),!?30,"Phone    : "_VAPA(8)
 I PSOBAR4 S X="S",X2=PSSN W @$S('PSORM:"!?30",1:"?$X+5") S X1=$X W @PSOBAR3,X2,@PSOBAR2,$C(13) S $X=0
 W:$G(DOD(DFN))]"" ?1,"**** Date of Death: "_DOD(DFN)_" ****",!
 D:'$D(HDFL)
 .K DIRUT,DIR,DUOUT,DTOUT D:'$G(CLAPP) RE^PSODEM Q:$D(DIRUT)
 .I $Y+15>IOSL,$E(IOST)="C" K DIR S DIR(0)="E" D ^DIR K DIR,DUOUT,DTOUT
 .Q:$D(DIRUT)
 .K ^UTILITY("VASD",$J),VASD S VASD("F")=DT,VASD("T")=9999999,VASD("W")="123456789" D:$G(DFN)&('$G(CLAPP)) SDA^VADPT K VASD I '$G(CLAPP)&($D(^UTILITY("VASD",$J))) D  S CLAPP=1 D HD:$G(^TMP($J,DFN))'<$G(PSONUM)&($G(PSOPOL))
 ..W:$E(IOST)="C" @IOF
 ..W !,$E(LINE,1,$S('PSORM:80,1:IOM)-1)
 ..S FA=DT W !!,"Pending Outpatient Clinic Appointments:"
 ..F PSOACPP=0:0 S PSOACPP=$O(^UTILITY("VASD",$J,PSOACPP)) Q:'PSOACPP  S PSOACPPE=$G(^UTILITY("VASD",$J,PSOACPP,"E")),PSOACPPI=$G(^("I")) W !?11,$P(PSOACPPE,"^"),?35,$P(PSOACPPE,"^",2) D CAPP
 ..I $E(IOST)="C" K DIR,DIRUT,DTOUT S DIR(0)="E" D ^DIR K DIR
 .E  D:$G(PAGE)>1&('$G(PSOPOL))
 ..S (WT,HT)="",X="GMRVUTL" X ^%ZOSF("TEST") I $T D
 ...F GMRVSTR="WT","HT" S VM=GMRVSTR D EN6^GMRVUTL S @VM=X,$P(@VM,"^")=$E($P(@VM,"^"),4,5)_"/"_$E($P(@VM,"^"),6,7)_"/"_($E($P(@VM,"^"),1,3)+1700)
 ...S X=$P(WT,"^",8),Y=$J(X/2.2046226,0,2),$P(WT,"^",9)=Y,X=$P(HT,"^",8),Y=$J(2.54*X,0,2),$P(HT,"^",9)=Y
 ..W !!,"WEIGHT(Kg): " W:+$P(WT,"^",8) $P(WT,"^",9)_" ("_$P(WT,"^")_")" W ?41,"HEIGHT(cm): " W:$P(HT,"^",8) $P(HT,"^",9)_" ("_$P(HT,"^")_")" K VM,WT,HT
 D:$D(DIRUT) KLCL Q:$D(DIRUT)  S PAGE=PAGE+1 I $D(^UTILITY("VASD",$J)),PAGE=2!($G(PSOPOLP)) D KLCL S PSOPOLP=0 D HD Q
 D KLCL I PSTYPE,'$D(HDFL) D 1 S HDFL=""
 W !,$E(LINE,1,$S('PSORM:80,1:IOM)-1),!,"Medication/Supply" Q:'PSORM
 W ?74,"Rx#",?85,"Status",?98,"Expiration",?110,"Provider",!,?101,"Date"
 Q
 ;
CAPP ;
 K X S X2=DT,X1=$P($P($G(PSOACPPI),"^"),".") I $G(X1) D ^%DTC
 W $S($P(PSOACPPI,"^",3)["C":"   *** Canceled ***",1:" ("_$G(X)_" days)")
 Q
PSRENW D:'$G(PSODTCUT) CUTDATE^PSOFUNC I $P(RX2,"^",6)<PSODTCUT S PSRENW=0 G LN
 I $E($P(RX0,"^",15))="D",$P(RX3,"^",5)<PSODTCUT,$P(^PSRX(RXNO,"STA"),"^")=12 S PSRENW=0 G LN
 I $E($P(RX0,"^",15))="D",$P(^PSRX(RXNO,"STA"),"^")'=12 S PSRENW=0
LN S CS=0 F DEA=1:1 Q:$E(PSODEA,DEA)=""  I $E(+PSODEA,DEA)>2,$E(+PSODEA,DEA)<6 S CS=1
 K DEA,PSODEA Q
KLCL K ^UTILITY("VASD",$J),PSOACPPI,PSOACPPE,PSOACPP Q
