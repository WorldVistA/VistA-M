ORCDLG2 ;SLC/MKB-Order dialogs cont ;10/12/2007
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**4,60,79,94,243**;Dec 17, 1997;Build 242
 ;;Per VHA Directive 2004-038, this routine should not be modified.
DIR ; -- ^DIR read of X, returns Y
 N INPUTXFM,LKUP,REPL K DTOUT,DUOUT,DIRUT,DIROUT,DDER,Y
 S (X,Y)="",INPUTXFM=$P(DIR(0),U,3,99)
 S LKUP=$G(ORDIALOG(PROMPT,"LKP")) ; special lookup rtn
 S REPL=$S(DATATYPE'="F":0,$L($G(DIR("B")))>20:1,1:0) S:REPL DIR(0)=$E(DIR(0))_"AO^"_$P(DIR(0),U,2,99)
DIR1 I 'REPL W !,DIR("A")_$S($D(DIR("B")):DIR("B")_"// ",1:"") R X:DTIME I '$T S DTOUT=1 Q
 I REPL D ^DIR Q:$D(DTOUT)!$D(DUOUT)
 I X="" S:$D(DIR("B")) X=DIR("B"),Y=ORDIALOG(PROMPT,ORI) S:'$L(X)&(SEQ=1)&('MULT) X="^" Q:'REQD!$L(X)  W $C(7),!!,$$REQUIRED^ORCDLG1,! G DIR1
 I X="@" Q:'REQD  W $C(7),!!,$$REQUIRED^ORCDLG1,! G DIR1
 I X?1"^".E S (DUOUT,DIRUT)=1,Y=X S:X="^^" DIROUT=1 Q
 I X?1"?".E D  G DIR1
 . N XHELP
 . S XHELP=$S($D(DIR("??")):$P(DIR("??"),U,2,99),1:("D "_DATATYPE_"^ORCDLGH"))
 . I (DATATYPE="P")!(DATATYPE="S")!(X?1"??".E) X XHELP
 . S:'$D(DIR("?")) DIR("?")=$$HELP(DATATYPE)
 . I $L(DIR("?"))<80 W !,DIR("?"),!
 . E  D  W !
 . . N X,DIWL,DIWR,I S X=DIR("?"),DIWL=1,DIWR=80 K ^UTILITY($J,"W")
 . . D ^DIWP F I=1:1:^UTILITY($J,"W",DIWL) W !,$G(^UTILITY($J,"W",DIWL,I,0))
 I $L(INPUTXFM) X INPUTXFM I '$D(X) D ERR G DIR1
 I $L(LKUP),$L($T(@LKUP)) D @LKUP Q:Y>0  D ERR G DIR1
 I $G(ORDIALOG(PROMPT,"LIST")) D  Q:$L(Y)  I $P(ORDIALOG(PROMPT,"LIST"),U,2) W $C(7) D LIST^ORCD G DIR1
 . N OROOT S OROOT="ORDIALOG("_PROMPT_",""LIST"")"
 . S:(X=" ")&(DATATYPE="P") X=$$SPACE(DOMAIN)
 . S Y=$$FIND(OROOT,X) ; I X'[",",X'["-" S Y=$$FIND Q
 . ; S ORX=$$EXPLIST(X) F  S Y(Y+1)=$$FIND
 I DATATYPE="P" D DIC I Y'>0 D ERR G DIR1
 I (DATATYPE="R")!(DATATYPE="D") D DT I Y<0 D ERR G DIR1
 I "^F^N^S^Y^"[(U_DATATYPE_U) D  I $G(DDER) D ERR G DIR1 ;JEH 'REPL was  checked 
 . N I F I=1:1:31 S X=$TR(X,$C(I)) ; strip out control char's
 . S DIR("V")="" D ^DIR ; silent
 Q
 ;
ERR ; -- show help msg on error
 W:$D(DIR("?")) $C(7),!,DIR("?"),!
 Q
 ;
FIND(LIST,X) ; -- find value X in LIST(#) or LIST("B",name)
 N Y,XP,CNT,MATCH,I,DIR
 S:$L(X)>63 X=$E(X,1,63) S X=$$UP^XLFSTR(X)
 S CNT=0,XP="" F  S XP=$O(@LIST@("B",XP)) Q:XP=""  I $S(X=+X:+XP=+X,1:$E(XP,1,$L(X))=X) S CNT=CNT+1,MATCH(CNT)=@LIST@("B",XP)_U_XP,DIR("A",CNT)=$J(CNT,3)_" "_XP
 I X=+X!(X?1"0."1.N) S Y=$G(@LIST@(X)) I $L(Y) W "   "_$P(Y,U,2) G:$$OK FQ S X="" W "   " ;force entire text to echo if CNT=1
 I 'CNT S Y="" G FQ
 I CNT=1 S Y=MATCH(1),XP=$P(Y,U,2) W $E(XP,$L(X)+1,$L(XP)) G FQ
 S DIR("A")="Select 1-"_CNT_": ",DIR(0)="NAO^1:"_CNT
 S DIR("?")="Select the desired value, by number"
 D ^DIR I $D(DTOUT)!($D(DUOUT))!(Y="") S Y="" G FQ
 S Y=MATCH(Y) W "  "_$P(Y,U,2)
FQ D:Y&((+DOMAIN=101.43)!(DOMAIN?1"ORD(101.43,:".E)) SETDISV
 Q Y
 ;
OK() ; -- Return 1 or 0, if selected item is correct
 N X,Y,DIR I CNT'>0 Q 1 ;no other matches
 S DIR(0)="YA",DIR("A")="   ...OK? ",DIR("B")="YES"
 S DIR("?")="Enter YES if this is the item you wish to select, or NO to continue searching the list"
 D ^DIR S:$D(DUOUT)!$D(DTOUT) Y=""
 Q +Y
 ;
DIC ; -- ^DIC lookup on X, return Y
 N ORDMN,ORDITM,DIC,D,ORDIC,TYPE S Y=-1,ORDMN=$P(ORDIALOG(PROMPT,0),U,2)
 S ORDITM=$S(+ORDMN=101.43:1,ORDMN?1"ORD(101.43,:".E:1,1:0) ; OI file?
 I X=" ",ORDITM D SPBAR W $S(Y>0:"   "_X,1:$C(7)_"  ??") Q
 I ORDITM,X?1"`"1.N W $C(7),!,"Lookup by internal entry number not allowed!",! Q
 I X=$G(DIR("B")) S Y=ORDIALOG(PROMPT,ORI) Q  ; default
 S DIC=$P(ORDMN,":"),DIC(0)=$P(ORDMN,":",2),ORDIC="^DIC" S:'DIC DIC=U_DIC
 S:$D(ORDIALOG(PROMPT,"S")) DIC("S")=ORDIALOG(PROMPT,"S")
 S TYPE=$P($G(^ORD(100.98,+$G(ORDG),0)),U,3)
 S:ORDITM DIC("W")="W:$S('$D(%):0,'$D(DIY):0,%=DIY:0,1:1) $G(DIY)"_$S(TYPE["RX":" W:$P($G(^(""PS"")),U,6) ""   (non-formulary)"" ",1:"") ;W NAME if OI/synm, or NF
 S D=$G(ORDIALOG(PROMPT,"D")),D=$TR(D,";","^")
 I $L(D) S ORDIC="IX^DIC" S:$L(D,U)>1 ORDIC="MIX^DIC1",DIC(0)=DIC(0)_"M"
 D @ORDIC,SETDISV:Y&ORDITM
 I DIC(0)["S",X'=$P(Y,"^",2) W "  ",$P(Y,"^",2)
 Q
 ;
SPACE(FILE) ; -- Resolve spbar-return for ptrs
 N X,Y,DIC,ROOT S X=" ",FILE=$P(FILE,":")
 I (+FILE=101.43)!(FILE="ORD(101.43,") D SPBAR Q X
 S ROOT=$S(+FILE:$$ROOT^DILFD(+FILE),1:U_FILE),Y=$G(^DISV(DUZ,ROOT))
 S:Y X=$P(@(ROOT_Y_",0)"),U)
 Q X
 ;
SPBAR ; -- Resolve spbar-return for #101.43
 N SDX,I,X1,D S SDX="",D=$G(ORDIALOG(PROMPT,"D")),D=$TR(D,";","^")
 F I=1:1:$L(D,"^") I $P(D,U,I)?1"S."1.E S SDX=$P(D,U,I) Q
 Q:'$L(SDX)  S X1=$G(^DISV(DUZ,"ORDITM",SDX,1)) Q:'$L(X1)
 S Y=$O(^ORD(101.43,SDX,X1,0)) S:Y X=X1,Y=Y_U_X1
 Q
 ;
SETDISV ; -- Save entry Y=ifn^name in ^DISV for #101.43
 N SDX,I Q:'$L($P(Y,U,2))
 S SDX="",D=$G(ORDIALOG(PROMPT,"D")) Q:D'["S."
 F I=1:1:$L(D,";") I $P(D,";",I)?1"S."1.E S SDX=$P(D,";",I) Q
 Q:'$L(SDX)  S ^DISV(DUZ,"ORDITM",SDX,1)=$P(Y,U,2)
 Q
 ;
DT ; -- %DT validation on X, return Y
 N %DT,BEG,END S %DT=$P(DOMAIN,":",3),X=$$UP^XLFSTR(X)
 I $L($P(DOMAIN,":")) S BEG=$$FMDT($P(DOMAIN,":")) ;earliest date allowed
 I $L($P(DOMAIN,":",2)) S END=$$FMDT($P(DOMAIN,":",2)) ;latest allowed
 D ^%DT Q:Y'>0
 I $G(BEG) D  Q:Y<0
 . I $L(Y,".")'=$L(BEG,".") S BEG=$P(BEG,".") ; date only
 . I Y<BEG W $C(7),!,"Date may not be before "_$$FMTE^XLFDT(BEG) S Y=-1 Q
 I $G(END) D  Q:Y<0
 . I $L(Y,".")'=$L(END,".") S END=$P(END,".") ; date only
 . I Y>END W $C(7),!,"Date may not be after "_$$FMTE^XLFDT(END) S Y=-1 Q
 I DATATYPE="R",$$RELDT(X) S:(%DT'["T")&("NOW"[X) X="TODAY" S Y=X ;text
 Q
DT1 S:X="NOON" X="T@NOON" S:$E("MIDNIGHT",1,$L(X))=X X="T@MIDNIGHT"
 I X'?1"V".E,X'?1"T".E D ^%DT S:Y>0&("NOW"[X) Y="NOW" Q
 S D=$$UP^XLFSTR($P(X,"@")),T=$P(X,"@",2)
 S Y=$E(D) I "VT"'[Y S Y=-1 Q
 I (D["+")!(D["-") D  Q:Y<0
 . N SIGN,OFFSET,X1,X2
 . S SIGN=$S(D["+":"+",1:"-"),OFFSET=$P(D,SIGN,2) I 'OFFSET S Y=-1 Q
 . S X1=+OFFSET,X2=$P(OFFSET,X1,2) I "DWM"'[$E(X2) S Y=-1 Q
 . S Y=Y_SIGN_X1_$E(X2) ; T+3W, e.g.
 I '$L(T)&(DOMAIN["R") S Y=-1 Q  ; time missing, required
 I $L(T) D  I '$D(T) S Y=-1 Q
 . I '(DOMAIN["T"!(DOMAIN["R")) K T Q  ; time prohibited
 . N X,Y S X="T@"_T,%DT=$TR(DOMAIN,"E") D ^%DT I Y<0 K T Q
 . S T=$E($P(Y,".",2),1,4) S:$L(T)<4 T=T_$E("0000",1,4-$L(T))
 S:$L(T) Y=Y_"@"_T ; Y=date text, or -1 if error
 Q
 ;
RELDT(X) ; -- Returns 1 or 0, if X is relative date
 N Y S X=$G(X)
 I ("NOON"[X)!("MIDNIGHT"[X)!($E(X)="T")!($E(X)="N") S Y=1
 E  S Y=0
 Q Y
 ;
FMDT(X) ; -- Return FM form of date X
 N Y,%DT S %DT="T" D ^%DT
 Q Y
 ;
WP ; -- edit WP field
 N DIC,DWLW,DWPK,DIWESUB,DONE,ORLINEDT,LCNT,UPCARR
 S DIC="^TMP(""ORWORD"",$J,"_PROMPT_","_INST_",",DWLW=80,DWPK=1
 S DIWESUB=$P(DIR("A"),":"),ORLINEDT=$$LINEDTR(DUZ)
 I '$D(^TMP("ORWORD",$J,PROMPT,INST)) M:$D(^ORD(101.41,+ORDIALOG,10,ITM,8))>9 ^TMP("ORWORD",$J,PROMPT,INST)=^(8)
 I 'ORLINEDT,'REQD,'$$EDITWP Q  ;94
WP1 W:ORLINEDT !,DIR("A") S DIWESUB=$P(DIR("A"),":")
 D EN^DIWE I $D(DTOUT)!($D(DUOUT)) S ORQUIT=1 Q
 I REQD,'$O(^TMP("ORWORD",$J,PROMPT,INST,0)) W $C(7),!!,"A response is required!" G:'$$DONE WP1 S ORQUIT=1 Q
 I '$O(^TMP("ORWORD",$J,PROMPT,INST,0)) K ^TMP("ORWORD",$J,PROMPT,INST),ORDIALOG(PROMPT,INST) Q  ;empty
 S LCNT="",UPCARR=0
 F  S LCNT=$O(^TMP("ORWORD",$J,PROMPT,INST,LCNT)) Q:LCNT=""!(UPCARR=1)  D
 .I LCNT>0,$G(^TMP("ORWORD",$J,PROMPT,INST,LCNT,0))[U S UPCARR=1
 I UPCARR=1 W !!,"An ""^"" is not allowed in a word processing field." G:'$$DONE WP1 S ORQUIT=1 Q
 S ORDIALOG(PROMPT,INST)="^TMP(""ORWORD"","_$J_","_PROMPT_","_INST_")",DONE=1
 I $D(^ORD(101.41,+ORDIALOG,10,ITM,5)) X ^(5) Q:$G(ORQUIT)!($G(DONE))  G WP1
 Q
 ;
EDITWP() ; -- Want to edit WP field?
 N X,Y,%,%Y
 W !,ORDIALOG(PROMPT,"A") S Y=$D(ORDIALOG(PROMPT,INST))
 I 'Y,REQD Q 1 ; no data, req'd
 W:'Y !,"  No existing text",! I Y D  ; show comments
 . N X,DIWL,DIWR,DIWF,ORI
 . S DIWL=3,DIWR=79,DIWF="W" K ^UTILITY($J,"W")
 . S ORI=0 F  S ORI=$O(^TMP("ORWORD",$J,PROMPT,INST,ORI)) Q:ORI'>0  S X=$G(^(ORI,0)) D:$L(X) ^DIWP
 . D ^DIWW
ED1 S %=$S($D(OREDIT):1,1:2) W "  Edit" D YN^DICN
 I %=0 W !,"  Enter 'YES' if you wish to go into the editor.",!,"  Enter 'NO' if you do not wish to edit at this time.",! G ED1
 S Y=$S(%<0:"^",%=2:0,1:1)
 Q Y
 ;
LINEDTR(USER) ; -- Returns 1 or 0, if user's editor will be LineEd
 N X,Y
 S X=+$P($G(^VA(200,USER,1)),U,5),Y=0 I 'X S Y=1
 E  S:$$GET1^DIQ(1.2,+X_",",.01)="LINE EDITOR - VA FILEMAN" Y=1
 Q Y
 ;
RETURN() ; -- press return to cont
 N X W !,"Press <return> to continue ..." R X:DTIME
 Q ""
 ;
DONE() ; -- Done editing?
 N DIR,X,Y
 S DIR(0)="YA",DIR("A")="Do you want to quit? ",DIR("B")="NO"
 S DIR("?")="Enter YES to exit this order, or NO to continue editing"
 D ^DIR
 Q +Y
 ;
HELP(TYPE) ; -- Returns default help msg for TYPE prompt
 N Y S Y=""
 I TYPE="D" S Y="Enter a date[/time]."
 I TYPE="R" S Y="Enter a date[/time] as T for TODAY or T+1 for TOMORROW."
 I TYPE="F" S Y="Enter a string of text."
 I TYPE="N" S Y="Enter a number."
 I TYPE="S" S Y="Enter an item from the list."
 I TYPE="Y" S Y="Enter YES or NO."
 I TYPE="P" S Y="Enter an item from the file."
 I TYPE="W" S Y=""
 Q Y
