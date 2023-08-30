PSO7L684 ;DAL/JCH - MIGRATION REPORT UTILITIES ;07/10/2022
 ;;7.0;OUTPATIENT PHARMACY;**684,545**;DEC 1997;Build 270
 ;
 Q
 ;
REMIG ; Task DEA Migration
 N ZTRTN,ZTDESC,ZTIO,ZTSAVE,PSOTDTH
 N HANDPSO,TITLE,LIFE,BEGDT,PURGDT,ZTDTH
 S HANDPSO="PSO70684-INSTALL",TITLE="PSO DEA Migration"
 S LIFE=90
 ;
 S PSOTDTH=$$GETSTART() I PSOTDTH'?7N0.1".".N D  Q
 . D BMES^XPDUTL(" ** DEA Migration NOT Queued! ** ")
 ;
 S BEGDT=PSOTDTH,PURGDT=$$FMADD^XLFDT(BEGDT,LIFE)
 ;
 S ZTSAVE("DUZ")="",ZTSAVE("ZTDTH")="",ZTDTH=PSOTDTH
 S ZTRTN="PRE^PSO7P684",ZTIO="",ZTDESC=TITLE D ^%ZTLOAD
 I '$D(ZTSK) D  Q
 . D BMES^XPDUTL("")
 . D MES^XPDUTL("There was a problem queueing this task")
 . D MES^XPDUTL("*** Task NOT Queued! ***")
 . K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 ;
 D:$D(ZTSK)
 . D MES^XPDUTL("*** Task #"_ZTSK_" Queued! ***")
 . D INITXTMP^PSO7E684(HANDPSO,TITLE,LIFE)
 . S ^XTMP(HANDPSO,0)=PURGDT_"^"_BEGDT_"^"_TITLE
 . S ^XTMP(HANDPSO,"STATUS")="Start of Install (Interactive)"
 . L -^XTMP(HANDPSO)
 ;
 D BMES^XPDUTL("")
 Q
 ;
GETSTART() ; Prompt for time to start DEA Migration
 ; Minimum time to start: 5 minutes into future.
 ; Maximum time to start: 72 hours into future.
 ;
 N DIR,X,Y,MIBEG,MIEND,MIDEF
 S MIBEG=$$FMADD^XLFDT($$NOW^XLFDT(),,,4)
 S MIEND=$$FMADD^XLFDT($$NOW^XLFDT(),,24)
 S MIDEF=$P($$FMTE^XLFDT($$FMADD^XLFDT($$NOW^XLFDT(),,,10),2),":",1,2)
 S DIR(0)="DA^"_MIBEG_":"_MIEND_":%DT"
 S DIR("?",1)="The DEA Migration must be scheduled a minimum of 5 minutes"
 S DIR("?",2)="later than the current date/time, and no more than 24 hours"
 S DIR("?",3)="later than the current date/time.",DIR("?",4)=""
 S DIR("?")="Enter '^' to exit without queueing."
 S DIR("??")="^D MSDTHLP^PSO7E684"
 S DIR("A")="Date/Time to Queue the DEA Migration: ",DIR("B")=MIDEF
 D ^DIR
 Q Y
 ;
ASKRPTSCH(MIRESET) ; Ask if user still wants to run report even though migration is scheduled to run in the future
 N MISCHDT,MISCHM,PSOAST
 S $P(PSOAST,"*",74)="*"
 S MISCHDT=$P($G(^XTMP("PSO70684-INSTALL",0)),"^",2)
 Q:'MISCHDT 1
 I $$FMDIFF^XLFDT($$DT^XLFDT,MISCHDT)>1!($$FMDIFF^XLFDT($$NOW^XLFDT,MISCHDT,2)>60) D  Q 1
 . S ^XTMP(HANDPSO,"STATUS")="Migration Halted"
 . S MIRESET=1
 L -^XTMP(HANDPSO)
 N DIR
 S MISCHM=" at "_$$FMTE^XLFDT(MISCHDT)
 S DIR("A",1)=PSOAST
 S DIR("A",2)=" A new DEA Migration is scheduled to run"_$G(MISCHM)_"."
 S DIR("A",3)=" The current DEA Migration report data will be obsolete after "
 S DIR("A",4)="               the scheduled migration runs."
 S DIR("A",5)=PSOAST
 S DIR("A",6)=""
 S DIR("B")="N"
 S DIR(0)="Y",DIR("A")="Do you want to print the obsolete DEA Migration Report" D ^DIR S PSOPRINT=+$G(Y)
 Q $S(PSOPRINT>0:1,1:0)
 ;
ASKSCH2(HANDPSO) ; Ask user if they really want obsolete report data, if they just scheduled the migration refresh
 N MIGSTAT
 S MIGSTAT=$G(^XTMP(HANDPSO,"STATUS"))
 I $G(MIGSTAT)["Start of Install" S PSOPRINT=$$ASKRPTSCH()
 Q PSOPRINT
 ;
RPTDTHD(PSOPRINT,HANDPSO) ; Report Pre-Header; Display Date/Time current report data was last compiled/migrated.
 N STATUS,LASTRUN,PHANDLE,LASTMSG
 S STATUS=$G(^XTMP(HANDPSO,"STATUS"))
 S PHANDLE=$O(^XTMP("PSODEAWB"_"-"_($H+1)),-1)
 S LASTRUN=$G(^XTMP(PHANDLE,"COMPLETE"))
 Q:'$G(LASTRUN)
 S LASTMSG=" *** Now printing DEA Migration data from "_$$FMTE^XLFDT(LASTRUN)_" ***"
 W !!,LASTMSG
 Q
