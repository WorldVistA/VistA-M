EDPGLOB ;SLC/BWF - Controller for ED Lab Retrieval ;4/25/12 12:51pm
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
RPC(EDPXML,PARAMS) ; Process request via RPC instead of CSP
 N X,REQ,EDPSITE,EDPUSER,EDPDBUG
 K EDPXML
 S EDPUSER=DUZ,EDPSITE=DUZ(2),EDPSTA=$$STA^XUAF4(DUZ(2))
 S X="" F  S X=$O(PARAMS(X)) Q:X=""  D
 . I $D(PARAMS(X))>9 M REQ(X)=PARAMS(X)
 . E  S REQ(X,1)=PARAMS(X)
 S EDPDBUG=$$DEBUG^EDPCDBG($G(PARAMS("swfID")))
 I EDPDBUG D PUTREQ^EDPCDBG(EDPDBUG,.PARAMS)
 ; parameters missing or invalid
 I $G(REQ("patient",1))<1 D  G OUT
 . D XML^EDPX("<error msg='"_$$MSG^EDPX(2300018)_"' />")
 ;
COMMON ; Come here for both CSP and RPC Mode
 ;
 N EDPFAIL,CMD
 S CMD=$G(REQ("command",1))
 ;
 ; switch on command
 ; 
 ; ---------------------------------
 ;
 ; getLabs = return lab results
 S EDPXML=$NA(^TMP("EDPGLOB",$J)) K @EDPXML
 I CMD="getLabs" D  G OUT
 . D EN^EDPLAB(EDPXML,.REQ)
 ;
 ; ---------------------------------
 ;
 ; else
 D XML^EDPX("<error msg='"_$$MSG^EDPX(2300010)_CMD_"' />")
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
