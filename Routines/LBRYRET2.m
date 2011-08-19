LBRYRET2 ;ISC2/DJM-RETURN FROM ROUTING NOTES ;[ 05/23/97  12:13 PM ]
 ;;2.5;Library;**2**;Mar 11, 1996
START S E=0,DIWL=1,DIWR=79,DIWF="N" K ^UTILITY($J,"W")
 S XX=$P(^LBRY(680,DA,16,0),U,3)
 F I=1:1:XX S X=^LBRY(680,DA,16,I,0) D ^DIWP
 S X=^UTILITY($J,"W",DIWL)-1,X1=0,X2=0
LOOP W @IOF,?5,"VA Library Return from Routing ** NOTES **",?60,YDT
 W !!,LA0 W:$D(LA00) !,LA00 W !! S X1=X1+X2,X2=X2+16 I X2>X S X2=X
 I X1'<X G EXIT
 F I=X1+1:1:X2 S O=^UTILITY($J,"W",DIWL,I,0) W O,!
QUERY W !!,$S(I<X:"Continue// ",1:"Exit// ")
 S DTOUT="" R Z:DTIME E  S DTOUT=1 W $C(7) G EXIT
 I I'=X,Z="" G LOOP
 I I=X,Z="" G EXIT
 I Z="^" G EXIT
 W !!,$S(I'=X:"Enter '^' to exit or <CR> to continue",1:"Enter <CR> to exit") G QUERY
EXIT K XX,^UTILITY($J,"W") Q
 Q
ASK W !!,"Enter copy number/s to return separated by commas or a hyphen."
 W !,"Copy nunber/s: EXIT// " S Q=1
ASK0 S DTOUT=0,X="" R X:DTIME E  W $C(7) S DTOUT=1 G EXIT
 I X="^" G ^LBRYRET
 I X="" G ^LBRYRET
 I X=" ",$D(^TMP("LBRY",DUZ,3)) S X=^(3)
 I X?.N D UTIL G PARSE
ASK3 S G=$P(X,",",Q) G:G="" ASK1 G:G["-" ASK4 G:G'?.N ASK2 S Q=Q+1 G ASK3
ASK1 D UTIL G PARSE
ASK2 W !!,"Please enter a copy number or a range of numbers separated by a hyphen '1-2'"
 W !,"or a combination of the two separated by a comma '1,2-4' or <CR> to EXIT."
 G ASK
ASK4 G:G'?1N.N1"-"1N.N ASK2 S Q=Q+1 G ASK3
UTIL K ^TMP("LBRY",DUZ,3) S ^(3)=X Q
PARSE F I=1:1 S G=$P(X,",",I) G:G="" FINI D:G=+G RETURN D:G["-" PARSE1
PARSE1 S G1=$P(G,"-",1),G2=$P(G,"-",2) I G2'<G1 F G=G1:1:G2 D RETURN
 Q
RETURN S NUM=$O(^LBRY(682,A(LBX),4,"B",G,0)) Q:NUM=""  L ^LBRY(682,A(LBX),4):1 Q:$T=0  S LBRYR=^LBRY(682,A(LBX),4,NUM,0) I $P(LBRYR,U,2)<3 S $P(^LBRY(682,A(LBX),4,NUM,0),U,2)=3,$P(^(0),U,5)=YDT1,$P(^(0),U,4)=DUZ
 L  Q
FINI S XZ="EXIT//" D PAUSE^LBRYCK0 K XZ
 G ^LBRYRET
