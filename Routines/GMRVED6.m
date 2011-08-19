GMRVED6 ;HIRMFO/YH-VM EDIT FOR PATIENT ON PASS OR REFUSE ;2/7/99
 ;;4.0;Vitals/Measurements;**1,7**;Apr 25, 1997
EN1 ;
 S %=2 W !,"Do you want to enter Vitals" D YN^DICN
 I %<0 S GMROUT=1 Q
 I %=1 Q
 F GMRX=2:1:$L(GMRSTR(0),";")-1 D
 .  S GMRY=$P(GMRSTR,";",GMRX),GMRDAT(GMRY)="pass",(GMRSITE(GMRY),GMRINF(GMRY))=""
 .  Q
 S GMROUT(1)=1 Q
EN2(GRSN) ;
 N GG,I,X S GG=3,GG(1)="Unavailable",GG(2)="Pass",GG(3)="Refused"
AGAIN W !!,"*** Reason for Omission ***" F I=1:1:GG W !,I_".  "_GG(I)
 W !!,"Select a number (the reason for the data omission) or ^ to quit: "
 S X=0 R X:DTIME I '$T!(X["^") S GMROUT=1,GRSN="" Q GRSN
 I $L(X)>2 G AGAIN
 I X["?" W !,"Enter the number of reason * was entered",! G AGAIN
 I '$D(GG(+X)) G AGAIN
 S GRSN=GG(+X)
 Q GRSN
EN3 ; SELECT ROOMS ON A GIVEN WARD
 K GMRMSL
 I $D(^DG(405.4,0)) S X=0 F Y=1:0 S X=$O(^DG(405.4,"W",GMRWARD,X)) Q:X'>0  I $D(^DG(405.4,X,0)),$P($P(^(0),"^"),"-")'="" S:'$D(GMRMSL("B",$P($P(^(0),"^"),"-"))) GMRMSL(Y)=$P($P(^(0),"^"),"-"),GMRMSL("B",$P($P(^(0),"^"),"-"))="",Y=Y+1
 S GMRMSL=Y-1
S3 K I S I(1)=1,I(2)=21,I(3)=41,I(4)=61,I(5)=81 W !!,"UNIT "_GMRWARD(1)_" has the following Rooms:",!! F Y=0:0 S Y=$O(GMRMSL(Y)) Q:Y'>0!(Y'<21)  D ROOMSEL^GMRVUT3
 W !!,"Select the NUMBER(S) of the Rooms for Vital/Measurement: " R GMRRMST:DTIME W:GMRRMST="" !,"NO ROOM SELECTED",! I "^"[GMRRMST!'$T!(GMRRMST="") S GMROUT=1 Q
 I $L(GMRRMST)>20 G S3
 I GMRRMST?1"?".E W !,?5,"Type in number(s) associated with the rooms you want,",!,?5,"separated by commas or hyphens if there is more than one room",!,?5,"(e.g.,  1-3,5 would be entries 1,2,3 and 5)." G S3
 I '(GMRRMST?.N!(GMRRMST?.NP&(GMRRMST["-"!(GMRRMST[",")))) W $C(7),"  ??" G S3
 F GMRI=1:1 S GMRLEN=$P(GMRRMST,",",GMRI) Q:GMRLEN=""  S GMRLEN(1)=$P(GMRLEN,"-",2)_"+"_GMRLEN F GMRX=+GMRLEN:1:+GMRLEN(1) D RMCHK I GMROUT S GMROUT=0 G S3
 Q
RMCHK ;
 I '$D(GMRMSL(GMRX)) W !?5,$C(7),"Please select a number between 1 and ",GMRMSL S GMROUT=1 Q
 S:GMRX=+GMRX GMRROOM(GMRMSL(GMRX))=""
 Q
