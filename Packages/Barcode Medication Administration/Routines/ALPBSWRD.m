ALPBSWRD ;OIFO-DALLAS MW,SED,KC - display BCBU records for patients on a selected ward ;01/01/03
 ;;3.0;BAR CODE MED ADMIN;**8**;Mar 2004
 ; 
 F  D  Q:$D(DIRUT)
 .W !!,"Inpatient Pharmacy Orders for a selected ward"
 .S DIR(0)="FAO^2:10"
 .S DIR("A")="Select WARD: "
 .S DIR("?")="^D WARDLIST^ALPBUTL(""C"")"
 .D ^DIR K DIR
 .I $D(DIRUT) Q
 .D WARDSEL^ALPBUTL(Y,.ALPBSEL)
 .I +$G(ALPBSEL(0))=0 D  Q
 ..W $C(7)
 ..W "  ??"
 ..D WARDLIST^ALPBUTL("C")
 ..K ALPBSEL
 .I +$G(ALPBSEL(0))=1 D
 ..S ALPBWARD=ALPBSEL(1)
 ..W "   ",ALPBWARD
 ..K ALPBSEL
 .I +$G(ALPBSEL(0))>1 D  I $D(DIRUT) K DIRUT,DTOUT,X,Y Q
 ..S ALPBX=0
 ..F  S ALPBX=$O(ALPBSEL(ALPBX)) Q:'ALPBX  W !?2,$J(ALPBX,2),"  ",ALPBSEL(ALPBX)
 ..K ALPBX
 ..S DIR(0)="NA^1:"_ALPBSEL(0)
 ..S DIR("A")="Select Ward from the list (1-"_ALPBSEL(0)_"): "
 ..W ! D ^DIR K DIR
 ..I $D(DIRUT) K ALPBSEL Q
 ..S ALPBWARD=ALPBSEL(+Y)
 .;
 .; all or just current orders?...
 .S DIR(0)="SA^A:ALL;C:CURRENT"
 .S DIR("A")="[A]LL or [C]URRENT orders? "
 .S DIR("B")="CURRENT"
 .S DIR("?")="ALL=all orders, CURRENT=all orders not expired or inactive"
 .W ! D ^DIR K DIR
 .I $D(DIRUT) K ALPBWARD,DIRUT,DTOUT,X,Y Q
 .S ALPBOTYP=Y
 .;
 .; BCMA Med Log info for how many days?...
 .S X1=$$DT^XLFDT()
 .S X2=-3
 .D C^%DTC
 .S DIR(0)="DA^::EXP"
 .S DIR("B")=$$FMTE^XLFDT(X)
 .S DIR("A")="Select beginning date for BCMA Medication Log history: "
 .S DIR("A",1)=" "
 .S DIR("?")="want only current day's entries, enter 'T' for today."
 .S DIR("?",1)="Select a date (in the past) from which you wish to see"
 .S DIR("?",2)="any BCMA Medication Log entries for each of this patient's"
 .S DIR("?",3)="orders.  The default date shown is 3 days ago.  If you"
 .D ^DIR K DIR
 .I $D(DIRUT) K ALPBOTYP,DIRUT,DTOUT,X,Y Q
 .S ALPBMLOG=Y
 .;
 .S %ZIS="Q"
 .W ! D ^%ZIS K %ZIS
 .I POP D  Q
 ..W $C(7)
 ..K ALPBWARD,POP
 .;
 .; output not queued...
 .I '$D(IO("Q")) D
 ..U IO
 ..D DISP
 ..I IO'=IO(0) D ^%ZISC
 .;
 .; set up the Task...
 .I $D(IO("Q")) D
 ..S ZTRTN="DISP^ALPBHL3"
 ..S ZTDESC="PSB INPT PHARM ORDERS FOR WARD "_ALPBWARD
 ..S ZTSAVE("ALPBWARD")=""
 ..S ZTSAVE("ALPBOTYP")=""
 ..S ZTSAVE("ALPBMLOG")=""
 ..S ZTIO=ION
 ..D ^%ZTLOAD
 ..D HOME^%ZIS
 ..W !,$S($G(ZTSK):"Task number "_ZTSK_" queued.",1:"ERROR -- NOT QUEUED!")
 ..K IO("Q"),ZTSK
 .K ALPBOTYP,ALPBWARD
 K DIRUT,DTOUT,X,Y
 Q
 ;
DISP ; output entry point...
 I $E(IOST)="C" W @IOF
 ;
 ; set report date...
 S ALPBRDAT=$S($G(ALPBOTYP)="C":$$NOW^XLFDT(),1:"")
 ;
 ; loop through ward cross reference in 53.7...
 S ALPBPTN=""
 F  S ALPBPTN=$O(^ALPB(53.7,"AW",ALPBWARD,ALPBPTN)) Q:ALPBPTN=""!($D(DIRUT))  D
 .S (ALPBIEN,ALPBPG)=0
 .F  S ALPBIEN=$O(^ALPB(53.7,"AW",ALPBWARD,ALPBPTN,ALPBIEN)) Q:'ALPBIEN!($D(DIRUT))  D
 ..S ALPBPT(0)=^ALPB(53.7,ALPBIEN,0)
 ..M ALPBPT(1)=^ALPB(53.7,ALPBIEN,1)
 ..I ALPBPG=0 D PAGE
 ..D ORDS^ALPBUTL(ALPBIEN,ALPBRDAT,.ALPBORDS)
 ..I +ALPBORDS(0)=0 D  Q
 ...W !!,">> NO ORDERS FOUND <<"
 ...K ALPBORDS,ALPBPT
 ..S ALPBOIEN=0
 ..F  S ALPBOIEN=$O(ALPBORDS(ALPBOIEN)) Q:'ALPBOIEN!($D(DIRUT))  D
 ...M ALPBDATA=^ALPB(53.7,ALPBIEN,2,ALPBOIEN)
 ...;
 ...D F80^ALPBFRM2(.ALPBDATA,ALPBMLOG,.ALPBFORM)
 ...I $Y+ALPBFORM(0)=IOSL!($Y+ALPBFORM(0)>IOSL) D  Q:$D(DIRUT)
 ....S DIR(0)="E"
 ....D ^DIR K DIR
 ....I $D(DIRUT) K ALPBDATA,ALPBFORM,ALPBPT Q
 ....D PAGE
 ...;
 ...S ALPBX=0
 ...F  S ALPBX=$O(ALPBFORM(ALPBX)) Q:'ALPBX  W !,ALPBFORM(ALPBX)
 ...K ALPBDATA,ALPBFORM,ALPBX
 ...I +$O(ALPBORDS(ALPBOIEN))=0 D
 ....S ALPBX="END OF "_$S(ALPBOTYP="A":"ALL",1:"CURRENT")_" ORDERS FOR "_ALPBPTN
 ....S ALPBX=$$CJ^XLFSTR(ALPBX,80,"-")
 ....W !,ALPBX
 ....K ALPBX
 ....S DIR(0)="E"
 ....D ^DIR K DIR
 ..K ALPBOIEN,ALPBORDS,ALPBPT
 .K ALPBIEN,ALPBPG
 I $E(IOST)="C" W @IOF
 K ALPBMLOG,ALPBOTYP,ALPBPTN,ALPBRDAT,DIRUT,DTOUT,X,Y
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
PAGE ; screen header for patient...
 W @IOF
 S ALPBPG=ALPBPG+1
 D HDR^ALPBFRM2(.ALPBPT,ALPBOTYP,ALPBPG,.ALPBHDR)
 F I=1:1:ALPBHDR(0) W !,ALPBHDR(I)
 K ALPBHDR
 Q
 ;
CONT ; continue?...
 I $E(IOST)="C" D
 .S DIR(0)="E"
 .D ^DIR K DIR
 I '$D(DIRUT) D
 .S ALPBPG=ALPBPG+1
 .D PAGE
 Q
