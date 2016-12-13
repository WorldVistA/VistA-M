IBRFIWL1 ;ALB/FA/JWS - RFAI Message Detail Worklist; 02-SEP-2015
 ;;2.0;INTEGRATED BILLING;**547**;21-MAR-94;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
 ;
EN(RFAIEN,RFAIDET,RFAIDHDR) ; Main entry point
 ; Displays the selected RFAI Message detail
 ; Input:   RFAIEN      - IEN of the selected RFAI Message
 ;          RFAIDET     - The detailed line from the initial worklist to show what entry is being worked on
 ;          RFAIDHDR    - The header for said details mentioned above
 N IBIFN,LOINC
 S IBIFN=$$GET1^DIQ(368,RFAIEN,111.01,"I")      ; IEN for Bill/Claims file
 D EN^VALM("IBRFI 277 DETAIL WL")
 I $D(IBFASTXT) S VALMBCK="Q"
 Q
 ;
HDR ;EP
 ; Listman Template action to display Worklist  header information
 ; Input:   RFAIEN - IEN of the selected Message
 ;          RFAIDET     - The detailed line from the initial worklist to show what entry is being worked on
 ;          RFAIDHDR    - The header for said details mentioned above
 ; Output:  Header information for the Selected Message
 ;
 N RBY,RDATE,XX
 S XX=$$GET1^DIQ(368,RFAIEN,200.04,"I")
 I XX D
 . S RDATE=$$GET1^DIQ(368,RFAIEN,200.05,"I")
 . S RDATE=$$FMTE^XLFDT(RDATE,"2DZ")
 . S RBY=$$GET1^DIQ(368,RFAIEN,200.06)
 . S XX="Review Status: Review in Process By: "_RBY_" on "_RDATE
 E  S XX="Review Status: Not Being Reviewed"
 S VALMHDR(1)=$G(RFAIDHDR)
 S VALMHDR(2)=$G(RFAIDET)
 S VALMHDR(3)=XX
 Q
 ;
INIT ;EP
 ; Listman Template action to initialize the template
 ; Input:   RFAIEN - IEN of the selected Message
 ;
 K ^TMP("IBRFIWL1",$J)
 D BLD
 Q
 ;
BLD ; Creates the body of the worklist
 ; Input:   IBIFN   - IEN of the Bill/Claim (file 399) of the selected message
 ;          RFAIEN  - IEN of the selected Message
 ;
 N ELINEL,ELINER,SLINE
 S SLINE=1
 D BLDISRC(RFAIEN,SLINE,.ELINEL)   ; Build Information Source section
 D BLDCLEV(RFAIEN,ELINEL,.ELINEL)  ; Build Claim Level Status section
 D BLDSLI^IBRFIWLA(RFAIEN,ELINEL,.ELINEL)   ; Build Service Line Info section
 D BLDCOM^IBRFIWLA(RFAIEN,ELINEL,.ELINEL)   ; Build Comment section
 S VALMCNT=ELINEL-1
 Q
 ;
BLDISRC(RFAIEN,SLINE,ELINE) ; Build the Information Source Section
 ; Input:   RFAIEN  - IEN of the selected Message
 ;          SLINE   - Starting Section Line Number
 ;          ELINE   - Current Ending Section Line Number
 ; Output:  ELINE   - Updated Ending Section Line Number
 ;
 N XX,YY,ZZ,WW
 S ELINE=$$SETN("Information Source",SLINE,1,1)
 S XX=$$GETFVAL^IBRFIWL(101.01,RFAIEN,"",0,2)
 S ELINE=$$SET("Payer Name: ",XX,ELINE,1)
 S XX=$$GETFVAL^IBRFIWL(1.03,RFAIEN,"",0,2)
 S ELINE=$$SET("Payer Contact Name: ",XX,ELINE,1)
 S XX=$$GETFVAL^IBRFIWL(3.01,RFAIEN,"",0,2)                 ; Contact 1
 S YY=$$GETFVAL^IBRFIWL(102.01,RFAIEN,"",0,2)               ; Contact 1 Type
 I (YY="FX"!(YY="TE")),$$HLPHONE^HLFNC(XX)]"" S XX=$$HLPHONE^HLFNC(XX)
 S XX=$S(XX="":"",YY="FX":XX_"(Fax)",YY="TE":XX_"(Tel)",YY="EX":XX_"(Ext)",YY="EM":"(Email)",YY="UR":"(url)",1:XX)
 S YY=$$GETFVAL^IBRFIWL(26.01,RFAIEN,"",0,2) I YY]"" S XX=XX_" EXT: "_YY
 S ELINE=$$SET("Payer Contact #1: ",XX,ELINE,1) ;3.01 add (Fax) or (Tel) when
 ;
 S XX=$$GETFVAL^IBRFIWL(4.01,RFAIEN,"",0,2)                 ; Contact 2
 I XX'="" D
 . S YY=$$GETFVAL^IBRFIWL(102.02,RFAIEN,"",0,2)             ; Contact 2 Type
 . I (YY="FX"!(YY="TE")),$$HLPHONE^HLFNC(XX)]"" S XX=$$HLPHONE^HLFNC(XX)
 . S XX=$S(XX="":"",YY="FX":XX_"(Fax)",YY="TE":XX_"(Tel)",YY="EX":XX_"(Ext)",YY="EM":"(Email)",YY="UR":"(url)",1:XX)
 . S YY=$$GETFVAL^IBRFIWL(27.01,RFAIEN,"",0,2) I YY]"" S XX=XX_" EXT: "_YY
 . S ELINE=$$SET("Payer Contact #2: ",XX,ELINE,1)
 ;
 S XX=$$GETFVAL^IBRFIWL(5.01,RFAIEN,"",0,2)                 ; Contact 3
 I XX'="" D
 . S YY=$$GETFVAL^IBRFIWL(102.03,RFAIEN,"",0,2)             ; Contact 3 Type
 . I (YY="FX"!(YY="TE")),$$HLPHONE^HLFNC(XX)]"" S XX=$$HLPHONE^HLFNC(XX)
 . S XX=$S(XX="":"",YY="FX":XX_"(Fax)",YY="TE":XX_"(Tel)",YY="EX":XX_"(Ext)",YY="EM":"(Email)",YY="UR":"(url)",1:XX)
 . S YY=$$GETFVAL^IBRFIWL(28.01,RFAIEN,"",0,2) I YY]"" S XX=XX_" EXT: "_YY
 . S ELINE=$$SET("Payer Contact #3: ",XX,ELINE,1)
 ;
 S XX=$$GETFVAL^IBRFIWL(15.01,RFAIEN,"",0,2)
 S ELINE=$$SET("Payer Response Contact Name: ",XX,ELINE,1)
 S XX=$$GETFVAL^IBRFIWL(17.01,RFAIEN,"",0,2)                ; Response Contact 1
 S YY=$$GETFVAL^IBRFIWL(16.01,RFAIEN,"",0,2)                ; Response Contact 1 Type
 I XX]"",(YY="FX"!(YY="TE")),$$HLPHONE^HLFNC(XX)]"" S XX=$$HLPHONE^HLFNC(XX)
 S XX=$S(XX="":"",YY="FX":XX_"(Fax)",YY="TE":XX_"(Tel)",YY="EX":XX_"(Ext)",YY="EM":"(Email)",YY="UR":"(url)",1:XX)
 S YY=$$GETFVAL^IBRFIWL(29.01,RFAIEN,"",0,2) I YY]"" S XX=XX_" EXT: "_YY
 S ELINE=$$SET("Payer Response Contact #1: ",XX,ELINE,1) ;5.01 skip when null
 ;
 S XX=$$GETFVAL^IBRFIWL(18.01,RFAIEN,"",0,2)                ; Response Contact 2
 I XX'="" D
 . S YY=$$GETFVAL^IBRFIWL(16.02,RFAIEN,"",0,2)              ; Contact 2 Type
 . I (YY="FX"!(YY="TE")),$$HLPHONE^HLFNC(XX)]"" S XX=$$HLPHONE^HLFNC(XX)
 . S XX=$S(XX="":"",YY="FX":XX_"(Fax)",YY="TE":XX_"(Tel)",YY="EX":XX_"(Ext)",YY="EM":"(Email)",YY="UR":"(url)",1:XX)
 . S YY=$$GETFVAL^IBRFIWL(30.01,RFAIEN,"",0,2) I YY]"" S XX=XX_" EXT: "_YY
 . S ELINE=$$SET("Payer Response Contact #2: ",XX,ELINE,1)
 ;
 S XX=$$GETFVAL^IBRFIWL(19.01,RFAIEN,"",0,2)                ; Response Contact 3
 I XX'="" D
 . S YY=$$GETFVAL^IBRFIWL(16.03,RFAIEN,"",0,2)              ; Contact 3 Type
 . I (YY="FX"!(YY="TE")),$$HLPHONE^HLFNC(XX)]"" S XX=$$HLPHONE^HLFNC(XX)
 . S XX=$S(XX="":"",YY="FX":XX_"(Fax)",YY="TE":XX_"(Tel)",YY="EX":XX_"(Ext)",YY="EM":"(Email)",YY="UR":"(url)",1:XX)
 . S YY=$$GETFVAL^IBRFIWL(31.01,RFAIEN,"",0,2) I YY]"" S XX=XX_" EXT: "_YY
 . S ELINE=$$SET("Payer Response Contact #3: ",XX,ELINE,1)
 ;
 S XX=$$GETFVAL^IBRFIWL(20.01,RFAIEN,"",0,2)                ; Response Cont Addr Line 1
 S ELINE=$$SET("Payer Address: ",XX,ELINE,1)
 S XX=$$GETFVAL^IBRFIWL(20.02,RFAIEN,"",0,2)                ; Response Cont Addr Line 2
 I XX]"" S ELINE=$$SET("                             ",XX,ELINE,1)
 S XX=$$GETFVAL^IBRFIWL(20.03,RFAIEN,"",0,2)                ; Response Cont City
 S YY=$$GETFVAL^IBRFIWL(120.04,RFAIEN,"",0,2)               ; Response Cont State
 S ZZ=$$GETFVAL^IBRFIWL(120.05,RFAIEN,"",0,2)               ; Response Cont ZIP
 S WW=$$GETFVAL^IBRFIWL(120.06,RFAIEN,"",0,2)               ; Response Cont Country
 S XX=$S(((XX'="")!(YY'="")!(ZZ'="")!(WW]"")):XX_", "_YY_" "_ZZ_" "_WW,1:"")
 S ELINE=$$SET("",XX,ELINE,1)
 ;
 S XX=$$GETFVAL^IBRFIWL(11.02,RFAIEN,"",0,2)               ; Patient Claim Control #
 S ELINE=$$SET("Payer Claim Control #: ",XX,ELINE,1)
 Q
 ;
BLDCLEV(RFAIEN,SLINE,ELINE) ; Build the Claim Level Status Section
 ; Input:   RFAIEN  - IEN of the selected Message
 ;          SLINE   - Starting Section Line Number
 ;          ELINE   - Current Ending Section Line Number
 ; Output:  ELINE   - Updated Ending Section Line Number
 ;
 N XX,YY,ZZ,XC0,RFAIEN1,IEN399,ARY,LN,I
 S ELINE=$$SET("",$J("",40),SLINE,1)            ; Spacing Blank Line
 S ELINE=$$SETN("Claim Level Status",ELINE,1,1)
 S XX=$$GETFVAL^IBRFIWL(111.01,RFAIEN,"",0,2)
 S ELINE=$$SET("Patient Control #:  ",XX,ELINE,1)
 S XX=$$GETFVAL^IBRFIWL(114.03,RFAIEN,"",3,2)
 S YY=$$GETFVAL^IBRFIWL(114.04,RFAIEN,"",3,2)
 I XX]"" S XX=XX_$S(YY]"":"-"_YY,1:"")
 I XX="" S XX=$$GETFVAL^IBRFIWL(14.05,RFAIEN,"",0,2)
 S ELINE=$$SET("Date of Service: ",XX,ELINE,1)
 S XX=$$GETFVAL^IBRFIWL(11.03,RFAIEN,"",0,2)
 S ELINE=$$SET("Medical Record Number: ",XX,ELINE,1)
 S XX=$$GETFVAL^IBRFIWL(10.01,RFAIEN,"",0,2)
 S ELINE=$$SET("Member Identification Number: ",XX,ELINE,1)
 ;
 S XX=$$GETFVAL^IBRFIWL(25.01,RFAIEN,"",0,2)
 S IEN399=$$GETFVAL^IBRFIWL(111.01,RFAIEN,"",0,0)
 I IEN399,$$INSPRF^IBCEF(IEN399) S ELINE=$$SET("Type of Service: ",XX,ELINE,1)
 I IEN399,XX]"",'$$INSPRF^IBCEF(IEN399) S ELINE=$$SET("Type of Service: ",XX,ELINE,1)
 I 'IEN399,XX]"" S ELINE=$$SET("Type of Service: ",XX,ELINE,1)
 ;
 S XC0=0 F  S XC0=$O(^IBA(368,RFAIEN,13,XC0)) Q:XC0'=+XC0  D
 . S RFAIEN1=XC0_","_RFAIEN
 . S XX=$$GETFVAL^IBRFIWL("368.0113,1.01",RFAIEN1,"",0,2)
 . S YY=$$GET1^DIQ(368.0113,RFAIEN1,1.01,"I")
 . I YY S ZZ=$$GET1^DIQ(368.001,YY_",",.02) I ZZ]"" S XX=XX_" - "_ZZ
 . I XX'="" D
 .. K ARY S LN=$$WRAP^IBRFIWLA(XX,64,79,.ARY)
 .. S ELINE=$$SET("HCCS Category: ",ARY(1),ELINE,1)
 .. F I=2:1:LN S:$D(ARY(LN)) ELINE=$$SET("",ARY(I),ELINE,1)
 .;
 . S XX=$$GETFVAL^IBRFIWL("368.0113,1.02",RFAIEN1,"",0,2)
 . S YY=$$GET1^DIQ(368.0113,RFAIEN1,1.02,"I")
 . I YY S ZZ=$P($$GET1^DIQ(368.0113,RFAIEN1,"1.02:80"),":") I ZZ]"" S XX=XX_" - "_ZZ
 . S LN=$$WRAP^IBRFIWLA(XX,42,79,.ARY)
 . S ELINE=$$SET("Add'l Info Request Modifier (LOINC): ",ARY(1),ELINE,1)
 . F I=2:1:LN S:$D(ARY(LN)) ELINE=$$SET("",ARY(I),ELINE,1)
 .;
 . S XX=$$GETFVAL^IBRFIWL("368.0113,10.01",RFAIEN1,"",0,2)
 . S YY=$$GET1^DIQ(368.0113,RFAIEN1,10.01,"I")
 . I YY S ZZ=$$GET1^DIQ(368.001,YY_",",.02) I ZZ]"" S XX=XX_" - "_ZZ
 . I XX'="" D
 .. K ARY S LN=$$WRAP^IBRFIWLA(XX,62,77,.ARY)
 .. S ELINE=$$SET("  HCCS Category: ",ARY(1),ELINE,1)
 .. F I=2:1:LN S:$D(ARY(LN)) ELINE=$$SET("  ",ARY(I),ELINE,1)
 .;
 . S XX=$$GETFVAL^IBRFIWL("368.0113,10.02",RFAIEN1,"",0,2)
 . S YY=$$GET1^DIQ(368.0113,RFAIEN1,10.02,"I")
 . I YY S ZZ=$P($$GET1^DIQ(368.0113,RFAIEN1,"10.02:80"),":") I ZZ]"" S XX=XX_" - "_ZZ
 . I XX'="" D
 .. K ARY S LN=$$WRAP^IBRFIWLA(XX,48,77,.ARY)
 .. S ELINE=$$SET("  Add'l Info Request Modifier: ",ARY(1),ELINE,1)
 .. F I=2:1:LN S:$D(ARY(LN)) ELINE=$$SET("  ",ARY(I),ELINE,1)
 .;
 . S XX=$$GETFVAL^IBRFIWL("368.0113,11.01",RFAIEN1,"",0,2)
 . S YY=$$GET1^DIQ(368.0113,RFAIEN1,11.01,"I")
 . I YY S ZZ=$$GET1^DIQ(368.001,YY_",",.02) I ZZ]"" S XX=XX_" - "_ZZ
 . I XX'="" D
 .. K ARY S LN=$$WRAP^IBRFIWLA(XX,62,77,.ARY)
 .. S ELINE=$$SET("  HCCS Category: ",ARY(1),ELINE,1)
 .. F I=2:1:LN S:$D(ARY(LN)) ELINE=$$SET("  ",ARY(I),ELINE,1)
 .;
 . S XX=$$GETFVAL^IBRFIWL("368.0113,11.02",RFAIEN1,"",0,2)
 . S YY=$$GET1^DIQ(368.0113,RFAIEN1,11.02,"I")
 . I YY S ZZ=$P($$GET1^DIQ(368.0113,RFAIEN1,"11.02:80"),":") I ZZ]"" S XX=XX_" - "_ZZ
 . I XX'="" D
 .. K ARY S LN=$$WRAP^IBRFIWLA(XX,48,77,.ARY)
 .. S ELINE=$$SET("  Add'l Info Request Modifier: ",ARY(1),ELINE,1)
 .. F I=2:1:LN S:$D(ARY(LN)) ELINE=$$SET("  ",ARY(I),ELINE,1)
 .;
 . S XX=$$GETFVAL^IBRFIWL("368.0113,.02",RFAIEN1,"",3,2)
 . S ELINE=$$SET("Status Information Effective Date: ",XX,ELINE,1)
 S XX=$$GETFVAL^IBRFIWL(112.01,RFAIEN,"",0,2)
 S ELINE=$$SET("Response Due Date: ",XX,ELINE,1)
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
SETN(TITLE,LINE,COL,RV) ; Sets a field Section title into the body of the worklist
 ; Input:   TITLE   - Text to be used for the field Section Title
 ;          LINE    - Line number in the body to insert the field section title
 ;          COL     - Starting Column position to set Section Title into
 ;          RV      - 1 - Set Reverse Video, 0 or null dont use Reverse Video
 ;                        Optional, defaults to ""
 ; Returns: LINE    - Line number increased by 1
 ;
 N IBY
 S IBY=" "_TITLE_" "
 D SET1(IBY,LINE,COL,$L(IBY),$G(RV))
 S LINE=LINE+1
 Q LINE
 ;
SET1(TEXT,LINE,COL,WIDTH,RV) ; Sets the TMP array with body data
 ; Input:   TEXT                - Text to be set into the specified line
 ;          LINE                - Line to set TEXT into
 ;          COL                 - Column of LINE to set TEXT into
 ;          WIDTH               - Width of the TEXT being set into line
 ;          RV                  - 1 - Set Reverse Video, 0 or null dont use
 ;                                    Reverse Video
 ;                                Optional, defaults to ""
 ;          ^TMP("IBRFIWL1",$J) - Current ^TMP array
 ; Output:  ^TMP("IBRFIWL1",$J) - Updated ^TMP array
 ;
 N IBX
 S IBX=$G(^TMP("IBRFIWL1",$J,LINE,0))
 S IBX=$$SETSTR^VALM1(TEXT,IBX,COL,WIDTH)
 D SET^VALM10(LINE,IBX)
 D:$G(RV)'="" CNTRL^VALM10(LINE,COL,WIDTH,IORVON,IORVOFF)
 Q
 ;
LOCKM(RFAIEN) ; Lock Selection of a specified Message
 ; Input:   RFAIEN  - IEN of the selected Message
 ; Returns: 1 - Lock was obtained, 0 otherwise
 L +^IBA(368,RFAIEN):3
 I '$T Q 0
 Q 1
 ;
UNLOCKM(RFAIEN) ; Unlock Selection of a specified Message
 ; Input:   RFAIEN  - IEN of the selected Message
 L -^IBA(368,RFAIEN)
 Q
 ;
REVIEW ;EP
 ; Protocol action to Mark/Unmark the mesage as being In-Progress
 ; Input:   RFAIEN  - IEN of the selected Message
 N DA,DIE,DR,DTOUT,NOW,X,XX,Y
 S VALMBCK="R"
 D FULL^VALM1
 I '$$LOCKM(RFAIEN) D  Q
 . W !!,*7,"Someone else is reviewing the status of this message."
 . W !,"Try again later."
 . D PAUSE^VALM1
 ; 
 S DA=RFAIEN,DIE=368,NOW=$$NOW^XLFDT()
 ;S XX=$$GET1^DIQ(368,RFAIEN,200.04,"I"),XX=$S(XX=1:"In Progress",1:XX)
 ;S DR="200.04//"_XX_";200.05////"_NOW_";200.06////"_DUZ
 S DR="200.04//REVIEW IN PROCESS"
 D ^DIE
 D UNLOCKM(RFAIEN)
 D HDR
 Q
 ;
COMMENT ;EP
 ; Protocol action to Enter/Edit the comment of the selected Message
 ; Input:   RFAIEN  - IEN of the selected Message
 N CMTIEN
 S VALMBCK="R"
 D FULL^VALM1
 I '$$LOCKM(RFAIEN) D  Q
 . W !!,*7,"Someone else is entering/editing this message."
 . W !,"Try again later."
 . D PAUSE^VALM1
 ; 
 S DA(1)=RFAIEN,DLAYGO=368.0201,DIC(0)="L",DIC="^IBA(368,"_DA(1)_",201,",X=$$NOW^XLFDT()
 D FILE^DICN K DD,DO S (CMTIEN,DA)=+Y I DA<1 D UNLOCKM(RFAIEN) Q
 S DIE="^IBA(368,"_DA(1)_",201,"
 S DR=".02////"_DUZ_";.03" D ^DIE
 I $G(^IBA(368,RFAIEN,201,CMTIEN,1,1,0))="" S DIK=DIE,DA(1)=RFAIEN,DA=CMTIEN D ^DIK
 ;. S DA=RFAIEN,DIE=368,NOW=$$NOW^XLFDT()
 ;. ;S XX=$$GET1^DIQ(368,RFAIEN,200.04,"I") I XX=1 Q
 I $G(^IBA(368,RFAIEN,201,CMTIEN,1,1,0))'="" D
 . N DA S DA=RFAIEN,DIE=368
 . S DR="200.04//REVIEW IN PROCESS"
 . D ^DIE
 D UNLOCKM(RFAIEN)
 D CLEAN^VALM10,INIT^IBRFIN
 Q
 ;
REMOVE ;EP
 ; Protocol action to manually remove the selected Message
 ; Input:   RFAIEN  - IEN of the selected Message
 N COM,XX
 S VALMBCK="R"
 D FULL^VALM1
 I '$$LOCKM(RFAIEN) D  Q
 . W !!,*7,"Someone else is removing this message."
 . W !,"Try again later."
 . D PAUSE^VALM1
 ; 
R2 ; Give final Warning
 N DIK,DA,DLAYGO,DIC,X,Y,DIE,DR,CMTIEN,NOW
 I '$$ASKYN("Are you Sure you want to Remove this Message") D  Q
 . D UNLOCKM(RFAIEN)
 ;
 ; create comment multiple
 S DA(1)=RFAIEN,DLAYGO=368.0201,DIC(0)="L",DIC="^IBA(368,"_DA(1)_",201,",X=$$NOW^XLFDT()
 D FILE^DICN K DD,DO S (CMTIEN,DA)=+Y I DA<1 D  Q
 . D UNLOCKM(RFAIEN)
 . W !!,*7,"Unable to create comment multiple to remove entry!"
 . D PAUSE^VALM1
 ;
 ; Add reason for removal
 S DIE="^IBA(368,"_DA(1)_",201,",DR=".02////"_DUZ_";.03" D ^DIE K DR,DIE
 ;
 ; be sure user enters a comment before actually removing the entry
 I $G(^IBA(368,RFAIEN,201,CMTIEN,1,1,0))=""!(X="^") D  G R2
 . W !!,*7,"Please enter the reason this entry is being removed.  A comment is mandatory!"
 . ; Must delete new comment multiple if they don't enter comment
 . S DIK="^IBA(368,"_DA(1)_",201," D ^DIK K DIK
 . D PAUSE^VALM1
 ;
 ; if comment entered, update review status
 N DA,DIE S DA=RFAIEN,DIE=368,NOW=$$NOW^XLFDT()
 I $G(^IBA(368,RFAIEN,201,CMTIEN,1,1,0))'="" D
 . S XX=$$GET1^DIQ(368,RFAIEN,200.04,"I") I XX=1 Q
 . S DR="200.04////1"
 . D ^DIE K DR
 ;
 ; Set deleted flag and date
 S DR="200.01////1;200.02////"_NOW_";200.03////"_DUZ
 D ^DIE K DR
 ;
 D UNLOCKM(RFAIEN)
 S VALMBCK="Q"
 Q
 ;
TPJI ;EP
 ; Protocol action to do Third Party Joint Inquiry for the selected message
 ; Input:   IBIFN   - IEN for Bill/Claim of the selected message
 S VALMBCK="R"
 D FULL^VALM1
 D TPJI1^IBCECOB2(IBIFN)
 Q
 ;
ASKYN(PROMPT,DEFAULT)   ; Ask a yes/no question
 ; Input:   PROMPT      - Question to be asked
 ;          DEFAULT     - Default Answer
 ;                        1 - YES, 0 - NO
 ;                        Optional, defaults to 0
 ; Returns: 1 - User answered YES, 0 othewise
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S:$G(DEFAULT)'=1 DEFAULT=0
 S DIR(0)="Y",DIR("A")=PROMPT
 S DIR("B")=$S(DEFAULT:"YES",1:"NO")
 D ^DIR
 Q Y
 ;  
HELP ;EP
 ; Protocol Action to display help information
 S X="?"
 D DISP^XQORM1
 W !!
 Q
 ;
EXIT ;EP
 ; Protocol action to exit the worklist
 K ^TMP("IBRFIWL1",$J)
 D CLEAR^VALM1
 Q
 ;
