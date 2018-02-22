GMPLBLD3 ; SLC/MKB,TC -- Bld PL Selection Lists cont ;08/22/17  14:15
 ;;2.0;Problem List;**28,42,49**;Aug 25, 1994;Build 43
 ;
 ; External References:
 ;   ICR  1966   $$GET1^DIQ(4.2,GMPLIFN,.01)
 ;   ICR  2056   $$GET1^DIQ
 ;   ICR  2263   ENVAL^XPAR
 ;   ICR  4083   $$STATCHK^LEXSRC2
 ;   ICR  5747   $$CODECS^ICDEX,$$STATCHK^ICDEX
 ;   ICR  10103  $$DT^XLFDT
 ;   ICR  10013  ^DIK
 ;   ICR  10026  ^DIR
 ;   ICR  10040  $$GET1^DIQ(44,GMPLIFN,.01)
 ;   ICR  10060  $$GET1^DIQ(200,DUZ,.01)
 ;   ICR  10090  $$GET1^DIQ(4,GMPLIFN,.01)
 ;
DELETE ; Delete Selection List
 N DIR,DIK,DA,X,Y,GMPQUIT,GMPLSLST,GMPLSEQ,GMPLDA,GMPLFDA,GMPLMSG
 N GMPLPAR,GMPLERR,GMPLENT,GMPLVIEW,GMPCNT,GMPLPLST,GMPLENTY
 N GMPLUSR,GMPLDUZ,GMPLLST,GMPLERR1,GMPLTXT,GMPLUCNT,GMPLSUC
 S (GMPLENT,GMPLENTY,GMPLUSR,GMPLDUZ)="",(GMPCNT,GMPLUCNT)=0,GMPLSUC=1
 S GMPLSLST=$$LIST^GMPLBLD2("") Q:GMPLSLST="^"
 I $P($G(GMPLSLST),U,5)="N" W !!,"Cannot delete a National Selection List." G DELQT
 W !!,"Checking the Default Problem Selection List parameter for use of this list ..."
 D ENVAL^XPAR(.GMPLPAR,"ORQQPL SELECTION LIST",1,.GMPLERR)
 I +$G(GMPLERR)>0 W !!,"Error: "_$P(GMPLERR,U,2) G DELQT
 I GMPLPAR>1 D
 . F  S GMPLENT=$O(GMPLPAR(GMPLENT)) Q:GMPLENT=""  D
 . . S GMPLVIEW=$G(GMPLPAR(GMPLENT,1)) Q:'GMPLVIEW  Q:GMPLVIEW'=+GMPLSLST
 . . S GMPCNT=GMPCNT+1,GMPLPLST(GMPLENT)="" W "."
 I GMPCNT D  Q
 . W !!,"CANNOT DELETE",!,"This list is currently assigned to the following entities:",!!
 . F  S GMPLENTY=$O(GMPLPLST(GMPLENTY)) Q:GMPLENTY=""  D
 . . I GMPLENTY["VA(" W ?7,"User: "_$$GET1^DIQ(200,$P(GMPLENTY,";"),.01),! Q
 . . I GMPLENTY["SC(" W ?7,"Clinic: "_$$GET1^DIQ(44,$P(GMPLENTY,";"),.01),! Q
 . . I GMPLENTY["DIC(4.2" W ?7,"System: "_$$GET1^DIQ(4.2,$P(GMPLENTY,";"),.01),! Q
 . . I GMPLENTY["DIC(4" W ?7,"Division: "_$$GET1^DIQ(4,$P(GMPLENTY,";"),.01),! Q
 . G DELQT
 W !,"No other parameter settings found."
DEL1 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Are you sure you want to delete this list"
 S DIR("?",1)="Enter YES if you wish to completely remove this list; press <return>",DIR("?")="to leave this list unchanged and exit this option."
 W $C(7),! D ^DIR Q:'Y
 W !!,"Deleting "_$P(GMPLSLST,U,2)_" selection list ..."
 S GMPLFDA(125,""_+GMPLSLST_",",.01)="@"
 D FILE^DIE("K","GMPLFDA","GMPLMSG")
 I $D(GMPLMSG) D EN^DDIOL("Error: "_GMPLMSG("DIERR",1,"TEXT",1))
 E  D
 . W !,"DONE."
 . I $D(^GMPL(125,0)) S $P(^GMPL(125,0),U,3)=0
 W !!,"Checking the NEW PERSON file for any pointers to this list and removing them..."
 F  S GMPLUSR=$O(^VA(200,"B",GMPLUSR)) Q:GMPLUSR=""  D
 . F  S GMPLDUZ=$O(^VA(200,"B",GMPLUSR,GMPLDUZ)) Q:GMPLDUZ=""  D
 . . S GMPLLST=$$GET1^DIQ(200,GMPLDUZ,125.1,"I") Q:'GMPLLST
 . . I +GMPLSLST=GMPLLST D
 . . . S GMPLUCNT=GMPLUCNT+1
 . . . S GMPLFDA(200,""_GMPLDUZ_",",125.1)="@"
 . . . D FILE^DIE("K","GMPLFDA","GMPLERR1")
 . . . I $D(GMPLERR1) D
 . . . . S GMPLTXT(1)="Error deleting pointer #"_GMPLLST_" from user "_GMPLUSR_"."
 . . . . S GMPLTXT(2)="Error: "_GMPLERR("DIERR",1,"TEXT",1),GMPLSUC=0
 . . . . D EN^DDIOL(.GMPLTXT)
 I 'GMPLUCNT W !,"No pointers found." G DELQT
 I GMPLSUC W !,"DONE."
DELQT W ! D PAUSE^GMPLX
 Q
 ;
MENU ; -- init variables and list array for GMPL LIST MENU list template
 ;    Expects GMPLSLST=selection list
 N GSEQ,PSEQ,GCNT,PCNT,GROUP,HDR,IFN,LCNT,ITEM,TEXT,GMPICD,GMPLCPTR,GMPSCTC,GMPDT
 S (GSEQ,GCNT,LCNT)=0,GMPDT=$$DT^XLFDT K ^TMP("GMPLMENU",$J)
 W !!,"Retrieving list of "_$P(GMPLSLST,U,2)_" problems ..."
 F  S GSEQ=$O(^GMPL(125,"AD",+GMPLSLST,GSEQ)) Q:GSEQ'>0  D
 . S IFN=$O(^GMPL(125,"AD",+GMPLSLST,GSEQ,0)) Q:IFN'>0
 . S ITEM=$G(^GMPL(125,+GMPLSLST,1,IFN,0)),GROUP=$P(ITEM,U,1),HDR=$P(ITEM,U,3,4)
 . S GCNT=GCNT+1,(PSEQ,PCNT)=0,^TMP("GMPLMENU",$J,GCNT,0)=HDR
 . F  S PSEQ=$O(^GMPL(125.11,"C",+GROUP,PSEQ)) Q:PSEQ'>0  D
 . . S IFN=$O(^GMPL(125.11,"C",+GROUP,PSEQ,0)) Q:IFN'>0
 . . S ITEM=$G(^GMPL(125.11,+GROUP,1,IFN,0)),TEXT=$P(ITEM,U,3)
 . . S GMPICD=$P(ITEM,U,4),GMPSCTC=$P(ITEM,U,5)
 . . I $L(GMPSCTC) D
 . . . I '$$STATCHK^LEXSRC2(GMPSCTC,GMPDT,"","SCT") Q
 . . I $L(GMPICD) D
 . . . N GMPLCPTR,GMI S GMPLCPTR=$P($$CODECS^ICDEX($P(GMPICD,"/"),80,GMPDT),U)
 . . . F GMI=1:1:$L(GMPICD,"/") D
 . . . . I '$$STATCHK^ICDEX($P(GMPICD,"/",GMI),GMPDT,GMPLCPTR) Q  ; screen inactive codes
 . . S PCNT=PCNT+1,^TMP("GMPLMENU",$J,GCNT,PCNT)=$P(ITEM,U,1)_U_$P(ITEM,U,3,4)
 I '$D(^TMP("GMPLMENU",$J)) W !!,"No items available.  Returning to Problem List ..." H 2 S VALMBCK="Q",VALMQUIT=1 Q
 D BUILD^GMPLMENU
 Q
