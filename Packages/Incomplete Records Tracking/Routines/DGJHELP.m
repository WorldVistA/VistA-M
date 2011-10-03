DGJHELP ;ALB/MRY - EXECUTABLE ADT HELP PROMPTS ; 23 AUG 2001
 ;;1.0;Incomplete Records Tracking;;Jun 25, 2001
 ;
EN ;called from ques node on dispo multiple
 Q
UP I X'?.UNP F %=1:1:$L(X) I $E(X,%)?1L S X=$E(X,0,%-1)_$C($A(X,%)-32)_$E(X,%+1,999)
 Q
IN S %=0 D UP I X]""&(Z[(U_X)) F I=$F(Z,U_X):1 S %=$E(Z,I) Q:%=U!(%']"")  W %
 E  S %=-1
 S:'% X=$E(X,1) K Z
 Q
