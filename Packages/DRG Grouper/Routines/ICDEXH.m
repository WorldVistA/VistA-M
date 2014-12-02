ICDEXH ;SLC/KER - ICD Extractor - API Help ;04/21/2014
 ;;18.0;DRG Grouper;**57**;Oct 20, 2000;Build 1
 ;               
 ;               
 ; Global Variables
 ;    None
 ;               
 ; External References
 ;    ^%ZIS               ICR  10086
 ;    HOME^%ZIS           ICR  10086
 ;    ^%ZISC              ICR  10089
 ;    ^%ZTLOAD            ICR  10063
 ;    ^DIR                ICR  10026
 ;               
EN ; API Help Main Entry Point
 D HLP("EXT") Q
ALL ;   Help for All APIs
 N SEL,EXIT,ANS,HDR S EXIT=0 K SEL D HLP("AL")
 Q
HLP(X) ; Help for X APIs
 N SEL,EXIT,ANS,TYPE,HDR S EXIT=0 K SEL S TYPE=$G(X) S:'$L(TYPE) TYPE="AL"  Q:'$L($T(@(TYPE_"+0^ICDEXH")))  D @TYPE
 Q
EXT ; Extraction API Help
 S HDR=" Data Extraction API Help available for:"
 D EX S ANS=$$ASK Q:+ANS'>0  Q:'$D(SEL(+ANS))  D DHLP
 Q
LEG ; Legacy API Help
 S HDR=" Legacy API Help available for:"
 D LG S ANS=$$ASK Q:+ANS'>0  Q:'$D(SEL(+ANS))  D DHLP
 Q
SDD ; SDD Mandated API Help
 S HDR=" SDD Mandated API Help available for:"
 D SD S ANS=$$ASK Q:+ANS'>0  Q:'$D(SEL(+ANS))  D DHLP
 Q
AL ; All APIs Help
 S HDR=" API Help available for:"
 K SEL D EX,LG,SD S ANS=$$ASK Q:+ANS'>0  Q:'$D(SEL(+ANS))  D DHLP
 Q
DHLP ;   Display Help
 N %ZIS,CF,CONT,DNC,EOP,I,LC,ZTDESC,ZTDTH,ZTIO,ZTQUEUED,ZTREQ,ZTRTN,ZTSAVE,ZTSK,POP
 S %ZIS("A")=" Device:  ",ZTRTN="DIS^ICDEXH",ZTDESC="Display ICD API Help"
 S ZTIO=ION,ZTDTH=$H,%ZIS="Q",ZTSAVE("SEL(")="",ZTSAVE("ANS")="" W ! D ^%ZIS I POP K %ZIS Q
 S ZTIO=ION I $D(IO("Q")) D QUE,^%ZISC,HOME^%ZIS K %ZIS Q
 K %ZIS D NOQUE Q
NOQUE ;   Do not queue Display
 W @IOF W:IOST["P-" !,"< Not queued, printing ICD API Help >",! U:IOST["P-" IO D @ZTRTN,^%ZISC,HOME^%ZIS Q
QUE ;   Task queued to print Help
 K IO("Q") D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued",1:"Request Cancelled"),! Q
 Q
CAP ; Capture
 D EX N ENT,CHR S CHR="",ENT=0 F  S ENT=$O(SEL(ENT)) Q:+ENT'>0  D
 . N API,TTL,END,MENU,TXT,TXT2,TAG,RTN,CF,FIRST,LINE S TTL=$G(SEL(ENT)),API=$G(SEL(ENT,1))
 . Q:'$L(TTL)  Q:'$L($P(TTL,"^",1))  Q:'$L($P(TTL,"^",2))  Q:'$L($P(TTL,"  ",2,299))
 . Q:'$L(API)  Q:'$L($P(API,"^",1))  Q:'$L($P(API,"^",2))  Q:API'["ICDEX"
 . S END=$E($P(API,"ICDEX",2),1) I END'=CHR D
 . . S CHR=END N HDR,LN S (HDR,LN)="" S:END="C" HDR="ICD Code APIs" S:END="A" HDR="Misceaneous ICD APIs"
 . . S:END="S" HDR="ICD Support APIs" S:END="D" HDR="DRG Grouper APIs" S:END="H" HDR="ICD API Help"
 . . S:END="L" HDR="ICD Special Lookup APIs" S:$L(HDR) $P(LN,"=",$L(HDR))="=" W:$L(HDR) !!,HDR,!,LN,!
 . S TAG=$P(API,"^",1),RTN=$P(API,"^",2)
 . Q:'$L($T(@(RTN_"^"_RTN)))  Q:'$L($T(@(TAG_"^"_RTN)))
 . S EXEC="S FIRST=$T("_TAG_"+1^"_RTN_")" X EXEC
 . S MENU=TTL,TXT2=$$TM($T(@(TAG_"+1^"_RTN))) W !!,$S('$D(FORUM):" ",1:""),MENU W:$G(FIRST)'[";" !
 . S CF=1 S TXT="" F LINE=1:1  D  Q:'$L(TXT)
 . . N EXEC,TXT2,TXT3 S (TXT,TXT2,TXT3)=""
 . . S EXEC="S (TXT,TXT2)=$T("_TAG_"+"_LINE_"^"_RTN_")" X EXEC
 . . S EXEC="S TXT3=$T("_TAG_"+"_(LINE+1)_"^"_RTN_")" X EXEC
 . . S TXT2=$$TM(TXT2) I TXT2="Q"!(TXT2'[";") S TXT="" Q
 . . S:TXT3'[";" TXT3="" S:TXT2[";" TXT2=" "_$P(TXT2,";",2,299)
 . . I $L(TXT2),$L(TXT3) W:'$D(FORUM) !,"  ",TXT2 W:$D(FORUM) !,$$TM(TXT2) S CF=0
 N FORUM
 Q
 ;
DIS ; Display
 N MENU,TAG,RTN,LINE,TXT,TXT1,TXT2,CF,LC,EOP,CONT,EXIT S ANS=+($G(ANS)) Q:+ANS'>0
 S MENU=$G(SEL(+($G(ANS)))),TAG=$G(SEL(+($G(ANS)),1)),RTN=$P(TAG,"^",2),TAG=$P(TAG,"^",1)
 Q:'$L(MENU)  Q:'$L(TAG)  Q:'$L(RTN)  Q:'$L($T(@(RTN_"^"_RTN)))  Q:'$L($T(@(TAG_"^"_RTN)))
 S CONT="",(CF,LC)=0,EOP=+($G(IOSL)) S:EOP=0 EOP=24 S TXT1=$$TM($T(@(TAG_"^"_RTN)))
 S TXT2=$$TM($T(@(TAG_"+1^"_RTN))) W:$L($G(IOF)) @IOF W:'$L($G(IOF)) ! D:'$L($G(IOF)) LF
 W !," ",MENU D LF W:$L(TXT2) ! D:$L(TXT2) LF
 S CF=1 S TXT="" F LINE=1:1  D  Q:'$L(TXT)
 . N EXEC,TXT2,TXT3 S (TXT,TXT2,TXT3)=""
 . S EXEC="S (TXT,TXT2)=$T("_TAG_"+"_LINE_"^"_RTN_")" X EXEC
 . S EXEC="S TXT3=$T("_TAG_"+"_(LINE+1)_"^"_RTN_")" X EXEC
 . S TXT2=$$TM(TXT2) I TXT2="Q"!(TXT2'[";") S TXT="" Q
 . S:TXT3'[";" TXT3="" S:TXT2[";" TXT2=" "_$P(TXT2,";",2,299)
 . I $L(TXT2),$L(TXT3) W !,"  ",TXT2 S CF=0 D LF
 S:$D(ZTQUEUED) ZTREQ="@" K:+($G(EXIT))>0 SEL,ANS Q:+($G(EXIT))>0  I 'CF D EOP
 W:$L($G(IOF)) @IOF K SEL,ANS
 Q
LF ;   Line Feed
 S LC=LC+1 D:IOST["P-"&(LC>(EOP-7)) EOP D:IOST'["P-"&(LC>(EOP-4)) EOP
 Q
EOP ;   End of Page
 S LC=0 W:IOST["P-" @IOF Q:IOST["P-"  W !! S CONT=$$CONT S CF=1
 Q
CONT(X) ;   Ask to Continue
 Q:+($G(EXIT))>0 "^^"  N DIR,DIROUT,DIRUT,DUOUT,DTOUT,Y S DIR(0)="EAO",DIR("A")=" Enter RETURN to continue or '^' to exit: "
 S DIR("PRE")="S:X[""?"" X=""??"" S:X[""^"" X=""^""",(DIR("?"),DIR("??"))="^D CONTH^ICDEXH"
 D ^DIR S:X["^^"!($D(DTOUT)) X="^^",EXIT=1 Q:X["^^"!(+($G(EXIT))>0) "^^"  Q:$D(DIROUT)!($D(DIRUT))!($D(DUOUT))!($D(DTOUT)) "^"
 Q:X["^^" "^^"  Q:X["^" "^"
 Q ""
CONTH ;      Ask to Continue Help
 W !,"     Enter either RETURN or '^'."
 Q
 ; 
ASK(X) ;   Multiple Entries Found
 Q:+($G(EXIT))>0 "^^"
 N IEN,ITEM,TOT,MAX,ENT,ANS,EXIT,LEN,ROOT,Y,INT S INT=" API Help available for:"
 S:$L($G(HDR)) INT=$G(HDR) S LEN=+($G(LEN)) S:+LEN'>0 LEN=10 S (MAX,ENT,ANS,EXIT)=0,U="^"
 S TOT=$O(SEL(" "),-1) G:+TOT=0 MULQ S ANS=0 W:+TOT>1 !,INT
 F ENT=1:1:TOT Q:((ANS>0)&(ANS<ENT+1))  Q:EXIT  D  Q:EXIT
 . N ITEM,IEN,TEXT S ITEM=$G(SEL(ENT))
 . S IEN=+ITEM,TEXT=$P(ITEM,U,2) Q:'$L(TEXT)
 . S MAX=ENT W:ENT#LEN=1 ! W !,$J(ENT,4),".  ",ITEM
 . W:ENT#LEN=0 ! S:ENT#LEN=0 ANS=$$MULS(MAX,ENT) S:ANS["^" EXIT=1
 I ENT#LEN'=0,+ANS=0 W ! S ANS=$$MULS(MAX,ENT) S:ANS["^" EXIT=1
 G MULQ
 Q X
MULS(MAX,ENT) ;     Select Multiple
 Q:+($G(EXIT))>0 "^^"
 N X,Y,LAST,NEXT,RAN,DIR,DTOUT,DUOUT,DIROUT,DIRUT,DIRB,HLP
 S MAX=+($G(MAX)),LAST=+($G(ENT)) Q:MAX'>0 -1
 S RAN=" Select 1-"_MAX_":  ",NEXT=$O(SEL(+LAST))
 S:+NEXT>0 DIR("A")=" Press <RETURN> for more, '^' to exit, or"_RAN
 S:+NEXT'>0 DIR("A")=RAN
 S HLP="    Answer must be from 1 to "_MAX_", or <Return> to continue"
 S DIR("PRE")="S:X[""?"" X=""??"""
 S (DIR("?"),DIR("??"))="^D MULSH^ICDEXH"
 S DIR(0)="NAO^1:"_MAX_":0" D ^DIR
 S:X["^^"!($D(DTOUT)) EXIT=1,X="^^"
 I X["^^"!(+($G(EXIT))>0) Q "^^"
 S Y=+Y S:$D(DTOUT)!(X["^") Y="^" K DIR
 Q Y
MULSH ;     Select Multiple Help
 I $L($G(HLP)) W !,$G(HLP) Q
 Q
MULQ ;     Quit Multiple
 Q:+($G(ANS))'>0 -1  S X=+($G(ANS))
 Q X
 ;
 ; Build Menus
EX ;   Extraction APIs
 N LINE,RTN,TXT S RTN="ICDEX",TXT="" F LINE=1:1  D  Q:'$L(TXT)
 . N EXEC,TXT1,TXT2,MENU,TAG,CALL,COMM,SEQ S (TXT,TXT1,TXT2)="",EXEC="S TXT1=$T(+"_LINE_"^"_RTN_")" X EXEC
 . S EXEC="S TXT2=$T(+"_(LINE+1)_"^"_RTN_")" X EXEC S TXT=TXT2 Q:'$L(TXT)  Q:$P(TXT1," ",1)="EN"!($P(TXT2," ",1)="EN")
 . Q:$P(TXT1," ",1)="HELP"!($P(TXT2," ",1)="HELP")  Q:TXT1["ICDEXH"!(TXT2["ICDEXH")
 . I $E(TXT1,1)'=" ",$E(TXT2,1)=" ",TXT1[" ; ",(TXT2["^ICDEX"!(TXT2["^ICDTOKN")) D
 . . N TAG,CALL,NAM,ENT,COM S TAG=$P(TXT1,"(",1),TAG=$P(TAG," ",1)
 . . I TXT1[(TAG_"(") D
 . . . S CALL=TAG_"^"_RTN S:TXT1[(TAG_"(") CALL=CALL_"("_$P($P(TXT1,"(",2),")",1)_")" S:TXT2["$$" CALL="$$"_CALL
 . . I TXT1'[(TAG_"(") S TAG=$P(TXT1," ; ",1),CALL=TAG_"^"_RTN
 . . S COM=$P(TXT1," ;",2),COM=$P(COM,"ICDEX",1),COM=$P(COM," (ICD",1),COM=$P(COM," (inter",1),COM=$P(COM," (opp",1)
 . . S COM=$$TM(COM),MENU=CALL,MENU=MENU_$J(" ",(40-$L(MENU)))_COM,CALL=$$TM(TXT2) S:$E(CALL,2)=" " CALL=$P(CALL," ",2)
 . . S:CALL["(" CALL=$P(CALL,"(",1) S TAG=$P(CALL,"^",1),NAM=$P(CALL,"^",2),TAG=$TR(TAG,"$","")
 . . S ENT=$T(@(TAG_"^"_NAM))
 . . Q:'$L(ENT)  S SEQ=$O(SEL(" "),-1)+1,SEL(SEQ)=MENU,SEL(SEQ,1)=TAG_"^"_NAM
 Q
LG ;   Legacy APIs
 N LINE,RTN,TXT S RTN="ICDEX",TXT="" F LINE=1:1  D  Q:'$L(TXT)
 . N EXEC,TXT1,MENU,TAG,CAL,NAM,TAG,RTN,SEQ S (TXT,TXT1,TXT2)="",EXEC="S TXT1=$T(LEGI+"_LINE_"^ICDEXH)" X EXEC
 . S TXT=TXT1 Q:'$L(TXT)  S TXT=$P(TXT,";;",2)  Q:'$L(TXT)  S CAL=$P(TXT1,";;",2) Q:'$L(CAL)
 . S NAM=$P(TXT1,";;",3) Q:'$L(NAM)  S TAG=$P(TXT1,";;",4) Q:'$L(TAG)  S RTN=$P(TXT1,";;",5) Q:'$L(RTN)
 . S MENU=CAL,MENU=MENU_$J(" ",(40-$L(MENU)))_NAM  S SEQ=$O(SEL(" "),-1)+1,SEL(SEQ)=MENU,SEL(SEQ,1)=TAG_"^"_RTN
 Q
LEGI ; Legacy API Menu Items
 ;;$$ICDDX^ICDCODE(CODE,CDT,DFN,SRC);;ICD Dx code info;;ICDDX;;ICDCODE
 ;;$$ICDOP^ICDCODE(CODE,CDT,DFN,SRC);;ICD Op/Proc code info;;ICDOP;;ICDCODE
 ;;ICDD^ICDCODE(CODE,OUTARR,CDT);;ICD description;;ICDD;;ICDCODE
 ;;$$CODEN^ICDCODE(CODE,FILE);;IEN from code;;CODEN;;ICDCODE
 ;;$$CODEC^ICDCODE(IEN,FILE);;Code from IEN;;CODEC;;ICDCODE
 ;;$$CODEBA^ICDCODE(CODE,ROOT);;IEN from code/root;;CODEBA;;ICDCODE
 ;;$$DTBR^ICDAPIU(CDT,CS);;Date Business Rules;;DTBR;;ICDAPIU
 ;;$$MSG^ICDAPIU(CDT,CS);;Warning Message;;MSG;;ICDAPIU
 ;;$$STATCHK^ICDAPIU(CODE,CDT);;Check ICD code status;;STATCHK;;ICDAPIU
 ;;$$NEXT^ICDAPIU(CODE);;Next ICD Code;;NEXT;;ICDAPIU
 ;;$$PREV^ICDAPIU(CODE);;Previous ICD Code;;PREV;;ICDAPIU
 ;;$$HIST^ICDAPIU(CODE,ARY);;Activation History;;HIST;;ICDAPIU
 ;;PERIOD^ICDAPIU(CODE,ARY);;Activation Periods;;PERIOD;;ICDAPIU
 ;;$$EFF^ICDSUPT(FILE,IEN,CDT);;Effective date and status;;EFF;;ICDSUPT
 ;;$$NUM^ICDSUPT(CODE);;Numeric value from code;;NUM;;ICDSUPT
 ;;;;
SD ;   SDD Mandated APIs
 N LINE,RTN,TXT S RTN="ICDEX",TXT="" F LINE=1:1  D  Q:'$L(TXT)
 . N EXEC,TXT1,MENU,TAG,CAL,NAM,TAG,RTN,SEQ S (TXT,TXT1,TXT2)="",EXEC="S TXT1=$T(SDDI+"_LINE_"^ICDEXH)" X EXEC
 . S TXT=TXT1 Q:'$L(TXT)  S TXT=$P(TXT,";;",2)  Q:'$L(TXT)  S CAL=$P(TXT1,";;",2) Q:'$L(CAL)
 . S NAM=$P(TXT1,";;",3) Q:'$L(NAM)  S TAG=$P(TXT1,";;",4) Q:'$L(TAG)  S RTN=$P(TXT1,";;",5) Q:'$L(RTN)
 . S MENU=CAL,MENU=MENU_$J(" ",(40-$L(MENU)))_NAM  S SEQ=$O(SEL(" "),-1)+1,SEL(SEQ)=MENU,SEL(SEQ,1)=TAG_"^"_RTN
 Q
SDDI ; SDD Mandated API Menu Items
 ;;$$ICDDATA^ICDXCODE(CSYS,CODE,DATE,FRMT);;ICD code data;;ICDDATA;;ICDXCODE
 ;;$$ICDDESC^ICDXCODE(CSYS,CODE,DATE,.ARY);;ICD code description;;ICDDESC;;ICDXCODE
 ;;$$STATCHK^ICDXCODE(CSYS,CODE,DATE);;ICD code status and date;;STATCHK;;ICDXCODE
 ;;$$PREV^ICDXCODE(CSYS,CODE);;Previous ICD code;;PREV;;ICDXCODE
 ;;$$NEXT^ICDXCODE(CSYS,CODE);;Next ICD code;;NEXT;;ICDXCODE
 ;;$$HIST^ICDXCODE(CSYS,CODE,ARY);;Activation History;;HIST;;ICDXCODE
 ;;$$PERIOD^ICDXCODE(CSYS,CODE,ARY);;Activation/Inactivation Periods;;PERIOD;;ICDXCODE
 ;;$$SEARCH^ICDSAPI(FILE,SCR,DI,VDT,FMT);;Search ICD files;;SEARCH;;ICDSAPI
 ;;;;
 ; Miscellaneous
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" " F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
