XQSMD5 ;SEA/JLI,MJM - SECURE MENU DELEGATE EDIT USER OPTIONS ;10/15/98  12:22
 ;;8.0;KERNEL;**72,99**;Jul 10, 1995
 Q
 ;
ENTRY ; Main Entry point to edit primary (if applicable) and secondary options
 ;
 ;   check to see if you have options to delegate
 I $O(^VA(200,DUZ,19.5,0))'>0 W !,$C(7),"No Delegated Options Available to Give Out",! Q
 ;
 ;   get user to delegate options to
 S Y=$$LOOKUP^XUSER("QA") G:Y'>0 EXIT S (XQDA,DA)=+Y
 ;
 ;   check user's primary menu, if user has primary and it's not one
 ;   of the ones that you can delegate, goto secondary options,
 ;   otherwise fall through and edit primary options
 S XQPRI=$S($D(^VA(200,DA,201)):+^(201),1:0) I XQPRI,'$D(^VA(200,DUZ,19.5,XQPRI,0)) G SEC
 ;
 ;   either change primary option or leave as is and go to secondary
 K DIC
 S XQOLD=XQPRI,DIC="^VA(200,"_DUZ_",19.5,",DIC(0)="QMAE",DA(1)=DUZ,DIC("A")="     PRIMARY MENU OPTION: " S:XQPRI>0 DIC("B")=$P(^DIC(19,XQPRI,0),U,1) D ^DIC I +Y=XQOLD!(+Y'>0) G SEC
 ;
 ;   changing primary option
 S (X,XQPRI)=+Y,X=$P(^DIC(19,X,0),U,1),DIE="^VA(200,",DA=XQDA,DR="201///"_X_";" D ^DIE
 ;
 ;   delete old keys associated with old primary menu
 I XQOLD  D
 .S MENUOLD(0)=1,MENUOLD(1)=XQOLD,XQANS=""
 .D KEYS^XQSMD6(.MENUOLD,.XQKEY,.ABORT) K MENUOLD
 .I XQKEY(0)  D
 ..D ADJUST
 ..Q:'ONEGOOD
 ..M XQ2=XQKEY
 ..W !,"...Removing KEYS associated with previous PRIMARY menu"
 ..D KEYDEL
 ..Q
 K XQ2,XQKEY
 ;
 ;   add new keys associated with new primary menu if you have
 ;   been delegated those keys
 G:'$D(^VA(200,DUZ,52)) SEC
 S MENUPRI(0)=1,MENUPRI(1)=XQPRI
 D KEYS^XQSMD6(.MENUPRI,.XQKEY,.ABORT) K MENUPRI
 D:XQKEY(0) KEYADD
 K XQKEY
 ;
 ;   fall through to secondary options
 ;
SEC ; Enter Secondary Menu Options from delegated options
 K DIC
 W ! S DIC="^VA(200,"_DUZ_",19.5,",DIC(0)="QMAE",DA(1)=DUZ,DIC("A")="     SECONDARY MENU OPTION: " D ^DIC G:Y'>0 ENTRY
 S XQX=$P(Y,U,2)
 S:'$D(^VA(200,XQDA,203,0)) ^(0)="^200.03P" S (XQXNAME,X)=$P(^DIC(19,+Y,0),U,1),DIC="^VA(200,"_XQDA_",203,",DIC(0)="ML",DLAYGO=200,DA(1)=XQDA D ^DIC
 ;
 S XQADD=+$P(Y,U,3),XQSEC=+Y D KEY:XQADD,DEL:'XQADD K ^DIC(200,XQDA,203.1)
 G SEC
 ;
EXIT ;
 K D0,DA,DI,DIC,DIE,DR,DQ,I,J,ONEGOOD,P,X,XQ1,XQ2,XQ3,XQADD,XQANS,XQCOMMON,XQDA,XQJ,XQKEY,XQKEYIEN,XQOLD,XQPRI,XQSEC,XQX,XQXNAME,Y,Z
 Q
 ;
DEL ;   delete delegated menu
 W !,$C(7),"Want to Delete ",XQXNAME," as a Secondary Option? Y// "
 R Z:DTIME Q:'$T!(Z[U)  S:Z="" Z="Y" Q:"Yy"'[$E(Z)
 ;
 ;   check to see if users has any keys delegated
 G:'$D(^VA(200,DUZ,52,0)) MENUDEL
 ;
 ;   build list of users primary ans secondary menus
 S MENU1(0)=1,MENU1(1)=XQPRI,XQJ=""
 F  S XQJ=$O(^VA(200,XQDA,203,"B",XQJ)) Q:XQJ=""  D
 . Q:XQJ=XQX
 . S MENU1(0)=MENU1(0)+1,MENU1(MENU1(0))=XQJ
 . Q
 ;
 ;   get list of keys for primary and all secondary menus in XQ1
 D KEYS^XQSMD6(.MENU1,.XQ1,.ABORT) K MENU1
 ;
 ;   get list of keys for delegated menu in XQ2
 S MENU2(0)=1,MENU2(1)=XQX
 D KEYS^XQSMD6(.MENU2,.XQ2,.ABORT) K MENU2
 ;
 ;   compare the two list and inform the user if delegated menu
 ;   has keys unique to the delegated menu, store in XQ3
 S XQANS="N",ONEGOOD=0
 D:XQ2(0)>0 COMPARE
 D:ONEGOOD INFORM
 ;
 ;   user timeout or "^" aborted
 I $G(DTOUT)!($G(DUOUT)) W !!,$C(7),"No action taken, menu delegation still active!" Q
 ;
 ;   delete keys if user respond with 'Unique' or 'All'
 I XQANS="U"!(XQANS="A") D KEYDEL
 ;
MENUDEL ;
 ;   delete menu from user's secondary menu's multiple
 S DIE="^VA(200,"_XQDA_",203,",DR=".01///@",DA=XQSEC,DA(1)=XQDA D ^DIE
 ;
 W !!,$C(7),"Delegated Menu: "_XQXNAME_" has been removed!"
 Q
 ;
KEY ;   get list of keys
 N MENULIST,XQKEY,ABORT
 S MENULIST(0)=1,MENULIST(1)=XQX
 D KEYS^XQSMD6(.MENULIST,.XQKEY,.ABORT)
 Q:ABORT
 D:XQKEY(0) KEYADD
 W !!,$C(7),"Delegated Menu: "_XQXNAME_" has been added!"
 Q
 ;
KEYDEL ;   delete keys
 F I=1:1:XQ2(0)  D
 .Q:XQ2(I)=""
 .S XQCOMMON=0,XQKEYIEN=""
 .I XQANS="U" F J=1:1:XQ3(0) S:XQ2(1)=XQ3(J) XQCOMMON=1
 .Q:XQCOMMON
 .S XQKEYIEN=$O(^DIC(19.1,"B",XQ2(I),0))
 .S DIE="^VA(200,"_XQDA_",51,",DR=".01///@",DA=XQKEYIEN,DA(1)=XQDA D ^DIE
 .W !,$C(7),"Key: "_XQ2(I)_" has been removed!"
 .Q
 Q
 ;
KEYADD ;   add keys
 ;   adjust list to ones that have been delegated to you
 D ADJUST Q:'ONEGOOD
 W !!,$C(7),"The following Keys LOCK options within this menu structure",!
 F I=1:1:XQKEY(0) W:XQKEY(I)'="" !,?5,XQKEY(I)
 W !!,$C(7),"Do you want to ALLOCATE these Keys to this User?  N// "
 R Z:DTIME Q:'$T!(Z[U)  S:Z="" Z="N" Q:"Nn"[$E(Z)
 ;
 K DIC
 S DIC="^VA(200,"_XQDA_",51,",DIC(0)="NMQ",DIC("P")="200.051PA",DA(1)=XQDA
 F I=1:1:XQKEY(0)  D
 .Q:XQKEY(I)=""
 .S X=$O(^DIC(19.1,"B",XQKEY(I),0)),DINUM=X
 .I '$D(^VA(200,XQDA,51,"B",X,X)) D FILE^DICN W !,$C(7),"Key: "_XQKEY(I)_" has been added!"
 .Q
 Q
 ;
COMPARE ;   compare keys used in the delegated menu against keys the user
 ;   will need based on their primary and secondary menus
 N KEYIEN
 S XQ3="",XQ3(0)=0
 F I=1:1:XQ2(0)  D
 .S KEYIEN=$O(^DIC(19.1,"B",XQ2(I),0))
 .I '$G(^VA(200,DUZ,52,KEYIEN,0)) S XQ2(I)="" Q
 .S ONEGOOD=1
 .F J=1:1:XQ1(0)  D
 ..Q:XQ2(I)'=XQ1(J)
 ..S XQ3(0)=XQ3(0)+1,XQ3(XQ3(0))=XQ2(I)
 ..Q
 Q
 ; 
INFORM ;   inform the user of the keys situation
 W !!,$C(7),"The following Keys LOCK options within this menu structure.",!
 F I=1:1:XQ2(0) W:XQ2(I)'="" !,?5,XQ2(I)
 W:XQ3(0) !!,$C(7),"The following are Keys from the list above that this User has potential needs",!,"for within their current assigned Menu's (Primary and all Secondaries)."
 W:XQ3(0) !,"Selecting 'U' will remove all keys EXCEPT those noted below.",!  F I=1:1:XQ3(0) W !,?5,XQ3(I)
 S DIR(0)="S^A:ALL  Remove all Keys associated with this Menu;N:NONE  Do not remove any Keys associated with this Menu"_$S(XQ3(0):";U:UNIQUE  Only remove Keys unique to this Menu",1:"")
 D ^DIR S XQANS=Y
 Q
 ;
ADJUST ;   adjust the list of keys to ones that the user (DUZ) has 
 ;   been delegated [node ^VA(200,DUZ,52,]
 N I,KEYIEN
 S ONEGOOD=0
 F I=1:1:XQKEY(0)  D
 . S KEYIEN=$O(^DIC(19.1,"B",XQKEY(I),0))
 . I $G(^VA(200,DUZ,52,KEYIEN,0)) S ONEGOOD=1 Q
 . S XQKEY(I)=""
 . Q
 Q
