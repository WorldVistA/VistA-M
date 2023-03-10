DGPFHLS ;ALB/RPM - PRF HL7 SEND DRIVERS ; 7/31/06 10:10am
 ;;5.3;Registration;**425,650,1005,1028,1037**;Aug 13, 1993;Build 4
 ;
SNDORU(DGPFIEN,DGPFHARR,DGFAC) ;Send ORU Message Types (ORU~R01)
 ;This function builds and transmits a single ORU message to all sites
 ;in the associated patient's TREATING FACILITY LIST (#391.91) file.
 ;The optional input parameter DGFAC overrides selection of sites
 ;from the TREATING FACILITY LIST file.
 ;
 ;  Supported DBIA #2990:  This supported DBIA is used to access the
 ;                         Registration API to generate a list of
 ;                         treating facilities for a given patient.
 ;  Supported by ICR #2263 This ICR permits use of $$GET^XPAR().
 ;  Input:
 ;    DGPFIEN - (required) IEN of assignment in PRF ASSIGNMENT (#26.13)
 ;                         file to transmit
 ;   DGPFHARR - (optional) array of assignment history IENs from the
 ;                         PRF ASSIGNMENT HISTORY (#26.14) file to 
 ;                         include in ORU.
 ;                         format:  DGPFHARR(assignment_date_time)=IEN
 ;                                  assignment_date_time in FM format
 ;                         [default = $$GETLAST^DGPFAAH(DGPFIEN)]
 ;      DGFAC - (optional) array of message destination facilities
 ;                         passed by reference
 ;                         format:  DGFAC(#)=station#
 ;
 ;  Output:
 ;   Function value - 1 on success, 0 on failure
 ;
 N DGHLEID   ;event protocol ID
 N DGHL      ;VistA HL7 environment array
 N DGHLROOT  ;message array location
 N DGPFA     ;assignment data array
 N DGPFAH    ;assignment history data array
 N DGPFHIEN  ;assignment history IEN
 N DGRSLT    ;function value
 N DGI       ;counter
 N DGCRNR    ;flag indicating that a converted facility was found
 N DGSTAT,DGSTAT2    ;status retuned when sending message
 ;
 S DGRSLT=0
 S DGHLROOT=$NA(^TMP("PRFORU",$J))
 K @DGHLROOT
 ;
 I +$G(DGPFIEN)>0,$D(^DGPF(26.13,DGPFIEN)) D
 . ;
 . ;retrieve assignment record
 . Q:'$$GETASGN^DGPFAA(DGPFIEN,.DGPFA)
 . ;
 . ;set up default history IEN array
 . I '$O(DGPFHARR(0)) D
 . . N DGPFAH
 . . S DGPFHIEN=$$GETLAST^DGPFAAH(DGPFIEN)
 . . Q:'$$GETHIST^DGPFAAH(DGPFHIEN,.DGPFAH)
 . . S DGPFHARR(+$G(DGPFAH("ASSIGNDT")))=DGPFHIEN
 . Q:'$O(DGPFHARR(0))
 . ;
 . ;retrieve treating facilities when no destination is provided
 . ;I $G(DGFAC(1))'>0 D TFL^VAFCTFU1(.DGFAC,+$G(DGPFA("DFN")))
 . I $G(DGFAC(1))'>0 D BLDTFL2^DGPFUT2(+$G(DGPFA("DFN")),.DGFAC)
 . Q:$G(DGFAC(1))'>0
 . ;
 . ;initialize VistA HL7 environment
 . S DGHLEID=$$INIT^DGPFHLUT("DGPF PRF ORU/R01 EVENT",.DGHL)
 . Q:'DGHLEID
 . ;
 . ;build ORU segments array
 . S DGPFHIEN=$$BLDORU^DGPFHLU(.DGPFA,.DGPFHARR,.DGHL,DGHLROOT)
 . Q:'DGPFHIEN
 . ;
 . ;transmit and log messages
 . S DGSTAT=0,DGSTAT2=0
 . S DGSTAT=$$XMIT^DGPFHLU6(DGPFHIEN,DGHLEID,.DGFAC,DGHLROOT,.DGHL)
 . ;
 . ;Should a copy be sent to the regional HC router?
 . S DGCRNR=$$CERNER2(DGPFIEN)
 . D:DGCRNR
 . . S DGSTAT2=$$XMIT1^DGPFHLU6(DGPFHIEN,DGHLEID,DGHLROOT,.DGHL)
 . ;
 . Q:'$G(DGSTAT)
 . I DGCRNR,'$G(DGSTAT2) Q
 . ;success
 . S DGRSLT=1
 ;
 ;cleanup
 K @DGHLROOT
 Q DGRSLT
 ;
SNDACK(DGACKTYP,DGMIEN,DGHL,DGSEGERR,DGSTOERR) ;Send ACK Message Type (ACK~R01)
 ;This procedure assumes the the VistA HL7 environment is providing the
 ;environment variables and will produce a fatal error if they are
 ;missing.
 ;
 ;  Input:
 ;    DGACKTYP - (required) ACK message type ("AA","AE")
 ;      DGMIEN - (required) IEN of message entry in file #773
 ;        DGHL - (required) HL7 environment array
 ;    DGSEGERR - (optional) Errors found during parsing
 ;    DGSTOERR - (optional) Errors during data storage
 ;
 ;  Output:
 ;    none
 ;
 N DGHLROOT
 N DGHLERR
 ;
 Q:($G(DGACKTYP)']"")
 Q:('+$G(DGMIEN))
 ;
 S DGHLROOT=$NA(^TMP("HLA",$J))
 K @DGHLROOT
 ;
 ;build ACK segments array
 I $$BLDACK^DGPFHLU4(DGACKTYP,DGHLROOT,.DGHL,.DGSEGERR,.DGSTOERR) D
 . ;send MailMan message on AE or AR
 . D SNDMAIL(DGMIEN,.DGHL,$NA(^TMP("HLA",$J)))
 . ;generate the message
 . D GENACK^HLMA1(DGHL("EID"),DGMIEN,DGHL("EIDS"),"GM",1,.DGHLERR)
 ;
 ;cleanup
 K @DGHLROOT
 Q
 ;
SNDQRY(DGDFN,DGMODE,DGFAC) ;Send QRY Message Types (QRY~R02)
 ;This function transmits a PRF Query (QRY~R02) HL7 message to a given
 ;patient's treating facility. 
 ;
 ;  Input:
 ;    DGDFN - (required) pointer to patient in PATIENT (#2) file
 ;   DGMODE - (optional) type of HL7 connection to use ("1" - direct
 ;            connection, "2" - deferred connection [default],
 ;            "3" - direct connection/display mode)
 ;    DGFAC - (optional) station number of query destination.
 ;            [default - most recent unqueried treating facility]
 ;
 ;  Output:
 ;   Function value - 1 on success, 0 on failure
 ;
 N DGEVNT
 N DGHLROOT
 N DGHLLNK
 N DGHL
 N DGICN
 N DGLSQ
 N DGMSG
 N DGMSGID
 N DGNXTF
 N DGRSLT
 N HLL
 N DGHLEID
 N DGHLRSLT
 N DGHLP
 ;
 ;the following HL* variables are created by DIRECT^HLMA
 N HL,HLCS,HLDOM,HLECH,HLFS,HLINST,HLINSTN
 N HLMTIEN,HLNEXT,HLNODE,HLPARAM,HLPROD,HLQ
 N HLQUIT
 ;
 S DGMODE=+$G(DGMODE)
 S DGFAC=$G(DGFAC)
 S DGRSLT=0
 S DGHLROOT=$NA(^TMP("HLS",$J))
 K @DGHLROOT
 ;
 I +$G(DGDFN)>0,$D(^DPT(DGDFN,0)) D
 . ;
 . ;ICN must be national
 . Q:'$$MPIOK^DGPFUT(DGDFN,.DGICN)
 . ;
 . ;find event, get last site queried and next treating facility
 . S DGEVNT=$$FNDEVNT^DGPFHLL1(DGDFN)
 . I 'DGEVNT,DGMODE'=3 D   ;no event and not display? create it!
 . . D STOEVNT^DGPFHLL1(DGDFN)
 . . S DGEVNT=$$FNDEVNT^DGPFHLL1(DGDFN)
 . S DGLSQ=$$GETLSQ^DGPFHLL(DGEVNT)
 . S DGNXTF=$$GETNXTF^DGPFUT(DGDFN,DGLSQ)
 . ;
 . ;determine treating facility institution number to query
 . S DGFAC=$S(DGFAC]"":$$IEN^XUAF4(DGFAC),DGNXTF:DGNXTF,DGLSQ&('DGNXTF):$$GETNXTF^DGPFUT(DGDFN),1:0)
 . ;
 . ;mark query event COMPLETE and return SUCCESS when no non-local
 . ;treating facilities are found and no previous queries have been run.
 . I DGFAC'>0,'DGLSQ D
 . . D STOEVNT^DGPFHLL1(DGDFN,"C")
 . . S DGRSLT=1
 . Q:(DGFAC'>0)
 . ;
 . ;retrieve treating facility HL Logical Link and build HLL array
 . S DGHLLNK=$$GETLINK^DGPFHLUT(DGFAC)
 . Q:(DGHLLNK=0)
 . S HLL("LINKS",1)="DGPF PRF ORF/R04 SUBSC"_U_DGHLLNK
 . ;S:$$CERNER(DGDFN) HLL("LINKS",1)="DGPF PRF ORF/R04 SUBSC"_U_"VACRNR"
 . ;
 . ;initialize VistA HL7 environment
 . S DGHLEID=$$INIT^DGPFHLUT("DGPF PRF QRY/R02 EVENT",.DGHL)
 . Q:'DGHLEID
 . ;
 . ;build QRY segments array
 . Q:'$$BLDQRY^DGPFHLQ(DGDFN,DGICN,DGHLROOT,.DGHL)
 . ;
 . ;display busy message to interactive users when direct-connect
 . I DGMODE=1!(DGMODE=3),$E($G(IOST),1,2)="C-" D
 . . S DGMSG(1)="Attempting to connect to "_$P($$NS^XUAF4(DGFAC),U)
 . . S DGMSG(2)="to search for Patient Record Flag Assignments."
 . . S DGMSG(3)="This request may take some time, please be patient ..."
 . . D EN^DDIOL(.DGMSG)
 . ;
 . ;generate HL7 message
 . I DGMODE=1!(DGMODE=3) D    ;generate direct-connect HL7 message
 . . S $P(DGHLP("SUBSCRIBER"),U,5)=$$STA^XUAF4(DGFAC)
 . . D DIRECT^HLMA(DGHLEID,"GM",1,.DGHLRSLT,"",.DGHLP)
 . . ;The DIRECT^HLMA API contains a bug that causes the message ID
 . . ;returned to be based on the HL7 MESSAGE TEXT (#772) file IEN and
 . . ;not the HL7 MESSAGE ADMINISTRATION (#773) file IEN.  Therefore,
 . . ;the following call to $$CONVMID is required to convert the
 . . ;message ID to the value stored in file #773.
 . . S DGMSGID=$$CONVMID^DGPFHLUT($P(DGHLRSLT,U))
 . . I DGMODE=1,DGMSGID>0 D STOQXMIT^DGPFHLL(DGEVNT,DGMSGID,DGFAC)
 . . I HLMTIEN,DGMODE'=3 D RCV^DGPFHLR
 . . I DGMODE=3 D DISPLAY^DGPFHLUQ(HLMTIEN,DGHLRSLT)
 . . ;success
 . . I '+$P(DGHLRSLT,U,2) S DGRSLT=1
 . ;
 . E  D              ;generate deferred HL7 message
 . . S $P(DGHLP("SUBSCRIBER"),U,5)=$$STA^XUAF4(DGFAC)
 . . D GENERATE^HLMA(DGHLEID,"GM",1,.DGHLRSLT,"",.DGHLP)
 . . I $P(DGHLRSLT,U)>0 D STOQXMIT^DGPFHLL(DGEVNT,$P(DGHLRSLT,U),DGFAC)
 . . ;success
 . . I '+$P(DGHLRSLT,U,2) S DGRSLT=1
 ;
 ;cleanup
 K @DGHLROOT
 Q DGRSLT
 ;
SNDORF(DGQRY,DGMIEN,DGHL,DGDFN,DGSEGERR,DGQRYERR) ;Send ORF Message Type (ORF~R04)
 ;This procedure assumes the the VistA HL7 environment is providing the
 ;environment variables and will produce a fatal error if they are
 ;missing.
 ;
 ;  Input:
 ;       DGQRY - (required) Array of QRY parsing results
 ;      DGMIEN - (required) IEN of message entry in file #773
 ;        DGHL - (required) HL7 environment array
 ;       DGDFN - (required) Pointer to patient in PATIENT (#2) file
 ;    DGSEGERR - (optional) Errors found during parsing
 ;    DGQRYERR - (optional) Errors found during query
 ;
 ;  Output:
 ;    none
 ;
 N DGHLROOT
 N DGHLERR
 ;
 Q:('$D(DGQRY))
 Q:('+$G(DGMIEN))
 ;
 S DGHLROOT=$NA(^TMP("HLA",$J))
 K @DGHLROOT
 ;
 ;build ORF segments array
 I $$BLDORF^DGPFHLQ(DGHLROOT,.DGHL,DGDFN,.DGQRY,.DGSEGERR,.DGQRYERR) D
 . ;send MailMan message on AE or AR
 . D SNDMAIL(DGMIEN,.DGHL,$NA(^TMP("HLA",$J)))
 . ;generate the message
 . D GENACK^HLMA1(DGHL("EID"),DGMIEN,DGHL("EIDS"),"GM",1,.DGHLERR)
 ;
 ;cleanup
 K @DGHLROOT
 Q
 ;
 ;patch 1005
CERNER(DGDFN) ;
 ;Is this a Cerner patient (i.e., is 200CRNR in the TFL)?
 ;input variables
 ;DGDFN - pointer to PATIENT (#2) file
 ;return value: 
 ; 1 - yes, 0 - no
 ;
 N DGRES,DGOUT,DGSITE,DGKEY,DGI
 S DGRES=0
 S DGSITE=$P($$SITE^VASITE,U,3)
 S DGKEY=DGDFN_U_"PI"_U_"USVHA"_U_DGSITE
 D TFL^VAFCTFU2(.DGOUT,DGKEY)
 S DGI=0
 F  S DGI=$O(DGOUT(DGI)) Q:DGI=""  D
 .I $P(DGOUT(DGI),U,4)="200CRNR",$P(DGOUT(DGI),U,2)="PI" S DGRES=1
 Q DGRES
 ;
CERNER2(DGIEN) ;
 ;This is a convenience routine that accepts a patient record flag
 ;assignment as input parameter.
 ;input variables:
 ;DGIEN - pointer to PRF ASSIGNMENT (#26.13) file
 ;return value:
 ; 1 - yes, 0 - no
 ;
 N DGDFN,DGPFA
 D GETASGN^DGPFAA(DGIEN,.DGPFA)
 S DGDFN=$P(DGPFA("DFN"),U)
 Q $$CERNER(DGDFN)
 ;
SNDMAIL(DGMIEN,DGHL,DGROOT) ;
 ;This entry point sends a MailMan message reporting that an AE or
 ;AR was generated.
 ;input variables:
 ;DGMIEN (required) - IEN of offending message in file #773
 ;DGHL (required)   - The "HL" array
 ;DGROOT (required) - root for the application ack passed to GENACK^HLMA1
 ;
 ;call to $$PROD^XUPROD supported by ICR #4440
 ;
 N XMDUZ,XMSUB,XMTEXT,XMY,XMZ ;MailMan variables
 N DGTXT,DGSTAT,DGMSA,DGMSH,DGTYP,DGFS,DGI,DGOMID
 S DGFS=DGHL("FS")
 S DGMSH=$G(^HLMA(DGMIEN,"MSH",1,0))
 S DGMSA=$G(@DGROOT@(1))
 S DGTYP=$P(DGMSA,DGFS,2)
 S DGOMID=$P(DGMSA,DGFS,3)
 Q:DGTYP="AA"  ;Don't send mail messages for succesful AAs.
 S DGSTAT=$P($$SITE^VASITE,U,3)
 S XMDUZ="PRF Error Processor"
 S XMSUB="PRF Application Error (station #"_DGSTAT_")"
 S XMSUB=XMSUB_" ["_$S($$PROD^XUPROD:"P",1:"T")_"]" ;production or test?
 S XMY("G.DGPF APPLICATION ERRORS")=""
 S XMTEXT="DGTXT("
 S DGTXT(1)="An error occurred processing message #"_DGMIEN
 S DGTXT(2)="Original MID: "_DGOMID
 S DGTXT(3)="Timestamp: "_$$FMTE^XLFDT($$NOW^XLFDT)_$$TZ^XLFDT
 S DGTXT(4)=""
 S DGTXT(5)="MESSAGE TEXT (ACK):"
 S DGTXT(6)=DGMSH
 S DGI=""  F  S DGI=$O(@DGROOT@(DGI)) Q:DGI=""  D
 . S DGTXT(DGI+6)=$G(@DGROOT@(DGI))
 D ^XMD
 Q
