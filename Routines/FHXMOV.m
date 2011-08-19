FHXMOV ; HISC/NCA - Process Annual Report Movement ;4/8/94  09:03
 ;;5.5;DIETETICS;;Jan 28, 2005
EN1 ; Move Data for Facility Profile in all four qtrs
 W !!,"Annual Report Data Conversion"
 K FHN F PRE=0:0 S PRE=$O(^FH(117.3,PRE)) Q:PRE<1  S STG=$G(^(PRE,0)),STG1=$G(^(1)),STG2=$G(^(3)) D MOV
 F FNOD=0:0 S FNOD=$O(FHN(FNOD)) Q:FNOD<1  F QTR=1:1:4 S PRE=FNOD_QTR_"00",STG=$G(^FH(117.3,PRE,0)),STG1=$G(^FH(117.3,PRE,1)),STG2=$G(^FH(117.3,PRE,3)) D CHK
 W !!,"Removal of Dietetic Survey Entries"
 K DA,DIK,DIU S DIU=117.334,DIU(0)="SD" D EN^DIU2 S DIK="^DD(117.3,",DA(1)=117.3,DA=34 D ^DIK
 K DA,DIK,DIU S DIU=117.335,DIU(0)="SD" D EN^DIU2 S DIK="^DD(117.3,",DA(1)=117.3,DA=35 D ^DIK
 K DA,DIK,DIU S DIU=117.336,DIU(0)="SD" D EN^DIU2 S DIK="^DD(117.3,",DA(1)=117.3,DA=36 D ^DIK
 K DA,DIK,DIU S DIU=117.337,DIU(0)="SD" D EN^DIU2 S DIK="^DD(117.3,",DA(1)=117.3,DA=37 D ^DIK
 K %,%H,%I,%T,DA,DIK,DIU,FHN,FNOD,I,J,K2,K3,LP,LST,PRE,STG,STG1,STG2,STR,TIT,TRN,QTR,X,XX,Z,Z1,ZZ Q
MOV ; Process Moving Data
 S FNOD=$E(PRE,1,4)
 I "^^^^^^^^^^"'[$P(STG,"^",2,12) S FHN(FNOD,1)=STG
 I "^^"'[$P(STG,"^",14,16) S FHN(FNOD,2)=$P(STG,"^",14,16)
 I "^^^"'[$P(STG1,"^",14,17) S FHN(FNOD,3)=$P(STG1,"^",14,17)
 I "^^^^^^"'[$P(STG2,"^",2,8) S FHN(FNOD,4)=$P(STG2,"^",2,8)
 I $P(STG2,"^",1)'="" S FHN(FNOD,5)=$P(STG2,"^",1)
 F TIT="AREA","DELV","EQUI","SPEC" D
 .I $O(^FH(117.3,PRE,TIT,0))>0 D
 ..I $O(FHN(FNOD,TIT,0))>0 K FHN(FNOD,TIT)
 ..S STR="" F K2=0:0 S K2=$O(^FH(117.3,PRE,TIT,K2)) Q:K2<1  S STR=$G(^(K2,0)),FHN(FNOD,TIT,K2)=STR
 ..Q
 .Q
 F LST="SURV1","TEMP" D
 .S TRN=$S(LST="SURV1":"OVA",1:"TEM")
 .Q:'$D(^FH(117.3,PRE,LST,0))
 .F LP=0:0 S LP=$O(^FH(117.3,PRE,LST,LP)) Q:LP<1  S ZZ=$P($G(^(LP,0)),"^",2,25) I "^^^^^^^^^^^^^^^^^^^^^^^"'[ZZ D
 ..I '$D(^FH(117.3,PRE,TRN,0)) S ^FH(117.3,PRE,TRN,0)=$S(TRN="TEM":"^117.31^^",1:"^117.366^^")
 ..S XX=$TR(ZZ,"^"," "),J=1,Z1=""
 ..F I=1:1:6 S:Z1'="" Z1=Z1_"^" S Z1=Z1_$S($P(XX," ",J):"V"_$P(XX," ",J),1:"")_$S($P(XX," ",J+1):" G"_$P(XX," ",J+1),1:"")_$S($P(XX," ",J+2):" F"_$P(XX," ",J+2),1:"")_$S($P(XX," ",J+3):" P"_$P(XX," ",J+3),1:"") S J=J+4
 ..Q:$D(^FH(117.3,PRE,TRN,LP,0))
 ..S Z=$G(^FH(117.3,PRE,TRN,0))
 ..S $P(^FH(117.3,PRE,TRN,0),"^",3,4)=LP_"^"_($P(Z,"^",4)+1)
 ..S ^FH(117.3,PRE,TRN,LP,0)=LP_"^"_Z1,^FH(117.3,PRE,TRN,"B",LP,LP)=""
 ..Q
 .Q
 Q
CHK ; Check to store Data Moved
 I STG="" S $P(^FH(117.3,PRE,0),"^",1)=PRE,^FH(117.3,"B",PRE,PRE)="",Z=$G(^FH(117.3,0)),$P(^FH(117.3,0),"^",3,4)=PRE_"^"_($P(Z,"^",4)+1),$P(^FH(117.3,PRE,0),"^",2,26)=$P($G(FHN(FNOD,1)),"^",2,26)
 I "^^"[$P(STG,"^",14,16) S $P(^FH(117.3,PRE,0),"^",14,16)=$G(FHN(FNOD,2))
 I "^^^"[$P(STG1,"^",14,17) S $P(^FH(117.3,PRE,1),"^",14,17)=$G(FHN(FNOD,3))
 I "^^^^^^"[$P(STG2,"^",2,8) S $P(^FH(117.3,PRE,3),"^",2,8)=$G(FHN(FNOD,4))
 I $P(STG2,"^",1)="" S $P(^FH(117.3,PRE,3),"^",1)=$G(FHN(FNOD,5))
 F TIT="AREA","DELV","EQUI","SPEC" D
 .I $O(^FH(117.3,PRE,TIT,0))<1,$O(FHN(FNOD,TIT,0))>0 D
 ..I '$D(^FH(117.3,PRE,TIT,0)) S ^FH(117.3,PRE,TIT,0)=$S(TIT="AREA":"^117.356S^^",TIT="DELV":"^117.313P^^",TIT="EQUI":"^117.338P^^",1:"^117.312P^^")
 ..F K2=0:0 S K2=$O(FHN(FNOD,TIT,K2)) Q:K2<1  S K3=$G(FHN(FNOD,TIT,K2)) D
 ...S ^FH(117.3,PRE,TIT,K2,0)=K3,^FH(117.3,PRE,TIT,"B",+K3,K2)="",Z=$G(^FH(117.3,PRE,TIT,0))
 ...S $P(^FH(117.3,PRE,TIT,0),"^",3,4)=K2_"^"_($P(Z,"^",4)+1)
 ...Q
 ..Q
 .Q
 Q
