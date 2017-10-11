RCTCSPD0 ;ALBANY/RGB-CROSS-SERVICING TRANSMISSION START ;06/15/17 3:34 PM
 ;;4.5;Accounts Receivable;**327**;Mar 20, 1995;Build 7
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;PRCA*4.5*327 new setup/finish extraction from RCTCSPD and
 ;             modify XTMP file kill to work correctly for
 ;             5 days after Tuesday run.
 ;             Also, send mail message to 'TCSP' mailgroup
 ;             to report any missing/corrupted debtor entries.
 ;
SETUP ;Entry point from nightly process PRCABJ
 ;
 ;initialize temporary global, variables
 ;
 K ^TMP("RCTCSPD",$J)
 K ^XTMP("RCTCSPD",$J)
 K ^XTMP("RCTCSPDN",$J)
 S ^XTMP("RCTCSPD",$J,0)=$$FMADD^XLFDT(DT,5)_"^"_DT
 S ^XTMP("RCTCSPDN",$J,0)=$$FMADD^XLFDT(DT,5)_"^"_DT
RESTART D NOW^%DTC S ^XTMP("RCTCSPD",$J,"ZZASTART")=%
 S SITE=$E($$SITE^RCMSITE(),1,3),SITECD=$P(^RC(342,1,3),U,5)
 S ACTDT=3150801 ;activation date for all sites except beckley, little rock, upstate ny 
 S:SITE=598 ACTDT=3150201 ;activation date for little rock
 S:SITE=517 ACTDT=3150201 ;activation date for beckley
 S:SITE=528 ACTDT=3150201 ;activation date for upstate ny
 S X1=DT,X2=-150 D C^%DTC S P150DT=X
 S X1=DT,X2=+60 D C^%DTC S F60DT=X
 S (CNTR(1),CNTR(2),CNTR("2A"),CNTR("2C"),CNTR(3),CNTR("5A"),CNTR("5B"))=0
 Q
FINISH ;sends mailman message to TCSP mail group to show batch fully completed
 I $D(^XTMP("RCTCSPD",$J,"ZZUNDEF")) D UNDEF
 N XMY,XMDUZ,XMSUB,XMTEXT,BMSG
 S XMDUZ="AR PACKAGE"
 S XMY("G.TCSP")=""
 S XMSUB="*** Batch Completion Notice ***"
 S BMSG(1)="The batch run and transmission completed on "_(17000000+^XTMP("RCTCSPD",$J,"ZZHCOMPLETE"))
 S XMTEXT="BMSG("
 D ^XMD
 K ^TMP("RCTCSPD",$J)
 Q
UNDEF ;send message to mail group for any undefined debtor entries found
 N XMY,XMDUZ,XMSUB,XMTEXT,BMSG,IEN,CTR
 S XMDUZ="AR PACKAGE"
 S XMY("G.TCSP")=""
 S XMSUB="**** FAILED DEBTOR ACTION NOTICE ***"
 S BMSG(1)="The following corrupted debtor records were found during the batch run."
 S BMSG(2)="They can be found in xref ^PRCA(430,_""C""_) and have no file 340 entry or a"
 S BMSG(3)="corrupted entry (missing node 0 or 1)."
 s BMSG(4)=" "
 S BMSG(97)=" "
 S BMSG(98)="*** These corrupt debtor file records must be reported to ***"
 S BMSG(99)="*** region IT staff to be corrected immediately !!        ***"
 S IEN=0,CTR=4 F  S IEN=$O(^XTMP("RCTCSPD",$J,"ZZUNDEF",IEN)) Q:'IEN  D
 . S CTR=CTR+1,BMSG(CTR)="CORRUPT DEBTOR INTERNAL: "_IEN
 S XMTEXT="BMSG("
 D ^XMD
 Q
