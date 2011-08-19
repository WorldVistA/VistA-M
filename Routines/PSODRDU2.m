PSODRDU2 ;BHAM ISC/SAB - dup drug/class display for outpatient orders ;9/23/97 8:40am
 ;;7.0;OUTPATIENT PHARMACY;**132,251,375,387**;DEC 1997;Build 13
 ;External reference ^PS(50.7 - 2223
 ;External reference ^PS(50.606 - 2174
 ;External reference ^PSDRUG( - 221
 ;External reference to ^PS(55 - 2228
EN(PSODFN,ORN,LIST) ;psodfn=patient's ifn, orn=ordertype;order#;drugtype;counter
 N DUPRXO,I,ISSD,J,BSIG,RFLS,RXREC,ST,PSONULN,LSTFL
 S $P(PSONULN,"-",79)="-"
 I $P(ORN,";")="O" G RX
 I $P(ORN,";")="P" G PND
 I $P(ORN,";")="N" G NVA
 I $P(ORN,";")="R" G RDI
 Q
RX ;Rx info
 Q:'$D(^PSRX($P(ORN,";",2),0))  N ISSD,LSTFLD S RXREC=$P(ORN,";",2)
 S DUPRX0=^PSRX(RXREC,0),RFLS=$P(DUPRX0,"^",9),ISSD=$P(^PSRX(RXREC,0),"^",13),ISSD=$E(ISSD,4,5)_"/"_$E(ISSD,6,7)_"/"_$E(ISSD,2,3)
 S LSTFL=(+^PSRX(RXREC,3)),LSTFL=$E(LSTFL,4,5)_"/"_$E(LSTFL,6,7)_"/"_$E(LSTFL,2,3),RX0=DUPRX0,RX2=^PSRX(RXREC,2)
 S STA="ACTIVE^NON-VERIFIED^REFILL^HOLD^NON-VERIFIED^SUSPENDED^^^^^DONE^EXPIRED^DISCONTINUED^DELETED^DISCONTINUED BY PROVIDER^DISCONTINUED (EDIT)^HELD BY PROVIDER"
 S ST=$P(STA,"^",(+$P(^PSRX(RXREC,"STA"),"^")+1)) K STA
 W !,"Local Rx #"_$P(DUPRX0,"^")_" ("_ST_") for "_$P(^PSDRUG($P(DUPRX0,"^",6),0),"^")
 K FSIG,BSIG I $P($G(^PSRX(RXREC,"SIG")),"^",2) D FSIG^PSOUTLA("R",RXREC,60) F PSREV=1:1 Q:'$D(FSIG(PSREV))  S BSIG(PSREV)=FSIG(PSREV)
 K FSIG,PSREV I '$P($G(^PSRX(RXREC,"SIG")),"^",2) D EN2^PSOUTLA1(RXREC,60)
 W !,"SIG: "_$G(BSIG(1)) I $O(BSIG(1)) F PSREV=1:0 S PSREV=$O(BSIG(PSREV)) Q:'PSREV  W !?20,$G(BSIG(PSREV))
 D PRSTAT(RXREC) W !
 Q
PND ;op pending orders
 Q:'$D(^PS(52.41,$P(ORN,";",2),0))
 N DUPRX0,FSIG
 S DUPRX0=^PS(52.41,$P(ORN,";",2),0)
 W !,"Pending Outpatient Drug for "_$S('$P(DUPRX0,"^",9):$P(^PS(50.7,$P(DUPRX0,"^",8),0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^"),1:$P(^PSDRUG($P(DUPRX0,"^",9),0),"^"))
 D FSIG^PSOUTLA("P",$P(ORN,";",2),IOM-6)
 W !,"SIG: " F I=0:0 S I=$O(FSIG(I)) Q:'I  W FSIG(I),!?5
 Q
NVA ;non-va meds
 Q:'$D(^PS(55,PSODFN,"NVA",$P(ORN,";",2),0))
 S DUPRX0=^PS(55,PSODFN,"NVA",$P(ORN,";",2),0)
 W !,"NON-VA Med: "_$S('$P(DUPRX0,"^",2):$P(^PS(50.7,$P(DUPRX0,"^"),0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^"),1:$P(^PSDRUG($P(DUPRX0,"^",2),0),"^")) ;_" (ACTIVE)"
 W !,"Dosage: "_$P(DUPRX0,"^",3),?25,"Schedule: "_$P(DUPRX0,"^",5)
 W !
 ;W !?3,"Date Documented: "_$E($P(DUPRX0,"^",10),4,5)_"/"_$E($P(DUPRX0,"^",10),6,7)_"/"_$E($P(DUPRX0,"^",10),2,3),?30,"Status: Active",!
 K DUPRX0
 Q
RDI ;RDI orders
 Q:'$D(^TMP($J,LIST,"OUT","REMOTE",$P(ORN,";",2)))
 S RXREC=^TMP($J,LIST,"OUT","REMOTE",$P(ORN,";",2))
 W !,"LOCATION: "_$P(RXREC,"^")
 W !,"Remote Rx #"_$P(RXREC,"^",5)_" ("_$P(RXREC,"^",4)_") for "_$P(RXREC,"^",3)
 W !,"SIG: " S I="" F  S I=$O(^TMP($J,LIST,"OUT","REMOTE",$P(ORN,";",2),"SIG",I)) Q:I=""  D
 .W ^TMP($J,LIST,"OUT","REMOTE",$P(ORN,";",2),"SIG",I),!
 .I $O(^TMP($J,LIST,"OUT","REMOTE",$P(ORN,";",2),"SIG",I))'="" W ?5
 W "Last Filled On: "_$P(RXREC,"^",6),!
 K RXREC,I
 Q
PRSTAT(DA) ;Displays the prescription's status
 N PSOTRANS,PSOREL,PSOCMOP,RXPSTA,PSOX,RFLZRO,PSOLRD,PSORTS,CMOP
 D HD^PSODDPR2():(($Y+5)'>IOSL) Q:$G(PSODLQT)  S RXPSTA="Processing Status: ",PSOLRD=$P($G(^PSRX(RXREC,2)),"^",13)
 D ^PSOCMOPA I $G(PSOCMOP)]"" D  K CMOP,PSOTRANS,PSOREL
 .S PSOTRANS=$E($P(PSOCMOP,"^",2),4,5)_"/"_$E($P(PSOCMOP,"^",2),6,7)_"/"_$E($P(PSOCMOP,"^",2),2,3)
 .S PSOREL=$S(CMOP("L")=0:$P($G(^PSRX(DA,2)),"^",13),1:$P(^PSRX(DA,1,CMOP("L"),0),"^",18))
 .S PSOREL=$E(PSOREL,4,5)_"/"_$E(PSOREL,6,7)_"/"_$E(PSOREL,2,3)_"@"_$E($P(PSOREL,".",2),1,4)
 .I '$D(IOINORM)!('$D(IOINHI)) S X="IORVOFF;IORVON;IOINHI;IOINORM" D ENDR^%ZISS
 .I $P($G(^PSRX(RXREC,"STA")),"^")=0 W:$$TRANCMOP^PSOUTL(RXREC) ?5,IORVON_IOINHI
 .W !,RXPSTA_$S($P(PSOCMOP,"^")=0!($P(PSOCMOP,"^")=2):"Transmitted to CMOP on "_PSOTRANS,$P(PSOCMOP,"^")=1:"Released by CMOP on "_PSOREL,1:"Not Dispensed"),IOINORM_IORVOFF
 D HD^PSODDPR2():(($Y+5)'>IOSL) Q:$G(PSODLQT)
 I $G(PSOCMOP)']"" D
 .F PSOX=0:0 S PSOX=$O(^PSRX(RXREC,1,PSOX)) Q:'PSOX  D
 ..S RFLZRO=$G(^PSRX(RXREC,1,PSOX,0))
 ..S:$P(RFLZRO,"^",18)'="" PSOLRD=$P(RFLZRO,"^",18) I $P(RFLZRO,"^",16) S PSOLRD=PSOLRD_"^R",PSORTS=$P(RFLZRO,"^",16)
 .I '$O(^PSRX(RXREC,1,0)),$P(^PSRX(RXREC,2),"^",15) S PSOLRD=PSOLRD_"^R",PSORTS=$P(^PSRX(RXREC,2),"^",15)
 .W !,RXPSTA I +$G(PSORTS) W "Returned to stock on "_$$FMTE^XLFDT(PSORTS,2) Q
 .W $S(PSOLRD="":"Not released locally",1:"Released locally on "_$$FMTE^XLFDT($P(PSOLRD,"^"),2)_" "_$P(PSOLRD,"^",2))_$S($P(^PSRX(RXREC,0),"^",11)="W":" (Window)",1:" (Mail)")
 Q
