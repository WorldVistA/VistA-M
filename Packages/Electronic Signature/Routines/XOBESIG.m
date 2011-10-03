XOBESIG ;Oakland/mko-ELECTRONIC SIGNATURE CODES ;9:29 AM  14 Jul 2006
 ;;1.0;Electronic Signature;;Jul 14, 2006
 ;;Foundations Electronic Signature Release v1.0 [Build: 1.0.0.024]
 ;
ISDEF(RESULT) ; -- Returns whether the user has an Electronic Signature Code defined.
 ; Returns:
 ;   0 : if the user has no esig defined
 ;   1 : if the user does have an esig defined
 ;  -2 : if DUZ doesn't refer to a valid user
 ;
 ; Remote Procedure: XOBE ESIG IS DEFINED
 ;
 NEW XOBESIG,XOBEMSG,DIERR
 KILL RESULT
 ;
 ; -- Get current esig
 SET XOBESIG=$$GET1^DIQ(200,+$GET(DUZ)_",",20.4,"I","","XOBEMSG")
 ;
 ; -- Check result
 IF $GET(DIERR),$DATA(XOBEMSG("DIERR","E",601)) SET RESULT=-2
 ELSE  IF XOBESIG]"" SET RESULT=1
 ELSE  SET RESULT=0
 QUIT
 ;
GETCODE(RESULT) ; -- Get user's Electronic Signature Code
 ; Return:
 ;   Electronic signature code
 ;   -2 : if DUZ doesn't refer to a valid user
 ;
 ; Remote Procedure: XOBE ESIG GET CODE
 ;
 NEW XOBESIG,XOBEMSG,DIERR
 KILL RESULT
 ;
 ; -- Get current esig
 SET XOBESIG=$$GET1^DIQ(200,+$GET(DUZ)_",",20.4,"I","","XOBEMSG")
 ;
 ; -- Return result
 IF $GET(DIERR),$DATA(XOBEMSG("DIERR","E",601)) SET RESULT=-2
 ELSE  IF XOBESIG="" SET RESULT=""
 ELSE  SET RESULT=$$ENCRYP^XUSRB1(XOBESIG)
 QUIT
 ;
SETCODE(RESULT,XOBESIG) ; -- Save user's Electronic Signature Code
 ; Return:
 ;   1 : if new ESig was correctly filed
 ;   0 : if new ESig code is not valid
 ;  -1 : if new ESig is the same as the old one
 ;  -2 : if DUZ doesn't refer to a valid user
 ;
 ; Remote Procedure: XOBE ESIG SET CODE
 ;
 NEW X,XOBEIENS,XOBEOLD,XOBEFDA,XOBEMSG,DIERR
 KILL RESULT
 ;
 ; -- Get the old esig code
 SET XOBEIENS=+$GET(DUZ)_","
 SET XOBEOLD=$$GET1^DIQ(200,XOBEIENS,20.4,"I","","XOBEMSG")
 IF $GET(DIERR) DO  QUIT
 . IF $DATA(XOBEMSG("DIERR","E",601)) SET RESULT=-2
 . ELSE  SET RESULT=0
 ;
 ; -- Validate format of new esig
 IF $GET(XOBESIG)="" SET RESULT=0 QUIT
 SET X=$$DECRYP^XUSRB1(XOBESIG)
 IF X'?.UNP!($LENGTH(X)>20)!($LENGTH(X)<6) SET RESULT=0 QUIT
 ;
 ; -- Make sure old and new are different
 DO HASH^XUSHSHP
 IF X=XOBEOLD SET RESULT=-1 QUIT
 ;
 ; -- Save the new code
 SET XOBEFDA(200,XOBEIENS,20.4)=X
 DO FILE^DIE("","XOBEFDA","XOBEMSG")
 IF $GET(DIERR) SET RESULT=0 QUIT
 ;
 SET RESULT=1
 QUIT
 ;
GETDATA(RESULT) ; -- Return electronic signature block-related data
 ; Return:
 ;   Electronic signature block-related data
 ;   -2 : if DUZ doesn't refer to a valid user
 ;
 ; Remote Procedure: XOBE ESIG GET DATA
 ;
 NEW XOBEIENS,XOBEFLDS,XOBETARG,XOBEMSG,DIERR
 KILL RESULT
 ;
 ; -- Setup input variables to GETS^DIQ call
 SET XOBEIENS=+$GET(DUZ)_","
 SET XOBEFLDS="1;20.2;20.3;.132;.137;.138"
 ;
 ; -- Get data
 DO GETS^DIQ(200,XOBEIENS,XOBEFLDS,"I","XOBETARG","XOBEMSG")
 IF $GET(DIERR) DO  QUIT
 . IF $DATA(XOBEMSG("DIERR","E",601)) SET RESULT=-2
 . ELSE  SET RESULT=""
 ;
 ; -- Put data into RESULT array
 SET RESULT(1)=$$VALUE($GET(XOBETARG(200,XOBEIENS,1,"I"))) ;initial
 SET RESULT(2)=$$VALUE($GET(XOBETARG(200,XOBEIENS,20.2,"I"))) ;sig blk printed name
 SET RESULT(3)=$$VALUE($GET(XOBETARG(200,XOBEIENS,20.3,"I"))) ;sig blk title
 SET RESULT(4)=$$VALUE($GET(XOBETARG(200,XOBEIENS,.132,"I"))) ;office phone
 SET RESULT(5)=$$VALUE($GET(XOBETARG(200,XOBEIENS,.137,"I"))) ;voice pager
 SET RESULT(6)=$$VALUE($GET(XOBETARG(200,XOBEIENS,.138,"I"))) ;digital pager
 QUIT
 ;
VALUE(X) ; -- Return X or if X is "", return @
 QUIT $SELECT($GET(X)="":"@",1:X)
 ;
SETDATA(RESULT,XOBEVALS) ; -- Save electronic signature block-related data
 ; Return:
 ;            1 : if successfully filed
 ;           -2 : if DUZ doesn't refer to a valid user
 ;   error text : if Filer call failed
 ;
 ; Remote Procedure: XOBE ESIG SET DATA
 ;
 NEW XOBEFDA,DIERR,XOBEMSG,XOBEIENS
 KILL RESULT
 SET XOBEIENS=+$GET(DUZ)_","
 ;
 ; -- Setup up FDA for FILE^DIE call
 SET XOBEFDA(200,XOBEIENS,1)=$GET(XOBEVALS("initial"))
 SET XOBEFDA(200,XOBEIENS,20.2)=$GET(XOBEVALS("signature block printed name"))
 SET XOBEFDA(200,XOBEIENS,20.3)=$GET(XOBEVALS("signature block title"))
 SET XOBEFDA(200,XOBEIENS,.132)=$GET(XOBEVALS("office phone"))
 SET XOBEFDA(200,XOBEIENS,.137)=$GET(XOBEVALS("voice pager"))
 SET XOBEFDA(200,XOBEIENS,.138)=$GET(XOBEVALS("digital pager"))
 ;
 ; -- File the data
 DO FILE^DIE("ET","XOBEFDA","XOBEMSG")
 ;
 ; -- Handle errors
 IF $GET(DIERR) DO  QUIT
 . ; -- Entry not found error
 . IF $DATA(XOBEMSG("DIERR","E",601)) SET RESULT(1)=-2 QUIT
 . ;
 . ; -- Put error message into RESULT array
 . NEW ERR,LN
 . SET ERR=0 FOR  SET ERR=$ORDER(XOBEMSG("DIERR",ERR)) QUIT:'ERR  DO
 .. DO ADDTEXT("Error #"_XOBEMSG("DIERR",ERR),.RESULT)
 .. DO ADDTEXT("--------------",.RESULT)
 .. SET LN=0 FOR  SET LN=$ORDER(XOBEMSG("DIERR",ERR,"TEXT",LN)) QUIT:'LN  DO
 ... DO ADDTEXT(XOBEMSG("DIERR",ERR,"TEXT",LN),.RESULT)
 .. ;
 .. ; -- If the error returned is 701 (invalid input),
 .. ; -- put the ? help for the field into the RESULT array
 .. IF XOBEMSG("DIERR",ERR)=701 DO ADDHELP(.XOBEMSG,ERR,.RESULT)
 ;
 ; -- Values were successfully saved
 SET RESULT(1)=1
 QUIT
 ;
ADDHELP(XOBEMSG,ERR,RESULT) ;
 NEW FILE,IENS,FIELD,LINE,MSG,DIERR,DIHELP
 ;
 ; -- Get file/field information from the XOBEMSG array
 SET FILE=$GET(XOBEMSG("DIERR",ERR,"PARAM","FILE"))
 SET IENS=$GET(XOBEMSG("DIERR",ERR,"PARAM","IENS"))
 SET FIELD=$GET(XOBEMSG("DIERR",ERR,"PARAM","FIELD"))
 ;
 ; -- Get the ? help for the field
 DO HELP^DIE(FILE,IENS,FIELD,"?","MSG")
 ;
 ; -- Add the ? help to the RESULT array
 SET LINE=0 FOR  SET LINE=$ORDER(MSG("DIHELP",LINE)) Q:'LINE  DO
 . DO ADDTEXT(MSG("DIHELP",LINE),.RESULT)
 DO ADDTEXT("",.RESULT)
 QUIT
 ;
ADDTEXT(TEXT,RESULT) ;Add TEXT to RESULT array
 NEW NODE
 SET NODE=$ORDER(RESULT(" "),-1)+1
 SET RESULT(NODE)=$GET(TEXT)
 QUIT
 ;
VALIDATE(RESULT,XOBESIG) ; -- Return whether passed ESig is valid
 ; Return:
 ;   1 if ESig is valid
 ;   0 if ESig is invalid
 ;  -1 if ESig is null
 ;  -2 if DUZ doesn't refer to a valid user
 ; This entry point is not currently used.
 ;
 NEW X,XOBECURR,XOBEIENS,XOBEMSG,DIERR
 KILL RESULT
 ;
 ; -- Get esig from New Person file
 SET XOBEIENS=+$GET(DUZ)_","
 SET XOBECURR=$$GET1^DIQ(200,XOBEIENS,20.4,"I","","XOBEMSG")
 ;
 ; -- Check that DUZ refers to a valid user
 IF $GET(DIERR),$DATA(XOBEMSG("DIERR","E",601)) SET RESULT=-2 QUIT
 ;
 ; -- Check for null esig
 IF XOBECURR="" SET RESULT=-1 QUIT
 ;
 ; -- Check whether old matches value passed in
 SET X=$$DECRYP^XUSRB1(XOBESIG)
 DO HASH^XUSHSHP
 SET RESULT=X=XOBECURR
 QUIT
