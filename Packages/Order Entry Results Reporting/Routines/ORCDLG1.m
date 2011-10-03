ORCDLG1 ; SLC/MKB - Order dialogs cont ;12/15/2006
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**60,71,95,110,243**;Dec 17, 1997;Build 242
 ;Per VHA Directive 2004-038, this routine should not be modified.
EN(ITM,INST) ; -- ask each ITM prompt where
 ;    ORDIALOG(PROMPT,#) = internal form of each response
 ;
 N ITEM,COND,MULT,REQD,EDITONLY,DATATYPE,DOMAIN,DIR,Y,ACTION,PROMPT,ORX,VALIDEF
 S ITEM=$G(^ORD(101.41,+ORDIALOG,10,ITM,0)),COND=$G(^(3))
 S PROMPT=$P(ITEM,U,2) Q:'PROMPT  S:'$G(INST) INST=1
 S MULT=$P(ITEM,U,7),ACTION=$P(ITEM,U,9)
 S REQD=$P(ITEM,U,6),EDITONLY=$P(ITEM,U,8) S:$G(ORTYPE)="Z" (REQD,EDITONLY)=0
 I $D(^ORD(101.41,+ORDIALOG,10,ITM,9)) X ^(9) G:$G(ORQUIT) ENQ ;Entry
 I $G(ORTYPE)="Q",$D(ORDIALOG(PROMPT,INST)),$E(ORDIALOG(PROMPT,0))'="W" S EDITONLY=1
 I '$D(ORDIALOG(PROMPT,INST)) D  ; get default value
 . I $E(ORDIALOG(PROMPT,0))="W",$D(^ORD(101.41,+ORDIALOG,10,ITM,8))>9 M ^TMP("ORWORD",$J,PROMPT,INST)=^(8) S ORDIALOG(PROMPT,INST)="^TMP(""ORWORD"","_$J_","_PROMPT_","_INST_")" Q
 . K Y X:$D(^ORD(101.41,+ORDIALOG,10,ITM,7)) ^(7)
 . I $D(Y) S VALIDEF=$$VALID S:VALIDEF ORDIALOG(PROMPT,INST)=Y ;**95
 . I $G(VALIDEF)=0 W !,"The DEFAULT value for the ",$G(ORDIALOG(PROMPT,"A"))," prompt is invalid." S EDITONLY=0 ;**95
 . K VALIDEF ;**95
 I $G(AUTO),'REQD!($E(ORDIALOG(PROMPT,0))="W"&$D(ORDIALOG(PROMPT,INST))) S EDITONLY=1 ;Auto-accept
EN0 I FIRST&EDITONLY D:$D(ORDIALOG(PROMPT,INST))  G ENQ  ;ck child prompts
 . Q:'$D(^ORD(101.41,+ORDIALOG,10,"DAD",PROMPT))  N SEQ,DA,ITEM,PRMT,X,Y,VALIDEF ;**95
 . S SEQ=0 F  S SEQ=$O(^ORD(101.41,+ORDIALOG,10,"DAD",PROMPT,SEQ)) Q:SEQ'>0  S DA=$O(^(SEQ,0)) D  Q:$G(ORQUIT)
 . . K VALIDEF ;110
 . . S ITEM=$G(^ORD(101.41,+ORDIALOG,10,DA,0)),PRMT=$P(ITEM,U,2)
 . . Q:$D(ORDIALOG(PRMT,INST))  ; already has a value
 . . K Y X:$D(^ORD(101.41,+ORDIALOG,10,DA,7)) ^(7)
 . . I $D(Y) S VALIDEF=$$VALID ;**95
 . . I $G(VALIDEF)!('$P(ITEM,U,6)) S:$G(VALIDEF) ORDIALOG(PRMT,INST)=Y Q  ;**95
 . . D EN(DA,INST) ; ask
 I ($G(OREDIT)&(ACTION'["C"))!($G(ORENEW)&(ACTION'["R")) G ENQ ;ask?
 I $G(OREWRITE),ACTION'["W",FIRST,'REQD!$D(ORDIALOG(PROMPT,INST)) G ENQ
 I $L(COND) X COND G:'$T ENQ ; failed condition
 M DIR=ORDIALOG(PROMPT) S DATATYPE=$E(DIR(0)),DOMAIN=$P(DIR(0),U,2)
 I 'MULT D WP^ORCDLG2:DATATYPE="W",ONE(INST,REQD):DATATYPE'="W" G ENQ
EN1 ; -- loop for multiples
 I '$O(ORDIALOG(PROMPT,0)) D  G:$G(ORQUIT)!('$O(ORDIALOG(PROMPT,0)))!FIRST ENQ
M1 . D ADDMULT Q:$G(ORQUIT)
 . Q:'REQD!$O(ORDIALOG(PROMPT,0))  I FIRST,$G(SEQ)=1 S ORQUIT=1 Q
 . W $C(7),!!,$$REQUIRED,! G M1
 F  S ORX=$$SELECT Q:ORX=""  S:ORX="^" ORQUIT=1 Q:$G(ORQUIT)  D  Q:$G(DIROUT)
 . S DIR("A")=ORDIALOG(PROMPT,"A"),X=$S('REQD:0,$$ONLY(ORX):1,1:0)
 . D ADDMULT:ORX="A",ONE(ORX,X):ORX Q:$G(DIROUT)  K ORQUIT,DIR("B")
 . I REQD,'$O(ORDIALOG(PROMPT,0)) W $C(7),!!,$$REQUIRED,!
ENQ X:$D(^ORD(101.41,+ORDIALOG,10,ITM,10)) ^(10) ; exit action
 Q
 ;
REQUIRED() ; -- Required response message
 Q "A response is required!  Enter '^' to quit."
 ;
SELECT() ; -- select instance of multiple to edit
 N DIR,X,Y,CNT,I,MAX,TOTAL,DONE
 S MAX=+$G(ORDIALOG(PROMPT,"MAX")),TOTAL=+$G(ORDIALOG(PROMPT,"TOT"))
 S DIR("A",1)=$S($L($G(ORDIALOG(PROMPT,"TTL"))):ORDIALOG(PROMPT,"TTL"),1:ORDIALOG(PROMPT,"A"))
 S (I,CNT)=0 F  S I=$O(ORDIALOG(PROMPT,I)) Q:I'>0  S CNT=CNT+1,CNT(CNT)=I,DIR("A",CNT+1)=$J(CNT,3)_": "_$$ITEM^ORCDLG(PROMPT,I) ; parent+children
 I 'MAX!(MAX&(MAX>TOTAL)) S CNT=CNT+1,CNT(CNT)="A",DIR("A",CNT+1)=$J(CNT,3)_": <enter more>"
 S DIR("A")="Select "_$S(CNT>1:"(1-"_CNT_")",1:1)_" or <return> to continue: "
 S DIR(0)="NAO^1:"_CNT,DIR("?")="Select the instance you wish to change"
S1 D ^DIR I $D(DTOUT)!(Y="^") Q "^"
 I Y?1"^".E D UJUMP Q:$G(ORQUIT)!($G(DONE)) "" G S1
 I Y="" Q Y
 Q CNT(Y)
 ;
ONLY(I) ; -- I the only instance?
 N J,Z S J=0,Z=1
 F  S J=$O(ORDIALOG(PROMPT,J)) Q:J'>0  I J'=I S Z=0 Q
 Q Z
 ;
ADDMULT ; -- add new instances of multiple
 N DONE,LAST,INST,MAX,ANOTHER
 S MAX=+$G(ORDIALOG(PROMPT,"MAX")) I MAX,MAX'>$G(ORDIALOG(PROMPT,"TOT")) W $C(7),!,"Only "_MAX_" items may be selected!",! Q
 S ANOTHER=$G(ORDIALOG(PROMPT,"MORE")) S:'$L(ANOTHER) ANOTHER="Another "
 S DIR("A")=$S($O(ORDIALOG(PROMPT,0)):ANOTHER,1:"")_ORDIALOG(PROMPT,"A")
 F  D  Q:$G(ORQUIT)!($G(DONE))  I MAX Q:MAX'>$G(ORDIALOG(PROMPT,"TOT"))
 . S INST=$O(ORDIALOG(PROMPT,"?"),-1)+1
 . D ONE(INST,0) I '$D(ORDIALOG(PROMPT,INST)) S DONE=1 Q
 . S ORDIALOG(PROMPT,"TOT")=+$G(ORDIALOG(PROMPT,"TOT"))+1,DIR("A")=ANOTHER_ORDIALOG(PROMPT,"A")
 Q
 ;
ONE(ORI,REQD) ; -- ask single-valued prompt
 N DONE,ORESET
 S:$D(ORDIALOG(PROMPT,ORI)) DIR("B")=$$EXT^ORCD(PROMPT,ORI),ORESET=ORDIALOG(PROMPT,ORI)
 F  D  Q:$G(DONE)  I $G(ORQUIT) Q:FIRST  Q:'REQD!$D(ORDIALOG(PROMPT,ORI))  S FIRST=$$DONE^ORCDLG2 Q:FIRST  K ORQUIT
 . D DIR^ORCDLG2 I $D(DTOUT)!$D(DIROUT)!(X=U) S ORQUIT=1 Q
 . I X="" S DONE=1 Q
 . I X?1"^".E D UJUMP Q
 . I X="@" D DELETE Q
 . I $E(DIR(0))="N",Y<1,$E(Y,1,2)'="0." S Y=0_Y
 . S ORDIALOG(PROMPT,ORI)=$P(Y,U),DONE=1
 . X:$L($G(^ORD(101.41,+ORDIALOG,10,ITM,5))) ^(5) I '$G(DONE) D RESET Q  ; validate - if failed, K DONE to reask
 . D:$D(^ORD(101.41,+ORDIALOG,10,"DAD",PROMPT)) CHILDREN(PROMPT,ORI) I '$G(DONE),'FIRST D DELCHILD(PROMPT,ORI),RESET Q
 Q
 ;
CHILDREN(PARENT,INST) ; -- ask child prompts
 N SEQ,DA,ORQUIT S SEQ=0
 F  S SEQ=$O(^ORD(101.41,+ORDIALOG,10,"DAD",PARENT,SEQ)) Q:SEQ'>0  S DA=$O(^(SEQ,0)) D EN(DA,INST) Q:$G(ORQUIT)
 K:$G(ORQUIT) DONE ; reask parent
 Q
 ;
RESET ; -- Reset original prompt value
 K ORDIALOG(PROMPT,ORI)
 S:$D(ORESET) ORDIALOG(PROMPT,ORI)=ORESET
 Q
 ;
UJUMP ; -- ^-jump
 N XP,P,CNT,MATCH,I,DIR,NEWSEQ ; XP=$$UP(X),P=PROMPT
 I $G(NOJUMP) W $C(7),"  ^-jumping not allowed!" Q
 S XP=$$UP^XLFSTR($P(X,U,2)) I "^"[XP S ORQUIT=1 Q
 I $G(ORDIALOG("B",XP)) S NEWSEQ=+ORDIALOG("B",XP) G UJQ
 S CNT=0,P=XP F  S P=$O(ORDIALOG("B",P)) Q:P=""  Q:$E(P,1,$L(XP))'=XP  Q:FIRST&(+ORDIALOG("B",P)'<SEQ)  S CNT=CNT+1,MATCH(CNT)=+ORDIALOG("B",P)_U_P ; =SEQ^TEXT
 I 'CNT W $C(7),"  ??" Q
 I CNT=1 S P=$P(MATCH(1),U,2) W $E(P,$L(XP)+1,$L(P)) S NEWSEQ=+MATCH(1) G UJQ
 F I=1:1:CNT S DIR("A",I)=I_"  "_$P(MATCH(I),U,2)
 S DIR("A")="Select 1-"_CNT_": ",DIR(0)="NAO^1:"_CNT
 S DIR("?")="Select the field you wish to jump to, by number"
 D ^DIR I $D(DTOUT)!($D(DUOUT))!(Y="") Q
 S NEWSEQ=+MATCH(Y)
UJQ I FIRST,NEWSEQ'<SEQ W $C(7),"  ^-jumping ahead not allowed now!" Q
 S SEQ=NEWSEQ-.01,DONE=1
 Q
 ;
DELETE ; -- delete response
 I '$D(DIR("B")) W $C(7),"  ??" Q
 Q:'$$SURE  S DONE=1
 K ORDIALOG(PROMPT,ORI),DIR("B")
 S:$G(ORDIALOG(PROMPT,"TOT")) ORDIALOG(PROMPT,"TOT")=ORDIALOG(PROMPT,"TOT")-1
 I $D(^ORD(101.41,+ORDIALOG,10,"DAD",PROMPT)) D DELCHILD(PROMPT,ORI)
 Q
 ;
DELCHILD(PARENT,INST) ; -- delete child prompts
 N SEQ,DA,PTR S:'$G(INST) INST=1
 S SEQ=0 F  S SEQ=$O(^ORD(101.41,+ORDIALOG,10,"DAD",PARENT,SEQ)) Q:SEQ'>0  S DA=$O(^(SEQ,0)),PTR=+$P($G(^ORD(101.41,+ORDIALOG,10,DA,0)),U,2) K:PTR ORDIALOG(PTR,INST)
 Q
 ;
SURE() ; -- sure you want to delete?
 N X,Y,DIR
 S DIR(0)="YA",DIR("A")="  Are you sure you want to delete this value? "
 S DIR("B")="NO" W $C(7) D ^DIR
 S:$D(DTOUT) Y="^"
 Q Y
 ;
VALID() ;Check to see if default value is valid.  Returns 0 or 1
 ;Entire section added in patch 95
 N TYPE,RANGE,MIN,MAX,DIR,X,ORDIC,DDS,RTYPE,ORIG
 I Y="" Q 1 ;If default is null allow to pass ;110
 S DIR(0)=$G(ORDIALOG(PROMPT,0)),(ORIG,X)=Y,DIR("V")="" ;Set reader type, default input, silent call
 S TYPE=$E($P(DIR(0),"^")) ;Get type of look-up being done
 I TYPE="W" Q 1 ;If word processing assume value is valid, may be referencing a global location
 I TYPE="R" S $P(DIR(0),"^")="D"_$E($P(DIR(0),"^"),2,999),TYPE="D",RTYPE=1 ;If type is R then change to date look up
 I TYPE="D" I X="AM"!(X="NEXT")!(X="NEXTA")!(X="CLOSEST") Q 1 ;If date/time prompt default is AM, NEXT, NEXTA, or CLOSEST then accept without checking
 S:TYPE="P"&(X=+X) X="`"_X ;If pointer type add ` to IEN for DIR call
 I TYPE="P" S ORDIC=$P(DIR(0),"^",2) S $P(ORDIC,":",2)=$TR($P(ORDIC,":",2),"QE","") S $P(DIR(0),"^",2)=ORDIC ;If pointer type remove Q&E from DIC(0) so no echo and no ?? on erroneous input
 I TYPE="D" S ORDIC=$P(DIR(0),"^",2) S $P(ORDIC,":",3)=$TR($P(ORDIC,":",3),"E",""),$P(ORDIC,":")=$TR($P(ORDIC,":"),"DTNOW",""),$P(DIR(0),"^",2)=ORDIC ;Remove "E" so no echo, remove DT and NOW so DIR call works correctly
 I TYPE="Y" S:"^Y^YE^YES^"[("^"_$TR(X,"yes","YES")_"^")!(X=1) X="YES" S:"^N^NO^"[("^"_$TR(X,"no","NO")_"^")!(X=0) X="NO" ;If yes/no type convert input to uppercase full entry to avoid echo
 I TYPE="S" S DDS=1 ;Stops DIR call from echoing rest of entry for set of codes
 D ^DIR
 I TYPE="D"&('$D(Y(0))) Q 0 ;Date not valid
 I TYPE="L"&($G(Y)="") Q 0 ;List/Range not valid
 I TYPE="N"&('$D(Y)) Q 0 ;Numeric not valid
 I TYPE="P"&($G(Y)=-1) Q 0 ;Pointer not valid
 I TYPE="S"&($G(Y(0))="") Q 0 ;Set of codes not valid
 I TYPE="Y"&($G(Y(0))="") Q 0 ;Yes/No not valid
 I TYPE="F" S RANGE=$P(DIR(0),"^",2),MIN=$S($P(RANGE,":"):$P(RANGE,":"),1:1),MAX=$S($P(RANGE,":",2):$P(RANGE,":",2),1:240) I $L(Y)<MIN!($L(Y)>MAX) Q 0 ;Free text and not within valid limit
 I $G(RTYPE) S Y=ORIG ;Set y back to relative date
 I TYPE="P" S Y=$P(Y,"^") ;only store IEN ;110
 Q 1 ;Must be valid
