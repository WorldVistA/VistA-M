TIUENV ; SLC/JER - Environment check routine ;2/17/95  11:14
 ;;1.0;TEXT INTEGRATION UTILITIES;;Jun 20, 1997
MAIN ; Controls branching
 W !,"** CHECKING DHCP ENVIRONMENT **",!!
 I +$G(DUZ)'>0!($G(DUZ(0))'="@") D  Q
 . S XPDQUIT=2
 . W !,"You must first initialize Programmer Environment by running ^XUP",!
 I $S('$D(^AUPNPAT):1,'$L($T(PXXDPT^PXXDPT)):1,1:0) D  Q
 . S XPDQUIT=2
 . W !,"You must first install the IHS Patient File.",!
 I $S('$D(^AUPNVSIT):1,'$L($T(VSIT^VSIT)):1,1:0) D  Q
 . S XPDQUIT=2
 . W !,"You must first install Visit Tracking.",!
 I $$VERSION^XPDUTL("VSIT")'="2.0" D  Q
 . S XPDQUIT=2
 . W !,"You must first install PCE v1.0 & Visit Tracking v2.0.",!
 ; Evaluate whether ASU v1.0 has been installed
 I $$VERSION^XPDUTL("USR")'="1.0" D  Q
 . S XPDQUIT=2
 . W !,"You must first install Authorization/Subscription Utilites (ASU) v1.0.",!
 ; Evaluate whether patch to ORU1 has been applied
 I $T(PATIENT^ORU1)'[",ORPGSUPP" D  Q
 . S XPDQUIT=2
 . W !,"You must first install patch OR*2.5*51.",!
 ; Evaluate whether patch to XQOR has been applied
 I +$$PATCH^XPDUTL("XU*8.0*56")'>0 D  Q
 . S XPDQUIT=2
 . W !,"You must first install patch XU*8.0*56.",!
 I +$G(^DD(409.61,0,"VR"))'<1,$L($T(^VALM1)) D  Q
 . W "Everything looks fine!",!
 W "You MUST first install the MAS v5.3 and VA ListManager v1.0 (VALM* w/INITS)...",!!
 W "Text Integration Utilities Initialization aborted.",!!
 S XPDQUIT=2
 Q
READ(TYPE,PROMPT,DEFAULT,HELP,SCREEN) ; Calls reader, returns response
 N DIR,X,Y
 S DIR(0)=TYPE
 I $D(SCREEN) S DIR("S")=SCREEN
 I $G(PROMPT)]"" S DIR("A")=PROMPT
 I $D(DEFAULT) S DIR("B")=DEFAULT
 I $D(HELP) S DIR("?")=HELP
 D ^DIR
 I $G(X)="@" S Y="@" G READX
 I Y]"",($L($G(Y),U)'=2) S Y=Y_U_$G(Y(0),Y)
READX Q Y
