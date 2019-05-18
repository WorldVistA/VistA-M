DIACP ;SLCISC/MKB - Print Policy Documentation ;17FEB2017
 ;;22.2;VA FileMan;**8**;Jan 05, 2016;Build 19
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; -- start here
 N TYPE S TYPE=$$REPORT Q:TYPE="^"
 D @("EN"_TYPE)
 Q
 ;
REPORT() ; -- select report type
 N X,Y,DIR,DUOUT,DTOUT
 S DIR(0)="SAO^1:SUMMARY;2:DETAILED"
 S DIR("A")="Print (S)ummary by Application Action, or (D)etails of a Policy? "
 S DIR("?",1)="Choose Summary to print a list of application actions and their policies,"
 S DIR("?")="or Details to show the full contents of a single policy."
 D ^DIR I Y<1 S Y="^"
 Q Y
 ;
EN1 ; -- print summary list of Events
 N DIC,L,FLDS
 S DIC=1.61,L="LIST ACTIONS",FLDS="[DIAC ACTIONS]"
 D EN1^DIP
 Q
 ;
SELECT() ; -- select a Policy
 N X,Y,DIC
 S DIC=1.6,DIC(0)="AEQM" D ^DIC
 Q $S(Y>0:Y,1:"^")
 ;
EN2 ; -- print Policy details
 N DIPOL S DIPOL=$$SELECT Q:DIPOL<1
 ;
 ;Device
 S %ZIS=$S($D(^%ZTSK):"Q",1:"")
 W ! D ^%ZIS K %ZIS I $G(POP) K POP Q
 K POP
 ;
 ;Queue report?
 I $D(IO("Q")),$D(^%ZTSK) D  G END
 . N ZTRTN,ZTDESC,ZTSAVE
 . S ZTRTN="MAIN^DIACP"
 . S ZTDESC="Report of Policy "_$P(DIPOL,U,2)
 . S ZTSAVE("DIPOL")=""
 . D ^%ZTLOAD
 . I $D(ZTSK)#2 W !,"Report queued!",!,"Task number: "_$G(ZTSK),!
 . E  W !,"Report canceled!",!
 . K ZTSK
 . S IOP="HOME" D ^%ZIS
 ;
 U IO
 ;
MAIN ;entry point for queued report
 N DISTK,DISEQ,DIFCN,DIACHDR,DIACRT,DIACPG
 ;
 D INIT
 D @("HDR"_(2-DIACRT))
 D ACTION
 ;
 ;Unwind members
 S DISTK=0,DISTK(0)=0 D ITEM(+DIPOL) Q:$D(DIRUT)
 S DISTK=1,DISTK(DISTK)=+DIPOL_"^0",DISEQ=0
 F  S DISEQ=$O(^DIAC(1.6,+DISTK(DISTK),10,"AC",DISEQ)) D @$S(+DISEQ'>0:"POP",1:"PROC") Q:DISTK<1  Q:$D(DIRUT)
 ;
 I '$D(DIRUT) D FCNS
 ;
END ;Finish up
 I $D(ZTQUEUED) S ZTREQ="@"
 E  X $G(^%ZIS("C"))
 K DIRUT,DUOUT,DTOUT
 Q
 ;
POP ; pop the stack
 S DISTK=DISTK-1,DISEQ=$P(DISTK(DISTK),U,2)
 Q
 ;
PROC ; process member
 N DIEN
 S $P(DISTK(DISTK),U,2)=DISEQ
 S DIEN=+$O(^DIAC(1.6,+DISTK(DISTK),10,"AC",DISEQ,0)) Q:DIEN<1
 D ITEM(DIEN)
 ; push the stack
 S DISTK=DISTK+1,DISTK(DISTK)=DIEN_"^0",DISEQ=0
 Q
 ;
ITEM(IEN) ; -- top of item
 N X0,X,TYPE,I,DA,T0,NM,VAL
 S X0=$G(^DIAC(1.6,IEN,0)),TYPE=$P(X0,U,2)
 S X=$S($G(DISEQ):DISEQ,TYPE="S":"POLICY SET",TYPE="R":"RULE",1:"POLICY")
 D PG Q:$D(DIRUT)
 W !?((DISTK-1)*3),X_": "_$P(X0,U),?48,"RESULT: "
 I TYPE="R" W $$EFFECT($P(X0,U,8))
 I TYPE'="R",$P(X0,U,7) W $$FNAME($P(X0,U,7)) S DIFCN("R",$P(X0,U,7))=""
 I $P(X0,U,3) D PG Q:$D(DIRUT)  W !?(DISTK*3),"** DISABLED **"
 I $P(X0,U,4) D  Q:$D(DIRUT)
 . D PG Q:$D(DIRUT)
 . W !?(DISTK*3),"ATTRIBUTES: "_$$FNAME($P(X0,U,4))
 . S DIFCN("A",$P(X0,U,4))=""
 ;
 ; targets
 I $O(^DIAC(1.6,IEN,2,0)) D  Q:$D(DIRUT)
 . D PG Q:$D(DIRUT)
 . W !?(DISTK*3),"TARGETS"_$$CONJ($P(X0,U,5))_": "
 . S I=0 F  S I=$O(^DIAC(1.6,IEN,2,"B",I)) Q:I<1  S DA=+$O(^(I,0)) D  Q:$D(DIRUT)
 .. S T0=$G(^DIAC(1.6,IEN,2,DA,0)),NM=$P(T0,U,2),VAL=$P(T0,U,3)
 .. D PG Q:$D(DIRUT)
 .. W !?(DISTK*3),I_":",?((DISTK+1)*3),NM_" = "_VAL
 ;
 ; conditions
 I $O(^DIAC(1.6,IEN,3,0)) D  Q:$D(DIRUT)
 . D PG Q:$D(DIRUT)
 . W !?(DISTK*3),"CONDITIONS"_$$CONJ($P(X0,U,6))_": "
 . S I=0 F  S I=$O(^DIAC(1.6,IEN,3,"B",I)) Q:I<1  S DA=+$O(^(I,0)) D  Q:$D(DIRUT)
 .. S T0=$G(^DIAC(1.6,IEN,3,DA,0)),NM=$P(T0,U,2),VAL=$P(T0,U,3) Q:NM<1
 .. D PG Q:$D(DIRUT)
 .. W !?(DISTK*3),I_":",?((DISTK+1)*3),$$FNAME(NM)_$S($L(VAL):" ("_VAL_")",1:"")
 .. S DIFCN("C",$P(T0,U,2))=""
 ;
 ; messages & functions
 S X=$G(^DIAC(1.6,IEN,7)) ;deny
 I X D PG Q:$D(DIRUT)  W !?(DISTK*3),"DENY FUNCTION: "_$$FNAME(+X) S DIFCN("O",+X)=""
 I $L($P(X,U,2)) D PG Q:$D(DIRUT)  W !?(DISTK*3),"DENY MESSAGE: "_$P(X,U,2)
 S X=$G(^DIAC(1.6,IEN,8)) ;permit
 I X D PG Q:$D(DIRUT)  W !?(DISTK*3),"PERMIT FUNCTION: "_$$FNAME(+X) S DIFCN("O",+X)=""
 I $L($P(X,U,2)) D PG Q:$D(DIRUT)  W !?(DISTK*3),"PERMIT MESSAGE: "_$P(X,U,2)
 ;
 ; available fields
 S X=$G(^DIAC(1.6,IEN,5)) I $L(X) D  Q:$D(DIRUT)
 . D PG Q:$D(DIRUT)
 . W !?(DISTK*3),"FIELDS: "_X
 . S I=0 F  S I=$O(^DIAC(1.6,IEN,5.1,I)) Q:I<1  S X0=$G(^(I,0)) D
 .. S X="("_$P(X0,U)_$S($P(X0,U,3):","_$P(X0,U,3),1:"")_")"
 .. D PG Q:$D(DIRUT)
 .. W !?(DISTK*3),X_": "_$P(X0,U,4)
 ;
 D PG Q:$D(DIRUT)  W !
 ;
 I TYPE'="R",$O(^DIAC(1.6,IEN,10,0)) D  ;caption for next stack level
 . D PG Q:$D(DIRUT)
 . W !?(DISTK*3),$S(TYPE="P":"RULES",1:"POLICIES")_": "
 Q
 ;
CONJ(X) ; -- return name of conjunction
 N Y S Y=$S(X="!":"OR",X="&":"AND",1:"")
 S:$L(Y) Y=" ("_Y_")"
 Q Y
 ;
EFFECT(X) ; -- return Effect name
 N Y S X=$G(X)
 S Y=$S(X="P":"PERMIT",X="D":"DENY",1:"")
 Q Y
 ;
FNAME(X) ; -- return Function name
 Q $P($G(^DIAC(1.62,+$G(X),0)),U)
 ;
FCNS ; -- display functions
 N DITYP,DIEN,X0
 F DITYP="A","C","O","R" D  Q:$D(DIRUT)
 . S DIEN=0 F  S DIEN=$O(DIFCN(DITYP,DIEN)) Q:DIEN<1  D  Q:$D(DIRUT)
 .. S X0=$G(^DIAC(1.62,DIEN,0)) Q:X0=""
 .. D PG Q:$D(DIRUT)  W !,"FUNCTION: "_$P(X0,U)
 .. W ?50,"TYPE: ",$$EXTERNAL^DILFD(1.62,.03,,$P(X0,U,3))
 .. D PG Q:$D(DIRUT)  W !,"  DISPLAY NAME: "_$P(X0,U,2)
 .. I DITYP="R",$L($P(X0,U,4)) D
 ... N X S X=$P(X0,U,4)
 ... W ?44,"NULL VALUE: "_$S(X="P":"PERMIT",X="D":"DENY",1:"")
 .. D PG Q:$D(DIRUT)  W !,"  EXECUTE CODE: "_$G(^DIAC(1.62,DIEN,1))
 .. I $O(^DIAC(1.62,DIEN,2,0)) D DESC(DIEN) Q:$D(DIRUT)
 .. D PG Q:$D(DIRUT)  W !
 Q
 ;
DESC(DA) ; -- write Function Description
 Q:'$O(^DIAC(1.62,+$G(DA),2,0))
 N DII,X
 D PG Q:$D(DIRUT)  W !," DESCRIPTION: "
 S DII=0 F  S DII=$O(^DIAC(1.62,DA,2,DII)) Q:DII<1  S X=$G(^(DII,0)) D PG Q:$D(DIRUT)  W !?1,X
 Q
 ;
INIT ; -- Setup
 N %,%H,X,Y
 S %H=$H D YX^%DTC
 S DIACHDR=$P(Y,"@")_"  "_$P($P(Y,"@",2),":",1,2)_"    PAGE "
 S DIACRT=$E(IOST,1,2)="C-"
 K DIRUT,DUOUT,DTOUT
 Q
 ;
ACTION ; -- display action
 I '$O(^DIAC(1.61,"D",+DIPOL,0)) W !,"APPLICATION ACTION: <none linked>",! Q
 N X0,I,X,DIACT
 S DIACT=0 F  S DIACT=+$O(^DIAC(1.61,"D",+DIPOL,DIACT)) Q:DIACT<1  D
 . S X0=$G(^DIAC(1.61,DIACT,0))
 . W !,"APPLICATION ACTION: ",$P(X0,U),?50,"TYPE: ",$$ACTYP($P(X0,U,4))
 . W !?13,"FILE#: ",$P(X0,U,2),?46,"API NAME: ",$P(X0,U,3)
 . W:$L($G(^DIAC(1.61,DIACT,1))) !," SHORT DESCRIPTION: ",^(1)
 . W:$L($G(^DIAC(1.61,DIACT,5))) !,"  AVAILABLE FIELDS: ",^(5)
 . S I=0 F  S I=$O(^DIAC(1.61,DIACT,5.1,I)) Q:I<1  S X0=$G(^(I,0)) D
 .. S X="("_$P(X0,U)_$S($P(X0,U,3):","_$P(X0,U,3),1:"")_")"
 .. W !,$$RJ^XLFSTR(X,18)_": "_$P(X0,U,4)
 . W !
 Q
 ;
ACTYP(X) ; -- return action type name
 N Y S X=$G(X)
 S Y=$S(X="C":"CREATE",X="R":"READ",X="U":"UPDATE",X="D":"DELETE",1:"")
 Q Y
 ;
PG ; -- check line count for new page
 I $Y+3'<IOSL D HEADER Q:$D(DIRUT)
 Q
 ;
HEADER ; -- all headers except first
 I DIACRT D  Q:$D(DIRUT)
 . N DIR,X,Y
 . S DIR(0)="E" W ! D ^DIR
 I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,DIRUT)=1 Q
HDR1 ;first header for CRTs
 W @IOF
HDR2 ;first header for non-CRTs
 S DIACPG=$G(DIACPG)+1
 ;I $G(DIACT),$L($G(^DIAC(1.61,+$G(DIACT),1))) W ^(1)
 W !,$P(DIPOL,U,2),?(IOM-$L(DIACHDR)-$L(DIACPG)-1),DIACHDR_DIACPG
 W !,$TR($J("",IOM-1)," ","-"),!
 Q
