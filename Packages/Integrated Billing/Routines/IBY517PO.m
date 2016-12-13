IBY517PO ;ALB/FA - Post-Install for IB patch 517 ;03-JUN-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; Entry point
 N IBXPD,IBPRD,XPDIDTOT
 S XPDIDTOT=6
 ;
 ; Determine if we're in a TEST or a PRODUCTION environment.
 S IBPRD=$S($$PROD^XUPROD(1)=1:"P",1:"T")
 ;
 ; Set the defaults for the new Health Care Services Review Section of the
 ; Claims Tracking site parameters
 D SETPARMS(1)
 D SETFSC(2,IBPRD)
 D SETNTJB(3,IBPRD)
 D CLEARDUP(4)
 D REINDEX(5)
 D DISPROT(6)
 D DONE
 Q
 ;
SETPARMS(IBXPD) ; Set the defaults for the new Health Care Services
 ; Review Section of the Claims Tracking site parameters
 ; Input:   IBXPD       - Post-Installation step being performed
 ;          XPDIDTOT    - Total Number of Post-Installation steps to perform
 ; Output:  Health Care Services Review site parameter defaults are set
 N IEN,SDATA
 S IEN="1,"
 D BMES^XPDUTL("STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-----------")
 D MES^XPDUTL("  Sets HCS Review Site Parameter Defaults ... ")
 ;
 ; Set fields 62.01 - 62.08
 S SDATA(350.9,IEN,62.13)=30        ; CPAC APPT FUTURE DAYS default
 S SDATA(350.9,IEN,62.02)=30        ; CPAC ADM FUTURE DAYS default
 S SDATA(350.9,IEN,62.03)=14        ; CPAC APPT PAST DAYS default
 S SDATA(350.9,IEN,62.04)=14        ; CPAC ADM PAST DAYS default
 S SDATA(350.9,IEN,62.05)=30        ; TRICARE APPT FUTURE DAYS default
 S SDATA(350.9,IEN,62.06)=30        ; TRICARE ADM FUTURE DAYS default
 S SDATA(350.9,IEN,62.07)=14        ; TRICARE APPT PAST DAYS default
 S SDATA(350.9,IEN,62.08)=14        ; TRICARE ADM PAST DAYS default
 S SDATA(350.9,IEN,62.09)=2555      ; PURGE DAYS Default
 S SDATA(350.9,IEN,62.10)=0         ; INQUIRY TRIGGER APPT default
 S SDATA(350.9,IEN,62.11)=0         ; INQUIRY TRIGGER ADM Default
 S SDATA(350.9,IEN,62.12)=20        ; HSCR RESPONSE PURGE DAYS Default
 D FILE^DIE(,"SDATA")
 D MES^XPDUTL("  HCS default site parameters have been updated successfully.")
 D MES^XPDUTL("STEP 1: Done.")
 D MES^XPDUTL("")
 Q
 ;
SETFSC(IBXPD,IBPRD) ; Stuff FSC domain into link.
 ; Input:   IBXPD       - Post-Installation step being performed
 ;          IBPRD       - "T"=Test Environment; "P"=Production Environment.
 N DIC,X,Y,DIE,DR,DA,DLAYGO
 D BMES^XPDUTL("STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-----------")
 D MES^XPDUTL("  Stuff FSC domain into the link ... ")
 ;
 ;Stuff FSC domain into link
 S DIC="^HLCS(870,",DLAYGO=870,DIC(0)="LS" S X="HCSR OUT" D ^DIC
 ; For test environments, use the FSC test domain
 I IBPRD="T",Y'=-1 S DIE=DIC,DA=+Y,DR=".08///ECOMMLLPTST.FSC.DOMAIN.EXT;400.02///54469;4.5///1" K DIC D ^DIE
 ; For Production environments, use the FSC PRD domain
 I IBPRD="P",Y'=-1 S DIE=DIC,DA=+Y,DR=".08///ECOMMLLPPRD.FSC.DOMAIN.EXT;400.02///9346;4.5///1" K DIC D ^DIE
 ; Stuff FSC domain into table update link
 S DIC="^HLCS(870,",DLAYGO=870,DIC(0)="LS" S X="IBTUPD OUT" D ^DIC
 I Y'=-1 S DIE=DIC,DA=+Y,DR=".08///Revenue.FSC-EDI.X12CODESUPDATES.DOMAIN.EXT" K DIC D ^DIE
 ;
 D MES^XPDUTL("STEP 2: Done.")
 D MES^XPDUTL("")
 Q
 ;
SETNTJB(IBXPD,IBPRD) ; Schedule the HCSR Patient Events Search Criteria
 ; as a Night Job using TaskMan.
 ; Input:   IBXPD       - Post-Installation step being performed
 ;          IBPRD       - "T"=Test Environment; "P"=Production Environment.
 N DIC,DLAYGO,TSTAMP,X,Y
 D BMES^XPDUTL("STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-----------")
 D MES^XPDUTL("  Setting up IBT HCSR NIGHTLY PROCESS ... ")
 I IBPRD'="P" D MES^XPDUTL("  Not a production account. No TaskMan job scheduled.") G SETNTJBX
 ;
 I $$FIND1^DIC(19.2,,"B","IBT HCSR NIGHTLY PROCESS","B") D MES^XPDUTL(" Already scheduled") G SETNTJBX  ; don't overwrite existing schedule
 S (DLAYGO,DIC)=19.2,DIC(0)="L"
 S X="IBT HCSR NIGHTLY PROCESS"
 S TSTAMP=$$FMADD^XLFDT($$NOW^XLFDT(),1),$P(TSTAMP,".",2)="2100"
 S DIC("DR")="2////"_TSTAMP_";6////D@9PM"
 D ^DIC
 D MES^XPDUTL("STEP 3: Done.")
 D MES^XPDUTL("")
SETNTJBX ;
 Q
 ;
CLEARDUP(IBXPD) ; clear duplicate entries in dictionary files
 N CODE,FILE,NEWDESC,NEWIEN,OLDIEN
 N DA,DIE,DIK,DR,X,Y
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Cleaning dictionary files ... ")
 F FILE=365.013,365.015,365.016,365.017,365.021,365.022,365.025,365.027 D
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
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(IBXPD)
 Q
 ;
REINDEX(IBXPD) ; Run new indices.  This is needed for entries at site not in file coming across.
 N FILE,DIK,X,Y
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Running new indices ... ")
 F FILE=365.013,365.015,365.016,365.021,365.022,365.025 D
 .S DIK="^IBE("_FILE_","
 .S DIK(1)=".02^C"
 .D ENALL^DIK
 .Q
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(IBXPD)
 Q
 ;
DISPROT(IBXPD) ; disable action protocols IBT HCSR SEND 278 REQUEST and IBT HCSR COPY 278 REQUEST
 N FDA,PRIEN,PRNAME
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Disabling out-of-order actions ... ")
 F PRNAME="IBT HCSR SEND 278 REQUEST","IBT HCSR COPY 278 REQUEST","IBT HCSR RESPONSE EE SEND278" D
 .S PRIEN=+$$FIND1^DIC(101,,"X",PRNAME,"B")
 .I PRIEN S FDA(101,PRIEN_",",2)="This action is not currently available."
 .Q
 I $D(FDA) D FILE^DIE("E","FDA")
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(IBXPD)
 Q
 ;
DONE ; Displays the 'Done' message and finishes the progress bar
 D MES^XPDUTL("")
 D MES^XPDUTL("POST-Install Completed.")
 Q
 ;
