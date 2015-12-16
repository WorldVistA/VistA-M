MAGROI01 ;WOIFO/FG,JSL - Release Of Information(ROI) RPCS ; 11/13/2014 11:37pm
 ;;3.0;IMAGING;**138,157**;Mar 19, 2002;Build 16;Nov 13, 2014
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q  ;
 ;
 ;+++++ GET LIST OF TRANSMIT DESTINATIONS TO QUEUE DICOM IMAGES
 ; RPC: MAG GET DICOM QUEUE LIST
 ;
 ; .MAGRY        Reference to a local variable where the results
 ;               are returned to.
 ;
 ; Input Parameters
 ; ================
 ; SITE id File #4
 ;  
 ; Return Values
 ; =============
 ; 
 ; If MAGRY(0) 1st '^'-piece is 0, then an error
 ; occurred during execution of the procedure: 0^0^ ERROR explanation
 ;
 ; Otherwise, the output array is as follows:
 ;
 ; MAGRY(0)     Description
 ;                ^01: 1
 ;                ^02: Total Number of Lines
 ;                ^03: "Record Number"
 ;                ^04: "Service Name"
 ;                ^05: "IP Address"
 ;                ^06: "Port Number"
 ;                ^07: "Gateway Station Number"
 ;
 ; MAGRY(i)     Description
 ;                ^01: Record Number
 ;                ^02: Service Name
 ;                ^03: IP Address
 ;                ^04: Port Number
 ;                ^05: Gateway Station Number
 ;  
GETDCLST(MAGRY,SITE) ; RPC [MAG GET DICOM QUEUE LIST]
 K MAGRY
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 N FILE,SCREEN,MAGREC,REC,CT,SERVNAME,IPADD,PORTN,LOC
 N MAGOUT,MAGERR,MAGPL,LIS,I,TEMP
 ;
 ; Get local associated sites
 S SITE=$G(SITE)
 I (SITE'="")!($$STA^XUAF4(SITE)="")!(SITE'=+SITE) D  ; P157 - Accept IEN or STATION NUMBER
 . N IEN S IEN=$$IEN^XUAF4(SITE)  ; Check if is STATION NUMBER
 . S:IEN SITE=IEN ; INSTITUTION IEN
 . Q
 S:SITE<1 SITE=$S($G(DUZ(2)):DUZ(2),1:+$$SITE^VASITE)
 S MAGPL=$$PLACE^MAGBAPI(SITE) ; Get 2006.1 place for DUZ(2)
 D GETS^DIQ(2006.1,MAGPL,".04*","I","MAGOUT","MAGERR")
 I $D(MAGERR) S MAGRY(0)="0^0^Access Error: "_MAGERR("DIERR",1,"TEXT",1) Q 
 ; Build list of associated sites
 S LIS=","_SITE_","
 S I=""
 F  S I=$O(MAGOUT(2006.12,I)) Q:I=""  D
 . S LIS=LIS_MAGOUT(2006.12,I,.01,"I")_","
 ;
 ; Get list of queues, filter out WorkList queues and non-associated sites
 ;
 S FILE=2006.587
 K MAGOUT,MAGERR
 S SCREEN="I $$UP^XLFSTR($P(^(0),U,6))=""VISTA_SEND_IMAGE"""  ; Filter out WorkList queues
 S SCREEN=SCREEN_",(LIS[$P(^(0),U,7))"           ; Include only sites in LIS
 D LIST^DIC(FILE,"",".01;3;4;7I","","","","","",SCREEN,"","MAGOUT","MAGERR")
 I $D(MAGERR) S MAGRY(0)="0^0^Access Error: "_MAGERR("DIERR",1,"TEXT",1) Q
 S MAGREC=""
 F  S MAGREC=$O(MAGOUT("DILIST","ID",MAGREC),-1) Q:MAGREC'>0  D
 . S LOC=MAGOUT("DILIST","ID",MAGREC,7)
 . S LOC=$$STA^XUAF4(LOC)                        ; Station Number ; Supported IA #2171
 . S REC=MAGOUT("DILIST",2,MAGREC)               ; Record number in file (#2006.587)
 . S SERVNAME=MAGOUT("DILIST","ID",MAGREC,.01)   ; Name of queue
 . S IPADD=MAGOUT("DILIST","ID",MAGREC,3)        ; IP address
 . S PORTN=MAGOUT("DILIST","ID",MAGREC,4)        ; Port number
 . S TEMP(SERVNAME_U_IPADD_U_PORTN_U_LOC)=REC    ; Temporary array to sort entries
 . Q
 ;
 ; Eliminate multiple entries: ignore record number
 ;
 S (CT,I)=0
 F  S I=$O(TEMP(I)) Q:I=""  D
 . S CT=CT+1
 . S MAGRY(CT)=TEMP(I)_U_I
 . Q
 S MAGRY(0)="1^"_CT_"^Record Number^Service Name^IP Address^Port Number^Gateway Station Number"
 Q  ;
 ;
 ;+++++ QUEUE IMAGE TO A DESTINATION
 ; RPC: MAG SEND IMAGE
 ;
 ; .MAGRY        Reference to a local variable where the results
 ;               are returned to.
 ;
 ; MAGIEN        IEN of the image(s) to send
 ;
 ; QREC          Record number of the destination queue (DOS/DICOM)
 ;
 ; PRI           Priority
 ;
 ; TYPE          Type of image:
 ;                 1: MS-DOS-Copy
 ;                 2: DICOM_Send
 ;
 ; Notes
 ; =====
 ;
 ; The MS-DOS-Copy case is included here for compatibility
 ;
 ; Return Values
 ; =============
 ; 
 ; If MAGRY(0) 1st '^'-piece is 0, then an error
 ; occurred during execution of the procedure: 0^0^ ERROR explanation
 ;
 ; Otherwise, the output array is as follows:
 ;
 ; MAGRY(0)     Description
 ;                ^01: 1
 ;                ^02: 0
 ;                ^03: Image <MAGIEN> routed to queue <Queue Name> 
 ;   
MAGSEND(MAGRY,MAGIEN,QREC,PRI,TYPE) ; RPC [MAG SEND IMAGE]
 K MAGRY
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 I '$G(MAGIEN) S MAGRY(0)="0^0^No Image IEN" Q
 I $$ISDEL^MAGGI11(MAGIEN) S MAGRY(0)="0^0^Deleted Image" Q
 N FILE,QUENAM
 S FILE=$S(TYPE=1:2005.2,TYPE=2:2006.587,1:"")
 I FILE="" S MAGRY(0)="0^0^Type must be 1 (MS-DOS-Copy) or 2 (DICOM_Send)" Q
 S QUENAM=$$GET1^DIQ(FILE,$G(QREC),.01)
 I QUENAM="" S MAGRY(0)="0^0^Invalid Queue Record" Q
 D SEND^MAGBRTUT(MAGIEN,QREC,PRI,TYPE)
 S MAGRY(0)="1^0^Image "_MAGIEN_" routed to queue "_QUENAM
 Q  ;
 ;
