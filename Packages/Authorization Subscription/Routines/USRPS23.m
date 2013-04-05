USRPS23 ; SLC/MAM -  After installing TIU*1.0*137;6/16/03
 ;;1.0;AUTHORIZATION/SUBSCRIPTION;**23**;Jun 20, 1997
 ; Run this after installing patch 137.
 ;Use option: TIU137 DDEFS Rules, Anat Path
MAIN ; Create new User Class & new Business Rules
 ; -- Check for potential dup User Class created after install
 ;    but before option:
 K ^TMP("USR23",$J)
 D SETXTMP^USREN23
 N USRDUPS,TMPCNT,SILENT
 S TMPCNT=0
 S TMPCNT=TMPCNT+1,^TMP("USR23",$J,TMPCNT)=""
 S TMPCNT=TMPCNT+1,^TMP("USR23",$J,TMPCNT)="        ***** User Class and Rules for LABORATORY REPORTS *****"
 S TMPCNT=TMPCNT+1,^TMP("USR23",$J,TMPCNT)=""
 S SILENT=1
 S USRDUPS=$$USRDUPS^USREN23(SILENT)
 I $G(USRDUPS) D  G MAINX
 . S TMPCNT=TMPCNT+1,^TMP("USR23",$J,TMPCNT)="Duplicate problem.  See description for patch TIU*1*137,"
 . S TMPCNT=TMPCNT+1,^TMP("USR23",$J,TMPCNT)="in the National Patch Module."
 N DONE,SUCCESS
 ; -- If User Class previously created by this patch,
 ;    say so and quit:
 S DONE=+$G(^XTMP("USR23","DONE"))
 I DONE>0 D  G MAINX
 . S TMPCNT=TMPCNT+1,^TMP("USR23",$J,TMPCNT)="User Class and, presumably, Business Rules"
 . S TMPCNT=TMPCNT+1,^TMP("USR23",$J,TMPCNT)="    were already created in a previous install."
 ; -- Create new User Class:
 D NEWCLASS(.SUCCESS,.TMPCNT)
 ; -- Create new Business Rules:
 I SUCCESS D NEWRULES(.TMPCNT)
MAINX ; Exit
 S TMPCNT=TMPCNT+1,^TMP("USR23",$J,TMPCNT)=""
 S TMPCNT=TMPCNT+1,^TMP("USR23",$J,TMPCNT)="                             *********"
 Q
 ;
NEWCLASS(SUCCESS,TMPCNT) ; Create one new User Class in file 8930
 N FDA,USRIEN,CLASSDA
 S SUCCESS=1
 ; -- Create new User Class:
 M FDA(8930,"+1,")=^XTMP("USR23","USRCLAS")
 D UPDATE^DIE("E","FDA","USRIEN")
 S CLASSDA=+$G(USRIEN(1))
 I CLASSDA'>0 D  Q
 . S TMPCNT=TMPCNT+1,^TMP("USR23",$J,TMPCNT)="Couldn't create a User Class named "_^XTMP("USR23","USRCLAS",.01)_"."
 . S TMPCNT=TMPCNT+1,^TMP("USR23",$J,TMPCNT)="    Please contact National VistA Support."
 . S SUCCESS=0
 S TMPCNT=TMPCNT+1,^TMP("USR23",$J,TMPCNT)="User Class named "_^XTMP("USR23","USRCLAS",.01)
 S TMPCNT=TMPCNT+1,^TMP("USR23",$J,TMPCNT)="    created successfully."
 ; -- Set "DONE" node to IEN:
 S ^XTMP("USR23","DONE")=CLASSDA
 Q
 ;
NEWRULES(TMPCNT) ; Create new Business Rules
 ; Create rules for ONE User Class & ONE DDEF
 ; -- Set data for rules:
 D SETDATA(.TMPCNT)
 N NUM,SUCCESS
 S SUCCESS=1,NUM=0
 ; -- Loop through numbered list of rules:
 I '$O(^XTMP("USR23","RULES",0)) S SUCCESS=0 Q
 F  S NUM=$O(^XTMP("USR23","RULES",NUM)) Q:'NUM  D
 . N USRERR,FDA,DESC
 . M FDA(8930.1,"+1,")=^XTMP("USR23","RULES",NUM)
 . M DESC=^XTMP("USR23","RULESDESC")
 . S FDA(8930.1,"+1,",1)="DESC"
 . D UPDATE^DIE("","FDA","","USRERR")
 . I $D(USRERR) S SUCCESS=0 Q
 . K ^XTMP("USR23","RULES",NUM)
 K ^XTMP("USR23","RULESDESC")
 I '$G(SUCCESS) D  Q
 . S TMPCNT=TMPCNT+1,^TMP("USR23",$J,TMPCNT)=""
 . S TMPCNT=TMPCNT+1,^TMP("USR23",$J,TMPCNT)="Problem creating Business Rules. Please contact National VistA Support."
 S TMPCNT=TMPCNT+1,^TMP("USR23",$J,TMPCNT)=""
 S TMPCNT=TMPCNT+1,^TMP("USR23",$J,TMPCNT)="Business Rules created successfully."
 Q
 ;
SETDATA(TMPCNT) ; Set data for rules
 ; -- Set data for exported Rules into Rule nodes of ^XTMP.
 ;    Use interior data since there may be dup DDEF names.
 ;    Must set AFTER User Class is created:
 N DDEFIEN,USRCLASS,RULENUM,EXACTION
 ; -- Get IEN of DDEF Number 2. (DDEF Number 2 is DC,
 ;    LR ANATOMIC PATHOLOGY.  See ^TIUEN137.)
 S DDEFIEN=$G(^XTMP("TIU137","BASICS",2,"DONE"))
 I DDEFIEN'>0 D  G SETX
 . S TMPCNT=TMPCNT+1,^TMP("USR23",$J,TMPCNT)=""
 . S TMPCNT=TMPCNT+1,^TMP("USR23",$J,TMPCNT)="Can't find Document Definition for rules. Contact National VistA Support."
 ; -- Get IEN of User Class created earlier:
 S USRCLASS=+$G(^XTMP("USR23","DONE"))
 ; -- Set data for flds .01 (DDEF) and .04 (User Class) for all rules:
 F RULENUM=1:1:9 D
 . S ^XTMP("USR23","RULES",RULENUM,.01)=DDEFIEN
 . S ^XTMP("USR23","RULES",RULENUM,.04)=USRCLASS
 ; -- Set rule desc data (same for all rules):
 S ^XTMP("USR23","RULESDESC",1)="Using this empty class to prevent this action on Anatomic Pathology documents."
 S ^XTMP("USR23","RULESDESC",2)="These documents should be managed from the Anatomic Pathology menu only."
 S ^XTMP("USR23","RULESDESC",3)="Rule created by patch USR*1*23."
 ; -- Set action data for each rule; set status data according
 ;    to action:
 S RULENUM=0
 F EXACTION="AMENDMENT","CHANGE TITLE","COPY RECORD","DELETE RECORD","ENTRY","IDENTIFY SIGNERS","MAKE ADDENDUM","PRINT RECORD","REASSIGN" D
 . N INACTION,EXSTATUS,INSTATUS
 . S RULENUM=RULENUM+1
 . S INACTION=$O(^USR(8930.8,"B",EXACTION,0))
 . S ^XTMP("USR23","RULES",RULENUM,.03)=INACTION
 . ; -- For action ENTRY, status is untranscribed:
 . I EXACTION="ENTRY" D  Q
 . . S EXSTATUS="UNTRANSCRIBED"
 . . S INSTATUS=$O(^USR(8930.6,"B",EXSTATUS,0))
 . . S ^XTMP("USR23","RULES",RULENUM,.02)=INSTATUS
 . ; -- For all others, status is completed:
 . S EXSTATUS="COMPLETED"
 . S INSTATUS=$O(^USR(8930.6,"B",EXSTATUS,0))
 . S ^XTMP("USR23","RULES",RULENUM,.02)=INSTATUS
SETX ;
 Q
