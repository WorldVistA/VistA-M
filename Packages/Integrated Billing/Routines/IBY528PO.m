IBY528PO ;ALB/CJS - Post install routine for patch 528 ;5-APR-15
 ;;2.0;INTEGRATED BILLING;**528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ; This post-install routine will rename a security key; assign
 ; it to three additional menu options and an action protocol;
 ; and remove another security key from the three menu options.
 ; 
 ; The name of the IBCNE IIV AUTO MATCH key will be changed to
 ; IBCNE EIV MAINTENANCE.
 ; 
 ; The newly named IBCNE EIV MAINTENANCE key will be used to lock
 ; the following menu options in place of the current IB INSURANCE
 ; SUPERVISOR lock:
 ;      IBCNE PAYER MAINTENANCE MENU
 ;      IBCNE PAYER EDIT
 ;      IBCNE PAYER LINK
 ; 
 ; It will also be used to lock the Payer action (PA) action on
 ; the IBCN INSURANCE CO EDIT screen.
 ;
 ; Then this routine will also add a new user.
 ; 
START ; CALL SECTIONS
 D MES^XPDUTL("  Starting post-install for IB*2.0*528")
 N IBY,Y
 F IBY="KEYS","ADDUSR","COMMENTS","TYPE","SRCINF" D
 . S Y=$$NEWCP^XPDUTL(IBY,IBY_"^IBY528PO")
 . D:'Y BMES^XPDUTL("ERROR Creating "_IBY_" Checkpoint.")
 ; Completion message
 D MES^XPDUTL("  Finished post-install for IB*2.0*528")
 Q
 ;
KEYS ; Rename IBCNE IIV AUTO MATCH security key to IBCNE EIV MAINTENANCE
 N IBFLAG,IBOPT,DA,DIC,DIE,DR,X
 D MES^XPDUTL("Renaming and re-indexing security key...")
 ; Check whether the key has already been renamed
 I $O(^DIC(19.1,"B","IBCNE IIV AUTO MATCH",0))'>0,+$O(^DIC(19.1,"B","IBCNE EIV MAINTENANCE",0)) D MES^XPDUTL("Key IBCNE IIV AUTO MATCH already renamed.") Q
 ;
 S IBFLAG=$$RENAME^XPDKEY("IBCNE IIV AUTO MATCH","IBCNE EIV MAINTENANCE")
 I 'IBFLAG D MES^XPDUTL("Key IBCNE IIV AUTO MATCH not renamed!"),MES^XPDUTL("Aborting security key updates.") Q
 ;
 ; Lock options IBCNE PAYER MAINTENANCE MENU, IBCNE PAYER EDIT, and IBCNE PAYER LINK with newly named key
 D MES^XPDUTL("Assigning key to options...")
 F IBOPT="MAINTENANCE MENU","EDIT","LINK" D
 .S DA=$$FIND1^DIC(19,"","X","IBCNE PAYER "_IBOPT,"B")
 .I 'DA D MES^XPDUTL("Option IBCNE PAYER "_IBOPT_" not found in system.") Q
 .S DIE=19,DR="3///IBCNE EIV MAINTENANCE"
 .L +^DIC(19,DA):0 I $T D ^DIE L -^DIC(19,DA) Q
 .D MES^XPDUTL("Option IBCNE PAYER "_IBOPT_" is locked by another user.")
 ;
 ; Lock protocol IBCNSC INS CO PAYER with newly named key
 D MES^XPDUTL("Assigning key to protocol...")
 S DA=$$FIND1^DIC(101,"","X","IBCNSC INS CO PAYER","B") D
 .I 'DA D MES^XPDUTL("Protocol IBCNSC INS CO PAYER not found in system.") Q
 .S DIE=101,DR="3///IBCNE EIV MAINTENANCE"
 .L +^ORD(101,DA):0 I $T D ^DIE L -^ORD(101,DA) Q
 .D MES^XPDUTL("Protocol IBCNSC INS CO PAYER is locked by another user.")
 ;
 Q
 ;
ADDUSR ; Add the user to the New Person file (#200)
 N DIC,X,Y,DO,DD,DLAYGO,IBNAME,IBIEN,IBERR,IBARR
 ;
 S IBNAME="AUTOUPDATE,IBEIV"
 S IBIEN=$$FIND1^DIC(200,"","MX",IBNAME,"","","IBERR") I $D(IBERR) D BMES^XPDUTL("Error in ADDUSR-IBY528PO - Cannot add "_IBNAME_" to New Person file #200") Q
 I +IBIEN D BMES^XPDUTL("User "_IBNAME_" already exists in the NEW PERSON file - not added") Q
 ;
 D BMES^XPDUTL("Adding new user, "_IBNAME_", to the NEW PERSON file")
 S DIC(0)="LMX"
 S IBARR(200,"+1,",.01)=IBNAME,IBARR(200,"+1,",1)="MRA"
 D UPDATE^DIE("E","IBARR","IBIEN","IBERR")
 ;
 I '+$G(IBIEN(1))!($D(IBERR)) D  Q
 . D BMES^XPDUTL("A problem was encountered trying to add user, "_IBNAME)
 . D BMES^XPDUTL("The entry must be added manually to the NEW PERSON file")
 ;
 D BMES^XPDUTL("User, "_IBNAME_", was successfully added to the NEW PERSON file")
 Q
 ;
COMMENTS ; copy historical comments (2.312, 1.08) into new field 2.312, 1.18 (COMMENT - SUBSCRIBER POLICY multiple)
 ;  and then update historical comment record with "postmaster" (2.312, 1.18, .02) and 
 ; date/time that historical comment copied into 2.312, 1.18 multiple
 D BMES^XPDUTL("Copy of data existing at COMMENT - PATIENT POLICY field 2.312, 1.08 field  "),BMES^XPDUTL("to new COMMENT - SUBSCRIBER POLICY multiple (2.312, 1.18)")
 N PTIEN,IPIEN,IENS,DATETIME,IBNUM,IBO,IBCOM,IBXCOM,I
 K ERROR,FDA
 S (PTIEN,IPIEN)=0
 S DATETIME=$$NOW^XLFDT()
 ; patient record can have 1 to many insurance policy records
 ; comments associated with the patient's specific insurance policy are at 2.312, 1.18 multiple
 S PTIEN=0 F  S PTIEN=$O(^DPT(PTIEN)) Q:'PTIEN  S IPIEN=0 F  S IPIEN=$O(^DPT(PTIEN,.312,IPIEN)) Q:'IPIEN  D
 . Q:$P($G(^DPT(PTIEN,.312,IPIEN,1)),U,8)']""  ; don't bother calling the FILER if there's nothing to populate from the old field
 . ;
 . ; -- quit if comment archived already
 . S IBCOM=$P(^DPT(PTIEN,.312,IPIEN,1),U,8),IBO=0
 . F I=0:0 S I=$O(^DPT(PTIEN,.312,IPIEN,13,I)) Q:I'>0!(IBO)  D
 . . S IBXCOM=$G(^DPT(PTIEN,.312,IPIEN,13,I,1))
 . . I IBCOM=IBXCOM S IBO=1
 . Q:IBO
 . ;
 . S IENS="+1"_","_IPIEN_","_PTIEN_","
 . S FDA(2.342,IENS,.01)=DATETIME
 . S FDA(2.342,IENS,.02)=.5
 . S FDA(2.342,IENS,.03)=$P(^DPT(PTIEN,.312,IPIEN,1),U,8)
 . D UPDATE^DIE(,"FDA",,"ERROR")
 . I $D(ERROR) D
 . . S IBNUM=+$G(ERROR("DIERR"))
 . . D BMES^XPDUTL("File: "_$G(ERROR("DIERR",IBNUM,"PARAM","FILE")))
 . . D BMES^XPDUTL("IENS: "_$G(ERROR("DIERR",IBNUM,"PARAM","IENS")))
 . . D BMES^XPDUTL("Field: "_$G(ERROR("DIERR",IBNUM,"PARAM","FIELD")))
 . . K ERROR
 Q
 ;
TYPE ; add type of plan entries to #355.1
 D ADTYPPLN^IBY528PA
 Q
 ;
SRCINF ; add new source of information entry to #355.12
 D ADSRCINF^IBY528PA
 Q
 ;IBY528PO
