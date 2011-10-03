RA27PST ;HIRMFO/SWM - Clean up after Patch RA*5.0*27 ;12/28/01  14:06
VERSION ;;5.0;Radiology/Nuclear Medicine;**27**;Mar 16, 1998
 ; *** Delete duplicate Clinical History from file #74 ***
 ;
QOFF ;Post-Install queues off clean-up job
 I '$D(XPDNM)#2 W !!,"** This entry point must be called from KIDS installation **",!! Q
 N RATXT,ZTDESC,ZTDTH,ZTIO,ZTRTN S ZTIO=""
 S ZTRTN="EN^RA27PST"
 S ZTDESC="RA*5.0*27 Cleanup Duplicate Clin. Hist. from File 74"
 S ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT(),0,0,2,0) ;add 2 minutes to 'now'
 D ^%ZTLOAD S RATXT(1)=" "
 S RATXT(2)="RA*5.0*27 cleanup is running in background."
 S:$G(ZTSK)>0 RATXT(3)="Task: "_ZTSK_"." D MES^XPDUTL(.RATXT)
 Q
MANUAL ;manually queue off clean-up job, only needed if post-install abends
 ;^XTMP("RA-RA27PST",0)=60days later^date+time this was 1st run^description^subsequent date+time this was run (overwritten each subsequent time)
 I +$G(DUZ)=0 W !!?5,"** DUZ is required!  Nothing done.  **",!! Q
 N RA1 S RA1=""
 I $D(^XTMP("RA-RA27PST",0))#2 S RA1=^(0)
 I RA1="" W !,"This clean-up was either never queued off by the Installation of RA*5.0*27,",!,"or it had been completed over 60 days ago.",!! G ASKQ
 I $P(RA1,"^",4)]"" S Y=$P(RA1,"^",4) D DD^%DT W !!?2,"MANUAL^RA27PST was done previously on ",Y,!!
 I $P(RA1,"^",4)="" S Y=$P(RA1,"^",2) D DD^%DT W !!?2,"The installation of RA*5*27 tasked this job on ",Y,!?2,"but the job abended.",!!
 I $G(^XTMP("RA-RA27PST","LAST"))="DONE" W !,"This clean-up was completed. You do not have to queue it again.",!! Q
ASKQ K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="Y",DIR("B")="No"
 S DIR("?")="Enter 'Y' if you want to queue the clean-up of duplicate Clin. History for File #74."
 S DIR("A")="Do you want to continue the clean-up from patch RA*5.0*27"
 D ^DIR
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 Q:'Y  ;don't queue if answer is NO
 N ZTDESC,ZTDTH,ZTIO,ZTRTN S ZTIO=""
 S ZTRTN="EN^RA27PST"
 S ZTDESC="MANUAL Cleanup Duplicate Clin. Hist. from File 74, (RA*5*27 post-install)"
 S ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT(),0,0,2,0) ;add 2 minutes to 'now'
 D ^%ZTLOAD
 W !?2,"RA*5.0*27 cleanup will start in 2 minutes in the background."
 I $G(ZTSK)>0 W !?2,"Task: "_ZTSK_".",!!
 Q
 ;
EN ; delete duplicate clinical history from file 74
 S ZTREQ="@" ; delete from the task global
 N %,RA70,RA701,RA74,RACNT,RAD0,RADFN,RADTI,RADELCNT,RADUPCNT
 N RACNI,RACN,RACNT,RADUPHX,RANODE,RAOK,RAPOINT,RAX,RAX1
 N RA1,RA2,RA3
 S RA1="To IRM staff:"
 S RA2=" If this routine abends, you may get the current count"
 S RA3=" of records processed by listing ^XTMP(""RA-RA27PST"" "
 S ^XTMP("RA-RA27PST",.1)="  Here are the counts from the post-install cleanup."
 S ^XTMP("RA-RA27PST",.2)=" "
 D INIT
 I RAPOINT="DONE" S ^XTMP("RA-RA27PST",.1)="Already done previously.  No need to continue.",^(.3)="----- Previous results are repeated below: ----- ",^(.4)="" D MAIL Q
 S RAD0=+RAPOINT
 F  S RAD0=$O(^RARPT(RAD0)) Q:'RAD0  D CHKHX D:RADUPHX DELHX S ^XTMP("RA-RA27PST","LAST")=RAD0,RACNT=RACNT+1,$P(^XTMP("RA-RA27PST",.5),"^")=RACNT
 ; increment "LAST" and RACNT  after  chkhx and delhx
 D FINISH
 D MAIL
 Q
CHKHX ; Check  History between  file 70 and 74.
 ; Returns RADUPHX  1 = Duplicate
 ;                  0 = Different
 S RADUPHX=0
 I '$O(^RARPT(RAD0,"H",0)) Q  ;default to 0 to skip DELHX since no data
 S RANODE=$G(^RARPT(RAD0,0)) Q:RANODE=""
 S RADFN=$P(RANODE,"^",2),RADTI=9999999.9999-$P(RANODE,"^",3)
 S RACN=$P(RANODE,"^",4)
 Q:'RADFN!('RADTI)!('RACN)
 S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P","B",RACN,0))
 Q:'RACNI
 S RA74=$O(^RARPT(RAD0,"H",""),-1)
 S RA70=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"H",""),-1),RA701=$O(^(0))
 Q:RA70=0  Q:RA701=""  ;no history in exam record
 S RAX=RA74-RA70+1 Q:RAX'=1  ;different total lines
 ; same total lines, so check line by line
 ; RAOK=1 all lines match, =0 at least 1 difference
 S RAOK=1
 F RAX1=RA701:1:RA70 I ^RARPT(RAD0,"H",RAX1,0)'=^RADPT(RADFN,"DT",RADTI,"P",RACNI,"H",RAX1,0) S RAOK=0 Q
 I 'RAOK Q
 S RADUPCNT=RADUPCNT+1
 S $P(^XTMP("RA-RA27PST",.6),"^")=RADUPCNT
 I $P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),"^",17)'=RAD0 D MSG1 Q  ;exam not pointing to this report, so skip this report
 S RADUPHX=1
 Q
DELHX ; delete history portion from this report
 L +^RARPT(RAD0):0 I '$T D MSG2 Q
 K ^RARPT(RAD0,"H")
 L -^RARPT(RAD0)
 S RADELCNT=RADELCNT+1
 S $P(^XTMP("RA-RA27PST",.7),"^")=RADELCNT
 Q
MSG1 ;
 S ^XTMP("RA-RA27PST",RAD0)=$P(RANODE,"^")_" ien="_RAD0_" but",^XTMP("RA-RA27PST",(RAD0+.1))=" ^RADPT("_RADFN_",""DT"","_RADTI_",""P"","_RACNI_",0)'s 17th piece="_$P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),"^",17)
 Q
MSG2 ;
 S ^XTMP("RA-RA27PST",RAD0)=$P(RANODE,"^")_" locked by another process."
 Q
INIT ; set point of latest ien processed
 N %,%H,%I,%T,X,Y,RANOW
 D NOW^%DTC S RANOW=% ;output NOW's dt+tm is in var %
 I $D(^XTMP("RA-RA27PST",0))#2 S $P(^(0),"^",4)=RANOW,RAPOINT=^("LAST"),RACNT=+^(.5),RADUPCNT=+^(.6),RADELCNT=+^(.7) Q
 S (RACNT,RADELCNT,RADUPCNT,RAPOINT)=0
 S X1=RANOW,X2=60 D C^%DTC ;add 60 days to RANOW, output is X
 S ^XTMP("RA-RA27PST",0)=X_"^"_RANOW_"^"_"RA*5*27 POST-INSTALL"
 S ^XTMP("RA-RA27PST","LAST")=0
 S ^XTMP("RA-RA27PST",.5)="^ reports processed"
 S ^XTMP("RA-RA27PST",.6)="^ reports with dupl history"
 S ^XTMP("RA-RA27PST",.7)="^ reports had dupl history purged"
 Q
FINISH ; all done
 S ^XTMP("RA-RA27PST","LAST")="DONE"
 S ^XTMP("RA-RA27PST",.8)=" "
 S ^XTMP("RA-RA27PST",.81)="  The cleanup finished."
 S ^XTMP("RA-RA27PST",.82)=" "
 I $O(^XTMP("RA-RA27PST",.99)) S ^XTMP("RA-RA27PST",.83)="The following reports' history was not purged:",^(.84)=" "
 Q
MAIL ; Send mail message to the installer
 N XMDUZ,XMSUB,XMTEXT,XMY S XMDUZ=.5
 S XMTEXT="^XTMP(""RA-RA27PST""," ;only numeric nodes are mailed
 S XMSUB="Results from patch RA*5*27's post-install rtn RA27PST"
 S XMY(DUZ)="" D ^XMD
 Q
