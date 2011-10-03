HLDIEDB3 ;CIOFO-O/LJA - Debug Data Display Code ;12/29/03 10:39
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13,1995
 ;
JOB ; Display information by job#...
 N JOBNO
 ;
 KILL ^TMP($J)
 ;
J1 D SHOWJOB
 ;
J2 R !!,"Enter job#: ",JOBNO:99 Q:JOBNO']""!(JOBNO[U)  ;->
 I '$D(^TMP($J,"HLJOB",JOBNO)) D  G J2 ;->
 .  W "  invalid job#..."
 ;
 D JOBSHOW(JOBNO)
 ;
 G J1 ;->
 ;
SHOWJOB ;
 N C2,CT,CALL,CT,DATA,DATE,JOB,HLDIE,LOOP,NO
 ;
 S HLDIE="HLDIE-DEBUG-",LOOP=HLDIE,CT=0
 F  S LOOP=$O(^XTMP(LOOP)) Q:LOOP'[HLDIE  D
 .  S JOB=0,DATE=$P(LOOP,"-",3)
 .  F  S JOB=$O(^XTMP(LOOP,JOB)) Q:'JOB  D
 .  .  S CALL=""
 .  .  F  S CALL=$O(^XTMP(LOOP,JOB,CALL)) Q:CALL']""  D
 .  .  .  S NO=0
 .  .  .  F  S NO=$O(^XTMP(LOOP,JOB,CALL,NO)) Q:'NO  D
 .  .  .  .  S DATA=^XTMP(LOOP,JOB,CALL,NO),LOC=+DATA
 .  .  .  .  S CT=CT+1,^TMP($J,"HLJOB",JOB,CT)=CALL_"~"_DATA
 .  .  .  .  S ^TMP($J,"HLJOBX",JOB,CALL,NO)=DATA
 ;
 S C2=20
 ;
 W !!,"Job",?C2,"Calls"
 W !,$$REPEAT^XLFSTR("=",IOM)
 ;
 S JOB=0,CT=0
 F  S JOB=$O(^TMP($J,"HLJOBX",JOB)) Q:'JOB  D
 .  S CT=CT+1
 .  W:CT>1 !
 .  W !,JOB,?C2
 .  S CALL=""
 .  F  S CALL=$O(^TMP($J,"HLJOBX",JOB,CALL)) Q:CALL']""  D
 .  .  W:($X+$L(CALL)+3)>IOM ! W:$X<C2 ?C2
 .  .  W:$X>C2 ", "
 .  .  W CALL
 ;
 Q
 ;
JOBSHOW(JOBNO) ;
 N ABORT,CONT,CT,GBL,LOC,NO
 ;
 S GBL="^TMP("_$J_",""HLJOB"","_JOBNO_")"
 ;
 D SHOWDTHD^HLDIEDB0
 ;
 S NO=0,ABORT=0,CT=0,CONT=0
 F  S NO=$O(@GBL@(NO)) Q:'NO!(ABORT)  D
 .  D LOADIT(NO)
 .  D EADTHD^HLDIEDB0(NO,FILE,IEN,LDT,JOBNO,RTN,NO,LOC)
 .  S CT=CT+1
 .  I 'CONT,'(CT#22) R X:60 S:X=" " CONT=1 S:X[U ABORT=1
 ;
 F  D  QUIT:'NO
 .  R !,"Enter #: ",NO:99 Q:NO']""!(NO[U)  ;->
 .  D LOADIT(NO)
 .  D INDIV^HLDIEDB0(LDT\1,JOBNO,RTN,LOC)
 ;
 Q
 ;
LOADIT(NO) ;
 ; GBL -- req
 S DATA=@GBL@(NO),RTN=$P(DATA,"~",1,2),DATA=$P(DATA,"~",3,999)
 S FILE=$P(DATA,U,3),IEN=$P(DATA,U,4),LDT=$P(DATA,U,2)
 S LOC=$P(DATA,U)
 Q
 ;
EOR ;HLDIEDB3 - Direct 772 & 773 Sets DEBUG CODE ; 11/18/2003 11:17
