RCDPESP1 ;BIRM/SAB - ePayment Lockbox Site Parameter Reports ;29 Jan 2019 18:00:14
 ;;4.5;Accounts Receivable;**298,304,318,321,326,332,345,349**;Mar 20, 1995;Build 44
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
RPT ; EDI Lockbox Parameters Report [RCDPE SITE PARAMETER REPORT]
 ; report data from:
 ;    AR SITE PARAMETER file (#342)
 ;    RCDPE PARAMETER file (#344.61)
 ;    RCDPE AUTO-PAY EXCLUSION file (#344.6)
 ;
 ; LOCAL VARIABLES:
 ;    RTYPE - Type of Report to run (Medical, Pharmacy, or Both)
 ;
 ; PRCA*4.5*349 - Add categories prompt
 N %ZIS,POP,RCCATS,RCHDR,RCLSTMGR,RCTEMP,RCTMPND,RCTYPE
 S RCCATS=$$CATS^RCDPESPC
 I RCCATS="" D RPTQ Q
 W !,$$HDRLN,!
 ;
 S RCTYPE=$$RTYPE^RCDPESP2
 I RCTYPE=-1 D RPTQ Q
 ; PRCA*4.5*349 - Start modified code block
 S RCLSTMGR=$$ASKLM^RCDPEARL                ; Ask to Display in Listman Template
 Q:RCLSTMGR<0                               ; '^' or timeout
 I RCLSTMGR D  D RPTQ Q  ;
 . S RCTMPND="RC SP REPORT"
 . K ^TMP($J,RCTMPND)
 . I RCCATS="AL" D  ;
 . . D SPRPT
 . E  D  ;
 . . D SPRPT^RCDPESPC
 . D LMHDR^RCDPESPC(.RCHDR,RCTYPE,RCCATS)
 . S RCTEMP="RCDPE PARAMETERS REPORT"
 . D LMRPT^RCDPEARL(.RCHDR,$NA(^TMP($J,RCTMPND)),RCTEMP) ; Generate ListMan display
 . K ^TMP($J,RCTMPND)
 ; PRCA*4.5*349 - End modified code block
 W !!                                   ; skip lines before device prompt
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . N ZTDESC,ZTQUEUED,ZTRTN,ZTSAVE,ZTSK
 . ; PRCA*4.5*349 - Task subroutine based on whether "All" or some cats were chosen
 . S ZTRTN=$S(RCCATS="AL":"SPRPT",1:"SPRPT2")_"^RCDPESP1",ZTDESC=$$HDRLN,ZTSAVE("RC*")=""
 . D ^%ZTLOAD
 . W !!,$S($G(ZTSK):"Task number "_ZTSK_" has been queued.",1:"Unable to queue this task.")
 . K IO("Q") D HOME^%ZIS
 ;
 ; PRCA*4.5*349 - Call correct subroutine depending on whether "All" cats are shown or not
 I RCCATS="AL" D SPRPT Q
 D SPRPT^RCDPESPC
 ;
RPTQ ;
 Q
 ;
SPRPT ; site parameter report entry point
 ; Input: RCTYPE - Type of report (Medical/Rx/TRICARE/All)
 ;        RCCATS - List of categories selected for report
 ; RCNTR - counter
 ; RCFLD - DD field number
 ; RCHDR - header information
 ; RCPARM - parameters
 ; RCSTOP - exit flag
 N FLDS,J,RCACTV,RCCARCD,RCCIEN,RCCODE,RCDATA,RCDESC,RCFLD,RCGLB,RCHDR,RCI,RCITEM
 N RCNTR,RCPARM,RCSTAT,RCSTOP,RCSTRING,V,X,XX,Y,YY
 ;
 S X="RC"
 F  S X=$O(^TMP($J,X)) Q:'($E(X,1,2)="RC")  K ^TMP($J,X) ; clear out old data
 ;
 ; RCGLB - ^TMP global storage locations
 ; ^TMP($J,"RC342") - AR SITE PARAMETER file (#342)
 ; ^TMP($J,"RC344.6") - RCDPE AUTO-PAY EXCLUSION file (#344.6)
 ; ^TMP($J,"RC344.61") - RCDPE PARAMETER file (#344.61)
 F J=342,344.6,344.61 D  ;
 . S RCGLB(J)=$NA(^TMP($J,"RC"_J))
 . K @RCGLB(J)
 ;
 S RCHDR("RUNDATE")=$$FMTE^XLFDT($$NOW^XLFDT,"10S")
 S RCHDR("PGNMBR")=0  ; page number
 ;
 ; AR SITE PARAMETER file (#342)
 D GETS^DIQ(342,"1,",".01;.14;.15;7.02;7.03;7.04;7.05;7.06;7.07;7.08;7.09","E",RCGLB(342)) ; PRCA*4.5*345
 ; add site to header data
 S RCHDR("SITE")="Site: "_@RCGLB(342)@(342,"1,",.01,"E")
 ;
 ; PRCA*4.5*345 add field .14 and .15 for first party auto-decrease 
 D AD2RPT("### EDI Lockbox Site & First Party Parameters ###")
 F RCFLD=7.02,7.03,7.04,.14,.15,7.05,7.06,7.07,7.08,7.09 D  ; EFT and ERA days unmatched  - PRCA*4.5*321
 . I RCFLD=7.05 D AD2RPT(" "),AD2RPT("### Auto-Audit Site Parameters ###")
 . S RCITEM=$S(RCFLD=.14!(RCFLD=.15)!(RCFLD>7.04):"TITLE",1:"LABEL") ; PRCA*4.5*345
 . I RCTYPE="P",(RCFLD=7.05)!(RCFLD=7.07)!(RCFLD=7.09) Q  ; PRCA*4.5*349 Exclude TRICARE
 . I RCTYPE="M",(RCFLD=7.06)!(RCFLD=7.08)!(RCFLD=7.09) Q  ; PRCA*4.5*349 Exclude TRICARE
 . I RCTYPE="T",RCFLD>7.04,RCFLD<7.09 Q  ; PRCA*4.5*349 Line Added TRICARE
 . S Y=$$GET1^DID(342,RCFLD,,RCITEM)_": "_@RCGLB(342)@(342,"1,",RCFLD,"E")
 . I RCFLD=7.05 D AD2RPT(" ")
 . I (RCFLD=7.06),(RCTYPE="P") D AD2RPT(" ")
 . I (RCFLD=7.09),(RCTYPE="T") D AD2RPT(" ")
 . D AD2RPT(Y)
 ;
 D AD2RPT(" ")
 ;
 ; Display Parameters
 ; RCDPE PARAMETER file (#344.61)
 S Y=".02;.03;.04;.05;.06;.07;.1;.11;.12;.13;1.01;1.02;1.03;1.04"
 S Y=Y_";1.05;1.06;1.07;1.08;1.09;1.1" ; PRCA*4.5*349 - Add TRICARE
 D GETS^DIQ(344.61,"1,",Y,"E",RCGLB(344.61))
 ;
 S Y=$$GET1^DID(344.61,.1,,"LABEL")_": "_@RCGLB(344.61)@(344.61,"1,",.1,"E") ; PRCA*4.5*321
 D AD2RPT("### Workload Notification Day Parameter ###")
 D AD2RPT(Y),AD2RPT(" ") ; PRCA*4.5*321
 ;
 ; get auto-post and auto-decrease settings, save zero node
 S X=$G(^RCY(344.61,1,0))
 S XX=$G(^RCY(344.61,1,1))                      ; PRCA*4.5*349 - Added line
 S RCPARM("AUTO-POST")=$P(X,U,2)
 S RCPARM("AUTO-DECREASE")=$P(X,U,3)
 S RCPARM(344.61,0)=X
 S RCPARM(344.61,1)=XX                          ; PRCA*4.5*349 - Added line
 S RCPARM("RX AUTO-POST")=$P(XX,U,1)
 S RCPARM("RX AUTO-DECREASE")=$P(XX,U,2)        ; PRCA*4.5*349 - Added line
 S RCPARM("TRI AUTO-POST")=$P(XX,U,5)           ; PRCA*4.5*349 - Added line
 S RCPARM("TRI AUTO-DECREASE")=$P(XX,U,6)       ; PRCA*4.5*349 - Added line
 ;
 ; PRCA*4.5*349 - Start modified block - Move code into subroutines for easier maintenance
 I (RCTYPE="M")!(RCTYPE="A") D MPARAMS^RCDPESPC(.RCPARM)  ; Display Medical Claim parameters
 ;
 I (RCTYPE="P")!(RCTYPE="A") D RXPARAMS^RCDPESPC(.RCPARM) ; Display Rx parameters 
 ;
 I (RCTYPE="T")!(RCTYPE="A") D TPARAMS^RCDPESPC(.RCPARM)  ; Display Rx parameters
 ; PRCA*4.5*349 - End modified block
 ;
 ; RCDPE PARAMETER file (#344.61)
 ;  ^DD(344.61,.06,0) > "MEDICAL EFT POST PREVENT DAYS"
 ;  ^DD(344.61,.07,0) > "PHARMACY EFT POST PREVENT DAYS"
 ;  ^DD(344.61,.13,0) > "TRICARE EFT POST PREVENT DAYS"
 D AD2RPT("### EFT Lock-Out Parameters ###")
 F RCFLD=.06,.07,.13 D 
 . Q:(RCFLD=.06)&'((RCTYPE="M")!(RCTYPE="A"))  ; Don't display if not showing Medical parameters
 . Q:(RCFLD=.07)&'((RCTYPE="P")!(RCTYPE="A"))   ; Don't display if not showing Rx parameters
 . Q:(RCFLD=.13)&'((RCTYPE="T")!(RCTYPE="A"))  ; PRCA*4.5*349 - Don't display if not showing TRICARE params
 . S Y=$$GET1^DID(344.61,RCFLD,,"TITLE")_" "_@RCGLB(344.61)@(344.61,"1,",RCFLD,"E")
 . D AD2RPT(Y)
 ;
 D AD2RPT(" "),AD2RPT($$ENDORPRT^RCDPEARL)
 ;
 I RCLSTMGR Q  ; PRCA*4.5*349 - If displaying as ListMan report, return here and let ListMan handle it
 ;
 S RCSTOP=0
 U IO
 D SPHDR(.RCHDR)
 S J=0
 F  S J=$O(^TMP($J,"RC SP REPORT",J)) Q:'J!RCSTOP  S Y=^TMP($J,"RC SP REPORT",J,0) D
 . W !,Y Q:'$O(^TMP($J,"RC SP REPORT",J))  ; quit if last line
 . I '$G(ZTSK),$E(IOST,1,2)="C-",$Y+3>IOSL D  Q
 . . D ASK^RCDPEARL(.RCSTOP)
 . . I 'RCSTOP D SPHDR(.RCHDR)
 . Q:RCSTOP  Q:$Y+2<IOSL
 . D SPHDR(.RCHDR)
 ;
 I '$G(ZTSK),$E(IOST,1,2)="C-",'RCSTOP D ASK^RCDPEARL(.RCSTOP)
 ;
 ; close device
 U IO(0) D ^%ZISC
 K @RCGLB(344.6)  ; delete old data
 S X="RC" F  S X=$O(^TMP($J,X)) Q:'($E(X,1,2)="RC")  K ^TMP($J,X) ; clean up
 ;
 Q
 ;
 ; PRCA*4.5*349 - MPARAMS, RXPARAMS, TPARAMS moved to RCDPESPC
 ;
SPHDR(HDR) ; HDR passed by ref.
 ; HDR("RUNDATE") - run date, external format
 ;  HDR("PGNMBR") - page number
 ;    HDR("SITE") - site name
 N CTLST,CUR,I,P,X,Y
 S P=$G(HDR("PGNMBR"))+1,HDR("PGNMBR")=P  ; increment page count
 ; 
 S X=$$HDRLN
 S P=IOM-($L(X)+10)\2,Y=$J(" ",P)_X_$J(" ",P)_" Page: "_HDR("PGNMBR")
 W @IOF,Y
 S X="   Run Date: "_HDR("RUNDATE"),Y=X_$J(HDR("SITE"),IOM-($L(X)+1))
 W !,Y
 ; PRCA*4.5*349 - Added categories to report header
 ; Add categories
 S Y="   Categories: "
 S CNT=$L(RCCATS,U),CUR=""
 D LSTCATS^RCDPESPC(.CTLST,1)
 S CTLST("AL")="All"
 F I=1:1:CNT D
 . S X=$G(CTLST($P(RCCATS,U,I)))
 . I ($L(Y)+$L(X))>IOM D
 . . W !,Y
 . . S Y="               "
 . S Y=Y_X
 . I I<CNT S Y=Y_", "
 W !,Y
 S Y=" "_$TR($J("",IOM-2)," ","-")  ; space_row of hyphens
 W !,Y
 Q
 ;
AD2RPT(A) ; add line to report
 Q:$G(A)=""
 N C S C=$G(^TMP($J,"RC SP REPORT",0))+1,^TMP($J,"RC SP REPORT",0)=C
 ; PRCA*4.5*349 - Add data to global depending on whether we're displaying in ListMan or not
 I '$G(RCLSTMGR) S ^TMP($J,"RC SP REPORT",C,0)=A
 E  S ^TMP($J,"RC SP REPORT",C)=A
 Q
 ;
HDRLN() ; Display report header line
 N XX,YY
 S YY=$G(RCTYPE)
 S XX=" - "_$S(YY="A":"ALL",YY="M":"MEDICAL",YY="P":"PHARMACY",YY="T":"TRICARE",1:"") ; PRCA*4.5*349
 Q "EDI Lockbox Parameters Report"_XX
 ;
CARCCHK(RCTYPE,PAID,TYPE) ; Checks to see if CARC parameters should appear on the report
 ; PRCA*4.5*349 - Reworte function
 ; Input:   RCTYPE - User selected filter (M/P/T/A)
 ;          PAID   - 1 - Auto-Decrease for Claims w/Payments
 ;                   0 - Auto-Decrease for Claims w/No Payments
 ;          TYPE  - Type currently being processed (M/P/T)
 ; Returns  1     - If Auto-Decreased is enabled for TYPE and it was in selected filter
 ;          0 - Otherwise
 N RCMEN,RCREN,XX
 I TYPE="M" D  Q XX                         ; Check Medical Auto-Decrease values
 . I RCTYPE'="A",RCTYPE'="M" S XX=0 Q
 . I PAID D  Q                              ; Auto-Decrease of Med Claims w/Payments
 . . S XX=+$P($G(^RCY(344.61,1,0)),U,3)
 . I 'PAID D  Q                             ; Auto-Decrease of Med Claims w/No Payments
 . . S XX=+$P($G(^RCY(344.61,1,0)),U,11)
 ;
 I TYPE="P" D  Q XX                         ; Check Rx Auto-Decrease values
 . I RCTYPE'="A",RCTYPE'="P" S XX=0 Q
 . S XX=+$P($G(^RCY(344.61,1,1)),U,2)
 ;
 I TYPE="T" D  Q XX                         ; Check TRICARE Auto-Decrease values
 . I RCTYPE'="A",RCTYPE'="T" S XX=0 Q
 . I PAID D  Q                              ; Auto-Decrease of TRICARE Claims w/Payments
 . . S XX=+$P($G(^RCY(344.61,1,1)),U,6)
 . I 'PAID D  Q                             ; Auto-Decrease of TRICARE Claims w/No Payments
 . . S XX=+$P($G(^RCY(344.61,1,0)),U,9)
 Q 0 ; Don't print the CARCs
 ;
MEDAUTOP(RCPARM) ; Display Medical Auto-Post parameters - PRCA*4.5*349
 ; Input:     RCPARM("AUTO-DECREASE") - 1 if Medical Auto-Posting is turned for claims w/Payments
 ;                                      0 otherwise
 D AUTOP(.RCPARM,0)
 Q
 ;
RXAUTOP(RCPARM) ; Display Pharmacy Auto-Post parameters - PRCA*4.5*349 
 ; Input:  RCPARM("RX AUTO-DECREASE") - 1 if Rx Auto-Posting is turned for claims w/Payments
 ;                                      0 otherwise
 D AUTOP(.RCPARM,1)
 Q
 ;
TRIAUTOP(RCPARM) ; Display TRICARE Auto-Post parameters - PRCA*4.5*349
 ; Input: RCPARM("TRI AUTO-DECREASE") - 1 if TRICARE Auto-Posting is turned for claims w/Payments
 ;                                      0 otherwise 
 D AUTOP(.RCPARM,2)
 Q
 ;
AUTOP(RCPARM,WHICH) ; Display auto-post parameters - PCRA*4.5*349
 ; Input:     RCPARM("AUTO-DECREASE") - 1 if Medical Auto-Posting is turned for claims w/Payments
 ;                                      0 otherwise 
 ;         RCPARM("RX AUTO-DECREASE") - 1 if Rx Auto-Posting is turned for claims w/Payments
 ;                                      0 otherwise
 ;        RCPARM("TRI AUTO-DECREASE") - 1 if TRICARE Auto-Posting is turned for claims w/Payments
 ;                                      0 otherwise
 ;                              WHICH - 0 - Medical, 1 - Rx, 2 - TRICARE
 ; @RCGLB(344.6) - LIST^DIC array of fields
 ; @RCGLB(344.61) - LIST^DIC array of fields
 N FLDS,SCRN,RCNTR,V,X,Y
 S FLDS="@;.01;.02;"_$S(WHICH=1:".08;3",WHICH=2:".13;5",1:".06;1")
 S SCRN="I $P(^(0),U,"_$S(WHICH=1:"8",WHICH=2:"13",1:"6")_")=1"
 D LIST^DIC(344.6,,FLDS,"P",,,,,SCRN,,RCGLB(344.6))
 S X=$$GET1^DID(344.61,$S(WHICH=1:1.01,WHICH=2:1.05,1:.02),,"TITLE") ; Auto-Post Rx/Tri/Med Claims Enabled
 S V=" (Y/N)" S:X[V X=$P(X,V,1)_$S(WHICH=1:": ",1:$P(X,V,2)) ; Remove yes/no prompt
 S Y=X_" "_@RCGLB(344.61)@(344.61,"1,",$S(WHICH=1:1.01,WHICH=2:1.05,1:.02),"E")
 D AD2RPT(Y)
 ; list auto-post excluded payers
 I (RCPARM($S(WHICH=1:"RX ",WHICH=2:"TRI ",1:"")_"AUTO-POST")!RCPARM($S(WHICH=1:"RX ",WHICH=2:"TRI ",1:"")_"AUTO-DECREASE")) D
 . D OPPAYS($S(WHICH=1:"Pharmacy",WHICH=2:"TRICARE",1:"Medical")_" Auto-Posting") ; PRCA*4.5*345
 . D AD2RPT(" ")
 ;
 K @RCGLB(344.6) ; Delete old data
 Q
 ;
MEDAUTOD(RCPARM,RCTYPE) ; Display auto-decrease parameters - PRCA*4.5*349
 ; Input:     RCPARM("AUTO-DECREASE") - 1 if Medical Auto-Posting is turned for claims w/Payments
 ;                                      0 otherwise
 ;            RCTYPE- Report type (M)edical, (P)harmacy, (T)RICARE or (A)ll
 N FLDSS
 Q:'((RCTYPE="M")!(RCTYPE="A"))
 ; RCDPE AUTO-PAY EXCLUSION file (#344.6)
 ; screening logic: ^DD(344.6,.07,0)="EXCLUDE MED CLAIMS DECREASE^S^0:No;1:Yes;^0;7^Q"
 S FLDS="@;.01;.02;.07;2"                           ; PRCA*4.5*349 - Added line
 D LIST^DIC(344.6,,FLDS,"P",,,,,"I $P(^(0),U,7)=1",,RCGLB(344.6)) ; PRCA*4.5*349
 D AD2RPT(" ")
 ; Display Auto-Decrease parameters for paid lines
 D AUTOD(1,0,.RCGLB,RCTYPE) ; PRCA*4.5*349
 ; Display Auto-Decrease parameters for no-pay lines
 D AUTOD(0,0,.RCGLB,RCTYPE) ; PRCA*4.5*349
 D AD2RPT(" ")
 ;
 Q
RXAUTOD(RCPARM,RCTYPE) ; Display auto-decrease parameters - PRCA*4.5*349
 ; Input:  RCPARM("RX AUTO-DECREASE") - 1 if Rx Auto-Posting is turned for claims w/Payments
 ;                                      0 otherwise
 ;            RCTYPE- Report type (M)edical, (P)harmacy, (T)RICARE or (A)ll
 N FLDS
 Q:'((RCTYPE="P")!(RCTYPE="A"))
 ; Display Auto-Decrease parameters for paid lines
 K @RCGLB(344.6)  ; delete old data
 ; RCDPE AUTO-PAY EXCLUSION file (#344.6)
 D LIST^DIC(344.6,,"@;.01;.02;.12;4","P",,,,,"I $P(^(0),U,12)=1",,RCGLB(344.6))
 D AUTOD(1,1,.RCGLB,RCTYPE) ; PRCA*4.5*345
 D AD2RPT(" ")
 Q
TRIAUTOD(RCPARM,RCTYPE) ; Display auto-decrease parameters - PRCA*4.5*349
 ; Input: RCPARM("TRI AUTO-DECREASE") - 1 if TRICARE Auto-Posting is turned for claims w/Payments
 ;                                      0 otherwise
 ;            RCTYPE- Report type (M)edical, (P)harmacy, (T)RICARE or (A)ll
 N FLDS
 Q:'((RCTYPE="T")!(RCTYPE="A"))
 ; RCDPE AUTO-PAY EXCLUSION file (#344.6)
 ; screening logic: ^DD(344.6,.14,0)="EXCLUDE TRICARE CLAIMS DECREASE^S^0:No;1:Yes;^0;7^Q"
 S FLDS="@;.01;.02;.14;6"
 D LIST^DIC(344.6,,FLDS,"P",,,,,"I $P(^(0),U,14)=1",,RCGLB(344.6))
 ;
 ; BEGIN PRCA*4.5*326
 ; Display Auto-Decrease parameters for paid lines
 D AUTOD(1,2,.RCGLB,RCTYPE)
 ; Display Auto-Decrease parameters for no-pay lines
 D AUTOD(0,2,.RCGLB,RCTYPE)
 ; END PRCA*4.5*326
 ;
 D AD2RPT(" ")
 Q
 ; BEGIN - PRCA*4.5*326
AUTOD(PAID,WHICH,RCGLB,RCTYPE) ; Display auto-decrease parameters - PRCA*4.5*345
 ; PRCA*4.5*349 - Added TRICARE
 ; Input:   PAID  - 1 - Claims with Payments parameters 
 ;                  0 - Claims with No Payments parameters
 ;          RCGLB - Field value array from LIST^DIC call
 ;          WHICH - 0 - Medical, 1 - Rx, 2 - TRICARE
 ;         RCTYPE- Report type (M)edical, (P)harmacy, (T)RICARE or (A)ll
 ;         RCPARM(344.61,0) - ^RCY(344.61,1,0)
 ;         RCPARM(344.61,1) - ^RCY(344.61,1,1)
 ; Output: Auto-Decrease parameters are added to the report
 ;
 ; PRCA*4.5*349 - Add ONOFF variable to whether auto-post is enabled/disabled for this type
 N CNT,FIELD,ONOFF,RCCODE,RCI,X,XX,Y,YY
 ; Do not display Auto-Decrease questions when Auto-Post Disabled
 S ONOFF=$$AUTOPON^RCDPESPC(WHICH)
 I ONOFF=0 D  Q
 . N WNAME
 . S WNAME=$S(WHICH=0:"Medical",WHICH=1:"Pharmacy",1:"TRICARE")
 . D AD2RPT("NOTICE: "_WNAME_" Auto-Decrease unavailable because Auto-Posting of "_WNAME_" Claims is currently disabled")
 ; RCDPE PARAMETER file (#344.61), auto-decrease of medical claims
 I WHICH=0 S FIELD=$S(PAID:.03,1:.11)
 E  I WHICH=1 S FIELD=1.02
 E  S FIELD=$S(PAID:1.06,1:1.09) ; PRCA*4.5*349
 S X=$$GET1^DID(344.61,FIELD,,"TITLE")
 I X[" (Y/N): " S X=$P(X," (Y/N): ")_": " ; remove yes/no prompt
 S Y=$J(X,45)_@RCGLB(344.61)@(344.61,"1,",FIELD,"E")
 D AD2RPT(" "),AD2RPT(Y)
 I WHICH=0 S XX=RCPARM("AUTO-POST"),YY=RCPARM("AUTO-DECREASE")         ; PRCA*4.5*349 - Added line
 I WHICH=1 S XX=RCPARM("RX AUTO-POST"),YY=RCPARM("RX AUTO-DECREASE")   ; PRCA*4.5*349 - Added line
 I WHICH=2 S XX=RCPARM("TRI AUTO-POST"),YY=RCPARM("TRI AUTO-DECREASE") ; PRCA*4.5*349 - Added line
 I PAID,(XX!YY) D  ;
 . D OPPAYS($S(WHICH=0:"Medical",WHICH=1:"Pharmacy",1:"TRICARE")_" Auto-Decrease") ; PRCA*4.5*349
 . D AD2RPT(" ")
 ; If auto-decrease is off - do not display CARCS or auto-decrease days or auto-decrease maximum
 I +$$GET1^DIQ(344.61,"1,",FIELD,"I")=0 Q
 ;
 ; PRCA*4.5*349 - Start modified block
 S XX=$S(WHICH=0:"MEDICAL",WHICH=1:"PHARMACY",1:"TRICARE")
 S YY="MAXIMUM DOLLAR AMOUNT TO AUTO-DECREASE PER "_XX_" CLAIM: "_"$"
 S XX=""
 I WHICH=0 D  ;
 . I PAID S XX=YY_$$GET1^DIQ(344.61,"1,",.05,"E")
 I WHICH=1 S XX=YY_$$GET1^DIQ(344.61,"1,",1.04,"E")
 I WHICH=2 D  ;
 . I PAID S XX=YY_$$GET1^DIQ(344.61,"1,",1.07,"E")
 I XX'="" D AD2RPT(XX)
 ; PRCA*4.5*349 - End modified block
 ;
 S CNT=0
 ; Print the CARC Auto-decrease parameters
 I $$CARCCHK(RCTYPE,PAID,$S(WHICH=0:"M",WHICH=1:"P",1:"T")) D  ; PRCA*4.5*349
 . D AD2RPT(" ")
 . S X=" AUTO-DECREASE "_$S(PAID:"PAID",1:"NO-PAY")
 . S X=X_" "_$S(WHICH=0:"MEDICAL",WHICH=1:"PHARAMCY",1:"TRICARE")
 . S X=X_" CLAIMS FOR THE FOLLOWING CARC/AMOUNTS ONLY:"
 . D AD2RPT(X)
 . D AD2RPT(" ")
 . S RCSTRING=$TR($J("",70)," ","-"),RCI=0
 . D AD2RPT(" CARC Description                                            Max. Amt")
 . D AD2RPT(" "_RCSTRING)
 . ;
 . ; Loop and print entries
 . S RCCODE="" F  S RCCODE=$O(^RCY(344.62,"B",RCCODE)) Q:RCCODE=""  D  ; PRCA*4.5*349 - Sort CARC entries by CARC code instead of by most recently entered
 . . S RCI=0 F  S RCI=$O(^RCY(344.62,"B",RCCODE,RCI)) Q:'RCI  D        ; PRCA*4.5*349 - Sort CARC entries by CARC code instead of by most recently entered
 . . . S RCCIEN=$O(^RC(345,"B",RCCODE,""))
 . . . S RCDESC=$G(^RC(345,RCCIEN,1,1,0)) ; WP field 345.04
 . . . I WHICH=0 S FIELD=$S(PAID:.02,1:.08)
 . . . I WHICH=1 S FIELD=2.01
 . . . I WHICH=2 S FIELD=$S(PAID:3.01,1:3.07)
 . . . S RCSTAT=$$GET1^DIQ(344.62,RCI,FIELD,"I")
 . . . Q:RCSTAT'=1
 . . . S CNT=CNT+1
 . . . I $L(RCDESC)>50 S RCDESC=$E(RCDESC,1,50)_"..."
 . . . D GETCODES^RCDPCRR(RCCODE,"","A",$$DT^XLFDT,"RCCARCD","1^70")
 . . . S Y=" "_$J(RCCODE,4)_" "_$E(RCDESC,1,53)
 . . . S:$L(RCDESC)<53 Y=Y_$J("",(53-$L(RCDESC)))
 . . . I WHICH=0 S FIELD=$S(PAID:.06,1:.12)
 . . . I WHICH=1 S FIELD=2.05
 . . . I WHICH=2 S FIELD=$S(PAID:3.05,1:3.11)
 . . . S Y=Y_$J($$GET1^DIQ(344.62,RCI,FIELD,"I"),10,0)
 . . . I '$$ACT^RCDPRU(345,RCCODE,) S Y=Y_" (I)"  ; if inactive, display (i)
 . . . D AD2RPT(Y)
 . I CNT=0 D AD2RPT(" No CARCs are set up for "_$S(PAID:"",1:"NO-PAY ")_"auto-decrease")
 ;
 ; Display auto-decrease days
 I WHICH=0 S FIELD=$S(PAID:.04,1:.12)
 I WHICH=1 S FIELD=1.03
 I WHICH=2 S FIELD=$S(PAID:1.08,1:1.1)
 S X=$P($$GET1^DID(344.61,FIELD,,"TITLE")," (",1)_": "
 S Y=$J(X,40)_@RCGLB(344.61)@(344.61,"1,",FIELD,"E")
 D AD2RPT(" "),AD2RPT(Y)
 Q
 ; END - PRCA*4.5*326
 ;
OPPAYS(RCTYPE) ; Output list of excluded payers - Added for PRCA*4.5*345
 ; Input: RCTYPE - Type of list being displayed. Free text. 
 ;        RCPARM - array assumed to exist and contain AUTO-POST and AUTO-DECREASE flags for MED or PHARM 
 ;        RCGLB - array assumed to exist and contain output from GETS^DIQ for payer exclusions
 ;
 N X,XX
 D AD2RPT(" ")
 I '$D(@RCGLB(344.6)@("DILIST",1,0)) D  Q
 . S X="     No payers excluded from "_RCTYPE_"." D AD2RPT($J(" ",80-$L(X)\2)_X)
 ;
 S XX=$P(RCTYPE," ",1)
 S XX=$S(XX="Pharmacy":"Rx",1:$E(XX,1,3))
 S XX=XX_" "_$P(RCTYPE," ",2,3)
 S X="   Excluded Payer ("_XX_")"_$J("",19-$L(XX))_"Comment"
 D AD2RPT(X)
 S RCNTR=0 F  S RCNTR=$O(@RCGLB(344.6)@("DILIST",RCNTR)) Q:'RCNTR  D
 . S V=@RCGLB(344.6)@("DILIST",RCNTR,0),X=$E($P(V,U,2),1,35)
 . S Y="   "_X_$J(" ",36-$L(X))_$P(V,U,5) D AD2RPT($E(Y,1,IOM))
 Q
