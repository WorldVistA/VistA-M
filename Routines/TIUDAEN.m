TIUDAEN ; SLC/AJB - Disclosure of Adverse Event Note ; August 10, 2005
 ;;1.0;TEXT INTEGRATION UTILITIES;**191**;Jun 20, 1997
 ;
 Q
EN ;
 X ^%ZOSF("EON") W IOCUON,@IOF ; prepares screen during install
 N DTOUT,DUOUT,TIU,TIUFPRIV,TIUIEN,TIUMSG,TIUPRNT,TIUTMP S TIUFPRIV=1
 I $$LOOKUP(8930,"CLINICAL COORDINATOR","X")<0 W !!,"Installation Error:  CLASS OWNER cannot be defined." S XPDABORT=1 G EXIT
 I $$LOOKUP(8925.1,"DISCLOSURE OF ADVERSE EVENT NOTE","X")>0 W !!,"Installation Error:  DISCLOSURE OF ADVERSE EVENT NOTE already exists." S XPDABORT=1 G EXIT
 F  D  Q:TIUPRNT>0!($D(XPDABORT))
 . W ! S TIUPRNT=$$LOOKUP(8925.1,,"AEQ","I $P(^(0),U,4)=""DC""","Select TIU DOCUMENT CLASS name:  ")
 . I $D(DTOUT) W !!,"Installation Aborted due to TIMEOUT." S XPDABORT=1 Q
 . I $D(DUOUT) W !!,"Installation Aborted by USER." S XPDABORT=1 Q
 . I TIUPRNT<0 W !!,"Installation Error:  Invalid Selection",!
 . I  W !,"A DOCUMENT CLASS must be entered or '^' to abort." Q
 . W ! I '$$READ^TIUU("Y","Is this correct","YES") S TIUPRNT=0
 I +$G(TIUPRNT)'>0 G EXIT
 S TIU(8925.1,"+1,",.01)="DISCLOSURE OF ADVERSE EVENT NOTE"
 S TIU(8925.1,"+1,",.02)=""
 S TIU(8925.1,"+1,",.03)="DISCLOSURE OF ADVERSE EVENT NOTE"
 S TIU(8925.1,"+1,",.04)="DOC"
 S TIU(8925.1,"+1,",.05)=""
 S TIU(8925.1,"+1,",.06)=$$LOOKUP(8930,"CLINICAL COORDINATOR")
 S TIU(8925.1,"+1,",.07)=13
 S TIU(8925.1,"+1,",3.02)=1
 S TIU(8925.1,"+1,",99)=$H
 W !!,"Creating DISCLOSURE OF ADVERSE EVENT NOTE title..."
 D UPDATE^DIE("","TIU","TIUIEN","TIUMSG")
 I $D(TIUMSG) D  S XPDABORT=1 G EXIT
 . W !!,"The following error message was returned:",!
 . S TIUMSG="" F  S TIUMSG=$O(TIUMSG("DIERR",1,"TEXT",TIUMSG)) Q:TIUMSG=""  W !,TIUMSG("DIERR",1,"TEXT",TIUMSG)
 W "DONE."
 S TIU(8925.14,"+2,"_TIUPRNT_",",.01)=TIUIEN(1)
 S TIU(8925.14,"+2,"_TIUPRNT_",",4)="Disclosure of Adverse Event Note"
 W !!,"Adding "_$P(^TIU(8925.1,TIUPRNT,0),U)_" as parent..."
 D UPDATE^DIE("","TIU","TIUIEN","TIUMSG")
 I $D(TIUMSG) D  S XPDABORT=1 G EXIT
 . W !!,"The following error message was returned:",!
 . S TIUMSG="" F  S TIUMSG=$O(TIUMSG("DIERR",1,"TEXT",TIUMSG)) Q:TIUMSG=""  W !,TIUMSG("DIERR",1,"TEXT",TIUMSG)
 W "DONE.",!
 D GETBOIL
 S TIUIEN(TIUIEN(1))=TIUIEN(1)
 S TIU(8925.1,TIUIEN(1)_",",3)="TIUTMP"
 W !,"Adding boilerplate text..."
 D UPDATE^DIE("","TIU","TIUIEN","TIUMSG")
 I $D(TIUMSG) D  S XPDABORT=1 G EXIT
 . W !!,"The following error message was returned:",!
 . S TIUMSG="" F  S TIUMSG=$O(TIUMSG("DIERR",1,"TEXT",TIUMSG)) Q:TIUMSG=""  W !,TIUMSG("DIERR",1,"TEXT",TIUMSG)
 W "DONE.",!
 W !,"*** The DISCLOSURE OF ADVERSE EVENT NOTE ***"
 W !,"*** title must be activated before use.     ***"
EXIT D
 .N DIR,X,Y S DIR(0)="E" W ! D ^DIR
 Q
REM ;
 N TIUTMP
 S TIUTMP=$$LOOKUP(8925.1,"DISCLOSURE OF ADVERSE EVENT NOTE")
 I TIUTMP>0 S $P(^TIU(8925.1,TIUTMP,0),U,13)=0
 Q
LOOKUP(FILE,NAME,TYPE,SCREEN,PROMPT) ;
 ; file = file # to perform lookup on
 ; [name]   = for instance lookups - required if type is missing
 ; [type]   = for inquiries to file (eg: "AEQ") - required if name is missing
 ; [screen] = screen for lookup/inquiries
 ; [prompt] = replace default prompt
 ;
 N DIC,X,Y S DIC=$G(FILE),DIC("S")=$G(SCREEN),X=$G(NAME)
 I $D(TYPE) S DIC(0)=TYPE
 I $D(PROMPT) S DIC("A")=PROMPT
 D ^DIC
 Q +Y
GETBOIL ;
 N LINE,LINETXT
 F LINE=1:1 S LINETXT=$P($T(BOILTXT+LINE),";;",2) Q:LINETXT="EOM"  S TIUTMP(LINE)=LINETXT
 Q
BOILTXT ;
 ;;DATE, TIME, AND PLACE OF DISCUSSION:
 ;;
 ;;
 ;;
 ;;NAMES OF THOSE PRESENT:
 ;;
 ;;
 ;;
 ;;DISCUSSION POINTS OF THE ADVERSE EVENT:
 ;;
 ;;
 ;;
 ;;OFFER OF ASSISTANCE INCLUDING BEREAVEMENT SUPPORT:
 ;;
 ;;
 ;;
 ;;QUESTIONS ADDRESSED IN THE DISCUSSION:
 ;;
 ;;
 ;;
 ;;ADVISEMENT OF 1151 CLAIMS PROCESS AND RIGHT TO FILE ADMINISTRATIVE
 ;;TORT CLAIM:
 ;;
 ;;
 ;;
 ;;CONTINUED COMMUNICATIONS REGARDING THE ADVERSE EVENT:
 ;;
 ;;
 ;;
 ;;EOM
 Q
