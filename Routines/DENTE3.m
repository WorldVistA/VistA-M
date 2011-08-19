DENTE3 ;ISC2/HAG-COMINATION OF ROUTINES ;10/24/90  13:56 ;
 ;;1.2;DENTAL;**11,13,19,20**;Apr 15, 1996
SRD ;RE-RELEASE A RANGE OF TREATMENT DATA
 S T1=1 R !!,"Select RELEASE DATE: ",Y:DTIME G EXIT:Y=""!(Y=U) I Y["?" S (A,Y)="" F T1=0:1 S (A,Y)=$O(^DENT(221,"AG",DENTSTA,A)) Q:Y=""  X ^DD("DD") W !,?7,Y
 D CHK G EXIT:T1=0,SRD:Y="" S X=Y,%DT="E" D ^%DT G:Y<0 SRD S N=""
 F T1=0:1 S N=$O(^DENT(221,"AG",DENTSTA,Y,N)) Q:N=""  D
 .K ^DENT(221,N,.1) S DENTPRV=$P(^DENT(221,N,0),"^",10)
 .S AG=$P(^DENT(221,N,0),"^",1) S:AG["." AG=$P(AG,".",1) S ^DENT(221,"A",DENTSTA,AG,N)="",^DENT(221,"AC",DENTSTA,AG,DENTPRV,N)="" Q
 D CHK G:T1=0 EXIT K ^DENT(221,"AG",DENTSTA,Y) X ^DD("DD") W !!,Y," station ",DENTSTA," has ",T1," treatment data entry now enabled for re-release." G SRD
CHK W:T1=0 !!,?2,"There is no released data to enable for station ",DENTSTA,"." Q
PROV ;CHECK PROVIDER STATUS
 W !! S DIC="^DENT(220.5,",DIC(0)="AELMQ",DLAYGO=220.5 D ^DIC K DLAYGO G:Y<0 EXIT S DA=+Y D LOCK^DENTE1 G:DENTL=0 PROV S DR="1;2",DIC("NO^")=1,DIE=DIC D ^DIE W ! L  G PROV
ATDEL ;DELETE SERVICE TAPE GLOBAL
 W *7,!!,"Before deleting this global, be sure that you have used the Generate Monthly",!,"Dental SERVICE Tape option to generate a tape to be mailed to the Austin, TX DPC."
 W !!,"Are you sure you want to delete the existing temporary global containing",!,"Dental SERVICE data" S %=2 D YN^DICN G ATDEL:%=0 I %'=1 W *7,!,"Nothing deleted." K % Q
 K ^UTILITY("DENTV"),% G EXIT
DPSET ;SET STATEMENT - MUMPS X-REF FOR FIELD 2 IN FILE 221
 I X="GROUP" S $P(^DENT(221,DA,0),"^",2)="000000001",$P(^(0),"^",26)=4,^DENT(221,"D","000000001",DA)="" Q
 I '$D(DENTDFN),$P(^DENT(221,DA,0),"^",4)'="" S (DFN,DENTDFN)=$P(^DENT(221,DA,0),"^",4) D DEM^VADPT S DENTSSN=$P(VADM(2),"^")
 S:$G(DENTDFN)>0 $P(^DENT(221,DA,0),"^",4)=DENTDFN,^DENT(221,"E",DENTDFN,DA)="" S:$G(DENTSSN)'="" $P(^DENT(221,DA,0),"^",2)=DENTSSN,^DENT(221,"D",DENTSSN,DA)=""
 K DENTDFN,DENTSSN,DFN D KVAR^VADPT Q
DPKILL ;KILL STATEMENT - MUMPS X-REF ON FIELD 2 IN FILE 221
 S Z=^DENT(221,DA,0),Z0=$P(Z,"^",4),Z1=$P(Z,"^",2),$P(Z,"^",2)="" S:X="GROUP" $P(Z,"^",26)="" S ^DENT(221,DA,0)=Z K:Z0'="" ^DENT(221,"E",Z0,DA) K:Z1 ^DENT(221,"D",Z1,DA) K Z,Z0,Z1 Q
STA W !! S Z1=0 G W:'$D(^DENT(225,0)) F Z3=0:1:2 S Z1=$O(^(Z1)) Q:Z1'>0  S Z2=Z1
 G:Z3=0 W I Z3>1 S DIC="^DENT(225,",DIC(0)="AEMNQ",DIC("A")="Select STATION.DIVISION: " S:$D(DENTSTA) DIC("B")=$S(DENTSTA[" ":+DENTSTA,1:DENTSTA) D ^DIC Q:Y<0  K DIC("A"),DIC("B")
 S Z=$S(Z3=1:Z2,1:+Y),DENTSTA=$P(^DENT(225,Z,0),"^") G W:DENTSTA="" S Y=1 Q
W W !!,"Stations have not been entered in the Dental Site Parameter file.",!,"You must enter a station before you can use this option" S Y=-1
EXIT K A,AG,DENTL,DR,T1,N,X,Y Q
PAT ; DENTAL PATIENT
 Q
TOO ; TOOTH PATTERN
 Q
