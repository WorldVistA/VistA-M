DG950PST ;OAK/ELZ-PATCH DG*5.3*950 POST INSTALLATION ROUTINE ;10/13/17
 ;;5.3;Registration;**950**;Aug 13, 1993;Build 4
 ;
 ; Story 603913: Add New DOD Documentation Type - VA Auspices (elz)
 ;               - Add new entry in SUPPORTING DOCUMENTATION TYPES (#47.75)
 ;                 Under VA Auspices    code: UVA
 ;               - Add new entry in SOURCE OF NOTIFICATION BUSINESS RULES (#47.761)
 ;                 VistA source of notification is Spouse/NOK/Other Person with supporting
 ;                 documentation of Under VA Auspices and active
 ;
 ;
 ; Story 603929: Add New DOD Documentation Type - EVVE Fact of Death Query (elz)
 ;               - Add new entry in SUPPORTING DOCUMENTATION TYPES (#47.75)
 ;                 EVVE Fact of Death Query    code: EFDQ 
 ;               - Add new entry in SOURCE OF NOTIFICATION BUSINESS RULES (#47.761)
 ;                 VistA source of notification is EVVE QUERY with supporting documentation of EVVE
 ;                 Fact of Death Query and active
 ;
 ; Story 625205: Loop through Patient file (#2) and verify that the ICN (#991.01) and
 ;               ICN CHECKSUM (#991.02) values match the FULL ICN (#991.1) value, if
 ;               NOT then update the FULL ICN field with the ICN and ICN CHECKSUM values.
 ;
POST ;
 D BMES^XPDUTL("Post-Install: Starting")
 D UPDTFLE
 D BRFILE
 D QUE  ;Task off validation of the FULL ICN values
 D BMES^XPDUTL("Post-Install: Finished")
 Q
 ;
UPDTFLE ;Create a new entries in SUPPORTING DOCUMENTATION TYPES (#47.75) file
 N DGDOCTYP
 D BMES^XPDUTL("   Adding new Supporting Document Types to File #47.75")
 F DGDOCTYP="20^UNDER VA AUSPICES^UVA","21^EVVE FACT OF DEATH QUERY^EFDQ" D
 . N DGFDA,DGERRMSG,DGIEN,DGTMP
 . I $$FIND1^DIC(47.75,"","X",$P(DGDOCTYP,"^",2)) D MES^XPDUTL("   *** '"_$P(DGDOCTYP,"^",2)_"' Supporting Documentation Type already exists!") Q
 . I $D(^DIC(47.75,+DGDOCTYP)) D MES^XPDUTL("   >>> ERROR! Entry #"_(+DGDOCTYP)_" for '"_$P(DGDOCTYP,"^",2)_"' already exists where it should not be") Q
 . S DGFDA(47.75,"+1,",.01)=$P(DGDOCTYP,"^",2)
 . S DGFDA(47.75,"+1,",1)=$P(DGDOCTYP,"^",3)
 . S DGIEN(1)=+DGDOCTYP
 . D UPDATE^DIE("","DGFDA","DGIEN","DGERRMSG")
 . I $D(DGERRMSG) D MES^XPDUTL("   >>> ERROR! '"_$P(DGDOCTYP,"^",2)_"' Supporting Document Type NOT added!"),MES^XPDUTL("           [#"_DGERRMSG("DIERR",1)_": "_DGERRMSG("DIERR",1,"TEXT",1)_"]") Q
 . ; Add name as description
 . S DGIEN=+DGDOCTYP_",",DGTMP("WP",1,0)=$P(DGDOCTYP,"^",2)
 . D WP^DIE(47.75,DGIEN,50,"K","DGTMP(""WP"")")
 . D MES^XPDUTL("   *** '"_$P(DGDOCTYP,"^",2)_"' Supporting Document Type successfully added")
 D BMES^XPDUTL("  Finished adding new Supporting Document Types to file #47.75")
 Q
 ;
BRFILE ; populate business new rules into file.  To ensure this is only done once, check the
 ; file to make sure they are not already just in case the patch is re-installed.
 D MES^XPDUTL("Filed Business Rules for Source of Notifications to Document Types.")
 N DGCOUNT,DGLINE,DGDATA,DGRTN
 D MES^XPDUTL("Adding business rules for new Supporting Document Types to file #47.761")
 S DGCOUNT=0
 F DGLINE=2:1 S DGDATA=$P($T(BRDATA+DGLINE),";",3) Q:DGDATA=""  S DGCOUNT=DGCOUNT+1,DGDATA(DGCOUNT)=DGDATA
 D BRDATA^DGDTHBR(.DGRTN,.DGDATA)
 I $G(DGRTN(1))>0 D MES^XPDUTL($P(DGRTN(1),"^")_" out of 2 successfully filed") Q
 S DGLINE=0 F  S DGLINE=$O(DGRTN(DGLINE)) Q:'DGLINE  D MES^XPDUTL(DGRTN(DGLINE))
 Q
 ;
BRDATA ; data to populate into the 47.761 file
 ; Format:  IEN of Source of Notification^Active^Supporting Document Type (Type Code)^Active
 ;;8^1^UVA^1
 ;;10^1^EFDQ^1
 ;;
 ;
QUE ;Queue the validation of the FULL ICN (#991.1) against the ICN (#991.01) and ICN CHECKSUM (#991.02)
 D BMES^XPDUTL("   Queuing job to validate the FULL ICNs.")
 N ZTIO,ZTSK,ZTRTN,ZTDESC,ZTSAVE,ZTDTH,Y
 S ZTIO="",ZTRTN="VFULLICN^DG950PST",ZTDTH=$H
 S ZTDESC="DG*5.3*950 post-install validation of FULL ICNs"
 D ^%ZTLOAD
 I '$G(ZTSK) D MES^XPDUTL("    **** Queuing job failed!!!") Q
 D MES^XPDUTL("    Job number #"_ZTSK_" was queued.")
 Q
 ;
VFULLICN ;entry point for queued job to loop on Patient file to validate FULL ICN
 N DFNCNT,DFN,FICNT,START,DONE,MPINODE,FULLICN,ICN,CKSUM,DGFDA,DGERRMSG
 S START=$$FMTE^XLFDT($$NOW^XLFDT)
 S (DFNCNT,DFN,FICNT)=0
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  S DFNCNT=DFNCNT+1 D
 .Q:'$D(^DPT(DFN,"MPI"))
 .S MPINODE=$G(^DPT(DFN,"MPI"))
 .S ICN=$P(MPINODE,"^"),CKSUM=$P(MPINODE,"^",2),FULLICN=$P(MPINODE,"^",10)
 .Q:(ICN="")
 .I ($TR(FULLICN,"V","")'=(ICN_CKSUM)) D
 ..K DGFDA
 ..S FICNT=FICNT+1
 ..L +^DPT(DFN,"MPI"):10
 ..S DGFDA(2,DFN_",",991.1)=ICN_"V"_CKSUM D UPDATE^DIE("","DGFDA","","DGERRMSG")
 ..L -^DPT(DFN,"MPI")
 S DONE=$$FMTE^XLFDT($$NOW^XLFDT)
 ;
EMAILS ;Send email to person who ran the INIT, letting them know results
 N XMDUZ,XMTEXT,XMSUB,XMY,XMZ,XMDUN,X,R
 S R(1)="Validation of FULL ICN (#991.1) against the ICN (#991.01) and"
 S R(2)=" ICN CHECKSUM (#991.02):"
 S R(3)=" "
 S R(4)="Process started: "_START
 S R(5)="Process completed: "_DONE
 S R(6)="Total number of records updated with a corrected FULL ICN: "_FICNT
 S R(7)=" ",R(8)="You can now delete the post-init routine ^DG950PST."
 S XMTEXT="R(",XMSUB="Results from running patch DG*5.3*950"
 S XMDUZ=.5
 S XMY(DUZ)=""
 D ^XMD
 ;
 ; Send message to MPI developers on Outlook
 ; IA#4440 supported call to check for test or production account
 Q:$$PROD^XUPROD()=0  ;not a production account. Don't send email to MPI dev
 ;
 N DGSNAME,DGSITE,XMDUZ,XMTEXT,XMSUB,XMY,XMZ,XMDUN,R
 S X=$$SITE^VASITE()
 S DGSNAME=$P(X,"^",2),DGSITE=$P(X,"^",3)
 S R(1)="Post-Init routine DG950PST run at station: "_DGSITE_" - "_DGSNAME
 S R(2)=" "
 S R(3)="Process Started: "_START_"  -  Completed: "_DONE
 S R(4)=" "
 S R(5)="Total Patient file records processed: "_DFNCNT
 S R(6)=" "
 S R(7)="Total number of records updated with a corrected FULL ICN: "_FICNT
 S XMTEXT="R(",XMSUB="Results from running patch DG*5.3*950 at station: "_DGSITE
 S XMDUZ=DUZ
 S XMY("Christine.Chesney@domain.ext")=""
 S XMY("John.Williams30ec0c@domain.ext")=""
 S XMY("Christine.Link@domain.ext")=""
 D ^XMD
 Q
 ;
