HDISVM02 ;;CT/GRR SEND MESSAGE ; 02 Mar 2005  4:25 PM
 ;;1.0;HEALTH DATA & INFORMATICS;**6**;Feb 22, 2005
 ;
SNDXML(ARRY,SRVR,HDISINP,SYSPTR) ;Send XML document to server
 ; Input: ARRY - Array containing XML document (closed root)
 ;        SRVR - 1 = VUID Server, 2 = Status Update Server
 ;        HDISINP - Array containing additional info (closed root) (optional)
 ;                  @HDISINP@(variable) = Value
 ;                  @HDISINP@(array,subscript) = Value
 ;                  @HDISINP@(array,subscript_1,subscript_2,...) = Value
 ;                  
 ;                  Example:
 ;                    @HDISINP@("TEST1")=1
 ;                    @HDISINP@("TEST2")=2
 ;                    @HDISINP@("TEST2","SUB1")="2A"
 ;                    @HDISINP@("TEST3","SUB1","SUB2")="3B"
 ;                  
 ;                  Results in the following variables/arrays being set:
 ;                    TEST1=1
 ;                    TEST2=2
 ;                    TEST2("SUB1")="2A"
 ;                    TEST3("SUB1","SUB2")="3B"
 ;        SYSPTR - Pointer to HDIS System file (optional)
 ;                 If passed, the destination information is obtained
 ;                 from the HDIS Parameter file entry for the referenced
 ;                 system.  By default, the destination information is
 ;                 pulled from the HDIS Parameter entry for the current
 ;                 system (which contains the destination information for
 ;                 the centrally located server)
 ;Output: None
 ;        XML document sent to Data Standardization server option
 ;        at given MailMan domain
 ;
 I ARRY=""!(SRVR="") Q "0^Required parameter missing"
 I SRVR'=1&(SRVR'=2) Q "0^SRVR Parameter invalid"
 N SUBJECT,HDITO,HDINSTR,HDIXMZ,SERVER,SRVTYP,MAXLIN,SRVROPT
 S SYSPTR=+$G(SYSPTR)
 I 'SYSPTR K SYSPTR I '$$CURSYS^HDISVF07(.SYSPTR) Q "0^Unable to determine current system"
 ;Get location information for VUID Server
 I SRVR=1 D
 .S SERVER=$$GETVLOC^HDISVF02(SYSPTR)
 .S SRVTYP=$$GETVCON^HDISVF02(SYSPTR)
 .S SRVROPT=$$GETVSRV^HDISVF02(SYSPTR)
 ;Get location information for Status Server
 I SRVR=2 D
 .S SERVER=$$GETSLOC^HDISVF03(SYSPTR)
 .S SRVTYP=$$GETSCON^HDISVF03(SYSPTR)
 .S SRVROPT=$$GETSSRV^HDISVF03(SYSPTR)
 ;Instantiate variables included in input array
 I $G(HDISINP)]"" D
 .N ROOT,RSCNT,NODE,NSCNT,TROOT
 .S ROOT=$$OREF^DILF(HDISINP)
 .S RSCNT=$QL(HDISINP)
 .S NODE=HDISINP
 .F  S NODE=$Q(@NODE) Q:(NODE="")!(NODE'[ROOT)  I $D(@NODE)#2 D
 ..S NSCNT=$QL(NODE)
 ..I (NSCNT-RSCNT)=1 S @$QS(NODE,NSCNT)=$G(@NODE) Q
 ..S TROOT=$QS(NODE,RSCNT+1)_"("_$P(NODE,",",RSCNT+2,NSCNT)
 ..S @TROOT=$G(@NODE)
 ;Set message subject
 I $G(SUBJECT)="" S SUBJECT="XML FORMATTED DATA FROM "_$P($$SITE^VASITE(),"^",2)
 ;Set message sender
 S HDINSTR("FROM")="Data Standardization Toolset"
 ;Set recipient list (includes server option on target server)
 N HDITO
 I SERVER="" S HDITO("S."_SRVROPT)=""
 I SERVER'="" S HDITO("S."_SRVROPT_"@"_SERVER)=""
 ;Send message to target server
 D SENDMSG^XMXAPI(DUZ,SUBJECT,ARRY,.HDITO,.HDINSTR,.HDIXMZ)
 I $G(XMERR) D
 .;Error sending message - log error text
 .D ERR2XTMP^HDISVU01("HDI-XM","Message sending",$NA(^TMP("XMERR",$J)))
 .K XMERR,^TMP("XMERR",$J)
 Q 1
 ;
