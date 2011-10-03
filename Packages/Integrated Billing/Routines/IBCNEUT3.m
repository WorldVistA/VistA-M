IBCNEUT3 ;DAOU/AM - eIV MISC. UTILITIES ;12-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,252,271,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; The purpose of the INSERROR utility is to identify a legitimate
 ; Insurance Company name, returning the associated Payer IEN and
 ; National ID.  This extrinsic function can receive either Insurance or
 ; Buffer data, identified as TYPE I or B, respectively.
 ;
 ; The former is the simpler case.  The IEN, in this case the Insurance
 ; IEN, is validated using the following criteria (some of which is
 ; validated in routine IBCNEUT4) :
 ;
 ; [1] Does it have a National ID?
 ; [2] Does the National ID have eIV defined?
 ; [3] Is the Payer active (i.e. the deactivated flag is turned off)
 ; [4] Is the national connection enabled?
 ; [5] Is the National ID blocked by VISTA?
 ;
 ; If all 5 criteria are met, the Payer IEN and National ID are
 ; returned.  If not, an error is generated and returned in ARRAY with
 ; information specific to the type of problem encountered.
 ;
 ; If the TYPE passed is B for Buffer, the IEN is the Buffer IEN.
 ; The Insurance Company name is retrieved from the Buffer file and
 ; leading and trailing spaces are stripped.  This value is compared to
 ; the entries in the "B" cross reference of the Insurance Company file
 ; (whose values have also been stripped of leading and trailing spaces).
 ; If a match (or several matches) is found,and a unique National ID is
 ; identified, confirm the 5 set of insurance validation criteria and
 ; process as above.
 ;
 ; If no match in the Insurance Company could be made, check the Auto
 ; Match file.  If a unique IEN is identified, confirm the 5 set of
 ; criteria stated above and process in kind.
 ;
 ; If no match could be established in both the Insurance Company and the
 ; Auto Match files, check the insurance company synonym file (stripping 
 ; off leading and trailing spaces) while preserving case sensitivity.
 ; If a unique Insurance Company could be identified, confirm the 5 set
 ; of validation criteria and process as above. 
 ;
 ; 
 ; Can't be called from the top
 Q
 ;
 ;
INSERROR(TYPE,IEN,ERRFLG,ARRAY) ;
 ; Formal parameters:
 ;  TYPE:   Type of IEN passed in the second parameter.
 ;          Either "B" for "Buffer" or "I" for "Insurance".
 ;          Mandatory, passed by value.
 ;  IEN:    IEN to perform a lookup for. Mandatory, passed by value.
 ;  ERRFLG: Error flag. "" or 0 if no extended error information is
 ;          requested, 1 if extended error information is requested.
 ;          Optional (the default is 0), passed by value.
 ;  ARRAY:  Array of error messages returned by the function.
 ;          Optional, passed by reference. Whatever is passed in will be
 ;          KILLed by the function. The structure of the return array is
 ;          as follows:
 ;          ARRAY         # of error messages passed back
 ;          ARRAY(error#) Data for this error number, including error
 ;          number 1 present in the value returned by the function.
 ;                [1]   IEN of the error code in the symbol file
 ;                [2]   # of lines in the error message text
 ;          ARRAY(error #,line #) - One line of error message text
 ;                                  up to 70 characters long
 ;
 ;          Returned value consists of the following "^"-delimited pcs:
 ;           [1]   The IEN of the IIV SYMBOL File (#365.15) entry for
 ;                 the first error condition encountered by the function.
 ;                 This is only present if a valid Payer was not found.
 ;           [2]   Payer IEN if a Payer was found, "" otherwise
 ;           [3]   National ID if a Payer was found
 ;
 ; Initialize all variables used in this program
 N INSIEN,INSNAME,NAMEARR,PAYID,PAYIEN,SYMIEN
 ; Initialize return variables
 S (PAYID,PAYIEN,SYMIEN)=""
 ; If the calling program didn't pass the Extended Error flag, init it
 S ERRFLG=+$G(ERRFLG)
 ; Initialize array of extended error info to be returned
 K ARRAY
 ; Validate input parameters
 I $G(TYPE)'="B",$G(TYPE)'="I" S SYMIEN=$$ERROR^IBCNEUT8("B9","IEN type "_$G(TYPE)_" passed to the insurance match algorithm is neither 'B' nor 'I'.") G EXIT
 I $G(IEN)="" S SYMIEN=$$ERROR^IBCNEUT8("B9","IEN is not passed to the insurance match algorithm.") G EXIT
 I TYPE="B",'$D(^IBA(355.33,IEN)) S SYMIEN=$$ERROR^IBCNEUT8("B9","Invalid Buffer IEN "_IEN_" has been passed to the insurance match algorithm.") G EXIT
 I TYPE="I",'$D(^DIC(36,IEN)) S SYMIEN=$$ERROR^IBCNEUT8("B9","Invalid Insurance Company IEN "_IEN_" has been passed to the insurance match algorithm.") G EXIT
 ;
 ; If the IEN is an Insurance Company IEN, validate it
 I TYPE="I" D  G EXIT
 . N TMP
 . ; Check to see if ins co is ACTIVE
 . S TMP=$$ACTIVE^IBCNEUT4(IEN)
 . I 'TMP S SYMIEN=$$ERROR^IBCNEUT8("B10","Insurance Company "_$P(TMP,U,2)_" is not active.") Q
 . D VALID^IBCNEUT4(IEN,.PAYIEN,.PAYID,.SYMIEN)
 ;
 ; Retrieve the ins co name from the Ins Buffer
 S INSNAME=$$TRIM^XLFSTR($P($G(^IBA(355.33,IEN,20)),U,1))
 I INSNAME="" S SYMIEN=$$ERROR^IBCNEUT8("B13") G EXIT
 ; Retrieve all ins co IENs matching this ins co name
 D INSIEN^IBCNEUT8(INSNAME,.INSIEN)
 ; 
 ; If one or more ins. co. name matches found, retrieve Payer info
 I $D(INSIEN) D  G EXIT
 . ; If there is one INSIEN - make sure it is ACTIVE
 . I $O(INSIEN(""))=$O(INSIEN(""),-1),'$$ACTIVE^IBCNEUT4($O(INSIEN(""))) S SYMIEN=$$ERROR^IBCNEUT8("B10","Insurance company "_INSNAME_" is not active.") Q
 . ; Find National IDs for these ins co IENs
 . D FINDPAY^IBCNEUT8(.INSIEN,.PAYID)
 . ; There were Multiple INSIENs - if none exist ALL were INACTIVE
 . I '$D(INSIEN) S SYMIEN=$$ERROR^IBCNEUT8("B10","All insurance companies named "_INSNAME_" are not active.") Q
 . ; Quit with an error if no Payer is found for these ins cos
 . I $O(PAYID(""))="" S SYMIEN=$$ERROR^IBCNEUT8("B4","Insurance company "_INSNAME_" is not linked to a Payer.") Q
 . ; Quit with an error if more than one Payer found
 . I $O(PAYID(""))'=$O(PAYID(""),-1) S SYMIEN=$$ERROR^IBCNEUT8("B3","There are multiple Insurance companies named "_INSNAME_" in the Insurance Company file that are linked to more than one Payer",.PAYID),PAYID="" Q
 . ; Validate the found unique Payer
 . D VALID^IBCNEUT4(PAYID($O(PAYID(""))),.PAYIEN,.PAYID,.SYMIEN)
 ;
 ; If no exact ins co name match was found, check AutoMatch file
 ; No need to filter out inactives as the AMLOOK will handle it
 I $$AMLOOK^IBCNEUT1(INSNAME,1,.NAMEARR) D  I $D(INSIEN) G EXIT
 . N NAME
 . ; Based on the array of ins cos returned by the AutoMatch
 . ; build an array of ins co IENs that they point to
 . S NAME="" F  S NAME=$O(NAMEARR(NAME)) Q:NAME=""  D INSIEN^IBCNEUT8($$TRIM^XLFSTR(NAME),.INSIEN)
 . ; If nothing found in the Insurance Co x-ref, quit w/o validation
 . I '$D(INSIEN) Q
 . ; Check if there is more than one ins co IEN that matches
 . ; the entered name, in which case exit with an error
 . I $O(INSIEN(""))'=$O(INSIEN(""),-1) S SYMIEN=$$ERROR^IBCNEUT8("B2","Insurance company name "_INSNAME_" in the Insurance Buffer matched more than one insurance company in the Auto Match file",.NAMEARR) Q
 . ; Validate the found unique ins co IEN
 . D VALID^IBCNEUT4($O(INSIEN("")),.PAYIEN,.PAYID,.SYMIEN)
 ;
 ;  If the first two lookups failed, check the Ins Co Synonym file:
 ; Retrieve all ins co IENs that match in the Synonym file
 M INSIEN=^DIC(36,"C",INSNAME)
 ;
 ; If nothing found in the Synonym file, error out
 I '$D(INSIEN) S SYMIEN=$$ERROR^IBCNEUT8("B1","Insurance company "_INSNAME_" could not be matched to a valid entry in the Insurance Company file.") G EXIT
 ; Loop thru the ins co IENs that matched in the Synonym file
 S INSIEN=0 F  S INSIEN=$O(INSIEN(INSIEN)) Q:'INSIEN  D
 . N NAME
 . ; Retrieve the ins co name for this IEN
 . S NAME=$$TRIM^XLFSTR($P($G(^DIC(36,INSIEN,0)),U,1))
 . I NAME'="" S NAMEARR(NAME)=""
 ;
 ; If more than one ins co name was found, error out
 I $O(NAMEARR(""))'=$O(NAMEARR(""),-1) D  G EXIT
 . S SYMIEN=$$ERROR^IBCNEUT8("B2","Insurance company name "_INSNAME_" in the Insurance Buffer matched more than one insurance company name in the Synonym cross-reference of the Insurance Company file",.NAMEARR)
 ;
 ; If there is one INSIEN - make sure it is ACTIVE
 I $O(INSIEN(""))=$O(INSIEN(""),-1),'$$ACTIVE^IBCNEUT4($O(INSIEN(""))) S SYMIEN=$$ERROR^IBCNEUT8("B10","Insurance company "_INSNAME_" is not active.") G EXIT
 ; Find Payers for these ins co IENs
 D FINDPAY^IBCNEUT8(.INSIEN,.PAYID)
 ;
 ; There were Multiple INSIENs - if none exist ALL were INACTIVE
 I '$D(INSIEN) S SYMIEN=$$ERROR^IBCNEUT8("B10","All insurance companies named "_INSNAME_" are not active."),PAYID="" G EXIT
 ; If no Payer was found, error out
 I $O(PAYID(""))="" S SYMIEN=$$ERROR^IBCNEUT8("B4","Insurance company "_$O(NAMEARR(""))_" is not linked to a Payer.") G EXIT
 ; If multiple Payers were found, error out
 I $O(PAYID(""))'=$O(PAYID(""),-1) S SYMIEN=$$ERROR^IBCNEUT8("B3","Insurance company "_$O(NAMEARR(""))_" is linked to more than one Payer",.PAYID),PAYID="" G EXIT
 ; Validate the found unique Payer
 D VALID^IBCNEUT4(PAYID($O(PAYID(""))),.PAYIEN,.PAYID,.SYMIEN)
 ;
EXIT ; Main function exit point
 Q SYMIEN_U_PAYIEN_U_PAYID
 ;
