%INDX52 ;SF-ISC/RWF - Add to list other routines called ;11/29/93  12:27 ;
 ;;7.3;TOOLKIT;;Apr 25, 1995
L1 S RTN="$",INDLC=0
 F I=0:0 S RTN=$O(^UTILITY($J,1,RTN)) Q:RTN=""  I '$D(^(RTN,52)) S ^(52)=1,S="$" F J=0:0 S S=$O(^UTILITY($J,1,RTN,"X",S)) Q:S=""  D L21
 S RTN="$",F52=0
 F I52=0:0 S RTN=$O(^UTILITY($J,RTN)) Q:RTN=""  I RTN'=1,'$D(^UTILITY($J,1,RTN)) D LOAD^%INDEX,BEG^%INDEX S F52=1
 G L1:F52
 K I52,F52 Q
L21 S X=$P(S," ") Q:$E(X)="%"  Q:$D(^UTILITY($J,1,X))  Q:"DD^DI^XM"[$E(X,1,2)  Q:"XQ^XQ1^XUS^"[$E(X,1,8)
 X ^%ZOSF("TEST") Q:'$T  ;I '$T S LAB=$P(^UTILITY($J,1,RTN,"X",S,0),",",1),LABO=0,ERR="W - Routine "_X_" is not in the current Account." G ^%INDX1
 S ^UTILITY($J,X)="" Q
CASE ;Convert LC to UC.
 S CM=$TR(CM,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 Q
