RCDPENR3 ;ALB/SAB - EPay National Reports - ERA/EFT Trending Report, part 2 ;20 Aug 2018 13:01:41
 ;;4.5;Accounts Receivable;**304,321,326,332,349,432,446**;Mar 20, 1995;Build 15
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
 ;Generate statistics for report
COMPILE ;
 ;
 ;RCERATYP values 1="ERA/EFT"  2="ERA/PAPER CHECK"  3="PAPER EOB/EFT"  4="UNMATCHED EOB" 5="ZERO PAYMENTS"
 ;     needed for correct report sort order, PRCA*4.5*446, Added values 4 and 5
 N I,J,RCINSTIN,RCERATYP,RCCLAIM,RCDATA,RCDAYS,RCEFTPD,RCEPDT,RCERAIEN,RCERANUM,RCEFTIEN  ; Looping variable
 N RCGPDATA,RCGPCT,RCGPBILL,RCGPPD,RCGPBECT,RCGPBEDY,RCGPEECT,RCGPEEDY,RCGPEPCT,RCGPEPDY,RCGPBPCT,RCGPBPDY,RCGPECT,RCGPENM,RCGPFCT,RCGPFPD  ; Grand Total W/Payment method variables 
 N RCMETHOD,RCPPDATA,RCPPCT,RCPPBILL,RCPPPD,RCPPBECT,RCPPBEDY,RCPPEECT,RCPPEEDY,RCPPEPCT,RCPPEPDY,RCPPBPCT,RCPPBPDY,RCPPECT,RCPPENM,RCPPFCT,RCPPFPD  ; Payer W/Payment method variables 
 ;
 ;Initialize all valid ERA/EFT combinations to report on.
 ; init grand total
 F I=1:1:3 D  ; US 767
 . I '$D(^TMP("RCDPENR2",$J,"GTOT","MANUAL",I)) S ^TMP("RCDPENR2",$J,"GTOT","MANUAL",I)=0     ; PRCA*4.5*349
 . I '$D(^TMP("RCDPENR2",$J,"GTOT","AUTOPOST",I)) S ^TMP("RCDPENR2",$J,"GTOT","AUTOPOST",I)=0 ; PRCA*4.5*349
 ;
 F I=4:1:5 D   ; PRCA*4.5*446, Added values 4 and 5
 . I '$D(^TMP("RCDPENR2",$J,"GTOT","UNPOSTED",I)) S ^TMP("RCDPENR2",$J,"GTOT","UNPOSTED",I)=0 ; PRCA*4.5*446 
 ;
 ; init insurance grand totals
 S RCINSTIN=""
 F  S RCINSTIN=$O(^TMP("RCDPENR2",$J,"PAYER",RCINSTIN)) Q:RCINSTIN=""  D
 . F I=1:1:3 D
 . . I '$D(^TMP("RCDPENR2",$J,"PAYER",RCINSTIN,"MANUAL",I)) S ^TMP("RCDPENR2",$J,"PAYER",RCINSTIN,"MANUAL",I)=0 ; PRCA*4.5*349
 . . I '$D(^TMP("RCDPENR2",$J,"PAYER",RCINSTIN,"AUTOPOST",I)) S ^TMP("RCDPENR2",$J,"PAYER",RCINSTIN,"AUTOPOST",I)=0 ; PRCA*4.5*349
 . F I=4:1:5 D   ; PRCA*4.5*446, Added values 4 and 5
 . . I '$D(^TMP("RCDPENR2",$J,"PAYER",RCINSTIN,"UNPOSTED",I)) S ^TMP("RCDPENR2",$J,"PAYER",RCINSTIN,"UNPOSTED",I)=0 ; PRCA*4.5*446
 ;
 ; Compile results
 S RCINSTIN=""
 F  S RCINSTIN=$O(^TMP("RCDPENR2",$J,"MAIN",RCINSTIN)) Q:RCINSTIN=""  D
 . S RCMETHOD="" ; PRCA*4.5*349
 . F  S RCMETHOD=$O(^TMP("RCDPENR2",$J,"MAIN",RCINSTIN,RCMETHOD)) Q:RCMETHOD=""  D  ; PRCA*4.5*349 add $O on RCMETHOD
 . . S RCERATYP="" ; PRCA*4.5*349 add 1 "." to this line and every line below
 . . F  S RCERATYP=$O(^TMP("RCDPENR2",$J,"MAIN",RCINSTIN,RCMETHOD,RCERATYP)) Q:RCERATYP=""  D
 . . . S RCCLAIM=""
 . . . F  S RCCLAIM=$O(^TMP("RCDPENR2",$J,"MAIN",RCINSTIN,RCMETHOD,RCERATYP,RCCLAIM)) Q:RCCLAIM=""  D
 . . . . S RCDATA=$G(^TMP("RCDPENR2",$J,"MAIN",RCINSTIN,RCMETHOD,RCERATYP,RCCLAIM))
 . . . . Q:RCDATA=""
 . . . . I RCPUZ="P" I RCAUTO="A"&(RCMETHOD="M")!(RCAUTO="N"&(RCMETHOD="A")) Q  ; PRCA*4.5*349, PRCA*4.5*446 If user selected Payments
 . . . . F J=RCMETHOD,"TOTAL" D COMPILEX(J,RCDATA,RCINSTIN,RCMETHOD,RCERATYP,RCCLAIM)
 Q
 ;
COMPILEX(J,RCDATA,RCINSTIN,RCMETHOD,RCERATYP,RCCLAIM) ; PRCA*4.5*349 subroutine split off
  ; Extract Grand Total by EFT/ERA type
  S RCGPDATA=$G(^TMP("RCDPENR2",$J,"GTOT",J,RCERATYP))
  S RCGPCT=$P(RCGPDATA,U)
  S RCGPBILL=$P(RCGPDATA,U,2)
  S RCGPPD=$P(RCGPDATA,U,3)
  S RCGPBECT=$P(RCGPDATA,U,4)
  S RCGPBEDY=$P(RCGPDATA,U,5)
  S RCGPEECT=$P(RCGPDATA,U,6)
  S RCGPEEDY=$P(RCGPDATA,U,7)
  S RCGPEPCT=$P(RCGPDATA,U,8)
  S RCGPEPDY=$P(RCGPDATA,U,9)
  S RCGPBPCT=$P(RCGPDATA,U,10)
  S RCGPBPDY=$P(RCGPDATA,U,11)
  S RCGPECT=$P(RCGPDATA,U,12)
  S RCGPENM=$P(RCGPDATA,U,13)
  S RCGPFCT=$P(RCGPDATA,U,14)
  S RCGPFPD=$P(RCGPDATA,U,15)
  ;
  ; Extract the Payer specific info by EFT/ERA type
  S RCPPDATA=$G(^TMP("RCDPENR2",$J,"PAYER",RCINSTIN,J,RCERATYP))
  S RCPPCT=$P(RCPPDATA,U)
  S RCPPBILL=$P(RCPPDATA,U,2)
  S RCPPPD=$P(RCPPDATA,U,3)
  S RCPPBECT=$P(RCPPDATA,U,4)
  S RCPPBEDY=$P(RCPPDATA,U,5)
  S RCPPEECT=$P(RCPPDATA,U,6)
  S RCPPEEDY=$P(RCPPDATA,U,7)
  S RCPPEPCT=$P(RCPPDATA,U,8)
  S RCPPEPDY=$P(RCPPDATA,U,9)
  S RCPPBPCT=$P(RCPPDATA,U,10)
  S RCPPBPDY=$P(RCPPDATA,U,11)
  S RCPPECT=$P(RCPPDATA,U,12)
  S RCPPENM=$P(RCPPDATA,U,13)
  S RCPPFCT=$P(RCPPDATA,U,14)
  S RCPPFPD=$P(RCPPDATA,U,15)
  ;
  ; Total counts - Grand/Payment Method
  S RCGPCT=RCGPCT+1
  S RCGPBILL=RCGPBILL+$P(RCDATA,U,6)
  S RCGPPD=RCGPPD+$P(RCDATA,U,7)
  ;
  ; Total counts - Payer/Payment method
  S RCPPCT=RCPPCT+1
  S RCPPBILL=RCPPBILL+$P(RCDATA,U,6)
  S RCPPPD=RCPPPD+$P(RCDATA,U,7)
  ;
  ; Billed to ERA received
  I $P(RCDATA,U,8),$P(RCDATA,U,9) D
  . S RCGPBECT=RCGPBECT+1
  . S RCPPBECT=RCPPBECT+1
  . S RCDAYS=$$FMDIFF^XLFDT($P(RCDATA,U,9),$P(RCDATA,U,8),1)
  . S RCGPBEDY=RCGPBEDY+RCDAYS
  . S RCPPBEDY=RCPPBEDY+RCDAYS
  ;
  ; ERA to EFT received
  I $P(RCDATA,U,10),$P(RCDATA,U,9) D
  . S RCGPEECT=RCGPEECT+1
  . S RCPPEECT=RCPPEECT+1
  . S RCDAYS=$$FMDIFF^XLFDT($P(RCDATA,U,10),$P(RCDATA,U,9),1)
  . S RCGPEEDY=RCGPEEDY+RCDAYS
  . S RCPPEEDY=RCPPEEDY+RCDAYS
  ;
  ; ERA and EFT received, and payment Posted
  I $P(RCDATA,U,10),$P(RCDATA,U,9),$P(RCDATA,U,11) D
  . S RCGPEPCT=RCGPEPCT+1
  . S RCPPEPCT=RCPPEPCT+1
  . S RCEPDT=$S($P(RCDATA,U,9)>$P(RCDATA,U,10):9,1:10)  ;determine which date is later
  . S RCDAYS=$$FMDIFF^XLFDT($P(RCDATA,U,11),$P(RCDATA,U,RCEPDT),1)
  . S RCGPEPDY=RCGPEPDY+RCDAYS
  . S RCPPEPDY=RCPPEPDY+RCDAYS
  ;
  ; Bill to Payment Posted
  I $P(RCDATA,U,8),$P(RCDATA,U,11) D
  . S RCGPBPCT=RCGPBPCT+1
  . S RCPPBPCT=RCPPBPCT+1
  . S RCDAYS=$$FMDIFF^XLFDT($P(RCDATA,U,11),$P(RCDATA,U,8),1)
  . S RCGPBPDY=RCGPBPDY+RCDAYS
  . S RCPPBPDY=RCPPBPDY+RCDAYS
  ;
  ; If the ERA hasn't already been counted, add it to the totals
  S RCERAIEN=$P(RCDATA,U,2)
  I RCERAIEN,'$D(^TMP("RCDPENR2",$J,"ERA",RCERAIEN,J)) D
  . S ^TMP("RCDPENR2",$J,"ERA",RCERAIEN,J)=""
  . S RCERANUM=$P(RCDATA,U,15)
  . S RCGPECT=RCGPECT+1,RCPPECT=RCPPECT+1
  . S RCGPENM=RCGPENM+RCERANUM,RCPPENM=RCPPENM+RCERANUM
  ;
  ; If the EFT hasn't already been counted, add it to the totals
  S RCEFTIEN=$P(RCDATA,U,3)
  I (RCEFTIEN),('$D(^TMP("RCDPENR2",$J,"EFT",RCEFTIEN,J))) D
  . S ^TMP("RCDPENR2",$J,"EFT",RCEFTIEN,J)=""
  . S RCEFTPD=$P(RCDATA,U,18)
  . S RCGPFCT=RCGPFCT+1,RCPPFCT=RCPPFCT+1
  . S RCGPFPD=RCGPFPD+RCEFTPD,RCPPFPD=RCPPFPD+RCEFTPD
  ;
  ; Update payer specific info By Payment Method
  S $P(RCPPDATA,U)=RCPPCT
  S $P(RCPPDATA,U,2)=RCPPBILL
  S $P(RCPPDATA,U,3)=RCPPPD
  S $P(RCPPDATA,U,4)=RCPPBECT
  S $P(RCPPDATA,U,5)=RCPPBEDY
  S $P(RCPPDATA,U,6)=RCPPEECT
  S $P(RCPPDATA,U,7)=RCPPEEDY
  S $P(RCPPDATA,U,8)=RCPPEPCT
  S $P(RCPPDATA,U,9)=RCPPEPDY
  S $P(RCPPDATA,U,10)=RCPPBPCT
  S $P(RCPPDATA,U,11)=RCPPBPDY
  S $P(RCPPDATA,U,12)=RCPPECT
  S $P(RCPPDATA,U,13)=RCPPENM
  S $P(RCPPDATA,U,14)=RCPPFCT
  S $P(RCPPDATA,U,15)=RCPPFPD
  S ^TMP("RCDPENR2",$J,"PAYER",RCINSTIN,J,RCERATYP)=RCPPDATA
  ;
  ; Update Grand Total specific information By Payment Method
  S $P(RCGPDATA,U)=RCGPCT
  S $P(RCGPDATA,U,2)=RCGPBILL
  S $P(RCGPDATA,U,3)=RCGPPD
  S $P(RCGPDATA,U,4)=RCGPBECT
  S $P(RCGPDATA,U,5)=RCGPBEDY
  S $P(RCGPDATA,U,6)=RCGPEECT
  S $P(RCGPDATA,U,7)=RCGPEEDY
  S $P(RCGPDATA,U,8)=RCGPEPCT
  S $P(RCGPDATA,U,9)=RCGPEPDY
  S $P(RCGPDATA,U,10)=RCGPBPCT
  S $P(RCGPDATA,U,11)=RCGPBPDY
  S $P(RCGPDATA,U,12)=RCGPECT
  S $P(RCGPDATA,U,13)=RCGPENM
  S $P(RCGPDATA,U,14)=RCGPFCT
  S $P(RCGPDATA,U,15)=RCGPFPD
  S ^TMP("RCDPENR2",$J,"GTOT",J,RCERATYP)=RCGPDATA ; PRCA*4.5*349
 Q
 ;
 ;Retrieve all necessary info for EFTs sent during requested period.
 ; PRCA*4.5*349 - Add Closed Claims filter
GETEFT(RCSDATE,RCEDATE,RCRATE,RCCLM,RCPUZ,RCSORT) ;EP
 ;RCSDATE - Start date of extraction
 ;RCEDATE - End date of extraction
 ;RCPUZ   - (P)ayment EEOBs, (U)nmatched EEOBs, (Z)ero payment EEOBs, (A)ll
 ;RCSORT  - (P)ayer, (A)mount
 ;
 ;^TMP("RCDPENR2",$J,"MAIN",IEN of Claim/Bill #) =
 ; Where:
 ; Piece  Variable
 ; 1      RCBILL   - IEN: Bill/Claim #
 ; 2      RCERA    - IEN: ERA the bill was paid on.
 ; 3      RCIEN    - IEN: EFT the money for the bill arrived on
 ; 4      RCEOB    - IEN: EOB within the ERA 
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
 I RCPUZ="U" Q   ;PRCA*4.5*446 If user selected Unmatched, all entries will come from ERA search, not EFT
 ;
 N OKAY,RCLDATE,RCINS,RCIEN,RCEFTDT,RCERA,RCEFT,RCRCPT,RCPOSTED,RCPAYTYP,RCERADT,RCTRACE,RCERAIDX
 N RCTRLN,RCTRBD,RCERANUM,RCTIN,RCPAYER,RCINSTIN,RCLPIEN,RCDTDATA,RCEOB,RCBILL,RCDIV,RCDOS,RCAMTBL
 N RCDTBILL,RCMETHOD,RCPAPER,RCEFTTYP,RCEFTPD,RCKEEP,RCTRNTYP,RCDATA,RCAMTPD,RCEFTRCD,RCERARCD,RCRATETP
 N RCMSTAT,RCEFTST,RCESUMDT,RCPSUMDT,RCZERO,X,ZZPNAME ; PRCA*4.5*349 ;PRCA*4.5*446 add RCEFTST
 ;
 ;Get EFT Detail info for report batches sent within given date range.
 S RCLDATE=RCSDATE-.001,RCEDATE=RCEDATE+1
 F  S RCLDATE=$O(^RCY(344.31,"ADR",RCLDATE)) Q:RCLDATE=""  Q:RCLDATE>RCEDATE  D
 . S RCIEN=0
 . F  S RCIEN=$O(^RCY(344.31,"ADR",RCLDATE,RCIEN)) Q:'RCIEN  D
 . . S RCEFTDT=$G(^RCY(344.31,RCIEN,0))
 . . Q:RCEFTDT=""
 . . I '$$CHKEFT^RCDPEU1(RCIEN) Q  ; Only include posted EFTs - PRCA*4.5*349
 . . I RCPAY="A",RCTYPE'="A" D  Q:'OKAY  ; PRCA*4.5*326 If all payers included, check by type
 . . . S OKAY=$$ISTYPE^RCDPEU1(344.31,RCIEN,RCTYPE)
 . . ; Check Payer Name
 . . I RCPAY'="A" D  Q:'OKAY               ; PRCA*4.5*326 
 . . . S OKAY=$$ISSEL^RCDPEU1(344.31,RCIEN)
 . . ;
 . . S RCERA=$P(RCEFTDT,U,10)            ; ERA IEN
 . . S RCEFTRCD=$P(RCEFTDT,U,13)
 . . S RCEFT=$P(RCEFTDT,U)
 . . S ZZPNAME=$P(RCEFTDT,U,2)
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
 . . . S RCEFTST=$P(RCERADT,U,9)
 . . . S RCPAYER=$$GETARPYR^RCDPENR2(RCTIN,ZZPNAME) ; find the AR Payer IEN
 . . . ; Q:'RCPAYER                  ; Quit if Payer/TIN not found
 . . . ; Q:'$$INSCHK^RCDPENR2(RCPAYER)    ; Payer is not in the included list for the report
 . . . S RCINSTIN=RCINS_"/"_RCTIN
 . . . S RCLPIEN=0
 . . . F  S RCLPIEN=$O(^RCY(344.4,RCERA,1,RCLPIEN)) Q:'RCLPIEN  D
 . . . . ; I $$GET1^DIQ(344.41,RCLPIEN_","_RCERA_",",.25,"I")="" Q  ; PRCA*4.5*349 - No receipt, line is not posted
 . . . . S RCDTDATA=$G(^RCY(344.4,RCERA,1,RCLPIEN,0))
 . . . . S RCEOB=$P(RCDTDATA,U,2)
 . . . . S RCBILL=$$BILLIEN^RCDPENR1(RCEOB)
 . . . . Q:RCBILL=""   ; no billing information
 . . . . I RCCLM="C",'$$CLOSEDB(RCBILL) Q           ; Bill isn't closed - PRCA*4.5*349 added line
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
 . . . . ; PRCA*4.5*446 Add logic for to filter zero-pay based on RCPUZ
 . . . . S RCZERO=0 I RCPUZ="Z" S RCKEEP=0 S:RCEFTST=3 RCKEEP=1,RCZERO=1 Q:'RCKEEP    ;RCEFTST=3 -> Match-0 Payment
 . . . . I RCPUZ="Z" Q:'RCZERO
 . . . . I (RCPUZ="U")!(RCPUZ="P") Q:RCZERO
 . . . . ;
 . . . . S RCMETHOD=$S(RCZERO:"UNPOSTED",$$GET1^DIQ(344.41,RCLPIEN_","_RCERA_",",9,"I")="":"MANUAL",1:"AUTOPOST") ; PRCA*4.5*349, PRCA*4.5*446
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
 . . . . S ^TMP("RCDPENR2",$J,"MAIN",RCINSTIN,RCMETHOD,RCERAIDX,RCBILL_"/"_RCERA_"/"_RCAMTBL)=RCDATA ; PRCA*4.5*349 add post method, PRCA*4.5*446 add pieces to last subscript to make unique
 . . . . I RCSORT="A" S ^TMP("RCDPENR2",$J,"MAINAMT",RCMETHOD,RCAMTBL,RCBILL_"/"_RCERA)=RCDATA_U_RCERAIDX_U_RCBILL   ;PRCA*4.5*446
 . . I (RCMSTAT=2),(RCIEN),('$D(^TMP("RCDPENR2",$J,"EFT",RCIEN))) D
 . . . S RCTIN=$P(RCEFTDT,U,3)
 . . . S RCINS=$P(RCEFTDT,U,2)
 . . . S RCPAYER=$$GETARPYR^RCDPENR2(RCTIN,ZZPNAME) ; find the AR Payer IEN
 . . . ; Q:'RCPAYER                  ; Quit if Payer/TIN not found
 . . . ; Q:'$$INSCHK^RCDPENR2(RCPAYER)    ; Payer is not in the included list for the report
 . . . S RCINSTIN=RCINS_"/"_RCTIN
 . . . S RCMETHOD="MANUAL" ; PRCA*4.5*349 - Unmatched EFT must be manually posted
 . . . F X=RCMETHOD,"TOTAL" D  ; PRCA*4.5*349
 . . . . S RCESUMDT=$G(^TMP("RCDPENR2",$J,"GTOT",X,3))           ; PRCA*4.5*349
 . . . . S RCPSUMDT=$G(^TMP("RCDPENR2",$J,"PAYER",RCINSTIN,X,3)) ; PRCA*4.5*349
 . . . . S $P(RCESUMDT,U,14)=$P(RCESUMDT,U,14)+1
 . . . . S $P(RCPSUMDT,U,14)=$P(RCPSUMDT,U,14)+1
 . . . . S $P(RCESUMDT,U,15)=$P(RCESUMDT,U,15)+RCEFTPD
 . . . . S $P(RCPSUMDT,U,15)=$P(RCPSUMDT,U,15)+RCEFTPD
 . . . . S ^TMP("RCDPENR2",$J,"GTOT",X,3)=RCESUMDT               ; PRCA*4.5*349
 . . . . S ^TMP("RCDPENR2",$J,"PAYER",RCINSTIN,X,3)=RCPSUMDT     ; PRCA*4.5*349
 Q
 ;
CLOSEDB(RCBILL) ;EP
 ; PRCA*4.5*349 - Added subroutine
 ; Check to see if a bill is closed
 ; Input:   RCBILL      - IEN for 361.1 of the bill to be checked
 ; Returns: 1 - Bill is closed, 0 Otherwise
 N XX
 S XX=$$GET1^DIQ(430,RCBILL_",",8,"I")
 S XX=$$GET1^DIQ(430.3,XX_",",1)
 I XX="CC" Q 1
 Q 0
 ;
 ;Moved PRINTGT to ^RCDPENR5 because of routine size, PRCA*4.5*446
 ;Moved GDTXT to ^RCDPENR5 because of routine size, PRCA*4.5*446
 ;
