XOBSCAV2 ;; kec/oak - VistaLink Access/Verify Security ; 12/09/2002  17:00
 ;;1.6;VistALink Security;;May 08, 2009;Build 15
 ;Per VHA directive 2004-038, this routine should not be modified.
 QUIT
 ;
 ; --------------------------------------------------------------------
 ;      Access/Verify Security: Security Message Request Handler
 ;   (AV.GetUserDemographics req/resp pairs; XML parser callbacks)
 ; --------------------------------------------------------------------
 ;
 ;==== AV.GetUserDemographics.Request message processing ====
SENDDEM ; respond to user demographics request
 IF '$$LOGGEDON^XOBSCAV() DO SENDDEM0("User not logged on.")
 DO SENDDEM1
 QUIT
SENDDEM1 ; success
 NEW XOBMSG,XOBI,XOBNC,XOBNC1,XOBDIV,XOBRET,XOBERR,XOBTXT
 ; get ptr to Name Components file
 DO GETS^DIQ(200,DUZ_",","10.1","I","XOBNC","XOBERR")
 IF $DATA(XOBERR) DO  QUIT
 .SET XOBI=0,XOBTXT="FileMan Error: "
 .FOR  SET XOBI=$ORDER(XOBERR("DIERR",XOBI)) QUIT:'+XOBI  SET XOBTXT=XOBTXT_XOBERR("DIERR",XOBI)_" "_XOBERR("DIERR",XOBI,"TEXT",1)
 .DO ERROR^XOBSCAV(.XOBR,$PIECE($TEXT(FSERVER^XOBSCAV),";;",2),"Demographics failure",183006,$$CHARCHK^XOBVLIB($$EZBLD^DIALOG(183006,.XOBTXT)))
 SET XOBNC=XOBNC(200,DUZ_",",10.1,"I")
 ; get name components -- read access to file 20: DBIA# 3041
 DO GETS^DIQ(20,XOBNC_",","1:6","","XOBNC1","XOBERR")
 IF $DATA(XOBERR) DO  QUIT
 .SET XOBI=0,XOBTXT="FileMan Error: "
 .FOR  SET XOBI=$ORDER(XOBERR("DIERR",XOBI)) QUIT:'+XOBI  SET XOBTXT=XOBTXT_XOBERR("DIERR",XOBI)_" "_XOBERR("DIERR",XOBI,"TEXT",1)
 .DO ERROR^XOBSCAV(.XOBR,$PIECE($TEXT(FSERVER^XOBSCAV),";;",2),"Demographics failure",183006,$$CHARCHK^XOBVLIB($$EZBLD^DIALOG(183006,.XOBTXT)))
 ; get more userinfo from Kernel
 DO USERINFO^XUSRB2(.XOBRET) ; use of USERINFO^XUSRB2: DBIA #4055
 ; strip any illegal xml chars from data
 FOR XOBI=1:1:7 SET XOBRET(XOBI)=$$CHARCHK^XOBVLIB(XOBRET(XOBI))
 FOR XOBI=1:1:6 SET XOBNC1(20,XOBNC_",",XOBI)=$$CHARCHK^XOBVLIB(XOBNC1(20,XOBNC_",",XOBI))
 ; format return message
 SET XOBMSG(1)="<NameInfo prefix='"_XOBNC1(20,XOBNC_",",4)_"' givenFirst='"_XOBNC1(20,XOBNC_",",2)_"' middle='"_XOBNC1(20,XOBNC_",",3)
 SET XOBMSG(1)=XOBMSG(1)_"' familyLast='"_XOBNC1(20,XOBNC_",",1)_"' suffix='"_XOBNC1(20,XOBNC_",",5)
 SET XOBMSG(1)=XOBMSG(1)_"' degree='"_XOBNC1(20,XOBNC_",",6)_"' newPerson01Name='"_XOBRET(1)_"' standardConcatenated='"_XOBRET(2)_"' />"
 SET XOBMSG(2)="<UserInfo duz='"_DUZ_"' title='"_$$CHARCHK^XOBVLIB(XOBRET(4))_"' serviceSection='"_$$CHARCHK^XOBVLIB(XOBRET(5))_"' language='"_$$CHARCHK^XOBVLIB(XOBRET(6))_"' timeout='"_$$CHARCHK^XOBVLIB(XOBRET(7))
 SET XOBMSG(2)=XOBMSG(2)_"' vpid='"_$$CHARCHK^XOBVLIB($G(XOBRET(8)))_"' />"
 SET XOBMSG(3)="<Division ien='"_$$CHARCHK^XOBVLIB($PIECE(XOBRET(3),U))_"' divName='"_$$CHARCHK^XOBVLIB($PIECE(XOBRET(3),U,2))_"' divNumber='"_$$CHARCHK^XOBVLIB($PIECE(XOBRET(3),U,3))_"' />"
 SET XOBMSG(4)="<SiteInfo domainName='"_$$KSP^XUPARAM("WHERE")_"'/>"
 DO SENDSEC^XOBSCAV(.XOBR,$PIECE($TEXT(RESTYPE^XOBSCAV),";;",2),$PIECE($TEXT(MSGUSERD^XOBSCAV),";;",2),.XOBMSG,$$SUCCESS^XOBSCAV(),$PIECE($TEXT(SCHUSERD^XOBSCAV),";;",2))
 QUIT
SENDDEM0(XOBTEXT) ; failure
 NEW XOBMSG
 SET XOBMSG(1)="<"_$PIECE($TEXT(MSGTAG^XOBSCAV),";;",2)_">"_$$CHARCHK^XOBVLIB(XOBTEXT)_"</"_$PIECE($TEXT(MSGTAG^XOBSCAV),";;",2)_">"
 DO SENDSEC^XOBSCAV(.XOBR,$PIECE($TEXT(RESTYPE^XOBSCAV),";;",2),$PIECE($TEXT(MSGUSERD^XOBSCAV),";;",2),.XOBMSG,$$FAILURE^XOBSCAV(),$PIECE($TEXT(SCHSIMPL^XOBSCAV),";;",2))
 QUIT
 ;
 ; ==== SAX Parser Callbacks ====
 ; 
ELEST(ELE,ATR) ; -- element start event handler
 ;
 IF ELE="VistaLink" DO  QUIT
 . SET XOBDATA("MODE")=$GET(ATR("mode"),"singleton")
 . SET XOBDATA("XOB SECAV","SECURITYTYPE")=$GET(ATR("messageType"),"unknown")
 ;
 IF ELE="SecurityInfo" DO  QUIT
 . SET XOBDATA("XOB SECAV","SECURITYVERSION")=$GET(ATR("version"),"unknown")
 ;
 IF ELE="Request" DO  QUIT
 . SET XOBDATA("XOB SECAV","SECURITYACTION")=$GET(ATR("type"),"unknown")
 . ; get ip from msg if provided
 . IF "AV.SetupAndIntroText"=XOBDATA("XOB SECAV","SECURITYACTION") DO
 . . SET XOBDATA("CLIENTIP")=$GET(ATR("clientIp"))
 ;
 IF XOBDATA("XOB SECAV","SECURITYTYPE")'=$$MSGTYP^XOBSCAV("request") DO  QUIT
 .;if not a security request, shouldn't be here
 .;
 IF '$DATA(XOBDATA("XOB SECAV","SECURITYACTION")) DO  QUIT
 .;if haven't processed the "action" yet, shouldn't be here
 ;
 IF XOBDATA("XOB SECAV","SECURITYACTION")="AV.SetupAndIntroText" DO  QUIT
 . IF ELE="productionInfo" DO
 . . SET XOBDATA("CLIENTISPRODUCTION")=$GET(ATR("clientIsProduction"))
 . . SET XOBDATA("CLIENTPRIMARYSTATION")=$GET(ATR("clientPrimaryStation"))
 ;
 IF XOBDATA("XOB SECAV","SECURITYACTION")="AV.GetUserDemographics" DO  QUIT
 .; nothing needed
 .; 
 IF XOBDATA("XOB SECAV","SECURITYACTION")="AV.Logon" DO  QUIT
 .IF ELE="avCodes" SET XOBAVCOD=""
 .SET XOBDATA("XOB SECAV","REQUESTCVC")=$GET(ATR("requestCvc"))
 ;
 IF XOBDATA("XOB SECAV","SECURITYACTION")="AV.Logout" DO  QUIT
 .; nothing needed
 ;
 IF XOBDATA("XOB SECAV","SECURITYACTION")="AV.SelectDivision" DO  QUIT
 .IF ELE="Division" SET XOBDATA("XOB SECAV","SELECTEDDIVISION")=$GET(ATR("ien"))
 ;
 IF XOBDATA("XOB SECAV","SECURITYACTION")="AV.UpdateVC" DO  QUIT
 .IF ELE="oldVc" SET XOBVCOLD="" QUIT
 .IF ELE="newVc" SET XOBVCNEW="" QUIT
 .IF ELE="confirmedVc" SET XOBVCCHK="" QUIT
 ;
 ;If got here -- an unknown type, ignore.
 ;
 QUIT
 ;
ELEND(ELE) ; -- element end event handler
 ;
 IF ELE="VistaLink" KILL XOBAVCOD,XOBVCOLD,XOBVCNEW,XOBVCCHK QUIT
 IF $GET(XOBDATA("XOB SECAV","SECURITYACTION"))="AV.Logon",ELE="avCodes" DO  QUIT
 .SET XOBDATA("XOB SECAV","AVCODE")=XOBAVCOD KILL XOBAVCOD
 IF $GET(XOBDATA("XOB SECAV","SECURITYACTION"))="AV.UpdateVC" DO  QUIT
 .IF ELE="oldVc" SET XOBDATA("XOB SECAV","OLDVC")=XOBVCOLD KILL XOBVCOLD QUIT
 .IF ELE="newVc" SET XOBDATA("XOB SECAV","NEWVC")=XOBVCNEW KILL XOBVCNEW QUIT
 .IF ELE="confirmedVc" SET XOBDATA("XOB SECAV","NEWVCCHECK")=XOBVCCHK KILL XOBVCCHK QUIT
 .;shouldn't get here.
 QUIT
 ;
CHR(TEXT) ; -- character value event handler <tag>TEXT</tag)
 ; -- need to concatenate because MXML parses on ENTITY characters (<>& etc.) and
 ;    callback gets hit multiple times even though the tag text value is just one piece of data.
 ;    (Yes, this seems kludgie!)
 IF $DATA(XOBAVCOD) SET XOBAVCOD=XOBAVCOD_TEXT QUIT
 IF $DATA(XOBVCOLD) SET XOBVCOLD=XOBVCOLD_TEXT QUIT
 IF $DATA(XOBVCNEW) SET XOBVCNEW=XOBVCNEW_TEXT QUIT
 IF $DATA(XOBVCCHK) SET XOBVCCHK=XOBVCCHK_TEXT QUIT
 QUIT
  ;==== AV.UpdateVC.Request message processing ====
SENDNVC ; respond to "change verify code" request. Use of CVC^XUSRB per DBIA #4054
 NEW XOBRET,XOBRETDV,XOBSDUZ
 SET XOBSDUZ=DUZ ; save DUZ in case of failure - we need to restore
 DO CVC^XUSRB(.XOBRET,XOBDATA("XOB SECAV","OLDVC")_U_XOBDATA("XOB SECAV","NEWVC")_U_XOBDATA("XOB SECAV","NEWVCCHECK"))
 KILL XOBDATA("XOB SECAV","OLDVC"),XOBDATA("XOB SECAV","NEWVC"),XOBDATA("XOB SECAV","NEWVCCHECK")
 IF +$GET(DUZ) DO  QUIT  ; success changing verify code
 .; check the divisions now
 .DO DIVGET^XUSRB2(.XOBRETDV,DUZ) ; use of DIVGET^XUSRB2: DBIA #4055
 .IF '+XOBRETDV(0) DO SENDNVC1 QUIT
 .; otherwise this is a multidivisional user
 .DO SENDNVCD(.XOBRETDV)
 ; cvc failed
 SET DUZ=XOBSDUZ ; restore DUZ
 DO SENDNVC0 ; failure
 QUIT
SENDNVC1 ; send verify code update success
 ;update the vc/finish the logon
 NEW XOBMSG
 DO SENDSEC^XOBSCAV(.XOBR,$PIECE($TEXT(RESTYPE^XOBSCAV),";;",2),$PIECE($TEXT(MSGUPDVC^XOBSCAV),";;",2),.XOBMSG,$$SUCCESS^XOBSCAV(),$PIECE($TEXT(SCHSIMPL^XOBSCAV),";;",2))
 QUIT
SENDNVC0 ; send verify code update error
 ;update the vc/finish the logon
 NEW XOBMSG,XOBI
 SET XOBMSG(1)="<"_$PIECE($TEXT(MSGTAG^XOBSCAV),";;",2)_">"_$$CHARCHK^XOBVLIB($GET(XOBRET(1)))_"</"_$PIECE($TEXT(MSGTAG^XOBSCAV),";;",2)_">"
 DO SENDSEC^XOBSCAV(.XOBR,$PIECE($TEXT(RESTYPE^XOBSCAV),";;",2),$PIECE($TEXT(MSGUPDVC^XOBSCAV),";;",2),.XOBMSG,$$FAILURE^XOBSCAV(),$PIECE($TEXT(SCHSIMPL^XOBSCAV),";;",2))
 QUIT
SENDNVCD(XOBDIVS) ; send verify code partial success, need divisions
 ;XOBDIVS is in format of output from DIVGET^XUSRB2
 NEW XOBMSG,XOBI,XOBLINE
 SET XOBLINE=$$ADDDIVS^XOBSCAV(.XOBDIVS,.XOBMSG)
 DO SENDSEC^XOBSCAV(.XOBR,$PIECE($TEXT(RESTYPE^XOBSCAV),";;",2),$PIECE($TEXT(MSGUPDVC^XOBSCAV),";;",2),.XOBMSG,$$PARTIAL^XOBSCAV(),$PIECE($TEXT(SCHPARTS^XOBSCAV),";;",2))
 QUIT
 ;
 ;==== utility functions ====
 ;
GETINTRO(XOBSREF,XOBSCNTR) ;
 ; XOBSREF: variable in which to store intro text (at one level descendant)
 ; XOBSCNT: integer subscript counter value at which to start storing text
 ; returns: XOBSREF containing <IntroText> element text with intro text lines in CDATA section
 ;          XOBSCNT incremented to last subscript at which text was stored (if passed as dot-arg)
 ; 
 NEW XOBCCMSK,XOBI,XOBITINF,XOBTMP1
 ; get intro text
 DO INTRO^XUSRB(.XOBITINF) ; use of INTRO^XUSRB: DBIA #4054
 ; set up control character mask
 SET XOBCCMSK="" FOR XOBI=0:1:8,11,12,14:1:31 SET XOBCCMSK=XOBCCMSK_$CHAR(XOBI)
 ; populate/format return value
 SET @XOBSREF@(XOBSCNTR)="<IntroText><![CDATA["
 SET XOBTMP1=-1 FOR  SET XOBTMP1=$ORDER(XOBITINF(XOBTMP1)) QUIT:XOBTMP1']""  DO
 .SET XOBSCNTR=XOBSCNTR+1,@XOBSREF@(XOBSCNTR)=$TRANSLATE(XOBITINF(XOBTMP1),XOBCCMSK,"")_"<BR>"
 SET XOBSCNTR=XOBSCNTR+1,@XOBSREF@(XOBSCNTR)="]]></IntroText>"
 QUIT
 ;
