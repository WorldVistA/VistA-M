DG967PST ;BIR/CML-PATCH DG*5.3*967 POST INSTALLATION ROUTINE ;8/14/18
 ;;5.3;Registration;**967**;Aug 13, 1993;Build 3
 ;
 ;      - Story 783361 (cml) DG*5.3*967
 ; This post-init will loop thru the DG SECURITY LOG FILE (#38.1) and identify entries that are marked as "sensitive".
 ; The job will be scheduled to run after 10:00pm local time.
 ; Any records that are found will trigger an A31 message to the MPI.
 ; When the job is complete it will send an email with stats to:
 ;  -  (locally) POSTMASTER and the person who installed the patch (DUZ)
 ;  -  (MPI Outlook) Christine.Chesney@domain.ext, Link.Christine@domain.ext and John.Williams30ec0c@domain.ext.
 ;
 ;      - Story 827326 (cml) DG*5.3*967
 ; This post-init will loop thru the Patient file (#2) and look for any records with the ZIP+4 field (#.1112) that contains a "-".
 ; The job will be scheduled to run after 10:00pm local time.
 ; Any records that are found will strip out the dash and reset the field which will put the edit in the ADT/HL7 PIVOT file (#391.71)
 ; When the job is complete it will send an email with stats to:
 ;  -  (locally) POSTMASTER and the person who installed the patch (DUZ)
 ;  -  (MPI Outlook) Christine.Chesney@domain.ext, Link.Christine@domain.ext and John.Williams30ec0c@domain.ext.
 ;
POST ;queue off post-init to identify patients marked as "sensitive" and trigger A31 to MPI and clean up ZIP+4 records
 N DGI,DGFLDS
 D BMES^XPDUTL("Post-Install for Sensitivity Seeding/ZIP+4 Cleanup:")    ;,MES^XPDUTL("")
 I $$PATCH^XPDUTL("DG*5.3*967") D BMES^XPDUTL("Post-Install for Sensitivity Seeding/ZIP+4 previously run.") Q
 D QUE  ;Task off seeding job of sensitivity updates to MPI and ZIP+4 cleanup
 D BMES^XPDUTL("Post-Install for Sensitivity Seeding/ZIP4 Queued.")
 Q
 ;
QUE ; Queue off seeding job of sensitivity updates to MPI and ZIP+4 cleanup to run after 10:00pm
 D BMES^XPDUTL(" Queuing job to seed sensitivity updates to MPI/ZIP+4 cleanup after 10:00pm.")
 N DAY,DONE,QQ,TIME,ZTIO,ZTSK,ZTRTN,ZTDESC,ZTSAVE,ZTDTH,Y
 S ZTIO="",ZTRTN="SECLOOP^DG967PST"
 ;schedule job after 10:00pm
 K SCH S QQ=$$NOW^XLFDT,DAY=$P(QQ,"."),TIME=$P(QQ,".",2)
 I TIME<"215900" S SCH=DAY_".2205"
 I TIME>"220000" S SCH=$$NOW^XLFDT
 S ZTDTH=SCH
 S ZTDESC="DG*5.3*967 post-install seeding sensitivity updates and ZIP+4 cleanup."
 D ^%ZTLOAD
 I '$G(ZTSK) D MES^XPDUTL("   **** Queuing job failed!!!") Q
 D MES^XPDUTL("   Job number #"_ZTSK_" was queued.")
 Q
 ;
SECLOOP ; entry point for queued job to loop on DG SECURITY LOG FILE
 N DFNCNT,DFN,ICN,SENSI,A31CNT,START,TRY,DONE
 S START=$$FMTE^XLFDT($$NOW^XLFDT)
 S (DFNCNT,DFN,A31CNT)=0
 F  S DFN=$O(^DGSL(38.1,DFN)) Q:'DFN  S DFNCNT=DFNCNT+1 D
 .I $D(^DPT(DFN,-9)) Q
 .S SENSI=$P(^DGSL(38.1,DFN,0),"^",2) I SENSI D
 ..S ICN=$P($G(^DPT(DFN,"MPI")),"^") I ICN S A31CNT=A31CNT+1 S TRY=$$A31^MPIFA31B(DFN)
 ;
 S DONE=$$FMTE^XLFDT($$NOW^XLFDT)
 ;
EMAILS1 ; Send email to person who ran the INIT, letting them know results
 N XMDUZ,XMTEXT,XMSUB,XMY,XMZ,XMDUN,X,R
 S R(1)="Seeding of patients marked as Sensitive:"
 S R(2)=" "
 S R(3)="Process started: "_START
 S R(4)="Process completed: "_DONE
 S R(5)="Total number of patients processed           : "_DFNCNT
 S R(6)="Total number of A31 messages triggered to MPI: "_A31CNT
 S XMTEXT="R(",XMSUB="Result of running patch DG*5.3*967 (Sensitivity Seeding)"
 S XMDUZ=.5
 S XMY(DUZ)=""
 D ^XMD
 ;
 ; Send message to MPI developers on Outlook
 ; IA#4440 supported call to check for test or production account
 I $$PROD^XUPROD()=0 G ZIP4LOOP  ;not a production account. Don't send email to MPI dev
 ;
 N DGSNAME,DGSITE,XMDUZ,XMTEXT,XMSUB,XMY,XMZ,XMDUN,R
 S X=$$SITE^VASITE()
 S DGSNAME=$P(X,"^",2),DGSITE=$P(X,"^",3)
 S R(1)="Post-Init routine ^DG967PST run at station: "_DGSITE_" - "_DGSNAME
 S R(2)=" "
 S R(3)="Seeding of patients marked as Sensitive:"
 S R(4)="Process Started: "_START_"  -  Completed: "_DONE
 S R(5)=" "
 S R(6)="Total number of patients processed: "_DFNCNT_"                    "
 S R(7)="Total number of A31 messages triggered to MPI: "_A31CNT
 S XMTEXT="R(",XMSUB="Result of running patch DG*5.3*967 (Sensitivity) at station: "_DGSITE
 S XMDUZ=DUZ
 S XMY("Christine.Chesney@domain.ext")=""
 S XMY("John.Williams30ec0c@domain.ext")=""
 S XMY("Christine.Link@domain.ext")=""
 D ^XMD
 ;
ZIP4LOOP ; start cleanup of ZIP+4 records
 N DFNCNT,DFN,NODE,ZIP4,EDZIP,EDCNT,START,DONE
 S START=$$FMTE^XLFDT($$NOW^XLFDT)
 S (DFNCNT,DFN,EDCNT)=0
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  S DFNCNT=DFNCNT+1 D
 .I $D(^DPT(DFN,-9)) Q
 .S NODE=$G(^DPT(DFN,.11)),ZIP4=$P(NODE,"^",12) I ZIP4["-" S EDCNT=EDCNT+1 D
 ..S EDZIP=$P(ZIP4,"-")_$P(ZIP4,"-",2) S X=EDZIP,DIE="^DPT(",DA=DFN,DR=".1112///^S X=EDZIP" D ^DIE K DIE,DA,DR
 ;
 S DONE=$$FMTE^XLFDT($$NOW^XLFDT)
 ;
EMAILS2 ; Send email to person who ran the INIT, letting them know results
 N XMDUZ,XMTEXT,XMSUB,XMY,XMZ,XMDUN,X,R
 S R(1)="Cleanup of Patient file records having ZIP+4 field (#.1112) with dashes:"
 S R(2)=" "
 S R(3)="Process started: "_START
 S R(4)="Process completed: "_DONE
 S R(5)="Total number of patients processed  : "_DFNCNT
 S R(6)="Total number of ZIP+4 records edited: "_EDCNT
 S R(7)=" ",R(8)="You can now delete the post-init routine ^DG967PST."
 S XMTEXT="R(",XMSUB="Result of running patch DG*5.3*967 (ZIP+4 cleanup)"
 S XMDUZ=.5
 S XMY(DUZ)=""
 D ^XMD
 ;
 ; Send message to MPI developers on Outlook
 ; IA#4440 supported call to check for test or production account
 Q:$$PROD^XUPROD()=0  ;not a production account. Don't send email to MPI dev
 ;
 N DGSNAME,DGSITE,XMDUZ,XMTEXT,XMSUB,XMY,XMZ,XMDUN,R
 S X=$$SITE^VASITE()
 S DGSNAME=$P(X,"^",2),DGSITE=$P(X,"^",3)
 S R(1)="Post-Init routine ^DG967PST run at station: "_DGSITE_" - "_DGSNAME
 S R(2)=" "
 S R(3)="Cleanup of Patient file records having ZIP+4 field (#.1112) with dashes:"
 S R(4)="Process Started: "_START_"  -  Completed: "_DONE
 S R(5)=" "
 S R(6)="Total number of patients processed: "_DFNCNT_"                    "
 S R(7)="Total number of ZIP+4 records edited: "_EDCNT
 S XMTEXT="R(",XMSUB="Result of running patch DG*5.3*967 (ZIP+4) at station: "_DGSITE
 S XMDUZ=DUZ
 S XMY("Christine.Chesney@domain.ext")=""
 S XMY("John.Williams30ec0c@domain.ext")=""
 S XMY("Christine.Link@domain.ext")=""
 D ^XMD
 Q
