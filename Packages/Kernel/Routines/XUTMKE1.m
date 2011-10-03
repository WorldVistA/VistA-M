XUTMKE1 ;SEA/RDS - Taskman: Option, XUTME SCREEN*, Part 1 ;04/17/98  13:18
 ;;8.0;KERNEL;**63,79**;Jul 10, 1995
 ;
SCLIST ;List Current Error Screens
 ;N % S %=$$LST(2) D:% MORE Q
ALL ;Show all error screens
 N % S %=$$LST(1),%=%+$$LST(2) D:% MORE Q
 ;
LST(IX) ;List a type a error screen
 N X,Y,ZT,ZTE
 S ZT="CURRENT "_$S(IX=1:"Don't show",1:"Don't record")_" ERROR SCREENS"
 I $O(^%ZTER(2,"AC",IX,0))="" W !!?5,"No '",ZT,"' error screens have been established" W:IX=2 !,?10,"--all errors are currently logged." Q 0
 W !!?6,ZT
 W !?5,"Screen",?40,"Count?"
 W !?5,"-------------",?40,"------"
 S ZTE="" F ZT=0:0 S ZTE=$O(^%ZTER(2,"AC",IX,ZTE)) Q:ZTE=""  D
 . S X=^%ZTER(2,ZTE,0),Y=$E($G(^(2)),1,50)
 . W !?5,$P(X,U) W ?40,$S($P(X,U,4):"yes: "_$G(^(3)),1:"no") W:$L(Y) !,?5,">>",^(2)
 W ! Q 1
 ;
MORE N DIR,DIRUT,DTOUT,DUOUT
 S DIR(0)="E",DIR("A")="     End of listing.  Press RETURN to continue"
 S DIR("?")="     Press RETURN to continue."
 D ^DIR K DIR
 I $D(DTOUT) W $C(7)
 Q
 ;
SCREM ;Remove An Error Screen
 N DIE,DR,DA,DIR,DIRUT,DTOUT,DUOUT,%ZT,ZTX,ZTY
 S ZTY=$$SCSEL^XUTMKE2(0,"Enter Error Screen to remove") Q:ZTY'>0
REM ;S DA=+ZTY,DR=$S(+$P(ZTY,U,5):"",1:".01;")_".03;.04",DIE="^%ZTER(2," D ^DIE
 D FORM^XUTMKE2(+ZTY)
 Q
 ;
