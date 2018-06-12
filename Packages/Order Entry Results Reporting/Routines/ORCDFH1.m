ORCDFH1 ;SLC/MKB,DKM - Utility functions for FH dialogs cont ; 8/31/17 10:37am
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**73,95,243,462**;Dec 17, 1997;Build 6
 ;
 ; External References:
 ; ^DIR         ICR #10026
 ; $$NOW^XLFDT  ICR #10103
 ; $$UP^XLFSTR  ICR #10104
 ;
RECENT ; -- get 5 most recent diet orders
 N ORDT,ORIFN,ORIT,ORTXT,ORCURR,I,X,CNT,INDT S ORDT=$$NOW^XLFDT,CNT=0
 F  S ORDT=$O(^OR(100,"AW",ORVP,ORDG,ORDT),-1) Q:ORDT'>0  S ORIFN=0 D  Q:CNT'<5
 . F  S ORIFN=$O(^OR(100,"AW",ORVP,ORDG,ORDT,ORIFN)) Q:ORIFN'>0  D  Q:CNT'<5
 .. S (ORIT,ORTXT)="" K ORCURR
 .. S:$P($G(^OR(100,+ORIFN,3)),U,3)=6 ORCURR=1 Q:'$O(^(.1,0))
 .. S I=0 F  S I=$O(^OR(100,ORIFN,.1,I)) Q:I'>0  S X=+$G(^(I,0)) I X D  ;**95
 ... S INDT=$G(^ORD(101.43,X,.1)) S ORIT=ORIT_$S($L(ORIT):";",1:"")_X,ORTXT=ORTXT_$S($L(ORTXT):", ",1:"")_$P($G(^ORD(101.43,X,0)),U)_$S(INDT&(INDT<$$NOW^XLFDT):" (*INACTIVE*)",1:"") ;**95
 .. Q:'ORIT  Q:'$L(ORTXT)  Q:ORTXT="NPO"
 .. S ORDIALOG(PROMPT,"LIST","D",ORIT)=ORIFN ;link oi string to order#
 .. Q:$G(ORCURR)  Q:+$G(ORDIALOG(PROMPT,"LIST","B",ORTXT))
 .. S CNT=CNT+1,ORDIALOG(PROMPT,"LIST",CNT)=ORIT_U_ORTXT
 .. S ORDIALOG(PROMPT,"LIST","B",ORTXT)=ORIT
 S ORDIALOG(PROMPT,"LIST")=CNT,ORDIALOG(PROMPT,"TOT")=0
 Q
 ;
PTR(X) ; -- Return ptr to Order Dialog file #101.41 for prompt X
 Q +$O(^ORD(101.41,"B","OR GTX "_X,0))
 ;
EXP ; -- Expand old order into instances
 N X,I,P,D S X=$G(ORDIALOG(PROMPT,ORI)) Q:'$L(X)  Q:X'[";"
 S ORDIALOG(PROMPT,ORI)=+X,I=ORI ;1st mod only
 F P=2:1:$L(X,";") S D=$P(X,";",P),I=I+1,ORDIALOG(PROMPT,I)=D,ORDIALOG(PROMPT,"TOT")=+$G(ORDIALOG(PROMPT,"TOT"))+1
 ;S:FIRST MAX=$L(X,";")
 Q
 ;
VALID() ; -- Returns 1 or 0, if selected diet modification is valid
 N Y,NUM,I,TOTAL,OI
 ; DRM - 462 - read total from current OI's in ORDIALOG because ORDIALOG(PROMPT,"TOT") doesn't always exist
 N ITEM S ITEM=0,TOTAL=0 F  S ITEM=$O(ORDIALOG(PROMPT,ITEM)) Q:'ITEM  S TOTAL=TOTAL+1
 I '$D(ORESET) S TOTAL=TOTAL-1
 ; DRM - 462 ---
 S OI=$G(ORDIALOG(PROMPT,ORI)) I OI[";" D  Q Y
 .S Y=1 D EXP
 .I $$INACTIVE S Y=0 S ORDIALOG(PROMPT,"TOT")=ORDIALOG(PROMPT,"TOT")-($L(OI,";")-1) F I=0:1:($L(OI,";")-1) K ORDIALOG(PROMPT,(I+ORI)) ;**95
 ; DRM - 462 - see above comment
 ;S Y=1,TOTAL=+$G(ORDIALOG(PROMPT,"TOT")),ORDIALOG(PROMPT,"MAX")=5,MAX=5
 S Y=1,ORDIALOG(PROMPT,"MAX")=5,MAX=5
 ; DRM - 462 ---
 I $$INACTIVE Q 0  ;**95
 ;S:FIRST MAX=$S($G(ORDIALOG(PROMPT,"LIST","D",OI)):1,1:5)
 S OI=$P($G(^ORD(101.43,+OI,0)),U)
 I (OI="REGULAR")!(OI="NPO") D  Q Y
 . I '$D(ORESET),TOTAL=0 S ORDIALOG(PROMPT,"MAX")=1,MAX=1 Q  ; add first
 . I $G(ORESET),TOTAL'>1 S ORDIALOG(PROMPT,"MAX")=1,MAX=1 Q  ; edit first
 . S Y=0 W $C(7),!,OI_" may not be ordered with other diets!"
 ;I $$DUP^ORCD(PROMPT,ORI) W $C(7),"This diet has already been selected!" Q 0  ;may delete after testing patch 95
 S NUM=$P($G(^ORD(101.43,+ORDIALOG(PROMPT,ORI),"FH")),U,2) ; precedence #
 S I=0 F  S I=$O(ORDIALOG(PROMPT,I)) Q:I'>0  D  Q:Y'>0
 . ; DRM - 462 - 2017/7/24 - if Regular or NPO diet, do not allow other diets to be added
 . ;Q:I=ORI  Q:$P($G(^ORD(101.43,+ORDIALOG(PROMPT,I),"FH")),U,2)'=NUM  ;ok
 . Q:I=ORI  Q:($P($G(^ORD(101.43,+ORDIALOG(PROMPT,I),"FH")),U,2)'=NUM)&($P($G(^ORD(101.43,+ORDIALOG(PROMPT,I),0)),U)'="REGULAR")&($P($G(^ORD(101.43,+ORDIALOG(PROMPT,I),0)),U)'="NPO")
 . ; DRM - 462 - 2017/7/24 ---
 . S Y=0 W $C(7),!,"This diet is not orderable with those already selected!",!
 Q Y
 ;
PREV ; -- Ck if previous diet being reordered
 N I,OI,IFN S OI="",I=0
 F  S I=$O(ORDIALOG(PROMPT,I)) Q:I'>0  S OI=OI_$S(OI:";",1:"")_ORDIALOG(PROMPT,I)
 S IFN=$S(OI:$G(ORDIALOG(PROMPT,"LIST","D",OI)),1:"")
 S:IFN ORDIALOG("PREV")=IFN K:'IFN ORDIALOG("PREV")
 Q
 ;
CNV ; -- Convert meal abbreviation to time in X [Input Xform]
 ; Expects X,PROMPT [also called from Entry Action, DO^ORWDXM2]
 N A1 S X=$$UP^XLFSTR(X),A1=$P(X,"@",2)
 I A1?1U,"BNE"[A1 D
 . I $G(ORTYPE)="Z" S DATATYPE="",Y=X Q  ;editor - ok
 . N TIMES S TIMES=$S($D(ORPARAM(2)):$P(ORPARAM(2),U,7,9),1:"6:00A^12:00P^6:00P")
 . S A1=$S(A1="B":$P(TIMES,U),A1="N":$P(TIMES,U,2),A1="E":$P(TIMES,U,3),1:A1)
 . S $P(X,"@",2)=A1
 Q
 ;
LKUP ; -- special lookup routine for diet modifications
 G:'$G(ORDIALOG(PROMPT,"LIST")) LKQ N OROOT,Z
 S:X=" " X=$$SPACE^ORCDLG2(DOMAIN) S OROOT=$NA(ORDIALOG(PROMPT,"LIST"))
 S Y=$$FIND^ORCDLG2(OROOT,X)
 I Y Q:X?1N  Q:'$$MORE(X,Y)  S Z=$$OK Q:Z  I Z="^" S Y="^" Q
LKQ D DIC^ORCDLG2
 Q
 ;
MORE(XX,YY) ; -- Returns 1 or 0, if more matches exist
 Q:$P(YY,U)[";" 1 ;multiple mods
 N CNT,XP,NOW S CNT=0,XP=XX,NOW=+$$NOW^XLFDT
 F  S XP=$O(^ORD(101.43,"S.DO",XP)) Q:$E(XP,1,$L(XX))'=XX  D  Q:CNT
 . N IFN S IFN=$O(^ORD(101.43,"S.DO",XP,0)) Q:IFN=+YY  ;same mod
 . I $G(^ORD(101.43,IFN,.1)),$G(^(.1))'>NOW Q  ;inactive
 . S CNT=CNT+1
 Q CNT
 ;
OK() ; -- Verify multiple diet mod selection
 N X,Y,DIR S DIR(0)="YA",DIR("A")="   ... OK? ",DIR("B")="Yes"
 S DIR("?")="Enter YES if you wish to re-order this entire diet, or NO to search for another single diet modification"
 D ^DIR S:$D(DUOUT)!$D(DTOUT) Y="^"
 Q Y
INACTIVE() ;Check for inactive/duplicate diets in single or multiple modifications ;**95
 N I,Y
 S Y=0
 S I=0 F  S I=$O(ORDIALOG(PROMPT,I)) Q:'+I  D
 .I $G(^ORD(101.43,ORDIALOG(PROMPT,I),.1)),^(.1)<$$NOW^XLFDT S Y=1 W !,"The ",$P(^ORD(101.43,ORDIALOG(PROMPT,I),0),U)," diet is INACTIVE." Q  ;Quit if inactive diet found in order
 F I=0:1:($L(OI,";")-1) I $$DUP^ORCD(PROMPT,(I+ORI)) S Y=1 W !,"The ",$P(^ORD(101.43,ORDIALOG(PROMPT,(I+ORI)),0),U)," diet has already been selected." ;check for duplicate orders
 Q Y
