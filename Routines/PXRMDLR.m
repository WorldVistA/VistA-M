PXRMDLR ;SLC/PJH - DIALOG RESULTS LOADER ;05/15/2007
 ;;2.0;CLINICAL REMINDERS;**6**;Feb 04, 2005;Build 123
 ;
 ;Build score related P/N text from score and result group
 ; 
 ;If not found
START(ORY,RESULT,ORES) ;
 I '$G(RESULT) S ORY(1)="-1^no results for this test" Q
 ;
 N ARRAY,ERROR,INSERT,OK,SCORE,SUB,YT,X
 ;
 I RESULT["~" S RESULT=$P(RESULT,"~")
 S ERROR=0
 ;
 ;Get score using API
 K ^TMP($J,"YSCOR")
 I ORES("CODE")'="DOM80" D  Q:ERROR
 .M YT=ORES
 .F X=1:1:$L(YT("R1")) I $E(YT("R1"),X)'="X" S YT(X)=X_U_$E(YT("R1"),X)
 .K YT("R1")
 .D CHECKCR^YTQPXRM4(.ARRAY,.YT)
 .S OK=0
 .;D PREVIEW^YTAPI4(.ARRAY,.YT)
 .I ^TMP($J,"YSCOR",1)'="[DATA]" S ORY(1)="-1^"_^TMP($J,"YSCOR",1)_^TMP($J,"YSCOD",2),ERROR=1 Q 
 .;I ARRAY(1)'="[DATA]" S ORY(1)="-1^"_ARRAY(1)_ARRAY(2),ERROR=1 Q
 .I $P($G(^TMP($J,"YSCOR",2)),"=",2)'="" S SCORE=$P($G(^TMP($J,"YSCOR",2)),"=",2),OK=1
 .;S SUB=0,OK=0
 .;F  S SUB=$O(ARRAY(SUB)) Q:'SUB  D  Q:OK
 .;.I $P(ARRAY(SUB),U)="S1" S SCORE=$P(ARRAY(SUB),U,3),OK=1
 .I 'OK S ORY(1)="-1^[ERROR] no score returned",ERROR=1 Q
 ;
 ;Except for DOM80
 I ORES("CODE")="DOM80" D
 .I $E(ORES("R1"))="Y" S SCORE=1 Q
 .I $E(ORES("R1"),2,3)="YY",($E(ORES("R1"),4)>1) S SCORE=1 Q
 .S SCORE=0
 ;
 S DFN=$G(ORES("DFN"))
 S INSERT("SCORE")=SCORE
 ;
 ;For AIMS special formatting is required 
 I ORES("CODE")="AIMS" D
 .N CNT,LITS,RESP,SUM
 .S LITS(0)="none",LITS(1)="minimal",LITS(2)="mild",LITS(3)="moderate"
 .S LITS(4)="severe",SUM(2)=0,SUM(3)=0,SUM(4)=0
 .F CNT=1:1 S RESP=$E(ORES("R1"),CNT) Q:RESP=""  D
 ..S INSERT("R"_CNT)=$G(LITS(RESP))
 ..I (CNT<8),(234[RESP) S SUM(RESP)=SUM(RESP)+1
 .F CNT=2,3,4 S INSERT("SUM"_CNT)=SUM(CNT)
 ;
TEXT ;
 I RESULT["~" S RESULT=$P(RESULT,"~")
 ;Load dialog results into ORY array
 N DATA,DCON,DITEM,DSEQ,DSUB,DTYP,INS,SEP,TEXT
 ;Get the result elements
 S DSEQ=0,OCNT=0
 F  S DSEQ=$O(^PXRMD(801.41,RESULT,10,"B",DSEQ)) Q:'DSEQ  D
 .S DSUB=$O(^PXRMD(801.41,RESULT,10,"B",DSEQ,"")) Q:'DSUB
 .S DITEM=$P($G(^PXRMD(801.41,RESULT,10,DSUB,0)),U,2) Q:'DITEM
 .;Get the result element
 .S DTYP=$P($G(^PXRMD(801.41,DITEM,0)),U,4) Q:DTYP'="T"
 .;Get the result element condition
 .S DCON=$P($G(^PXRMD(801.41,DITEM,0)),U,13)
 .;Skip if condition not satisfied
 .I DCON'="" S DCON=$TR(DCON,"~"," ") Q:'$$TRUE(SCORE,DCON,DFN)
 .;Get progress note text if defined
 .N LAST,NULL,SUB,TEXT S SUB=0,LAST=0
 .F  S SUB=$O(^PXRMD(801.41,DITEM,35,SUB)) Q:'SUB  D
 ..;Insert score into text (if neccessary)
 ..S TEXT=$G(^PXRMD(801.41,DITEM,35,SUB,0))
 ..S NULL=0 I ($E(TEXT)=" ")!(TEXT="") S NULL=1
 ..;Add line breaks if is or preceded by blank line or starts with space
 ..I ('NULL),LAST S TEXT="<br>"_TEXT
 ..S TEXT=$$STRREP^PXRMUTIL(TEXT,"\\","<br>")
 ..S LAST=0 I NULL S TEXT="<br>"_TEXT,LAST=1
 ..;Check for inserts - note there may be embedded TIU markers too
 ..N INS
 ..S INS=""
 ..F  S INS=$O(INSERT(INS)) Q:INS=""  D
 ...S SEP="|"_INS_"|" I '$F(TEXT,SEP) Q
 ...S TEXT=$P(TEXT,SEP)_$G(INSERT(INS))_$P(TEXT,SEP,2,99)
 ..S OCNT=OCNT+1,ORY(OCNT)=7_U_TEXT
 Q
 ;
MHDLL(ORES,RESULT,SCORE,DFN) ;
 S INSERT("SCORE")=SCORE
 D TEXT
 Q
OUT(DATA) ;Display element details
 N DITEM S DITEM=$P(DATA,U,2) Q:'DITEM
 W $P($G(^PXRMD(801.41,DITEM,0)),U)
 W !,$J("Element Condition:  ",19)
 W $TR($P($G(^PXRMD(801.41,DITEM,0)),U,13),"~"," ")
 W !,$J("Element text:",17)
 ;Get progress note text if defined
 N SUB,TEXT S SUB=0
 F  S SUB=$O(^PXRMD(801.41,DITEM,35,SUB)) Q:'SUB  D
 .S TEXT=$G(^PXRMD(801.41,DITEM,35,SUB,0)) W !,?5,TEXT
 Q
 ;
TRUE(V,COND,DFN) ; Check if value meets element condition
 N RESULT,SEX
 I COND["SEX" D  Q RESULT
 . S RESULT=0
 . S SEX=$P($G(^DPT(DFN,0)),U,2)
 . X COND I  S RESULT=1
 X COND I  Q 1
 Q 0
