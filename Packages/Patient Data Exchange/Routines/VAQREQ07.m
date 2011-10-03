VAQREQ07 ;ALB/JFP - PDX, CREATE NOTIFY LIST, REQUEST SCREEN;01MAR93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
EP ; -- Main entry point for the list processor
 ;    - Called from VAQREQ02
 ;
REQ ; -- Request users for notify list
 K ^TMP("VAQNOTI",$J)
 N POP,NOTIDA,NOTIUSER,DIRUT,DTOUT,DUOUT,D,J,L,N,X,Y
 ;
 F J=1:1 D ASKNOTI  I $D(DIRUT) D DBLCHK  Q:$D(DIRUT)!(POP)
 ; -- Cleanup and quit
 K POP,NOTIDA,NOTIUSER,DIRUT,DTOUT,DUOUT,D,J,L,N,X,Y
 K MAILDA,MAILNM
 QUIT
 ;
DBLCHK ; -- Double check for exit
 Q:$D(DUOUT)
 S (VAQNOTI,POP)="0"
 I $D(^TMP("VAQNOTI",$J)) D DBL1
 QUIT
 ;
DBL1 ;
 W !!
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Include Data with Notification(s):"
 D ^DIR K DIR
 I Y=1 S VAQNOTI="1"
 W !!
 S DIR(0)="Y",DIR("B")="YES",DIR("A")="Exit Notify:"
 D ^DIR K DIR
 I Y=1 S POP=1
 QUIT
 ; 
ASKNOTI ; -- Call to Dir to request notify list
 D:$D(^TMP("VAQNOTI",$J)) LISTD
 S POP=0
 S DIR("A")="User to notify: "
 S DIR(0)="FAO^1:30"
 S DIR("?")="^D HLP1^VAQREQ07"
 S DIR("??")="^D HLP2^VAQREQ07"
 W ! D ^DIR K DIR  Q:$D(DIRUT)
 S X=Y
 I X="*L" D LISTD  Q:POP
 I $E(X,1,1)="-" D DELNOTI  Q:POP
 I $E(X,1,2)'="G." D NOTI Q:POP
 I $E(X,1,2)="G." D GNOTI  Q:POP
 QUIT
 ;
NOTI ; -- Dic lookup to verify user in file 200 (new person)
 S DIC="^VA(200,",DIC(0)="EMQZ"
 D ^DIC K DIC I $D(DTOUT)!$D(DUOUT)!(Y<0) S POP=1  QUIT
 S NOTIDA=$P(Y,U,1),NOTIUSER=$P(Y,U,2),^TMP("VAQNOTI",$J,NOTIUSER)=NOTIDA
 QUIT
 ;
GNOTI ; -- Dic lookup to verify mail group name in file XMB(3.8 
 S X=$P(X,".",2) ; -- strip off G.
 S DIC="^XMB(3.8,"
 S DIC(0)="EMQZ"
 D ^DIC K DIC I $D(DTOUT)!$D(DUOUT)!(Y<0) S POP=1  QUIT
 S MAILDA=$P(Y,U,1)
 S MAILNM=$P(Y,U,2)
 D G1
 QUIT
 ;
G1 S NOTIDA=""
 N XMDUZ,XMCHAN,X,Y
 S XMDUZ=$G(DUZ),XMCHAN=1
 S X="G."_MAILNM
 D WHO^XMA21 ; -- Mailman call to determine whos in group, sets XMY(
 F  S NOTIDA=$O(XMY(NOTIDA))  Q:'NOTIDA  D SETG
 QUIT
 ;
SETG ; -- 
 Q:NOTIDA'?1N.N
 S NOTIUSER=$P($G(^VA(200,NOTIDA,0)),U,1)
 S ^TMP("VAQNOTI",$J,NOTIUSER)=NOTIDA
 QUIT
 ;
DELNOTI ; -- Deletes person from notify list
 S POP=1,X=$E(X,2,99)
 I X="" W "     ...No Entries Selected"  QUIT
 S X=$$PARTIC^VAQUTL94("^TMP(""VAQNOTI"","_$J_")",X)
 I X=-1 W "     ... Not Selected" QUIT
 I '$D(^TMP("VAQNOTI",$J,X)) W "     ... ",X," Not Selected"  QUIT
 K ^TMP("VAQNOTI",$J,X) W "     ... ",X," Deleted"
 QUIT
 ;
HLP1 ; -- Display options for user to notify prompt
 W !!!,"Options for User to notify prompt:",!
 W !,"User to notify: users name        ; select user (new person)"
 W !,"User to notify: G.mail group      ; select mail group"
 W !,"User to notify: -users name       ; de-selects a user"
 W !,"User to notify: *L                ; list selected users"
 W !,"User to notify: ^                 ; terminates option"
 W !,"User to notify: return            ; done with option"
 W !,"User to notify: ?                 ; list of input options"
 W !,"User to notify: ??                ; displays choices"
 QUIT
 ;
HLP2 ; -- Display new person file or mail group file
 W !!,"(1) - New Person",!,"(2) - Mail Group",!
 R "Select Display Option: ",X:DTIME  Q:X=""
 I X="^"  QUIT
 I X=1 D H1  QUIT
 I X=2 D H2  QUIT
 W "        ...invalid entry"
 K X
 QUIT
 ;
H1 ; -- Displays new person file
 S DIC="^VA(200,",DIC(0)="C",D="B"
 D DQ^DICQ
 K DIC,D
 QUIT
 ;
H2 ; -- Display mail groups
 S DIC="^XMB(3.8,"
 S DIC(0)="CM"
 S D="B",DZ="??"
 D DQ^DICQ
 K DIC,D,DZ
 QUIT
 ;
LISTD ; -- Displays a list of names selected
 S POP=1
 I '$D(^TMP("VAQNOTI",$J))  W "     ...No User(s) Selected"  QUIT
 W !!,"-------------------------------- User Selected --------------------------------"
 S N="" F L=0:1 S N=$O(^TMP("VAQNOTI",$J,N))  Q:N=""  W:'(L#8) ! W ?L#8*30 W N
 W !,"--------------------------------------------------------------------------------"
 W ! QUIT
 ;
END ; -- End of code
 QUIT
