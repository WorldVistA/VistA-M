FHREC3 ; HISC/REL - Re-cost recipes ;5/14/93  14:53 
 ;;5.5;DIETETICS;;Jan 28, 2005
A1 R !!,"Do you want to re-cost recipes? (Y/N): ",X:DTIME G:'$T!(X="^") KIL S:X="" X="?" D TR^FH I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7,"  Answer YES or NO" G A1
 G:X'?1"Y".E KIL
 W !!,"Beginning re-costing of all recipes ..." S CNT=0
 F R1=0:0 S R1=$O(^FH(114,R1)) Q:R1<1  D REC S CNT=CNT+1 W:CNT#10=0 "."
 W !!,"Done ...",! G KIL
REC S CST=0 F N=0:0 S N=$O(^FH(114,R1,"I",N)) Q:N<1  S X=^(N,0) D I1
 F N=0:0 S N=$O(^FH(114,R1,"R",N)) Q:N<1  S X=^(N,0) D R1
 S POR=$P(^FH(114,R1,0),"^",2) Q:'POR  S CST=+$J(CST/POR,0,3)
 S:CST $P(^FH(114,R1,0),"^",13)=CST Q
I1 S I2=$P(X,"^",1),AMT=$P(X,"^",2) Q:'I2  S Y0=$G(^FHING(I2,0))
 S C=$P(Y0,"^",17) Q:'C  S AMT=AMT/C
 S C=$P(Y0,"^",8) Q:'C  S AMT=AMT/C
 S C=$P(Y0,"^",9),CST=C*AMT+CST Q
R1 S R2=$P(X,"^",1),AMT=$P(X,"^",2) Q:'R2  S C=$P($G(^FH(114,R2,0)),"^",13)
 S CST=C*AMT+CST Q
KIL K AMT,C,CNT,CST,I2,N,POR,R1,R2,X,Y0 Q
