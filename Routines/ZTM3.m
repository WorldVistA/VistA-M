%ZTM3 ;SEA/RDS-TaskMan: Manager, Part 5 (Link Handling 2) ;22 May 2003 10:21 am
 ;;8.0;KERNEL;**275**;JUL 10, 1995
 ;
LINK ;CHECK^%ZTM/LOOKUP^%ZTM0--test dropped links for recovery
 L ^%ZTSCH("LINK") S ^%ZTSCH("LINK")=""
 S ZTDVOL=""
L0 F ZT=0:0 S ZTDVOL=$O(^%ZTSCH("LINK",ZTDVOL)) Q:ZTDVOL=""  D TEST
 I $D(^%ZTSCH("LINK"))#2,$O(^%ZTSCH("LINK",""))="" K ^%ZTSCH("LINK")
 L  K %ZTX,ZT,ZTDVOL,ZTD,ZTDTH,ZTH,ZTI,ZTM,ZTN,ZTR,ZTS,ZTSK,ZTT
 Q
 ;
TEST ;LINK--test dropped link and send tasks if restored
 S ZTI=$O(^%ZIS(14.5,"B",ZTDVOL,""))
 S ZTS=^%ZIS(14.5,ZTI,0)
 I $P(ZTS,U,3)="N" D REJECT Q
 I $P(ZTS,U,4)="Y" Q
 S ZTM=$P(ZTS,U,6)
 S ZTN=$P(ZTS,U,7)
 I ZTN S ZTNS=^%ZIS(14.5,ZTN,0),ZTN=$P(ZTNS,U)
 I ZTN="" S ZTN=ZTDVOL
 E  S ZTS=ZTNS
T1 ;
 S X="ERTEST^%ZTM3",@^%ZOSF("TRAP")
 S X=$D(^[ZTM,ZTN]%ZTSK)
 S X="",@^%ZOSF("TRAP")
 I $P(ZTS,U,10)="C" K ^%ZTSCH("LINK",ZTDVOL) Q
 D XCPU I $O(^%ZTSCH("LINK",ZTDVOL,""))="" K ^%ZTSCH("LINK",ZTDVOL)
 Q
 ;
REJECT ;TEST--reject waiting tasks whose volume set's link access is removed
 S ZTDTH=""
R3 S ZTDTH=$O(^%ZTSCH("LINK",ZTDVOL,ZTDTH)) I ZTDTH="" K ^%ZTSCH("LINK",ZTDVOL) Q
 S ZTSK=""
R4 S ZTSK=$O(^%ZTSCH("LINK",ZTDVOL,ZTDTH,ZTSK)) I ZTSK="" G R3
 K ^%ZTSCH("LINK",ZTDVOL,ZTDTH,ZTSK)
 I '$D(^%ZTSK(ZTSK)) G R4
 D TSKSTAT^%ZTM1("B","NO LINK ACCESS TO VOLUME SET")
 G R4
 ;
ERTEST ;TEST--trap if dropped link is still down
 S X="",@^%ZOSF("TRAP")
 S ^%ZTSCH("LINK")=$H
 Q
 ;
XCPU ;TEST--send saved tasks across reestablished link
 S X="ERXCPU^%ZTM3",@^%ZOSF("TRAP")
 I '$D(^[ZTM,ZTN]%ZTSCH("RUN")) S ZTT=$H G X1
 S ZTR=^[ZTM,ZTN]%ZTSCH("RUN"),ZTH=$H
 S ZTD=$P(ZTDTH,",",2)+(ZTR-ZTH*86400)+$P(ZTR,",",2)-$P(ZTH,",",2)
 S ZTT=ZTDTH+ZTR-ZTH+(ZTD\86400)-(ZTD<0)_","_$S(ZTD<0:0,1:ZTD#86400)
 ;
X1 S ZTDTH=""
X3 S ZTDTH=$O(^%ZTSCH("LINK",ZTDVOL,ZTDTH)) I ZTDTH="" Q
 S ZTSK=""
X4 S ZTSK=$O(^%ZTSCH("LINK",ZTDVOL,ZTDTH,"")) I ZTSK="" G X3
 K ^%ZTSCH("LINK",ZTDVOL,ZTDTH,ZTSK)
 I $D(^%ZTSK(ZTSK,0))[0 G X4
 I $L($P($G(^%ZTSK(ZTSK,.1)),U,10)) D TSKSTAT^%ZTM1("D","Stopped while waiting for Link") G X4
 ;
 L ^[ZTM,ZTN]%ZTSK(-1)
 S ZTS=^[ZTM,ZTN]%ZTSK(-1)+1
 F ZTI=0:0 Q:'$D(^[ZTM,ZTN]%ZTSK(ZTS))  S ZTS=ZTS+1
 S ^[ZTM,ZTN]%ZTSK(-1)=ZTS
 ;
 L (^%ZTSK(ZTSK),^[ZTM,ZTN]%ZTSK(ZTS))
 D TSKSTAT^%ZTM1(1,"Link")
 S %X="^%ZTSK(ZTSK,",%Y="^[ZTM,ZTN]%ZTSK(ZTS," D %XY^%RCR
 S $P(^[ZTM,ZTN]%ZTSK(ZTS,0),U,6)=ZTT
 S ^[ZTM,ZTN]%ZTSCH(ZTT,ZTS)=""
 ;
 K ^%ZTSK(ZTSK)
 L ^%ZTSCH("LINK")
 G X4
 ;
ERXCPU ;XCPU--trap if link drops again while a task is being sent
 S X="",@^%ZOSF("TRAP")
 I ^%ZTSCH("LINK")="" S ^("LINK")=$H
 I ZTSK]"",$D(^%ZTSK(ZTSK,0))#2 D TSKSTAT^%ZTM1("G","Link Error")
 L ^%ZTSCH("LINK")
 Q
 ;
