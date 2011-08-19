FSCUF ;SLC/STAFF-NOIS Utilities Functions ;7/21/95  15:24
 ;;1.1;NOIS;;Sep 06, 1998
 ;
DEFLIST(USER) ; $$(user) -> user's default list
 N LIST
 S LIST=+$P($G(^FSC("SPEC",+$O(^FSC("SPEC","B",USER,0)),0)),U,9)
 I 'LIST Q ""
 Q LIST_U_$$VALUE^FSCGET(LIST,7105.2,9)
 ;
CAP(TYPE,STYLE,LISTNUM) ; $$(type,style,list number) -> caption
 N CAPTION,FORMAT,VALUES
 I TYPE="L" Q " #      Call ID                    Call Subject                                  "
 S VALUES=$G(^TMP("FSC SELECT",$J,$S(TYPE="E":"EVALUES",1:"VVALUES")))
 S CAPTION=$S(VALUES=+VALUES:"     Call "_VALUES,1:$S($G(LISTNUM):"     Call "_LISTNUM_" of",1:"     Calls")_" ("_VALUES_")")
 I '$O(^TMP("FSC LIST CALLS",$J,0)) S CAPTION=" "
 S FORMAT=$S(STYLE="BRIEF":"Brief Format       ",STYLE="DETAIL":"Detailed Format    ",STYLE="FORMAT":$S($G(STYLE("F")):$P(STYLE("F"),U,2),1:"      ")_" Format       ",STYLE="STAT":"Statistic Format   ",1:"Fields Format      ")
 Q $$SETSTR^VALM1(FORMAT,CAPTION,62,$L(FORMAT))
 ;
STYLE(STYLE) ; $$(style) -> style name
 Q $S(STYLE="B":"BRIEF",STYLE="D":"DETAIL",STYLE="F":"FORMAT",STYLE="S":"STAT",STYLE="C":"CUSTOM",1:"")
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
 Q:'$D(^FSC("SPEC",USER,0)) "USER" Q:$P(^(0),U,7) "SUPER" Q "SPEC"
 ;
USERINI(USER) ; $$(user) -> user's initials
 Q $P($G(^VA(200,+USER,0)),U,2)
 ;
MODINI(MOD) ; $$(module) -> module's initials (naming convention)
 Q $P($G(^FSC("MOD",+MOD,0)),U,7)
 ;
VFORMAT(USER) ; $$(user) -> default format type for view screen
 N FTYPE
 S FTYPE=$P($G(^FSC("SPEC",USER,0)),U,17) I 'FTYPE Q "DETAIL"
 S FTYPE=$P($G(^FSC("FTYPE",FTYPE,0)),U,2) I '$L(FTYPE) Q "DETAIL"
 Q FTYPE
 ;
EFORMAT(USER) ; $$(user) -> default format type for edit screen
 N FTYPE
 S FTYPE=$P($G(^FSC("SPEC",USER,0)),U,18) I 'FTYPE Q "BRIEF"
 S FTYPE=$P($G(^FSC("FTYPE",FTYPE,0)),U,2) I '$L(FTYPE) Q "BRIEF"
 Q FTYPE
 ;
EXIT(USER) ; $$(user) -> 1 or 0, default to exit or quit on NOIS screens
 Q +$P($G(^FSC("SPEC",USER,0)),U,19)
ALERT(USER) ; $$(user) -> action on alerts
 N ACTION
 S ACTION=$P($G(^FSC("SPEC",USER,0)),U,20)
 I ACTION="VIEW" Q "View"
 Q "Edit"
