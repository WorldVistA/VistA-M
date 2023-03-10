DGPFHLU6 ;ALB/RPM - PRF HL7 ORU~R01 UTILITIES ; 8/31/05 1:09pm
 ;;5.3;Registration;**425,554,1005,1028**;Aug 13, 1993;Build 4
 ;Call to $$GET^XPAR supported by ICR #2263
 ;
 Q  ;no direct entry
 ;
XMIT(DGPFHIEN,DGHLEID,DGFAC,DGHLROOT,DGHL,DGHC) ;transmit ORU messages
 ;This function loops through an array of treating facilities.  For
 ;each treating facility: the HL7 logical link is determined, the ORU
 ;message contained in the DGHLROOT input parameter is transmitted and
 ;an entry is created in the PRF HL7 TRANSMISSION LOG (#26.17) file.
 ;
 ;  Supported DBIA #2171:  This supported DBIA is used to access the
 ;                         Kernel API to convert a station number
 ;                         to an INSTITUTION (#4) file IEN, and for 
 ;                         Kernel API to check whether a  station has
 ;                         to Cerner.
 ;  Supported ICR #2263:   This ICR permits the use of $$GET^XPAR to
 ;                         retrieve a parameter value.
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
 N DGSTAT    ;station number
 ;
 S DGHLS=$NA(^TMP("HLS",$J))
 S DGLINST=$P($$SITE^VASITE(),U,1)
 S DGRSLT=0
 ;
 S DGI=0
 F  S DGI=$O(DGFAC(DGI)) Q:'DGI  D
 . N DGHLRSLT
 . N DGLOGERR
 . N DGSTAT
 . ;
 . ;convert the station number to INSTITUTION (#4) file IEN
 . S DGSTAT=$P(DGFAC(DGI),U,1)
 . S DGINST=+$$IEN^XUAF4($P(DGFAC(DGI),U,1))
 . Q:('DGINST!(DGINST=DGLINST))
 . ;
 . ;must be a medical treating facility
 . Q:'$$TF^XUAF4(DGINST)
 . ;
 . ;must not be 200CRNR - patch 1005
 . Q:$$STA^XUAF4(DGINST)="200CRNR"
 . ;
 . ;get the HL7 LOGICAL LINK associated with the institution
 . S DGHLLNK=$$GETLINK^DGPFHLUT(DGINST)
 . ;
 . Q:DGHLLNK=0  ;patch 1028 - Don't try to send if there is no link.
 . ;
 . ;copy formatted message to HL7 "HLS" array
 . K @DGHLS
 . M @DGHLS=@DGHLROOT
 . ;
 . ;build HLL logical link array
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
 ;
XMIT1(DGPFHIEN,DGHLEID,DGROOT,DGHL,DGSTAT) ;
 ;  Input:
 ; DGPFHIEN - pointer to PRF ASSIGNMENT HISTORY (#26.14) file
 ;  DGHLEID - event protocol ID
 ; DGHLROOT - name of array containing formatted ORU message
 ;     DGHL - VistA HL7 environment array
 ; DGSTAT   - station IEN
 ;  Output:
 ; function value - 1 on success, 0 on failure
 ;
 ;  Supported ICR #2171:   This supported DBIA is used to access the
 ;                         Kernel API to convert a station number
 ;                         to an INSTITUTION (#4) file IEN, and for 
 ;                         Kernel API to check whether a  station has
 ;                         to Cerner.
 ;  Supported ICR #2263:   This ICR permits the use of $$GET^XPAR to
 ;                         retrieve a parameter value.
 ;
 N DGHLS     ;name of HL7 "HLS" array
 N DGRSLT    ;return value
 N HLL       ;HL7 links array
 N DGINST    ;pointer to INSTITUTION file
 N DGLOGERRR ;logging error
 N DGHLP     ;HL7 "HLP" array
 S DGINST=$$IEN^XUAF4("200CRNR") ;for logging purposes
 S DGHLS=$NA(^TMP("HLS",$J))
 K @DGHLS
 M @DGHLS=@DGROOT ;copy message to "HLS" array
 S DGRSLT=0
 ;set recipient to HC regional router
 S HLL("LINKS",1)="DGPF PRF ORU/R01 SUBSC"_U_$$GET^XPAR("SYS","DG PRF REGIONAL ROUTER",1)
 S $P(DGHLP("SUBSCRIBER"),U,5)="200CRNR"
 D GENERATE^HLMA(DGHLEID,"GM",1,.DGHLRSLT,"",.DGHLP) ;send the message
 Q:$P(DGHLRSLT,U,2)]"" DGRSLT
 D STOXMIT^DGPFHLL(DGPFHIEN,$P(DGHLRSLT,U),DGINST,.DGLOGERR) ;log it
 Q:$D(DGLOGERR) DGRSLT
 S DGRSLT=1 ;success
 Q DGRSLT
