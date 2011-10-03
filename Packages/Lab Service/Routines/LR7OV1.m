LR7OV1 ;slc/dcm - Update Ordering Parameters ;8/11/97
 ;;5.2;LAB SERVICE;**121,187**;Sep 27, 1994
 ;
PKG() ;Package level parameters
 S X=$O(^DIC(9.4,"B","LAB SERVICE",0))_";DIC(9.4,"
 Q X
 ;
EN ;Pass Lab parameters to OE/RR
 N DATA,IFN,X
 S DATA=($P($G(^LAB(69.9,1,5)),"^",4)=1) D MON(DATA)
 S DATA=($P($G(^LAB(69.9,1,5)),"^",5)=1) D TUES(DATA)
 S DATA=($P($G(^LAB(69.9,1,5)),"^",6)=1) D WED(DATA)
 S DATA=($P($G(^LAB(69.9,1,5)),"^",7)=1) D THURS(DATA)
 S DATA=($P($G(^LAB(69.9,1,5)),"^",1)=1) D FRI(DATA)
 S DATA=($P($G(^LAB(69.9,1,5)),"^",2)=1) D SAT(DATA)
 S DATA=($P($G(^LAB(69.9,1,5)),"^",3)=1) D SUN(DATA)
 S DATA=$P($G(^LAB(69.9,1,0)),"^",10) D HOL(DATA)
 S IFN=0 F  S IFN=$O(^LAB(69.9,1,4,IFN)) Q:IFN<1  S X=^(IFN,0) D
 . S DATA=$P(X,"^"),DIV=$P(X,"^",4) D COLTIM(DIV,IFN,$P(X,"^",2))
 S IFN=0 F  S IFN=$O(^LAB(69.9,1,9,IFN)) Q:IFN<1  S X=^(IFN,0) D
 . D:$P(X,"^",2) MAXDAY($P(X,"^"),1,$P(X,"^",2))
 . D:$P(X,"^",5) URG($P(X,"^"),1,1)
 . D:$L($P(X,"^",6)) TYPE($P(X,"^"),1,$P(X,"^",6))
 S IFN=0 F  S IFN=$O(^LAB(69.9,1,2,IFN)) Q:IFN<1  S X=+^(IFN,0) D
 . D:X EXCEPTED(X,1,1)
 Q
MON(DATA) ;Collect Monday orders
 Q:'$$XPARCK^LR7OV2
 N X D PUT^XPAR($$PKG,"LR COLLECT MONDAY",1,DATA)
 Q
TUES(DATA) ;Collect Tuesday orders in
 Q:'$$XPARCK^LR7OV2
 N X D PUT^XPAR($$PKG,"LR COLLECT TUESDAY",1,DATA)
 Q
WED(DATA) ;Collect Wednesday order in
 Q:'$$XPARCK^LR7OV2
 N X D PUT^XPAR($$PKG,"LR COLLECT WEDNESDAY",1,DATA)
 Q
THURS(DATA) ;Collect Thursday order in
 Q:'$$XPARCK^LR7OV2
 N X D PUT^XPAR($$PKG,"LR COLLECT THURSDAY",1,DATA)
 Q
FRI(DATA) ;Collect Friday orders in
 Q:'$$XPARCK^LR7OV2
 N X D PUT^XPAR($$PKG,"LR COLLECT FRIDAY",1,DATA)
 Q
SAT(DATA) ;Collect Saturday orders in
 Q:'$$XPARCK^LR7OV2
 N X D PUT^XPAR($$PKG,"LR COLLECT SATURDAY",1,DATA)
 Q
SUN(DATA) ;Collect Sunday orders in
 Q:'$$XPARCK^LR7OV2
 N X D PUT^XPAR($$PKG,"LR COLLECT SUNDAY",1,DATA)
 Q
HOL(DATA) ;Ignore holidays
 Q:'$$XPARCK^LR7OV2
 N X D PUT^XPAR($$PKG,"LR IGNORE HOLIDAYS",1,DATA)
 Q
DIV(DIV) ;Division level parameters
 S X=$S(DIV:DIV,$D(DUZ(2)):DUZ(2),1:"")_";DIC(4,"
 Q X
COLTIM(DIV,ID,DATA) ;Phlebotomy collection time
 Q:'$$XPARCK^LR7OV2
 N X
 N X D PUT^XPAR($$DIV(DIV),"LR PHLEBOTOMY COLLECTION",ID,DATA)
 Q
MAXDAY(LOC,ID,DATA) ;Max days for continuous orders
 Q:'$$XPARCK^LR7OV2
 N X D PUT^XPAR($$LOC(LOC),"LR MAX DAYS CONTINUOUS",ID,DATA)
 Q
LOC(LOC) ;Location level parameters
 S X=LOC_";SC("
 Q X
 ;
EXCEPTED(LOC,ID,DATA) ;Excepted locations
 Q:'$$XPARCK^LR7OV2
 D PUT^XPAR($$LOC(LOC),"LR EXCEPTED LOCATIONS",ID,DATA)
 Q
URG(LOC,ID,DATA) ;Ask Urgency
 Q:'$$XPARCK^LR7OV2
 N X D PUT^XPAR($$LOC(LOC),"LR ASK URGENCY",ID,DATA)
 Q
TYPE(LOC,ID,DATA) ;Default Collection type for quick orders
 Q:'$$XPARCK^LR7OV2
 N X D PUT^XPAR($$LOC(LOC),"LR DEFAULT TYPE QUICK",ID,DATA)
 Q
