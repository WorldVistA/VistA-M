IBVCB ;LITS/MRD - VIEW CANCELLED BILL ;25-JUN-14
 ;;2.0;INTEGRATED BILLING;**516**;21-MAR-94;Build 123
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; The View Cancelled Bill option allows the user to view the values
 ; of many fields of a cancelled bill.  The user may select a patient,
 ; and then pick from a list of that patient's cancelled claims, or
 ; simply enter a claim number.  Claims that do not have a Status of
 ; 'Cancelled' cannot be selected.
 ; The user may also select the device to which the report will be
 ; printed.
 ; For many of the sections on this report, if there is no data, the
 ; report will display a message stating 'No Data' rather than print
 ; the labels without any data following them.
 ; 
EN ; Main Entry Point.
 ;
 N IBHEADER,IBIFN,IBPAGE,IBQUIT,IBTEXT
 ;
EN1 ;
 ;
 S IBQUIT=0
 ;
 D SELECT I IBQUIT G ENQ
 ;
 D DEVICE I IBQUIT G ENQ
 ;
 D DISPLAY
 ;
 G EN1
 ;
ENQ ;
 ;
 D ^%ZISC
 ;
 Q
 ;
SELECT ; Prompt user for patient or bill.
 ;
 N DIC,X,Y
 ;
 W !
 S DIC="^DGCR(399,"
 S DIC(0)="AEMQZ"
 S DIC("A")="Enter BILL NUMBER or PATIENT NAME: "
 ; Status of bill must be 7/Cancelled.
 S DIC("S")="I $P($G(^DGCR(399,Y,0)),U,13)=7"
 D ^DIC
 ;
 I X["^"!(X="") S IBQUIT=1 G SELECTQ
 ;
 S IBIFN=$P(Y,U,1)
 I IBIFN="" S IBQUIT=1
 ;
SELECTQ ;
 Q
 ;
DEVICE ; Allow user to select the device.
 ;
 S %ZIS=""
 D ^%ZIS
 I POP S IBQUIT=1
 ;
 Q
 ;
DISPLAY ; Display claim information to user.
 ;
 D HEADERA
 ;
 D PART1 I IBQUIT Q
 D PART2^IBVCB1 I IBQUIT Q
 D PART3^IBVCB2
 ;
 Q
 ;
HEADERA ; Pull header information.
 ;
 ; IBHEADER = Patient Name ^ Full SSN ^ Last 4 of SSN.
 ;
 S IBHEADER=$$PT^IBEFUNC($$GET1^DIQ(399,IBIFN_",",.02,"I"))
 S IBPAGE=0
 ;
 D HEADERB
 ;
 Q
 ;
HEADERB ; Print header information.
 ;
 S IBPAGE=IBPAGE+1
 I $E(IOST,1,2)="C-",IBPAGE>1 D CONTINUE
 W @IOF  ; Print the device-specific form feed sequence.
 W !,$P(IBHEADER,U,1)
 I $P(IBHEADER,U,3)'="" W "   "_$E(IBHEADER,1)_$P(IBHEADER,U,3)
 W ?41,$$GET1^DIQ(399,IBIFN_",",.17,"E")
 W ?72,"Page ",$J(IBPAGE,2)
 W !,"==============================================================================="
 ;
 Q
 ;
CONTINUE ; Enter return to continue.
 ;
 W !
 N DIR
 S DIR(0)="E"
 D ^DIR
 I 'Y S IBQUIT=1
 W $C(13),"                                                  ",$C(13)
 Q
 ;
LINE(IBTEXT) ; Print the lines of information in the IBTEXT array.
 ;
 ; IBTEXT is passed by reference.  The first subscript is an integer
 ; representing the relative line number (1, 2, 3, etc.).  The second
 ; subscript will be '1' or '2'.
 ;     IBTEXT(x,1) = Text to be printed in the 1st column.
 ;     IBTEXT(x,2) = Text to be printed in the 2nd column, if any.
 ; The IBTEXT array is Killed off before Quitting out.  This resets
 ; the array so the rest of the code does not have to.
 ;
 N IBX
 ;
 ; The number of lines to be printed is found by $O(IBTEXT(""),-1).
 ; $Y represents the line on the page of the printer or line on the
 ; screen if printing to a terminal.  If there is not enough space
 ; remaining on the current page to display the number of lines
 ; in IBTEXT, then it calls HEADERB, which Writes a form feed and
 ; prints the header.  $Y is reset to 0 by the statement W @IOF
 ; in the HEADERB procedure.
 ;
 S IBX=$O(IBTEXT(""),-1)  ; How many lines are to be printed.
 I $Y>(IOSL-(IBX+3)) D HEADERB
 ;
 S IBX=""
 F  S IBX=$O(IBTEXT(IBX)) Q:IBX=""  D
 . W !
 . I $D(IBTEXT(IBX,1)) W IBTEXT(IBX,1)
 . I $D(IBTEXT(IBX,2)) W ?41,IBTEXT(IBX,2)
 . Q
 K IBTEXT
 Q
 ;
DOLLAR(X) ; Function to return a formatted dollar amount.
 ;
 I $G(X)="" Q ""
 N X2,X3
 S X2="2$",X3=0
 D COMMA^%DTC
 Q X
 ;
PART1 ; General Claim Data, Other Care, Codes.
 ;
 N IBBT,IBFIND,IBX
 ;
 S IBTEXT(1,1)=""
 S IBTEXT(2,1)="General Claim Data"
 S IBTEXT(3,1)="------------------"
 D LINE(.IBTEXT)
 ;
 S IBTEXT(1,1)="Primary Bill: "_$$GET1^DIQ(399,IBIFN_",",.17,"E")
 S IBTEXT(1,2)="Event Date: "_$$GET1^DIQ(399,IBIFN_",",.03,"E")
 S IBTEXT(2,1)="Rate Type: "_$$GET1^DIQ(399,IBIFN_",",.07,"E")
 S IBTEXT(2,2)="Outpt Visit Date: "
 S IBX=$O(^DGCR(399,IBIFN,"OP",0))
 I IBX'="" S IBTEXT(2,2)=IBTEXT(2,2)_$$GET1^DIQ(399.043,IBX_","_IBIFN_",",.01,"E")
 D LINE(.IBTEXT)
 ; Look for more Outpt Visit Dates.
 F  S IBX=$O(^DGCR(399,IBIFN,"OP",IBX)) Q:'IBX  D
 . S IBTEXT(1,2)="Outpt Visit Date: "_$$GET1^DIQ(399.043,IBX_","_IBIFN_",",.01,"E")
 . D LINE(.IBTEXT)
 . Q
 ;
 S IBTEXT(1,1)="Responsible Party: "_$$GET1^DIQ(399,IBIFN_",",.11,"E")
 S IBTEXT(1,2)="Service Fac. Taxonomy: "_$$GET1^DIQ(399,IBIFN_",",243,"E")
 S IBTEXT(2,1)="Responsible Institution: "_$$GET1^DIQ(399,IBIFN_",",111,"E")
 D LINE(.IBTEXT)
 ;
 S IBTEXT(1,1)="Timeframe: "_$$GET1^DIQ(399,IBIFN_",",.06,"E")
 S IBTEXT(1,2)="Default Division: "_$$GET1^DIQ(399,IBIFN_",",.22,"E")
 D LINE(.IBTEXT)
 ;
 S IBTEXT(1,1)="Charge Type: "_$$GET1^DIQ(399,IBIFN_",",.27,"E")
 S IBTEXT(1,2)="Assignment of Benefits: "_$$GET1^DIQ(399,IBIFN_",",156,"E")
 D LINE(.IBTEXT)
 ;
 S IBTEXT(1,1)="LOC: "_$$GET1^DIQ(399,IBIFN_",",.04,"E")
 D LINE(.IBTEXT)
 ;
 S IBTEXT(1,1)="D/C Status: "_$$GET1^DIQ(399,IBIFN_",",162,"E")
 S IBTEXT(2,1)="D/C Bedsection: "_$$GET1^DIQ(399,IBIFN_",",161,"E")
 S IBTEXT(2,2)="Form Type: "_$$GET1^DIQ(399,IBIFN_",",.19,"E")
 D LINE(.IBTEXT)
 ;
 S IBTEXT(1,1)="Bill Classification: "_$$GET1^DIQ(399,IBIFN_",",.05,"E")
 D LINE(.IBTEXT)
 ;
 S IBTEXT(1,1)="Statement From: "_$$GET1^DIQ(399,IBIFN_",",151,"E")
 S IBTEXT(1,2)="Statement To: "_$$GET1^DIQ(399,IBIFN_",",152,"E")
 D LINE(.IBTEXT)
 ;
 S IBTEXT(1,1)="Sensitive?: "_$$GET1^DIQ(399,IBIFN_",",155,"E")
 S IBTEXT(1,2)="ROI Complete?: "_$$GET1^DIQ(399,IBIFN_",",157,"E")
 D LINE(.IBTEXT)
 ;
 S IBTEXT(1,1)="Admission Type: "_$$GET1^DIQ(399,IBIFN_",",158,"E")
 S IBTEXT(1,2)="Admission Source: "_$$GET1^DIQ(399,IBIFN_",",159,"E")
 D LINE(.IBTEXT)
 ;
 S IBTEXT(1,1)="Non-PTF Admission Hr.: "_$$GET1^DIQ(399,IBIFN_",",159.5,"E")
 S IBTEXT(1,2)="Admitting DX: "_$$GET1^DIQ(399,IBIFN_",",215,"E")
 D LINE(.IBTEXT)
 ;
 S IBTEXT(1,1)="Accident Hr.: "_$$GET1^DIQ(399,IBIFN_",",160,"E")
 S IBTEXT(1,2)="Co-Insurance Days: "_$$GET1^DIQ(399,IBIFN_",",221,"E")
 D LINE(.IBTEXT)
 ;
 S IBTEXT(1,1)="Covered Days: "_$$GET1^DIQ(399,IBIFN_",",216,"E")
 S IBTEXT(1,2)="Non-Covered Days: "_$$GET1^DIQ(399,IBIFN_",",217,"E")
 D LINE(.IBTEXT)
 ;
 S IBTEXT(1,1)="Length of Stay: "_$$GET1^DIQ(399,IBIFN_",",165,"E")
 S IBTEXT(1,2)="PPS: "_$$GET1^DIQ(399,IBIFN_",",170,"E")
 D LINE(.IBTEXT)
 ;
 S IBTEXT(1,1)="Total Charge: "_$$DOLLAR($$GET1^DIQ(399,IBIFN_",",201,"E"))
 D LINE(.IBTEXT)
 ;
 S IBTEXT(1,1)="Unable to Work From: "_$$GET1^DIQ(399,IBIFN_",",166,"E")
 S IBTEXT(1,2)="Unable to Work To: "_$$GET1^DIQ(399,IBIFN_",",167,"E")
 D LINE(.IBTEXT)
 ;
 S IBTEXT(1,1)="Current Payer Seq.: "_$$GET1^DIQ(399,IBIFN_",",.21,"E")
 S IBTEXT(1,2)="SC: "_$$GET1^DIQ(399,IBIFN_",",.18,"E")
 D LINE(.IBTEXT)
 ;
 S IBTEXT(1,1)="Status: "_$$GET1^DIQ(399,IBIFN_",",.13,"E")
 S IBTEXT(1,2)="Status Date: "_$$GET1^DIQ(399,IBIFN_",",.14,"E")
 D LINE(.IBTEXT)
 ;
 S IBTEXT(1,1)="Bill Copied From: "_$$GET1^DIQ(399,IBIFN_",",.15,"E")
 S IBTEXT(1,2)="PTF Record #: "_$$GET1^DIQ(399,IBIFN_",",.08,"E")
 D LINE(.IBTEXT)
 ;
 S IBTEXT(1,1)="Procedure Coding Method: "_$$GET1^DIQ(399,IBIFN_",",.09,"E")
 D LINE(.IBTEXT)
 ;
 S IBBT=$$GET1^DIQ(399,IBIFN_",",.25,"I")
 I IBBT'="" S IBBT=$P($G(^DGCR(399.1,IBBT,0)),U,2),IBBT=$$GET1^DIQ(399,IBIFN_",",.24,"I")_IBBT_$$GET1^DIQ(399,IBIFN_",",.26,"I")
 ;
 S IBTEXT(1,1)="Bill Type: "_IBBT
 S IBTEXT(1,2)="Non-VA D/C Date: "_$$GET1^DIQ(399,IBIFN_",",.16,"E")
 D LINE(.IBTEXT)
 ;
 S IBTEXT(1,1)="Mammography No.: "_$$GET1^DIQ(399,IBIFN_",",242,"E")
 S IBTEXT(1,2)="CLIA No.: "_$$GET1^DIQ(399,IBIFN_",",235,"E")
 D LINE(.IBTEXT)
 ;
 S IBTEXT(1,1)="Special Program Indicator: "_$$GET1^DIQ(399,IBIFN_",",238,"E")
 D LINE(.IBTEXT)
 ;
 S IBTEXT(1,1)="Forced to Print: "_$$GET1^DIQ(399,IBIFN_",",27,"E")
 S IBTEXT(1,2)="MRA Secondary Forced to Print: "_$$GET1^DIQ(399,IBIFN_",",28,"E")
 D LINE(.IBTEXT)
 ;
 S IBTEXT(1,1)="COB Total Non-Covered Amt: "_$$DOLLAR($$GET1^DIQ(399,IBIFN_",",260,"E"))
 D LINE(.IBTEXT)
 ;
 S IBTEXT(1,1)="Disability Start Date: "_$$GET1^DIQ(399,IBIFN_",",263,"E")
 S IBTEXT(1,2)="Disability End Date: "_$$GET1^DIQ(399,IBIFN_",",264,"E")
 D LINE(.IBTEXT)
 ;
 S IBTEXT(1,1)="Prim Surgical Proc: "_$$GET1^DIQ(399,IBIFN_",",266,"E")
 S IBTEXT(1,2)="Sec Surgical Proc: "_$$GET1^DIQ(399,IBIFN_",",267,"E")
 D LINE(.IBTEXT)
 ;
 S IBTEXT(1,1)="Relinquish Care Date: "_$$GET1^DIQ(399,IBIFN_",",283,"E")
 S IBTEXT(1,2)="Assumed Care Date: "_$$GET1^DIQ(399,IBIFN_",",282,"E")
 D LINE(.IBTEXT)
 ;
 S IBTEXT(1,1)="Attachment Report Type: "_$$GET1^DIQ(399,IBIFN_",",285,"E")
 S IBTEXT(2,1)="Attachment Report Transmit Method: "_$$GET1^DIQ(399,IBIFN_",",286,"E")
 S IBTEXT(3,1)="Attachment Control No.: "_$$GET1^DIQ(399,IBIFN_",",284,"E")
 D LINE(.IBTEXT)
 ;
 S IBTEXT(1,1)=""
 S IBTEXT(2,1)="Other Care"
 S IBTEXT(3,1)="----------"
 D LINE(.IBTEXT)
 ;
 S IBFIND=0,IBX=0
 F  S IBX=$O(^DGCR(399,IBIFN,"OT",IBX)) Q:'IBX  D
 . S IBFIND=1
 . S IBTEXT(1,1)="Other Care: "_$$GET1^DIQ(399.048,IBX_","_IBIFN_",",.01,"E")
 . S IBTEXT(2,1)="Other Care Date(s): "_$$GET1^DIQ(399.048,IBX_","_IBIFN_",",.02,"E")_" - "_$$GET1^DIQ(399.048,IBX_","_IBIFN_",",.03,"E")
 . D LINE(.IBTEXT)
 . Q
 I 'IBFIND D
 . S IBTEXT(1,1)="*** No Other Care Data Found ***"
 . D LINE(.IBTEXT)
 . Q
 ;
 S IBTEXT(1,1)=""
 S IBTEXT(2,1)="Codes"
 S IBTEXT(3,1)="-----"
 D LINE(.IBTEXT)
 ;
 S IBFIND=0,IBX=0
 F  S IBX=$O(^DGCR(399,IBIFN,"CC",IBX)) Q:'IBX  D
 . S IBFIND=1
 . S IBTEXT(1,1)="Condition Code: "_$$GET1^DIQ(399.04,IBX_","_IBIFN_",",.01,"E")
 . D LINE(.IBTEXT)
 . Q
 I 'IBFIND D
 . S IBTEXT(1,1)="*** No Condition Codes Found ***"
 . D LINE(.IBTEXT)
 . Q
 ;
 S IBFIND=0,IBX=0
 F  S IBX=$O(^DGCR(399,IBIFN,"OC",IBX)) Q:'IBX  D
 . S IBFIND=1
 . S IBTEXT(1,1)="Occurrence Code: "_$$GET1^DIQ(399.041,IBX_","_IBIFN_",",.01,"E")
 . S IBTEXT(1,2)="Occurrence State: "_$$GET1^DIQ(399.041,IBX_","_IBIFN_",",.03,"E")
 . S IBTEXT(2,1)="Occ. Date(s): "_$$GET1^DIQ(399.041,IBX_","_IBIFN_",",.02,"E")_" - "_$$GET1^DIQ(399.041,IBX_","_IBIFN_",",.04,"E")
 . D LINE(.IBTEXT)
 . Q
 I 'IBFIND D
 . S IBTEXT(1,1)="*** No Occurrence Codes Found ***"
 . D LINE(.IBTEXT)
 . Q
 ;
 S IBFIND=0,IBX=0
 F  S IBX=$O(^DGCR(399,IBIFN,"CV",IBX)) Q:'IBX  D
 . S IBFIND=1
 . S IBTEXT(1,1)="Value Code: "_$$GET1^DIQ(399.047,IBX_","_IBIFN_",",.01,"E")
 . S IBTEXT(1,2)="Value: "_$$GET1^DIQ(399.047,IBX_","_IBIFN_",",.02,"E")
 . D LINE(.IBTEXT)
 . Q
 I 'IBFIND D
 . S IBTEXT(1,1)="*** No Value Codes Found ***"
 . D LINE(.IBTEXT)
 . Q
 ;
 Q
 ;
