ICPT614E ;DLS/DEK- ICPT Env. Check; 04/28/2003
 ;;6.0;CPT/HCPCS;**14**;May 19, 1997
 ;
 ; External References
 ;   DBIA  10141  $$PATCH^XPDUTL
 ;   DBIA  10141  BMES^XPDUTL   
 ;   DBIA  10141  MES^XPDUTL    
 ;                    
ENVCHK ; Check Environment for needed vars.
 N PATCH,BUILD
 S XPDABORT="",PATCH="ICPT*6.0*13",BUILD="ICPT*6.0*14"
 F PATCH="ICPT*6.0*12","ICPT*6.0*13" D  Q:+($G(XPDABORT))>0 
 . I '$$PATCH^XPDUTL(PATCH) D
 . . D BM(PATCH_" is required and MUST be installed prior to this patch."),ABRT
 I +($$CPD)'>0,+($G(XPDENV))=0 D
 . I +($G(^LEXM(0,"CHECKSUM")))'=70183825959 D
 . . D BM("Global ^LEXM either not found or incomplete."),ABRT
 Q:+($G(XPDABORT))>0  D PROGCHK(.XPDABORT)
 I $G(XPDABORT)="" K XPDABORT D OK
 Q
 ;
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
 N ZTRTN,ZTDESC,ZTSK,ZTDTH,ZTIO,CPT1,CPT2 S (CPT1,CPT2)=0
 S ZTRTN="CPTP^ICPT614E",ZTDESC="Re-Index file #81"
 S ZTIO="",ZTDTH=$H K ZTSK D ^%ZTLOAD,HOME^%ZIS
 S:+($G(ZTSK))>0 CPT1=+($G(ZTSK))
 S ZTRTN="CPTM^ICPT614E",ZTDESC="Re-Index file #81.3"
 S ZTIO="",ZTDTH=$H D ^%ZTLOAD,HOME^%ZIS
 S:+($G(ZTSK))>0 CPT2=+($G(ZTSK))
 I CPT1>0,CPT2'>0 D BM(("Task "_+CPT1_" to rebuild indexes for CPT Procedures file #81 started"))
 I CPT1'>0,CPT2>0 D BM(("Task "_+CPT2_" to rebuild indexes for CPT Modifier file #81.3 started"))
 I CPT1>0,CPT2>0 D
 . D BM(("Task "_+CPT1_" to rebuild indexes for CPT Procedures file #81 started"))
 . D M(("Task "_+CPT2_" to rebuild indexes for CPT Modifier file #81.3 started"))
 K Y,ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,CPT1,CPT2
 Q
CPTP ;   ICPT( Procedures
 S:$D(ZTQUEUED) ZTREQ="@"
 N DA,DIK S U="^",DT=$$DT^XLFDT,DIK="^ICPT(",DA=0
 F  S DA=$O(^ICPT(DA)) Q:+DA=0  K ^ICPT(DA,60,"B")
 K ^ICPT("ACT"),^ICPT("B"),^ICPT("BA"),^ICPT("C")
 K ^ICPT("D"),^ICPT("E"),^ICPT("F") D IXALL^DIK
 Q
CPTM ;   DIC(81.3, Modifiers
 S:$D(ZTQUEUED) ZTREQ="@"
 N DA,DIK S U="^",DT=$$DT^XLFDT,DIK="^DIC(81.3,",DA=0
 F  S DA=$O(^DIC(81.3,DA)) Q:+DA=0  D
 . K ^DIC(81.3,DA,60,"B"),^DIC(81.3,DA,"M")
 K ^DIC(81.3,"ACT"),^DIC(81.3,"B"),^DIC(81.3,"BA")
 K ^DIC(81.3,"C"),^DIC(81.3,"D") D IXALL^DIK
 Q
CPD(X) ;   Check Current Patched Data is installed
 Q:$D(^LEX(757.1,"B",180595,257762))&('$D(^LEX(757.02,"B",322162,3296))) 1
 Q 0
 ;                  
 ; Miscellaneous
BM(X) ;   Blank Line with Message
 S X=" "_$G(X) Q:$D(GMTSQT)  D:$D(XPDNM) BMES^XPDUTL($G(X)) W:'$D(XPDNM) !!,$G(X) Q
M(X) ;   Message
 S X=" "_$G(X) Q:$D(GMTSQT)  D:$D(XPDNM) MES^XPDUTL($G(X)) W:'$D(XPDNM) !,$G(X) Q
