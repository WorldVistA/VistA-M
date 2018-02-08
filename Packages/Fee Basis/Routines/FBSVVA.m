FBSVVA ;ISW/SAB - VOUCHER BATCH ACKNOWLEDGEMENT MESSAGE SERVER ;4/23/2012
 ;;3.5;FEE BASIS;**131,132,158**;JAN 30, 1995;Build 94
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This routine is called by a server option to process the
 ; Payment Batch Result message sent by Central Fee.
 ;
 ; ICRs
 ;  #2053  FILE^DIE
 ;  #2054  CLEAN^DILF
 ;  #2056  $$GET1^DIQ
 ;  #10069 XMB
 ;  #10072 REMSBMSG^XMA1C
 ;  #10096 ^%ZOSF("ERRTN" ), ^%ZOSF("TRAP")
 ;  #10103 $$FMTE^XLFDT, $$NOW^XLFDT
 ;  #10104 $$TRIM^XLFSTR
 ;
 ; init
 N FBERR,FBHDR,FBHL,FBN,FBSN,FBSTAT,FBTYPE,X,XMER,XMRG,FBNEW
 S FBERR=0
 ;
 ; switch to a Fee Basis server error trap
 S X="TRAP^FBMRASV2" S @^%ZOSF("TRAP")
 ;
HDR ; process header line
 X XMREC
 I XMER<0 D ERR("Error reading header line.")
 I FBERR G END
 I $E(XMRG,2,4)="FEV" G HDR ; skip initial line if just envelope data
 ;
 I $L(XMRG)'=25,$L(XMRG)'=26 D ERR("Header line has incorrect length.")  ;FB*3.5*158
 I FBERR G END
 ;
 ; extract data from header line
 S FBHL(1)=$$TRIM^XLFSTR($E(XMRG,1,6),"R") ; station number
 S FBHL(2)=$E(XMRG,7,14) ; date YYYYMMDD
 S FBHL(3)=$E(XMRG,15) ; processing stage (A)
 S FBHL(4)=$E(XMRG,16) ; payment type (3, 5, 9, or T)
 ;FB*3.5*158
 S FBNEW=$S($L(XMRG)=25:0,1:1)
 ;
 I FBNEW D
 . S FBHL(5)=+$E(XMRG,17,23) ; batch number
 . S FBHL(6)=$E(XMRG,24,25) ; status (AA or AE)
 . S FBHL(7)=$E(XMRG,26) ; delimiter ($)
 E  D
 . S FBHL(5)=+$E(XMRG,17,22) ; batch number
 . S FBHL(6)=$E(XMRG,23,24) ; status (AA or AE)
 . S FBHL(7)=$E(XMRG,25) ; delimiter ($)
 ;
 ; validate header data
 I FBHL(3)'="A" D ERR("Processing stage ("_FBHL(3)_") is invalid.")
 I "^3^5^9^T^"'[("^"_FBHL(4)_"^") D ERR("Payment type ("_FBHL(4)_") is invalid.")
 I "^AA^AE^"'[("^"_FBHL(6)_"^") D ERR("Acknowledgement status ("_FBHL(6)_") is invalid.")
 I FBERR G END
 ;
 ; determine batch IEN
 S FBN=$O(^FBAA(161.7,"B",FBHL(5),0))
 I 'FBN D ERR("Could not locate record for batch "_FBHL(5)_".")
 I FBERR G END
 ;
 ; obtain batch data
 S FBTYPE=$$GET1^DIQ(161.7,FBN_",",2,"I") ; type (internal)
 S FBSTAT=$$GET1^DIQ(161.7,FBN_",",11,"I") ; status (internal)
 S FBSN=$$GET1^DIQ(161.7,FBN_",",16) ; station number (3 digit)
 ;
 ; verify batch values
 I FBHL(4)="T",FBTYPE'="B2" D ERR("Payment Type in message is not consistent with the batch type.")
 I FBHL(4),FBHL(4)'=$E(FBTYPE,2) D ERR("Payment Type in message is not consistent with the batch type.")
 I FBSN'=$E(FBHL(1),1,3) D ERR("Station number in message is not consistent with the batch station number.")
 I FBSTAT'="V" D ERR("Current batch status is not VOUCHERED.")
 I FBERR G END
 ;
 ; loop thru detail lines (errors and warnings) in message
 S FBHDR=1
 F  X XMREC Q:XMER<0!($E(XMRG,1,4)="NNNN")  I XMRG]"" D
 . N FBDL
 . ;
 . S FBDL(6)=$E(XMRG,$S(FBNEW:24,1:23),$S(FBNEW:24,1:23)) ; severity (E or W)
 . S FBDL(7)=$$TRIM^XLFSTR($E(XMRG,$S(FBNEW:25,1:24),$S(FBNEW:28,1:27))) ; message code
 . S FBDL(8)=$$TRIM^XLFSTR($E(XMRG,$S(FBNEW:29,1:28),$S(FBNEW:98,1:97))) ; message text
 . ;
 . I FBHDR D MSG("Messages from Central Fee follow") S FBHDR=0
 . D MSG(" ("_FBDL(6)_")  "_FBDL(8))
 ;
 ; update batch
 I FBN D
 . N DIERR,FBFDA,FBX
 . ; set VOUCHER MSG ACK STATUS to A or E
 . S FBFDA(161.7,FBN_",",22)=$S(FBHL(6)="AA":"A",1:"E")
 . D FILE^DIE("","FBFDA")
 . D CLEAN^DILF
 ;
END ;
 ; switch back to the standard Kernel error trap
 S X=^%ZOSF("ERRTN"),@^%ZOSF("TRAP")
 ;
 ; remove Central Fee message from server basket
 N XMSER,XMZ
 S XMSER="S."_XQSOP,XMZ=XQMSG D REMSBMSG^XMA1C
 ;
 I FBERR D
 . ; add text to bulletin
 . D ERR(" ")
 . D ERR("The above message # has been forwarded to the FEE mail group.")
 . ;
 . ; send bulletin
 . D SNDBUL^FBSVBR("for batch "_$G(FBHL(5))_" voucher ack.")
 . ;
 . ; forward served message to G.FEE
 . N XMDUZ,XMY,XMZ
 . S XMY("G.FEE")=""
 . S XMZ=XQMSG
 . D ENT1^XMD
 ;
 ; if no VistA error, but Central Fee sent a warning or error
 I 'FBERR,'FBHDR D
 . ; send bulletin
 . D SNDBUL^FBSVBR("for batch "_$G(FBHL(5))_" voucher ack.")
 ;
 K XQSTXT
 Q
 ;
ERR(FBTXT) ; set error flag and save text for inclusion in bulletin
 N FBL
 S FBERR=1
 S FBL=$P($G(XQSTXT(0)),"^",4)
 S FBL=FBL+1
 S XQSTXT(FBL)=$G(FBTXT)
 S $P(XQSTXT(0),"^",3,4)=FBL_"^"_FBL
 Q
 ;
MSG(FBTXT) ; set save text for inclusion in bulletin
 N FBL
 S FBL=$P($G(XQSTXT(0)),"^",4)
 S FBL=FBL+1
 S XQSTXT(FBL)=$G(FBTXT)
 S $P(XQSTXT(0),"^",3,4)=FBL_"^"_FBL
 Q
 ;
 ;FBSVVA
