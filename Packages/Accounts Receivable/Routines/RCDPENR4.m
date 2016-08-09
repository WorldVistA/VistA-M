RCDPENR4 ;ALB/SAB - EPay National Reports - ERA/EFT Report Utilities ;12/14/15
 ;;4.5;Accounts Receivable;**304**;Mar 20, 1995;Build 104
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
GETERA(RCSDATE,RCEDATE,RCRATE) ;
 ;
 N RCLDATE,RCBDIV,RCIEN,RCDATA,RCLIEN,RCDTLDT,RCEOB,RCBILL,RCTRACE
 N RCEFTST,RCDOS,RCAMTBL,RCAMTPD,RCDTBILL,RCTIN,RCINS,RCERARCD,RCINS
 N RCPAPER,RCMETHOD,RCEFTTYP,RCTRNTYP,RCINSTIN,RCERAIDX,RCEFTST
 N RCEFTPD,RCDIV,RCERANUM,RCRATETP,RCPAYER,RCTRLN,RCTRBD,RCPOSTED
 ;
 S RCLDATE=RCSDATE-.001
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
 .. I (RCEFTST=1)!(RCEFTST>2) Q
 .. ;
 .. S RCERARCD=$P($P(RCDATA,U,7),".",1)  ;get the date of the ERA
 .. S RCTRACE=$P(RCDATA,U,2)             ;get the trace number
 .. S RCTRLN=$L(RCTRACE),RCTRBD=$S(RCTRLN<11:1,1:RCTRLN-9)
 .. S RCTRACE=$E(RCTRACE,RCTRBD,RCTRLN)  ; get the last 10 digits of Trace #
 .. S RCTIN=$P(RCDATA,U,3)               ;Payer TIN
 .. S RCINS=$P(RCDATA,U,6)               ;Insurance IEN
 .. S RCPAYER=$$GETARPYR^RCDPENR2(RCTIN) ; find the AR Payer IEN
 .. Q:'RCPAYER                           ; Quit if Payer/TIN not found
 .. Q:'$$INSCHK^RCDPENR2(RCPAYER)        ; Payer is not in the included list for the report
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
 ... Q:RCDTBILL=""   ;cant calculate if date first printed is NULL
 ... S RCMETHOD=$S($P($G(^RCY(344.4,RCIEN,1,RCLIEN,4)),U)="":"MANUAL",1:"AUTOPOST")
 ... S RCPAPER=$P($G(^RCY(344.4,RCLIEN,20)),U,3)  ; Paper EOB ERA?
 ... ;ERA not a paper ERA, is the EOB a Paper EOB
 ... S:'RCPAPER RCPAPER=$S($$GET1^DIQ(361.1,RCEOB_",",.17,"I")=0:"ERA",1:"PAPER")
 ... S RCEFTTYP=$S(RCEFTST=2:"PAPER",1:"EFT")
 ... S RCTRNTYP=RCPAPER_"/"_RCEFTTYP
 ... S RCERAIDX=$S(RCTRNTYP="ERA/EFT":1,RCTRNTYP="ERA/PAPER":2,RCTRNTYP="PAPER/EFT":3,1:4)
 ... Q:RCERAIDX=4   ;Paper Check Paper EOB not supported
 ... ;
 ... S RCPOSTED=$P($G(^RCY(344.4,RCIEN,7)),U)
 ... S RCINSTIN=RCINS_"/"_RCTIN
 ... ;
 ... S RCDATA=RCBILL_U_RCIEN_U_U_RCEOB_U_RCDOS_U_RCAMTBL_U_RCAMTPD_U_RCDTBILL_U_RCERARCD
 ... S RCDATA=RCDATA_U_U_RCPOSTED_U_RCTRACE_U_RCMETHOD_U
 ... S RCDATA=RCDATA_RCTRNTYP_U_RCERANUM_U_RCDIV_U_RCINSTIN_U
 ... S ^TMP("RCDPENR2",$J,"MAIN",RCINSTIN,RCERAIDX,RCBILL)=RCDATA
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
