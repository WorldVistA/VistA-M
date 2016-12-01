RORP028 ;ALB/TK  ENV CK, PRE and POST INSTALL - PATCH 28 ; 18 Feb 2016  6:23 PM
 ;;1.5;CLINICAL CASE REGISTRIES;**28**;Feb 17, 2006;Build 66
 ;
 ;*****************************************************************************
 ;*****************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE       DEVELOPER    MODIFICATION
 ;-----------  ---------  -----------  ----------------------------------------
 ;ROR*1.5*28   APR 2016   T KOPP       Added routine for env check, pre/post
 ;                                     install
 ;                                               
 ;******************************************************************************
 ;******************************************************************************
 ; 
 ; SUPPORTED CALLS:
 ;  RTN^%ZTLOAD   #10063
 ;  STAT^%ZTLOAD  #10063
 ;  BMES^XPDUTL   #10141
 ;  MES^XPDUTL    #10141
 ;  BLD^DIALOG    #2050
 ;  UPDATE^DIE    #2053
 ;  FMADD^XLFDT   #10103
 ;  NOW^XLFDT     #10103
 ;  FMTE^XLFDT    #10103
 ;  CLEAN^DILF    #2054
 ;  GET1^DIQ      #2056
 ;  ^DIR          #10026
 ;  FIND1^DIC     #2051
 ;
ENV ;  Environment check
 S XPDNOQUE=1 ; disable queuing
 Q
 ;
PRE ; Patch pre-install
 N RC,ZTSK,RORBUF,RORMES
 ; Check for ROR INITIALIZE task running
 D BMES^XPDUTL("   *** Checking to be sure ROR INITIALIZE task is not already running")
 S RC=0
 D RTN^%ZTLOAD("RORSET02","RORBUF")
 S ZTSK="" F  S ZTSK=$O(RORBUF(ZTSK)) Q:ZTSK=""  D  I $G(ZTSK(1))=2 S RC=-1 Q
 . D STAT^%ZTLOAD
 ;--- Display error message if option is running
 I RC<0  D  S XPDABORT=2 Q
 . K RORMES
 . D BMES^XPDUTL($$MSG^RORERR20(RC,,XPDNM))
 . D BMES^XPDUTL("")
 . S RORMES(1)="   >> ROR INITIALIZE task is already running.  Task # is "_ZTSK
 . S RORMES(2)="      This task must complete or be terminated before the install can continue"
 . S RORMES(3)="      Restart this patch install when this task is not running"
 . S RORMES(4)=" "
 . D MES^XPDUTL(.RORMES)
 S RORPARM("DEVELOPER")=1
 N RORI,REGIEN,RORREG,Z,X,Y,DIR
 K ^XTMP("ROR_NO_INIT")  ; Will contain any pre-initialized registries not to be reinitialized
 D XTMPHDR^RORUTL01("ROR_NO_INIT",7,"CCR REGISTRIES NOT TO BE RE-INITIALIZED")
 F RORI=1:1 S RORREG=$P($P($T(@("NEWREG+"_RORI_"^RORP028")),";;",2),U) Q:RORREG=""  D  Q:$G(XPDABORT)
 . S REGIEN=$$REGIEN^RORUTL02(RORREG)
 . Q:REGIEN'>0  ; new registry doesn't yet exist
 . ; Check if registry is already initiated (has a value in HDT field)
 . S Z=$$GET1^DIQ(798.1,REGIEN_",",21.05,"I")
 . I Z'="" D  Q
 .. S DIR(0)="YA",DIR("A",1)="  >> New registry "_RORREG_"(ien #"_REGIEN_") has already completed initialization"
 .. S DIR("A")="Do you want to rerun its initialization?: ",DIR("B")="NO"
 .. W ! D ^DIR K DIR W !
 .. I $D(DIRUT)!($D(DIROUT)) S XPDABORT=2 K ^XTMP("ROR_NO_INIT") D BMES^XPDUTL("INSTALL ABORTED") Q
 .. I Y'=1 S ^XTMP("ROR_NO_INIT",REGIEN)=""
 Q
 ;
POST ; Patch post-install
 N CT,RORI,RORREG,REGIEN,Z
 N RORPARM
 S RORPARM("DEVELOPER")=1
 D BMES^XPDUTL("POST INSTALL START")
 ;
 D BMES^XPDUTL(">> Adding new panel to DAA Lab Monitoring report")
 D NEWPANEL
 ; Update Knee/Hip replacement registries short description
 D BMES^XPDUTL(">> Updating Short Description for 2 Registries")
 D UPDNM
 ;
 D BMES^XPDUTL(">> Updating List Items for new registries")
 D UPDLIST,COMPL
 ;
 D BMES^XPDUTL(">> Initiating background job to set up registries added with this patch")
 N RORKIDS,RORERR,RORFDA,CT,DIERR,X,Y
 S RORKIDS=1
 F RORI=1:1 S RORREG=$P($P($T(@("NEWREG+"_RORI_"^RORP028")),";;",2),U) Q:RORREG=""  D
 . S REGIEN=$$REGIEN^RORUTL02(RORREG)
 . Q:REGIEN'>0
 . I $D(^XTMP("ROR_NO_INIT",REGIEN)) D  Q
 .. S RORERR(1)="   o New registry "_RORREG_"(ien #"_REGIEN_") is already initialized"
 .. S RORERR(2)="     You have chosen not to re-initialize this registry"
 .. S RORERR(3)=" "
 .. D MES^XPDUTL(.RORERR)
 .. K RORERR
 . ;
 . K RORFDA,RORMSG,RORERR
 . S RORFDA(798.1,REGIEN_",",1)=2850101
 . S RORFDA(798.1,REGIEN_",",19.1)=""
 . S RORFDA(798.1,REGIEN_",",21.05)=""
 . D UPDATE^DIE(,"RORFDA",,"RORMSG")
 . I $D(DIERR) D
 .. K RORERR
 .. M RORERR=RORMSG
 .. D DBS^RORERR("RORMSG",-112,,,798.1,REGIEN)
 .. M RORMSG=RORERR
 .. K RORERR
 .. S RORERR(1)="     New registry "_RORREG_"(ien #"_REGIEN_") encountered the following error"
 .. S RORERR(2)="     and may not initialize correctly.  Please report this error to your CCR contact:"
 .. S RORERR(3)=""
 .. S Z=0,CT=3 F  S Z=$O(RORMSG("DIERR",1,"TEXT",Z)) Q:'Z  S CT=CT+1,RORERR(CT)=$J("",10)_$G(RORMSG("DIERR",1,"TEXT",Z))
 .. S CT=CT+1,RORERR(CT)=" "
 .. D MES^XPDUTL(.RORERR)
 D ^RORSET02
 K ^XTMP("ROR_NO_INIT")
 D COMPL
 ;
 D BMES^XPDUTL(">> Setting flag for back pull of problem list for HIV/HEPC registries")
 D XTMPHDR^RORUTL01("ROR_ONETIME_PROBLEM_LIST_EXTRACT",60,"ONE TIME PROBLEM LIST BACK PULL PATCH 28")
 S ^XTMP("ROR_ONETIME_PROBLEM_LIST_EXTRACT",1)=1
 D COMPL
 ;
 D CLEAN^DILF
 D BMES^XPDUTL("POST INSTALL COMPLETE")
 Q
 ;
NEWREG ; List of new registries to initialize
 ;;VA CROHNS
 ;;VA DEMENTIA
 ;;VA HEPB
 ;;VA THYROID CA
 ;;VA UC
 ;;
 ;
NEWPANEL ; For DAA Lab Monitoring report - add panel 55 after ,24,
 N RORRPT,RORMSG,RORPAN,RORERR,RORFDA,X,Y,DIERR
 S RORRPT=$$FIND1^DIC(799.34,,"X","DAA Lab Monitoring")
 S RORPAN=$G(^ROR(799.34,RORRPT,1))
 K RORFDA,RORMSG
 I RORPAN[",24,55," D  Q
 . D BMES^XPDUTL("   o New panel already exists for registry")
 . D COMPL
 I RORPAN'[",24,55," D
 . S RORFDA(799.34,RORRPT_",",1)=$P(RORPAN,",24,")_",24,55,"_$P(RORPAN,",24,",2)
 . D UPDATE^DIE("","RORFDA",,"RORMSG")
 . I $D(DIERR) D  Q
 .. K RORERR
 .. D DBS^RORERR("RORMSG",-112,,,799.34,RORRPT)
 .. M RORMSG=RORERR
 .. K RORERR
 .. S RORERR(1)="     Update of report "_$P($G(^ROR(799.34,RORRPT,0)),U)_" with new panel"
 .. S RORERR(2)="      encountered the following error.  Please report this error to your CCR contact:"
 .. S RORERR(3)=""
 .. S Z=0,CT=3 F  S Z=$O(RORMSG("DIERR",1,"TEXT",Z)) Q:'Z  S CT=CT+1,RORERR(CT)=$J("",10)_$G(RORMSG("DIERR",1,"TEXT",Z))
 .. S CT=CT+1,RORERR(CT)=" "
 .. D MES^XPDUTL(.RORERR)
 D COMPL
 Q
 ;
UPDNM ;
 N DIERR,ROR,ROR1,ROR2,RORFDA,RORMSG,RORERR,X,Y
 F ROR="VA TOTAL KNEE","VA TOTAL HIP" D
 . S ROR1=$$FIND1^DIC(798.1,,"X",ROR)
 . I ROR1'>0 D  Q
 .. D BMES^XPDUTL("   o "_ROR_" registry does not exist"),COMPL
 . S ROR2=$P($G(^ROR(798.1,ROR1,0)),U,4)
 . ;
 . I ROR2[" Registry" D  Q
 .. D BMES^XPDUTL("   o "_ROR_" registry description was already updated")
 . ;
 . K RORFDA,RORMSG,DIERR,RORERR
 . S ROR2=ROR2_" Registry"
 . S RORFDA(798.1,ROR1_",",4)=ROR2
 . D UPDATE^DIE("","RORFDA",,"RORMSG")
 . I $D(DIERR) D  Q
 .. K RORERR
 .. D DBS^RORERR("RORMSG",-112,,,798.1,ROR1)
 .. M RORMSG=RORERR
 .. K RORERR
 .. S RORERR(1)="     Update of the "_ROR_" registry description was not successful"
 .. S RORERR(2)="      Please report this error to your CCR contact:"
 .. S RORERR(3)=""
 .. S Z=0,CT=3 F  S Z=$O(RORMSG("DIERR",1,"TEXT",Z)) Q:'Z  S CT=CT+1,RORERR(CT)=$J("",10)_$G(RORMSG("DIERR",1,"TEXT",Z))
 .. S CT=CT+1,RORERR(CT)=" "
 .. D MES^XPDUTL(.RORERR)
 . D BMES^XPDUTL("   o "_ROR_" registry description updated")
 D COMPL
 Q
 ;
COMPL ;
 D BMES^XPDUTL("   >> Step complete")
 Q
 ;
LISTITEM ;  Entries to add to file 799.1  text^group^code
 ;;eGFR by CKD-EPI^7^3
 ;;eGFR by MDRD^7^2
 ;;Creatinine clearance by Cockcroft-Gault^7^1
 ;;FIB-4^6^4
 ;;APRI^6^3
 ;;MELD-Na^6^2
 ;;MELD^6^1
 ;;BMI^5^1
 ;;Registry Lab^3^1
 ;;
 ;
 ; Update ROR LIST ITEM file (#799.1) for new registries
UPDLIST  ;
 N RORI,RORI1,RORREG,RORDATA,REGIEN,Z,CT,DIERR,RORFDA,RORMSG,RORERR
 F RORI=1:1 S RORREG=$P($P($T(@("NEWREG+"_RORI_"^RORP028")),";;",2),U) Q:RORREG=""  D
 . S REGIEN=$$REGIEN^RORUTL02(RORREG)
 . I REGIEN>0 D
 .. F RORI1=1:1 S RORDATA=$P($T(@("LISTITEM+"_RORI1_"^RORP028")),";;",2) Q:RORDATA=""  D
 ... Q:$D(^ROR(799.1,"KEY",+$P(RORDATA,U,2),REGIEN,+$P(RORDATA,U,3)))  ; Entry already exists
 ... K RORFDA,RORMSG,RORERR,DIERR
 ... S RORFDA(799.1,"?+1,",.01)=$P(RORDATA,U)
 ... S RORFDA(799.1,"?+1,",.02)=$P(RORDATA,U,2)
 ... S RORFDA(799.1,"?+1,",.03)=REGIEN
 ... S RORFDA(799.1,"?+1,",.04)=$P(RORDATA,U,3)
 ... D UPDATE^DIE(,"RORFDA",,"RORMSG")
 ... I $G(DIERR) D
 .... K RORERR
 .... S RORERR(1)="     New entry for "_RORREG_"(ien #"_REGIEN_") encountered the following error"
 .... S RORERR(2)="     and was not added to the ROR LIST ITEM file."
 .... S RORERR(3)="     (Data = "_RORDATA_")"
 .... S RORERR(4)="     Please report this error to your CCR contact:"
 .... S RORERR(5)=""
 .... S Z=0,CT=5 F  S Z=$O(RORMSG("DIERR",1,"TEXT",Z)) Q:'Z  S CT=CT+1,RORERR(CT)=$J("",6)_$G(RORMSG("DIERR",1,"TEXT",Z))
 .... S CT=CT+1,RORERR(CT)=" "
 .... D MES^XPDUTL(.RORERR)
 Q
 ;
 ; Sets the DIR array from the post-install question #3 (suspension start time)
POSQ3(DIR) ;
 K:$G(XPDQUES("POSQ2"))'=1 DIR
 Q:'$D(DIR)
 D BLD^DIALOG(7980000.011,,,"DIR(""?"")","S")
 Q
 ;
 ; Sets the DIR array from the post-install question #4  (suspension end time)
POSQ4(DIR) ;
 K:$G(XPDQUES("POSQ2"))'=1 DIR
 Q:'$D(DIR)
 S DIR("A")="Suspension end time"
 ;  Make sure end time entered is later than end time start
 S DIR(0)="D^::R^K:(Y#1)'>(XPDQUES(""POSQ3"")#1) X"
 D BLD^DIALOG(7980000.012,,,"DIR(""?"")","S")
 Q
 ;
 ; Updates the DIR array from the post-install question #5  (schedule time for ROR INITIALIZE task)
POSQ5(DIR) ;
 Q:'$D(DIR)
 N ROREDT
 ; Set earliest date to schedule to 15 minutes from 'NOW'
 S ROREDT=$$FMADD^XLFDT($$NOW^XLFDT(),,,15)
 ; Strip seconds
 S ROREDT=$P(ROREDT,".",1)_"."_$E($P(ROREDT,".",2),1,4)
 ;  Make sure future date/time is entered
 S $P(DIR(0),U,3)=("K:Y<"_ROREDT_" X")
 S DIR("B")=$$FMTE^XLFDT(ROREDT,2)
 Q
 ;
