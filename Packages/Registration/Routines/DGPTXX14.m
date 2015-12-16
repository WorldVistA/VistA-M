DGPTXX14 ; COMPILED XREF FOR FILE #45.05 ; 09/16/15
 ; 
 S DA=0
A1 ;
 I $D(DISET) K DIKLM S:DIKM1=1 DIKLM=1 G @DIKM1
0 ;
A S DA=$O(^DGPT(DA(1),"P",DA)) I DA'>0 S DA=0 G END
1 ;
 S DIKZ(0)=$G(^DGPT(DA(1),"P",DA,0))
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,6)
 I X'="" S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,7)
 I X'="" S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,8)
 I X'="" S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,9)
 I X'="" S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,10)
 I X'="" S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,11)
 I X'="" S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,12)
 I X'="" S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,13)
 I X'="" S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,14)
 I X'="" S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,15)
 I X'="" S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,16)
 I X'="" S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,17)
 I X'="" S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,18)
 I X'="" S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,19)
 I X'="" S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,20)
 I X'="" S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,21)
 I X'="" S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,22)
 I X'="" S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,23)
 I X'="" S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,24)
 I X'="" S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
 S DIKZ(1)=$G(^DGPT(DA(1),"P",DA,1))
 S X=$P($G(DIKZ(1)),U,1)
 I X'="" S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(1)),U,2)
 I X'="" S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(1)),U,3)
 I X'="" S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(1)),U,4)
 I X'="" S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(1)),U,5)
 I X'="" S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
CR1 S DIXR=1200
 K X
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,5)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFP^DGPTDDCR(.X,.DA,"P",1)
CR2 S DIXR=1201
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"P",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,6)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFP^DGPTDDCR(.X,.DA,"P",2)
CR3 S DIXR=1202
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"P",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,7)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFP^DGPTDDCR(.X,.DA,"P",3)
CR4 S DIXR=1203
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"P",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,8)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFP^DGPTDDCR(.X,.DA,"P",4)
CR5 S DIXR=1204
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"P",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,9)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFP^DGPTDDCR(.X,.DA,"P",5)
CR6 S DIXR=1250
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"P",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,14)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFP^DGPTDDCR(.X,.DA,"P",10)
CR7 S DIXR=1251
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"P",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,15)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFP^DGPTDDCR(.X,.DA,"P",11)
CR8 S DIXR=1252
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"P",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,16)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFP^DGPTDDCR(.X,.DA,"P",12)
CR9 S DIXR=1253
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"P",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,17)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFP^DGPTDDCR(.X,.DA,"P",13)
CR10 S DIXR=1254
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"P",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,18)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFP^DGPTDDCR(.X,.DA,"P",14)
CR11 S DIXR=1255
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"P",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,19)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFP^DGPTDDCR(.X,.DA,"P",15)
CR12 S DIXR=1256
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"P",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,20)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFP^DGPTDDCR(.X,.DA,"P",16)
CR13 S DIXR=1257
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"P",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,21)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFP^DGPTDDCR(.X,.DA,"P",17)
CR14 S DIXR=1258
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"P",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,22)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFP^DGPTDDCR(.X,.DA,"P",18)
CR15 S DIXR=1259
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"P",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,23)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFP^DGPTDDCR(.X,.DA,"P",19)
CR16 S DIXR=1260
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"P",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,24)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFP^DGPTDDCR(.X,.DA,"P",20)
CR17 S DIXR=1261
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"P",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S DIKZ(1)=$G(^DGPT(DA(1),"P",DA,1))
 S X(2)=$P(DIKZ(1),U,1)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFP^DGPTDDCR(.X,.DA,"P",21)
CR18 S DIXR=1262
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"P",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S DIKZ(1)=$G(^DGPT(DA(1),"P",DA,1))
 S X(2)=$P(DIKZ(1),U,2)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFP^DGPTDDCR(.X,.DA,"P",22)
CR19 S DIXR=1263
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"P",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S DIKZ(1)=$G(^DGPT(DA(1),"P",DA,1))
 S X(2)=$P(DIKZ(1),U,3)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFP^DGPTDDCR(.X,.DA,"P",23)
CR20 S DIXR=1264
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"P",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S DIKZ(1)=$G(^DGPT(DA(1),"P",DA,1))
 S X(2)=$P(DIKZ(1),U,4)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFP^DGPTDDCR(.X,.DA,"P",24)
CR21 S DIXR=1265
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"P",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S DIKZ(1)=$G(^DGPT(DA(1),"P",DA,1))
 S X(2)=$P(DIKZ(1),U,5)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFP^DGPTDDCR(.X,.DA,"P",25)
CR22 S DIXR=1266
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"P",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,10)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFP^DGPTDDCR(.X,.DA,"P",6)
CR23 S DIXR=1267
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"P",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,11)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFP^DGPTDDCR(.X,.DA,"P",7)
CR24 S DIXR=1268
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"P",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,12)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFP^DGPTDDCR(.X,.DA,"P",8)
CR25 S DIXR=1269
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"P",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,13)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFP^DGPTDDCR(.X,.DA,"P",9)
CR26 K X
 G:'$D(DIKLM) A Q:$D(DISET)
END G ^DGPTXX15
