FBFPTR ;WOIFO/SAB-FPPS TRANSMIT REPORT ;9/8/2003
 ;;3.5;FEE BASIS;**61**;JAN 30, 1995
 ;
 W !,"This option generates a report of transmissions to FPPS for a date range.",!
 ; ask start date
 S DIR(0)="D^::EX",DIR("A")="From Date"
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S FBDT1=Y
 ;
 ; ask end date
 S DIR(0)="DA^"_FBDT1_":"_DT_":EX",DIR("A")="To Date: "
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S FBDT2=Y
 ;
 ; ask device
 S %ZIS="QM" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="QEN^FBFPTR",ZTDESC="FPPS Transmit Report"
 . F FBX="FBDT*" S ZTSAVE(FBX)=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
 ;
QEN ; queued entry
 U IO
 ;
GATHER ; collect and sort data
 S FBQUIT=0
 ; initialize totals array
 K FBT
 ;
 ; loop thru MESSAGE DATE/TIME x-ref by date and process transmissions
 S FBC=0 ; initialize count of records processed
 S FBDT=FBDT1
 F  S FBDT=$O(^FBHL(163.5,"AMD",FBDT)) Q:FBDT=""!($P(FBDT,".")>FBDT2)  D  Q:FBQUIT
 . S FBDA=0 F  S FBDA=$O(^FBHL(163.5,"AMD",FBDT,FBDA)) Q:'FBDA  D  Q:FBQUIT
 . . S FBC=FBC+1 ; increment count of records processed
 . . ; if tasked then check for stop request
 . . I $D(ZTQUEUED),FBC\1000,$$S^%ZTLOAD S ZTSTOP=1,FBQUIT=1 Q
 . . ; get data
 . . S FBY=$G(^FBHL(163.5,FBDA,0))
 . . S FBFILE=$P(FBY,U,2) ; invoice file number
 . . I FBFILE="" S FBFILE="U"
 . . S FBTTYP=$P(FBY,U,6) ; transaction type
 . . I FBTTYP="" S FBTTYP="U"
 . . S FBSTA=" "_$P(FBY,U,7) ; station number
 . . I FBSTA=" " S FBSTA=" UNK"
 . . ; add to transmitted total
 . . S $P(FBT(FBSTA,FBFILE,FBTTYP),U)=$P($G(FBT(FBSTA,FBFILE,FBTTYP)),U)+1
 . . ; if accepted by interface engine then add to accepted total
 . . I $P(FBY,U,8)="A" S $P(FBT(FBSTA,FBFILE,FBTTYP),U,2)=$P($G(FBT(FBSTA,FBFILE,FBTTYP)),U,2)+1
 ;
PRINT ; report data
 S FBPG=0 D NOW^%DTC S Y=% D DD^%DT S FBDTR=Y
 K FBDL S FBDL="",$P(FBDL,"-",IOM)=""
 ;
 ; build page header text for selection criteria
 S FBHDT(1)="  For "_$$FMTE^XLFDT(FBDT1)_" through "_$$FMTE^XLFDT(FBDT2)
 ;
 D HD
 ;
 I 'FBQUIT,'$D(FBT) W !,"No invoices were transmitted during specified period."
 ;
 I 'FBQUIT,$D(FBT) D RSUM
 ;
 I FBQUIT W !!,"REPORT STOPPED AT USER REQUEST"
 ;
 I 'FBQUIT,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 D ^%ZISC
 ;
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@"
 K FBC,FBDA,FBDL,FBDT,FBDT1,FBDT2,FBDTR,FBFILE,FBHDT,FBPG,FBQUIT
 K FBSTA,FBT,FBTTYP,FBX,FBY
 K %,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,I,J,POP,X,Y
 Q
 ;
RSUM ; report summary
 N FBCC,FBCL,FBCX
 ;
 W !!,"SUMMARY OF EDI INVOICES TRANSMITTED TO FPPS"
 ;
 ; summary header
 D HDSUM
 ;
 ; init grand total
 S FBT="0^0^0" ; confirm^cancel^accepted
 ;
 ; loop thru station
 S FBSTA="" F  S FBSTA=$O(FBT(FBSTA)) Q:FBSTA=""  D  Q:FBQUIT
 . I $Y+9>IOSL D HD Q:FBQUIT  D HDSUM
 . ; init station totals
 . S FBT(FBSTA)="0^0^0" ; confirm^cancel^accepted
 . ;
 . W !
 . ;
 . ; loop thru file type
 . S FBFILE="" F  S FBFILE=$O(FBT(FBSTA,FBFILE)) Q:FBFILE=""  D  Q:FBQUIT
 . . ;
 . . ; get counts for each transaction types
 . . S FBCC=$P($G(FBT(FBSTA,FBFILE,"C")),U) ; claim
 . . S FBCL=$P($G(FBT(FBSTA,FBFILE,"L")),U) ; line
 . . S FBCX=$P($G(FBT(FBSTA,FBFILE,"X")),U) ; cancel
 . . S FBCA=$P($G(FBT(FBSTA,FBFILE,"C")),U,2)+$P($G(FBT(FBSTA,FBFILE,"L")),U,2)+$P($G(FBT(FBSTA,FBFILE,"X")),U,2) ; accepted
 . . ;
 . . ; write the line for the file type
 . . W !,FBSTA
 . . W ?9,$S(FBFILE=3:"Outpatient/Ancillary",FBFILE=5:"Pharmacy",FBFILE=9:"Inpatient",1:"Unknown")
 . . W ?31,$J($FN(FBCL+FBCC,","),9)
 . . W ?42,$J($FN(FBCX,","),9)
 . . W ?53,$J($FN(FBCL+FBCC+FBCX,","),9)
 . . W ?64,$J($FN(FBCA,","),14)
 . . ;
 . . ; add file type counts to station totals
 . . S $P(FBT(FBSTA),U)=$P(FBT(FBSTA),U)+FBCL+FBCC
 . . S $P(FBT(FBSTA),U,2)=$P(FBT(FBSTA),U,2)+FBCX
 . . S $P(FBT(FBSTA),U,3)=$P(FBT(FBSTA),U,3)+FBCA
 . ;
 . ; write station total
 . W !,?31,"---------",?42,"---------",?53,"---------",?64,"--------------"
 . W !,FBSTA," Station Totals",?31,$J($FN($P(FBT(FBSTA),U),","),9)
 . W ?42,$J($FN($P(FBT(FBSTA),U,2),","),9)
 . W ?53,$J($FN($P(FBT(FBSTA),U)+$P(FBT(FBSTA),U,2),","),9)
 . W ?64,$J($FN($P(FBT(FBSTA),U,3),","),14)
 . ;
 . ; add station totals to grand total
 . S $P(FBT,U)=$P(FBT,U)+$P(FBT(FBSTA),U)
 . S $P(FBT,U,2)=$P(FBT,U,2)+$P(FBT(FBSTA),U,2)
 . S $P(FBT,U,3)=$P(FBT,U,3)+$P(FBT(FBSTA),U,3)
 ;
 Q:FBQUIT
 ;
 ; write report totals
 W !!,?31,"=========",?42,"=========",?53,"=========",?64,"=============="
 W !,"Report Totals",?31,$J($FN($P(FBT,U),","),9)
 W ?42,$J($FN($P(FBT,U,2),","),9)
 W ?53,$J($FN($P(FBT,U)+$P(FBT,U,2),","),9)
 W ?64,$J($FN($P(FBT,U,3),","),14)
 Q
 ;
HD ; page header
 N FBI
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,FBQUIT=1 Q
 I $E(IOST,1,2)="C-",FBPG S DIR(0)="E" D ^DIR K DIR I 'Y S FBQUIT=1 Q
 I $E(IOST,1,2)="C-"!FBPG W @IOF
 S FBPG=FBPG+1
 W !,"FPPS Transmission Report ",?49,FBDTR,?72,"page ",FBPG
 S FBI=0 F  S FBI=$O(FBHDT(FBI)) Q:'FBI  W !,FBHDT(FBI)
 W !,FBDL
 Q
 ;
HDSUM ; report summary header
 W !!,?31,"------------- Transmission Counts -------------"
 W !,?31,"Payment",?42,"Payment",?64,"Accepted by"
 W !,"Station",?9,"Invoice Type",?31,"Confirmed",?42,"Cancelled",?53,"Total",?64,"Interface Eng."
 W !,"-------",?9,"------------",?31,"---------",?42,"---------",?53,"---------",?64,"--------------"
 Q
 ;
 ;FBFPTR
