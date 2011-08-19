LRPXAPI4 ;SLC/STAFF Lab Extract API code - Exact Match ;9/29/03  21:17
 ;;5.2;LAB SERVICE;**295**;Sep 27, 1994
 ;
EXACT(DFN,DATE,CONDS) ; from LRPXAPI5
 ; check if conditions are met for date/time
 N FETCH,ITEM,NODE,OK,RESULTS,SEPARATE,XDATE K FETCH,RESULTS,SEPARATE
 S OK=1
 I '$L($O(CONDS(""))) Q 1
 M FETCH=^PXRMINDX(63,"PDI",DFN,DATE)
 S ITEM=""
 F  S ITEM=$O(FETCH(ITEM)) Q:ITEM=""  D
 . S NODE=""
 . F  S NODE=$O(FETCH(ITEM,NODE)) Q:NODE=""  D
 .. S SEPARATE($P(NODE,";",1,3),ITEM,NODE)=""
 S XDATE=""
 F  S XDATE=$O(SEPARATE(XDATE)) Q:XDATE=""  D  Q:OK
 . K RESULTS
 . M RESULTS=SEPARATE(XDATE)
 . I '$L($O(RESULTS(""))) S OK=0 Q
 . I $D(CONDS("MIR")) D MIR(.CONDS,.RESULTS,.OK) I 'OK Q
 . I $D(CONDS("AS")) D AS(.CONDS,.RESULTS,.OK) I 'OK Q
 . I $D(CONDS("MC")) D MC(.CONDS,.RESULTS,.OK) I 'OK Q
 . I $D(CONDS("AC")) D AC(.CONDS,.RESULTS,.OK) I 'OK Q
 . I $D(CONDS(1)) D EQUAL(.CONDS,.RESULTS,.OK) I 'OK Q
 . I $D(CONDS(0)) D NOTEQUAL(.CONDS,.RESULTS,.OK) I 'OK Q
 . I '$L($O(RESULTS(""))) S OK=0 Q 0
 . D SCRAPS(.CONDS,.RESULTS,.OK) I 'OK Q
 . D THREAD(.CONDS,.RESULTS,.OK) I 'OK Q
 Q OK
 ;
THREAD(CONDS,RESULTS,OK) ;
 ; uses TCHK within this scope
 N CHK,FILE,IEN,ITEM,ITEMC,NEXT,NODE,NODEC,NUM,PAR,PARSTOP,START,STOP
 S OK=1
 ; check Micro - only O <-> A match
 I $D(CONDS("X","M;O")),($D(CONDS("X","M;A"))!$D(CONDS("X","M;M"))) D  Q:'OK
 . I '($D(CONDS("X","M;A"))!$D(CONDS("X","M;M"))!$D(CONDS("X","M;MIR"))) Q
 . S ITEM="M;O;"
 . F  S ITEM=$O(RESULTS(ITEM)) Q:ITEM=""  Q:ITEM]"M;O;Z"  D  Q:'OK
 .. S NODE=""
 .. F  S NODE=$O(RESULTS(ITEM,NODE)) Q:NODE=""  D  Q:'OK
 ... S IEN=$P(NODE,";",5)
 ... S OK=0
 ... S ITEMC="M;A;"
 ... F  S ITEMC=$O(RESULTS(ITEMC)) Q:ITEMC=""  Q:ITEMC]"M;A;Z"  D  Q:OK
 .... S NODEC=""
 .... F  S NODEC=$O(RESULTS(ITEMC,NODEC)) Q:NODEC=""  D  Q:OK
 ..... I IEN=$P(NODEC,";",5) S OK=1 Q
 ... S ITEMC="M;M;"
 ... F  S ITEMC=$O(RESULTS(ITEMC)) Q:ITEMC=""  Q:ITEMC]"M;M;Z"  D  Q:OK
 .... S NODEC=""
 .... F  S NODEC=$O(RESULTS(ITEMC,NODEC)) Q:NODEC=""  D  Q:OK
 ..... I IEN=$P(NODEC,";",5) S OK=1 Q
 I $D(CONDS("X","M")) Q
 ; check AP - M <-> E , S <-> T and O <-> [D M F P] match
 S PAR="A;M",START="A;E"
 I $D(CONDS("X",PAR)),$D(CONDS("X",START)) D TCHK(PAR,7,START) Q:'OK
 S PAR="A;S",START="A;T"
 I $D(CONDS("X",PAR)),$D(CONDS("X",START)) D TCHK(PAR,5,START) Q:'OK
 S PAR="A;O"
 I $D(CONDS("X",PAR)) D  Q:'OK
 . F FILE="D","M","F","P" D  Q:'OK
 .. S START="A;"_FILE
 .. I $D(CONDS("X",START)) D TCHK(PAR,5,START)
 Q
TCHK(PAR,NUM,START) ; within scope of THREAD
 S ITEM=PAR,PARSTOP=PAR_";Z",STOP=START_";Z"
 F  S ITEM=$O(RESULTS(ITEM)) Q:ITEM=""  Q:ITEM]PARSTOP  D  Q:'OK
 . S NODE=""
 . F  S NODE=$O(RESULTS(ITEM,NODE)) Q:NODE=""  D  Q:'OK
 .. S IEN=$P(NODE,";",1,NUM)
 .. S CHK=0
 .. S ITEMC=START
 .. F  S ITEMC=$O(RESULTS(ITEMC)) Q:ITEMC=""  Q:ITEMC]STOP  D  Q:CHK
 ... S NODEC=""
 ... F  S NODEC=$O(RESULTS(ITEMC,NODEC)) Q:NODEC=""  D  Q:CHK
 .... I IEN=$P(NODEC,";",1,NUM) S CHK=1 Q
 .... I $L(NODEC,";")=4 S CHK=1 Q  ; at collection date
 .. I 'CHK K RESULTS(ITEM)
 S NEXT=$O(RESULTS(PAR))
 I NEXT="" S OK=0 Q
 I NEXT]PARSTOP S OK=0 Q
 Q
 ;
SCRAPS(CONDS,RESULTS,OK) ;
 N ITEM,ITEMC
 S OK=1
 S ITEM=""
 F  S ITEM=$O(RESULTS(ITEM)) Q:ITEM=""  D
 . S ITEMC=$P(ITEM,";",1,2)
 . I ITEMC="M;A",$D(CONDS("MIR")) Q
 . I ITEMC="M;M",$D(CONDS("MIR")) Q
 . I '$D(CONDS("X",ITEMC)) K RESULTS(ITEM)
 I '$L($O(RESULTS(""))) S OK=0 Q
 Q
 ;
NOTEQUAL(CONDS,RESULTS,OK) ;
 ; check not equal condition for pointer values
 N FILE,ITEM,START,STOP,TYPE
 S OK=1
 S ITEM=""
 F  S ITEM=$O(CONDS(0,ITEM)) Q:ITEM=""  D  Q:'OK
 . S TYPE=$E(ITEM),FILE=$E(ITEM,3),START=TYPE_";"_FILE,STOP=TYPE_";"_FILE_";Z"
 . K RESULTS(ITEM)
 . S NEXT=$O(RESULTS(START))
 . I NEXT="" S OK=0 Q
 . I NEXT]STOP S OK=0 Q
 Q
 ;
EQUAL(CONDS,RESULTS,OK) ;
 ; check equal condition for pointer values
 N FILE,ITEM,ITEMC,NEXT,START,STOP,TYPE
 S OK=1
 S ITEM=""
 F  S ITEM=$O(CONDS(1,ITEM)) Q:ITEM=""  D
 . S TYPE=$E(ITEM),FILE=$E(ITEM,3),START=TYPE_";"_FILE,STOP=TYPE_";"_FILE_";Z"
 . S ITEMC=START
 . F  S ITEMC=$O(RESULTS(ITEMC)) Q:ITEMC=""  Q:ITEMC]STOP  D
 .. I ITEMC=ITEM Q
 .. K RESULTS(ITEMC)
 S NEXT=$O(RESULTS(START))
 I NEXT="" S OK=0 Q
 I NEXT]STOP S OK=0 Q
 Q
 ;
AC(CONDS,RESULTS,OK) ;
 ; check conditions for AP categories
 N CAT,CATEGORY,ITEM,ITEMC,NODE,NOTEQUAL,SUB
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
 ... I NOTEQUAL,CAT=CATEGORY K RESULTS(ITEMC,NODE) Q
 ... I 'NOTEQUAL,CAT'=CATEGORY K RESULTS(ITEMC,NODE) Q
 I '$L($O(RESULTS(""))) S OK=0 Q
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
 ... I NOTEQUAL,SUB=CATSUB K RESULTS(ITEMC,NODE) Q
 ... I 'NOTEQUAL,SUB'=CATSUB K RESULTS(ITEMC,NODE) Q
 S NEXT=$O(RESULTS("M"))
 I NEXT="" S OK=0 Q
 I NEXT]"M;S" S OK=0 Q
 Q
 ;
AS(CONDS,RESULTS,OK) ;
 ; check conditions for AP specimen
 N CHECK,ITEM,ITEMC,NEXT,S
 S OK=1
 S ITEM=""
 F  S ITEM=$O(CONDS("AS",ITEM)) Q:ITEM=""  D
 . I $E(ITEM,2)="'" D  Q
 .. ; good if the specimen text is not present for this collection
 .. S ITEMC="A;S;1"
 .. F  S ITEMC=$O(RESULTS(ITEMC)) Q:ITEMC=""  Q:ITEMC]"A;S;Z"  D
 ... S S=$P(ITEMC,"1.",2)
 ... S CHECK="I "_ITEM
 ... X CHECK I '$T K RESULTS(ITEMC)
 . ; good if any of the specimen text for this collection have a matching text
 . I $O(RESULTS("A;S;1"))="" Q
 . I $O(RESULTS("A;S;1"))]"A;S;Z" Q
 . S OK=0
 . S ITEMC="A;S;1"
 . F  S ITEMC=$O(RESULTS(ITEMC)) Q:ITEMC=""  Q:ITEMC]"A;S;Z"  D
 .. S S=$P(ITEMC,"1.",2)
 .. S CHECK="I "_ITEM
 .. X CHECK I '$T K RESULTS(ITEMC)
 S NEXT=$O(RESULTS("A;S;"))
 I NEXT="" S OK=0 Q
 I NEXT]"A;S;Z" S OK=0 Q
 S OK=1
 Q
 ;
MIR(CONDS,RESULTS,OK) ;
 ; check conditions for antimicrobial results and interpretations
 ; uses MCHK within this scope
 N ABNODE,ABTYPE,CHECK,I,ITEM,ITEMC,NEXTA,NEXTM,NODE,R,START,STOP
 S OK=0
 F ABTYPE="A","M" D MCHK(ABTYPE)
 S NEXTA=$O(RESULTS("M;A"))
 S NEXTM=$O(RESULTS("M;M"))
 I NEXTA="",NEXTM="" Q
 I NEXTA="",NEXTM]"M;M;Z" Q
 I NEXTA]"M;A;Z",NEXTM="" Q
 I NEXTA]"M;A;Z",NEXTM]"M;M;Z" Q
 S OK=1
 Q
MCHK(ABTYPE) ; within scope of MIR
 S START="M;"_ABTYPE
 S STOP=START_";Z"
 S ITEM=""
 F  S ITEM=$O(CONDS("MIR",ITEM)) Q:ITEM=""  D
 . I $E(ITEM,2)="'" D  Q
 .. ; good if the interpretation/result is not present for this collection
 .. S ITEMC=START
 .. F  S ITEMC=$O(RESULTS(ITEMC)) Q:ITEMC=""  Q:ITEMC]STOP  D
 ... S NODE=""
 ... F  S NODE=$O(RESULTS(ITEMC,NODE)) Q:NODE=""  D
 .... S ABNODE=$$REFVAL^LRPXAPI(NODE)
 .... I ABTYPE="A" D
 ..... S I=$P(ABNODE,U,2)
 ..... S R=$P(ABNODE,U)
 .... E  D
 ..... S R=$P(ABNODE,U)
 ..... S I=R
 .... S CHECK="I "_ITEM
 .... X CHECK I $T Q
 .... K RESULTS(ITEMC,NODE)
 . ; good if any of the interpretations/results have matching conditions
 . I $O(RESULTS(START))="" Q
 . I $O(RESULTS(START))]STOP Q
 . S ITEMC=START
 . F  S ITEMC=$O(RESULTS(ITEMC)) Q:ITEMC=""  Q:ITEMC]STOP  D
 .. S NODE=""
 .. F  S NODE=$O(RESULTS(ITEMC,NODE)) Q:NODE=""  D
 ... S ABNODE=$$REFVAL^LRPXAPI(NODE)
 ... S I=$P(ABNODE,U,2)
 ... S R=$P(ABNODE,U)
 ... S CHECK="I "_ITEM
 ... X CHECK I '$T K RESULTS(ITEMC,NODE)
 Q
 ;
