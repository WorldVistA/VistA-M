GMPLUTL1 ; SLC/MKB/KER/TC -- PL Utilities (cont) ;01/15/14  11:13
 ;;2.0;Problem List;**3,8,7,9,26,35,39,36,42**;Aug 25, 1994;Build 46
 ;
 ; External References
 ;   DBIA   446  ^AUTNPOV(
 ;   DBIA 10082  ^ICD9(
 ;   DBIA  1571  ^LEX(757.01
 ;   DBIA 10040  ^SC(
 ;   DBIA 10060  ^VA(200
 ;   DBIA 10003  ^%DT
 ;   DBIA 10104  $$UP^XLFSTR
 ;    ICR  5699  $$ICDDATA^ICDXCODE
 ;
 ; All entry points in this routine expect the
 ; PL("data item") array from routine ^GMPLUTL.
 ;
 ;   Entry     Expected Variable
 ;   Point     From VADPT^GMPLX1
 ;    AO           GMPAGTOR
 ;    IR           GMPION
 ;    EC           GMPGULF
 ;    HNC          GMPHNC
 ;    MST          GMPMST
 ;    CV           GMPCV
 ;    SHD          GMPSHD
 ;
 Q
DIAGNOSI ; ICD Diagnosis Pointer
 N GMPICDSY S GMPICDSY=$S($L($G(PL("CODESYS"))):PL("CODESYS"),1:"DIAG")
 S:'$L($G(PL("DIAGNOSIS"))) PL("DIAGNOSIS")=$$NOS^GMPLX
 Q:$P($$ICDDATA^ICDXCODE(GMPICDSY,+PL("DIAGNOSIS"),PL("DX_DATE_OF_INTEREST"),"I"),U)>0
 S GMPQUIT=1,PLY(0)="Invalid ICD Diagnosis"
 Q
 ;
LEXICON ; Clinical Lexicon Pointer
 S:'$L($G(PL("LEXICON"))) PL("LEXICON")=1
 Q:$D(^LEX(757.01,+PL("LEXICON"),0))
 S GMPQUIT=1,PLY(0)="Invalid Lexicon term"
 Q
DUPLICAT ; Problem Already on the List
 N DUPL,NODE0,NODE1
 Q:$P($G(^GMPL(125.99,1,0)),U,6)'=1
 S:'$L($G(PL("DIAGNOSIS"))) PL("DIAGNOSIS")=$$NOS^GMPLX
 I '$D(^AUPNPROB("B",+PL("DIAGNOSIS")))!('$D(^AUPNPROB("AC",GMPDFN))) Q
 F IFN=0:0 S IFN=$O(^AUPNPROB("AC",GMPDFN,IFN)) Q:IFN'>0  D  Q:$D(GMPQUIT)
 . S (DUPL(1),DUPL(2))=0
 . S NODE0=$G(^AUPNPROB(IFN,0)),NODE1=$G(^(1)) Q:$P(NODE1,U,2)="H"
 . I +PL("DIAGNOSIS")=+NODE0 S DUPL(1)=IFN
 . S:$$UP^XLFSTR(PL("NARRATIVE"))=$$UP^XLFSTR($P(^AUTNPOV($P(NODE0,U,5),0),U)) DUPL(2)=IFN
 . I DUPL(1)>0&DUPL(2)>0 S GMPQUIT=1,PLY(0)="Duplicate problem"
 Q
 ;
LOCATION ; Hospital Location (Clinic) Pointer
 S:'$D(PL("LOCATION")) PL("LOCATION")="" Q:'$L(PL("LOCATION"))
 I $D(^SC(+PL("LOCATION"),0)) S:$P(^(0),U,3)'="C" PL("LOCATION")="" Q
 S GMPQUIT=1,PLY(0)="Invalid hospital location"
 Q
 ;
PROVIDER ; Responsible Provider
 S:'$D(PL("PROVIDER")) PL("PROVIDER")=""
 Q:'$L(PL("PROVIDER"))  Q:$D(^VA(200,+PL("PROVIDER"),0))
 S GMPQUIT=1,PLY(0)="Invalid provider"
 Q
 ;
STATUS ; Problem Status
 S:$G(PL("STATUS"))="" PL("STATUS")="A"
 I "^A^I^a^i^"[(U_PL("STATUS")_U) S PL("STATUS")=$$UP^XLFSTR(PL("STATUS")) Q
 S GMPQUIT=1,PLY(0)="Invalid problem status"
 Q
 ;
ONSET ; Date of Onset
 N %DT,Y,X
 S:'$D(PL("ONSET")) PL("ONSET")="" Q:'$L(PL("ONSET"))
 S %DT="P",%DT(0)="-NOW",X=PL("ONSET") D ^%DT
 I Y>0 S PL("ONSET")=Y Q
 S GMPQUIT=1,PLY(0)="Invalid Date of Onset"
 Q
 ;
RESOLVED ; Date Resolved (Requires STATUS, ONSET)
 N %DT,Y,X
 S:'$D(PL("RESOLVED")) PL("RESOLVED")="" Q:'$L(PL("RESOLVED"))
 S %DT="P",%DT(0)="-NOW",X=PL("RESOLVED") D ^%DT
 I Y'>0 S GMPQUIT=1,PLY(0)="Invalid Date Resolved" Q
 I PL("STATUS")="A" S GMPQUIT=1,PLY(0)="Active problems cannot have a Date Resolved" Q
 I Y<PL("ONSET") S GMPQUIT=1,PLY(0)="Date Resolved cannot be prior to Date of Onset" Q
 S PL("RESOLVED")=Y
 Q
 ;
RECORDED ; Date Recorded (Requires ONSET)
 N %DT,Y,X
 S:'$D(PL("RECORDED")) PL("RECORDED")="" Q:'$L(PL("RECORDED"))
 S %DT="P",%DT(0)="-NOW",X=PL("RECORDED") D ^%DT
 I Y'>0 S GMPQUIT=1,PLY(0)="Invalid Date Recorded" Q
 I PL("RECORDED")<PL("ONSET") S GMPQUIT=1,PLY(0)="Date Recorded cannot be prior to Date of Onset" Q
 S PL("RECORDED")=Y
 Q
 ;
SC ; SC condition flag
 S:'$D(PL("SC")) PL("SC")=""
 I "^^1^0^"'[(U_PL("SC")_U) S GMPQUIT=1,PLY(0)="Invalid SC flag" Q
 I 'GMPSC,+PL("SC") S GMPQUIT=1,PLY(0)="Invalid SC flag"
 Q
 ;
AO ; AO exposure flag (Requires GMPAGTOR)
 S:'$D(PL("AO")) PL("AO")=""
 I "^^1^0^"'[(U_PL("AO")_U) S GMPQUIT=1,PLY(0)="Invalid AO flag" Q
 I 'GMPAGTOR,+PL("AO") S GMPQUIT=1,PLY(0)="Invalid AO flag"
 Q
 ;
IR ; IR exposure flag (Requires GMPION)
 S:'$D(PL("IR")) PL("IR")=""
 I "^^1^0^"'[(U_PL("IR")_U) S GMPQUIT=1,PLY(0)="Invalid IR flag" Q
 I 'GMPION,+PL("IR") S GMPQUIT=1,PLY(0)="Invalid IR flag"
 Q
 ;
EC ; EC exposure flag (Requires GMPGULF)
 S:'$D(PL("EC")) PL("EC")=""
 I "^^1^0^"'[(U_PL("EC")_U) S GMPQUIT=1,PLY(0)="Invalid EC flag" Q
 I 'GMPGULF,+PL("EC") S GMPQUIT=1,PLY(0)="Invalid EC flag"
 Q
HNC ; HNC/NTR exposure flag (Requires GMPHNC)
 S:'$D(PL("HNC")) PL("HNC")=""
 I "^^1^0^"'[(U_PL("HNC")_U) S GMPQUIT=1,PLY(0)="Invalid HNC flag" Q
 I 'GMPHNC,+PL("HNC") S GMPQUIT=1,PLY(0)="Invalid HNC flag"
 Q
MST ; MST exposure flag (Requires GMPMST)
 S:'$D(PL("MST")) PL("MST")=""
 I "^^1^0^"'[(U_PL("MST")_U) S GMPQUIT=1,PLY(0)="Invalid MST flag" Q
 I 'GMPMST,+PL("MST") S GMPQUIT=1,PLY(0)="Invalid MST flag"
 Q
CV ; CV exposure flag (Requires GMPCV)
 S:'$D(PL("CV")) PL("CV")=""
 I "^^1^0^"'[(U_PL("CV")_U) S GMPQUIT=1,PLY(0)="Invalid CV flag" Q
 I 'GMPCV,+PL("CV") S GMPQUIT=1,PLY(0)="Invalid CV flag"
 Q
SHD ; SHD exposure flag (Requires GMPSHD)
 S:'$D(PL("SHD")) PL("SHD")=""
 I "^^1^0^"'[(U_PL("SHD")_U) S GMPQUIT=1,PLY(0)="Invalid SHD flag" Q
 I 'GMPSHD,+PL("SHD") S GMPQUIT=1,PLY(0)="Invalid SHD flag"
 Q
CENTER(X) ; Center X
 N SP
 S $P(SP," ",((IOM-$L(X))\2))=""
 Q $G(SP)_X
READ(TYPE,PROMPT,DEFAULT,HELP,SCREEN) ; Calls reader, returns response
 N DIR,X,Y
 S DIR(0)=TYPE
 I $D(SCREEN) S DIR("S")=SCREEN
 I $G(PROMPT)]"" S DIR("A")=PROMPT
 I $G(DEFAULT)]"" S DIR("B")=DEFAULT
 I $D(HELP) S DIR("?")=HELP
 D ^DIR
 I $G(X)="@" S Y="@" G READX
 I Y]"",($L($G(Y),U)'=2) S Y=Y_U_$G(Y(0),Y)
READX Q Y
EDATE(PRMPT,STATUS,DFLT) ; Get early date
 N X,Y,GMPLPRMT,GMPLDFLT
 I $G(STATUS)=4 S Y=1 Q Y
 S GMPLPRMT=" Start "_$S($L($G(PRMPT)):PRMPT_" ",1:"")_"Date [Time]: "
 S GMPLDFLT=$S($L($G(DFLT)):DFLT,1:"T-30")
 S Y=$$READ("DOA^::AET",GMPLPRMT,GMPLDFLT)
 Q Y
LDATE(PRMPT,STATUS,DFLT) ; Get late date
 N X,Y,GMPLPRMT,GMPLDFLT
 I $G(STATUS)=4 S Y=9999999 Q Y
 S GMPLPRMT="Ending "_$S($L($G(PRMPT)):PRMPT_" ",1:"")_"Date [Time]: "
 S GMPLDFLT=$S($L($G(DFLT)):DFLT,1:"NOW")
 S Y=$$READ("DOA^::AET",GMPLPRMT,GMPLDFLT)
 Q Y
STOP(PROMPT,SCROLL) ; Call DIR at bottom of screen
 N DIR,X,Y,DTOUT
 I $E(IOST)'="C" S Y="" G STOPX
 I +$G(SCROLL),(IOSL>($Y+5)) F  W ! Q:IOSL<($Y+6)
 S DIR(0)="FO^1:1",DIR("A")=$S($G(PROMPT)]"":PROMPT,1:"Press RETURN to continue or '^' to exit")
 S DIR("?")="Enter '^' to quit present action or '^^' to quit to menu"
 D ^DIR I $D(DIRUT),(Y="") K DIRUT
 S Y=$S(Y="^":0,Y="^^":0,$D(DTOUT):"",Y="":1,1:1_U_Y)
STOPX Q Y
DATE(X,FMT) ; Call with X=2910419.01 and FMT=Return Format of date ("MM/DD")
 N AMTH,MM,CC,DD,YY,GMPLI,GMPLTMP
 I +X'>0 S $P(GMPLTMP," ",$L($G(FMT))+1)="",FMT=GMPLTMP G QDATE
 I $S('$D(FMT):1,'$L(FMT):1,1:0) S FMT="MM/DD/YY"
 S MM=$E(X,4,5),DD=$E(X,6,7),YY=$E(X,2,3),CC=17+$E(X)
 S:FMT["AMTH" AMTH=$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",+MM)
 F GMPLI="AMTH","MM","DD","CC","YY" S:FMT[GMPLI FMT=$P(FMT,GMPLI)_@GMPLI_$P(FMT,GMPLI,2)
 I FMT["HR" S FMT=$$TIME(X,FMT)
QDATE Q FMT
TIME(X,FMT) ; Recieves X as 2910419.01 and FMT=Return Format of time (HH:MM:SS).
 N HR,MIN,SEC,GMPLI
 I $S('$D(FMT):1,'$L(FMT):1,1:0) S FMT="HR:MIN"
 S X=$P(X,".",2),HR=$E(X,1,2)_$E("00",0,2-$L($E(X,1,2))),MIN=$E(X,3,4)_$E("00",0,2-$L($E(X,3,4))),SEC=$E(X,5,6)_$E("00",0,2-$L($E(X,5,6)))
 F GMPLI="HR","MIN","SEC" S:FMT[GMPLI FMT=$P(FMT,GMPLI)_@GMPLI_$P(FMT,GMPLI,2)
 Q FMT
NAME(X,FMT) ; Call with X="LAST,FIRST MI", FMT=Return Format ("LAST, FI")
 N GMPLLAST,GMPLLI,GMPFIRST,GMPLFI,GMPLMI,GMPLI
 I X']"" S FMT="" G NAMEX
 I $S('$D(FMT):1,'$L(FMT):1,1:0) S FMT="LAST,FIRST"
 S FMT=$$LOW^XLFSTR(FMT)
 S GMPLLAST=$P(X,","),GMPLLI=$E(GMPLLAST),GMPFIRST=$P(X,",",2)
 S GMPLFI=$E(GMPFIRST)
 S GMPLMI=$S($P(GMPFIRST," ",2)'="NMI":$E($P(GMPFIRST," ",2)),1:"")
 S GMPFIRST=$P(GMPFIRST," ")
 F GMPLI="last","li","first","fi","mi" I FMT[GMPLI S FMT=$P(FMT,GMPLI)_@("GMPL"_$$UP^XLFSTR(GMPLI))_$P(FMT,GMPLI,2)
NAMEX Q FMT
TITLE(X) ; Pads titles
 ; Recieves:    X=title to be padded
 N I,TITLE
 S TITLE="" F I=1:1:$L(X) S TITLE=TITLE_" "_$E(X,I)
 Q TITLE
JUSTIFY(X,JUST) ; Justifies Text
 ; Receives:    X=text to be justified
 ;           JUST="L" --> left, "C" --> center, "R" --> right,
 ;                "J" --> justified to WIDTH
 ;           WIDTH=justification width (when JUST="j"
 I "Cc"[JUST W ?((80-$L(X))/2),X
 I "Ll"[JUST W X,!!
 I "Rr"[JUST W ?(80-$L(X)),X
 Q
