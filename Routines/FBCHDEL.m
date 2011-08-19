FBCHDEL ;AISC/DMK-DELETE NOTIFICATION/REQUEST ;29MAY90
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 D HOME^%ZIS S DIC("S")=$S($D(^XUSEC("FBAASUPERVISOR",DUZ)):"I $P(^(0),U,17)=""""",1:"I $P(^(0),U,17)=""""&($P(^(0),U,8)=DUZ)") D ASKV^FBCHREQ G END:X=""!(X="^")
 W !! S DR="0:99" D EN^DIQ
ASK S DIR(0)="Y",DIR("A")="Are you sure you want to delete this Request",DIR("B")="NO" D ^DIR K DIR G END:$D(DIRUT)!'Y
EN I $D(DA),DA S FBDA=DA,DIK="^FBAA(162.2," D ^DIK W !,?3,"...request deleted",!
 I $D(FBDA),FBDA,$D(^FBAA(161.5,FBDA,0)) S DA=FBDA,DIK="^FBAA(161.5," D ^DIK
END K DIC,DIK,DIRUT,DA,FBDA,X,VAL,FBDA,DR,FBDFN,FBNAME,FBSSN,S,Y Q
