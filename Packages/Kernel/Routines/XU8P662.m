XU8P662 ;SLC/JAS - Post Install for 662 ;July 21, 2022@12:08:00
 ;;8.0;KERNEL;**662**;Jul 10, 1995;Build 49
 ;Per VHA Directive 2004-038, this routine should not be modified
 ;
 ; DBIA 10112  $$SITE^VASITE
 ; DBIA 10060  ^VA(200,"B"
 ;
ENV ; ensure that user understands what is about to happen with creation
 ; of New Style cross reference.
 Q  ;Decided not to use the environment check
 N DIR,DIRUT,DTOUT,DUOUT,Y
 S XPDABORT=""
 W !!,$C(7),"****** Creation of New Style 'PAR' Cross Reference ******",!
 W !,"This will loop through the RECIPIENT Multiple of the entire ALERT"
 W !,"TRACKING File (#8992.1) and create the 'PAR' New Style Cross"
 W !,"Reference based on the PROCESSED ALERT & RECIPIENT sub-fields.",!
 W !,"WARNING: Once you agree to create this, you should let it run until"
 W !,"it has finished completely !!",!
 S DIR("A")="Are you sure you want to do this"
 S DIR("A",1)="You are about to create the index which could take quite awhile."
 S DIR("B")="NO"
 S DIR(0)="Y"
 D ^DIR
 I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!(Y'=1) W !!,"Ok, I am stopping the install." S XPDABORT=1 Q
 E  W !,"Ok, let's continue!",!
 I XPDABORT="" K XPDABORT
 Q
 ;
POST ; Post-Install for XU*8.0*662
 ; This will assist with PAR cross reference creation along with
 ; Creation of new PAR Indices
 N XUMSG
 S XUMSG(1)="This patch will create a new New Style cross reference"
 S XUMSG(2)="called 'PAR' which will be at the ALERT TRACKING file level"
 S XUMSG(3)="but on PROCESSED ALERT & RECIPIENT sub-fields of the"
 S XUMSG(4)="RECIPIENT Multiple."
 S XUMSG(5)=" "
 S XUMSG(6)="Creation of 'PAR' will now go forward in the"
 S XUMSG(7)="Background."
 S XUMSG(8)=" "
 S XUMSG(9)="You will be given a TaskMan task # to check on or,"
 S XUMSG(10)="alternately, you can check your mail on MailMan for a"
 S XUMSG(11)="message expressing Completion of this Task with"
 S XUMSG(12)="appropriate details."
 S XUMSG(13)=" "
 S XUMSG(14)="Note Install of this Patch cannot be considered"
 S XUMSG(15)="Complete unless and until this Task is Completed."
 S XUMSG(16)=" "
 D BMES^XPDUTL(.XUMSG)
 I $D(^XTMP("XU8P662","START")) D
 . D MES^XPDUTL("Task to Create 'PAR' Already Begun "_$$HTE^XLFDT(^XTMP("XU8P662","START"))_".")
 . D MES^XPDUTL("")
 I $D(^XTMP("XU8P662","FINISH")) D  Q
 . D MES^XPDUTL("...and Completed "_$$HTE^XLFDT(^XTMP("XU8P662","FINISH"))_".")
 . D MES^XPDUTL("")
 Q:$D(^XTMP("XU8P662"))
 S ZTRTN="SETXREF^XU8P662",ZTIO="",ZTDTH=$H
 S ZTDESC="Creation of New Style X-Ref 'PAR' in ALERT TRACKING file" D ^%ZTLOAD
 I $G(ZTSK) D MES^XPDUTL("Task #"_ZTSK_" queued to start "_$$HTE^XLFDT($G(ZTSK("D")))) I 1
 E  D MES^XPDUTL("***** UNABLE TO QUEUE CREATION OF 'PAR' ALERT TRACKING FILE X-REF *****")
 K ZTRTN,ZTIO,ZTDTH,ZTDESC,ZTSK
 Q
 ;
RERUN ; if post install didn't complete this tag will allow manual rerun
 K ^XTMP("XU8P662"),^XTMP("XU8P662ERR")
 D POST
 Q
 ;
SETXREF ; Set new PAR New Style cross reference for old data
 N DA,DIK,ORIEN,XTMPCNT,XTMPMSG,ZTREQ,XUIEN,ERRDD
 ; mwa defensive coding added to protect against bug where ^DD(8992.11,"IX",.01) goes missing after many records are already processed
 H 60 ; just in case something with the install is causing a set/killwait 60 seconds to start the processing
 S (ERRDD,ERRDD("HANGS"))=0
 K ^XTMP("XU8P662")
 S ^XTMP("XU8P662",0)=$$FMADD^XLFDT($$DT^XLFDT(),90)
 S ^XTMP("XU8P662","START")=$H
 S XTMPCNT=1
 S XTMPMSG="Creation of 'PAR' X-Ref for ALERT TRACKING file Started "
 S XTMPMSG=XTMPMSG_$$HTE^XLFDT(^XTMP("XU8P662","START"))_"."
 S ^XTMP("XU8P662",XTMPCNT)=XTMPMSG
 S XTMPCNT=XTMPCNT+1,^XTMP("XU8P662",XTMPCNT)=" "
 K ^XTV(8992.1,"PAR")
 S XUIEN=0
 F  S XUIEN=$O(^XTV(8992.1,XUIEN)) Q:'XUIEN  D
 . ; mwa ^DD(8992.11,"IX",.01) is required for D ENALL^DIK (if not present error occurs)
 . ; the hope is that it is temporary (during a set/kill...etc), so just hang the task and try again
 . ; If too many records get passed due to attempted hangs...just record the number of errors for mailman and stop hanging
 . I '$D(^DD(8992.11,"IX",.01)) Q:ERRDD("HANGS")>5  H 30 S ERRDD("HANGS")=ERRDD("HANGS")+1
 . I '$D(^DD(8992.11,"IX",.01)) S ERRDD=ERRDD+1 Q
 . S DIK="^XTV(8992.1,"_XUIEN_",20,",DIK(1)=".01^PAR",DA(1)=XUIEN D ENALL^DIK
 S XTMPMSG="Creation of 'PAR' X-Ref Completed"
 I ERRDD>0 S XTMPMSG=XTMPMSG_" With Errors"
 S XTMPCNT=XTMPCNT+1,^XTMP("XU8P662",XTMPCNT)=XTMPMSG
 S XTMPCNT=XTMPCNT+1,^XTMP("XU8P662",XTMPCNT)=" "
 S ^XTMP("XU8P662","FINISH")=$H
 S XTMPMSG="Background Task Finished "
 S XTMPMSG=XTMPMSG_$$HTE^XLFDT(^XTMP("XU8P662","FINISH"))_"."
 S XTMPCNT=XTMPCNT+1,^XTMP("XU8P662",XTMPCNT)=XTMPMSG
 I ERRDD>0 D
 . S XTMPCNT=XTMPCNT+1,^XTMP("XU8P662",XTMPCNT)=""
 . S XTMPCNT=XTMPCNT+1,^XTMP("XU8P662",XTMPCNT)="The CPRS Development team has already been contacted to assist with the errors"
 . S XTMPCNT=XTMPCNT+1,^XTMP("XU8P662",XTMPCNT)="You will be contacted to as soon as possible by a CPRS Developer"
 ;
 D:ERRDD ERRMSG
 ; Send Mail to installer to notify of completion
 S XMSUB="XU*8.0*662 post install has run to completion."
 S XMDUZ="Patch XU*8.0*662"
 S XTMPCNT=0
XRFLOOP S XTMPCNT=$O(^XTMP("XU8P662",XTMPCNT)) G:XTMPCNT'?1N.N FIN
 S ^TMP($J,"XU8P662",XTMPCNT,0)=^XTMP("XU8P662",XTMPCNT)
 G XRFLOOP
 ;
FIN S XMTEXT="^TMP($J,""XU8P662"","
 S XMY(DUZ)="" D ^XMD K ^TMP($J,"XU8P662") S ZTREQ="@"
 K XMDUZ,XMSUB,XMTEXT,XMY
 Q
 ;
ERRMSG ;
 ; Send Mail to CPRS Dev Team to notify of errors...need to rerun
 N SITE S SITE=$P($$SITE^VASITE,U,2)
 S XMTEXT="^XTMP($J,""XU8P662ERR"","
 S ^XTMP($J,"XU8P662ERR",0)=$$FMADD^XLFDT($$DT^XLFDT(),90)
 S ^XTMP($J,"XU8P662ERR",1)=ERRDD_" ^DD(8992.11,""IX"",.01) error(s) occurred while installing XU*8.0*662"
 S ^XTMP($J,"XU8P662ERR",2)="Site: "_SITE_" Installer: "_$G(^VA(200,"B",DUZ))
 S ^XTMP($J,"XU8P662ERR",3)="Verify that Data Dictionary is correct...then instruct site to rerun this post install routine using ""D RERUN^XU8P662"" at the programmer prompt"
 S XMSUB="XU*8.0*662 Error reported at "_SITE
 S XMDUZ="Patch XU*8.0*662"
 S XMY("AUGUSTINIAK.MARK@DOMAIN.EXT")=""
 S XMY("PHELPS.TY@DOMAIN.EXT")=""
 S XMY("CRUMLEY.JAMIE@DOMAIN.EXT")=""
 S XMY("LEVI.TEITELBAUM@DOMAIN.EXT")=""
 S XMY("THOMPSON.WILLIAM_ANTHONY@DOMAIN.EXT")=""
 D ^XMD K ^TMP($J,"XU8P662ERR") S ZTREQ="@"
 K XMDUZ,XMSUB,XMTEXT,XMY
 Q
 ;
