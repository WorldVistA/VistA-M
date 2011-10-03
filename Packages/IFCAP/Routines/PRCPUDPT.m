PRCPUDPT ;WISC/RFJ-distribution point selection                     ;10 Sep 93
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
TO(INVPT) ;  select the distr pt which invpt distributes stock TO
 ;  return da; 0 no item selected; ^ for ^ entered or timeout
 I '$D(^PRCP(445,+INVPT,0)) Q ""
 N %,C,DA,DIC,DISYS,DTOUT,DUOUT,I,PRCPPRIV,X,Y
 S:'$D(^PRCP(445,INVPT,2,0)) ^(0)="^445.03PA^^"
 S DIC="^PRCP(445,"_INVPT_",2,",DIC(0)="QEAM",DIC("W")="I $P($G(^PRCP(445,Y,0)),U,2)=""Y"" W ?60,""KEEP PERPETUAL INV""",DA=INVPT,PRCPPRIV=1
 W ! D ^DIC
 Q $S($G(DUOUT):"^",$G(DTOUT):"^",Y<1:0,1:+Y)
 ;
 ;
FROM(DISTRPT) ;  select the inventory pt which distrpt receives stock FROM
 ;  return da; 0 no item selected; ^ for ^ entered or timeout
 I '$D(^PRCP(445,+DISTRPT,0)) Q 0
 N %,DIC,DTOUT,DUOUT,PRCPPRIV,TYPE,X,Y
 S TYPE=$P(^PRCP(445,DISTRPT,0),"^",3)
 S DIC="^PRCP(445,",DIC(0)="QEAM",DIC("S")="I $D(^PRCP(445,+Y,2,DISTRPT)),$P(^PRCP(445,+Y,0),U,3)="_$S(TYPE="P":"""W""",TYPE="S":"""P""",1:"""""")
 S DIC("A")="Select "_$S(TYPE="P":"WAREHOUSE",TYPE="S":"PRIMARY",1:"")_" Inventory Distribution Point: ",PRCPPRIV=1
 W ! D ^DIC
 Q $S($G(DUOUT):"^",$G(DTOUT):"^",Y<1:0,1:+Y)
 ;
 ;
FROMCHEK(DISTRPT,SELECT) ;  check to see if distrpt is stocked by none
 ;  or one inventory points
 ;  pass select=1 to ask for selection if stocked by more than one
 ;  return da if stocked by one, 0 otherwise
 ;  set variable prcpfone=1 if only stocked by one inventory pt
 ;  set variable prcpfnon=1 if not stocked by any inventory pts
 K PRCPFONE,PRCPFNON
 N %,DA,X
 S X=0 F %=0:1 S X=$O(^PRCP(445,"AB",+DISTRPT,X)) Q:'X  S DA=X
 I '% S PRCPFNON=1 Q 0
 I %=1 S PRCPFONE=1 Q DA
 I 'SELECT Q 0
 Q $$FROM(DISTRPT)
 ;
 ;
SPD(DISTRPT,SELECT) ;  lookup and return only spd inventory point
 ;  distrpt=secondary invpt stocked by spd
 ;  select =ask for selection if set to 1
 N SPD
 S SPD=+$O(^PRCP(445,"ASPEC","S",0))
 I '$D(^PRCP(445,SPD,2,+DISTRPT,0)) S SPD=""
 I SPD="",SELECT Q $$FROMCHEK(DISTRPT,1)
 I SPD="" Q 0
 Q SPD
