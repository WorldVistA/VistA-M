LR519 ;HPS/DSK - LR*5.2*519 PATCH POST INSTALL ROUTINE ;Apr 03, 2019@12:00
 ;;5.2;LAB SERVICE;**519**;Sep 27, 1994;Build 16
 ;
 ; Reference to ^DD(63.04 supported by DBIA #7053
 ; $$FMADD^XLFDT supported by DBIA #10103
 ; $$SENDMSG^XMXAPI supported by IA #2729
 ;
 Q
 ;
EN ;
 N LRDUZ
 S ZTRTN="START^LR519"
 S ZTDESC="LR*5.2*519 Post-Install Routine"
 S ZTIO="",ZTDTH=$H
 S LRDUZ=DUZ
 S ZTSAVE("LRDUZ")=""
 D ^%ZTLOAD
 W !!,"LR*5.2*519 Post-Install Routine has been tasked - TASK NUMBER: ",$G(ZTSK)
 W !!,"You as well as members of the LMI MailMan Group will receive"
 W !,"a MailMan message when the search completes.",!
 Q
 ;
START ;
 N LRA,LRB,LRNAME,LRNUM,LRCOUNT
 K ^TMP("LR519",$J)
 S (LRA,LRB)="",LRNUM=0
 F  S LRA=$O(^DD(63.04,"B",LRA)) Q:LRA=""  D
 . S LRCOUNT=0
 . F  S LRB=$O(^DD(63.04,"B",LRA,LRB)) Q:LRB=""  D
 . . S LRCOUNT=LRCOUNT+1
 . . I LRCOUNT>1 M ^TMP("LR519",$J,LRA)=^DD(63.04,"B",LRA)
 D XTMP,MAIL
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
XTMP ;Generate MailMan message and keep in ^XTMP for 60 days
 N LRSPACE,LRDASH,LRSTR,LRHIT
 S LRSPACE="                              "
 S LRDASH="------------------------------------------------------------"
 S LRNUM=1
 S ^XTMP("LR 519 POST INSTALL",0)=$$FMADD^XLFDT(DT,60)_"^"_DT_"^LR*5.2*519 POST INSTALL"
 I $O(^TMP("LR519",$J,""))="" D  Q
 . S ^XTMP("LR 519 POST INSTALL",LRNUM)=" "
 . S LRNUM=LRNUM+1
 . S ^XTMP("LR 519 POST INSTALL",LRNUM)="No issues found."
 ;
 ;Issues were found
 S ^XTMP("LR 519 POST INSTALL",LRNUM)=" "
 S LRNUM=LRNUM+1
 S ^XTMP("LR 519 POST INSTALL",LRNUM)="The following issue(s) were found in ^DD(63.04."
 S LRNUM=LRNUM+1
 S ^XTMP("LR 519 POST INSTALL",LRNUM)=" "
 S LRNUM=LRNUM+1
 S ^XTMP("LR 519 POST INSTALL",LRNUM)="Please submit a ServiceNow ticket with the assignment group"
 S LRNUM=LRNUM+1
 S ^XTMP("LR 519 POST INSTALL",LRNUM)="of NTL SUP CLIN2 for assistance with correcting the issue(s)."
 S LRNUM=LRNUM+1
 S ^XTMP("LR 519 POST INSTALL",LRNUM)=" "
 S LRNUM=LRNUM+1
 S ^XTMP("LR 519 POST INSTALL",LRNUM)="NOTE: Names such as ""not in use"", etc. which do not appear to"
 S LRNUM=LRNUM+1
 S ^XTMP("LR 519 POST INSTALL",LRNUM)="      pertain to active tests do not warrant correction."
 S LRNUM=LRNUM+1
 S ^XTMP("LR 519 POST INSTALL",LRNUM)=" "
 S LRNUM=LRNUM+1
 S ^XTMP("LR 519 POST INSTALL",LRNUM)="Name(s) With Multiple IENs"
 S LRNUM=LRNUM+1
 S ^XTMP("LR 519 POST INSTALL",LRNUM)="Name                     IEN"
 S LRNUM=LRNUM+1
 S ^XTMP("LR 519 POST INSTALL",LRNUM)=LRDASH
 S LRNUM=LRNUM+1
 S (LRA,LRB)=""
 F  S LRA=$O(^TMP("LR519",$J,LRA)) Q:LRA=""  D
 . S LRNUM=LRNUM+1
 . S ^XTMP("LR 519 POST INSTALL",LRNUM)=" "
 . S LRB=$O(^TMP("LR519",$J,LRA,"")) D
 . . S LRNUM=LRNUM+1
 . . S ^XTMP("LR 519 POST INSTALL",LRNUM)=$E(LRA,1,23)_$E(LRSPACE,1,25-$L(LRA))_LRB
 . F  S LRB=$O(^TMP("LR519",$J,LRA,LRB)) Q:LRB=""  D
 . . S LRNUM=LRNUM+1
 . . S ^XTMP("LR 519 POST INSTALL",LRNUM)=$E(LRSPACE,1,25)_LRB
 Q
 ;
MAIL ;
 N LRMY,LRMSUB,LRMTEXT,LRMFROM,LRMIN
 S LRMIN("FROM")="LR*5.2*519 Post-Install"
 S LRMY(LRDUZ)=""
 S LRMY("G.LMI")=""
 S LRMSUB="LR*5.2*519 Check of ^DD(63.04"
 S LRMTEXT="^XTMP(""LR 519 POST INSTALL"")"
 D SENDMSG^XMXAPI(DUZ,LRMSUB,LRMTEXT,.LRMY,.LRMIN,"","")
 K ^TMP("LR519",$J)
 Q
