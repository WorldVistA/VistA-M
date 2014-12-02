EDPGLOB ;SLC/BWF - Controller for ED Lab Retrieval ;4/25/12 12:51pm
 ;;2.0;EMERGENCY DEPARTMENT;**6**;May 2, 2012;Build 200
 ;
RPC(EDPXML,PARAMS,PARAMS2) ; Process request via RPC instead of CSP
 N X,REQ,EDPSITE,EDPUSER,EDPDBUG
 K EDPXML
 S EDPUSER=DUZ,EDPSITE=DUZ(2),EDPSTA=$$STA^XUAF4(DUZ(2))
 S X="" F  S X=$O(PARAMS(X)) Q:X=""  D
 . I $D(PARAMS(X))>9 M REQ(X)=PARAMS(X)
 . E  S REQ(X,1)=PARAMS(X)
 ; params2 will not be converted the same way as params. It is still unclear why params was converted.
 ; There seems to be no reason to do this.
 S EDPDBUG=$$DEBUG^EDPCDBG($G(PARAMS("swfID")))
 I EDPDBUG D PUTREQ^EDPCDBG(EDPDBUG,.PARAMS)
 ; parameters missing or invalid
 ;I $G(REQ("patient",1))<1 D  G OUT
 ;. D XML^EDPX("<error msg='"_$$MSG^EDPX(2300018)_"' />")
 ;
COMMON ; Come here for both CSP and RPC Mode
 ;
 N EDPFAIL,CMD
 S CMD=$G(REQ("command",1))
 S EDPXML=$NA(^TMP("EDPGLOB",$J)) K @EDPXML
 ;
 ; switch on command
 ; 
 ; ---------------------------------
 ;
 ; getLabs = return lab results
 I CMD="getLabs" D  G OUT
 . I $G(REQ("patient",1))<1 D XML^EDPX("<error msg='"_$$MSG^EDPX(2300018)_"' />") Q
 . D EN^EDPLAB(EDPXML,.REQ)
 ;
 ; ---------------------------------
 ; getReportList - return adhoc reports (list or full definition)
 I CMD="getReportList" D  G OUT
 . D GETREPL^EDPARPT(EDPXML,.PARAMS)
 ; ---------------------------------
 ; saveReportDef - save adhoc report template/definition
 I CMD="saveReportDef" D  G OUT
 . D SAVE^EDPARPT(EDPXML,.PARAMS,.PARAMS2)
 ; ---------------------------------
 ; getReportElements - return adhoc report data elements
 I CMD="getReportElements" D  G OUT
 . D GETELM^EDPARPT(EDPXML,.PARAMS,.PARAMS2)
 ; ---------------------------------
 ; executeReport - execute adhoc report
 I CMD="executeReport" D  G OUT
 . D EXE^EDPARPT(EDPXML,.PARAMS,.PARAMS2)
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
