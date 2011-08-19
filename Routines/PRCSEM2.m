PRCSEM2 ;WISC/KMB-RESET APPROPRIATION ENTRIES ; 7/23/96
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 N Z,Z1,Z2,F,F1
 S Z=0 F  S Z=$O(^PRC(420,"B",Z)) Q:Z=""  D
 .S Z1=Z_"-"_97
 .S Z2=0 F  S Z2=$O(^PRCF(421,"AJ",Z1,Z2)) Q:Z2=""  D
 ..S F=$P($G(^PRCF(421,Z2,0)),"^",16) I F'="" K ^PRCF(421,"AG",F,Z2)
 ..S F1=$$ACC(Z2) Q:F1=""  S ^PRCF(421,"AG",F1,Z2)="",$P(^PRCF(421,Z2,0),"^",16)=F1
 .. W !,Z1,"    ",Z2,"    ",F1
 ..QUIT
 .QUIT
 QUIT
 ;
ACC(A) ;GET ACC CODE
 N B,C,D,E,F,X
 S X=^PRCF(421,A,0)
 S B=$P(X,"-"),D=$P(X,"-",2),E=$P(+$P(X,"^",2)," ")
 S C=$E($P(X,"^",23),2,3) S:C="" C=97 S C=+$$YEAR^PRC0C(C)
 S F=$$ACC^PRC0C(B,E_"^"_D_"^"_C),F=B_"-"_D_"-"_$P(F,"^",11)_"-"_$P(F,"^",5)_"-"_$P(F,"^",2)
 QUIT F
