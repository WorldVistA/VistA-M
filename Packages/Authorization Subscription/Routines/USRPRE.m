USRPRE ; SLC/JER - Pre-init routine ;4/8/93  10:15
 ;;1.0;AUTHORIZATION/SUBSCRIPTION;;Jun 20, 1997
MAIN ; Controls branching
 W !,"** CHECKING DHCP ENVIRONMENT **",!!
 I +$G(DUZ)'>0!($G(DUZ(0))'="@") D  Q
 . S XPDQUIT=2
 . W !,"You must first initialize Programmer Environment by running ^XUP",!
 I $L($T(^VALM1)) D  Q
 . W "Everything looks fine!",!
 W "You MUST first install the MAS v5.3 and VA ListManager v1.0 (VALM* w/INITS)...",!!
 W "Authorization/Subscription Utilities Installation ABORTED.",!!
 S XPDQUIT=2
 Q
