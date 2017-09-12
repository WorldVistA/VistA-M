LR256 ;slc/dcm - Environment check routine for patch 256 ;4/19/00  14:35
 ;;5.2;LAB SERVICE;**256**;Sep 27, 1994
 ;
PARAM ;Install new parameter value at package level
 N PKG,PRAM,VAL
 S PKG=$O(^DIC(9.4,"C","LR",0))
 Q:'PKG
 S PRAM=$O(^XTV(8989.51,"B","LR LAB COLLECT FUTURE",0))
 Q:'PRAM
 S VAL=$O(^XTV(8989.5,"AC",PRAM,PKG_";DIC(9.4,",1,0))
 I VAL,$G(^XTV(8989.5,VAL,0)) Q
 D EN^XPAR(PKG_";DIC(9.4,",PRAM,1,7)
 Q
