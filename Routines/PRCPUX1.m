PRCPUX1 ;WISC/RFJ/DGL/DWA-extrinsic functions ; 7/22/99 3:08pm
 ;;5.1;IFCAP;**17**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
UNIT(INVPT,ITEMDA,DELIM) ;  unit per issue for inventory point and item
 ;  if delim delimiter : pkgmult delim units (1 per EA)
 N D,Y
 S D=$G(^PRCP(445,+INVPT,1,+ITEMDA,0)),Y=$S($P(D,"^",14):$P(D,"^",14),1:"?")_"/"_$$UNITCODE($P(D,"^",5))
 I $G(DELIM)'="" S Y=$P(Y,"/")_DELIM_$P(Y,"/",2)
 Q Y
 ;
 ;
UNITVAL(PKGMULT,UNITS,DELIM) ;  unit per issue for values passed as follows:
 N Y
 S Y=$S(PKGMULT:PKGMULT,1:"?")_"/"_$$UNITCODE(UNITS)
 I $G(DELIM)'="" S Y=$P(Y,"/")_DELIM_$P(Y,"/",2)
 Q Y
 ;
 ;
SKU(INVPT,ITEMDA) ;  get the sku for an item in the item master file
 N %
 S %=$$UNITCODE($P($G(^PRC(441,+ITEMDA,3)),"^",8)) I %["?" S %=$$UNITCODE($P($G(^PRCP(445,+INVPT,1,+ITEMDA,0)),"^",5))
 Q %
 ;
 ;
UNITCODE(UNITS) ;  get 2 character unit code from file 420.5
 N % S %=$P($G(^PRCD(420.5,+UNITS,0)),"^") S:%="" %="??"
 Q %
 ;
 ;
NSN(ITEMDA) ;  return nsn for itemda
 Q $P($G(^PRC(441,+ITEMDA,0)),"^",5)
 ;
 ;
FSC(ITEMDA) ;  return FSC as NSN for a given ITEMDA
 Q $P($G(^PRC(441,+ITEMDA,0)),"^",3)
 ;
 ;
ACCT(NSN) ;  return account code for nsn (first 4 digits)
 I $G(DT)="" Q 8
 Q $S(DT>2971000:8,NSN=6505!(NSN=6508):1,$E(NSN,1,2)=65!($E(NSN,1,2)=66):2,NSN=8975:3,$E(NSN,1,2)=89:8,$E(NSN,1,2)=91:6,1:3)
 ;
 ;
ACCT1(NSN) ;  return account code for nsn for GIP
 Q $S(NSN=6505!(NSN=6508):1,$E(NSN,1,2)=65!($E(NSN,1,2)=66):2,NSN=8975:3,$E(NSN,1,2)=89:8,$E(NSN,1,2)=91:6,1:3)
 ;
 ;
FOOD(ITEMDA) ;  return food group for itemda
 Q $P($G(^PRC(441,ITEMDA,3)),"^",7)
 ;
 ;
DESCR(INVPT,ITEMDA) ;  description from inventory point or item master file
 N Y
 S Y=$P($G(^PRCP(445,+INVPT,1,+ITEMDA,6)),"^") I Y="" S Y=$P($G(^PRC(441,+ITEMDA,0)),"^",2)
 Q Y
 ;
 ;
INVNAME(INVPT) ;  inventory point name for inventory point
 Q $P($G(^PRCP(445,+INVPT,0)),"^")
 ;
 ;
FCPDA(SITE,INVPT) ;  returns fund control point da number for site and invpt
 N Y
 S Y=$P($G(^PRC(420,+SITE,1,+$O(^PRC(420,"AE",+SITE,+INVPT,0)),0))," ") I Y'="" S Y=SITE_Y ; Multiple FCP not supported
 Q Y
 ;
 ;
VENNAME(VENDA) ;  return vendor name for da;global (445 or 440)
 I VENDA["PRC(440" Q $P($G(^PRC(440,+VENDA,0)),"^")
 I VENDA["PRCP(445" Q $$INVNAME(+VENDA)
 Q ""
 ;
 ;
VENDOR(INVPT,ITEMDA) ;  return vendor number or name
 N TYPE,X,Y
 S TYPE=$P($G(^PRCP(445,INVPT,0)),"^",3),X=$P($G(^PRCP(445,INVPT,1,ITEMDA,0)),"^",12),Y=""
 I TYPE="W" S Y=+X
 I TYPE="P" S Y=$S(X["440":+X,1:"WHSE")
 I TYPE="S" S Y=$P($$INVNAME(+X),"-",2,99)
 Q Y
