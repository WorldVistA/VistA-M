RCDPRU ;ALB/TJB - CARC REPORT ON PAYER OR CARC CODE ;9/15/14 3:00pm
 ;;4.5;Accounts Receivable;**303**;Mar 20, 1995;Build 84
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ; PRCA*4.5*303 - CARC and Payer report utilities
 ; IA 594 - ACCOUNTS RECEIVABLE CATEGORY file (#430.2)
 ; IA 1077 - Using DIVISION^VAUTOMA to query for division
 ; IA 1992 - BILL/CLAIMS file (#399)
 ; IA 3820 - BILL/CLAIMS file (#399)
 ; IA 3822 - RATE TYPE file (#399.3)
 ; IA 4051 - EXPLANATION OF BENEFITS file (#361.1)
 ; IA 4996 - BILL/CLAIMS file (#399)
 ;
DISPTY() ; function, ask display/output type
         ; processes input from user
         ; returns: Output destination (0=Display, 1=MS Excel, -1=timeout or '^)
 N DIR,DUOUT,DIRUT,X,Y
 S DIR(0)="YA",DIR("A")="Export the report to Microsoft Excel? (Y/N): ",DIR("B")="NO"
 D ^DIR
 I $D(DUOUT)!$D(DIRUT) S Y=-1
 Q Y
 ;
INFO ; Useful Info for Excel capture
 N SP S SP=$J(" ",10)  ; spaces
 W !!!,SP_"Before continuing, please set up your terminal to capture the"
 W !,SP_"report data as this report may take a while to run."
 W !!,SP_"To avoid undesired wrapping of the data saved to the"
 W !,SP_"file, please enter '0;256;999' at the 'DEVICE:' prompt."
 W !!,SP_"It may be necessary to set the terminal's display width"
 W !,SP_"to 256 characters, which can be performed by selecting the"
 W !,SP_"Display option located within the 'Setup' menu on the"
 W !,SP_"tool bar of the terminal emulation software (e.g. KEA,"
 W !,SP_"Reflection, or Smarterm).",!!
 Q
 ;
ASK(RCSTOP) ; User if you want to quit or continue
 S RCSTOP=0
 I $E(IOST,1,2)'["C-" Q
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="E" W ! D ^DIR
 I ($D(DIRUT))!($D(DUOUT)) S RCSTOP=1 Q
 Q
 ;
UP(TEXT) ; Translate text to upper case
 Q $$UP^XLFSTR($G(TEXT))
 ;
DATE(X,F) ; date in external format
 I $G(F)="" S F="2Z" ; set date to return mm/dd/yy 
 Q $$FMTE^XLFDT(X,F)
 ;
NOW(F) ; Date/Time of right now in external format
 S:$G(F)="" F=1 ; Date format Mon dd, yyyy@hh:mm:ss see kernel documentation
 Q $$FMTE^XLFDT($$NOW^XLFDT,F)
 ;
VAL(XF,CODE) ; Validate a range or list of CARC (345), RARC (346) or PLB (345.1) Codes
 ; If invalid code is found VAILD = 0 and CODE will contain the offending codes
 N VALID,ELEM,I,RNG1,RNG2,O1,O2,NWCD,RET S RET=""
 S VALID=1,NWCD=$TR(CODE,";",":"),NWCD=$TR(NWCD,"-",":") ; Fix ";" or "-" to ":" (colons) for parsing
 F I=1:1 S ELEM=$P(NWCD,",",I) Q:ELEM=""  D
 .; Is this a single code or range:
 .I $L(ELEM,":")>2 S VALID=0,RET=$$PUSH(.RET,ELEM) Q
 .I ELEM[":" D  Q  ; Range
 ..S RNG1=$P(ELEM,":",1),RNG2=$P(ELEM,":",2)
 ..;Lookup the codes
 ..S O1=$O(^RC(XF,"B",RNG1),-1),O1=$O(^RC(XF,"B",O1))
 ..S O2=$O(^RC(XF,"B",RNG2),-1),O2=$O(^RC(XF,"B",O2))
 ..I RNG1'=O1 S VALID=0,RET=$$PUSH(.RET,RNG1)
 ..I RNG2'=O2 S VALID=0,RET=$$PUSH(.RET,RNG2)
 .E  D
 ..;Validate individual items
 ..S O1=$O(^RC(XF,"B",ELEM),-1),O1=$O(^RC(XF,"B",O1))
 ..I ELEM'=O1 S VALID=0,RET=$$PUSH(.RET,ELEM)
 ;
 S:VALID CODE=NWCD
 S:'VALID CODE=RET
 Q VALID
 ;
ACT(XF,CODE,DATE) ; Is the code active on Date
 ; If code is active return 1. If no date use today, date should be in fileman format.
 N VALID,XIEN,XDT S VALID=0
 I '$D(XF) Q VALID  ; No file return 0
 I $G(CODE)="" Q VALID  ; No code return 0
 S:'$D(DATE) DATE=$$DT^XLFDT
 S XIEN=$$FIND1^DIC(XF,,"O",CODE)
 I XIEN="" Q VALID  ; No IEN for this code return 0
 S XDT=$$GET1^DIQ(XF,XIEN_",",2,"I") ; Get date in FM format
 S:XDT="" VALID=1 ; No stop date so it is active
 I (XDT'="")&(XDT>DATE) S VALID=1
 Q VALID
 ;
PUSH(VAR,VALUE) ;
 Q:VAR="" VALUE ; Empty variable
 Q VAR_U_VALUE
 ;
 ; Collect data in a list or range to an array, ARRAY passed by reference
RNG(TYPE,ITEM,ARRAY) ;
 ; Take everything for this TYPE if item is all and quit out
 I $G(ITEM)="ALL"!($G(ITEM)="A") S ARRAY(TYPE)="ALL" Q
 N X1,X2,NW,I,ELEM
 S NW=$TR(ITEM,";",":"),NW=$TR(NW,"-",":") ; Fix ";" or "-" to ":" (colons) for parsing
 F I=1:1 S ELEM=$P(NW,",",I) Q:ELEM=""  D
 . ; Single element set into array 
 . I ELEM'[":" S ARRAY(TYPE,ELEM)=1
 . E  D RNGIT(TYPE,ELEM,.ARRAY)
 Q
 ; Process ranges for CARC/PLB/PAYER/TIN
 ; ZAR passed by reference
RNGIT(TYPE,ITEM,ZAR) ;
 N X1,X2,ELEM,O1,ZGBL,IDX,FILE
 ; Set file # and index for the range lookup
 S FILE=$S(TYPE="CARC":345,TYPE="PAYER":344.6,TYPE="TIN":344.6,TYPE="PLB":345.1,1:0)
 S IDX=$S(TYPE="CARC":"B",TYPE="PAYER":"B",TYPE="TIN":"C",TYPE="PLB":"B",1:0)
 ; Get closed root of the Global
 S ZGBL=$$ROOT^DILFD(FILE,"",1,"")
 I ZGBL="" Q
 ; Process range of things in ITEM
 S X1=$P(ITEM,":",1),X2=$P(ITEM,":",2)
 S O1=$O(@ZGBL@(IDX,X1),-1) ; Set the start
 F  S O1=$O(@ZGBL@(IDX,O1)) Q:(O1="")!($$AFTER(O1,X2))  S ZAR(TYPE,O1)=1
 Q
 ;
AFTER(ZZ1,ZZ2) ; Is ZZ1 after (or collates after) ZZ2
 N XZ1,XZ2
 S XZ1=+ZZ1,XZ2=+ZZ2
 I (XZ1'=0)&(XZ2'=0) Q (XZ1>XZ2)  ; Numeric
 I (XZ1=0)&(XZ2'=0) Q 1  ; XZ1 not numeric, XZ2 numeric, XZ1 is after XZ2
 I (XZ1=0)&(XZ2=0) Q (ZZ1]ZZ2)  ; Both not numeric see if XZ1 collates after XZ2
 Q 1 ; Default to after 
 ;
GLIST(FILE,IDX,GLARR) ;Build list for this file
 ; Build list of available payers
 N CNT,RCPAY S CNT=0,RCPAY=""
 F  S RCPAY=$O(^RCY(FILE,IDX,RCPAY)) Q:RCPAY=""  D
 .S CNT=CNT+1
 .S @GLARR@(CNT)=RCPAY
 .S @GLARR@(IDX,RCPAY,CNT)=""
 ;
 Q
 ; Pass RCPAY by reference
GETPAY(RCPAY) ; Get payer information
 N EX,RCLPAY S EX=1 ; Exit status
 S DIR("A")="Select (A)ll or (R)ange of 835 Payer Names?: ",DIR(0)="SA^A:All Payer Names;R:Range or List of Payer Names"
 S DIR("B")="ALL" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S EX=0 Q EX
 S RCLPAY=Y I $G(Y)="A" S RCPAY="ALL",RCPAY("DATA")="ALL" G GPO
 ; Get Range of 835 Payers
 ;I RCLPAY="R" D GLIST(344.6,"B",$NA(^TMP("RCDPARC_P",$J))),GETPAYR("RCPAY",$NA(^TMP("RCDPARC_P",$J))) S EX=RTNFLG
 I RCLPAY="R" S EX=$$GETRNG(.RCPAY,"P"),RCPAY="R"
GPO ;
 Q EX
 ;
 ; Pass RCTIN by reference
GETTIN(RCTIN) ; Get Payer TIN information
 N EX,RCTLIST,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y S EX=1 ; Exit status
 S DIR("A")="Select (A)ll or (R)ange of 835 Payer TINs?: ",DIR(0)="SA^A:All Payer TINs;R:Range or List of Payer TINs"
 S DIR("B")="ALL" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S EX=0 Q EX
 S RCTLIST=Y I $G(Y)="A" S RCTIN="ALL",RCTIN("DATA")="ALL" G GTO
 ; Get Range of 835 Payer TINs
 I RCTLIST="R" S EX=$$GETRNG(.RCTIN,"T"),RCTIN="R"
GTO ;
 Q EX
 ; RTNARR - Indirect Return array
 ; TYPE - The type of lookup "P" - Payer; "T" - TIN
GETRNG(RTNARR,TYPE) ;
 N DIC,D,RCDTN,RCDN,RCPT,DTOUT,DUOUT,DIRUT,DIROUT,X,Y,IDX
 I $G(TYPE)=""!("PT"'[$G(TYPE)) S RTNARR="ERROR" Q  ; Quit if TYPE not correct
 S IDX=$S(TYPE="P":"B",TYPE="T":"C")
 K DIC S DIC="^RCY(344.6,",DIC(0)="AES",D=IDX
 S DIC("A")="Start with 835 "_$S(TYPE="P":"Payer Name",TYPE="T":"Payer TIN")_": "
 I TYPE="P" S DIC("W")="D EN^DDIOL($P(^(0),U,2),,""?35"")"
 E  S DIC("W")="D EN^DDIOL($P(^(0),U,1),,""?35"")"
 D IX^DIC I $D(DTOUT)!$D(DUOUT)!(Y="")!(Y=-1) Q 0
 S RCDN=$O(^RCY(344.6,IDX,X,""))
 S RTNARR("START")=RCDN_U_X_U_Y,RTNARR("DATA")=X
 ;
 K DIC S DIC="^RCY(344.6,",DIC(0)="AES",D=IDX
 S DIC("A")="Go to with 835 "_$S(TYPE="P":"Payer Name",TYPE="T":"Payer TIN")_": "
 I TYPE="P" S DIC("W")="D EN^DDIOL($P(^(0),U,2),,""?35"")"
 E  S DIC("W")="D EN^DDIOL($P(^(0),U,1),,""?35"")"
 D IX^DIC I $D(DTOUT)!$D(DUOUT)!(Y="")!(Y=-1) Q 0
 S RCDN=$O(^RCY(344.6,IDX,X,""))
 S RTNARR("END")=RCDN_U_X_U_Y
 I TYPE="P" S RTNARR("DATA")=$P(RTNARR("START"),U,4)_":"_$P(RTNARR("END"),U,4)
 I TYPE="T" S RTNARR("DATA")=$P(RTNARR("START"),U,2)_":"_$P(RTNARR("END"),U,2)
 Q 1
 ;
CHECKDT(GSTART,GSTOP,GFILE) ; See if we have any possible data to report
 N SDT,IEN,PTR,COUNT,RCGX
 S COUNT=0
 I GFILE=361.1 D
 . S SDT=GSTART-0.001
 . F  S SDT=$O(^IBM(361.1,"E",SDT)) Q:(SDT="")!(SDT>GSTOP)!(COUNT>0)  S COUNT=COUNT+1
 I GFILE=344.4 D
 . S SDT=GSTART-.001
 . F  S SDT=$O(^RCY(344.4,"AC",SDT)) Q:(SDT="")!(SDT>GSTOP)!(COUNT>0)  D
 .. S IEN="" F  S IEN=$O(^RCY(344.4,"AC",SDT,IEN)) Q:IEN=""  D
 ... K RCGX D GETS^DIQ(344.4,IEN_",","2*;","E","RCGX") Q:$D(RCGX)=0
 ... S COUNT=COUNT+1 ; We have at least 1 ERA with a PLB
 Q COUNT
 ;
 ; Moved from RCDPARC
SUM(ARRAY,IEN,BILL,CARC,PAYER,BAMT,PAMT,DESC,AAMT,SORT) ; Count Claims and summarize for the report
 ; IEN: IEN from 361.1 file; BILL: The K-Bill number; ITEM: Top level sort item PAYER or CARC to summarize;
 ; BAMT: Billed Amount; PAMT: Paid Amount ; AAMT: Adjustment Amount;
 ; LVL: second level sort (CARC/Payer) ; SORT: "C" is CARC or "P" is Payer first level sort,
 N ITEM,LVL
 I SORT="C" S ITEM=CARC,LVL=PAYER
 E  S ITEM=PAYER,LVL=CARC
 ;
 ;D:$G(@ARRAY@("~~SUM",ITEM,BILL))'=1  ; If we already counted this claim for CARC or Payer skip
 ;W $NA(@ARRAY@("~~SUM",ITEM,IEN)),"=|",$G(@ARRAY@("~~SUM",ITEM,IEN)),"|",!
 D:$G(@ARRAY@("~~SUM",ITEM,IEN))'=1  ; If we already counted this claim for CARC or Payer skip
 . S $P(@ARRAY@("REPORT",ITEM,"~~SUM"),U,1)=$P($G(@ARRAY@("REPORT",ITEM,"~~SUM")),U,1)+1 ; Count claims
 . S $P(@ARRAY@("REPORT",ITEM,"~~SUM"),U,2)=$P($G(@ARRAY@("REPORT",ITEM,"~~SUM")),U,2)+BAMT ; Summarize amount billed
 . S $P(@ARRAY@("REPORT",ITEM,"~~SUM"),U,3)=$P($G(@ARRAY@("REPORT",ITEM,"~~SUM")),U,3)+PAMT ; Summarize amount paid
 ; Always add in the adjustment (this is a different adjustment each time procedure is called)
 S $P(@ARRAY@("REPORT",ITEM,"~~SUM"),U,4)=$P($G(@ARRAY@("REPORT",ITEM,"~~SUM")),U,4)+AAMT ; Summarize amount adjusted
 S:SORT="C" $P(@ARRAY@("REPORT",ITEM,"~~SUM"),U,5)=$G(DESC) ; CARC Description
 ;I (ITEM="1") W "ITEM=",ITEM,"  LVL=",LVL,"  ARRAY(REPORT,",ITEM,",~~SUM,",LVL,")=|",$G(@ARRAY@("REPORT",ITEM,"~~SUM",LVL)),"|  LVL&IEN (",IEN,") Array=|",$G(@ARRAY@("~~SUM",LVL,IEN)),"|",!
 ;I $G(LVL)'="" D:$G(@ARRAY@("~~SUM",ITEM,BILL))'=1
 I (SORT="C")&($G(LVL)'="") D:$G(@ARRAY@("~~SUM",ITEM,IEN))'=1
 . S $P(@ARRAY@("REPORT",ITEM,"~~SUM",LVL),U,1)=$P($G(@ARRAY@("REPORT",ITEM,"~~SUM",LVL)),U,1)+1 ; Count claims
 . S $P(@ARRAY@("REPORT",ITEM,"~~SUM",LVL),U,2)=$P($G(@ARRAY@("REPORT",ITEM,"~~SUM",LVL)),U,2)+BAMT ; Summarize amount billed
 . S $P(@ARRAY@("REPORT",ITEM,"~~SUM",LVL),U,3)=$P($G(@ARRAY@("REPORT",ITEM,"~~SUM",LVL)),U,3)+PAMT ; Summarize amount paid
 ;I $G(LVL)'="" D:$G(@ARRAY@("~~SUM",LVL,IEN))'=1
 I (SORT="P")&($G(LVL)'="") D:$G(@ARRAY@("~~SUM",ITEM,IEN,LVL))'=1
 . S $P(@ARRAY@("REPORT",ITEM,"~~SUM",LVL),U,1)=$P($G(@ARRAY@("REPORT",ITEM,"~~SUM",LVL)),U,1)+1 ; Count claims
 . S $P(@ARRAY@("REPORT",ITEM,"~~SUM",LVL),U,2)=$P($G(@ARRAY@("REPORT",ITEM,"~~SUM",LVL)),U,2)+BAMT ; Summarize amount billed
 . S $P(@ARRAY@("REPORT",ITEM,"~~SUM",LVL),U,3)=$P($G(@ARRAY@("REPORT",ITEM,"~~SUM",LVL)),U,3)+PAMT ; Summarize amount paid
 ; Always add in the adjustment (this is a different adjustment each time procedure is called)
 S $P(@ARRAY@("REPORT",ITEM,"~~SUM",LVL),U,4)=$P($G(@ARRAY@("REPORT",ITEM,"~~SUM",LVL)),U,4)+AAMT ; Summarize amount adjusted
 I SORT="P",$G(LVL)'="" S $P(@ARRAY@("REPORT",ITEM,"~~SUM",LVL),U,5)=DESC ; CARC Description
 ; Get grand totals for report
 D:$G(@ARRAY@("~~SUM",BILL))'=1
 . S $P(@ARRAY@("~~SUM","CLAIMS"),U,1)=$P($G(@ARRAY@("~~SUM","CLAIMS")),U,1)+1
 . S $P(@ARRAY@("~~SUM","CLAIMS"),U,2)=$P($G(@ARRAY@("~~SUM","CLAIMS")),U,2)+BAMT
 . S $P(@ARRAY@("~~SUM","CLAIMS"),U,3)=$P($G(@ARRAY@("~~SUM","CLAIMS")),U,3)+PAMT
 ; May have more than one adjustment on a bill
 I $G(@ARRAY@("~~SUM",BILL,ITEM))'=1 S $P(@ARRAY@("~~SUM","CLAIMS"),U,4)=$P($G(@ARRAY@("~~SUM","CLAIMS")),U,4)+AAMT ;W "BILL: ",BILL," ITEM: ",ITEM," Adj: ",AAMT,!
 ; Set markers so we don't double count a claim
 S @ARRAY@("~~SUM",ITEM,BILL)=1,@ARRAY@("~~SUM",ITEM,IEN)=1,@ARRAY@("~~SUM",ITEM,IEN,LVL)=1,@ARRAY@("~~SUM",BILL)=1,@ARRAY@("~~SUM",LVL,BILL)=1,@ARRAY@("~~SUM",LVL,IEN)=1
 Q
 ;
 ; RARR - Report array to walk; SUBS - Subscript to walk to sum the report
 ; ZSORT - Sorting on PLB Codes "C" or Payer/TIN "P"
SUMIT(RARR,SUBS,ZSORT) ; Summarize data in the array reference for PLB Report
 N LVL2,ZZ,XX,ZAD,ZCO,ZDC,ZN,ZPAT,ZPD,ZT,ZC,ZCT,ZS,ZTOT,YY,QQ,OLD,TADJ,ZIDX
 S ZT=0,ZC=0,ZTOT=0,ZAD=0,ZCO="",OLD=""
 I $G(SUBS)="" Q  ; We should always have this Variable
 S ZZ="",ZCT=0,ZAD=0
 ; Walk the collection in "ERA" or "PAYR" this will have all of the ERAs for this report and summarize
 F  S ZZ=$O(@RARR@(SUBS,ZZ)) Q:ZZ=""  D
 . K ZCT S XX="",ZCT=0,ZTOT=0,ZAD=0,ZPD=0,ZDC=""
 . ; XX will be the IEN of the ERA to count.
 . F  S XX=$O(@RARR@(SUBS,ZZ,XX)) Q:XX=""  S ZN=@RARR@(SUBS,ZZ,XX,0),ZPD=ZPD+$P(ZN,U,5),ZPAT=$P(ZN,U,6)_"/"_$P(ZN,U,3) D
 .. S ZCT=ZCT+1 S:ZSORT="C" ZCT(ZPAT)=$G(ZCT(ZPAT))+1,ZPD(ZZ_ZPAT)=$G(ZPD(ZZ_ZPAT))+$P(ZN,U,5) ; Count the ERAs and get paid for this payer
 .. S ZTOT=+$G(@RARR@("00_ERA",XX,.1))
 .. ; Get the adjusted amounts for the PLB codes (in ZZ if by Code)
 .. I ZSORT="C" S ZAD=$$TAMT(XX,RARR,ZZ),ZDC=$$TCD(XX,RARR,ZZ)
 .. I ZSORT="P" S YY=0.11 F  S YY=$O(@RARR@("00_ERA",XX,YY)) Q:YY=""  D 
 ... ; Get PLB Code, Adjusted amt and Code Description for By Payer summary
 ... N QPD S QPD=0,ZCO=$P($G(@RARR@("00_ERA",XX,YY)),U,1),QPD("ADJ")=$P($G(@RARR@("00_ERA",XX,YY)),U,2),ZDC=$P($G(@RARR@("00_ERA",XX,YY)),U,4)
 ... S QPD=$G(@RARR@("SUMMARY",ZZ,ZCO)) ; existing data for this PLB Code (QPD)
 ... I ($G(OLD(ZZ,ZCO,XX))'=1) S QPD("PAID")=$P(QPD,U,2)+$P(ZN,U,5),QPD("COUNT")=$P(QPD,U,3)+1,QPD("TBILLED")=$P(QPD,U,5)+ZTOT
 ... E  S QPD("PAID")=$P(QPD,U,2),QPD("COUNT")=$P(QPD,U,3),QPD("TBILLED")=$P(QPD,U,5)
 ... ; Adj Amt ^ Paid ^ Count of ERAs ^ Description ^ Total Billed
 ... S ZAD=($P(QPD,U,1)+QPD("ADJ")),ZPD=QPD("PAID"),ZCT=QPD("COUNT"),ZTOT=QPD("TBILLED")
 ... S @RARR@("SUMMARY",ZZ,ZCO)=ZAD_U_ZPD_U_ZCT_U_ZDC_U_ZTOT
 ... S OLD(ZZ,ZCO,XX)=1
 .. S LVL2=$S(ZSORT="C":ZPAT,ZSORT="P":ZCO,1:XX)
 .. S:ZSORT="C" ZAD=ZAD+$P($G(@RARR@("SUMMARY",ZZ,LVL2)),U,1),ZTOT=ZTOT+$P($G(@RARR@("SUMMARY",ZZ,LVL2)),U,5) ; Sum the ADJ & BILLED amounts
 .. ; Adj Amt ^ Paid ^ Count of ERAs ^ ^ Total Billed
 .. I ZSORT="C" S @RARR@("SUMMARY",ZZ,LVL2)=ZAD_U_ZPD(ZZ_ZPAT)_U_ZCT(ZPAT)_U_U_ZTOT
 ;
 ; Summarize the Code level totals
 I ZSORT="C" K OLD S ZZ="",QQ="" F  S ZZ=$O(@RARR@("ERA",ZZ)) Q:ZZ=""  D
 . S QQ="",(ZCT,ZPD,ZAD,ZTOT)=0 F  S QQ=$O(@RARR@("ERA",ZZ,QQ)) Q:QQ=""  D
 .. S ZCT=ZCT+1
 .. S ZPD=ZPD+$P(@RARR@("ERA",ZZ,QQ,0),U,5),ZTOT=ZTOT+@RARR@("00_ERA",QQ,.1),ZAD=ZAD+$$TAMT(QQ,RARR,ZZ),ZDC=$$TCD(QQ,RARR,ZZ)
 . S @RARR@("SUMMARY",ZZ)=ZAD_U_ZPD_U_ZCT_U_ZDC_U_ZTOT
 ;
 ; Summarize the Payer level totals
 I ZSORT="P" K OLD S ZZ="",QQ="" F  S ZZ=$O(@RARR@("PAYR",ZZ)) Q:ZZ=""  D
 . S QQ="",(ZCT,ZPD,ZAD,ZTOT)=0 F  S QQ=$O(@RARR@("PAYR",ZZ,QQ)) Q:QQ=""  D
 .. S ZCT=ZCT+1
 .. S ZPD=ZPD+$P(@RARR@("PAYR",ZZ,QQ,0),U,5),ZTOT=ZTOT+@RARR@("00_ERA",QQ,.1),ZAD=ZAD+$$TAMT(QQ,RARR,"")
 . S @RARR@("SUMMARY",ZZ)=ZAD_U_ZPD_U_ZCT_U_U_ZTOT
 ;
 ; Collect and summarize the Grand Totals.
 S ZZ="",QQ="" F  S ZZ=$O(@RARR@(SUBS,ZZ)) Q:ZZ=""  D 
 . S XX="" F  S XX=$O(@RARR@(SUBS,ZZ,XX)) Q:XX=""  S ZT=$G(@RARR@("TOTALS")),ZS=$G(@RARR@("SUMMARY",ZZ)) D  S @RARR@("ZZ_COUNTED",XX)=1
 .. S ZN=$G(@RARR@(SUBS,ZZ,XX,0)),ZN("TBILLED")=@RARR@("00_ERA",XX,.1),TADJ=$$TAMT(XX,RARR,"")
 .. I $G(@RARR@("ZZ_COUNTED",XX))'=1 D
 ... S @RARR@("TOTALS")=($P(ZT,U,1)+TADJ)_U_($P(ZT,U,2)+$P(ZN,U,5))_U_($P(ZT,U,3)+1)_U_U_($P(ZT,U,5)+ZN("TBILLED"))
 Q
 ;
TAMT(ZIEN,XGBL,ZCODE) ; Get Adjustment Amounts
 N ZAMT,XDN,AA S ZAMT=0
 ; ZCODE if defined is get the Adjustment amounts for just this code
 ; otherwise sum the adjustment amounts for this ERA in ZIEN
 D
 . S AA=0.1 F  S AA=$O(@XGBL@("00_ERA",ZIEN,AA)) Q:AA=""  D
 .. I $G(ZCODE)'="" Q:$P($G(@XGBL@("00_ERA",ZIEN,AA)),U,1)'=ZCODE  ; Quit if we don't have the right code
 .. ; Collect adjustment amounts to return for this ZIEN
 .. S ZAMT=ZAMT+$P(@XGBL@("00_ERA",ZIEN,AA),U,2)
 Q ZAMT
 ;
TCD(ZIEN,XGBL,ZCODE) ; Get PLB Description for Code & IEN given
 N RET,AA S RET=""
 Q:$G(ZCODE)="" ""
 S AA=0.1 F  S AA=$O(@XGBL@("00_ERA",ZIEN,AA)) Q:AA=""  D  Q:RET'=""
 . Q:$P($G(@XGBL@("00_ERA",ZIEN,AA)),U,1)'=ZCODE  ; Quit if we don't have the right code
 . S RET=$P(@XGBL@("00_ERA",ZIEN,AA),U,4)
 Q RET
 ;
 ; Moved from RCDPEM2 because of size issues
UPDERA(DA,RECEPT,FOUND) ;Mark ERA as posted to paper EOB
 N Y,X,DR,DIE,%
 D NOW^%DTC
 S DIE="^RCY(344.4,",FOUND=0
 ;Update Receipt #, EFT Match Status, Detail Post Status and Paper EOB
 S DR=".08///"_RECEPT_";.09///2;.14///2;20.03///1"
 ;Update Date/Time Posted and User fields
 S DR=DR_";7.01///"_%_";7.02///"_DUZ
 D ^DIE
 I '$D(Y) D
 .K DIR
 .S DIR(0)="EA"
 .S DIR("A",1)="ERA HAS BEEN MARKED AS POSTED USING PAPER EOB"
 .S DIR("A")="Press ENTER to continue: " W ! D ^DIR K DIR
 .S FOUND=1
 E  W !,"Unable to update ERA for receipt "_RECEPT,!
 Q FOUND
 ;
 ; Get Reciept Date (moved from RCDPEM2
RCDATE(RECEPT) ;
 N RCRECTDA
 ;Get receipt IEN
 S RCRECTDA=$O(^RCY(344,"B",RECEPT,0)) Q:'RCRECTDA 0
 ;Return Receipt date
 Q $P($G(^RCY(344,RCRECTDA,0)),U,3)
 ;
AMT(RECEPT) ;Total Receipt amount
 N RCRECTDA,RCTRAN,RCTOT
 ;Get receipt IEN
 S RCRECTDA=$O(^RCY(344,"B",RECEPT,0)) Q:'RCRECTDA 0
 ;Total the Receipt transactions
 S RCTRAN=0,RCTOT=0
 F  S RCTRAN=$O(^RCY(344,RCRECTDA,1,RCTRAN)) Q:'RCTRAN  D
 .S RCTOT=RCTOT+$P($G(^RCY(344,RCRECTDA,1,RCTRAN,0)),U,4)
 Q RCTOT
 ;
 ; Moved from RCDPEM2 for Manual match because RCDPEM2 was too big in size
 ; END, DTRNG, RCERA, RCMBG, START variables are newed and cleaned up in RCDPEM2
ML0() ;
ML0A S RCERA=$$SEL^RCDPEWL7() ; Select ERA to use from screen
 S RCMBG=VALMBG ; Save the line, we need it when we go back to the worklist.
 I RCERA=0 Q 1
 S RCERA(0)=^RCY(344.4,RCERA,0) ; Get the zero node for this ERA 
 I ((+($P(RCERA(0),U,9)))>0)!($P(RCERA(0),U,8)'="") W !,"ERA is already matched please select another ERA...",! G ML0A
 S DIR("A")="Select EFT by date Range? (Y/N) ",DIR(0)="YA",DIR("B")="NO" D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) Q 1
 I Y<1 G MLQ ; Go to the EFT Selection
 S DTRNG=Y  ; flag indicating date range selected
 K DIR S DIR("?")="Enter the earliest date for the selection range."
 ; value in DIR(0) for %DT = APE: ask date, past assumed, echo answer
 S DIR(0)="DAO^:"_DT_":APE",DIR("A")="Start Date: " D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q 1
 S START=Y K DIR,X,Y
 S DIR("?")="Enter the latest date for the selection range."
 S DIR(0)="DAO^"_START_":"_DT_":APE",DIR("A")="End Date: ",DIR("B")=$$FMTE^XLFDT(DT)
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q 1
 S END=Y
 ;
MLQ Q 0
