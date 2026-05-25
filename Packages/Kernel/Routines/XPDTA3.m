XPDTA3 ;OAK/BT -  Build Component ; Sep 23, 2024@09:58:21
 ;;8.0;KERNEL;**802**;Jul 10, 1995;Build 3
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
WEBAPP ;Web Server Application #18.12
 N %,%1,%2
 ;Loop thru WEB SERVICEs
 S %1=0 F  S %1=$O(^XTMP("XPDT",XPDA,"KRN",18.12,DA,100,%1)) Q:'%1  D
 . S %=$G(^(%1,0)),%2=$P(%,U)
 . I $G(%2)'="" S $P(%,U)=$P($G(^XOB(18.02,%2,0)),U),^XTMP("XPDT",XPDA,"KRN",18.12,DA,100,%1,0)=%
 Q
 ;
WEBE ;
 S ^TMP($J,"XPDI",DA)=$G(XPDFL)
 Q
 ;
WEBE0 ;
 N %,%1,%2,%I
 S (%1,%I)=0
 K ^XTMP("XPDI",XPDA,"KRN",18.12,OLDA,100,"B")
 K ^XOB(18.12,DA,100)
 F  S %1=$O(^XTMP("XPDI",XPDA,"KRN",18.12,OLDA,100,%1)) Q:%1'>0  D
 . S %=$G(^XTMP("XPDI",XPDA,"KRN",18.12,OLDA,100,%1,0)),%2=$P(%,U)
 . I $G(%2)="" Q
 . S %2=$O(^XOB(18.02,"B",%2,0))
 . I +%2'>0 Q
 . S $P(^XTMP("XPDI",XPDA,"KRN",18.12,OLDA,100,%1,0),U)=+%2
 . S ^XTMP("XPDI",XPDA,"KRN",18.12,OLDA,100,"B",+%2,%1)=""
 . Q
 Q
 ;
WEBE1 ;
 Q
 ;
WEBE2 ;
 Q
 ;
WEBDEL(%XOB) ;del Web Server
 D DELIEN^XPDUTL1(18.12,$G(%XOB))
 Q
