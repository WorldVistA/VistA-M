EDPBKS ;SLC/MKB -- EDPF BIGBOARD KIOSKS list template
 ;;1.0;EMERGENCY DEPARTMENT;;Sep 30, 2009;Build 74
 ;
EN ; -- main entry point
 S EDPSITE=$$DIV Q:EDPSITE<1
 D EN^VALM("EDPF BIGBOARD KIOSKS")
 Q
 ;
HDR ; -- header code
 N X S X=$$NS^XUAF4(EDPSITE)
 S VALMHDR(1)="Division: "_$P(X,U)_" ("_$P(X,U,2)_")"
 Q
 ;
INIT ; -- init variables and list array EDPB
 N EDPX,I,X K EDPB
 D GETLST^XPAR(.EDPX,"DIV.`"_EDPSITE,"EDPF BIGBOARD KIOSKS")
 S VALMCNT=EDPX I EDPX F I=1:1:EDPX D
 . S X=EDPX(I),EDPB("IDX",I)=X
 . N X1,X2 S X1=$P(X,U),X2=$P(X,U,2)
 . S:$L(X1)>37 X1=$E(X1,1,37)_"..." S:$L(X2)>27 X2=$E(X2,1,27)_"..."
 . S EDPB(I,0)=$$LJ^XLFSTR(I,4)_$$LJ^XLFSTR(X1,40)_X2
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K EDPSITE
 Q
 ;
DIV() ; -- select division
 N X,Y,DIC
 S DIC=4,DIC(0)="AEQM"
 ; DIC("S")= only local divisions ??
 D ^DIC S Y=$S(Y<1:"",1:+Y)
 Q Y
 ;
ENTER(NAME,DEFAULT) ; -- prompt for NAME
 N X,Y,DIR,DTOUT,DUOUT
 S DIR(0)="FAO",DIR("A")=NAME_": " S:$L($G(DEFAULT)) DIR("B")=DEFAULT
 I $E(NAME)="C" S DIR("?")="Enter a fully specified computer name; this will be saved in lowercase."
 E  S DIR("?")="Enter the name of the board to be displayed on this computer; this value is case-sensitive."
 D ^DIR I $G(DTOUT)!$G(DUOUT) S Y=""
 Q Y
 ;
SELECT() ; -- select item from list by number
 N X,Y,DIR,DTOUT,DUOUT
 S DIR(0)="NAO^1:"_VALMCNT,DIR("A")="Select computer/board: "
 D ^DIR
 Q Y
 ;
SURE(NAME) ; -- are you sure?
 N X,Y,DIR,DTOUT,DUOUT W !
 S DIR("A",1)="Deletions are done immediately!"
 S DIR(0)="YA",DIR("A")="Are you sure"_$S($L($G(NAME)):" you want to remove "_NAME,1:"")_"? "
 D ^DIR
 Q Y
 ;
 ; -- EDPF BIGBOARD MENU actions --
 ;
NEWDIV ; -- select new division
 N X D FULL^VALM1 S VALMBCK="R"
 S X=$$DIV I X,X'=EDPSITE D
 . W !,"Rebuilding list ..." H 1
 . S EDPSITE=X D INIT
 . K VALMHDR
 Q
 ;
ADD ; -- add a computer/board
 N INST,VAL,DONE,EDPERR,MORE
 D FULL^VALM1 S VALMBCK="R" W !
 S (DONE,MORE)=0 F  D  Q:DONE
 . S INST=$$ENTER("Computer Name") I '$L(INST) S DONE=1 Q
 . S INST=$$LOW^XLFSTR(INST) ;enforce lowercase
 . S VAL=$$ENTER("Display Board") I '$L(VAL) S DONE=1 Q
 . D ADD^XPAR("DIV.`"_EDPSITE,"EDPF BIGBOARD KIOSKS",INST,VAL,.EDPERR)
 . I EDPERR W !,$P(EDPERR,U,2),! H 2 Q
 . S MORE=1 W !
 D:MORE INIT
 Q
 ;
REM ; -- remove a computer/board
 N NUM,INST,EDPERR S VALMBCK=""
 S NUM=$$SELECT Q:NUM<1
 S INST=$P($G(EDPB("IDX",NUM)),U)
 I '$L(INST) W !,"Invalid selection" H 1 Q
 Q:'$$SURE(INST)
 D DEL^XPAR("DIV.`"_EDPSITE,"EDPF BIGBOARD KIOSKS",INST,.EDPERR)
 I EDPERR W !,$P(EDPERR,U,2) H 2 Q
 W !,"Board removed." H 1
 D INIT S VALMBCK="R"
 Q
 ;
CHG ; -- change a computer or board name
 N NUM,OLD,INST,VAL,EDPERR S VALMBCK=""
 S NUM=$$SELECT Q:NUM<1
 S OLD=$G(EDPB("IDX",NUM)),VALMBCK="R"
 S INST=$$ENTER("Computer Name",$P(OLD,U)) Q:'$L(INST)
 S INST=$$LOW^XLFSTR(INST) ;enforce lowercase
 S VAL=$$ENTER("Display Board",$P(OLD,U,2)) Q:'$L(VAL)
 I OLD=(INST_U_VAL) Q  ;no change
 I INST'=$P(OLD,U) D  Q:EDPERR
 . D REP^XPAR("DIV.`"_EDPSITE,"EDPF BIGBOARD KIOSKS",$P(OLD,U),INST,.EDPERR)
 . I EDPERR W !,$P(EDPERR,U,2) H 2
 I VAL'=$P(OLD,U,2) D
 . D CHG^XPAR("DIV.`"_EDPSITE,"EDPF BIGBOARD KIOSKS",INST,VAL,.EDPERR)
 . I EDPERR W !,$P(EDPERR,U,2) H 2 Q
 D INIT
 Q
