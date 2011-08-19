%ZTMSH ;SEA/RDS-TaskMan: Submanager, Utility (Header Page) ;3/9/92  12:01 ;
 ;;8.0;KERNEL;;JUL 10, 1995
 ;
GENERIC ;Print The Generic Header Page
 S %H=$H D YX^%DTC S ZTX=" UCI: "_ZTUCI_"  PGM: "_$S(ZTRTN["^":$P(ZTRTN,"^",2),1:ZTRTN)_"  "_Y_" ",ZTY=IOM-3\2-($L(ZTX)\2) F ZT=1:1:ZTY S ZTX="*"_ZTX_"*"
 F ZT=1:1:10 W !,ZTX
 W @IOF Q
 ;
