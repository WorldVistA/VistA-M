ALPBPCLN ;OIFO-DALLAS MW,SED,KC-PRINT 3-7 DAY MAR BCMA BCBU REPORT FOR CLINICS ;3/9/13 9:13am
 ;;3.0;BAR CODE MED ADMIN;**73**;Mar 2004;Build 31
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; 
 ; NOTE: this routine is designed for hard-copy output.
 ;      Output is formatted for 132-column printing.
 ; 
EN(RPT) ;Entry point to print either All clinics or a selected clinics
 N ALPBCL
 S RPT=$G(RPT,"ALL")   ;assume All cllinics if RPT is not defined
 ;
 ;selected Clinic report tag
 F  D  Q:$D(DIRUT)
 .D:RPT="CLN"
 ..W !,"Inpatient Pharmacy Orders for a selected Clinic"
 ..S DIR(0)="FAO^2:30"
 ..S DIR("A")="Select CLINIC: "
 ..S DIR("?")="^D CLINLIST^ALPBUTL(""C"")"
 ..D ^DIR K DIR
 ..I $D(DIRUT) Q
 ..D CLINSEL^ALPBUTL(Y,.ALPBSEL)
 ..I +$G(ALPBSEL(0))=0 D  Q
 ...W $C(7)
 ...W "  ??"
 ...D CLINLIST^ALPBUTL("C")
 ...K ALPBSEL
 ..I +$G(ALPBSEL(0))=1 D
 ...S ALPBCL=ALPBSEL(1)
 ...W "   ",ALPBCL
 ...K ALPBSEL
 ..I +$G(ALPBSEL(0))>1 D  I $D(DIRUT) K DIRUT,DTOUT,X,Y Q
 ...S ALPBX=0
 ...F  S ALPBX=$O(ALPBSEL(ALPBX)) Q:'ALPBX  W !?2,$J(ALPBX,2),"  ",ALPBSEL(ALPBX)
 ...K ALPBX
 ...S DIR(0)="NA^1:"_ALPBSEL(0)
 ...S DIR("A")="Select Clinic from the list (1-"_ALPBSEL(0)_"): "
 ...W ! D ^DIR K DIR
 ...I $D(DIRUT) K ALPBSEL Q
 ...S ALPBCL=ALPBSEL(+Y)
 ...W "   ",ALPBCL
 ...K ALPBSEL
 .Q:$D(DIRUT)!($D(DUOUT))
 .I ($G(RPT)="CLN")&($G(ALPBCL)="") D  Q
 ..W !,"No Clinic Selected"
 .;
 .; Get All or Current Orders?
 .S DIR(0)="SA^A:ALL;C:CURRENT"
 .S DIR("A")="Report [A]LL or [C]URRENT orders? "
 .S DIR("B")="CURRENT"
 .S DIR("?")="[A]LL=all orders in the file, [C]URRENT=orders not yet expired."
 .W ! D ^DIR K DIR
 .I $D(DIRUT) K:RPT="CLN" ALPBCL,DIRUT,DTOUT,X,Y Q
 .S ALPBOTYP=Y
 .;
 .; Include a Patient's Inpatient Medications on this Clinic Report
 .S ALPBINCLI=""
 .S DIR(0)="SA^Y:YES;N:NO"
 .S DIR("A")="Include a Patient's Inpatient Medications on the Clinic report? "
 .S DIR("B")="YES"
 .S DIR("?",1)=" [Y]es = include any Inpatient medications found for this patient on the"
 .S DIR("?",2)="         Clinic report."
 .S DIR("?",3)=" [N]o =  do not include Inpatient medications for this patient on the"
 .S DIR("?")="         Clinic report."
 .W ! D ^DIR K DIR
 .I $D(DIRUT) K ALPBOTYP,DIRUT,DTOUT,DUOUT,X,Y Q
 .S ALPBINCLI=Y
 .;
 .; Print How Many Days MAR?...
 .S DIR(0)="NA^1:7"
 .S DIR("A")="Print how many days MAR? "
 .S DIR("B")=$$DEFDAYS^ALPBUTL()
 .S DIR("?")="The default is shown; please select a number 1 to 7."
 .W ! D ^DIR K DIR
 .I $D(DIRUT) K ALPBOTYP,DIRUT,DTOUT,X,Y Q
 .S ALPBDAYS=+Y
 .;
 .; BCMA Med Log Info for How Many Entries?
 .S DIR(0)="NA^1:99"
 .S DIR("B")=$$DEFML^ALPBUTL3()
 .S DIR("A")="Select how many BCMA Medication Log history: "
 .S DIR("A",1)=" "
 .S DIR("?",1)="Select a number of BCMA Medication log entries"
 .S DIR("?",2)="for each of the patient's orders"
 .S DIR("?")="They are listed by the most current entry first"
 .D ^DIR K DIR
 .I $D(DIRUT) K ALPBOTYP,ALPBCL,DIRUT,DTOUT,X,Y Q
 .S ALPBMLOG=Y
 .;
 .S %ZIS="Q"
 .S %ZIS("B")=$$DEFPRT^ALPBUTL()
 .I %ZIS("B")="" K %ZIS("B")
 .W ! D ^%ZIS K %ZIS
 .I POP D  Q
 ..W $C(7)
 ..K ALPBMLOG,ALPBOTYP,ALPBCL,ALPBINCLI,POP
 .;
 .; output not queued...
 .I '$D(IO("Q")) D
 ..W ! W:RPT="ALL" "ALL CLINICS REPORT" W:RPT="CLN" "SELECTED CLINIC REPORT FOR "_$G(ALPBCL) W " IS RUNNING...",! H 1
 ..U IO
 ..D DQ(RPT)
 ..I IO'=IO(0) D ^%ZISC
 .;
 .; Set up the Task
 .I $D(IO("Q")) D
 ..S ZTRTN="DQ^ALPBPCLN(RPT)"
 ..S ZTDESC="PSB INPT PHARM ORDERS FOR CLIN "_$S(($G(ALPBCL)'=""):ALPBCL,1:"ALL CLINICS")
 ..S ZTSAVE("ALPBDAYS")=""
 ..S ZTSAVE("ALPBCL")=""
 ..S ZTSAVE("ALPBMLOG")=""
 ..S ZTSAVE("ALPBOTYP")=""
 ..S ZTSAVE("ALPBINCLI")=""
 ..S ZTSAVE("RPT")=""
 ..S ZTIO=ION
 ..D ^%ZTLOAD
 ..D HOME^%ZIS
 ..W !,$S($G(ZTSK):"Task number "_ZTSK_" queued.",1:"ERROR -- NOT QUEUED!")
 ..K IO("Q"),ZTSK
 .K ALPBDAYS,ALPBMLOG,ALPBOTYP,ALPBCL,ALPBINCLI
 .I RPT="ALL" S DIRUT=1
 K DIRUT,DTOUT,X,Y
 Q
 ;
DQ(RPT) ; output entry point...
 ; set report date...  SED 11/4/03
 N ALPBRDAT S ALPBRDAT=$S(ALPBOTYP="C":$$NOW^XLFDT(),1:"")
 K ^TMP($J),^TMP("PSBCL",$J)
 D @RPT                           ;Do Tag CLN or ALL
 D DONE
 Q
 ;
ALL ;All Clinic report
 N ALPBPG,ALPBIEN,PATNAM
 ;loop thru Clinics xref for ALL clinics & build ^TMP, sorted by
 ; Clinic, by patn name, by patn ien
 S ALPBCL=""
 F  S ALPBCL=$O(^ALPB(53.7,"AC",ALPBCL)) Q:ALPBCL=""  D
 .S ALPBIEN=0
 .F  S ALPBIEN=$O(^ALPB(53.7,"AC",ALPBCL,ALPBIEN)) Q:'ALPBIEN  D
 ..S PATNAM=$P(^ALPB(53.7,ALPBIEN,0),U)
 ..S ^TMP("PSBCL",$J,ALPBCL,PATNAM,ALPBIEN)=""
 S ALPBCL=""
 F  S ALPBCL=$O(^TMP("PSBCL",$J,ALPBCL)) Q:ALPBCL=""  D
 .D GETORDS
 S ALPBPG=0
 D PRT
 Q
 ;
CLN ;Selected Clinic report
 N ALPBPG,ALPBIEN,PATNAM
 ;loop thru Clinics xref & build a TMP global for each clinic on file
 ;   by clinic name, by patn name, by patn ien
 S ALPBIEN=0
 F  S ALPBIEN=$O(^ALPB(53.7,"AC",ALPBCL,ALPBIEN)) Q:'ALPBIEN  D
 .S PATNAM=$P(^ALPB(53.7,ALPBIEN,0),U)
 .S ^TMP("PSBCL",$J,ALPBCL,PATNAM,ALPBIEN)=""
 D GETORDS
 S ALPBPG=0
 D PRT
 Q
 ;
GETORDS ;Get orders per clinic
 N ALPBPTN,ALPBIEN,ALPBOIEN,ALPBCLIN,ALPBOCT,ALPBDRGNAME,ALPBOST
 N ALPBORDS,ALPBDATA,ALPBDAT0
 S ALPBPTN=""
 F  S ALPBPTN=$O(^TMP("PSBCL",$J,ALPBCL,ALPBPTN)) Q:ALPBPTN=""  D
 .S ALPBIEN=0 K ALPBORDS
 .F  S ALPBIEN=$O(^TMP("PSBCL",$J,ALPBCL,ALPBPTN,ALPBIEN)) Q:'ALPBIEN  D
 ..D ORDS^ALPBUTL(ALPBIEN,ALPBRDAT,.ALPBORDS,ALPBCL,ALPBINCLI)
 ..I $G(ALPBPDAT(0))="" S ALPBPDAT(0)=$G(^ALPB(53.7,ALPBIEN,0))
 ..S ALPBOIEN=0
 ..F  S ALPBOIEN=$O(ALPBORDS(ALPBOIEN)) Q:'ALPBOIEN  D
 ...S ALPBDATA=$G(^ALPB(53.7,ALPBIEN,2,ALPBOIEN,1))
 ...S ALPBDAT0=$G(^ALPB(53.7,ALPBIEN,2,ALPBOIEN,0))
 ...S ALPBCLIN=$P(ALPBDAT0,U,5) S:ALPBCLIN="" ALPBCLIN=0
 ...S ALPBOCT=$P($G(^ALPB(53.7,ALPBIEN,2,ALPBOIEN,3)),U,1)
 ...S:$P($G(^ALPB(53.7,ALPBIEN,2,ALPBOIEN,4)),U,3)["PRN" ALPBOCT=ALPBOCT_"P"
 ...;drug name being used for alpha-sorting medications within order types (unit dose, unit dose-PRN, intravenous, intravenous-PRN)
 ...S ALPBDRGNAME=$P($G(^ALPB(53.7,ALPBIEN,2,ALPBOIEN,7,1,0)),U,2)
 ...S:ALPBDRGNAME="" ALPBDRGNAME="NOT FOUND"
 ...; if report is for "C"urrent, check stop date and quit if
 ...; stop date is less than report date
 ...I ALPBOTYP="C"&($P(ALPBDATA,U,2)<ALPBRDAT) K ALPBDATA Q
 ...S ALPBORDN=ALPBORDS(ALPBOIEN)
 ...S ALPBOST=$$STAT2^ALPBUTL1(ALPBORDS(ALPBOIEN,2))
 ...S ^TMP($J,ALPBPTN)=ALPBIEN
 ...S ^TMP($J,ALPBPTN,ALPBCLIN,ALPBOCT,ALPBDRGNAME,ALPBOST,ALPBORDN)=ALPBOIEN
 Q
 ;
PRT ;
 N ALPBPTN,ALPBCLIN,ALPBOCT,ALPBDRGNAME,ALPBOST
 S ALPBPTN=""
 F  S ALPBPTN=$O(^TMP($J,ALPBPTN)) Q:ALPBPTN=""  D
 .S ALPBIEN=^TMP($J,ALPBPTN)
 .S ALPBPDAT(0)=$G(^ALPB(53.7,ALPBIEN,0))
 .K ALPBPDAT(1) M ALPBPDAT(1)=^ALPB(53.7,ALPBIEN,1)
 .I ALPBPG=0 D PAGE
 .S ALPBCLIN=""
 .F  S ALPBCLIN=$O(^TMP($J,ALPBPTN,ALPBCLIN)) Q:ALPBCLIN=""  D
 ..S ALPBOCT=""
 ..F  S ALPBOCT=$O(^TMP($J,ALPBPTN,ALPBCLIN,ALPBOCT)) Q:ALPBOCT=""  D
 ...S ALPBDRGNAME=""
 ...F  S ALPBDRGNAME=$O(^TMP($J,ALPBPTN,ALPBCLIN,ALPBOCT,ALPBDRGNAME)) Q:ALPBDRGNAME=""  D
 ....S ALPBOST=""
 ....F  S ALPBOST=$O(^TMP($J,ALPBPTN,ALPBCLIN,ALPBOCT,ALPBDRGNAME,ALPBOST)) Q:ALPBOST=""  D
 .....S ALPBORDN=""
 .....F  S ALPBORDN=$O(^TMP($J,ALPBPTN,ALPBCLIN,ALPBOCT,ALPBDRGNAME,ALPBOST,ALPBORDN)) Q:ALPBORDN=""  D
 ......S ALPBOIEN=^TMP($J,ALPBPTN,ALPBCLIN,ALPBOCT,ALPBDRGNAME,ALPBOST,ALPBORDN)
 ......; get and print this order's data...
 ......M ALPBDATA=^ALPB(53.7,ALPBIEN,2,ALPBOIEN)
 ......D F132^ALPBFRM1(.ALPBDATA,ALPBDAYS,ALPBMLOG,.ALPBFORM,ALPBIEN)
 ......I $Y+ALPBFORM(0)=IOSL!($Y+ALPBFORM(0)>IOSL) D PAGE
 ......F ALPBX=1:1:ALPBFORM(0) W !,ALPBFORM(ALPBX)
 ......K ALPBDATA,ALPBFORM,ALPBOIEN,ALPBX
 .; print footer at end of this patient's record...
 .I $Y+10>IOSL D PAGE
 .;
 .;additional blank lines added to separate footer from header and
 .;allow room for notes
 .I $E(IOST)="P" F  Q:$Y>=(IOSL-6)  W !
 .;
 .D FOOT^ALPBFRMU
 .S ALPBPG=0
 .K ALPBDAT
 Q
 ;
DONE ;   
 K ALPBDAYS,ALPBMLOG,ALPBOTYP,ALPBCL,ALPRM,ALPRM1,ALPBD,^TMP($J),^TMP("PSBCL",$J)
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
PAGE ; print page header for patient...
 W @IOF
 S ALPBPG=ALPBPG+1
 D HDR^ALPBFRMU(.ALPBPDAT,ALPBPG,.ALPBHDR)
 F ALPBX=1:1:ALPBHDR(0) W !,ALPBHDR(ALPBX)
 K ALPBHDR,ALPBX
 Q
