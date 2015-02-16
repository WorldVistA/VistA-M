TIU285PS ; SLC/DJH - Patch 285 post-install routine ; 5/21/14 1:47pm
 ;;1.0;TEXT INTEGRATION UTILITIES;**285**;Jun 20, 1997;Build 5
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
EN ; reindex the "AC" index on file 8925.7
 ;
 N TIUD0,NAMSP,TIUDOC
 S NAMSP=$$NAMSP
 I $P($G(^XTMP(NAMSP,0,"STATUS")),U)="COMPLETED" Q
 K ^TIU(8925.7,"AC")
 ;
 S TIUD0=0
 F  S TIUD0=$O(^TIU(8925.7,TIUD0)) Q:'TIUD0  D
 . S TIUDOC=+$G(^TIU(8925.7,TIUD0,0))
 . I 'TIUDOC!'+$G(^TIU(8925,TIUDOC,0)) Q  ; skip if no tiu doc ptr or record
 . I $P($G(^TIU(8925.7,TIUD0,0)),U,4) Q  ; skip if signed
 . S ^TIU(8925.7,"AC",$P($G(^TIU(8925,TIUDOC,12)),U),$G(TIUDOC),TIUD0)=""
 S $P(^XTMP(NAMSP,0,"STATUS"),U)="COMPLETED"  ;  Set Completed status
 S $P(^XTMP(NAMSP,0,"STATUS"),U,3)=$$NOW^XLFDT  ;  Set completed date/time
 D MAIL
 Q
 ;
MAIL ;
 N CNT,MSG,XMY,XMDUZ,DIFROM,XMSUB,XMTEXT,I,NMSP,VAR
 S CNT=1,XMY(DUZ)="",XMY("G.TIU CACS")=""
 S XMSUB="INDEX REBUILD POST INSTALL",XMTEXT="MSG(",XMDUZ="Patch TIU*1.0*285"
 S MSG(CNT)="",CNT=CNT+1
 S MSG(CNT)="Patch TIU*1.0*285 post install routine has completed",CNT=CNT+1
 S MSG(CNT)="",CNT=CNT+1
 S MSG(CNT)="For more information about the related issue, review patch TIU*1*285",CNT=CNT+1
 S MSG(CNT)=""
 D ^XMD
 Q
 ;
QUE ;  Entry point from KIDS Install
 N NAMSP,PATCH,JOBN,ZTSK,ZTRTN,ZTIO,ZTDTH,ZTDESC,ZTSAVE,BEGDT,PURGDT
 S NAMSP=$$NAMSP ;TIU285PS
 S JOBN="TIU FIX REPORT INDEX",PATCH="TIU*1.0*285"
 ;
 I $D(^XTMP(NAMSP)) D  Q
 . D BMES^XPDUTL("=============================================================")
 . D MES^XPDUTL("Cannot queue background job!")
 . D MES^XPDUTL("This job was previously run on "_$$FMTE^XLFDT($P($G(^XTMP(NAMSP,0,"STATUS")),"^",2)))
 . D MES^XPDUTL("to run it again, ^XTMP('"_NAMSP_"') must be deleted.")
 . D MES^XPDUTL("=============================================================")
 ;
 ; INITIALIZE ^XTMP
 S BEGDT=$$NOW^XLFDT,PURGDT=$$FMADD^XLFDT(BEGDT,90)  ;90 day life
 S ^XTMP(NAMSP,0)=PURGDT_"^"_BEGDT_"^"_PATCH
 S ^XTMP(NAMSP,0,"STATUS")="RUN^"_$$NOW^XLFDT_"^^^"
 ;
 D BMES^XPDUTL("=============================================================")
 D MES^XPDUTL("Queuing background job for "_JOBN_"...")
 D MES^XPDUTL("Start time: "_$$HTE^XLFDT($H))
 D MES^XPDUTL("A Mailman message will be sent when it finishes")
 D MES^XPDUTL("==============================================================")
 ;
 S ZTRTN="EN^"_NAMSP,ZTIO=""
 S ZTDESC="Background job "_JOBN_" updated via "_PATCH,ZTSAVE("JOBN")=""
 S ZTDTH=$$FMTH^XLFDT($$NOW^XLFDT)  ; start time now
 D ^%ZTLOAD
 D:$D(ZTSK)
 . D MES^XPDUTL("*** Task #"_ZTSK_" Queued! ***")
 . D BMES^XPDUTL("")
 D BMES^XPDUTL("")
 K XPDQUES
 Q
 ;
NAMSP() ;
 Q $T(+0)
