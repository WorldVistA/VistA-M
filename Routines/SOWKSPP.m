SOWKSPP ;B'HAM ISC/DLR - Routine to delete duplicate entries in the SPP code field; 21 Oct 93 / 2:29 PM
 ;;3.0; Social Work ;**11**;27 Apr 93
 N XX,SP1,SP,X2,X3
 S XX=0,SP1="",SP("01")=1,SP("02")=2,SP("03")=3,SP("04")=4
 F  S XX=$O(^SOWK(650.1,XX)) Q:XX=""  D
 .S X2="" F  S X2=$O(^SOWK(650.1,XX,2,"C",X2)) Q:X2=""  D
 ..S X3="" F  S X3=$O(^SOWK(650.1,XX,2,"C",X2,X3)) Q:X3=""  D
 ...I $D(SP(X2)) I SP(X2)'=X3 W !,X2," is a duplicate code value for  ",$P(^SOWK(650.1,XX,2,X3,0),U) S DA=X3,DA(1)=XX,DR=".01;1",DIE="^SOWK(650.1,"_DA(1)_",2," D ^DIE K DA,DR,DIE,DIC
 ...I '$D(SP(X2)) S SP(X2)=X3
 Q
