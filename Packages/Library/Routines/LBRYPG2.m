LBRYPG2 ;ISC2/DJM-LIBRARY PURGE PARSING ;[ 05/23/97  12:13 PM ]
 ;;2.5;Library;**2**;Mar 11, 1996
PARSE F I=1:1 S G=$P(LBRYX,",",I) G:G="" CONT^LBRYPG D:G=+G PURGE D:G["-" PARSE1
 Q
PARSE1 S G1=$P(G,"-",1),G2=$P(G,"-",2) I G2'<G1 F G=G1:1:G2 D PURGE
 Q
PURGE I $D(A(G)) S DIK="^LBRY(682,",DA=A(G),Y=$P($G(^LBRY(682,A(G),1)),U) I Y>0 X ^DD("DD") W !,"PURGING ",Y," ISSUE." D ^DIK
 Q
ASK S LBRYX=X,Q=2 I LBRYX?.N G PARSE
ASK3 S G=$P(LBRYX,",",Q) G:G="" ASK1 G:G["-" ASK4 G:G'?.N ASK2 S Q=Q+1 G ASK3
ASK1 G PARSE
ASK2 W !!,"Please enter an ID NUM or a range of ID NUMs separated by a hyphen '1-2'"
 W !,"or a combination of the two separated by a comma '1,2-4' or <CR> to EXIT.",!
 G ASK1^LBRYPG
ASK4 G:G'?1N.N1"-"1N.N ASK2 S Q=Q+1 G ASK3
