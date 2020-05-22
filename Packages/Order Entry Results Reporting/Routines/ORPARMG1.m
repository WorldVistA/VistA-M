ORPARMG1 ; SPFO/AJB - ListManager Parameter Display for Notifications ;Dec 18, 2019@08:15:15
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**500,518**;Dec 17, 1997;Build 11
 ;
 ; Global References
 ;    ^VA(200,            ICR   10060
 ; External References
 ;    ^DIC                ICR   10006   $$GET1^DIQ       ICR   2056    ^DIR             ICR   10026
 ;    EN^VALM             ICR   10118   $$SETFLD^VALM1   ICR   10116   $$SETSTR^VALM1   ICR   10116
 ;    FULL^VALM1          ICR   10116   SET^VALM10       ICR   10117   RE^VALM4         ICR   10120
 ;    GETLST^XPAR         ICR   2263    DISP^XQORM1      ICR   10102   EN^XUTMDEVQ      ICR   1519
 ;    DIV4^XUSER          ICR   2343    $$RJ^XLFSTR      ICR   10104   $$CJ^XLFSTR      ICR   10104
 ;    $$KSP^XUPARAM       ICR   2541
 Q
STATUS(VAL) ; evaluates the levels of a notification and returns the status
 N ORQ,PKG,SYS,DIV,SRV,TEA,USR,X,Y S ORQ=0
 S Y=0 F X="PKG","SYS","DIV","SRV","TEA","USR" D  ; set values for each level
 . S Y=Y+1,@X=$S($P(VAL,U,Y)="":"N",1:$P(VAL,U,Y))
 S VAL="0^OFF no settings found."
 I USR="E"!(USR="M") Q "ON User value is "_$S(USR="E":"ENABLED.",1:"MANDATORY.") ; evaluate USER level
 I USR="D" S VAL="0^OFF User value is DISABLED"
 F X=1:1:$L(TEA,"|") S Y=$P($P(TEA,"|",X),";") D  Q:+ORQ  ; evaluate TEAM level
 . I Y="M" S VAL="1^ON "_$P($P(TEA,"|",X),";",2)_" is MANDATORY." S ORQ=1 Q
 . I Y="E",USR'="D" S VAL="1^ON "_$P($P(TEA,"|",X),";",2)_" is ENABLED." S ORQ=1 Q
 . I Y="D",USR'="D" S VAL="1^OFF "_$P($P(TEA,"|",X),";",2)_" is DISABLED." Q
 Q:+VAL $P(VAL,U,2)
 I SRV="M" Q "ON "_$$GET1^DIQ(200,IEN,29,"E")_" service is MANDATORY."
 I SRV="E",USR'="D" Q "ON "_$$GET1^DIQ(200,IEN,29,"E")_" service is ENABLED."
 I SRV="D",USR'="D" S VAL="0^OFF "_$$GET1^DIQ(200,IEN,29,"E")_" service is DISABLED."
 Q:+VAL $P(VAL,U,2)  S ORQ=0
 F X=1:1:$L(DIV,"|") S Y=$P($P(DIV,"|",X),";") D  Q:+ORQ  ; evaluate DIVISION level
 . I Y="M" S VAL="1^ON "_$P($P(DIV,"|",X),";",2)_" is MANDATORY." S ORQ=1 Q
 . I Y="E",USR'="D" S VAL="1^ON "_$P($P(DIV,"|",X),";",2)_" is ENABLED." S ORQ=1 Q
 . I Y="D",USR'="D" S VAL="1^OFF "_$P($P(DIV,"|",X),";",2)_" is DISABLED." Q
 Q:+VAL $P(VAL,U,2)
 I SYS="M" Q "ON System value is MANDATORY."
 I SYS="E",USR'="D" Q "ON System value is ENABLED."
 I SYS="D",USR'="D" Q "OFF System value is DISABLED."
 I PKG="M" Q "ON Package value is MANDATORY."
 I PKG="E",USR'="D" Q "ON Packagae value is ENABLED."
 I PKG="D",USR'="D" Q "OFF Package value is DISABLED."
 Q "OFF no values found."
OUTPUT ; display output for detailed view
 N DIV,END,LN,NOT,NOTIFS,NUM,SVS,TM,X,Y
 S (TM,X)=0 F  S TM=$O(^OR(100.21,"C",IEN,TM)) Q:'+TM  S X=X+1,TM(X)=TM_";"_$$GET1^DIQ(100.21,TM,.01) ; get user team(s)
 S TM=X ; number of teams for user
 S SVS=$$GET1^DIQ(200,IEN,29,"I") ; get user service
 S DIV=$$DIV4^XUSER(.DIV,IEN) ; get user division(s)
 S (DIV,X)=0 F  S DIV=$O(DIV(DIV)) Q:'+DIV  S X=X+1,DIV(X)=DIV_";"_$$GET1^DIQ(4,DIV,.01) K DIV(DIV)
 S DIV=X ; number of divisions for user
 S LN=0 S LN=LN+1,LN(LN)="Notification List for "_$$GET1^DIQ(200,IEN,.01),LN(LN)=$$CJ^XLFSTR(LN(LN),80),LN=LN+1,LN(LN)=""
 I SHOW="C" D
 . S LN=LN+1,LN(LN)=$S($E(IOST,1,2)="C-":ORUON,1:"")_"Notification                      Status Why                                    "_$S($E(IOST,1,2)="C-":ORUOFF,1:"")
 . I $E(IOST,1,2)'="C-" S LN=LN+1,LN(LN)="",$P(LN(LN),"-",80)="-"
 S NOT="" F  S NOT=$O(^ORD(100.9,"B",NOT)) Q:NOT=""  S NUM=0 F  S NUM=$O(^ORD(100.9,"B",NOT,NUM)) Q:'+NUM  D
 . I SHOW'="C" D
 . . S LN=LN+1,LN(LN)=$S($E(IOST,1,2)="C-":ORUON,1:"")_"Notification"_$$SETSTR^VALM1("USR/TEAM/SRV/DIV/SYS/PKG","",45,24)_$S($E(IOST,1,2)="C-":ORUOFF,1:"")
 . . I $E(IOST,1,2)'="C-" S LN=LN+1,LN(LN)="",$P(LN(LN),"-",80)="-" ; add 'underline' for non-display output
 . N VAL S VAL=$$GET^XPAR(IEN_";VA(200,","ORB PROCESSING FLAG",NUM,"I") ; user level value
 . S $P(NOTIFS,U,6)=VAL ; set user level value
 . S LN=LN+1,LN(LN)=NOT S:SHOW'="C" LN(LN)=$$SETSTR^VALM1(VAL,LN(LN),58,$L(VAL))
 . S VAL=$$GET^XPAR(SVS_";DIC(49,","ORB PROCESSING FLAG",NUM,"I") ; service level value
 . S $P(NOTIFS,U,4)=VAL ; set service level value
 . S:SHOW'="C" LN(LN)=$$SETSTR^VALM1(VAL,LN(LN),67,$L(VAL))
 . S VAL=$$GET^XPAR("SYS","ORB PROCESSING FLAG",NUM,"I") ; system level value
 . S $P(NOTIFS,U,2)=VAL ; set system level value
 . S:SHOW'="C" LN(LN)=$$SETSTR^VALM1(VAL,LN(LN),75,$L(VAL))
 . S VAL=$$GET^XPAR("PKG","ORB PROCESSING FLAG",NUM,"I") ; package level value
 . S $P(NOTIFS,U,1)=VAL ; set package level value
 . S:SHOW'="C" LN(LN)=$$SETSTR^VALM1(VAL,LN(LN),79,$L(VAL))
 . N CNT I +TM S (CNT,X)=0,Y="" F  S X=$O(TM(X)) Q:'+X  D  S $P(NOTIFS,U,5)=Y
 . . S VAL=$$GET^XPAR(+TM(X)_";OR(100.21,","ORB PROCESSING FLAG",NUM,"I") Q:VAL=""&'+SHOW  S CNT=CNT+1,$P(Y,"|",X)=VAL_";"_$P(TM(X),";",2)
 . . S LN(LN+CNT)=$S(CNT=1:" Team: "_$P(TM(X),";",2),1:"       "_$P(TM(X),";",2))
 . . S LN(LN+CNT)=$$SETSTR^VALM1(VAL,LN(LN+CNT),63,$L(VAL))
 . I +DIV S (CNT(1),X)=0,Y="" F  S X=$O(DIV(X)) Q:'+X  D  S $P(NOTIFS,U,3)=Y
 . . S VAL=$$GET^XPAR(+DIV(X)_";DIC(4,","ORB PROCESSING FLAG",NUM,"I") Q:VAL=""&'+SHOW  S CNT(1)=CNT(1)+1,$P(Y,"|",X)=VAL_";"_$P(DIV(X),";",2)
 . . S LN(LN+CNT(1)+$G(CNT))=$S(CNT(1)=1:" Division: "_$P(DIV(X),";",2),1:"           "_$P(DIV(X),";",2))
 . . S LN(LN+CNT(1)+$G(CNT))=$$SETSTR^VALM1(VAL,LN(LN+CNT(1)+$G(CNT)),71,$L(VAL))
 . I SHOW'="C" S LN="",LN=$O(LN(LN),-1),LN=LN+1,LN(LN)=""
 . I SHOW="C" D  Q
 . . S X=$$STATUS(NOTIFS),Y=$P(X," ",2,99),X=$P(X," ") S X=X_$S(X="ON":"     ",1:"    ")_Y,X=$TR(X,".","")
 . . S LN(LN)=$$SETSTR^VALM1(X,LN(LN),35,$L(X))
 . S LN=LN+1,LN(LN)=$$STATUS(NOTIFS),LN(LN+1)="",$P(LN(LN+1),"=",$L(LN(LN)))="="
 . S LN(LN)=$$RJ^XLFSTR(LN(LN),80),LN(LN+1)=$$RJ^XLFSTR(LN(LN+1),80),LN=LN+1
 . S LN=LN+1,LN(LN)=""
 S (END,Y)=0
 D:$E(IOST,1,2)="C-" HDR2
 F  S Y=$O(LN(Y)) Q:'+Y!(+END)  D
 . D HDR1:$Y+3>IOSL Q:+END  W LN(Y),!
 Q:+END  R:$E(IOST,1,2)="C-" !,"Press <Enter> to continue ",X:DTIME
 Q
ADD ;
 D FULL^VALM1 W @IOF
 N USRLST I +ENT(0)=200 D  Q:USRLST'="N"
 . S USRLST=$P($$READ("SA^A:All Active CPRS Users;D:DIVISION;S:SERVICE;T:TEAM;N:Nope","Add USERS to the ENTITY List by Team, Service, Division, or ALL? ","NO"),U)
 . Q:USRLST="N"
 . I USRLST="A" D  Q
 . . W !,"Adding All Active CPRS Users to the list..."
 . . N NAME,IEN S NAME="" F  S NAME=$O(^VA(200,"AUSER",NAME)) Q:NAME=""  S IEN=0 F  S IEN=$O(^VA(200,"AUSER",NAME,IEN)) Q:'+IEN  D
 . . . I +$$SCREEN(IEN) S ENTRIES(NAME,IEN)=""
 . . D INIT,RE^VALM4
 . I USRLST="D"!(USRLST="S") D  Q
 . . N DIC,VAL S DIC=$S(USRLST="D":"^DIC(4,",1:"^DIC(49,"),DIC(0)="AEMQ"
 . . W ! S VAL=$$DIC(.DIC) Q:'+VAL
 . . D FIND($S(USRLST="D":"^VA(200,""AH"")",1:"^VA(200,""E"")"),+VAL)
 . . D INIT,RE^VALM4
 . I USRLST="T" D  Q
 . . N DIC,VAL S DIC="^OR(100.21,",DIC(0)="AEMQ"
 . . W ! S VAL=$$DIC(.DIC) Q:'+VAL
 . . D FIND("^OR(100.21,"_+VAL_")",1)
 . . D INIT,RE^VALM4
 N DIC,POP,X,Y S DIC=ENT(1),DIC(0)="AEMQ" F  W ! S Y=$$DIC(.DIC) Q:Y=-1  S ENTRIES($P(Y,U,2),+Y)=""
 D INIT,RE^VALM4
 Q
DIC(DIC) ;
 N POP,X,Y
 D ^DIC
 Q Y
FIND(GBL,IEN) ; File #200 Only
 N X,Y S X=0 F  S X=$O(@GBL@(IEN,X)) Q:'+X  S ENTRIES($$GET1^DIQ(200,X,.01),X)=""
 Q
DETV ; detailed view of notifications a user can receive
 W @IOF
 N DIC,IEN,ORUON,ORUOFF,POP,SHOW,X,Y,ZTSAVE
 S DIC="^VA(200,",DIC(0)="AEMQ",DIC("A")="Enter NEW PERSON: ",DIC("B")=DUZ D ^DIC Q:Y=-1  S IEN=+Y ; get user to evaluate
 W ! S SHOW=$P($$READ("SA^C:Condensed;D:Detailed;B:Basic","Condensed, Detailed, or Basic Report? ","B"),U) S:SHOW="D" SHOW=1
 D PREP^XGF S ORUON=IOUON,ORUOFF=IOUOFF S ZTSAVE("ORUON")="",ZTSAVE("ORUFF")="" D CLEAN^XGF
 S ZTSAVE("IEN")="",ZTSAVE("SHOW")=""
 D EN^XUTMDEVQ("OUTPUT^ORPARMG1","",.ZTSAVE)
 Q
HDR1 ;
 I $E(IOST,1,2)="C-" D
 . R !,"Press <ENTER> to continue or '^' to exit ",X:DTIME S END='$T!(X=U)
 Q:+END
HDR2 W:$E(IOST,1,2)="C-" @IOF Q
REMOVE ;
 D FULL^VALM1
 N IEN,X
 N LVL S LVL="" F  S LVL=$O(SEL(LVL)) Q:LVL=""  D
 . N ERR,IEN,LEN S LEN=$L(SEL(LVL),",")-1
 . N J F J=1:1:LEN D
 . . S IEN=$O(@VALMAR@("IDX",$P(SEL(LVL),",",J),"")) Q:'+IEN  ; error here if no IEN
 . . K @VALMAR@("IDX",$P(SEL(LVL),",",J),IEN),ENTRIES($$GET1^DIQ(+ENT(0),IEN,.01),IEN)
 S VALMBG=1 D INIT,RE^VALM4
 Q
VIEW ;
 D FULL^VALM1
 N IEN,ORQ,X,Y S ORQ=1
 F X=1:1:($L(SEL,",")-1) Q:'+ORQ  D
 . W @IOF
 . S IEN=$O(@VALMAR@("IDX",$P(SEL,",",X),""))
 . N LIST D GETLST^XPAR(.LIST,IEN_ENT,+PAR,"E")
 . I +ENT(0)=200 N SYSLST D GETLST^XPAR(.SYSLST,SYSTEM,+PAR,"E") D
 . . S Y=0 F  S Y=$O(SYSLST(Y)) Q:'+Y  S SYSLST($P(SYSLST(Y),U))=$P(SYSLST(Y),U,2) K SYSLST(Y)
 . W "Detailed settings for:  ",$$GET1^DIQ(+ENT(0),IEN,.01)
 . W:+ENT(0)=200 !!,IOUON,"Instance",?57,"User        [System]  ",IOUOFF
 . W:+ENT(0)'=200 !!,IOUON,"Instance",?75,"Value",IOUOFF
 . ;S Y=0 F  S Y=$O(LIST(Y)) Q:'+Y  D
 . I LIST'<1 F Y=1:1:LIST D
 . . S LIST($P(LIST(Y),U))=LIST(Y) K LIST(Y) ; reorder list
 . S Y=0 F  S Y=$O(LIST(Y)) Q:Y=""!('+ORQ)  D
 . . N STAT S STAT=$P(LIST(Y),U,2)
 . . W !,$P(LIST(Y),U),?$S(+$D(SYSLST):57,1:(IOM-$L($P(LIST(Y),U,2)))),$P(LIST(Y),U,2) W:$D(SYSLST($P(LIST(Y),U))) ?69,"["_SYSLST($P(LIST(Y),U))_"]"
 . . I $Y>(IOSL-4) W !,IOCUOFF S ORQ=+$$READ("EA",IORVON_"Press <ENTER> to continue or '^' to exit."_IORVOFF) Q:'+ORQ  W @IOF
 . I '+ORQ W IOCUON Q
 . F  Q:$Y>(IOSL-3)  W !
 . W IOCUOFF S ORQ=+$$READ("EA",IORVON_"Press <ENTER> to continue or '^' to exit."_IORVOFF) W IOCUON
 Q
TEXT(X,Y,Z) ;
 S Z=$S($G(Z)="":"",1:Z)
 S Y=$S($G(Y)="C":((IOM-$L(X))/2),$G(Y)="R":(IOM-$L(X)),+$G(Y)>0:Y,1:0)
 Q $$SETSTR^VALM1(X,Z,Y,$L(X))
 ; S DIC="^VA(200,",DIC(0)="AEMQ",DIC("A")="Enter NEW PERSON NAME: ",DIC("S")="I +$$SCREEN^ORNOTN(Y)"
SCREEN(USER) ;
 N ORTAB,ORX
 S ORX=0,ORX=+$O(^VA(200,USER,"ORD","B",1,ORX)) ; IA# 10060
 I ORX=0 Q 0 ; No CPRS Tabs assigned
 S ORTAB=$G(^VA(200,USER,"ORD",ORX,0))
 I +ORTAB'=1 Q 0 ; check for core tab
 I DT<$P(ORTAB,U,2) Q 0 ; check effective date
 I +$P(ORTAB,U,3)=0 Q 1 ; check expiration date (not set)
 I DT'<$P(ORTAB,U,3) Q 0 ; check expiration date
 Q 1
REMALL ;
 K @VALMAR,ENTRIES
 D INIT,RE^VALM4
 Q
ASK ;
 N ACT S ACT=$P($$READ("S^REMOVE:Remove Entry;VIEW:View Entry","Select Action",$S($L(SEL,",")>2:"Remove",1:"View")),U)
 D:ACT'="" @ACT
 Q
HDR ;
 S VALMHDR(1)=$P(ENT(0),U,2)_" ["_$P(ENT(0),U,6)_"] List"
 S VALMHDR(1)=$$SETSTR^VALM1(VALMHDR(1),"",IOM-$L(VALMHDR(1))/2,$L(VALMHDR(1)))
 D XQORM
 Q
INIT ;
 N IEN,NAME S VALMCNT=0
 K @VALMAR
 I +$D(ENTRIES) S ENTRIES=0 D
 . S NAME="" F  S NAME=$O(ENTRIES(NAME)) Q:NAME=""  S IEN=0 F  S IEN=$O(ENTRIES(NAME,IEN)) Q:'+IEN  D
 . . N X S ENTRIES=ENTRIES+1,VALMCNT=VALMCNT+1,X=""
 . . S X=$$SETFLD^VALM1(VALMCNT,X,"NUMBER")
 . . S X=$$SETFLD^VALM1($$GET1^DIQ(+ENT(0),IEN,.01),X,"ENTITY")
 . . D SET^VALM10(VALMCNT,X,IEN)
 I VALMCNT=0 S VALMCNT=1 D
 . D SET^VALM10(1," ",0)
 . S X="<NONE>"
 . S X=$$SETSTR^VALM1(X,"",(IOM-$L(X))/2,$L(X))
 . D SET^VALM10(2,X,0)
 . S VALMCNT=0
 Q
HELP ;
 S X="?" D DISP^XQORM1 W !!
 Q
EXIT ;
 D XQORM
 Q
EXPND ;
 Q
XQORM ;
 S XQORM("#")=$O(^ORD(101,"B","ORNOT DEFAULT ENTITY SELECTIONS",0))_U_"1:"_VALMCNT
 Q
EN ;
 D EN^VALM("OR PARAMETER SELECT")
 Q
SELECT(ACT) ;
 I ACT="REMALL" D @ACT Q
 I VALMCNT=0 Q
 D FULL^VALM1
 N SEL,X,Y
 S SEL(0)=$S(VALMCNT=1:"1,",1:$P(XQORNOD(0),"=",2)),SEL=SEL(0) ; if only 1 item in list, make it default SEL
 I SEL="" S SEL=$$LOR^ORPARMGR(.SEL) Q:'+SEL
 D @ACT
 Q
READ(TYPE,PROMPT,DEFAULT,HELP,SCREEN) ;
 N DIR,X,Y
 S DIR(0)=TYPE
 I $D(SCREEN) S DIR("S")=SCREEN
 I $G(PROMPT)]"" S DIR("A")=PROMPT
 I $G(DEFAULT)]"" S DIR("B")=DEFAULT
 I $D(HELP) S DIR("?")=HELP
 D ^DIR
 I $G(X)="@" S Y="@" Q Y
 I Y]"",($L($G(Y),U)'=2) S Y=Y_U_$G(Y(0),Y)
 Q Y
