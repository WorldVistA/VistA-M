IBCOPP3 ;ALB/NLR - LIST INS. PLANS BY CO. (PRINT) ; 20-OCT-2015
 ;;2.0;INTEGRATED BILLING;**28,516,528,549**;21-MAR-94;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Print the report.
 ; Input:   IBAI            - 0 - Only Selected Insurance Companies
 ;                            1 - All Insurance Companies
 ;          IBAIA           - 0 - Only select Inactive Insurance Companies
 ;                            1 - Only select Active Insurance Companies
 ;                            2 - Select both Active and Inactive Insurance
 ;                                Companies
 ;          IBAO            - E - Output to Excel
 ;                            R - Report
 ;          IBAPA           - 0 - List Insurance Plans by Insurance Company
 ;                            1 - List Insurance Plans by Insurance Company
 ;                                with Subscriber information
 ;          IBAIPA          - 0 - Only select Inactive Insurance Company Plans
 ;                            1 - Only select Active Insurance Company Plans
 ;                            2 - Select both Active and Inactive Insurance 
 ;                                Company Plans
 ;          IBAPL           - 0 - Only list selected plans for Insurance Companies
 ;                            1 - List all plans for selected Insurance Companies
 ;          ^TMP($J,"PR"    - Global Print Array
 ;          ^TMP($J,"PR",IBI)=A1^A2^...^A10 Where:
 ;                             IBI  - Counter of # of Insurance Companies included
 ;                                    (starts at 1)
 ;                             A1   - Insurance Company Name (1st 25 characters)
 ;                             A2   - Street Address Line 1
 ;                             A3   - City, State Zip Code (up to 9 digits + dash)
 ;                             A4   - Timely Filing Timeframe
 ;                             A5   - # of total plans for the Insurance Company
 ;                             A6   - # of total subscribers per Insurance Company
 ;                             A7   - # of selected Plans per Insurance Company
 ;                             A8   - # of subscribers per selected plans
 ;                             A9   - Maximum Length of the Electronic Plan
 ;                                    Field for this Insurance Company
 ;                             A10  - Maximum Length of the Type of Plan
 ;                                    Field for this Insurance Company
 ;                             A11  - Max length of Patient ID for Ins Co
 ;          ^TMP($J,"PR",IBI,IBPTR))- B1^B2^..^B6 where
 ;                             IBI  - Counter of # of Insurance Companies included
 ;                             IBPTR- Group Plan IEN, file 355.3
 ;                             B1   - Group Number, field 355.3,2.02
 ;                             B2   - Group Name, field 355.3,2.01
 ;                             B3   - Group Plan Timely Filing Time frame (max len 21)
 ;                             B4   - Electronic Plan Type (max length 26)
 ;                             B5   - Type of Plan (max length 34)
 ;                             B6   - Total number of subscribers for Group Plan
 ;          ^TMP($J,"PR",IBI,IBPTR,IBNAM_"@@"_DFN_"@@"_IBCDFN)=B1^B2^...^B8 Where
 ;                DFN   - IEN of the patient, file 2
 ;                IBCDFN- Insurance Company multiple
 ;                IBI   - Insurance counter
 ;                IBNAM - Patient's Name (B1)
 ;                IBPTR - IEN of the Group Plan, file 355.3
 ;                B1    - Patient's Name (1st 22 chars)
 ;                B2    - Last 4 Patient's SSN (with trailing 'P' if pseudo)
 ;                B3    - Patient's DOB (mm/dd/yy)
 ;                B4    - Subscriber ID (20 chars max)
 ;                B5    - Effective Date (mm/dd/yy)
 ;                B6    - Expiration Date (mm/dd/yy)
 ;                B7    - Whose Insurance (5 chars max)
 ;                B8    - Patient ID (30 chars max)
 ;
 N COLEP,COLFTF,COLPID,TRUNCPT,XX,%
 I IBAO="E" D  Q
 . D EXCEL
 . W !!?30,"*** End of Report ***"
 ;
 S (IBI,IBQUIT,IBPAG)=0
 D NOW^%DTC
 S IBHDT=$$DAT2^IBOUTL($E(%,1,12))
 ;
 F  S IBI=$O(^TMP($J,"PR",IBI)) Q:'IBI  S IBC=$G(^TMP($J,"PR",IBI)) D  Q:IBQUIT
 . D COMP(.COLEP,.COLFTF,.TRUNCPT)
 . S IBP=0
 . F  S IBP=$O(^TMP($J,"PR",IBI,IBP)) Q:'IBP  S IBPD=$G(^(IBP)) D  Q:IBQUIT
 . . I $Y>(IOSL-$S(IBAPA:9,1:5)) D PAUSE Q:IBQUIT  D COMP(.COLEP,.COLFTF,.TRUNCPT)
 . . D PLAN(COLEP,COLFTF,TRUNCPT)
 . . ; 
 . . ; Display Subscriber Information
 . . I IBAPA D
 . . . S XX=$O(^TMP($J,"PR",IBI,IBP,""))    ; Are the subscribers to display
 . . . D:XX'="" SUBHDR                      ; Display Subscriber Headers
 . . . S IBS=""
 . . . F  S IBS=$O(^TMP($J,"PR",IBI,IBP,IBS)) Q:IBS=""  D  Q:IBQUIT
 . . . . S IBSD=$G(^TMP($J,"PR",IBI,IBP,IBS))
 . . . . D SUBS
 . Q:IBQUIT
 . ;
 . ; Print company totals
 . I $Y>(IOSL-4) D PAUSE Q:IBQUIT  D
 . . D COMP(.COLEP,.COLFTF,.TRUNCPT)
 . . D PLAN(COLEP,COLFTF,TRUNCPT)
 . W !!?90,"Number of Plans Selected = ",$P(IBC,"^",7)
 . W !?76,"Total Subscribers Under Selected Plans = ",$P(IBC,"^",8)
 . D PAUSE
 ;
 ; IB*2.0*549 - Added next line
 W !!?30,"*** End of Report ***"
 ;
 K IBAIA,IBAIPA,IBAPA,IBJJ,IBI,IBQUIT,IBPAG,IBHDT,IBC,IBP,IBPD,IBS,IBSD
 Q
 ;
COMP(COLEP,COLFTF,TRUNCPT) ; Print Company header
 ; Input:   IBC     - ^TMP($J,"PR",IBC), see documentation above
 ;          IBPAG   - Current Page Counter
 ;          IBHDT   - Current date/time (external format)
 ;          IBAIA   - 0 - Only select Inactive Insurance Companies
 ;                    1 - Only select Active Insurance Companies
 ;                    2 - Select both Active and Inactive Insurance Companies
 ;          IBAIPA  - 0 - Only select Inactive Insurance Company Plans
 ;                    1 - Only select Active Insurance Company Plans
 ;                    2 - Select both Active and Inactive Insurance Company Plans
 ;          IBAPA   - 0 - List Insurance Plans by Insurance Company
 ;                    1 - List Insurance Plans by Insurance Company with
 ;                        Subscriber information
 ; Output:  COLEP   - Starting Column Position of the Electronic Plan Type Col
 ;          COLFTF  - Starting Column Position of the FTF Col
 ;          TRUNCPT - # of characters to truncate from the Plan Type field (if any)   
 ;          IBPAG   - Updated Page Counter
 N LENEP,LENPT
 K COLEP,COLFTF,TRUNCPT
 S LENPT=$P(IBC,"^",9),LENEP=$P(IBC,"^",10)
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 W !,"LIST OF PLANS BY INSURANCE COMPANY"
 W:IBAPA " WITH SUBSCRIBER INFORMATION"
 W ?IOM-34,IBHDT,?IOM-10,"Page: ",IBPAG
 W !,$TR($J(" ",IOM)," ","-")
 ;
 ; IB*2.0*549 - Added next 3 lines
 W !,"+ =>INDIV. PLAN    * => INACTIVE"
 W !,"Filters: ",$S(IBAI=1:"All",1:"Selected")," Insurances"
 W ", ",$S(IBAPL=1:"All",1:"Selected")," Group Plans",!
 ;
 ; IB*2.0*549 - Changed fields displayed for each Insurance Company
 W !?1,$P(IBC,"^",1)                        ; Insurance Company Name (26 chars max)
 W !?1,$P(IBC,"^",2)                        ; Street Address line 1 (35 chars max)
 W ?45,"FTF = ",$P(IBC,"^",4)               ; Timely Filing Timeframe (28 chars max)
 W ?105,"GROUP PLAN TOTAL= ",$P(IBC,"^",5)
 W !?1,$P(IBC,"^",3)                        ; City State Zip Code
 W ?105,"SUBSCRIBER TOTAL= ",$P(IBC,"^",6)
 ;
 ; Check to see if the Plan Type and/or Electronic Plan Type fields need to be
 ; truncated
 S COLEP=$S(LENPT<13:76,LENPT:64+LENPT+3,1:76)  ; Elec Plan Col, assuming no truncation
 S COLFTF=$S(LENEP<10:COLEP+13,1:COLEP+LENEP+3) ; FTF Col, assuming no truncation
 S:'LENEP COLFTF=COLFTF+8
 S TRUNCPT=0                                ; Assume no truncation needed
 I 64+$P(IBC,"^",9)+$P(IBC,"^",10)>103 D
 . S TRUNCPT=(64+$P(IBC,"^",10))-103        ; # of Characters to truncate
 . S COLEP=(64+$P(IBC,"^",10)+3)-TRUNCPT
 . S COLFTF=COLEP+$P(IBC,"^",9)+2           ; FTF Col
 W !?5,"GROUP NUMBER",?32,"GROUP NAME",?62,"TYPE OF PLAN"
 W ?COLEP,"ELEC PLAN",?COLFTF,"FTF"
 Q
 ;
PLAN(COLEP,COLFTF,TRUNCPT) ; Print Group Plan information.
 ; Input:   COLEP   - Starting Column Position of the Electronic Plan Type Col
 ;          COLFTF  - Starting Column Position of the FTF Col
 ;          TRUNCPT - # of characters to truncate from the Plan Type field (if any)   
 ;          IBPD    - ^TMP($J,"PR",IBC,IBPTR), see documentation above
 ;          IBAPA   - 0 - List Insurance Plans by Insurance Company
 ;                    1 - List Insurance Plans by Insurance Company with
 ;                        Subscriber information
 ;          ^TMP($J,"PR",IBI,IBPTR))- B1^B2^..^B6 where
 ;                             IBI  - Counter of # of Insurance Companies included
 ;                             IBPTR- Group Plan IEN
 ;                             B1   - Group Number, field 355.3,2.02
 ;                             B2   - Group Name, field 355.3,2.01
 ;                             B3   - Group Plan Timely Filing Time frame (max len 21)
 ;                             B4   - Electronic Plan Type (max length 26)
 ;                             B5   - Type of Plan (max length 40)
 ;                             B6   - Total # of subscribers for Group Plan
 ;
 ; IB*2.0*549 - Changed fields displayed for each Group Plan
 N XX
 W !?5,$P(IBPD,"^",1)                       ; Group Plan Number
 W ?32,$P(IBPD,"^",2)                       ; Group Plan Name
 S XX=$P(IBPD,"^",5)
 S:TRUNCPT XX=$E(XX,1,$L(XX)-TRUNCPT)
 W ?62,XX                                   ; Type of Plan (40 Chars max)
 W ?COLEP,$P(IBPD,"^",4)                    ; Electronic Plan Type (26 Chars max)
 W ?COLFTF,$P(IBPD,"^",3)                   ; Group Plan FTF (26 Chars max)
 W !?10,"SUBSCRIBERS = ",$P(IBPD,"^",6)     ; Group Plan Subscriber total
 Q
 ;
SUBHDR ; Print the Subscriber Header Line
 ; IB*2.0*549 New Method
 W !?10,"SUBSCRIBER NAME",?35,"SSN",?43,"DOB",?53,"SUB ID",?76,"EFF",?86,"EXP"
 W ?96,"WHO",?102,"PAT ID"
 Q
 ;
SUBS ; Print subscriber information.
 ; IB*2.0*549 Changed fields displayed
 ; Input:   IBSD        - Subscriber detail - ^TMP($J,"PR",IBI,IBP,IBS)
 ; Subscriber ID to display more characters.
 N COLEP,COLFTF,TRUNCPT
 I $Y>(IOSL-4) D PAUSE Q:IBQUIT  D
 . D COMP(.COLEP,.COLFTF,.TRUNCPT)
 . D PLAN(COLEP,COLFTF,TRUNCPT)
 . D SUBHDR
 W !?10,$P(IBSD,"^",1),?35,$P(IBSD,"^",2),?43,$P(IBSD,"^",3),?53,$P(IBSD,"^",4)
 W ?76,$P(IBSD,"^",5),?86,$P(IBSD,"^",6),?96,$P(IBSD,"^",7),?102,$P(IBSD,"^",8)
 Q
 ;
PAUSE ; Pause for screen output.
 ; Input:   None
 ; Output:  IBQUIT  - 1 if user timed out or entered '^'
 N DIR,DIRUT,DTOUT,DUOUT,IBJJ
 Q:$E(IOST,1,2)'["C-"
 S DIR(0)="E"
 D ^DIR K DIR
 I $D(DIRUT)!($D(DUOUT)) D
 . S IBQUIT=1
 Q
 ;
EXCEL ; Output in excel format
 N HDR,IBC,IBHDT,IBP,IBPD,IBS,IBSD
 D NOW^%DTC
 S IBHDT=$$DAT2^IBOUTL($E(%,1,12))
 ;
 ; Set Report Header into output
 W !,"LIST OF PLANS BY INSURANCE COMPANY"
 W:IBAPA " WITH SUBSCRIBER INFORMATION"
 W "          Run On: ",IBHDT
 ;
 ; Set filter into output
 ; IB*2.0*549 - Added next 3 lines
 W !,"+ =>INDIV. PLAN    * => INACTIVE"
 W !,"Filters: ",$S(IBAI=1:"All",1:"Selected")," Insurances"
 W ", ",$S(IBAPL=1:"All",1:"Selected")," Group Plans",!
 ;
 S HDR="INS. CO.^ADDRESS^CITY,STATE ZIP^FTF^PLAN TOTAL^SUBS TOTAL^PLANS SELECTED^TOT SUBS"
 S HDR=HDR_"^GROUP NUMBER^GROUP NAME^FTF^ELEC PLAN^TYPE OF PLAN^NO. SUBS"
 I IBAPA S HDR=HDR_"^SUBSCRIBER NAME^SSN^DOB^SUB ID^EFF DT^EXP DT^WHOSE INS^PAT ID"
 W !,HDR
 S IBI=0
 F  S IBI=$O(^TMP($J,"PR",IBI)) Q:'IBI  S IBC=$G(^TMP($J,"PR",IBI)) D
 . S IBC=$P(IBC,"^",1,8),IBP=0
 . F  S IBP=$O(^TMP($J,"PR",IBI,IBP)) Q:'IBP  S IBPD=$G(^TMP($J,"PR",IBI,IBP)) D
 . . I 'IBAPA W !,IBC_U_IBPD Q
 . . S IBS=""
 . . F  S IBS=$O(^TMP($J,"PR",IBI,IBP,IBS)) Q:IBS=""  S IBSD=$G(^TMP($J,"PR",IBI,IBP,IBS)) D
 . . . W !,IBC_U_IBPD_U_IBSD
 Q
