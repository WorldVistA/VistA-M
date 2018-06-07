PRCA315P ;SLT/BAA-PRCA*4.5*315 POST INSTALL ;1 Mar 97
 ;;4.5;Accounts Receivable;**315**;Mar 20, 1995;Build 67
 ;;Per VA Directive 6402, this routine should not be modified.
POSTINIT ;
 ;
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine ...")
 D MES^XPDUTL(" ")
 ; AR CATEGORIES
 D ARCAT
 D REVSC
 D DELOPT
 D CRSSVC
 D CSJOB
 D MES^XPDUTL(" >>  End of the Post-Initialization routine ...")
 Q
 ;
 ;
ARCAT ;AR CATEGORY ENTRIES (430.2)
 N %,ARNAME,D,D0,DA,DI,DIC,DIE,DIK,DINUM,DLAYGO,DQ,DR,RCDATA,RCDINUM,X,Y,FLG,RCS
 D MES^XPDUTL("     -> Adding new ACCOUNTS RECEIVABLE CATEGORY file (#430.2) entries ...")
 ;
 ;  install entries in file 430.2
 S FLG=0
 F RCDINUM=46,47 D
 . S RCS="CT"_RCDINUM
 . S RCDATA=$P($T(@RCS),";",3,99)
 . S (DIC,DIE)="^PRCA(430.2,",DIC(0)="L",DLAYGO=430.2
 . ;
 . S ARNAME=$P(RCDATA,";")
 . ;
 . I $D(^PRCA(430.2,RCDINUM,0)) S DIK="^PRCA(430.2,",DA=RCDINUM D ^DIK
 . ;
 . S (DIC,DIE)="^PRCA(430.2,",DIC(0)="L",DLAYGO=430.2
 . ;
 . ;  set the fields
 . S (DINUM,DA)=RCDINUM,X=ARNAME
 . S DIC("DR")="1///"_$P(RCDATA,";",2)_";2///"_$P(RCDATA,";",3)_";3///"_$P(RCDATA,";",6)_";5///"_$P(RCDATA,";",5)_";6///"_$P(RCDATA,";",4)
 . S DIC("DR")=DIC("DR")_";7///2;9///0;10///0;11///0;12///"_$P(RCDATA,";",7)_";13///2;"
 . ;  add entry
 . S X=ARNAME D FILE^DICN K DIC I Y<1 K X,Y Q
 . D MES^XPDUTL("        New Category "_ARNAME_" added") S FLG=1
 ;
 I FLG D MES^XPDUTL("        New ACCOUNTS RECEIVABLE CATEGORY file (#430.2) entries added")
 D MES^XPDUTL("  ")
 Q
 ;
 ;
REVSC ;REVENUE SOURCE CODE entries in file #347.3
 N I,RSCDATA,DIC,Y,GBL,DA,X,DIE,DR
 D MES^XPDUTL("     -> Adding new REVENUE SOURCE CODE file (#347.3) entries ...")
 S GBL="^RC(347.3,"
 F I=1:1 D  Q:RSCDATA="END"
 . S RSCDATA=$P($T(NEWRSC+I),";",3,99)
 . Q:RSCDATA="END"
 . ; do a lookup and continue if exists.
 . S DIC=GBL,X=$P(RSCDATA,";") D ^DIC
 . I +Y>0 S DIK=GBL,DA=+Y D ^DIK
 . ; add entry
 . S X=$P(RSCDATA,";")
 . S DIC("DR")=".02///"_$P(RSCDATA,";",2)_";",DIC(0)="L"
 . S DIC("DR")=DIC("DR")_".03///0;"
 . D FILE^DICN
 . I +Y=-1 D
 . . D MES^XPDUTL("        "_$P(RSCDATA,";")_" failed to add!")
 D MES^XPDUTL("        New REVENUE SOURCE CODE file (#347.3) entries added")
 Q
 ;
 ;
DELOPT ; remove PRCAC SET REPAYMENT option
 N DA,DIK,MEN,OPT,RET
 ; RET - value returned from
 S MEN="PRCAC REPAYMENT MENU"
 S DA(1)=+$$LKOPT^XPDMENU(MEN)
 S OPT="PRCAC SET REPAYMENT"
 D BMES^XPDUTL("     -> Updating ["_MEN_"]")
 S RET=$$DELETE^XPDMENU(MEN,OPT)  ; delete option from menu
 S DA=+$$LKOPT^XPDMENU(OPT)  ; get option IEN
 I DA>0 S DIK="^DIC(19," D ^DIK  ; code can be re-run if already deleted
 D MES^XPDUTL("        Menu update "_$S(RET:"completed.",1:"not needed."))
 S OPT="PRCAC ENTER EDIT REPAYMENT"
 S DA=+$$LKOPT^XPDMENU(OPT)  ; get option IEN
 I $D(^DIC(19,DA(1),10,"B",DA)) Q  ; Option already added
 D ADD^XPDMENU(MEN,OPT,"",1) ; Set Enter/Edit Repayment as the first item in Repayment Menu
 Q
 ;
CRSSVC ;Cross-servicing - Replace (renamed) menu options - RCTCSP RECONCILIATION WORKLIST, RCTCSP RECONCIL REPORT options to menu - Cross-Servicing Menu [RCTCSP MENU]
 N DA,DIK,MEN,OPT,RET
 ; RET - value returned from
 S MEN="RCTCSP MENU"
 S DA(1)=+$$LKOPT^XPDMENU(MEN)
 D BMES^XPDUTL("     -> Updating ["_MEN_"]")
 F OPT="RCTCSP RECONCILIATION WORKLIST","RCTCSP RECONCIL REPORT" D
 . K RET S RET=$$DELETE^XPDMENU(MEN,OPT)  ; delete option from menu
 . S DA=+$$LKOPT^XPDMENU(OPT)  ; get option IEN
 . D MES^XPDUTL("        Menu update to option:  "_OPT_"  "_$S(RET:"completed.",1:"not needed."))
 . I $D(^DIC(19,DA(1),10,"B",DA)) Q  ; Option already added
 . D ADD^XPDMENU(MEN,OPT,"")
 Q
 ;
CSJOB ;Job the process to build the new Cross-Servicing data fields.
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSK
 ;
 D BMES^XPDUTL("     -> Queuing background job to do the following:")
 D MES^XPDUTL("        1. Populate Cross-Servicing indices in ACCOUNTS RECEIVABLE file (#430)")
 D MES^XPDUTL("        2. Searching ACCOUNTS RECEIVABLE file (#430) for CS Stops placed")
 D MES^XPDUTL("           prior to this patch in field STOP TCSP REFERRAL FLAG (#157).")
 D MES^XPDUTL("        3. Populate new field ORIGINAL DATE REFERRED TO TCSP (#156) in ACCOUNTS")
 D MES^XPDUTL("           RECEIVABLE file (#430).")
 D MES^XPDUTL(" ")
 ;
 ; Setup required variables
 S ZTRTN="CSJOB1^PRCA315P",ZTIO="",ZTDTH=$H
 S ZTDESC="Background job to build CS indices for PRCA*4.5*315"
 ;
 ; Task the job
 D ^%ZTLOAD
 ;
 ; Check if task was created
 I $D(ZTSK) D MES^XPDUTL("        Task #"_ZTSK_" queued.")
 I '$D(ZTSK) D MES^XPDUTL("        Task not queued.  Please create a support ticket.")
 D MES^XPDUTL("  ")
 Q
 ;
CSJOB1 ;Populate new indices in #430
 K ^TMP($J)
 S DIK="^PRCA(430,",DIK(1)="172" D ENALL^DIK
 S ^TMP($J,"PRCA315P",1)="FILE #430 FIELD #172 INDEX POPULATED"
 S DIK="^PRCA(430,",DIK(1)="301" D ENALL^DIK
 S ^TMP($J,"PRCA315P",2)="FILE #430 FIELD #301 INDEX POPULATED"
 ;
CSSTOP ;determine CS stops placed in 430 prior to Patch 315
 N RCIEN,DEBTOR,BILL,CSDATE,LIST,MSG,GLO
 N DIFROM,XMDUN,XMY,XMZ ;  need to be newed or mailman will not deliver the message
 S GLO=$NA(^TMP($J,"RCRJRCORMM"))
 ;
 S @GLO@(1)="Bills currently flagged to stop TCSP referral activity prior"
 S @GLO@(2)="to PRCA*4.5*315. These bills will not show on the new report:"
 S @GLO@(3)="'Cross-Servicing Stop Reactivate Report'."
 S @GLO@(4)="  "
 S RCIEN=0 F  S RCIEN=$O(^PRCA(430,RCIEN)) Q:'RCIEN  D
 . K LIST
 . I $P($G(^PRCA(430,RCIEN,15)),U,7) D
 .. D GETS^DIQ(430,RCIEN_",",".01;9;158","IE","LIST","MSG")
 .. S BILL=$G(LIST(430,RCIEN_",",.01,"E")),DEBTOR=$G(LIST(430,RCIEN_",",9,"E")),CSDATE=$G(LIST(430,RCIEN_",",158,"E"))
 .. S @GLO@(RCIEN)=BILL_U_DEBTOR_U_CSDATE
 . ;Load date into field #156, ORIGINAL DATE REFERRED TO TCSP
 . I $G(^PRCA(439,RCIEN,21)) Q
 . D GETS^DIQ(430,RCIEN_",","151;153;158","I","LIST","MSG")
 . F I=151,153,158 I LIST(430,RCIEN_",",I,"I")?7N S ^PRCA(430,RCIEN,21)=LIST(430,RCIEN_",",I,"I") Q
 S ^TMP($J,"PRCA315P",3)="BILLS CURRENTLY FLAGGED TO STOP TCSP REPORT CREATED"
 S ^TMP($J,"PRCA315P",4)="FILE #430 FIELD #156 VALUES POPULATED"
 S XMDUZ=.5,XMY(.5)="",XMY(DUZ)="",XMY("G.TCSP")=""
 S XMZ=$$SENDMSG^RCRJRCOR("STOP TCSP REFERRAL's existing before PRCA*4.5*315",.XMY)
 K ^TMP($J,"RCRJRCORMM")
 S ^TMP($J,"PRCA315P",5)="BILLS CURRENTLY FLAGGED TO STOP TCSP REPORT MAIL SENT"
 ;
 N CNT,MSG,XMY,XMDUZ,DIFROM,XMSUB,XMTEXT
 S XMY(DUZ)=""
 S XMSUB="PRCA*4.5*315 Post install routine has completed",XMDUZ="Patch PRCA*4.5*315"
 S XMTEXT="^TMP($J,""PRCA315P"","
 D ^XMD
 Q
 ;
 ;Revenue Source Codes (RSC#)//
NEWRSC ;SOURCE CODE;NAME
 ;;8VZZ;HUMAN 3RD-PRTY OUTPATIENT
 ;;8UZZ;HUMAN 3RD-PRTY INPATIENT
 ;;841Z;INELI 3RD-PARTY INPATIENT
 ;;842Z;INELI 3RD-PARTY OUTPATIENT 
 ;;END
 ;
 ;
 ;;ACCOUNTS RECEIVABLE CATEGORY FILE (#430.2)
 ;;.01 CATEGORY;1 ABBREVIATION;6 CATEGORY NUMBER;7 ACCRUED
CT46 ;;EMERGENCY/HUMANITARIAN REIMB.;HR;252;48;T;1213;1
CT47 ;;INELIGIBLE HOSP. REIMB.;IR;251;49;T;1213;0
