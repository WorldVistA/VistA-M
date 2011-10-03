EAS1A58 ;ALB/PJR/EG - INVALID ENTRIES - EAS MT LETTER FILE ; 2/18/05 7:28 AM
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**58**; 21-OCT-94
 ;This post install routine checks the EAS MT Letter File (713.3)
 ;for the possible existence of entries for 20 and 40 day letters.
 ;If found, these entries will be deleted.
 Q
 ;
EP ;Entry point
 N DA,DIE,DR,X,ZBBB,ZCNT,ZDATE,ZNUM,PURDAT,BEGTIME
 ;capture beginning date/time and get purge date
 S BEGTIME=$$NOW^XLFDT()
 S PURGDT=$$FMADD^XLFDT(BEGTIME,15)
 S ZCNT=0,ZDATE=$$DT^XLFDT
 S $P(^XTMP("EAS1A58","DATE"),U)=$$FMTE^XLFDT($$NOW^XLFDT(),"5P")
 ;Check EAS MT Letter File
 F ZNUM=20,40 S ZBBB=$O(^EAS(713.3,"B",ZNUM_" ")) D
 .I $E(ZBBB,1,2)=ZNUM,ZBBB["DAY",ZBBB["LETTER",$E(ZBBB,3)'?1N D
 ..S DA=$O(^EAS(713.3,"B",ZBBB,0)) I 'DA Q
 ..S DIE=713.3,DR=".01////@" D ^DIE S ZCNT=ZCNT+1 Q
 S $P(^XTMP("EAS1A58","DATE"),U,2)=$$FMTE^XLFDT($$NOW^XLFDT(),"5P")
 S ZDATE=$$DT^XLFDT
 D EA58 S ^XTMP("EAS1A58",0)=PURGDT_U_BEGTIME_U_X_U_ZCNT_U_ZDATE
 S ^XTMP("EAS1A58","COMPLETED")=1 D MSG
 Q
 ;
 ;
MSG ;create bulletin message in install file.
 N TXT S (TXT(3),TXT(5))=" "
 S TXT(1)="This patch checked the EAS MT Letter File (713.3)"
 S TXT(2)="for the existence of entries for 20 and 40 day letters."
 I ZCNT D SOME
 I 'ZCNT D NONE
 D BMES^XPDUTL(.TXT)
 Q
SOME ;
 I ZCNT=1 S TXT(4)="One entry was removed.  The process is complete." Q
 S TXT(4)=ZCNT_" entries were removed.  The process is complete."
 Q
NONE ;
 S TXT(4)="No such entries were found.  No action was necessary."
 Q
 ;
EA58 S X="EAS*1.0*58 Invalid Entries in EAS MT Letter File" Q
