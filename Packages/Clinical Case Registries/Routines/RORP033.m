RORP033 ;ALB/MAF - CCR PRE/POST-INSTALL PATCH 33 ;18 Apr 2018  1:38 PM
 ;;1.5;CLINICAL CASE REGISTRIES;**33**;Feb 17, 2006;Build 81
 ;
 ;*****************************************************************************
 ;*****************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;  
 ;PKG/PATCH    DATE       DEVELOPER    MODIFICATION
 ;-----------  ---------  -----------  ----------------------------------------
 ;ROR*1.5*33   Mar 2018   M FERRARESE  Added routine for env check, pre/post
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
PRE ; --- Pre-Install routine for Patch 32
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
 F RORI=1:1 S RORREG=$P($P($T(@("NEWREG+"_RORI_"^RORP033")),";;",2),U) Q:RORREG=""  D  Q:$G(XPDABORT)
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
POST ; --- Post-Install routine for Patch 32
 N CT,RORI,RORREG,REGIEN,Z
 N RORPARM
 S RORPARM("DEVELOPER")=1
 D BMES^XPDUTL("POST INSTALL START")
 ;
 D BMES^XPDUTL(">> Adding new LOINC codes to the VA HIV registry parameters")
 D LOINC
 D BMES^XPDUTL("   >> Step complete")
 ;
 D BMES^XPDUTL(">> Adding new Future Appointments panel to reports")
 D UPDPANEL
 D BMES^XPDUTL("   >> Step complete")
 ;
 D BMES^XPDUTL("Checking VA GENERIC drug file..Bictegravir/emtricitabine/tenofovir alafenamide ")
 D BMES^XPDUTL("                            ..Efavirenz/lamivudine/tenofovir disoproxil fumarate ")
 D BMES^XPDUTL("                            ..Lamivudine/tenofovir disoproxil fumarate ")
 D GENDRG
 D BMES^XPDUTL("   >> Step complete")
 D CLEAN^DILF
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
 F RORI=1:1 S RORREG=$P($P($T(@("NEWREG+"_RORI_"^RORP033")),";;",2),U) Q:RORREG=""  D
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
 ;  HIV registry  : BICTEGRAVIR/EMTRICITABINE/TENOFOVIR ALAFENAMIDE - "BICTEGRAVIR/EMTRICITABINE/TENOFOVIRQW"  Released in PSN*4*
 ;                : EFAVIRENZ/LAMIVUDINE/TENOFOVIR DISOPROXIL FUMARATE - "EFAVIRENZ/LAMIVUDINE/TENOFOVIR"  Released in PSN*4*
 ;                : LAMIVUDINE/TENOFOVIR DISOPROXIL FUMARATE - "LAMIVUDINE/TENOFOVIR"  Released in PSN*4* 
 ;
 ;
 N DIC,X,DIK,DA,RORNAME,Y
 S DIC=799.51,DIC(0)="MNZ"
 F RORNAME="BICTEGRAVIR/EMTRICITABINE/TENOFOVIR","EFAVIRENZ/LAMIVUDINE/TENOFOVIR","LAMIVUDINE/TENOFOVIR" D
 .S X=RORNAME D ^DIC Q:+Y<0
 .Q:+$P(Y(0),U,4)>0
 .S DA=+Y,DIK="^ROR(799.51," D ^DIK
 .D BMES^XPDUTL("WARNING*** Missing entry in VA GENERIC file 50.6.")
 Q
 ; 
LOINC ;Add new LOINC codes to the VA HIV lab search criterion in
 ;ROR LAB SEARCH file #798.9.  Don't add them if they already exist.  Don't
 ;add the 'dash' or the number following it (checksum)
 ;**********************************************************************
 N I,HEPCIEN,HIVIEN,RORDATA,RORLOINC,RORTAG,ROR K RORMSG1,RORMSG2
 S HIVIEN=$O(^ROR(798.9,"B","VA HIV",0)) ;HIV top level IEN
 ;--- add LOINC codes to the VA HIV search criteria
 F I=1:1  S RORTAG="HIV+"_I,ROR=$P($T(@RORTAG),";;",2) Q:ROR=""  D
 . S RORLOINC=$P(ROR,"-",1)
 . ;don't add if it's already in the global
 . Q:($D(^ROR(798.9,HIVIEN,1,"B",RORLOINC)))
 . S RORDATA(1,798.92,"+2,"_HIVIEN_",",.01)=$G(RORLOINC)
 . S RORDATA(1,798.92,"+2,"_HIVIEN_",",1)=6
 . D UPDATE^DIE("","RORDATA(1)",,"RORMSG1")
 K RORDATA,RORMSG1,RORMSG2
 ;
 Q
 ;
 ;**********************************************************************
 ;New LOINC codes
 ;**********************************************************************
HIV ;
 ;;28004-0
 ;;42768-2
 ;;48345-3
 ;;51866-2
 ;;56888-1
 ;;57975-5
 ;;58900-2
 ;;68961-2
 ;;69668-2
 ;;73906-0
 ;;75666-8
 ;;80203-3
 ;;81641-3
 ;;85037-0
 ;;
 ;
UPDPANEL ;
 ; For parameter panel field, add 29, after ,24, right below the Additional Identifiers panel for
 ;     Combined Meds and Labs    (REPORT CODE=12)
 ;     Hepatitis A Vaccine or Immunity   (REPORT CODE=24)  
 ;     Hepatitis B Vaccine of Immunity   (REPORT CODE=25) 
 ;     Liver Score by Range    (REPORT CODE=19)  
 ;     Registry Lab Tests by Range    (REPORT CODE=10) 
 ;     Renal Function by Range    (REPORT CODE=20)
 ;     BMI by Range    (REPORT CODE=18)
 ;
 ; In the Hepatitis C registry right below the Additional Identifiers panel
 ;     Potential DAA Candidates (REPORT CODE=21)
 ;     BMI by Range    (REPORT CODE=18)
 ;
 N CT,RORRPT,RORMSG,RORPAN,RORERR,RORFDA,Z,Z1,DIERR
 S RORRPT=0 F  S RORRPT=$O(^ROR(799.34,RORRPT)) Q:'RORRPT  S RORPAN=$P($G(^ROR(799.34,RORRPT,0)),U,4) D:$S(RORPAN=10:1,RORPAN=12:1,RORPAN=18:1,RORPAN=19:1,RORPAN=20:1,RORPAN=21:1,RORPAN=24:1,RORPAN=25:1,1:0)
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
 ;;VA TRANSPLANT HEART
 ;;VA TRANSPLANT INTESTINE
 ;;VA TRANSPLANT KIDNEY
 ;;VA TRANSPLANT LIVER
 ;;VA TRANSPLANT LUNG
 ;;VA TRANSPLANT PANCREAS
 ;;
 ;
UPDPROC ; --- Update ROR LIST ITEM file (#799.1) for new registriesAdds ICD dx/procedure codes and CPT codes to the new registries in ROR ICD file
 ; Delete if already there
 N CT,I1,DA,DIK,X,Y,Z,RORDATA,RORFDA,RORI,RORPROC,RORREG,RORIEN,RORFDA1
 F RORI="TRANSPLANT HEART","TRANSPLANT INTESTINE","TRANSPLANT KIDNEY","TRANSPLANT LIVER","TRANSPLANT LUNG","TRANSPLANT PANCREAS" S DIC="^ROR(798.5,",X="VA "_RORI,DIC(0)="" D ^DIC I Y>0 D
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
 ;;VA TRANSPLANT HEART
 ;;^^^996.83,V42.1,V43.21,V43.22,T86.20,T86.21,T86.22,T86.23,T86.290,T86.298,T86.30,T86.31,T86.32,T86.33,T86.39,Z48.21,Z48.280,Z94.1,Z94.3
 ;;VA TRANSPLANT INTESTINE
 ;;^^^996.87,V42.84,Z94.82,T86.850,T86.851,T86.852,T86.858,T86.859,
 ;;VA TRANSPLANT KIDNEY
 ;;^^^V42.0,T86.10,T86.11,T86.12,T86.13,T86.19,Z48.22,Z94.0
 ;;VA TRANSPLANT LIVER
 ;;^^^996.82,V42.7,T86.40,T86.41,T86.42,T86.43,T86.49,Z48.23,Z94.4
 ;;VA TRANSPLANT LUNG
 ;;^^^996.84,V42.6,T86.30,T86.31,T86.32,T86.33,T86.39,T86.810,T86.811,T86.812,T86.818,T86.819,Z48.24,Z48.280,Z94.2
 ;;VA TRANSPLANT PANCREAS
 ;;^^^996.86,V42.83,Z94.83
 Q
 ;
UPDLIST  ; --- Update ROR LIST ITEM file (#799.1) for new registries
 N RORI,RORI1,RORREG,RORDATA,REGIEN,Z,CT,DIERR,RORFDA,RORMSG,RORERR
 F RORI=1:1 S RORREG=$P($P($T(@("NEWREG+"_RORI_"^RORP033")),";;",2),U) Q:RORREG=""  D
 . S REGIEN=$$REGIEN^RORUTL02(RORREG)
 . I REGIEN>0 D
 ..  F RORI1=1:1 S RORDATA=$P($T(@("LISTITEM+"_RORI1_"^RORP033")),";;",2) Q:RORDATA=""  D
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
