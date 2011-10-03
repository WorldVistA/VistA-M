IBCNEUT8 ;DAOU/AM - eIV MISC. UTILITIES ;12-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine includes subroutines originally included in IBCNEUT3
 ; and referenced by IBCNEUT3 and IBCNEUT4.
 ;
 ; INSIEN returns an array of matching insurance IENs based upon the
 ; provided Insurance Name.
 ;
 ; FINDPAY returns the National IDs for all provided active insurance
 ; companies.
 ;
 ; ERROR returns the IEN of the symbol mnemonice passed to it and updates
 ; an array of items to display, if passed.
 ; 
 ; Can't be called from the top
 Q
 ;
 ;
INSIEN(INSNAME,INSIEN) ; Subroutine to find all ins co IENs
 ; matching a given ins co name
 ; Input parameter: INSNAME - Ins co name to find IENs for
 ; Output parameter: INSIEN - array of ins co IENs that
 ;   match the passed ins co name, passed by reference
 ;   If the array is defined at the time this subroutine is called,
 ;   then it will add to the data that pre-exists in the array
 ;
 N NAME
 ; Loop through the ins co names starting with a space (" ")
 ; looking for matching names
 S NAME=" " F  S NAME=$O(^DIC(36,"B",NAME)) Q:$E(NAME,1)'=" "  D
 . I $$TRIM^XLFSTR(NAME)=INSNAME M INSIEN=^DIC(36,"B",NAME)
 . Q
 ;
 ; Retrieve the ins co names from the Ins Buffer
 ; starting with the entry prior to the ins co name in
 ; the Buffer and look for ins co name matches
 S NAME=$O(^DIC(36,"B",INSNAME),-1)
 F  S NAME=$O(^DIC(36,"B",NAME)) Q:$E(NAME,1,$L(INSNAME))'=INSNAME  D
 . I $$TRIM^XLFSTR(NAME)=INSNAME M INSIEN=^DIC(36,"B",NAME)
 . Q
 ;
 Q
 ;
FINDPAY(INSIEN,PAYID) ; Find National IDs for an array of ins co IENs
 ; Input parameter: INSIEN - Array of ins co IENs
 ; Output parameter: PAYID - Array of National IDs
 N PAYIEN,IEN
 S IEN=0 F  S IEN=$O(INSIEN(IEN)) Q:'IEN  D
 . ; Discard INACTIVE ins companies from the array
 . I '$$ACTIVE^IBCNEUT4(IEN) K INSIEN(IEN) Q
 . ; Retrieve the Payer IEN for this ins co IEN
 . S PAYIEN=$P($G(^DIC(36,IEN,3)),U,10)
 . I 'PAYIEN Q
 . ; Retrieve the National ID for this ins co IEN
 . S PAYID=$P($G(^IBE(365.12,PAYIEN,0)),U,2)
 . I PAYID'="" S PAYID(PAYID)=IEN
 Q
 ;
ERROR(ERRCODE,ERRTEXT,MULTI) ; Function to return the IEN of the Symbol
 ; file entry and error text - also adds error data to ARRAY
 ; Input parameters: ERRCODE - Symbol mnemonic ("B1", "B2", etc)
 ;                   ERRTEXT - Optional additional error text
 ;                   MULTI   - Optional array of items to display
 ; Output parameters: ARRAY - Updated by this function
 ;     Function value - Symbol IEN
 NEW %,DISYS,DIW,DIWI,DIWT,DIWTC,DIWX,DN,ERRARR,I,SYMIEN,Z
 ; If an optional array of items to display was passed in, add it
 I $G(ERRTEXT)'="",$D(MULTI) S ERRTEXT=$$MULTNAME^IBCNEUT4(ERRTEXT,.MULTI)
 S SYMIEN=$$FIND1^DIC(365.15,,"X",$G(ERRCODE))
 ; call an IB utility to parse ERRTEXT into lines of acceptable length
 D FSTRNG^IBJU1($G(ERRTEXT),70,.ERRARR)
 ; Update the line counter in the error array
 S ARRAY=$G(ARRAY)+1
 ; Merge the error text array returned by the IB utility in
 M ARRAY(ARRAY)=ERRARR
 ; Reset the error-specific node of the error array to follow the
 ; published input/output parameter format
 S ARRAY(ARRAY)=SYMIEN_U_ERRARR
 Q SYMIEN
 ;
