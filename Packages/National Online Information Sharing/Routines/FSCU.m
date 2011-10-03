FSCU ;SLC/STAFF-NOIS Utilities ;10/18/96  09:56
 ;;1.1;NOIS;;Sep 06, 1998
 ;
CONST ; tempoary use (called when options or protocol actions are disabled)
 W !,"UNDER CONSTRUCTION",! H 2
 Q
 ;
DATE(X) ; $$(date in external format) -> FM format
 N Y D ^%DT Q Y
 ;
PAUSE(OK) ; from FSCFORMP, FSCLMPO, FSCLMPOC, FSCLMPOE, FSCLMPON, FSCLMPOW, FSCRUDQ, FSCRX, FSCUEDIT, FSCUEDS
 N DIR,X,Y K DIR S OK=1
 S DIR(0)="E"
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I Y<1 S OK=0
 Q
 ;
DEFLIST(USER) ; $$(user) -> user's default list
 N LIST
 S LIST=+$P($G(^FSC("SPEC",+$O(^FSC("SPEC","B",USER,0)),0)),U,9)
 I 'LIST S LIST=+$O(^FSC("LIST","B","EMPTY",0))
 I 'LIST Q ""
 Q LIST_U_$$VALUE^FSCGET(LIST,7105.2,9)
 ;
VIDEOOFF ; from FSCFORM, FSCLMPC, FSCLMPCC, FSCLMV
 Q:'$D(VALMCC)  N LINE
 D KILL^VALM10(.LINE)
 Q
 ;
USERDEF(USER) ; $$(user) -> defaults
 N DEF
 S DEF=$$UP^XLFSTR($P($G(^FSC("SPEC",+USER,0)),U,11))
 I '$L(DEF) S DEF="SM"
 Q DEF
 ;
CAP(TYPE,STYLE,LISTNUM) ; $$(type,style,list number) -> caption
 N CAPTION,FORMAT,VALUES
 I TYPE="L",'$L($G(FSCUD)) Q " #      Call ID                    Call Subject                                  "
 I TYPE="L" D  Q CAPTION
 .S CAPTION=" #     Call ID     "
 .I FSCUD["S" S CAPTION=$$SETSTR^VALM1("Status",CAPTION,$L(CAPTION)+1,6)
 .I FSCUD["M" S CAPTION=$$SETSTR^VALM1("Mod",CAPTION,$L(CAPTION)+2,3)
 .I FSCUD["U" S CAPTION=$$SETSTR^VALM1("Spec",CAPTION,$L(CAPTION)+4,4)
 .I FSCUD["R" S CAPTION=$$SETSTR^VALM1("Ref",CAPTION,$L(CAPTION)+4,4)
 .I FSCUD["P" S CAPTION=$$SETSTR^VALM1("Pri",CAPTION,$L(CAPTION)+3,3)
 .S CAPTION=$$SETSTR^VALM1("Call Subject",CAPTION,$L(CAPTION)+8,60)
 S VALUES=$G(^TMP("FSC SELECT",$J,$S(TYPE="E":"EVALUES",1:"VVALUES")))
 S CAPTION=$S(VALUES=+VALUES:"     Call "_VALUES,1:$S($G(LISTNUM):"     Call "_LISTNUM_" of",1:"     Calls")_" ("_VALUES_")")
 I '$O(^TMP("FSC LIST CALLS",$J,0)) S CAPTION=" "
 S STYLE=$G(STYLE,"BRIEF")
 S FORMAT=$S(STYLE="BRIEF":"Brief Format       ",STYLE="DETAIL":"Detailed Format    ",STYLE="FORMAT":$S($G(STYLE("F")):$P(STYLE("F"),U,2),1:"      ")_" Format       ",STYLE="STAT":"Statistic Format   ",1:"Fields Format      ")
 Q $$SETSTR^VALM1(FORMAT,CAPTION,62,$L(FORMAT))
 ;
STYLE(STYLE) ; $$(style) -> style name
 Q $S(STYLE="B":"BRIEF",STYLE="D":"DETAIL",STYLE="F":"FORMAT",STYLE="S":"STAT",STYLE="C":"CUSTOM",STYLE="FM":"FM",1:"")
 ;
ACCESS(USER,ACCESS) ; $$(user,access) -> 1 or 0
 ; access uses hierarchy of user, spec, super
 I '$L(ACCESS) Q 1
 I ACCESS="USER" Q 1
 N USERACC
 S USERACC=$$PRIV(USER)
 I ACCESS="SUPER",USERACC="SUPER" Q 1
 I ACCESS="SPEC",USERACC="SUPER" Q 1
 I ACCESS="SPEC",USERACC="SPEC" Q 1
 Q 0
 ;
PRIV(USER) ; -> $$(user) -> user, spec, or super
 Q:'$D(^FSC("SPEC",+USER,0)) "USER" Q:$P(^(0),U,2) "USER" Q:$P(^(0),U,7) "SUPER" Q "SPEC"
 ;
HELP(DIR) ;
 N CNT
 W !
 S CNT=0 F  S CNT=$O(DIR("?",CNT)) Q:CNT<1  W !?5,DIR("?",CNT)
 I $G(DIR("?",+$O(DIR("?","A"),-1)))'["??" W !?5,"Enter '^' to exit, '??' for additional help."
 Q
