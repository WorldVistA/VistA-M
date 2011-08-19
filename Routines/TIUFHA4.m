TIUFHA4 ; SLC/MAM - LM Templates H and A action Edit Name/Owner/PrintName ;4/17/97  11:02
 ;;1.0;TEXT INTEGRATION UTILITIES;**13**;Jun 20, 1997
EDATTR ; Actions Edit Name/Owner/PrintName.
 N FIELDS,ATTR,OLDLNO,TIUFDA,NEWLNO,TIUFXNOD,TIUFFULL,EDIT
 N DTOUT,DIRUT,DIROUT
 S VALMBCK="",TIUFXNOD=$G(XQORNOD(0))
 S EDIT=$S(TIUFXNOD["Print":"PRINT NAME",TIUFXNOD["Owner":"OWNER",1:"NAME")
 W !!,"Selecting entries for "_EDIT_" Edit"
 D EN^VALM2(XQORNOD,"O") I '$O(VALMY(0)) G EDATX
 S OLDLNO=0 F  S OLDLNO=$O(VALMY(OLDLNO)) Q:'OLDLNO  S TIUFDA(OLDLNO)=$P(^TMP("TIUF1IDX",$J,OLDLNO),U,2)
 I TIUFTMPL="A"!(TIUFTMPL="J") D  ;if Temp=A,J delete selected entries:
 . S OLDLNO=0 F  S OLDLNO=$O(VALMY(OLDLNO)) Q:'OLDLNO  D
 . . S NEWLNO=$O(^TMP("TIUF1IDX",$J,"DAF",TIUFDA(OLDLNO),0)) D UPDATE^TIUFLLM1("A",-1,NEWLNO-1) S VALMCNT=VALMCNT-1
 S FIELDS=$S(EDIT="NAME":";.01;",EDIT="OWNER":";.05;.06;",1:";.03;")
 D BASIC(EDIT)
EDATX I $D(DTOUT) S VALMBCK="Q" Q
 I $G(TIUFFULL) S VALMBCK="R" D RESET^TIUFXHLX
 Q
 ;
BASIC(EDIT) ; Edit one basic field.
 N LINENO,FILEDA,NODE0,CNTCHNG,NOMATCH,STATUS,EXITFLG,MSG
 N SHARED,NATL,TYPE,PFILEDA,PLINENO,BYPASS
 S LINENO=0 K DUOUT
 F  S LINENO=$O(VALMY(LINENO)) Q:'LINENO!$D(DTOUT)!$D(DUOUT)  D
 . S FILEDA=TIUFDA(LINENO),NODE0=^TIU(8925.1,FILEDA,0),NATL=+$P(NODE0,U,13),TYPE=$P(NODE0,U,4),STATUS=$$STATWORD^TIUFLF5($P(NODE0,U,7)),SHARED=$P(NODE0,U,10)
 . S NOMATCH=0,MSG=" Editing Entry "_LINENO W !!,MSG
 . I TIUFWHO'="N",NATL,EDIT'="OWNER" S MSG=" Entry "_LINENO_" is National; Can't Edit" W !!,MSG,! D PAUSE^TIUFXHLX G AUPDATE
 . ; W Msg, G AUPDATE if editing field other than Owner and active and not Shared component or Object, and not Natl User.
 . ; G AUPDATE if editing field other than Owner and active and Natl user and user chooses NO.
 . I SHARED,TIUFTMPL'="A" W !,"Shared Components can be edited only through the SORT Option",! D PAUSE^TIUFXHLX G AUPDATE
 . I EDIT'="OWNER",SHARED,'$$PERSOWNS^TIUFLF2(FILEDA,DUZ) W !,"Only the Owner can edit Shared Components",! D PAUSE^TIUFXHLX G AUPDATE
 . I EDIT'="OWNER",TYPE="O" W !,"To Edit Name or Print Name of an Object, please select Detailed Display and then",!,"select Basics.",! D PAUSE^TIUFXHLX G AUPDATE
 . I EDIT'="OWNER",SHARED,'$$CANEDIT^TIUFLF6(FILEDA) W !,"Shared Component has parent that isn't Inactive: Can't Edit",! D PAUSE^TIUFXHLX G AUPDATE
 . I 'SHARED,STATUS="NO/BAD",TYPE'="O" W !!," Entry has No Status/Bad Status; Can't Edit",! D PAUSE^TIUFXHLX G AUPDATE
 . I 'SHARED,EDIT'="OWNER",STATUS'="INACTIVE" K DIRUT D  Q:$D(DTOUT)  G:TIUFWHO'="N" AUPDATE G:$D(DIRUT)!(BYPASS'=1) AUPDATE
 . . I TIUFWHO'="N" W !!," Entry "_LINENO_" is not Inactive; Can't Edit",! D PAUSE^TIUFXHLX Q
 . . N DIR,X,Y D  ; Let Natl Developer choose to bypass safety:
 . . . S DIR(0)="Y",(DIR("A",1),DIR("A",2),DIR("A",3))="  "
 . . . S DIR("A",4)=" Entry "_LINENO_" is Active.  Do you want to bypass safety measures and edit"
 . . . S DIR("A",5)="even though this may cause errors if e.g. a document is being entered"
 . . . S DIR("A")="on this entry.",DIR("B")="NO" D ^DIR S BYPASS=Y K DIR,X,Y
 . L +^TIU(8925.1,FILEDA):1 I '$T W !!,"Another user is editing this entry; please try later.",! H 2 G LOOPX
 . S EXITFLG=0 D ASKFLDS^TIUFLF1(FILEDA,FIELDS,0,0,.EXITFLG) G:$D(DTOUT) LOOPX
 . G:EXITFLG AUPDATE
 . S NODE0=^TIU(8925.1,FILEDA,0),VALMBCK="R"
 . I TIUFTMPL="H" N INFO S INFO=^TMP("TIUF1IDX",$J,LINENO) D LINEUP^TIUFLLM1(.INFO,"H") G LOOPX
AUPDATE . I TIUFTMPL="A"!(TIUFTMPL="J") D
 . . S NODE0=^TIU(8925.1,FILEDA,0)
 . . D AUPDATE^TIUFLA1(NODE0,FILEDA,.CNTCHNG) S:CNTCHNG=1 VALMCNT=VALMCNT+1 I 'CNTCHNG S NOMATCH=1
 . . I NOMATCH S MSG=" Edited Entry Not in current View" W !!,MSG,! K MSG D PAUSE^TIUFXHLX
LOOPX . L -^TIU(8925.1,FILEDA)
 Q
 ;
