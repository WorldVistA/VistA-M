GMRVALL1 ;HIRMFO/YH-ENTER/EDIT V/M AND OTHER MEASUREMENTS ;2/6/99
 ;;4.0;Vitals/Measurements;**7**;Apr 25, 1997
LISTOP ;
 W !,"Select the combination of Vitals/Measurements you want to enter.",! F I=1:1:9 S X=$T(QUES+I) Q:X=""  S GMRW=$P(X,";;",2),GNNX(+GMRW)=$E(GMRW,4,99),GNNX=+GMRW W !,$P(GMRW,"^")
 Q
QUES ;
 ;;1  T^T
 ;;2  P^P
 ;;3  R^R
 ;;4  B/P^BP
 ;;5  Wt^WT
 ;;6  Ht^HT
 ;;7  Circumference/Girth^CG
 ;;8  Pulse Oximetry^PO2
 ;;9  Pain^PN
VALIDAT ;
 S GMROUT(1)=0 F GNURX(1)=1:1 S GNURX(2)=$P(GNI,",",GNURX(1)) Q:GNURX(2)=""  D VAL1
 Q
VAL1 ;
 I GNURX(2)["-" D VAL2 Q
 S:'$D(GNNX(+GNURX(2))) GMROUT(1)=1 Q:GMROUT(1)  S GSEL(GNURX(2))="" Q
VAL2 ;
 S GNURX(3)=$P(GNURX(2),"-") I GNURX(3)<1!(GNURX(3)>GNNX)!'$D(GNNX(+GNURX(3))) S GMROUT(1)=1 Q
 S GNURX(4)=$P(GNURX(2),"-",2) S:'$D(GNNX(+GNURX(4))) GMROUT(1)=1 Q:GMROUT(1)  F GNURX(5)=GNURX(3):1:GNURX(4) S:'$D(GNNX(GNURX(5))) GMROUT(1)=1 Q:GMROUT(1)  S GSEL(GNURX(5))=""
 Q 
