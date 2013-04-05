EDPCBRD ;SLC/KCM - Controller for ED Tracking Board ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
RPC(EDPXML,SESS,PARAMS) ; Process request via RPC instead of CSP
 N X,REQ,EDPSITE,EDPUSER,EDPDBUG
 K EDPXML
 S EDPUSER=$P($G(SESS),U),EDPSTA=$P($G(SESS),U,2),EDPSITE=$$IEN^XUAF4(EDPSTA)
 S X="" F  S X=$O(PARAMS(X)) Q:X=""  S REQ(X,1)=PARAMS(X)
 S EDPDBUG=$$DEBUG^EDPCDBG("board")
 I EDPDBUG D PUTREQ^EDPCDBG(EDPDBUG,.PARAMS)
 ;
COMMON ; Come here for both CSP and RPC Mode
 ;
 N EDPFAIL,CMD
 S CMD=$G(REQ("command",1))
 I $L($G(REQ("machine",1))) D  G:$D(EDPXML)>0 OUT  ; exit on error
 . N BRD
 . S REQ("machine",1)=$$LOW^XLFSTR(REQ("machine",1))
 . S BRD=$$GET^XPAR("DIV","EDPF BIGBOARD KIOSKS",REQ("machine",1),"I")
 . I '$L(BRD) D
 .. S BRD=$$GET^XPAR(EDPSITE_";DIC(4,","EDPF BIGBOARD KIOSKS",REQ("machine",1),"I")
 . I '$L(BRD) D XML^EDPX("<error>Computer name not found.</error>") Q
 . S REQ("board",1)=BRD
 ;
 ; switch on command
 ; 
 ; ---------------------------------
 ;
 ; initTracking
 ; return <user area="" areaNm="" />...
 I CMD="initTracking" D BRDUSER^EDPQAR($$VAL("area")) G OUT
 ;
 ; ---------------------------------
 ; 
 ; initDisplayBoard
 ; return <spec>
 ;        <color><map />...</color>...
 ;        <rows><row />...</rows>
 I CMD="initDisplayBoard" D  G OUT
 . D GET^EDPQDBS($$VAL("area"),$$VAL("board"))
 . D GET^EDPQDB($$VAL("area"),$$VAL("board"),-1)
 ;
 ; ---------------------------------
 ; 
 ; refreshDisplayBoard
 ; return <rows><row />...</rows>
 I CMD="refreshDisplayBoard" D  G OUT
 . D GET^EDPQDB($$VAL("area"),$$VAL("board"),$$VAL("last"))
 ;
 ; ---------------------------------
 ; else
 D XML^EDPX("<error msg='"_$$MSG^EDPX(2300010)_"' />")
 ; end switch
 ; 
OUT ; output the XML
 I EDPDBUG D PUTXML^EDPCDBG(EDPDBUG,.EDPXML)
 I $L($G(EDPHTTP)) D        ; if in CSP mode
 . U EDPHTTP
 . W "<results>",!
 . N I S I=0 F  S I=$O(EDPXML(I)) Q:'I  W EDPXML(I),!
 . W "</results>",!
 K EDPHTTP
END Q
 ;
VAL(X) ; return value from request
 Q $G(REQ(X,1))
