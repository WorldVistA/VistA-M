PSGWEDI1 ;BHAM ISC/GRK,CML-Enter/Edit of AOU Inventory Values - CONTINUED ; 06 May 97 / 1:50 PM
 ;;2.3; Automatic Replenishment/Ward Stock ;**2,12**;4 JAN 94
EN1 ; ENTRY POINT FROM PSGWEDI
 N GOTIT
 S DIC("W")="W $P(^(0),""^"",8)"
 I $L(PSGWDRG)>1 S X=$E(PSGWDRG,2,$L(X)),DIC(0)="QEM"
 E  S DIC(0)="QEAM"
 S DIC("S")="D CHK^PSGWEDI1",DIC="^PSI(58.1,PSGWDA,1," D ^DIC
 W:('$G(GOTIT))&(+Y>0) !,"Item stocked in this AOU, but not listed on this Inventory Sheet!",! S:('$G(GOTIT))&(+Y>0) Y=-1 S DA=+Y K DIC Q:Y<0
 D ALIGN Q
 ;
 ;
ALIGN ;Align on this item
 Q:'$D(^PSI(58.1,PSGWDA,1,+Y,0))  S K=^(0) D LOC S PSGTYP=""
TYP S PSGTYP=$O(^PSI(58.19,"AINV",PSGWIDA,PSGWDA,PSG1,PSG2,PSG3,PSGTYP)) Q:PSGTYP=""
 I $D(^PSI(58.19,"AINV",PSGWIDA,PSGWDA,PSG1,PSG2,PSG3,PSGTYP,PSGDR)) S PSGDR=$E(PSGDR,1,$L(PSGDR)-1)_$E(" ",$E(PSGDR,$L(PSGDR))'=" ") Q
 E  G TYP
LOC ;Build item address
 S K1=$P(K,"^",8) F I=1:1:3 S @("PSG"_I)=$S($P(K1,",",I)]"":$P(K1,",",I),1:" ")
 S PSGDR=$S($D(^PSDRUG(+K,0))#2:$P(^(0),"^",1),1:+K)
 Q
CHK ;CHECK TO SEE IF ENTRY IS IN THE AINV X-REF
 N P1,P2,P3,P4 S GOTIT=0 D
 .S P1="" F  S P1=$O(^PSI(58.19,"AINV",PSGWIDA,PSGWDA,P1)) Q:P1=""  Q:GOTIT  D
 ..S P2="" F  S P2=$O(^PSI(58.19,"AINV",PSGWIDA,PSGWDA,P1,P2)) Q:P2=""  Q:GOTIT  D
 ...S P3="" F  S P3=$O(^PSI(58.19,"AINV",PSGWIDA,PSGWDA,P1,P2,P3)) Q:P3=""  Q:GOTIT  D
 ....S P4="" F  S P4=$O(^PSI(58.19,"AINV",PSGWIDA,PSGWDA,P1,P2,P3,P4)) Q:P4=""  I $D(^PSI(58.19,"AINV",PSGWIDA,PSGWDA,P1,P2,P3,P4,$P(^PSDRUG($P(^PSI(58.1,PSGWDA,1,+Y,0),"^"),0),"^"))) S GOTIT=1 Q
 Q
EN3 ;ENTRY POINT FROM PSGWEDI
 S (A,^(1,PSGWIDA,0))=PSGWIDA_"^"_$P(^PSI(58.1,PSGWDA,1,PSGDDA,0),"^",2)
 I '$D(^PSI(58.1,PSGWDA,1,PSGDDA,1,0)) S ^(0)="^58.12P^"_PSGWIDA_"^1"
 E  S ^(0)=$P(^PSI(58.1,PSGWDA,1,PSGDDA,1,0),"^",1,2)_"^"_$S($P(^(0),"^",3)<PSGWIDA:PSGWIDA,1:$P(^(0),"^",3))_"^"_($P(^(0),"^",4)+1)
 Q
