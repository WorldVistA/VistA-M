ORQPTQ4 ; slc/CLA - Extrinsic functions for patient information ;12/15/97
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 Q
DOB(DFN) ; extrinsic function to return patient date of birth:
 N VADM
 D DEM^VADPT
 Q VADM(3)
AGE(DFN) ; extrinsic function to return patient age:
 N VADM
 D DEM^VADPT
 Q VADM(4)
SEX(DFN) ; extrinsic function to return patient sex:
 N VADM
 D DEM^VADPT
 Q VADM(5)
WT(DFN) ; extrinsic function to return patient weight:
 K ^UTILITY($J,"GMRVD")
 S GMRVSTR(0)="^^^",GMRVSTR="WT"
 D EN1^GMRVUT0
 N ORT,ORD,ORY
 S ORT="",ORD=0,ORY=""
 S ORT=$O(^UTILITY($J,"GMRVD","WT",ORT)) I $L($G(ORT)) D
 .S ORD=$O(^(ORT,ORD)) I $L($G(ORD)) D
 ..S ORY=ORD_"^"_$P(^(ORD),"^",8)_"^"_$P(^(ORD),"^")
 K GMRVSTR,^UTILITY($J,"GMRVD")
 Q ORY
HT(DFN) ; extrinsic function to return patient height:
 K ^UTILITY($J,"GMRVD")
 S GMRVSTR(0)="^^^",GMRVSTR="HT"
 D EN1^GMRVUT0
 N ORT,ORD,ORY
 S ORT="",ORD=0,ORY=""
 S ORT=$O(^UTILITY($J,"GMRVD","HT",ORT)) I $L($G(ORT)) D
 .S ORD=$O(^(ORT,ORD)) I $L($G(ORD)) D
 ..S ORY=ORD_"^"_$P(^(ORD),"^",8)_"^"_$P(^(ORD),"^")
 K GMRVSTR,^UTILITY($J,"GMRVD")
 Q ORY
PRIM(DFN) ; extrinsic function to return patient primary provider
 ; based on current patient location
 N ORQPRIM
 K VAINDT S VA200=1
 D INP^VADPT ;get inpatient's primary provider
 S ORQPRIM=VAIN(2)
 K VAIN,VA200,VAERR
 Q:$L($G(ORQPRIM)) ORQPRIM
 S ORQPRIM=$$OUTPTPR^SDUTL3(DFN,"","") ;get outpatient's primary provider
 S:'$L($G(ORQPRIM)) ORQPRIM=U_"Not found"
 Q ORQPRIM
