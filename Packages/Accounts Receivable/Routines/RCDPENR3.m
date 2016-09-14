RCDPENR3 ;ALB/SAB - EPay National Reports - ERA/EFT Trending Report, part 2 ;06/30/15
 ;;4.5;Accounts Receivable;**304**;Mar 20, 1995;Build 104
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;Read ^DGCR(399) via Private IA 3820
 ;Read ^DG(40.8) via Controlled IA 417
 ;Read ^IBM(361.1) via Private IA 4051
 ;Use DIV^IBJDF2 via Private IA 3130
 ;
 Q
 ;
 ;
 ;Generate the needed statistics for the report
COMPILE ;
 ;
 ;RCERATYP values 1="ERA/EFT"  2="ERA/PAPER CHECK"  3="PAPER EOB/EFT"
 ;     needed for the correct report sort order
 N I,RCINSTIN,RCERATYP,RCCLAIM,RCDATA,RCDAYS,RCEFTPD,RCEPDT,RCERAIEN,RCERANUM,RCEFTIEN  ; Looping variable
 N RCGPDATA,RCGPCT,RCGPBILL,RCGPPD,RCGPBECT,RCGPBEDY,RCGPEECT,RCGPEEDY,RCGPEPCT,RCGPEPDY,RCGPBPCT,RCGPBPDY,RCGPECT,RCGPENM,RCGPFCT,RCGPFPD  ; Grand Total W/Payment method variables 
 N RCPPDATA,RCPPCT,RCPPBILL,RCPPPD,RCPPBECT,RCPPBEDY,RCPPEECT,RCPPEEDY,RCPPEPCT,RCPPEPDY,RCPPBPCT,RCPPBPDY,RCPPECT,RCPPENM,RCPPFCT,RCPPFPD  ; Payer W/Payment method variables 
 ;
 ;Initialize all valid ERA/EFT combinations to report on.
 ; init grand total
 F I=1:1:3 I '$D(^TMP("RCDPENR2",$J,"GTOT",I)) S ^TMP("RCDPENR2",$J,"GTOT",I)=0
 ;
 ; init insurance grand totals
 S RCINSTIN=""
 F  S RCINSTIN=$O(^TMP("RCDPENR2",$J,"PAYER",RCINSTIN)) Q:RCINSTIN=""  D
 . F I=1:1:3 I '$D(^TMP("RCDPENR2",$J,"PAYER",RCINSTIN,I)) S ^TMP("RCDPENR2",$J,"PAYER",RCINSTIN,I)=0
 ;
 ; Compile results
 S RCINSTIN=""
 F  S RCINSTIN=$O(^TMP("RCDPENR2",$J,"MAIN",RCINSTIN)) Q:RCINSTIN=""  D
 . S RCERATYP=""
 . F  S RCERATYP=$O(^TMP("RCDPENR2",$J,"MAIN",RCINSTIN,RCERATYP)) Q:RCERATYP=""  D
 . . S RCCLAIM=""
 . . F  S RCCLAIM=$O(^TMP("RCDPENR2",$J,"MAIN",RCINSTIN,RCERATYP,RCCLAIM)) Q:RCCLAIM=""  D
 . . . S RCDATA=$G(^TMP("RCDPENR2",$J,"MAIN",RCINSTIN,RCERATYP,RCCLAIM))
 . . . Q:RCDATA=""
 . . . ;
 . . . ; Extract the Grand Total by EFT/ERA type
 . . . S RCGPDATA=$G(^TMP("RCDPENR2",$J,"GTOT",RCERATYP))
 . . . S RCGPCT=$P(RCGPDATA,U)
 . . . S RCGPBILL=$P(RCGPDATA,U,2)
 . . . S RCGPPD=$P(RCGPDATA,U,3)
 . . . S RCGPBECT=$P(RCGPDATA,U,4)
 . . . S RCGPBEDY=$P(RCGPDATA,U,5)
 . . . S RCGPEECT=$P(RCGPDATA,U,6)
 . . . S RCGPEEDY=$P(RCGPDATA,U,7)
 . . . S RCGPEPCT=$P(RCGPDATA,U,8)
 . . . S RCGPEPDY=$P(RCGPDATA,U,9)
 . . . S RCGPBPCT=$P(RCGPDATA,U,10)
 . . . S RCGPBPDY=$P(RCGPDATA,U,11)
 . . . S RCGPECT=$P(RCGPDATA,U,12)
 . . . S RCGPENM=$P(RCGPDATA,U,13)
 . . . S RCGPFCT=$P(RCGPDATA,U,14)
 . . . S RCGPFPD=$P(RCGPDATA,U,15)
 . . . ;
 . . . ; Extract the Payer specific information by EFT/ERA type
 . . . S RCPPDATA=$G(^TMP("RCDPENR2",$J,"PAYER",RCINSTIN,RCERATYP))
 . . . S RCPPCT=$P(RCPPDATA,U)
 . . . S RCPPBILL=$P(RCPPDATA,U,2)
 . . . S RCPPPD=$P(RCPPDATA,U,3)
 . . . S RCPPBECT=$P(RCPPDATA,U,4)
 . . . S RCPPBEDY=$P(RCPPDATA,U,5)
 . . . S RCPPEECT=$P(RCPPDATA,U,6)
 . . . S RCPPEEDY=$P(RCPPDATA,U,7)
 . . . S RCPPEPCT=$P(RCPPDATA,U,8)
 . . . S RCPPEPDY=$P(RCPPDATA,U,9)
 . . . S RCPPBPCT=$P(RCPPDATA,U,10)
 . . . S RCPPBPDY=$P(RCPPDATA,U,11)
 . . . S RCPPECT=$P(RCPPDATA,U,12)
 . . . S RCPPENM=$P(RCPPDATA,U,13)
 . . . S RCPPFCT=$P(RCPPDATA,U,14)
 . . . S RCPPFPD=$P(RCPPDATA,U,15)
 . . . ;
 . . . ; Total counts - Grand/Payment Method
 . . . S RCGPCT=RCGPCT+1
 . . . S RCGPBILL=RCGPBILL+$P(RCDATA,U,6)
 . . . S RCGPPD=RCGPPD+$P(RCDATA,U,7)
 . . . ;
 . . . ; Total counts - Payer/Payment method
 . . . S RCPPCT=RCPPCT+1
 . . . S RCPPBILL=RCPPBILL+$P(RCDATA,U,6)
 . . . S RCPPPD=RCPPPD+$P(RCDATA,U,7)
 . . . ;
 . . . ; Billed to ERA received
 . . . I $P(RCDATA,U,8),$P(RCDATA,U,9) D
 . . . . S RCGPBECT=RCGPBECT+1
 . . . . S RCPPBECT=RCPPBECT+1
 . . . . S RCDAYS=$$FMDIFF^XLFDT($P(RCDATA,U,9),$P(RCDATA,U,8),1)
 . . . . S RCGPBEDY=RCGPBEDY+RCDAYS
 . . . . S RCPPBEDY=RCPPBEDY+RCDAYS
 . . . ;
 . . . ; ERA to EFT received
 . . . I $P(RCDATA,U,10),$P(RCDATA,U,9) D
 . . . . S RCGPEECT=RCGPEECT+1
 . . . . S RCPPEECT=RCPPEECT+1
 . . . . S RCDAYS=$$FMDIFF^XLFDT($P(RCDATA,U,10),$P(RCDATA,U,9),1)
 . . . . S RCGPEEDY=RCGPEEDY+RCDAYS
 . . . . S RCPPEEDY=RCPPEEDY+RCDAYS
 . . . ;
 . . . ; ERA and EFT received, and payment Posted
 . . . I $P(RCDATA,U,10),$P(RCDATA,U,9),$P(RCDATA,U,11) D
 . . . . S RCGPEPCT=RCGPEPCT+1
 . . . . S RCPPEPCT=RCPPEPCT+1
 . . . . S RCEPDT=$S($P(RCDATA,U,9)>$P(RCDATA,U,10):9,1:10)  ;determine which date is later
 . . . . S RCDAYS=$$FMDIFF^XLFDT($P(RCDATA,U,11),$P(RCDATA,U,RCEPDT),1)
 . . . . S RCGPEPDY=RCGPEPDY+RCDAYS
 . . . . S RCPPEPDY=RCPPEPDY+RCDAYS
 . . . ;
 . . . ; Bill to Payment Posted
 . . . I $P(RCDATA,U,8),$P(RCDATA,U,11) D
 . . . . S RCGPBPCT=RCGPBPCT+1
 . . . . S RCPPBPCT=RCPPBPCT+1
 . . . . S RCDAYS=$$FMDIFF^XLFDT($P(RCDATA,U,11),$P(RCDATA,U,8),1)
 . . . . S RCGPBPDY=RCGPBPDY+RCDAYS
 . . . . S RCPPBPDY=RCPPBPDY+RCDAYS
 . . . ;
 . . . ; If the ERA hasn't already been counted, add it to the totals
 . . . S RCERAIEN=$P(RCDATA,U,2)
 . . . I RCERAIEN,'$D(^TMP("RCDPENR2",$J,"ERA",RCERAIEN)) D
 . . . . S ^TMP("RCDPENR2",$J,"ERA",RCERAIEN)=""
 . . . . S RCERANUM=$P(RCDATA,U,15)
 . . . . S RCGPECT=RCGPECT+1,RCPPECT=RCPPECT+1
 . . . . S RCGPENM=RCGPENM+RCERANUM,RCPPENM=RCPPENM+RCERANUM
 . . . ;
 . . . ; If the EFT hasn't already been counted, add it to the totals
 . . . S RCEFTIEN=$P(RCDATA,U,3)
 . . . I (RCEFTIEN),('$D(^TMP("RCDPENR2",$J,"EFT",RCEFTIEN))) D
 . . . . S ^TMP("RCDPENR2",$J,"EFT",RCEFTIEN)=""
 . . . . S RCEFTPD=$P(RCDATA,U,18)
 . . . . S RCGPFCT=RCGPFCT+1,RCPPFCT=RCPPFCT+1
 . . . . S RCGPFPD=RCGPFPD+RCEFTPD,RCPPFPD=RCPPFPD+RCEFTPD
 . . . ;
 . . . ; Update the payer specific information By Payment Method
 . . . S $P(RCPPDATA,U)=RCPPCT
 . . . S $P(RCPPDATA,U,2)=RCPPBILL
 . . . S $P(RCPPDATA,U,3)=RCPPPD
 . . . S $P(RCPPDATA,U,4)=RCPPBECT
 . . . S $P(RCPPDATA,U,5)=RCPPBEDY
 . . . S $P(RCPPDATA,U,6)=RCPPEECT
 . . . S $P(RCPPDATA,U,7)=RCPPEEDY
 . . . S $P(RCPPDATA,U,8)=RCPPEPCT
 . . . S $P(RCPPDATA,U,9)=RCPPEPDY
 . . . S $P(RCPPDATA,U,10)=RCPPBPCT
 . . . S $P(RCPPDATA,U,11)=RCPPBPDY
 . . . S $P(RCPPDATA,U,12)=RCPPECT
 . . . S $P(RCPPDATA,U,13)=RCPPENM
 . . . S $P(RCPPDATA,U,14)=RCPPFCT
 . . . S $P(RCPPDATA,U,15)=RCPPFPD
 . . . S ^TMP("RCDPENR2",$J,"PAYER",RCINSTIN,RCERATYP)=RCPPDATA
 . . . ;
 . . . ; Update the Grand Total specific information By Payment Method
 . . . S $P(RCGPDATA,U)=RCGPCT
 . . . S $P(RCGPDATA,U,2)=RCGPBILL
 . . . S $P(RCGPDATA,U,3)=RCGPPD
 . . . S $P(RCGPDATA,U,4)=RCGPBECT
 . . . S $P(RCGPDATA,U,5)=RCGPBEDY
 . . . S $P(RCGPDATA,U,6)=RCGPEECT
 . . . S $P(RCGPDATA,U,7)=RCGPEEDY
 . . . S $P(RCGPDATA,U,8)=RCGPEPCT
 . . . S $P(RCGPDATA,U,9)=RCGPEPDY
 . . . S $P(RCGPDATA,U,10)=RCGPBPCT
 . . . S $P(RCGPDATA,U,11)=RCGPBPDY
 . . . S $P(RCGPDATA,U,12)=RCGPECT
 . . . S $P(RCGPDATA,U,13)=RCGPENM
 . . . S $P(RCGPDATA,U,14)=RCGPFCT
 . . . S $P(RCGPDATA,U,15)=RCGPFPD
 . . . S ^TMP("RCDPENR2",$J,"GTOT",RCERATYP)=RCGPDATA
 Q
 ;
 ;Retrieve all necessary information for the EFTs sent during the requested period.
GETEFT(RCSDATE,RCEDATE,RCRATE) ;
 ;RCSDATE - Start date of extraction
 ;RCEDATE - End date of extraction
 ;
 ;^TMP("RCDPENR2",$J,"MAIN",IEN of Claim/Bill #) =
 ; Where:
 ; Piece  Variable
 ; 1      RCBILL   - IEN of Bill/Claim #
 ; 2      RCERA    - IEN of the ERA the bill was paid on.
 ; 3      RCIEN    - IEN of the EFT the money for the bill arrived on
 ; 4      RCEOB    - IEN of the EOB within the ERA 
 ; 5      RCDOS    - Date of Service
 ; 6      RCAMTBL  - Amount Billed
 ; 7      RCAMTPD  - Amount Paid
 ; 8      RCDTBILL - Date of Bill
 ; 9      RCERARCD - Date ERA received
 ; 10     RCEFTRCD - Date EFT received
 ; 11     RCPOSTED - Date Payment Posted to claim
 ; 12     RCTRACE  - ERA Trace number for EOB
 ; 13     RCMETHOD - Method of Payment transmittal
 ; 14     RCTRNTYP - Was payment EFT or Paper Check / Was the ERA Paper or EDI Lockbox
 ; 15     RCERANUM - # EOB'S in ERA
 ; 16     RCDIV    - Division of the bill
 ; 17     RCINSTIN - Insurance/Insurance TIN
 ; 18     RCEFTPD  - Amount paid as an EFT, not as a check.
 ;
 N RCLDATE,RCINS,RCIEN,RCEFTDT,RCERA,RCEFT,RCRCPT,RCPOSTED,RCPAYTYP,RCERADT,RCTRACE,RCERAIDX
 N RCTRLN,RCTRBD,RCERANUM,RCTIN,RCPAYER,RCINSTIN,RCLPIEN,RCDTDATA,RCEOB,RCBILL,RCDIV,RCDOS,RCAMTBL
 N RCDTBILL,RCMETHOD,RCPAPER,RCEFTTYP,RCEFTPD,RCTRNTYP,RCDATA,RCAMTPD,RCEFTRCD,RCERARCD,RCRATETP
 N RCMSTAT,RCESUMDT,RCPSUMDT
 ;
 ;Get the EFT Detail information for the report batches sent within the given date range.
 S RCLDATE=RCSDATE-.001
 F  S RCLDATE=$O(^RCY(344.31,"ADR",RCLDATE)) Q:RCLDATE=""  Q:RCLDATE>RCEDATE  D
 . S RCIEN=0
 . F  S RCIEN=$O(^RCY(344.31,"ADR",RCLDATE,RCIEN)) Q:'RCIEN  D
 . . S RCEFTDT=$G(^RCY(344.31,RCIEN,0))
 . . Q:RCEFTDT=""
 . . S RCERA=$P(RCEFTDT,U,10)            ; ERA IEN
 . . S RCEFTRCD=$P(RCEFTDT,U,13)
 . . S RCEFT=$P(RCEFTDT,U)
 . . S RCMSTAT=$P(RCEFTDT,U,8)
 . . S RCRCPT=$P(RCEFTDT,U,9)
 . . S RCEFTPD=$P(RCEFTDT,U,7)
 . . S RCPOSTED=$$GET1^DIQ(344.3,RCEFT_",",.11,"I")
 . . S RCPAYTYP=$$GET1^DIQ(344,RCRCPT_",",.04,"I")
 . . I RCERA D  Q
 . . . S RCERADT=$G(^RCY(344.4,RCERA,0)) ; ERA Data extracted
 . . . Q:'RCERADT
 . . . S RCTRACE=$P(RCERADT,U,2)         ; Trace #
 . . . S RCTRLN=$L(RCTRACE),RCTRBD=$S(RCTRLN<11:1,1:RCTRLN-9)
 . . . S RCTRACE=$E(RCTRACE,RCTRBD,RCTRLN)  ; get the last 10 digits of Trace #
 . . . S RCERARCD=$P($P(RCERADT,U,7),".",1)  ;get the date of the ERA
 . . . S RCERANUM=$P(RCERADT,U,11)
 . . . S RCTIN=$P(RCERADT,U,3)
 . . . S RCINS=$P(RCERADT,U,6)
 . . . S RCPAYER=$$GETARPYR^RCDPENR2(RCTIN) ; find the AR Payer IEN
 . . . Q:'RCPAYER                  ; Quit if Payer/TIN not found
 . . . Q:'$$INSCHK^RCDPENR2(RCPAYER)    ; Payer is not in the included list for the report
 . . . S RCINSTIN=RCINS_"/"_RCTIN
 . . . S RCLPIEN=0
 . . . F  S RCLPIEN=$O(^RCY(344.4,RCERA,1,RCLPIEN)) Q:'RCLPIEN  D
 . . . . S RCDTDATA=$G(^RCY(344.4,RCERA,1,RCLPIEN,0))
 . . . . S RCEOB=$P(RCDTDATA,U,2)
 . . . . S RCBILL=$$BILLIEN^RCDPENR1(RCEOB)
 . . . . Q:RCBILL=""   ; no billing information
 . . . . Q:$D(^TMP("RCDPENR2",$J,"MAIN",RCBILL))  ;already captured.
 . . . . S RCDIV=$$DIV^IBJDF2(RCBILL)
 . . . . S RCDIV=$$GET1^DIQ(40.8,RCDIV_",",".01","E")
 . . . . ;
 . . . . S RCRATETP=$$GET1^DIQ(399,RCBILL_",",.07,"I")
 . . . . Q:RCRATETP'=RCRATE
 . . . . ; Quit if user specified a specific division and bill is not in that Division
 . . . . I '$D(^TMP("RCDPENR2",$J,"DIVALL"))&'$D(^TMP("RCDPENR2",$J,"DIV",RCDIV)) Q 
 . . . . S RCDOS=$$GET1^DIQ(399,RCBILL_",",.03,"I")
 . . . . S RCAMTBL=$$GET1^DIQ(361.1,RCEOB_",",2.04,"I")
 . . . . S RCAMTPD=$$GET1^DIQ(361.1,RCEOB_",",1.01,"I")
 . . . . S RCDTBILL=$$GET1^DIQ(399,RCBILL_",",12,"I")
 . . . . Q:RCDTBILL=""   ;cant calculate if date first printed is NULL
 . . . . ;
 . . . . S RCMETHOD=$S($$GET1^DIQ(344,RCERA_",",4.02,"I")="":"MANUAL",1:"AUTOPOST")
 . . . . S RCPAPER=$P($G(^RCY(344.4,RCERA,20)),U,3)  ; Paper EOB ERA?
 . . . . ;ERA not a paper ERA, is the EOB a Paper EOB
 . . . . S:'RCPAPER RCPAPER=$S($$GET1^DIQ(361.1,RCEOB_",",.17,"I")=0:"ERA",1:"PAPER")
 . . . . S RCEFTTYP=$S(RCPAYTYP=4:"PAPER",1:"EFT")
 . . . . S RCTRNTYP=RCPAPER_"/"_RCEFTTYP
 . . . . S RCERAIDX=$S(RCTRNTYP="ERA/EFT":1,RCTRNTYP="ERA/PAPER":2,RCTRNTYP="PAPER/EFT":3,1:4)
 . . . . Q:RCERAIDX=4   ;Paper Check Paper EOB not supported
 . . . . S RCDATA=RCBILL_U_RCERA_U_RCIEN_U_RCEOB_U_RCDOS_U_RCAMTBL_U_RCAMTPD_U_RCDTBILL_U_RCERARCD
 . . . . S RCDATA=RCDATA_U_RCEFTRCD_U_RCPOSTED_U_RCTRACE_U_RCMETHOD_U
 . . . . S RCDATA=RCDATA_RCTRNTYP_U_RCERANUM_U_RCDIV_U_RCINSTIN_U_RCEFTPD
 . . . . S ^TMP("RCDPENR2",$J,"MAIN",RCINSTIN,RCERAIDX,RCBILL)=RCDATA
 . . I (RCMSTAT=2),(RCIEN),('$D(^TMP("RCDPENR2",$J,"EFT",RCIEN))) D
 . . . S RCTIN=$P(RCEFTDT,U,3)
 . . . S RCINS=$P(RCEFTDT,U,2)
 . . . S RCPAYER=$$GETARPYR^RCDPENR2(RCTIN) ; find the AR Payer IEN
 . . . Q:'RCPAYER                  ; Quit if Payer/TIN not found
 . . . Q:'$$INSCHK^RCDPENR2(RCPAYER)    ; Payer is not in the included list for the report
 . . . S RCINSTIN=RCINS_"/"_RCTIN
 . . . S RCESUMDT=$G(^TMP("RCDPENR2",$J,"GTOT",3))
 . . . S RCPSUMDT=$G(^TMP("RCDPENR2",$J,"PAYER",RCINSTIN,3))
 . . . S $P(RCESUMDT,U,14)=$P(RCESUMDT,U,14)+1
 . . . S $P(RCPSUMDT,U,14)=$P(RCPSUMDT,U,14)+1
 . . . S $P(RCESUMDT,U,15)=$P(RCESUMDT,U,15)+RCEFTPD
 . . . S $P(RCPSUMDT,U,15)=$P(RCPSUMDT,U,15)+RCEFTPD
 . . . S ^TMP("RCDPENR2",$J,"GTOT",3)=RCESUMDT
 . . . S ^TMP("RCDPENR2",$J,"PAYER",RCINSTIN,3)=RCPSUMDT
 Q
 ;
 ;Print the Grand Total/Summary data for the EFT/ERA Trending Report
PRINTGT(RCTITLE,RCDATA,RCDISP,RCERAFLG,RCEXCEL) ;
 ;
 ; Undeclared Parameter(s) - RCRPIEN,RCLINE,RCSTOP
 ;
 N RCCOUNT,RCBILL,RCPAID,RCPCT,RCBECT,RCBEDY,RCAVGBE,RCEECT,RCEEDY
 N RCEPCT,RCEPDY,RCAVGEP,RCBPCT,RCBPDY,RCAVGBP,RCBORDER,RCSCDATA
 N RCC,RCB,RCAVGEE,RCLTXT,I,RCSTRDTA,RCSTRNG,RCDTXT
 ;
 S RCERAFLG=+$G(RCERAFLG),RCDISP=$G(RCDISP)
 I $Y>(IOSL-7),RCDISP D ASK^RCDPEADP(.RCSTOP,0) Q:RCSTOP  D HEADER^RCDPENR2
 ;
 ; Display report type being displayed
 D PRINTHDR^RCDPENR2(RCTITLE)
 ;
 ; Extract data from string and build string for output
 S $P(RCSCDATA,U,1)=+$P(RCDATA,U)
 S RCBILL=+$P(RCDATA,U,2)
 S RCPAID=+$P(RCDATA,U,3)
 S $P(RCSCDATA,U,2)=RCBILL
 S $P(RCSCDATA,U,3)=RCPAID
 S $P(RCSCDATA,U,4)=$S(+RCBILL=0:0,1:RCPAID/RCBILL)*100  ; Convert to percent format
 S RCBECT=+$P(RCDATA,U,4)
 S RCBEDY=+$P(RCDATA,U,5)
 S $P(RCSCDATA,U,6)=$FN($S(+RCBECT=0:0,1:RCBEDY/RCBECT),"",0)
 S RCEECT=+$P(RCDATA,U,6)
 S RCEEDY=+$P(RCDATA,U,7)
 S $P(RCSCDATA,U,7)=$FN($S(+RCEECT=0:0,1:RCEEDY/RCEECT),"",0)
 S RCEPCT=+$P(RCDATA,U,8)
 S RCEPDY=+$P(RCDATA,U,9)
 S $P(RCSCDATA,U,8)=$FN($S(+RCEPCT=0:0,1:RCEPDY/RCEPCT),"",0)
 S RCBPCT=+$P(RCDATA,U,10)
 S RCBPDY=+$P(RCDATA,U,11)
 S $P(RCSCDATA,U,9)=$FN($S(+RCBPCT=0:0,1:RCBPDY/RCBPCT),"",0)
 S $P(RCSCDATA,U,11)=+$P(RCDATA,U,12)
 S $P(RCSCDATA,U,12)=+$P(RCDATA,U,13)
 S $P(RCSCDATA,U,14)=+$P(RCDATA,U,14)
 S $P(RCSCDATA,U,15)=+$P(RCDATA,U,15)
 S $P(RCSCDATA,U,16)=RCPAID-$P(RCDATA,U,15)
 F I=1:1:16 D  Q:RCSTOP
 . I RCDISP,($Y>(IOSL-4)) D  Q:RCSTOP
 . .  D ASK^RCDPEADP(.RCSTOP,0)
 . .  Q:RCSTOP
 . .  D HEADER^RCDPENR2
 . ;if printing from monthly background job save in file and quit
 . ;Otherwise print to screen
 . S (RCLTXT,RCDTXT)=$P($T(GDTXT+I),";;",2)
 . I RCTITLE["PAPER" D
 . . I (I>5),(I<9) D      ; correct display for lines 6,7,8,16
 . . . I (I=6),RCTITLE["CHECK" Q     ;Dont change line 6 if Paper check section
 . . . S RCB="EFT",RCC="CHK"  ; Correct display for Paper check section
 . . . I RCTITLE["EOB" S RCB="ERA",RCC="EOB"   ;correct display for paper eob
 . . . S RCDTXT=$P(RCLTXT,RCB,1)_RCC_$P(RCLTXT,RCB,2)
 . I 'RCDISP!RCEXCEL D  Q
 . . S RCSTRDTA=$P(RCSCDATA,U,I)
 . . ;Format lines: lines 2&3 are amounts, 4 is a percentage, remainder are integers.
 . . S RCSTRNG=RCDTXT_"^"_$S(I=4:$J($P(RCSTRDTA,"."),2)_"%",1:RCSTRDTA)
 . . I 'RCDISP D SAVEDATA^RCDPENR1(RCSTRNG,RCRPIEN) Q
 . .;if printing in an EXCEL format, print "^" delimited and quit
 . . I RCEXCEL W RCSTRNG,! Q
 . ;Output to screen
 . ;currency format
 . I (I=2)!(I=3)!(I=15) W RCDTXT,?65,$J($P(RCSCDATA,U,I),13,2),! Q
 . ; For the line items that are percentages.  Not using $J formatting due to rounding errors.
 . I I=4 W RCDTXT,?65,$J($P($P(RCSCDATA,U,I),"."),12),"%",! Q
 . ;Otherwise print Number format
 . I (I=16) D  Q
 . . W:RCERAFLG RCDTXT,?65,$J($P(RCSCDATA,U,I),13,2),!
 . W RCDTXT,?65,$J($P(RCSCDATA,U,I),13),!
 I RCSTOP Q RCSTOP
 I RCDISP W RCLINE,! ;Otherwise print Number format
 I 'RCDISP D SAVEDATA^RCDPENR1(RCLINE,RCRPIEN)
 Q RCSTOP
 ;
GDTXT ;
 ;;TOTAL NUMBER OF CLAIMS
 ;;TOTAL AMOUNT BILLED
 ;;TOTAL AMOUNT PAID
 ;;PERCENTAGE AMOUNT PAID: (%Total Paid/Billed)
 ;;
 ;;AVG #DAYS BETWEEN BILLED/ERA
 ;;AVG #DAYS BETWEEN ERA/EFT
 ;;AVG #DAYS BETWEEN ERA+EFT REC'D/PMT POSTED
 ;;AVG #DAYS BETWEEN BILLED/PMT POSTED
 ;;
 ;;TOTAL NUMBER OF ERAs
 ;;TOTAL NUMBER OF EEOBs
 ;;
 ;;TOTAL NUMBER OF EFTs
 ;;TOTAL AMOUNT COLLECTED
 ;;TOTAL DIFFERENCE BETWEEN ERAs (PAID) - EFTs (COLLECTED):
 Q
