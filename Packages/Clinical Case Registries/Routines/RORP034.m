RORP034 ;ALB/MAF - CCR PRE/POST-INSTALL PATCH 34 ;18 Nov 2018  1:38 PM
 ;;1.5;CLINICAL CASE REGISTRIES;**34**;Feb 17, 2006;Build 45
 ;
 ;*****************************************************************************
 ;*****************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;  
 ;PKG/PATCH    DATE       DEVELOPER    MODIFICATION
 ;-----------  ---------  -----------  ----------------------------------------
 ;ROR*1.5*34   Nov 2018   M FERRARESE  Added routine for env check, pre/post
 ;                                     install          
 ;******************************************************************************
 ;******************************************************************************
 ; 
 ; SUPPORTED CALLS:
 ;  RTN^%ZTLOAD   #10063
 ;  STAT^%ZTLOAD  #10063
 ;  BMES^XPDUTL   #10141
 ;  OWNSKEY^XUSRB #3277 (supported)  
 ;  MES^XPDUTL    #10141
 ;  BLD^DIALOG    #2050
 ;  UPDATE^DIE    #2053
 ;  FMADD^XLFDT   #10103
 ;  NOW^XLFDT     #10103
 ;  FMTE^XLFDT    #10103
 ;  ADD^XPAR      #2263
 ;  DEL^XPAR      #2263
 ;  CLEAN^DILF    #2054
 ;
ENV ; --- Environment check
 S XPDNOQUE=1 ; disable queuing
 Q
 ;
PRE ; --- Pre-Install routine for Patch 34
 ; CHECK FOR ROR VA IRM KEY, ABORT IF USER DOES NOT POSSESS
 N RORKEYOK
 D BMES^XPDUTL("Verifying installing user has the ROR VA IRM security key")
 D OWNSKEY^XUSRB(.RORKEYOK,"ROR VA IRM",DUZ)
 I '$G(RORKEYOK(0)) D  Q
 . S XPDABORT=1
 . D BMES^XPDUTL("****** INSTALL ABORTED!!! ******")
 . D BMES^XPDUTL("This patch can only be installed by a user who is assigned the ROR VA IRM key")
 . D BMES^XPDUTL("Restart the installation again once the appropriate key has been assigned")
 D BMES^XPDUTL("  User has the ROR VA IRM key - OK to install")
 ;
 N RC,ZTSK,RORBUF,RORMES
 ; Check for ROR INITIALIZE task running
 D BMES^XPDUTL("   *** Checking to be sure ROR INITIALIZE task is not already running")
 S RC=0
 D OPTION^%ZTLOAD("ROR INITIALIZE",.RORBUF)
 S ZTSK=0 F  S ZTSK=$O(@RORBUF@(ZTSK)) Q:'ZTSK  D  I $G(ZTSK(1))=2 S RC=-1 Q
 . D STAT^%ZTLOAD
 S ZTSK=0 F  S ZTSK=$O(@RORBUF@(ZTSK)) Q:'ZTSK  K @RORBUF@(ZTSK) ;clean up
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
  ; Is ROR TASK option running
 D BMES^XPDUTL("   *** Checking to be sure ROR TASK is not running")
 S RC=0 K RORBUF
 D OPTION^%ZTLOAD("ROR TASK",.RORBUF) ;returns data in ^TMP($J)
 S ZTSK=0
 F  S ZTSK=$O(@RORBUF@(ZTSK)) Q:'ZTSK  D  I $G(ZTSK(1))=2 S RC=-76 Q
 . D STAT^%ZTLOAD
 ;don't want to K ^TMP($J). May kill something that is needed elsewhere.
 S ZTSK=0 F  S ZTSK=$O(@RORBUF@(ZTSK)) Q:'ZTSK  K @RORBUF@(ZTSK)
 ;--- Display error message if option is running
 I RC<0  D  S XPDABORT=2 Q
 . K RORMES
 . D BMES^XPDUTL($$MSG^RORERR20(RC,,,"ROR TASK"))
 . D BMES^XPDUTL("")
 . S RORMES(1)="   >> ROR TASK is already running.  Task # is "_ZTSK
 . S RORMES(2)="      This task must complete before the install can continue."
 . S RORMES(3)="      Restart this patch install when this task is not running."
 . S RORMES(4)=" "
 . D MES^XPDUTL(.RORMES)
 S RORPARM("DEVELOPER")=1
 N RORI,REGIEN,RORREG,Z,X,Y,DIR
 K ^XTMP("ROR_NO_INIT")  ; Will contain any pre-initialized registries not to be reinitialized
 D XTMPHDR^RORUTL01("ROR_NO_INIT",7,"CCR REGISTRIES NOT TO BE RE-INITIALIZED")
 F RORI=1:1 S RORREG=$P($P($T(@("NEWREG+"_RORI_"^RORP034")),";;",2),U) Q:RORREG=""  D  Q:$G(XPDABORT)
 . S REGIEN=$$REGIEN^RORUTL02(RORREG)
 . Q:REGIEN'>0  ; new registry doesn't yet exist
 . ; Check if registry is already initiated (has a value in HDT field)
 . S Z=$$GET1^DIQ(798.1,REGIEN_",",21.05,"I")
 . I Z'="" D  Q
 . . S DIR(0)="YA",DIR("A",1)="  >> New registry "_RORREG_"(ien #"_REGIEN_") has already completed initialization"
 . . S DIR("A")="Do you want to rerun its initialization?: ",DIR("B")="NO"
 . . W ! D ^DIR K DIR W !
 . . I Y<0 S XPDABORT=2 K ^XTMP("ROR_NO_INIT") D BMES^XPDUTL("INSTALL ABORTED") Q
 . . I Y'=1 S ^XTMP("ROR_NO_INIT",REGIEN)=""
 Q
 ;
POST ; --- Post-Install routine for Patch 34
 N CT,RORI,RORREG,REGIEN,Z
 N RORPARM
 S RORPARM("DEVELOPER")=1
 D BMES^XPDUTL("POST INSTALL START")
 ;
 D BMES^XPDUTL(">> Adding new Future Appointments panel to reports")
 D UPDPANEL
 D BMES^XPDUTL("   >> Step complete")
 ;
 D BMES^XPDUTL("Checking VA GENERIC drug file..COBICISTAT/DARUNAVIR/EMTRICITABINE/TENOFOVIR AF ")
 D GENDRG
 D BMES^XPDUTL("   >> Step complete")
 ;
 D BMES^XPDUTL(">> Adding CPT and ICD-9 procedures to ROR ICD SEARCH file for new registries")
 D UPDPROC
 D BMES^XPDUTL("   >> Step complete")
 ;
 D BMES^XPDUTL("Updating List Items for new registries")
 D UPDLIST
 D BMES^XPDUTL("    >> Step complete")
 ;
 D BMES^XPDUTL(">> Initiating background job to set up registries added with this patch")
 N RORKIDS,RORERR,CT,DIERR
 S RORKIDS=1
 F RORI=1:1 S RORREG=$P($P($T(@("NEWREG+"_RORI_"^RORP034")),";;",2),U) Q:RORREG=""  D
 . S REGIEN=$$REGIEN^RORUTL02(RORREG)
 . Q:REGIEN'>0
 . I $D(^XTMP("ROR_NO_INIT",REGIEN)) D  Q
 . . S RORERR(1)="   It appears new registry "_RORREG_"(ien #"_REGIEN_") has already been initialized"
 . . S RORERR(2)="   You have chosen not to re-initialize this registry"
 . . S RORERR(3)=" "
 . . D MES^XPDUTL(.RORERR)
 . . K RORERR
 . ;
 . K RORFDA,RORMSG,RORERR
 . S RORFDA(798.1,REGIEN_",",1)=2850101
 . S RORFDA(798.1,REGIEN_",",19.1)=""
 . S RORFDA(798.1,REGIEN_",",21.05)=""
 . D UPDATE^DIE(,"RORFDA",,"RORMSG")
 . I $D(DIERR) D
 . . K RORERR
 . . M RORERR=RORMSG
 . . D DBS^RORERR("RORMSG",-112,,,798.1,REGIEN)
 . . M RORMSG=RORERR
 . . K RORERR
 . . S RORERR(1)="     New registry "_RORREG_"(ien #"_REGIEN_") encountered the following error"
 . . S RORERR(2)="     and may not initialize correctly.  Please report this error to your CCR contact:"
 . . S RORERR(3)=""
 . . S Z=0,CT=3 F  S Z=$O(RORMSG("DIERR",1,"TEXT",Z)) Q:'Z  S CT=CT+1,RORERR(CT)=$J("",10)_$G(RORMSG("DIERR",1,"TEXT",Z))
 . . S CT=CT+1,RORERR(CT)=" "
 . . D MES^XPDUTL(.RORERR)
 D ^RORSET02
 K ^XTMP("ROR_NO_INIT")
 D BMES^XPDUTL("   >> Step complete")
 D BMES^XPDUTL("Updating the Drug matching entries...") D EN^RORUTL22
 D BMES^XPDUTL("Tasking nightly job to gather drug matching...") D TASK^RORUTL22
 D CLEAN^DILF
 D BMES^XPDUTL("POST INSTALL COMPLETE")
 Q
GENDRG ; --- Delete entry in ROR GENERIC DRUG with unresolved pointers
 ; clean up 799.51 if pointers are bad
 ;  HIV registry  : COBICISTAT/DARUNAVIR/EMTRICITABINE/TENOFOVIR AF - "COBI/DARUNAVIR/EMTRIC/TAF"  Released in PSN*4*
 ;               
 ;
 ;
 N DIC,X,DIK,DA,RORNAME,Y
 S DIC=799.51,DIC(0)="MNZ"
 F RORNAME="COBI/DARUNAVIR/EMTRIC/TAF" D
 .S X=RORNAME D ^DIC Q:+Y<0
 .Q:+$P(Y(0),U,4)>0
 .S DA=+Y,DIK="^ROR(799.51," D ^DIK
 .D BMES^XPDUTL("WARNING*** Missing entry in VA GENERIC file 50.6.")
 Q
 ; 
UPDPANEL ;
 ; For parameter panel field, add 29, after ,24, right below the Additional Identifiers panel for
 ;      Diagnosis    ( REPORT CODE 13)
 ;      Procedure    ( REPORT CODE 15)
 ;
 N CT,RORRPT,RORMSG,RORPAN,RORERR,RORFDA,Z,Z1,DIERR
 S RORRPT=0 F  S RORRPT=$O(^ROR(799.34,RORRPT)) Q:'RORRPT  S RORPAN=$P($G(^ROR(799.34,RORRPT,0)),U,4) D:$S(RORPAN=13:1,RORPAN=15:1,1:0)
 . S Z1=$G(^ROR(799.34,RORRPT,1))
 . K RORFDA,RORMSG
 . I Z1[",24,29," D  Q
 . .D BMES^XPDUTL("   o New panel already exists for registry")
 . I Z1'[",24,29," D 
 . . I Z1[",24,",Z1'[",24,29," S RORFDA(799.34,RORRPT_",",1)=$P(Z1,",24,")_",24,29,"_$P(Z1,",24,",2)
 . Q:'$D(RORFDA)
 . D UPDATE^DIE("","RORFDA",,"RORMSG")
 . I $D(DIERR) D
 .. K RORERR
 .. D DBS^RORERR("RORMSG",-112,,,799.34,RORRPT)
 .. M RORMSG=RORERR
 .. K RORERR
 .. S RORERR(1)="     Update of report "_$P($G(^ROR(799.34,RORRPT,0)),U)_" with new panel"
 .. S RORERR(2)="     encountered the following error.  Please report this error to your CCR contact:"
 .. S RORERR(3)=""
 .. S Z=0,CT=3 F  S Z=$O(RORMSG("DIERR",1,"TEXT",Z)) Q:'Z  S CT=CT+1,RORERR(CT)=$J("",10)_$G(RORMSG("DIERR",1,"TEXT",Z))
 .. S CT=CT+1,RORERR(CT)=" "
 .. D MES^XPDUTL(.RORERR)
 Q
 ;
POSQ3(DIR)  ; --- Sets the DIR array from the post-install question #3 (suspension start time)
 K:$G(XPDQUES("POSQ2"))'=1 DIR
 Q:'$D(DIR)
 D BLD^DIALOG(7980000.011,,,"DIR(""?"")","S")
 Q
 ;
POSQ4(DIR)  ; --- Sets the DIR array from the post-install question #4  (suspension end time)
 K:$G(XPDQUES("POSQ2"))'=1 DIR
 Q:'$D(DIR)
 S DIR("A")="Suspension end time"
 ;  Make sure end time entered is later than end time start
 S DIR(0)="D^::R^K:(Y#1)'>(XPDQUES(""POSQ3"")#1) X"
 D BLD^DIALOG(7980000.012,,,"DIR(""?"")","S")
 Q
 ;
POSQ5(DIR) ; --- Updates the DIR array from the post-install question #5  (schedule time for ROR INITIALIZE task)
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
 ;
 ;
 ;
NEWREG ; --- Update ROR LIST ITEM file (#799.1) for new registriesList of new registries to initialize
 ;;VA LYMPHOMA
 ;;VA NASH
 ;;VA ILD
 ;;
 ;
UPDPROC ; --- Update ROR LIST ITEM file (#799.1) for new registriesAdds ICD dx/procedure codes and CPT codes to the new registries in ROR ICD file
 ; Delete if already there
 N CT,I1,DA,DIK,X,Y,Z,RORDATA,RORFDA,RORI,RORPROC,RORREG,RORIEN,RORFDA1
 F RORI="LYMPHOMA","NASH","ILD" S DIC="^ROR(798.5,",X="VA "_RORI,DIC(0)="" D ^DIC I Y>0 D
 . S DIK="^ROR(798.5,",DA=+Y D ^DIK
 F RORI=1:1 S RORDATA=$P($T(ICDPROC+RORI),";;",2) Q:RORDATA=""  D
 . S RORREG=$P(RORDATA,U)
 . I RORREG'="" D  Q
 .. ; add new registry top level entry
 .. D:$D(RORFDA) ADD7985(.RORFDA,RORIEN,$P($G(^ROR(798.1,+$G(RORIEN),0)),U)) ;Store 'previous registry' if RORFDA exists
 .. K RORFDA1
 .. S RORFDA1(798.5,"+1,",.01)=RORREG,RORIEN="",CT=0
 .. D ADD7985(.RORFDA1,.RORIEN,RORREG)
 .. S Z=+$O(RORIEN(0)),Z=$G(RORIEN(Z))
 .. K RORIEN,RORFDA1 S RORIEN=Z
 . I $P(RORDATA,U,2)'="" D  Q  ; Add ICD-codes to the entry
 .. S RORPROC=$P(RORDATA,U,2)
 .. F I1=1:1:$L(RORPROC,",") S X=$P(RORPROC,",",I1) I X'="" S CT=CT+1,RORFDA(798.52,"+"_CT_","_RORIEN_",",.01)=X
 . I $P(RORDATA,U,3)'="" D  Q  ; Add ICPT codes to the entry
 .. S RORPROC=$P(RORDATA,U,3)
 .. F I1=1:1:$L(RORPROC,",") S X=$P(RORPROC,",",I1) I X'="" S CT=CT+1,RORFDA(798.53,"+"_CT_","_RORIEN_",",.01)=X
 . I $P(RORDATA,U,4)'="" D  Q  ; Add ICD diagnosis codes to the entry
 .. S RORPROC=$P(RORDATA,U,4)
 .. F I1=1:1:$L(RORPROC,",") S X=$P(RORPROC,",",I1) I X'="" S CT=CT+1,RORFDA(798.51,"+"_CT_","_RORIEN_",",.01)=X
 .. ;
 I $D(RORFDA) D ADD7985(.RORFDA,RORIEN,RORREG)
 D CLEAN^DILF
 Q
 ;
ADD7985(RORFDA,RORIEN,RORREG) ; Adds procedures to the entries in the files
 N RORMSG,DIERR
 D UPDATE^DIE("E","RORFDA","RORIEN","RORMSG")
 I $G(DIERR) D
 . N Z,CT,RORERR
 . M RORERR=RORMSG
 . D DBS^RORERR("RORMSG",-112,,,798.5,RORREG)
 . M RORMSG=RORERR
 . K RORERR
 . S RORERR(1)="     Adding procedures for new registry "_RORREG_" encountered the"
 . S RORERR(2)="     following error.  Please report this error to your CCR contact:"
 . S RORERR(3)=""
 . S Z=0,CT=3 F  S Z=$O(RORMSG("DIERR",1,"TEXT",Z)) Q:'Z  S CT=CT+1,RORERR(CT)=$J("",10)_$G(RORMSG("DIERR",1,"TEXT",Z))
 . S CT=CT+1,RORERR(CT)=" "
 . D MES^XPDUTL(.RORERR)
 Q
 ;
ICDPROC ; Registry name^PTF ICD Procedure codes, separated by commas^PTF CPT codes, separated by commas^ ICD DIAGNOSIS codes
 ;;VA LYMPHOMA
 ;;^^^202.80,201.90,C91.50,C91.51,C91.52
 ;;^^^C84.70,C84.71,C84.72,C84.73,C84.74,C84.75,C84.76,C84.77,C84.78,C84.79
 ;;^^^C84.60,C84.61,C84.62,C84.63,C84.64,C84.65,C84.66,C84.67,C84.68,C84.69
 ;;^^^C85.10,C85.11,C85.12,C85.13,C85.14,C85.15,C85.16,C85.17,C85.18,C85.19
 ;;^^^C83.50,C83.51,C83.52,C83.53,C83.54,C83.55,C83.56,C83.57,C83.58,C83.59
 ;;^^^C88.0,C88.3,C88.4
 ;;^^^C83.70,C83.71,C83.72,C83.73,C83.74,C83.75,C83.76,C83.77,C83.78,C83.79
 ;;^^^C83.10,C83.11,C83.12,C83.13,C83.14,C83.15,C83.16,C83.17,C83.18,C83.19
 ;;^^^C82.60,C82.61,C82.62,C82.63,C82.64,C82.65,C82.66,C82.67,C82.68,C82.69 
 ;;^^^C84.A0,C84.A1,C84.A2,C84.A3,C84.A4,C84.A5,C84.A6,C84.A7,C84.A8,C84.A9
 ;;^^^C82.50,C82.51,C82.52,C82.53,C82.54,C82.55,C82.56,C82.57,C82.58,C82.59
 ;;^^^C83.30,C83.31,C83.32,C83.33,C83.34,C83.35,C83.36,C83.37,C83.38,C83.39
 ;;^^^C86.0,C86.1,C86.2,C86.3,C86.4,C86.5,C86.6
 ;;^^^C82.90,C82.91,C82.92,C82.93,C82.94,C82.95,C82.96,C82.97,C82.98,C82.99
 ;;^^^C82.00,C82.01,C82.02,C82.03,C82.04,C82.05,C82.06,C82.07,C82.08,C82.09
 ;;^^^C82.10,C82.11,C82.12,C82.13,C82.14,C82.15,C82.16,C82.17,C82.18,C82.19
 ;;^^^C82.20,C82.21,C82.22,C82.23,C82.24,C82.25,C82.26,C82.27,C82.28,C82.29
 ;;^^^C82.30,C82.31,C82.32,C82.33,C82.34,C82.35,C82.36,C82.37,C82.38,C82.39
 ;;^^^C82.40,C82.41,C82.42,C82.43,C82.44,C82.45,C82.46,C82.47,C82.48,C82.49
 ;;^^^C82.80,C82.81,C82.82,C82.83,C82.84,C82.85,C82.86,C82.87,C82.88,C82.89
 ;;^^^C85.90,C85.91,C85.92,C85.93,C85.94,C85.95,C85.96,C85.97,C85.98,C85.99
 ;;^^^C96.A
 ;;^^^C81.90,C81.91,C81.92,C81.93,C81.94,C81.95,C81.96,C81.97,C81.98,C81.99
 ;;^^^C81.30,C81.31,C81.32,C81.33,C81.34,C81.35,C81.36,C81.37,C81.38,C81.39
 ;;^^^C81.40,C81.41,C81.42,C81.43,C81.44,C81.45,C81.46,C81.47,C81.48,C81.49
 ;;^^^C81.20,C81.21,C81.22,C81.23,C81.24,C81.25,C81.26,C81.27,C81.28,C81.29
 ;;^^^C81.00,C81.01,C81.02,C81.03,C81.04,C81.05,C81.06,C81.07,C81.08,C81.09
 ;;^^^C81.10,C81.11,C81.12,C81.13,C81.14,C81.15,C81.16,C81.17,C81.18,C81.19
 ;;^^^C81.70,C81.71,C81.72,C81.73,C81.74,C81.75,C81.76,C81.77,C81.78,C81.79
 ;;^^^C83.80,C83.81,C83.82,C83.83,C83.84,C83.85,C83.86,C83.87,C83.88,C83.89
 ;;^^^C84.40,C84.41,C84.42,C84.43,C84.44,C84.45,C84.46,C84.47,C84.48,C84.49
 ;;^^^C83.00,C83.01,C83.02,C83.03,C83.04,C83.05,C83.06,C83.07,C83.08,C83.09
 ;;^^^C84.90,C84.91,C84.92,C84.93,C84.94,C84.95,C84.96,C84.97,C84.98,C84.99
 ;;^^^C84.Z0,C84.Z1,C84.Z2,C84.Z3,C84.Z4,C84.Z5,C84.Z6,C84.Z7,C84.Z8,C84.Z9
 ;;^^^C85.20,C85.21,C85.22,C85.23,C85.24,C85.25,C85.26,C85.27,C85.28,C85.29
 ;;^^^C83.90,C83.91,C83.92,C83.93,C83.94,C83.95,C83.96,C83.97,C83.98,C83.99
 ;;^^^C85.80,C85.81,C85.82,C85.83,C85.84,C85.85,C85.86,C85.87,C85.88,C85.89
 ;;VA NASH
 ;;^^^571.8,K75.81,571.40,571.41,571.49,K76.0
 ;;VA ILD
 ;;^^^501.,508.1,495.9,518.89,515.,516.0,516.1,516.2,516.30,516.31,516.32
 ;;^^^516.33,516.34,516.35,516.36,516.37,516.4,516.5,516.61,516.62,516.63
 ;;^^^516.64,516.69,516.9,517.8,714.81
 ;;^^^J84.10,J84.89,J84.01,J84.03,J84.02
 ;;^^^J84.111,J84.112,J84.113,J84.114,J84.115,J84.2,J84.116,J84.117
 ;;^^^J84.81,J84.82,J84.841,J84.842,J84.83,J84.843,J84.848,J84.9,D86.0,D86.1,D86.2
 ;;^^^J99.,M32.13,M33.01,M35.02,M33.11,M33.91,M33.21
 ;;^^^M05.19,M05.112,M05.111,M05.119,M05.121,M05.122,M05.129
 ;;^^^M05.131,M05.132,M05.139,M05.141,M05.142,M05.149,M05.151,M05.152,M05.159
 ;;^^^M05.161,M05.162,M05.169,M05.171,M05.172,M05.179,J61.,J70.1,J67.9
 Q
 ;
UPDLIST  ; --- Update ROR LIST ITEM file (#799.1) for new registries
 N RORI,RORI1,RORREG,RORDATA,REGIEN,Z,CT,DIERR,RORFDA,RORMSG,RORERR
 F RORI=1:1 S RORREG=$P($P($T(@("NEWREG+"_RORI_"^RORP034")),";;",2),U) Q:RORREG=""  D
 . S REGIEN=$$REGIEN^RORUTL02(RORREG)
 . I REGIEN>0 D
 ..  F RORI1=1:1 S RORDATA=$P($T(@("LISTITEM+"_RORI1_"^RORP034")),";;",2) Q:RORDATA=""  D
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
LISTITEM ; --- Entries to add to ROR LIST ITEM file (#799.1)  text^group^code
 ;;eGFR by CKD-EPI^7^3
 ;;eGFR by MDRD^7^2
 ;;Creatinine clearance by Cockcroft-Gault^7^1
 ;;FIB-4^6^4
 ;;APRI^6^3
 ;;MELD-Na^6^2
 ;;MELD^6^1
 ;;BMI^5^1
 ;;
 ; 
