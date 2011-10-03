PXRMDRSG ;SLC/AGP - DIALOG RESULTS LOADER ;05/14/2007
 ;;2.0;CLINICAL REMINDERS;**6**;Feb 04, 2005;Build 123
 ;
 ;Build score related P/N text from score and result group
 ; 
MHDLL(ORY,RESULTS,SCORES,DFN) ;
 N ARY,CNT,NODE,RESULT,SCORE,SCALENUM
 N OCNT,IMULT,MULT
 S OCNT=0,IMULT=0,MULT=0
 S CNT=0 F  S CNT=$O(SCORES(CNT)) Q:CNT'>0  D
 .S NODE=$G(SCORES(CNT)) Q:NODE=""
 .S ARY($P(NODE,"~"))=$P(NODE,"~",2)
 S CNT=0 F  S CNT=$O(RESULTS(CNT)) Q:CNT'>0  D
 .S RESULT=$G(RESULTS(CNT)) Q:RESULT=""
 .I $P($G(^PXRMD(801.41,RESULT,50)),U,1)="" Q
 .S SCALENUM=$P($G(^PXRMD(801.41,RESULT,50)),U,2) Q:SCALENUM=""
 .S SCORE=$G(ARY(SCALENUM)) Q:SCORE=""
 .S INSERT("SCORE")=SCORE
 .D TEXT(.ORY,.OCNT,IMULT,.MULT,SCORE)
 Q
 ;
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
 W !,$J("Informational text:",17)
 N SUB,TEXT S SUB=0
 F  S SUB=$O(^PXRMD(801.41,DITEM,25,SUB)) Q:'SUB  D
 .S TEXT=$G(^PXRMD(801.41,DITEM,25,SUB,0)) W !,?5,TEXT
 Q
 ;
TEXT(ORY,OCNT,IMULT,MULT,SCORE) ;
 ;Load dialog results into ORY array
 N DATA,DCON,DITEM,DSEQ,DSUB,DTYP,INS,SEP,TEXT
 N INFOTEXT
 ;S SCORE=$G(INSERT("SCORE")) Q:SCORE=""
 ;Get the result elements
 S DSEQ=0
 F  S DSEQ=$O(^PXRMD(801.41,RESULT,10,"B",DSEQ)) Q:'DSEQ  D
 .S DSUB=$O(^PXRMD(801.41,RESULT,10,"B",DSEQ,"")) Q:'DSUB
 .S DITEM=$P($G(^PXRMD(801.41,RESULT,10,DSUB,0)),U,2) Q:'DITEM
 .;Get the result element
 .S DTYP=$P($G(^PXRMD(801.41,DITEM,0)),U,4) Q:DTYP'="T"
 .;Get the result element condition
 .S DCON=$P($G(^PXRMD(801.41,DITEM,0)),U,13)
 .;Skip if condition not satisfied
 .I DCON'="" S DCON=$TR(DCON,"~"," ") Q:'$$TRUE(SCORE,DCON,DFN)
 .;Get progress note/Info text if defined
 .N LAST,NULL,SUB,TEXT S SUB=0,LAST=0
 .S INFOTEXT=""
 .F  S SUB=$O(^PXRMD(801.41,DITEM,25,SUB)) Q:'SUB  D
 ..S TEXT=$G(^PXRMD(801.41,DITEM,25,SUB,0))
 ..I INFOTEXT="" S INFOTEXT="[INFOTEXT]"
 ..S NULL=0 I ($E(TEXT)=" ")!(TEXT="") S NULL=1
 ..;Add line breaks if is or preceded by blank line or starts with space
 ..I ('NULL),LAST S TEXT="<br>"_TEXT
 ..S TEXT=$$STRREP^PXRMUTIL(TEXT,"\\","<br>")
 ..S LAST=0 I NULL S TEXT="<br>"_TEXT,LAST=1
 ..I MULT=1,SUB=1,$E(TEXT,1,4)'="<br>" S TEXT="<br>"_TEXT
 ..S TEXT=$$STRREP^PXRMUTIL(TEXT,"<br>",U)
 ..I SUB=1,IMULT=1 S TEXT=U_TEXT
 ..S OCNT=OCNT+1,ORY(OCNT)=INFOTEXT_TEXT
 ..I IMULT=0,OCNT>0 S IMULT=1
 ..;S INFOTEXT=INFOTEXT_TEXT
 .;
 .S LAST=0,NULL=0,SUB=0
 .F  S SUB=$O(^PXRMD(801.41,DITEM,35,SUB)) Q:'SUB  D
 ..;Insert score into text (if neccessary)
 ..S TEXT=$G(^PXRMD(801.41,DITEM,35,SUB,0))
 ..S NULL=0 I ($E(TEXT)=" ")!(TEXT="") S NULL=1
 ..;Add line breaks if is or preceded by blank line or starts with space
 ..I ('NULL),LAST S TEXT="<br>"_TEXT
 ..S TEXT=$$STRREP^PXRMUTIL(TEXT,"\\","<br>")
 ..S LAST=0 I NULL S TEXT="<br>"_TEXT,LAST=1
 ..I MULT=1,SUB=1,$E(TEXT,1,4)'="<br>" S TEXT="<br>"_TEXT
 ..;Check for inserts - note there may be embedded TIU markers too
 ..N INS
 ..S INS=""
 ..F  S INS=$O(INSERT(INS)) Q:INS=""  D
 ...S SEP="|"_INS_"|" I '$F(TEXT,SEP) Q
 ...S TEXT=$P(TEXT,SEP)_$G(INSERT(INS))_$P(TEXT,SEP,2,99)
 ..S OCNT=OCNT+1,ORY(OCNT)=TEXT
 ..I MULT=0,OCNT>0 S MULT=1
 .;I $G(INFOTEXT)'="" S OCNT=OCNT+1,ORY(OCNT)=INFOTEXT
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
