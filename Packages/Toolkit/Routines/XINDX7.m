XINDX7 ;ISC/RWF - SETUP ENVITOMENT ;04/22/08  15:12
 ;;7.3;TOOLKIT;**20,27,48,68,110,140,148**;Apr 25, 1995;Build 3
 ; Per VHA Directive 2004-038, this routine should not be modified.
 ;To call XINDEX from elsewere.
 ;D SETUP^XINDX7 then load routines into ^UTILITY($J,1,<rtn name>,0,n,0)
 ;with @root@(0)='line count' and @root@(n,0)=a routine line
 ;Then for each routine S RTN="rtn name",INDLC=0 D BEG^XINDEX
 ;
 Q
SETUP ;Write startup header stuff.
 D BUILD
 U IO D HDR
 S Q="""",U="^",INDDS=0,RTN="$",DA=INDDA,IND("TM")=$H
 I INDDA>0 D START^XINDX10 D:IOSL\2<$Y HDR W !!,"Routines are being processed.",!
 ;Build count of routines.
 S NRO=0,NRO(1)=0,RTN="$"
 F  S RTN=$O(^UTILITY($J,RTN)) Q:RTN=""  S NRO=NRO+1 S:RTN["|" NRO(1)=NRO(1)+1
 S RTN="$"
 W "Routines: ",NRO-NRO(1),"  Faux Routines: ",NRO(1),!!
 Q
HDR S:'$D(INDXDT) DT=$$DT^XLFDT(),INDXDT=$$HTE^XLFDT($H)
 I '$D(INDHDR)  D
 . X ^%ZOSF("UCI") S INDHDR(1)="UCI: "_$P(Y,",")_" CPU: "_^%ZOSF("VOL")_"    "_INDXDT
 . S INDHDR="V. A.  C R O S S  R E F E R E N C E R  "_$P($T(+2),";",3)
 . S INDHDR(2)="[5/5/2016 VA Standards & Conventions]"
 . Q
 W:$Y>3 @IOF W !!,?IOM-$L(INDHDR)\2,INDHDR,!,?IOM-$L(INDHDR(2))\2,INDHDR(2),!,?IOM-$L(INDHDR(1))\2,INDHDR(1),!
 Q
BUILD N IX,X,TAG,TG,TX,S,L,V K IND
 F TAG=1:1 S X=$T(TABLE+TAG) Q:X=""  D
 . S TG=$P(X,";;",2),TX=$P(X,";;",3) Q:TG=""
 . F IX=1:1 S X=$P(TX,":",IX) Q:X=""  D
 . . S S=$P(X,","),L=$P(X,",",2),V=$P(X,",",3)
 . . S IND(TG,S)=L_"^"_V,IND(TG,L)=L_"^"_V
 . Q
 Q
 ;p148 change $Q to 2 max # parameters
TABLE ;;Short name, Full name, parameters (CMD default - add to GRB), FNC: function^min # parameters ; max # parameters
CMD ;;CMD;;B,BREAK,B:C,CLOSE,C:D,DO,DG1^XINDX4:E,ELSE,:F,FOR,F:G,GOTO,G:H,HALT,H:H,HANG,H:I,IF,:J,JOB,J:K,KILL,K:L,LOCK,L
 ;;CMD;;M,MERGE,M:N,NEW,N:O,OPEN,O:Q,QUIT,Q:R,READ,R:S,SET,S:TC,TCOMMIT,TR:TRE,TRESTART,TR:TRO,TROLLBACK,TR:TS,TSTART,TR:U,USE,U:V,VIEW,V:W,WRITE,W:X,XECUTE,X:
 ;;
FNC ;;FNC;;A,ASCII,1;2:C,CHAR,1;999:D,DATA,1;1:E,EXTRACT,1;3:F,FIND,2;3:G,GET,1;2:I,INCREMENT,1;2:J,JUSTIFY,2;3:L,LENGTH,1;2:O,ORDER,1;2:P,PIECE,2;4:Q,QUERY,1;2:R,RANDOM,1;1:S,SELECT,1;999:T,TEXT,1;1:V,VIEW,1;999,
 ;;FNC;;FN,FNUMBER,2;3:NA,NAME,1;2:QL,QLENGTH,1;1:QS,QSUBSCRIPT,1;3:RE,REVERSE,1;1:ST,STACK,1;2:TR,TRANSLATE,1;3:WFONT,WFONT,4;4:WTFIT,WTFIT,6;6:WTWIDTH,WTWIDTH,5;5:
 ;;
SVN ;;SVN;;D,DEVICE:EC,ECODE:ES,ESTACK:ET,ETRAP:H,HOROLOG:I,IO:J,JOB:K,KEY:P,PRINCIPAL:Q,QUIT:S,STORAGE:ST,STACK:SY,SYSTEM:T,TEST:X,X:Y,Y
 ;;
SSVN ;;SSVN;;C,CHARACTER:D,DEVICE:DI,DISPLAY:E,EVENT:G,GLOBAL:J,JOB:L,LOCK:R,ROUTINE:S,SYSTEM:W,WINDOW:Z,Z
