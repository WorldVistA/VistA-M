RCDPENR4 ;ALB/SAB - EPay National Reports - ERA/EFT Report Utilities ;12/14/15
 ;;4.5;Accounts Receivable;**304,321,326,349,446**;Mar 20, 1995;Build 15
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;Read ^DGCR(399) via Private IA 3820
 ;Read ^DG(40.8) via Controlled IA 417
 ;Read ^IBM(361.1) via Private IA 4051
 ;Use DIV^IBJDF2 via Private IA 3130
 Q
 ;
 ; Retrieve a single payer from the 
SPAY() ;
 ;
 N DIC,X,Y,DTOUT,DUOUT,DINUM,DLAYGO,NAME
 ;
 S DIC="^DIC(36,",DIC(0)="AEQMZ",DIC("S")="I '$G(^(5))"
 S DIC("?")="Enter the Payer name to run this report on."
 S DIC("A")="Select Payer: "
 D ^DIC K DIC
 ; timeout or user requested exit
 I $G(DUOUT)!$G(DTOUT) Q -1
 ;
 ;Return the name instead of the IEN
 Q $P(Y,U,2)
 ;
 ; - Return first/last day of month (if Y=0), previous month (if Y=1),
M1(X,Y) ;
 ;   first/last day of month in MMDDYYYY format (if Y=2), or date in
 ;   external format (if Y=3).
 N X1,X2 S:'$G(X)!(X'?7N.1".".6N) X=DT S:'$G(Y) Y=0
 S X2="31^"_$S($E(X,1,3)#4=0:29,1:28)_"^31^30^31^30^31^31^30^31^30^31"
 I 'Y S X=$E(X,1,5),X=X_"01"_U_X_$P(X2,U,+$E(X,4,5)) Q X
 I Y=1 S X=($E(X,1,5)_"00")-$S(+$E(X,4,5)=1:8900,1:100) Q X
 I Y=2 D  Q X
 .S X1=1700+$E(X,1,3),X=$E(X,4,5),X=X_"01"_X1_U_X_$P(X2,U,+X)_X1
 S Y=X X ^DD("DD") S X=Y
 Q X
 ;
 ; Retrieve the needed 835 information.
 ; PRCA*4.5*349 - Add Closed Claims filter
GETERA(RCSDATE,RCEDATE,RCRATE,RCCLM,RCPUZ,RCSORT) ;
 ;
 N OKAY,RCAMTBL,RCAMTPD,RCBDIV,RCBILL,RCDATA,RCDIV,RCDOS,RCDTBILL,RCDTLDT,RCEFTPD,RCEFTST,RCEFTTYP ; PRCA*4.5*349
 N RCEOB,RCERAIDX,RCERANUM,RCERARCD,RCIEN,RCINS,RCINSTIN,RCKEEP,RCLDATE,RCLIEN,RCMETHOD ; PRCA*4.5*349
 N RCPAPER,RCPAYER,RCPOSTED,RCPSTAT,RCRATETP,RCTIN,RCTRACE,RCTRBD,RCTRLN,RCTRNTYP ; PRCA*4.5*349
 ;
 S RCLDATE=RCSDATE-.001
 S RCEDATE=RCEDATE+1
 ;
 F  S RCLDATE=$O(^RCY(344.4,"AFD",RCLDATE)) Q:RCLDATE>RCEDATE  Q:RCLDATE=""  D
 . S RCIEN=""
 . F  S RCIEN=$O(^RCY(344.4,"AFD",RCLDATE,RCIEN)) Q:'RCIEN  D  Q
 .. S RCDATA=$G(^RCY(344.4,RCIEN,0))
 .. Q:RCDATA=""         ;No data defined in the transaction
 .. Q:'$P(RCDATA,U,10)  ;Transaction is an MRA
 .. ;
 .. ; Only calculate if status is NULL, Unmatched or Matched to Paper Check
 .. ; GETEFT will have grabbed there rest
 .. S RCEFTST=$P(RCDATA,U,9)
 .. I RCPUZ="P" I (RCEFTST=1)!(RCEFTST>2) Q
 .. S RCPSTAT=$$GET1^DIQ(344.4,RCIEN_",",.14,"I") ; PRCA*4.5*349
 .. I RCPUZ="P" I 'RCPSTAT!("/1/2/5/"'[("/"_RCPSTAT_"/")) Q  ; PRCA*4.5*349 - ERA is not posted, PRCA*4.5*446 only check if user picked Payment EEOB
 .. ;
 .. S RCERARCD=$P($P(RCDATA,U,7),".",1)  ;get the date of the ERA
 .. S RCTRACE=$P(RCDATA,U,2)             ;get the trace number
 .. S RCTRLN=$L(RCTRACE),RCTRBD=$S(RCTRLN<11:1,1:RCTRLN-9)
 .. S RCTRACE=$E(RCTRACE,RCTRBD,RCTRLN)  ;get the last 10 digits of Trace #
 .. S RCTIN=$P(RCDATA,U,3)               ;Payer TIN
 .. S RCINS=$P(RCDATA,U,6)               ;Insurance free text
 .. I RCPAY="A",RCTYPE'="A" D  Q:'OKAY  ; PRCA*4.5*326 If all payers included, check by type
 ... S OKAY=$$ISTYPE^RCDPEU1(344.4,RCIEN,RCTYPE)
 .. ;
 .. ; Check Payer Name
 .. I RCPAY'="A" D  Q:'OKAY               ; PRCA*4.5*326 
 ... S OKAY=$$ISSEL^RCDPEU1(344.4,RCIEN)
 .. S RCERANUM=$P(RCDATA,U,11)           ;# EOBs in ERA
 .. ;
 .. S RCLIEN=0
 .. F  S RCLIEN=$O(^RCY(344.4,RCIEN,1,RCLIEN)) Q:RCLIEN=""  D  Q
 ... S RCDTLDT=$G(^RCY(344.4,RCIEN,1,RCLIEN,0))   ;Get the ERA Detail
 ... Q:RCDTLDT=""             ;Quit if no ERA Detail
 ... ;
 ... S RCEOB=$P(RCDTLDT,U,2)  ;Get the EOB info
 ... Q:'RCEOB                 ;quit if no info
 ... ;
 ... ; Get the BILL/CLAIM IEN from the #399 file
 ... S RCBILL=$$BILLIEN^RCDPENR1(RCEOB)
 ... Q:RCBILL=""    ;EEOB corrupted, quit
 ... ;
 ... I RCCLM="C",'$$CLOSEDB^RCDPENR3(RCBILL) Q           ; Bill isn't closed PRCA*4.5*349 added line
 ... ;
 ... S RCDIV=$$DIV^IBJDF2(RCBILL)
 ... S RCDIV=$$GET1^DIQ(40.8,RCDIV_",",".01","E")
 ... ;
 ... S RCRATETP=$$GET1^DIQ(399,RCBILL_",",.07,"I")
 ... Q:RCRATETP'=RCRATE       ;Not requested Rate Type
 ... ;
 ... S RCDOS=$$GET1^DIQ(399,RCBILL_",",.03,"I")
 ... S RCAMTBL=$$GET1^DIQ(361.1,RCEOB_",",2.04,"I")
 ... S RCAMTPD=$$GET1^DIQ(361.1,RCEOB_",",1.01,"I")
 ... S RCDTBILL=$$GET1^DIQ(399,RCBILL_",",12,"I")
 ... Q:RCDTBILL=""   ;can't calculate if date first printed is NULL
 ... S RCMETHOD=$S($$GET1^DIQ(344.41,RCLIEN_","_RCIEN_",",9)="":"MANUAL",1:"AUTOPOST") ; PRCA*4.5*349
 ... I (RCEFTST=3) S RCMETHOD="UNPOSTED"                 ;PRCA*4.5*446 zero payment
 ... I (RCPSTAT="")!("/0/3/4/"[("/"_RCPSTAT_"/")) S RCMETHOD="UNPOSTED"    ;PRCA*4.5*446 Unmatched
 ... S RCPAPER=$P($G(^RCY(344.4,RCLIEN,20)),U,3)         ; Paper EOB ERA?
 ... ;ERA not a paper ERA, is the EOB a Paper EOB
 ... S RCERAIDX=""                                       ; PRCA*4.5*446 Initialize RCERAIDX
 ... I RCEFTST=3 S RCERAIDX=5,RCTRNTYP="ERA/EFT"         ; PRCA*4.5*446 ZERO PAYMENTS
 ... I 'RCEFTST S RCERAIDX=4,RCTRNTYP="ERA/EFT"          ; PRCA*4.5*446 UNMATCHED ERA, status is null or 0  ***** THIS IS WRONG
 ... I 'RCERAIDX D                                       ; PRCA*4.5*446 if not ZERO PAYMENTS or UNMATCHED ERA
 .... S:'RCPAPER RCPAPER=$S($$GET1^DIQ(361.1,RCEOB_",",.17,"I")=0:"ERA",1:"PAPER")
 .... S RCEFTTYP=$S(RCEFTST=2:"PAPER",1:"EFT")
 .... S RCTRNTYP=RCPAPER_"/"_RCEFTTYP
 .... S RCERAIDX=$S(RCTRNTYP="ERA/EFT":1,RCTRNTYP="ERA/PAPER":2,RCTRNTYP="PAPER/EFT":3,1:6)
 ... Q:RCERAIDX=6   ;Paper Check Paper EOB not supported
 ... ;
 ... S RCPOSTED=$P($G(^RCY(344.4,RCIEN,7)),U)
 ... S RCINSTIN=RCINS_"/"_RCTIN
 ... ;
 ... ; PRCA*4.5*446 Add logic for filter: PAYMENT EEOBS, UNMATCHED EEOBS, ZERO PAYMENT EEOBS, ALL
 ... S RCKEEP=0 D  Q:'RCKEEP
 .... I RCPUZ="A" S RCKEEP=1 Q   ; If user selected ALL EEOBs, keep everything
 .... I RCPUZ="U" S:((RCEFTST="")!(RCEFTST=0)) RCKEEP=1 Q
 .... I RCPUZ="Z" S:RCEFTST=3 RCKEEP=1 Q
 .... S RCKEEP=1 ; If not unmatched and not zero pay, it's a payment EEOB and RCPUZ must be P
 .... ; PRCA*4.5*446 End filter logic
 ... ;
 ... ;PRCA*4.5*446 Zero payment or Unmatched, EFT field is N/A
 ... N RCEFTFLD S RCEFTFLD="" I (RCPSTAT="")!(RCPSTAT=0)!(RCEFTST=3) S RCEFTFLD="N/A"
 ... ;
 ... S RCDATA=RCBILL_U_RCIEN_U_RCEFTFLD_U_RCEOB_U_RCDOS_U_RCAMTBL_U_RCAMTPD_U_RCDTBILL_U_RCERARCD
 ... S RCDATA=RCDATA_U_U_RCPOSTED_U_RCTRACE_U_RCMETHOD_U
 ... S RCDATA=RCDATA_RCTRNTYP_U_RCERANUM_U_RCDIV_U_RCINSTIN_U
 ... S ^TMP("RCDPENR2",$J,"MAIN",RCINSTIN,RCMETHOD,RCERAIDX,RCBILL_"/"_RCIEN_"/"_RCAMTBL)=RCDATA   ;PRCA*4.5*446 add pieces to last subscript to make unique
 ... I RCSORT="A" S ^TMP("RCDPENR2",$J,"MAINAMT",RCMETHOD,RCAMTBL,RCBILL_"/"_RCIEN)=RCDATA_U_RCERAIDX_U_RCBILL  ;PRCA*4.5*446
 ;
 ; Compile the list of payers using the payer TIN.  The Payer IENS are extracted
TINARY(RCSTART,RCEND) ;
 ;
 ;RCSTART - The text to start the search for insurance companies
 ;RCEND - The text to end the search for insurance companies,
 ;
 N RCI,RCJ,RCFILE
 ;
 ; Clear old data out
 K ^TMP("RCDPEADP",$J,"TIN")
 ;
 ; If start and end are NULL, then User wishes all payers, set flag and quit
 I (RCSTART=""),(RCEND="") S ^TMP("RCDPEADP",$J,"TIN","A")="" Q
 ;
 ; If single payer, find the IEN if it exists and post it.
 I RCSTART=RCEND D  Q
 . S RCJ=""
 . F  S RCJ=$O(^RCY(344.6,"C",RCSTART,RCJ)) Q:RCJ=""  D
 . . S ^TMP("RCDPEADP",$J,"TIN",RCJ)=""
 ;
 ; For a range of payers, loop through the Payer name list until 
 ; you reach the last payer in the range (RCEND)
 ;
 S RCI=$O(^RCY(344.6,"C",RCSTART),-1)    ; Set the starting location for the loop
 ; Loop through the index to find the correct entries.  Append a space
 F  S RCI=$O(^RCY(344.6,"C",RCI)) Q:RCI=""  Q:RCI]RCEND  D
 . S RCJ=""
 . F  S RCJ=$O(^RCY(344.6,"C",RCI,RCJ)) Q:RCJ=""  D
 . . S ^TMP("RCDPEADP",$J,"TIN",RCJ)=""
 ;
 Q
 ;
 ;Look at both Payer and Payer Tin lists and find insurance companies on both lists to report on.
INTRSCT() ;
 ;
 N RCLPIEN,RCPYRFLG
 ;
 ; If ALL payers was selected for both the Payer Name and Payer TIN parameters, set the all flag and quit.
 I $D(^TMP("RCDPEADP",$J,"TIN","A"))&$D(^TMP("RCDPEADP",$J,"INS","A")) S ^TMP("RCDPENR2",$J,"INS","A")="" Q 1
 ;
 ; If All payers was elected for Payer Name and Payer TIN had entries
 ; Loop through the Payer TIN array and update valid report array and quit
 I $D(^TMP("RCDPEADP",$J,"INS","A")) D  Q 1
 . M ^TMP("RCDPENR2",$J,"INS")=^TMP("RCDPEADP",$J,"TIN")
 . K ^TMP("RCDPEADP",$J,"INS","A")  ;remove the all flag from the list
 ;
 ; If All payers was elected for Payer TIN and Payer NAME had entries
 ; Loop through the Payer TIN array and update valid report array and quit
 I $D(^TMP("RCDPEADP",$J,"TIN","A")) D  Q 1
 . M ^TMP("RCDPENR2",$J,"INS")=^TMP("RCDPEADP",$J,"INS")
 . K ^TMP("RCDPENR2",$J,"TIN","A")  ;remove the all flag from the list
 ;
 ; A range of payers (1 or more) were selected for both Payer lists (Name and TIN)
 ; Loop through the TIN array and see if the Payer Name IEN is in the TIN array.
 ; If so, update the valid report array and quit.
 S RCPYRFLG=0,RCLPIEN=""
 F  S RCLPIEN=$O(^TMP("RCDPEADP",$J,"TIN",RCLPIEN)) Q:'RCLPIEN  D
 . I $D(^TMP("RCDPEADP",$J,"INS",RCLPIEN)) D
 . . S ^TMP("RCDPENR2",$J,"INS",RCLPIEN)=""
 . . S:'RCPYRFLG RCPYRFLG=1
 ;
 ; No payers found
 Q RCPYRFLG
 ;
 ;Print the data requested (Volume Statistics Report)
PRINTRP(RCTITLE,RCDATA,RCRPIEN,RCDISP,RCTFLG) ;
 ;
 ;Expected "^" delimeted format of RCDATA is:
 ; Piece 1 - # 837s
 ; Piece 2 - # NCPDPs
 ; Piece 3 - # 835s
 ; Piece 4 - # 837s with 835s
 ; Piece 5 - # NCPDPs with 835s
 ; Piece 6 - Avg days from 837 send to 835 receipt
 ; Piece 7 - Avg days from NCPDP send to 835 receipt
 ;
 ; Undeclared parameters RCLINE (line of "-" characters) RCSTOP (user requested stop flag)
 ;
 N RC835,RCNCPDP,RC837,RCNO837,RCNNCPDP,RCANCPDP,RCAVG837,RCSPACE,RCSTR,RCFLG
 ;
 I $Y>(IOSL-12),RCDISP D  Q:RCSTOP RCFLG
 . D ASK^RCDPEADP(.RCSTOP,0)
 . I RCSTOP S RCFLG=-1 Q
 . D HEADER^RCDPENR1
 ;
 S RCDISP=$G(RCDISP),RCTFLG=$G(RCTFLG)
 I RCDISP,RCTFLG D
 . W !,RCTITLE,!!
 . W RCLINE,!
 ;
 S RCSPACE=""
 S $P(RCSPACE," ",80)=""
 ;
 I RCDISP D  Q 1
 . W "NUMBER OF 837s TRANSMITTED TO MEDICAL PAYERS",?65,$J(+$P(RCDATA,U),10)
 . W !,"NUMBER OF NCPDP CLAIMS TRANSMITTED TO PHARMACY PBMs",?65,$J(+$P(RCDATA,U,2),10)
 . W !,"NUMBER OF 835s RECEIVED FROM MEDICAL PAYERS",?65,$J(+$P(RCDATA,U,3),10)
 . W !,"NUMBER OF 835s RECEIVED FROM PHARMACY PBMS",?65,$J(+$P(RCDATA,U,4),10)
 . W !,"NUMBER OF 837s WITH A CORRESPONDING 835 (MRA Excluded)",?65,$J(+$P(RCDATA,U,5),10)
 . W !,"NUMBER OF NCPDP CLAIM WITH A CORRESPONDING 835",?65,$J(+$P(RCDATA,U,6),10)
 . W !,"AVG #DAYS BETWEEN 837 TRANSMIT AND 835 RECEIVED",?65,$J(+$P(RCDATA,U,7),10,1)
 . W !,"AVG #DAYS BETWEEN NCPDP CLAIM TRANSMIT AND 835 RCVD",?65,$J(+$P(RCDATA,U,8),10,1)
 . W !,RCLINE,!
 I 'RCDISP D
 . S RCSTR="NUMBER OF 837s TRANSMITTED TO MEDICAL PAYERS^"_+$P(RCDATA,U)
 . D SAVEDATA^RCDPENR1(RCSTR,RCRPIEN)
 . S RCSTR="NUMBER OF NCPDP CLAIMS TRANSMITTED TO PHARMACY PBMs^"_+$P(RCDATA,U,2)
 . D SAVEDATA^RCDPENR1(RCSTR,RCRPIEN)
 . S RCSTR="NUMBER OF 835s RECEIVED FROM MEDICAL PAYERS^"_+$P(RCDATA,U,3)
 . D SAVEDATA^RCDPENR1(RCSTR,RCRPIEN)
 . S RCSTR="NUMBER OF 835s RECEIVED FROM PHARMACY PBMS^"_+$P(RCDATA,U,4)
 . D SAVEDATA^RCDPENR1(RCSTR,RCRPIEN)
 . S RCSTR="NUMBER OF 837s WITH A CORRESPONDING 835 (MRA Excluded)^"_+$P(RCDATA,U,5)
 . D SAVEDATA^RCDPENR1(RCSTR,RCRPIEN)
 . S RCSTR="NUMBER OF NCPDP CLAIM WITH A CORRESPONDING 835^"_+$P(RCDATA,U,6)
 . D SAVEDATA^RCDPENR1(RCSTR,RCRPIEN)
 . S RCSTR="AVG #DAYS BETWEEN 837 TRANSMIT AND 835 RECEIVED^"_+$P(RCDATA,U,7)
 . D SAVEDATA^RCDPENR1(RCSTR,RCRPIEN)
 . S RCSTR="AVG #DAYS BETWEEN NCPDP CLAIM TRANSMIT AND 835 RCVD^"_+$P(RCDATA,U,8)
 . D SAVEDATA^RCDPENR1(RCSTR,RCRPIEN)
 Q 1
 ;
PAYSUM(RCINSTIN,RCPUZ) ;Print the Payer Summary portion of the report for one payer. New for ; PRCA*4.5*349
 ; Input: RCINSTIN - Payer Name/TIN combination, key to ^TMP global.
 ;           RCPUZ - P: Payment EEOBs, U: Unmatched EEOBs, Z: Zero Payment EEOBs, A: All       ;PRCA*4.5*446
 ;
 N I,I1,I2,I3,J,RCDATA,RCEFT,RCEFTTXT,RCERA,RCERAFLG,RCERATYP,RCERATXT,RCSTRING ; PRCA*4.5*349, PRCA*4.5*446 I1,I2,I3
 ;
 ; Print ERA/EFT combinations for each Insurance Company/Tin combination
 S RCINSTIN="",RCSTOP=0
 F  S RCINSTIN=$O(^TMP("RCDPENR2",$J,"PAYER",RCINSTIN)) Q:RCINSTIN=""  D  Q:RCSTOP
 . I $Y>(IOSL-7) D ASK^RCDPEADP(.RCSTOP,0) Q:RCSTOP  D HEADER^RCDPENR2
 . D PRINTINS^RCDPENR2(RCINSTIN)
 . ; Print autoposted and manual for all 3 combinations
 . ; PRCA*4.5*446, add I1,I2,I3
 . S I1=1,I2=1,I3=5   ; default for RCPUZ="A", ALL
 . I RCPUZ="U" S I1=4,I3=4         ;Unposted contains Zero Pay and Unmatched
 . I RCPUZ="Z" S I1=5,I3=5         ;Unposted contains Zero Pay and Unmatched
 . I RCPUZ="P" S I3=3              ;Don't include Unposted
 . ;
 . F J="AUTOPOST","MANUAL","UNPOSTED","TOTAL" Q:RCSTOP  F I=I1:I2:I3 D  Q:RCSTOP  ; PRCA*4.5*349, PRCA*4.5*446 Add I1,I2,I3
 . . ;
 . . ; PRCA*4.5*446 filter for RCPUZ
 . . I (RCPUZ="U")!(RCPUZ="Z") I (J="AUTOPOST")!(J="MANUAL") Q
 . . I (RCPUZ="U")!(RCPUZ="Z") I J="TOTAL" Q   ; For Unmatched and Zero Pay, there are not 2 categories to total together like Autopost+Manual
 . . I RCPUZ="P" I J="UNPOSTED" Q
 . . ;
 . . I J="AUTOPOST",I>1 Q  ; Only EFT/ERA can be auto-posted - PRCA*4.5*349
 . . I J="MANUAL",I>3 Q    ; Unmatched and Zero pay are Unposted
 . . I J="UNPOSTED",I<4 Q  ; Unmatched and Zero pay are Unposted
 . . I '("/Z/U/"[("/"_RCPUZ_"/")) I (RCAUTO="A"&(J="MANUAL"))!(RCAUTO="N"&(J="AUTOPOST"))!(RCAUTO'="B"&(J="TOTAL")) Q  ; PRCA*4.5*349, PRCA*4.5*446 check RCPUZ
 . . S RCDATA=$G(^TMP("RCDPENR2",$J,"PAYER",RCINSTIN,J,I))
 . . S RCERATYP=$S(I=1:"EFT/ERA",I=2:"PAPER CHECK/ERA",I=3:"EFT/PAPER EOB",I=4:"/UNMATCHED ERA",1:"/ZERO PAYMENTS")  ; PRCA*4.5*446
 . . S RCERAFLG=0
 . . S RCEFTTXT=$P(RCERATYP,"/")
 . . S RCERATXT=$P(RCERATYP,"/",2)
 . . S RCEFT=$S(RCEFTTXT="EFT":"AN EFT",RCEFTTXT="PAPER CHECK":"A PAPER CHECK",1:"")  ; PRCA*4.5*446
 . . I '((I=4)!(I=5)) S RCSTRING=RCERATXT_" MATCHED TO "_RCEFT_" - "_J ; PRCA*4.5*349, PRCA*4.5**446 If not unmatched or zero pay
 . . I ((I=4)!(I=5)) S RCSTRING=RCERATXT   ; PRCA*4.5**446 If not unmatched or zero pay
 . . I (RCEFTTXT="EFT"),(RCERATXT["ERA") S RCERAFLG=1
 . . I (I=4)!(I=5) S RCERAFLG=1   ; PRCA*4.5*446 If unmatched or zero pay, then set ERA flag
 . . D PRINTGT^RCDPENR5(RCSTRING,RCDATA,RCDISP,RCERAFLG,RCEXCEL,RCPUZ)  ; PRCA*4.5**446
 ;
 Q RCSTOP
 ;
DIV(RCDIV) ; build the list of divisions to report on.
 ; PRCA*4.5*349 - Moved from RCDPENR2 for size
 ;
 N RCI
 ;
 ; If all divisions selected, set the all division flag
 I $D(RCDIV("A")) S ^TMP("RCDPENR2",$J,"DIVALL")="" Q
 ;
 ; Loop through division list and build temp array for it.
 S RCI=0
 F  S RCI=$O(RCDIV(RCI)) Q:'RCI  S ^TMP("RCDPENR2",$J,"DIV",RCDIV(RCI))=""
 Q
 ;
GETDIV(RCDIV) ; Retrieve the Division
 ; PRCA*4.5*349 - Moved from RCDPENR2 for size
 ;
 ; The use of DIVISION^VAUTOMA Supported by IA 1077
 ;
 N VAUTD
 D DIVISION^VAUTOMA
 I VAUTD=1 S RCDIV("A")="" Q 1
 I 'VAUTD&($D(VAUTD)'=11) Q -1
 M RCDIV=VAUTD
 Q 1
 ;
ASKPUZ() ; EP from RCDPENR2 - added for PRCA*4.5*446
 ; Input:   N/A
 ; Returns: -1      - User ^ or timed out
 ;           P      - Include Payment EEOBs only
 ;           U      - Include Unmatched EEOBs only
 ;           Z      - Include Zero payment EEOBs only
 ;           A      - Include All types
 ;
 N DA,DIR,DTOUT,DUOUT,X,Y,DIRUT,DIROUT,RCTYPE,RETURN
 S RCTYPE=""
 S DIR("?",1)="Enter 'P' to include only Payment EEOBs"
 S DIR("?",2)="      'U' to include only Unmatched EEOBs"
 S DIR("?",3)="      'Z' to include only Zero payment EEOBs"
 S DIR("?")="      'A' to include all: Payment, Unmatched, Zero payment EEOBs"
 S DIR(0)="SA^P:PAYMENT EEOBs;U:UNMATCHED EEOBs;Z:ZERO PAYMENT EEOBs;A:ALL"
 S DIR("A")="(P)AYMENT EEOBs, (U)NMATCHED EEOBs, (Z)ERO PAYMENT EEOBs or (A)LL: "
 S DIR("B")=$S($G(DEF)'="":DEF,1:"ALL")
 D ^DIR
 K DIR
 I $D(DTOUT)!$D(DUOUT) Q -1
 Q:Y="" "A"
 S RETURN=$E(Y)
 Q RETURN
 ;
ASKSORT() ; EP from RCDPENR2 - added for PRCA*4.5*446
 ; Input:   N/A
 ; Returns: -1      - User ^ or timed out
 ;           P      - Sort by Payer
 ;           A      - Sort by Amount of payment
 ;
 N DA,DIR,DTOUT,DUOUT,X,Y,DIRUT,DIROUT,RCTYPE,RETURN
 S RCTYPE=""
 S DIR("?",1)="Enter 'P' to sort by Payer"
 S DIR("?")="      'A' to sort by Amount of payment"
 S DIR(0)="SA^P:PAYER;A:AMOUNT OF PAYMENT"
 S DIR("A")="SORT BY (P)AYER or (A)MOUNT OF PAYMENT: "
 S DIR("B")=$S($G(DEF)'="":DEF,1:"PAYER")
 D ^DIR
 K DIR
 I $D(DTOUT)!$D(DUOUT) Q -1
 Q:Y="" "P"
 S RETURN=$E(Y)
 Q RETURN
 ;
GETSDATE()  ;
 ; PRCA*4.5*446 - Moved from RCDPENR2 for size
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT,RCTODAY
 ;
 ;Assume the start date is 45 days prior to the end date
 ;
 ;Get the start date.  
 S RCTODAY=$P($$NOW^XLFDT,".")
 S DIR("?")="ENTER THE EARLIEST DATE TO INCLUDE ON THE REPORT"
 S DIR(0)="DA^:"_RCTODAY_":APE",DIR("A")="Start with DATE: "
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q -1
 Q Y
 ;
 ; Retrieve the end date of the report from the user.
GETEDATE(RCBDATE)  ;
 ; PRCA*4.5*446 - Moved from RCDPENR2 for size
 ; RCBDATE - Begin date of the report.  Used as a lower bound
 ;
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT,RCTODAY
 ;
 ; Get the End date first.  Assume the end date is today.
 S RCTODAY=$P($$NOW^XLFDT,".")
 S DIR("?")="ENTER THE LATEST DATE TO INCLUDE ON THE REPORT"
 S DIR("B")=$$FMTE^XLFDT(RCTODAY,2)
 S DIR(0)="DAO^"_$G(RCBDATE)_":"_RCTODAY_":APE",DIR("A")="Go to DATE: " D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q -1
 Q Y
 ;
 ;Retrieve the Report Type
GETRATE() ;
 ; PRCA*4.5*446 - Moved from RCDPENR2 for size
 ;
 ;RCMNFLG - Ask to print the Main report (Detailed) report.  0=No, 1=Yes
 N X,Y,DIC,DTOUT,DUOUT
 ;
 S DIC="^DGCR(399.3,",DIC(0)="AEQMN"
 S DIC("S")="I $P(^(0),U,7)=""i"""
 D ^DIC K DIC
 Q +Y
 ;
