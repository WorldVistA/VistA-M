TIUP149P ; SLC/JAK,RMO - Post-Install for TIU*1*149 Cont.;10/30/02@09:27:47
 ;;1.0;TEXT INTEGRATION UTILITIES;**149**;Jun 20, 1997
PRINT ; -- Device Selection
 N EXNDBIF,TIUOUT
 W !!,"This routine will print the results of the clean up routine in patch"
 W !,"TIU*1*149 which provides a clean up for documents pointing to a different"
 W !,"patient's visit in the TIU DOCUMENT file (#8925)."
 ;
 ;If integrated facility, ask about excluding NDBI fix needed records
 I $$CHKINF^TIUP149,$$ASKEX(.TIUOUT) S EXNDBIF=1
 G PRINTQ:$G(TIUOUT)
 ;
 W !!,*7,"This report requires a column width of 132.",!
 S %ZIS="Q" D ^%ZIS I POP K POP G PRINTQ
 I $D(IO("Q")) K IO("Q") D  Q
 . I $G(EXNDBIF) S ZTSAVE("EXNDBIF")=""
 . S ZTRTN="LIST^TIUP149P"
 . S ZTDESC="TIU*1*149 - PRINT CLEAN-UP RESULTS"
 . D ^%ZTLOAD W !,$S($D(ZTSK):"Request queued",1:"Request Cancelled!")
 . K ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,%ZIS
 . D HOME^%ZIS
 U IO D LIST,^%ZISC
PRINTQ Q
 ;
ASKEX(TIUOUT) ;Ask if user would like to exclude NDBI fix needed records
 ; Input  -- None
 ; Output -- 1=Yes and 0=No
 ;           TIUOUT   Timeout or up-arow flag
 N DIR,DTOUT,DUOUT,Y
 S DIR("A")="Do you want to exclude 'NDBI Fix Needed' records from the report"
 S DIR("B")="YES",DIR(0)="Y"
 W ! D ^DIR
 I $D(DTOUT)!($D(DUOUT)) S TIUOUT=1
 Q +$G(Y)
 ;
LIST ; -- Entry point to generate list
 N TIUDA,TIULNK,TIUOUT S TIUOUT=0
 I $D(ZTQUEUED) S ZTREQ="@"
 D HDR
 I +$O(^XTMP("TIUP149","LNK",0))'>0 W !?4,"No records in list." G LISTQ
 S TIUDA=0
 F  S TIUDA=$O(^XTMP("TIUP149","LNK",TIUDA)) Q:'TIUDA!(TIUOUT)  S TIULNK=$G(^(TIUDA)) D LISTONE(TIUDA,TIULNK,$G(EXNDBIF))
LISTQ K EXNDBIF
 Q
 ;
LISTONE(TIUDA,TIULNK,EXNDBIF) ;Entry point to list one record
 ; Input  -- TIUDA    TIU Document file (#8925) IEN
 ;           TIULNK   1st piece= 1=Linked and 0=Not Linked
 ;                    2nd piece= Exception type if not linked
 ;                    3rd piece= Visit file (#9000010) IEN if linked
 ;           EXNDBIF  Exclude "NDBI Fix Needed" records flag  (Optional) 
 ; Output -- None
 N DFN,TIUEX,VADM,VAIP,VAIN,VA
 I $Y>(IOSL-4) D ASK G LISTONEQ:TIUOUT  D HDR
 S DFN=+$P($G(^TIU(8925,+TIUDA,0)),U,2)
 S TIUEX=+$P($G(TIULNK),U,2)
 ;
 ;If exclude NDBI record flag set and NDBI record, exit
 I $G(EXNDBIF),TIUEX=3 G LISTONEQ
 D OERR^VADPT
 W !,$E($G(VADM(1)),1,20)_" ("_$G(VA("BID"))_")"
 W ?30,TIUDA
 W ?42,$E($P($G(^TIU(8925.1,+$G(^TIU(8925,+TIUDA,0)),0)),U,1),1,15)
 I +$G(TIULNK),$P(TIULNK,U,3) D
 . N DA,DIC,DIQ,DR,TIUVISIT
 . S DIC="^AUPNVSIT(",DIQ="TIUVISIT",DIQ(0)="E",DA=+$P(TIULNK,U,3)
 . S DR=".01;.22" D EN^DIQ1
 . W ?60,$G(TIUVISIT(9000010,DA,.01,"E"))
 . W ?84,$E($G(TIUVISIT(9000010,DA,.22,"E")),1,20)
 . W ?106,"Yes - Visit #"_$P(TIULNK,U,3)
 ELSE  D
 . W ?106,"No  - "
 . W $S(TIUEX=1:"Entry in Use",TIUEX=2:"Unlinked Visit",TIUEX=3:"NDBI Fix Needed",1:"")
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
 W @IOF,"TIU*1*149 TIU DOCUMENTS LINKED TO A DIFFERENT PATIENT'S VISIT CLEAN-UP - Printed: ",TIUNOW
 W !,"Patient",?30,"Document #",?42,"Title",?60,"Visit Date/Time",?84,"Hospital Location",?106,"Linked"
 W ! S LNE="",$P(LNE,"-",(IOM-1))="" W LNE
 Q
 ;
MAIL ;Send completion message to user who initiated post-install
 N XMSUB,XMTEXT,XMDUZ,XMY,XMZ,XMMG
 N TIURNG,TIUTXT
 S XMDUZ="PATCH TIU*1*149 TIU DOCUMENT CLEAN-UP RESULTS",XMY(.5)=""
 S:$G(DUZ) XMY(DUZ)=""
 S XMY("G.PATIENT SAFETY NOTIFICATIONS")=""
 S TIUTXT(1)="Clean up TIU Documents linked to a different patient's visit."
 S TIUTXT(2)=""
 S TIUTXT(3)="Task Started: "_$$FMTE^XLFDT($G(^XTMP("TIUP149","T0")))
 S TIUTXT(4)="Task   Ended: "_$$FMTE^XLFDT($G(^XTMP("TIUP149","T1")))
 S TIUTXT(5)=""
 ;
 S TIUTXT(6)="Number of entries linked to Correct Visit: "_+$G(^XTMP("TIUP149","CNT","LNK"))
 S TIUTXT(7)=""
 S TIUTXT(8)="Number of entries not corrected because Entry in Use: "_+$G(^XTMP("TIUP149","CNT","EX",1))
 S TIUTXT(9)=""
 S TIUTXT(10)="Number of entries unlinked from Incorrect Visit: "_+$G(^XTMP("TIUP149","CNT","EX",2))
 S TIUTXT(11)=""
 S TIUTXT(12)="TOTAL Number of entries processed: "_+$G(^XTMP("TIUP149","CNT","TOT"))
 S TIUTXT(13)=""
 I $G(^XTMP("TIUP149","STOP")) D
 . S TIUTXT(14)="Task STOPPED: "_$$FMTE^XLFDT($G(^XTMP("TIUP149","STOP")))_"."
 ELSE  D
 . S TIUTXT(14)="Task COMPLETED successfully."
 . S TIUTXT(15)=""
 . S TIUTXT(16)="To print a detailed listing of the clean up invoke D PRINT^TIUP149P."
 ;
 I $G(NDBIF) D
 . S TIUTXT(17)=""
 . S TIUTXT(18)="SPECIAL NOTE FOR INTEGRATED FACILITIES:"
 . S TIUTXT(19)=""
 . S TIUTXT(20)="- Number of entries not corrected because NDBI Fix Needed: "_+$G(^XTMP("TIUP149","CNT","EX",3))
 S XMTEXT="TIUTXT(",XMSUB="TIU*1*149 TIU Document Clean up for Different Patient's Visit"
 D ^XMD
 Q
