PSIVAL ;BIR/RGY,PR-ACTIVITY LOGGER ;16 OCT 92 / 11:01 AM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
ENFR ;
 S PSIVPC=2 G GET
ENTO ;
 S PSIVPC=3
GET ;
 N DFN,ON
 S (DFN,PSIVDFN)=$S(PSIVF1=55.01:DA(1),1:DA(2)),(ON,PSIVON)=$S(PSIVF1=55.01:DA,1:DA(1))
 I '$D(PSIVLN) D ENTACT S $P(^PS(55,PSIVDFN,"IV",PSIVON,"A",PSIVLN,0),"^",2,4)="E^"_$S('$D(^VA(200,DUZ,0)):"User # "_DUZ,$P(^(0),"^")]"":$P(^(0),"^"),1:"User # "_DUZ)_"^FileMan Edit (Not recommended)"
 I $D(PSIVAL(PSIVF1,PSIVF2,DA)) S PSIVFN=+PSIVAL(PSIVF1,PSIVF2,DA) G SET
 S:'$D(^PS(55,PSIVDFN,"IV",PSIVON,"A",PSIVLN,1,0)) ^(0)="^55.15^^" S PSIVFN=$P(^(0),"^",3)+1,$P(^(0),"^",3,4)=$P(^(0),"^",3)+1_"^"_($P(^(0),"^",4)+1),PSIVAL(PSIVF1,PSIVF2,DA)=PSIVFN
SET ;
 S $P(^PS(55,PSIVDFN,"IV",PSIVON,"A",PSIVLN,1,PSIVFN,0),"^")=$P(^DD(PSIVF1,PSIVF2,0),"^")
 I PSIVF1=55.01,(PSIVF2=100!(PSIVF2=.04)) S Y=^DD(55.01,PSIVF2,0),X=$P($P(";"_$P(Y,"^",3),";"_X_":",2),";")
 I PSIVF1=55.02 S X=$S(PSIVF2=.01:$S($D(^PS(52.6,X,0)):$P(^(0),"^"),1:""),1:X)_$S(PSIVF2=.01:"",1:" ("_$S($D(^PS(52.6,+^PS(55,DA(2),"IV",DA(1),"AD",DA,0),0)):$P(^(0),"^")_")",1:""))
 I PSIVF1=55.01,PSIVF2=.06 S X=$S('$D(^VA(200,+X,0)):X_";VA(200,",^(0):+^(0),1:X_";VA(200,")
 I PSIVF1=55.11 S X=$S(PSIVF2=.01:$S($D(^PS(52.7,X,0)):$P(^(0),"^"),1:"*** Undefined Solution"),1:X)_$S(PSIVF2=.01:"",1:" ("_$S($D(^PS(52.7,+^PS(55,DA(2),"IV",DA(1),"SOL",DA,0),0)):$P(^(0),"^")_")",1:""))
 I PSIVF1=55.01,(PSIVF2=.02!(PSIVF2=.03)) S Y=X X ^DD("DD") S X=Y
 I PSIVPC=2,$P(^PS(55,PSIVDFN,"IV",PSIVON,"A",PSIVLN,1,PSIVFN,0),"^",2)="" S $P(^(0),"^",2)=X,$P(^(0),"^",3)=""
 I PSIVPC=3 S $P(^PS(55,PSIVDFN,"IV",PSIVON,"A",PSIVLN,1,PSIVFN,0),"^",3)=X
 K PSIVDFN,PSIVON,PSIVFN,PSIVPC,PSIVF1,PSIVF2 Q
 ;
ENTACT ;
 N %,X,Y S:'$D(^PS(55,DFN,"IV",+ON,"A",0)) ^(0)="^55.04A^^" S PSIVLN=($P(^PS(55,DFN,"IV",+ON,"A",0),"^",3)+1),$P(^(0),"^",3)=PSIVLN,$P(^(0),"^",4)=$P(^(0),"^",4)+1
 D NOW^%DTC S ^PS(55,DFN,"IV",+ON,"A",PSIVLN,0)=PSIVLN_"^^^^"_%
 Q
