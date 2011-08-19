USRPS24 ; SLC/MAM -  After installing TIU*1.0*165;6/18/03
 ;;1.0;AUTHORIZATION/SUBSCRIPTION;**24**;Jun 20, 1997
 ; Run this after installing patch 165.
 ;Use option: TIU165 DDEFS & RULES, PRF
 ;
MAIN ; Create new User Class & new Business Rules
 ; -- Check for potential dup User Class created after install
 ;    but before option:
 K ^TMP("USR24",$J)
 D SETXTMP^USREN24
 N USRDUPS,TMPCNT,SILENT
 S TMPCNT=0
 S TMPCNT=TMPCNT+1,^TMP("USR24",$J,TMPCNT)=""
 S TMPCNT=TMPCNT+1,^TMP("USR24",$J,TMPCNT)="        ***** User Class and Rules for PATIENT RECORD FLAGS *****"
 S TMPCNT=TMPCNT+1,^TMP("USR24",$J,TMPCNT)=""
 S SILENT=1
 S USRDUPS=$$USRDUPS^USREN24(SILENT)
 I $G(USRDUPS) D  G MAINX
 . S TMPCNT=TMPCNT+1,^TMP("USR24",$J,TMPCNT)="Duplicate problem.  See description for patch TIU*1*165,"
 . S TMPCNT=TMPCNT+1,^TMP("USR24",$J,TMPCNT)="in the National Patch Module."
 N DONE,SUCCESS
 ; -- If User Class previously created by this patch,
 ;    say so and quit:
 S DONE=+$G(^XTMP("USR24","DONE"))
 I DONE>0 D  G MAINX
 . S TMPCNT=TMPCNT+1,^TMP("USR24",$J,TMPCNT)="User Class and, presumably, Business Rules"
 . S TMPCNT=TMPCNT+1,^TMP("USR24",$J,TMPCNT)="    were already created in a previous install."
 ; -- Create new User Class:
 D NEWCLASS(.SUCCESS,.TMPCNT)
 ; -- Create new Business Rules:
 I SUCCESS D NEWRULES(.TMPCNT)
MAINX ; Exit
 S TMPCNT=TMPCNT+1,^TMP("USR24",$J,TMPCNT)=""
 S TMPCNT=TMPCNT+1,^TMP("USR24",$J,TMPCNT)="                             *********"
 Q
 ;
NEWCLASS(SUCCESS,TMPCNT) ; Create one new User Class in file 8930
 N FDA,USRIEN,CLASSDA
 S SUCCESS=1
 ; -- Create new User Class:
 M FDA(8930,"+1,")=^XTMP("USR24","USRCLAS")
 D UPDATE^DIE("E","FDA","USRIEN")
 S CLASSDA=+$G(USRIEN(1))
 I CLASSDA'>0 D  Q
 . S TMPCNT=TMPCNT+1,^TMP("USR24",$J,TMPCNT)="Couldn't create a User Class named "_^XTMP("USR24","USRCLAS",.01)_"."
 . S TMPCNT=TMPCNT+1,^TMP("USR24",$J,TMPCNT)="    Please contact National VistA Support."
 . S SUCCESS=0
 S TMPCNT=TMPCNT+1,^TMP("USR24",$J,TMPCNT)="User Class named "_^XTMP("USR24","USRCLAS",.01)
 S TMPCNT=TMPCNT+1,^TMP("USR24",$J,TMPCNT)="    created successfully."
 ; -- Set "DONE" node to IEN:
 S ^XTMP("USR24","DONE")=CLASSDA
 Q
 ;
NEWRULES(TMPCNT) ; Create new Business Rule
 ; Create rule for ONE User Class & ONE DDEF
 ; -- Set data for rule:
 D SETDATA(.TMPCNT)
 N NUM,SUCCESS
 S SUCCESS=1,NUM=0
 ; -- Loop through numbered list of rules (one, in this case):
 I '$O(^XTMP("USR24","RULES",0)) S SUCCESS=0 Q
 F  S NUM=$O(^XTMP("USR24","RULES",NUM)) Q:'NUM  D
 . N USRERR,FDA,DESC
 . M FDA(8930.1,"+1,")=^XTMP("USR24","RULES",NUM)
 . M DESC=^XTMP("USR24","RULESDESC")
 . S FDA(8930.1,"+1,",1)="DESC"
 . D UPDATE^DIE("","FDA","","USRERR")
 . I $D(USRERR) S SUCCESS=0 Q
 . K ^XTMP("USR24","RULES",NUM)
 K ^XTMP("USR24","RULESDESC")
 I '$G(SUCCESS) D  Q
 . S TMPCNT=TMPCNT+1,^TMP("USR24",$J,TMPCNT)=""
 . S TMPCNT=TMPCNT+1,^TMP("USR24",$J,TMPCNT)="Problem creating Business Rule. Please contact National VistA Support."
 S TMPCNT=TMPCNT+1,^TMP("USR24",$J,TMPCNT)=""
 S TMPCNT=TMPCNT+1,^TMP("USR24",$J,TMPCNT)="Business Rule created successfully."
 Q
 ;
SETDATA(TMPCNT) ; Set data for rule
 ; -- Set data for exported Rule into Rule node of ^XTMP.
 ;    Use interior data since there may be dup DDEF names.
 ;    Must set AFTER User Class is created:
 N DDEFIEN,USRCLASS,EXACTION,INACTION,EXSTATUS,INSTATUS
 ; -- Get IEN of DDEF Number 1. (DDEF Number 1 is DC,
 ;    PATIENT RECORD FLAG CAT I.  See ^TIUEN165.)
 S DDEFIEN=$G(^XTMP("TIU165","BASICS",1,"DONE"))
 I DDEFIEN'>0 D  G SETX
 . S TMPCNT=TMPCNT+1,^TMP("USR23",$J,TMPCNT)=""
 . S TMPCNT=TMPCNT+1,^TMP("USR23",$J,TMPCNT)="Can't find Document Definition for rules. Contact National VistA Support."
 ; -- Get IEN of User Class created earlier:
 S USRCLASS=+$G(^XTMP("USR24","DONE"))
 ; -- Set data for flds .01 (DDEF) and .04 (User Class) for rule:
 S ^XTMP("USR24","RULES",1,.01)=DDEFIEN
 S ^XTMP("USR24","RULES",1,.04)=USRCLASS
 ; -- Set rule desc data:
 S ^XTMP("USR24","RULESDESC",1)="This rule limits note entry to persons specially trained to assign and"
 S ^XTMP("USR24","RULESDESC",2)="document the assignment of Category I Patient Record Flags."
 S ^XTMP("USR24","RULESDESC",3)="Sites must not alter or delete this User Class."
 S ^XTMP("USR24","RULESDESC",4)="Sites must not alter, delete, or override this rule."
 S ^XTMP("USR24","RULESDESC",5)="Rule created by patch USR*1*24."
 ; -- Set action and status data for rule:
 S EXACTION="ENTRY"
 S INACTION=$O(^USR(8930.8,"B",EXACTION,0))
 S ^XTMP("USR24","RULES",1,.03)=INACTION
 S EXSTATUS="UNTRANSCRIBED"
 S INSTATUS=$O(^USR(8930.6,"B",EXSTATUS,0))
 S ^XTMP("USR24","RULES",1,.02)=INSTATUS
SETX ;
 Q
