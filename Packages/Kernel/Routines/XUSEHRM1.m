XUSEHRM1 ; BA/OAK - EHRM REVERSED LOCK -ASSIGN AND REMOVE; Jan 19, 2022@08:07:01
 ;;8.0;KERNEL;**758**;Jul 10, 1995;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified
 Q
1 ; assign a Program Replacement Key to all users
 N XUSASK,XUSDVSION,XUSKEY,XUDUZ,XUANS,XUSER,DIR,XUEXIT,ZTSK
 S XUSDUZ=$G(DUZ,.5),XUSER="",XUSDVSION="",XUSKEY="",XUEXIT=""
 S XUSKEY=+$$ASKKEY("What Program Replacement Key do you want to assign to VistA users? ") I XUSKEY'>0 G END
 S XUSKEY=$P($G(^DIC(19.1,XUSKEY,0)),"^")
 SET DIR(0)="SA^U:User(s);D:Division(s);A:All users;Q:Quit",DIR("A")="Do you want to select (U)sers, (D)ivisions, (A)ll users, (Q)uit: ",DIR("B")="D"
 W ! D ^DIR S XUANS=Y
 K DIR
 IF XUANS="^" Q
 IF XUANS="Q" Q
 IF XUANS="U" D 
 . S XUSER=$$U1("NULL") I +XUSER'>0 S XUEXIT=1 Q
 . W !
 . N Y,X,DIR
 . S DIR(0)="Y",DIR("B")="YES",DIR("A")="Are you ready to assign the Program Replacement Key <"_XUSKEY_"> to the users" D ^DIR
 . K DIR I +$G(Y)'>0 S XUEXIT=1 Q
 IF XUANS="D" D
 . S XUSDVSION=$$D1("NULL") I +XUSDVSION'>0 S XUEXIT=1 Q
 . W !!!,"Chosen Division(s):"
 . W !,"-------------------"
 . D LISTDVS(XUSDVSION)
 . W !
 . S DIR(0)="Y",DIR("B")="YES",DIR("A")="Are you ready to assign the Program Replacement Key <"_XUSKEY_"> to VistA users at above Division(s): " D ^DIR K DIR
 . I +Y'>0 S XUEXIT=1 Q
 . Q
 IF XUANS="A" S DIR(0)="Y",DIR("B")="YES",DIR("A")="Are you ready to assign the Program Replacement Key <"_XUSKEY_"> to ALL VistA users" D ^DIR K DIR I +Y'>0 S XUEXIT=1 Q
 I XUEXIT=1 Q
 ; Start Queue process
 S ZTRTN="ASSIGN^XUSEHRM1",ZTIO="" ;queue the process
 S ZTSAVE("XUSKEY")="",ZTSAVE("XUSDVSION")="",ZTSAVE("XUDUZ")="",ZTSAVE("XUSER")="",ZTSAVE("XUANS")=""
 S ZTDESC="Assign Keys for users."
 D ^%ZTLOAD
 I $D(ZTSK) W !!,"Task #: ",ZTSK,!
 Q
 ;-------------------------------------------------------------
U1(XUS) ; select users
 N DIC,Y,X,XUTEXT,XUSER1U,XUC1U
 S XUTEXT="Select a user: ",XUSER1U="",XUC1U=0
LOOP1U ;
 S DIC="^VA(200,",DIC(0)="AEQM" S DIC("A")=XUTEXT D ^DIC
 I Y=-1,$G(X)="^" S XUC1U=0
 I +Y>0 S XUTEXT="Select another user: ",XUSER1U=XUSER1U_";"_+Y,XUC1U=XUC1U+1 G LOOP1U
 Q XUC1U_"^"_$P(XUSER1U,";",2,99)
 ;------------------------------------------------------------
D1(XUS) ; select Divisions
 N DIC,Y,X,XUTEXT,XUSER1D,XUC1D
 S XUTEXT="Select a division: ",XUSER1D="",XUC1D=0
LOOP1D ;
 S DIC="^DIC(4,",DIC(0)="AEQM" S DIC("A")=XUTEXT D ^DIC
 I Y=-1,$G(X)="^" S XUC1D=0
 I +Y>0 S XUTEXT="Select another division: ",XUSER1D=XUSER1D_";"_+Y,XUC1D=XUC1D+1 G LOOP1D
 Q XUC1D_"^"_$P(XUSER1D,";",2,99)
 ;--------------------------------------------------------------
2 ; remove a Program Replacement Key from all users
 N XUSASK,XUSDVSION,XUSKEY,XUDUZ,XUANS,XUSER,DIR,XUEXIT,ZTSK
 S XUSDUZ=$G(DUZ,.5),XUSER="",XUSDVSION="",XUSKEY="",XUEXIT=""
 S XUSKEY=+$$ASKKEY("What Program Replacement Key do you want to remove from VistA users? ") I XUSKEY'>0 G END
 S XUSKEY=$P($G(^DIC(19.1,XUSKEY,0)),"^")
 SET DIR(0)="SA^U:User(s);D:Division(s);A:All users;Q:Quit",DIR("A")="Do you want to select (U)sers, (D)ivisions, (A)ll users, (Q)uit: ",DIR("B")="D"
 W ! D ^DIR S XUANS=Y
 K DIR
 IF XUANS="^" Q
 IF XUANS="Q" Q
 IF XUANS="U" D 
 . S XUSER=$$U1("NULL") I +XUSER'>0 S XUEXIT=1 Q
 . W !
 . N Y,X,DIR
 . S DIR(0)="Y",DIR("B")="YES",DIR("A")="Are you ready to remove the Program Replacement Key <"_XUSKEY_"> from the users" D ^DIR
 . K DIR I +$G(Y)'>0 S XUEXIT=1 Q
 IF XUANS="D" D
 . S XUSDVSION=$$D1("NULL") I +XUSDVSION'>0 S XUEXIT=1 Q
 . W !!!,"Chosen Division(s):"
 . W !,"-------------------"
 . D LISTDVS(XUSDVSION)
 . W !
 . S DIR(0)="Y",DIR("B")="YES",DIR("A")="Are you ready to remove the Program Replacement Key <"_XUSKEY_"> from VistA users at above Division(s): " D ^DIR K DIR
 . I +Y'>0 S XUEXIT=1 Q
 . Q
 IF XUANS="A" S DIR(0)="Y",DIR("B")="YES",DIR("A")="Are you ready to remove the Program Replacement Key <"_XUSKEY_"> from ALL VistA users" D ^DIR K DIR I +Y'>0 S XUEXIT=1 Q
 ; Start Queue process
 I XUEXIT=1 Q
 S ZTRTN="REMOVE^XUSEHRM1",ZTIO=""  ;queue the process
 S ZTSAVE("XUSKEY")="",ZTSAVE("XUSDVSION")="",ZTSAVE("XUDUZ")="",ZTSAVE("XUSER")="",ZTSAVE("XUANS")=""
 S ZTDESC="Remove Keys from users."
 D ^%ZTLOAD
 I $D(ZTSK) W !!,"Task #: ",ZTSK,!
 Q
 ;--------------------------------------------------
5 ; set REVERSE/NEGATIVE LOCK field
 N XUSKEY,XUSOPTN,XUSKEYN,DIR,XUANS,XUFLAG,ZTSK
 SET XUFLAG=0
 K ^XUBA758("ACTION758")
 SET XUSKEY=+$$ASKKEY("What Program Replacement Key do you want to assign to options? ") I XUSKEY'>0 Q
 SET XUSKEYN=$P($G(^DIC(19.1,XUSKEY,0)),"^")
 SET DIR(0)="SA^N:NameSpace;O:Option;Q:Quit",DIR("A")="Do you want to select (N)ameSpaces, (O)ptions, (Q)uit: ",DIR("B")="O"
 W ! D ^DIR S XUANS=Y
 IF XUANS="^" Q
 IF XUANS="N" D NAMESPACE
 IF XUANS="O" D OPTION
 IF XUANS="Q" Q
 I $D(^XUBA758("ACTION758"))'>0 Q
 SET ZTRTN="SETLOCKS^XUSEHRM1",ZTIO=""  ;queue the process
 SET ZTSAVE("XUSKEYN")="",ZTSAVE("^XUBA758")="",ZTSAVE("XUFLAG")=""
 SET ZTDESC="Add REVERSE/NEGATIVE LOCK field."
 DO ^%ZTLOAD
 IF $D(ZTSK) W !!,"Task #: ",ZTSK,!
 Q
 ;----------------------------------------------------
6 ; remove REVERSE/NEGATIVE LOCK field
 N XUSKEY,XUSOPTN,XUSKEYN,DIR,XUANS,XUCOUNT,XUFLAG,ZTSK
 S XUFLAG=1
 K ^XUBA758("ACTION758")
 SET XUSKEY=+$$ASKKEY("What Program Replacement Key do you want to remove from options? ") I XUSKEY'>0 Q
 SET XUSKEYN=$P($G(^DIC(19.1,XUSKEY,0)),"^")
 SET DIR(0)="SA^N:NameSpace;O:Option;Q:Quit",DIR("A")="Do you want to select (N)ameSpaces, (O)ptions, (Q)uit: ",DIR("B")="O"
 W ! D ^DIR S XUANS=Y
 IF XUANS="^" Q
 IF XUANS="N" D NAMESPACE
 IF XUANS="O" D OPTION
 IF XUANS="Q" Q
 I $D(^XUBA758("ACTION758"))'>0 Q
 SET ZTRTN="DELOCKS^XUSEHRM1",ZTIO=""  ;queue the process
 SET ZTSAVE("XUSKEYN")="",ZTSAVE("^XUBA758")="",ZTSAVE("XUFLAG")=""
 SET ZTDESC="Remove REVERSE/NEGATIVE LOCK field."
 DO ^%ZTLOAD
 IF $D(ZTSK) W !!,"Task #: ",ZTSK,!
 Q
 ;----------------------------------------------------------
YN(XUSTEXT) ; ask yes no question
 N DIR,Y
 S DIR(0)="Y",DIR("B")="YES",DIR("A")=XUSTEXT D ^DIR K DIR
 Q Y
 ;------------------------------------------------------
SELECOP(XUSTEXT,ACTION) ; select Option in the Option file
 ; ACTION is "ACTION758" or "NOACTION758"
 N DIC,Y,XUCOUNT
 K ^XUBA758(ACTION)
 S XUCOUNT=0
LOOP1 ;
 S DIC="^DIC(19,",DIC(0)="AEQ" S DIC("A")=XUSTEXT D ^DIC
 I Y=-1,$G(X)="^" G END
 I Y>0 D
 . I ACTION="NOACTION758" S ^XUBA758(ACTION,$J,+Y)="" G LOOP1
 . I ACTION="ACTION758" S XUCOUNT=XUCOUNT+1,^XUBA758(ACTION,$J,XUCOUNT)=Y G LOOP1
 Q XUCOUNT
 ;-------------------------------------------------------
LISTDVS(XUSDVSION) ; List the chosen DIVISIONS
 N XUS,XUS1,XUS2,XUS3
 S XUS=$P(XUSDVSION,"^")
 S XUS1=$P(XUSDVSION,"^",2,99)
 F XUS2=1:1:XUS D 
 . S XUS3=$P(XUS1,";",XUS2) W !,$P($G(^DIC(4,XUS3,0)),"^")
 Q
 ;----------------------------------------------------------
ASKKEY(XUSTEXT) ; select REPLACEMENT Keys
 N DIC,Y
BACK ;
 S DIC="^DIC(19.1,",DIC(0)="AEQ" S DIC("A")=XUSTEXT D ^DIC I Y'>0 Q Y
 I Y'["REPLACEMENT" W !!,"Invalid Program Replacement Key, it must contain <REPLACEMENT>",! G BACK
 Q Y
 ;----------------------------------------------------------
ASSDVS(XUSIEN4) ; set Key for user in specific one Division XUSIEN4 is the IEN in the INSTITUTION file.
 N XUS S XUS=0
 F  S XUS=$O(^VA(200,"AH",XUSIEN4,XUS)) Q:XUS'>0  D
 . I $D(^VA(200,XUS,0))'>0 Q
 . I $D(^XUSEC(XUSKEY,XUS))>0 Q  ; prevent a user has mutiple divisions
 . D SETKEY(XUS,XUSKEY)
 . I $D(^XUSEC(XUSKEY,XUS))>0 S XUCN=XUCN+1
 Q
 ;---------------------------------------------------------
ASSIGN ; assign the Program Replacement Key to all users
 N XUS,XUCN,XUSD1,XUSD2,XUI,XUSIEN4,XUIEN
 S XUS=0,XUCN=0
 S XUDUZ=$G(XUDUZ,DUZ),XUANS=$G(XUANS),XUSDVSION=$G(XUSDVSION),XUSER=$G(XUSER)
 I XUANS="D" D 
 . S XUSD1=$P(XUSDVSION,"^"),XUSD2=$P(XUSDVSION,"^",2)
 . F XUI=1:1:XUSD1 S XUSIEN4=$P(XUSD2,";",XUI) D ASSDVS(XUSIEN4)
 I XUANS="U" D
 . S XUSC1=$P(XUSER,"^"),XUSC2=$P(XUSER,"^",2)
 . F XUI=1:1:XUSC1 S XUIEN=$P(XUSC2,";",XUI) D SETKEY(XUIEN,XUSKEY)
 . S XUCN=XUSC1
 I XUANS="A" D
 . F  S XUS=$O(^VA(200,XUS)) Q:XUS'>0  D
 .. I $D(^VA(200,XUS,0))'>0
 .. D SETKEY(XUS,XUSKEY)
 .. I $D(^XUSEC(XUSKEY,XUS))>0 S XUCN=XUCN+1
 D SENDALERT(XUDUZ,XUSKEY,"Assigned",XUCN)
 K XUDUZ,XUSKEY,XUSER,XUANS
 Q
 ;-----------------------------------------------------------
SETKEY(XUS,XUSKEY) ;assign a Program Replacement Key for a user
 N IENS,XUSKEYN,ERR
 K FDA
 S IENS="?+2,"_XUS_","
 S FDA(200.051,IENS,.01)=XUSKEY
 D UPDATE^DIE("E","FDA",,"ERR")
 Q
 ;-----------------------------------------------------------
DELKEY(XUIEN,KEY) ;delete a Program Replacement Key for a user
 N DIK,DA S DA(1)=XUIEN,DA=KEY,DIK="^VA(200,"_DA(1)_",51," D ^DIK
 Q
 ;-----------------------------------------------------------
REMDVS(XUSIEN4) ; remove Program Replacement Key for users at specific one Division
 N XUS S XUS=0
 F  S XUS=$O(^VA(200,"AH",XUSIEN4,XUS)) Q:XUS'>0  D
  . I +$D(^XUSEC(XUSKEY,XUS))>0 D DELKEY(XUS,XUSKEY1) S XUCN=XUCN+1
 Q
 ;-----------------------------------------------------------
REMOVE ;remove a Program Replacement Key from all users
 N XUS,XUCN,XUSD1,XUSD2,XUI,XUSIEN4,XUIEN,XUSKEY1
 S XUS=0,XUCN=0
 S XUSKEY1=+$O(^DIC(19.1,"B",XUSKEY,0))
 I XUSKEY1'>0 Q
 S XUDUZ=$G(XUDUZ,DUZ),XUANS=$G(XUANS),XUSDVSION=$G(XUSDVSION),XUSER=$G(XUSER)
 I XUANS="D" D 
 . S XUSD1=$P(XUSDVSION,"^"),XUSD2=$P(XUSDVSION,"^",2)
 . F XUI=1:1:XUSD1 S XUSIEN4=$P(XUSD2,";",XUI) D REMDVS(XUSIEN4)
 I XUANS="U" D
 . S XUSC1=$P(XUSER,"^"),XUSC2=$P(XUSER,"^",2)
 . F XUI=1:1:XUSC1 S XUIEN=$P(XUSC2,";",XUI) D DELKEY(XUIEN,XUSKEY1)
 . S XUCN=XUSC1
 I XUANS="A" D
 . F  S XUS=$O(^XUSEC(XUSKEY,XUS)) Q:XUS'>0  D
 .. I $D(^VA(200,XUS,0))'>0
 .. D DELKEY(XUS,XUSKEY1) S XUCN=XUCN+1
 D SENDALERT(XUDUZ,XUSKEY,"Removed",XUCN)
 K XUDUZ,XUSKEY,XUSER,XUANS
 Q
 ;------------------------------------------------------------
GETOPTION(XUSOPTN,XUCOUNT) ;
 N XUOPTIEN,XUOPTIEN1
 S XUOPTIEN=0
 K OUT758
 S XUSOPTN=$P($G(XUSOPTN),"*")
 ;I XUSOPTN="" Q XUCOUNT
 D LIST^DIC(19,"","","",,XUSOPTN,XUSOPTN,"","","","OUT758")
 S OUT758("DILIST",1,.1)=XUSOPTN
 F  S XUOPTIEN=$O(OUT758("DILIST",1,XUOPTIEN)) Q:+XUOPTIEN'>0  D
 . S XUOPNAME=$G(OUT758("DILIST",1,XUOPTIEN)) Q:XUOPNAME=""
 . S XUOPTIEN1=$O(^DIC(19,"B",XUOPNAME,0)) Q:XUOPTIEN1'>0
 . S XUCOUNT=XUCOUNT+1,^XUBA758("ACTION758",$J,XUCOUNT)=XUOPTIEN1_"^"_XUOPNAME
 Q XUCOUNT
 ;------------------------------------------------------------
NAMESPACE ; Set Reversed Lock for NameSpaces
 N XUCOUNT,XU3
 S XUCOUNT=0
 S XUCOUNT=$$ASKNAMESP("Please select a NameSpace") Q:XUCOUNT=0
 S XUS3=$$PRINTOPTION(XUCOUNT,XUFLAG)
 I XUS3=0 G END
 D EXCLUDE
 Q 
 ;----------------------------------------------------------
OPTION ;Set Reversed Lock for Options
 N XUCOUNT,XU3
 S XUCOUNT=$$SELECOP("Select an option: ","ACTION758")
 S XUS3=$$PRINTOPTION(XUCOUNT,XUFLAG)
 I XUS3=0 G END
 D EXCLUDE
 Q
 ;-----------------------------------------------------------
ASKNAMESP(XUSTEXT) ; ask NameSpaces
 N DIR,Y,XUCOUNT,XUNEXT
 S XUCOUNT=0
 K ^XUBA758("ACTION758")
LOOPN ;
 S DIR(0)="FO^1:30",DIR("A")=$G(XUNEXT,XUSTEXT),DIR("?")="You may select a NameSpace* such as TIU* or one or more option names such as TIU MAIN MENU MGR, TIU MAIN MENU MRT"
 D ^DIR K DIR
 I Y="*" S XUNEXT="Invalid NameSpace, please choose another NameSpace. For example TIU*" G LOOPN
 I Y'="^",Y'="" S XUCOUNT=$$GETOPTION(Y,XUCOUNT) S XUNEXT="Another NameSpace" G LOOPN
 W !
 Q XUCOUNT
 ;----------------------------------------------------------
PRINTOPTION(XUCOUNT,XUFLAG) ; list options and ask users if they want to remove any options from the list.
 N XUI,XUY,XUZ,XU2,XU3
 S XUY="",XUZ=0,XU3=0
 K ^XUBA758("NOACTON758")
 W !,"Option list :"
 W !,"-----------------"
 F XUI=1:1:XUCOUNT D
 . S XUY=$P($G(^XUBA758("ACTION758",$J,XUI)),"^",2),XUY1=+$P($G(^XUBA758("ACTION758",$J,XUI)),"^")
 . I XUY1,XUFLAG=1,$P($G(^DIC(19,XUY1,3)),"^")'=XUSKEYN Q
 . S XUZ=XUZ+1,XU2=XUZ/2
 . I $P(XU2,".",2)=5 W !,XUY S XU3=XU3+1 Q
 . W ?40,XUY
 . S XU3=XU3+1
 . Q
 N XUOPTION,XUARE
 S XUOPTION="option",XUARE="is"
 IF XU3>1 S XUOPTION="options",XUARE="are"
 W !!,"There ",XUARE," ",XU3," ",XUOPTION," from the list above."
 Q XU3
 ;------------------------------------------------------------
EXCLUDE ; remove options from the list
 N ANS,XUN
 S ANS=$$YN("Do you want to remove any options from the list above")
 I ANS=0 Q
 I ANS="^" G END
 W !
 S XUN=$$SELECOP("Select an option: ","NOACTION758")
 W !
 Q
 ;-----------------------------------------------------------
END ;
 K ^XUBA758("ACTION758")
 K ^XUBA758("NOACTION758")
 Q
END1 ;
 ;-----------------------------------------------------------
SETLOCKS ; set REVERSE/NEGATIVE LOCK for options
 N XUOPTIEN,XUSECOND
 S XUI=0,XUSECOND=$O(^XUBA758("ACTION758",0)) I XUSECOND'>0 Q
 F  S XUI=$O(^XUBA758("ACTION758",XUSECOND,XUI)) Q:XUI'>0  D
 . S XUOPTIEN=+$G(^XUBA758("ACTION758",XUSECOND,XUI))
 . I XUOPTIEN="" Q
 . I $D(^XUBA758("NOACTION758",XUSECOND,XUOPTIEN)) Q
 . D SETLOCK(XUOPTIEN) ;set REVERSE/NEGATIVE LOCK
 D END
 Q
 ;-------------------------------------------------------------
SETLOCK(XUOPTIEN) ; set REVERSE/NEGATIVE LOCK for an option
 N DR,DIE
 S DIE="^DIC(19,",DA=XUOPTIEN
 S DR="3.01////^S X=XUSKEYN"
 D ^DIE
 Q
 ;--------------------------------------------------------------
DELOCKS ;remove REVERSE/NEGATIVE LOCK for options
 N XUOPTIEN,XUSECOND
 S XUI=0,XUSECOND=$O(^XUBA758("ACTION758",0)) I XUSECOND'>0 Q
 F  S XUI=$O(^XUBA758("ACTION758",XUSECOND,XUI)) Q:XUI'>0  D
 . S XUOPTIEN=+$G(^XUBA758("ACTION758",XUSECOND,XUI))
 . I XUOPTIEN'>0 Q
 . I $P($G(^DIC(19,XUOPTIEN,3)),"^")'=XUSKEYN Q
 . I $D(^XUBA758("NOACTION758",XUSECOND,XUOPTIEN)) Q
 . D DELOCK(XUOPTIEN) ;remove REVERSE/NEGATIVE LOCK
 D END
 Q
 ;--------------------------------------------------------------
DELOCK(XUOPTIEN) ; remove REVERSE/NEGATIVE LOCK for an option
 N DR,DIE,XUSKEYN
 S XUSKEYN="@"
 S DIE="^DIC(19,",DA=XUOPTIEN
 S DR="3.01////^S X=XUSKEYN"
 D ^DIE
 Q
 ;--------------------------------------------------------------
SENDALERT(XUDUZ,XUKEY,STATUS,XUCN) ; send alert to user
 ;XUDUZ is IEN of user
 ;XUKEY is Replacement Key
 ;STATUS is Assign or Remoe
 ;XUCN is number of users
 N XQA,XQAARCH,XQADATA,XQAFLG,XQAGUID,XQAID,XQAMSG,XQAOPT,XQAROU,XQASUPV,XQASURO,XQATEXT,XQALERR,XQVAR
 N XUDATE S XUDATE=$$NOW^XLFDT,XUDATE=$$FMTE^XLFDT(XUDATE,1)
 S XQA(XUDUZ)="" ; recipient is user
 S XQAMSG=XUCN_" users are "_STATUS_" the Program Replacement Key "_XUKEY_" on "_XUDATE_"."
 S XQVAR=$$SETUP1^XQALERT I $G(XQALERR)'="" W !,"ERROR IN ALERT: ",XQALERR
 Q
 ;---------------------------------------------------------------
