PRCG239P ;WISC/BGJ - IFCAP 442 FILE CLEANUP (PURGE); 11/5/99 12:22pm ;9/20/00  12:56
V ;;5.1;IFCAP;**95**;Oct 20, 2000
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;This routine is installed by patch PRC*5.1*95.
 ;The purpose of this routine is to clean up FMS reconcilliation data
 ;in file 417 that were not purged by running the Archive/Purge
 ;functionality.  Routine PRCG239Q is a routine installed by patch
 ;95 that queues entries into PurgeMaster for purging.  Those entries
 ;are then purged by this routine as PurgeMaster cycles through file
 ;443.1 (PurgeMaster Worklist).
 ;
417(X) ;
 N DA,KDA,BEGDA,ENDA,PODATE,DTPOASN,SITE,DATE,ZERONODE,MOP
 D UNLOAD
 F  S DA=$O(^PRCS(417,DA)) Q:'DA!(DA>ENDA)  D
 . S ZERONODE=$G(^PRCS(417,DA,0)) Q:ZERONODE=""
 . S PODATE=$P($G(^PRCS(417,DA,0)),"^",22)
 . I PODATE>DATE Q
 . S KDA=DA D KILL417(KDA)
 Q
UNLOAD ;
 S BEGDA=$P(X,"-",1),ENDA=+$P(X,"-",2),SITE=$P(X,";",2)
 S DATE=$P(X,";",3)
 S DA=BEGDA-.1
 Q
KILL417(DA) ;
 Q:'$D(^PRCS(417,DA,0))
 S DIK="^PRCS(417," D ^DIK
 K DIK
 Q
