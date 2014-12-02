LRXREF1 ;SLC/RWA,ALB/TMK - CONTINUE BUILD X-REF FOR RE-INDEX ;09/15/2010 10:42:09
 ;;5.2;LAB SERVICE;**425**;Sep 27, 1994;Build 30
 ;
AT ;^LRO(69,"AT" CROSS REFERENCE
 I DA,DA(1),DA(2),$D(^LRO(69,DA(2),1,DA(1),2,DA,0)) D AT1
 Q
AT1 S ATX=+^LRO(69,DA(2),1,DA(1),0),ATX(1)=DA(2),ATX(2)=+^(2,DA,0)
 I $D(^LRO(69,DA(2),1,DA(1),4,1,0)) S ATX(3)=+^LRO(69,DA(2),1,DA(1),4,1,0) I ATX,ATX(1),ATX(2),ATX(3) S ^LRO(69,"AT",ATX,ATX(2),ATX(3),ATX(1))="",^(-ATX(1))=""
 K ATX
 Q
ATD ;KILL FOR ^LRO(69,"AT" CROSS REFERENCE
 I DA,DA(1),DA(2),$D(^LRO(69,DA(2),1,DA(1),2,DA,0)) S ATX=+^LRO(69,DA(2),1,DA(1),0),ATX(1)=DA(2),ATX(2)=+^(2,DA,0)
 I $D(^LRO(69,DA(2),1,DA(1),4,1,0)) S ATX(3)=+^LRO(69,DA(2),1,DA(1),4,1,0) I ATX,ATX(1),ATX(2),ATX(3) K ^LRO(69,"AT",ATX,ATX(2),ATX(3),ATX(1)),^(-ATX(1))
 K ATX
 Q
AC ;BUILD "AC" CROSS-REFERENCE IN FILE 68
 S LRTN=0,LRTEST=""
 F I=0:0 S LRTN=$O(^LRO(68,DA(2),1,DA(1),1,DA,4,LRTN)) Q:LRTN<1  S LRGTN=LRTN S:LRTEST'="" LRTEST=LRTEST_"^"_LRTN S:LRTEST="" LRTEST=LRTN
 D ^LREXPD G:'$D(LRORD) SET F I=1:1:LRTSTS S LRGTN=LRORD(I) D SET
END K LRTEST,LRTSTS,^TMP("LR",$J),LRTN,LRGTN Q
SET I $D(LRGTN) I $D(^LAB(60,LRGTN,.2)) I $P(^LAB(60,LRGTN,0),U,3)'["N" I $P(^(0),U,3)'["I" S ^LRO(68,"AC",+^LRO(68,DA(2),1,DA(1),1,DA,0),$P(^LRO(68,DA(2),1,DA(1),1,DA,3),U,5),+^LAB(60,LRGTN,.2))="" Q
 G:'$D(LRORD) END Q
AC1 ;KILL "AC" CROSS-REFERENCE IN FILE 68
 S LRTN=0,LRTEST=""
 F I=0:0 S LRTN=$O(^LRO(68,DA(2),1,DA(1),1,DA,4,LRTN)) Q:LRTN<1  S LRGTN=LRTN S:LRTEST'="" LRTEST=LRTEST_"^"_LRTN S:LRTEST="" LRTEST=LRTN
 D ^LREXPD G:'$D(LRORD) KILL F I=1:1:LRTSTS S LRGTN=LRORD(I) D KILL
 K LRTEST,LRTSTS,^TMP("LR",$J),LRTN,LRGTN Q
KILL I $D(^LAB(60,LRGTN,.2)) I $D(^LRO(68,"AC",+^LRO(68,DA(2),1,DA(1),1,DA,0),$P(^LRO(68,DA(2),1,DA(1),1,DA,3),U,5),+^LAB(60,LRGTN,.2))) K ^LRO(68,"AC",+^LRO(68,DA(2),1,DA(1),1,DA,0),$P(^LRO(68,DA(2),1,DA(1),1,DA,3),U,5),+^LAB(60,LRGTN,.2))
 Q
A65 ;Rebuild "A" x-ref in file 65 for 65.15,.08 for Re-index utility
 F LR=0:0 S LR=$O(^LRD(65,DA,15,LR)) Q:'LR  S LR(1)=$P(^(LR,0),"^",8) S:LR(1) ^LRD(65,"A",LR(1),DA)=""
 Q
A658 ;build "A" x-ref in file 65 for 65,.05 for Re-index utility
 S LR=$P(^LRD(65,DA(1),0),"^",5) S:LR ^LRD(65,"A",LR,DA(1))="" Q
C ;build "C" x-ref in file 69
 I '$D(DIU(0)) S ^LRO(69,"C",+X,DA(1),DA)="" Q
 I $D(DIU(0)),$D(^LRO(69,DA(1),1,DA,2)) S ^LRO(69,"C",+X,DA(1),DA)=""
 Q
A6599 ;Rebuild Archive "A" x-ref in file 65.9999 for 65.999915,.08 for Re-index utility
 F LR=0:0 S LR=$O(^LRD(65.9999,DA,15,LR)) Q:'LR  S LR(1)=$P(^(LR,0),"^",8) S:LR(1) ^LRD(65.9999,"A",LR(1),DA)=""
 Q
A65899 ;build Archive "A" x-ref in file 65.9999 for 65.9999,.05 for Re-index utility
 S LR=$P(^LRD(65.9999,DA(1),0),"^",5) S:LR ^LRD(65.9999,"A",LR,DA(1))="" Q
 ;
IT600101(DA,DINUM,X) ;
 ; Input Transform for Sub-File #60.01 field #.01 SITE/SPECIMEN
 ; Expects X (#61 IEN of SITE/SPECIMEN being added to the test) and DA array -- DA(1)=^LAB(60,DA(1))  DA=^LAB(60,DA(1),1,DA)
 ; Kills X if invalid selection
 ; Sets DINUM if valid selection
 N LRA
 S LRA=$P(^LAB(60,DA(1),0),U,5)
 I LRA="" K X Q
 S LRA=$O(^LAB(60,"C",LRA,0))
 I LRA'=DA(1) D EN^DDIOL("Site/specimens may only be added for "_$P(^LAB(60,LRA,0),U,1),"","!") K X Q
 ; Make sure entry from file 61 is not inactive as of the current date
 I '$$ACTV61^LRJUTL3(X,DT) D EN^DDIOL("Site/Specimen "_$P(^LAB(61,X,0),U,1)_" is inactive","","!") K X Q
 S DINUM=X
 Q
 ;
IT600301(DA,X) ;
 ; Input Transform for Sub-File #60.03 field #.01 COLLECTION SAMPLE
 ; Expects X (#62 IEN of COLLECTION SAMPLE being added to the test) and DA array -- DA(1)=^LAB(60,DA(1))  DA=^LAB(60,DA(1),1,DA)
 ; Kills X if invalid selection
 I $P(^LAB(60,DA(1),0),U,8),$O(^(3,0))>0 D EN^DDIOL("ONLY ONE UNIQUE COLLECTION SAMPLE","","?0") K X Q
 ; Make sure entry from file 62 is not inactive as of the current date
 I '$$ACTV62^LRJUTL3(X,DT) D EN^DDIOL("Collection Sample "_$P(^LAB(62,X,0),U,1)_" is inactive","","!") K X Q
 Q
 ; 
