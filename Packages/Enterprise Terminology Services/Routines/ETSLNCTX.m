ETSLNCTX ;O-OIFO/FM23 - LOINC Taxonomy Search (Part 1) ;01/31/2017
 ;;1.0;Enterprise Terminology Service;**1**;Mar 20, 2017;Build 7
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
TAX(ETSX,ETSSRC,ETSDT,ETSSUB,ETSVER) ; Get Taxonomy Information
 ;
 ; Input:
 ; 
 ;  ETSX    Search String Either a partial text or a LOINC Code with check digit
 ;    
 ;  ETSSRC  Source: either LNC or LOINC
 ;                 
 ;  ETSDT   Date to use to evaluate status in FileMan Format (defaults to TODAY)
 ;    
 ;  ETSSUB  Name of a subscript to use in the ^TMP 
 ;          global (optional)
 ;            
 ;          ^TMP(ETSSUB,$J,
 ;          ^TMP("ETSTAX",$J,    Default
 ;    
 ;  ETSVER  Versioning Flag (optional, default = 0)
 ;     
 ;          0  Return active and inactive codes
 ;          1  Version, return active codes only
 ;     
 ; Output: 
 ; 
 ;  $$TAX   The number of codes found or -1 ^ error message
 ;    
 ;  ^TMP(ETSSUB,$J,ETSSRC,(ETSCODE_" "),#)
 ;    
 ;          5 piece "^" delimited string
 ;                             
 ;          1   Activation Date (can be a future date)
 ;          2   Inactivation Date (can be a future date)
 ;          3   Not Needed (NULL)
 ;          4   Variable Pointer to a National file (i.e. <IEN>;ETSLNC(129.1,
 ;          5   LONG COMMON NAME (field #83)
 ; 
 ;  ^TMP(ETSSUB,$J,ETSSRC,(ETSCODE_" "),#,0)
 ;    
 ;          2 piece "^" delimited string
 ;                             
 ;          1   Code (no spaces)
 ;          2   Fully Specified Name (Field #80)
 ;
 N ETSIEN,ETSNUM,ETSLNCDG
 ;
 ;Check for Parameter errors
 Q:$G(ETSX)="" "-1^Search Text Missing"
 S:$G(ETSSRC)="" ETSSRC="LNC"
 I ETSSRC'="LNC" Q "-1^Invalid Source"
 ;
 ;Set Default values for optional parameters
 S:$G(ETSDT)="" ETSDT=$$DT^XLFDT
 ; Make sure Date is a valid FileMan Date
 Q:+$$CHKDATE^ETSLNC(ETSDT)=-1 "-1^Invalid Date"
 ;
 S:$G(ETSSUB)="" ETSSUB="ETSTAX"
 ;Clear the temporary array in case there is older data in existence
 K ^TMP(ETSSUB,$J)
 ;
 S ETSVER=+$G(ETSVER)
 I (ETSVER>1)!(ETSVER<0) Q "-1^Invalid Version Flag"
 ;
 ;Standardize search string to all CAPS to match Indexes
 S ETSX=$$UP^XLFSTR($G(ETSX))
 ;
 ; Check data format.  If it is in 1N.N-N format (i.e. 1-8 or 11111-8)
 ; or all numeric, then it is a LOINC Code (processed below)
 I (ETSX?1N.N1"-"1N)!(ETSX?1N.N) D  Q:(+ETSIEN=-1) ETSIEN
 . ; Check for valid LOINC Code and retrieve the IEN, correct
 . ; the input to be LOINC-Check Digit if necessary.
 . I ETSX?1N.N D
 .. S ETSIEN=$O(^ETSLNC(129.1,"B",ETSX,""))
 .. I ETSIEN="" S ETSIEN="-1^Invalid LOINC Code" Q
 .. S ETSLNCDG=ETSIEN_"-"_$P($G(^ETSLNC(129.1,ETSIEN,0)),U,15)   ; Set LOINC code for the return array
 . I ETSX?1N.N1"-"1N D
 .. S ETSIEN=$$CHKCODE^ETSLNC1(ETSX),ETSLNCDG=ETSX  ; Set the IEN and LOINC code for the return array
 . Q:(+ETSIEN=-1)
 . ;
 . ;Update TMP array and counter
 . S ETSCT=1
 . D UPDARY(ETSLNCDG,.ETSCT,ETSIEN,ETSDT,ETSVER)
 . S ^TMP(ETSSUB,$J,0)=ETSCT
 ;
 ;Otherwise, it's a text string. Call partial search algorithm
 D:ETSX'?1N.N1"-"1N TEXTSRCH(ETSX,ETSSUB,ETSDT,ETSVER)
 ;
 ;
 ;Return # items found in the search
 S ETSNUM=+($G(^TMP(ETSSUB,$J,0))) Q:ETSNUM'>0 "-1^No Entries Found"
 Q ETSNUM
 ;
TEXTSRCH(ETSX,ETSSUB,ETSDT,ETSVER) ; Look for Taxonomy items by Text String
 ;
 N ETSTERM,ETSCT,ETSDATA,I,ETSFLG,ETSIEN,ETSLCCD
 ;
 ;Apply Indexing formatting rules to the searching
 S ETSX=$$PREPTEXT^ETSLNCIX(ETSX)
 Q:ETSX=""   ;No valid terms to search, exit
 ;
 ;Store each word in its own node in an local array
 F I=1:1:$L(ETSX," ") S ETSTERM(I)=$P(ETSX," ",I)
 ;
 ;Initialize looping and counter variables
 S (ETSCT,ETSIEN)=0
 ;
 ;Loop to find All IENS with all of the search terms
 ;(intersection of all of the terms sent)
 S ETSTERM(0)=$L(ETSX," ")
 F  S ETSIEN=$O(^ETSLNC(129.1,"D",ETSTERM(1),ETSIEN)) Q:'ETSIEN  D
 . S ETSFLG=1  ; Assume all terms are in array
 . I ETSTERM(0)>1 D
 . . F I=2:1:ETSTERM(0) I ETSTERM(I)'="" I '$D(^ETSLNC(129.1,"D",ETSTERM(I),ETSIEN)) S ETSFLG=0 Q
 . I ETSFLG S ^TMP(ETSSUB,$J,"RESULT",ETSIEN)="",ETSCT=ETSCT+1
 ;
 ;If no matches found, exit
 Q:'ETSCT
 ; 
 ;Reset Counter and Looping Variable
 S ETSCT=0,ETSIEN=""
 ;
 ;Loop through the "RESULT" node to extract the necessary data to return
 F  S ETSIEN=$O(^TMP(ETSSUB,$J,"RESULT",ETSIEN)) Q:'ETSIEN  D
 . S ETSDATA=$G(^ETSLNC(129.1,ETSIEN,0))
 . Q:$G(ETSDATA)=""   ; check for data corruption
 . S ETSCT=ETSCT+1
 . S ETSLCCD=$P(ETSDATA,U)_"-"_$P(ETSDATA,U,15) ; build LOINC Code for lookup
 . D UPDARY(ETSLCCD,.ETSCT,ETSIEN,ETSDT,ETSVER)
 S ^TMP(ETSSUB,$J,0)=ETSCT
 ;
 ;Clear the result node
 K ^TMP(ETSSUB,$J,"RESULT")
 Q
 ;
UPDARY(ETSX,ETSCT,ETSIEN,ETSDT,ETSVER) ; Update the Temporary array
 ;
 N ETSSTR,ETSARY,ETSAPER,ETSINDT,ETSPERD,ETSNFLG
 S (ETSINDT,ETSSTR)="",ETSNFLG=0
 ;
 ;Obtain the Activation History of the code)
 S ETSAPER=$$PERIOD^ETSLNC(ETSX,"LNC",.ETSARY)
 ;
 S ETSPERD=$O(ETSARY(ETSDT),-1)          ;Get the current activation period
 I ETSPERD=0 D
 . I $G(ETSARY(ETSDT))="" S ETSNFLG=1 Q  ;no activation history for date
 . S ETSPERD=ETSDT                    ; otherwise, date is first day of activation
 S:$G(ETSARY(ETSPERD))'=0 ETSINDT=$P(ETSARY(ETSPERD),U)
 ;
 ;stop processing if version flag is for actives only and the code is inactive
 ;also adjust the counter
 I (ETSVER),($G(ETSINDT)'=""),(ETSDT'<ETSINDT) S ETSFLG=1,ETSCT=ETSCT-1 Q
 ;
 ;If no Activation history, update Dates with NULL
 I +ETSAPER'>0 D
 . S $P(ETSSTR,U,1)=""                     ;Activation Date
 . S $P(ETSSTR,U,2)=""                     ;Inactive date (If present)
 ;
 ;If Activation history, update the dates
 I +ETSAPER>0 D
 . I 'ETSNFLG D
 .. S $P(ETSSTR,U,1)=ETSPERD                ;Activation Date
 .. S $P(ETSSTR,U,2)=ETSINDT                ;Inactive date (If present)
 S $P(ETSSTR,U,4)=ETSIEN_";ETSLNC(129.1,"   ;Variable pointer
 S $P(ETSSTR,U,5)=$G(^ETSLNC(129.1,ETSIEN,83))   ;Long Common Name
 S ^TMP(ETSSUB,$J,1,ETSX_" ",ETSCT)=ETSSTR
 S ^TMP(ETSSUB,$J,1,ETSX_" ",ETSCT,0)=ETSX_"^"_$G(^ETSLNC(129.1,ETSIEN,80)) ;LOINC Code^Fully Specified Name
 Q
