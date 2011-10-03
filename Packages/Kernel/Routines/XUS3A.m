XUS3A ;SF-ISC/STAFF - CHANGE UCI'S ; 2/4/03 9:51am
 ;;8.0;KERNEL;**13,282**;Jul 10, 1995
 Q
 ;PICK A UCI TO SWITCH TO
SWITCH ;Allow users that have the UCI field in there NP file to switch UCI's.
 W !!,"Switch UCI's option.",!
 I $$PROGMODE^%ZOSV() W !,$C(7),"No switching UCI's in Programmer Mode." Q
 I $O(^VA(200,DUZ,.2,0))'>0 D  Q
 . W !,"Sorry but you do not have any UCI's that you are allowed to"
 . W !,"switch to."
 . Q
 N DIR,X,Y,PGM,%UCI,DEF
 S DEF="ZU" ;DEF is default routine to switch to.
UCI S DIR(0)="F",DIR("A")="Select UCI:ROUTINE",DIR("??")="^D SHOW^XUS3A"
 S DIR("?")="Enter a UCI name (:Routine) to switch to."
 D ^DIR K DIR I $D(DUOUT)!$D(DTOUT)!(X="^") Q
 I Y?.N,$D(^VA(200,DUZ,.2,Y,0)) S UC=^(0),Y=$P(UC,U)_":"_$P($P(UC,U,2),":")
 S X=$P(Y,":"),PGM=$P(Y,":",2,3) S:PGM[":" X=$P(Y,":",1,2),PGM=$P(Y,":",3) ;for M/vx
 S:PGM="" PGM=DEF
SAME I X="" Q  ;Didn't select anything.
 D PM S %UCI=X X ^%ZOSF("UCICHECK") I 0[Y G BAD
 F DA=0:0 S DA=$O(^VA(200,DUZ,.2,DA)) Q:DA'>0  S Y=^(DA,0) D  G:GO NXT
 . S GO=0,X=$P(Y,U),XUA=$P(Y,U,2) D PM Q:%UCI'=X 
 . I XUA="" S XUA=DEF
 . F %=1:1:20 I $P(XUA,":",%)=PGM S GO=1 Q
 . Q
BAD W !,"UCI not found!" D SHOW G UCI
 ;
NXT ;Here we go.
 D C^XUSCLEAN K ^XUTL("XQ",$J),^XUTL($J),^TMP($J),^UTILITY($J)
 ;K DA S XQZ="^"_PGM_"["_%UCI_"]" D DO^%XUCI G ^XUSCLEAN
 K DA G GO^%XUCI
 ;
 ;
SHOW W ! S I=0,UC="",X=$S($D(^VA(200,DUZ,201)):+^(201),1:0)
 W !,"Enter ^ to return to your current menu, or select from:"
 F I=0:0 S I=$O(^VA(200,DUZ,.2,I)) Q:I'>0  D
 . W !,?5 S UC=$G(^VA(200,DUZ,.2,I,0)),X=$P(UC,U,1),UC=$P(UC,U,2,99)
 . I UC'[":" W I
 . D PM W ?10,X X ^%ZOSF("UCICHECK") I 0[Y W " -- Not currently a valid  UCI!",$C(7) Q
 . W:UC]"" ":"_UC
 . Q
 Q
 ;
PM I X="PROD"!(X="MGR") S X=^%ZOSF(X)
 Q
