VBECRPC ; HOIFO/BNT - VBECS Remote Procedure Utilities;Mar 23,2005
 ;;1.0;VBECS;;Apr 14, 2005;Build 35
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ; 
 ; Integration Agreements:
 ; Reference to $$GET1^DIQ supported by IA #2052
 ; Reference to $$CHARCHK^XOBVLIB supported by IA #4090
 ;
 QUIT
 ;
STRIPL(VBDATA) ;STRIP TRAILING SPACES
 F  Q:$E(VBDATA,$L(VBDATA))'=" "  S VBDATA=$E(VBDATA,1,$L(VBDATA)-1)
 Q VBDATA
STRIPL3(VBDATA)  ;STRIP LAST 3 CHARACTERS
 S VBDATA=$E(VBDATA,1,$L(VBDATA)-3)
 Q VBDATA
BEGROOT(X) ; Add beginning root element
 D ADD("<"_X_">")
 Q
 ;
ENDROOT(X) ; Add end root element
 D ADD("</"_X_">")
 Q
 ;
ADD(STR) ; Add XML to result global
 S VBECCNT=VBECCNT+1
 S @RESULTS@(VBECCNT)=STR
 Q
 ;
ERROR(STR) ; Return ERROR
 ;
 D BEGROOT("Error")
 D ADD("<Text>"_$$CHARCHK^XOBVLIB(STR)_"</Text>")
 D ENDROOT("Error")
 Q
 ;
BADRPC(RPC,RTN,OPTION) ; Send back information on bad RPC call
 ;
 ;
 S @RESULTS@(0)="-1^Error calling RPC: "_RPC_" at "_OPTION_U_RTN
 Q
 ;
BLDERMSG(VBECPRMS,VBRSLT,VBMT) ;  build error message(s) into VBMT global
 ;
 N VBX       ; temporary variable for holding text
 N VBNM      ; indirect name of request/results array/global
 N VBNM2     ; copy of VBNM for different FOR loop
 N VBORIG    ; copy of VBNM with trailing parenthesis removed
 N VBDATA    ; data value from request/results node
 N VBLBL     ; label value comprised of $NA_VBDATA
 N VBSUB     ; subscript value for array node
 N VBOUT     ; full concatenated value of node to display
 N VBLCV     ; loop control variable for FOR loop
 N VBDONE    ; flag to signify 'done' with loop
 N VBBLANK   ; blank line of blank spaces
 N VBMAXDAT  ; maximum allowable length of array node data value
 N VBMAXLBL  ; maximum discovered length of array node label value
 N VBSPACES  ; calulated gap to format display to show data at column
 ;
 S VBX="Following are the request and results array(s)"
 I $D(@VBMT@("!INITIAL IEN"))#2=1 D
 . S VBX=VBX_" for IEN # "_$P(@VBMT@("!INITIAL IEN"),U,2)
 . S @VBMT@("#FOLLOWS MSG")=VBX
 S VBBLANK="                                                         "
 ;
 F VBNM="VBECPRMS",$NA(@VBRSLT) D
 . S VBNM2=VBNM,VBORIG=$P(VBNM,")")
 . S VBMAXLBL=1
 . F  S VBNM2=$Q(@VBNM2) Q:VBNM2=""  Q:$NA(@VBNM2)'[VBORIG  D
 . . S:VBORIG="VBECPRMS" VBLBL=$P($NA(@VBNM2),"(",2)
 . . S:VBORIG=$P($NA(@VBRSLT),")") VBLBL=$P($NA(@VBNM2),")")
 . . I VBORIG["VBECPRMS" D
 . . . S VBLBL=$P(VBLBL,")")
 . . I VBORIG'["VBECPRMS" D
 . . . S VBLBL=$P(VBLBL,"(",2)
 . . . S VBLBL=$P(VBLBL,$J)_$E(VBLBL,$F(VBLBL,$J)+1,$L(VBLBL))
 . . . S VBLBL=$TR(VBLBL,"""","'"),VBLBL="'"_$P(VBLBL,"XML_",2)
 . . S VBMAXLBL=$S($L(VBLBL)>VBMAXLBL:$L(VBLBL),1:VBMAXLBL)
 . S VBMAXLBL=$S(VBMAXLBL>30:30,1:VBMAXLBL+3)
 . S VBMAXDAT=80-VBMAXLBL-2
 . S VBORIG=$P(VBNM,")")
 . F  S VBNM=$Q(@VBNM) Q:VBNM=""  Q:$NA(@VBNM)'[VBORIG  D
 . . S VBLCV=0
 . . S VBSUB=$NA(@VBNM),VBSUB=$TR(VBSUB,"""","")
 . . S:VBORIG="VBECPRMS" VBLBL=$P($NA(@VBNM),"(",2)
 . . S:VBORIG=$P($NA(@VBRSLT),")") VBLBL=$P($NA(@VBNM),")")
 . . I VBORIG["VBECPRMS" D
 . . . S VBLBL=$P(VBLBL,")")
 . . I VBORIG'["VBECPRMS" D
 . . . S VBLBL=$P(VBLBL,"(",2)
 . . . S VBLBL=$P(VBLBL,$J)_$E(VBLBL,$F(VBLBL,$J)+1,$L(VBLBL))
 . . . S VBLBL=$TR(VBLBL,"""","'"),VBLBL="'"_$P(VBLBL,"XML_",2)
 . . S VBSPACES="",$P(VBSPACES," ",VBMAXLBL-$L(VBLBL))=""
 . . S VBSPACES=VBSPACES
 . . S VBDATA=$G(@VBNM)
 . . K VBDONE
 . . F VBLCV=0:1:25 D  Q:$D(VBDONE)
 . . . S VBSUB=$P(VBSUB,"||")
 . . . S VBSUB=VBSUB_"||"_VBLCV
 . . . S VBDATA(VBLCV)="  "_$E(VBDATA,1,VBMAXDAT)
 . . . S VBDATA=$E(VBDATA,VBMAXDAT+1,$L(VBDATA))
 . . . S:$L(VBDATA)'>0 VBDONE=1
 . . . I VBLCV<1 D  Q
 . . . . I $L(VBLBL)'>VBMAXLBL D  Q
 . . . . . S $P(VBSPACES," ",$L(VBLBL)-VBMAXLBL)=""
 . . . . . S VBLBL=VBLBL_VBSPACES
 . . . . . S VBOUT=VBLBL_VBDATA(VBLCV)
 . . . . . S @VBMT@(VBSUB)=VBOUT
 . . . . I $L(VBLBL)>VBMAXLBL D
 . . . . . S @VBMT@(VBSUB)=VBLBL
 . . . . . S VBSUB=VBSUB_"||"_VBLCV
 . . . . . S VBLBL=$E(VBBLANK,1,VBMAXLBL-1)
 . . . . . S VBOUT=VBLBL_VBDATA(VBLCV)
 . . . . . S VBSUB=$P(VBSUB,"||")
 . . . . . S VBLCV=VBLCV+1
 . . . . . S VBSUB=VBSUB_"||"_VBLCV
 . . . . . S @VBMT@(VBSUB)=VBOUT
 . . . I VBLCV>0 D
 . . . . S VBLBL=$E(VBBLANK,1,VBMAXLBL-1)
 . . . . S VBOUT=VBLBL_VBDATA(VBLCV)
 . . . . S @VBMT@(VBSUB)=VBOUT
 K VBDATA
 Q
SENDMSG(VBMT,SENDER,RECEIVER,SUBJECT) ;  Function - send message to mail group
 ;
 ; Input:
 ;   VBMT - Array with error information for message text
 ;   SENDER - Name of sender (routine tag and name)
 ;   RECEIVER - Mail group or individual
 ;   SUBJECT - Text for message subject
 ;
 N VBT      ; node in array during $Q
 N VBLN     ; message parameters
 N VBGROUP  ; name of mail group to which message will be sent
 N VBCNT    ; line count of VBLN array
 N VBUSERNM ; IEN of user's entry in NEW PERSON file
 N VBUSER   ; name of user running this program
 N XMDUZ    ; sender
 N XMSUB    ; message subject
 N XMTEXT   ; message text array
 N XMY      ; recipient array
 N XMZ      ; returned message number
 ;
 I '$D(VBMT) Q
 I '$D(SENDER) S SENDER="VBECS VistALink M Client"
 I '$D(RECEIVER) S RECEIVER="G.VBECS INTERFACE ADMIN"
 I '$D(SUBJECT) S SUBJECT="VBECS VistaLink Error"
 ;
 S VBCNT=1
 S VBT=$NA(@VBMT)
 ;
 S VBUSERNM=$$GET1^DIQ(200,DUZ,.01)
 ;
 S VBLN(VBCNT)="* * * VBECS VistALink Error Notification * * *"
 S VBCNT=VBCNT+1,VBLN(VBCNT)=" ",VBCNT=VBCNT+1
 S VBLN(VBCNT)="      Generated by: "_VBUSERNM
 S VBCNT=VBCNT+1,VBLN(VBCNT)=" "
 F  S VBT=$Q(@VBT) Q:VBT=""  Q:$NA(@VBT)'[$J  D
 . S VBCNT=VBCNT+1
 . S:VBT["DILIST" VBLN(VBCNT)=$G(@VBT)
 . S:VBT'["DILIST" VBLN(VBCNT)=$P($G(@VBT),U)
 . S VBLN(VBCNT)=$TR(VBLN(VBCNT),"""","'")
 ;
 S XMDUZ=SENDER
 S XMSUB=SUBJECT
 S XMTEXT="VBLN("
 ; reactivate the following ling after testing:
 S XMY(RECEIVER)=""
 ;S XMY(VBUSERNM)=""
 D ^XMD
 Q
