PRCP5POS ;WISC/RFJ-post init for inventory version 5                ;29 Jun 94
 ;;5.0;IFCAP;;4/21/95
 ;
 ;
START ;  start post init
 N DA,DATA,DIK,INVPT,ITEMDA,ITEMDATA,PRCPX,X
 ;  clean up due-ins and due-outs
 W !!,"Looping inventory points and items, copying due-ins/outs to new fields",!
 S INVPT=0 F  S INVPT=$O(^PRCP(445,INVPT)) Q:'INVPT  W "." S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445,INVPT,1,ITEMDA)) Q:'ITEMDA  S ITEMDATA=$G(^PRCP(445,INVPT,1,ITEMDA,0)) I ITEMDATA'="",'$D(^PRCP(445,INVPT,1,ITEMDA,"DUE")) D
 .   S ^PRCP(445,INVPT,1,ITEMDA,"DUE")=+$P(ITEMDATA,"^",8)_"^"_+$P(ITEMDATA,"^",20)
 .   S $P(^PRCP(445,INVPT,1,ITEMDA,0),"^",8)="",$P(^PRCP(445,INVPT,1,ITEMDA,0),"^",20)=""
 ;  set due-outs in secondaries to zero
 S INVPT=0 F  S INVPT=$O(^PRCP(445,INVPT)) Q:'INVPT  W "." I $P($G(^(INVPT,0)),"^",3)="S" S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445,INVPT,1,ITEMDA)) Q:'ITEMDA  I $D(^PRCP(445,INVPT,1,ITEMDA,"DUE")) S $P(^("DUE"),"^",2)=0
 ;  redirect barcode pointers
 S X=$O(^PRCT(446.6,"B","INTERMEC TRAKKER 9440",0)) I X S %=0 F  S %=$O(^PRCT(446.4,%)) Q:'%  I $D(^PRCT(446.4,%,0)) S $P(^(0),"^",9)=X
 S X=$O(^PRCT(446.6,"B","LABEL 3X1/INTERMEC 8646",0)) I X S %=0 F  S %=$O(^PRCT(446.5,%)) Q:'%  I $D(^PRCT(446.5,%,0)) S $P(^(0),"^",6)=X
 ;  change barcode routine prcpubar to prcpbalm
 S X=0 F  S X=$O(^PRCT(446.4,X)) Q:'X  S %=$P($G(^(X,0)),"^",4) I %["PRCPBAR" S $P(^PRCT(446.4,X,0),"^",4)=$S(%="EN1-PRCPBAR":"PHYSICAL-PRCPBALM",%="EN2-PRCPBAR":"USAGE-PRCPBALM",1:"")
 ;  recompile print labels
 F PRCPX="PRIMARY/SECONDARY LABEL","WAREHOUSE LABEL","TEST/LABEL 3X1","EXPENDABLE INVENTORY","RUN IRL PROGRAM" S DA=+$O(^PRCT(446.5,"B",PRCPX,0)) I $D(^PRCT(446.5,DA,0)) D
 .   I PRCPX="TEST/LABEL 3X1",'$D(^PRC(440,0)) Q
 .   D COMP^PRCTRED
 ;  clean dd's
 K ^DD(445.121,0,"ID","WRITE")
 K ^DD(445.121,0,"NM","MEMBER OF SET/PACK")
 ;  add PRCP options which were deleted from PRC
 N %,ADDOPT,DISPLAY,OPTION,PRCPOPT
 F %=1:1 S X=$P($T(OPTION+%),";",3,99) Q:X=""  S OPTION(%)=$O(^DIC(19,"B",$P(X,"^"),0)),DISPLAY(%)=$P(X,"^",2,3)
 S PRCPOPT=$O(^DIC(19,"B","PRCHPM RA MENU",0)) I PRCPOPT F ADDOPT=1 I OPTION(ADDOPT) D ADDOPT(PRCPOPT,OPTION(ADDOPT),+$P(DISPLAY(ADDOPT),"^"))
 S PRCPOPT=$O(^DIC(19,"B","PRCHUSER PPM",0)) I PRCPOPT F ADDOPT=1 I OPTION(ADDOPT) D ADDOPT(PRCPOPT,OPTION(ADDOPT),+$P(DISPLAY(ADDOPT),"^",2))
 S PRCPOPT=$O(^DIC(19,"B","PRCHUSER COORDINATOR",0)) I PRCPOPT,OPTION(2) D ADDOPT(PRCPOPT,OPTION(2),0)
 ;  run inits for list manager
 S X="PRCPL" X:$D(^%ZOSF("TEST")) ^("TEST") I $T D ^PRCPL
 S X="PRCPONIT" X:$D(^%ZOSF("TEST")) ^("TEST") I $T D ^PRCPONIT
 ;  re-index new cross-references
 S DIK="^PRCP(445,",DIK(1)=15 D ENALL^DIK
 S DIK="^PRCP(445.2,",DIK(1)=3 D ENALL^DIK
 S DIK="^PRCP(445.2,",DIK(1)=13 D ENALL^DIK
 Q
 ;
 ;
ADDOPT(V1,V2,V3) ;add option da=v2 to menu option da=v1 ; display order=v3
 ;  option is already in the menu
 I $O(^DIC(19,V1,10,"B",V2,0)) Q
 I '$D(^DIC(19,V1,0))!('$D(^DIC(19,V2,0))) Q
 N D0,DA,DD,DI,DIC,DIE,DLAYGO,DQ,DR,X,Y
 I '$D(^DIC(19,V1,10,0)) S ^(0)="^19.01PI^^"
 S DIC="^DIC(19,"_V1_",10,",DIC(0)="L",DLAYGO=19,DA(1)=V1,X=V2 S:V3 DIC("DR")="3///"_V3 D FILE^DICN
 Q
 ;
 ;
 ;;option to add ^ display order (prchpm ra menu) ^ display order (prchuser ppm)
OPTION ;;options to add to menus
 ;;PRCP PPM MENU^20^35
 ;;PRCP POSTED DIETETIC REPORT
