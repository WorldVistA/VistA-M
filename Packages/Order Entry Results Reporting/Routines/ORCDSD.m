ORCDSD ;SLC/AGP Scheduling Order dialog utilities ;09/12/17
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**434**;Dec 17, 1997;Build 35
 ;Per VHA Directive 6402, this routine should not be modified.
 Q
 ;
INTERH ;
 N LIST,NAME
 W !,"Select one of the following:"
 D INTERL(.LIST)
 S NAME="" F  S NAME=$O(LIST(NAME)) Q:NAME=""  W !,"  "_NAME
 Q
INTERL(LIST) ;
 S LIST("WEEKLY")="",LIST("DAILY")=""
 Q
 ;
INTERV ;
 N NAME,LIST,TMP
 S TMP=$$UP^XLFSTR(X)
 D INTERL(.LIST)
 I $D(LIST(TMP)) Q
 W !!,X_"is an invalid interval",!!
 D INTERH
 W !
 K X
 Q
 ;
PREREQP(LIST) ;
 N ERR
 D GETLST^XPAR(.LIST,"SYS","OR SD DIALOG PREREQ","N",.ERR)
 Q
 ;
PREREQH ;
 N CNT,LIST
 D PREREQP(.LIST)
 I '$D(LIST) W !,"No prerequisites defined"
 W !,"Select from the following:"
 S CNT=0 F  S CNT=$O(LIST(CNT)) Q:CNT'>0  D
 .I $P(LIST(CNT),U)="" Q
 .W !,"  "_$P(LIST(CNT),U)
 Q
 ;
PREREQN() ;
 N LIST,NUM
 D PREREQP(.LIST)
 I '$D(LIST) Q 0
 S NUM=LIST
 Q NUM
 ;
PREREQV ;
 N ARRAY,CNT,NODE,LIST,TMP
 S TMP=$$UP^XLFSTR(X)
 D PREREQP(.LIST)
 S CNT=0 F  S CNT=$O(LIST(CNT)) Q:CNT'>0  D
 .I $P(LIST(CNT),U)="" Q
 .S ARRAY($$UP^XLFSTR($P(LIST(CNT),U)))=""
 I '$D(ARRAY(TMP)) W !,X_" is not a valid prerequisite" K X Q
 I $G(X)="" W !! D PREREQH
 Q
 ;
SETSTOP() ;
 N %DT,CIDC,RESULT,OFFSET,X,Y
 S RESULT="T"
 S X=$$VAL^ORCD("CLINICALLY")
 S %DT="T" D ^%DT
 S OFFSET=$$GET^XPAR("SYS","OR SD CIDC STOP OFFSET",1,"E")
 I Y>0 S RESULT=$$FMADD^XLFDT(Y,OFFSET)
 Q RESULT
 ;
VALCLINC(Y) ;
 ;N IEN
 ;S IEN=$O(^SC("B",X,"")) I IEN'>0 Q 0
 I ("C"'[$P($G(^SC(Y,0)),U,3)!('$$ACTLOC^ORWU(Y))) Q 0
 Q 1
 ;
