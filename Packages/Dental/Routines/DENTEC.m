DENTEC ;ISC2/SAW,NCA-TREATMENT DATA VALIDITY CHECKS ; 12/5/88  4:45 PM ;
 ;;1.2;DENTAL;**23**;Oct 08, 1992
 G:'$D(^DENT(221,DA,0)) EXIT1 S G=^DENT(221,DA,0),X=$P(G,"^",19),E="",M="ERROR-- "
 I X="" S E=1 W !,M,"Patient category is missing." G N
 I X<8&(X'=4)&(X'=5)&($P(G,"^",6)="") S E=1 W !,M,"Bed section is missing."
 I $P(G,"^",6)'="" I X>8!(X=4)!(X=5) S E=1 W !,M,"Bed section must be blank if patient category is OPT, NHC or DOM."
 I $P(G,"^",27)!($P(G,"^",44)) I X>17!(X<9) S E=1 W !,M,"Patient category must be Class I-VI (9-17) for spot check/pre-auth exam."
 I X=7!(X=8)!(X=21)!(X=22) I $P(G,"^",7)="S"!($P(G,"^",15))!($P(G,"^",16))!($P(G,"^",17))!($P(G,"^",18))!($P(G,"^",42))!($P(G,"^",43)) S E=1 W !,M,"Patient category and type of service code are incompatible."
 I $P(G,"^",43),$P(G,"^",7)]"" S E=1 W !,M,"You are not allowed to mark both the screening/complete and evaluation fields."
N I $P(G,"^",12)'=""!($P(G,"^",13)'="") I $P(G,"^",26)'="" S E=1 W !,M,"Patient education must be blank if prophy is marked."
 I $P(G,"^",24)'=""&($P(G,"^",25)'="") W !,"WARNING - Both perio and quad fields have been marked, please verify."
 I ($P(G,"^",30)=""&($P(G,"^",31)'=""))!($P(G,"^",31)=""&($P(G,"^",30)'="")) S E=1 W !,M,"Only one fixed partial field is marked.  Both must be marked or blank."
 I $P(G,"^",39)="" S E=1 W !,M,"Dental patient is missing."
 I '$P(G,"^",3) S E=1 W !,M,"Dental provider is missing." G EXIT
 I $P(G,"^",14) I $E($P(G,"^",10),1)'<3 S E=1 W !,M,"Operating room can only be marked if the provider is a staff dentist."
EXIT I E,X="" W *7,!!,"Would you like to delete this entire treatment data entry" S %=2 D YN^DICN D:%=0 Q1 G EXIT:%=0 I %=1 S DIK="^DENT(221," D ^DIK W !,"Entry deleted." G EXIT1
 I E W *7,!!,"You must correct the above error(s) before continuing.",!,"Press return when you are ready to re-edit this treatment data entry." R X:DTIME I $D(DENTFUL) S DJDN=DENTDA,DJSC=DENTSC D EN^DENTD S DA=DENTDA G DENTEC
 I E S DIE="^DENT(221,",DA=DENTDA,DR=DENTDR D ^DIE G:'$D(DA) EXIT1 G DENTEC
EXIT1 K DENTZ3,DIK,E,G,M,RELDT,X Q
Q1 W !!,"Enter 'Y' or 'Yes' to delete this treatment data entry.  Press return or",!,"enter 'N' or 'No' if you do not want to delete this treatment data entry.",!,"Uparrow (^) is not allowed." Q
