MAGTP008 ;WOIFO/FG,MLH,JSL - TELEPATHOLOGY TAGS ; 17 Apr 2013 2:52 PM
 ;;3.0;IMAGING;**138**;Mar 19, 2002;Build 5380;Sep 03, 2013
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
 ;***** INITIALIZE SESSION (COLLECT USER INFO)
 ;      SEE USERINF2^MAGJUTL3
 ; RPC: MAGTP GET USER
 ;
 ; .MAGRY      Reference to a variable naming the global to store returned data
 ;
 ; Input Parameters
 ; ================
 ; N/A
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
 ;                ^01: DUZ
 ;                ^02: NAME
 ;                ^03: INITIALS
 ;                ^04: SSN
 ;                ^05: UserLocalStationNumber
 ;                ^06: PrimarySiteStationNumber
 ;                ^07: SiteServiceURL
 ;                ^08: SiteCode
 ;                ^09: SiteName
 ;                ^10: Production account? 0:"NO",1:"YES"
 ;
 ; MAGRY(1:N)    Description
 ;                 LAB DATA file (#63) Security Keys
 ;
USERINF(MAGRY) ; RPC [MAGTP GET USER]
 K MAGRY
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 I +$G(DUZ)=0 S MAGRY(0)="0^0^DUZ Undefined, Null or Zero" Q
 I +$G(DUZ(2))=0 S MAGRY(0)="0^0^DUZ(2) Undefined, Null or Zero" Q
 N MAGPL,SSUNC,VIXPTR,KEY,CT
 ;
 S MAGRY(0)=DUZ_U_$$GET1^DIQ(200,DUZ_",",.01)_U_$$GET1^DIQ(200,DUZ_",",1)  ; IA #10060
 ;
 ; Add pieces ^04:^06 for VIX
 S MAGRY(0)=MAGRY(0)_U_$$GET1^DIQ(200,DUZ_",",9)  ;...SSN                  ; IA #10060
 S MAGRY(0)=MAGRY(0)_U_$$GET1^DIQ(4,DUZ(2),99,"E")  ;.UserLocalStationNumber
 S MAGRY(0)=MAGRY(0)_U_$P($$SITE^VASITE(),U,3)  ;.....PrimarySiteStationNumber
 ;
 ; Lookup SiteServiceURL
 S MAGPL=$$PLACE^MAGBAPI(+$G(DUZ(2)))          ; Get place for DUZ(2)
 S VIXPTR=$$GET1^DIQ(2006.1,MAGPL,55,"I")      ; Net site service
 ;
 ; Return UNC only if OpStatus is 'online'
 I VIXPTR,+$$GET1^DIQ(2005.2,VIXPTR,5,"I") D
 . S SSUNC=$$GET1^DIQ(2005.2,VIXPTR,1)
 S MAGRY(0)=MAGRY(0)_U_$G(SSUNC)  ;...................SiteServiceURL
 S MAGRY(0)=MAGRY(0)_U_$$GET1^DIQ(2006.1,MAGPL,.09)  ;SiteCode
 S MAGRY(0)=MAGRY(0)_U_$$GET1^DIQ(2006.1,MAGPL,.01)  ;SiteName
 S MAGRY(0)=MAGRY(0)_U_$S($L($T(PROD^XUPROD)):+$$PROD^XUPROD,1:0)  ; IA #4440
 ;
 ; KEYS
 S KEY="LR",CT=0                               ; Find LAB DATA file keys
 F  S KEY=$O(^XUSEC(KEY)) Q:$E(KEY,1,2)'="LR"  D     ; IA #10076
 . I $D(^XUSEC(KEY,DUZ)) S CT=CT+1,MAGRY(CT)=KEY     ; IA #10076
 Q  ;
 ;
 ;+++++ GET THE ABBREVIATION FOR A SITE IEN FROM FILE (#2006.19)
 ;
 ; SITE          Site Number (IEN)
 ;
 ; Return Value
 ; ============
 ;
 ; ABBR          Abbreviation for SITE
 ;
GETABBR(SITE) ;
 Q:'$G(SITE) ""
 N MAGREC,ABBR
 S MAGREC=$O(^MAG(2006.19,"D",SITE,""))
 S ABBR=$S(MAGREC:$P($G(^MAG(2006.19,MAGREC,0)),U,4),1:"")
 Q ABBR
