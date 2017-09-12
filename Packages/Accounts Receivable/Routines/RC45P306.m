RC45P306 ;OAK/ELZ-POST-INSTALL PRCA*4.5*306 ROLLBACK DEPOSIT ;14-SEP-08
 ;;4.5;Accounts Receivable;**306**;Mar 20, 1995;Build 3
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;
POST ;This will find and backout a deposit that needs to be reversed
 ; the deposit ticket number is 16822 + 3 digit station number
 ; - explain job
 ;
 D BMES^XPDUTL(" Post-install for PRCA*4.5*306 Starting.")
 ;
 N RCDPOSIT,RCDPDT,RCDTOP,RCRCPT,RCDATA0,RCMSG,RCMSGC
 S RCMSGC=0
 S RCDPOSIT=16822_(+$P($$SITE^VASITE,"^",3))
 ;
 ; look up deposit
 S RCDPDT=$O(^RCY(344.1,"B",RCDPOSIT,0))
 I 'RCDPDT D  Q
 . D BMES^XPDUTL("  - Unable to find deposit "_RCDPOSIT_".")
 . D BMES^XPDUTL(" Nothing done, quitting post-install")
 ;
 ; display deposit found.
 D BMES^XPDUTL("  - Found deposit ticket "_RCDPOSIT_" **REVERSING**")
 S RCRCPT=0 F  S RCRCPT=$O(^RCY(344,"AD",RCDPDT,RCRCPT))  Q:'RCRCPT  D
 . S RCDATA0=$G(^RCY(344,RCRCPT,0))
 . S RCDTOP=$P(RCDATA0,"^",3)
 . I 'RCDTOP D   Q
 .. D BMES^XPDUTL("  - AR Batch Payment "_$P(RCDATA0,"^")_"has no date opened!")
 .. D BMES^XPDUTL("  CANNOT PROCESS IT FURTHER!")
 . S RCDTOP($P(RCDATA0,"^",3))=""
 . S RCMSGC=RCMSGC+1,RCMSG(RCMSGC)="  - Date Opened "_$$FMTE^XLFDT(RCDTOP)_" with "_$P($G(^RCY(344,RCRCPT,1,0)),"^",4)_" transactions"
 D BMES^XPDUTL(.RCMSG) K RCMSG
 ;
 ; call to roll back the deposit
 D BMES^XPDUTL("  - Rolling back deposit(s)...")
 S RCDTOP=0 F  S RCDTOP=$O(RCDTOP(RCDTOP)) Q:'RCDTOP  D REVERSE^RCDPXFIX(RCDPOSIT,RCDTOP)
 S RCMSG(1)="  - All done, the members of RCDP PAYMENTS will receive"
 S RCMSG(2)="    MailMan message(s) of the results."
 D BMES^XPDUTL(.RCMSG)
 ;
 D BMES^XPDUTL(" Post-install for PRCA*4.5*306 Complete.")
 ;
 Q
 ;
