XU8P480 ;OAK_TKW - POST-INSTALL ROUTINE FOR XU*8*480 ;6/6/08  13:21
 ;;8.0;KERNEL;**480**; July 10, 1995;Build 38
 ;;Per VHA Directive 2004-038, this routine should not be modified
POST ; run post-init routine
 ; Assign security key XUSNPIMTL to users with XUS NPI MENU option
 N XUSIEN,XUSSIEN,XUSOIEN,XUSXREF,CNT,X,Y
 K ^TMP("DIERR",$J)
 D MES^XPDUTL("Assigning new security key XUSNPIMTL to users with XUS NPI MENU option...")
 ; Find IEN of security key XUSNPIMTL and option XUS NPI MENU
 S XUSSIEN=$$FIND1^DIC(19.1,,"QX","XUSNPIMTL","B")
 I 'XUSSIEN!($D(^TMP("DIERR",$J))) D  Q
 . D MES^XPDUTL("  **Security Key 'XUSNPIMTL' is not on your system")
 . D POST2 Q
 S XUSOIEN=$$FIND1^DIC(19,,"QX","XUS NPI MENU","B")
 I 'XUSOIEN!($D(^TMP("DIERR",$J))) D  Q
 . D MES^XPDUTL("  **OPTION 'XUS NPI MENU' is not on your system")
 . D POST2 Q
 ; Build list of users who hold the menu option 
 K ^TMP($J,"XU8P480")
 F XUSXREF="AD","AP" D
 . F XUSIEN=0:0 S XUSIEN=$O(^VA(200,XUSXREF,XUSOIEN,XUSIEN)) Q:'XUSIEN  D
 . . Q:'$D(^VA(200,XUSIEN,.1))
 . . Q:'$$ACTIVE^XUSER(XUSIEN)
 . . S ^TMP($J,"XU8P480",XUSIEN)=""
 . . Q
 . Q
 I '$D(^TMP($J,"XU8P480")) D  Q
 . D MES^XPDUTL("  *No users were found with access to the XUS NPI MENU option.")
 . D MES^XPDUTL("  *Key 'XUSNPIMTL' was not assigned to any users.")
 . D POST2 Q
 ; Assign the key XUSNPIMTL to the users
 N DIC,DA,DINUM
 F XUSIEN=0:0 S XUSIEN=$O(^TMP($J,"XU8P480",XUSIEN)) Q:'XUSIEN  D
 . Q:$D(^VA(200,XUSIEN,51,XUSSIEN))
 . S DIC(0)="NLX",DIC("P")="200.051PA",DIC="^VA(200,XUSIEN,51,",DA(1)=XUSIEN
 . S X=XUSSIEN,DINUM=X D FILE^DICN
 . I Y>0 D MES^XPDUTL("  Key assigned to "_$P(^VA(200,XUSIEN,0),"^"))
 . Q
 K ^TMP($J,"XU8P480")
POST2 ; Initialize new field 41.97 AUTHORIZES RELEASE OF NPI to 1 (Yes)
 ; on all provider entries in file 200
 D BMES^XPDUTL("Initializing AUTHORIZE RELEASE OF NPI field to 1 (Yes)...")
 N XUSAUTH
 S CNT=0
 F XUSIEN=0:0 S XUSIEN=$O(^VA(200,XUSIEN)) Q:'XUSIEN  D
 . ; Only update providers who have an NPI field.
 . S X=$G(^VA(200,XUSIEN,"NPI"))
 . S XUSAUTH=$P(X,"^",3)
 . I $P(X,U)="",$O(^VA(200,XUSIEN,"NPISTATUS",0))'>0 D  Q
 . . Q:XUSAUTH=""
 . . S $P(^VA(200,XUSIEN,"NPI"),"^",3)=""
 . . Q
 . Q:XUSAUTH=1
 . S $P(^VA(200,XUSIEN,"NPI"),"^",3)=1
 . S CNT=CNT+1
 . Q
 D MES^XPDUTL("  AUTHORIZE RELEASE OF NPI field was set on "_CNT_" providers")
 ; Rebuild list of taxonomy values for providers normally assigned NPIs.
 D BMES^XPDUTL("Rebuilding temporary list of taxonomy values for providers who are")
 D MES^XPDUTL(" normally assigned NPIs...")
 K ^XTMP("NPIVALS")
 S X=$$CHKGLOB^XUSNPIDA()
 ; Add key XUSNPIMTL to the option XUS NPI MENU
 N XUSMIEN,XUSFDA,XUSIEN
 S XUSMIEN=$$LKOPT^XPDMENU("XUS NPI MENU")
 I 'XUSMIEN D BMES^XPDUTL("****WARNING - Menu Option XUS NPI MENU is not on your system!!! *****") Q
 K XUSFDA
 S XUSFDA(19,XUSMIEN_",",3)="XUSNPIMTL"
 D FILE^DIE("","XUSFDA")
 K XUSFDA
 ; Remove menu option that was added during testing. The AUTHORIZE USE OF NPI flag was
 ; discontinued before patch XU*8*480 was released.
 ; 
 ; QUIT if option to edit AUTHORIZE USE OF NPI does not exist on this system.
 S XUSIEN=$$FIND1^DIC(19,"","QX","XUS NPI EDIT AUTH TO RELEASE","B")
 Q:'XUSIEN
 ; Quit if option to edit AUTHORIZE USE OF NPI is not on the main NPI menu.
 S X=$$FIND1^DIC(19.01,","_XUSMIEN_",","","XUS NPI EDIT AUTH TO RELEASE")
 ; Delete the option to edit AUTHORIZE USE OF NPI from main menu, then delete the option.
 I X D
 . S XUSFDA(19.01,X_","_XUSMIEN_",",.01)="@"
 . D FILE^DIE("","XUSFDA")
 . Q
 Q:'XUSIEN
 K XUSFDA
 S XUSFDA(19,XUSIEN_",",.01)="@"
 D FILE^DIE("","XUSFDA")
 Q
 ;
 ;
