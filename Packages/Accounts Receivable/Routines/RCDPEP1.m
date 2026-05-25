RCDPEP1 ;AITC/CJE - FLAG PAYERS AS PHARMACY/TRICARE ; 19-APR-2017
 ;;4.5;Accounts Receivable;**439**;;Build 29
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EXCEL ; Output identify payer list in Excel format 
 ; Inputs      DATEFILT - Date Filter
 ;             FILTER   - Filter by Type
 ;
 I RCDISP D INFO^RCDPEM6                            ; Display capture information for Excel
 S %ZIS="QM" D ^%ZIS Q:POP                          ; Select output device
 ;
 D HEADER
 D GETPAY^RCDPEP(FILTER,DATEFILT) ; Retrieve the payors sorted and filtered
 D OUTPUT
 W !!,"*** END OF REPORT ***",!
 N STOP S STOP=""
 D ASK^RCDPEARL(.STOP)
 Q
HEADER ; Output header for Excel format identify payer list
 W !,"Payer Name^TIN^Pharmacy^Tricare^CHAMPVA^Date Added^EFT Only"
 Q
OUTPUT ; Output records in ^TMP($J, "RCDPEPIX"), already filtered list
 ; See GETPAY^RCDPEP for documentation of record format
 N CNT,FLD,J,REC
 S CNT=0
 F  S CNT=$O(^TMP($J,"RCDPEPIX",CNT)) Q:'CNT  D  ;
 . S REC=^TMP($J,"RCDPEPIX",CNT)
 . W !
 . F J=2,3,5,6,8,4 D  ;
 . . S FLD=$P(REC,"^",J)
 . . ;I FLD["," S FLD=""""_FLD_"""" ; If data contains "," add quotes for Excel
 . . W FLD_"^"
 . W $P(REC,"^",7)
 Q
