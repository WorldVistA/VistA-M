PRCPENU1 ;WISC/RFJ-utility for distribution point edit              ;06 Jan 94
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
DELETE(INVPT,DISTRPT) ;  delete distrpt from invpt
 I '$D(^PRCP(445,+INVPT,2,+DISTRPT)) Q
 N DA,DIC,DIK
 S DIK="^PRCP(445,"_(+INVPT)_",2,",DA(1)=+INVPT,DA=+DISTRPT
 D ^DIK
 Q
 ;
 ;
ADD(INVPT,DISTRPT) ;  add distrpt for invpt
 I '$D(^PRCP(445,+INVPT,0)) Q
 I '$D(^PRCP(445,+DISTRPT,0)) Q
 N D0,DA,DD,DIC,DINUM,DLAYGO,X,Y
 I '$D(^PRCP(445,+INVPT,2,0)) S ^(0)="^445.03PA^^"
 S DIC="^PRCP(445,"_(+INVPT)_",2,",DIC(0)="L",DLAYGO=445,DA(1)=+INVPT,(X,DINUM)=+DISTRPT,PRCPPRIV=1
 D FILE^DICN K PRCPPRIV
 I Y<1 W !,"  UNABLE TO ADD INVENTORY POINT AS A WAREHOUSE DISTRIBUTION POINT."
 Q
