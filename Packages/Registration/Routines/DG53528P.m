DG53528P ;ALB/ERC - COMBAT VET PRE & POSTINSTALLS ;7/22/03
 ;;5.3;Registration;**528**; Aug 13, 1993
 ;
PRE ;add 5 new entries to the INCONSISTENT DATA ELEMENTS file (#38.6)
 ;to alert users that critical dates for the determination of CV
 ;status are either imprecise or missing
 ;
 ;first check to see if patch already installed - if so do not
 ;add these new entries
 I $$PATCH^XPDUTL("DG*5.3*528") Q
 N DGK,DGWP
 K XPDABORT
 F DGK=67:1:71 I $D(^DGIN(38.6,DGK)) Q:$G(XPDABORT)=2  D
 . D BMES^XPDUTL(" ** Internal Entry # "_DGK_" already exists in file #38.6, contact NVS **")
 . S XPDABORT=2
 I $G(XPDABORT)'=2 D
 . D BMES^XPDUTL("  >> Adding new entries into the INCONSISTENT DATA ELEMENTS file (#38.6).")
 . D ADD
 Q
ADD ;set up FDA arrays for the addition of new entries in 38.6
 N DG,DG67,DG68,DG69,DG70,DG71,DGERR,DGFDA,DGIEN,DGWORD,DGX
 D SET
 F DGX=DG67,DG68,DG69,DG70,DG71 D
 . K DGFDA
 . S DGFDA(38.6,"+1,",.01)=$P(DGX,U)
 . S DGFDA(38.6,"+1,",2)=$P(DGX,U,2)
 . S DGFDA(38.6,"+1,",50)="DGWP"
 . S DGWP(1,0)=DGWORD
 . I $D(DGFDA) D UPD
 Q
UPD ;call UPDATE^DIE
 S DGIEN(1)=$P(DGX,U,3)
 D UPDATE^DIE("E","DGFDA","DGIEN","DGERR")
 I $D(DGERR) D BMES^XPDUTL("   >>> ERROR! "_$P($G(DGX),U)_" not added to file #38.6"),MES^XPDUTL(DGERR("DIERR",1)_": "_DGERR("DIERR",1,"TEXT",1)) Q
 D BMES^XPDUTL("      "_$P($G(DGX),U)_" successfully added.")
 Q
SET ;set the entry field values into variables
 N DGA,DGB
 S DGA="NO CV, CHECK "
 S DGB="Imprecise or Missing"
 S DGWORD="Combat Vet status cannot be determined if critical dates are missing or imprecise."
 S DG67=DGA_"SERVICE SEP DATE^SERVICE SEPARATION DATE [LAST] "_DGB_"^"_67
 S DG68=DGA_"COMBAT TO DATE^COMBAT TO DATE "_DGB_"^"_68
 S DG69=DGA_"YUGOSLAV TO DATE^YUGOSLAVIA TO DATE "_DGB_"^"_69
 S DG70=DGA_"SOMALIA TO DATE^SOMALIA TO DATE "_DGB_"^"_70
 S DG71=DGA_"PERS GULF TO DATE^PERSIAN GULF TO DATE "_DGB_"^"_71
 Q
 ;
POST ;post install routine for Combat Veteran - will loop through the
 ;Patient file and populate field .5295 (Combat Veteran End Date)
 ;for any veterans who are eligible (.5296 will be also stuffed with
 ;the current date in SERCV^DGCV and DELCV^DGCV)
 N DFN,DG,DGDONE,ZTSAVE
 D POST1 Q:DGDONE
 D POSTQ
 Q
POST1 ;check to see if process already finished, already started or currently 
 ;running
 N DGMSG,DGSTAT,DGTASK
 S DGDONE=0
 I '$D(^XTMP("DGCV")) Q
 I $G(^XTMP("DGCV","DONE"))=1 D  Q
 . S DGMSG="COMBAT VET INITIAL SEEDING COMPLETED ON PREVIOUS INSTALL. EXITING"
 . D BMES^XPDUTL(.DGMSG)
 . S DGDONE=1
 I $G(DGREQ)'=1 K ^XTMP("DGCV")
 S DGTASK=$G(^XTMP("DGCV","TASK"))
 I DGTASK'="" D
 . S DGSTAT=$$ACTIVE(DGTASK)
 . I DGSTAT>0 S DGMSG="Task: "_DGTASK_" is currently running, cannot start duplicate process." D
 . . D BMES^XPDUTL(.DGMSG)
 . . S DGDONE=1
 Q
ACTIVE(DGTASK) ;check to see if task already running
 ;  DGTASK - taskman task number
 ;  output - (1,0) is the task running?
 N DGSTAT,Y,ZTSK
 S DGSTAT=0,ZTSK=DGTASK
 D STAT^%ZTLOAD
 S Y=ZTSK(1)
 I Y=0 S DGSTAT=-1
 I ",1,2,"[(","_Y_",") S DGSTAT=1
 I ",3,5,"[(","_Y_",") S DGSTAT=0
 Q DGSTAT
POSTQ ;queue the task
 N DGTXT,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSK
 S ZTRTN="LOOP^DG53528P",ZTIO="",ZTDTH=$$NOW^XLFDT()
 S ZTDESC="COMBAT VET INITIAL DATA SEEDING"
 S ZTSAVE("POS1")="",ZTSAVE("XPDQUES")=""
 S ZTSAVE("*")=""
 D NOW^%DTC
 S ZTDTH=%
 D ^%ZTLOAD
 S ^XTMP("DGCV","TASK")=ZTSK
 S DGTXT(1)="Task: "_ZTSK_" queued."
 D BMES^XPDUTL(.DGTXT)
 Q
LOOP ;
 N DGC,DGT,X,X1,X2,ZTSTOP
 S (DFN,DGC,DGT,ZTSTOP)=0
 S DFN=+$G(^XTMP("DGCV","DFN"))
 S X1=DT,X2=30 D C^%DTC
 S ^XTMP("DGCV",0)=X_"^"_$$DT^XLFDT_"^Combat Veteran Initial Patient File Seeding - DG*5.3*528"
 I '$D(^XTMP("DGCV","START")) S ^XTMP("DGCV","START")=$$FMTE^XLFDT($$NOW^XLFDT(),"5P")
 I $G(XPDQUES("POS1","B"))]"" S IOP=$G(XPDQUES("POS1","B")) ;result of install question
 I $G(IOP)]"" D
 . S IOP=$O(^%ZIS(1,"B",IOP,""))
 . S IOP="`"_IOP
 I $G(IOP)]"" D
 . S ^XTMP("DGCV","DEVICE")=IOP
 . I '$D(^XTMP("DGCV",0)) D
 . . N X,X1,X2
 . . S X1=DT,X2=60 D C^%DTC
 . . S ^XTMP("DGCV",0)=X_"^"_$$DT^XLFDT_"^Combat Veteran Initial Patient File Seeding - DG*5.3*528"
 ;
 F  S DFN=$O(^DPT(DFN)) Q:+DFN=0!(ZTSTOP)  D
 . S DG=0
 . S DGT=DGT+1 ;count of records checked
 . S ^XTMP("DGCV","DFN")=DFN ;current DFN
 . I (DGT#1000=0),($$S^%ZTLOAD) S ZTSTOP=1 ;is there a stop request?
 . S DG=$$CVELIG^DGCV(DFN)
 . I +$G(DG)=1 D
 . . S DGSRV=$$GET1^DIQ(2,DFN_",",.327,"I")
 . . I $G(DGSRV)']"" Q
 . . D SETCV^DGCV(DFN,DGSRV)
 . . S DGC=DGC+1
 . S ^XTMP("DGCV","COUNT")=DGT_"^"_DGC
 . Q:$G(DGSRV)']""
 . I $G(DG)=0!($G(DG)=1)!($G(DG)']"") Q
 . D RPT^DGCV1(DG)
 S $P(^XTMP("DGCV","START"),U,2)=$$FMTE^XLFDT($$NOW^XLFDT(),"5P")
 I ZTSTOP D  Q
 . N DGMSG,XMDUZ,XMSUB,XMTEXT,XMY
 . S XMSUB="COMBAT VET INITIAL DATA SEEDING"
 . S DGMSG(1)="Patch DG*5.3*528"
 . S DGMSG(2)="Combat Veteran Initial database seeding was interrupted by"
 . S DGMSG(3)="user request.  Please re-start by using the following command at the"
 . S DGMSG(4)="programmer prompt."
 . S DGMSG(5)="D REQUE^DG53528P"
 . D BMES^XPDUTL(.DGMSG)
 . D SENDMSG^XMXAPI(DUZ,XMSUB,"DGMSG",DUZ)
 D REPORT^DGCV1
 N DGMSG
 S DGMSG(1)=""
 S DGMSG(2)="   Patient file seeding completed...."
 S XMSUB="COMBAT VET INITIAL DATA SEEDING - DG*5.3*528"
 D SENDMSG^XMXAPI(DUZ,XMSUB,"DGMSG",DUZ)
 D BMES^XPDUTL(.DGMSG)
 S ^XTMP("DGCV","DONE")=1
 K DG,DGCOM,DGCVDT,DGGULF,DGSOM,DGSRV,DGYUG
 Q
REQUE ;requeue initial seeding if interrupted
 N DGREQ
 S DGREQ=1
 D POST
 Q
