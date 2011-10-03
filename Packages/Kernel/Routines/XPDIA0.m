XPDIA0 ;SFISC/RSD - Cont. of XPDIA ;03/09/2000  06:50
 ;;8.0;KERNEL;**131,144**;Jul 10, 1995
 Q
PROE1 ;protocols entry pre
 N %,I
 S ^TMP($J,"XPD",DA)=XPDFL
 ;if Event Driver, subscriber multiple is on node 775
 I $P(^XTMP("XPDI",XPDA,"KRN",101,OLDA,0),U,4)="E" D
 . Q:$D(^XTMP("XPDI",XPDA,"KRN",101,OLDA,775))
 . ;pre patch HL*1.6*57, convert menu multiple to subscriber
 . M ^XTMP("XPDI",XPDA,"KRN",101,OLDA,775)=^XTMP("XPDI",XPDA,"KRN",101,OLDA,10)
 . K ^XTMP("XPDI",XPDA,"KRN",101,OLDA,10)
 ;if Menu linking or merge save menu and subscriber mult. and process in FPOS code
 I XPDFL>1 D
 . M ^TMP($J,"XPD",DA,775)=^XTMP("XPDI",XPDA,"KRN",101,OLDA,775),^TMP($J,"XPD",DA,10)=^XTMP("XPDI",XPDA,"KRN",101,OLDA,10)
 . K ^XTMP("XPDI",XPDA,"KRN",101,OLDA,775),^(10)
 ;if Menu link, XPDQUIT prevents data merge
 I XPDFL=2 S XPDQUIT=1 Q
 ;if this is new to the site then disable and quit
 I $G(XPDNEW) D:XPDSET  Q
 .;quit if option already has out of order msg.
 .Q:$P(^XTMP("XPDI",XPDA,"KRN",101,OLDA,0),U,3)]""
 .S $P(^XTMP("XPDI",XPDA,"KRN",101,OLDA,0),U,3)=$P(XPDSET,U,3)
 .D ADD^XQOO1($P(XPDSET,U,2),101,DA)
 S I=^XTMP("XPDI",XPDA,"KRN",101,OLDA,0),%=^ORD(101,DA,0)
 ;$P(%,U,3)=disable message,
 S:$P(I,U,3)]"" $P(I,U,3)=$P(%,U,3)
 ;if there is no new Security Key, save the old Key
 S:$P(I,U,6)="" $P(I,U,6)=$P(%,U,6)
 S ^XTMP("XPDI",XPDA,"KRN",101,OLDA,0)=I
 ;if there is a new Description, kill the old Description
 K:$O(^XTMP("XPDI",XPDA,"KRN",101,OLDA,1,0)) ^ORD(101,DA,1)
 ;kill old ACCESS multiple
 K ^ORD(101,DA,3) S I=0
 ;XPDFL=3-merge menu items, Quit
 ;the new menu items have already been saved into ^TMP, will restore in
 ;the file post action as a relink
 Q:XPDFL=3
 ;we are replacing menu items, kill the old.
 ;loop thru and kill "AD" and "AB" x-ref., it will be reset with new options
 F  S I=$O(^ORD(101,DA,10,I)) Q:'I  S %=+$G(^(I,0)) K:% ^ORD(101,"AD",%,DA,I)
 F  S I=$O(^ORD(101,DA,775,I)) Q:'I  S %=+$G(^(I,0)) K:% ^ORD(101,"AB",%,DA,I)
 K ^ORD(101,DA,10),^ORD(101,DA,775)
 Q
