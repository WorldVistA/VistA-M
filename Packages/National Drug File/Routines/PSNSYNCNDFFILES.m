PSNSYNCNDFFILES ; OSE/SMH - PPS-N National File Updates File Sync;2018-04-20  11:28 AM ; 6/4/18 4:02pm
 ;;4.0;NATIONAL DRUG FILE;**10001**; 30 Oct 98;Build 61
 ;
 ; Entire routine authored by Sam Habiel (c) 2018.
 ; See accompanying licnese for usage conditions.
 ;
EN ; [Private] Main Entry Point to download files
 ; Now now
 N PSNDNLDB S PSNDNLDB=$$NOW^XLFDT()
 ;
 ; 
 ; Sanity Check:
 ; 1. Create Local Directory (no-op if it exists)
 ; 2. Check Remote Site Information
 ; 3. Check Remote Site Path
 N PSREMFIL S PSREMFIL="n/a"
 ;
 ; Make directory; or else.
 N PSWRKDIR S PSWRKDIR=$$GETD^PSNFTP()
 N % S %=$$MKDIR^%ZISH(PSWRKDIR)
 I % D  QUIT
 . N MSG S MSG="Error creating directory "_PSWRKDIR
 . D EN^DDIOL(MSG)
 . D MAILFTP^PSNFTP(0,"n/a",0,MSG)
 ;
 ; Check Server
 N PSADDR S PSADDR=$$GET1^DIQ(57.23,1,20)
 I PSADDR="" DO  QUIT
 . N MSG S MSG="Remote Server Address in the PPS-N Site Parameters is not defined or invalid"
 . D EN^DDIOL(MSG)
 . D MAILFTP^PSNFTP(0,"n/a",0,MSG)
 ;
 ; Check Remote Site Path
 N PSREMDIR S PSREMDIR=$$GET1^DIQ(57.23,1,21)
 I PSREMDIR="" DO  QUIT
 . N MSG S MSG="REMOTE DIRECTORY ACCESS in PPS-N UPDATE CONTROL (#57.23) file is not defined"
 . D EN^DDIOL(MSG)
 . D MAILFTP^PSNFTP(0,"n/a",0,MSG)
 ;
 ;
 ; Get list of old files
 N A S A("*")=""
 N OLD
 N % S %=$$LIST^%ZISH(PSWRKDIR,"A","OLD")
 ;
 ; Checks are okay. Now we need to download.
 ;
 ; Change download status to downloading
 N DIE,DA,DR
 S DIE="^PS(57.23,",DA=1,DR="9///Y" D ^DIE
 ;
 ; Sync remote site contents with current folder
 D EN^DDIOL("Syncing "_PSADDR_"/"_PSREMDIR_" to "_PSWRKDIR)
 N % S %=$$WGETSYNC^%ZISH(PSADDR,PSREMDIR,PSWRKDIR,"*.DAT*")
 I % DO  DO UNLOCK QUIT
 . N MSG S MSG="WGET came back with an error. Error code: "_%
 . D EN^DDIOL(MSG)
 . D MAILFTP^PSNFTP(0,"n/a",0,MSG)
 I '% D EN^DDIOL("Sync complete")
 ;
 ; Find the new files that we got.
 N A S A("*")=""
 N NEW
 N % S %=$$LIST^%ZISH(PSWRKDIR,"A","NEW")
 ;
 ; Intersect old files with new files; and see if we really have new ones
 N JUSTDW ; Just downloaded
 N F S F=""
 F  S F=$O(NEW(F)) Q:F=""  I '$D(OLD(F)) S JUSTDW(F)=""
 ;
 D EN^DDIOL()
 ;
 I $D(JUSTDW) D
 . D EN^DDIOL("These files are new: ")
 . N F S F="" F  S F=$O(JUSTDW(F)) Q:F=""  D EN^DDIOL(F)
 E  D EN^DDIOL("No new files have been downloaded")
 ;
 ; For each new file
 N PSREMFIL S PSREMFIL=""
 F  S PSREMFIL=$O(NEW(PSREMFIL))  Q:PSREMFIL=""  D
 . ;
 . ; If the file was already downloaded, don't do anything
 . I $D(^PS(57.23,1,4,"G",PSREMFIL)) QUIT
 . ; 
 . ; - update PPS-N UPDATE CONTROL:RETRIEVAL VERSION (#57.23:8)
 . ; (NB: We don't use this field in our version of stuff)
 . N PSNEW S PSNEW=+$P(PSREMFIL,"PRV_",2)
 . N DIE,DA,DR
 . S DIE="^PS(57.23,",DA=1,DR="8///"_PSNEW D ^DIE
 . ;
 . ; get size
 . N PSSIZE S PSSIZE=$$SIZE^%ZISH(PSWRKDIR,PSREMFIL)
 . ;
 . ; email that we are done
 . D MAILFTP^PSNFTP(1,PSREMFIL,PSSIZE,"")
 . ;
 . ; update the control file
 . D UPDTCTRL^PSNFTP
 ;
UNLOCK ; [fall through] Turn off downloading flag
 K DIE,DA,DR
 S DIE="^PS(57.23,",DA=1,DR="9///N" D ^DIE K DIE,DA,DR
 Q
