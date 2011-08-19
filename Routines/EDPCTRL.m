EDPCTRL ;SLC/KCM - Controller for ED Tracking
 ;;1.0;EMERGENCY DEPARTMENT;;Sep 30, 2009;Build 74
 ;
RPC(EDPXML,PARAMS) ; Process request via RPC instead of CSP
 N X,REQ,EDPSITE,EDPUSER,EDPDBUG
 K EDPXML
 S EDPUSER=DUZ,EDPSITE=DUZ(2),EDPSTA=$$STA^XUAF4(DUZ(2))
 S X="" F  S X=$O(PARAMS(X)) Q:X=""  S REQ(X,1)=PARAMS(X)
 S EDPDBUG=$$DEBUG^EDPCDBG($G(PARAMS("swfID")))
 I EDPDBUG D PUTREQ^EDPCDBG(EDPDBUG,.PARAMS)
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
 ; initUser
 ; return <user />
 ;        <view />...
 I CMD="initUser" D  G OUT
 . D SESS^EDPFAA,VIEWS^EDPFAA
 ;
 ; ---------------------------------
 ;
 ; matchPatients
 ; return <ptlk />...<ptlk />
 I CMD="matchPatients" D  G OUT
 . D MATCH^EDPFPTL($$VAL("partial"))
 ;
 ; ---------------------------------
 ; 
 ; getPatientChecks
 ; return <checks />
 ;        <similar />
 ;        <warning> </warning>
 ;        <patientRecordFlags><flag> <text> </text></flag>...</patientRecordFlags>
 I CMD="getPatientChecks" D  G OUT
 . D CHK^EDPFPTC($$VAL("area"),$$VAL("patient"),$$VAL("name"))
 ; 
 ; ---------------------------------
 ; 
 ; saveSecurityLog
 ; return <save />
 I CMD="saveSecurityLog" D  G OUT
 . D LOG^EDPFPTC($$VAL("patient"))
 ; 
 ; ---------------------------------
 ; 
 ; getLexiconMatches
 ; return <items><item />...</items>
 I CMD="getLexiconMatches" D  G OUT
 . D ICD^EDPFLEX($$VAL("text"))
 ; 
 ; ---------------------------------
 ; 
 ; initLogArea
 ; return <udp />
 ;        <params disposition="" diagnosis="" delay="" delayMinutes="" />
 ;        <logEntries><log />...</logEntries>
 I CMD="initLogArea" D  G OUT
 . I $L($$VAL("logEntry")) D UPD^EDPLOG($$VAL("logEntry")) Q:$G(EDPFAIL)
 . D PARAM^EDPQAR($$VAL("area"))
 . D GET^EDPQLP($$VAL("area"),-1)  ;-1 = force refresh
 ;
 ; ---------------------------------
 ; 
 ; checkLogin  -- OBSOLETE
 ; return <user />
 I CMD="checkLogin" D SESS^EDPFAA G OUT
 ;
 ; ---------------------------------
 ; 
 ; refreshLogSelector
 ; return <logEntries><log />...</logEntries>
 I CMD="refreshLogSelector" D  G OUT
 . D GET^EDPQLP($$VAL("area"),$$VAL("token"))
 ;
 ; ---------------------------------
 ; 
 ; switchLogEntry
 ; return <udp />
 ;        <logEntry>log fields...</logEntry>
 ;        <choices>choice lists...</choices>
 I CMD="switchLogEntry" D  G OUT
 . I $L($$VAL("logEntry")) D UPD^EDPLOG($$VAL("logEntry")) Q:$G(EDPFAIL)
 . D GET^EDPQLE($$VAL("logID"),$$VAL("choiceTS"))
 ;
 ; ---------------------------------
 ; 
 ; saveLogEntry
 ; return <upd />
 I CMD="saveLogEntry" D  G OUT
 . D UPD^EDPLOG($$VAL("logEntry")) Q:$G(EDPFAIL)
 ;
 ; ---------------------------------
 ; 
 ; addPatientToLog
 ; return <upd />
 ;        <add />
 ;        <logEntry>log fields...</logEntry>
 ;        <choices>choice lists...</choices>
 ;        <logEntries><log />...</logEntries>
 I CMD="addPatientToLog" D  G OUT
 . D ADD^EDPLOGA($$VAL("addPatient"),$$VAL("area"),$$VAL("localTime"),$$VAL("choiceTS"))
 . Q:$G(EDPFAIL)
 . D GET^EDPQLP($$VAL("area"),-1)
 ;
 ; ---------------------------------
 ;
 ; deleteStubEntry
 ; return <upd />
 I CMD="deleteStubEntry" D  G OUT
 . D DEL^EDPLOGA($$VAL("area"),$$VAL("logID"))
 ;
 ; ---------------------------------
 ; 
 ; removeLogEntry
 ; return <upd />
 ;        <logEntries><log />...</logEntries>
 I CMD="removeLogEntry" D  G OUT
 . D UPD^EDPLOG($$VAL("logEntry"),1) Q:$G(EDPFAIL)
 . D GET^EDPQLP($$VAL("area"),-1)
 ;
 ; ---------------------------------
 ;
 ; matchClosed
 ; return <visit />...
 I CMD="matchClosed" D  G OUT
 . D CLOSED^EDPQLP($$VAL("area"),$$VAL("partial"))
 ;
 ; ---------------------------------
 ;
 ; loadConfiguration
 ; return <color><map />...</color>...
 ;        <columnList><col />...</columnList>
 ;        <colorMapList><colorMap><map />...</colorMapList>
 ;        <beds><bed />...</beds>
 ;        <params />
 ;        <defaultRoomList><item />...</defaultRoomList>
 ;        <displayWhen><when />...</displayWhen>
 ;        <statusList><status />...</statusList>
 I CMD="loadConfiguration" D  G OUT
 . D LOAD^EDPBCF($$VAL("area"))
 ;
 ; ---------------------------------
 ;
 ; loadBoardConfig
 ; return <spec><row /><col />...</spec>
 I CMD="loadBoardConfig" D  G OUT
 . D LOADBRD^EDPBCF($$VAL("area"),$$VAL("boardID"))
 ;
 ; ---------------------------------
 ;
 ; saveConfigBoard
 ; return <save />
 I CMD="saveConfigBoard" D  G OUT
 . D SAVEBRD^EDPBCF(.REQ) ; pass whole request for parsing
 ;
 ; ---------------------------------
 ;
 ; saveBedConfig
 ; return <save />
 I CMD="saveBedConfig" D  G OUT
 . D SAVE^EDPBRM(.REQ,$$VAL("area")) ; pass whole request for parsing
 ;
 ; ---------------------------------
 ;
 ; saveColorConfig
 ; return <save />
 I CMD="saveColorConfig" D  G OUT
 . D SAVE^EDPBCM(.REQ) ; pass whole request for parsing
 ;
 ; ---------------------------------
 ;
 ; loadSelectionConfig
 ; return <selectionName><code />....</selectionName>...
 I CMD="loadSelectionConfig" D  G OUT
 . D LOAD^EDPBSL($$VAL("area"))
 ;
 ; ---------------------------------
 ; 
 ; loadStaffConfig
 ; return providers, nurses, staff for area
 I CMD="loadStaffConfig" D  G OUT
 . D LOAD^EDPBST($$VAL("area"))
 ;
 ; ---------------------------------
 ;
 ; saveStaffConfig
 ; return <save />
 I CMD="saveStaffConfig" D  G OUT
 . D SAVE^EDPBST(.REQ) ; pass whole request for parsing
 ;
 ; ---------------------------------
 ;
 ; matchPersons
 ; return <per />...<per />
 I CMD="matchPersons" D  G OUT
 . D MATCH^EDPFPER($$VAL("partial"),$$VAL("personType"))
 ;
 ; ---------------------------------
 ;
 ; saveParamConfig
 ; return <save />
 I CMD="saveParamConfig" D  G OUT
 . D SAVE^EDPBPM($$VAL("area"),$$VAL("param"))
 ;
 ; ---------------------------------
 ;
 ; saveSelectionConfig
 ; return <save />
 I CMD="saveSelectionConfig" D  G OUT
 . D SAVE^EDPBSL($$VAL("area"),.REQ)
 ;
 ; ---------------------------------
 ; 
 ; getReport
 ; return <logEntries><log />...</logEntries>
 ;        <averages><all /><not /><adm /></averages>
 ;        <providers><md />...</providers>
 I CMD="getReport" D  G OUT
 . D EN^EDPRPT($$VAL("start"),$$VAL("stop"),$$VAL("report"),$$VAL("id"))
 ;
 ; ---------------------------------
 ; 
 ; getCSV
 ; return TAB separated values for report
 I CMD="getCSV" D  G OUT
 . N EDPCSV   ; CSV mode uses EDPCSV instead of EDPXML
 . D EN^EDPRPT($$VAL("start"),$$VAL("stop"),$$VAL("report"),$$VAL("id"),1)
 . M EDPXML=EDPCSV
 ;
 ; ---------------------------------
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
END Q
 ;
VAL(X) ; return value from request
 Q $G(REQ(X,1))
