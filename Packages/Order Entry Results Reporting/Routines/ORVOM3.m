ORVOM3 ; slc/dcm - Creates rtn ending in 'ONIT2' ;1/23/91  07:15
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 S DNAME=E_2,DL=0,(DH,Q)=" ;" K ^UTILITY($J) F DD=1:1 S X=$P($T(TEXT+DD),";",3,999) Q:X=""  S ^UTILITY($J,DD,0)=X,ORVROM=2
 D ZI G ^ORVOM4 ;cu
 ;
FILE ;
 S DL=0,Q="Q Q",S=" ;;"
NAME S D=$L(DH)+10,DNAME=DN_$E(DRN,2,4)
ZI ;
 I '$D(DIFROM(1)) S %H=+$H D YX^%DTC S DIFROM(1)=$E(Y,5,6)_"-"_$E(Y,1,3)_"-"_$E(Y,9,12)
2 K ^UTILITY($J,0) S ^(0,1)=DNAME_" ; ; "_DIFROM(1),^(1.1)=DILN2
 S ^UTILITY($J,0,2)=DH,^UTILITY($J,0,3)=Q F L=4:1 S DL=$O(^UTILITY($J,DL)) Q:DL=""  S ^UTILITY($J,0,L)=S_^(DL,0),D=$L(^(L))+D I D+380>DIFRM,$E(^(L),4)'="^",$E(^(L),4)'=$C(126) Q
 S DRN=DRN+1,X=DNAME X ^DD("OS",DISYS,"ZS") W !,X_" HAS BEEN FILED..." G NAME:DL>0
K K %A,%B,%C,%Z,^UTILITY($J) S DL=0 Q
 ;
TEXT ;
 ;; K ^UTILITY("ORVROM",$J),DIC
 ;; Q
 ;;DT W !
 ;; I '$D(DTIME) S DTIME=999
 ;; K %DT D NOW^%DTC S DT=X
 ;; K DIK,DIC,%I,DICS Q
 ;; ;
