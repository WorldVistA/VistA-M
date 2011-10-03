PXRMTECK ; SLC/PKR - Check expanded taxonomies. ;02/25/2009
 ;;2.0;CLINICAL REMINDERS;**12**;Feb 04, 2005;Build 73
 ;
 ;====================================================
ALL ;Check all expansions.
 N IEN,IO,NAME,POP,TEXT
 W !,"Verify all taxonomy expansions."
 D ^%ZIS
 I POP Q
 U IO
 W !,"Checking all taxonomy expansions."
 S NAME=""
 F  S NAME=$O(^PXD(811.2,"B",NAME)) Q:NAME=""  D
 . S IEN=$O(^PXD(811.2,"B",NAME,""))
 . D CHECK(IEN)
 D ^%ZISC
 Q
 ;
 ;====================================================
CHECK(IEN) ;Check an expansion.
 ;Save existing expansion.
 N CODE,EXPOK,HIGH,IND,LOW,NAME,TEMP,TYPE
 S NAME=$P(^PXD(811.2,IEN,0),U,1)
 W !!,"Taxonomy: ",NAME," (IEN=",IEN,")"
 I '$D(^PXD(811.3,IEN)) W !,"Expansion does not exist." Q
 K ^TMP($J,"CUREXP"),^TMP($J,"NEWEXP")
 I $D(^PXD(811.3,IEN,80,"ICD9P")) M ^TMP($J,"CUREXP","ICD 9")=^PXD(811.3,IEN,80,"ICD9P")
 I $D(^PXD(811.3,IEN,80.1,"ICD0P")) M ^TMP($J,"CUREXP","ICD 0")=^PXD(811.3,IEN,80.1,"ICD0P")
 I $D(^PXD(811.3,IEN,81,"ICPTP")) M ^TMP($J,"CUREXP","CPT")=^PXD(811.3,IEN,81,"ICPTP")
 ;Rexpand
 S IND=0
 F  S IND=+$O(^PXD(811.2,IEN,80.1,IND)) Q:IND=0  D
 . S TEMP=^PXD(811.2,IEN,80.1,IND,0)
 . S LOW=$P(TEMP,U,1)
 . S HIGH=$P(TEMP,U,2)
 . I HIGH="" S HIGH=LOW
 . D ICD0(IEN,LOW,HIGH,"NEWEXP")
 ;
 S IND=0
 F  S IND=+$O(^PXD(811.2,IEN,80,IND)) Q:IND=0  D
 . S TEMP=^PXD(811.2,IEN,80,IND,0)
 . S LOW=$P(TEMP,U,1)
 . S HIGH=$P(TEMP,U,2)
 . I HIGH="" S HIGH=LOW
 . D ICD9(IEN,LOW,HIGH,"NEWEXP")
 ;
 S IND=0
 F  S IND=+$O(^PXD(811.2,IEN,81,IND)) Q:IND=0  D
 . S TEMP=^PXD(811.2,IEN,81,IND,0)
 . S LOW=$P(TEMP,U,1)
 . S HIGH=$P(TEMP,U,2)
 . I HIGH="" S HIGH=LOW
 . D ICPT(IEN,LOW,HIGH,"NEWEXP")
 ;Do the comparsions.
 S EXPOK=1
 W !,"Expansion was last built on ",$$FMTE^XLFDT($P(^PXD(811.3,IEN,0),U,2),"5Z")
 F TYPE="ICD 9","ICD 0","CPT" D
 . S CODE=""
 . F  S CODE=$O(^TMP($J,"NEWEXP",TYPE,CODE)) Q:CODE=""  D
 .. I $D(^TMP($J,"CUREXP",TYPE,CODE)) K ^TMP($J,"CUREXP",TYPE,CODE),^TMP($J,"NEWEXP",TYPE,CODE)
 I $D(^TMP($J,"NEWEXP")) D
 . S EXPOK=0
 . W !!,"The following codes are missing from the expansion:"
 . D OUTPUT("NEWEXP")
 I $D(^TMP($J,"CUREXP")) D
 . S EXPOK=0
 . W !!,"The following codes are in the expansion and they should not be:"
 . D OUTPUT("CUREXP")
 I EXPOK W !,"The expansion is correct."
 K ^TMP($J,"CUREXP"),^TMP($J,"NEWEXP")
 Q
 ;
 ;====================================================
ICD0(TAXIEN,LOW,HIGH,SUB) ;Build the list of internal entries for ICD0
 ;(File 80.1). Use of ICDAPIU: DBIA #3991
 N CODE,IEN,TEMP
 S CODE=LOW
 F  Q:(CODE]HIGH)!(CODE="")  D
 . S TEMP=$$STATCHK^ICDAPIU(CODE,"")
 . S IEN=$P(TEMP,U,2)
 . I IEN'=-1,'$D(^TMP($J,SUB,"ICD 0",IEN)) D
 .. S ^TMP($J,SUB,"ICD 0",IEN)=""
 . S CODE=$$NEXT^ICDAPIU(CODE)
 Q
 ;
 ;====================================================
ICD9(TAXIEN,LOW,HIGH,SUB) ;Build the list of internal entries for ICD9
 ;(File 80). Use of ICDAPIU: DBIA #3991
 N CODE,IEN,TEMP
 S CODE=LOW
 F  Q:(CODE]HIGH)!(CODE="")  D
 . S TEMP=$$STATCHK^ICDAPIU(CODE,"")
 . S IEN=$P(TEMP,U,2)
 . I IEN'=-1,'$D(^TMP(SUB,"ICD 9",IEN)) D
 .. S ^TMP($J,SUB,"ICD 9",IEN)=""
 . S CODE=$$NEXT^ICDAPIU(CODE)
 Q
 ;
 ;====================================================
ICPT(TAXIEN,LOW,HIGH,SUB) ;Build the list of internal entries
 ;for ICPT (File 81). Use of ICDAPIU: DBIA #3991
 N CODE,IEN,RADIEN,TEMP
 S CODE=LOW
 F  Q:(CODE]HIGH)!(CODE="")  D
 . S TEMP=$$STATCHK^ICPTAPIU(CODE,"")
 . S IEN=$P(TEMP,U,2)
 . I IEN'=-1,'$D(^TMP($J,SUB,"CPT",IEN)) D
 .. S ^TMP($J,SUB,"CPT",IEN)=""
 . S CODE=$$NEXT^ICPTAPIU(CODE)
 Q
 ;
 ;====================================================
OUTPUT(SUB) ;Output codes that are left.
 ;References to ICDCODE DBIA #3990.
 ;References to ICPTCOD DBIA #1995.
 N IEN,LIST,NUM,TEMP,TYPE
 K LIST
 S TYPE=""
 F  S TYPE=$O(^TMP($J,SUB,TYPE)) Q:TYPE=""  D
 . W !," ",TYPE," codes:"
 . S IEN=0
 . F  S IEN=$O(^TMP($J,SUB,TYPE,IEN)) Q:IEN=""  D
 .. I TYPE="CPT" D
 ... S CODE=$$CPT^ICPTCOD(IEN,DT)
 ... S TEMP=$P(CODE,U,3)
 .. I TYPE="ICD 0" D
 ... S CODE=$$ICDOP^ICDCODE(IEN,DT)
 ... S TEMP=$P(CODE,U,5)
 .. I TYPE="ICD 9" D
 ... S CODE=$$ICDDX^ICDCODE(IEN,DT)
 ... S TEMP=$P(CODE,U,4)
 .. S TEMP=$E(TEMP,1,30)
 .. S LIST($P(CODE,U,2)_" ")=$$LJ^XLFSTR(TEMP,30)_" (IEN="_IEN_")"
 . S CODE="",NUM=0
 . F  S CODE=$O(LIST(CODE)) Q:CODE=""  D
 .. S NUM=NUM+1
 .. W !,$$RJ^XLFSTR(NUM,4)," ",$$LJ^XLFSTR(CODE,9),LIST(CODE)
 Q
 ;
