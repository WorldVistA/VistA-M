DG531027P ;ALB/MCF - DG*5.3*1027 PRE AND POST-INSTALL ROUTINE TO SET UP HWSC ENTRIES FOR E&E WEB SERVICE;9 September 2020 9:00 AM
 ;;5.3;Registration;**1027**;Aug 13, 1993;Build 70
 ;
 ; This routine is also used as an Environmental Check routine, though it does nothing except make the HELP
 ;  tag below available for the Installation question in the build.
 Q
 ;
HELP ; Help for ?? on Installation Question POS1 (use direct writes in env check routine)
 W !,"Enter 1 if patch is being installed in a Pre-Production (Mirror) system."
 W !,"Enter 2 if patch is being installed in a Software Quality Assurance system."
 W !,"Enter 3 if patch is being installed in a Development system."
 Q
 ;
PRE ; PRE INSTALL Main entry point
 ; This routine contains the pre-install check which gets executed
 ; before patch DG*5.3*1027 is allowed to install.
 ; - Check that the wsdl file is accessible
 ;
 ; ICRs:  #2320 : $$LIST^%ZISH,$$DEFDIR^%ZISH
 ;        10141 : BMES^XPDUTL
 ;              : MES^XPDUTL
 ;
 ;  Input: Variables set by KIDS during pre-install check
 ; Output: XPDABORT - KIDS variable set to abort installation - set to 1 to remove installation from the system
 ;
 D BMES^XPDUTL(">>> Beginning the DG*5.3*1027 Pre-install Routine")
 ;
 ; Check for wsdl file
 D CHK
 I $G(XPDABORT) D  Q
 . D BMES^XPDUTL(">>> DG*5.3*1027 Pre-install Routine Failed.")
 . D MES^XPDUTL("    - Installation Terminated.")
 . D MES^XPDUTL("    - Transport global removed from system.")
 D BMES^XPDUTL(">>> DG*5.3*1027 Pre-Install Successful")
 Q
 ;
CHK ; Check for existence of WSDL file.
 N DGBPATH
 D BMES^XPDUTL(" o  Checking for the existence of the WSDL file eesummary.wsdl")
 S DGBPATH=$$GETPATH("eesummary.wsdl")
 ; If file is not found, abort the install
 I DGBPATH="" S XPDABORT=1
 E  D MES^XPDUTL("    > WSDL file located: "_DGBPATH)
 Q
 ;
GETPATH(DGBWSDL) ; - Get the location of the DGBWSDL file
 ; Return the path of the file. If not found, give error message and return NULL
 N DGBSTAT,DGBPATH,DGBFILE
 ; First check SOFTWARE directory
 S DGBPATH="/srv/vista/patches/SOFTWARE/"
 S DGBFILE(DGBWSDL)=""
 S DGBSTAT=$$LIST^%ZISH(DGBPATH,"DGBFILE","DGBSTAT")
 I 'DGBSTAT!($D(DGBSTAT)'=11) D
 . ; If not found, check PUB directory
 . S DGBPATH="/srv/vista/patches/PUB/DG_53_P1027/"
 . S DGBSTAT=$$LIST^%ZISH(DGBPATH,"DGBFILE","DGBSTAT")
 . I 'DGBSTAT!($D(DGBSTAT)'=11) D
 . . ; If not found, check PRIMARY HFS DIRECTORY
 . . S DGBPATH=$$DEFDIR^%ZISH
 . . S DGBSTAT=$$LIST^%ZISH(DGBPATH,"DGBFILE","DGBSTAT")
 . . I 'DGBSTAT!($D(DGBSTAT)'=11) D
 . . . D BMES^XPDUTL("**** Error cannot find file "_DGBWSDL)
 . . . D MES^XPDUTL("**** WSDL file "_DGBPATH_DGBWSDL_" not found.")
 . . . D MES^XPDUTL("     File is needed prior to install.")
 . . . S DGBPATH=""
 Q DGBPATH
 ;
POST ; POST INSTALL Main entry point
 ; ICRs:
 ;        10141 : BMES^XPDUTL
 ;              : MES^XPDUTL
 ;         5421 : GENPORT^XOBWLIB
 ;         7190 : R/W access to file 18.02
 ;         7191 : R/W access to file 18.12
 ;         2240 : $$ENCRYP^XUSRB1
 ;        10096 : ^%ZSOF("DEL")
 ;         3352 : DIEZ^DIKCUTL3
 ;
 D BMES^XPDUTL(">>> Patch DG*5.3*1027 - Post-install start...")
 D POST1
 D POST2
 D POST3
 D BMES^XPDUTL(">>> Patch DG*5.3*1027 - Post-install complete.")
 Q
POST1 ; Setup DG EE SUMMARY SERVER and SEVICE
 N DGSRVR,DGSRVC
 D BMES^XPDUTL(" o  Post-install set up for SSL Configuration...")
 S DGSRVR="DG EE SUMMARY SERVER"
 S DGSRVC="DG EE SUMMARY SERVICE"
 ; If the DG EE SUMMARY SERVER is installed, set it to DISABLED so the update of the server won't cause errors
 ; The patch installation will set it back to ENABLED.
 D DISABLE
 D SERVICE
 D SERVER
 Q
 ;
SERVICE ; from wsdl, create/compile classes and set up service
 N DGARR,DGSTAT,DGBPATH
 S DGBPATH=$$GETPATH("eesummary.wsdl")
 S DGARR("WSDL FILE")=DGBPATH_"eesummary.wsdl"
 S DGARR("CACHE PACKAGE NAME")="dgeewebsvc"
 S DGARR("WEB SERVICE NAME")=DGSRVC
 ; $$GENPORT^XOBWLIB handles BMES^XPDUTL messaging in the event of a success.
 S DGSTAT=$$GENPORT^XOBWLIB(.DGARR)
 I +DGSTAT=0 D BMES^XPDUTL($P(DGSTAT,"^",2)) Q   ; in the event of a failure
 Q
 ;
SERVER ; set up web server
 N DGEXIT,DGTYPE,DGCOUNT,DGEPT,DGPW,DGPORT,DGDATA
 N DGIEN,DGIENS,DGSERVER,DGFDAI,DGERR,DGERR12,DGERR02,DGSRVIEN,DGSERVICE
 ; Get the site type entered in the Installation question POS1
 S DGTYPE=$G(XPDQUES("POS1"))
 ; DGTYPE will be a value of 1-3 (PRE-PROD, SQA, DEVELOPMENT) (if no value, this is a PRODUCTION system)
 I 'DGTYPE S DGTYPE=4
 D MES^XPDUTL(" o  Setting up the server for "_$S(DGTYPE=1:"PRE-PROD",DGTYPE=2:"SQA",DGTYPE=3:"DEVELOPMENT",1:"PRODUCTION")_".")
 S DGEXIT=0
 ; Get the matching endpoint, password and port for the site type
 F DGCOUNT=1:1 S DGDATA=$P($T(TYPEMAP+DGCOUNT),";;",2) D  Q:DGEXIT
 . I $P(DGDATA,";",1)=DGTYPE S DGEPT=$P(DGDATA,";",3),DGPW=$P(DGDATA,";",4),DGPORT=$P(DGDATA,";",5),DGEXIT=1
 S DGIEN("SRV")=$$FIND1^DIC(18.12,,"B",DGSRVR)
 I DGIEN("SRV") S DGIENS("SRV")=DGIEN("SRV")_","
 E  S DGIENS("SRV")="+1,"
 ; NAME
 S DGSERVER(18.12,DGIENS("SRV"),.01)=DGSRVR
 ; PORT
 S DGSERVER(18.12,DGIENS("SRV"),.03)=DGPORT
 ; SERVER endpoint
 S DGSERVER(18.12,DGIENS("SRV"),.04)=DGEPT
 ; STATUS
 ; For Pre-Prod, set Status to disabled, otherwise, enable
 S DGSERVER(18.12,DGIENS("SRV"),.06)=$S(DGTYPE=1:0,1:1)
 ; LOGIN REQUIRED
 S DGSERVER(18.12,DGIENS("SRV"),1.01)=1
 ; SSL ENABLED
 S DGSERVER(18.12,DGIENS("SRV"),3.01)=1
 ; SSL CONFIGURATION
 S DGSERVER(18.12,DGIENS("SRV"),3.02)="encrypt_only_tlsv12"
 ; SSL PORT
 S DGSERVER(18.12,DGIENS("SRV"),3.03)=DGPORT
 ; USERNAME
 S DGSERVER(18.12,DGIENS("SRV"),200)="VistASvcUsr"
 ; PASSWORD - must be encrypted
 S DGSERVER(18.12,DGIENS("SRV"),300)=$$ENCRYP^XUSRB1(DGPW)
 ;
 I DGIEN("SRV") D FILE^DIE("","DGSERVER","DGERR12")    ; update existing entry
 I 'DGIEN("SRV") D UPDATE^DIE("","DGSERVER","DGFDAI","DGERR") ; create new entry
 I $D(DGFDAI) S DGIENS("SRV")=DGFDAI(1)_",",DGIEN("SRV")=DGFDAI(1)
 I '$D(DGERR12("DIERR",1,"TEXT",1)) D BMES^XPDUTL(" o  WEB SERVER '"_DGSRVR_"' addition/update succeeded.")
 I $D(DGERR12("DIERR",1,"TEXT",1)) D BMES^XPDUTL(" o  WEB SERVER '"_DGSRVR_"' Error: "_DGERR12("DIERR",1,"TEXT",1)) Q
 ; once server is set up add the web service
 S DGIENS("SRC")="+1,"
 S DGSRVIEN=0
 F  S DGSRVIEN=$O(^XOB(18.12,DGIEN("SRV"),100,"B",DGSRVIEN)) Q:'DGSRVIEN  D
 . I $$GET1^DIQ(18.02,DGSRVIEN,.01)=DGSRVC S DGIENS("SRC")=DGSRVIEN_","
 I DGIENS("SRC")'="+1," Q  ; don't update subentry pointers if already exist.
 K DGSERVICE,DGFDAI
 S DGSERVICE(18.121,DGIENS("SRC")_DGIENS("SRV"),.01)=DGSRVC
 S DGSERVICE(18.121,DGIENS("SRC")_DGIENS("SRV"),.06)="ENABLED"
 D UPDATE^DIE("E","DGSERVICE","DGFDAI","DGERR02") ; create new entry
 I $D(DGERR02("DIERR",1,"TEXT",1)) D MES^XPDUTL(" o  "_DGERR02("DIERR",1,"TEXT",1))
 I '$D(DGERR02("DIERR",1,"TEXT",1)) D BMES^XPDUTL(" o  '"_DGSRVC_"' service successfully authorized on server.")
 Q
 ;
DISABLE ; Disable DG EE SUMMARY server if it exists - update of server will set it back to enabled (except for Pre-prod)
 N DGIEN,DGSERVER,DGERR12
 S DGIEN("SRV")=$$FIND1^DIC(18.12,,"B",DGSRVR)
 I 'DGIEN("SRV") Q
 ; Set STATUS to DISABLED
 S DGSERVER(18.12,DGIEN("SRV")_",",.06)=0
 D FILE^DIE("","DGSERVER","DGERR12")    ; update existing entry
 D BMES^XPDUTL(" o  '"_DGSRVR_"' server temporarily disabled.")
 Q
 ;
POST2 ; Cleanup of routines generated by WSDL compilation
 D BMES^XPDUTL(" o  Cleanup of routines compiled from the WSDL.")
 N DGCOUNT,DGDATA,X
 F DGCOUNT=1:1 S DGDATA=$P($T(ROU+DGCOUNT),";;",2) Q:DGDATA="END"  D
 . ; Delete all routines from the uppercase DGEEWEBS namespace
 . S X="DGEEWEBS."_(DGDATA) X ^%ZOSF("DEL")
 . ; Delete the routines in the lowercase dgeewebsvc namespace except the ones needed by the DG EE SUMMARY SERVICE
 . I DGDATA="eeSummary.1"!(DGDATA="enrollmentDeterminationInfo.1")!(DGDATA="registrationInfo.1")!(DGDATA="eeSummaryPortSoap11.getEESummary.1")!(DGDATA="eeSummaryPortSoap11.1") Q
 . S X="dgeewebsvc."_(DGDATA) X ^%ZOSF("DEL")
 Q
 ;
POST3 ; Recompile all input templates for fields that were modified
 ;Recompile all compiled input templates that contain specific fields.
 N DGFLD
 D BMES^XPDUTL(" o Recompile all compiled input templates that contain the following fields:")
 D MES^XPDUTL("    PATIENT ENROLLMENT file(#27.11): ")
 D MES^XPDUTL("    o APPLICATION DATE (#.01)")
 D MES^XPDUTL("    o REASON/CANCELLED DECLINED (#.05)")
 D MES^XPDUTL("    o PT APPLIED FOR ENROLLMENT? (#.14)")
 D MES^XPDUTL("    o REGISTRATION ONLY REASON (#.15)")
 ;
 ;build array of file and field numbers for top-level file and fields being exported
 ;array format: DGFLD(file#,field)=""
 ;recompile all compiled input templates that contain the fields in the DGLFD array passed by reference 
 ; PATIENT ENROLLMENT file #27.11
 S DGFLD(27.11,.01)=""  ; APPLICATION DATE
 S DGFLD(27.11,.05)=""  ; REASON/CANCELLED DECLINED
 S DGFLD(27.11,.14)=""  ; PT APPLIED FOR ENROLLMENT?
 S DGFLD(27.11,.15)=""  ; REGISTRATION ONLY REASON 
 D DIEZ^DIKCUTL3(27.11,.DGFLD)
 Q
 ;
ROU ; WSDL routines compiled
 ;;EmailType.1
 ;;NotificationType.1
 ;;baseAddressInfo.1
 ;;assetInfo.1
 ;;baseFinancialInfo.1
 ;;addressInfo.1
 ;;associationInfo.1
 ;;cancelDeclineInfo.1
 ;;beneficiaryTravelInfo.1
 ;;cdConditionInfo.1
 ;;categoryInfo.1
 ;;cdProcedureInfo.1
 ;;combatEpisodeInfo.1
 ;;catastrophicDisabilityInfo.1
 ;;conflictExperienceInfo.1
 ;;consentInfo.1
 ;;communityCareEligibilityInfo.1
 ;;debitInfo.1
 ;;contactInfo.1
 ;;deathRecondInfo.1
 ;;dependentInfo.1
 ;;demographicInfo.1
 ;;eligibilityInfo.1
 ;;dependentFinancialsInfo.1
 ;;eligibilityStatusInfo.1
 ;;eligibilityVerificationInfo.1
 ;;emergencyResponseInfo.1
 ;;employmentInfo.1
 ;;eeSummary.1
 ;;emailInfo.1
 ;;expenseInfo.1
 ;;feeBasisInfo.1
 ;;financialsInfo.1
 ;;geocodingInfo.1
 ;;financialStatementInfo.1
 ;;incomeInfo.1
 ;;hardshipInfo.1
 ;;healthBenefitPlanInfo.1
 ;;enrollmentDeterminationInfo.1
 ;;incompetenceRulingInfo.1
 ;;ineligibilityFactorInfo.1
 ;;incomeTestStatusInfo.1
 ;;ivmLetterCandidateInfo.1
 ;;ivmCandidateInfo.1
 ;;incomeTestInfo.1
 ;;ivmLetterInfo.1
 ;;ivmLetterStatusInfo.1
 ;;linkNotificationInfo.1
 ;;militaryServiceEpisodeInfo.1
 ;;insuranceInfo.1
 ;;militarySexualTraumaInfo.1
 ;;monetaryBenefitAwardInfo.1
 ;;militaryServiceInfo.1
 ;;moveNotificationInfo.1
 ;;nameInfo.1
 ;;militaryServiceSiteRecordInfo.1
 ;;monetaryBenefitInfo.1
 ;;phoneInfo.1
 ;;nonPrimaryFinancialStatementInfo.1
 ;;noseThroatRadiumInfo.1
 ;;powEpisodeInfo.1
 ;;primaryviewNotificationInfo.1
 ;;preferredFacilityInfo.1
 ;;prisonerOfWarInfo.1
 ;;purpleHeartInfo.1
 ;;registrationInfo.1
 ;;personInfo.1
 ;;relationInfo.1
 ;;sendIVMInfo.1
 ;;ratedDisabilityInfo.1
 ;;specialFactorsInfo.1
 ;;sensitivityInfo.1
 ;;serviceConnectionAwardInfo.1
 ;;spinalCordInjuryInfo.1
 ;;ssnInfo.1
 ;;spouseFinancialsInfo.1
 ;;vamcInfo.1
 ;;vceEligibilityInfo.1
 ;;spouseInfo.1
 ;;deliveryPreferenceInfo.1
 ;;eeSummaryPortSoap11.1
 ;;eeSummaryPortSoap11.getDeliveryPreference.1
 ;;eeSummaryPortSoap11.getEESummary.1
 ;;eeSummaryPortSoap11.getEESummaryHistory.1
 ;;eeSummaryPortSoap11.getEligibilityDetermination.1
 ;;eeSummaryPortSoap11.getIVMLetterStatuses.1
 ;;eeSummaryPortSoap11.getPersonNotification.1
 ;;eeSummaryPortSoap11.retrieveIVMCandidates.1
 ;;eeSummaryPortSoap11.sendIVMUpdates.1
 ;;eeSummaryPortSoap11.updateDeliveryPreference.1
 ;;eeSummaryPortSoap11.updateIVMRecordStatus.1
 ;;END
TYPEMAP ;  Map the system type to the SERVER endpoint, Password and Port values
 ;;1;PREPROD;vaww.esrpre-prod.aac.domain.ext;Th7$kj32;8443
 ;;2;SQA;vaww.esrstage1a.aac.domain.ext;P6hy%43!;8443
 ;;3;DEV;vaww.dev03-esm.domain.ext;4rfv$RFV;443
 ;;4;PROD;vaww.esr.aac.domain.ext;Nh8#lkm7;8443
