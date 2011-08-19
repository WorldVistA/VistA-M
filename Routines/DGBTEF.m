DGBTEF ;ALB/SCK - BENEFICIARY TRAVEL ENTER/EDIT CERTIFICATION FILE ; 12/8/92 03/11/93
 ;;1.0;Beneficiary Travel;**7**;September 25, 2001
CERT ;
 D QUIT S DIC="^DPT(",DIC(0)="AEQMZ" W !! D ^DIC K DIC G QUIT:Y'>0 S DFN=+Y
 G:'$O(^DGBT(392.2,"C",DFN,0)) ADD S DGBT=$O(^(0))
 S DGBT=^DGBT(392.2,DGBT,0) W !!,"Last Certification: " S VADAT("W")=+DGBT D ^VADATE W VADATE("E"),?39,"Eligible: ",$S($P(DGBT,U,3):"YES",1:"NO"),?55,"Amount Certified: ",$P(DGBT,U,4)
AE ;
 S DIR("A")="'A'DD A NEW DATE, 'E'DIT EXISTING OR 'Q'UIT: ",DIR("A",1)="",DIR("B")="ADD",DIR("?")="Q - to 'Q'uit",DIR("?",1)=""
 S DIR("?",2)="ENTER    A - to 'A'dd a new certification date",DIR("?",3)="E - to 'E'dit an existing entry for this patient"
 S DIR(0)="SAO^A:ADD;E:EDIT;Q:QUIT"
 D ^DIR K DIR Q:$D(DUOUT)!($D(DTOUT))!(Y="Q")  G EDIT:Y="E",ADD:Y="A"
 Q
ADD ;
 S DIR(0)="D^:NOW:PXR",DIR("A")="Select CERTIFICATION DATE: ",DIR("A",1)="",DIR("B")="NOW",DIR("?")="^D DHELP^DGBTEF"
 D ^DIR K DIR G QUIT:$D(DUOUT) G QUIT1:$D(DTOUT) S DGBTA=9999999.99999-(+Y),DGBTDT=+Y
 I $D(^DGBT(392.2,"C",DFN)) F I=0:0 S I=$O(^DGBT(392.2,"C",DFN,I)) Q:'I  I I[$P(DGBTA,".") W !!,"There is already a certification for " S VADAT("W")=DGBTDT D ^VADATE W VADATE("E"),".",!,"Only one certification per date is necessary." G AE
LOCK ;
 I DGBTA'["." D DHELP G:DGBTA'["." ADD
 L ^DGBT(392.2,DGBTA):1 I '$T!$D(^DGBT(392.2,DGBTA)) L  S DGBTA=DGBTA+.00001 G LOCK
 S VADAT("W")=9999999.99999-DGBTA D ^VADATE W " ",VADATE("E")
 K DD,DO S X=DGBTDT,DINUM=DGBTA,DIC="^DGBT(392.2,",DIC(0)="L",DIC("DR")="2////"_DFN D FILE^DICN K DIC("DR") L  G:Y'>0 CERT
DIE ;
 N X3 ;Clean copy used by COMMA^%DTC
 S X=$$LST^DGMTU(DFN,"",1) I $G(X),$D(^DGMT(408.31,+X,0)) S X=$P(^(0),"^",4),X2="0$" D COMMA^%DTC S DGBTMTI=X K X,X2 W !!,"REPORTED MEANS TEST INCOME: ",DGBTMTI
 ;I $D(^DG(41.3,DFN,0)),$D(^(1,0)),$D(^(2,0)) S DGBTMTD=$P(^DG(41.3,DFN,1,$P(^(1,0),"^",3),0),"^",3),X=$P(^DG(41.3,DFN,2,$P(^(2,0),"^",3),0),"^",4),X2="0$" D COMMA^%DTC S DGBTMTI=X K X,X2 W !!,"REPORTED MEANS TEST INCOME: ",DGBTMTI
 D 6^VADPT S DGBTCC=$S($D(^DIC(5,+VAPA(5),1,+VAPA(7),0)):$P(^(0),"^",3),1:""),DGBTEL=$P(VAEL(1),"^",2)
 S DA=DGBTA,DIE="^DGBT(392.2,",DIE("NO^")="12345"
 S DR=".01;4;3;5////"_DUZ_";6///"_DT_";11///^S X=VAPA(1);12///^S X=VAPA(2);13///^S X=VAPA(3);14///^S X=VAPA(4);15///"_$S(VAPA(5)]"":+VAPA(5),1:"")_";16///^S X=$P(VAPA(11),U,1);17///"_DGBTCC_";18///"_$P(VAEL(9),"^")_";19///"_DGBTEL
 D ^DIE G QUIT:$D(DTOUT) G:'$D(DA) CERT
 I $D(^DGBT(392.2,DA,0)) S X=$P(^DGBT(392.2,DA,0),U,4),X2="0$" D COMMA^%DTC S DGBTCA=X K X,X2
 I $D(^DGBT(392.2,DA,0)),$D(DGBTMTI),DGBTMTI'=DGBTCA W !!?5," * * * * Discrepancy exists in incomes reported, please verify * * * *",! S DGBTINFL=1
 G CERT
EDIT ;
 S X="",(DGBTC,DGBTCH,DGFL)=0 F I=0:0 S I=$O(^DGBT(392.2,"C",DFN,I)) Q:'I  S DGBTC=DGBTC+1,^UTILITY($J,"DGBT",DGBTC,I)=""
 I '$D(^UTILITY($J,"DGBT"))!'$D(^DGBT(392.2,"C",DFN)) W !,"There are no computer entries on file for this patient." G CERT
 F I=0:0 S I=$O(^UTILITY($J,"DGBT",I)) Q:'I!(DGBTCH)!(X["^")!(DGFL)  D
 . F J=0:0 S J=$O(^UTILITY($J,"DGBT",I,J)) Q:'J  S K=I,Y=9999999.99999-J X ^DD("DD") W !?5,I,". ",?10,$P(Y,"@") I K#5=0 D CHOZ Q:DGBTCH!(DGFL)
 G:DGFL=1 QUIT D:K#5'=0 CHOZ I DGBTCH S DGBTA=$O(^UTILITY($J,"DGBT",X,0)) G DIE
 G:'$T QUIT G AE
CHOZ ;
 S DIR("A")="Choose",DIR(0)="NO^1:"_K D ^DIR K DIR Q:$D(DIRUT)
 I Y,$D(^UTILITY($J,"DGBT",Y)) S DGBTCH=1,VADAT("W")=9999999.99999-$O(^(Y,0)) D ^VADATE W " ",VADATE("E") Q
 Q
DHELP ;
 W !!,"Enter the date of annual certification.",!,"Time is required when adding a new certification date.",!,"Future dates are not allowed.",! S X="?",%DT="ER" D ^%DT Q
QUIT1 ;
 I $D(DA) S DIK="^DGBT(392.2," D ^DIK K DIK
QUIT ;
 K ^UTILITY($J,"DGBT"),%DT,D,DA,DD,DFN,DGBT,DGBTA,DGBTC,DGBTCA,DGBTCC,DGBTCH,DGBTDT,DGBTEL,DGBTINFL,DGBTMTD,DGBTMTI,DGFL,DIC,DIE,DINUM,DO,DR,I,J,K,VA,VADAT,VADATE,VADM,VAEL,VAERR,VAPA,VAROOT,X,Y,Z Q
