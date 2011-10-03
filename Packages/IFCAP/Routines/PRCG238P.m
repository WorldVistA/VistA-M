PRCG238P ;WISC/BGJ-IFCAP 410 FILE CLEANUP (PURGE) ;11/5/99
V ;;5.1;IFCAP;**95**;Oct 20, 2000
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;This routine is installed by patch PRC*5*238.
 ;The purpose of this routine is to cleanup entries in files 410, 410.1
 ;and 443 that are leftover after running the Archive/Purge
 ;functionality.  Routine PRCG238Q is a routine installed by patch 238
 ;that queues entries into PurgeMaster for purging.  Those entries
 ;are then purged by this routine as PurgeMaster cycles through file
 ;443.1 (PurgeMaster Worklist).
 ;
410(X) ;
 N DA,KDA,OK,X1,FORMTYPE,TRANTYPE,REQDATE,REQFY,PRCHDA,PONUM,REQID,TEMPID,BEGDA,ENDA,SITE,PERMDATE,TEMPDATE
 D UNLOAD
 F  S DA=$O(^PRCS(410,DA)) Q:'DA!(DA>ENDA)  D
 . S OK=1
 . ;Kill 410 record when no zeroth node
 . S X=$G(^PRCS(410,DA,0)) I X="" S X="SYSPURG1",^(0)=X,^PRCS(410,"B","SYSPURG1",DA)="" S KDA=DA D KILL443(KDA),KILL410(KDA) Q
 . S X1=$G(^PRCS(410,DA,1)),FORMTYPE=$P(X,"^",4),TRANTYPE=$P(X,"^",2),REQDATE=$P(X1,"^"),REQID=$P(X,"^"),TEMPID=$P(X,"^",3)
 . I $P(REQID,"-")'=SITE Q
 . S PRCHDA=$P($G(^PRCS(410,DA,10)),"^",3),PONUM=$E($P($G(^PRCS(410,DA,4)),"^",5),1,6) S:PONUM]"" PONUM=SITE_"-"_PONUM
 . ;Ceiling transactions
 . I TRANTYPE="C" D CEILING Q:'OK  S KDA=DA D KILL443(KDA),KILL410(KDA) Q
 . ;Kill temp request when request date <= date specified for temps
 . I REQID=TEMPID,(REQDATE'>TEMPDATE) S KDA=DA D KILL443(KDA),KILL410(KDA) Q
 . Q:'+REQID
 . ;Do not delete when date of request > date specified for permanent requests
 . I REQDATE>PERMDATE Q
 . ;If no date of request, use the fiscal year from the txn #
 . I '+REQDATE S REQFY=$P(REQID,"-",2),REQFY=$S(REQFY<70:3,1:2)_REQFY I REQFY>$E(PERMDATE,1,3) Q
 . ;If no reference to purchase order or if PO referenced does not exist - kill record
 . I PRCHDA]""!(PONUM]"") D  Q
 . . I PRCHDA]"",$D(^PRC(442,PRCHDA,0)) D CHKDT(REQDATE,PRCHDA) Q:'OK
 . . I PONUM]"" S X=$O(^PRC(442,"B",PONUM,0)) I +X,$D(^PRC(442,+X,0)) D CHKDT(REQDATE,+X) Q:'OK
 . . S KDA=DA D KILL443(KDA),KILL410(KDA)
 . I PRCHDA="",PONUM="" S KDA=DA D KILL443(KDA),KILL410(KDA)
 Q
443(X) ;
 N DA,BEGDA,ENDA,SITE
 D UNLOAD
 F  S DA=$O(^PRC(443,DA)) Q:'DA!(DA>ENDA)  D
 . I '$D(^PRCS(410,DA,0)) S KDA=DA D KILL443(KDA)
 Q
4101(X) ;
 N DA,BEGDA,ENDA,SITE,PERMDATE,X0,LDA
 D UNLOAD
 F  S DA=$O(^PRCS(410.1,DA)) Q:'DA!(DA>ENDA)  D
 . S X0=$G(^PRCS(410.1,DA,0)) Q:X0=""
 . Q:SITE'=$P(X0,"-")
 . S LDA=$P(X0,"^",3)
 . Q:LDA>PERMDATE
 . S DIK="^PRCS(410.1," D ^DIK
 . K DIK
 Q
UNLOAD ;
 S BEGDA=$P(X,"-",1),ENDA=+$P(X,"-",2),SITE=$P(X,";",2)
 S X=$P(X,";",3)
 I X]"" S TEMPDATE=$P(X,"-",1),PERMDATE=$P(X,"-",2)
 S DA=BEGDA-.1
 Q
CHKDT(RDATE,PODA) ;
 N PODATE
 ;Use DATE PO ASSIGNED field if defined, else use PO DATE
 S PODATE=$P($P($G(^PRC(442,PODA,12)),"^",5),".")
 I +PODATE=0 S PODATE=$P($G(^PRC(442,PODA,1)),"^",15) Q:'+PODATE
 I '+RDATE D  Q
 . I REQFY<$E(PODATE,1,3) Q
 . S OK=0
 I $E(RDATE,1,3)<$E(PODATE,1,3) Q
 S OK=0
 Q
CEILING ;
 N ALLOCDT,REQFY
 S ALLOCDT=$P($G(^PRCS(410,DA,6)),"^",2)
 I +ALLOCDT'=0,ALLOCDT>PERMDATE S OK=0 Q
 S REQFY=$P(REQID,"-",2),REQFY=$S(REQFY<70:3,1:2)_REQFY
 I REQFY>$E(PERMDATE,1,3) S OK=0 Q
 I PRCHDA]""!(PONUM]"") D
 . I PRCHDA]"",$D(^PRC(442,PRCHDA,0)) D CHKDT(ALLOCDT,PRCHDA) Q:'OK
 . I PONUM]"" S X=$O(^PRC(442,"B",PONUM,0)) I +X,$D(^PRC(442,+X,0)) D CHKDT(ALLOCDT,+X)
 Q
KILL410(DA) ;
 Q:'$D(^PRCS(410,DA,0))
 S DIK="^PRCS(410," D ^DIK
 K DIK
 D KILL4101
 Q
KILL443(DA) ;
 Q:'$D(^PRC(443,DA,0))
 S DIK="^PRC(443," D ^DIK
 K DIK
 Q
KILL4101 ;
 Q:$G(REQID)=""
 N DA,ID1,ID2,ID3,ID,LDA
 S ID1=$P(REQID,"-")_"-"_$P(REQID,"-",2)_"-"_$P(REQID,"-",4)
 S ID2=$G(PONUM)
 S ID3=REQID
 F ID=ID1,ID2,ID3 I ID'="",$D(^PRCS(410.1,"B",ID)) D
 . S DA=$O(^PRCS(410.1,"B",ID,0))
 . Q:DA=""
 . Q:'$D(^PRCS(410.1,DA,0))
 . S LDA=$P(^PRCS(410.1,DA,0),"^",3)
 . Q:LDA>PERMDATE
 . S DIK="^PRCS(410.1," D ^DIK
 . K DIK
 Q
FIND445 ;find invalid records in file 445
 S IPIEN=0
 F  S IPIEN=$O(^PRCP(445,IPIEN)) Q:IPIEN'>0  D
 .S IEN=0
 .F  S IEN=$O(^PRCP(445,IPIEN,1,IEN)) Q:IEN'>0  D
 ..Q:'$D(^PRCP(445,IPIEN,1,IEN,7))
 ..S TTLI=$P(^PRCP(445,IPIEN,1,IEN,7,0),U,4)
 ..S ITIEN=0
 ..F  S ITIEN=$O(^PRCP(445,IPIEN,1,IEN,7,ITIEN)) Q:ITIEN'>0  D
 ...I '$D(^PRCS(410,ITIEN)) D KILL445
 ..S $P(^PRCP(445,IPIEN,1,IEN,7,0),U,4)=TTLI
 ..;-leave this with zero amount don't delete? - I TTLI=0 S ^PRCP(445,IPIEN,1,IEN,7) Q
 ..Q
 .Q
 K IPIEN,IEN,ITIEN,TTLI
 Q
KILL445 ;clear the invalid records
 Q:'$D(^PRCP(445,IPIEN,1,IEN,7,ITIEN,0))
 S HLDDA=DA,DA(2)=IPIEN,DA(1)=IEN,DA=ITIEN
 S DIK="^PRCP(445,"_DA(2)_",1,"_DA(1)_",7,"
 D ^DIK
 K DIK
 S TTLI=TTLI-1
 S DA=HLDDA
 Q
