DG53742 ;ALB/TMK - DG*5.3*764 (formerly 742) Cleanup OEF/OIF site info; 01/10/2007
 ;;5.3;Registration;**764**;Aug 13,1993;Build 16
 ;
POST ; This routine was previously part of patch DG*5.3*742, now in *764
 N ZTRTN,ZTDESC,ZTSAVE,ZTIO,ZTSK,ZTDTH
 D BMES^XPDUTL("Queue-ing the job to correct OEF/OIF site info...")
 K ^XTMP($$NAMSPC)
 S ZTRTN="RUN^DG53742",ZTDESC="Correct OEF/OIF site info"
 S ZTIO="",ZTDTH=$$NOW^XLFDT D ^%ZTLOAD
 D BMES^XPDUTL("This request queued as Task # "_$G(ZTSK))
 D BMES^XPDUTL("=====================================================")
 D BMES^XPDUTL("")
 Q
EP ; Queue the conversion
 N %
 S %=$$NEWCP^XPDUTL("POST","POST^DG53742")
 S %=$$NEWCP^XPDUTL("EVC1","EVC1^DG53742")
 S %=$$NEWCP^XPDUTL("END","END^DG53742") ; Leave as last update
 Q
 ;
EVC1 ; Update the USE FOR Z07 CHECK field #6
 ; in the INCONSISTENT DATA ELEMENTS file #38.6 for CC 718
 N RULE,DA,DIE,DR,X,Y
 S RULE=718
 D BMES^XPDUTL("Modifying entry #"_RULE_" in 38.6 file.")
 S DIE=38.6,DA=$$FIND1^DIC(DIE,"","X",RULE)
 I 'DA D  Q
 .D MES^XPDUTL("    *** Entry not found! Nothing Updated!! ***") Q
 S DR="6////0" D ^DIE
 D MES^XPDUTL("    *** Update Complete ***")
 D BMES^XPDUTL("")
 Q
 ;
END ; Post-install done
 D BMES^XPDUTL("Post install complete.")
 Q
 ;
RUN ; 'Live' entry point from taskman
 N NAMSPC
 S NAMSPC=$$NAMSPC
 D QUE(NAMSPC,0)
 Q
 ;
TEST ;entry point for test mode
 N NAMSPC
 S NAMSPC=$$NAMSPC_"_TEST"
 D QUE(NAMSPC,1)
 Q
 ;
QUE(NAMSPC,TESTING) ;
 N ZTSTOP,DGX,X,Y
 S TESTING=+$G(TESTING)
 D SETUPX(NAMSPC,90)
 S DGX=$G(^XTMP(NAMSPC,0,0))
 I $P(DGX,U,6)="COMPLETED" D MAIL(NAMSPC,TESTING) Q
 S $P(DGX,U,6)="RUNNING"
 S $P(DGX,U,7)=$$NOW^XLFDT
 S ^XTMP(NAMSPC,0,0)=DGX
 ;
 S X=$$LOOP(NAMSPC,TESTING),ZTSTOP=$P(X,U,2)
 S X=$G(^XTMP(NAMSPC,0,0))
 S $P(X,U,6)=$S(ZTSTOP:"STOPPED",1:"COMPLETED")
 S $P(X,U,8)=$$NOW^XLFDT
 S ^XTMP(NAMSPC,0,0)=X
 ;
 D MAIL(NAMSPC,TESTING)
 Q
 ;
SETUPX(NAMSPC,EXPDAYS) ;
 ; requires EXPDAYS - # days to keep XTMP around
 N BEGTIME,PURGDT
 S NAMSPC=$$NAMSPC
 S BEGTIME=$$NOW^XLFDT()
 S PURGDT=$$FMADD^XLFDT(BEGTIME,EXPDAYS)
 S ^XTMP(NAMSPC,0)=PURGDT_U_BEGTIME
 S $P(^XTMP(NAMSPC,0),U,3)="Correct OEF/OIF site info"
 Q
 ;
LOOP(NAMSPC,TESTING) ;
 ;returns 0^stop flag
 N X,XREC,LASTREC,TOTREC,TOTPAT
 S LASTREC="",ZTSTOP=0
 S TOTREC=0
 I $D(^XTMP(NAMSPC,0,0)) D
 . S XREC=$G(^XTMP(NAMSPC,0,0))
 . ;last xref entry processed
 . S LASTREC=$P(XREC,U,1)
 . ;total records read
 . S TOTREC=+$P(XREC,U,2)
 . ; total OEIF records updated
 . S TOTPAT=+$P(XREC,U,10)
 . Q
 D OEIF(NAMSPC,TESTING,LASTREC)
 Q 0_"^"_ZTSTOP
 ;
OEIF(NAMSPC,TESTING,LASTREC) ;
 N GBL,DFN,OEIF,SITE,X,Y,Z,DIE,DR,DA
 S ZTSTOP=0
 S GBL="^DPT(""ALOEIF"""
 I $TR(LASTREC,";")'="" D
 . F Z=1:1:5 Q:$P(LASTREC,";",Z)=""  S:Z=1 GBL=GBL_"," S GBL=GBL_""""_$P(LASTREC,";",Z)_""""_$S($P(LASTREC,";",Z+1)'="":",",1:"")
 S GBL=GBL_")"
 F  S GBL=$Q(@GBL) Q:GBL=""!($QS(GBL,1)'="ALOEIF")!ZTSTOP  S DFN=$QS(GBL,5) I DFN D
 . S OEIF=0 F  S OEIF=$O(^DPT(DFN,.3215,OEIF)) Q:'OEIF  S SITE=$P($G(^(OEIF,0)),U,6) I SITE,+SITE'=SITE S SITE=+$O(^DIC(4,"D",SITE,0)) I SITE D
 .. S DR=".06////"_SITE,DA(1)=DFN,DA=OEIF,DIE="^DPT("_DA(1)_",.3215," D:'TESTING ^DIE S TOTPAT=TOTPAT+1
 . S ZTSTOP=$$CHKR(NAMSPC,TESTING,GBL,TOTPAT,.TOTREC)
 Q
 ;
CHKR(NAMSPC,TESTING,GBL,TOTPAT,TOTREC) ;
 N X,Z,ZTSTOP
 S ZTSTOP=0
 F Z=2:1:6 S LASTREC=$QS(GBL,Z)_";"
 S TOTREC=TOTREC+1
 D UPDATEX(NAMSPC,TOTREC,LASTREC,TOTPAT)
 I '(TOTREC#500) S ZTSTOP=$$STOP(NAMSPC)
 Q ZTSTOP
 ;
UPDATEX(NAMSPC,TOTREC,LASTREC,TOTPAT) ;
 N X
 S X=$G(^XTMP(NAMSPC,0,0))
 S $P(X,U,1)=$G(LASTREC),$P(X,U,2)=$G(TOTREC)
 S $P(X,U,10)=$G(TOTPAT)
 S ^XTMP(NAMSPC,0,0)=X
 Q
 ;
STATUS ;display status of current run
 N DIR,X,Y,DTOUT,DUOUT,NAMSPC
 S DIR(0)="SA^T:TEST;L:LIVE",DIR("A")="(T)EST OR (L)IVE?: ",DIR("B")="LIVE"
 D ^DIR K DIR
 Q:$D(DTOUT)!$D(DUOUT)
 S NAMSPC=$$NAMSPC_$S(Y="L":"",1:"_TEST")
 I Y'="L" W !,"TEST TEST TEST TEST TEST TEST",!
 S X=$G(^XTMP(NAMSPC,0,0))
 I X="" W !!,"Task not started!!!" Q
 W !!," Current status: ",$P(X,U,6)
 W !,"  Starting time: ",$$FMTE^XLFDT($P(X,U,7))
 I $P(X,U,8) W !,"    Ending time: ",$$FMTE^XLFDT($P(X,U,8))
 W !!,"      Total patient records read: ",$P(X,U,2)
 W !,"    Last patient record processed: ",$P(X,U,1)
 W !,"    Total OEF/OIF records changed: ",$P(X,U,10)
 Q
 ;
STOP(NAMSPC) ; returns stop flag
 N ZTSTOP,X
 S ZTSTOP=0
 I $$S^%ZTLOAD S ZTSTOP=1
 I $D(^XTMP(NAMSPC,"STOP")) S ZTSTOP=1 K ^XTMP(NAMSPC,"STOP")
 I ZTSTOP D
 . S X=$G(^XTMP(NAMSPC,0,0))
 . S $P(X,U,6)="STOPPED",$P(X,U,7)=$$NOW^XLFDT
 . S ^XTMP(NAMSPC,0,0)=X
 . Q
 Q ZTSTOP
 ;
NAMSPC() ;
 Q $T(+0)
 ;
MAIL(NAMSPC,TESTING) ; mail stats
 N MSGNO,TOTREC,TOTPAT,STAT,STIME,ETIME,LIN,HTEXT,X
 S X=$G(^XTMP(NAMSPC,0,0))
 S TOTREC=$P(X,U,2)
 S STAT=$P(X,U,6),STIME=$P(X,U,7)
 S ETIME=$P(X,U,8)
 S TOTPAT=$P(X,U,10)
 ;
 D HDNG(NAMSPC,.HTEXT,.LIN,STAT,STIME,ETIME,TESTING)
 D SUMRY(.LIN,TOTREC,TOTPAT)
 D MAILIT(HTEXT,NAMSPC)
 K ^TMP(NAMSPC,$J,"MSG")
 Q
 ;
HDNG(NAMSPC,HTEXT,LIN,STAT,STIME,ETIME,TESTING) ; build heading lines
 N X,Y,TEXT
 K ^TMP(NAMSPC,$J,"MSG")
 S LIN=0
 S HTEXT="Correct OEF/OIF site info "_STAT_" on "
 S HTEXT=HTEXT_$$FMTE^XLFDT(ETIME)
 D BLDLINE(NAMSPC,HTEXT,.LIN)
 D BLDLINE(NAMSPC,"",.LIN)
 I TESTING D
 . S TEXT="** TESTING - NO CHANGES TO DATABASE EXECUTED **"
 . D BLDLINE(NAMSPC,TEXT,.LIN)
 D BLDLINE(NAMSPC,"",.LIN)
 Q
 ;
SUMRY(LIN,TOTREC,TOTPAT) ; build summary lines
 N TEXT
 S TEXT="      Total Patient Records Read: "_$J($FN(TOTREC,","),11)
 D BLDLINE(NAMSPC,TEXT,.LIN)
 S TEXT="   Total OEF/OIF Records Changed: "_$J($FN(TOTPAT,","),11)
 D BLDLINE(NAMSPC,TEXT,.LIN)
 Q
 ;
BLDLINE(NAMSPC,TEXT,LIN) ;build a single line in TMP msg global
 S LIN=LIN+1
 S ^TMP(NAMSPC,$J,"MSG",LIN)=TEXT
 Q
 ;
MAILIT(HTEXT,NAMSPC) ; send the msg
 N XMY,XMDUZ,XMSUB,XMTEXT
 S XMY(DUZ)="",XMDUZ=.5
 S XMY("G.DGEN ELIGIBILITY ALERT")=""
 S XMSUB=HTEXT
 S XMTEXT="^TMP(NAMSPC,$J,""MSG"","
 D ^XMD
 Q
 ;
