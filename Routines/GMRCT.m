GMRCT ; SLC/DLT\JFR - Get DUZ's of users for notification to service ; 11/25/2000
 ;;3.0;CONSULT/REQUEST TRACKING;**1,5,11,18**;Dec 27, 1997
EN(GMRCSRV,USER,TEST) ;Get who is to be notified for alert action
 ; return them in array GMRCADUZ(DUZ)=""
 N GMRCLIS,GMRCHKD,GMRCNT,GMRCLP,GMRCQUIT
 D RECIP(GMRCSRV,$G(TEST)) I $D(TEST),$G(USER),$D(GMRCADUZ(USER)) Q
 I '$P(^GMR(123.5,+GMRCSRV,0),U,8) Q  ; don't check parents
 S GMRCHKD(GMRCSRV)="",GMRCNT=1
 D FINDPAR^GMRCAU(GMRCSRV,.GMRCNT) I '$D(GMRCLIS) Q
 S GMRCLP=0
 F  S GMRCLP=$O(GMRCLIS(GMRCLP)) Q:'GMRCLP  D  I $D(GMRCQUIT) Q
 . I +$P(GMRCLIS(GMRCLP),U,2) K GMRCLIS(GMRCLP) Q  ;been checked
 . I '$D(GMRCHKD(+GMRCLIS(GMRCLP))) D
 .. ; check parent 
 .. D RECIP(+GMRCLIS(GMRCLP),$G(TEST)) I $G(USER),$D(GMRCADUZ(USER)) D  Q
 ... S GMRCQUIT=1
 .. S GMRCHKD(+GMRCLIS(GMRCLP))=""
 . S $P(GMRCLIS(GMRCLP),U,2)=1
 . I $P(^GMR(123.5,+GMRCLIS(GMRCLP),0),U,8) D  ;check parents, fld .08 =1
 .. D FINDPAR^GMRCAU(+GMRCLIS(GMRCLP),.GMRCNT)
 . S GMRCLP=0 ;start back at top and don't miss any
 Q
RECIP(GMRCSS,NOTNULL) ;gather recipients for GMRCSS
 N GMRCTM,GMRCTMI,GMRCLST,GMRCER,GMRCHL,GMRCSSI,GMRCU,GMRCWL
 I $D(^GMR(123.5,GMRCSS,123)),$P(^GMR(123.5,GMRCSS,123),"^",8) S GMRCADUZ($P(^(123),"^",8))=$S($G(NOTNULL):$$NOTSERV($P(^(123),"^",8)),1:"")
 I $D(^GMR(123.5,GMRCSS,123.1)) D TEAM
 I $D(^GMR(123.5,GMRCSS,123.2)),+$G(GMRCO) D LOC
 I $D(^GMR(123.5,GMRCSS,123.33)) D ADMU
 I $D(^GMR(123.5,GMRCSS,123.34)) D ADMT
 Q
LOC ;Find the patients location and match to location assignments
 S GMRCWL="",GMRCHL=""
 I +$G(GMRCO) S GMRCHL=$P(^GMR(123,+GMRCO,0),"^",4) I GMRCHL S GMRCWL=$G(^SC(GMRCHL,42)) S:GMRCWL GMRCWL=GMRCWL_";DIC(42," S GMRCHL=GMRCHL_";SC("
 E  S:+$G(GMRCWLI) GMRCWL=GMRCWLI_";DIC(42," S:+$G(GMRCHLI) GMRCHL=GMRCHLI_";SC("
 I +GMRCWL S GMRCSSI=$O(^GMR(123.5,GMRCSS,123.2,"B",GMRCWL,"")) I GMRCSSI D LOC1
 I +GMRCHL S GMRCSSI=$O(^GMR(123.5,GMRCSS,123.2,"B",GMRCHL,"")) I GMRCSSI D LOC1
 Q
LOC1 ;Get user and/or team assigned to location
 I $P(^GMR(123.5,GMRCSS,123.2,GMRCSSI,0),"^",2) S GMRCADUZ($P(^(0),"^",2))=$S($G(NOTNULL):$$NOTSERV($P(^(0),"^",2)),1:"")
 I $P(^GMR(123.5,GMRCSS,123.2,GMRCSSI,0),"^",3) S GMRCTMI=$P(^(0),"^",3) D TEAM1
 Q
ADMU ;Get notification recips from admin users field (123.33)
 ;Loop "AC" x-ref to get those admin users marked as notif recipients
 N RECIP
 S RECIP=0
 F  S RECIP=$O(^GMR(123.5,GMRCSS,123.33,"AC",1,RECIP)) Q:'RECIP  D
 . S GMRCADUZ(RECIP)=$S($G(NOTNULL):$$NOTSERV(RECIP),1:"")
 Q
ADMT ;Get notification recips from admin teams field (123.34)
 ;Loop "AC" x-ref to get those admin teams marked as notif recipients
 ;call TEAM1 to get list of users and add to recip list
 N GMRCTMI S GMRCTMI=0
 F  S GMRCTMI=$O(^GMR(123.5,GMRCSS,123.34,"AC",1,GMRCTMI)) Q:'GMRCTMI  D
 . D TEAM1
TEAM ;Loop through Teams to send all users notifications
 S GMRCTM=0 F  S GMRCTM=$O(^GMR(123.5,GMRCSS,123.1,GMRCTM)) Q:'+GMRCTM  S GMRCTMI=$P($G(^GMR(123.5,GMRCSS,123.1,GMRCTM,0)),"^") I GMRCTMI D TEAM1
 Q
TEAM1 ;Get user DUZ's from Team pointed to in File
 S GMRCLST="" D TEAMPROV^ORQPTQ1(.GMRCLST,GMRCTMI)
 Q:$S('$O(GMRCLST(0)):1,$P(GMRCLST(1),"^",2)="No providers found.":1,1:0)
 S GMRCU=0 F  S GMRCU=$O(GMRCLST(GMRCU)) Q:GMRCU=""  D
 . I '$G(NOTNULL) D  Q
 .. S GMRCADUZ($P(GMRCLST(GMRCU),"^",1)_U_GMRCTMI)=""
 . S GMRCADUZ($P(GMRCLST(GMRCU),"^",1))=$S($G(NOTNULL):$$NOTSERV(GMRCU),1:"")
 K GMRCLST
 Q
NOTSERV(RECIP) ;set GMRCADUZ(RECIP)=all services they receive for
 I '$D(GMRCADUZ(RECIP)) Q $P(^GMR(123.5,+GMRCSS,0),U)
 Q GMRCADUZ(RECIP)_"~"_$P(^GMR(123.5,+GMRCSS,0),U)
TEST ; called from GMRC NOTIF RECIPIENTS
 N GMRCSRV,GMRCUSR,GMRCADUZ
 N DIR,DIROUT,DIRUT,DUOUT,DTOUT,X,Y
 S DIR(0)="PO^123.5:EM",DIR("A")="Select Consult Service"
 S DIR("?")="Choose the consult service to check update status of user"
 S DIR("??")="^D TESTHELP^GMRCAU(""ALL SERVICES"")" D ^DIR
 I $D(DIRUT) Q
 S GMRCSRV=+Y
 N DIR
 S DIR(0)="PO^200:EM",DIR("A")="Choose notification recipient"
 D ^DIR I $D(DIRUT) Q
 S GMRCUSR=+Y
 D EN(GMRCSRV,GMRCUSR,1)
 I $D(GMRCADUZ(GMRCUSR)) D
 . W !!,"This user is a notification recipients for "_GMRCADUZ(GMRCUSR),!
 . I GMRCADUZ(GMRCUSR)'=$P(^GMR(123.5,GMRCSRV,0),U) D
 .. D HIER(GMRCADUZ(GMRCUSR))
 . W !!
 I '$D(GMRCADUZ(GMRCUSR)) W !!,"This user is not a notification recipient.",!!
 G TEST
HIER(SERV) ;ask to see the hierarchy
 N DIR,DIRUT,DUOUT,DTOUT
 S DIR(0)="Y"
 S DIR("A")="View hierarchy from this service to the selected service"
 S DIR("B")="NO"
 D ^DIR
 I Y>0 D TESTHELP^GMRCAU(SERV)
 Q
TSTINTRO ; entry action for GMRC USER NOTIFICATION
 W !,"This option will list how a given user became a notification recipient"
 W !,"for a selected consult service. If the PROCESS PARENTS FOR NOTIFS field is"
 W !,"set to YES, all the parents of the service will also be processed to"
 W !,"determine if the user is a recipient via that service.",!!
 Q
