MHVRQI ;WAS/GPM - Request Manager Immediate Mode ; 7/28/05 11:49pm [12/14/06 11:38am]
 ;;1.0;My HealtheVet;**2**;Aug 23, 2005;Build 22
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
REALTIME(REQ,XMT,HL) ; Manage immediate mode / real time requests
 ;
 ;  Triage, execute/extract and respond to real time requests and
 ; queries.  If the request is rejected (blocked, or doesn't support
 ; real time access), send a negative acknowledgement, otherwise call
 ; the execute/extraction routine.  If there are no errors transmit
 ; the results, send a negative acknowledgement if there are errors.
 ;
 ; Input:
 ;      REQ - Parsed query and query parameters
 ;      XMT - Transmission parameters
 ;       HL - HL7 package array variable
 ;
 ; Output:
 ;      Extract information and respond to query
 ;
 N ERR,DATAROOT,MHVDATA
 S DATAROOT="^TMP(""MHVEXTRACT"","_$J_","_REQ("TYPE")_")"
 S ERR=""
 ;
 D LOG^MHVUL2("REQUEST MGR - IMMEDIATE","BEGIN","S","TRACE")
 ;
 I $$REJECT(.REQ,.ERR) D  Q
 . D LOG^MHVUL2("REQUEST CHECK","REJECT^"_ERR,"S","ERROR")
 . D XMIT^MHV7T(.REQ,.XMT,ERR,"",.HL)
 D LOG^MHVUL2("REQUEST CHECK","PROCESS","S","TRACE")
 ;
 I '$$EXECUTE(.REQ,.ERR,.DATAROOT) D  Q
 . D LOG^MHVUL2("REQUEST EXECUTE","ERROR^"_ERR,"S","ERROR")
 . D XMIT^MHV7T(.REQ,.XMT,ERR,DATAROOT,.HL)
 D LOG^MHVUL2("REQUEST EXECUTE","COMPLETE","S","TRACE")
 ;
 D XMIT^MHV7T(.REQ,.XMT,ERR,DATAROOT,.HL)
 K @DATAROOT
 ;
 D LOG^MHVUL2("REQUEST MGR - IMMEDIATE","END","S","TRACE")
 ;
 Q
 ;
REJECT(REQ,ERR) ;Check to see if request can be processed
 S ERR=""
 I REQ("BLOCKED") D  Q 1
 . S ERR="^207^AR^Request Type Blocked by Site"
 . I $D(REQ("QPD")) S ERR="QPD^1^4"_ERR Q    ;QBP query flag the QPD
 . I $D(REQ("QRD")) S ERR="QRD^1^10"_ERR Q   ;old style query flag QRD
 . S ERR="MSH^1^9"_ERR                       ;not a query flag MSH
 . Q
 I 'REQ("REALTIME") D  Q 1
 . S ERR="^207^AR^Real Time Calls Not Supported By Request Type"
 . I $D(REQ("QPD")) S ERR="RCP^1^1"_ERR Q    ;QBP query flag RCP
 . I $D(REQ("QRD")) S ERR="QRD^1^3"_ERR Q    ;old style query flag QRD
 . S ERR="MSH^1^9"_ERR                       ;not a query flag MSH
 . Q
 Q 0
 ;
EXECUTE(REQ,ERR,DATAROOT) ;Execute action or extraction
 ;Calls the execute routine for this request type
 ;For queries this is the extraction routine
 ;Parameters can be passed on REQ
 ;Errors are passed on ERR
 ;
 ; DATAROOT is passed by reference because extractors are permitted
 ; to change the root referenced.  This allows on the fly use of
 ; local variables and globals produced by calls to other packages.
 ; Care must be given when using locals because they cannot be NEWed.
 ; MHVDATA is NEWed above, and can be safely used.
 ; The KILL in the main loop above will clean up.
 ;
 S ERR=""
 D @(REQ("EXECUTE")_"(.REQ,.ERR,.DATAROOT)")
 I ERR D  Q 0
 . S ERR="^207^AR^"_$P(ERR,"^",2)
 . I $D(REQ("QPD")) S ERR="QPD^1^4"_ERR Q    ;QBP query flag the QPD
 . I $D(REQ("QRD")) S ERR="QRD^1^10"_ERR Q   ;old style query flag QRD
 . S ERR="MSH^1^9"_ERR                       ;not a query flag MSH
 . Q
 Q 1
 ;
