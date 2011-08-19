RMPR5NDL ;HIN/RVD-PROS INVENTORY DELETE UTILITY ;9/03/99
 ;;3.0;PROSTHETICS;**37,51**;Feb 09, 1996
 ;
 ; ODJ - patch 51 - 10/20/00 - implement requirement for dual RMPR
 ;                             manager signatories before deleting
 ;                             locations.
 ;
 D DIV4^RMPRSIT I $D(Y),(Y<0) K DIC("B") Q
 S X="NOW" D ^%DT
LOC ;ask for Location.
 W @IOF,!!,"Delete an Inventory Location.....",!
 W !,"This option now requires the electronic signatures of 2 users"
 W !,"holding the RMPRMANAGER key to be entered before a location"
 W !,"will be deleted.",!
 K DTOUT,DUOUT,DIC("B")
 S DZ="??",D="B",DIC("S")="I $P(^RMPR(661.3,+Y,0),U,3)=RMPR(""STA"")"
 S DIC="^RMPR(661.3,",DIC(0)="AEQM"
 S D="B",DIC("A")="Enter Pros Location: " D MIX^DIC1
 G:$D(DTOUT)!$D(DUOUT)!(Y'>0) EXIT S (DA,RMLODA)=+Y
CHK D STOCK(RMLODA) ;check and display number&quantities of items
OSIG I '$$GETO(DUZ) G EXIT ;get other signature exit if not OK
ESIG I $D(XQUSER) D
 . W !!,XQUSER," please..."
 . Q
 E  D
 . W !!,$P(^VA(200,DUZ,0),"^",1)," please..."
 . Q
 D SIG^XUSESIG G:X1="" EXIT ;get electronic sig. of main user
DEL ;delete a location
 S DIR(0)="Y",DIR("B")="N"
 W !
 S DIR("A")="Are you sure you want to DELETE this LOCATION (Y/N) "
 D ^DIR I $D(DTOUT)!$D(DUOUT)!(Y="^")!(Y=0) W !,"Nothing Deleted.." G EXIT
 L +^RMPR(661.3,RMLODA):2
 I '$T W !,"Record in use. Try again later..." G EXIT
 I Y>0 S DIK="^RMPR(661.3,",DA=RMLODA D ^DIK W:'$D(^RMPR(661.3,RMLODA,0)) !,"Location is deleted!!!!" H 2
 ;
 ;
EXIT ;MAIN EXIT POINT
 N RMPR,RMPRSITE D KILL^XUSCLEAN
 Q
 ;
 ; Patch 51 - get electronic signatures from 2 RMPR managers in order
 ;            to OK a delete
GETO(RMPRDUZ) ;
 N RMPRMGR,RMPROK,RMPRUSR1,RMPRUSR2,X,X1,DUZ,RMPRKEYS
 W !!,"Pease ask another user with the RMPRMANAGER key to"
 W !,"enter their user name and electronic signature.",!
 S RMPROK=0
 S RMPRKEYS("RMPRMANAGER")=""
 S RMPRUSR1("DUZ")=RMPRDUZ
 I $$GETUSR2(.RMPRUSR2,.RMPRKEYS,.RMPRUSR1)'="" G GETOKX
 S DUZ=RMPRUSR2("DUZ")
 W !,RMPRUSR2("NAME")," please..."
 D SIG^XUSESIG I X1="" G GETOKX
 S RMPROK=1
GETOKX Q RMPROK
 ;
 ; Get 2nd User and ensure they have RMPRMANAGER key
GETUSR2(RMPRUSR2,RMPRKEYS,RMPRUSR1) ;
 N DIC,X,Y,DLAYGO,DTOUT,DUOUT,RMPREXC,RMPRKEY,DUZ
 S DUZ=RMPRUSR1("DUZ")
USR2E K RMPRUSR2
 S DIC="^VA(200,"
 S DIC(0)="ABEQ"
 S DIC("A")="Enter user name of 2nd manager:"
 D ^DIC
 I Y=-1 S RMPREXC="^" G USR2X
 S RMPRUSR2("DUZ")=$P(Y,U,1)
 ;
 ; User 2 can't be same as user 1
 I RMPRUSR2("DUZ")=RMPRUSR1("DUZ") D  G USR2E
 . W !,"The 2nd manager must be different to the manager logged on."
 . Q
 ;
 ; User 2 must have defined security keys
 S RMPRKEY=""
 F  S RMPRKEY=$O(RMPRKEYS(RMPRKEY)) Q:RMPRKEY=""  Q:$D(^XUSEC(RMPRKEY,RMPRUSR2("DUZ")))
 I RMPRKEY="" D  G USR2E
 . W !,"The 2nd manager does not have the correct security key set up."
 . Q
 ;
 ; User 2 verified
 S RMPRUSR2("NAME")=$P(Y,U,2)
 S RMPREXC=""
USR2X Q RMPREXC
 ;
 ; Get number of HCPC items, quantity in stock and cost for location
STOCK(RMPRILOC) ;
 N IEN1,IEN2,S,RMPRSTK
 K RMPRSTK S RMPRSTK("ITEMS")=0
 S IEN1=0
 F  S IEN1=$O(^RMPR(661.3,RMPRILOC,1,IEN1)) Q:'+IEN1  D
 . S IEN2=0
 . F  S IEN2=$O(^RMPR(661.3,RMPRILOC,1,IEN1,1,IEN2)) Q:'+IEN2  D
 .. S RMPRSTK("ITEMS")=1+RMPRSTK("ITEMS")
 .. S S=$G(^RMPR(661.3,RMPRILOC,1,IEN1,1,IEN2,0))
 .. S RMPRSTK("QOH")=$P(S,"^",2)+$G(RMPRSTK("QOH"))
 .. S RMPRSTK("COST")=$P(S,"^",3)+$G(RMPRSTK("COST"))
 .. Q
 . Q
 W !,"The above location contains "
 W RMPRSTK("ITEMS")," types of items"
 I RMPRSTK("ITEMS")=0 D
 . W "."
 . Q
 E  D
 . W ", ",!,"with a total quantity of ",RMPRSTK("QOH")
 . W " and cost of $",RMPRSTK("COST"),"."
 . Q
 W !
 Q
