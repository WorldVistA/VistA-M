ORMBLDP1 ;SLC/MKB-Build outgoing Pharmacy ORM msgs ;10/01/2009
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**243,280**;Dec 17, 1997;Build 85
 ;
ADDFRQCV(STR,PATH) ;
 N RESULT
 S RESULT=""
 I PATH="O" D  Q RESULT
 .S STR=$$UP^XLFSTR(STR)
 .I STR="1 BAG/DAY" S RESULT=1 Q
 .I STR="ALL BAGS" S RESULT="A" Q
 .I STR="SEE COMMENTS" S RESULT="S"
 .I STR["in bag" S RESULT=$P(STR," ",3)
 I PATH="I" D
 .I STR=1 S RESULT="1 Bag/Day" Q
 .I STR="A" S RESULT="All Bags" Q
 .I STR="" Q
 .S RESULT="in bag "_STR
 Q RESULT
 ;
MOB(ORIEN,DFN) ;
 N IVTYPE,NODE,NUM,TYPE
 S IVTYPE=""
 D MOB^PSBAPIPM(DFN,ORIEN)
 S NODE=$G(^TMP("PSB",$J,0)) I NODE=-1 Q IVTYPE
 S TYPE=$P(NODE,U,3)
 S NUM=+$P(NODE,U,4)
 I TYPE="A" S IVTYPE="C" Q IVTYPE
 I TYPE="P" S IVTYPE="I" Q IVTYPE
 I TYPE="S",NUM=0 S IVTYPE="C" Q IVTYPE
 I TYPE="S",NUM=1 S IVTYPE="I" Q IVTYPE
 Q IVTYPE
 ;
HL7IVLMT(STR) ;
 N LEN,VAL,UNIT,IVLMT,TVAL
 S (UNIT,IVLMT)="",VAL=0
 I $E($$LOW^XLFSTR(STR))="f" D
 . I STR["for a total of" D  Q
 . .S VAL=$P(STR," ",5)
 . .S UNIT=$P(STR," ",6)
 . S VAL=$P(STR," ",2)
 . S UNIT=$E($P(STR," ",3))
 I $E($$LOW^XLFSTR(STR))="w" D
 . S TVAL=$P(STR," ",4)      ;pull data in total example 0.5ml
 . S VAL=+TVAL     ;this will strip out leading zero and alpha 00.5L becomes .5 or 05.5 becomes 5.5
 . S LEN=$F(TVAL,VAL)        ;get length up to alphas or trailing zeros
 . I $P(VAL,".")="" S VAL=0_VAL  ;make sure decimal values have only one leading zero .5 becomes 0.5.
 . F  S UNIT=$E(TVAL,LEN) Q:((UNIT'=0)&(UNIT'="."))  D    ;get first alpha m or l
 . . S LEN=LEN+1
 I $L(UNIT),$L(VAL) S IVLMT=$$LOW^XLFSTR(UNIT)_VAL
 Q IVLMT
