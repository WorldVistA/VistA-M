ICD186E ;DLS/DEK- ICD Env. Check; 04/28/2003
 ;;18.0;DRG Grouper;**6**;Oct 20, 2000
 ;
 ; External References
 ;   DBIA  10141  $$PATCH^XPDUTL
 ;   DBIA  10141  BMES^XPDUTL   
 ;   DBIA  10141  MES^XPDUTL
 ;                           
ENVCHK ; Check Environment for needed vars.
 N PATCH,BUILD
 S XPDABORT="",PATCH="ICD*18.0*5",BUILD="ICD*18.0*6"
 I '$$PATCH^XPDUTL(PATCH) D  Q
 . D BM(PATCH_" is required and MUST be installed prior to this patch."),ABRT
 I +($$CPD)'>0,+($G(XPDENV))=0 D
 . I +($G(^LEXM(0,"CHECKSUM")))'=70183825959 D
 . . D BM("Global ^LEXM either not found or incomplete."),ABRT
 D:+($G(XPDABORT))'>0 PROGCHK(.XPDABORT)
 I $G(XPDABORT)="" K XPDABORT D OK
 Q
PROGCHK(XPDABORT) ; Check for Programmer
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D
 . D BM("Programming variables are not set up properly."),ABRT
 Q
ABRT ; Abort - All or nothing
 S XPDABORT=1,XPDQUIT=1,XPDQUIT("LEX*2.0*25")=1
 S XPDQUIT("ICD*18.0*6")=1,XPDQUIT("ICPT*6.0*14")=1
 S XPDQUIT("CSV UTIL 1.0")=1
 Q
OK ; Environment is Ok
 Q:+($G(XPDENV))>0
 D BM(("  Environment for patch/build "_BUILD_" is ok")),M(" ")
 Q
 ;                     
POST ; Post-Install - Rebuild Indexes
 N ZTRTN,ZTDESC,ZTSK,ZTDTH,ZTIO,ZTQUEUED,ZTREQ,ICD1,ICD2 S (ICD1,ICD2)=0
 S ZTRTN="ICDD^ICD186E",ZTDESC="Re-Index file #80"
 S ZTIO="",ZTDTH=$H K ZTSK D ^%ZTLOAD,HOME^%ZIS
 S:+($G(ZTSK))>0 ICD1=+($G(ZTSK))
 S ZTRTN="ICDP^ICD186E",ZTDESC="Re-Index file #80.1"
 S ZTIO="",ZTDTH=$H D ^%ZTLOAD,HOME^%ZIS
 S:+($G(ZTSK))>0 ICD2=+($G(ZTSK))
 I ICD1>0,ICD2'>0 D BM(("Task "_+ICD1_" to rebuild indexes for ICD Diagnosis file #80 started"))
 I ICD1'>0,ICD2>0 D BM(("Task "_+ICD2_" to rebuild indexes for ICD Procedure file #80.1 started"))
 I ICD1>0,ICD2>0 D
 . D BM(("Task "_+ICD1_" to rebuild indexes for ICD Diagnosis file #80 started"))
 . D M(("Task "_+ICD2_" to rebuild indexes for ICD Procedure file #80.1 started"))
 K Y,ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ICD1,ICD2
 Q
ICDD ;   ICD9( Diagnosis
 S:$D(ZTQUEUED) ZTREQ="@"
 N DA,DIK S U="^",DT=$$DT^XLFDT,DIK="^ICD9(",DA=0
 F  S DA=$O(^ICD9(DA)) Q:+DA=0  K ^ICD9(DA,66,"B")
 K ^ICD9("AB"),^ICD9("ACC"),^ICD9("ACT")
 K ^ICD9("BA"),^ICD9("D")
 D IXALL^DIK
 Q
ICDP ;   ICD0( Procedure
 S:$D(ZTQUEUED) ZTREQ="@"
 N DA,DIK S U="^",DT=$$DT^XLFDT,DIK="^ICD0(",DA=0
 F  S DA=$O(^ICD0(DA)) Q:+DA=0  K ^ICD0(DA,66,"B")
 K ^ICD0("AB"),^ICD0("ACT"),^ICD0("BA"),^ICD0("D")
 K ^ICD0("E") D IXALL^DIK
 Q
CPD(X) ;   Check Current Patched Data is installed
 Q:$D(^LEX(757.1,"B",180595,257762))&('$D(^LEX(757.02,"B",322162,3296))) 1
 Q 0
 ;                     
 ; Miscellaneous
BM(X) ;   Blank Line with Message
 S X=" "_$G(X) D:$D(XPDNM) BMES^XPDUTL($G(X)) W:'$D(XPDNM) !!,$G(X) Q
M(X) ;   Message
 S X=" "_$G(X) D:$D(XPDNM) MES^XPDUTL($G(X)) W:'$D(XPDNM) !,$G(X) Q
