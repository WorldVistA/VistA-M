DG53P423 ;ALB/RPM - Pre/Post-Install;Nov 13, 2001 ; 1/16/02 3:33pm
 ;;5.3;Registration;**423**;Aug 13, 1993
 ;
 ;
ENV ;Main entry point for Environment check point.
 ;
 S XPDABORT=""
 D PROGCHK(.XPDABORT) ;checks programmer variables
 I XPDABORT="" K XPDABORT
 Q
 ;
 ;
PRE ;Main entry point for Pre-init items.
 ;
 Q
 ;
 ;
POST ;Main entry point for Post-init items.
 ;
 D POST1  ;rebuild 'AST' index for file #28.11
 D POST2  ;requeue Head and Neck Cancer PTF messages
 Q
 ;
 ;
PROGCHK(XPDABORT) ;checks for necessary programmer variables
 ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") DO
 .D BMES^XPDUTL("*****")
 .D MES^XPDUTL("Your programming variables are not set up properly.")
 .D MES^XPDUTL("Installation aborted.")
 .D MES^XPDUTL("*****")
 .S XPDABORT=2
 Q
 ;
POST1 ;Rebuild the "AST" index for file #28.11
 N DIK,X
 I '$D(^DGNT(28.11,"AST")) D  Q
 . D BMES^XPDUTL(" Re-index of 'AST' cross reference not needed.")
 D BMES^XPDUTL(" Please be patient while I re-index the 'AST' cross reference.")
 K ^DGNT(28.11,"AST")
 S DIK="^DGNT(28.11,",DIK(1)=".03^AST"
 D ENALL^DIK
 D BMES^XPDUTL(" The NOSE AND THROAT RADIUM HISTORY file (#28.11) 'AST' x-ref re-indexed.")
 Q
 ;
POST2 ;Set up TaskMan to re-queue PTF records in the background
 N ZTDESC,ZTDTH,ZTIO,ZTQUEUED,ZTREQ,ZTRTN,ZTSAVE,ZTSK
 S ZTRTN="SCAN^DG53P423"
 S ZTDESC="Re-queue PTF records for DG*5.3*423"
 ;Queue Task to start in 60 seconds
 S ZTDTH=$$SCH^XLFDT("60S",$$NOW^XLFDT)
 S ZTIO=""
 D ^%ZTLOAD
 D BMES^XPDUTL("*****")
 D
 . I $D(ZTSK)[0 D  Q
 . .D MES^XPDUTL("TaskMan run to requeue PTF records for DG*5.3*423 was not started.")
 . .D MES^XPDUTL("Re-run Post Install routine POST2^DG53P423.")
 . D MES^XPDUTL("Task "_ZTSK_" started to requeue PTF records.")
 . I $D(ZTSK("D")) D
 . . D MES^XPDUTL("Task will start at "_$$HTE^XLFDT(ZTSK("D")))
 D MES^XPDUTL("*****")
 Q
 ;
SCAN ;Scan the Nose and Throat Radium History file (#28.11) for patients
 ;who have a Screening Status of either 4:VERIFIED MILITARY MEDICAL
 ;RECORD AND DIAGNOSIS or 5:VERIFIED SERVICE RECORD AND DIAGNOSIS.
 ;Search the PTF records for any messages that would have
 ;been transmitted to the NPCD after the verification date and re-queue
 ;those messages.
 ;
 N DGSTART   ;Job start date/time
 N DGTOTCNT  ;count of verified patients
 N DGPTFCNT  ;count of re-queued PTF records
 N DGMSG     ;free text message/line count passed to NOTIFY
 N DGSTAT    ;NTR Status value
 N DGIEN     ;IEN for NTR History file
 N DGX       ;generic index counter
 N DGNT      ;array of NTR History file nodes
 N DGDTTMP   ;temporary value of NTR verification date
 N DGDFN     ;IEN to PATIENT file (#2)
 N DGDT      ;NTR verification date
 N DGPTFARR  ;array of PTF records to re-queue
 N DGQUIT    ;job control flag
 ;
 S DGSTART=$$NOW^XLFDT
 S (DGMSG,DGQUIT,DGTOTCNT)=0
 S DGPTFCNT="0^0"
 S ZTREQ="@"  ;delete task when finished
 L +^DGP(45.83):3 I '$T D  Q
 . S DGMSG=2
 . S DGMSG(1)="PTF Transmission Currently Running - Patch Re-queue Job Stopping"
 . S DGMSG(2)="Re-run Post Install routine POST2^DG53P423."
 . D NOTIFY(DGSTART,DGTOTCNT,DGPTFCNT,.DGMSG)
 S DGDFN=0
 F  S DGDFN=$O(^DGNT(28.11,"APR",DGDFN)) Q:'DGDFN  D  Q:DGQUIT
 . K DGPTFARR
 . S DGIEN=$O(^DGNT(28.11,"APR",DGDFN,1,0))
 . Q:'DGIEN
 . S DGDT=0
 . F DGX=0:1:2 D
 . . S DGNT(DGX)=$G(^DGNT(28.11,DGIEN,DGX))
 . . S DGDTTMP=+$P(DGNT(DGX),U,$S(DGX=0:7,1:2))  ;get date field
 . . I DGDTTMP>DGDT S DGDT=DGDTTMP
 . Q:'DGDT
 . Q:".4.5."'[("."_$P(DGNT(0),U,3)_".")    ;only verified N/T
 . S DGTOTCNT=DGTOTCNT+1
 . ;search for any PTF records that were xmit'ed and re-queue them
 . I $$GETPTF(DGDFN,DGDT,.DGPTFARR) D REQPTF(.DGPTFARR,.DGPTFCNT)
 . I $$S^%ZTLOAD D  Q
 . . S DGMSG=2
 . . S DGMSG(1)="Patch DG*5.3*423 PTF Re-queue Task Stopped by User"
 . . S DGMSG(2)="Re-run Post Install routine POST2^DG53P423."
 . . S (ZTSTOP,DGQUIT)=1
 L -^DGP(45.83)
 D NOTIFY(DGSTART,DGTOTCNT,DGPTFCNT,.DGMSG)
 Q
 ;
GETPTF(DFN,DGDAT,DGPT) ;Find PTF records transmitted after the verification
 ; date.  Build array subscripted by record numbers set equal to the
 ; PTF record type.
 ;
 ;  Input
 ;    DFN   - IEN to PATIENT file (#2)
 ;    DGDAT - date of NTR verification
 ;    DGPT - array node passed by reference
 ;
 ;  Output
 ;    DGPT - array of PTF record types and queue dates (1:PTF,2:CENSUS)
 ;           subscripted by PTF record # (ex. DGPT(1402)=2^3011212)
 ;    function result - 0 : no records found
 ;                      1 : records found
 ;
 N DGPTF  ;PTF record number (file #45 IEN)
 N DGQDT  ;Date Queued
 N DGRTY  ;Record type
 N DGPT0  ;zero node of patient's PTF record
 ;
 I '$D(^DGPT("B",DFN)) Q 0
 S DGPTF=0
 F  S DGPTF=$O(^DGPT("B",DFN,DGPTF)) Q:'DGPTF  D
 . ;borrowed from DIC("S") in DREL^DGPTFDEL
 . I $D(^DGPT(DGPTF,0)),$D(^DGPT(DGPTF,70)),+^DGPT(DGPTF,70)>2901000,$D(^DGP(45.83,"C",DGPTF)) D
 . . S DGPT0=^DGPT(DGPTF,0),DGRTY=$P(DGPT0,U,11)
 . . S DGQDT=$O(^DGP(45.83,"C",DGPTF,0))
 . . I DGQDT_".999999">DGDAT,DGRTY>0,DGRTY<3 S DGPT(DGPTF)=DGRTY_U_DGQDT
 Q ($D(DGPT)>0)
 ;
REQPTF(DGPTFT,DGPTFC) ;Re-queue the PTF record for transmission
 ;  Input
 ;    DGPTFT - array of PTF record #'s to resend for a patient
 ;    DGPTFC - count of re-queued PTF records
 ;
 ;  Output
 ;    DGPTFC - count of re-queued PTF records PTF^CENSUS
 ;             (ex.  DGPTFC=4^1)
 ;
 N DGPTF  ;PTF record number
 N DGRTY  ;PTF record type (1:PTF, 2:CENSUS)
 N DGDAT  ;Date of queuing for previous transmission
 ;
 S DGPTF=0
 F  S DGPTF=$O(DGPTFT(DGPTF)) Q:'DGPTF  D
 . S DGRTY=+DGPTFT(DGPTF),DGDAT=$P(DGPTFT(DGPTF),U,2)
 . I $$UNREL(DGPTF,DGDAT) D RELEASE(DGPTF) S $P(DGPTFC,U,DGRTY)=$P(DGPTFC,U,DGRTY)+1
 Q
 ;
UNREL(DGPTF,DGDT) ;Unrelease the PTF record - borrowed from OK^DGPTFDEL
 ;
 ;  Input:
 ;    DGPTF - PTF record number
 ;    DGDT  - Date of Previously Queued Transmission
 ;
 ;  Output:
 ;    function result 1:success, 0:failure
 ;
 N DA,DIK  ;FileMan variables
 ;
 S DA(1)=DGDT
 I 'DA(1) Q 0
 S DIK="^DGP(45.83,"_DA(1)_",""P"",",DA=DGPTF D ^DIK
 Q 1
 ;
RELEASE(DGPTF) ;Re-release the PTF record - borrowed from REL^DGPTFREL
 ;
 ;  Input:
 ;    DGPTF - PTF record number
 ;
 ;  Output:
 ;    none
 ;
 N DA,DIC,DIE,DINUM,DR,X  ;FileMan variables
 ;
 ;if date entry doesn't exist then create new entry and "P" node
 I '$D(^DGP(45.83,DT,0)) D
 . S (DINUM,X)=DT,DIC="^DGP(45.83,",DIC(0)="L"
 . K DD,DO
 . D FILE^DICN
 . K DINUM,DIC
 I '($D(^DGP(45.83,DT,"P",0))#2) S ^DGP(45.83,DT,"P",0)="^45.831PA^0^0"
 ;if transmission date exists then clear it to allow re-transmission
 I $P(^DGP(45.83,DT,0),U,2) D
 . S DA=DT,DIE="^DGP(45.83,",DR="1///@"
 . D ^DIE
 . K DA,DIE,DR
 ;add the PTF record to the queue
 S (DINUM,X)=DGPTF,DIC(0)="L",DA(1)=DT,DIC="^DGP(45.83,"_DT_",""P"","
 D FILE^DICN
 K DA,DIC,DINUM
 ;update RELEASE DATE and RELEASED BY fields in PTF CLOSE OUT file.
 S DA=DGPTF,DIE="^DGP(45.84,",DR="4////"_DT_";5////"_DUZ
 D ^DIE
 K DA,DIE,DR
 Q
 ;
NOTIFY(DGSTIME,DGTOT,DGPTFNUM,DGMESS) ;send job msg
 ;
 ;  Input
 ;    DGSTIME - job start date/time
 ;    DGTOT - count of patients checked
 ;    DGPTFNUM - count of PTF messages re-queued
 ;    DGMESS - free text message array for task stop or errors passed
 ;             by reference
 ;
 ;  Output
 ;    none
 ;
 N DIFROM,XMDUZ,XMSUB,XMTEXT,XMY,XMZ
 N DGSITE,DGETIME,DGTEXT,DGI
 S DGSITE=$$SITE^VASITE
 S DGETIME=$$NOW^XLFDT
 S XMDUZ="PTF Re-queue"
 S XMSUB="Patch DG*5.3*423 Mill Bill Co-Pay Enhancements"
 S XMTEXT="DGTEXT("
 S XMY(DUZ)=""
 S DGTEXT(1)=""
 S DGTEXT(2)="          Facility Name:  "_$P(DGSITE,U,2)
 S DGTEXT(3)="         Station Number:  "_$P(DGSITE,U,3)
 S DGTEXT(4)=""
 S DGTEXT(5)="  Date/Time job started:  "_$$FMTE^XLFDT(DGSTIME)
 S DGTEXT(6)="  Date/Time job stopped:  "_$$FMTE^XLFDT(DGETIME)
 S DGTEXT(7)=""
 I $G(DGMESS) D
 . F DGI=1:1:DGMESS D
 . . S DGTEXT(7+DGI)="*** "_$E($G(DGMESS(DGI)),1,65)
 I '$G(DGMESS) D
 . S DGTEXT(8)="PTF Message Re-queue Complete"
 . S DGTEXT(9)="Total Verified patients in file (#28.11): "_DGTOT
 . S DGTEXT(10)="Total PTF     records re-queued: "_$P(DGPTFNUM,U,1)
 . S DGTEXT(11)="Total CENSUS  records re-queued: "_$P(DGPTFNUM,U,2)
 D ^XMD
 Q
