TIUPLST ; SLC/JER - Enter/edit personal document pick-list ;13-JUL-2000 10:43:41
 ;;1.0;TEXT INTEGRATION UTILITIES;**91,103**;Jun 20, 1997
MAIN ; Control branching
 N DA,TIUFPRIV,DUOUT,DTOUT
 S TIUFPRIV=1
 D INTROTXT
 I $S($D(DUOUT):1,$D(DTOUT):1,$D(DIROUT):1,1:0) Q
 D GETEDIT
 Q
INTROTXT ; Write Introductory Text for the Option
 W !
 D JUSTIFY^TIUU("--- Personal Document Lists ---","C")
 W !!,"This option allows you to create and maintain lists of TITLES for any of the"
 W !,"active CLASSES of documents supported by TIU at your site.",!
 I '$$READ^TIUU("Y","Explain Details","NO") Q
 W !!,"When you use the option to enter a document belonging to a given class"
 W !,"you will be asked to select a TITLE belonging to that class."
 W !!,"For any particular class, you may find that you only wish to choose from"
 W !,"among a few highly specific titles (e.g., if you are a Pulmonologist"
 W !,"entering a PROGRESS NOTE, you may wish to choose from a short list of"
 W !,"three or four titles related to Pulmonary Function, or Pulmonary Disease)."
 W !,"Rather than presenting you with a list of hundreds of unrelated titles,"
 W !,"TIU will present you with the list you name here."
 W !!,"In the event that you need to select a TITLE which doesn't appear on your"
 W !,"list, you will always be able to do so."
 W !!,"NOTE:  If you expect to enter a single title, or would be unduely restricted"
 W !,"by use of a short list, then we recommend that you bypass the creation of"
 W !,"a list, and simply enter a DEFAULT TITLE for the class...This option will"
 W !,"afford you the opportunity to do so.",!
 Q
GETEDIT ; Get record in picklist file, determine action
 N D,DIC,TIUNM,X,Y,CREATE,PROMPT
 S TIUNM=$P(^VA(200,+$G(DUZ),0),U)
 W !,"   Enter/edit Personal Document List"
 I +$O(^TIU(8925.98,"B",DUZ,0))'>0 D  Q
 . S Y=+$$NEWLIST(TIUNM,1)
 . I +Y>0 D EDIT(+Y)
 W !!,"You already have one or more Personal Lists...",!
 S PROMPT="You may (E)dit, (D)elete, or (C)reate a List: "
 S CREATE=$P($$READ^TIUU("SA^E:edit;D:delete;C:create",PROMPT,"EDIT"),U)
 I $S(CREATE="":1,$D(DUOUT):1,$D(DTOUT):1,$D(DIROUT):1,1:0) Q
 I CREATE="C" S Y=+$$NEWLIST(TIUNM) D:+Y>0 EDIT(+Y) Q
 W !!,"Please choose a list to ",$S(CREATE="E":"Edit",1:"Delete"),"...",!
 S DIC=8925.98,DIC(0)="ENZ",D="B",X=DUZ
 S DIC("S")="I +$G(^TIU(8925.98,+Y,0))=DUZ"
 S DIC("W")="W ?21,"" "",$E($$DOCNAME^TIUPLST($P(^TIU(8925.98,+Y,0),U,2)),1,34)"
 D IX^DIC
 ;TIU*1*91 limit NEWLIST to CREATE=E (If include D & get good Y from NEWLIST, still deletes, never get to edit):
 I +Y'>0,CREATE="E" W !!,"No List Selected...",! S Y=+$$NEWLIST(TIUNM,1)
 I +Y'>0 W !!,"No changes made..." Q
 I CREATE="D" D DELETE(+Y) Q
 D EDIT(+Y)
 Q
DOCNAME(TIUDA) ; Get the NAME (.01) field of the document
 Q $P($G(^TIU(8925.1,+TIUDA,0)),U)
NEWLIST(TIUNM,ASK) ; Create a new List for the user
 N ASKNEW,DIC,DLAYGO,Y
 S DIC="^TIU(8925.98,",DLAYGO=8925.98,DIC(0)="UNXLZ",ASKNEW=1
 I +$G(ASK) S ASKNEW=$$READ^TIUU("Y","Add a new Personal Document List","YES")
 I +ASKNEW'>0 S Y=-1 G NEWX
 S X=DUZ,D="B"
 S X=""""_"`"_X_""""
 W !!,"Creating a new Personal Document List...",!
 D IX^DIC
 ;TIU*1*91 If DIC adds new entry, can get anyone w/ same name:
 I Y>0,+Y(0)'=DUZ N DA,DIK D
 . W !!,"   Sorry, you can create lists for YOURSELF only.  Please try again."
 . I $P(Y,U,3)=1 S DA=+Y,DIK="^TIU(8925.98," D ^DIK S Y=-1
NEWX Q +$G(Y)
 ;
DELETE(DA) ; Call ^DIK to delete the list
 N YASURE,TIUNAME S YASURE=0
 S TIUNAME=$$UP^XLFSTR($$PNAME^TIULC1($P(^TIU(8925.98,+DA,0),U,2)))
 I TIUNAME'="UNKNOWN" D
 . W !!,"You are about to DELETE your entry for CLASS "
 . W TIUNAME,!
 . S YASURE=$$READ^TIUU("Y","Are you SURE","NO")
 I TIUNAME="UNKNOWN" D
 . W !!,"You must specify a CLASS in order to maintain the list.",!
 . S YASURE=1
 I +YASURE'>0 W !!,"Nothing deleted...No harm done!" Q
 D DIK(DA,TIUNAME)
 Q
DIK(DA,TIUNAME) ; Remove a list
 N DIK
 S DIK="^TIU(8925.98,"
 D ^DIK
 I $G(TIUNAME)]"" W !,TIUNAME," List DELETED."
 Q
EDIT(DA) ; Call ^DIE to edit the record
 N DIE,DIRUT,DIROUT,DTOUT,DR,X,Y,TIUCLASS,TIUASK
 S DIE=8925.98
 S DR="[TIU ENTER/EDIT PERSONAL LIST]"
 D ^DIE  Q:$D(Y)!$D(DTOUT)
 I $G(TIUCLASS)="" D DIK(DA,"")
 Q
ALREADY(TIUCLASS) ; Indicate that a List for TIUCLASS already exists
 W !!,$C(7),"You already have a list for class ",$$PNAME^TIULC1(TIUCLASS),"."
 W !!,"Please Edit that list instead..."
 Q
