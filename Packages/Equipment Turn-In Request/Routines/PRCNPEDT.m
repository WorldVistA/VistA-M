PRCNPEDT ;SSI/ALA-PPM Equipment Request Edit ;[ 07/19/96  2:34 PM ]
 ;;1.0;Equipment/Turn-In Request;;Sep 13, 1996
RRV ; Review transaction for request
 S DIC("S")="S ST=$P(^(0),U,7) I ST=6!(ST=15)!(ST=10)!(ST=31)!(ST=38)!(ST=39)!(ST=28)"
 S DIC="^PRCN(413,",DIC(0)="AEQZ",DIE=413 D ^DIC G EXIT:+Y<0 K DIC("S")
 S (IN,DA)=+Y,DIE("NO^")="OUTOK",DR="[PRCNPPE]",PRCNUSR=8
 D SETUP^PRCNPRNT
 W !,"Do you want to edit this request" S %=2 D YN^DICN G EXIT:%'=1
 D ^DIE
ENG S %=2 W !!,"Resend to Engineering for Editing" D YN^DICN
 I %=0 D  G ENG
 . W !!,"Enter 'Y'es if this request needs to be edited by the Engineering group."
 I %=1 D
 . S DA=D0,DR="6///^S X=8;7///^S X=DT" D ^DIE
 G RRV
EXIT K IN,DA,D0,ST,PRCNUSR,DR,DIC,DIE,PRCNTDA,%
 Q
TRV ; Review transaction for turn-in
 S DIC("S")="S ST=$P(^(0),U,7) I ST=6!(ST=23)"
 S DIC="^PRCN(413.1,",DIC(0)="AEQZ",DIE=413.1 D ^DIC G EXIT:+Y<0 K DIC("S")
 S (IN,PRCNTDA,DA)=+Y,DR="[PRCNTIPED]",PRCNUSR=2
 D SETUP^PRCNTIPR
 W !,"Do you want to edit this request" S %=2 D YN^DICN G EXIT:%'=1
 D ^DIE
 G TRV
