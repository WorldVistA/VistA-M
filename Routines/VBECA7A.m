VBECA7A ;HOIFO/SAE - Workload API ; 9/30/04 5:38pm
 ;;1.0;VBECS;**10**;Apr 14, 2005;Build 15
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ; 
 ; Integration Agreements:
 ;  VBECS workload update supported by IA 4628
 ; Reference to LIST^DIC supported by DBIA #2051
 ; Reference to EN^MXMLPRSE supported by IA #4149
 ; 
 QUIT
 ;
UPDTWKLD ;  Update Workload Event Data
 ;
 ; This routine initializes Vistalink connection values (port,
 ; URL, etc.), then builds a local array of selected entries
 ; (those that have been successfully processed) from the
 ; VistA VBECS WORKLOAD CAPTURE (#6002.01) file.
 ; For each entry, listed in the local array, does the following:
 ; - sends request, via VistaLink, to .Net VBECS VistALink listener
 ; - receives response: VBECS processing status or ErrorText message
 ; - If no errors (comm, VistaLink, etc.):
 ;   - update VBECS WORKLOAD CAPTURE (#6002.01) file entry:
 ;     - delete it (if it had been successfully processed in VBECS) or
 ;     - update two fields in this entry (if there had been ErrorText)
 ; - If comm, VistaLink, etc., errors:
 ;   -  not update VistA
 ;   -  save the non-specific error for inclusion in MailMan message.
 ; - A MailMan message is transmitted to the G.VBECS INTERFACE ADMIN
 ;      mail group:
 ;   - identifying success or failure and other transaction info
 ;
 ; Input  - none
 ; Output - no output variables.
 ;          However, MailMan msg is sent for fatal errors.
 ;
 N VBY       ; array of file 6002.01 fields from selected entries
 N VBIEN     ; IEN of entry to delete - used in ENELE subroutine
 N VBRSLT    ; ^TMP global array of results returned from VBECS
 N VBMT      ; array with VistA update status messages for mail text
 N VBN       ; loop control variable for For loop
 N VBECPRMS  ; local array for REQUEST and results
 N VBIENSV   ; IEN to save and use to verify same as VBECS
 N VBMTBLT   ; flag that signifies that VBMT has been built
 ;
 S VBN=0
 S VBRSLT=$NA(^TMP("VBECS_XML_RES",$J)) K @VBRSLT
 S VBMT=$NA(^TMP("VBECS_MAIL_TEXT",$J)) K @VBMT
 ;
 D INITV^VBECRPCC("VBECS Update Workload Event") ; init VL listener
 D CHKERROR^VBECA7A1(.VBECPRMS,VBRSLT,VBMT)
 I $D(@VBMT@(" ERROR")) D  Q
 . D BLDERMSG^VBECA7A1(.VBECPRMS,VBRSLT,VBMT)
 . D SENDMSG(VBMT)
 . D CLEANUP
 ;
 D GETVISTA(.VBY)
 ;
 ; step thru array. each node contains one entry from file 6002.01
 F  S VBN=$O(VBY("DILIST",VBN)) Q:VBN']""  D  Q:$D(@VBMT@(" ERROR"))
 . K @VBMT
 . D BLDPARMS(.VBY,VBN,.VBECPRMS)
 . D BLDRSLTS(.VBECPRMS)
 . D CHKERROR^VBECA7A1(.VBECPRMS,VBRSLT,VBMT)
 . Q:$D(@VBMT@(" ERROR"))
 . D BLDGLOB(.VBECPRMS,VBRSLT)
 . D CHKERROR^VBECA7A1(.VBECPRMS,VBRSLT,VBMT)
 . Q:$D(@VBMT@(" ERROR"))
 . D SETVISTA(VBRSLT)
 . D CHKERROR^VBECA7A1(.VBECPRMS,VBRSLT,VBMT)
 ;
 I $D(@VBMT@(" ERROR")) D  Q
 . D BLDERMSG^VBECA7A1(.VBECPRMS,VBRSLT,VBMT)
 . D SENDMSG(VBMT)
 ;
 D CLEANUP
 Q
 ;
GETVISTA(VBY) ; get file entries from VBECS WORKLOAD CAPTURE (#6002.01) file
 ;
 Q:$D(@VBMT@(" ERROR"))
 ;
 ;
 ; Input
 ;   none
 ; Output
 ;   VBY - array, with each entries' fields packed into each node:
 ;           IEN of entry is in first piece of the node value
 ;           Fields shown in VBECFLDS variable
 ;           List fields in same sequence as SDD Input section 4.1.4
 ;
 N VBECFLDS  ; fields to retrieve & pack in each VBY("DILIST") node
 N VBECSCR   ; screen to filter in entries for two fields:
 ;              PROCESSED DATE (#4) field - not null
 ;              STATUS         (#5) field - (S)UCCESSFULLY PROCESSED
 ;
 S X1=DT,X2=-14 D C^%DTC S VBOFF=X
 S VBECFLDS="@;.01;5I;4I;20;99"
 S VBECSCR("S")="I ($P(^(0),U,4)>VBOFF)&($P(^(0),U,6)=""S"")" ;RLM 6-1-2010
 D LIST^DIC(6002.01,"",VBECFLDS,"P","","","","",.VBECSCR,"","VBY")
 S VBLOOP=0 F  S VBLOOP=$O(VBY("DILIST",VBLOOP)) Q:'VBLOOP  S $P(VBY("DILIST",VBLOOP,0),"^",4)=$P(VBY("DILIST",VBLOOP,0),"^",4)_$E("0000000.000000",$L($P(VBY("DILIST",VBLOOP,0),"^",4)),13)
 ;Added formatting to ensure a six digit time. RLM 4/2/2008
 ; VBY("DILIST",4,0)=
 ;    8^AC934682-43C2-4B7E-B63B-063C7BABCFAD^^JUL 28, 2004@23:23:49^
 ;    some sample error text^pce encounter value
 Q
 ;
BLDPARMS(VBY,VBN,VBECPRMS) ;  build VBECPRMS(PARAMS)
 ;
 Q:$D(@VBMT@(" ERROR"))
 ;
 ; Build VBECPRMS("PARAMS" array for current VistA entry
 ;
 ; Input
 ;   VBY       ; Array: VBECS WORKLOAD CAPTURE (#6002.01) file entries
 ;   VBN       ; Node from VBY filtered collection of entries
 ;   VBECPRMS  ; root of target 'REQUEST' array to build
 ; Output
 ;   VBECPRMS  ; root of target 'REQUEST' array to build
 ;
 N VBW       ; field value
 N VBECPI    ; DILIST node piece and VBECPRMS node subscript
 N VBNODVAL  ; value of node
 N VBX       ; array node
 ;
 S VBNODVAL=VBY("DILIST",VBN,0)
 S VBX="INITIAL IEN:  "_$P(VBNODVAL,U)_U_$P(VBNODVAL,U)
 S @VBMT@("!INITIAL IEN")=VBX
 S VBNODVAL=$E(VBNODVAL,$F(VBNODVAL,U),$L(VBNODVAL))  ; remove IEN
 F VBECPI=1:1:5  D
 . S VBW=$P(VBNODVAL,U,VBECPI)
 . S VBECPRMS("PARAMS",VBECPI,"VALUE")=VBW
 . S VBECPRMS("PARAMS",VBECPI,"TYPE")="STRING"
 Q
 ;
BLDRSLTS(VBECPRMS) ;  put results in VBECPRMS("RESULTS") local array
 ;
 ; Input
 ;   VBECPRMS  ; root of target 'REQUEST' array to build
 ; Output
 ;   VBECPRMS  ; root of target 'REQUEST' array to build
 ;
 N VBSTAT  ; temp variable
 ;
 S VBSTAT=$$EXECUTE^VBECRPCC(.VBECPRMS)
 Q
 ;
BLDGLOB(VBECPRMS,VBRSLT) ;  put results from VBECS in ^TMP global
 ;
 Q:$D(@VBMT@(" ERROR"))
 ;
 ;
 ; Input
 ;   VBECPRMS - array
 ; Output
 ;   VBRSLT   - $NA of ^TMP results global to build
 ;
 D PARSE^VBECRPC1(.VBECPRMS,VBRSLT)
 Q
 ;
SETVISTA(VBRSLT) ;  Update Vista. MXMLPRSE invokes callback routines
 ;
 ; Input
 ;   VBRSLT - name of results global
 ;
 N VBCBK  ; callback routines
 ;
 Q:$D(@VBMT@(" ERROR"))
 ;
 ; callbacks allow MXMLPRSE to put data in file 6002.01
 S VBCBK("STARTELEMENT")="STELE^VBECA7A1"
 S VBCBK("ENDELEMENT")="ENELE^VBECA7A1"
 S VBCBK("CHARACTERS")="CHAR^VBECA7A1"
 S OPTION=""
 D EN^MXMLPRSE(VBRSLT,.VBCBK,.OPTION)
 Q
 ;
SENDMSG(VBMT) ;  Function - send error message to mail group
 ;
 ; If unsuccessful deletion, send error text
 ;
 ; Input:
 ;   VBMT array with info about transaction
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
 I '$D(@VBMT@(" ERROR")) Q
 ;. S VBX="SUCCESSFUL VBECS-VistA dialog"
 ;. S @VBMT@("!SUCCESSFUL VBECS-VISTA DIALOG")=VBX
 ;
 S VBCNT=1
 S VBT=$NA(@VBMT)
 ;
 ;S VBUSERNM=$$GET1^DIQ(200,DUZ,.01)
 ;
 S VBLN(VBCNT)="* * * VBECS Workload Event Error Notification * * *"
 F  S VBT=$Q(@VBT) Q:VBT=""  Q:$NA(@VBT)'[$J  D
 . S VBCNT=VBCNT+1
 . S:VBT["DILIST" VBLN(VBCNT)=$G(@VBT)
 . S:VBT'["DILIST" VBLN(VBCNT)=$P($G(@VBT),U)
 . S VBLN(VBCNT)=$TR(VBLN(VBCNT),"""","'")
 ;
 S XMDUZ="VBECS Workload Event"
 S XMSUB="VBECS Workload Event"
 S XMTEXT="VBLN("
 ; reactivate the following ling after testing:
 S XMY("G.VBECS INTERFACE ADMIN")=""
 ;S XMY(VBUSERNM)=""
 D ^XMD
 Q
 ;
CLEANUP K ATR,CBK,DIERR,ELE,VBFDA,OPTION,TEXT,VBECPRMS,@VBRSLT,@VBMT
 Q
