TIUP271 ;SMT - Clean up utility for TIU*271 ; 4/12/13 10:57am
 ;;1.0;TEXT INTEGRATION UTILITIES;**271**;Aug 23, 2012;Build 12
 Q
 ; Utility By Seth Thompson - updated by Daniel Huffman
 ; Clean up String Dates in Field 1301 of file 8925
 ;
EN ;
 N DIE,DA,DR,TIUDT,TIUDA,CNT,RECS,ERR
 ;
 I $D(^TMP("TIU271")) W !,"Already Running! Only one instance allowed" Q
 S ^TMP("TIU271",0)="TIU*1*271 CLEANUP RUNNING"
 ;
 S TIUDT=9999999,ERR=0,CNT=1,RECS=0
 F  S TIUDT=$O(^TIU(8925,"D",TIUDT)) Q:'TIUDT  D
 . S DA=0 F  S DA=$O(^TIU(8925,"D",TIUDT,DA)) Q:'DA  D
 . . S RECS=RECS+1 D LOCK^TIUSRVP(.ERR,DA)
 . . I 'ERR D  Q
 . . . S DIE="^TIU(8925,",DR="1301///"_+TIUDT
 . . . D ^DIE
 . . . D UNLOCK^TIUSRVP(.ERR,DA)
 . . I $D(^TIU(8925,"D",TIUDT,DA)) D  ;If the node still exists...
 . . . S ^TMP("TIU271",CNT)="TIU Document:"_DA_" Reference Date:"_$$GET1^DIQ(8925,DA,1301,"I"),CNT=CNT+1
 . . . S ^TMP("TIU271",CNT)=" Reason: "_$S(ERR:$P(ERR,"^",2),1:"UNKNOWN"),CNT=CNT+1
 D MAIL
 K ^TMP("TIU271")
 S $P(^XTMP("TIUP271",0,"LAST"),U)="COMPLETED"  ;  djh update Set Completed status
 S $P(^XTMP("TIUP271",0,"LAST"),U,3)=$$NOW^XLFDT  ;  djh update Set completed date/time
 Q
 ;
MAIL ;
 ; djh update - Change XMD to XMY in newed list
 N CNT,MSG,XMY,XMDUZ,DIFROM,XMSUB,XMTEXT,I,NMSP,VAR
 ;
 S CNT=1
 S XMY(DUZ)="",XMY("G.TIU CACS")=""
 ; djh update add 'Patch ' to from text (XMDUZ) - fixes problem with mailman msg not being sent if any user name starts with TIU
 S XMSUB="REFERENCE DATES CORRECTED",XMTEXT="MSG(",XMDUZ="Patch TIU*1.0*271"
 S MSG(CNT)="This is a list of TIU Documents that had erroneous dates in the REFERENCE DATE ",CNT=CNT+1
 S MSG(CNT)="field and could not be cleaned up.",CNT=CNT+1
 S MSG(CNT)="For more information about the related issue, please see patch TIU*1*271",CNT=CNT+1
 S MSG(CNT)="",CNT=CNT+1
 ;
 S I=0 F  S I=$O(^TMP("TIU271",I)) Q:'I  S MSG(CNT)=^TMP("TIU271",I),CNT=CNT+1
 S:$O(^TMP("TIU271",0))="" MSG(CNT)="No Problems in REFERENCE DATE correction."
 D ^XMD
 Q
 ;
QUE ;  Entry point from kids Install
 N NAMSP,PATCH,JOBN,DTOUT,DUOUT,ZTSK,ZTRTN,ZTIO,ZTDTH,ZTDESC,QUIT,Y,ZTQUEUED,ZTREQ,ZTSAVE
 S NAMSP=$$NAMSP
 S JOBN="REFERENCE DATE UPDATE"
 S PATCH="TIU*1.0*271"
 ;
 L +^XTMP(NAMSP):$G(DILOCKTM,3) I '$T D  Q
 . D BMES^XPDUTL(JOBN_" job is already running.  Halting...")
 . D MES^XPDUTL("")
 . D QUIT
 ;
 I '$D(^XTMP(NAMSP)) D INITXTMP(NAMSP,JOBN_", "_PATCH,90)        ;90 day life
 S QUIT=0
 ;
 I $G(^XTMP(NAMSP,0,"LAST"))["COMPLETED" D  Q
 . W !!,*7,"This job has been run before to completion on "
 . ; djh update - use completed date from piece 3
 . W $$FMTE^XLFDT($P($G(^XTMP(NAMSP,0,"LAST")),"^",3)),!!
 . W "If you want to run it again, the global subscript ^XTMP('"_NAMSP_"') must be",!
 . W "deleted prior to doing so.",!!
 . D QUIT
 ;
 ;ques 2, if running from mumps prompt
 I '$D(XPDQUES("POS2")) D  I 'ZTDTH D QUIT Q
 . K DIR
 . S DIR("A",1)=" Enter when to Queue the "_JOBN_" job to run"
 . S DIR("A")=" in date@time format"
 . S DIR("B")="NOW"
 . S DIR(0)="D^::%DT"
 . S DIR("?")=" Enter when to start the job. The default is Now. You can enter a date and time in the format like this: 021506@3:30p"
 . D ^DIR I $D(DUOUT) W !,"Halting..." S ZTDTH="" Q
 . S:$D(DTOUT) Y=$$NOW^XLFDT S ZTDTH=$$FMTH^XLFDT(Y)
 . S $P(^XTMP(NAMSP,0,"LAST"),"^",1,2)="RUN^"_$$NOW^XLFDT
 ;
 ;ques 2, if running from kids install
 I $D(XPDQUES("POS2")) S ZTDTH=$$FMTH^XLFDT(XPDQUES("POS2"))
 ;
 D BMES^XPDUTL("=============================================================")
 D MES^XPDUTL("Queuing background job for "_JOBN_"...")
 D MES^XPDUTL("Start time: "_$$HTE^XLFDT(ZTDTH))
 D MES^XPDUTL("==============================================================")
 I ZTDTH="" D BMES^XPDUTL(JOBN_" NOT QUEUED") D QUIT Q
 ;
 S:$D(^XTMP(NAMSP,0,"LAST")) ^XTMP(NAMSP,0,"ZAUDIT",$H)="RE-STARTED ON"_"^"_$$NOW^XLFDT_"^"_$P(^XTMP(NAMSP,0,"LAST"),"^",2,5)
 ;
 I $P($G(^XTMP(NAMSP,0,"LAST")),"^")="STOP" D
 . S $P(^XTMP(NAMSP,0,"LAST"),"^",1,2)="RUN^"_$$NOW^XLFDT
 E  D
 . S ^XTMP(NAMSP,0,"LAST")="RUN^"_$$NOW^XLFDT_"^^^"
 ;
 S ZTRTN="EN^"_NAMSP,ZTIO=""
 S ZTDESC="Background job "_JOBN_" updated via "_PATCH
 S ZTSAVE("JOBN")=""
 L -^XTMP(NAMSP)
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
 ;
STOP ;stop job command
 I $$ST S ^XTMP($$NAMSP,0,"STOP")="" D
 . W !,"TALLY MISSING EXPIRATION DATES Job - set to STOP Soon"
 . W !!,"Check Status to be sure it has stopped and is not running..."
 . W !,"     (D STATUS^PSOTEXP1)"
 Q
 ;
ST() ;status
 L +^XTMP($$NAMSP):$G(DILOCKTM,3) I $T D  Q 0
 . L -^XTMP($$NAMSP)
 . W !,"*** NOT CURRENTLY RUNNING! ***",!
 Q 1
 ;
INITXTMP(NAMSP,TITLE,LIFE) ;create ^Xtmp according to SAC std
 N BEGDT,PURGDT
 S BEGDT=$$NOW^XLFDT()
 S PURGDT=$$FMADD^XLFDT(BEGDT,LIFE)
 I $G(^XTMP(NAMSP,0))']"" S ^XTMP(NAMSP,0)=PURGDT_"^"_BEGDT_"^"_TITLE
 Q
 ;
QUIT ;
 L -^XTMP(NAMSP)
 Q
 ;
