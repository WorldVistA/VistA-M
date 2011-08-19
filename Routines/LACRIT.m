LACRIT ;SLC/RWF - PRINT OUT CRITICAL VALUES AT DATA GATHER TIME ;7/20/90  07:56 ;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;;Sep 27, 1994
 S Y=$S(DPF=62.3:"Q"_LRDFN,1:"P")
 F I=1:1:TC Q:'$D(^TMP($J,I))  S X=^(I) D CK
 Q
CK S V=@TC(I,1) IF V]"",$L($P(X,U,4,5))>1,(V<$P(X,U,4))!(V>$P(X,U,5)) D TELL
 IF V]"" S X=$S($D(^TMP($J,Y,I)):^(I),1:""),^(I)=(X+V)_U_($P(X,U,2)+1)
 Q
TELL O IO::1 Q:'$T  U IO
 W !,$C(7),"*********************************************************"
 W !,$C(7)," CRITICAL VALUE ",V," ON TEST ",$P(X,U,1)," FOR ID: ",ID," (",ID,")"
 W !,$C(7),"*********************************************************"
 C IO Q
SET Q
 Q
MEAN O IO::1 Q:'$T  U IO
 S J="P" W !!!,"  AVERAGE PATIENT VALUES" D WR
 S J="Q" F LX=0:0 S J=$O(^TMP($J,J)) Q:J']"Q"  W !!!,"  AVERAGE ",$S($D(^LAB(62.3,+$P(J,"Q",2),0)):^(0),1:"UNKNOWN")," VALUES" D WR
 Q
WR W !,"TEST",?20,"# VALUES",?30,"AVERAGE"
 F I=1:1:TC W !,$P(^TMP($J,I),U,1),?20 IF $D(^TMP($J,J,I)) S X=^(I),Y=$P(X,U,2) IF Y W Y,?30,$J(X/Y,7,2)
 Q
