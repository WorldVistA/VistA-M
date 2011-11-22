DVBAUTLP ;ALB/SBW - Pre/Post Install APIs For CAPRI Templates & AMIE Exams ; 8/MAR/2011
 ;;2.7;AMIE;**166**;Apr 10, 1995;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; No direct entry allowed
 Q
 ;
 ; This Pre/Post Install Utility has APIs for Disabling and Activating/
 ; Renaming CAPRI Templates Definition (File #396.18) entries. 
 ; It also has APIs for Inactivating old and Creating new AMIE or 
 ; Updating existing Exams (File # 396.6) entries.
 ;
 ; Note that for Development Test Environments and VAMC Test Sites there
 ; will be a CAPRI Template Definition entry for each Test Patch Version 
 ; and the Released Patch installed. At all VAMC Sites who did not test
 ; the patch there will be just one released version per patch for which
 ; the original or updated template was distributed differentiated
 ; by Patch Number Version Suffix.
 ;
 ;
DISABLE(DVBNM,DVBVERSN,DVBACTR,DVBAMSG) ;Disable matching CAPRI template entries
 ;
 ; This procedure will find each entry in the CAPRI TEMPLATE 
 ; DEFINITIONS (#396.18) file where the first delimited (~) piece 
 ; matches the passed name (DVBNM) of the template being exported. Once
 ; a matching entry is found, it will be disabled if the 396.18 entry 
 ; Version Suffix does not match the Passed (DVBERSN) Version Suffix
 ; to be used for new templates to be added by the patch.
 ; Format for Template Name is:
 ;     Name~Version Suffix (e.g. DBQ TEST EXAMPLE~999T1) 
 ;
 ; An entry will be disabled by doing the following:
 ; - Turning off the SELECTABLE BY USER? field. This will keep the
 ;   entry from showing in the CAPRI GUI template list.
 ; - Looking at DE-ACTIVATION DATE field. If there's no date, set 
 ;   it to today.
 ;
 ;INPUT:
 ;  DVBNM -    Name of CAPRI template entry to be disabled
 ;  DVBVERSN - Patch Version Suffix (e.g. 999 or 999T1)
 ;    Format for version suffix are:
 ;      Released patch will be just Patch Number (e.g 999)
 ;      Test Patch will be Patch Number with a "T" and Test Patch
 ;         Version Number (e.g. 999T1)
 ;INPUT/OUTPUT:
 ;  DVBACTR -  Passed variable which contains the number of 
 ;             CAPRI templates disabled (Incremented by one for 
 ;             each CAPRI template successfully disabled.
 ;  DVBAMSG -  Array variable passed back to calling API with 
 ;             API result messages
 ;
 ;Quit if Template name or Version is not passed
 Q:$G(DVBNM)=""!($G(DVBVERSN)="")
 ;
 N DVBABIEN ;ien of CAPRI TEMPLATE DEFINITIONS file
 N DVBABST  ;template NAME field (i.e. DBQ PARKINSONS~999T1)
 N DVBACH   ;flag used to indicate template was disabled
 N DVBAFDA  ;FDA array for FILE^DIE
 N DVBMCTR  ;status message counter
 ;
 S DVBABIEN=0,DVBMCTR=0
 ;
 ;walk through CAPRI TEMPLATE DEFINITIONS (#396.18) file entries
 F  S DVBABIEN=$O(^DVB(396.18,DVBABIEN)) Q:'DVBABIEN  D
 . S DVBABST=$P($G(^DVB(396.18,DVBABIEN,0)),U,1) ;template name
 . ;if name matches and version is different, then disable entry
 . I $P(DVBABST,"~",1)=DVBNM  I $P(DVBABST,"~",2)'=DVBVERSN  D
 . . S DVBACH=0
 . . ;turn SELECTABLE BY USER (#7) field off
 . . I $P($G(^DVB(396.18,DVBABIEN,6)),U,1)'="0" S DVBAFDA(396.18,DVBABIEN_",",7)="0",DVBACH=1
 . . ;set DE-ACTIVATION DATE (#3) field to TODAY
 . . I $P($G(^DVB(396.18,DVBABIEN,2)),U,2)="" S DVBAFDA(396.18,DVBABIEN_",",3)=DT,DVBACH=1
 . . N DVBAERR  ;Array where error can be stored for Fileman calls
 . . ;output list of disabled templates
 . . I DVBACH=1 D
 . . . D FILE^DIE("K","DVBAFDA","DVBAERR")
 . . . S:$D(DVBAERR("DIERR"))'>0 DVBACTR=+$G(DVBACTR)+1
 . . . S DVBMCTR=DVBMCTR+1
 . . . S DVBAMSG(DVBMCTR)="   Disabling: "_DVBABST
 . . . ; Include Fileman Error message returned if any
 . . . I $D(DVBAERR("DIERR"))>0 D
 . . . . S DVBMCTR=DVBMCTR+1
 . . . . S DVBAMSG(DVBMCTR)="     *** Warning - Unable to disable."
 . . . . D ADDERR(.DVBAMSG,.DVBAERR,.DVBMCTR)
 Q
 ;
RENAME(DVBNM,DVBVERSS,DVBVERSN,DVBACTR,DVBAMSG) ; Rename CAPRI templates loaded
 ; by the patch
 ;
 ; This procedure is used to lookup and rename a template in the
 ; CAPRI TEMPLATE DEFINITIONS (#396.18) file. This is done to 
 ; rename the imported version of a template (i.e. DBQ 
 ; PARKINSONS~999F) to its new name/version (i.e. TEST - DBQ 
 ; PARKINSONS~999T1 or RELEASED - DBQ PARKINSONS~999).
 ; 
 ;INPUT:
 ;  DVBNM -    Name of CAPRI template entry to be disabled
 ;  DVBVERSS - Incoming Patch Version Suffix (e.g. 999F)
 ;  DVBVERSN - Rename Patch Version Suffix (e.g. 999 or 999T1)
 ;    Format for version suffix are (delimiter is "~"):
 ;      New entry to be renamed is Patch Number with a "F" (e.g 999F)
 ;      Released patch will be just Patch Number (e.g 999)
 ;      Test Patch will be Patch Number with a "T" and Test Patch
 ;         Version Number (e.g. 999T1)
 ;INPUT/OUTPUT:
 ;  DVBACTR -  Passed variable which contains the number of 
 ;             CAPRI templates renamed (Incremented by one for 
 ;             each CAPRI template disabled.
 ;  DVBAMSG -  Array variable passed back to calling API with 
 ;             API result messages
 ;
 ;Quit if Template Name, or Incoming Patch Version, or New Patch 
 ;Version is not passed
 Q:$G(DVBNM)=""!($G(DVBVERSS)="")!($G(DVBVERSN)="")
 ;
 N DVBABIEN,DVBABIE2 ;ien of CAPRI TEMPLATE DEFINITIONS file
 N DVBABST  ;incoming template NAME field (e.g. AUDIO~999F)
 N DVBABS2  ;renamed template NAME field (e.g. AUDIO~999T1 or AUDIO~999)
 N DVBACH   ;flag to indicate if template version is found or not
 N DVBAFDA  ;FDA array for FILE^DIE
 N DVBAADT  ;template activation date
 N DVBMCTR  ;status message counter
 ;
 S DVBABIEN=0,DVBMCTR=0
 ;
 ;main loop-walk through CAPRI TEMPLATE DEFINITIONS file entries
 F  S DVBABIEN=$O(^DVB(396.18,DVBABIEN)) Q:'DVBABIEN  D
 . S DVBABST=$P($G(^DVB(396.18,DVBABIEN,0)),U,1) ;template name
 . ;look for template versions just loaded by the patch by
 . ; Checking Version Suffix
 . I $P(DVBABST,"~",1)=DVBNM  I $P(DVBABST,"~",2)=DVBVERSS  D
 . . S DVBABIE2=0,DVBACH=0
 . . ; secondary loop-walk through CAPRI TEMPLATE DEFINITIONS file 
 . . ; entries
 . . F  S DVBABIE2=$O(^DVB(396.18,DVBABIE2)) Q:'DVBABIE2  D
 . . . ;Template Name
 . . . S DVBABS2=$P($G(^DVB(396.18,DVBABIE2,0)),U,1)
 . . . ; if new version of template exists in file, set flag
 . . . I $P(DVBABS2,"~",1)=DVBNM,$P(DVBABS2,"~",2)=DVBVERSN S DVBACH=1
 . . ; if new version already exists, delete the imported version 
 . . ; (abort rename)
 . . N DVBAERR  ;Array where error can be stored for Fileman calls
 . . I DVBACH=1 D
 . . . S DVBMCTR=DVBMCTR+1
 . . . S DVBAMSG(DVBMCTR)="      Found existing "_DVBNM_DVBVERSN_". No modifications made."
 . . . S DVBAFDA(396.18,DVBABIEN_",",.01)="@"
 . . . D FILE^DIE("","DVBAFDA","DVBAERR")
 . . ;
 . . ; Otherwise, if new version isn't found, rename imported 
 . . ; template name to the new version name (e.g. 
 . . ; DBQ PARKINSONS~999F --> DBQ PARKINSONS~999T1)
 . . I DVBACH=0 D
 . . . S DVBAADT=$P($G(^DVB(396.18,DVBABIEN,2)),U)
 . . . S DVBAFDA(396.18,DVBABIEN_",",.01)=DVBNM_"~"_DVBVERSN
 . . . I DVBAADT=""!(DVBAADT<DT) S DVBAFDA(396.18,DVBABIEN_",",2)=DT
 . . . D FILE^DIE("K","DVBAFDA","DVBAERR")
 . . . S:$D(DVBAERR("DIERR"))'>0 DVBACTR=+$G(DVBACTR)+1
 . . . ;Include status message
 . . . S DVBMCTR=DVBMCTR+1
 . . . S DVBAMSG(DVBMCTR)="    Activating: "_$P($G(^DVB(396.18,DVBABIEN,0)),U,1)
 . . . I $D(DVBAERR("DIERR"))>0 D
 . . . . S DVBMCTR=DVBMCTR+1
 . . . . S DVBAMSG(DVBMCTR)="      *** Warning - Unable to activate."
 . . ;
 . . ; Include Fileman Error message returned if any
 . . I $D(DVBAERR("DIERR"))>0 D ADDERR(.DVBAMSG,.DVBAERR,.DVBMCTR)
 ;
 Q
 ;
INACTEXM(DVBIEN,DVBEXM,DVBAMSG) ;Inactivate old (current) AMIE Exam 
 ; (#396.6) Entries
 ;
 ;INPUT:
 ;  DVBIEN -   Internal Entry Number of AMIE Exam to be inactivated
 ;  DVBEXM -   Exam Name of entry to to be inactivated
 ;INPUT/OUTPUT:
 ;  DVBAMSG -  Array variable passed back to calling API with 
 ;             action result message
 ;
 N DVBAFDA,DVBMCTR,DVBAERR
 S DVBMCTR=0
 ; Quit if valid IEN and Exam (.01 field) not passed
 Q:$G(DVBIEN)'>0!($G(DVBEXM)']"")
 ;If passed Exam Name different from .01 field, send warning msg
 I $P($G(^DVB(396.6,+DVBIEN,0)),U,1)'=DVBEXM D
 . ; Create error message if Exam Name in Entry is different
 . S DVBMCTR=DVBMCTR+1
 . S DVBAMSG(DVBMCTR)="    *** Warning - Entry #"_DVBIEN_" for exam"
 . S DVBMCTR=DVBMCTR+1
 . S DVBAMSG(DVBMCTR)="                  "_DVBEXM
 . S DVBMCTR=DVBMCTR+1
 . S DVBAMSG(DVBMCTR)="                  could not be inactivated. Check Exam Name!"
 ;If passed Exam Name is same as .01 fld update Status to Inactive
 I $P($G(^DVB(396.6,+DVBIEN,0)),U,1)=DVBEXM D
 . S DVBAFDA(396.6,+DVBIEN_",",.5)="I"
 . D FILE^DIE("K","DVBAFDA","DVBAERR")
 . ; Create status message if update successful
 . I $D(DVBAERR("DIERR"))'>0 D
 . . S DVBMCTR=DVBMCTR+1
 . . S DVBAMSG(DVBMCTR)="    Entry #"_DVBIEN_" for exam "_DVBEXM
 . . S DVBMCTR=DVBMCTR+1
 . . S DVBAMSG(DVBMCTR)="      successfully inactivated."
 . ; Create status message if error with update
 . I $D(DVBAERR("DIERR"))>0 D
 . . S DVBMCTR=DVBMCTR+1
 . . S DVBAMSG(DVBMCTR)="    *** Warning - Unable to inactivate Entry #"_DVBIEN_" for exam"
 . . S DVBMCTR=DVBMCTR+1
 . . S DVBAMSG(DVBMCTR)="                  "_DVBEXM_"."
 . . ; Include Fileman Error message returned if any
 . . D ADDERR(.DVBAMSG,.DVBAERR,.DVBMCTR)
 Q
 ;
NEWEXAM(DVBIEN,DVBEXM,DVBPNM,DVBBDY,DVBROU,DVBSTAT,DVBWKS,DVBAMSG) ;
 ; Add new exam entries to AMIE EXAM (#396.6) File
 ;INPUT:
 ;  DVBIEN -  Internal Entry Number of AMIE Exam entry to be added
 ;  DVBEXM -  Name of AMIE Exam entry to be added
 ;  DVBPNM -  Print Name of AMIE Exam entry to be added
 ;  DVBBDY -  Body System of AMIE Exam entry to be added
 ;  DVBROU -  Reporting Program Name of AMIE Exam entry to be added
 ;  DVBSTAT - Status of AMIE Exam entry to be added
 ;  DVBWKS -  AMIE Worksheet # of AMIE Exam entry to be added 
 ;INPUT/OUTPUT:
 ;  DVBAMSG - Array variable passed back to calling API with 
 ;            API result messages
 ;
 N DVBAFDA,DVBAIEN,DVBMCTR,DVBAERR
 S DVBMCTR=0
 ;
 ; Quit if valid IEN and Exam (.01 field) not passed
 Q:$G(DVBIEN)'>0!($G(DVBEXM)']"")
 ; Update existing entry
 I $D(^DVB(396.6,DVBIEN,0))>0 D
 . S DVBMCTR=DVBMCTR+1
 . S DVBAMSG(DVBMCTR)="    You have an Entry #"_DVBIEN_"."
 . S DVBMCTR=DVBMCTR+1
 . S DVBAMSG(DVBMCTR)="    Updating "_DVBEXM_"."
 . S DVBAFDA(396.6,+DVBIEN_",",.01)=$G(DVBEXM)
 . S DVBAFDA(396.6,+DVBIEN_",",.07)=$G(DVBWKS)
 . S DVBAFDA(396.6,+DVBIEN_",",.5)=$G(DVBSTAT)
 . S DVBAFDA(396.6,+DVBIEN_",",2)=$G(DVBBDY)
 . S DVBAFDA(396.6,+DVBIEN_",",6)=$G(DVBPNM)
 . S DVBAFDA(396.6,+DVBIEN_",",7)=$G(DVBROU)
 . D FILE^DIE("K","DVBAFDA","DVBAERR")
 . I $D(DVBAERR("DIERR"))'>0 D
 . . S DVBMCTR=DVBMCTR+1
 . . S DVBAMSG(DVBMCTR)="    Successfully updated Entry #"_DVBIEN_" for exam"
 . . S DVBMCTR=DVBMCTR+1
 . . S DVBAMSG(DVBMCTR)="       "_DVBEXM_"."
 . I $D(DVBAERR("DIERR"))>0 D
 . . S DVBMCTR=DVBMCTR+1
 . . S DVBAMSG(DVBMCTR)="    *** Warning - Unable to update Entry."
 ;
 ; Add new entry
 I $D(^DVB(396.6,DVBIEN,0))'>0 D
 . S DVBAIEN(1)=DVBIEN
 . S DVBAFDA(396.6,"+1,",.01)=$G(DVBEXM)
 . S DVBAFDA(396.6,"+1,",.07)=$G(DVBWKS)
 . S DVBAFDA(396.6,"+1,",.5)=$G(DVBSTAT)
 . S DVBAFDA(396.6,"+1,",2)=$G(DVBBDY)
 . S DVBAFDA(396.6,"+1,",6)=$G(DVBPNM)
 . S DVBAFDA(396.6,"+1,",7)=$G(DVBROU)
 . D UPDATE^DIE("","DVBAFDA","DVBAIEN","DVBAERR")
 . I $D(DVBAERR("DIERR"))'>0 D
 . . S DVBMCTR=DVBMCTR+1
 . . S DVBAMSG(DVBMCTR)="    Successfully added Entry #"_DVBIEN_" for exam"
 . . S DVBMCTR=DVBMCTR+1
 . . S DVBAMSG(DVBMCTR)="       "_DVBEXM_"."
 . I $D(DVBAERR("DIERR"))>0 D
 . . S DVBMCTR=DVBMCTR+1
 . . S DVBAMSG(DVBMCTR)="    *** Warning - Unable to add Entry #"_DVBIEN
 . . S DVBMCTR=DVBMCTR+1
 . . S DVBAMSG(DVBMCTR)="                  for exam "_DVBEXM_"."
 ;
 ;Include FILE^DIE or UPDATE^DIE error message in DVBAMSG array
 I $D(DVBAERR("DIERR"))>0 D ADDERR(.DVBAMSG,.DVBAERR,.DVBMCTR)
 Q
 ;
ADDERR(DVBMSG,DVBERR,DVBCTR) ;Include passed FM error message into DVBMSG 
 ;array
 ;INPUT:
 ;  DVBERR - Passed error Array from Fileman call
 ;INPUT/OUTPUT:
 ;  DVBMSG - Passed array with status messages. Passed FM Error will
 ;           be added to array and returned to calling API
 ;  DVBCTR - Passed Counter Variable to used for DVBMSG array. Updated
 ;           Counter will be returned to call API.
 ;Quit if DVBERR isn't defined
 Q:$D(DVBERR)'>0
 N DVBMSG1,CTR
 D MSG^DIALOG("AE",.DVBMSG1,"","","DVBERR")
 S CTR=0
 F  S CTR=$O(DVBMSG1(CTR)) Q:CTR'>0  D
 . S DVBCTR=$G(DVBCTR)+1
 . S DVBMSG(DVBCTR)="        "_DVBMSG1(CTR)
 Q
