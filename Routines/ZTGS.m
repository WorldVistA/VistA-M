ZTGS ;SF/RWF - GLOBAL SEARCH ;12/6/89  14:01 ;
 ;;7.3;TOOLKIT;;Apr 25, 1995
 S:'$D(DTIME) DTIME=600
A W !,"GLOBAL SEARCH",!,"Global reference: " R GREF:DTIME G QUIT:(GREF="^")!(GREF="")
 S:$E(GREF)'="^" GREF="^"_GREF S:GREF'["(" GREF=GREF_"("
 S GBL=GREF S:$E(GBL,$L(GBL))="," GBL=$E(GBL,1,$L(GBL)-1) S:$E(GBL,$L(GBL))'=")" GBL=GBL_")" S:$E(GREF,$L(GREF))=")" GREF=$E(GREF,1,$L(GREF)-1)
 S:GBL["()" GBL=$P(GBL,"()",1)_"(-9)" S GBLSTART=GBL
 I $Q(@GBL)="" W !,"Non-existing global." G A
B R !,"Search for: ",VAL:DTIME,! G QUIT:VAL="^",A:VAL="" S GBL=GBLSTART
 ;I '$D(@GBL) S X=$O(@GBL),GBL=$ZR
 I $D(@GBL)#2,@GBL[VAL W !,GBL,"=",@GBL,!
 F I=1:1 S GBL=$Q(@GBL) Q:GBL'[GREF  W:I#25=0 "." I @GBL[VAL W !,GBL,"=",@GBL,!
 G B
QUIT K GBL,GREF,VAL Q
