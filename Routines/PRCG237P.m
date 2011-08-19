PRCG237P ;WISC/BGJ - IFCAP 442 FILE CLEANUP (PURGE); 11/5/99 12:22pm ;9/20/00  12:56
V ;;5.1;IFCAP;**95,131**;Oct 20, 2000;Build 13
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;This routine is installed by patch PRC*5*237.
 ;The purpose of this routine is to clean up Accounts Receivable entries
 ;in file 442 that were not purged by running the Archive/Purge
 ;functionality.  It will also purge entries in file 442 that do not
 ;have a date in the P.O. DATE field (DATE P.O. ASSIGNED field is used
 ;for comparison).  Routine PRCG237Q is a routine installed by patch
 ;237 that queues entries into PurgeMaster for purging.  Those entries
 ;are then purged by this routine as PurgeMaster cycles through file
 ;443.1 (PurgeMaster Worklist).
 ;
442(X) ;
 N DA,KDA,BEGDA,ENDA,PODATE,DTPOASN,SITE,DATE,ZERONODE,MOP,PONUM
 D UNLOAD
 F  S DA=$O(^PRC(442,DA)) Q:'DA!(DA>ENDA)  D
 . S ZERONODE=$G(^PRC(442,DA,0)),PONUM=$P(ZERONODE,"^")
 . I $P(ZERONODE,"-")'=SITE Q
 . S PODATE=$P($G(^PRC(442,DA,1)),"^",15)
 . I PODATE>DATE Q
 . I +PODATE=0 D  Q
 . . S DTPOASN=$P($P($G(^PRC(442,DA,12)),"^",5),".")
 . . I DTPOASN>DATE Q
 . . S KDA=DA D KILL442(KDA)
 . S MOP=$P(ZERONODE,"^",2),PONUM=$P(ZERONODE,"^")
 . I 'MOP Q
 . S MOP=$P($G(^PRCD(442.5,MOP,0)),"^",2)
 . I MOP="AR" S KDA=DA D KILL442(KDA)
 Q
UNLOAD ;
 S BEGDA=$P(X,"-",1),ENDA=+$P(X,"-",2),SITE=$P(X,";",2)
 S DATE=$P(X,";",3)
 S DA=BEGDA-.1
 Q
KILL442(DA) ;
 Q:'$D(^PRC(442,DA,0))
 S DIK="^PRC(442," D ^DIK
 K DIK
 D KLL4406,KLL4219
 Q
KLL4406 ;find/kill invalid records in file 440.6
 N IPIEN,HLDDA
 S IPIEN=0,HLDDA=0
 F  S IPIEN=$O(^PRCH(440.6,"PO",DA,IPIEN)) Q:IPIEN'>0  D
 .S HLDDA=DA,DA=IPIEN
 .S DIK="^PRCH(440.6," D ^DIK
 .K DIK
 .S DA=HLDDA
 K IPIEN,HLDDA
 Q
KLL4219 ;find/kill invalid records in file 421.9
 Q:$G(PONUM)=""
 N IPIEN,HLDDA
 S IPIEN=0,HLDDA=DA
 F  S IPIEN=$O(^PRCF(421.9,"B",PONUM,IPIEN)) Q:IPIEN'>0  D
 .S DA=IPIEN
 .S DIK="^PRCF(421.9," D ^DIK
 .K DIK
 S DA=HLDDA
 K IPIEN,HLDDA
 Q
