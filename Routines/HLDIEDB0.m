HLDIEDB0 ;CIOFO-O/LJA - Debug Data Display Code ;12/29/03 10:39
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13,1995
 ;
FILEIEN ; Input FILE,IEN to find debug data to display...
 N ABORT,CT,DATE,FILE,GBL,GCT,IEN,JOB,LOC,RTN,X
 ;
 W @IOF,$$CJ^XLFSTR("Debug Data Display by FILE,IEN",IOM)
 W !,$$REPEAT^XLFSTR("=",IOM)
 ;
 I '$D(^XTMP("HLDIE-DEBUGX")) D  QUIT  ;->
 .  W !!,"No debug data exists..."
 .  H 1
 ;
 S GBL="^XTMP(""HLDIE-DEBUGX"")"
 ;
 F  D  QUIT:'FILE  ;->
 .  D SF
 .  R !!,"Enter FILE#: ",FILE:99 Q:FILE']""!(FILE[U)  ;->
 .  F  D  QUIT:'IEN  ;->
 .  .  D SI(FILE)
 .  .  R !!,"Enter IEN: ",IEN:99 Q:'IEN  ;->
 .  .  W !!,?2,"#",?5,"File & IEN",?20,"Date",?35,"Job#",?50,"Rtn",?68,"Debug#"
 .  .  W !,$$REPEAT^XLFSTR("=",IOM)
 .  .  KILL ^TMP($J,"H")
 .  .  S DATE=0,ABORT=0,GCT=0
 .  .  F  S DATE=$O(@GBL@(FILE,IEN,DATE)) Q:'DATE!(ABORT)  D
 .  .  .  S JOB=0
 .  .  .  F  S JOB=$O(@GBL@(FILE,IEN,DATE,JOB)) Q:'JOB!(ABORT)  D
 .  .  .  .  S RTN=""
 .  .  .  .  F  S RTN=$O(@GBL@(FILE,IEN,DATE,JOB,RTN)) Q:RTN']""!(ABORT)  D
 .  .  .  .  .  S LOC=""
 .  .  .  .  .  F  S LOC=$O(@GBL@(FILE,IEN,DATE,JOB,RTN,LOC)) Q:LOC']""!(ABORT)  D
 .  .  .  .  .  .  S GCT=GCT+1
 .  .  .  .  .  .  S ^TMP($J,"H",GCT)=DATE_U_JOB_U_RTN_U_LOC
 .  .  .  .  .  .  W !,$J(GCT,3),?5,FILE,"[#",IEN,"]",?20,DATE,?35,JOB,?50,RTN,?68,LOC
 .  .  F  D  QUIT:'GCT
 .  .  .  R !!,"Enter #: ",GCT:99 Q:'GCT  ;->
 .  .  .  S X=$G(^TMP($J,"H",+GCT)),DATE=+X,JOB=$P(X,U,2),RTN=$P(X,U,3),LOC=$P(X,U,4) QUIT:LOC']""  ;->
 .  .  .  D INDIV(DATE\1,JOB,RTN,LOC)
 .  .  .  W !,$$REPEAT^XLFSTR("-",IOM)
 ;
 KILL ^TMP($J,"H")
 ;
 Q
 ;
SF ; Show files...
 ; GBL -- req
 N CT,FILE
 W !!,$$CJ^XLFSTR(" Files w/Debug Data ",IOM,"=")
 S CT=0,FILE=0
 F  S FILE=$O(@GBL@(FILE)) Q:'FILE  D
 .  S CT=CT+1 W:CT>1 ", "
 .  W FILE
 W !,$$REPEAT^XLFSTR("-",IOM)
 Q
 ;
SI(FILE) ; Show IENs for file...
 ; GBL -- req
 N CT,IEN
 W !!,$$CJ^XLFSTR(" IENs w/Debug Data for File# "_FILE_" ",IOM,"=")
 S CT=0,IEN=0
 F  S IEN=$O(@GBL@(FILE,IEN)) Q:'IEN!(CT>100)  D
 .  S CT=CT+1
 .  W:$X>65 ! W:$X<6 ?6 W:$X>6 ","
 .  W IEN
 I CT>100 D
 .  W !!,"Some IENs not displayed (because there were too many)..."
 .  W !,"(The LAST IEN is ",$O(@GBL@(FILE,":"),-1),".)"
 W !,$$REPEAT^XLFSTR("-",IOM)
 Q
 ;
SEARCH ; Search of global data to find & display...
 N ABORT,CONT,CT,DATA,FIND,LP,ORIG,POSX,SRCH,ST,X
 ;
 W @IOF,$$CJ^XLFSTR("Debug Data Display by Global Search",IOM)
 W !,$$REPEAT^XLFSTR("=",IOM)
 ;
 I '$D(^XTMP("HLDIE-DEBUGX")) D  QUIT  ;->
 .  W !!,"No debug data exists..."
 .  H 1
 ;
S1 KILL SRCH
 ;
 F  R !!,"Search string: ",SRCH:999 Q:SRCH']""!(SRCH=U)  D
 .  S SRCH($$UP^XLFSTR(SRCH))=""
 ;
 QUIT:$O(SRCH(""))']""  ;->
 ;
 W !!,"Searching..."
 ;
 S CT=0,ABORT=0,CONT=0
 ;
 S LP="^XTMP(""HLDIE-DEBUF""",ST="^XTMP(""HLDIE-DEBUG",LP=LP_")"
 F  S LP=$Q(@LP) Q:LP'[ST!(ABORT)  D
 .  S ORIG=@LP,DATA=$$UP^XLFSTR(ORIG),FIND=0,SRCH=""
 .  F  S SRCH=$O(SRCH(SRCH)) Q:SRCH']""!(FIND)  D
 .  .  QUIT:DATA'[SRCH&(LP'[SRCH)  ;->
 .  .  S FIND=1
 .  QUIT:'FIND  ;->
 .  W !,LP,"="
 .  W:$X>55 !,?10,"-> "
 .  S POSX=$X
 .  F  D  QUIT:ORIG']""
 .  .  W:$X>POSX ! W:$X<POSX ?POSX
 .  .  W $E(ORIG,1,IOM-POSX)
 .  .  S ORIG=$E(ORIG,IOM-POSX+1,999)
 .  QUIT:CONT  ;->
 .  S CT=CT+1 Q:(CT#10)  ;->
 .  W " <-" R X:99 S:X]""&(X'=" ") ABORT=1 S:X=" " CONT=1
 ;
 I ABORT=1 W !!,"... aborting ..."
 ;
 G S1 ;->
 ;
API ; Select RTN & SUBRTN to find & show debug data...
 N DATE,FILE,MAX,NUM,RTN,SUB
 ;
 W @IOF,$$CJ^XLFSTR("Debug Data Display by API Call",IOM)
 W !,$$REPEAT^XLFSTR("=",IOM)
 ;
 I '$D(^XTMP("HLDIE-DEBUGX")) D  QUIT  ;->
 .  W !!,"No debug data exists..."
 .  H 1
 ;
 W !
 D COLLECT
 D SHOW
 ;
R1 R !!,"File: ",FILE:99 QUIT:FILE']""  ;->
 I '$D(^XTMP("HLDIE-DEBUGX",FILE)) D  G R1 ;->
 .  W "  no data..."
 ;
 R !,"Rtn: ",RTN:99 G:RTN']"" R1 ;->
 R !,"Subrtn: ",SUB:99 G:SUB']"" R1 ;->
 S RTN=RTN_"~"_SUB
 ;
 R !,"Max#: 20// ",MAX:99 S:MAX']"" MAX=20
 S MAX=$S(MAX:MAX,1:20)
 ;
 F  D  QUIT:DATE']""  ;->
 .  KILL ^TMP($J,"R")
 .  R !!,"Enter Date/time (FM): ",DATE:99 QUIT:DATE']""  ;->
 .  I DATE'?7N.E W " invalid format..." QUIT  ;->
 .  
 .  W !
 .  D SHOWDT(FILE,DATE,RTN,MAX)
 .  QUIT:'$D(^TMP($J,"R"))  ;->
 .
 .  F  D  QUIT:NUM']""!(NUM[U)
 .  .  R !!,"Enter # to display: ",NUM:99 Q:NUM']""!(NUM[U)  ;->
 .  .  I '$D(^TMP($J,"R",NUM)) D  QUIT  ;->
 .  .  .  W "  entry not found..."
 .  .  D SHOWONE(+NUM)
 ;
 H 2
 ;
 D SHOW
 ;
 G R1 ;->
 ;
SHOWONE(NUM) ; REquires ^TMP($J,"R",NUM)
 N DATA,DATE,FILE,IEN,JOB,LOC,RTN
 ;
 S DATA=^TMP($J,"R",NUM)
 ;
 S FILE=+DATA,IEN=$P(DATA,U,2),DATE=$P(DATA,U,3)\1
 S JOB=$P(DATA,U,4),RTN=$P(DATA,U,5),LOC=$P(DATA,U,6)
 ;
 D INDIV(DATE,JOB,RTN,LOC)
 ;
 Q
 ;
INDIV(DATE,JOB,RTN,LOC) ; Display entry's data from ^XTMP global...
 N LP,REF,ST
 ;
 S LP="^XTMP(""HLDIE-DEBUG-"_DATE_""","_JOB_","""_RTN_""","_LOC
 S ST=LP,LP=LP_")"
 ;
 W !!,"...",$P(LP,"^XTMP(""HLDIE-DEBUG-"_DATE,2),"="
 D SDATA($X,$G(@LP))
 ;
 F  S LP=$Q(@LP) Q:LP'[ST  D
 .  S REF=$P(LP,"^XTMP(""HLDIE-DEBUG-"_DATE,2)_"="
 .  W !,"...",REF
 .  D SDATA($X,@LP)
 ;
 W !
 ;
 Q
 ;
SDATA(POSX,DATA) ; Show data...
 ;
 F  D  Q:DATA']""
 .  QUIT:DATA']""  ;->
 .  W:$X>POSX ! W:$X<POSX ?POSX
 .  W $E(DATA,1,IOM-POSX)
 .  S DATA=$E(DATA,IOM-POSX+1,999)
 ;
 Q
 ;
SHOWDT(FILE,DATE,RTN,MAX) ; Show entries and create ^TMP($J,"R")...
 N ABORT,CT,DATA,GBL,IEN,JOB,JOBLAST,LDT,NO,NUM
 ;
 S GBL="^XTMP(""HLDIE-DEBUGX"","_FILE_")"
 ;
 D SHOWDTHD
 ;
 S IEN=0,CT=0,ABORT=0,JOBLAST=""
 F  S IEN=$O(@GBL@(IEN)) Q:'IEN!(CT'<MAX)  D
 .  S LDT=DATE-.0000000001
 .  F  S LDT=$O(@GBL@(IEN,LDT)) Q:'LDT  D
 .  .  S JOB=0
 .  .  F  S JOB=$O(@GBL@(IEN,LDT,JOB)) Q:JOB'>0  D
 .  .  .  S NO=$O(@GBL@(IEN,LDT,JOB,RTN,":"),-1)/2\1 QUIT:'NO  ;->
 .  .  .  S NUM=0
 .  .  .  F  S NUM=$O(@GBL@(IEN,LDT,JOB,RTN,NUM)) Q:'NUM  D
 .  .  .  .  S CT=CT+1
 .  .  .  .  S DATA=$G(@GBL@(IEN,LDT,JOB,RTN,NUM))
 .  .  .  .  S ^TMP($J,"R",CT)=FILE_U_IEN_U_LDT_U_JOB_U_RTN_U_NUM
 .  .  .  .  I JOBLAST'=""&(JOBLAST) W ! S JOBLAST=0
 .  .  .  .  D EADTHD(CT,FILE,IEN,LDT,JOB,RTN,NUM,+DATA)
 .  .  .  S JOBLAST=JOB
 ;
 Q
 ;
EADTHD(CT,FILE,IEN,LDT,JOB,RTN,NUM,LOC) ;
 W !,$J(CT,3),?5,FILE,?15,+IEN,?25,"@",$P(LDT,".",2)
 W ?35,JOB,?50,RTN,?70,LOC,$S(LOC=1:"<-Beg",1:"")
 Q
 ;
SHOWDTHD ;
 W !!,"#",?5,"File",?15,"IEN",?25,"Time",?35,"Job#",?50,"Location"
 W ?70,"Call#"
 W !,$$REPEAT^XLFSTR("=",IOM)
 Q
 ;
SHOW ;
 N CT,DATE,FILE,RTN
 ;
 W !!,"File",?17,"Date",?40,"API"
 W !,$$REPEAT^XLFSTR("=",IOM)
 ;
 S FILE=0
 F  S FILE=$O(^TMP($J,"D",FILE)) Q:'FILE  D
 .  W !,FILE," [#",^TMP($J,"D",FILE),"]"
 .  S DATE=0
 .  F  S DATE=$O(^TMP($J,"D",FILE,DATE)) Q:'DATE  D
 .  .  W:$X>17 ! W:$X<17 ?17
 .  .  W DATE," [#",^TMP($J,"D",FILE,DATE),"]"
 .  .  S RTN=""
 .  .  F  S RTN=$O(^TMP($J,"D",FILE,DATE,RTN)) Q:RTN']""  D
 .  .  .  W:$X>40 ! W:$X<40 ?40
 .  .  .  W RTN," [#",^TMP($J,"D",FILE,DATE,RTN),"]"
 ;
 Q
 ;
COLLECT ; Collect data into ^TMP($J,"D")...
 N DATE,FILE,IEN,JOB,LOC,RTN
 ;
 KILL ^TMP($J)
 ;
 S FILE=0
 F  S FILE=$O(^XTMP("HLDIE-DEBUGX",FILE)) QUIT:'FILE  D
 .  S IEN=0
 .  F  S IEN=$O(^XTMP("HLDIE-DEBUGX",FILE,IEN)) Q:'IEN  D
 .  .  S DATE=0
 .  .  F  S DATE=$O(^XTMP("HLDIE-DEBUGX",FILE,IEN,DATE)) Q:'DATE  D
 .  .  .  ; HLDIE-DEBUGX data hangs around longer...
 .  .  .  QUIT:'$D(^XTMP("HLDIE-DEBUG-"_(DATE\1)))  ;->
 .  .  .  S JOB=0
 .  .  .  F  S JOB=$O(^XTMP("HLDIE-DEBUGX",FILE,IEN,DATE,JOB)) Q:'JOB  D
 .  .  .  .  S RTN=""
 .  .  .  .  F  S RTN=$O(^XTMP("HLDIE-DEBUGX",FILE,IEN,DATE,JOB,RTN)) Q:RTN']""  D
 .  .  .  .  .  S LOC=0
 .  .  .  .  .  F  S LOC=$O(^XTMP("HLDIE-DEBUGX",FILE,IEN,DATE,JOB,RTN,LOC)) Q:'LOC  D
 .  .  .  .  .  .  D COLL1(FILE,IEN,DATE\1,JOB,RTN,LOC)
 ;
 Q
 ;
COLL1(FILE,IEN,DATE,JOB,RTN,LOC) ; Called by COLLECT...
 ;
 S ^TMP($J,"D",FILE)=$G(^TMP($J,"D",FILE))+1
 S ^TMP($J,"D",FILE,DATE)=$G(^TMP($J,"D",FILE,DATE))+1
 S ^TMP($J,"D",FILE,DATE,RTN)=$G(^TMP($J,"D",FILE,DATE,RTN))+1
 ;
 Q
 ;
ONLYASC(TXT) ; Return ASCII only. No CTRL characters...
 N ASCII,CHAR,NTXT,POS
 S NTXT=""
 F POS=1:1:$L(TXT) D
 .  S CHAR=$E(TXT,+POS),ASCII=$A(CHAR)
 .  I ASCII<32 S CHAR="{"_ASCII_"}"
 .  S NTXT=NTXT_CHAR
 QUIT NTXT
 ;
EOR ;HLDIEDBO - Direct 772 & 773 Sets DEBUG CODE ; 11/18/2003 11:17
