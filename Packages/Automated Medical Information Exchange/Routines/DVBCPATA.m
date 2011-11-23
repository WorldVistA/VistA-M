DVBCPATA ;ALB/JLU,557/THM-ADD NEW VET TO FILE #2 ; 10/4/91  9:22 AM
 ;;2.7;AMIE;**1,23,40,42,55,77,149**;Apr 10, 1995;Build 16
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ;retrieve patient for C&P request
 ;DVBA*2.7*149 removed ability for user to add patient to File #2
 S OLDHD1=HD1,HD1="Additional Veteran Information"
 K OUT
 S DIC="^DPT(",DIC(0)="AEMQ"
 D ^DIC
 I Y<0 S OUT=1 D EXIT Q
 S DA=+Y
 ;
ADDR S DTA=^DPT(DA,0),PNAM=$P(DTA,U,1),SSN=$P(DTA,U,9),DFN=DA,CNUM=$S($D(^DPT(DFN,.31)):$P(^(.31),U,3),1:"Unknown") S:CNUM="" CNUM="Unknown"
 ;
ASK K %Y D ADDR^DVBCUTIL W !,"Is this the correct Veteran" S %=2 D YN^DICN I $D(DTOUT)!(%<0) S OUT=1 G EXIT
 I $D(%Y) I %Y["?" W !!,"Enter Y if it is the correct Veteran, N to reselect",! G ASK
 K %Y I $D(%),%'=1 D CLR G EN
 W !!
 ;
EXIT S HD1=OLDHD1 K OLDHD1,DIC,%,%Y,DTA,X,Y,DTOUT,DUOUT Q
 ;
CLR W @IOF,!?(IOM-$L(HD1)\2),HD1,!!
 Q
 ;
MPI(DVBBKMSG,DFN) ;MPI call to set ICN
 ;check to see if CIRN PD/MPI is installed
 I $D(DG20NAME) K DG20NAME
 N X S X="MPIFAPI" X ^%ZOSF("TEST") Q:'$T
 K MPIFRTN
 S MPIFS=1
 D MPIQ^MPIFAPI(DFN)
 K MPIFRTN
 Q
