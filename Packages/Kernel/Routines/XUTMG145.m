XUTMG145 ;SEA/RDS - TaskMan: Globals: Code for File 14.5 ;5/17/91  12:54 ;
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
 Q
 ;
IT01 ;input transform for field .01
 I $L(X)>30!($L(X)<2)!'(X'?1P.E) K X Q
 I $D(DA)#2,DA]"",$D(^%ZIS(14.5,DA,0))#2,$P(^(0),U)=X Q
 I $O(^%ZIS(14.5,"B",X,""))]"" K X S ZTUNIQUE=0 Q
 Q
 ;
S01 ;set statement for field .01
 N DIG,DIH,DIU,DIV,ZT,ZT1,ZTDA,ZTD0,ZTS,ZTX
 S ZTX=X,ZTDA=DA,DIH=14.6
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZIS(14.6,ZT1)) Q:ZT1=""  I $D(^%ZIS(14.6,ZT1,0))#2 S ZTS=^(0) D S01A
 S X=ZTX,DA=ZTDA Q
 ;
S01A ;S01--re-crossreference appropriate fields
 S DA=ZT1,D0=ZT1,DIV(0)=DA,DIU=ZTDA,DIV=ZTDA
 I $P(ZTS,U,5)=ZTDA S DIG=1 D ^DICR Q
 I $P(ZTS,U,6)=ZTDA S DIG=2 D ^DICR Q
 Q
 ;
