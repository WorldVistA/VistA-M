DG53342P ;BPFO/JRP;POST INIT FOR PATCH 342;1-FEB-2001
 ;;5.3;Registration;**342**;Aug 13, 1993
 ;
POST ;Main entry point of post init routine
 N X,FDAROOT,MSGROOT,FDAWP,IENROOT,IENS
 ;Delete obsolete trigger
 S X(1)=" "
 S X(2)="Deleting trigger on VIETNAM SERVICE INDICATED? field"
 S X(3)="(#.32101) that deletes Agent Orange data when set to NO"
 S X(4)=" "
 D MES^XPDUTL(.X) K X
 D DELIX^DDMOD(2,.32101,3)
 ;Update entry in INCONSISTENT DATA ELEMENTS file (#38.6)
 S X(1)=" "
 S X(2)="Updating definition of INCONSISTENT DATA ELEMENT number 25"
 S X(3)=" "
 D MES^XPDUTL(.X) K X
 K FDAROOT,MSGROOT,FDAWP,IENROOT,IENS
 S IENS="25,"
 S:'$D(^DGIN(38.6,25)) IENS="+1,"
 S FDAROOT(38.6,IENS,.01)="AO CLAIMED W/OUT VIETNAM POS"
 S FDAROOT(38.6,IENS,2)="AGENT ORANGE EXPOSURE INDICATED WITHOUT VIETNAM ERA PERIOD OF SERVICE"
 S FDAROOT(38.6,IENS,3)="SERVICE VERIFIED"
 S FDAROOT(38.6,IENS,4)="NO"
 S FDAROOT(38.6,IENS,5)="CHECK"
 S FDAROOT(38.6,IENS,50)="FDAWP"
 S FDAWP(1,0)="Inconsistency results if the patient is a veteran, the 'EXPOSED TO AGENT"
 S FDAWP(2,0)="ORANGE' prompt is answered YES, and the 'PERIOD OF SERVICE' prompt is not"
 S FDAWP(3,0)="answered VIETNAM ERA (#7)."
 S IENROOT(1)=25
 I IENS="25," D FILE^DIE("E","FDAROOT","MSGROOT") I 1
 E  D UPDATE^DIE("E","FDAROOT","IENROOT","MSGROOT")
 I $D(MSGROOT("DIERR")) D
 .N ERR,LINE,SPOT
 .S SPOT=2
 .S ERR=0
 .F  S ERR=+$O(MSGROOT("DIERR",ERR)) Q:'ERR  D
 ..I SPOT'=2 S X(SPOT)=" ",SPOT=SPOT+1
 ..S LINE=0
 ..F  S LINE=+$O(MSGROOT("DIERR",ERR,"TEXT",LINE)) Q:'LINE  D
 ...S X(SPOT)=MSGROOT("DIERR",ERR,"TEXT",LINE)
 ...S SPOT=SPOT+1
 .S (X(1),X(SPOT))=" "
 .D MES^XPDUTL(.X) K X
 ;Create entry in INCONSISTENT DATA ELEMENTS file (#38.6)
 S X(1)=" "
 S X(2)="Creating definition of INCONSISTENT DATA ELEMENT number 60"
 S X(3)=" "
 D MES^XPDUTL(.X) K X
 K FDAROOT,MSGROOT,IENROOT,FDAWP,IENS
 S IENS="+1,"
 S:$D(^DGIN(38.6,60)) IENS="60,"
 S FDAROOT(38.6,IENS,.01)="AGENT ORANGE EXP LOC MISSING"
 S FDAROOT(38.6,IENS,2)="'AGENT ORANGE EXPOSURE LOCATION' REQUIRED IF AO EXP INDICATED"
 S FDAROOT(38.6,IENS,3)="SERVICE VERIFIED"
 S FDAROOT(38.6,IENS,4)="NO"
 S FDAROOT(38.6,IENS,5)="CHECK"
 S FDAROOT(38.6,IENS,50)="FDAWP"
 S FDAWP(1,0)="Inconsistency results if the 'EXPOSED TO AGENT ORANGE' prompt is answered"
 S FDAWP(2,0)="YES and the 'AGENT ORANGE EXPOSURE LOCATION' prompt is not answered."
 S IENROOT(1)=60
 I IENS="+1," D UPDATE^DIE("E","FDAROOT","IENROOT","MSGROOT") I 1
 E  D FILE^DIE("E","FDAROOT","MSGROOT")
 I $D(MSGROOT("DIERR")) D
 .N ERR,LINE,SPOT
 .S SPOT=2
 .S ERR=0
 .F  S ERR=+$O(MSGROOT("DIERR",ERR)) Q:'ERR  D
 ..I SPOT'=2 S X(SPOT)=" ",SPOT=SPOT+1
 ..S LINE=0
 ..F  S LINE=+$O(MSGROOT("DIERR",ERR,"TEXT",LINE)) Q:'LINE  D
 ...S X(SPOT)=MSGROOT("DIERR",ERR,"TEXT",LINE)
 ...S SPOT=SPOT+1
 .S (X(1),X(SPOT))=" "
 .D MES^XPDUTL(.X) K X
EN1 ;Queue seeding of new field
 ; Queue time is post install question POS1 (use NOW if not defined)
 ; If queued using entry point QUEUE, queue time will be prompted for
 N ZTSK,ZTRTN,ZTIO,ZTDESC,ZTDTH
 S X(1)=" "
 S X(2)=" "
 S X(3)="Routine to populate AGENT ORANGE EXPOSURE LOCATION field"
 S X(4)="(#.3213) with VIETNAM for all patients claiming exposure"
 S X(5)="to agent orange (AGENT ORANGE EXPOS. INDICATED? equals"
 S X(6)="YES) will now be queued"
 S X(7)=" "
 D MES^XPDUTL(.X) K X
 I $D(^XTMP("DG53342P",2)) D  Q
 .S X(1)=" "
 .S X(2)="*****"
 .S X(3)="Post init appears to be running.  If it is not, delete the"
 .S X(4)="node ^XTMP(""DG53342P"",2) and use line tag QUEUE^DG53342P"
 .S X(5)="to [re]start the process."
 .S X(6)="*****"
 .S X(7)=" "
 .D MES^XPDUTL(.X) K X
 I $D(^XTMP("DG53342P",3)) D  Q
 .S X(1)=" "
 .S X(2)="*****"
 .S X(3)="Post init appears to have run to completion on "_$$FMTE^XLFDT(^XTMP("DG53342P",3))_"."
 .S X(4)="If it did not, delete the node ^XTMP(""DG53342P"",3) and use"
 .S X(5)="line tag QUEUE^DG53342P to [re]start the process."
 .S X(6)="*****"
 .S X(7)=" "
 .D MES^XPDUTL(.X) K X
 S ZTRTN="SET^DG53342P",ZTIO=""
 S ZTDTH=$H S X=+$G(XPDQUES("POS1")) S:(X) ZTDTH=$$FMTH^XLFDT(X) K:$G(DG53342P) ZTDTH
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
 S ^XTMP("DG53342P",0)=$$FMADD^XLFDT(DATIM,30)_"^"_DATIM
 S ^XTMP("DG53342P",2)=1
 S QFLG=0
 S Y=$G(^XTMP("DG53342P",1))
 S (DFN,LASTDFN)=+Y,DFNCNT=+$P(Y,"^",2),AOCNT=+$P(Y,"^",3)
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D  Q:QFLG
 .S DFNCNT=DFNCNT+1
 .S LASTDFN=DFN
 .S Y=$G(^DPT(DFN,.321))
 .I $P(Y,U,2)="Y" S:($P(Y,U,13)="") $P(^DPT(DFN,.321),U,13)="V",AOCNT=AOCNT+1
 .I '(DFNCNT#100) S QFLG=$$S^%ZTLOAD("DFN: "_DFN) H 5
 S ^XTMP("DG53342P",1)=LASTDFN_"^"_DFNCNT_"^"_AOCNT
 K ^XTMP("DG53342P",2)
 S DATIM=$$NOW^XLFDT()
 I QFLG D  I 1
 .S ZTSTOP=1
 .S Y=$$S^%ZTLOAD("STOPPED PROCESSING AT DFN "_LASTDFN)
 E  D
 .S ^XTMP("DG53342P",3)=DATIM
 .S ZTREQ="@"
 S XMSUB="DG*5.3*342 post init has run to completion."
 S:(QFLG) XMSUB="DG*5.3*342 post init was asked to stop."
 K ^TMP($J,"DG53342P")
 S ^TMP($J,"DG53342P",1,0)="Routine to populate AGENT ORANGE EXPOSURE LOCATION field"
 S ^TMP($J,"DG53342P",2,0)="(#.3213) with VIETNAM for all patients claiming exposure"
 S ^TMP($J,"DG53342P",3,0)="to agent orange (AGENT ORANGE EXPOS. INDICATED? equals"
 S ^TMP($J,"DG53342P",4,0)="YES) ran to completion on "_$$FMTE^XLFDT(DATIM)_"."
 S ^TMP($J,"DG53342P",5,0)=" "
 S ^TMP($J,"DG53342P",6,0)="Post init routine DG53342P can be deleted."
 I QFLG D
 .S ^TMP($J,"DG53342P",4,0)="YES) was asked to stop on "_$$FMTE^XLFDT(DATIM)_"."
 .S ^TMP($J,"DG53342P",5,0)=" "
 .S ^TMP($J,"DG53342P",6,0)="Use the entry point QUEUE^DG53342P to resume seeding."
 S XMDUZ="Patch DG*5.3*342"
 S XMTEXT="^TMP($J,""DG53342P"","
 S XMY(DUZ)=""
 D ^XMD
 K ^TMP($J,"DG53342P")
 S ZTREQ="@"
 Q
 ;
QUEUE ;Line tag for field to use to requeue seeding
 N X,DG53342P
 S DG53342P=1
 D EN1
 Q
