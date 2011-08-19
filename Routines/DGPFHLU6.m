DGPFHLU6 ;ALB/RPM - PRF HL7 ORU~R01 UTILITIES ; 8/31/05 1:09pm
 ;;5.3;Registration;**425,554**;Aug 13, 1993
 ;
 Q  ;no direct entry
 ;
XMIT(DGPFHIEN,DGHLEID,DGFAC,DGHLROOT,DGHL) ;transmit ORU messages
 ;This function loops through an array of treating facilities.  For
 ;each treating facility: the HL7 logical link is determined, the ORU
 ;message contained in the DGHLROOT input parameter is transmitted and
 ;an entry is created in the PRF HL7 TRANSMISSION LOG (#26.17) file.
 ;
 ;  Supported DBIA #2171:  This supported DBIA is used to access the
 ;                         Kernel API to convert a station number
 ;                         to an INSTITUTION (#4) file IEN.
 ;
 ;  Input:
 ; DGPFHIEN - pointer to PRF ASSIGNMENT HISTORY (#26.14) file
 ;  DGHLEID - event protocol ID
 ;    DGFAC - treating facilities array
 ; DGHLROOT - name of array containing formatted ORU message
 ;     DGHL - VistA HL7 environment array
 ;
 ;  Output:
 ;   Function value - returns 1 on sucess, 0 on failure
 ;
 N DGHLLNK   ;single logical link
 N DGHLS     ;name of HL7 "HLS" array
 N DGI       ;generic counter
 N DGINST    ;pointer to INSTITUTION (#4) file
 N DGLOGERR  ;error array from transmit log filer
 N DGLINST   ;pointer to INSTITUTION (#4) file for local site
 N DGRSLT    ;function value
 N HLL       ;logical links array
 N DGHLRSLT    ;message IEN on successful transmit
 ;
 S DGHLS=$NA(^TMP("HLS",$J))
 S DGLINST=$P($$SITE^VASITE(),U,1)
 S DGRSLT=0
 ;
 S DGI=0
 F  S DGI=$O(DGFAC(DGI)) Q:'DGI  D
 . N DGHLRSLT
 . N DGLOGERR
 . ;
 . ;convert the station number to INSTITUTION (#4) file IEN
 . S DGINST=+$$IEN^XUAF4($P(DGFAC(DGI),U,1))
 . Q:'DGINST!(DGINST=DGLINST)
 . ;
 . ;must be a medical treating facility
 . Q:'$$TF^XUAF4(DGINST)
 . ;
 . ;get the HL7 LOGICAL LINK associated with the institution
 . S DGHLLNK=$$GETLINK^DGPFHLUT(DGINST)
 . Q:DGHLLNK=0
 . ;
 . ;copy formatted message to HL7 "HLS" array
 . K @DGHLS
 . M @DGHLS=@DGHLROOT
 . ;
 . ;build HLL logical link
 . S HLL("LINKS",1)="DGPF PRF ORU/R01 SUBSC"_U_DGHLLNK
 . ;
 . ;generate the message
 . D GENERATE^HLMA(DGHLEID,"GM",1,.DGHLRSLT,"","")
 . Q:$P(DGHLRSLT,U,2)]""
 . ;
 . ;store the message ID and destination site in the HL7 transmission log
 . D STOXMIT^DGPFHLL(DGPFHIEN,$P(DGHLRSLT,U),DGINST,.DGLOGERR)
 . Q:$D(DGLOGERR)
 . ;
 . ;success
 . S DGRSLT=1
 ;
 Q DGRSLT
