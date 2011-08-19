XQLOCK ;SEA/Luke - Find all the keys in the tree; [6/28/02 5:55am]
 ;;8.0;KERNEL;**20,157,237**;Jul 10, 1995
 ;
 ;
 ;Input: XQX is the internal number of the parent menu
 ;       XQUSR is the DUZ of the owner of that menu
 ;
EN1 ;Look up menu trees by user. Entry for option ENLOCK1.
 S XQEN=0 D INIT,USR G:Y=-1 OUT D BLD G:'XQN OUT D DISP,SHOW,CHUZ1,OUT
 Q
 ;
EN2 ;Look up keys for a given menu tree. Entry for option ENLOCK2.
 S XQEN=1 D INIT,TREE G:Y=-1 OUT D BLD G:'XQN OUT D DISP,SHOW,CHUZ1,OUT
 Q
EN3 ;Look up Keys for menu delegation.
 S XQEN=2,XQUSR=XQDA,XQDIC=XQX D INIT,BLD G:'XQN OUT D DISP,SHOW,CHUZ1,OUT
 Q
 ;
INIT ;Get things set up
 S XQBOSS=0 S:$D(^XUSEC("XUMGR",DUZ)) XQBOSS=1
 Q
USR ;Find the user and the menu in question
 Q:XQEN=2
 S DIC="^VA(200,",DIC(0)="AEMQZ",DIC("A")="Please enter the user's name: " W ! D ^DIC Q:Y=-1  S XQUSR=+Y Q:XQEN  D SHO Q:Y=-1
 ;
 W !!,"Enter a menu tree by number : " R %:DTIME S:%="" %=U S:(%=0)!('$D(XQMENU(%)))!(%'=+%) %=U
 I %=U S Y=-1 Q
 S XQX=+XQMENU(%)
 Q
 ;
TREE ;Get the name of the menu tree in question
 S DIC="^DIC(19,",DIC(0)="AEMQZ",DIC("A")="Please enter the parent menu: " D ^DIC Q:Y=-1  S XQX=+Y
 Q
 ;
BLD ;See if the menu tree has been built if not, do it
 S:$D(XQDIC) XQSAV=XQDIC S:XQX'["P" XQX="P"_XQX S XQDIC=XQX
 I '$D(^XUTL("XQO",XQDIC)) S XQXUF="" W !!,"==> Working... "
 D PM1^XQ8
 I $D(XQPSM) S XQSAVE1=XQPSM
 S XQPSM="P"_XQDIC
 D MERGE^XQ12
 I $D(XQSAVE1) S XQPSM=XQSAVE1
 ;
FIND ;Order through the child options and find the locks
 S XQJ=0,XQN=0
 F  S XQJ=$O(^XUTL("XQO",XQDIC,"^",XQJ)) Q:XQJ=""  I $P(^(XQJ),U,7)]""&($P(^DIC(19,XQJ,0),U,6)]"") S XQNM=$P(^(0),U,1),XQTXT=$P(^(0),U,2),XQK=$P(^(0),U,6) D GOT1
 ;
 I 'XQN W:'$D(ZTQUEUED) !!,"No keys need to be given to this user for this menu tree." Q  ;There are no keys to give, so quit
 Q
 ;
DISP ;Display the locked options with their keys
 W !!,"There ",$S(XQN=1:"is one ",1:"are some "),"locked option",$S(XQN=1:":",1:"s:")
 W !!," Option Name",?23,"Option Text",?62,"Locked With",!
 F XQI=0:1:XQN-1 W !,$P(^TMP($J,"XQ",XQI),U),?22,$P(^TMP($J,"XQ",XQI),U,2),?60,$P(^TMP($J,"XQ",XQI),U,3) D:XQI&'(XQI#15) PAUSE^XQLOCK1 Q:XQI=-1
 Q
 ;
SHOW ;Show the current set of keys
 W !!,"This is the current set of keys we are working with: ",! S XQJ="",XQI=5 F XQK=0:1 S XQJ=$O(XQKEY(XQJ)) Q:XQJ=""  W:'(XQK#XQI) ! W ?(XQK#XQI*15),XQJ
 Q
 ;
CHUZ1 W !!,"Please enter one of the following codes:",!!?5,"'A' means allocate these keys",!?5,"'D' means delegate this key set"
 W !?5,"'E' to edit the set of keys you wish to allocate",!?5,"'^' or 'RETURN' to quit",!?5,"'L' to list the locked options again, or",!?5,"'S' to show the set of keys you are allocating again."
 R !!,"Enter A, D, E, ^, L, or S: ",XQUR:DTIME S:XQUR="" XQUR=U Q:XQUR=U
 I "AaDdEe^LlSs"'[$E(XQUR,1) W $C(7),"?? " G CHUZ1
 I XQUR="A"!(XQUR="a") S XQAL=1 D:'$D(XQUSR) USR D:$D(XQUSR) DOIT K XQUS Q:XQEN=2  G CHUZ1
 I XQUR="D"!(XQUR="d") S XQAL=0 D:'$D(XQUSR) USR D:$D(XQUSR) DOIT K XQUSR Q:XQEN=2  G CHUZ1
 I XQUR="E"!(XQUR="e") D EDIT^XQLOCK1 Q:XQUR=U  G CHUZ1
 I XQUR="L"!(XQUR="l") D DISP G CHUZ1
 I XQUR="S"!(XQUR="s") D SHOW G CHUZ1
 Q
 ;
DOIT ;Add the key set to a user's Aloocated or Delegated Keys file
 N DA,DIC,X
 S XQFL=$S(XQAL:51,1:52),DIC="^VA(200,"_+XQUSR_","_XQFL_",",DIC(0)="NMQ",DIC("P")=$S(XQAL:"200.051PA",1:"200.052P"),DA(1)=XQUSR
 S XQNXT="" F  S XQNXT=$O(XQKEY(XQNXT)) Q:XQNXT=""  S X=XQKEY(XQNXT),DINUM=X I '$D(^VA(200,XQUSR,XQFL,"B",X,X)) D FILE^DICN
 K DINUM
 S XQZZGOOD=1
 Q
 ;
OUT ;Clean up and quit
 S:$D(XQSAV) XQDIC=XQSAV
 K ^TMP($J,"XQ")
 K %,DA,DIC,X,XQ,XQAL,XQEN,XQBOSS,XQI,XQIJ,XQJ,XQK,XQKEY,XQKN,XQMENU,XQN,XQNM,XQNXT,XQOP,XQSAV,XQSAVE1,XQTXT,XQUR,XQUSR,XQX,XQZZGOOD,Y
 Q
 ;
GOT1 ;Record a lock
 S XQKN=$O(^DIC(19.1,"B",XQK,0))
 I 'XQBOSS Q:'$D(^VA(200,DUZ,52,XQKN))  ;DUZ can't allocate that key
 I $D(XQUSR) Q:$D(^VA(200,+XQUSR,51,"B",XQKN))  ;User already owns that key
 S:'$D(ZTQUEUED) ^TMP($J,"XQ",XQN)="["_XQNM_"]  "_U_XQTXT_U_" <== "_XQK
 S XQN=XQN+1
 S XQKEY(XQK)=XQKN
 Q
 ;
SHO ;Show the primary and secondary menus of +XQUSR
 S %=+$G(^VA(200,+XQUSR,201)),XQMENU(1)=$S(%<1:"",1:%_U_$P($G(^DIC(19,%,0)),U,1,2))
 I XQMENU(1)="" W !!?5,"==> ",$P(XQUSR,U,2)," has no primary menu." S Y=-1 Q
 S %=0 F XQI=2:1  S %=$O(^VA(200,+XQUSR,203,%)) Q:%'>0  S XQSM=+^(%,0) I $D(^DIC(19,XQSM,0))#2 S XQMENU(XQI)=XQSM_U_$P(^(0),U,1,2)
 I '$D(ZTQUEUED) W ! S XQIJ=0 F  S XQIJ=$O(XQMENU(XQIJ)) Q:XQIJ=""  W !,XQIJ,". ",$P(XQMENU(XQIJ),U,2),?23,$P(XQMENU(XQIJ),U,3),?62,$S(XQIJ=1:"Primary Menu",1:"Secondary") D:'(XQIJ#22) PAUSE^XQLOCK1
 Q
 ;
KEY ;Look up a key in the Key file and get its number
 S XQ=$O(^DIC(19.1,"B",XQK,0)) I XQ="" W $C(7),!!?5,"==> A key named ",XQK," ??",!
 Q
