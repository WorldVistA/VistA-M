DG53A564 ;ALB/PJR;POST INIT FOR PATCH 564 ; 6/9/04 3:51pm
 ;;5.3;Registration;**564**;Aug 13, 1993
 ;
EP ;Main entry point of post init routine
EN1 ;Queue seeding of new field
 ; Queue time is post install question POS1 (use NOW if not defined)
 ; If queued using entry point QUEUE, queue time will be prompted for
 N ZTSK,ZTRTN,ZTIO,ZTDESC,ZTDTH,Y9
 S X(1)=" "
 S X(2)=" "
 S X(3)="Routine to populate AGENT ORANGE EXPOSURE LOCATION field"
 S X(4)="(#.3213) with VIETNAM for all patients claiming exposure"
 S X(5)="to agent orange (AGENT ORANGE EXPOS. INDICATED? equals"
 S X(6)="YES) and Exposure Location equals NULL will now be queued"
 S X(7)=" "
 D MES^XPDUTL(.X) K X
 I $D(^XTMP("DG53A564",2)) D  Q
 .S X(1)=" "
 .S X(2)="*****"
 .S X(3)="Post init appears to be running.  If it is not, delete the"
 .S X(4)="node ^XTMP(""DG53A564"",2) and use line tag QUEUE^DG53A564"
 .S X(5)="to [re]start the process."
 .S X(6)="*****"
 .S X(7)=" "
 .D MES^XPDUTL(.X) K X
 I $D(^XTMP("DG53A564",3)) D  Q
 .S X(1)=" "
 .S X(2)="*****"
 .S X(3)="Post init appears to have run to completion on "_$$FMTE^XLFDT(^XTMP("DG53A564",3))_"."
 .S X(4)="If it did not, delete the node ^XTMP(""DG53A564"",3) and use"
 .S X(5)="line tag QUEUE^DG53A564 to [re]start the process."
 .S X(6)="*****"
 .S X(7)=" "
 .D MES^XPDUTL(.X) K X
 S ZTRTN="SET^DG53A564",ZTIO=""
 S ZTDTH=$H S X=+$G(XPDQUES("POS1")) S:(X) ZTDTH=$$FMTH^XLFDT(X) K:$G(DG53A564) ZTDTH
 S ZTDESC="Initial seeding of AGENT ORANGE EXPOSURE LOCATION field"
 D ^%ZTLOAD
 I $G(ZTSK) D MES^XPDUTL("Task #"_ZTSK_" queued to start "_$$HTE^XLFDT($G(ZTSK("D")))) I 1
 E  D MES^XPDUTL("***** UNABLE TO QUEUE INITIAL SEEDING *****")
 Q
 ;
SET ; This is the post-init to make sure all patients claiming
 ; exposure to agent orange have a selected location for the
 ; exposure.  The initial setting is Vietnam.
 N AOCNT,DFNCNT,DATIM,DFN,QFLG,Y,XMSUB,XMDUZ,XMTEXT,XMY,LASTDFN
 S DATIM=$$DT^XLFDT()
 S ^XTMP("DG53A564",0)=$$FMADD^XLFDT(DATIM,30)_"^"_DATIM
 S ^XTMP("DG53A564",2)=1
 S QFLG=0
 S Y=$G(^XTMP("DG53A564",1))
 S (DFN,LASTDFN)=+Y,DFNCNT=+$P(Y,"^",2),AOCNT=+$P(Y,"^",3)
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D  Q:QFLG
 .S DFNCNT=DFNCNT+1
 .S LASTDFN=DFN
 .S Y9=$G(^DPT(DFN,.321)) I $P(Y9,U,2)="Y",$P(Y9,U,13)="" D
 ..S (DA,Y)=DFN,DIE="^DPT(",DR=".3213///VIETNAM" D ^DIE S AOCNT=AOCNT+1
 .I '(DFNCNT#1000) S QFLG=$$S^%ZTLOAD("DFN: "_DFN) H 1
 S ^XTMP("DG53A564",1)=LASTDFN_"^"_DFNCNT_"^"_AOCNT
 K ^XTMP("DG53A564",2)
 S DATIM=$$NOW^XLFDT()
 I QFLG D  I 1
 .S ZTSTOP=1
 .S Y=$$S^%ZTLOAD("STOPPED PROCESSING AT DFN "_LASTDFN)
 E  D
 .S ^XTMP("DG53A564",3)=DATIM
 .S ZTREQ="@"
 S XMSUB="DG*5.3*564A post init has run to completion."
 S:(QFLG) XMSUB="DG*5.3*564A post init was asked to stop."
 K ^TMP($J,"DG53A564")
 S ^TMP($J,"DG53A564",1,0)="Routine to populate AGENT ORANGE EXPOSURE LOCATION field"
 S ^TMP($J,"DG53A564",2,0)="(#.3213) with VIETNAM for all patients claiming exposure"
 S ^TMP($J,"DG53A564",3,0)="to agent orange (AGENT ORANGE EXPOS. INDICATED? equals"
 S ^TMP($J,"DG53A564",4,0)="YES) and Exposure Location equals NULL"
 S ^TMP($J,"DG53A564",5,0)="ran to completion on "_$$FMTE^XLFDT(DATIM)_"."
 S ^TMP($J,"DG53A564",6,0)=" "
 S ^TMP($J,"DG53A564",7,0)="Post init routine DG53A564 can be deleted."
 I QFLG D
 .S ^TMP($J,"DG53A564",4,0)="YES) was asked to stop on "_$$FMTE^XLFDT(DATIM)_"."
 .S ^TMP($J,"DG53A564",5,0)=" "
 .S ^TMP($J,"DG53A564",6,0)="Use the entry point QUEUE^DG53A564 to resume seeding."
 S XMDUZ="Patch DG*5.3*564A"
 S XMTEXT="^TMP($J,""DG53A564"","
 S XMY(DUZ)=""
 D ^XMD
 K ^TMP($J,"DG53A564")
 S ZTREQ="@"
 Q
 ;
QUEUE ;Line tag for field to use to requeue seeding
 N X,DG53A564
 S DG53A564=1
 D EN1
 Q
