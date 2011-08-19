LRORDIM ;DALCIOFO/FHS - PROCESS IMMEDIATE LAB COLLECT ALLOWABLE COLLECTION TIMES ;11/24/98
 ;;5.2;LAB SERVICE;**75,201,213**;Sep 27, 1994
EN N D1 K LRCDT,LRODT,LRORDTIM
 W !!?25
 S X="NOW",%DT="ET",Z="0000"
 W @LRVIDO
 D ^%DT W "  "_$$DOW^XLFDT(Y),@LRVIDOF
 W !!
 S I=$O(^LAB(69.9,1,7,DUZ(2),0))
 I '$L(I) W !,"SERVICE NOT AVAILABLE",! G END
 S NODE=$G(^LAB(69.9,1,7,DUZ(2),0))
 I '$L(NODE) W !,"SERVICE NOT AVAILABLE ",! G END
 W !!,?25,$S('$P(NODE,U,2):"NO ",1:"")_"COLLECTION ON HOLIDAYS ",!
 F I="SUN","MON","TUE","WED","THU","FRI","SAT" D
 . I $D(^LAB(69.9,1,7,DUZ(2),I)) S X=^(I)
 . I  W !,I_" Collection Between: "
 . I  S X1=$E(Z,($L(+$P(X,U,2))+1),4)_$P(X,U,2)
 . I  S X2=$E(Z,($L(+$P(X,U,3))+1),4)_$P(X,U,3)
 . I  S X3=$E(X1,1,2)_":"_$E(X1,3,4)
 . I  S X4=$E(X2,1,2)_":"_$E(X2,3,4)
 . I  W ?30,X3_"  and  ",X4
 W !! K %DT S %DT("A")="Enter Collection Time: ",%DT="AET" D ^%DT
 G:Y<1 END I '$L($P(Y,".",2)) W !,"YOU MUST ALSO ENTER COLLECTION TIME",! G EN
 I '$P(NODE,U,2),$D(^HOLIDAY($P(Y,"."))) W $C(7),!!,"SORRY SERVICE NOT OFFERED ON "_$P($G(^($P(Y,"."),0)),U,2),! G EN
 K H,S S (LRCDT,X)=Y,M=$P(NODE,U,4),D=$$NOW^XLFDT() D DATE
 I LRCDT'>NOW1 W !!,"MUST BE "_M_" MINUTES IN THE FUTURE",!!,$C(7) G EN
 K M,S S H=$S($P(NODE,U,5):$P(NODE,U,5),1:24) D DATE I LRCDT>NOW1 W !!,"MUST BE LESS THAN "_H_" HRS IN THE FUTURE",!!,$C(7) G EN
CHK ;
 S DAY=$E($$DOW^XLFDT(LRCDT),1,3) ; Get the day of the week
 S DAY=$$UP^XLFSTR(DAY) ; Convert to all Uppercase for compatibility
 S NODE1=$G(^LAB(69.9,1,7,DUZ(2),DAY)),NOP=0,X2=$P(LRCDT,".",2),X2=X2_$E("0000",($L(X2)+1),4)
 S:'$L(NODE1)!('$P(NODE1,U)) NOP=1 I NOP=1 W !,"SERVICE NOT OFFERED ON "_DAY,!!,$C(7) G EN
 I NOP=0 S:X2<$P(NODE1,U,2)!(X2>$P(NODE1,U,3)) NOP=2 I NOP=2 D DIS1 G EN
 I 'NOP W !!?10,"DATE/TIME ACCEPTED",!!
 S LRODT=$P(LRCDT,"."),LRORDTIM=$P(LRCDT,".",2)
 K %A,%DT,%H,%T,D,D1,DAY,H,I,M,NODE,NODE1,NOP,NOW1,S,X,X2,Y,Z Q
END ;
 K LRCDT,%A,%DT,%H,%T,D,D1,DAY,H,I,M,NODE,NODE1,NOP,NOW1,S,X,X2,Y,Z Q  ;
DATE ;
 I '$G(D) Q
 S D1=+$G(D1),H=+$G(H),M=+$G(M),S=+$G(S)
 S %H=$$FMTH^XLFDT(D),%T=$P(%H,",",2),%H=$P(%H,",")
 S %H=%H+D1,%T=(%T+(H*3600)+(M*60)+S)
 S %A=%T\86400
 S:%A %H=%H+%A,%T=(%T-(86400*%A))
 S NOW1=$$HTFM^XLFDT(%H_","_%T)
 Q
DIS1 W !!!,$C(7),"SERVICE FOR ["_DAY_"] OFFERED BETWEEN "_$E(Z,($L(+$P(NODE1,U,2))+1),4)_$P(NODE1,U,2)_" AND "_$E(Z,($L(+$P(NODE1,U,3))+1),4)_$P(NODE1,U,3)_" Hrs ",! Q
 Q
