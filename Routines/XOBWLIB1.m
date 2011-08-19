XOBWLIB1 ;ALB/MJK - HWSC :: Utilities Library ; 09/13/10 4:00pm
 ;;1.0;HwscWebServiceClient;;September 13, 2010;Build 31
 ;
 QUIT
 ;
 ;----------------------- Private Calls used By XOBWLIB --------------------------
HEAD ; -- display heading
 WRITE @IOF,!
 WRITE $$CJ^XLFSTR("List of Web Servers",80),!
 WRITE $$CJ^XLFSTR("HealtheVet Web Services Client (HWSC)  "_$$GETBLD(),80),!
 WRITE !,?2,"Name",?31,"Server:Port"
 WRITE !,?2,"====",?31,"==========="
 QUIT
 ;
PAUSE(XOBEXIT) ; -- screen continue message
 NEW X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 WRITE !,?4,"* = enabled"
 SET DIR(0)="E",DIR("A")="Enter RETURN to continue or '^' to stop" DO ^DIR KILL DIR
 SET XOBEXIT=+$GET(DIRUT)
 QUIT
 ;
GETBLD() ; -- get current build number
 QUIT "Build "_$$VERSION^XOBWENV()
 ;
STATKSP() ; -- get station number for computing facility
 QUIT $$STA^XUAF4($$KSP^XUPARAM("INST"))
 ;
STATUSER() ; -- get station number for logged-on user
 QUIT $$STA^XUAF4(DUZ(2))
 ;
 ; ----------- web service Proxy APIs ------------
 ; 
ATTACHDR(XOBPROXY) ; -- add VistaInfoHeader to proxy object
 NEW INFOARR
 SET INFOARR=##class(%Library.ArrayOfDataTypes).%New()
 DO INFOARR.SetAt($GET(DUZ,"Unknown"),"duz")
 DO INFOARR.SetAt($$VPID^XUPS($GET(DUZ)),"vpid")
 DO INFOARR.SetAt($IO,"mio")
 DO INFOARR.SetAt($JOB,"mjob")
 DO INFOARR.SetAt($$STATKSP(),"station-ksp")
 DO INFOARR.SetAt($$STATUSER(),"station-user")
 DO INFOARR.SetAt($$PROD^XUPROD(0),"production")
 DO ##class(xobw.VistaInfoHeader).attachHeader(XOBPROXY,INFOARR)
 QUIT
 ; 
 ; ----------- error processing APIs ------------
EOFAC(XOBPROXY) ; --  Error Object FACtory
 NEW $ETRAP,XOBERR
 SET $ETRAP="D ^%ZTER HALT"
 ;
 ; -- SOAP fault error
 IF $$EC^%ZOSV()["<ZSOAP>",$GET(XOBPROXY)]"",XOBPROXY.SoapFault]"" DO  GOTO EOFACQ
 . SET XOBERR=##class(xobw.error.SoapError).%New(XOBPROXY.SoapFault)
 . KILL %objlasterror
 ;
 ; -- object error
 ; -- Future: Can we remove the $$EC^%ZOSV()["<ZSOAP>"? (There could be spurious %objlasterror in partition)
 IF $$EC^%ZOSV()["<ZSOAP>",$GET(%objlasterror)]"" DO  GOTO EOFACQ
 . SET XOBERR=##class(xobw.error.ObjectError).%New(.%objlasterror)
 . KILL %objlasterror
 ;
 ; -- DIALOG object error [used in xobw.WebServiceProxyFactory]
 ;     input structure of %XOBWERR:
 ;       <DIALOG ien> ^ <parameter #1> ^ <parameter #2> ^ <so on...>
 IF $GET(%XOBWERR)]"" DO  GOTO EOFACQ
 . NEW XOBPARMS,XOBCODE,Y,I
 . SET XOBCODE=$PIECE(%XOBWERR,"^")
 . FOR I=2:1 SET Y=$PIECE(%XOBWERR,"^",I) QUIT:Y=""  SET XOBPARMS(I-1)=Y
 . SET XOBERR=##class(xobw.error.DialogError).%New(XOBCODE,$$EZBLD^DIALOG(XOBCODE,.XOBPARMS))
 . KILL %XOBWERR
 ;
 ; -- basic M-type error
 SET XOBERR=##class(xobw.error.BasicError).%New($ECODE,$$EC^%ZOSV())
 ;
EOFACQ ;
 QUIT $GET(XOBERR)
 ;
 ; ----------- Miscellaneous Helper APIs -----------
 ;
IMPORT(XOBDIR,XOBFILE) ; -- import Cache-exported XML file into Cache
 ; input parameters: 
 ;  XOBDIR: directory holding 'export' file
 ;  XOBFILE: 'export' file to import
 ; return: 
 ;  success: positive return value
 ;  failure: 0^reason
 ;  
 NEW XOBPATH,XOBSTAT,XOBLIST,XOBLERR,X,I
 SET XOBPATH=$GET(XOBDIR)_$GET(XOBFILE)
 IF ##class(%File).Exists(XOBPATH) DO
 . SET XOBSTAT=$system.OBJ.Load(XOBPATH,"ck","",.XOBLIST)
 . IF XOBSTAT QUIT
 . DO $system.Status.DecomposeStatus(%objlasterror,.XOBLERR)
 . SET X="" FOR I=1:1:XOBLERR SET X=X_XOBLERR(I)
 . SET XOBSTAT="0^"_X
 ELSE  DO
 . SET XOBSTAT="0^File not found"
 QUIT XOBSTAT
 ;
 ; ----------- web server lookup key APIs -----------
 ; 
SKEYADD(XOBWKEY,XOBWDESC,XOBOERR) ; add or edit a server key name/desc (no prompting)
 NEW XOBFDA,XOBFDAI,XOBIENS,XOBIEN,DIERR,XOBERR
 SET XOBWKEY=$$UP^XLFSTR(XOBWKEY) ; force uppercase
 SET XOBIEN=+$$FIND1^DIC(18.13,"","BX",XOBWKEY,"","","")
 ;
 ; -- If record doesn't already exist, create new
 IF XOBIEN SET XOBIENS=XOBIEN_","
 ELSE  SET XOBIENS="+1,"
 ;
 ; -- Set up array with field values
 SET XOBFDA(18.13,XOBIENS,.01)=$GET(XOBWKEY)
 SET XOBFDA(18.13,XOBIENS,.02)=$GET(XOBWDESC)
 ;
 IF XOBIEN DO  ; edit
 . DO FILE^DIE("E","XOBFDA","XOBERR")
 . IF $DATA(DIERR) DO
 . . SET XOBIEN=0
 . . DO MSG^DIALOG("AE",.XOBOERR,245,"","XOBERR")
 ELSE  DO  ; add
 . DO UPDATE^DIE("E","XOBFDA","XOBFDAI","XOBERR")
 . IF $DATA(DIERR) DO
 . . SET XOBIEN=0
 . . DO MSG^DIALOG("AE",.XOBOERR,245,"","XOBERR")
 . ELSE  DO
 . . SET XOBIEN=$GET(XOBFDAI(1))
 ;
 QUIT $SELECT($GET(XOBIEN)>0:XOBIEN,1:0)
 ;
SNAME4KY(XOBWKEY,XOBWSNM,XOBERR) ; get server name based on key
 NEW XOBWSIEN,XOBKYIEN,XOBKYNM,XOBPARMS
 SET XOBKYNM=$$UP^XLFSTR(XOBWKEY)
 ; -- exist check
 IF XOBKYNM="" SET XOBERR="186008^"_$$EZBLD^DIALOG(186008,"") QUIT 0
 SET XOBKYIEN=$ORDER(^XOB(18.13,"PRIMARY",XOBKYNM,""))
 IF 'XOBKYIEN SET XOBERR="186008^"_$$EZBLD^DIALOG(186008,XOBKYNM) QUIT 0
 ; -- server association check
 SET XOBWSIEN=$PIECE($GET(^XOB(18.13,XOBKYIEN,0)),U,3)
 IF 'XOBWSIEN SET XOBERR="186009^"_$$EZBLD^DIALOG(186009,XOBWKEY) QUIT 0
 ; -- success
 SET XOBWSNM=$PIECE($GET(^XOB(18.12,XOBWSIEN,0)),U)
 QUIT 1
 ;
 ;------------ Developer Testing APIs ------------
 ;
GETSRV() ; -- PUBLIC API: return interactive-user-selected server name
 NEW DIC,DUOUT,DTOUT,X,Y
 SET DIC="^XOB(18.12,"
 SET DIC(0)="AEMQ"
 IF $DATA(^XOB(18.12,+$GET(^DISV(DUZ,"^XOB(18.12,")),0)) SET DIC("B")=$PIECE(^(0),U)
 DO ^DIC KILL DIC
 IF +$GET(Y)'>0 QUIT ""
 QUIT $PIECE(Y,U,2)
 ;
DISPSRVS ; -- display servers
 NEW NAME,IPPORT,DEFAULT,STATUS,SITE,XOBEXIT,XOBI,XOBJ,XOBSVRS,XOBR
 SET XOBEXIT=0,XOBR=""
 SET XOBSVRS=$NAME(XOBDATA("DILIST","ID"))
 DO LIST^DIC(18.12,"",".01;.03;.04;.06","I","","","","","","",$NAME(XOBDATA))
 DO HEAD
 FOR XOBI=0:0 SET XOBI=$ORDER(@XOBSVRS@(XOBI)) QUIT:'XOBI!(XOBEXIT)  DO
 . SET NAME=$GET(@XOBSVRS@(XOBI,.01))
 . SET IPPORT=$GET(@XOBSVRS@(XOBI,.04))_":"_$GET(@XOBSVRS@(XOBI,.03))
 . SET STATUS=$SELECT($GET(@XOBSVRS@(XOBI,.06))=1:"* ",1:" ")
 . IF $Y>(IOSL-5) DO PAUSE(.XOBEXIT) QUIT:XOBEXIT  DO HEAD
 . WRITE !,STATUS,NAME,?31,IPPORT
 IF 'XOBEXIT WRITE !,?0,"* = enabled"
 KILL XOBDATA
 QUIT
 ;
