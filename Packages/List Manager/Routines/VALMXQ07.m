VALMXQ07 ; alb/mjk - XQORD1 for export with LM v1 ; 3/30/93
 ;;1;List Manager;;Aug 13, 1993
 ;
 ;
XQORD1 ; SLC/KCM - Process Menus, WP during dialog ;11/19/92  08:31
 ;;6.7;Sidewinder;;Jan 08, 1993
 ;
RDR ;Setup and prompt using reader (DIR)
 ;Entry: X(field) is entire prompt node, XQORDLG(ITM) is previous response
 N DIR
 I X("DOM")="D",'$L(X("PARM")) S X("PARM")="::ET"
 S DIR(0)=X("DOM")_"A"_$S(X("MODE")["R":"",1:"O")_"^"_X("PARM")
 S DIR("A")=X("PRMT") S:DIR("A")'?.E1P1" " DIR("A")=DIR("A")_": "
 S:$L(X("DFLT")) DIR("B")=X("DFLT") ;default answer
 S:$D(XQORDLG(ITM))#2 DIR("B")=XQORDLG(ITM) ;last entered answer
 S:$L(X("HELP")) DIR("?")=X("HELP") ;help prompt
 D ^DIR
 Q  ;Exit: X is user entry, Y is validated answer (internal value)
 ;
WP ;Prompt for word processing
 ;Entry: .X is entire prompt node, XQORDLG(ITM) is last answer to this prompt
 N IFN,PRMT,DIC,DLAYGO,DIE,DR,DA,%
 S PRMT=X("PRMT") ;boilerplate in $P(X,"^",2)
 I '$G(XQORDLG(ITM)) DO
 . I '$D(^XUTL("XQORW",0)) S ^XUTL("XQORW",0)="XQOR WORD PROCESSING^101.11D^" ;if ^XUTL killed
 . D NOW^%DTC
 . S X=""""_%_"""",DIC="^XUTL(""XQORW"",",DIC(0)="L",DLAYGO=101.11 D ^DIC ;stuff entry
 I $G(XQORDLG(ITM)) S Y=XQORDLG(ITM),DIC="^XUTL(""XQORW"","
 S IFN=+Y,DIE=DIC,DR="1"_$TR(PRMT,";:","  "),DA=IFN D ^DIE
 S Y=IFN,X=$G(^XUTL("XQORW",IFN,1,+$O(^XUTL("XQORW",IFN,1,0)),0))
 Q  ;Exit: X is first entered line, Y is pointer 101.11 entry
 ;
MENU ;Allow menu selections from 101, 19, and similar files (XQORM)
 ;Entry: X(field) is prompt node, XQORDLG(ITM) is last answer to this prompt
 Q  ;N XQORM (menus not allowed for now)
 S XQORM=$P(X,"^",6),XQORM(0)=$P(X,"^",4)_"\",XQORM("A")=$P(X,"^",1)_": "
 S:'$L(XQORM(0)) XQORM(0)="A"
 S:$L($P(X,"^",2)) XQORM("B")=$P(X,"^",2) ;default selection
 S:$D(XQORDLG(ITM,1,"E")) XQORM("B")=XQORDLG(ITM,1,"E") ;last answer
 S:$L($P(X,"^",5)) XQORM("?")="W !!,"""_$P(X,"^",5)_""",!" ;help prompt
 D EN^XQORM
 Q  ;Exit: X is user entry, Y is pointer to entry in menu file
