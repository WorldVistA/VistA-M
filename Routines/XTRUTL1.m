XTRUTL1 ;ISCSF/RWF - Developer Routine Utilities Build File ;10/09/2002  09:17
 ;;7.3;TOOLKIT;**20,66**;Apr 25, 1995
 ;
 Q  ;No entry from the top.
BUILD() ;This will select an entry in the BUILD file.
 N BLDA,DIC,X,Y
 S DIC="^XPD(9.6,",DIC(0)="AEMQZ" D ^DIC
 Q Y
RTN(IEN) ;This will build a list of routines from the BUILD file.
 N X,IX S U="^"
 F IX=0:0 S IX=$O(^XPD(9.6,IEN,"KRN",9.8,"NM",IX)) Q:IX'>0  S X=^(IX,0) S:'$P(X,U,3) ^UTILITY($J,$P(X,U))=""
 F IX="INI","INIT","PRE" S X=$G(^XPD(9.6,IEN,IX)) I X]"" S ^UTILITY($J,$S(X[U:$P(X,U,2),1:X))=""
 Q
 ;
VER(X) ;returns version number from Build file, X=build name
 Q:X["*" $P(X,"*",2)
 Q $P(X," ",$L(X," "))
 ;
PATCH(X) ;returns the patch number from the Build file, X=build name
 Q $S(X["*":$P(X,"*",3),1:"")
 ;
PLCP(PL,N) ;Patch list contains patch number
 N PAT S PAT="PL?.E1P1"""_N_"""1P.E"
 Q @PAT
