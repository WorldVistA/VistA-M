ORWGRPC ; SLC/STAFF - Graph RPC ;3/9/06  13:59
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**215,243**;Dec 17, 1997;Build 242
 ;
ALLITEMS(ITEMS,DFN) ; RPC - get all items of data on patient (procedures, tests, codes,..)
 D ALLITEMS^ORWGAPI("ORWGRPC",DFN)
 S ITEMS=$NA(^TMP("ORWGRPC",$J))
 Q
 ;
ALLVIEWS(DATA,VIEW,USER) ; RPC - get all graph views
 D ALLVIEWS^ORWGAPI("ORWGRPC",+$G(VIEW),+$G(USER))
 S DATA=$NA(^TMP("ORWGRPC",$J))
 Q
 ;
CLASS(DATA,TYPE) ; RPC - get classifications
 D CLASS^ORWGAPI("ORWGRPC",TYPE)
 S DATA=$NA(^TMP("ORWGRPC",$J))
 Q
 ;
DATEDATA(DATA,OLDEST,NEWEST,TYPEITEM,DFN) ; RPC - get data for an item on patient in date range
 D DATEDATA^ORWGAPI("ORWGRPC",OLDEST,NEWEST,TYPEITEM,DFN)
 S DATA=$NA(^TMP("ORWGRPC",$J))
 Q
 ; 
DATEITEM(DATA,OLDEST,NEWEST,FNUM,DFN) ; RPC - get patient items in date range for a type
 D DATEITEM^ORWGAPI("ORWGRPC",OLDEST,NEWEST,FNUM,DFN)
 S DATA=$NA(^TMP("ORWGRPC",$J))
 Q
 ; 
DELVIEWS(ERR,NAME,PUBLIC) ; RPC - delete a graph view
 D DELVIEWS^ORWGAPI("ORWGRPC",NAME,+$G(PUBLIC))
 S ERR=$NA(^TMP("ORWGRPC",$J))
 Q
 ;
DETAIL(ITEMS,DFN,DATE1,DATE2,VAL,COMP) ; RPC - get all reports for types of data from items and date range
 D DETAIL^ORWGAPI("ORWGRPC",DFN,DATE1,DATE2,.VAL,$G(COMP))
 S ITEMS=$NA(^TMP("ORWGRPC",$J))
 Q
 ;
DETAILS(ITEMS,DFN,DATE1,DATE2,TYPE,COMP) ; RPC - get report for type of data for a date or date range
 D DETAILS^ORWGAPI("ORWGRPC",DFN,DATE1,DATE2,TYPE,$G(COMP))
 S ITEMS=$NA(^TMP("ORWGRPC",$J))
 Q
 ;
FASTDATA(DATA,DFN) ; RPC - get all data (non-lab) set up on patient
 D FASTDATA^ORWGAPI(.DATA,DFN)
 Q
 ;
FASTITEM(ITEMS,DFN) ; RPC - get all items set up on patient
 D FASTITEM^ORWGAPI(.ITEMS,DFN)
 Q
 ;
FASTLABS(DATA,DFN) ; RPC - get all lab data set up on patient
 D FASTLABS^ORWGAPI(.DATA,DFN)
 Q
 ;
FASTTASK(STATUS,DFN,OLDDFN) ; set up all data and items on patient
 D FASTTASK^ORWGAPI(.STATUS,DFN,$G(OLDDFN))
 Q
 ;
GETDATES(DATA,REPORTID) ; RPC - get graph date range
 D GETDATES^ORWGAPI("ORWGRPC",$G(REPORTID))
 S DATA=$NA(^TMP("ORWGRPC",$J))
 Q
 ;
GETPREF(DATA) ; RPC - get graph settings
 D GETPREF^ORWGAPI("ORWGRPC")
 S DATA=$NA(^TMP("ORWGRPC",$J))
 Q
 ;
GETSIZE(DATA) ; RPC - get graph positions and sizes
 D GETSIZE^ORWGAPI("ORWGRPC")
 S DATA=$NA(^TMP("ORWGRPC",$J))
 Q
 ;
GETVIEWS(DATA,ALL,PUBLIC,EXT,USER) ; RPC - get graph views
 D GETVIEWS^ORWGAPI("ORWGRPC",ALL,+$G(PUBLIC),+$G(EXT),+$G(USER))
 S DATA=$NA(^TMP("ORWGRPC",$J))
 Q
 ;
ITEMDATA(DATA,ITEM,START,DFN) ; RPC - get data of an item on patient (glucose results)
 D ITEMDATA^ORWGAPI("ORWGRPC",ITEM,START,DFN)
 S DATA=$NA(^TMP("ORWGRPC",$J))
 Q
 ; 
ITEMS(ITEMS,DFN,TYPE) ; RPC - get items of a type of data on patient (lab tests)
 D ITEMS^ORWGAPI("ORWGRPC",DFN,TYPE)
 S ITEMS=$NA(^TMP("ORWGRPC",$J))
 Q
 ;
LOOKUP(VAL,INFO,FROM,DIR) ; RPC - get item names for long lookup
 D LOOKUP^ORWGAPI(.VAL,INFO,.FROM,DIR)
 Q
 ;
PUBLIC(VAL) ; RPC - check if user can edit public views and settings
 S VAL=$$PUBLIC^ORWGAPI(DUZ)
 Q
 ;
RPTPARAM(VAL,IEN) ; RPC - return PARAM1^PARAM2 for graph report
 S VAL=$$RPTPARAM^ORWGAPI(IEN)
 Q
 ;
SETPREF(ERR,SETTING,PUBLIC) ; RPC - set a graph setting
 D SETPREF^ORWGAPI("ORWGRPC",SETTING,+$G(PUBLIC))
 S ERR=$NA(^TMP("ORWGRPC",$J))
 Q
 ;
SETSIZE(ERR,VAL) ; RPC - set graph positions and sizes
 D SETSIZE^ORWGAPI("ORWGRPC",.VAL)
 S ERR=$NA(^TMP("ORWGRPC",$J))
 Q
 ;
SETVIEWS(ERR,NAME,PUBLIC,VAL) ; RPC - set a graph view
 D SETVIEWS^ORWGAPI("ORWGRPC",NAME,+$G(PUBLIC),.VAL)
 S ERR=$NA(^TMP("ORWGRPC",$J))
 Q
 ;
TAX(DATA,ALL,REMTAX) ; RPC - get reminder taxonomies
 D TAX^ORWGAPI("ORWGRPC",+$G(ALL),.REMTAX)
 S DATA=$NA(^TMP("ORWGRPC",$J))
 Q
 ;
TESTING(DATA) ; RPC - cache data
 D TESTING^ORWGAPI("ORWGRPC")
 S DATA=$NA(^TMP("ORWGRPC",$J))
 Q
 ;
TESTSPEC(DATA) ; RPC - get test/spec info on all lab tests
 D TESTSPEC^ORWGAPI("ORWGRPC")
 S DATA=$NA(^TMP("ORWGRPC",$J))
 Q
 ;
TYPES(TYPES,DFN,SUB) ; RPC - get all the types of data on a patient (SUB=1, gets subtypes, DFN=0 gets all types), 
 D TYPES^ORWGAPI("ORWGRPC",DFN,+$G(SUB))
 S TYPES=$NA(^TMP("ORWGRPC",$J))
 Q
 ;
