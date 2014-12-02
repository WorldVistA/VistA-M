LR425 ;ALB/GTS - LR*5.2*425 KIDS POST-INIT ROUTINE ;09/28/2012 11:25
 ;;5.2;LAB SERVICE;**425**;Sep 27, 1994;Build 30
 ;
 ;
 ;Environment check for LSRP: ENSTART, CHK4LSRP, LSRPEX and Call Environment check in LR*425
ENSTART ; -- Generic Lab environment check
 ; May prevent loading of the transport global.
 ; Environment check is done only during the install.
 ;
 N LRMSG,LAPOS,LRALST,MSG,BAD,LSRPEND,X
 S LSRPEND="N/A"
 S XPDNOQUE=1 ;no queuing
 S LAPOS=$G(IOM,80) S:LAPOS<1 LAPOS=80
 D LMES($$CJ^XLFSTR("***"_$S('$G(XPDENV):" 'Transport Global Load'",1:" 'Installation'")_" Environment Check started ***",LAPOS),1,"B")
 ;
 ; Check for LMI mailgroup
 D LMES("'LMI' Mail Group must exist.",10,"B")
 D LMES("Checking for 'LMI' Mail Group...",15)
 S X=$$FIND1^DIC(3.8,,"BOQUX","LMI","B","","LAMSG")
 I 'X D  Q  ;QUIT/Abort if LMI Mailgroup is not defined
 . D LMES("Mail Group (#3.8) 'LMI' does not exist.",20)
 . D LMES($$CJ^XLFSTR("* * *  Environment failed.  Aborting.  * * *",LAPOS),1,"B")
 . S XPDABORT=2 ; Leave transport global
 . D LSRPEX
 E  D 
 . D LMES("'LMI' Mail Group exists.",20)
 . D LMES("Continuing...",25)
 ;
 I '$G(XPDENV) D  Q  ;QUIT if Loading Distribution
 . NEW LRC383,LAC75,LRP393,LAP76
 . SET MSG="Distribution for '"_$G(XPDNM,"Unknown patch")_"' loaded "_$$HTE^XLFDT($H)
 . DO LMES(" ",1)
 . DO LMES("Sending distribution loaded alert...",7,"B")
 . DO ALERT(MSG)
 . SET LRC383=$$PATCH^XPDUTL("LR*5.2*383")
 . SET LAC75=$$PATCH^XPDUTL("LA*5.2*75")
 . SET LRP393=$$PATCH^XPDUTL("LR*5.2*393")
 . SET LAP76=$$PATCH^XPDUTL("LA*5.2*76")
 . SET LSRPEND=(LRC383!LAC75!LRP393!LAP76)
 . DO LSRPEX
 ;
 ;Continue if $G(XPDENV) - Installation underway, Check for LSRP
 D LMES("Sending install started alert...",7,"B")
 S MSG="Installation of '"_$G(XPDNM,"Unknown patch")_"' started "_$$HTE^XLFDT($H)
 D ALERT(MSG)
 ;
 D CHK4LSRP
 D LSRPEX
 Q
 ;
CHK4LSRP ; [During Installation...] Check if LSRP is installed at site, do NOT install over LSRP
 NEW LRC383,LAC75,LRP393,LAP76
 SET LRC383=$$PATCH^XPDUTL("LR*5.2*383")
 SET LAC75=$$PATCH^XPDUTL("LA*5.2*75")
 SET LRP393=$$PATCH^XPDUTL("LR*5.2*393")
 SET LAP76=$$PATCH^XPDUTL("LA*5.2*76")
 IF (LRC383!LAC75!LRP393!LAP76) DO  ;LSRP Site?
 . NEW LRMGR,LROVRD
 . DO OWNSKEY^XUSRB(.LRMGR,"LRJ CERNER MGR")
 . DO OWNSKEY^XUSRB(.LROVRD,"LRJ CERNER OVERRIDE")
 . IF ($G(LRMGR(0))=0)!($G(LROVRD(0))=0) DO  ;Hold LRJ CERNER MGR & LRJ CERNER OVERRIDE keys?
 . . SET XPDABORT=1
 . . SET BAD=1
 . . SET BAD(1)="**  LSRP is installed at this site!!  **"
 . . SET BAD(2)="All Lab (LR/LA namespaced) patches must be installed by the LSRP Triage team."
 . ELSE  DO
 . . NEW DIR,X,Y,DTOUT,DIRUT,DUOUT,LROK
 . . WRITE !
 . . SET DIR(0)="Y"
 . . SET DIR("A",1)="You are installing a Legacy Lab patch at a LSRP Site."
 . . SET DIR("A",2)="The LSRP Triage Team should be coordinating this installation."
 . . SET DIR("A",3)="If LSRP Triage is NOT coordinating, DO NOT INSTALL THIS PATCH!"
 . . SET DIR("A")="Do you want to install"
 . . SET DIR("B")="NO"
 . . SET DIR("?",1)="You have the privileges to install this patch."
 . . SET DIR("?",2)="Installing means LSRP Triage has determined if this patch will"
 . . SET DIR("?")="overwrite LSRP system structures and how to address the conflicts."
 . . DO ^DIR
 . . SET LROK=+Y
 . . SET LSRPEND='+Y
 . . IF 'LROK DO
 . . . SET XPDABORT=1
 . . . DO LMES("Installer with DUZ: "_DUZ_" defering to LSRP Triage.",20,"B")
 . . . DO:$G(XPDENV) LMES("Installation will stop and remove global.",25)
 . . . DO LMES($$CJ^XLFSTR("* * *  Install stopped during Environment check.  * * *",LAPOS),1,"B")
 Q
 ;
LSRPEX ; LSRP Exit message for Install log
 NEW LAPOS,MSG
 SET LAPOS=$G(IOM,80) S:LAPOS<1 LAPOS=80
 IF $G(XPDQUIT)!$G(XPDABORT) DO  QUIT  ;
 . W !!,$C(7)
 . D:LSRPEND=1 LMES($$CJ^XLFSTR("* * *  Installer aborted installation.  * * *",LAPOS),1,"B")
 . D:LSRPEND="N/A" LMES($$CJ^XLFSTR("* * *  Environment Check FAILED  * * *",LAPOS),1,"B")
 . I $G(BAD(1))'="" D LMES($$CJ^XLFSTR(BAD(1),LAPOS),1,"B")
 . I $G(BAD(2))'="" D LMES($$CJ^XLFSTR(BAD(2),LAPOS),1,"B")
 . D LMES("Sending Install aborted alert...",7,"B")
 . S MSG="Installation of '"_$G(XPDNM,"Unknown patch")_"' Aborted "_$$HTE^XLFDT($H)
 . D ALERT(MSG)
 . D LMES("",1,"B")
 ;
 I '$G(XPDENV),LSRPEND=1 D
 . DO LMES("Sending 'Lab Patch at LSRP site' alert...",7,"B")
 . SET MSG="Transport global for Lab patch available at LSRP site.  Notify LSRP Triage!"
 . DO ALERT(MSG)
 . DO LMES($$CJ^XLFSTR("* * Loaded Lab patch on a LSRP Site. * *",LAPOS),1,"B")
 . DO LMES($$CJ^XLFSTR("** Installation must be coordinated with LSRP Triage Team! **",LAPOS),1,"")
 . DO LMES("",1,"B")
 I '$G(XPDENV),LSRPEND=0 D LMES($$CJ^XLFSTR("--- Lab Environment okay ---",LAPOS),1,"B")
 ;
 D LMES(" ",1,"B")
 IF $G(XPDENV),LSRPEND="N/A" D LMES($$CJ^XLFSTR("--- Lab Environment okay ---",LAPOS),1,"B")
 IF $G(XPDENV),LSRPEND=0 D LMES($$CJ^XLFSTR("--- LSRP Environment okay for install with LSRP Triage assistance. ---",LAPOS),1,"B")
 IF $G(XPDENV),LSRPEND=1 D LMES($$CJ^XLFSTR("--- LSRP Environment not OK for install.  Requires LSRP Triage assistance. ---",LAPOS),1,"B") ;Bullet Proof
 QUIT
 ;
POST ; -- post-init for LR*5.2*425
 N LAPOS
 S LAPOS=$G(IOM,80) S:LAPOS<1 LAPOS=80
 D LMES($$CJ^XLFSTR("*** Post install started ***",LAPOS),1,"B")
 ;
 D AUDSET("LRJSMLA1","patient location") ;Enable Fileman auditing for HLCMS (Hospital Location monitoring)
 D LMES("Enable Auditing for selected LABORATORY TEST file (#60) fields...",10,"B")
 D AUDSET^LRJSAU ; Set up auditing on LABORATORY TEST file fields
 ;
 D LMES("Checking parameters for file 60 audit changes affecting quick orders...",10,"B")
 D SETP ; Set parameters in file 69.9 if previous file 60 audits exist
 ;
 D LMES($$CJ^XLFSTR("*** Post install completed ***",LAPOS),1,"B")
 D LMES("",1,"B")
 D LMES("Sending install completion alert to mail group G.LMI",7,"B")
 D ALERT("Installation of '"_$G(XPDNM,"Unknown patch")_"' completed "_$$HTE^XLFDT($H))
 Q
 ;
AUDSET(LROU,LRFILTXT) ; -- enable audit on select Hospital Location, Ward Location and Room-Bed fields
 ;
 ;INPUT : LROU     - Name of routine containing "AFLDS" tag.
 ;        LRFILTXT - Descriptive text of data being audited for message.
 ;
 NEW LRI,LRAFLDS,LRJ,LRFLD
 D LMES("Enable Auditing for selected "_LRFILTXT_" fields...",10,"B")
 FOR LRI=1:1 SET LRAFLDS=$P($TEXT(AFLDS+LRI^@LROU),";;",2) QUIT:LRAFLDS=""  DO
 . DO TURNON^DIAUTL(+LRAFLDS,$P(LRAFLDS,"^",2))  ;IA #5611 allows audit in HL files
 . D LMES("Turn on Audit Attribute for the following fields in file: "_$P(LRAFLDS,"^"),15,"B")
 . F LRJ=1:1 S LRFLD=$P($P(LRAFLDS,"^",2),";",LRJ) Q:LRFLD=""  D LMES("Field #: "_LRFLD,20)
 ;
 D LMES("Continuing...",20)
 D LMES("",1,"B")
 QUIT
 ;
SETP ; Set parameters for the latest file 60 audit file entries affecting quick orders, if not already set
 N LRLIEN,LRLDATE,LRMSG,LRD
 S LRLIEN=+$O(^DIA(60,"A"),-1)
 S LRLDATE=$P($G(^DIA(60,+$O(^DIA(60,"A"),-1),0)),U,2)
 I 'LRLIEN,'LRLDATE D  Q
 . D LMES("No previous file 60 audits found, no parameter update necessary",15)
 D GETS^DIQ(69.9,1,"64.913;64.914","I","LRD")
 I $G(LRD(69.9,"1,",64.913,"I"))=""!($G(LRD(69.9,"1,",64.914,"I"))="") D  Q
 . K LRD
 . S LRD(69.9,"1,",64.913)=LRLIEN,LRD(69.9,"1,",64.914)=LRLDATE
 . D FILE^DIE("","LRD","LRMSG")
 . D LMES("Parameters updated based on data found for last file 60 audit",15)
 . D LMES("LAST IEN: "_LRLIEN_"    LAST DATE: "_$$FMTE^XLFDT(LRLDATE,2),20)
 D LMES("Parameters are already set, no update necessary",15)
 Q
 ;
LMES(STR,SPCNUM,BVAR) ; List text in output display
 ;
 ; INPUT:
 ;   STR    - String to output
 ;   SPCNUM - # Leading spaces
 ;   BVAR   - Null: Do not print a blank prior to text (Default) [MES]
 ;            "B" : Print a blank prior to text [BMES]
 ;
 ; Write string in a single line list
 N LRMSG
 S LRMSG=""
 S:+$G(SPCNUM)=0 SPCNUM=1
 S $P(LRMSG," ",SPCNUM)=STR
 D:$G(BVAR)'="B" MES^XPDUTL(LRMSG)
 D:$G(BVAR)="B" BMES^XPDUTL(LRMSG)
 Q
 ;
ALERT(MSG) ;Send Alert message
 ;Input: MSG - Alert message to send
 N XQA,XQAMSG
 S XQAMSG=$G(MSG)
 ;
 I $$GOTLOCAL^XMXAPIG("LMI") DO
 . S XQA("G.LMI")=""
 . D LMES("Alert addressed to mail group G.LMI",10)
 E  DO
 . S XQA(DUZ)=""
 . D LMES("LMI Mail group not defined. Alert addressed to installer.",10)
 ;
 D:$G(MSG)]"" LMES(MSG,80-$L(MSG))
 D LMES(" ",1)
 I '$$SETUP1^XQALERT DO
 .D:$G(MSG)']"" LMES($$CJ^XLFSTR("Alert Message string not defined.",IOM),1)
 .D LMES($$CJ^XLFSTR("** Alert error occured...Alert not sent!! **",IOM),1,"B")
 Q
