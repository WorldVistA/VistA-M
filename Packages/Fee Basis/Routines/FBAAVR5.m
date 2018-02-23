FBAAVR5 ;WOIFO/SAB - GENERATE VOUCHER BATCH MSG ;9/12/2012
 ;;3.5;FEE BASIS;**132,158**;JAN 30, 1995;Build 94
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; ICRs
 ;  #2053  FILE^DIE
 ;  #2054  CLEAN^DILF
 ;  #2056  $$GET1^DIQ
 ;  #2729  SENDMSG^XMXAPI
 ;  #10104 $$LG^XLFSTR, $$RJ^XLFSTR
 Q
 ;
VBMSG(FBN) ; Generate Voucher Batch Message
 ; input
 ;   FBN - Batch IEN (file 161.7)
 ; returns value
 ;   =message number if successful
 ;   =0^error message if unsuccessful
 ;
 N FBAUS,FBCNT,FBHD,FBLN,FBNUM,FBRET,FBSTUB,FBTYPE
 K ^TMP($J,"FBVBM")
 ;
 ; check for required input
 I '$G(FBN) S FBRET="0^Batch IEN not provided." G END
 ;
 ; retrieve batch data
 S FBNUM=$$GET1^DIQ(161.7,FBN_",",.01) ; NUMBER
 I $D(DIERR) S FBRET="0^Error getting batch data." G END
 S FBTYPE=$$GET1^DIQ(161.7,FBN_",",2,"I") ; TYPE
 I "^B2^B3^B5^B9^"'[("^"_FBTYPE_"^") S FBRET="0^Invalid batch type" G END
 ;
 ; determine subsystem identifier
 D HD^FBAAUTL
 I $G(FBHD)="" S FBRET="0^Error obtaining Subsystem Identifier." G END
 ;
 ; determine string values to transmit
 S FBAUS("SN")=$$LJ^XLFSTR($$STANUM(FBN),6) ; station number
 S FBAUS("DT")=$$AUSDT^FBAAV3(DT) ; date
 S FBAUS("PT")=$S(FBTYPE="B2":"T",1:$E(FBTYPE,2)) ; payment type
 ;
 S FBCNT=0 ; init reject line count
 ;
 ; determine stub string for voucher batch reject line
 S FBSTUB=FBAUS("SN")_FBAUS("DT")_"V"_FBAUS("PT")
 ;
 ; loop thru line items rejected from batch
 I FBTYPE="B2" D
 . N FBIEN,FBIENS
 . S FBIEN(1)=0
 . F  S FBIEN(1)=$O(^FBAAC("AG",FBN,FBIEN(1))) Q:'FBIEN(1)  D
 . . S FBIEN=0
 . . F  S FBIEN=$O(^FBAAC("AG",FBN,FBIEN(1),FBIEN)) Q:'FBIEN  D
 . . . S FBIENS=FBIEN_","_FBIEN(1)_","
 . . . Q:$$GET1^DIQ(162.04,FBIENS,6.3,"I")=1  ; skip interface rej.
 . . . S FBPICN=FBIEN(1)_"^"_FBIEN
 . . . S FBPICN=$$ORGICN(162.04,FBPICN) ; send original ICN
 . . . D ADDLN
 ;
 I FBTYPE="B3" D
 . N FBIEN,FBIENS,FBPICN
 . S FBIEN(3)=0
 . F  S FBIEN(3)=$O(^FBAAC("AH",FBN,FBIEN(3))) Q:'FBIEN(3)  D
 . . S FBIEN(2)=0
 . . F  S FBIEN(2)=$O(^FBAAC("AH",FBN,FBIEN(3),FBIEN(2))) Q:'FBIEN(2)  D
 . . . S FBIEN(1)=0
 . . . F  S FBIEN(1)=$O(^FBAAC("AH",FBN,FBIEN(3),FBIEN(2),FBIEN(1))) Q:'FBIEN(1)  D
 . . . . S FBIEN=0
 . . . . F  S FBIEN=$O(^FBAAC("AH",FBN,FBIEN(3),FBIEN(2),FBIEN(1),FBIEN)) Q:'FBIEN  D
 . . . . . S FBIENS=FBIEN_","_FBIEN(1)_","_FBIEN(2)_","_FBIEN(3)_","
 . . . . . Q:$$GET1^DIQ(162.03,FBIENS,21.3,"I")=1  ; skip interface rej.
 . . . . . S FBPICN=FBIEN(3)_"^"_FBIEN(2)_"^"_FBIEN(1)_"^"_FBIEN
 . . . . . S FBPICN=$$ORGICN(162.03,FBPICN) ; send orignal ICN
 . . . . . D ADDLN
 ;
 I FBTYPE="B5" D
 . N FBIEN,FBIENS,FBPICN
 . S FBIEN(1)=0
 . F  S FBIEN(1)=$O(^FBAA(162.1,"AF",FBN,FBIEN(1))) Q:'FBIEN(1)  D
 . . S FBIEN=0
 . . F  S FBIEN=$O(^FBAA(162.1,"AF",FBN,FBIEN(1),FBIEN)) Q:'FBIEN  D
 . . . S FBIENS=FBIEN_","_FBIEN(1)_","
 . . . Q:$$GET1^DIQ(162.11,FBIENS,19.3,"I")=1  ; skip interface rej.
 . . . S FBPICN=FBIEN(1)_"^"_FBIEN
 . . . D ADDLN
 ;
 I FBTYPE="B9" D
 . N FBIEN,FBIENS,FBPICN
 . S FBIEN=0
 . F  S FBIEN=$O(^FBAAI("AH",FBN,FBIEN)) Q:'FBIEN  D
 . . S FBIENS=FBIEN_","
 . . Q:$$GET1^DIQ(162.5,FBIENS,15.3,"I")=1  ; skip interface rej.
 . . S FBPICN=FBIEN
 . . D ADDLN
 ;
 ; build message header line - FB*3.5*158
 S ^TMP($J,"FBVBM",1)=FBHD_"V"_FBAUS("PT")_FBAUS("DT")_FBAUS("SN")_$$RJ^XLFSTR(FBNUM,7,"0")_$$RJ^XLFSTR(FBCNT,3,"0")_"$"
 ;
 ; address and send message
 D
 . N FBINSTR,XMDUZ,XMERR,XMSUBJ,XMY,XMZ
 . S XMSUBJ="FEE BASIS VOUCHER MESSAGE BATCH "_FBNUM
 . S FBINSTR("ADDR FLAGS")="R"
 . D RECIP
 . D SENDMSG^XMXAPI(XMDUZ,XMSUBJ,"^TMP("_$J_",""FBVBM"")",.XMY,.FBINSTR,.XMZ)
 . I $G(XMERR) S FBRET="0^Error generating mail message"
 . I '$G(XMERR) S FBRET=XMZ
 ;
 ; if message created update batch
 I FBRET D
 . N DIERR,FBFDA,FBX
 . S FBFDA(161.7,FBN_",",21)=DT ; VOUCHER MSG DATE
 . S FBFDA(161.7,FBN_",",22)="P" ; VOUCHER MSG ACK STATUS
 . D FILE^DIE("","FBFDA")
 . D CLEAN^DILF
 ;
END ;
 K ^TMP($J,"FBVBM")
 Q FBRET
 ;
ADDLN ; add detail line
 S FBCNT=FBCNT+1
 S ^TMP($J,"FBVBM",FBCNT+1)=FBSTUB_$$RJ^XLFSTR(FBPICN,30,"0")_"$"
 Q
 ;
STANUM(FBN) ; determine station number to transmit
 ;
 N FBRET,FBX,FBY0
 S FBRET=""
 ;
 ; determine station number based on obligation of batch
 I $G(FBN) D
 . S FBY0=$G(^FBAA(161.7,FBN,0))
 . S FBX=$$SUB^FBAAUTL5(+$P(FBY0,U,8)_"-"_$P(FBY0,U,2))
 . I FBX]"" S FBRET=FBX
 ;
 ; if station number not found use default station number
 I FBRET="" D
 . S FBX=$P($G(^FBAA(161.4,1,1)),"^",3)
 . S:FBX FBRET=$$STA^XUAF4(FBX)
 ;
 Q FBRET
 ;
RECIP ; determine message recipients
 ; input
 ;  DUZ
 ; output
 ;  XMDUZ
 ;  XMY(
 N FBXMFEE,FBXMNVP
 S XMDUZ=DUZ
 ;
 ; get recipients from TRANSMISISON ROUTERS files
 D
 . N FBI,FBVAR,VAT,VATERR,VATNAME
 . D ADDRESS^FBAAV01
 ;
 ; set XMY array and XMDUZ
 D
 . N FBFLAG,FBI,XMD,XMLOC,XMMG,XMN,X,Y
 . D ROUT^FBAAV01
 Q
 ;
ORGICN(FBFILE,FBICN) ; return original ICN value for a line item
 ; input
 ;   FBFILE - sub-file (162.03 or 162.04)
 ;   FBICN  - ICN value
 ; return value = the original ICN value
 ;
 N FBRET
 S FBRET=$G(FBICN)
 ;
 I "^162.03^162.04^"[("^"_$G(FBFILE)_"^"),$G(FBICN)'="" D
 . N FBCIENS,FBOIENS,FBSIENS
 . ; determine starting IEN string
 . I FBFILE=162.03 S FBSIENS=$P(FBICN,"^",4)_","_$P(FBICN,"^",3)_","_$P(FBICN,"^",2)_","_$P(FBICN,"^",1)_","
 . I FBFILE=162.04 S FBSIENS=$P(FBICN,"^",2)_","_$P(FBICN,"^",1)_","
 . ;
 . S FBCIENS=FBSIENS ; init current IEN string as starting IEN string
 . ;
 . ;loop thru moves for current IENs until no more moves are found
 . F  D  Q:FBOIENS=""
 . . N FBDA
 . . S FBOIENS="" ; init old IENs value for a move
 . . S FBDA=$O(^FBAA(161.45,"AN",FBFILE,FBCIENS,0))
 . . Q:'FBDA  ; no more moves
 . . S FBOIENS=$P($G(^FBAA(161.45,FBDA,0)),U,2) ; old IENs
 . . ; if old IEN is same as starting IEN, break out of the endless loop
 . . I FBOIENS=FBSIENS S FBOIENS="" Q
 . . ; set current IENs to the new value
 . . S:FBOIENS'="" FBCIENS=FBOIENS
 . ;
 . ; if current IENs is different from starting IENs update outputs
 . I FBCIENS'=FBSIENS D
 . . I FBFILE=162.03 S FBRET=$P(FBCIENS,",",4)_"^"_$P(FBCIENS,",",3)_"^"_$P(FBCIENS,",",2)_"^"_$P(FBCIENS,",",1)
 . . I FBFILE=162.04 S FBRET=$P(FBCIENS,",",2)_"^"_$P(FBCIENS,",",1)
 ;
 Q FBRET
 ;
 ;FBAAVR5
