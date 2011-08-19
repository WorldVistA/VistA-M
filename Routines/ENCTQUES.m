ENCTQUES ;(WASH ISC)/RGY-Misc Bar Code Utilities ;11-2-89
 ;;7.0;ENGINEERING;;Aug 17, 1993
 ;Copy of PRCTQUES ;DH-WASH ISC
ENQ S QUD=$P(X,"^",2) W !!,$P(X,"^")," " W:QUD]"" QUD,"// " R QUX:DTIME W:'$T *7 S:'$T QUX="^" S:QUX="" QUX=QUD G:"^"[QUX KILL I QUX["?",$P(X,"^",6)]"" D @$P(X,"^",5,6) G ENQ
 F QUX1=1:1 Q:QUX1>$L(QUX)  I $A($E(QUX,QUX1))>96,$A($E(QUX,QUX1))<123 S QUX=$E(QUX,1,QUX1-1)_$C($A($E(QUX,QUX1))-32)_$E(QUX,QUX1+1,999)
 S QUD=";"_$P(X,"^",3)_";" G:QUD'[(";"_QUX_":") VAR S QUX1=$E(QUD,$F(QUD,QUX_":"),($F(QUD,";",$F(QUD,QUX_":"))-2)) G:QUX1[":" VAR W "    ",QUX1 G KILL
VAR F QUX1=2:1 S QUD=$P($P($P(X,"^",3),":",QUX1),";") Q:QUD=""  I $P(QUD,QUX)="" W $S($P(X,"^",2)=QUX:"   "_QUX,1:"")_$P(QUD,QUX,2,99) S QUX=$P($P($P(X,"^",3),";",QUX1-1),":") G KILL
 F QUX1=1:1 S QUD=$P($P(X,"^",4),",",QUX1) Q:QUD=""  I $P(QUD,QUX)="" W $S($P(X,"^",2)=QUX:"    "_QUX,1:"")_$P(QUD,QUX,2,99) S QUX=QUD G KILL
PAT I $P(X,"^",7)]"",@$P(X,"^",7,999) G KILL
 W *7," ???" G ENQ
KILL S X=QUX K QUX,QUX1,QUD Q
ENC ;
 S X=$P($P(";"_$P(Y,"^",3),";"_X_":",2),";") Q
ENYN S $P(X,"^",3)="1:YES;0:NO" S:$P(X,"^",6)="" $P(X,"^",5,6)="YN^ENCTMES1" G ENQ
