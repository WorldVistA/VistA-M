LR538PST ;HPS/DSK - LR*5.2*538 PATCH POST INSTALL ROUTINE ;May 22, 2020@12:00
 ;;5.2;LAB SERVICE;**538**;Sep 27, 1994;Build 9
 ;
 ;External reference to ^XLFDT is supported by DBIA 10103
 Q
 ;
EN ;
 ;This post-install routine for LR*5.2*538 will clean up orphan entries
 ;in the ACCESSION (#68) file. 
 ;This routine is not deleted after install since it is tasked. A future
 ;patch will delete the routine.
 ;
 N LRDUZ
 S ZTRTN="START^LR538PST"
 S ZTDESC="LR*5.2*538 Post-Install Routine"
 S ZTIO="",ZTDTH=$H
 S LRDUZ=DUZ
 S ZTSAVE("LRDUZ")=""
 D ^%ZTLOAD
 W !!,"LR*5.2*538 Post-Install Routine has been tasked - TASK NUMBER: ",$G(ZTSK)
 W !!,"You as well as members of the LMI MailMan Group will receive"
 W !,"a MailMan message when the search completes.",!
 Q
 ;
START ;
 N LRAREA,LRDATE,LRACN,LRNUM,LRNOWYR,LRHIT,LRTXT,LRYEAR
 S ^XTMP("LR 538 POST INSTALL",0)=$$FMADD^XLFDT(DT,60)_"^"_DT_"^LR*5.2*538 POST INSTALL"
 S ^XTMP("LR 538 POST INSTALL",1)="Accession Area^Year^Accession^Test IEN^Load List Entry"
 ;Setting variable for current year in case this patch is not released until 2021
 S LRNOWYR=$$NOW^XLFDT(),LRNOWYR=$E(LRNOWYR,1,3)
 S LRAREA=0,LRNUM=1
 F  S LRAREA=$O(^LRO(68,LRAREA)) Q:'LRAREA  D
 . I $P($G(^LRO(68,LRAREA,0)),"^",3)="Y" D
 . . ;Variable LRHIT is used to determine whether the accession area is already set
 . . ;into ^TMP("LR538",$J)
 . . S (LRHIT,LRDATE)=0
 . . S LRTXT=$P($G(^LRO(68,LRAREA,0)),"^")
 . . ;There is no need to check the current year since the issue only
 . . ;affects accessions for previous years.
 . . F  S LRDATE=$O(^LRO(68,LRAREA,1,LRDATE)) Q:'LRDATE  Q:$E(LRDATE,1,3)=LRNOWYR  D
 . . . S LRYEAR=$$FMTE^XLFDT(LRDATE)
 . . . S LRACN=0
 . . . F  S LRACN=$O(^LRO(68,LRAREA,1,LRDATE,1,LRACN)) Q:'LRACN  D LRTST
 D XTMP,MAIL
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
LRTST ;
 N LRTST,LRSTR,LRTSTNM
 S LRTST=0
 F  S LRTST=$O(^LRO(68,LRAREA,1,LRDATE,1,LRACN,4,LRTST)) Q:'LRTST  D
 . S LRSTR=$G(^LRO(68,LRAREA,1,LRDATE,1,LRACN,4,LRTST,0))
 . S LRTSTNM=$P($G(^LAB(60,LRTST,0)),"^")
 . ;Is the first piece (test number) null (it should never be null)
 . ;and the load/list pointer field not null. (If it is null,
 . ;the issue addressed by LR*5.2*538 did not occur for test.)
 . I $P(LRSTR,"^")="",$P(LRSTR,"^",3)]"" D
 . . S LRNUM=LRNUM+1
 . . S ^XTMP("LR 538 POST INSTALL",LRNUM)=LRTXT_"^"_LRYEAR_"^"_LRACN_"^"_LRTSTNM_"^"_$P(LRSTR,"^",3)
 . . I 'LRHIT S ^TMP("LR538",$J,LRTXT)="",LRHIT=1
 . . ;Delete the corrupt node
 . . K ^LRO(68,LRAREA,1,LRDATE,1,LRACN,4,LRTST,0)
 Q
 ;
XTMP ;Generate MailMan message and keep in ^XTMP for 60 days
 S ^XTMP("LR 538 MAILMAN MESSAGE",0)=$$FMADD^XLFDT(DT,60)_"^"_DT_"^LR*5.2*538 POST INSTALL"
 I $O(^XTMP("LR 538 POST INSTALL",1))="" D  Q
 . S ^XTMP("LR 538 MAILMAN MESSAGE",2)=" "
 . S ^XTMP("LR 538 MAILMAN MESSAGE",3)="LR*5.2*538 post-install routine found no occurrences"
 . S ^XTMP("LR 538 MAILMAN MESSAGE",4)="in the ACCESSION (#68) file related to the issue for"
 . S ^XTMP("LR 538 MAILMAN MESSAGE",5)="ServiceNow ticket INC10676331."
 . ;Set an entry in the detail ^XTMP("LR 538 POST INSTALL" if needed for future reference
 . S ^XTMP("LR 538 POST INSTALL",1)="No issues found."
 ;
 ;Issues were found
 S ^XTMP("LR 538 MAILMAN MESSAGE",1)=" "
 S ^XTMP("LR 538 MAILMAN MESSAGE",2)="The post install for LR*5.2*538 found orphan nodes in the ACCESSION (#68)"
 S ^XTMP("LR 538 MAILMAN MESSAGE",3)="file which were set because of the issue for ServiceNow ticket INC10676331."
 S ^XTMP("LR 538 MAILMAN MESSAGE",4)=" "
 S ^XTMP("LR 538 MAILMAN MESSAGE",5)="The orphan nodes have been deleted."
 S ^XTMP("LR 538 MAILMAN MESSAGE",6)=" "
 S ^XTMP("LR 538 MAILMAN MESSAGE",7)="The global ^XTMP(""LR 538 POST INSTALL"") contains detailed information"
 S ^XTMP("LR 538 MAILMAN MESSAGE",8)="regarding specific accessions and tests which were set as orphan nodes."
 S ^XTMP("LR 538 MAILMAN MESSAGE",9)="The global will be deleted in sixty (60) days."
 S ^XTMP("LR 538 MAILMAN MESSAGE",10)=" "
 S ^XTMP("LR 538 MAILMAN MESSAGE",11)="Accession areas which contained orphan nodes are listed below:"
 S ^XTMP("LR 538 MAILMAN MESSAGE",12)=" "
 S ^XTMP("LR 538 MAILMAN MESSAGE",13)="Accession Area"
 S ^XTMP("LR 538 MAILMAN MESSAGE",14)="==================================="
 S LRNUM=14
 S LRAREA=""
 F  S LRAREA=$O(^TMP("LR538",$J,LRAREA)) Q:LRAREA=""  D
 . S LRNUM=LRNUM+1
 . S ^XTMP("LR 538 MAILMAN MESSAGE",LRNUM)=LRAREA
 K ^TMP("LR538",$J)
 Q
 ;
MAIL ;
 N LRMY,LRMSUB,LRMTEXT,LRMFROM,LRMIN
 S LRMIN("FROM")="LR*5.2*538 Post-Install"
 S LRMY(LRDUZ)=""
 S LRMY("G.LMI")=""
 S LRMSUB="LR*5.2*538 Post-Install"
 S LRMTEXT="^XTMP(""LR 538 MAILMAN MESSAGE"")"
 D SENDMSG^XMXAPI(DUZ,LRMSUB,LRMTEXT,.LRMY,.LRMIN,"","")
 Q
