DG53632P ;ALB/LBD - Post install routine for DG*5.3*632; 1 NOV 2004
 ;;5.3;Registration;**632**; Aug 13, 1993
 ;
POST ; Post install entry point
 D FVINC Q:$G(XPDABORT)=2
 D UNEMPOW
 Q
FVINC ; Add new entry #86 to the INCONSISTENT DATA ELEMENTS file (#38.6)
 N DGFDA,DGIEN,DGERR,ROOT,DGWP,DGINC
 K XPDABORT
 D BMES^XPDUTL(">>> Adding entry #86 to the INCONSISTENT DATA ELEMENTS file (#38.6) <<<")
 S DGINC="INEL FIL VET SHOULD BE VET='N'"
 I $D(^DGIN(38.6,86,0)) D  Q
 .D BMES^XPDUTL("   Internal entry #86 already exists in file #38.6")
 .I $P($G(^DGIN(38.6,86,0)),U)=DGINC D MES^XPDUTL("   Entry matches incoming inconsistency for Filipino Vet - OK") Q
 .D MES^XPDUTL("    >>> ERROR: Entry #86 needs to be reviewed by EVS!")
 .D MES^XPDUTL("        Existing entry: "_$P($G(^DGIN(38.6,86,0)),U))
 .D MES^XPDUTL("        Incoming entry: "_DGINC)
 .D BMES^XPDUTL("        <<<<   INSTALLATION ABORTED   >>>>")
 .S XPDABORT=2
 S ROOT="DGFDA(38.6,""?+1,"")"
 S @ROOT@(.01)=DGINC
 S @ROOT@(2)="INELIGIBLE FILIPINO VETERAN SHOULD HAVE A VETERAN STATUS OF 'NO'"
 S @ROOT@(3)=3
 S @ROOT@(50)="DGWP"
 S DGWP(1,0)="Inconsistency results if a veteran has a Filipino Veteran branch of"
 S DGWP(2,0)="service (F.COMMONWEALTH, F.GUERILLA, F.SCOUTS NEW, or F.SCOUTS OLD),"
 S DGWP(3,0)="but is ineligible because of no World War II military service dates"
 S DGWP(4,0)="or no proof of F.Vet eligibility (for the first three BOS only), and"
 S DGWP(5,0)="the Veteran Status is set to 'YES'."
 S DGIEN(1)=86
 D UPDATE^DIE("","DGFDA","DGIEN","DGERR")
 I $D(DGERR) D  Q
 .D BMES^XPDUTL("   >>> ERROR: "_DGINC_" not added to file #38.6")
 .D MES^XPDUTL("     "_DGERR("DIERR",1)_": "_DGERR("DIERR",1,"TEXT",1))
 .D BMES^XPDUTL("                <<<<   INSTALLATION ABORTED  >>>>")
 .S XPDABORT=2
 D BMES^XPDUTL("    "_DGINC_" successfully added.")
 Q
 ;
UNEMPOW ; Run update process for Unemployable and POW Veterans
 D BMES^XPDUTL(">>> Update process for Unemployable and POW Veterans <<<")
 Q:'$$CHK
 D QUETASK
 Q
QUETASK ; Queue the Unemp/POW Vet update job
 N TXT,ZTRTN,ZTDESC,ZTSK,ZTIO,ZTDTH
 S ZTRTN="EN^DG53632P",ZTIO="",ZTDTH=$$NOW^XLFDT()
 S ZTDESC="UPDATE PROCESS FOR UNEMPLOYABLE AND POW VETS"
 D ^%ZTLOAD S ^XTMP("DG53632P",0,"TASK")=$G(ZTSK)
 S TXT=$S($G(ZTSK):"Task: "_ZTSK_" Queued.",1:"Error: Process not queued!")
 D BMES^XPDUTL(TXT)
 Q
 ;
EN ; Entry point for queued process
 I $G(ZTSK) S ZTREQ="@"
 S $P(^XTMP("DG53632P",0,"DATE"),U,1)=$$FMTE^XLFDT($$NOW^XLFDT(),"5P")
 ; Loop through Patient file "AENRC" x-ref for verified enrollments (2)
 N DFN
 S DFN=0
 F  S DFN=$O(^DPT("AENRC",2,DFN)) Q:'DFN  D
 .I $$POW(DFN) D  Q
 ..S ^XTMP("DG53632P","POWTOT")=$G(^XTMP("DG53632P","POWTOT"))+1
 ..D UPRX(DFN,"POW")
 .I $$UNEMP(DFN) D
 ..S ^XTMP("DG53632P","UNEMPTOT")=$G(^XTMP("DG53632P","UNEMPTOT"))+1
 ..D UPRX(DFN,"UNEMP")
 S $P(^XTMP("DG53632P",0,"DATE"),U,2)=$$FMTE^XLFDT($$NOW^XLFDT(),"5P")
 S ^XTMP("DG53632P",0,"COMPLETED")=1
 D SENDMSG
 Q
 ;
POW(DFN) ; Is veteran a POW?
 I '$G(DFN) Q 0
 I $P($G(^DPT(DFN,.52)),U,5)="Y" Q 1  ;POW Indicator='Y'
 I +$G(^DPT(DFN,.36))=18 Q 1 ;Primary Eligibility code = POW
 I $D(^DPT(DFN,"E",18)) Q 1  ;Secondary Eligibility code = POW
 Q 0
 ;
UNEMP(DFN) ; Is veteran Unemployable Priority 1?
 N DGENRIEN
 S DGENRIEN=$$FINDCUR^DGENA(DFN) Q:'DGENRIEN 0  ;Get current enrollment
 Q:'$$GET^DGENA(DGENRIEN,.DGENR) 0  ;Get enrollment data
 Q:$G(DGENR("PRIORITY"))'=1 0  ;Quit if not priority group 1
 Q:$G(DGENR("ELIG","UNEMPLOY"))'="Y" 0  ;Quit if not unemployable
 Q:$G(DGENR("ELIG","SCPER"))>49 0  ;Quit if SC % 50-100
 Q 1
 ;
UPRX(DFN,EX) ; Update RX Copay status in Annual Means Test file (#408.31)
 ; and Billing Patient file (#354)
 ; INPUT - DFN = Patient IEN
 ;         EX = Exemption type, either POW or UNEMP
 N REAS,STAT
 I '$D(^IBA(354,DFN)) Q
 S STAT=$$GET1^DIQ(354,DFN_",",.04,"E")
 S REAS=$$GET1^DIQ(354,DFN_",",.05,"E")
 I REAS[EX Q  ;correct exemption type already set
 I EX="POW",STAT="EXEMPT",REAS'["INCOME" Q
 D EN^DGMTCOR  ;Update RX copay test and IB file #354
 S ^XTMP("DG53632P",EX_"UP")=$G(^XTMP("DG53632P",EX_"UP"))+1
 S ^XTMP("DG53632P","VET",DFN)=EX
 Q
CHK() ; Check if Unemp Vet update process should be run
 N CDT,TASK,TXT
 I '$D(^XTMP("DG53632P",0)) S ^XTMP("DG53632P",0)=$$FMADD^XLFDT(DT,60)_U_DT_U_"DG*5.3*632 POST-INSTALL UPDATE FOR POW & UNEMP VETS" Q 1
 I $G(^XTMP("DG53632P",0,"COMPLETED")) D  Q 0
 .S CDT=$P($G(^XTMP("DG53632P",0,"DATE")),U,2)
 .S TXT(1)="The update process for Unemployable and POW Veterans was completed"
 .S TXT(2)="on "_CDT
 .D BMES^XPDUTL(.TXT)
 S TASK=$G(^XTMP("DG53632P",0,"TASK")) I 'TASK Q 1
 I $$ACTIVE(TASK) D  Q 0
 .S TXT(1)="Task: "_TASK_" is currently running the update process for unemployable"
 .S TXT(2)="& POW veterans.  A duplicate job cannot be started."
 .D BMES^XPDUTL(.TXT)
 Q 1
ACTIVE(TASK) ; Check if task is running
 ; Input  -- TASK = Task number
 ; Output -- 1 = Task is running
 ;           0 = Task is not running
 N STAT,ZTSK,Y
 S STAT=0,ZTSK=+$G(TASK) I 'ZTSK Q STAT
 D STAT^%ZTLOAD
 S Y=ZTSK(1)
 I "^1^2^"[(U_Y_U) S STAT=1
 I "^3^5^"[(U_Y_U) S STAT=0
 Q STAT
 ;
SENDMSG ; Send Mailman bulletin when process completes
 N SITE,STATN,SITENM,XMDUZ,XMSUB,XMY,XMTEXT,MSG
 S SITE=$$SITE^VASITE,STATN=$P($G(SITE),U,3),SITENM=$P($G(SITE),U,2)
 S:$$GET1^DIQ(869.3,"1,",.03,"I")'="P" STATN=STATN_" [TEST]"
 S XMDUZ="UNEMPLOYABLE AND POW VETS UPDATE",XMSUB=XMDUZ_" (DG*5.3*632) - "_STATN
 S (XMY(DUZ),XMY("linda.desmond@domain.ext"))=""
 S XMTEXT="MSG("
 S MSG(1)="The post-install process for patch DG*5.3*632 has completed successfully."
 S MSG(2)="This process searched for POW and Priority 1 Unemployable Veterans and"
 S MSG(3)="updated their RX copay status to Exempt in the Billing Patient file #354,"
 S MSG(3.1)="if necessary."
 S MSG(4)=""
 S MSG(5)="Task: "_$G(^XTMP("DG53632P",0,"TASK"))
 S MSG(6)="Site Station Number: "_STATN
 S MSG(7)="Site Name: "_SITENM
 S MSG(8)=""
 S MSG(9)="Process started   : "_$P($G(^XTMP("DG53632P",0,"DATE")),U,1)
 S MSG(10)="Process completed : "_$P($G(^XTMP("DG53632P",0,"DATE")),U,2)
 S MSG(10.5)=""
 S MSG(11)="Total Priority 1 Unemployable Vets  : "_+$G(^XTMP("DG53632P","UNEMPTOT"))
 S MSG(12)="Total RX Copay Status Updates       : "_+$G(^XTMP("DG53632P","UNEMPUP"))
 S MSG(12.5)=""
 S MSG(13)="Total Former POW Veterans           : "_+$G(^XTMP("DG53632P","POWTOT"))
 S MSG(14)="Total RX Copay Status Updates       : "_+$G(^XTMP("DG53632P","POWUP"))
 D ^XMD
 Q
