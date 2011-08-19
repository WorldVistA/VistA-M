TIUFIX ; SLC/JER,MAM - Resolve Upload Filing Errors Library ;10/19/06  14:31
 ;;1.0;TEXT INTEGRATION UTILITIES;**131,211**;Jun 20, 1997;Build 26
 ;
TITLDFLT(TRANTITL,TIUTYPE,BADTYPES) ; Return default title
 ; Call with: [TRANTITL] - transcribed title
 ;             [TIUTYPE] - type of docmt being uploaded
 ;            [BADTYPES] - ^-delimited string of types default
 ;                         should NOT be (optional)
 ; Returns:        Title - transcribed title if TRANTITL is a 
 ;                         unique TITLE of type TIUTYPE and
 ;                         not of a type in list BADTYPES.
 ;                         Null Otherwise
 N DIC,X,Y,TITLE,TITLDA
 S DIC=8925.1,DIC(0)="X"
 S X=TRANTITL,DIC("S")="I $P(^(0),U,4)=""DOC""" D ^DIC
 D ^DIC
 S TITLDA=+Y
 S TITLE=$S(Y>0:$P(Y,U,2),1:"")
 ; -- Require/Disallow types:
 I TITLDA>0,+$$ISA^TIULX(TITLDA,TIUTYPE)'>0 S TITLE=""
 I TITLDA>0,$$ISTYPE(TITLDA,BADTYPES) S TITLE=""
 Q TITLE
 ;
ISTYPE(TITLDA,TYPELIST) ; Is TITLDA in list TYPELIST?
 ; Requires TITLDA
 ; Requires TYPELIST of form typeien^typeien^typeien etc., or null
 N ANS,TIUI,TYPE
 S ANS=0
 F TIUI=1:+1 S TYPE=$P(TYPELIST,U,TIUI) Q:'TYPE  D  G:ANS ISTYPEX
 . I +$$ISA^TIULX(TITLDA,TYPE)>0 S ANS=1
ISTYPEX Q ANS
 ;
GETTITLE(SUCCESS,TIUTYPE,TIUFLDS,TITLDA,BADTYPES,ASK) ; Get title from user
 ;   SUCCESS - Passed back
 ;   TIUTYPE - Type of docmt being uploaded
 ;   TIUFLDS - Array of transcribed data, as set in LOADHDR^TIUFIX2
 ;    TITLDA - Gotten from user and passed back
 ;  BADTYPES - ^-delimited list of types title CANNOT be (optional)
 ;       ASK - Flag to ask user if they want to change
 ;             type to progress note (optional)
 N DEFAULT,Y,SCREEN,TYPENM
 S SUCCESS="0^Title is Required."
 S DEFAULT=$$TITLDFLT($G(TIUFLDS(.01)),TIUTYPE,$G(BADTYPES))
 S SCREEN="I $P(^TIU(8925.1,+Y,0),U,4)=""DOC"",($P(^(0),U)'[""ADDENDUM""),+$$ISA^TIULX(+Y,+TIUTYPE),+$$CANPICK^TIULP(+Y),+$$CANENTR^TIULP(+Y),'$$ISTYPE^TIUFIX(+Y,$G(BADTYPES))"
 S TYPENM=$$PNAME^TIULC1(+TIUTYPE)
 W !!,"  Please enter a ",$$PNAME^TIULC1(+TIUTYPE)," title"
 I '$G(ASK) W "."
 I $G(ASK) W ", or enter '^' to exit",!,"or to change document to a Progress Note."
 ; -- Ask user for title:
 S TITLDA=$$ASKTYP^TIULA2(+TIUTYPE,DEFAULT,SCREEN,"TITLE: ",1)
 I TITLDA>0 S SUCCESS=1
 Q:'$G(ASK)
 I TITLDA'>0 D
 . W !,"Title is Required.",!
 . ; -- Ask user if want to change to PN:
 . K DIRUT S Y=$$ASKCHNG(1,.TIUTYPE)
 . ; -- Quit if user ^d or user said yes:
 . Q:$D(DIRUT)
 . Q:TIUTYPE=3
 . ; -- Reprompt for same type of title if user said no:
 . W !,"  OK, please enter a ",TYPENM," title."
 . S TITLDA=$$ASKTYP^TIULA2(+TIUTYPE,DEFAULT,SCREEN,"TITLE: ",1)
 . I TITLDA>0 S SUCCESS=1
 Q
 ;
ASKCHNG(ONEORTWO,TIUTYPE) ; Ask user if they want to change doc type
 ;to Progress Notes
 ; [ONEORTWO] - Which help msg, as below
 ; [TIUTYPE] - Passed back = 3 if user wants to change to PN
 N HELP,HELP1,HELP2,ANS
 S HELP="If you are sure there is no request to associate with this document, answer 'YES' to upload into a progress note.  If you are not sure,"
 S HELP1=HELP_" answer 'NO' and enter a consult title.  You can change your mind later."
 S HELP2=HELP_" answer 'NO' and come back and resolve the error later."
 S HELP=$S(ONEORTWO=1:HELP1,1:HELP2)
 S ANS=$$READ^TIUU("YO","Want to upload into a progress note instead of a consults title","NO",HELP)
 I ANS S TIUTYPE=3
ASKX Q ANS
