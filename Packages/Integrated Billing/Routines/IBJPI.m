IBJPI ;DAOU/BHS - IBJP eIV SITE PARAMETERS SCREEN ;01-APR-2015
 ;;2.0;INTEGRATED BILLING;**184,271,316,416,438,479,506,528,549,601,621,659**;21-MAR-94;Build 16
 ;;Per VA Directive 6402, this routine should not be modified.
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
 W !,"This screen displays all of the eIV Site Parameters used to manage the"
 W !,"eIV application used for electronic Insurance Verification."
 W !!,"The General Parameters section concerns overall parameters for"
 W !,"monitoring the interface and controlling eIV communication between"
 W !,"VistA and the EC located in Austin."
 W !!,"The Batch Extracts section concerns extract-specific parameters"
 W !,"including active/inactive status and selection criteria. Parameters"
 W !,"associated with a specific extract may also be detailed here."
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
 S VALMCNT=ELINEL-1
 Q
 ;
BLDGENE(SLINE,ELINE) ; Build the General Editable Parameters Section
 ; Input:   SLINE   - Starting Section Line Number
 ;          ELINE   - Current Ending Section Line Number
 ; Output:  ELINE   - Updated Ending Section Line Number
 ;
 ; IB*2.0*621/DM adjusted this area to get SSVI parameters on the same line 
 N XX
 S ELINE=$$SETN("General Parameters (editable)",SLINE,1,1)
 S ELINE=$$SET("          Medicare Payer: ",$$GET1^DIQ(350.9,"1,",51.25),ELINE,1)
 S ELINE=$$SET("           HMS Directory: ",$$GET1^DIQ(350.9,"1,",13.01),ELINE,1)
 S ELINE=$$SET("              EII Active: ",$$GET1^DIQ(350.9,"1,",13.02),ELINE,1)
 ;
 S XX=$$GET1^DIQ(350.9,"1,",100,"I"),XX=$S(XX:"YES",1:"NO")
 S ELINE=$$SET("            SSVI Enabled: ",XX,ELINE,1)    ; IB*2*528/baa
 S XX=$$GET1^DIQ(350.9,"1,",103,"I")
 S ELINE=$$SET("Days to retain SSVI data: ",XX,ELINE-1,38) ; IB*2*528/baa
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
 S ELINE=$$SETN("General Parameters (non-editable)",ELINE,1,1)
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
 N IBEX,IBEX1,IBEX2,IBEX3,IBIIVB,IBST,IEN
 S ELINE=$$SET("",$J("",40),ELINE,1)            ; Spacing Blank Line
 S ELINE=$$SETN("Batch Extracts",ELINE,1,1)
 S ELINE=$$SET(" Extract               Selection    Maximum # to","",ELINE,1)
 S ELINE=$$SETN("Name         On/Off   Criteria     Extract/Day",ELINE,1,"",1)
 ;
 ; Loop thru extracts
 S IEN=0
 F  D  Q:'IEN
 . S IEN=$O(^IBE(350.9,1,51.17,IEN))
 . Q:'IEN
 . S IBIIVB=$G(^IBE(350.9,1,51.17,IEN,0))       ; Batch Extract multiple line
 . S IBEX=+$P(IBIIVB,"^",1)                     ; Type
 . Q:'$F(".1.2.","."_IBEX_".")
 . S IBST=$$FO^IBCNEUT1($S($P(IBIIVB,"^",1)'="":$$GET1^DIQ(350.9002,IEN_",1,",.01,"E"),1:""),14)
 . S IBST=IBST_$$FO^IBCNEUT1($S(+$P(IBIIVB,"^",2):"ON",1:"OFF"),9)
 . S IBEX1=$S(+$P(IBIIVB,U,3)'=0:+$P(IBIIVB,"^",3),1:$P(IBIIVB,"^",3))
 . S IBEX2=$S(+$P(IBIIVB,U,4)'=0:+$P(IBIIVB,"^",4),1:$P(IBIIVB,"^",4))
 . S IBST=IBST_$$FO^IBCNEUT1($S(IBEX=1:"n/a",IBEX=2:IBEX1,IBEX=3:IBEX1_"/"_IBEX2,1:"ERROR"),13)
 . S IBST=IBST_$$FO^IBCNEUT1($S(+$P(IBIIVB,"^",5):+$P(IBIIVB,"^",5),1:$P(IBIIVB,"^",5)),14)
 . S ELINE=$$SET(IBST,"",ELINE,1)
 ; IB*2.0*621/DM display EICD extract (#4), eventually, other extracts will migrate to this structure 
 S ELINE=$$SET("",$J("",40),ELINE,1)  ; Spacing Blank Line 
 S ELINE=$$SET("",$J("",40),ELINE,1)  ; Spacing Blank Line
 S ELINE=$$SET(" Extract               Start Days   Days After           Maximum # to","",ELINE,1)
 S ELINE=$$SETN("Name         On/Off   From Today   Start        Freq.   Extract/Day",ELINE,1,"",1)
 I $$GET1^DIQ(350.9002,"4,1,",.01)="EICD" D 
 . S IBEX=$$SETTINGS^IBCNEDE7(4) ; collect EICD parameters 
 . S IBST=$$FO^IBCNEUT1("EICD",14)
 . S IBST=IBST_$$FO^IBCNEUT1($S(+IBEX:"ON",1:"OFF"),9)
 . S IBST=IBST_$$FO^IBCNEUT1(+$P(IBEX,"^",6),13) ; Start Days
 . S IBST=IBST_$$FO^IBCNEUT1(+$P(IBEX,"^",7),13) ; Days After 
 . S IBST=IBST_$$FO^IBCNEUT1(+$P(IBEX,"^",8),8) ; Frequency
 . S IBST=IBST_$$FO^IBCNEUT1(+$P(IBEX,"^",4),8) ; Max extract
 . S ELINE=$$SET(IBST,"",ELINE,1)
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
