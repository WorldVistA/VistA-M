IBJPI ;DAOU/BHS - IBJP eIV SITE PARAMETERS SCREEN ; 01-APR-2015
 ;;2.0;INTEGRATED BILLING;**184,271,316,416,438,479,506,528,549,601,621,659,668,687,702,732**;21-MAR-94;Build 13
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;/vd-IB*2*668 - Removed the SSVI logic introduced with IB*2*528 in its entirety within VistA.
 ;
 ; eIV - Electronic Insurance Verification Interface parameters
 ;
EN ; main entry pt for IBJP IIV SITE PARAMS
 N CTRLCOL,POP,VALMCNT,VALMHDR,X,%DT
 D EN^VALM("IBJP IIV SITE PARAMETERS")
 Q
 ;
HDR ; header 
 S VALMHDR(1)="Only authorized persons may edit this data."
 Q
 ;
INIT ; init vars & list array
 K ^TMP($J,"IBJPI")
 ; Kills data and video control arrays with active list
 D CLEAN^VALM10
 D BLD
 Q
 ;
HELP ; help
 ; IB*2.0*601,IB*2.0*621/DM adjust help text
 D FULL^VALM1
 W @IOF
 ;IB*732/CKB - modified the text & added text for the Fix Corrupt Buffers action
 W !,"This screen displays all the eIV and IIU Site Parameters used to manage"
 W !,"electronic Insurance Verification."
 W !!,"The General Parameters section concerns overall parameters for"
 W !,"monitoring the interface and controlling eIV and IIU communication"
 W !,"between VistA and the EC located in Austin."
 W !!,"The Batch Extracts section concerns extract-specific parameters"
 W !,"including active/inactive status and selection criteria. Parameters"
 W !,"associated with a specific extract may also be detailed here."
 W !!,"The Fix Corrupt Buffers action allows a user to fix corrupted entries in"
 W !,"the INSURANCE VERIFICATION PROCESSOR file (#355.33) aka ""the buffer file""."
 D PAUSE^VALM1
 W @IOF
 S VALMBCK="R"
 Q
 ;
EXIT ; exit
 K ^TMP($J,"IBJPI")
 D CLEAN^VALM10
 Q
 ;
BLD ; Creates the body of the worklist
 ; IB*2.0*549 - rewrote this entire method and all methods called from it to
 ;              change to a totally new display of fields
 N ELINEL,ELINER,SLINE,STARTR
 S VALMCNT=0,SLINE=1
 D BLDGENE(SLINE,.ELINEL)                       ; Build Editable General Parameters
 D BLDGENNL(ELINEL,.STARTR,.ELINEL)             ; Build Non-Editable Gen Param left
 D BLDGENNR(STARTR,.ELINER)                     ; Build Non-Editable Gen Param Right
 S SLINE=$S(ELINEL>ELINER:ELINEL,1:ELINER)
 D BLDGENNB(SLINE,.ELINEL)                      ; Build Non-Editable Bottom Params
 D BLDBE(ELINEL,.ELINEL)                        ; Build Batch Extract Gen Parameters
 D BLDGENNS(.ELINEL)                     ; Build Non-Editable IIU Parameters - vd/IB*2*687
 S VALMCNT=ELINEL-1
 Q
 ;
BLDGENE(SLINE,ELINE) ; Build the General Editable Parameters Section
 ; Input:   SLINE   - Starting Section Line Number
 ;          ELINE   - Current Ending Section Line Number
 ; Output:  ELINE   - Updated Ending Section Line Number
 ;
 N STRTLN,XX   ;/vd-IB*2*687 - added the STRTLN variable
 S ELINE=$$SETN("General Parameters (editable)",SLINE,1,1)
 S ELINE=$$SET("          Medicare Payer: ",$$GET1^DIQ(350.9,"1,",51.25),ELINE,1)
 S ELINE=$$SET("           HMS Directory: ",$$GET1^DIQ(350.9,"1,",13.01),ELINE,1)
 S ELINE=$$SET("              EII Active: ",$$GET1^DIQ(350.9,"1,",13.02),ELINE,1)
 ;/vd-IB*2*687 - Added the following 3 lines.
 S STRTLN=ELINE
 S ELINE=$$SET("             IIU Enabled: ",$$GET1^DIQ(350.9,"1,",53.02),ELINE,1)
 ;IB*702/TAZ - Added display for EIV NO GRP NUM A/U
 S ELINE=STRTLN
 S ELINE=$$SET(" eIV No Group # Auto-Update: ",$$GET1^DIQ(350.9,"1,",51.34),ELINE,41)
 ;
 Q
 ;
BLDGENNL(SLINE,STARTR,ELINE) ; Build the Left portion of the General
 ; Non-Editable Parameters Section
 ; Input:   SLINE   - Starting Section Line Number
 ;          ELINE   - Current Ending Section Line Number
 ; Output:  STARTR  - Line to start displaying General Non-Editable Right
 ;                    Section
 ;          ELINE   - Updated Ending Section Line Number
 ;
 N XX
 S ELINE=$$SET("",$J("",40),SLINE,1)            ; Spacing Blank Line
 S ELINE=$$SETN("eIV Parameters (non-editable)",ELINE,1,1)   ;/vd-IB*2*687 - changed the text for this line.
 S STARTR=ELINE                                 ; Start of Right Section
 S ELINE=$$SET("          Freshness Days: ",$$GET1^DIQ(350.9,"1,",51.01),ELINE,1)
 S ELINE=$$SET("            Timeout Days: ",$$GET1^DIQ(350.9,"1,",51.05),ELINE,1)
 S ELINE=$$SET("     Timeout Mailman Msg: ",$$GET1^DIQ(350.9,"1,",51.07),ELINE,1)
 S ELINE=$$SET("             Default STC: ",$$GET1^DIQ(350.9,"1,",60.01),ELINE,1)
 S ELINE=$$SET("  Master Switch Realtime: ",$$GET1^DIQ(350.9,"1,",51.27),ELINE,1)
 S ELINE=$$SET("           CMS MBI Payer: ",$$GET1^DIQ(350.9,"1,","MBI PAYER"),ELINE,1) ; IB*2.0*601/DM 
 S ELINE=$$SET("              EICD Payer: ",$$GET1^DIQ(350.9,"1,","EICD PAYER"),ELINE,1) ; IB*2.0*621/DM 
 Q
 ;
BLDGENNR(SLINE,ELINE) ; Build the Right portion of the General
 ; Non-Editable Parameters Section
 ; Input:   SLINE   - Starting Section Line Number
 ;          ELINE   - Current Ending Section Line Number
 ; Output:  ELINE   - Updated Ending Section Line Number
 ;
 S ELINE=SLINE
 ;/vd-IB*2*659 - Moved the HL7 Max # to the bottom of the 2nd column and
 ;               inserted the Medicare Freshness Days to the top of the 2nd column.
 S ELINE=$$SET("Medicare Freshness Days: ",$$GET1^DIQ(350.9,"1,",51.32),ELINE,39)
 S ELINE=$$SET("           Retry Flag: ",$$GET1^DIQ(350.9,"1,",51.26),ELINE,41)
 S ELINE=$$SET("    Number of Retries: ",$$GET1^DIQ(350.9,"1,",51.06),ELINE,41)
 S ELINE=$$SET("           Mail Group: ",$$MGRP^IBCNEUT5,ELINE,41)
 S ELINE=$$SET("Master Switch Nightly: ",$$GET1^DIQ(350.9,"1,",51.28),ELINE,41)
 S ELINE=$$SET("            HL7 Max #: ",$$GET1^DIQ(350.9,"1,",51.15),ELINE,41)
 Q
 ;
BLDGENNB(SLINE,ELINE) ; Build the General Non-Editable Bottom Parameters Section
 ; Input:   SLINE   - Starting Section Line Number
 ;          ELINE   - Current Ending Section Line Number
 ; Output:  ELINE   - Updated Ending Section Line Number
 ;
 N XX
 S ELINE=$$SET("",$J("",40),SLINE,1)            ; Spacing Blank Line
 S XX=$$GET1^DIQ(350.9,"1,",51.2)
 S:XX="" XX="NO"
 S ELINE=$$SET("Send MailMan Message if Communication Problem: ",XX,ELINE,1)
 S XX=$$GET1^DIQ(350.9,"1,",51.02)
 S:XX="" XX="NO"
 S XX=$$GET1^DIQ(350.9,"1,",51.02)_" at "_$$GET1^DIQ(350.9,"1,",51.03)
 S ELINE=$$SET("   Receive MailMan Message, Daily Statistical: ",XX,ELINE,1)
 Q
 ;
BLDBE(SLINE,ELINE) ; Build the Batch Extract Parameters Section
 ; Input:   SLINE   - Starting Section Line Number
 ;          ELINE   - Current Ending Section Line Number
 ; Output:  ELINE   - Updated Ending Section Line Number
 ;
 N IBEX,IBEX1,IBEIVB,IBST,IEN
 S ELINE=$$SET("",$J("",40),ELINE,1)            ; Spacing Blank Line
 S ELINE=$$SETN("Batch Extracts",ELINE,1,1)
 ;/vd-IB*2*687 - Commented the following section of code and re-wrote it to make it cleaner.
 ;               Also renamed variable IBIIVB to IBEIVB to better reflect the application name
 ;S ELINE=$$SET(" Extract               Selection    Maximum # to","",ELINE,1)
 ;S ELINE=$$SETN("Name         On/Off   Criteria     Extract/Day",ELINE,1,"",1)
 ;
 ; Loop thru extracts
 ;S IEN=0
 ;F  D  Q:'IEN
 ;. S IEN=$O(^IBE(350.9,1,51.17,IEN))
 ;. Q:'IEN
 ;. S IBIIVB=$G(^IBE(350.9,1,51.17,IEN,0))       ; Batch Extract multiple line
 ;. S IBEX=+$P(IBIIVB,"^",1)                     ; Type
 ;. Q:'$F(".1.2.","."_IBEX_".")
 ;. S IBST=$$FO^IBCNEUT1($S($P(IBIIVB,"^",1)'="":$$GET1^DIQ(350.9002,IEN_",1,",.01,"E"),1:""),14)
 ;. S IBST=IBST_$$FO^IBCNEUT1($S(+$P(IBIIVB,"^",2):"ON",1:"OFF"),9)
 ;. S IBEX1=$S(+$P(IBIIVB,U,3)'=0:+$P(IBIIVB,"^",3),1:$P(IBIIVB,"^",3))
 ;. S IBEX2=$S(+$P(IBIIVB,U,4)'=0:+$P(IBIIVB,"^",4),1:$P(IBIIVB,"^",4))
 ;. S IBST=IBST_$$FO^IBCNEUT1($S(IBEX=1:"n/a",IBEX=2:IBEX1,IBEX=3:IBEX1_"/"_IBEX2,1:"ERROR"),13)
 ;. S IBST=IBST_$$FO^IBCNEUT1($S(+$P(IBIIVB,"^",5):+$P(IBIIVB,"^",5),1:$P(IBIIVB,"^",5)),14)
 ;. S ELINE=$$SET(IBST,"",ELINE,1)
 ;; IB*2.0*621/DM display EICD extract (#4), eventually, other extracts will migrate to this structure 
 ;S ELINE=$$SET("",$J("",40),ELINE,1)  ; Spacing Blank Line 
 ;S ELINE=$$SET("",$J("",40),ELINE,1)  ; Spacing Blank Line
 ;S ELINE=$$SET(" Extract               Start Days   Days After           Maximum # to","",ELINE,1)
 ;S ELINE=$$SETN("Name         On/Off   From Today   Start        Freq.   Extract/Day",ELINE,1,"",1)
 ;I $$GET1^DIQ(350.9002,"4,1,",.01)="EICD" D 
 ;. S IBEX=$$SETTINGS^IBCNEDE7(4) ; collect EICD parameters 
 ;. S IBST=$$FO^IBCNEUT1("EICD",14)
 ;. S IBST=IBST_$$FO^IBCNEUT1($S(+IBEX:"ON",1:"OFF"),9)
 ;. S IBST=IBST_$$FO^IBCNEUT1(+$P(IBEX,"^",6),13) ; Start Days
 ;. S IBST=IBST_$$FO^IBCNEUT1(+$P(IBEX,"^",7),13) ; Days After 
 ;. S IBST=IBST_$$FO^IBCNEUT1(+$P(IBEX,"^",8),8) ; Frequency
 ;. S IBST=IBST_$$FO^IBCNEUT1(+$P(IBEX,"^",4),8) ; Max extract
 ;. S ELINE=$$SET(IBST,"",ELINE,1)
 ;
 ;/vd-IB*2*687 - Beginning of new/restructured code.
 N APPTBE,BENAME,FRESHDAY
 S FRESHDAY=$$GET1^DIQ(350.9,"1,",51.01)  ; FRESHNESS DAYS - used by Buffer/Appt as "Frequency"
 S ELINE=$$SET(" Extract               Start Days   Days After           Maximum # to","",ELINE,1)
 S ELINE=$$SETN("Name         On/Off   From Today   Start        Freq.   Extract/Day",ELINE,1,"",1)
 ;
 ; Loop thru Batch Extracts.
 S IEN=0
 F  S IEN=$O(^IBE(350.9,1,51.17,IEN)) Q:'IEN  D
 . S IBEX=+$P($G(^IBE(350.9,1,51.17,IEN,0)),U)    ; Type
 . I "^1^2^4^"'[(U_IBEX_U) Q          ; Only want Buffer, Appt and EICD Batch Extracts.
 . S IBEIVB=$$SETTINGS^IBCNEDE7(IBEX) ; collect specific extract's site parameter settings
 . S BENAME=$S($P(IBEIVB,U,1)'="":$$GET1^DIQ(350.9002,IEN_",1,",.01,"E"),1:"")
 . I BENAME="Appt" S APPTBE=1,BENAME=BENAME_" *"   ; If this is the APPT extract, need to add footnote.
 . S IBST=$$FO^IBCNEUT1(BENAME,14)    ; Extract Name 
 . S IBST=IBST_$$FO^IBCNEUT1($S(+$P(IBEIVB,"^",1):"ON",1:"OFF"),9)
 . S IBEX1=$P(IBEIVB,U,6)
 . S IBST=IBST_$$FO^IBCNEUT1($S("^1^2^"[(U_IBEX_U):"Today",IBEX=4:IBEX1,1:"n/a"),13) ; Start Days
 . S IBST=IBST_$$FO^IBCNEUT1($S(IBEX=1:"Today",IBEX=2:$$GET1^DIQ(350.9002,IEN_",1,",.03),IBEX=4:+$P(IBEIVB,U,7),1:"n/a"),13)   ; Days After Start
 . S IBST=IBST_$$FO^IBCNEUT1($S(IBEX=4:+$P(IBEIVB,U,8),1:FRESHDAY),8) ; Frequency
 . S IBST=IBST_$$FO^IBCNEUT1(+$P(IBEIVB,U,4),8)                       ; Max extract
 . S ELINE=$$SET(IBST,"",ELINE,1)
 ;/vd-IB*2*687 - End of new/restructured code.
 ;
 I +APPTBE D   ;/vd-IB*2*687 - Added to indicate "APPT" Buffer Entry.
 . S ELINE=$$SET("","",ELINE,1)            ; Spacing Blank Line
 . S ELINE=$$SET("   * Appt extract - Medicare frequency is "_$$GET1^DIQ(350.9,"1,",51.32)_" days","",ELINE,1)
 Q
 ;
 ;/vd - IB*2.0*687 - The BLDGENNS module was added for the IIU Parameters.
BLDGENNS(ELINE) ; Build the IIU Parameters Non-editable Section
 ; Input: SLINE - Starting Section Line Number
 ; ELINE - Current Ending Section Line Number
 ; Output: ELINE - Updated Ending Section Line Number
 ;
 N STRTLN,XX
 S ELINE=$$SET("",$J("",40),ELINE,1) ; Spacing Blank Line
 S ELINE=$$SETN("IIU Parameters (non-editable)",ELINE,1,1)
 S STRTLN=ELINE
 S ELINE=$$SET("     Max Days of Recent Visit: ",$$GET1^DIQ(350.9,"1,",53.03),ELINE,1)
 S ELINE=$$SET("Min Days Before Sharing Again: ",$$GET1^DIQ(350.9,"1,",53.04),ELINE,1)
 S ELINE=$$SET("            IIU Master Switch: ",$$GET1^DIQ(350.9,"1,",53.01),ELINE,1)
 S ELINE=STRTLN
 S ELINE=$$SET("      Purging Sent Records: ",$$GET1^DIQ(350.9,"1,",53.05),ELINE,41)
 S ELINE=$$SET("  Purging Received Records: ",$$GET1^DIQ(350.9,"1,",53.07),ELINE,41)
 S ELINE=$$SET(" Purging Candidate Records: ",$$GET1^DIQ(350.9,"1,",53.06),ELINE,41)
 Q
 ;
SET(LABEL,DATA,LINE,COL) ; Sets text into the body of the worklist
 ; Input:   LABEL   - Label text to set into the line
 ;          DATA    - Field Data to set into the line
 ;          LINE    - Line to set LABEL and DATA into
 ;          COL     - Starting column position in LINE to insert
 ;                    LABEL_DATA text
 ; Returns: LINE    - Updated Line by 1
 ;
 N IBY
 S IBY=LABEL_DATA
 D SET1(IBY,LINE,COL,$L(IBY))
 S LINE=LINE+1
 Q LINE
 ;
SETN(TITLE,LINE,COL,RV,ULINE) ; Sets a field Section title into the body of the worklist
 ; Input:   TITLE   - Text to be used for the field Section Title
 ;          LINE    - Line number in the body to insert the field section title
 ;          COL     - Starting Column position to set Section Title into
 ;          RV      - 1 - Set Reverse Video, 0 or null don't use Reverse Video
 ;                        Optional, defaults to ""
 ;          ULINE   - 1 - Set Underline, 0 or null don't use underline
 ;                        Optional, defaults to ""
 ; Returns: LINE    - Line number increased by 1
 ;
 N IBY
 S IBY=" "_TITLE_" "
 D SET1(IBY,LINE,COL,$L(IBY),$G(RV),$G(ULINE))
 S LINE=LINE+1
 Q LINE
 ;
SET1(TEXT,LINE,COL,WIDTH,RV,ULINE) ; Sets the TMP array with body data
 ; Input:   TEXT                - Text to be set into the specified line
 ;          LINE                - Line to set TEXT into
 ;          COL                 - Column of LINE to set TEXT into
 ;          WIDTH               - Width of the TEXT being set into line
 ;          RV                  - 1 - Set Reverse Video, 0 or null don't use
 ;                                    Reverse Video
 ;                                Optional, defaults to ""
 ;          ULINE               - 1 - Set Underline, 0 or null don't use
 ;                                    Underline
 ;                                Optional, defaults to ""
 ;          ^TMP($J,"IBJPI")   - Current ^TMP array
 ; Output:  ^TMP($J,"IBJPI")   - Updated ^TMP array
 ;
 N IBX
 S IBX=$G(^TMP($J,"IBJPI",LINE,0))
 S IBX=$$SETSTR^VALM1(TEXT,IBX,COL,WIDTH)
 D SET^VALM10(LINE,IBX)
 D:$G(RV)'="" CNTRL^VALM10(LINE,COL,WIDTH,IORVON,IORVOFF)
 D:$G(ULINE)'="" CNTRL^VALM10(LINE,COL,WIDTH,IOUON,IOUOFF)
 Q
 ; 
