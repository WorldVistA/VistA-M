LRPXAPI5 ;SLC/STAFF Lab Extract API code - Match ;9/30/03  09:59
 ;;5.2;LAB SERVICE;**295**;Sep 27, 1994
 ;
MATCH(DFN,DATE,CONDS,TYPE) ; $$(dfn,date,conds,type) -> 1 if ok, else 0
 ; from LRPXAPI3,LRPXAPI6
 ; check if conditions are met for date/time
 I CONDS="|" Q $$EXACT^LRPXAPI4(DFN,DATE,.CONDS)
 N FETCH,ITEM,NODE,OK,RESULTS,SEPARATE,SUB,XDATE K FETCH,RESULTS,SEPARATE
 S OK=1
 I '$L($O(CONDS(""))) Q 1
 M FETCH=^PXRMINDX(63,"PDI",DFN,DATE)
 S ITEM=""
 F  S ITEM=$O(FETCH(ITEM)) Q:ITEM=""  D  Q:'OK
 . I $E(ITEM)'=TYPE S OK=0 Q
 . S NODE=""
 . F  S NODE=$O(FETCH(ITEM,NODE)) Q:NODE=""  D
 .. S SUB=$P(NODE,";",2)
 .. I '(SUB="AU"!(SUB="AY")!(SUB=33)!(SUB=80)) D
 ... S SEPARATE($P(NODE,";",1,3),ITEM,NODE)=""
 .. E  S SEPARATE(DATE,ITEM,NODE)=""
 I 'OK Q 0
 S XDATE=""
 F  S XDATE=$O(SEPARATE(XDATE)) Q:XDATE=""  D  Q:OK
 . K RESULTS
 . M RESULTS=SEPARATE(XDATE)
 . I '$L($O(RESULTS(""))) S OK=0 Q
 . I $D(CONDS(0)) D NOTEQUAL(.CONDS,.RESULTS,.OK) I 'OK Q
 . I $D(CONDS(1)) D EQUAL(.CONDS,.RESULTS,.OK) I 'OK Q
 . I $D(CONDS("AC")) D AC(.CONDS,.RESULTS,.OK) I 'OK Q
 . I $D(CONDS("MC")) D MC(.CONDS,.RESULTS,.OK) I 'OK Q
 . I $D(CONDS("AS")) D AS(.CONDS,.RESULTS,.OK) I 'OK Q
 . I $D(CONDS("MIR")) D MIR(.CONDS,.RESULTS,.OK) I 'OK Q
 Q OK
 ;
NOTEQUAL(CONDS,RESULTS,OK) ;
 ; check not equal condition for pointer values
 N ITEM,ITEM1
 S OK=1
 S ITEM=""
 F  S ITEM=$O(CONDS(0,ITEM)) Q:ITEM=""  D  I 'OK Q
 . I $D(RESULTS(ITEM)) S OK=0 Q
 . S ITEM1=$O(RESULTS($P(ITEM,";",1,2)))
 . I $P(ITEM1,";",1,2)'=$P(ITEM,";",1,2) S OK=0 Q
 Q
 ;
EQUAL(CONDS,RESULTS,OK) ;
 ; check equal condition for pointer values
 N ITEM
 S OK=1
 S ITEM=""
 F  S ITEM=$O(CONDS(1,ITEM)) Q:ITEM=""  D  I 'OK Q
 . I '$D(RESULTS(ITEM)) S OK=0 Q
 Q
 ;
AC(CONDS,RESULTS,OK) ;
 ; check conditions for AP categories
 N CAT,CATEGORY,ITEM,ITEMC,NEXT,NODE,NOTEQUAL,SUB
 S OK=1
 S ITEM=""
 F  S ITEM=$O(CONDS("AC",ITEM)) Q:ITEM=""  D
 . S CATEGORY=$P(ITEM,"=",2)
 . I '$L(CATEGORY) Q
 . S CATEGORY=$E(CATEGORY,2)
 . S NOTEQUAL=0
 . I $L($P(ITEM,"'=",2)) S NOTEQUAL=1
 . S ITEMC="A"
 . F  S ITEMC=$O(RESULTS(ITEMC)) Q:ITEMC=""  Q:ITEMC]"A;Z"  D
 .. I ITEMC["A;T;" Q
 .. S NODE=""
 .. F  S NODE=$O(RESULTS(ITEMC,NODE)) Q:NODE=""  D
 ... S SUB=$P(NODE,";",2)
 ... I SUB=33!(SUB=80) S CAT="A"
 ... E  S CAT=$E(SUB)
 ... I NOTEQUAL,CAT=CATEGORY K RESULTS
 ... I 'NOTEQUAL,CAT'=CATEGORY K RESULTS(ITEMC,NODE) Q
 S NEXT=$O(RESULTS("A"))
 I NEXT="" S OK=0 Q
 I NEXT]"A;S" S OK=0 Q
 Q
 ;
MC(CONDS,RESULTS,OK) ;
 ; check conditions for Micro categories
 N CATEGORY,CATSUB,ITEM,ITEMC,NEXT,NODE,NOTEQUAL,SUB
 S OK=1
 S ITEM=""
 F  S ITEM=$O(CONDS("MC",ITEM)) Q:ITEM=""  D
 . S CATEGORY=$P(ITEM,"=",2)
 . I '$L(CATEGORY) Q
 . S CATEGORY=$E(CATEGORY,2)
 . S CATSUB=$$CATSUB^LRPXAPIU(CATEGORY,"M")
 . S NOTEQUAL=0
 . I $L($P(ITEM,"'=",2)) S NOTEQUAL=1
 . S ITEMC="M"
 . F  S ITEMC=$O(RESULTS(ITEMC)) Q:ITEMC=""  Q:ITEMC]"M;Z"  D
 .. I ITEMC["M;T;" Q
 .. I ITEMC["M;S;" Q
 .. S NODE=""
 .. F  S NODE=$O(RESULTS(ITEMC,NODE)) Q:NODE=""  D
 ... S SUB=$P(NODE,";",4)
 ... I NOTEQUAL,SUB=CATSUB K RESULTS Q
 ... I 'NOTEQUAL,SUB'=CATSUB K RESULTS(ITEMC,NODE) Q
 S NEXT=$O(RESULTS("M"))
 I NEXT="" S OK=0 Q
 I NEXT]"M;S" S OK=0 Q
 Q
 ;
AS(CONDS,RESULTS,OK) ;
 ; check conditions for AP specimen
 N CHECK,ITEM,ITEMC,S
 S OK=1
 S ITEM=""
 F  S ITEM=$O(CONDS("AS",ITEM)) Q:ITEM=""  D  I OK Q
 . I $E(ITEM,2)="'" D  Q
 .. ; good if the specimen text is not present for this collection
 .. S ITEMC="A;S;1"
 .. F  S ITEMC=$O(RESULTS(ITEMC)) Q:ITEMC=""  Q:ITEMC]"A;S;Z"  D  Q:OK
 ... S OK=0
 ... S S=$P(ITEMC,"1.",2)
 ... S CHECK="I "_ITEM
 ... X CHECK I $T S OK=1
 . ; good if any of the specimen text for this collection have a matching text
 . I $O(RESULTS("A;S;1"))="" Q
 . I $O(RESULTS("A"))]"A;S;Z" Q
 . S OK=0
 . S ITEMC="A;S;1"
 . F  S ITEMC=$O(RESULTS(ITEMC)) Q:ITEMC=""  Q:ITEMC]"A;S;Z"  D  Q:OK
 .. S S=$P(ITEMC,"1.",2)
 .. S CHECK="I "_ITEM
 .. X CHECK I $T S OK=1
 Q
 ;
MIR(CONDS,RESULTS,OK) ; $$(dfn,date,conds) -> 1 if ok, else 0
 ; check conditions for antimicrobial results and interpretations
 N ABNODE,CHECK,I,ITEM,ITEMC,ITEMZ,NODE,R
 S OK=1
 ; check bacterial antimicrobials
 S ITEM=""
 F  S ITEM=$O(CONDS("MIR",ITEM)) Q:ITEM=""  D  I 'OK Q
 . I $E(ITEM,2)="'" D  Q
 .. ; good if the interpretation/result is not present for this collection
 .. S ITEMC="M;A"
 .. S ITEMZ="M;A;Z"
 .. F  S ITEMC=$O(RESULTS(ITEMC)) Q:ITEMC=""  Q:ITEMC]ITEMZ  D  Q:'OK
 ... S NODE=""
 ... F  S NODE=$O(RESULTS(ITEMC,NODE)) Q:NODE=""  D  Q:'OK
 .... S ABNODE=$$REFVAL^LRPXAPI(NODE)
 .... S I=$P(ABNODE,U,2)
 .... S R=$P(ABNODE,U)
 .... S CHECK="I "_ITEM
 .... X CHECK I $T S OK=0
 . ; good if any of the interpretations/results have matching conditions
 . I $O(RESULTS("M;A"))="" Q
 . I $O(RESULTS("M;A"))]"M;A;Z" Q
 . S OK=0
 . S ITEMC="M;A"
 . S ITEMZ="M;A;Z"
 . F  S ITEMC=$O(RESULTS(ITEMC)) Q:ITEMC=""  Q:ITEMC]ITEMZ  D  Q:OK
 .. S NODE=""
 .. F  S NODE=$O(RESULTS(ITEMC,NODE)) Q:NODE=""  D  Q:OK
 ... S ABNODE=$$REFVAL^LRPXAPI(NODE)
 ... S I=$P(ABNODE,U,2)
 ... S R=$P(ABNODE,U)
 ... S CHECK="I "_ITEM
 ... X CHECK I $T S OK=1
 ; check mycobacterial antimicrobials
 F  S ITEM=$O(CONDS("MIR",ITEM)) Q:ITEM=""  D  I 'OK Q
 . I $E(ITEM,2)="'" D  Q
 .. ; good if the interpretation/result is not present for this collection
 .. S ITEMC="M;M"
 .. S ITEMZ="M;M;Z"
 .. F  S ITEMC=$O(RESULTS(ITEMC)) Q:ITEMC=""  Q:ITEMC]ITEMZ  D  Q:'OK
 ... S NODE=""
 ... F  S NODE=$O(RESULTS(ITEMC,NODE)) Q:NODE=""  D  Q:'OK
 .... S ABNODE=$$REFVAL^LRPXAPI(NODE)
 .... S R=$P(ABNODE,U)
 .... S I=R
 .... S CHECK="I "_ITEM
 .... X CHECK I $T S OK=0
 . ; good if any of the interpretations/results have matching conditions
 . I $O(RESULTS("M;M"))="" Q
 . I $O(RESULTS("M;M"))]"M;M;Z" Q
 . S OK=0
 . S ITEMC="M;M"
 . S ITEMZ="M;M;Z"
 . F  S ITEMC=$O(RESULTS(ITEMC)) Q:ITEMC=""  Q:ITEMC]ITEMZ  D  Q:OK
 .. S NODE=""
 .. F  S NODE=$O(RESULTS(ITEMC,NODE)) Q:NODE=""  D  Q:OK
 ... S ABNODE=$$REFVAL^LRPXAPI(NODE)
 ... S R=$P(ABNODE,U)
 ... S I=R
 ... S CHECK="I "_ITEM
 ... X CHECK I $T S OK=1
 Q
 ;
