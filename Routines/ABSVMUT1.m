ABSVMUT1 ;OAKLANDFO/DPC-VSS MIGRATIOIN;8/3/2002
 ;;4.0;VOLUNTARY TIMEKEEPING;**31,33**;Jul 1994
 ;
BLDVOLLT(FLAG)       ;
 ;
 ;FLAG="S" -- Only need site data into ABSSITES()
 N REGIEN,VOLPTR,SITE,REG0,SRTDATE,ENTRY,TERM
 K ^TMP("ABSVM","VOLWHRS",$J),ABSSITES
 S REGIEN=0
 F  S REGIEN=$O(^ABS(503331,REGIEN)) Q:'REGIEN  D
 . S REG0=$G(^ABS(503331,REGIEN,0))
 . I $P(REG0,U,3)<2961001 Q
 . S VOLPTR=$P(REG0,U)
 . S SITE=$P(REG0,U,7)
 . ;check for excluded sites
 . Q:(VOLPTR="")!(SITE="")  Q:$D(EXSITES(SITE))
 . I $G(FLAG)="S" S ABSSITES(SITE)="" Q
 . S ^TMP("ABSVM","VOLWHRS",$J,VOLPTR,SITE)=""
 . Q
 ;check for new volunteer's, less than 90 days, with no hours
 S VOLPTR=0,SRTDATE=$$HTFM^XLFDT($$HADD^XLFDT($H,-90))
 F  S VOLPTR=$O(^ABS(503330,VOLPTR)) Q:VOLPTR=""  D
 . S REGIEN=0
 . F  S REGIEN=$O(^ABS(503330,VOLPTR,4,REGIEN)) Q:'REGIEN  D
 .. S REG0=$G(^ABS(503330,VOLPTR,4,REGIEN,0))
 .. Q:REG0=""
 .. ;check for excluded sites
 .. S SITE=$P(REG0,U,12)  Q:SITE=""  Q:$D(EXSITES(SITE))
 .. S ENTRY=$P(REG0,U,2),TERM=$P(REG0,U,8)
 .. I ENTRY>SRTDATE,TERM="",'$D(^TMP("ABSVM","VOLWHRS",$J,VOLPTR,REGIEN)) S ^(REGIEN)=""
 .. Q
 Q
 ;
EXSITES ;get exclude sites and put in EXSITES array
 ;
 N I,J,X
 K EXSITES
 ;there should only be one entry at top level
 S I=$O(^ABS(503339.5,"IN","N",0)),J=0 Q:I=""
 F  S J=$O(^ABS(503339.5,"IN","N",I,J)) Q:J=""  D
 . S X=$P($G(^ABS(503339.5,I,1,J,0)),U)
 . S:X]"" EXSITES(X)=""
 Q
 ;
ABSIEN ;get the ien of Migration Log file
 ;returns ABSIEN=IEN or 0 if failed
 S ABSIEN=0
 D LIST^DIC(503339.5)
 I '^TMP("DILIST",$J,0) D  Q
 . W "You must run the Prepare for Transition to VSS option first."
 . W !,"If you have any questions, contact the System Implementation team."
 . Q
 I ^TMP("DILIST",$J,0)>1 D  Q
 . W "You have multiple entries in the Voluntary Migration Log."
 . W !,"Contact System Implementation."
 S ABSIEN=^TMP("DILIST",$J,2,1)
 ;
SETUPXTP ;
 ;Sets up 0-nodes in XTMP
 S ^XTMP("ABSVMORG",0)=$$NOW^XLFDT_U_$$HTFM^XLFDT($$HADD^XLFDT($H,30))_U_"Voluntary Organizations to be migrated."
 S ^XTMP("ABSVMSERV",0)=$$NOW^XLFDT_U_$$HTFM^XLFDT($$HADD^XLFDT($H,30))_U_"Voluntary Services to be migrated."
 S ^XTMP("ABSVMOHRS",0)=$$NOW^XLFDT_U_$$HTFM^XLFDT($$HADD^XLFDT($H,30))_U_"Voluntary Occasional Hours to be migrated."
 S ^XTMP("ABSVMRHRS",0)=$$NOW^XLFDT_U_$$HTFM^XLFDT($$HADD^XLFDT($H,30))_U_"Voluntary Regular Hours to be migrated."
 S ^XTMP("ABSVMVOL",0)=$$NOW^XLFDT_U_$$HTFM^XLFDT($$HADD^XLFDT($H,30))_U_"Volunteers to be migrated."
 S ^XTMP("ABSVMVOLP",0)=$$NOW^XLFDT_U_$$HTFM^XLFDT($$HADD^XLFDT($H,30))_U_"Volunteer Profiles to be migrated."
 S ^XTMP("ABSVMVOLCB",0)=$$NOW^XLFDT_U_$$HTFM^XLFDT($$HADD^XLFDT($H,30))_U_"Volunteer Combination Codes to be migrated."
 S ^XTMP("ABSVMVOLPK",0)=$$NOW^XLFDT_U_$$HTFM^XLFDT($$HADD^XLFDT($H,30))_U_"Volunteer Parking Stickers to be migrated."
 Q
 ;
CLEANXTP ;
 ;Empties all the XTMP()s and TMP holding IENs to Export.
 K ^XTMP("ABSVMSERV"),^XTMP("ABSVMORG")
 K ^XTMP("ABSVMRHRS"),^XTMP("ABSVMOHRS")
 K ^XTMP("ABSVMVOL"),^XTMP("ABSVMVOLP")
 K ^XTMP("ABSVMVOLCB"),^XTMP("ABSVMVOLPK")
 K ^TMP("ABSVM","VOLWHRS"),^TMP("ABSVM",$J)
 Q
 ;
LDCDS ;
 ;Call routines that Load codes for orgs, services,
 ;work schedules and awards into Local arrays.
 D LDORGS^ABSVMLC1 ;Organizations into OCDS()
 D LDSRVS^ABSVMLC2 ;Services into SCDS()
 D LDWKS^ABSVMLC3 ; Work Schedules into WCDS()
 D LDAWDS^ABSVMLC3 ;Awards into ACDS()
 Q
 ;
CLEANCDS ;
 ;Kills local arrays of national codes
 K OCDS,SCDS,WCDS,ACDS
 Q
 ;
CRERRLOG(RUNTYPE,SEND) ;
 ;Function that creates an entry in the VALIDATION RESULTS multiple.
 ;Returns the DA of the subentry.
 N ABSVMFDA,ABSVMIEN,DIERR,ABSIEN
 ;Get IEN of Migration Log entry.
 D ABSIEN Q:'ABSIEN
 ;Set TIME RUN = NOW
 S ABSVMFDA(503339.52,"+1,"_ABSIEN_",",.01)=$$NOW^XLFDT
 ;Set VALIDATED DATA = Type passed in.
 S ABSVMFDA(503339.52,"+1,"_ABSIEN_",",1)=RUNTYPE
 I $G(SEND)["S" S ABSVMFDA(503339.52,"+1,"_ABSIEN_",",2)="Y"
 E  S ABSVMFDA(503339.52,"+1,"_ABSIEN_",",2)="N"
 D UPDATE^DIE(,"ABSVMFDA","ABSVMIEN")
 I $G(DIERR)="" Q ABSVMIEN(1) ;Successful creation
 D MSG^DIALOG()
 Q 0
 ;
RECERR(VALRESUL,ERRORS) ;
 ;Records errors in the VALIDATION RESULTS multiple.
 ;Also, increments the error count.
 ;Get IEN of Migration Log entry.
 I $G(VALRESUL("ERRIEN"))="" D
 . N ABSIEN
 . D ABSIEN Q:'ABSIEN
 . S VALRESUL("ERRIEN")=ABSIEN
 . Q
 D WP^DIE(503339.52,VALRESUL("DA")_","_VALRESUL("ERRIEN")_",",4,"A","ERRORS")
 S VALRESUL("ERRCNT")=$G(VALRESUL("ERRCNT"))+1
 Q
 ;
ERRCNT(VALRESUL) ;
 ;Records the number of errors during a run.
 N ABSVMFDA,ABSIEN
 I $G(VALRESUL("ERRIEN"))="" D
 . D ABSIEN Q:'ABSIEN
 . S VALRESUL("ERRIEN")=ABSIEN
 . Q
 S ABSVMFDA(503339.52,VALRESUL("DA")_","_VALRESUL("ERRIEN")_",",3)=VALRESUL("ERRCNT")
 D FILE^DIE(,"ABSVMFDA")
 Q
 ;
