SD628PST ;ALB/BNT - Scheduling Enhancements Post Install Routine ;11/04/2014
 ;;5.3;Scheduling;**628**;Aug 13, 1993;Build 371
 ;
 Q
 ;
POST ; Entry point for post install
 D MES^XPDUTL("  Starting post-install of SD*5.3*628")
 ;
STPCDS ; Set up default PRIMARY CARE STOP CODES
 N LIST,X
 D REMSTP
 ;
 ; Set up Primary Care Stop Codes
 D GETLST^XPAR(.LIST,"PKG.SCHEDULING","SDEC PRIMARY CARE STOP CODES","B")
 I $G(LIST)=0 D SETPCDEF
 ; Display current Primary Care Stop Codes
 I +$G(LIST) D
 . W ! D MES^XPDUTL("    Active Primary Care Stop Codes...")
 . S X="" F  S X=$O(LIST(X)) Q:X=""  I $P(LIST(X,"V"),U) D
 . . D MES^XPDUTL("    - "_$P(LIST(X,"N"),U,2))
 ;
 ; Set up Specialty Care Stop Codes
 N LIST,X D GETLST^XPAR(.LIST,"PKG.SCHEDULING","SDEC SPECIALTY CARE STOP CODES","B")
 I $G(LIST)=0 D SETSCDEF
 ; Display current Specialty Care Stop Codes
 I +$G(LIST) D
 . W ! D MES^XPDUTL("    Active Specialty Care Stop Codes...")
 . S X="" F  S X=$O(LIST(X)) Q:X=""  I $P(LIST(X,"V"),U) D
 . . D MES^XPDUTL("    - "_$P(LIST(X,"N"),U,2))
 ;
 ; Set up Mental Health Stop Codes
 N LIST,X D GETLST^XPAR(.LIST,"PKG.SCHEDULING","SDEC MENTAL HEALTH STOP CODES","B")
 I $G(LIST)=0 D SETMHDEF
 ; Display current Mental Health Stop Codes
 I +$G(LIST) D
 . W ! D MES^XPDUTL("    Active Mental Health Stop Codes...")
 . S X="" F  S X=$O(LIST(X)) Q:X=""  I $P(LIST(X,"V"),U) D
 . . D MES^XPDUTL("    - "_$P(LIST(X,"N"),U,2))
 ;
 F REGRPC="SD VSE FILTER RPC","SD VSE REPORT RPC" D REGRPC(REGRPC,"SDECRPC")
 ;
 ; Schedule background build of data in ^TMP
 D SCHTSK("SDEC REPORT DATA")
 ;
 ; Build VSE Encounter and Appointment Data from Scheduling files into ^XTMP
 ; Remove old ^XTMP files first
 K ^XTMP("SDVSE"),^XTMP("SDCEX"),^TMP("SDCEX"),^TMP("SDVSE"),^TMP("SDRPC")
 W !,"Queuing job to Re-Index the OUTPATIENT ENCOUNTER file (#409.68)"
 W !,"Queuing job to build VSE GUI Resource Management Report data"
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSK
 S ZTIO=""
 S ZTRTN="TSKINDX^SD628PST"
 S ZTDTH=$$NOW^XLFDT
 S ZTDESC="SD*5.3*628 Post Init Data Compiler"
 D ^%ZTLOAD
 Q
 ;
TSKINDX ; Re-Index the Outpatient Encounter file then start background job to compile report data
 ; If the 'D' new style index does not exist then re-index file 409.68
 N SDECMAIL S SDECMAIL=1 ; Flag to send data collection statistics mail message to installer.
 I '$D(^SCE("D")) N DIK S DIK="^SCE(",DIK(1)=".01^D" D ENALL^DIK
 ; Run the Resource Management Report Compiler
 D EN^SDCED
 Q
 ;
SCHTSK(OPTNAME) ; Schedule Option
 N SCHNM,DIC,X,Y,SDIEN S SDIEN=""
 Q:$G(OPTNAME)=""
 S DIC(0)="I",X=OPTNAME,DIC="^DIC(19,"
 D ^DIC Q:'(Y>0)  S SCHNM=+Y
 ;D CLEAN^DILF
 S FDA(19.2,"?+1,",.01)=SCHNM,X=SCHNM
 I 'SCHNM D  Q
 .W !,OPTNAME," option can't be scheduled - option does not exist"
 S FDA(19.2,"?+1,",1)=SCHNM
 S FDA(19.2,"?+1,",2)=$P($$NOW^XLFDT,".")_".03"
 S FDA(19.2,"?+1,",6)="1D"
 D UPDATE^DIE("","FDA","SDIEN")
 W !,"Scheduled option ",OPTNAME
 D CLEAN^DILF
 ; Set the ^XTMP("SDECMAIL",0) Global with the user ID of installer
 S ^XTMP("SDECMAIL",0)=$$FMADD^XLFDT($$NOW^XLFDT,7,0,0,)_"^"_+$G(DUZ)
 Q 
 ;
SETPCDEF ; Create the default SCHEDULING PRIMARY CARE STOP CODE list
 N LINE,NUM,DATA,DESC,ERR,AMIS,IEN
 D MES^XPDUTL("    Activating Default Primary Care Stop Codes...")
 F LINE=1:1 S DATA=$P($T(DFPCPRMS+LINE),";;",2,99) Q:DATA=""  D
 . S AMIS=$P(DATA,U),DESC=$P(DATA,U,2),IEN=$O(^DIC(40.7,"C",AMIS,0))
 . S ERR=0
 . D EN^XPAR("PKG.SCHEDULING","SDEC PRIMARY CARE STOP CODES","`"_+IEN,1,.ERR)
 . I 'ERR D MES^XPDUTL("    - Activated "_DESC) Q
 . E  D MES^XPDUTL("    - Error Activating "_DESC)
 Q
 ;
SETSCDEF ; Create the default SCHEDULING SPECIALTY CARE STOP CODE list
 N LINE,NUM,DATA,DESC,ERR,AMIS,IEN
 W ! D MES^XPDUTL("    Activating Default Specialty Care Stop Codes...")
 F LINE=1:1 S DATA=$P($T(DFSCPRMS+LINE),";;",2,99) Q:DATA=""  D
 . S AMIS=$P(DATA,U),DESC=$P(DATA,U,2),IEN=$O(^DIC(40.7,"C",AMIS,0))
 . S ERR=0
 . D EN^XPAR("PKG.SCHEDULING","SDEC SPECIALTY CARE STOP CODES","`"_+IEN,1,.ERR)
 . I 'ERR D MES^XPDUTL("    - Activated "_DESC) Q
 . E  D MES^XPDUTL("    - Error Activating "_DESC)
 Q
 ;
SETMHDEF ; Create the default SCHEDULING MENTAL HEALTH STOP CODE list
 N LINE,NUM,DATA,DESC,ERR,AMIS,IEN
 W ! D MES^XPDUTL("    Activating Default Mental Health Stop Codes...")
 F LINE=1:1 S DATA=$P($T(DFMHPRMS+LINE),";;",2,99) Q:DATA=""  D
 . S AMIS=$P(DATA,U),DESC=$P(DATA,U,2),IEN=$O(^DIC(40.7,"C",AMIS,0))
 . S ERR=0
 . D EN^XPAR("PKG.SCHEDULING","SDEC MENTAL HEALTH STOP CODES","`"_+IEN,1,.ERR)
 . I 'ERR D MES^XPDUTL("    - Activated "_DESC) Q
 . E  D MES^XPDUTL("    - Error Activating "_DESC)
 Q
 ;
REMSTP ; Remove the SCHEDULING STOP CODE list
 N LINE,NUM,DATA,DESC,ERR,CNT
 W ! D GETLST^XPAR(.LIST,"PKG.SCHEDULING","SDEC PRIMARY CARE STOP CODES","B")
 I +$G(LIST) D
 . S CNT=0 F  S CNT=$O(LIST(CNT)) Q:CNT=""  D
 . . S NUM=$P(LIST(CNT,"N"),U),DESC=$P(LIST(CNT,"N"),U,2),ERR=0
 . . D EN^XPAR("PKG.SCHEDULING","SDEC PRIMARY CARE STOP CODES","`"_+NUM,"@",.ERR)
 D GETLST^XPAR(.LIST,"PKG.SCHEDULING","SDEC SPECIALTY CARE STOP CODES","B")
 I +$G(LIST) D
 . S CNT=0 F  S CNT=$O(LIST(CNT)) Q:CNT=""  D
 . . S NUM=$P(LIST(CNT,"N"),U),DESC=$P(LIST(CNT,"N"),U,2),ERR=0
 . . D EN^XPAR("PKG.SCHEDULING","SDEC SPECIALTY CARE STOP CODES","`"_+NUM,"@",.ERR)
 D GETLST^XPAR(.LIST,"PKG.SCHEDULING","SDEC MENTAL HEALTH STOP CODES","B")
 I +$G(LIST) D
 . S CNT=0 F  S CNT=$O(LIST(CNT)) Q:CNT=""  D
 . . S NUM=$P(LIST(CNT,"N"),U),DESC=$P(LIST(CNT,"N"),U,2),ERR=0
 . . D EN^XPAR("PKG.SCHEDULING","SDEC MENTAL HEALTH STOP CODES","`"_+NUM,"@",.ERR)
 Q
 ;
REGRPC(REGRPC,REGOPT) ; Register RPC
 N X,Y,DIC,FDA,RPCIEN,OPTIEN,SDIEN
 Q:$G(REGRPC)=""!($G(REGOPT)="")
 S DIC(0)="I",X=REGRPC,DIC="^XWB(8994,"
 D ^DIC Q:'(Y>0)  S RPCIEN=+Y
 D CLEAN^DILF
 S DIC(0)="I",X=REGOPT,DIC="^DIC(19,"
 D ^DIC Q:'(Y>0)  S OPTIEN=+Y
 D CLEAN^DILF
 S FDA(19.05,"?+1,"_OPTIEN_",",.01)=RPCIEN
 D UPDATE^DIE("","FDA","SDIEN")
 W !,"Added RPC ",REGRPC," to option ",REGOPT
 Q
 ;
DFPCPRMS ;
 ;;322^Comprehensive Women's Primary Care Clinic
 ;;323^Primary Care/Medicine
 ;;350^GeriPACT
 Q
 ;
DFSCPRMS ;
 ;;123^NUTRITION/DIETETICS-INDIVIDUAL
 ;;149^Radiation Therapy Treatment
 ;;180^Dental
 ;;197^POLYTRAUMA/TRAUMATIC BRAIN INJURY (TBI)-INDI
 ;;201^PHYSICAL MED & REHAB SVC
 ;;203^AUDIOLOGY
 ;;204^SPEECH LANGUAGE PATHOLOGY
 ;;205^PHYSICAL THERAPY
 ;;206^OCCUPATIONAL THERAPY
 ;;210^SPINAL CORD INJURY
 ;;214^KINESIOTHERAPY
 ;;301^GENERAL INTERNAL MEDICINE
 ;;302^ALLERGY IMMUNOLOGY
 ;;303^CARDIOLOGY
 ;;304^DERMATOLOGY
 ;;305^ENDO/METAB (EXCEPT DIABETES)
 ;;306^DIABETES
 ;;307^GASTROENTEROLOGY
 ;;308^HEMATOLOGY
 ;;310^INFECTIOUS DISEASE
 ;;312^PULMONARY/CHEST
 ;;313^RENAL/NEPHROL (EXCEPT DIALYSIS)
 ;;314^RHEUMATOLOGY/ARTHRITIS
 ;;315^NEUROLOGY
 ;;316^ONCOLOGY/TUMOR
 ;;317^ANTI-COAGULATION CLINIC
 ;;318^Geriatric Problem-Focused Clinic
 ;;337^HEPATOLOGY CLINIC
 ;;401^GENERAL SURGERY
 ;;403^ENT
 ;;404^GYNECOLOGY
 ;;406^NEUROSURGERY
 ;;407^OPHTHALMOLOGY
 ;;408^OPTOMETRY
 ;;409^ORTHOPEDICS
 ;;410^PLASTIC SURGERY
 ;;411^PODIATRY
 ;;413^THORACIC SURGERY
 ;;414^UROLOGY
 ;;415^VASCULAR SURGERY
 ;;420^PAIN CLINIC
 Q
 ;
DFMHPRMS ;
 ;;502^MH CLINIC IND
 ;;509^PSYCHIATRY INDIV
 ;;510^PSYCHOLOGY IND
 ;;513^SUB USE DISORDER INDIV
 ;;540^PCT-PTSD IND
 Q
