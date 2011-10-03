SD53P499 ;ALB/ESW - SD*5.3*499 POST INIT; Oct 04, 2006  ; Compiled February 12, 2008 11:19:50
 ;;5.3;SCHEDULING;**499**;AUG 13, 1993;Build 21
 ;Unflagging all entries from file 404.43 from inactivation
 ;Sending a notification to the PCMM PATIENT/PROVIDER INACTIVE Mail Group
 ;Flagging for inactivation entries in file 404.43 following the revised functionality
 Q
 ;
POST ;
 N SDA
 S SDA(1)="",SDA(2)="    SD*5.3*499 Post-Install started.....",SDA(3)="" D ATADDQ
 ;
 N SDA
 S SDA(1)="",SDA(2)=" Un-flagging the current entries in the Patient Team Position Assignment"
 S SDA(3)=" file (# 404.43)",SDA(4)="" D ATADDQ
 N SDA
 N SD499,SDDATE S SDDATE="" F  S SDDATE=$O(^SCPT(404.43,"AFLG",SDDATE)) Q:SDDATE=""  D
 .S SD499="" F  S SD499=$O(^SCPT(404.43,"AFLG",SDDATE,SD499)) Q:SD499=""  D
 ..N ENTRY S ENTRY=SD499 D UNFLG^SCMCTSK2
 S SDA(1)="",SDA(2)=" Patients un-flagging process has been finished.",SDA(3)="" D ATADDQ
 ;
 N SDA S SDA(1)=""
 S SDA(2)=" Flagging patients for inactivation following new functionality started."
 S SDA(3)="" D ATADDQ
 D INACTIVE^SCMCTSK1
 N SDA S SDA(1)=""
 S SDA(2)=" Flagging Patients for Inactivation has been finished. "
 S SDA(3)="Use option: SCHD   Patients Scheduled for Inactivation from PC Panels"
 S SDA(4)="to print the current list of patients flagged for inactivation."
 S SDA(5)="" D ATADDQ
 ;another message
 N SDX,CNT S CNT=0
 S CNT=CNT+1,SDX(CNT)=" PATIENT TEAM POSITION ASSIGNMENT file has been updated "
 S CNT=CNT+1,SDX(CNT)=" by un-flagging all entries from inactivation "
 S CNT=CNT+1,SDX(CNT)=" and then flagging them again following new functionality"
 S CNT=CNT+1,SDX(CNT)=" provided with patch SD*5.3*499."
 S CNT=CNT+1,SDX(CNT)=" Use option: SCHD   Patients Scheduled for Inactivation from PC Panels"
 S CNT=CNT+1,SDX(CNT)=" to print a current list of patients flagged for inactivation."
 D MSGG(.SDX)
 Q
ATADDQ D MES^XPDUTL(.SDA) K SDA
 Q
MSG(X) ;
 N SDX S SDX=$O(SDA(999999),-1) S:'SDX SDX=1 S SDX=SDX+1
 S SDA(SDX)=$G(X)
 Q
MSGG(SDX) ;send message
 N SDAMX,XMSUB,XMY,XMTEXT,XMDUZ,DIFROM
 S XMSUB="PATCH SD*5.3*499 POST-INSTALL: Update Entries in File 404.43"
 S XMY("G.PCMM PATIENT/PROVIDER INACTIVE")=""
 S XMY(DUZ)=""
 S XMTEXT="SDX("
 S CNT=$O(SDX(""),-1)
 D ^XMD
