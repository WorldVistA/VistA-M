ORWPFSS ; SLC/REV/GSS - CPRS PFSS Calls; 11/15/04 [11/15/04 11:43am]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**215,228**;Dec 17, 1997
 ; Sub-routines for phase II of the CPRS PFSS project except for
 ;   tag PFSSACTV which (with different code) is in CPRS v26 or phase I
 ;
 Q
 ;
PFSSACTV(ORY) ; Is PFSS active for this system/user/etc?
 ; RPC called by Delphi to determine if passing visit string
 ;
 ; 1 = PFSS active - pass visit string with order
 ; 0 = PFSS not active - do not pass visit string
 ;
 ;$$SWSTAT^IBBAPI() WILL BE RELEASED IN IB*2*286, as per E.Zeigler
 ;
 ;Check for IB patch
 S ORY=+$$PATCH^XPDUTL("IB*2.0*286") Q:ORY=0
 ;Check PFSS master switch status (1=On, 0=Off) 
 S ORY=+$$SWSTAT^IBBAPI()  ;IA #4663
 Q
 ;
ORACTREF(ORACTREF,ORIEN) ;Return PFSS Account Reference Number (ARN)
 ; PFSS ARN in order file (#100) as field #97, i.e., ^OR(100,ORIEN,5.5)
 ; This API is covered under IA #4673
 ;
 ; Access as D ORACTREF^ORWPFSS(.ORACTREF,ORIEN), where
 ;    ORIEN      Order IEN
 ;    ORACTREF   returned in internal format, i.e., pointer to file #375
 ;
 ; Input:
 ;   ORIEN     Order internal reference number related to PFSS ARN
 ; Output:
 ;   ORACTREF  PFSS Account Reference Number
 ;
 ; new variables
 N ORERCK,ORPKG,OIREC,OIV,OIVN
 ; initialize PCE Account Reference Number variable
 S ORACTREF=""
 ; check for a valid ORIEN
 S ORERCK=$$ORDERCK(ORIEN) Q:+ORERCK>1
 ; get PFSS ARN from Order File (#100)
 S ORACTREF=$$GET1^DIQ(100,ORIEN_",",97,"I","","")
 Q
 ;
ORDERCK(ORIEN) ; check validity of Order IEN (ORIEN)
 ; used by ORWPFSS & ORWPFSS1, access as $$ORDERCK^ORWPFSS(ORIEN)
 ;
 ; Input:
 ;   ORIEN    Order internal reference number related to PFSS ARN
 ; Output:
 ;   if error, returns #^reason, where #>1
 ;   if valid, returns 1
 ;
 ; quit if ORIEN is null
 I $G(ORIEN)="" Q 90_U_"ORIEN IS NULL"
 ; quit if order is a document/note, i.e., not an order
 I ORIEN=0 Q 91_U_"ORIEN IS A DOCUMENT/NOTE"
 ; quit if ORIEN value is invalid, e.g., no such order
 I $D(^OR(100,ORIEN,0))'=1 Q 92_U_"ORIEN IS AN INVALID ORDER NUMBER"
 ; determine if package type supported
 I '$$PKGTYP(ORIEN) Q 93_U_"PACKAGE TYPE NOT SUPPORTED"
 ; ORIEN is valid
 Q 1
 ;
PKGTYP(ORIEN) ; Build CPRS PFSS supported packages array
 ; returns 1 if order package type supported, otherwise returns 0
 ; LR=Lab, RA=Radiology
 ; to add a package, include it above (documentation) & in For stmt below
 ;
 N I,ORPKG,ORPKGARY
 F I=1:1 S ORPKG=$P("LR;RA",";",I) Q:ORPKG=""  D
 . ; create ORPKGARY array of supported package types
 . S ORPKGARY(+$O(^DIC(9.4,"C",ORPKG,0)))=ORPKG  ; ^DIC(9.4) is pkg file
 ; yes, order passed is of a package type that is supported
 I $D(ORPKGARY($P(^OR(100,ORIEN,0),U,14))) Q 1
 Q 0  ; package type not supported
