PSDOPTN ;BIR/LTL - Review OP Transactions for a Drug (cont.) ; 24 Jan 95
 ;;3.0; CONTROLLED SUBSTANCES ;**18,55**;13 Feb 97
 ;
 ;References to ^PSD(58.8, covered by DBIA2711
 ;References to DD(58.81 and ^PSD(58.81 are covered by DBIA2808
 ;References to ^PSDRUG( are covered by DBIA221
 ;References to ^PSRX( are covered by DBIA986
 S DIR(0)="DA^2910501::AEPT"
 S DIR("A")="Beginning date@time filled (not posted): ",DIR("?")="I will list Outpatient transactions for your selected drug(s) within your selected date@time range.  Please don't enter a date@time in the future" W ! D ^DIR G:Y<1 END
 S (PSDT,PSDTB)=Y,PSDTB(2)=Y(0)
 S DIR(0)="DA^"_PSDT_"::AET"
 S DIR("A")="Ending date@time filled (not posted): "
 S DIR("?")=$G(DIR("?"))_" or before "_$G(PSDTB(2))
 W ! D ^DIR K DIR G:Y<1 END S PSDTB(1)=Y,PSDTB(3)=Y(0)
 S:'$P(PSDTB(1),".",2) PSDTB(1)=PSDTB(1)+.999999
 S Y=$P($G(^PSD(58.8,+PSDLOC,2)),"^",9),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=Y
DEV ;device
 K IO("Q") N %ZIS,IOP,POP S %ZIS="Q",%ZIS("B")=PSDEV W ! D ^%ZIS I POP W !,"NO DEVICE SELECTED OR OUTPUT PRINTED!" Q
 I $D(IO("Q")) N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDOPTN",ZTDESC="Drug OP transaction review" D SAVE D ^%ZTLOAD,HOME^%ZIS S PSDOUT=1 G END
START ;compiles
 U IO N PSDR,PG S (PG,PSDOUT)=0 K LN D HEADER S PSDT=PSDT-1
 ;loop thru Prescription file by date filled
 F  S PSDT=$O(^PSRX("AD",PSDT)) Q:'PSDT!(PSDT>PSDTB(1))  W:$E(IOST)="C" "." S PSDT(1)=0 D
 .F  S PSDT(1)=$O(^PSRX("AD",PSDT,PSDT(1))) Q:'PSDT(1)  D
 ..S PSDT(5)=$G(^PSRX(PSDT(1),0))
 ..S PSDT(2)=$P($G(^PSDRUG(+$P(PSDT(5),U,6),0)),U) Q:PSDT(2)']""
 ..Q:'$D(^TMP("PSD",$J,PSDT(2)))  S PSDT(4)=""
 ..F  S PSDT(4)=$O(^PSRX("AD",PSDT,PSDT(1),PSDT(4))) Q:PSDT(4)=""  D
 ...;Returned to stock?
 ...Q:$S('PSDT(4):$P($G(^PSRX(PSDT(1),2)),U,15),1:$P($G(^PSRX(PSDT(1),1,PSDT(4),0)),U,16))
 ...;posted to the vault?
 ...S PSDT(3)=0
 ...F  S PSDT(3)=$O(^PSD(58.81,"AOP",PSDT(1),PSDT(3))) Q:'PSDT(3)!($S('PSDT(4)&('$P($G(^PSD(58.81,+PSDT(3),6)),U,2)):1,PSDT(4)=$P($G(^(6)),U,2):1,1:0))
 ...Q:PSDT(3)
 ...;suspended & printed
 ...S (PSDT(3),PSDT(8))=0
 ...I PSDT>DT D  Q:'PSDT(8)
 ....F  S PSDT(3)=$O(^PSRX(PSDT(1),"L",PSDT(3))) Q:'PSDT(3)  S:$P($G(^PSRX(PSDT(1),"L",PSDT(3),0)),U,2)=PSDT(4) PSDT(8)=1
 ...;quantity
 ...S PSDT(6)=$S('PSDT(4):$P(PSDT(5),U,7),1:$P($G(^PSRX(PSDT(1),1,PSDT(4),0)),U,4))
 ...S DFN=$P(PSDT(5),U,2) N C S Y=DFN,C=$P(^DD(58.81,73,0),U,2) D Y^DIQ
 ...S PSDT(7)=Y D PID^VADPT6 S PSDT(7)=PSDT(7)_" ("_VA("BID")_")"
 ...S:$P(PSDT(5),U)]"" ^TMP("PSDO",$J,PSDT(2),$P(PSDT(5),U),PSDT(4))=PSDT(6)_U_PSDT_U_PSDT(7)
 I '$D(^TMP("PSDO",$J)) W !!,"Nothing to Report.",!! G END
 F  S PSDT=$O(^TMP("PSDO",$J,PSDT)) Q:PSDT']""!PSDOUT  D  Q:PSDOUT
 .D:$Y+5>IOSL HEADER Q:PSDOUT  W !!,"Drug =>  ",PSDT  S PSDT(1)=0
 .F  S PSDT(1)=$O(^TMP("PSDO",$J,PSDT,PSDT(1))) Q:'PSDT(1)!PSDOUT  D  Q:PSDOUT
 ..S PSDT(2)=""
 ..F  S PSDT(2)=$O(^TMP("PSDO",$J,PSDT,PSDT(1),PSDT(2))) Q:PSDT(2)=""!PSDOUT  D  Q:PSDOUT
 ...I $Y+4>IOSL D HEADER Q:PSDOUT  W !!,PSDT," (continued)"
 ...W !!,PSDT(1)," (",PSDT(2),")"
 ...S PSDT(3)=$G(^TMP("PSDO",$J,PSDT,PSDT(1),PSDT(2)))
 ...W ?9,$J($P(PSDT(3),U),4) S Y=$P(PSDT(3),U,2) X ^DD("DD") W ?20,Y
 ...W ?40,$P(PSDT(3),U,3)
END W:$E(IOST)'="C" @IOF
 I $E(IOST)="C",'PSDOUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu." W ! D ^DIR
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 D KVAR^VADPT K IO("Q"),VA("PID"),VA("BID"),^TMP("PSDO",$J)
 Q
HEADER I $E(IOST,1,2)'="P-",PG S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSDOUT=1
 W:$Y @IOF S $P(LN,"-",81)="",PG=PG+1 W !,"Outpatient Activity from ",PSDTB(2)," to ",PSDTB(3),?70,"PAGE: ",PG,!,LN,!,"Rx#",?10,"QTY",?20,"Fill Date",?40,"Patient",!,LN
 Q
SAVE ;
 S ZTSAVE("^TMP(""PSD"",$J,")=""
 S (ZTSAVE("PSDT"),ZTSAVE("PSDLOC"),ZTSAVE("PSDTB"),ZTSAVE("PSDTB("))=""
 Q
