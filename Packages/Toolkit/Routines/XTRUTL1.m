XTRUTL1 ;ISCSF/RWF - Developer Routine Utilities Build & Install Files ;2/14/07  15:50
 ;;7.3;TOOLKIT;**20,66,132**;Apr 25, 1995;Build 13
 ; Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q  ;No entry from the top.
BUILD() ;This will select an entry in the BUILD file.
 N BLDA,DIC,X,Y
 S DIC="^XPD(9.6,",DIC(0)="AEMQZ" D ^DIC
 Q Y
INSTALL() ;This will select an entry in the INSTALL file.
 N BLDA,DIC,X,Y
 S DIC="^XPD(9.7,",DIC(0)="AEMQZ",DIC("S")="I '$P(^(0),U,9),$D(^XTMP(""XPDI"",Y))"
 D ^DIC
 Q Y
RTN(IEN,FILE) ;This will build a list of routines from the BUILD or INSTALL (FILE) file.
 Q:'$G(IEN)  S:'$G(FILE) FILE=9.6
 N X,IX,R S U="^"
 I FILE=9.6 D  Q
 . F IX=0:0 S IX=$O(^XPD(9.6,IEN,"KRN",9.8,"NM",IX)) Q:IX'>0  S X=^(IX,0) S:'$P(X,U,3) ^UTILITY($J,$P(X,U))=""
 . F IX="INI","INIT","PRE" S X=$G(^XPD(9.6,IEN,IX)) I X]"" S R=$P($S(X[U:$P(X,U,2),1:X),"("),^UTILITY($J,R)=""
 . Q
 ;get routines from Transport Global and merge into ^UTILITY
 I FILE=9.7 D  Q
 . S X=""
 . F  S X=$O(^XTMP("XPDI",IEN,"RTN",X)) Q:X=""  S R=^(X),^UTILITY($J,X)="" D
 .. M ^UTILITY($J,1,X,0)=^XTMP("XPDI",IEN,"RTN",X)
 .. S ^UTILITY($J,1,X,"RSUM")=$P(R,"^",3),^UTILITY($J,1,X,0,0)=$O(^UTILITY($J,1,X,0,""),-1) ;set RSUM and line count
 . Q
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
