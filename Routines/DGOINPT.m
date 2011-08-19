DGOINPT ;RWA/SLC,XAK/ALBANY;ALB/MLI;ALB/REW - WARD ROSTER ; 6/11/03 12:26pm
 ;;5.3;Registration;**524**;Aug 13, 1993
 ;;MAS VERSION 5.1;
 ;
 ; DGHOW = PRIMARY SORT METHOD (W=WARD P=PROVIDER)
 ; DGPVAR= PROVIDER TYPE (P,A, OR E)
 ; VAUTW = WARD ARRAY
 ; DGSUBS= SECONDARY SORT METHOD (R=ROOM-BED N=NAME)
 ; DGDS  = DOUBLE SPACE: (1=YES 0=NO
 ; DGCYPS= # OF COPIES TO PRINT
 ; VAUTD = DIVISION VARIABLE/ARRAY
 ;
 D QUIT^DGOINPT1,LO^DGUTL
 D SETUP
 D QUIT^DGOINPT1
 Q
SETUP ;
 R !!,"Sort this report by (W)ard or (P)rovider?  WARD// ",X:DTIME I '$T!(X["^") Q
 I X="" S X="W" W X
 S Z="^WARD^PROVIDER" D IN^DGHELP
 I %=-1 W !!?3,"Enter W to sort this report of inpatients by WARD",!?6,"or P to sort the report by PROVIDER." G SETUP
 S DGHOW=X
WARD I (DGHOW="W") D ASK2^SDDIV Q:Y<0  S VAUTNI=1 D WARD^VAUTOMA Q:Y<0  G NMRM
 Q:(DGHOW'="P")
PROV W !,"Which provider? ",!!
 R "(P)rimary Care, (A)ttending, or (E)ITHER? EITHER// ",X:DTIME I '$T!(X["^") Q
 I X="" S X="E" W X
 S Z="^PRIMARY CARE^ATTENDING^EITHER" D IN^DGHELP
 I %=-1 W !!?3,"Enter P to sort this report of inpatients by PRIMARY CARE PHYSICIAN",!?9,"A to sort the report by ATTENDING PHYSICIAN, or",!?9,"E to print the report where the provider was EITHER",!?12,"Attending or Primary Care" G PROV
 S DGPVAR=X,VAUTNI=3
 S DIC="^VA(200,",VAUTSTR="provider",VAUTVB="VAUTW" D FIRST^VAUTOMA
 Q:Y<0
NMRM ;
 R !!,"Sub-sort by (N)ame of Patient or (R)oom  NAME// ",X:DTIME I '$T!(X["^") Q
 I X="" S X="N" W X
 S Z="^NAME^ROOM" D IN^DGHELP
 I %=-1 W !!,"SECONDARY SORT ORDER:",!!?3,"Enter N to sort this report of inpatients by NAME",!?6,"or R to sort the report by ROOM NUMBER.",!!?6,"Note: ROOM NUMBER = First set of numbers that appear in ROOM-BED" G NMRM
 S DGSUBS=X
DSP W !,"WOULD YOU LIKE THE INPATIENT ROSTER DOUBLE SPACED" S %=2 D YN^DICN Q:%<0  S DGDS='(%-1) I '% W !?4,"Enter 'Y'es to double space this report, 'N'o to single space" G DSP
CPYS R !,"HOW MANY COPIES OF THE INPATIENT ROSTER WOULD YOU LIKE? 1//",X:DTIME Q:X="^"!'$T  S:X="" X=1 I $S(X<1:1,X>10:1,1:0) W !,"Enter a number from 1 to 10 indicating the number of copies you want printed." G CPYS
 W !!,*7,!!,"THIS REPORT REQUIRES 132 COLUMN OUTPUT"
 S DGCPYS=X,DGPGM="ROSTER^DGOINPT1",DGVAR="VAUTD#^VAUTW#^DGPVAR^DGHOW^DGCPYS^DGDS^DGSUBS" D ZIS^DGUTQ Q:POP
 D ROSTER^DGOINPT1
 Q
