DGPFHLS ;ALB/RPM - PRF HL7 SEND DRIVERS ; 7/31/06 10:10am
 ;;5.3;Registration;**425,650**;Aug 13, 1993;Build 3
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
 N DGHLEID     ;event protocol ID
 N DGHL      ;VistA HL7 environment array
 N DGHLROOT  ;message array location
 N DGPFA     ;assignment data array
 N DGPFAH    ;assignment history data array
 N DGPFHIEN  ;assignment history IEN
 N DGRSLT    ;function value
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
 . I $G(DGFAC(1))'>0 D TFL^VAFCTFU1(.DGFAC,+$G(DGPFA("DFN")))
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
 . Q:'$$XMIT^DGPFHLU6(DGPFHIEN,DGHLEID,.DGFAC,DGHLROOT,.DGHL)
 . ;
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
 . ;
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
 . . S DGMSG(3)="This request may take sometime, please be patient ..."
 . . D EN^DDIOL(.DGMSG)
 . ;
 . ;generate HL7 message
 . I DGMODE=1!(DGMODE=3) D    ;generate direct-connect HL7 message
 . . D DIRECT^HLMA(DGHLEID,"GM",1,.DGHLRSLT,"","")
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
 . . D GENERATE^HLMA(DGHLEID,"GM",1,.DGHLRSLT,"","")
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
 . ;
 . ;generate the message
 . D GENACK^HLMA1(DGHL("EID"),DGMIEN,DGHL("EIDS"),"GM",1,.DGHLERR)
 ;
 ;cleanup
 K @DGHLROOT
 Q
