IBRFIWL ;ALB/FA - IB LIST OF Request For Additional Information (RFAI) SCREEN ;18-JUL-2015
 ;;2.0;INTEGRATED BILLING;**547**;21-MAR-1994;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; Main entry point for RFAI Management Worklist
 ; Input: None
 ; Output:  IBAUTHB     - Selected Authorized Biller(s)
 ;          IBSORT1     - Selected Primary Sort
 ;          IBSORT2     - Selected Secondary Sort
 N IBAUTHB,IBDONE,IBSORT1,IBSORT2,VALMSG
 S IBDONE=$$SORT(0)
 I IBDONE D  Q
 . W !!,*7,"Sort Criteria was not selected"
 . D PAUSE^VALM1
 . S VALMQUIT=1
 D EN^VALM("IBRFI 277 WL")
 Q
 ;
HDR ;EP
 ; Build the listman template header information
 ; Input:   IBAUTHB     - Selected Authorized Biller(s)
 ;          IBSORT1     - Selected Primary Sort
 ;          IBSORT2     - Selected Secondary Sort
 ; Output:  VALMHDR     - array of header lines for the templaqte3
 ;N XX
 ;S XX="Primary Sort: "_$$SD^IBRFIWLA(IBSORT1)
 ;S:IBSORT2'="" XX=XX_"   Secondary Sort: "_$$SD^IBRFIWLA(IBSORT2)
 ;S VALMHDR(1)=XX
 ;S:IBAUTHB VALMHDR(2)="Filter: Selected Authorized Billers"
 Q
 ;
INIT ;EP
 ; Initialize variables and list array
 ; Input:   IBAUTHB     - Selected Authorized Biller(s)
 ;          IBSORT1     - Selected Primary Sort
 ;          IBSORT2     - Selected Secondary Sort
 ;K ^TMP("IBBIL",$J)
 K ^TMP("IBRFIWL",$J),^TMP("IBRFIWLS",$J),^TMP("IBRFIWLIX",$J)
 K VALMQUIT
 S VALMSG="|* Review in progress | Enter ?? for more actions|"
 D BLD(.IBAUTHB,IBSORT1,IBSORT2)
 Q
 ;
SORT(REBUILD) ;EP
 ; Protocol action and also called initially from method EN
 ; Select/ReSelect Sort/Filter criteria
 ; Input:   REBUILD     - 1 to rebuild the worklist (set to 1 from Resort
 ;                          protocol option)
 ;                        Optional, defaults to 0
 ;          IBAUTHB     - Currently Selected Authorized Biller(s)
 ;          IBSORT1     - Currently Selected Primary Sort
 ;          IBSORT2     - Currently Selected Secondary Sort
 ; Output:  IBAUTHB     - Currently Selected Authorized Biller(s)
 ;          IBSORT1     - Currently Selected Primary Sort
 ;          IBSORT2     - Currently Selected Secondary Sort
 ; Returns: 1 - User exited without entering Sort/Filter criteria
 ;          0 Otherwise
 N IBDONE,IBSTOP,XX
 S:'$D(REBUILD) REBUILD=0
 D FULL^VALM1
 D AUTHB(.IBAUTHB,.IBDONE)                      ; Authorized Biller filter
 Q:IBDONE 1
 S IBSORT1=$$SORTSET^IBRFIWLA(1,"L","",.IBDONE) ; Primary Sort
 Q:IBDONE 1
 ;
 ; If the user selected Oldest or Newest Date Received as the primary sort,
 ; Do not ask for secondary sort
 ;I (IBSORT1="O")!(IBSORT1="N") S IBSORT2=0
 ;E  D
 ;. S XX=$S(IBSORT1="O":"",1:"O")                ; Default Secondary Sort
 ;. S IBSORT2=$$SORTSET^IBRFIWLA(2,XX,IBSORT1,.IBDONE)    ; Secondary Sort
 S XX=$S(IBSORT1="O"!(IBSORT1="N"):"L",1:"O")                ; Default Secondary Sort
 S IBSORT2=$$SORTSET^IBRFIWLA(2,XX,IBSORT1,.IBDONE)    ; Secondary Sort
 I REBUILD D
 . D INIT                                       ; Rebuild Sorted worklist
 . D HDR                                        ; Redisplay Header
 . S VALMBCK="R"
 Q:IBDONE 1
 Q 0
 ;
AUTHB(IBAUTHB,IBDONE)  ; Set the Authorized Biller
 ; Input:   None
 ; Output:  IBAUTHB     - 1 - Authorized Biller(s) selected, 0 otherwise
 ;          IBDONE      - 1 if user quit or timed out
 ;
 K ^TMP("IBBIL",$J)
 N FIRST,DIC,DTOUT,DONE,DUOUT,X,Y
 S FIRST=1,(DONE,IBDONE)=0,IBAUTHB=0
 F  D  Q:DONE
 . S DIC="^VA(200,",DIC(0)="AEQM"
 . S DIC("A")="Select "_$S(FIRST:"",1:" Another ")_"Authorizing Biller: "
 . S:FIRST DIC("A")=DIC("A")_"ALL// "
 . D ^DIC
 . K DIC
 . I Y<0 S DONE=1 Q
 . I $D(^TMP("IBBIL",$J,+Y)) D  Q
 . . W !!,*7,"This biller has already been selected",!
 . S ^TMP("IBBIL",$J,+Y)="",FIRST=0,IBAUTHB=1
 I $D(DTOUT)!$D(DUOUT) S IBDONE=1 Q
 Q
 ;
BLD(IBAUTHB,IBSORT1,IBSORT2) ; Build the listman template body
 ; Input:   IBAUTHB                         - Authorized Biller filter
 ;          IBSORT1                         - Primary Sort
 ;          IBSORT2                         - Secondary Sort
 ;          ^TMP("IBRFIWLS",$J,A,B)=RFAIEN  - See GETMSGS
 ;          ^TMP("IBRIFWLIX",$J,CNT)=RFAIEN^### - Message Selector Index
 N AA,CNT,PFILTER,RFAIEN,S1,S2,XX,SFILTER
 D GETMSGS(.IBAUTHB,IBSORT1,IBSORT2)            ; Get Sorted/Filtered list
 S (CNT,VALMCNT)=0,(AA,PFILTER,S1)=""
 F  D  Q:AA=""
 . S AA=$O(^TMP("IBRFIWLS",$J,AA))
 . Q:AA=""
 . S S1=""
 . F  D  Q:S1=""
 . . S S1=$O(^TMP("IBRFIWLS",$J,AA,S1))
 . . Q:S1=""
 . . S S2=""
 . . F  D  Q:S2=""
 . . . S S2=$O(^TMP("IBRFIWLS",$J,AA,S1,S2))
 . . . Q:S2=""
 . . . S RFAIEN=""
 . . . F  D  Q:RFAIEN=""
 . . . . S RFAIEN=$O(^TMP("IBRFIWLS",$J,AA,S1,S2,RFAIEN))
 . . . . Q:RFAIEN=""
 . . . . S XX=$S(AA="~":S1,1:0)
 . . . . D BLDONEM(.VALMCNT,.CNT,RFAIEN,IBSORT1,.PFILTER,XX,S1,IBSORT2,S2,.SFILTER)
 Q
 ;
GETMSGS(IBAUTHB,IBSORT1,IBSORT2) ; Retrieves the RFAI Messages filtering
 ; by Authorized Biller in sorted order
 ; Input:   IBAUTHB - Authorized Biller filter
 ;          IBSORT1 - Primary Sort
 ;          IBSORT2 - Secondary Sort
 ; Output:  ^TMP("IBRFIWLS",$J,A,B,C,IEN)=""- Where:
 ;                                        A   - ~ - Bad Record Indicator
 ;                                              1 - No Authorized Biller filter
 ;                                              Authorized Biller Name
 ;                                        B   - When A=0 - Bad Data Type
 ;                                              Otherwise Primary sort value
 ;                                        C   - When A=0 - 0
 ;                                              Otherwise Secondary Sort value OR
 ;                                              0 if no secondary sort
 ;                                        IEN - IEN of the RFAI Message
 N CNT,IBIFN,PIEN,RAUTHBV,RFAIEN,SKIP,STATUS,XX
 S CNT=0,RFAIEN=""
 F  D  Q:RFAIEN=""
 . S RFAIEN=$O(^IBA(368,"E",0,RFAIEN))
 . Q:RFAIEN=""
 . S SKIP=0
 . Q:$$BADREQ(RFAIEN)                           ; Quit if bad data error
 . S:'$G(IBAUTHB) RAUTHBV=1  ; No Authorized Biller filter or primary sort
 . S:IBSORT1="B" RAUTHBV=""
 . ;
 . ; Filtering on Authorized Biller
 . I $G(RAUTHBV)'=1 D  Q:SKIP
 . . S RAUTHBV=$$GET1^DIQ(399,IBIFN,11,"I")     ; IEN of Bill/Claims Authorizer
 . . ;
 . . ; If Request MRA bill, pull the MRA Requestor user instead
 . . I 'RAUTHBV D
 . . . S STATUS=$$GET1^DIQ(399,IBIFN,.13,"I")       ; Status of Bill
 . . . Q:STATUS'=2                              ; Not a Request MRA Bill
 . . . S RAUTHBV=$$GET1^DIQ(399,IBIFN,8,"I")    ; MRA Requestor
 . . ;
 . . ; Not a selected Authorized Biller
 . . I $G(IBAUTHB),'$D(^TMP("IBBIL",$J,RAUTHBV)) S SKIP=1 Q
 . . S RAUTHBV=$$GET1^DIQ(200,RAUTHBV,.01)      ; New Person NAME
 . ;
 . D GETONEM(RFAIEN,RAUTHBV,IBSORT1,IBSORT2,IBIFN)   ; Get One Message
 Q
 ;
BADREQ(RFAIEN) ; Marks a record that contains missing or incorrect
 ; critical data
 ; Input:   RFAIEN                  - IEN of the record containing bad data
 ;          ^TMP("IBRFIWLS",$J,-1,TYPE,0)=RFAIEN potentially
 ; Returns: 1 - Bad data found, 0 otherwise
 N PIEN,XX
 S IBIFN=$$GET1^DIQ(368,RFAIEN,111.01,"I")      ; IEN for Bill/Claims file
 I IBIFN="" D  Q 1
 . S ^TMP("IBRFIWLS",$J,"~",1,0,RFAIEN)=""
 ;
 S PIEN=$$GET1^DIQ(368,RFAIEN,109.01,"I")       ; Patient IEN
 I PIEN="" D  Q 1
 . S ^TMP("IBRFIWLS",$J,"~",2,0,RFAIEN)=""        ; Patient Bill/Mismatch
 Q 0
 ;
GETONEM(RFAIEN,RAUTHB,IBSORT1,IBSORT2,IBIFN)  ; Get the Data for a specified
 ; RFAI Message
 ; Input:   RFAIEN  - IEN of the selected RFAI Message
 ;          RAUTHB  - Authorized Biller Name
 ;                    1 - No Authorized Biller filter
 ;          IBSORT1 - Primary Sort Code
 ;          IBSORT2 - Secondary Sort Code 
 ;          IBIFN   - IEN for the associated Bill/Claims record          
 ; Output:  ^TMP("IBRFIWLS",$J,A,B,C)=IEN - Where:
 ;                                        A   - 0 - Bad Record Indicator
 ;                                              1 - No Authorized Biller filter or it passed the filter
 ;                                        B   - When A=0 - Bad Data Type
 ;                                              Otherwise Primary sort value
 ;                                        C   - When A=0 - 0
 ;                                              Otherwise Secondary Sort value OR
 ;                                              0 if no secondary sort
 ;                                        IEN - IEN of the RFAI Message
 N FIELDP,FIELDS,RDATE
 S (FIELDP,FIELDS)=""
 ;
 ; Determine the Primary Sort field
 S:(IBSORT1="N")!(IBSORT1="O") FIELDP=100.02    ; Request date/tinme
 I FIELDP="",((IBSORT1="E")!(IBSORT1="D")) D    ; Response Date
 . S FIELDP=112.01
 I FIELDP="",IBSORT1="I" S FIELDP=101.01        ; Insurance Company Name
 I FIELDP="",IBSORT1="P" S FIELDP=109.01        ; Patient Name
 I FIELDP="",IBSORT1="L" S FIELDP=122.03        ; LOINC Code
 S:FIELDP="" FIELDP=-1                          ; Authorized Biller
 ;
 ; Determine the Secondary Sort field
 I IBSORT2="" S FIELDS=-2                         ; No Secondary Sort
 S:(IBSORT2="N")!(IBSORT2="O") FIELDS=100.03       ; Transmission Date
 I FIELDS="",((IBSORT2="E")!(IBSORT2="D")) D    ; Request Due Date
 . S FIELDS=112.01
 I FIELDS="",IBSORT2="I" S FIELDS=101.01        ; Insurance Company Name
 I FIELDS="",IBSORT2="P" S FIELDS=109.01        ; Patient Name
 I FIELDS="",IBSORT2="L" S FIELDS=122.03        ; LOINC Code
 S:FIELDS="" FIELDS=-1                          ; Authorized Biller
 ;
 ; Get the sort values
 ;S RDATE=$S(IBSORT1="N":1,IBSORT1="E":1,1:2)
 S RDATE=$S(IBSORT1="O":1,IBSORT1="D":1,1:2)
 S FIELDP=$S(IBSORT1="B":RAUTHB,1:$$GETFVAL(FIELDP,RFAIEN,RAUTHB,RDATE)) ; Get Primary sort value
 I ".D.O.N.E."[("."_IBSORT1_".") S FIELDP=$P(FIELDP,".")   ; don't need times for sort
 ;S RDATE=$S(IBSORT2="N":1,IBSORT2="E":1,1:2)
 S RDATE=$S(IBSORT2="O":1,IBSORT2="D":1,1:2)
 S FIELDS=$$GETFVAL(FIELDS,RFAIEN,RAUTHB,RDATE) ; Get Secondary sort value
 I ".D.O.N.E."[("."_IBSORT2_".") S FIELDS=$P(FIELDS,".")
 I IBSORT2=""!(IBSORT2=0) S FIELDS=0  ; no secondary, avoild subscript error
 ;
 ; Finally set the sorted record into the list
 S ^TMP("IBRFIWLS",$J,$S(RAUTHB="~":"~",1:1),FIELDP,FIELDS,RFAIEN)=""
 Q
 ;
GETFVAL(FIELD,RFAIEN,RAUTHB,RDATE,RETNA) ;EP
 ; Returns the external value of the specified field
 ; Input:   FIELD   - # of the field to be retrieved
 ;                    NOTE: if this number is >100 AND no value is found, then
 ;                          the value of FIELD-100 will be returned which is
 ;                          the raw value received from the HL7 message. 
 ;                          The following are 'special' FIELD values:
 ;                             -1 - RAUTHB variable is used
 ;                             -2 - 0 is returned
 ;                             -3 - Last 4 digits of the SSN are returned
 ;                             -4 - Current balance is returned
 ;                          FIELD
 ;          RFAIEN  - IEN of the RFAI Message (file 368) to retrieve values from
 ;          RAUTHB  - IEN of the Authorized Billed (special case)
 ;                    Optional, defaults to ""
 ;          RDATE   - 1 - Return negative internal date (used for sorting)
 ;                    2 - Return internal date (used for sorting)
 ;                    3 - Force Date conversion to DD/MM/YY
 ;                    0 - Return external date (DD/MM/YY)
 ;                    Optional, defaults to 0
 ;          RETNA   - 2 - Return null if field does not contain a value
 ;                    1 - Return '*NA*' if field does not contain a value
 ;                    0 - Return '0'
 ;                    Optional, defaults to 0
 ; Returns: External Field value
 N VAL,VAL2,XX,YY
 S:'$D(RAUTHB) RAUTHB=0
 S:'$D(RDATE) RDATE=0
 S:'$D(RETNA) RETNA=0
 I $F(FIELD,",") D  Q VAL
 . N FILE
 . S FILE=$P(FIELD,","),FIELD=$P(FIELD,",",2)
 . S VAL=$$GET1^DIQ(FILE,RFAIEN,FIELD)
 . I RDATE=3,VAL]"" S VAL2=$$GET1^DIQ(FILE,RFAIEN,FIELD,"I") S:VAL2]"" VAL=$$FMTE^XLFDT(VAL2,"2DZ")
 . I VAL="" D                    ; Return raw value
 .. I FILE=368.0113 S FILE=368.013
 .. I FILE=368.0121 S FILE=368.021
 .. I FILE=368.12199 S FILE=368.2199
 .. S VAL=$$GET1^DIQ(FILE,RFAIEN,FIELD)
 .. I VAL="" S VAL=$S(RETNA=1:"*NA*",RETNA=2:"",1:0)
 .. Q
 . Q
 I FIELD=-1 Q $$GET1^DIQ(200,RAUTHB,.01)        ; Authorized Biller Name
 I FIELD=-2 Q 0
 I FIELD=-3 D  Q VAL                            ; Last 4 digits of SSN
 . S VAL=$$GET1^DIQ(368,RFAIEN,109.01,"I")      ; Patient Pointer
 . I VAL="" S VAL=$S(RETNA=1:"*NA*",RETNA=2:"",1:0) Q
 . S VAL=$$GET1^DIQ(2,VAL,.09)                 ; SSN number
 . I VAL="" S VAL=$S(RETNA=1:"*NA*",RETNA=2:"",1:0) Q
 . S VAL=$E(VAL,6,9)
 I FIELD=-4 D  Q VAL                            ; Current Balance
 . S VAL=$$GET1^DIQ(368,RFAIEN,111.01,"I")      ; Bill pointer
 . I VAL="" S VAL=$S(RETNA=1:"*NA*",RETNA=2:"",1:0) Q
 . S XX=$$GET1^DIQ(399,VAL,201,"I")             ; Current Balance
 . S YY=$$GET1^DIQ(399,VAL,202,"I")             ; Offset
 . S VAL=XX-YY
 ;
 S VAL=$$GET1^DIQ(368,RFAIEN,FIELD,"E")         ; Get external value
 I FIELD=122.03,VAL'="" S VAL=VAL_":  "_$$GET1^DIQ(368,RFAIEN,FIELD_":1")    ; add LOINC code description
 I FIELD=122.03,VAL="" S VAL=$$GET1^DIQ(368,RFAIEN,22.03,"E")  ; for LOINC codes not in LAB LOINC file
 I ((FIELD=100.02)!(FIELD=100.03)!(FIELD=.03)!(FIELD=122.04)!(FIELD=113.03)!(FIELD=112.01)!(FIELD=114.03)!(FIELD=114.04)),VAL'="" D  Q VAL
 . S VAL=$$GET1^DIQ(368,RFAIEN,FIELD,"I")
 . Q:RDATE=2                                    ; Return internal date
 . I RDATE=1 S VAL=VAL*-1 Q                     ; Return negative internal date
 . S VAL=$$FMTE^XLFDT(VAL,"2DZ")                ; Return external date  
 I VAL'="" Q VAL
 I VAL="",FIELD>100 D                    ; Return raw value
 . S FIELD=FIELD-100
 . S VAL=$$GET1^DIQ(368,RFAIEN,FIELD)
 S:VAL="" VAL=$S(RETNA=1:"*NA*",RETNA=2:"",1:0)
 Q VAL
 ;
BLDONEM(VALMCNT,MSGCNT,RFAIEN,IBSORT1,PFILTER,BTYPE,PSORT,IBSORT2,SSORT,SFILTER) ; Build one Message into
 ; the listman display
 ; Input:   VALMCNT                     - Current Line of the display being
 ;                                       (re)built
 ;          MSGCNT                      - Current Message Number
 ;          RFAIEN                      - IEN of the message to be displayed
 ;          IBSORT1                     - Primary Sort Code
 ;          PFILTER                     - Current Filter line value
 ;          BTYPE                       - 0 - Not a bad record
 ;                                        Otherwise, type of bad record (1-2)
 ;          PSORT                       - External value of primary sort data
 ;          IBSORT2                     - Secondary Sort Code
 ;          SSORT                       - External value of secondary sort data
 ;
 ; Output:  VALMCNT                     - Updated Line of the display being
 ;          MSGCNT                      - Updated Message Number
 ;          PFILTER                     - Update Filter line Value
 ;          ^TMP("IBRIFWLIX",$J,CNT)    - Message Selector Index
 N LINE,VAL,XX
 I BTYPE D                                      ; Display Bad Record Type
 . Q:PFILTER=BTYPE                              ; Same as previous line
 . S VALMCNT=VALMCNT+1,PFILTER=BTYPE
 . I BTYPE=1 D
 . . S LINE="Messages with an invalid Bill Number"
 . I BTYPE=2 D
 . . S LINE="Messages with Patient/Bill Mismatch"
 . D SET^VALM10(VALMCNT,LINE,VALMCNT)
 I 'BTYPE D
 . I ".N.O.E.D."[("."_IBSORT1_".") S PSORT=$TR(PSORT,"-"),PSORT=$$FMTE^XLFDT(PSORT,"2DZ")
 . S LINE=$S(IBSORT1="I":"Insurance Company Name:  ",IBSORT1="P":"Patient Name:  ",IBSORT1="B":"Authorizing Biller:  ",IBSORT1="L":"LOINC Code:  ",IBSORT1="E"!(IBSORT1="D"):"Date Due:  ",1:"Date Received:  ")_PSORT
 . I PFILTER'=LINE D 
 . . S VALMCNT=VALMCNT+1,PFILTER=LINE
 . . D SET^VALM10(VALMCNT,LINE,VALMCNT)
 . . S SFILTER=""
 . I $G(IBSORT2)]"",$G(IBSORT2)'=0 D
 . . I ".N.O.E.D."[("."_IBSORT2_".") S SSORT=$TR(SSORT,"-"),SSORT=$$FMTE^XLFDT(SSORT,"2DZ")
 . . S LINE=" "_$S(IBSORT2="I":"Insurance Company Name:  ",IBSORT2="P":"Patient Name:  ",IBSORT2="B":"Authorizing Biller:  ",IBSORT2="L":"LOINC Code:  ",IBSORT2="E"!(IBSORT2="D"):"Date Due:  ",1:"Date Received:  ")_SSORT
 . . I SFILTER'=LINE D
 . . . S VALMCNT=VALMCNT+1,SFILTER=LINE
 . . . D SET^VALM10(VALMCNT,LINE,VALMCNT)
 S CNT=CNT+1,VALMCNT=VALMCNT+1
 S ^TMP("IBRFIWLIX",$J,CNT)=RFAIEN
 S LINE=$$SETL("",MSGCNT,"",1,4)                ; Message #
 S VAL=$$GETFVAL(111.01,RFAIEN,"",0,2)          ; External Bill #
 S XX=$$GET1^DIQ(368,RFAIEN,200.04,"I")         ; Review Status
 S:XX VAL=VAL_"*"
 S LINE=$$SETL(LINE,VAL,"",5,8)
 D SET^VALM10(VALMCNT,LINE,VALMCNT)
 S VAL=$$GETFVAL(101.01,RFAIEN,"",0,2)          ; Ins. Co. Name
 S LINE=$$SETL(LINE,VAL,"",15,16)
 D SET^VALM10(VALMCNT,LINE,VALMCNT)
 S VAL=$$GETFVAL(109.01,RFAIEN,"",0,2)          ; Patient Name
 S LINE=$$SETL(LINE,VAL,"",33,20)
 D SET^VALM10(VALMCNT,LINE,VALMCNT)
 S VAL=$$GETFVAL(-3,RFAIEN,"",0,2)              ; SSN
 S LINE=$$SETL(LINE,VAL,"",56,4)
 D SET^VALM10(VALMCNT,LINE,VALMCNT)
 S VAL=$$GETFVAL(114.03,RFAIEN,"",2,2)          ; Service Date
 I VAL'="" S VAL=$$FMTE^XLFDT(VAL,"2Z")
 S LINE=$$SETL(LINE,VAL,"",61,8)
 D SET^VALM10(VALMCNT,LINE,VALMCNT)
 S VAL=$$GETFVAL(-4,RFAIEN,"",0,2)              ; Current Balance
 S VAL=$J("$"_$FN(VAL,"",2),9)
 S LINE=$$SETL(LINE,VAL,"",71,9)
 D SET^VALM10(VALMCNT,LINE,VALMCNT)
 ;
 S ^TMP("IBRFIWLIX",$J,CNT)=RFAIEN_U_VALMCNT   ; Selection Index - RFAIEN is pointer to file 368, VALMCNT points to detailed entry in worklist ^TMP
 ;I IBSORT1'="L" D
 ;. S VALMCNT=VALMCNT+1
 ;. S VAL=$$GETFVAL(122.03,RFAIEN,"",0,2)        ; LOINC Code + Description
 ;. I VAL'="" D
 ;. . S LINE=$$SETL("",VAL,"",6,80)
 ;. . D SET^VALM10(VALMCNT,LINE,VALMCNT)
 ;
 S VALMCNT=VALMCNT+1
 S VAL=$$GETFVAL(122.03,RFAIEN,"",0,2)        ; LOINC Code + Description
 I VAL'="" D
 . S LINE=$$SETL("",VAL,"",5,80)
 . D SET^VALM10(VALMCNT,LINE,VALMCNT)
 Q
 ;
SETL(LINE,DATA,LABEL,COL,LNG) ; Creates a line of data to be set into the body
 ; of the worklist
 ; Input:   LINE    - Current line being created
 ;          DATA    - Information to be added to the end of the current line
 ;          LABEL   - Label to describe the information being added
 ;          COL     - Column position in line to add information add
 ;          LNG     - Maximum length of data information to include on the line
 ; Returns: Line updated with added information
 S LINE=LINE_$J("",(COL-$L(LABEL)-$L(LINE)))_LABEL_$E(DATA,1,LNG)
 Q LINE
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 S VALMSG="* Indicates review in progress"
 Q
 ;
SMSG ;EP
 ; Protocol action to select an RFI message to be worked
 ; Input:   ^TMP("IBRFIWLIX",$J,CNT)=RFAIEN
 N RFAIEN,RFAIDET,RFAIDHDR
 S VALMBCK="R"
 D FULL^VALM1
 S RFAIEN=$$SELMSG^IBRFIWLA("Select Message")
 I RFAIEN="" S VALMSG="|* Review in progress | Enter ?? for more actions|" Q
 S (RFAIDET,RFAIDHDR)=""
 I $P(RFAIEN,U,2) D
 .S RFAIDET=$P($G(RFAIEN),U,2)
 .I $G(RFAIDET) S RFAIDET=$E($G(^TMP("IBRFIWL",$J,+$G(RFAIDET),0)),6,999)
 .S RFAIDHDR=$E($G(VALMCAP),6,999)
 S RFAIEN=$P(RFAIEN,U)
 ;
 D EN^IBRFIWL1(RFAIEN,RFAIDET,RFAIDHDR)                      ; Show the detail of the message
 D INIT                                     ; Rebuild the list
 Q
 ;
EXIT ; -- exit code
 K IBAUTH,IBSORT1,IBSORT2
 K ^TMP("IBBIL",$J),^TMP("IBRFIWL",$J),^TMP("IBRFIWLS",$J),^TMP("IBRFIWLIX",$J)
 D CLEAN^VALM10
 Q
