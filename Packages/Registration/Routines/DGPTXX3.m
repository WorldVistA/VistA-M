DGPTXX3 ; COMPILED XREF FOR FILE #45.01 ; 09/16/15
 ; 
 S DA(1)=DA S DA=0
A1 ;
 I $D(DIKILL) K DIKLM S:DIKM1=1 DIKLM=1 G @DIKM1
0 ;
 K ^DGPT(DA(1),"S","AO")
 K ^DGPT(DA(1),"S","AO")
 K ^DGPT(DA(1),"S","AO")
 K ^DGPT(DA(1),"S","AO")
 K ^DGPT(DA(1),"S","AO")
 K ^DGPT(DA(1),"S","AO")
 K ^DGPT(DA(1),"S","AO")
 K ^DGPT(DA(1),"S","AO")
 K ^DGPT(DA(1),"S","AO")
 K ^DGPT(DA(1),"S","AO")
 K ^DGPT(DA(1),"S","AO")
 K ^DGPT(DA(1),"S","AO")
 K ^DGPT(DA(1),"S","AO")
 K ^DGPT(DA(1),"S","AO")
 K ^DGPT(DA(1),"S","AO")
 K ^DGPT(DA(1),"S","AO")
 K ^DGPT(DA(1),"S","AO")
 K ^DGPT(DA(1),"S","AO")
 K ^DGPT(DA(1),"S","AO")
 K ^DGPT(DA(1),"S","AO")
 K ^DGPT(DA(1),"S","AO")
 K ^DGPT(DA(1),"S","AO")
 K ^DGPT(DA(1),"S","AO")
 K ^DGPT(DA(1),"S","AO")
 K ^DGPT(DA(1),"S","AO")
A S DA=$O(^DGPT(DA(1),"S",DA)) I DA'>0 S DA=0 G END
1 ;
CR1 S DIXR=1205
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,8)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2))=""
 . D KPTFP^DGPTDDCR(.X,.DA,"S",1)
CR2 S DIXR=1206
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,9)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2))=""
 . D KPTFP^DGPTDDCR(.X,.DA,"S",2)
CR3 S DIXR=1207
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,10)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2))=""
 . D KPTFP^DGPTDDCR(.X,.DA,"S",3)
CR4 S DIXR=1208
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,11)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2))=""
 . D KPTFP^DGPTDDCR(.X,.DA,"S",4)
CR5 S DIXR=1209
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,12)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2))=""
 . D KPTFP^DGPTDDCR(.X,.DA,"S",5)
CR6 S DIXR=1270
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,17)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2))=""
 . D KPTFP^DGPTDDCR(.X,.DA,"S",10)
CR7 S DIXR=1271
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,18)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2))=""
 . D KPTFP^DGPTDDCR(.X,.DA,"S",11)
CR8 S DIXR=1272
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,19)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2))=""
 . D KPTFP^DGPTDDCR(.X,.DA,"S",12)
CR9 S DIXR=1273
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,20)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2))=""
 . D KPTFP^DGPTDDCR(.X,.DA,"S",13)
CR10 S DIXR=1274
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,21)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2))=""
 . D KPTFP^DGPTDDCR(.X,.DA,"S",14)
CR11 S DIXR=1275
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,22)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2))=""
 . D KPTFP^DGPTDDCR(.X,.DA,"S",15)
CR12 S DIXR=1276
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,23)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2))=""
 . D KPTFP^DGPTDDCR(.X,.DA,"S",16)
CR13 S DIXR=1277
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,24)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2))=""
 . D KPTFP^DGPTDDCR(.X,.DA,"S",17)
CR14 S DIXR=1278
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,25)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2))=""
 . D KPTFP^DGPTDDCR(.X,.DA,"S",18)
CR15 S DIXR=1279
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,26)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2))=""
 . D KPTFP^DGPTDDCR(.X,.DA,"S",19)
CR16 S DIXR=1280
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,27)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2))=""
 . D KPTFP^DGPTDDCR(.X,.DA,"S",20)
CR17 S DIXR=1281
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S DIKZ(1)=$G(^DGPT(DA(1),"S",DA,1))
 S X(2)=$P(DIKZ(1),U,1)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2))=""
 . D KPTFP^DGPTDDCR(.X,.DA,"S",21)
CR18 S DIXR=1282
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S DIKZ(1)=$G(^DGPT(DA(1),"S",DA,1))
 S X(2)=$P(DIKZ(1),U,2)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2))=""
 . D KPTFP^DGPTDDCR(.X,.DA,"S",22)
CR19 S DIXR=1283
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S DIKZ(1)=$G(^DGPT(DA(1),"S",DA,1))
 S X(2)=$P(DIKZ(1),U,3)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2))=""
 . D KPTFP^DGPTDDCR(.X,.DA,"S",23)
CR20 S DIXR=1284
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S DIKZ(1)=$G(^DGPT(DA(1),"S",DA,1))
 S X(2)=$P(DIKZ(1),U,4)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2))=""
 . D KPTFP^DGPTDDCR(.X,.DA,"S",24)
CR21 S DIXR=1285
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S DIKZ(1)=$G(^DGPT(DA(1),"S",DA,1))
 S X(2)=$P(DIKZ(1),U,5)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2))=""
 . D KPTFP^DGPTDDCR(.X,.DA,"S",25)
CR22 S DIXR=1286
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,13)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2))=""
 . D KPTFP^DGPTDDCR(.X,.DA,"S",6)
CR23 S DIXR=1287
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,14)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2))=""
 . D KPTFP^DGPTDDCR(.X,.DA,"S",7)
CR24 S DIXR=1288
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,15)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2))=""
 . D KPTFP^DGPTDDCR(.X,.DA,"S",8)
CR25 S DIXR=1289
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,16)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2))=""
 . D KPTFP^DGPTDDCR(.X,.DA,"S",9)
CR26 S DIXR=1290
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,8)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . K ^DGPT(DA(1),"S","AO",X,DA)
CR27 S DIXR=1291
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,17)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . K ^DGPT(DA(1),"S","AO",X,DA)
CR28 S DIXR=1292
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,18)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . K ^DGPT(DA(1),"S","AO",X,DA)
CR29 S DIXR=1293
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,19)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . K ^DGPT(DA(1),"S","AO",X,DA)
CR30 S DIXR=1294
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,20)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . K ^DGPT(DA(1),"S","AO",X,DA)
CR31 S DIXR=1295
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,21)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . K ^DGPT(DA(1),"S","AO",X,DA)
CR32 S DIXR=1296
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,22)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . K ^DGPT(DA(1),"S","AO",X,DA)
CR33 S DIXR=1297
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,23)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . K ^DGPT(DA(1),"S","AO",X,DA)
CR34 S DIXR=1298
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,24)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . K ^DGPT(DA(1),"S","AO",X,DA)
CR35 S DIXR=1299
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,25)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . K ^DGPT(DA(1),"S","AO",X,DA)
CR36 S DIXR=1300
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,26)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . K ^DGPT(DA(1),"S","AO",X,DA)
CR37 S DIXR=1301
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,9)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . K ^DGPT(DA(1),"S","AO",X,DA)
CR38 S DIXR=1302
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,27)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . K ^DGPT(DA(1),"S","AO",X,DA)
CR39 S DIXR=1303
 K X
 S DIKZ(1)=$G(^DGPT(DA(1),"S",DA,1))
 S X(1)=$P(DIKZ(1),U,1)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . K ^DGPT(DA(1),"S","AO",X,DA)
CR40 S DIXR=1304
 K X
 S DIKZ(1)=$G(^DGPT(DA(1),"S",DA,1))
 S X(1)=$P(DIKZ(1),U,2)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . K ^DGPT(DA(1),"S","AO",X,DA)
CR41 S DIXR=1305
 K X
 S DIKZ(1)=$G(^DGPT(DA(1),"S",DA,1))
 S X(1)=$P(DIKZ(1),U,3)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . K ^DGPT(DA(1),"S","AO",X,DA)
CR42 S DIXR=1306
 K X
 S DIKZ(1)=$G(^DGPT(DA(1),"S",DA,1))
 S X(1)=$P(DIKZ(1),U,4)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . K ^DGPT(DA(1),"S","AO",X,DA)
CR43 S DIXR=1307
 K X
 S DIKZ(1)=$G(^DGPT(DA(1),"S",DA,1))
 S X(1)=$P(DIKZ(1),U,5)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . K ^DGPT(DA(1),"S","AO",X,DA)
CR44 S DIXR=1308
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,10)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . K ^DGPT(DA(1),"S","AO",X,DA)
CR45 S DIXR=1309
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,11)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . K ^DGPT(DA(1),"S","AO",X,DA)
CR46 S DIXR=1310
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,12)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . K ^DGPT(DA(1),"S","AO",X,DA)
CR47 S DIXR=1311
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,13)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . K ^DGPT(DA(1),"S","AO",X,DA)
CR48 S DIXR=1312
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,14)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . K ^DGPT(DA(1),"S","AO",X,DA)
CR49 S DIXR=1313
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,15)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . K ^DGPT(DA(1),"S","AO",X,DA)
CR50 S DIXR=1314
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"S",DA,0))
 S X(1)=$P(DIKZ(0),U,16)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . K ^DGPT(DA(1),"S","AO",X,DA)
CR51 K X
 G:'$D(DIKLM) A Q:$D(DIKILL)
END G ^DGPTXX4
