DGROHLS ;DJH/AMA - ROM HL7 SEND DRIVERS ; 27 Apr 2004  5:16 PM
 ;;5.3;Registration;**533,572**;Aug 13, 1993
 ;
SNDACK(DGACKTYP,DGMIEN,DGHL,DGSEGERR,DGSTOERR) ;Send ACK Message Type (ACK~R01)
 ;This procedure assumes that the VistA HL7 environment is providing the
 ;environment variables and will produce a fatal error if they are missing.
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
 N DGHLROOT,DGHLERR
 ;
 Q:($G(DGACKTYP)']"")
 Q:('+$G(DGMIEN))
 ;
 S DGHLROOT=$NA(^TMP("HLA",$J))
 K @DGHLROOT
 ;
 ;build ACK segments array
 I $$BLDACK^DGROHLU4(DGACKTYP,DGHLROOT,.DGHL,.DGSEGERR,.DGSTOERR) D
 . ;
 . ;generate the message
 . D GENACK^HLMA1(DGHL("EID"),DGMIEN,DGHL("EIDS"),"GM",1,.DGHLERR)
 ;
 ;cleanup
 K @DGHLROOT
 Q
 ;
SNDQRY(DGDFN) ;Send QRY Message Types (QRY~R02)
 ;
 ;  Input:
 ;    DGDFN - (required) pointer to patient in PATIENT (#2) file
 ;
 ;  Output:
 ;   Function value - 1 on success, 0 on failure
 ;
 ;   Use of the API $$GET^XUESSO1() supported by DBIA # 4342
 ;
 N DGLST,DGHLROOT,DGHLLNK,DGHL,DGUSER,DGICN,DGMSG,DGRSLT,HLL,HLEID,HLRSLT
 ;
 ;the following HL* variables are created by DIRECT^HLMA
 N HL,HLCS,HLDOM,HLECH,HLFS,HLINST,HLINSTN,HLQ,ACKCODE
 N HLMTIEN,HLNEXT,HLNODE,HLPARAM,HLPROD,HLQUIT
 ;
 S DGRSLT=0
 S DGHLROOT=$NA(^TMP("HLS",$J))
 K @DGHLROOT
 ;
 I +$G(DGDFN)>0,$D(^DPT(DGDFN,0)) D
 . ;
 . ;ICN must be national and LST must not be local site
 . Q:'$$MPIOK^DGROUT(DGDFN,.DGICN,.DGLST)
 . ;
 . ;retrieve LST's HL Logical Link and build HLL array
 . S DGHLLNK=$$GETLINK^DGROHLUT(DGLST)
 . Q:(DGHLLNK=0)
 . S HLL("LINKS",1)="DGRO ROM ORF/R04 SUBSC"_U_DGHLLNK
 . ;
 . ;initialize VistA HL7 environment
 . S HLEID=$$INIT^DGROHLUT("DGRO ROM QRY/R02 EVENT",.DGHL)
 . Q:'HLEID
 . ;
 . ;retrieve user info    ;DG*5.3*572
 . S DGUSER=$$GET^XUESSO1()
 . I +DGUSER<0 D  Q
 . . ;display error message to interactive users
 . . S DGMSG(1)=" "
 . . S DGMSG(2)="The query to the LST has been terminated due to insufficient user data"
 . . D EN^DDIOL(.DGMSG)
 . S DGUSER=$P(DGUSER,U,1,2)_U_$P(DGUSER,U,5,6)
 . S DGUSER=$TR(DGUSER,U,"~")
 . ;
 . ;build QRY segments array
 . Q:'$$BLDQRY^DGROHLQ(DGDFN,DGICN,DGHLROOT,.DGHL,DGUSER)
 . ;
 . ;display busy message to interactive users
 . S DGMSG(1)=" "
 . S DGMSG(2)="Attempting to connect to the Last Site of Treatment ("_$G(DGLST)_") to search for Patient"
 . S DGMSG(3)="Demographic Data.  This request may take some time, please be patient ..."
 . D EN^DDIOL(.DGMSG)
 . ;
 . ;generate HL7 message
 . D DIRECT^HLMA(HLEID,"GM",1,.HLRSLT,"","")
 . Q:$P(HLRSLT,U,2)]""
 . I HLMTIEN N DGROVRCK S DGROVRCK=1 D RCV^DGROHLR
 . I ($D(DGROVRCK)),(DGROVRCK=0) K DGROVRCK QUIT
 . Q:$G(ACKCODE)
 . ;success
 . S DGRSLT=1
 ;
 ;cleanup
 K @DGHLROOT
 Q DGRSLT
 ;
SNDORF(DGQRY,DGMIEN,DGHL,DGDFN,DGSEGERR,DGQRYERR) ;Send ORF Message Type (ORF~R04)
 ;This procedure assumes the the VistA HL7 environment is providing the
 ;environment variables and will produce a fatal error if they are
 ;missing.  (Called from RCVQRY^DGROHLR)
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
 Q:($TR(DGQRY("USER"),"~",U)']"")
 ;
 S DGHLROOT=$NA(^TMP("HLA",$J)) K @DGHLROOT
 ;
 ;build ORF segments array
 I $$BLDORF^DGROHLQ(DGHLROOT,.DGHL,DGDFN,.DGQRY,.DGSEGERR,.DGQRYERR) D
 . ;
 . ;generate the message
 . D GENACK^HLMA1(DGHL("EID"),DGMIEN,DGHL("EIDS"),"GM",1,.DGHLERR)
 ;
 ;cleanup
 K @DGHLROOT
 Q
