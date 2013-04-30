FBSVPR ;ISW/SAB - PAYMENT BATCH RESULT MESSAGE SERVER ;3/23/2012
 ;;3.5;FEE BASIS;**131,132**;JAN 30, 1995;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine is called by a server option to process the
 ; Post Voucher Reject message sent by Central Fee.
 ;
 ; ICRs
 ;  #2056  $$GET1^DIQ
 ;  #10069 XMB
 ;  #10072 REMSBMSG^XMA1C
 ;  #10096 ^%ZOSF("ERRTN" ), ^%ZOSF("TRAP")
 ;  #10103 $$FMTE^XLFDT, $$NOW^XLFDT
 ;  #10104 $$TRIM^XLFSTR
 ;
 ; init
 N FBBATCH,FBERR,FBHL,FBTYPE,X,XMER,XMRG
 S FBERR=0
 ;
 ; switch to a Fee Basis server error trap
 S X="TRAP^FBMRASV2" S @^%ZOSF("TRAP")
 ;
HDR ; process header line
 X XMREC
 I XMER<0 D ERR("Error reading header line.")
 I FBERR G END
 I $E(XMRG,2,4)="FEP" G HDR ; skip initial line if just envelope data
 ;
 I $L(XMRG)'=17 D ERR("Header line has incorrect length.")
 I FBERR G END
 ;
 ; extract data from header line
 S FBHL(1)=$$TRIM^XLFSTR($E(XMRG,1,6),"R") ; station number
 S FBHL(2)=$E(XMRG,7,14) ; date YYYYMMDD
 S FBHL(3)=$E(XMRG,15) ; processing stage (P)
 S FBHL(4)=$E(XMRG,16) ; payment type (3, 5, 9, or T)
 S FBHL(5)=$E(XMRG,17) ; delimiter ($)
 ;
 ; validate header data
 I FBHL(3)'="P" D ERR("Processing stage ("_FBHL(3)_") is invalid.")
 I "^3^5^9^T^"'[("^"_FBHL(4)_"^") D ERR("Payment type ("_FBHL(4)_") is invalid.")
 I FBERR G END
 ;
 ; determine batch type
 I FBHL(4)="T" S FBTYPE="B2"
 I FBHL(4) S FBTYPE="B"_FBHL(4)
 ;
 ; process line rejects
 ; loop thru detail lines in message
 F  X XMREC Q:XMER<0!($E(XMRG,1,4)="NNNN")  I XMRG]"" D
 . N FBI,FBIEN,FBIENS,FBJ,FBN,FBRCA,FBX
 . ; determine the reject codes for the line item
 . S FBJ=0 ; init number of reject codes for line item
 . ; loop thru the five data elements that can hold a reject code
 . F FBI=1:1:5 D
 . . N FBP
 . . S FBP=47+((FBI-1)*4) ; calc data element starting position
 . . S FBX=$$TRIM^XLFSTR($E(XMRG,FBP,FBP+3))
 . . I FBX'="" S FBJ=FBJ+1,FBRCA(FBJ)=FBX ; add to array
 . ;
 . ; determine the IENs for the line item
 . S FBX=$E(XMRG,17,46) ; IEN string
 . I FBTYPE="B2" D
 . . S FBIEN(1)=+$P(FBX,U),FBIEN=+$P(FBX,U,2)
 . . ; if line item not found then check if moved
 . . I '$D(^FBAAC(FBIEN(1),3,FBIEN,0)) D
 . . . N FBPROG
 . . . S FBPROG="T"
 . . . D CHKMOVE^FBPAID1
 . . S FBIENS=FBIEN_","_FBIEN(1)_","
 . . S FBN=$$GET1^DIQ(162.04,FBIENS,1,"I") ; batch IEN
 . ;
 . I FBTYPE="B3" D
 . . S FBIEN(3)=+$P(FBX,U),FBIEN(2)=+$P(FBX,U,2)
 . . S FBIEN(1)=+$P(FBX,U,3),FBIEN=+$P(FBX,U,4)
 . . ; if line item not found then check if moved
 . . I '$D(^FBAAC(FBIEN(3),1,FBIEN(2),1,FBIEN(1),1,FBIEN,0)) D
 . . . N FBPROG
 . . . S FBPROG=3
 . . . D CHKMOVE^FBPAID1
 . . S FBIENS=FBIEN_","_FBIEN(1)_","_FBIEN(2)_","_FBIEN(3)_","
 . . S FBN=$$GET1^DIQ(162.03,FBIENS,7,"I") ; batch IEN
 . ;
 . I FBTYPE="B5" D
 . . S FBIEN(1)=+$P(FBX,U),FBIEN=+$P(FBX,U,2)
 . . S FBIENS=FBIEN_","_FBIEN(1)_","
 . . S FBN=$$GET1^DIQ(162.11,FBIENS,13,"I") ; batch IEN
 . ;
 . I FBTYPE="B9" D
 . . S FBIEN=+FBX
 . . S FBIENS=FBIEN_","
 . . S FBN=$$GET1^DIQ(162.5,FBIENS,20,"I") ; batch IEN
 . ;
 . ; call to reject the line item
 . D REJLN
 ;
 ; update obligation for rejected lines posted by batch (if any)
 I $O(FBBATCH(0)) D
 . N FBBAMT,FBN
 . ; loop thru batch
 . S FBN=0 F  S FBN=$O(FBBATCH(FBN)) Q:'FBN  D
 . . N FBX
 . . S FBBAMT=FBBATCH(FBN)
 . . Q:FBBAMT'>0
 . . S FBX=$$POSTBAT^FB1358(FBN,FBBAMT,"R",1)
 . . I 'FBX D
 . . . D ERR("Error posting to 1358 for batch")
 . . . D ERR("  "_$P(FBX,"^",2))
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
 . D SNDBUL^FBSVBR("for post voucher rejects")
 . ;
 . ; forward served message to G.FEE
 . N XMDUZ,XMY,XMZ
 . S XMY("G.FEE")=""
 . S XMZ=XQMSG
 . D ENT1^XMD
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
REJLN ; reject payment line item
 N FBX
 S FBX=1
 ;
 ; verify batch data (note: null batch value is handled by $$SETREJ)
 I FBN D
 . N FBNUM,FBSN,FBSTAT
 . ;
 . ; obtain batch data
 . S FBNUM=$$GET1^DIQ(161.7,FBN_",",.01) ; batch number
 . S FBSTAT=$$GET1^DIQ(161.7,FBN_",",11,"I") ; status (internal)
 . S FBSN=$$GET1^DIQ(161.7,FBN_",",16) ; station number (3 digit)
 . ;
 . ; verify batch values
 . I FBSN'=$E(FBHL(1),1,3) S FBX="0^Station number in message is not consistent with batch "_FBNUM_"." Q
 . I FBSTAT'="V" S FBX="0^Batch "_FBNUM_" status is not VOUCHERED." Q
 ;
 ; if batch OK then set reject flag for line
 I FBX S FBX=$$SETREJ^FBAAVR4(FBN,FBTYPE,FBIENS,1,,.FBRCA)
 ;
 ; if problem
 I 'FBX D
 . D ERR("Error rejecting line with IENS "_FBIENS)
 . D ERR("  "_$P(FBX,"^",2))
 ;
 ; if success
 I FBX D
 . N FBN,FBPBYINV
 . S FBN=$P(FBX,"^",2) ; batch IEN
 . ;
 . ; determine if 1358 posted by invoice or batch
 . S FBPBYINV=0
 . I FBTYPE="B9",$$GET1^DIQ(162.5,FBIENS,4,"I")'["FB583" S FBPBYINV=1
 . ;
 . ; if by batch then accumulate amount for later posting
 . I 'FBPBYINV S FBBATCH(FBN)=$G(FBBATCH(FBN))+$P(FBX,"^",3)
 . ;
 . ; if by B9 invoice then post it now
 . I FBPBYINV D
 . . N FBX1
 . . S FBX1=$$POSTINV^FB1358(FBN,+FBIENS,"R",1)
 . . I 'FBX1 D
 . . . D ERR("Error posting invoice "_+FBIENS_" to 1358")
 . . . D ERR("  "_$P(FBX,"^",2))
 Q
 ;
 ;FBSVPR
