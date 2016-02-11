RORP026 ;ALB/TK  ENV CK, PRE and POST INSTALL - PATCH 26 ; 04 Aug 2015  6:28 PM
 ;;1.5;CLINICAL CASE REGISTRIES;**26**;Feb 17, 2006;Build 53
 ;
 ;*****************************************************************************
 ;*****************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE       DEVELOPER    MODIFICATION
 ;-----------  ---------  -----------  ----------------------------------------
 ;ROR*1.5*26   JAN 2015   T KOPP       Added routine for env check, pre/post
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
 ;  ADD^XPAR      #2263
 ;  DEL^XPAR      #2263
 ;  CLEAN^DILF    #2054
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
 F RORI=1:1 S RORREG=$P($P($T(@("NEWREG+"_RORI_"^RORP026")),";;",2),U) Q:RORREG=""  D  Q:$G(XPDABORT)
 . S REGIEN=$$REGIEN^RORUTL02(RORREG)
 . Q:REGIEN'>0  ; new registry doesn't yet exist
 . ; Check if registry is already initiated (has a value in HDT field)
 . S Z=$$GET1^DIQ(798.1,REGIEN_",",21.05,"I")
 . I Z'="" D  Q
 .. S DIR(0)="YA",DIR("A",1)="  >> New registry "_RORREG_"(ien #"_REGIEN_") has already completed initialization"
 .. S DIR("A")="Do you want to rerun its initialization?: ",DIR("B")="NO"
 .. W ! D ^DIR K DIR W !
 .. I Y<0 S XPDABORT=2 K ^XTMP("ROR_NO_INIT") D BMES^XPDUTL("INSTALL ABORTED") Q
 .. I Y'=1 S ^XTMP("ROR_NO_INIT",REGIEN)=""
 Q
 ;
POST ; Patch post-install
 N CT,RORI,RORREG,REGIEN,Z
 N RORPARM
 S RORPARM("DEVELOPER")=1
 D BMES^XPDUTL("POST INSTALL START")
 ;
 D BMES^XPDUTL(">> Adding Liver Transplantation diagnosis group to common templates")
 D DXGRP
 D BMES^XPDUTL("   >> Step complete")
 ;
 D BMES^XPDUTL(">> Adding new panels to reports")
 D UPDPANEL
 D BMES^XPDUTL("   >> Step complete")
 ;
 D BMES^XPDUTL(">> Adding inpatient procedures fields to ROR METADATA file")
 D UPDMETA
 D BMES^XPDUTL("   >> Step complete")
 ;
 D BMES^XPDUTL(">> Adding CPT and ICD-9 procedures to ROR ICD SE""ARCH file for new registries")
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
 F RORI=1:1 S RORREG=$P($P($T(@("NEWREG+"_RORI_"^RORP026")),";;",2),U) Q:RORREG=""  D
 . S REGIEN=$$REGIEN^RORUTL02(RORREG)
 . Q:REGIEN'>0
 . I $D(^XTMP("ROR_NO_INIT",REGIEN)) D  Q
 .. S RORERR(1)="   It appears new registry "_RORREG_"(ien #"_REGIEN_") has already been initialized"
 .. S RORERR(2)="   You have chosen not to re-initialize this registry"
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
 D BMES^XPDUTL("   >> Step complete")
 ;
 D CLEAN^DILF
 D BMES^XPDUTL("POST INSTALL COMPLETE")
 Q
 ;
NEWREG ; List of new registries to initialize
 ;;VA TOTAL KNEE
 ;;VA TOTAL HIP
 ;;
UPDPROC ; Adds ICD dx/procedure codes and CPT codes to the new registries in ROR ICD file
 ; Delete if already there
 N CT,I1,DA,DIK,X,Y,Z,RORDATA,RORFDA,RORI,RORPROC,RORREG,RORIEN,RORFDA1
 F RORI="KNEE","HIP" S DIC="^ROR(798.5,",X="VA TOTAL "_RORI,DIC(0)="" D ^DIC I Y>0 D
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
 ;;VA TOTAL KNEE
 ;;^81.54,81.55,00.80,00.81,00.82,00.83,00.84,0SRC07Z,0SRC0J9,0SRC0JA,0SRC0JZ,0SRC0KZ
 ;;^0SRD07Z,0SRD0J9,0SRD0JA,0SRD0JZ,0SRD0KZ,0SRT07Z,0SRT0J9,0SRT0JA,0SRT0JZ,0SRT0KZ,0SRU07Z
 ;;^0SRU0J9,0SRU0JA,0SRU0JZ,0SRU0KZ,0SRV07Z,0SRV0J9,0SRV0JA,0SRV0JZ,0SRV0KZ,0SRW07Z,0SRW0J9
 ;;^0SRW0JA,0SRW0JZ,0SRW0KZ
 ;;^^27447
 ;;^^^V43.65,Z96.651,Z96.652,Z96.653,Z96.659
 ;;VA TOTAL HIP
 ;;^00.70,00.71,00.72,00.73,00.74,00.75,00.76,00.77,81.51,81.52,81.53,0SR901Z,0SR9019,0SR901A
 ;;^0SR9029,0SR902A,0SR902Z,0SR9039,0SR903A,0SR903Z,0SR9049,0SR904A,0SR904Z,0SR907Z,0SR90J9
 ;;^0SR90JA,0SR90JZ,0SR90KZ,0SRB019,0SRB01A,0SRB01Z,0SRB029,0SRB02A,0SRB02Z,0SRB039,0SRB03A
 ;;^0SRB03Z,0SRB049,0SRB04A,0SRB04Z,0SRB07Z,0SRB0J9,0SRB0JA,0SRB0JZ,0SRB0KZ
 ;;^^27130,27132
 ;;^^^V43.64,Z96.641,Z96.642,Z96.643,Z96.649
 Q
 ;
UPDMETA ;
 ; Add 2 new outpatient procedure fields to file 45 in the ROR METADATA file (delete first if they already exist)
 N DIERR,DA,DIC,DIK,X,Y,Z,RORIEN,RORFDA,RORI,RORDATA,RORIENS,RORMSG,Z,CT,RORERR
 F RORI=1:1:2 S RORDATA=$P($T(META45+RORI),";;",2) D
 . S RORDATA(RORI)=RORDATA
 . S X=$P(RORDATA,U),DA(1)=45,DIC="^ROR(799.2,"_DA(1)_",2," D ^DIC
 . I Y>0 S DA(1)=45,DIK="^ROR(799.2,"_DA(1)_",2,",DA=+Y D ^DIK
 S RORIEN(1)=45,RORDATA=0
 F RORI=1:1 S RORDATA=$O(RORDATA(RORDATA)) Q:RORDATA=""  D
 . S RORIENS="+"_(RORI+1)_",45,"
 . S RORFDA(799.22,RORIENS,.01)=$P(RORDATA(RORI),U)
 . S RORFDA(799.22,RORIENS,.02)=$P(RORDATA(RORI),U,2)
 . S RORFDA(799.22,RORIENS,4)=$P(RORDATA(RORI),U,3)
 . S RORFDA(799.22,RORIENS,1)=$P(RORDATA(RORI),U,4)
 D UPDATE^DIE(,"RORFDA","RORIEN","RORMSG")
 I $D(DIERR) D
 . D BMES^XPDUTL("Update to ROR METADATA <<FAILED>>")
 . K RORERR
 . M RORERR=RORMSG
 . D DBS^RORERR("RORMSG",-112,,,799.22,45)
 . M RORMSG=RORERR
 . K RORERR
 . S RORERR(1)="    Update to ROR METADATA file has <<FAILED>>"
 . S RORERR(2)="    Please report this error to your CCR contact:"
 . S RORERR(3)=""
 . S Z=0,CT=3 F  S Z=$O(RORMSG("DIERR",1,"TEXT",Z)) Q:'Z  S CT=CT+1,RORERR(CT)=$J("",10)_$G(RORMSG("DIERR",1,"TEXT",Z))
 . S CT=CT+1,RORERR(CT)=" "
 . D MES^XPDUTL(.RORERR)
 Q
 ;
 ; Data to be added to ROR METADATA file (#799.2/799.22)
 ; DATA NAME^CODE^VALUE TYPE^LOADER API
META45 ; Elements to add to file 45 entry in ROR METADATA
 ;;INPATIENT ICD PROCEDURE^152^I^3
 ;;INPATIENT CPT^153^I^3
 Q
 ;
UPDPANEL ;
 ; For parameter panel field, add 27, after ,25, for all except Sustained Virologic Report (REPORT CODE=23),
 ; DAA Lab Monitoring (REPORT CODE=22) and Potential DAA Candidates (REPORT CODE=21)
 ; For Potential DAA report - add panels 201,47 after ,90,
 N CT,RORRPT,RORMSG,RORPAN,RORERR,RORFDA,Z,Z1,DIERR
 S RORRPT=0 F  S RORRPT=$O(^ROR(799.34,RORRPT)) Q:'RORRPT  S RORPAN=$P($G(^ROR(799.34,RORRPT,0)),U,4) D:$S(RORPAN=23:0,RORPAN=22:0,1:1)
 . S Z1=$G(^ROR(799.34,RORRPT,1))
 . K RORFDA,RORMSG
 . I RORPAN=21 D
 .. I Z1'[",201,47,",Z1[",90," S RORFDA(799.34,RORRPT_",",1)=$P(Z1,",90,")_",90,201,47,"_$P(Z1,",90,",2)
 . I RORPAN'=21 D
 .. I Z1[",25,",Z1'[",25,27," S RORFDA(799.34,RORRPT_",",1)=$P(Z1,",25,")_",25,27,"_$P(Z1,",25,",2)
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
 ; Sets the DIR array from the post-install question #3 (suspension start time)
POSQ3(DIR) ;
 K:$G(XPDQUES("POSQ2"))'=1 DIR
 Q:'$D(DIR)
 D BLD^DIALOG(7980000.011,,,"DIR(""?"")","S")
 Q
 ;
 ; Update ROR LIST ITEM file (#799.1) for new registries
UPDLIST  ;
 N RORI,RORI1,RORREG,RORDATA,REGIEN,Z,CT,DIERR,RORFDA,RORMSG,RORERR
 F RORI=1:1 S RORREG=$P($P($T(@("NEWREG+"_RORI_"^RORP026")),";;",2),U) Q:RORREG=""  D
 . S REGIEN=$$REGIEN^RORUTL02(RORREG)
 . I REGIEN>0 D
 .. F RORI1=1:1 S RORDATA=$P($T(@("LISTITEM+"_RORI1_"^RORP026")),";;",2) Q:RORDATA=""  D
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
 ;******************************************************************************
 ;Add new ICD9 entry/group "Liver Transplantation" to the PARAMETERS file #8989.5
 ;ADD^XPAR(entity,parameter[,instance],value[,.error])
 ;*****************************************************************************
DXGRP ;
 N RORPARAMETER,RORENTITY,RORINSTANCE,RORVALUE,RORERR
 S RORENTITY="PKG.CLINICAL CASE REGISTRIES"
 S RORPARAMETER="ROR REPORT PARAMS TEMPLATE"
 S RORINSTANCE="13::Liver Transplantation"
 ;delete it first (in case it already exists)
 D DEL^XPAR(RORENTITY,RORPARAMETER,RORINSTANCE,.RORERR)
 S RORVALUE="CCR Predefined Report Template"
 S RORVALUE(1,0)="<?xml version="_"""1.0"""_" encoding="_"""UTF-8"""_"?>"
 S RORVALUE(2,0)="<PARAMS>"
 S RORVALUE(3,0)="<ICD9LST>"
 S RORVALUE(4,0)="<GROUP ID="_"""Liver Transplantation"""_">"
 S RORVALUE(5,0)="<ICD ID=""V42.7"" VERSION=""ICD-9"">LIVER TRANSPLANT STATUS (CC)</ICD>"
 S RORVALUE(6,0)="<ICD ID=""996.82"" VERSION=""ICD-9"">COMPL OF TRANSPLANTED LIVER (CC)</ICD>"
 S RORVALUE(7,0)="<ICD ID=""T86.40"" VERSION=""ICD-10"">UNSPECIFIED COMPLICATION OF LIVER TRANSPLANT</ICD>"
 S RORVALUE(8,0)="<ICD ID=""T86.41"" VERSION=""ICD-10"">LIVER TRANSPLANT REJECTION</ICD>"
 S RORVALUE(9,0)="<ICD ID=""T86.42"" VERSION=""ICD-10"">LIVER TRANSPLANT FAILURE</ICD>"
 S RORVALUE(10,0)="<ICD ID=""T86.43"" VERSION=""ICD-10"">LIVER TRANSPLANT INFECTION</ICD>"
 S RORVALUE(11,0)="<ICD ID=""T86.49"" VERSION=""ICD-10"">OTHER COMPLICATIONS OF LIVER TRANSPLANT</ICD>"
 S RORVALUE(12,0)="<ICD ID=""Z48.23"" VERSION=""ICD-10"">ENCOUNTER FOR AFTERCARE FOLLOWING LIVER TRANSPLANT</ICD>"
 S RORVALUE(13,0)="<ICD ID=""Z94.4"" VERSION=""ICD-10"">LIVER TRANSPLANT STATUS</ICD10>"
 S RORVALUE(14,0)="</GROUP>"
 S RORVALUE(15,0)="</ICD9LST>"
 S RORVALUE(16,0)="<PANELS>"
 S RORVALUE(17,0)="<PANEL ID="_"""160"""_"/>"
 S RORVALUE(18,0)="</PANELS>"
 S RORVALUE(19,0)="</PARAMS>"
 ;add it
 D ADD^XPAR(RORENTITY,RORPARAMETER,RORINSTANCE,.RORVALUE,.RORERR)
 Q
 ;
