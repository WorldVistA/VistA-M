FSCSTUP ;SLC/STAFF-NOIS Site Tracking Update Reporting ;11/15/97  20:56
 ;;1.1;NOIS;;Sep 06, 1998
 ;
PATCH ; from FSCLMP
 N DIR,X,Y K DIR
 W !!,"*******  VALID for patches verified since 1/1/98  **********"
 W !!,"Choose method of reviewing PATCH installs"
 W !,"Installed:"
 W !?5,"1) Sites that have a patch installed"
 W !?5,"2) All patches installed at a site"
 W !?5,"3) Patches installed at a site for a package"
 W !!,"Not installed:"
 W !?5,"4) Sites that do not have a patch installed"
 W !?5,"5) All patches not installed at a site"
 W !?5,"6) Patches not installed at a site for a package"
 W !!,"Patches being tested:"
 W !?5,"7) Test patches installed"
 W !?5,"8) Test patches installed at a site"
 W !?5,"9) Test patches installed for a package"
 S DIR(0)="NOA^1:9:0",DIR("A")="Select number: "
 S DIR("?",1)="Enter the number of the selection."
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) Q
 I Y=1 D SITE Q
 I Y=2 D ALL Q
 I Y=3 D PACK Q
 I Y=4 D SITENOT Q
 I Y=5 D ALLNOT Q
 I Y=6 D PACKNOT Q
 I Y=7 D TEST Q
 I Y=8 D TESTSITE Q
 I Y=9 D TESTPACK Q
 Q
 ;
SITE ;
 N OK,PATCH
 D PATCHES(.PATCH,"V",.OK) I 'OK Q
 S FSCSTU="PATCH SITE" D ENTRY^FSCLMIPX,HEADER^FSCLMIPX
 Q
 ;
ALL ;
 N DATE,OK,SITE
 D SITES^FSCSTUR(.SITE,.OK) I 'OK Q
 D DATE^FSCSTUR(.DATE,.OK) I 'OK Q
 S FSCSTU="PATCH ALL" D ENTRY^FSCLMIPX,HEADER^FSCLMIPX
 Q
 ;
PACK ;
 N MODULE,OK,SITE
 D SITES^FSCSTUR(.SITE,.OK) I 'OK Q
 D MOD(.MODULE,.OK) I 'OK Q
 S FSCSTU="PATCH PACK" D ENTRY^FSCLMIPX,HEADER^FSCLMIPX
 Q
 ;
SITENOT ;
 N OK,PATCH
 D PATCHES(.PATCH,"V",.OK) I 'OK Q
 S FSCSTU="PATCH SITENOT" D ENTRY^FSCLMIPX,HEADER^FSCLMIPX
 Q
 ;
ALLNOT ;
 N OK,SITE
 D SITES^FSCSTUR(.SITE,.OK) I 'OK Q
 S FSCSTU="PATCH ALLNOT" D ENTRY^FSCLMIPX,HEADER^FSCLMIPX
 Q
 ;
PACKNOT ;
 N MODULE,OK,SITE
 D SITES^FSCSTUR(.SITE,.OK) I 'OK Q
 D MOD(.MODULE,.OK) I 'OK Q
 S FSCSTU="PATCH PACKNOT" D ENTRY^FSCLMIPX,HEADER^FSCLMIPX
 Q
 ;
TEST ;
 N OK,PATCH
 D PATCHES(.PATCH,"N",.OK) I 'OK Q
 S FSCSTU="PATCH TEST" D ENTRY^FSCLMIPX,HEADER^FSCLMIPX
 Q
 ;
TESTSITE ;
 N OK,SITE
 D SITES^FSCSTUR(.SITE,.OK) I 'OK Q
 S FSCSTU="PATCH TESTSITE" D ENTRY^FSCLMIPX,HEADER^FSCLMIPX
 Q
 ;
TESTPACK ;
 N MODULE,OK
 D MOD(.MODULE,.OK) I 'OK Q
 S FSCSTU="PATCH TESTPACK" D ENTRY^FSCLMIPX,HEADER^FSCLMIPX
 Q
 ;
PATCHES(PATCH,VERIFY,OK) ;
 S OK=0
 N DIC,X,Y K DIC
 S DIC=11005,DIC(0)="AEMOQ",DIC("A")="Select Patch: "
 I VERIFY="V" D
 .S DIC("S")="I $P(^(0),U,11),$D(^NTS(2050.2,""B"",+Y))"
 .W !,"Only patches that are verified and tracked can be selected."
 I VERIFY="N" D
 .S DIC("S")="I '$P(^(0),U,11),$D(^NTS(2050.2,""B"",+Y))"
 .W !,"Only patches that are not verified and tracked can be selected."
 F  D ^DIC Q:Y<1  Q:$D(^NTS(2050.2,"B",+Y))  W !,"This patch has no tracking information."
 K DIC I Y<1 Q
 S PATCH=+Y,OK=1
 I $P(^A1AE(11005,PATCH,0),U,8)="e" D
 .W !,"This patch was Entered in Error." H 2
 Q
 ;
MOD(MODULE,OK) ;
 S OK=0
 N DIR,Y K DIR
 S DIR(0)="PAO^7105.4:EM",DIR("A")="Module: "
 S DIR("?",1)="Enter the module/version# to review."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) Q
 S MODULE=+Y,OK=1
 Q
