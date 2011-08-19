NURAED4 ;HIRMFO/MD/RM-DATA ENTRY FOR POSITION ;10/15/90
 ;;4.0;NURSING SERVICE;**2,7**;Apr 25, 1997
EDTADD ;
 K NURSW D GETNOD I $D(^VA(200,ID,.11)),($P(^(.11),"^",1)!($P(^(.11),"^",2)'="")!($P(^(.11),"^",3)'="")!($P(^(.11),"^",4)'="")!($P(^(.11),"^",5)'="")!($P(^(.11),"^",6)'=""))
 E  S NURSW=1 Q
 S NURSADD1=$P(^VA(200,ID,.11),"^",1),NURSADD2=$P(^(.11),"^",2),NURSADD3=$P(^(.11),"^",3),NURSCITY=$P(^(.11),"^",4),NURSZIP=$P(^(.11),"^",6),NURSTATE=$S($P(^(.11),"^",5)="":"",'$D(^DIC(5,$P(^VA(200,ID,.11),"^",5),0)):"",1:$P(^(0),"^",1))
 W !,"STREET ADDRESS: ",NURSADD1 G PRT
EDTMAIL ;
 K NURSW
 I $D(^NURSF(210,DA,15)),($P(^(15),"^",1)'=""!($P(^(15),"^",2)'="")!($P(^(15),"^",3)'="")!($P(^(15),"^",4)'="")!($P(^(15),"^",5)'="")!($P(^(15),"^",6)'=""))
 E  S NURSW=1 Q
 S NURSADD1=$P(^NURSF(210,DA,15),"^",1),NURSADD2=$P(^(15),"^",2),NURSADD3=$P(^(15),"^",3),NURSCITY=$P(^(15),"^",4),NURSZIP=$P(^(15),"^",6),NURSTATE=$S($P(^(15),"^",5)="":"",'$D(^DIC(5,$P(^NURSF(210,DA,15),"^",5),0)):"",1:$P(^(0),"^",1))
 W !,"MAILING ADDRESS: ",NURSADD1
PRT W:NURSADD2'="" !,?18,NURSADD2 W:NURSADD3'="" !,?18,NURSADD3
 W !,"CITY: ",NURSCITY,!,"STATE: ",NURSTATE,?20,"ZIP CODE: ",NURSZIP
 K NURSADD1,NURSADD2,NURSADD3,NURSCITY,NURSTATE,NURSZIP,ID
 Q
GETNOD ;OBTAIN POINTER TO VA(200
 S ID=$P(^NURSF(210,+NURSDBA,0),"^")
 Q
STST ; SET START DATE FOR POSITION DISPLAY
 W !!,"Would you like to see this employee's (C)urrent or (P)ast",!,"positions: C// " R NURLS:DTIME I '$T!(NURLS?1"^".E) S NUROUT=1 Q
 S NURLS=$S("Cc"[NURLS:"C","Pp"[NURLS:"P",1:NURLS)
 S:NURLS?1L X=$C($A(NURLS)-32) I '(NURLS="C"!(NURLS="P")) W $C(7),!!?4,"ENTER A C TO SEE CURRENT POSITIONS,",!?12,"P TO SEE PAST POSITIONS" G STST
 G:NURLS'="P" STDT
CPDS ; SELECT A DATE IF PAST SELECTED
 S %DT("A")="From what date would you like to list the positions: "
 I $D(^NURSF(210,+NURSDBA,0)),+$P(^(0),U,6) S (%DT(0),Y)=$P(^(0),U,6) D D^DIQ S:Y'="" %DT("B")=Y
 ;I X?1"?".E W $C(7),!!?4,"SELECT A DATE THAT PRECEEDS ALL POSITION START DATES IN THE DESIRED DISPLAY." G CPDS
 S %DT="AE" D ^%DT K %DT I "^"[X S NUROUT=1 Q
 I +Y'>0 W $C(7) G CPDS
STDT ; SET THE DATE
 S NURSTDT=$S(NURLS="C":DT,1:Y)
 Q
MORHELP ;
 W $C(7)
 I $O(NURSASS("")) S XQH="NURA-ASSIGNMENT SELECTION" D EN1^XQH K XQH S:$G(DIRUT) NUROUT=1
 I '$O(NURSASS("")) W !!?5,"TO ADD NEW POSITIONS ENTER THE LETTER 'N'."
 I 'NUROUT W !!,"Press return to continue or ""^"" to exit " R X:DTIME S:'$T X="^^" I X="^^"!(X=U) S NUROUT=1 Q
 Q
