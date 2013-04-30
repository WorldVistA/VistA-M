FBSVBR ;ISW/SAB - PAYMENT BATCH RESULT MESSAGE SERVER ;5/8/2012
 ;;3.5;FEE BASIS;**131,132**;JAN 30, 1995;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
 N FBBAMT,FBERR,FBHL,FBN,FBSN,FBSTAT,FBTYPE,X,XMER,XMRG
 S FBERR=0
 ;
 ; switch to a Fee Basis server error trap
 S X="TRAP^FBMRASV2" S @^%ZOSF("TRAP")
 ;
HDR ; process header line
 X XMREC
 I XMER<0 D ERR("Error reading header line.")
 I FBERR G END
 I $E(XMRG,2,4)="FEB" G HDR ; skip initial line if just envelope data
 ;
 I $L(XMRG)'=33 D ERR("Header line has incorrect length.")
 I FBERR G END
 ;
 ; extract data from header line
 S FBHL(1)=$$TRIM^XLFSTR($E(XMRG,1,6),"R") ; station number
 S FBHL(2)=$E(XMRG,7,14) ; date YYYYMMDD
 S FBHL(3)=$E(XMRG,15) ; processing stage (R)
 S FBHL(4)=$E(XMRG,16) ; payment type (3, 5, 9, or T)
 S FBHL(5)=+$E(XMRG,17,22) ; batch number
 S FBHL(6)=$$TRIM^XLFSTR($E(XMRG,23,26)) ; batch reject code
 S FBHL(7)=+$E(XMRG,27,29) ; number accepted
 S FBHL(8)=+$E(XMRG,30,32) ; number rejected
 S FBHL(9)=$E(XMRG,33) ; delimiter ($)
 ;
 ; validate header data
 I FBHL(3)'="R" D ERR("Processing stage ("_FBHL(3)_") is invalid.")
 I "^3^5^9^T^"'[("^"_FBHL(4)_"^") D ERR("Payment type ("_FBHL(4)_") is invalid.")
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
 I FBSTAT'="T" D ERR("Current batch status is not TRANSMITTED.")
 I FBERR G END
 ;
 S FBBAMT=0 ; init dollar amount for posting to 1358 by batch
 ;
 ; if batch reject code sent then reject entire batch
 I FBHL(6)'="" D
 . N FBIEN,FBIENS,FBRCA
 . S FBRCA(1)=FBHL(6) ; reject code array
 . ;
 . ; loop thru line items in batch
 . I FBTYPE="B2" D
 . . S FBIEN(1)=0
 . . F  S FBIEN(1)=$O(^FBAAC("AD",FBN,FBIEN(1))) Q:'FBIEN(1)  D
 . . . S FBIEN=0
 . . . F  S FBIEN=$O(^FBAAC("AD",FBN,FBIEN(1),FBIEN)) Q:'FBIEN  D
 . . . . S FBIENS=FBIEN_","_FBIEN(1)_","
 . . . . D REJLN
 . ;
 . I FBTYPE="B3" D
 . . S FBIEN(3)=0
 . . F  S FBIEN(3)=$O(^FBAAC("AC",FBN,FBIEN(3))) Q:'FBIEN(3)  D
 . . . S FBIEN(2)=0
 . . . F  S FBIEN(2)=$O(^FBAAC("AC",FBN,FBIEN(3),FBIEN(2))) Q:'FBIEN(2)  D
 . . . . S FBIEN(1)=0
 . . . . F  S FBIEN(1)=$O(^FBAAC("AC",FBN,FBIEN(3),FBIEN(2),FBIEN(1))) Q:'FBIEN(1)  D
 . . . . . S FBIEN=0
 . . . . . F  S FBIEN=$O(^FBAAC("AC",FBN,FBIEN(3),FBIEN(2),FBIEN(1),FBIEN)) Q:'FBIEN  D
 . . . . . . S FBIENS=FBIEN_","_FBIEN(1)_","_FBIEN(2)_","_FBIEN(3)_","
 . . . . . . D REJLN
 . ;
 . I FBTYPE="B5" D
 . . S FBIEN(1)=0
 . . F  S FBIEN(1)=$O(^FBAA(162.1,"AE",FBN,FBIEN(1))) Q:'FBIEN(1)  D
 . . . S FBIEN=0
 . . . F  S FBIEN=$O(^FBAA(162.1,"AE",FBN,FBIEN(1),FBIEN)) Q:'FBIEN  D
 . . . . S FBIENS=FBIEN_","_FBIEN(1)_","
 . . . . D REJLN
 . ;
 . I FBTYPE="B9" D
 . . S FBIEN=0
 . . F  S FBIEN=$O(^FBAAI("AC",FBN,FBIEN)) Q:'FBIEN  D
 . . . S FBIENS=FBIEN_","
 . . . D REJLN
 ;
 ; if batch reject code not sent then process line rejects (if any)
 I FBHL(6)="" D
 . ; loop thru detail lines in message
 . F  X XMREC Q:XMER<0!($E(XMRG,1,4)="NNNN")  I XMRG]"" D
 . . N FBI,FBJ,FBIEN,FBIENS,FBRCA,FBX
 . . ; determine the reject codes for the line item
 . . S FBJ=0 ; init number of reject codes for line item
 . . ; loop thru the five data elements that can hold a reject code
 . . F FBI=1:1:5 D
 . . . N FBP
 . . . S FBP=53+((FBI-1)*4) ; calc data element starting position
 . . . S FBX=$$TRIM^XLFSTR($E(XMRG,FBP,FBP+3))
 . . . I FBX'="" S FBJ=FBJ+1,FBRCA(FBJ)=FBX ; add to array
 . . ;
 . . ; determine the IENs for the line item
 . . S FBX=$E(XMRG,23,52) ; IEN string
 . . I FBTYPE="B2" D
 . . . S FBIEN(1)=+$P(FBX,U),FBIEN=+$P(FBX,U,2)
 . . . ; if line item not found then check if moved
 . . . I '$D(^FBAAC(FBIEN(1),3,FBIEN,0)) D
 . . . . N FBPROG
 . . . . S FBPROG="T"
 . . . . D CHKMOVE^FBPAID1
 . . . S FBIENS=FBIEN_","_FBIEN(1)_","
 . . ;
 . . I FBTYPE="B3" D
 . . . S FBIEN(3)=+$P(FBX,U),FBIEN(2)=+$P(FBX,U,2)
 . . . S FBIEN(1)=+$P(FBX,U,3),FBIEN=+$P(FBX,U,4)
 . . . ; if line item not found then check if moved
 . . . I '$D(^FBAAC(FBIEN(3),1,FBIEN(2),1,FBIEN(1),1,FBIEN,0)) D
 . . . . N FBPROG
 . . . . S FBPROG=3
 . . . . D CHKMOVE^FBPAID1
 . . . S FBIENS=FBIEN_","_FBIEN(1)_","_FBIEN(2)_","_FBIEN(3)_","
 . . ;
 . . I FBTYPE="B5" D
 . . . S FBIEN(1)=+$P(FBX,U),FBIEN=+$P(FBX,U,2)
 . . . S FBIENS=FBIEN_","_FBIEN(1)_","
 . . ;
 . . I FBTYPE="B9" D
 . . . S FBIEN=+FBX
 . . . S FBIENS=FBIEN_","
 . . ;
 . . ; call to reject the line item
 . . D REJLN
 ;
 ; update obligation for rejected lines posted by batch
 I FBBAMT>0 D
 . N FBX
 . S FBX=$$POSTBAT^FB1358(FBN,FBBAMT,"R",1)
 . I 'FBX D
 . . D ERR("Error posting to 1358 for batch")
 . . D ERR("  "_$P(FBX,"^",2))
 ;
 ; update batch status
 I FBN D
 . N DIERR,FBFDA,FBX
 . S FBX="F" ; init new status as Central Fee Accepted
 . ; if no lines remain in batch change new status to Vouchered
 . I FBTYPE="B2",'$O(^FBAAC("AD",FBN,0)) S FBX="V"
 . I FBTYPE="B3",'$O(^FBAAC("AC",FBN,0)) S FBX="V"
 . I FBTYPE="B5",'$O(^FBAA(162.1,"AE",FBN,0)) S FBX="V"
 . I FBTYPE="B9",'$O(^FBAAI("AC",FBN,0)) S FBX="V"
 . S FBFDA(161.7,FBN_",",11)=FBX
 . I FBX="V" D
 . . S FBFDA(161.7,FBN_",",13)=DT ; DATE FINALIZED
 . . S FBFDA(161.7,FBN_",",14)=DUZ ; PERSON WHO COMPLETED
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
 . D SNDBUL("for batch "_$G(FBHL(5))_" results")
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
 ; set reject flag
 S FBX=$$SETREJ^FBAAVR4(FBN,FBTYPE,FBIENS,1,,.FBRCA)
 ;
 ; if problem
 I 'FBX D
 . D ERR("Error rejecting line with IENS "_FBIENS)
 . D ERR("  "_$P(FBX,"^",2))
 ;
 ; if success
 I FBX D
 . N FBPBYINV
 . ; determine if 1358 posted by invoice or batch
 . S FBPBYINV=0
 . I FBTYPE="B9",$$GET1^DIQ(162.5,FBIENS,4,"I")'["FB583" S FBPBYINV=1
 . ;
 . ; if by batch then accumulate amount for later posting
 . I 'FBPBYINV S FBBAMT=FBBAMT+$P(FBX,"^",3)
 . ;
 . ; if by B9 invoice then post it now
 . I FBPBYINV D
 . . N FBX1
 . . S FBX1=$$POSTINV^FB1358(FBN,+FBIENS,"R",1)
 . . I 'FBX1 D
 . . . D ERR("Error posting invoice "_+FBIENS_" to 1358")
 . . . D ERR("  "_$P(FBX1,"^",2))
 Q
 ;
SNDBUL(FBSUB) ; send bulletin
 ;
 N XMB,XMBTMP,XMDF,XMDT,XMDUZ,XMTEXT,XMY,XMYBLOB
 S XMB="FBAA SERVER"
 S XMB(1)=$$FMTE^XLFDT($$NOW^XLFDT) ; date/time
 S XMB(2)=$G(XQSND) ; sender of message sent to server option
 S XMB(3)=$G(XQSOP) ; server option
 S XMB(4)=$G(XQSUB) ; subject of message sent to server option
 S XMB(5)=$G(XQMSG) ; number of message sent to server option
 S XMB(6)="An issue occurred that requires notification." ; comment
 S XMB(7)=$G(FBSUB) ; optional text for bulletin message subject
 S:$O(XQSTXT(0)) XMTEXT="XQSTXT(" ; additional text
 S XMY("G.FEE")=""
 S XMY("G.FEE FINANCE")=""
 D ^XMB
 Q
 ;FBSVBR
