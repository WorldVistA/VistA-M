TIUP146P ; SLC/JAK,RMO - Post-Install for TIU*1*146 Cont.;9/9/02@13:15:47
 ;;1.0;TEXT INTEGRATION UTILITIES;**146**;Jun 20, 1997
PRINT ; -- Device Selection
 W !!,"This routine will print the results of the search routine in patch"
 W !,"TIU*1*146 which identifies documents pointing to a different"
 W !,"patient's visit in the TIU DOCUMENT file (#8925)."
 W !!,*7,"This report requires a column width of 132.",!
 S %ZIS="Q" D ^%ZIS I POP K POP G PRINTQ
 I $D(IO("Q")) K IO("Q") D  Q
 . S ZTRTN="LIST^TIUP146P"
 . S ZTDESC="TIU*1*146 - PRINT SEARCH RESULTS"
 . D ^%ZTLOAD W !,$S($D(ZTSK):"Request queued",1:"Request Cancelled!")
 . K ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,%ZIS
 . D HOME^%ZIS
 U IO D LIST,^%ZISC
PRINTQ Q
 ;
LIST ; -- Entry point to generate list
 N TIUDA,TIUOUT,TIUVSIT S TIUOUT=0
 I $D(ZTQUEUED) S ZTREQ="@"
 D HDR
 I +$O(^XTMP("TIUP146","EX",0))'>0 W !?4,"No records in list." G LISTQ
 S TIUDA=0
 F  S TIUDA=$O(^XTMP("TIUP146","EX",TIUDA)) Q:'TIUDA!(TIUOUT)  S TIUVSIT=+$G(^(TIUDA)) D LISTONE(TIUDA,TIUVSIT)
LISTQ Q
 ;
LISTONE(TIUDA,TIUVSIT) ;Entry point to list one record
 ; Input  -- TIUDA    TIU Document file (#8925) IEN
 ;           TIUVSIT  Visit file (#9000010) IEN
 ; Output -- None
 N DFN,TIUD0,TIUHL,VADM,VAIP,VAIN,VA
 I $Y>(IOSL-4) D ASK G LISTONEQ:TIUOUT  D HDR
 S TIUD0=$G(^TIU(8925,+TIUDA,0))
 S TIUHL=$P($G(^TIU(8925,+TIUDA,12)),U,11)
 S DFN=+$P(TIUD0,U,2)
 I DFN>0 D OERR^VADPT
 W !,TIUDA
 W ?12,$E($$UPPER^TIULS($P($G(^TIU(8925.6,+$P(TIUD0,U,5),0)),U)),1,5)
 W ?19,$S(DFN>0:$E($G(VADM(1)),1,20)_" ("_$G(VA("BID"))_")",1:"")
 W ?48,$E($P($G(^TIU(8925.1,+TIUD0,0)),U,1),1,10)
 W ?60,$$DATE^TIULS(+$P($G(^TIU(8925,+TIUDA,13)),U,1),"MM/DD/CCYY HR:MIN")
 W ?78,$E($$GET1^DIQ(44,+TIUHL,.01,"E"),1,15)
 I TIUVSIT>0 D
 . N DA,DIC,DIQ,DR,TIUVISIT
 . S DIC="^AUPNVSIT(",DIQ="TIUVISIT",DIQ(0)="E",DA=+TIUVSIT
 . S DR=".01" D EN^DIQ1
 . W ?95,$G(TIUVISIT(9000010,DA,.01,"E"))
 . W ?118,TIUVSIT
LISTONEQ Q
 ;
ASK ; -- End of Page
 I IO=IO(0),$E(IOST)="C" D
 . W ! N DIR,X,Y S DIR(0)="E"
 . D ^DIR I $D(DUOUT)!$D(DTOUT) S TIUOUT=1
 Q
 ;
HDR ; -- Header for report
 N LNE,TIUNOW
 D NOW^%DTC S Y=% X ^DD("DD") S TIUNOW=Y
 W @IOF,"TIU*1*146 TIU DOCUMENTS LINKED TO A DIFFERENT PATIENT'S VISIT - Printed: ",TIUNOW
 W !,"Document #",?12,"Status",?19,"Patient in Document",?48,"Title",?60,"Reference Date",?78,"Visit Location",?95,"Incorrect Visit Date &",?118,"Visit #"
 W ! S LNE="",$P(LNE,"-",(IOM-1))="" W LNE
 Q
 ;
MAIL ;Send completion message to user who initiated post-install
 N XMSUB,XMTEXT,XMDUZ,XMY,XMZ,XMMG
 N TIUTXT
 S XMDUZ="PATCH TIU*1*146 TIU DOCUMENT SEARCH RESULTS",XMY(.5)=""
 S:$G(DUZ) XMY(DUZ)=""
 S XMY("G.PATIENT SAFETY NOTIFICATIONS")=""
 S TIUTXT(1)="TIU Documents linked to different patient's visit."
 S TIUTXT(2)=""
 S TIUTXT(3)="Task Started: "_$$FMTE^XLFDT($G(^XTMP("TIUP146","T0")))
 S TIUTXT(4)="Task   Ended: "_$$FMTE^XLFDT($G(^XTMP("TIUP146","T1")))
 S TIUTXT(5)=""
 ;
 S TIUTXT(6)="Number of entries linked to Different Patient's Visit: "_+$G(^XTMP("TIUP146","CNT","EX"))
 S TIUTXT(7)=""
 S TIUTXT(8)="TOTAL Number of entries processed: "_+$G(^XTMP("TIUP146","CNT","TOT"))
 S TIUTXT(9)=""
 I $G(^XTMP("TIUP146","STOP")) D
 . S TIUTXT(10)="Task STOPPED: "_$$FMTE^XLFDT($G(^XTMP("TIUP146","STOP")))_"."
 ELSE  D
 . S TIUTXT(10)="Task COMPLETED successfully."
 . S TIUTXT(11)=""
 . S TIUTXT(12)="To print a detailed listing of the results invoke D PRINT^TIUP146P."
 S XMTEXT="TIUTXT(",XMSUB="TIU*1*146 TIU Documents Linked to Different Patient's Visit"
 D ^XMD
 Q
