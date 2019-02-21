PSO7P517 ;MHA - Post Install routine for PSO*7*517 ;1/25/18@14:30
 ;;7.0;OUTPATIENT PHARMACY;**517**;DEC 1997;Build 15
 ;This post-installation routine will loop through the PHARMACY PATIENT file (#55) 
 ;and plus the ^PS(55,DFN,"PS") - DEFAULT PATIENT STATUS - node if it contains "^"
 ;delimiters, because this node should only contain one numeric piece.
 Q
 ;
EN ; Begin post-installation routine 
 I $G(DUZ)="" W !,"Your DUZ is not defined.  It must be defined to run this routine." Q
 N PATCH,JOBN,ZTSK,ZTRTN,ZTIO,ZTDTH,ZTDESC,Y,ZTQUEUED,ZTREQ,ZTSAVE,SBJM,ZZ
 S JOBN="PSO*7.0*517 Post-Installation"
 S PATCH="PSO*7.0*517",ZZ="PSO7P517"
 S Y=$$NOW^XLFDT S ZTDTH=$$FMTH^XLFDT(Y)
 D BMES^XPDUTL("=============================================================")
 D MES^XPDUTL("Queuing background job for "_JOBN_"...")
 D MES^XPDUTL("Start time: "_$$HTE^XLFDT(ZTDTH))
 D MES^XPDUTL("A MailMan message will be sent to the installer upon Post")
 D MES^XPDUTL("Install Completion.  This may take an hour or more, depending")
 D MES^XPDUTL("upon site size.")
 D MES^XPDUTL("==============================================================")
 ;
 S ZTRTN="ENQN^PSO7P517",ZTIO=""
 S (SBJM,ZTDESC)="Background job for "_JOBN
 S ZTSAVE("JOBN")="",ZTSAVE("ZTDTH")="",ZTSAVE("DUZ")="",ZTSAVE("SBJM")="",ZTSAVE("ZZ")=""
 D ^%ZTLOAD
 D:$D(ZTSK)
 . D MES^XPDUTL("*** Task #"_ZTSK_" Queued! ***")
 . D BMES^XPDUTL("")
 D BMES^XPDUTL("")
 K XPDQUES
 Q
 ;
ENQN ;
 N PSOCNT,PSOCREAT,PSODFN,PSOEXPR,PSOPSNEW,PSOPSOLD,PSOSTART
 D NOW^%DTC S PSOSTART=$E(%,1,12),PSOCREAT=$E(%,1,7),PSOEXPR=$$FMADD^XLFDT(PSOCREAT,60,0,0,0)
 K ^XTMP($J,ZZ),^TMP($J,"PSO")
 S (PSOCNT,PSODFN)=0 F  S PSODFN=$O(^PS(55,PSODFN)) Q:'PSODFN  D
 .I $G(^PS(55,PSODFN,"PS"))["^"  D
 ..S PSOPSOLD=^PS(55,PSODFN,"PS")
 ..S PSOPSNEW=+^PS(55,PSODFN,"PS")
 ..S ^PS(55,PSODFN,"PS")=PSOPSNEW
 ..S ^XTMP($J,ZZ,PSODFN,"PS")=PSOPSNEW_"|"_PSOPSOLD
 ..S PSOCNT=PSOCNT+1
 D STOP
 Q
 ;
STOP K DA,DIE,DR,NUM,CPS,CPSX,%
 D XMAIL1
 D XMAIL2
 S:$D(^XTMP($J,ZZ)) ^XTMP($J,ZZ,0)=PSOEXPR_"^"_PSOCREAT
 Q
 ;
XMAIL1 ; Post-installation Notification for Installer
 K PSG,XMY S XMDUZ=.5,XMSUB="PATCH PSO*7.0*517 INSTALLATION COMPLETE",XMTEXT="PSG(",XMY(DUZ)="" D NOW^%DTC S Y=% X ^DD("DD")
 S PSG(1,0)="  -- INSTALLER --"
 S PSG(2,0)="  The post-install for PSO*7.0*517 completed "_Y_"."
 D ^XMD
 Q
 ;
XMAIL2 ; Post-installation Notification for Users 
 N PSOX,PSODFN,PSOPSNEW,PSOPSOLD
 S XMSUB="PSO*7.0*517 Pharmacy Patient file (#55) PS Node Change"
 S XMDUZ=.5
 S ^TMP($J,"PSO",1)=" Patch PSO*7.0*517 post-installation routine has updated"
 S ^TMP($J,"PSO",2)=" the ""PS"" node of "_PSOCNT_" patients on the PHARMACY"
 S ^TMP($J,"PSO",3)=" PATIENT file (#55)."
 S ^TMP($J,"PSO",4)=" "
 S ^TMP($J,"PSO",5)=" The DEFAULT PATIENT STATUS node should contain only one piece"
 S ^TMP($J,"PSO",6)=" of numeric data that corresponds to a Patient Status in the"
 S ^TMP($J,"PSO",7)=" RX PATIENT STATUS file (#53)."
 S ^TMP($J,"PSO",8)=" "
 S ^TMP($J,"PSO",9)=" Information identifying patients with PS node changes"
 S ^TMP($J,"PSO",10)=" will remain in ^XTMP("_$J_",""PSO7P517"",DFN,""PS"") for 60"
 S ^TMP($J,"PSO",11)=" days."
 S ^TMP($J,"PSO",12)=""
 S ^TMP($J,"PSO",13)=" The following PHARMACY PATIENT file (#55) entries"
 S ^TMP($J,"PSO",14)=" contained corrupt ""PS"" nodes that were updated."
 S ^TMP($J,"PSO",15)=""
 S ^TMP($J,"PSO",16)=" DFN          Old PS Node   New PS Node"
 S ^TMP($J,"PSO",17)=" ----------   -----------   -----------"
 I PSOCNT=0 S ^TMP($J,"PSO",18)=" No corrupt PS Nodes found."
 S PSOCNT=17
 S PSODFN=0 F  S PSODFN=$O(^XTMP($J,ZZ,PSODFN)) Q:PSODFN=""  D
 . S PSOCNT=PSOCNT+1
 . S PSOPSOLD=$P(^XTMP($J,ZZ,PSODFN,"PS"),"|",2)
 . S PSOPSNEW=$P(^XTMP($J,ZZ,PSODFN,"PS"),"|")
 . S ^TMP($J,"PSO",PSOCNT)=" "_$J(PSODFN,10)_"   "_$J(PSOPSOLD,11)_"   "_$J(PSOPSNEW,11)
 S PSOX="" F  S PSOX=$O(^XUSEC("PSORPH",PSOX)) Q:'PSOX  S XMY(PSOX)=""
 S XMY(DUZ)=""
 S XMTEXT="^TMP($J,""PSO""," N DIFROM D ^XMD
 K PSOCNT,XMSUB,XMDUZ,XMY,XMTEXT,^TMP($J,"PSO")
 Q
 ;
