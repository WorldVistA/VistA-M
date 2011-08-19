XOBWD ;ALB/MJK - HWSC :: Private Deployment APIs ; 09/13/10 4:00pm
 ;;1.0;HwscWebServiceClient;;September 13, 2010;Build 31
 ;
 QUIT
 ;
GENPORT(XOBY) ; -- generate http port class from WSDL during install
 NEW XOBSTAT,XOBWSDL
 SET XOBWSDL=$GET(XOBY("WSDL FILE"))
 ;
 IF ##class(%File).Exists(XOBWSDL) DO
 . SET XOBSTAT=$$ADDPROXY(.XOBY)
 ELSE  DO
 . SET XOBSTAT="0^File does not exist ["_XOBWSDL_"]"
 QUIT XOBSTAT
 ;
ADDPROXY(XOBY) ; -- create client proxy class
 NEW XOBREADR,XOBSTAT,XOBINFO,XOBCLASS,XOBCXT,I,X,XOBLERR,XOBWSDL,XOBPKG,XOBWSN,XOBTYPE,XOBWAV
 ;
 SET XOBWSDL=$GET(XOBY("WSDL FILE"))
 SET XOBPKG=$GET(XOBY("CACHE PACKAGE NAME"))
 SET XOBWSN=$GET(XOBY("WEB SERVICE NAME"))
 SET XOBWAV=$GET(XOBY("AVAILABILITY RESOURCE"))
 ;
 SET XOBINFO=##class(xobw.WsdlHandler).getInfoFromFile(XOBWSDL)
 IF XOBINFO="" QUIT "0^Unable to parse WSDL file ["_XOBWSDL_"]"
 IF $GET(XOBPKG)="" NEW XOBPKG SET XOBPKG=$LISTGET(XOBINFO,1)
 SET XOBCLASS=XOBPKG_"."_$LISTGET(XOBINFO,2)
 SET XOBCXT=$LISTGET(XOBINFO,3)
 ;
 SET XOBREADR=##class(%SOAP.WSDL.Reader).%New()
 SET XOBREADR.OutputTypeAttribute=1
 SET XOBSTAT=XOBREADR.Process(XOBWSDL,XOBPKG)
 IF XOBSTAT DO
 . DO REGSOAP^XOBWLIB(XOBWSN,XOBCXT,XOBCLASS,XOBWSDL,XOBWAV)
 ELSE  DO
 . DO $system.Status.DecomposeStatus(%objlasterror,.XOBLERR)
 . SET X="" FOR I=1:1:XOBLERR SET X=X_XOBLERR(I)
 . SET XOBSTAT="0^"_X
 ;
 QUIT XOBSTAT
 ;
REGISTER(XOBWSN,XOBTYPE,XOBCXT,XOBCLASS,XOBWSDL,XOBCAURL) ; -- register SOAP and REST service
 ;  Input:
 ;    XOBWSN    -   web service name
 ;    XOBTYPE   -   type of web service [ 1 - SOAP | 2 - REST ]
 ;    XOBCXT    -   web service context root
 ;    XOBCLASS  -   full class name, including package
 ;    XOBWSDL   -   file path containing WSDL document
 ;    XOBCAURL  -   'check availability' url portion to follow context root [optional]
 ;
 NEW XOBCDEF,XOBOK,XOBCHK
 SET XOBCHK=$$CHKTYPE(XOBWSN,XOBTYPE) IF '+XOBCHK DO  QUIT
 . DO BMES^XPDUTL(" o  Type mismatch: attempted "_$SELECT(XOBTYPE=1:"SOAP",XOBTYPE=2:"REST",1:"unknown")_" update of "_$SELECT($P(XOBCHK,"^",2)=1:"SOAP",$P(XOBCHK,"^",2)=2:"REST",1:"unknown")_"-type service '"_XOBWSN_"' failed.")
 IF XOBTYPE=1 DO  QUIT:XOBCDEF=""
 . SET XOBCDEF=##class(%Dictionary.ClassDefinition).%OpenId(XOBCLASS)
 . ; -- perform check to see if port class creation matches what was expected
 . IF XOBCDEF="" DO BMES^XPDUTL(" o  Creating the class definition for '"_XOBCLASS_"' failed.")
 ;
 ; -- add entry into table
 SET XOBOK=$$FILE(XOBWSN,XOBTYPE,XOBCXT,.XOBCLASS,.XOBWSDL,.XOBCAURL)
 DO MES^XPDUTL(" o  WEB SERVICE '"_XOBWSN_"' addition/update "_$SELECT(XOBOK:"succeeded.",1:"failed."))
 DO MES^XPDUTL(" ")
 QUIT
 ;
UNREG(XOBWSN) ; -- unregister and delete web service
 NEW DIK,XOBSRVDA,XOBMULDA,XOBDA,XOBSRVNM,DA
 SET XOBDA=$ORDER(^XOB(18.02,"B",XOBWSN,0)) IF '+XOBDA DO  QUIT
 . DO MES^XPDUTL(" o  WEB SERVICE '"_XOBWSN_"' not found for deletion.")
 ; delete from web servers' authorized multiple
 SET XOBSRVDA=0,XOBMULDA=0
 FOR  SET XOBSRVDA=$ORDER(^XOB(18.12,"AB",XOBDA,XOBSRVDA)) Q:'+XOBSRVDA  DO
 . FOR  SET XOBMULDA=$ORDER(^XOB(18.12,"AB",XOBDA,XOBSRVDA,XOBMULDA)) Q:'+XOBMULDA  DO
 . . SET XOBSRVNM=$P($G(^XOB(18.12,XOBSRVDA,0)),U)
 . . KILL DIK,DA SET DA=XOBMULDA,DA(1)=XOBSRVDA,DIK="^XOB(18.12,"_DA(1)_",100,"
 . . DO ^DIK
 . . DO MES^XPDUTL(" o  WEB SERVICE '"_XOBWSN_"' unauthorized from '"_XOBSRVNM_"'.")
 ; delete web service
 KILL DIK,DA SET DA=XOBDA,DIK="^XOB(18.02," DO ^DIK
 DO MES^XPDUTL(" o  WEB SERVICE '"_XOBWSN_"' unregistered/deleted.")
 QUIT
 ;
CHKTYPE(XOBWSN,XOBTYPE) ; return 1 if no svc, or right type; 0^existing type if mismatch
  NEW XOBIEN
  SET XOBIEN=+$$FIND1^DIC(18.02,"","BX",XOBWSN,"","","")
  IF XOBIEN,XOBTYPE'=$P(^XOB(18.02,XOBIEN,0),"^",2) QUIT 0_"^"_$P(^XOB(18.02,XOBIEN,0),"^",2)
  QUIT 1
  ;
FILE(XOBWSN,XOBTYPE,XOBCXT,XOBCLASS,XOBWSDL,XOBCAURL) ;-- File a new record in file #18.02 or edit existing
 ;  Input:
 ;    XOBWSN    -   web service name
 ;    XOBTYPE   -   type of web service [ 1 - SOAP | 2 -REST ]
 ;    XOBCXT    -   web service context root
 ;    XOBCLASS  -   full class name, including package
 ;    XOBWSDL   -   file path containing WSDL document
 ;    XOBCAURL  -   'check availability' url portion to follow context root [optional]
 ;
 ; Output:
 ;    Function Value - Returns IEN of record on success, 0 on failure
 ;
 NEW XOBFDA,XOBFDAI,XOBERR,XOBIENS,XOBIEN,DIERR
 ;
 SET XOBIEN=+$$FIND1^DIC(18.02,"","BX",XOBWSN,"","","")
 ;
 ; -- If record doesn't already exist, create new
 IF XOBIEN SET XOBIENS=XOBIEN_","
 ELSE  SET XOBIENS="+1,"
 ;
 ; -- validate values ; quit if not valid
 IF '$$VALIDATE() QUIT 0
 ;
 ; -- Set up array with field values
 SET XOBFDA(18.02,XOBIENS,.01)=$GET(XOBWSN)
 SET XOBFDA(18.02,XOBIENS,.02)=$GET(XOBTYPE)
 SET XOBFDA(18.02,XOBIENS,.03)=$$NOW^XLFDT
 SET XOBFDA(18.02,XOBIENS,100)=$GET(XOBCLASS)
 SET XOBFDA(18.02,XOBIENS,200)=$GET(XOBCXT)
 SET XOBFDA(18.02,XOBIENS,201)=$GET(XOBCAURL)
 ;
 IF XOBIEN DO
 . DO FILE^DIE("","XOBFDA","XOBERR")
 . IF $DATA(DIERR) DO
 . . DO DISPERR($NAME(XOBERR))
 . . SET XOBIEN=0
 ELSE  DO
 . DO UPDATE^DIE("","XOBFDA","XOBFDAI","XOBERR")
 . IF $DATA(DIERR) DO
 . . DO DISPERR($NAME(XOBERR))
 . . SET XOBIEN=0
 . ELSE  DO
 . . SET XOBIEN=$GET(XOBFDAI(1))
 ;
 ; -- add copy of WSDL to a SOAP-type entry
 IF XOBIEN,$GET(XOBWSDL)]"" DO WSDL(.XOBWSDL,.XOBIEN)
 ;
 QUIT $SELECT($GET(XOBIEN)>0:XOBIEN,1:0)
 ;
VALIDATE() ; -- validate values of input variables
 NEW XOBY,XOBERR,XOBOK
 SET XOBOK=1
 DO VAL^DIE(18.02,XOBIENS,.01,"",$GET(XOBWSN),.XOBY,"","XOBERR"),CHK
 DO VAL^DIE(18.02,XOBIENS,.02,"",$GET(XOBTYPE),.XOBY,"","XOBERR"),CHK
 DO VAL^DIE(18.02,XOBIENS,100,"",$GET(XOBCLASS),.XOBY,"","XOBERR"),CHK
 DO VAL^DIE(18.02,XOBIENS,200,"",$GET(XOBCXT),.XOBY,"","XOBERR"),CHK
 ; -- work around for FM DBS bug that does not allow input to start with ?
 IF $EXTRACT($GET(XOBCAURL))'="?" DO
 . DO VAL^DIE(18.02,XOBIENS,201,"",$GET(XOBCAURL),.XOBY,"","XOBERR"),CHK
 QUIT XOBOK
 ;
CHK ;
 IF $GET(XOBY)="^" DO
 . SET XOBOK=0
 . DO DISPERR("XOBERR")
 QUIT
 ;
DISPERR(XOBINARR) ; -- display error message
 NEW XOBOUT,XOBI,XOBX
 DO MES^XPDUTL("FM Database Server Error Information:")
 DO MSG^DIALOG("AE",.XOBOUT,70,"",XOBINARR)
 FOR XOBI=1:1 QUIT:$D(XOBOUT(XOBI))=0  DO MES^XPDUTL($GET(XOBOUT(XOBI)))
 QUIT
 ;
WSDL(XOBWSDL,XOBIEN) ; -- file copy of WSDL
 NEW XOBSTRM,XOBROOT,XOBI,XOBERR,DIERR
 SET XOBROOT=$NAME(^TMP("XOBW WSDL FILING",$JOB))
 SET XOBI=0
 SET XOBSTRM=##class(%FileCharacterStream).%New()
 SET XOBSTRM.Filename=$GET(XOBWSDL)
 FOR  QUIT:XOBSTRM.AtEnd  DO
 . SET XOBI=XOBI+1
 . SET @XOBROOT@(XOBI)=XOBSTRM.ReadLine()
 DO WP^DIE(18.02,XOBIEN_",",300,"K",XOBROOT,$NAME(XOBERR))
 ; -- if error occurs, just display
 IF $DATA(DIERR) DO DISPERR($NAME(XOBERR))
 QUIT
 ;
