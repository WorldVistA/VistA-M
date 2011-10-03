XOBWSSL ;ALB/MJK - HWSC :: SSL Integration Tools ; 09/13/10 4:00pm
 ;;1.0;HwscWebServiceClient;;September 13, 2010;Build 31
 ;
 QUIT
 ;
CHKNAME(XOBCFGN) ; -- match configuration name / used by input transform (18.12 : 3.02)
 QUIT:$$CACH2008() 1  ; skip match checking if Cache 2008/higher, can't check oustide %SYS 
 NEW MATCH,STATUS,RS,MORE
 SET MATCH=0
 SET RS=##class(%ResultSet).%New("%Net.SSL.Configuration:ListNames")
 IF $system.Status.IsError(RS.Execute()) GOTO CHKNAMEQ
 ; -- see if there is a match
 FOR  SET MORE=RS.Next(.STATUS) QUIT:'MORE!($system.Status.IsError(STATUS))  DO  QUIT:MATCH
 . IF XOBCFGN=$GET(RS.Data("Name")) SET MATCH=1 QUIT
CHKNAMEQ ; -- check name quit point
 QUIT MATCH
 ;
DISPLAY ; -- display list of SSL configuration names  / used by XECUTABLE HELP (18.12 :3.02)
 QUIT:$$CACH2008()  ; skip display if Cache 2008/higher, can't check oustide %SYS 
 NEW COUNT,RS,STATUS
 SET COUNT=0
 DO EN^DDIOL("Possible SSL configurations are the following:")
 SET RS=##class(%ResultSet).%New("%Net.SSL.Configuration:ListNames")
 IF $system.Status.IsError(RS.Execute()) GOTO DISPLAYQ
 ; -- display the names
 FOR  SET MORE=RS.Next(.STATUS) QUIT:'MORE!($system.Status.IsError(STATUS))  DO
 . DO EN^DDIOL("- "_$GET(RS.Data("Name")),"","!?5")
 . SET COUNT=COUNT+1
DISPLAYQ ; -- display list quit point
 IF COUNT=0 DO EN^DDIOL("<No SSL configurations defined>","","!?5")
 QUIT
 ;
GETCFG(XOBCFGN) ; -- get %Net.SSL.Configuration instance
 NEW STATUS,RS,MORE,CFG
 SET CFG=""
 SET RS=##class(%ResultSet).%New("%Net.SSL.Configuration:Extent")
 IF $system.Status.IsError(RS.Execute()) GOTO GETCFGQ
 ; -- see if there is a match
 FOR  SET MORE=RS.Next(.STATUS) QUIT:'MORE!($system.Status.IsError(STATUS))  DO  QUIT:CFG]""
 . SET CFG=##class(%Net.SSL.Configuration).%OpenId(RS.Data("ID"))
 . IF XOBCFGN=CFG.Name QUIT
 . SET CFG=""
GETCFGQ ; -- get SSL config instance exit point
 QUIT CFG
 ;
SHOW(XOBCFGN) ; -- simple display of SSL Configuration
 QUIT:$$CACH2008()  ; skip if Cache 2008/higher, can't check oustide %SYS 
 NEW CFG
 SET CFG=$$GETCFG(XOBCFGN)
 IF CFG="" GOTO SHOWQ
 WRITE !,"SSL Configuration Name: ",!?5," > ",CFG.Name
 WRITE !,"File containing X.509 certificate(s) of trusted CAs: ",!?5," > ",$$GETSTR(CFG.CAFile)
 WRITE !,"Directory containing file(s) with X.509 certificate(s) of trusted CA: ",!?5," > ",$$GETSTR(CFG.CAPath)
 WRITE !,"File containing this configuration's X.509 certificate: ",!?5," > ",$$GETSTR(CFG.CertificateFile)
 WRITE !,"Ciphersuites: ",!?5," > ",$$GETSTR(CFG.CipherList)
 WRITE !,"File containing this configuration's private key: ",!?5," > ",$$GETSTR(CFG.PrivateKeyFile)
 WRITE !,"Private key type: ",!?5," > ",$$GETSTR($SELECT(CFG.PrivateKeyType=1:"DSA",CFG.PrivateKeyType=2:"RSA",1:""))
 WRITE !,"Intended role for this configuration: ",!?5," > ",$$GETSTR($SELECT(CFG.Role=0:"client",CFG.Role=1:"server",1:""))
 WRITE !,"Peer certificate verification level: " DO
 . ; -- client role
 . IF CFG.Role=0 WRITE !?5," > ",$$GETSTR($SELECT(CFG.VerifyPeer=0:"none",CFG.VerifyPeer=1:"required",1:"")) QUIT
 . ; -- server role
 . IF CFG.Role=1 WRITE !?5," > ",$$GETSTR($SELECT(CFG.VerifyPeer=0:"none",CFG.VerifyPeer=1:"request",CFG.VerifyPeer=3:"required",1:"")) QUIT
 WRITE !,"Maximum number of CA certificates allowed in peer certificate chain: ",!?5," > ",$$GETSTR(CFG.VerifyDepth)
SHOWQ ;
 QUIT
 ;
GETSTR(STR) ; 
 QUIT $SELECT(STR]"":STR,1:"<null>")
 ;
CACH2008() ; quit 1 if OS is 2008 or higher
 NEW XOBVER
 SET XOBVER=$$VERSION^%ZOSV()
 IF +$P(XOBVER,".")>2007 QUIT 1
 QUIT 0
