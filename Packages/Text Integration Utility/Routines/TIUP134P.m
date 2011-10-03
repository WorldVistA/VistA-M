TIUP134P ; SLC/JAK,RMO - Post-Install for TIU*1*134 Cont.;7/8/02@13:15:47
 ;;1.0;TEXT INTEGRATION UTILITIES;**134**;Jun 20, 1997
PRINT ; -- Device Selection
 W !!,"This routine will print ALL records processed to date by the"
 W !,"auto-link routine independent of the date range selected at"
 W !,"processing time."
 W !!,*7,"This report requires a column width of 132.",!
 S %ZIS="Q" D ^%ZIS I POP K POP G PRINTQ
 I $D(IO("Q")) K IO("Q") D  Q
 . S ZTRTN="LIST^TIUP134P"
 . S ZTDESC="TIU*1*134 AUTO-LINK MISSING VISIT TO DOCUMENT RESULTS"
 . D ^%ZTLOAD W !,$S($D(ZTSK):"Request queued",1:"Request Cancelled!")
 . K ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,%ZIS
 . D HOME^%ZIS
 U IO D LIST,^%ZISC
PRINTQ Q
 ;
LIST ; -- Entry point to generate list
 N TIUDA,TIULNK,TIUOUT S TIUOUT=0
 I $D(ZTQUEUED) S ZTREQ="@"
 D HDR
 I +$O(^XTMP("TIUP134","LNK",0))'>0 W !?4,"No records in list." G LISTQ
 S TIUDA=0
 F  S TIUDA=$O(^XTMP("TIUP134","LNK",TIUDA)) Q:'TIUDA!(TIUOUT)  S TIULNK=$G(^(TIUDA)) D LISTONE(TIUDA,TIULNK)
LISTQ Q
 ;
LISTONE(TIUDA,TIULNK) ;Entry point to list one record
 ; Input  -- TIUDA    TIU Document file (#8925) IEN
 ;           TIULNK   1st piece= 1=Linked and 0=Not Linked
 ;                    2nd piece= Exception type if not linked
 ;                    3rd piece= Visit file (#9000010) IEN if linked
 ; Output -- None
 N DFN,TIUEX,VADM,VAIP,VAIN,VA
 I $Y>(IOSL-4) D ASK G LISTONEQ:TIUOUT  D HDR
 S DFN=+$P($G(^TIU(8925,+TIUDA,0)),U,2)
 S TIUEX=+$P($G(TIULNK),U,2)
 D OERR^VADPT
 W !,$E($G(VADM(1)),1,20)_" ("_$G(VA("BID"))_")"
 W ?30,TIUDA
 W ?42,$E($P($G(^TIU(8925.1,+$G(^TIU(8925,+TIUDA,0)),0)),U,1),1,10)
 W ?53,$$DATE^TIULS(+$P($G(^TIU(8925,+TIUDA,13)),U,1),"MM/DD/CCYY HR:MIN")
 I +$G(TIULNK),$P(TIULNK,U,3) D
 . N DA,DIC,DIQ,DR,TIUVISIT
 . S DIC="^AUPNVSIT(",DIQ="TIUVISIT",DIQ(0)="E",DA=+$P(TIULNK,U,3)
 . S DR=".01;.22" D EN^DIQ1
 . W ?70,$E($G(TIUVISIT(9000010,DA,.22,"E")),1,15)
 . W ?86,$G(TIUVISIT(9000010,DA,.01,"E"))
 . W ?109,"Yes-Visit #"_$P(TIULNK,U,3)
 ELSE  D
 . W ?109,"No-"
 . W $S(TIUEX=1:"Multiple Visits",TIUEX=2:"Entry in Use",TIUEX=3:"No Matching Visit",1:"")
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
 W @IOF,"TIU*1*134 AUTO-LINK MISSING VISIT TO DOCUMENT LIST - Printed: ",TIUNOW
 W !,"Patient",?30,"Document #",?42,"Title",?53,"Reference Date",?70,"Visit Location",?86,"Visit Date/Time",?109,"Linked"
 W ! S LNE="",$P(LNE,"-",(IOM-1))="" W LNE
 Q
 ;
MAIL ;Send completion message to user who initiated post-install
 N XMSUB,XMTEXT,XMDUZ,XMY,XMZ,XMMG
 N TIURNG,TIUTXT
 S XMDUZ="PATCH TIU*1*134 AUTO-LINK VISIT TO DOCUMENT",XMY(.5)=""
 S:$G(DUZ) XMY(DUZ)=""
 S TIUTXT(1)="Auto-link missing VISIT field (#.03) in the TIU DOCUMENT file (#8925)"
 S TIUTXT(2)="to an existing visit:"
 S TIUTXT(3)=""
 S TIUTXT(4)="Task Started: "_$$FMTE^XLFDT($G(^XTMP("TIUP134","T0")))
 S TIUTXT(5)="Task   Ended: "_$$FMTE^XLFDT($G(^XTMP("TIUP134","T1")))
 S TIUTXT(6)=""
 ;
 S TIURNG=$$FMTE^XLFDT($P($G(^XTMP("TIUP134","CHKPT")),U,2))_" thru "_$S($G(^XTMP("TIUP134","STOP")):$$FMTE^XLFDT($P($G(^XTMP("TIUP134","CHKPT")),U,1)),1:$$FMTE^XLFDT($P($G(^XTMP("TIUP134","CHKPT")),U,3)))
 S TIUTXT(7)="Date Range Processed: "_TIURNG
 S TIUTXT(8)=""
 S TIUTXT(9)="Number of entries automatically linked: "_+$G(^XTMP("TIUP134","CNT","LNK"))
 S TIUTXT(10)=""
 S TIUTXT(11)="Number of entries NOT automatically linked: "_+$G(^XTMP("TIUP134","CNT","EX"))
 S TIUTXT(12)="  -Number NOT linked because - Multiple Visits: "_+$G(^XTMP("TIUP134","CNT","EX",1))
 S TIUTXT(13)="  -Number NOT linked because - Entry in Use: "_+$G(^XTMP("TIUP134","CNT","EX",2))
 S TIUTXT(14)="  -Number NOT linked because - No Matching Visit: "_+$G(^XTMP("TIUP134","CNT","EX",3))
 S TIUTXT(15)=""
 S TIUTXT(16)="TOTAL Number of entries processed: "_+$G(^XTMP("TIUP134","CNT","TOT"))
 S TIUTXT(17)=""
 I $G(^XTMP("TIUP134","STOP")) D
 . S TIUTXT(18)="Task STOPPED: "_$$FMTE^XLFDT($G(^XTMP("TIUP134","STOP")))_"."
 ELSE  D
 . S TIUTXT(18)="Task COMPLETED successfully."
 . S TIUTXT(19)=""
 . S TIUTXT(20)="To print a detailed listing of ALL records processed invoke D PRINT^TIUP134P."
 S XMTEXT="TIUTXT(",XMSUB="TIU*1*134 Auto-link from "_TIURNG
 D ^XMD
 Q
