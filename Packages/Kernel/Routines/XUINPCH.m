XUINPCH ;SF/RWF - RE-INDEX NEW X-REF ON FILE 200 ;01/13/99  09:40
 ;;8.0;KERNEL;**20,36,49,63,65,69,96,91,111**;Feb. 9, 1996
 Q
POST1 ;Post init for patch XU*8*20 to reindex new X-ref on file 200.
 N XU,DA,DIK
 F XU=0:0 S XU=$O(^VA(200,XU)) Q:XU'>0  I $D(^VA(200,XU,203,0)) D
 . S DA(1)=XU,DIK="^VA(200,"_XU_",203,",DIK(1)=".01^4"
 . D ENALL^DIK
 . Q
 Q
POST14 ;Post INIT for patch XU*8*14 to seed the E-sig last changed date.
 N DA,%,%H,LT S DA=.5,%H=$H,LT=$$KSP^XUPARAM("LIFETIME")
 F  S DA=$O(^VA(200,DA)) Q:DA'>0  S %=$G(^VA(200,DA,20)) I $L(%) D
 . Q:'$L($P(%,U,4))!$P(%,U,1)
 . S $P(^VA(200,DA,20),U,1)=+$$HADD^XLFDT(%H,($R(LT)+30),0,0,0)
 . Q
 Q
 ;
POST36 ;Post INIT for patch XU*8*36
 N I,X
 ;Cleanup some old data in file 4.
 F I=0:0 S I=$O(^DIC(4,I)) Q:I'>0  I $D(^DIC(4,I,1,"B"))>2 K ^DIC(4,I,1,"B")
 ;See that we have the current ID nodes for file 200
 F I=1,2,3 S X=$T(ID200+I) I $P(X,";",3)]"" S ^DD(200,0,"ID",$P(X,";",3))=$P(X,";",4,99)
 Q
ID200 ;;
 ;;1;D EN^DDIOL("   "_$P(^(0),U,2),"","?0")
 ;;28;D:$D(^(5)) EN^DDIOL("   "_$P(^(5),U,2),"","?0")
 ;;W8;D:$P(^(0),U,9) EN^DDIOL("   "_$$EXTERNAL^DILFD(200,8,"",$P(^(0),U,9)),"","?0")
 ;
POST49 ;Post INIT for patch XU*8*49
 N I,X
 ;See that we have the current ID nodes for file 3.2 and 3.5
 F I=1:1:4 S X=$T(ID49+I) I $P(X,";",3)]"" S ^DD($P(X,";",3),0,"ID",$P(X,";",4))=$P(X,";",5,99)
 Q
ID49 ;;
 ;;3.2;W99;N % S %=$P($G(^(9)),U,1) D:$L(%) EN^DDIOL("  "_%,"",$S($S($X>30:$X,1:30)+$L(%)>76:"!?8",1:"?30"))
 ;;3.5;.02;N % S %=$P($G(^(1)),U) D:$L(%) EN^DDIOL("  "_%,"",$S($X+$L(%)>76:"!?"_(77-$L(%)),1:"?0"))
 ;;3.5;1;D EN^DDIOL("   "_$P(^(0),U,2),"","?0")
 ;;3.5;1.9;D EN^DDIOL("   "_$P(^(0),U,9),"","?0")
 ;
POST63 ;Post INIT for patch xu*8*63
 ;Move taskman screens to error message file.
 N X1,X2,X3,ZDF,ZDA,DIE,DR,DA S X1=""
 F X3=1:1 S X1=$O(^%ZTSCH("ES",X1)) Q:X1=""  D
 . S X2=$O(^%ZTER(2,"B",X1,0)) I X2 S DA=X2,DR=".03////2",DIE="3.076" D ^DIE Q
 . S ZDA="?+1,",ZDF(3.076,ZDA,.01)="LOCAL_"_X3,ZDF(3.076,ZDA,.02)="L",ZDF(3.076,ZDA,.03)=2,ZDF(3.076,ZDA,2)=X1
 . D UPDATE^DIE("","ZDF","") K ZDF Q
 . Q
 K ^%ZTSCH("ES")
 Q
 ;
POST65 ;Post INIT for patch XU*8*65
 ;Remove extra CPU field from sign-on file.
 I $D(^DD(3.081,60,0)) S DIK="^DD(3.081,",DA=60,DA(1)=3.081 D ^DIK
 Q
POST69 ;Post init for patch XU*8*69
 ;Remove extra node from Option file set by patch 49
 N DA,DIK,DF,X,Y,Z,N
 K ^DD(19,.01,7.5),^DD(19,.01,4)
 ;Delete extra data from the device file
 F DF=0:0 S DF=$O(^%ZIS(1,DF)) Q:DF'>0  S X=$G(^%ZIS(1,DF,91)),Y=+$G(^("SUBTYPE")) D
 . S Z=$G(^%ZIS(2,Y,1)),N=""
 . I X>0,$P(X,U,1,4)'=$P(Z,U,1,4) S:X>0 N=+X S:$P(X,U,3)]"" $P(N,U,3)=$P(X,U,3)
 . K ^%ZIS(1,DF,91) S:N]"" ^(91)=N
 . Q
 ;Remove fields 10 and 12 from file 3.5
 F DA=10,12 S DIK="^DD(3.5,",DA(1)=3.5 D ^DIK
 ;Remove X-ref from SUBTYPE field.
 I $D(^DD(3.5,3,1,1,0)) S DIK="^DD(3.5,3,1,",DA=1,DA(1)=3,DA(2)=3.5 D ^DIK
 ;Cleanup Resource file
 K ^%ZIS(3.54) ;Been setting wrong global
 S DA=" "
 F  S DA=$O(^%ZISL(3.54,DA),-1) Q:DA'>0  S Z=$P(^%ZISL(3.54,DA,0),U) D
 . I $D(^%ZISL(3.54,DA,1,0))#2,$P(^(0),U,2)'="3.542" S $P(^(0),U,2)=3.542
 . S Z(1)=$O(^%ZISL(3.54,"B",Z,0)) Q:Z(1)'<DA  D
 . . S DIK="^%ZISL(3.54," D ^DIK
 ;See that the FF field has data.
 S DA=0
 F  S DA=$O(^%ZIS(2,DA)) Q:DA'>0  I "PC"[$E(^(DA,0)) S Z=$G(^%ZIS(2,DA,1)) I $P(Z,U,2)="" S $P(^%ZIS(2,DA,1),U,2)="#" W !,DA
 Q
 ;
POST91 ;Fix SCR on file 3.5 for printing.
 ;;I 1 Q:$G(D)'="LSYN"  Q:'$D(^%ZOSF("VOL"))  I $P(^%ZIS(1,Y,0),U,9)=^%ZOSF("VOL")!($P(^%ZIS(1,Y,0),U,9)="")
 S ^DD(3.5,0,"SCR")=$P($T(POST91+1),";;",2,99)
 Q
POST96 ;Run the new X-ref
 N IX,DIK,DA
 F DA=0:0 S DA=$O(^DIC(4,DA)) Q:DA'>0  I '$D(^AUTTLOC(DA,0)) D
 . S DIK="^DIC(4,",DIK(1)=".01" D EN1^DIK
 . Q
 Q
POST111 ;Delete file 49 subfiles that point to file 3.
 N DIU
 I $G(^DD(49.01,0))["*" S DIU=49.01,DIU(0)="SD" D EN^DIU2
 I $G(^DD(49.02,0))["*" S DIU=49.02,DIU(0)="SD" D EN^DIU2
 Q
