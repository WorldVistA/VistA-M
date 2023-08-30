RMPR213P ;HDSO/JSG - RMPR*3.0*213 Post-install routine; Mar 2, 2023@16:00
 ;;3.0;PROSTHETICS;**213**; 30 Oct 98;Build 12
 ;
 ;;Reference to $$ICDDX^ICDEX supported by ICR #5747
 ;;Reference to ^GMR(123,30.1) supported by ICR# 3067
 ;
 Q
 ;
EN ;
 ;This post-install routine for RMPR*3.0*213 will:
 ;
 ;1. Scan for any records with "-1" in the ICD field (#1.6) of
 ;   the PROSTHETIC SUSPENSE file (#668).
 ;
 ;2. When a record with "-1" is found, the PROVISIONAL DIAGNOSIS
 ;   field (#1.5) is retrieved and the ICD10 code is extracted.
 ;
 ;3. Then retrieves the CONSULT pointer (#20)
 ;
 ;4. Using the CONSULT pointer, the PROVISIONAL DIAGNOSIS CODE (#30.2)
 ;   is retrieved from the REQUEST CONSULTATION FILE (#123)
 ;   
 ;5. The extracted code is used to call $$ICDDX^ICDEX to return
 ;   the correct ICD10 pointer (IEN) for the code.
 ;
 ;6. The IEN is then inserted into the ICD field (#1.6).
 ; 
 ;7. The unmodified record is stored in ^XTMP for potential
 ;   recovery by executing BACKOUT^RMPR213P in programmer mode.
 ;
 ;8. This routine is not deleted after install since it is tasked.
 ;   A future patch will delete the routine.
 ;
 D BMES^XPDUTL($$LJ^XLFSTR("RMPR*3.0*213 Post-Install Routine will scan the PROSTHETIC SUSPENSE",80))
 D BMES^XPDUTL($$LJ^XLFSTR("file for corrupt ICD fields and correct them.",80))
 D BMES^XPDUTL($$LJ^XLFSTR("You will receive a MailMan message when it completes.",80))
 N RMPRDUZ,ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSAVE
 S ZTRTN="START^RMPR213P"
 S ZTDESC="RMPR*3.0*213 Post-Install Routine"
 S ZTIO="",ZTDTH=$H
 S RMPRDUZ=DUZ
 S ZTSAVE("RMPRDUZ")=""
 D ^%ZTLOAD
 D BMES^XPDUTL($$LJ^XLFSTR("RMPR*3.0*213 Post-Install Routine has been tasked.",80))
 D BMES^XPDUTL($$LJ^XLFSTR("Task Number: "_$G(ZTSK),80))
 D BMES^XPDUTL($$LJ^XLFSTR("You will receive a MailMan message when it completes.",80))
 Q
 ;
START ;
 ;
 S ^XTMP("RMPR*3.0*213 POST INSTALL",0)=$$FMADD^XLFDT(DT,90)_"^"_DT_"^RMPR*3.0*213 POST INSTALL"
 ;
 N RMMAILSQ,RMPRNF,RMPRNC
 S RMMAILSQ=0,(RMPRNF,RMPRNC)=0
 D ICD,RMPR,MAIL
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
ICD ;
 S ^XTMP("RMPR*3.0*213 POST INSTALL",1)=" "
 S ^XTMP("RMPR*3.0*213 POST INSTALL",2)="The incorrect ICD entries in the PROSTHETIC SUSPENSE file (#668)"
 S ^XTMP("RMPR*3.0*213 POST INSTALL",3)="have been corrected to contain an ICD10 IEN rather than ""-1""."
 S ^XTMP("RMPR*3.0*213 POST INSTALL",4)=" "
 Q
 ;
RMPR ;Correct records in the PROSTHETIC SUSPENSE file (#668).
 N RMNX,RMICD,RMICDP,RMSTR,RM8ORIG,RM0ORIG,RMCON,RMPRDRXW
 S RMNX=0
 F  S RMNX=$O(^RMPR(668,RMNX)) Q:RMNX<1  D               ;QUIT IF:
 . Q:'$D(^RMPR(668,RMNX,8))  S RM8ORIG=^(8)              ;no 8 node
 . Q:$P(RM8ORIG,"^",3)'="-1"                             ;3rd piece not -1
 . S RMPRNF=RMPRNF+1
 . Q:'$D(^RMPR(668,RMNX,0))  S RM0ORIG=^(0)              ;no 0 node
 . S RMCON=$P(RM0ORIG,"^",15) Q:RMCON=""                 ;no CONSULT
 . S RMPRDRXW=$P(RM0ORIG,U,16) S:RMPRDRXW'>0 RMPRDRXW=DT ;date Rx written
 . Q:'$$FIND1^DIC(123,,"A",RMCON)                        ;no CONSULT record
 . S RMICD=$$GET1^DIQ(123,RMCON,30.1),RMICD=$P(RMICD,U)
 . Q:RMICD=""                                            ;no consult DIAGNOSIS record
 . S RMICDP=$P($$ICDDX^ICDEX(RMICD,RMPRDRXW),"^")        ;get the IEN for the correct code
 . Q:RMICDP<0                                            ;invalid code
 . S ^XTMP("RMPR*3.0*213 POST INSTALL",0,668,RMNX,8)=RM8ORIG ;preserve the old node value
 . S $P(RM8ORIG,"^",3)=RMICDP,RMPRNC=RMPRNC+1
 . S ^RMPR(668,RMNX,8)=RM8ORIG
 S ^XTMP("RMPR*3.0*213 POST INSTALL",RMMAILSQ+5)="RMPR*3.0*213 Post Install Routine Summary Report"
 S ^XTMP("RMPR*3.0*213 POST INSTALL",RMMAILSQ+6)="Number of records found needing correction: "_RMPRNF
 S ^XTMP("RMPR*3.0*213 POST INSTALL",RMMAILSQ+7)="               Number of records corrected: "_RMPRNC
 S ^XTMP("RMPR*3.0*213 POST INSTALL",RMMAILSQ+8)=" "
 S ^XTMP("RMPR*3.0*213 POST INSTALL",RMMAILSQ+9)="******************************************************************"
 S ^XTMP("RMPR*3.0*213 POST INSTALL",RMMAILSQ+10)="*  The original records with the appropriate subscripts are      *"
 S ^XTMP("RMPR*3.0*213 POST INSTALL",RMMAILSQ+11)="*  saved for 90 days at ^XTMP(""RMPR*3.0*213 POST INSTALL"",0).    *"
 S ^XTMP("RMPR*3.0*213 POST INSTALL",RMMAILSQ+12)="******************************************************************"
 S ^XTMP("RMPR*3.0*213 POST INSTALL",RMMAILSQ+13)=" "
 I RMPRNC=0 S ^XTMP("RMPR*3.0*213 POST INSTALL",RMMAILSQ+14)="No entries were found which needed correction."
 Q
 ;
MAIL ;send MailMan message to installer and users with the RMPRMANAGER key.
 N RMPRREC,RMPRTEXT,RMPRMY,RMPRSUB,RMPRMIN,RMPRDUZ
 I '$D(RMPRDUZ) S RMPRDUZ=DUZ
 S RMPRTEXT="^XTMP(""RMPR*3.0*213 POST INSTALL"")"
 S RMPRREC=""
 F  S RMPRREC=$O(^XUSEC("RMPRMANAGER",RMPRREC)) Q:RMPRREC=""  S RMPRMY(RMPRREC)=""
 S RMPRMY(RMPRDUZ)=""
 S RMPRSUB="RMPR*3.0*213 Post-Install Summary Information"
 S RMPRMIN("FROM")="RMPR*3.0*213 Post-Install"
 D SENDMSG^XMXAPI(RMPRDUZ,RMPRSUB,RMPRTEXT,.RMPRMY,.RMPRMIN,"","")
 Q
 ;
 ;
BACKOUT ;This section is invoked from the programmer's prompt if patch back out is required.
 N DIR,Y
 S DIR("A",1)="This action will back out the file modifications that were performed"
 S DIR("A",2)="after the install of RMPR*3.0*213."
 S DIR("A")="Are you sure you wish to proceed",DIR("B")="NO",DIR(0)="Y"
 D ^DIR
 Q:Y<1
 ;
 S ^XTMP("RMPR*3.0*213 BACK OUT",0)=$$FMADD^XLFDT(DT,90)_"^"_DT_"^RMPR*3.0*213 BACK OUT"
 S ^XTMP("RMPR*3.0*213 BACK OUT",1)=" "
 S ^XTMP("RMPR*3.0*213 BACK OUT",2)="Patch RMPR*3.0*213 was backed out by "_$$GET1^DIQ(200,DUZ,.01)_"."
 S ^XTMP("RMPR*3.0*213 BACK OUT",3)=" "
 ;
 N RMMAILSQ,RMPRZ,RMPRDUZ
 S RMMAILSQ=3,RMPRDUZ=DUZ
 W !!,"Please wait until the back out completes."
 W !,"Working."
 D ICDBACK,MAILBACK
 Q
 ;
ICDBACK ;
 N RMPRX,RMPRSTR,RMPRZ,RMPRDUZ
 S RMPRZ=0,RMPRSTR="",(RMPRNF,RMPRNC)=0
 F  S RMPRZ=$O(^XTMP("RMPR*3.0*213 POST INSTALL",0,668,RMPRZ)) Q:RMPRZ=""  S RMPRX=0 D
 . F  S RMPRX=$O(^XTMP("RMPR*3.0*213 POST INSTALL",0,668,RMPRZ,RMPRX)) Q:RMPRX=""  D
 .. S ^XTMP("RMPR*3.0*213 BACK OUT",0,668,RMPRZ,RMPRX)=^RMPR(668,RMPRZ,RMPRX)
 .. S ^RMPR(668,RMPRZ,RMPRX)=^XTMP("RMPR*3.0*213 POST INSTALL",0,668,RMPRZ,RMPRX)
 .. S RMPRNF=RMPRNF+1,RMPRNC=RMPRNC+1
 ;
 S ^XTMP("RMPR*3.0*213 BACK OUT",RMMAILSQ+1)="RMPR*3.0*213 Rollback Summary Report"
 S ^XTMP("RMPR*3.0*213 BACK OUT",RMMAILSQ+2)="Number of records found to rollback: "_RMPRNF
 S ^XTMP("RMPR*3.0*213 BACK OUT",RMMAILSQ+3)="       Number of records backed out: "_RMPRNC
 S ^XTMP("RMPR*3.0*213 BACK OUT",RMMAILSQ+4)=" "
 S ^XTMP("RMPR*3.0*213 BACK OUT",RMMAILSQ+5)="***************************************************************"
 S ^XTMP("RMPR*3.0*213 BACK OUT",RMMAILSQ+6)="*  The corrected records with the appropriate subscripts are  *"
 S ^XTMP("RMPR*3.0*213 BACK OUT",RMMAILSQ+7)="*  saved for 90 days at ^XTMP(""RMPR*3.0*213 BACK OUT"",0).     *"
 S ^XTMP("RMPR*3.0*213 BACK OUT",RMMAILSQ+8)="***************************************************************"
 S ^XTMP("RMPR*3.0*213 BACK OUT",RMMAILSQ+9)=" "
 Q
 ;
MAILBACK ;
 N RMPRREC,RMPRTEXT,RMPRMY,RMPRSUB,RMPRMIN,RMPRMZ,DIR
 S ^XTMP("RMPR*3.0*213 BACK OUT",RMMAILSQ+10)="The text of this message will be stored in the global"
 S ^XTMP("RMPR*3.0*213 BACK OUT",RMMAILSQ+11)="^XTMP(""RMPR*3.0*213 BACK OUT"" for 90 days."
 S RMPRTEXT="^XTMP(""RMPR*3.0*213 BACK OUT"")"
 S RMPRREC=""
 F  S RMPRREC=$O(^XUSEC("RMPRMANAGER",RMPRREC)) Q:RMPRREC=""  S RMPRMY(RMPRREC)=""
 S RMPRMY(RMPRDUZ)=""
 S RMPRSUB="RMPR*3.0*213 Back Out Information"
 S RMPRMIN("FROM")="RMPR*3.0*213 BACK OUT"
 D SENDMSG^XMXAPI(RMPRDUZ,RMPRSUB,RMPRTEXT,.RMPRMY,.RMPRMIN,.RMPRMZ,"")
 S DIR("A",1)="MailMan message #"_RMPRMZ_" has been sent to you as well as"
 S DIR("A",2)="holders of the RMPRMANAGER security key."
 S DIR("A")="Press any key to continue"
 S DIR(0)="E" D ^DIR
 Q
 ;
