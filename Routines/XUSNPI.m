XUSNPI ;OAK_BP/BDT - NATIONAL PROVIDER IDENTIFIER ;6/3/08  13:51
 ;;8.0;KERNEL;**410,416,480**; July 10, 1995;Build 38
 ;;Per VHA Directive 2004-038, this routine should not be modified
ADDNPI(XUSQI,XUSIEN,XUSNPI,XUSDATE,XUSTATUS) ;
 ;;==============================================================
 ;; Update the Effective Date, Status & NPI trio.
 ;; XUSQI   : Qualified Identifier, Required. For examble: Individual_ID Or Organization_ID
 ;; XUSIEN  : Internal Entry Number. Required.
 ;; XUSNPI  : National Provider Identifier. Required.
 ;; XUSDATE : Active Date. Required.
 ;; 
 ;; If successful, return XUSRTN = IEN of new 42 sub-file entry.
 ;; Else return XUSRTN = "-1^ErrorMessage".
 ;; =============================================================
 ;
 ; Check valid inputs.
 N XUSROOT,XUSFNB
 S XUSROOT=$$GET^XPAR("PKG.KERNEL","XUSNPI QUALIFIED IDENTIFIER",XUSQI)
 I $E(XUSROOT)'="^" S XUSROOT="^"_XUSROOT
 I XUSROOT="^" Q "-1^Invalid Qualified Identifier"
 I $$GLCK(XUSROOT)'>0 Q "-1^Invalid Qualified Identifier"
 S XUSFNB=+$P(XUSROOT,"(",2)
 I 'XUSFNB Q "-1^No File #"
 S XUSFNB=XUSFNB_".42"
 I $G(XUSIEN)'>0 Q "-1^Invalid IEN"
 ;I (XUSIEN?.N)=0 Q "-1^Invalid IEN"
 I ((XUSIEN?.N)!(XUSIEN?.N1"."1N.N))=0 Q "-1^Invalid IEN"
 N XUIENCK S XUIENCK=XUSROOT_XUSIEN_","_0_")" I '$D(@XUIENCK) Q "-1^Invalid IEN"
 I '$$CHKDGT(XUSNPI) Q "-1^Invalid NPI"
 I '$$CHKDT(XUSQI,XUSIEN,XUSDATE) Q "-1^Invalid Effective Date"
 I $G(XUSTATUS)="" S XUSTATUS=1
 I (XUSTATUS'=0),(XUSTATUS'=1) Q "-1^Invalid Status"
 N CHNPI S CHNPI=$$CHKDGT^XUSNPIE1(XUSNPI,XUSIEN,XUSQI) ; check if NPI is being used.
 I CHNPI'=1 Q "-1^The NPI is being used."
 ;
 ;------------------------------------------------------------------
 N ZZ,XUSRTN,ERRMSG,XUSX S ERRMSG=""
 S XUSX=XUSROOT_XUSIEN_","_"""NPISTATUS"""_")"
 ; Update Effective Date #42 multiple fields 
 S XUSFNB=$P(XUSROOT,"(",2)
 S XUSFNB=+$P(XUSFNB,",") I XUSFNB S XUSFNB=XUSFNB_".042"
 S ZZ(1,XUSFNB,"+2,"_XUSIEN_",",.01)=XUSDATE
 S ZZ(1,XUSFNB,"+2,"_XUSIEN_",",.02)=XUSTATUS
 S ZZ(1,XUSFNB,"+2,"_XUSIEN_",",.03)=XUSNPI
 D UPDATE^DIE("","ZZ(1)",,ERRMSG)
 I $L(ERRMSG) Q "-1^"_$G(ERRMSG)
 S XUSX=XUSROOT_XUSIEN_","_"""NPISTATUS"""_","_"""B"""_","_XUSDATE_","_"""A"""_")"
 S XUSRTN=$O(@XUSX,-1)
 I '+XUSRTN Q "-1^No entry add"
 Q XUSRTN
 ;
NPI(XUSQI,XUSIEN,XUSDATE) ; Retrieve the NPI value for a qualified identifier entity.
 ;;==============================================================
 ;; XUSQI   : Qualified Identifier, Required. For examble: Individual_ID Or Organization_ID
 ;; XUSIEN  : Internal Entry Number of file #4 or #200. Required.
 ;; XUSDATE : Active Date. Not Required. Default: 'Today'.
 ;; 
 ;; If current NPI exists, return XUSRTN = 'NPI^EffectiveDate^Status'
 ;; If invalid XUSQI or XUSIEN, return '-1^ErrorMessage'
 ;; Else return 0
 ;; =============================================================
 ; check valid inputs
 I $G(XUSIEN)'>0 Q "-1^Invalid IEN"
 ;I (XUSIEN?.N)=0 Q "-1^Invalid IEN"
 I ((XUSIEN?.N)!(XUSIEN?.N1"."1N.N))=0 Q "-1^Invalid IEN"
 I $G(XUSDATE)="" S XUSDATE=$$NOW^XLFDT
 N X,Y,%DT S %DT="T",X=XUSDATE D ^%DT I Y'=XUSDATE Q "-1^Invalid Effective Date"
 ;-----------------------------------
 N XUSDA,XUSI,XUSRTN,XUSROOT,XUSX,XUSTAT S (XUSDA,XUSRTN)="",XUSTAT="Inactive"
 ; get global from Parameter file base on Qualified Identifier.
 S XUSROOT=$$GET^XPAR("PKG.KERNEL","XUSNPI QUALIFIED IDENTIFIER",XUSQI)
 I $E(XUSROOT)'="^" S XUSROOT="^"_XUSROOT
 I XUSROOT="^" Q "-1^Invalid Qualified Identifier"
 N XUIENCK S XUIENCK=XUSROOT_XUSIEN_","_0_")" I '$D(@XUIENCK) Q "-1^Invalid IEN"
 I $$GLCK(XUSROOT)'>0 Q "-1^Invalid Qualified Identifier"
 S XUSROOT=XUSROOT_XUSIEN_","_"""NPISTATUS"""
 S XUSX=XUSROOT_")" I '$D(@XUSX) Q "-1^No NPI found"
 S XUSI=0 F  S XUSI=$O(@(XUSROOT_","_"""B"""_","_XUSI_")")) Q:XUSI>XUSDATE!'XUSI
 I 'XUSI S XUSX=XUSROOT_","_"""B"""_","_"""A"""_")",XUSDA=$O(@XUSX,-1)
 I XUSI>XUSDATE S XUSX=XUSROOT_","_"""B"""_","_XUSI_")",XUSDA=$O(@(XUSX),-1)
 I XUSDA="" Q 0
 S XUSDA=XUSROOT_","_"""B"""_","_XUSDA_","_"""A"""_")",XUSDA=$O(@XUSDA,-1)
 S XUSRTN=XUSROOT_","_XUSDA_","_0_")"
 I '$D(@XUSRTN) Q "-1^Invalid IEN"
 I $P($G(@XUSRTN),"^",2)=1 S XUSTAT="Active"
 Q $P($G(@XUSRTN),"^",3)_"^"_$P($G(@XUSRTN),"^",1)_"^"_XUSTAT
 ;       
QI(XUSNPI) ; Retrieve the ALL qualified indentifier entity for an NPI value.
 ;;================================================
 ;; XUSNPI  : National Provider Identifier. Required
 ;; 
 ;; If qualified identified entity exists, return
 ;; 'QualifiedIdentifier^IEN^EffectiveDate^Status;'
 ;; If more than one records found, they are separated by ";"
 ;; Else return 0        
 ;;================================================
 ; check valid NPI
 I '$$CHKDGT(XUSNPI) Q "0^Invalid NPI"
 N ZZ
 D GETLST^XPAR(.ZZ,"PKG.KERNEL","XUSNPI QUALIFIED IDENTIFIER")
 I ZZ'>0 Q 0
 N XUSI,XUSIEN,XUSROOT,XUSQT,XUSX,XUSRTN,XUSRTN1 S (XUSQT,XUSRTN)=0,XUSRTN1=""
 S XUSI=0 F  S XUSI=$O(ZZ(XUSI)) Q:'XUSI  D
 . S XUSROOT=$P(ZZ(XUSI),"^",2),XUSROOT="^"_XUSROOT
 . I $$GLCK(XUSROOT)'>0 Q  ;check valid global root
 . I $E(XUSNPI,1,1)=0 S XUSNPI=""""_XUSNPI_""""
 . S XUSX=XUSROOT_"""NPI42"""_","_XUSNPI_")" Q:'$D(@XUSX)
 . S XUSIEN=0 F  S XUSX=XUSROOT_"""NPI42"""_","_XUSNPI_","_XUSIEN_")",XUSIEN=$O(@XUSX) Q:XUSIEN'>0  D
 . . S XUSRTN=$$SRCHNPI(XUSROOT,XUSIEN,XUSNPI)
 . . I +XUSRTN S XUSRTN1=XUSRTN1_$P(ZZ(XUSI),"^")_"^"_XUSRTN_";",XUSQT=XUSQT+1
 I XUSRTN1="" S XUSRTN1=0
 Q XUSRTN1
 ;
GLCK(XUSROOT) ; check valid global root
 N XUFNB,ZZ
 I $G(XUSROOT)="" Q 0
 S XUFNB=$P(XUSROOT,"(",2),XUFNB=$P(XUFNB,",")
 D FILE^DID(XUFNB,"","GLOBAL NAME","ZZ")
 Q (XUSROOT=$G(ZZ("GLOBAL NAME")))
 ;
SRCHNPI(XUSROOT,XUSIEN,XUSNPI) ;
 I $G(XUSIEN)'>0 Q 0
 I (XUSIEN?.N)=0 Q 0
 N XUSX,XUSRTN S XUSRTN=0
 I $E(XUSNPI,1,1)=0 S XUSNPI=""""_XUSNPI_""""
 S XUSX=XUSROOT_XUSIEN_","_"""NPISTATUS"""_","_"""C"""_","_XUSNPI_")"
 I '$D(@XUSX) Q 0
 S XUSX=XUSROOT_XUSIEN_","_"""NPISTATUS"""_","_"""C"""_","_XUSNPI_","_"""A"""_")"
 S XUSRTN=$O(@XUSX,-1)
 I '+XUSRTN Q 0
 S XUSX=XUSROOT_XUSIEN_","_"""NPISTATUS"""_","_XUSRTN_","_0_")"
 I '$D(@XUSX) Q 0
 S XUSRTN=$G(@XUSX) I XUSRTN S XUSRTN=XUSIEN_"^"_$P(XUSRTN,"^")_"^"_$P(XUSRTN,"^",2)
 I $P(XUSRTN,"^",3)=1 S $P(XUSRTN,"^",3)="Active"
 I $P(XUSRTN,"^",3)=0 S $P(XUSRTN,"^",3)="Inactive"
 Q XUSRTN
 ;
CHKDGT(XUSNPI) ;
 ;  Function to validate the format of an NPI number.  It checks the
 ;  length of the number, whether the NPI is numeric, and whether
 ;  the check digit is valid.
 ;
 ;  Input parameter:
 ;    NPI - 10-digit NPI number to validate.
 ;
 ;  Output parameter:
 ;    Boolean value indicating whether the NPI has a valid format
 ;
 ;  NPI must be 10 digits long.
 I XUSNPI'?10N Q 0
 Q $E(XUSNPI,10)=$$CKDIGIT($E(XUSNPI,1,9))
 ;
CKDIGIT(XUSNPI) ;
 ;  Function to calculate and return the check digit of an NPI.
 ;  The check digit is calculated using the Luhn Formula for
 ;  Modulus 10 "double-add-double" Check Digit.  A value of 24 is
 ;  added to the total to account for the implied USA (80840) prefix.
 ;
 N XUSCTOT,XUSCN,XUSCDIG,XUSI
 S XUSCTOT=24
 F XUSI=9:-2:1 S XUSCN=2*$E(XUSNPI,XUSI),XUSCTOT=XUSCTOT+$E(XUSCN)+$E(XUSCN,2)+$E(XUSNPI,XUSI-1)
 S XUSCDIG=150-XUSCTOT
 Q $E(XUSCDIG,$L(XUSCDIG))
 ;
CHKDT(XUSQI,XUSIEN,XUSDATE) ; Check Date
 ;;============================================================================
 ;;  XUSQI   : Qualified Identifier. Required. For examble: "Individual_ID"
 ;;  XUSIEN  : Internal Entry Number. Required.
 ;;  XUSDATE : The Effective Date value to test. Must be FM date. Required. 
 ;;  
 ;;  If input passes date comparison, return 1.
 ;;  Else return 0.
 ;;============================================================================
 ; 
 I $G(XUSIEN)'>0 Q "0^Invalid IEN."
 ;I (XUSIEN?.N)=0 Q "0^Invalid IEN."
 I ((XUSIEN?.N)!(XUSIEN?.N1"."1N.N))=0 Q "-1^Invalid IEN"
 N X,Y,%DT S %DT="T",X=$G(XUSDATE) D ^%DT I Y'=XUSDATE Q "0^Invalid Effective Date. Must be FM Date/Time."
 ;-----------------------------------
 N XUSROOT,XUSDA
 N XUSCRDT S XUSCRDT=$$NOW^XLFDT I XUSDATE>XUSCRDT Q 0
 ; get global from Parameter file base on Qualified Identifier.
 S XUSROOT=$$GET^XPAR("PKG.KERNEL","XUSNPI QUALIFIED IDENTIFIER",XUSQI)
 I $E(XUSROOT)'="^" S XUSROOT="^"_XUSROOT
 I XUSROOT="^" Q "0^Invalid Qualified Identifier."
 I $$GLCK(XUSROOT)'>0 Q "-1^Invalid Qualified Identifier"
 N XUIENCK S XUIENCK=XUSROOT_XUSIEN_","_0_")" I $D(@XUIENCK)'>0 Q "0^Invalid IEN."
 S XUSROOT=XUSROOT_XUSIEN_","_"""NPISTATUS"""_","_"""B"""_","_"""A"""_")",XUSDA=$O(@XUSROOT,-1)
 Q (XUSDATE'<XUSDA)
 ;
GETRLNPI(XUSIEN) ; Return field indicating blanket release of NPI
 ;; XUSIEN  : Internal Entry Number of person in file 200. Required
 ;; Output: -1^error message or contents of AUTHORIZE RELEASE OF NPI field.
 S XUSIEN=+$G(XUSIEN) I $G(^VA(200,XUSIEN,0))="" Q "-1^Invalid IEN"
 N X
 S X=$$NPI^XUSNPI("Individual_ID",XUSIEN)
 I (X'>0)!($P(X,U,3)'="Active") Q "-1^User has no active NPI"
 S X=$P($G(^VA(200,XUSIEN,"NPI")),U,3)
 S:X="" X=0
 Q X
 ;
