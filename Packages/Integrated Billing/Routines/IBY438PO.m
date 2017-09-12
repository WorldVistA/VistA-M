IBY438PO ;BP/YMG - Post Install for IB patch 438 ;27-Aug-2010
 ;;2.0;INTEGRATED BILLING;**438**;21-MAR-94;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; eIV Phase 3 Iteration 2 post-install
 ;
EN ; entry point
 N XPDIDTOT
 S XPDIDTOT=5
 D CLEARDUP(1)  ; 1. Clear duplicate entries in dictionary files
 D RMSG(2)      ; 2. Send site registration message to FSC
 D SCHED(3)     ; 3. Schedule unlinked payers notification
 D STC(4)       ; 4. Set-up Service Type Codes
 D PARM(5)      ; 5. Set eIV site parameters
 ;
EX ; exit point
 Q
 ;
CLEARDUP(IBXPD) ; clear duplicate entries in dictionary files
 N CODE,FILE,NESDESC,NEWIEN,OLDIEN
 N DA,DIE,DIK,DR,X,Y
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Cleaning dictionary files ... ")
 F FILE=365.011:.001:365.028 D
 .I '$D(^DIC(FILE)) Q
 .S CODE="" F  S CODE=$O(^IBE(FILE,"B",CODE)) Q:CODE=""  D
 ..S OLDIEN=$O(^IBE(FILE,"B",CODE,"")),NEWIEN=$O(^IBE(FILE,"B",CODE,""),-1)
 ..I OLDIEN=NEWIEN Q  ; only one entry, no duplicates
 ..; replace description in the old entry
 ..S NEWDESC=$P($G(^IBE(FILE,NEWIEN,0)),U,2) I NEWDESC="" Q
 ..S DIE=FILE,DA=OLDIEN,DR=".02///"_NEWDESC D ^DIE
 ..; delete duplicate entry
 ..S DA=NEWIEN,DIK="^IBE("_FILE_"," D ^DIK
 ..Q
 .Q
 ; remove duplicate entry in file 353.1
 S OLDIEN=+$O(^IBE(353.1,"B",99,""))
 S NEWIEN=+$O(^IBE(353.1,"B",99,""),-1)
 I NEWIEN,NEWIEN'=OLDIEN S DA=NEWIEN,DIK="^IBE(353.1," D ^DIK
 ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(IBXPD)
 Q
 ;
RMSG(IBXPD) ; send site registration message to FSC
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Sending site registration message to FSC ... ")
 I '$$PROD^XUPROD(1) D MES^XPDUTL(" N/A - not a production account") G RMSGX  ; only sent reg. message from production account
 D ^IBCNEHLM
 D MES^XPDUTL(" Done.")
RMSGX ;
 D UPDATE^XPDID(IBXPD)
 Q
 ;
SCHED(IBXPD) ; schedule unlinked payers notification
 N DIC,DLAYGO,TSTAMP,X,Y
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Scheduling unlinked payers notification ... ")
 I '$$PROD^XUPROD(1) D MES^XPDUTL(" N/A - not a production account") G SCHEDX  ; only schedule in production account
 I $$FIND1^DIC(19.2,,"B","IBCNE EIV PAYER LINK NOTIFY","B") D MES^XPDUTL(" Already scheduled") G SCHEDX  ; don't overwrite existing schedule
 S (DLAYGO,DIC)=19.2,DIC(0)="L"
 S X="IBCNE EIV PAYER LINK NOTIFY"
 S TSTAMP=$$FMADD^XLFDT($$NOW^XLFDT(),1),$P(TSTAMP,".",2)="0500"
 S DIC("DR")="2////"_TSTAMP_";6////7D"
 D ^DIC
 D MES^XPDUTL(" Done.")
SCHEDX ;
 D UPDATE^XPDID(IBXPD)
 Q
 ;
STC(IBXPD) ;Set-up Service Type Codes for eIV
 N DIE,DA,DR,X,Y
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Setting Default Service Type Codes ... ")
 ; Set Default Service Type Codes
 S DIE=350.9,DA=1
 S DR="60.01///1;60.02///7;60.03///30;60.04///47;60.05///54;60.06///62;60.07///75;60.08///88;60.09///97;60.1///98;60.11///MH"
 D ^DIE
 D MES^XPDUTL(" Done.")
STCX ;
 D UPDATE^XPDID(IBXPD)
 Q
 ;
PARM(IBXPD) ; set eIV site parameters for non-verified extract
 N DA,DIK,DONE,IEN,TYPE
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Setting eIV Site Parameters ... ")
 S (DONE,IEN)=0
 F  S IEN=$O(^IBE(350.9,1,51.17,IEN)) Q:'IEN!DONE  I +$P($G(^IBE(350.9,1,51.17,IEN,0)),U)=3 S DONE=1
 I IEN S DA=IEN,DA(1)=1,DIK="^IBE(350.9,1,51.17," D ^DIK
 ;
PARMX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(IBXPD)
 Q
