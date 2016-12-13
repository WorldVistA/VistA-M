IBRFIWLA ;ALB/FA - IB LIST OF Request For Additional Information (RFAI) SCREEN ;18-JUL-2015
 ;;2.0;INTEGRATED BILLING;**547**;21-MAR-1994;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Continuation of methods for the Request for Additional Information worklist
 ;
 Q
 ;
SORTSET(LEVEL,DEFSORT,IBSORT1,IBDONE) ;EP
 ; Allows the user to select Primary or Secondary sort option
 ; Input:   LEVEL   - 1 - Setting Primary Sort
 ;                    2 - Setting Secondary sort
 ;          DEFSORT - Default sort value
 ;                    Optional, defaults to ""
 ;          IBSORT1 - Current Primary Sort Value
 ;                    Optional, only passed when selecting the Secondary sort
 ; Output:  IBDONE  - 1 if user '^' or timed out, 0 otherwise
 ; Returns: Selected Sort Option
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LEVDESC,LINE,LN,SORT,SKIP,XX,X,Y
 S:'$D(DEFSORT) DEFSORT=""
 S IBDONE=0
 S LEVDESC=$S(LEVEL=2:"Secondary",1:"Primary")
 S DIR("A")="Select "_LEVDESC_" Sort"
 S:DEFSORT'="" DIR("B")=$$SD(DEFSORT)
 S DIR("?")="Enter a code from the list to indicate the "_LEVDESC_" sort order."
 I LEVEL=2 D
 . S DIR("?",1)="  Primary Sort is "_$$SD($G(IBSORT1))
 . S DIR("?",LEVEL)=""
 ;
 I LEVEL=1 S DIR(0)="S"                         ; Primary sort required
 E  S DIR(0)="SO"                               ; Optional Secondary sort
 ;
 ; Set the allowable sort options
 S XX=""
 F LN=1:1 D  Q:SORT=""
 . S SORT=$P($T(ZZ+LN),";",3),SKIP=0            ; Sort Code
 . Q:SORT="END"
 . ;
 . ; Secondary Sort - exclude primary sort or related option
 . I LEVEL=2 D  Q:SKIP
 . . I $P(SORT,":",1)=IBSORT1 S SKIP=1 Q        ; Exclude Primary Sort
 . . I IBSORT1="D",$P(SORT,":",1)="E" S SKIP=1 Q
 . . I IBSORT1="E",$P(SORT,":",1)="D" S SKIP=1 Q
 . . I IBSORT1="N",$P(SORT,":",1)="O" S SKIP=1 Q
 . . I IBSORT1="O",$P(SORT,":",1)="N" S SKIP=1 Q
 . S XX=$S(XX="":SORT,1:XX_";"_SORT)
 S $P(DIR(0),"^",2)=XX
 D ^DIR
 K DIR
 I $D(DTOUT) S IBDONE=1 Q 0                     ; Timeout
 ;I $D(DIRUT),LEVEL=1 S IBDONE=1 Q 0             ; ^ or nil response
 I $D(DIRUT) S IBDONE=1 Q 0             ; ^ or nil response
 Q Y
 ;
SELMSG(PROMPT) ;EP
 ; Select a message
 ; Input:   PROMPT                  - Prompt to display to the user
 ;          ^TMP("IBRFIWLIX",$J,CNT)=RFAIEN
 ; Returns: IEN of the selected message or ""
 N DIROUT,DIRUT,DLINE,DTOUT,DUOUT,END,MCNT,RFAIEN,START,X,Y
 I '$D(^TMP("IBRFIWLIX",$J)) W !!?5,"There are no 'RFAI Messages' to select." D PAUSE^VALM1 Q ""
 S START=1,END=$O(^TMP("IBRFIWLIX",$J,""),-1)
 D FULL^VALM1
 S MCNT=$P($P($G(XQORNOD(0)),"^",4),"=",2)    ; User selection with action
 S MCNT=$TR(MCNT,"/\; .",",,,,,")             ; Check for multi-selection
 ;
 I MCNT["," D  Q ""                           ; Invalid multi-selection
 . W !,*7,">>>> Only single entry selection is allowed"
 . K DIR
 . D PAUSE^VALM1
 S:MCNT="" MCNT=$$SELENTRY(PROMPT,START,END)
 Q:MCNT<1 ""
 S RFAIEN=^TMP("IBRFIWLIX",$J,MCNT)
 Q RFAIEN
 ;
SELENTRY(PROMPT,START,END)    ; select a Message
 ; Input:   PROMPT  - Prompt to be displayed to the user
 ;          START   - Starting Message # that can be selected
 ;          END     - Ending Message # that can be selected
 ; Returns: Selected Message # or "" if not selected
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="NO^"_START_":"_END_":0"
 S DIR("A")=PROMPT
 D ^DIR K DIR
 Q +X
 ;
BLDCOM(RFAIEN,SLINE,ELINE) ; Build the Comment Section (if a comment exists) - called from IBRFIWL1
 ; Input:   RFAIEN  - IEN of the selected Message
 ;          SLINE   - Starting Section Line Number
 ;          ELINE   - Current Ending Section Line Number
 ; Output:  ELINE   - Updated Ending Section Line Number
 ;
 N CBY,CDATE,COM,IX,LI,LIDATA
 S ELINE=$$SET^IBRFIWL1("",$J("",40),SLINE,1)            ; Spacing Blank Line
 I '$O(^IBA(368,RFAIEN,201,0)) Q        ; See if we have a comment
 S ELINE=$$SETN^IBRFIWL1("Comment History",ELINE,1,1)
 ; See if we have a comment
 S LI=0 F  S LI=$O(^IBA(368,RFAIEN,201,LI)) Q:LI'=+LI  D
 . S CDATE=$$GET1^DIQ(368.0201,LI_","_RFAIEN,.01,"I")
 . S CDATE=$$FMTE^XLFDT(CDATE,"2ZM")
 . S CBY=$$GET1^DIQ(368.0201,LI_","_RFAIEN,.02)
 . S ELINE=$$SETN^IBRFIWL1("Comment - Entered By: "_CBY_" on "_CDATE,ELINE,1)
 . S IX=0 F  S IX=$O(^IBA(368,RFAIEN,201,LI,1,IX)) Q:IX=""  S LIDATA=$G(^(IX,0)) D
 .. S ELINE=$$SET^IBRFIWL1("  ",LIDATA,ELINE,1)
 Q
 ;
WRAP(STRING,ROOM,SUBS,IBARY) ; wrap long lines without breaking up words, called from IBRFIWL1
 ;
 ; STRING = data string to wrap
 ; ROOM = number of characters to break at for line 1
 ; SUBS = number of characters to break at for subsequent lines (may or may not be same as ROOM)
 ; IBARY = (required) subscripted array to return wrapped data in:
 ;  array(1)=first line
 ;  array(2)= 2nd line and so on
 ;
 ; Returns total # of lines in description
 ;
 N START,END,I,C
 ; if there is enough room for 1 line, no wrapping needed
 I $L(STRING)'>ROOM S IBARY(1)=STRING Q 1
 ; add a space to the end of the string to avoid dropping last character
 S START=1,END=ROOM,STRING=STRING_" "
 F C=1:1 D  Q:$L(STRING)<START  ; stop if we have made it to the end of the data string
 .; start at the end and work backwards until you find a blank space, cut the line there and move on to the next line 
 .F I=END:-1:1 I $E(STRING,I)=" " S IBARY(C)=$E(STRING,START,I),START=I+1,END=SUBS+START Q
 Q C
 ;
SD(SORT) ;EP
 ; Returns the sort description given the sort code
 ; Input:   SORT    - Sort Code
 ; Returns: Sort Description
 Q $P($P($T(@("ZZ"_$G(SORT))),";",3),":",2)
 ;
ZZ ; List of allowable sort criteria
ZZN ;;N:Earliest Date Received
ZZO ;;O:Latest Date Received
ZZE ;;E:Earliest Due Date
ZZD ;;D:Latest Due Date
ZZI ;;I:Insurance Company Name
ZZP ;;P:Patient Name
ZZB ;;B:Authorizing Biller
ZZL ;;L:LOINC Code
END ;;END
 ;
 Q
PURGWL ; purge file 368 entries based on # of days in PURGE DAYS 277 RFAI 
 ;       in IB SITE PARAMETERS (field #52.02 in file #350.9)
 ; Called from NIGHTLY^IBTRKR (tasked option IB MT NIGHT COMP)
 ; null entry (the default) indicates the transactions will be stored forever.
 N CMTIEN,DA,DIC,DLAYGO,IBPERS,IBRFI,NMIDX,NOW,RMVCOM,WLENDT,WLPRGD
 ; get INTERFACE,IB RFI user id#
 S IBPERS=$$FIND1^DIC(200,,,"INTERFACE,IB RFI")
 S IBPERS=$S(IBPERS:IBPERS,1:.5) ; force to POSTMASTER if unknown 
 ; get Purge in Number of days and WL Ending Date
 S WLPRGD=$$GET1^DIQ(350.9,1,52.02) Q:WLPRGD=""
 S WLENDT=$$FMTHL7^XLFDT($$FMADD^XLFDT(DT,-WLPRGD))
 ; loop through non-deleted entries and see if they meet purge days criteria
 S IBRFI="" F  S IBRFI=$O(^IBA(368,"E",0,IBRFI)) Q:IBRFI=""  D
 . Q:$E($$GET1^DIQ(368,IBRFI,.03,"I"),1,8)>WLENDT
 . ; CHECK FOR REVIEW STATUS (#200.04) I STATUS="1" for "REVIEW IN PROGRESS", QUIT
 . Q:$$GET1^DIQ(368,IBRFI,200.04,"I")=1
 . I '$$LOCKM^IBRFIWL1(IBRFI) Q  ;  unable to remove the WL, due to LOCK
 . ;
 . ; REMOVE WL & SET Comment Entered Date      (^IBA(368,D0,201,D1,0) [1P:200]
 . S DA(1)=IBRFI,DLAYGO=368.0201,DIC(0)="L",DIC="^IBA(368,"_DA(1)_",201,"
 . S X=$$NOW^XLFDT()
 . D FILE^DICN
 . K DD,DO S (CMTIEN,DA)=+Y
 . I DA<1 D UNLOCKM^IBRFIWL1(IBRFI) Q  ; WL locked, unable to create comment multiple
 . ;
 . ; SET Comment Entered By & Comment          (^IBA(368,D0,201,D1,0) [2P:200]
 . S DIE="^IBA(368,"_DA(1)_",201,"
 . S RMVCOM="Entry automatically expired from the RFAI Management Worklist."
 . S DR=".02////"_IBPERS_";.03///"_RMVCOM ;   user INTERFACE,IB RFI
 . D ^DIE
 . K DR,DIE
 . ;
 . ; if comment entered, update deleted flag and date
 . N DA,DIE
 . S DA=IBRFI,DIE=368,NOW=$$NOW^XLFDT()
 . S DR="200.01////1;200.02////"_NOW_";200.03////"_IBPERS ;   User INTERFACE,IB RFI
 . D ^DIE K DR
 . ;
 . D UNLOCKM^IBRFIWL1(IBRFI)
 K CMTIEN,DA,DIC,DLAYGO,IBPERS,IBRFI,IBSTR,NMIDX,NOW,RMVCOM,WLENDT,WLPRGD,WLRVST
 Q
 ;
BLDSLI(RFAIEN,SLINE,ELINE) ; Build the Service Line Information Section - called from IBRFIWL1
 ; Input:   RFAIEN  - IEN of the selected Message
 ;          SLINE   - Starting Section Line Number
 ;          ELINE   - Current Ending Section Line Number
 ; Output:  ELINE   - Updated Ending Section Line Number
 ;
 N SL0,SL1,RFAIEN1,XX,YY,ARY,LN,I
 S ELINE=$$SET^IBRFIWL1("",$J("",40),SLINE,1)            ; Spacing Blank Line-
 S ELINE=$$SETN^IBRFIWL1("Service Line Information / Service Line Status Information",ELINE,1,1)
 ;
 ; Make sure there is line info before wasting everyones time
 I '+$O(^IBA(368,RFAIEN,21,0)) D  Q
 .S ELINE=$$SET^IBRFIWL1("**No line information received** ","",ELINE+1,2)
 .Q
 ;
 S SL0=0
 F  S SL0=$O(^IBA(368,RFAIEN,21,SL0)) Q:SL0'=+SL0  D
 . S RFAIEN1=SL0_","_RFAIEN_","
 . S XX=$$GETFVAL^IBRFIWL("368.021,.1",RFAIEN1,"",0,2)
 . S ELINE=$$SET^IBRFIWL1("Line Item Control Number: ",XX,ELINE,1)
 . S XX=$$GETFVAL^IBRFIWL("368.0121,.11",RFAIEN1,"",3,2)
 . S ELINE=$$SET^IBRFIWL1("Service Line Date: ",XX,ELINE,1)  ;*FA* Same as service date above
 . S XX=$$GETFVAL^IBRFIWL("368.0121,.09",RFAIEN1,"",0,2)
 . S ELINE=$$SET^IBRFIWL1("Revenue Code: ",XX,ELINE,1)
 . S XX=$$GETFVAL^IBRFIWL("368.0121,.02",RFAIEN1,"",0,2)
 . S ELINE=$$SET^IBRFIWL1("Coding Method: ",XX,ELINE,1)
 . S XX=$$GETFVAL^IBRFIWL("368.0121,.03",RFAIEN1,"",0,2)
 . S ELINE=$$SET^IBRFIWL1("Procedure Code: ",XX,ELINE,1)
 . S XX=$$GETFVAL^IBRFIWL("368.0121,.04",RFAIEN1,"",0,2)
 . S:XX'="" ELINE=$$SET^IBRFIWL1("  Procedure Modifier 1: ",XX,ELINE,1)
 . S XX=$$GETFVAL^IBRFIWL("368.0121,.05",RFAIEN1,"",0,2)
 . S:XX'="" ELINE=$$SET^IBRFIWL1("  Procedure Modifier 2: ",XX,ELINE,1)
 . S XX=$$GETFVAL^IBRFIWL("368.0121,.06",RFAIEN1,"",0,2)
 . S:XX'="" ELINE=$$SET^IBRFIWL1("  Procedure Modifier 3: ",XX,ELINE,1)
 . S XX=$$GETFVAL^IBRFIWL("368.0121,.07",RFAIEN1,"",0,2)
 . S:XX'="" ELINE=$$SET^IBRFIWL1("  Procedure Modifier 4: ",XX,ELINE,1)
 . S XX=$$GETFVAL^IBRFIWL("368.0121,.08",RFAIEN1,"",0,2) S:XX]"" XX="$"_XX
 . S ELINE=$$SET^IBRFIWL1("Line Item Charge Amount: ",XX,ELINE,1)
 . S SL1=0 F  S SL1=$O(^IBA(368,RFAIEN,121,SL0,99,SL1)) Q:SL1'=+SL1  D
 .. S RFAIEN1=SL1_","_SL0_","_RFAIEN
 .. S XX=$$GETFVAL^IBRFIWL("368.12199,1.01",RFAIEN1,"",0,2)
 .. S YY=$$GET1^DIQ(368.12199,RFAIEN1,1.01,"I")
 .. I YY S ZZ=$$GET1^DIQ(368.001,YY_",",.02) I ZZ]"" S XX=XX_" - "_ZZ
 .. I XX'="" D
 ... K ARY S LN=$$WRAP^IBRFIWLA(XX,64,79,.ARY)
 ... S ELINE=$$SET^IBRFIWL1("HCCS Category: ",ARY(1),ELINE,1)
 ... F I=2:1:LN S:$D(ARY(LN)) ELINE=$$SET^IBRFIWL1("",ARY(I),ELINE,1)
 .. S XX=$$GETFVAL^IBRFIWL("368.12199,1.02",RFAIEN1,"",0,2)
 .. S YY=$$GET1^DIQ(368.12199,RFAIEN1,1.02,"I")
 .. I YY S ZZ=$P($$GET1^DIQ(368.12199,RFAIEN1,"1.02:80"),":") I ZZ]"" S XX=XX_" - "_ZZ
 .. S LN=$$WRAP^IBRFIWLA(XX,42,79,.ARY)
 .. S ELINE=$$SET^IBRFIWL1("Add'l Info Request Modifier (LOINC): ",ARY(1),ELINE,1)
 .. F I=2:1:LN S:$D(ARY(LN)) ELINE=$$SET^IBRFIWL1("",ARY(I),ELINE,1)
 .. S XX=$$GETFVAL^IBRFIWL("368.12199,10.01",RFAIEN1,"",0,2)
 .. S YY=$$GET1^DIQ(368.12199,RFAIEN1,10.01,"I")
 .. I YY S ZZ=$$GET1^DIQ(368.001,YY_",",.02) I ZZ]"" S XX=XX_" - "_ZZ
 .. I XX'="" D
 ... K ARY S LN=$$WRAP^IBRFIWLA(XX,62,77,.ARY)
 ... S ELINE=$$SET^IBRFIWL1("  HCCS Category: ",ARY(1),ELINE,1)
 ... F I=2:1:LN S:$D(ARY(LN)) ELINE=$$SET^IBRFIWL1("  ",ARY(I),ELINE,1)
 .. S XX=$$GETFVAL^IBRFIWL("368.12199,10.02",RFAIEN1,"",0,2)
 .. S YY=$$GET1^DIQ(368.12199,RFAIEN1,10.02,"I")
 .. I YY S ZZ=$P($$GET1^DIQ(368.12199,RFAIEN1,"10.02:80"),":") I ZZ]"" S XX=XX_" - "_ZZ
 .. I XX'="" D
 ... K ARY S LN=$$WRAP^IBRFIWLA(XX,48,77,.ARY)
 ... S ELINE=$$SET^IBRFIWL1("  Add'l Info Request Modifier: ",ARY(1),ELINE,1)
 ... F I=2:1:LN S:$D(ARY(LN)) ELINE=$$SET^IBRFIWL1("  ",ARY(I),ELINE,1)
 .. S XX=$$GETFVAL^IBRFIWL("368.12199,11.01",RFAIEN1,"",0,2)
 .. S YY=$$GET1^DIQ(368.12199,RFAIEN1,11.01,"I")
 .. I YY S ZZ=$$GET1^DIQ(368.001,YY_",",.02) I ZZ]"" S XX=XX_" - "_ZZ
 .. I XX'="" D
 ... K ARY S LN=$$WRAP^IBRFIWLA(XX,62,77,.ARY)
 ... S ELINE=$$SET^IBRFIWL1("  HCCS Category: ",ARY(1),ELINE,1)
 ... F I=2:1:LN S:$D(ARY(LN)) ELINE=$$SET^IBRFIWL1("  ",ARY(I),ELINE,1)
 .. S XX=$$GETFVAL^IBRFIWL("368.12199,11.02",RFAIEN1,"",0,2)
 .. S YY=$$GET1^DIQ(368.12199,RFAIEN1,11.02,"I")
 .. I YY S ZZ=$P($$GET1^DIQ(368.12199,RFAIEN1,"11.02:80"),":") I ZZ]"" S XX=XX_" - "_ZZ
 .. I XX'="" D
 ... K ARY S LN=$$WRAP^IBRFIWLA(XX,48,77,.ARY)
 ... S ELINE=$$SET^IBRFIWL1("  Add'l Info Request Modifier: ",ARY(1),ELINE,1)
 ... F I=2:1:LN S:$D(ARY(LN)) ELINE=$$SET^IBRFIWL1("  ",ARY(I),ELINE,1)
 .. S XX=$$GETFVAL^IBRFIWL("368.12199,.02",RFAIEN1,"",3,2)
 .. S ELINE=$$SET^IBRFIWL1("Status Information Effective Date: ",XX,ELINE,1)
 .. ;S ELINE=$$SET^IBRFIWL1("Response Due Date: ","",ELINE,1)
 Q
