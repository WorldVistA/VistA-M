XQORD1 ; SLC/KCM - Process Menus, WP during dialog ;11/19/92  08:31 [ 05/08/95  4:17 PM ]
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
RDR ;Setup and prompt using reader (DIR)
 ;Entry: XQORDX(field) is entire prompt node, XQORDLG(ITM) is previous response
 N DIR
 I XQORDX("DOM")="D",'$L(XQORDX("PARM")) S XQORDX("PARM")="::ET"
 S DIR(0)=XQORDX("DOM")_"A"_$S(XQORDX("MODE")["R":"",1:"O")_"^"_XQORDX("PARM")
 S DIR("A")=XQORDX("PRMT") S:DIR("A")'?.E1P1" " DIR("A")=DIR("A")_": "
 S:$L(XQORDX("DFLT")) DIR("B")=XQORDX("DFLT") ;default answer
 S:$D(XQORDLG(ITM))#2 DIR("B")=XQORDLG(ITM) ;last entered answer
 S:$L(XQORDX("HELP")) DIR("?")=XQORDX("HELP") ;help prompt
 D ^DIR
 Q  ;Exit: X is user entry, Y is validated answer (internal value)
 ;
WP ;Prompt for word processing
 ;Entry: .X is entire prompt node, XQORDLG(ITM) is last answer to this prompt
 N IFN,PRMT,DIC,DLAYGO,DIE,DR,DA,%
 S PRMT=XQORDX("PRMT") ;boilerplate in $P(X,"^",2)
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
 ;Entry: XQORDX(field) is prompt node, XQORDLG(ITM) is last answer to this prompt
 Q  ;N XQORM (menus not allowed for now)
 S XQORM=$P(X,"^",6),XQORM(0)=$P(X,"^",4)_"\",XQORM("A")=$P(X,"^",1)_": "
 S:'$L(XQORM(0)) XQORM(0)="A"
 S:$L($P(X,"^",2)) XQORM("B")=$P(X,"^",2) ;default selection
 S:$D(XQORDLG(ITM,1,"E")) XQORM("B")=XQORDLG(ITM,1,"E") ;last answer
 S:$L($P(X,"^",5)) XQORM("?")="W !!,"""_$P(X,"^",5)_""",!" ;help prompt
 D EN^XQORM
 Q  ;Exit: X is user entry, Y is pointer to entry in menu file
