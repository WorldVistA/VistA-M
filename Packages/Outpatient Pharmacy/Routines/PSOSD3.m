PSOSD3 ;BHAM ISC/RTR - Prints pending orders on action profile ;11/20/95
 ;;7.0;OUTPATIENT PHARMACY;**2,19,107,110,132,233,258,326**;DEC 1997;Build 11
 ;External reference ^PS(50.7 - 2223
 ;External reference ^PS(50.606 - 2174
 ;External reference ^PSDRUG( - 221
 ;External reference ^PS(59.7 - 694
 ;External reference to ^PS(55 - 2228
 ;
START Q:$D(DUOUT)!($D(DTOUT))!('$G(DFN))
 N MMM,PNDIS,PNDLINE,PNDREX,PNPOI,PPPP,PSOPRVD,PSCONT,PSOEFF,PSOQTY,PSOREFLS,PZSTAT,WWW
 D ELIG^PSOSD1,DEM^VADPT,INP^VADPT,ADD^VADPT,PID^VADPT S PSSN=VA("PID"),ADDRFL=$S(+VAPA(9):"Temporary ",1:"")
 S PSNAME=$E(VADM(1),1,28),PSDOB=$P(VADM(3),"^",2)
 K ^TMP($J,"PSOPEND") S $P(PNDLINE,"-",33)=""
 S PSCONT=1 F MMM=0:0 S MMM=$O(^PS(52.41,"P",DFN,MMM)) Q:'MMM  S PZSTAT=$P($G(^PS(52.41,MMM,0)),"^",3) I PZSTAT="NW"!(PZSTAT="HD")!(PZSTAT="RNW") D
 .S ^TMP($J,"PSOPEND",PSCONT)=MMM_"^"_$S(+$P($G(^PS(52.41,MMM,0)),"^",9):"DD",1:"OI") S PSCONT=PSCONT+1
 I $Y+6>IOSL D HD1 S:$D(DTOUT)!($D(DUOUT)) PSQFLG=1 G:$G(PSQFLG) END
 D HD
 I PSCONT=1 W !?10,"No pending orders for this patient!",! G END
 F WWW=0:0 S WWW=$O(^TMP($J,"PSOPEND",WWW)) Q:'WWW!($G(PSQFLG))  D
 .S PNDREX=$P(^TMP($J,"PSOPEND",WWW),"^"),PNDIS=$P($G(^PS(52.41,PNDREX,0)),"^",9),PNPOI=$P($G(^(0)),"^",8),PSOEFF=$P($G(^(0)),"^",6),PSOQTY=$P($G(^(0)),"^",10),PSOREFLS=$P($G(^(0)),"^",11),PSOPRVD=$P($G(^(0)),"^",5)
 .W !,"Drug: ",$S($P(^TMP($J,"PSOPEND",WWW),"^",2)="DD":$P($G(^PSDRUG(+PNDIS,0)),"^"),1:$P($G(^PS(50.7,+PNPOI,0)),"^")_" "_$P($G(^PS(50.606,+$P($G(^(0)),"^",2),0)),"^")),!
 .W ?1,"Eff. Date: ",$E(PSOEFF,4,5)_"-"_$E(PSOEFF,6,7)_"-"_($E(PSOEFF,1,3)+1700),?22,"Qty: ",PSOQTY,?40,"Refills: ",PSOREFLS,?52,"Prov: ",$E($P($G(^VA(200,+PSOPRVD,0)),"^"),1,21)
 .S PSCONT=1 W !?1,"Sig: " F PPPP=0:0 S PPPP=$O(^PS(52.41,PNDREX,"SIG",PPPP)) Q:'PPPP!($G(PSQFLG))  W:PSCONT>1 ! W ?6,$G(^PS(52.41,PNDREX,"SIG",PPPP,0)) S PSCONT=PSCONT+1
 .I $E(IOST)'="C" W !
 .I $E(IOST)="C" D HD1 S:$D(DUOUT)!($D(DTOUT)) PSQFLG=1 Q:$G(PSQFLG)  D HD
 .I $E(IOST)'="C" I $Y+9>IOSL D HD1 S:$D(DUOUT)!($D(DTOUT)) PSQFLG=1 Q:$G(PSQFLG)  D HD
END K ^TMP($J,"PSOPEND") Q
HD W !,PNDLINE,"PENDING ORDERS",PNDLINE,! Q
 ;
HD1 S FN=DFN
 I $E(IOST)="C" K DIR S DIR(0)="E",DIR("A")="Press Return to Continue or ""^"" to Exit" D ^DIR Q:$D(DUOUT)!($D(DTOUT))
 D ELIG^PSOSD1,DEM^VADPT,INP^VADPT,ADD^VADPT,PID^VADPT S PSSN=VA("PID"),ADDRFL=$S(+VAPA(9):"Temporary ",1:"")
 S PSNAME=$E(VADM(1),1,28),PSDOB=$P(VADM(3),"^",2)
 I $D(IOF) W @IOF
 W $S(PSTYPE:"Action",1:"Informational")_" Rx Profile",?47,"Run Date: " S Y=DT D DT^DIO2 W ?71,"Page: "_PAGE
 W !,"Sorted by drug classification for Rx's currently active"_$S('PSDAYS:" only.",1:"") W:PSDAYS !,"and for those Rx's that have been inactive less than "_PSDAYS_" days."
 S X=$$SITE^VASITE
 W @$S(PSORM:"?70",1:"!"),"Site: VAMC "_$P(X,"^",2)_" ("_$P(X,"^",3)_")",!,$E(LINE,1,$S('PSORM:80,1:IOM)-1)
 I $P(VAIN(4),"^",2)]"",+$P($G(^PS(59.7,1,40.1)),"^") W !,"Outpatient prescriptions are discontinued 72 hours after admission.",!
 I $D(CLINICX) W !?1,"Clinic: "_$E(CLINICX,1,28),?45,"Date/Time: " S Y=CLDT D DT^DIO2
 W !?1,"Name  : ",PSNAME W:PSTYPE ?58,"Action Date: ________" W !?1,"DOB   : "_PSDOB
 W:ADDRFL]"" ?30,ADDRFL,! W ?30,"Address  :"
 I $G(ADDRFL)="" D CHECKBAI^PSOSD1
 W ?41,VAPA(1) W:VAPA(2)]"" !?41,VAPA(2) W:VAPA(3)]"" !?41,VAPA(3)
 W !?41,VAPA(4)_", "_$P(VAPA(5),"^",2)_"  "_$S(VAPA(11)]"":$P(VAPA(11),"^",2),1:VAPA(6)),!?30,"Phone    : "_VAPA(8)
 I PSOBAR4 S X="S",X2=PSSN W @$S('PSORM:"!?30",1:"?$X+5") S X1=$X W @PSOBAR3,X2,@PSOBAR2,$C(13) S $X=0
 W:$G(DOD(DFN))]"" ?1,"**** Date of Death: "_DOD(DFN)_" ****",!
 S (WT,HT)="",X="GMRVUTL" X ^%ZOSF("TEST") I $T D
 .F GMRVSTR="WT","HT" S VM=GMRVSTR D EN6^GMRVUTL S @VM=X,$P(@VM,"^")=$E($P(@VM,"^"),4,5)_"/"_$E($P(@VM,"^"),6,7)_"/"_($E($P(@VM,"^"),1,3)+1700)
 .S X=$P(WT,"^",8),Y=$J(X/2.2,0,2),WT=WT_"^"_Y,X=$P(HT,"^",8),Y=$J(2.54*X,0,2),HT=HT_"^"_Y
 W !!,"WEIGHT(Kg): " W:+$P(WT,"^",8) $P(WT,"^",9)_" ("_$P(WT,"^")_")" W ?41,"HEIGHT(cm): " W:$P(HT,"^",8) $P(HT,"^",9)_" ("_$P(HT,"^")_")" K VM,WT,HT
 S PAGE=PAGE+1 W !,$E(LINE,1,$S('PSORM:80,1:IOM)-1)
 Q
NVA ;displays non-va meds
 Q:'$O(^PS(55,DFN,"NVA",0))
 Q:$D(DUOUT)!($D(DTOUT))!('$G(DFN))
 D HD1 S $P(PNDLINE,"-",IOM)="",PSODFN=DFN
 W !,PNDLINE,!?25,"Non-VA Meds (Not dispensed by VA)",!,PNDLINE,!
 F NVA=0:0 S NVA=$O(^PS(55,DFN,"NVA",NVA)) Q:'NVA  D  Q:$G(PSQFLG)
 .I $Y+6>IOSL D HD1 S:$D(DTOUT)!($D(DUOUT)) PSQFLG=1 Q:$G(PSQFLG)
 .Q:'$P(^PS(55,PSODFN,"NVA",NVA,0),"^")
 .S DUPRX0=^PS(55,PSODFN,"NVA",NVA,0)
 .W !,"Orderable Item: "_$P(^PS(50.7,$P(DUPRX0,"^"),0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^")
 .W !,"Drug: "_$S($P(DUPRX0,"^",2):$P(^PSDRUG($P(DUPRX0,"^",2),0),"^"),1:"No Dispense Drug Selected")
 .W !,"Status: "_$S($P(DUPRX0,"^",7):"Discontinued ("_$$FMTE^XLFDT($P($P(DUPRX0,"^",7),"."))_")",1:"Active")
 .W !,"Dosage: "_$P(DUPRX0,"^",3)
 .W !,"Schedule: "_$P(DUPRX0,"^",5),!,"Route: "_$P(DUPRX0,"^",4)
 .W !,"Start Date: "_$$FMTE^XLFDT($P(DUPRX0,"^",9)),?40,"CPRS Oder #: "_$P(DUPRX0,"^",8)
 .W !,"Documented By: "_$P(^VA(200,$P(DUPRX0,"^",11),0),"^")_" on "_$$FMTE^XLFDT($P(DUPRX0,"^",10))
 .S RMLEN=$S('PSORM:75,1:IOM-5)
 .F I=0:0 S I=$O(^PS(55,PSODFN,"NVA",NVA,"OCK",I)) Q:'I  D  W !
 ..S ORD=$P(^PS(55,PSODFN,"NVA",NVA,"OCK",I,0),"^"),ORP=$P(^(0),"^",2)
 ..W !,"Order Check #"_I_": "
 ..K OCK,LEN I $L(ORD)>RMLEN S (LEN,IEN)=1 D
 ...F SG=1:1:$L(ORD) S:$L($G(OCK(IEN))_" "_$P(ORD," ",SG))>RMLEN&($P(ORD," ",SG)]"") IEN=IEN+1 S:$P(ORD," ",SG)'="" OCK(IEN)=$G(OCK(IEN))_" "_$P(ORD," ",SG)
 ...F II=0:0 S II=$O(OCK(II)) Q:'II  W !?5,OCK(II)
 ..W:'$G(LEN) ORD K LEN,SG,IEN,II,OCK,ORD
 ..W !,"Overriding Provider: "_$S($G(ORP):$P(^VA(200,ORP,0),"^"),1:"")
 ..K ORP,OCK,REA W !,"Reason:" F SS=0:0 S SS=$O(^PS(55,PSODFN,"NVA",NVA,"OCK",I,"OVR",SS)) Q:'SS  S REA(SS)=^PS(55,PSODFN,"NVA",NVA,"OCK",I,"OVR",SS,0)
 ..S IEN=1 F II=0:0 S II=$O(REA(II)) Q:'II  D
 ...F SG=1:1:$L(REA(II)) S:$L($G(OCK(IEN))_" "_$P(REA(II)," ",SG))>RMLEN&($P(REA(II)," ",SG)]"") IEN=IEN+1 S:$P(REA(II)," ",SG)'="" OCK(IEN)=$G(OCK(IEN))_" "_$P(REA(II)," ",SG)
 ...K REA,IEN,SG F II=0:0 S II=$O(OCK(II)) Q:'II  W OCK(II) I $O(OCK(II)) W !?5
 .K OCK W !,"Statement/Explanation/Comments:" F SS=0:0 S SS=$O(^PS(55,PSODFN,"NVA",NVA,"DSC",SS)) Q:'SS  S DSC(SS)=^PS(55,PSODFN,"NVA",NVA,"DSC",SS,0)
 .S IEN=1 F II=0:0 S II=$O(DSC(II)) Q:'II  D
 ..F SG=1:1:$L(DSC(II)) S:$L($G(OCK(IEN))_" "_$P(DSC(II)," ",SG))>RMLEN&($P(DSC(II)," ",SG)]"") IEN=IEN+1 S:$P(DSC(II)," ",SG)'="" OCK(IEN)=$G(OCK(IEN))_" "_$P(DSC(II)," ",SG)
 .K IEN,DSC,SG F II=0:0 S II=$O(OCK(II)) Q:'II  W !?5,OCK(II)
 .W !! I $E(IOST)'="C" W !
 K RMLEN
 Q
