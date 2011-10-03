HLPOSTQ ;ALB/JRP - POST-INIT QUESTIONS;23-MAR-95
 ;;1.6;HEALTH LEVEL SEVEN;;Oct 13, 1995
RUNAGAIN(RUNDATE) ;ASK USER IF POST-INIT SHOULD BE RUN AGAIN
 ;INPUT  : RUNDATE - Date post-init was originally run
 ;OUTPUT : 1 = Yes
 ;         0 = No
 ;        -1 = Error (bad input/time out/user abort)
 ;
 ;CHECK INPUT
 Q:('$G(RUNDATE)) -1
 Q:(RUNDATE'?7N.1".".6N) -1
 ;DECLARE VARIABLES
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S Y=RUNDATE
 X ^DD("DD")
 S RUNDATE=$P(Y,"@",1)_" @ "_$P(Y,"@",2)
 S DIR(0)="YA"
 S DIR("A")="Do you wish to continue ? "
 S DIR("A",1)="Post-init was already run on "_RUNDATE
 S DIR("B")="NO"
 S DIR("?",1)="This post-init has already been run.  Answering 'YES' will allow you to"
 S DIR("?",2)="selectively re-run portions of the post-init.  If you do not want to do"
 S DIR("?")="this, answer 'NO' (the default response)."
 W !!
 D ^DIR
 ;USER ABORT
 Q:($D(DIRUT)) -1
 ;RETURN Y
 Q (+Y)
PROTINST() ;ASK USER IF PROTOCOLS SHOULD BE RE-INSTALLED
 ;INPUT  : None
 ;OUTPUT : 1 = Yes
 ;         0 = No
 ;        -1 = Error (bad input/time out/user abort)
 ;
 ;DECLARE VARIABLES
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="YA"
 S DIR("A")="Do you want to re-install PROTOCOLS ? "
 S DIR("B")="YES"
 S DIR("?",1)="This package distributes a set of protocols which may have already"
 S DIR("?",2)="been installed.  Answering 'YES' (the default and recommended response)"
 S DIR("?")="will re-install these protocols."
 W !!
 D ^DIR
 ;USER ABORT
 Q:($D(DIRUT)) -1
 ;RETURN Y
 Q (+Y)
LISTINST() ;ASK USER IF LIST TEMPLATES SHOULD BE RE-INSTALLED
 ;INPUT  : None
 ;OUTPUT : 1 = Yes
 ;         0 = No
 ;        -1 = Error (bad input/time out/user abort)
 ;
 ;DECLARE VARIABLES
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="YA"
 S DIR("A")="Do you want to re-install LIST TEMPLATES ? "
 S DIR("B")="YES"
 S DIR("?",1)="This package distributes a set of list templates which may have already"
 S DIR("?",2)="been installed.  Answering 'YES' (the default and recommended response)"
 S DIR("?")="will re-install these list templates."
 W !!
 D ^DIR
 ;USER ABORT
 Q:($D(DIRUT)) -1
 ;RETURN Y
 Q (+Y)
FILECNV() ;ASK USER IF FILE CONVERSIONS SHOULD BE RE-RUN
 ;INPUT  : None
 ;OUTPUT : 1 = Yes
 ;         0 = No
 ;        -1 = Error (bad input/time out/user abort)
 ;
 ;DECLARE VARIABLES
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="YA"
 S DIR("A")="Do you want to re-run the file conversions ? "
 S DIR("B")="YES"
 S DIR("?",1)="Installation of this package requires that a set of file conversions be"
 S DIR("?",2)="run.  Answering 'YES' (the default and recommended response) will allow"
 S DIR("?",3)="these conversions to be re-run.  Answer 'NO' if the file conversions"
 S DIR("?")="have already run to completion."
 W !!
 D ^DIR
 ;USER ABORT
 Q:($D(DIRUT))
 ;RETURN Y
 Q (+Y)
