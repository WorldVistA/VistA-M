XUDHGUI ;ISF/STAFF,SLC/KCM - Device Utilites for Windows Calls ;03/24/10  10:34
 ;;8.0;KERNEL;**220,542**;Jul 10, 1995;Build 5
 ;
DEVICE(LST,FROM,DIR,RMAR) ; Return a subset of entries from the Device file
 ; Return up to 20 entries.
 ; .LST(n)=IEN^Name^DisplayName^Location^RMar^PLen
 ; FROM=text to $O from. Allow the DisplayName to be used.
 ; Allow "NAME*" to get count limit from that starting point.
 ; DIR=$O direction
 ; [RMAR]=min RM value or min-max value (Default to 80).
 N I,IEN,CNT,FR,SHOW,X,RML,RMH
 S I=0,CNT=$G(CNT,20),RMAR=$G(RMAR,80)
 I '$G(DIR) S DIR=1
 S RML=+RMAR,RMH=$S(RMAR["-":$P(RMAR,"-",2),1:99999)
 ;Allow the DisplayName to be used.
 I FROM["  <" S FROM=$RE($P($RE(FROM),"<  ",2))
 S FR=FROM I FROM["*" S FROM=$P(FROM,"*",1),FR=""
 F  Q:I'<CNT  S FROM=$O(^%ZIS(1,"B",FROM),DIR) Q:(FROM="")  D
 . I $L(FR),($E(FROM,1,$L(FR))'=FR) Q
 . S IEN=0 F  S IEN=$O(^%ZIS(1,"B",FROM,IEN)) Q:'IEN  D
 .. N X0,X1,X90,X91,X95,XTYPE,XSTYPE,XTIME,%A,%C,%H,%L,%X,EXT
 .. Q:'$D(^%ZIS(1,IEN,0))  S X0=^(0),X1=$G(^(1)),X90=$G(^(90)),X91=$G(^(91)),X95=$G(^(95)),XSTYPE=$G(^("SUBTYPE")),XTIME=$G(^("TIME")),XTYPE=$G(^("TYPE"))
 .. I $E($G(^%ZIS(2,+XSTYPE,0)))'="P" Q  ;Printers only
 .. S X=$P(XTYPE,"^") I X'="TRM",X'="HG",X'="HFS",X'="CHAN" Q  ;Device Types
 .. I ($P(X0,U,2)="0")!($P(X0,U,12)=2) Q  ;Queuing allowed
 .. S X=+X90 I X,(X'>DT) Q  ;Out of Service
 .. ;%C is current time, %L is lower limit, %H is upper limit
 .. S %A=$P(XTIME,"^") I $L(%A) S %C=$P($H,",",2),%C=%C\60#60+(%C\3600*100),%H=$P(%A,"-",2),%L=+%A I $S(%H'<%L:(%C'>%H&(%C'<%L)),1:(%C'<%L!(%C'>%H))) Q  ;Prohibited Times
 .. S EXT=0
 .. I X95]"" S %X=$G(DUZ(0)) I %X'="@" S EXT=1 F %A=1:1:$L(%X) I X95[$E(%X,%A) S EXT=0 Q
 .. Q:EXT  ;Security check
 .. I '+X91 S X91=$G(^%ZIS(2,+XSTYPE,1),"80^#^60^") ;Get default width & page length p542
 .. I RML>0,(+X91<RML)!(+X91>RMH) Q
 .. S SHOW=$P(X0,U) I SHOW'=FROM S SHOW=FROM_"  <"_SHOW_">"
 .. S I=I+1,LST(I)=IEN_U_$P(X0,U)_U_SHOW_U_$P(X1,U)_U_$P(X91,U)_U_$P(X91,U,3)
 Q
