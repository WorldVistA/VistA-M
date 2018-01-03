DG944PST ;BIR/CML-PATCH DG*5.3*944 POST INSTALLATION ROUTINE ;5/1/17
 ;;5.3;Registration;**944**;Aug 13, 1993;Build 2
 ;
 ;      - Story 500994 (cml)
 ; This post-init will loop thru the Patient file (^DPT(DFN)) and check the zero node looking for any names
 ; that contain lowercase letters. 
 ; Any that are found will be updated to all uppercase and saved into the .01 field of the PATIENT (#2) file.  
 ; When the job is complete it will send an email to:
 ;  -  (locally) POSTMASTER and the person who installed the patch (DUZ)
 ;  -  (MPI Outlook) Christine.Chesney@domain.ext, Link.Christine@domain.ext and John.Williams30ec0c@domain.ext.
 ;
 ;      - Story 557843 (cml)
 ; This post-init will loop thru the Patient file (^DPT(DFN)) and check for any records that have an ICN and
 ; an ICN CHECKSUM but do NOT have the FULL ICN field populated.
 ; Any that are found will have the FULL ICN field updated to be ICN_"V"_CHECKSUM.
 ; When the job is complete it will send an email to:
 ;  -  (locally) POSTMASTER and the person who installed the patch (DUZ)
 ;  -  (MPI Outlook) Christine.Chesney@domain.ext, Link.Christine@domain.ext and John.Williams30ec0c@domain.ext.
 ;
 ;      - Story 557808 (jfw)
 ; Add 'Department of Defense' entry to the SOURCE OF NOTIFICATION File (#47.76).
 ;
 ;      - Story 557909 (jfw)
 ; Enable auditing on the PLACE OF BIRTH CITY (.092)/STATE (.093) fields
 ; in the PATIENT file (#2). 
 ;
 ;      - Stories 557815 and 557804 (elz)
 ; Populate the new Source of Notification Business Rules (#47.761) file with initial
 ; business rules for both Source of Notification and Document Types allowed
 ;
 ;
POST ;queue off post-init to identify and cleanup any names with lowercase characters or missing FULL ICN
 N DGI,DGFLDS
 ;  Modifying the following field(s) in the PATIENT File #2:
 ;     - .092 PLACE OF BIRTH [CITY]
 ;     - .093 PLACE OF BIRTH [STATE]
 S DGFLDS=".092,.093"
 D BMES^XPDUTL("Post-Install:"),MES^XPDUTL("")
 ;Turning on AUDITING for PATIENT File field(s)
 F DGI=1:1:$L(DGFLDS,",")  D AUDIT(2,$P(DGFLDS,",",DGI),"PATIENT")
 D UPDTFLE  ;Add new Source of Notification
 D BRFILE  ;Add the DOD Source/Document type business rules into the new file
 D QUE  ;Task off cleanup of lowercase letters in names or missing FULL ICN
 D BMES^XPDUTL("Post-Install: Finished")
 Q
 ;
AUDIT(DGFILE,DGFLD,DGFNAME) ;Turn on Auditing for Field in File
 D TURNON^DIAUTL(DGFILE,DGFLD)  ;DBIA #4397 Supported
 D MES^XPDUTL("   Enabled AUDIT on file #"_DGFILE_" ("_DGFNAME_"), field #"_DGFLD)
 Q
 ;
UPDTFLE ;Create a new entry in SOURCE OF NOTIFICATIONS file (#47.76)
 N DGFDA,DGERRMSG
 D BMES^XPDUTL("   Add A New Source Of Notification (Department of Defense) to File #47.76.")
 I $$FIND1^DIC(47.76,"","X","Department of Defense") D MES^XPDUTL("   *** 'Department of Defense' Source of Notification entry already exists!") Q
 S DGFDA(47.76,"+1,",.01)="Department of Defense"
 S DGFDA(47.76,"+1,",1)=14
 S DGFDA(47.76,"+1,",2)=1
 D UPDATE^DIE("","DGFDA","","DGERRMSG")
 I $D(DGERRMSG) D MES^XPDUTL("   >>> ERROR! 'Department of Defense' Source of Notification NOT added!"),MES^XPDUTL("           [#"_DGERRMSG("DIERR",1)_": "_DGERRMSG("DIERR",1,"TEXT",1)_"]") Q
 D MES^XPDUTL("   *** 'Department of Defense' Source of Notification successfully added to")
 D MES^XPDUTL("        File #47.76!")
 Q
 ;
QUE ; Queue off the cleanup of names with lowercase letters and missing FULL ICNs
 D BMES^XPDUTL("   Queuing job to clean up lowercase names and missing FULL ICNs.")
 N ZTIO,ZTSK,ZTRTN,ZTDESC,ZTSAVE,ZTDTH,Y
 S ZTIO="",ZTRTN="DFNLOOP^DG944PST",ZTDTH=$H
 S ZTDESC="DG*5.3*944 post-install cleanup of patient names with lowercase letters and missing FULL ICNs"
 D ^%ZTLOAD
 I '$G(ZTSK) D MES^XPDUTL("   **** Queuing job failed!!!") Q
 D MES^XPDUTL("   Job number #"_ZTSK_" was queued.")
 Q
 ;
DFNLOOP ; entry point for queued job to loop on Patient file
 N DFNCNT,DFN,LCCNT,FICNT,NM,START,DONE,CKSUM,MPINODE,FULLICN,ICN,QUIT
 S START=$$FMTE^XLFDT($$NOW^XLFDT)
 S (DFNCNT,DFN,LCCNT,FICNT)=0
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  S DFNCNT=DFNCNT+1 D
 .I $D(^DPT(DFN,-9)) Q
 .S NM=$P($G(^DPT(DFN,0)),"^") I NM]"" I NM'["MERGING" I NM'?.UPN S LCCNT=LCCNT+1 D UPDNM
 .D FULLCHK
 S DONE=$$FMTE^XLFDT($$NOW^XLFDT)
 ;
EMAILS ; Send email to person who ran the INIT, letting them know results
 N XMDUZ,XMTEXT,XMSUB,XMY,XMZ,XMDUN,X,R
 S R(1)="Cleanup of patient names containing lowercase letters and missing FULL ICNs:"
 S R(2)=" "
 S R(3)="Process started: "_START
 S R(4)="Process completed: "_DONE
 S R(5)="Total number of patient names converted to uppercase: "_LCCNT
 S R(6)="Total number of records updated with FULL ICN: "_FICNT
 S R(7)=" ",R(8)="You can now delete the post-init routine ^DG944PST."
 S XMTEXT="R(",XMSUB="Results from running patch DG*5.3*944"
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
 S R(1)="Post-Init routine ^DG944PST run at station: "_DGSITE_" - "_DGSNAME
 S R(2)=" "
 S R(3)="Process Started: "_START_"  -  Completed: "_DONE
 S R(4)=" "
 S R(5)="Total Patient file records processed: "_DFNCNT
 S R(6)=" "
 S R(7)="Total names converted to uppercase: "_LCCNT
 S R(8)=" "
 S R(9)="Total number of records updated with FULL ICN: "_FICNT
 S XMTEXT="R(",XMSUB="Results from running patch DG*5.3*944 at station: "_DGSITE
 S XMDUZ=DUZ
 S XMY("Christine.Chesney@domain.ext")=""
 S XMY("John.Williams30ec0c@domain.ext")=""
 S XMY("Christine.Link@domain.ext")=""
 D ^XMD
 Q
 ;
UPDNM ; convert lowercase letters to uppercase letters and edit .01 in Patient file
 N NEWNM,CHK
 S CHK=NM,NEWNM=$TR(CHK,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 L +^DPT(DFN):10 I '$T Q
 S DIE="^DPT(",DA=DFN,DR=".01///^S X=NEWNM"
 D ^DIE K DIE,DA,DR
 L -^DPT(DFN)
 Q
 ;
FULLCHK ; check and populate FULL ICN field if needed
 Q:'$D(^DPT(DFN,"MPI"))
 S MPINODE=$G(^DPT(DFN,"MPI"))
 S ICN=$P(MPINODE,"^"),CKSUM=$P(MPINODE,"^",2),FULLICN=$P(MPINODE,"^",10)
 Q:FULLICN]""
 I ICN,CKSUM D
 . S FULLICN=ICN_"V"_CKSUM
 . S DIE="^DPT(",DA=DFN,DR="991.1///^S X=FULLICN" D ^DIE S FICNT=FICNT+1
 Q
 ;
BRFILE ; populate business rules into new file.  To ensure this is only done once, check the
 ; file to make sure there are no entries in it already just in case the patch is re-installed.
 ; This way if there are changes broadcast from the MPI, they are not overwritten.
 D MES^XPDUTL("Filed Business Rules for Source of Notifications to Document Types.")
 N DGCOUNT,DGLINE,DGDATA,DGTIEN
 S DGCOUNT=0
 I $P($G(^DG(47.761,0)),"^",4) D  Q
 . D MES^XPDUTL("SOURCE OF NOTIFICATION BUSINESS RULES (#47.761) file already populated.")
 F DGLINE=2:1 S DGDATA=$P($T(BRDATA+DGLINE),";",3) Q:DGDATA=""  D
 . N DGFDA,DGTYPE,DGIEN,DGROOT
 . S DGTYPE=$O(^DG(47.75,"C",$P(DGDATA,"^",2),0))
 . I 'DGTYPE D MES^XPDUTL("Document Type "_$P(DGDATA,"^",2)_" NOT FOUND!!") Q
 . S DGIEN=+DGDATA
 . I '$D(^DG(47.761,DGIEN)) D
 .. N DGFDA
 .. S DGFDA(1,47.761,"+1,",.01)=DGIEN
 .. S DGFDA(1,47.761,"+1,",.02)=1
 .. S DGFDA(1,47.761,"+1,",.03)=DT
 .. S DGIEN(1)=DGIEN
 .. D UPDATE^DIE("","DGFDA(1)","DGIEN","DGROOT")
 . I $D(DGROOT) D MES^XPDUTL("ERROR filing Source "_DGDATA_$G(DGROOT("DIERR",1,"TEXT",1))) Q
 . S DGFDA(1,47.7611,"+1,"_DGIEN_",",.01)=DGTYPE
 . S DGFDA(1,47.7611,"+1,"_DGIEN_",",.02)=1
 . S DGTIEN(1)=DGTYPE
 . D UPDATE^DIE("","DGFDA(1)","DGTIEN","DGROOT")
 . I $D(DGROOT) D MES^XPDUTL("ERROR filing Doc Type "_DGDATA_".") Q
 . S DGCOUNT=DGCOUNT+1
 D MES^XPDUTL("Filed Business Rules for "_DGCOUNT_" of 15 successfully.")
 Q
 ;
BRDATA ; data to populate into the 47.761 file
 ; Format:  Source of Notification^Document Type
 ;;1^INPTD
 ;;8^DC
 ;;8^SPROD
 ;;8^CR
 ;;8^DCUSG
 ;;8^CSUSG
 ;;8^ORUS
 ;;8^NDUCROD
 ;;8^NDPRA
 ;;8^NDCEOR
 ;;8^NODAP
 ;;8^NODOF
 ;;8^NODOFAF
 ;;8^UACCM
 ;;10^EC
 ;;
