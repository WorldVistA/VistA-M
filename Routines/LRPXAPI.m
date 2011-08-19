LRPXAPI ;SLC/STAFF Lab Extract APIs ;2/26/04  13:34
 ;;5.2;LAB SERVICE;**295**;Sep 27, 1994
 ;
 ; lab extract API routines
 ; dbia 4245
 ; no need to namespace local variables when calling these APIs
 ; the LRPXAPP routine shows examples of calling these APIs
 ; parameters: (.parameter is a call by reference)
 ; .TESTS array(ien)=ien^test name
 ; .VALUES array(seq of recent first)=col date/time^TEST^comment flag^RESULT
 ; .PATS array(dfn)=dfn^patient name
 ; .DATES array(-date)=date
 ;  DFN is patient ien
 ;  MAX is optional, # of tests,values,pts to return/call, default is 100
 ; .NEXT is optional, if NEXT'=0 then not finished
 ;  COND is optional, condition for value (example I V>30), default is ""
 ;  TYPE is [C M A] and is optional, default is C
 ;  DATE1 is optional, earliest date, default is 0 (oldest)
 ;  DATE2 is optional, latest date, default is 9999999 (most recent)
 ; .DATA is lab result or array(STYPE,#)= specimen, comments, datanumbers
 ;  DATE is collection date/time
 ;  ITEM is test number in file 60 for Chem data
 ;  ITEM is "M;[S T O A M];[S T O A M] ien" for Micro data
 ;  ITEM is "A;[S T O D M E F P I];[S T O D M E F P I] ien" for AP data
 ;  SOURCE is optional, array reference used as alternate list of patients
 ; .RESULT is patient's test result (result^flag^...)
 ;  NODE is data reference in ^PXRMINDX( indexes "lrdfn;CH;lridt;lrdn"
 ;  LRDFN is lab patient ien
 ;  LRIDT is lab collection time (inverted)
 ;  LRDN is lab datanumbers for test values
 ;  STYPE is "S" specimen node, "C" comments, "V" data nodes, "A" all
 ; .ERR is -1 when data cannot be found
 ;
 ; -- TESTS returns tests (items) on patient; dfn required --
 ;
TESTS(TESTS,DFN,TYPE,MAX,NEXT,COND,DATE1,DATE2) ; API
 I $G(TESTS)?1U1UN1.14UNP,'$G(MAX) S MAX=1000000000 ; default for ^TMP is all, else 100 tests
 E  S MAX=+$G(MAX,100)
 S TYPE=$G(TYPE,"C") ; default is CH data
 I TYPE="C" D TESTS^LRPXAPI1(.TESTS,+$G(DFN),MAX,.NEXT,$G(COND),$G(DATE1),$G(DATE2)) Q
 D TESTS^LRPXAPI3(.TESTS,+$G(DFN),TYPE,MAX,.NEXT,$G(COND),$G(DATE1),$G(DATE2)) Q
 Q
 ;
 ; -- RESULTS returns results on patient; dfn required --
 ;
RESULTS(VALUES,DFN,ITEM,MAX,NEXT,COND,DATE1,DATE2) ; API
 N TYPE
 I $G(VALUES)?1U1UN1.14UNP,'$G(MAX) S MAX=1000000000 ; default for ^TMP is all, else 100 results
 E  S MAX=+$G(MAX,100)
 S ITEM=$G(ITEM)
 I ITEM'=+ITEM,$L(ITEM)<5 D  Q  ; results for all of type or partial item
 . S MAX=+$G(MAX,10)
 . S TYPE=$E(ITEM)
 . I TYPE="C"!'$L(TYPE) D RESULTS^LRPXAPI1(.VALUES,+$G(DFN),MAX,.NEXT,$G(COND),$G(DATE1),$G(DATE2)) Q
 . D RESULTS^LRPXAPI3(.VALUES,+$G(DFN),ITEM,MAX,.NEXT,$G(COND),$G(DATE1),$G(DATE2)) Q
 I ITEM=+ITEM D TRESULTS^LRPXAPI1(.VALUES,+$G(DFN),ITEM,MAX,.NEXT,$G(COND),$G(DATE1),$G(DATE2)) Q
 S TYPE=$E(ITEM)
 D TRESULTS^LRPXAPI3(.VALUES,+$G(DFN),TYPE,ITEM,MAX,.NEXT,$G(COND),$G(DATE1),$G(DATE2)) Q
 Q
 ;
 ; -- PATIENTS returns patients with a specific item; item required --
 ;
PATIENTS(PATS,ITEM,SOURCE,MAX,NEXT,COND,DATE1,DATE2) ; API
 N TYPE
 I $G(PATS)?1U1UN1.14UNP,'$G(MAX) S MAX=1000000000 ; default for ^TMP is all, else 100 patients
 E  S MAX=+$G(MAX,100)
 S ITEM=$G(ITEM,0)
 I ITEM=0!'$L($G(ITEM)) D ALLPATS^LRPXAPI3(.PATS,$G(SOURCE),MAX,.NEXT,$G(COND),$G(DATE1),$G(DATE2)) Q
 I ITEM'=+ITEM,$L(ITEM)<5 D  Q  ; patients for all of type or partial item
 . S TYPE=$E(ITEM)
 . I TYPE="C" D PTS^LRPXAPI1(.PATS,$G(SOURCE),MAX,.NEXT,$G(COND),$G(DATE1),$G(DATE2)) Q
 . D PTS^LRPXAPI3(.PATS,TYPE,ITEM,$G(SOURCE),MAX,.NEXT,$G(COND),$G(DATE1),$G(DATE2)) Q
 I ITEM=+ITEM D PATIENTS^LRPXAPI1(.PATS,ITEM,$G(SOURCE),MAX,.NEXT,$G(COND),$G(DATE1),$G(DATE2)) Q
 S TYPE=$E(ITEM)
 D PATIENTS^LRPXAPI3(.PATS,TYPE,ITEM,$G(SOURCE),MAX,.NEXT,$G(COND),$G(DATE1),$G(DATE2)) Q
 Q
 ;
 ; -- DATES returns col date/times as (date) or (type,date); dfn required --
 ;
DATES(DATES,DFN,TYPE,MAX,NEXT,DATE1,DATE2) ; API
 I $G(DATES)?1U1UN1.14UNP,'$G(MAX) S MAX=1000000000 ; default for ^TMP is all, else 100 date/times
 E  S MAX=+$G(MAX,100)
 S TYPE=$G(TYPE,"C") ; default is CH data
 D DATES^LRPXAPI1(.DATES,+$G(DFN),TYPE,MAX,.NEXT,$G(DATE1),$G(DATE2))
 Q
 ;
 ; ------------ other extract APIs --------------------
 ;
VALUE(RESULT,DFN,DATE,TEST,COND,ERR) ; API
 ; returns result node as RESULT; dfn, date, test required
 D VALUE^LRPXAPI2(.RESULT,+$G(DFN),+$G(DATE),+$G(TEST),$G(COND),.ERR)
 Q
 ;
LRVALUE(RESULT,LRDFN,LRIDT,LRDN,COND,ERR) ; API
 ; returns result node as RESULT; lrdfn, lridt, lrdn required
 D LRVALUE^LRPXAPI2(.RESULT,+$G(LRDFN),+$G(LRIDT),+$G(LRDN),$G(COND),.ERR)
 Q
 ;
LRPXRM(RESULT,NODE,ITEM,TYPES) ; API
 ; returns lab data using ^PXRMINDX indexes; node, item required
 ; types of data: V value, S specimen, C comments, or combinations
 D LRPXRM^LRPXAPI2(.RESULT,$G(NODE),$G(ITEM),$G(TYPES,"VS"))
 Q
 ;
SPEC(DATA,DFN,DATE,STYPE,ERR) ; API
 ; returns specimen node, comments, data nodes
 ; returned in array DATA; dfn, date required
 D SPEC^LRPXAPI2(.DATA,+$G(DFN),+$G(DATE),$G(STYPE),.ERR)
 Q
 ;
LRSPEC(DATA,LRDFN,LRIDT,STYPE,ERR) ; API
 ; returns specimen node, comments, data nodes
 ; returned in array DATA; lrdfn, lridt required
 D LRSPEC^LRPXAPI2(.DATA,+$G(LRDFN),+$G(LRIDT),$G(STYPE),.ERR)
 Q
 ;
VERIFIED(LRDFN,LRIDT) ; API $$(lrdfn,lridt) -> 1 if verified, else 0
 Q $$VERIFIED^LRPXAPI2(+$G(LRDFN),+$G(LRIDT))
 ;
MIVERIFY(LRDFN,LRIDT,SUB) ; $$(lrdfn,lridt,sub) -> 1 if verified, else 0
 Q $$MIVERIFY^LRPXAPI2(+$G(LRDFN),+$G(LRIDT),$G(SUB,"MI"))
 ;
APVERIFY(LRDFN,LRIDT,SUB) ; $$(lrdfn,lridt,sub) -> 1 if verified, else 0
 Q $$APVERIFY^LRPXAPI2(+$G(LRDFN),+$G(LRIDT),$G(SUB))
 ;
VAL(LRDFN,LRIDT,LRDN) ; API $$(lrdfn,lridt,lrdn) -> result node
 Q $$VAL^LRPXAPI2(+$G(LRDFN),+$G(LRIDT),+$G(LRDN))
 ;
REFVAL(NODE) ; API $$(reference node) -> data node
 Q $$REFVAL^LRPXAPI2($G(NODE))
 ;
COMMENT(LRDFN,LRIDT) ; API $$(lrdfn,lridt) --> 1 if comment exists, else 0
 Q $$COMMENT^LRPXAPI2(+$G(LRDFN),+$G(LRIDT))
 ;
ACCY(TESTS,ACC,BDN) ; API
 ; returns TESTS from yearly accession, ACC, BDN required
 ; BDN is beginning date number
 D ACCY^LRPXAPI2(.TESTS,ACC,BDN)
 Q
 ;
CHNODE(ARRAY,NODE) ; API
 ; returns ARRAY of values on CH result node
 D CHNODE^LRPXAPI2(.ARRAY,$G(NODE))
 Q
 ;
HASITEM(DFN,ITEM) ; API $$(dfn,item) -> 1 if patient has item, else 0
 I $D(^PXRMINDX(63,"PI",+$G(DFN),$G(ITEM,0))) Q 1
 Q 0
 ;
