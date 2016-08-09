RCDPEAC ;ALB/TMK/PJH - ACTIVE BILLS WITH EEOB ON FILE ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**208,269,276,298,303**;Mar 20, 1995;Build 84
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; Entry point for Active Bills With EEOB Report [RCDPE ACTIVE WITH EEOB REPORT]
 N %ZIS,DTOUT,DUOUT,CHAM,HDR,POP,RCCT,RCDISPTY,RCHDR,RCINS,RCLSTMGR,RCPGNUM,RCSORT,RCSTOP,RCTMPND,TRIC,VAUTD,X,Y
 N START,END,RCZRO,RCMDRX
 ; PRCA*4.5*276 - IA 1077 - Query Division
 D DIVISION^VAUTOMA
 I 'VAUTD&($D(VAUTD)'=11) Q
 ; PRCA*4.5*276 - select report format
 Q:'$$SELECT(.RCINS,.RCSORT,.RCZRO,.RCMDRX)
 ;
 S RCTMPND="",RCPGNUM=0,RCSTOP=0
 I RCLSTMGR D  G ENOUT
 . S RCTMPND=$T(+0)_"^AR - ACTIVE BILLS WITH EEOB REPORT"  K ^TMP($J,RCTMPND)  ; clean any residue
 . D ENQ
 . M HDR=RCHDR
 . D LMRPT^RCDPEARL(.HDR,$NA(^TMP($J,RCTMPND))) ; generate ListMan display
 . I $D(RCTMPND) K ^TMP($J,RCTMPND)
 ;
 W !
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 .N ZTDESC,ZTRTN,ZTSAVE,ZTSK
 .S ZTRTN="ENQ^RCDPEAC",ZTDESC="AR - ACTIVE BILLS WITH EEOB REPORT",ZTSAVE("*")=""
 .D ^%ZTLOAD
 .W !!,$S($D(ZTSK):"Your task number"_ZTSK_" has been queued.",1:"Unable to queue this job.")
 .K IO("Q") D HOME^%ZIS
 U IO
 ;
ENQ ; Queued entry point for the report
 ; RCSORT and array RCINS must exist
 ; RCINS = "A" for all ins co, "R" for range, "S" for selected individual
 ;         for RCINS="R"  ("FR")=from payer name and ("TR")=to payer name
 ;         for RCINS="S"  ("S",INS CO IEN IN FILE 36)=""
 ; RCSORT = "PN" for sort by patient name followed by ;- if reverse order
 ;          "L4" for sort by patient SSN followed by ;- if reverse order
 ;
 N RC0,RC399,RC399M1,RC430,RCACT,RCBILL,RCEIEN,RCEOB,RCEX,RCEXT,RCNEW,RCPT,RCSSN,RCSTOP,RCTOT,RCZ,RCZ0,RCZ1,X,Y,Z,Z0
 N POSTDT,SN
 K ^TMP($J,"RCSORT")
 S RCCT=0 ;Page count for List Manager
 S RCEXT=0 ; Set Excel page 1 count
 I 'RCLSTMGR D HDRBLD
 I RCLSTMGR D HDRLM
 S RCACT=+$O(^PRCA(430.3,"AC",102,0)) ; Get active status ien
 G:'RCACT ENOUT
 ;
 I 'RCLSTMGR D HDRLST^RCDPEARL(0,.RCHDR)  ; initial report header
 S RCBILL=0,RCDT=START-.0001
 ; PRCA*4.5*303 - Changed loop to use the "AD" index on 361.1 so that the number of records checked is limited by
 ; the START and END dates of when the EEOB was recieved in VistA
 F  S RCDT=$O(^IBM(361.1,"AD",RCDT)) Q:(RCDT>END)!(RCDT="")  D
 . S RCEIEN="" F  S RCEIEN=$O(^IBM(361.1,"AD",RCDT,RCEIEN)) Q:RCEIEN=""  S RCBILL=$P(^IBM(361.1,RCEIEN,0),U,1) I ($P(^PRCA(430,RCBILL,0),U,8)=RCACT),$$INCLUDE(.RCINS,RCBILL,TRIC,CHAM),$$EEOB(RCBILL,.RCEOB,RCZRO) D
 . . S (RCTOT,RCEOB,SN)=0 F  S RCEOB=$O(RCEOB(RCEOB)) Q:'RCEOB  F  S SN=$O(RCEOB(RCEOB,SN))  Q:'SN  D
 . . . S RCTOT=RCTOT+$G(^IBM(361.1,RCEOB,1)),^TMP($J,"RCSORT",$$INSNM(RCBILL),$$SL1(RCSORT,RCBILL),RCBILL,+RCEOB(RCEOB,SN)_"_"_RCEOB_"_"_SN,RCEOB)=$P(RCEOB(RCEOB,SN),U,2) ; PRCA*4.5.303 add ERA PD AMOUNT
 . . . I $O(RCEOB(0)) S ^TMP($J,"RCSORT",$$INSNM(RCBILL),$$SL1(RCSORT,RCBILL),RCBILL)=RCTOT   ;This is from the eob and will be the same for each line
 ;
 S RCZ="",(RCSTOP,RCNEW)=0
 F  S RCZ=$O(^TMP($J,"RCSORT",RCZ)) Q:RCZ=""!RCSTOP  D  S:($G(RCINS)="R")!($G(RCINS)="S")&(RCPGNUM>1) RCNEW=1
 . I RCSORT'["-" D
 .. S RCZ0="" F  S RCZ0=$O(^TMP($J,"RCSORT",RCZ,RCZ0)) Q:RCZ0=""!RCSTOP  D OUTPUT(RCZ,RCZ0,RCSORT,.RCSTOP,.RCINS,RCNEW) S RCNEW=0
 . I RCSORT["-" D
 .. S RCZ0="" F  S RCZ0=$O(^TMP($J,"RCSORT",RCZ,RCZ0),-1) Q:RCZ0=""!RCSTOP  D OUTPUT(RCZ,RCZ0,RCSORT,.RCSTOP,.RCINS,.RCNEW) S RCNEW=0
 ;
 I '$D(^TMP($J,"RCSORT")) S $P(Z," ",25)="",Z=Z_"*** NO RECORDS TO PRINT ***" D SL^RCDPEARL(Z,.RCCT,RCTMPND)
 I $D(^TMP($J,"RCSORT")),'RCSTOP D SL^RCDPEARL($$ENDORPRT^RCDPEARL,.RCCT,RCTMPND)
 ; PRCA*4.5*303 - If regular report (no listmanager or queued) ask user to quit
 I 'RCSTOP,'RCLSTMGR,'$D(ZTQUEUED) D ASK^RCDPEARL(.RCSTOP)
 ;
ENOUT I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) D ^%ZISC
 K ^TMP($J,"RCSORT"),RCDT
 Q
 ;
OUTPUT(RCZ,RCZ0,RCSORT,RCSTOP,RCINS,RCNEW) ; Output the data
 ; RCZ, RCZ0 are the first 2 sort levels for the array
 ; RCINS = insurance co info array
 ; RCSTOP passed by ref - returned if user chooses to stop
 ; RCNEW = 1 if the header should be forced to print
 N ZZ,RCEPD
 S RCBILL=0 F  S RCBILL=$O(^TMP($J,"RCSORT",RCZ,RCZ0,RCBILL)) Q:'RCBILL!RCSTOP  S RCZ1="" F  S RCZ1=$O(^TMP($J,"RCSORT",RCZ,RCZ0,RCBILL,RCZ1)) Q:RCZ1=""!RCSTOP  D
 . I $D(ZTQUEUED),$$S^%ZTLOAD S (RCSTOP,ZTSTOP)=1 K ZTREQ I +$G(RCSTOP) W !!,"***TASK STOPPED BY USER***" Q
 . ; IA 1992 - BILL/CLAIMS file (#399)
 . S RC399=$G(^DGCR(399,RCBILL,0)),RC399M1=$G(^DGCR(399,RCBILL,"M1")),RCPT=+$P(RC399,U,2),RC430=$G(^PRCA(430,RCBILL,0))   ;RC430 is from the top level
 . ; PRCA*4.5*276 - Check for Division
 . I VAUTD=0 Q:$P(RC399,U,22)=""  Q:$G(VAUTD($P(RC399,U,22)))=""
 . ; PRCA*$.5*303 Check for medical or pharmacy claims, don't check further if we are reporting both
 . I RCMDRX'="B" S ZZ=$S((RCMDRX="P")&($P(RC399M1,U,8)'=""):1,(RCMDRX="M")&($P(RC399M1,U,8)=""):1,1:0) Q:ZZ=0
 . S RCSTOP=$$NEWPG(.RCINS,RCNEW) S RCNEW=0 Q:RCSTOP
 . S RCSTOP=$$NEWPG(.RCINS,RCNEW) Q:RCSTOP
 . S X=$$GET1^DIQ(430,RCBILL_",",11)
 . ; PRCA*4.5*276 - Row #1: Print last 4 SSN only - Move Bill Number to end
 . S RCSSN=$P($G(^DPT(RCPT,0)),U,9),RCSSN=$E(RCSSN,$L(RCSSN)-3,$L(RCSSN))
 . I $G(RCDISPTY) S RCEX=$P($G(^DPT(RCPT,0)),U)_"^"_RCSSN_"^"_$TR($P(RC430,U),"-","")
 . E  D
 .. S Z=$E($P($G(^DPT(RCPT,0)),U)_$J("",25),1,25)_"  "_$E(RCSSN_$J("",5),1,5)_"  "_$TR($P(RC430,U),"-","")
 .. D SL^RCDPEARL(Z,.RCCT,RCTMPND)
 . ; PRCA*4.5*276 - Row #2: Move Ins Name, Balance, Amt Bill, Amt Paid
 . S Y=+$G(^TMP($J,"RCSORT",RCZ,RCZ0,RCBILL))
 . I $G(RCDISPTY) S RCEX=RCEX_"^"_$$INSNM(RCBILL)_"^"_+X_"^"_+$P(RC430,U,3)_"^"_Y
 . E  D
 .. S Z=$E($$INSNM(RCBILL)_$J("",30),1,30)_$E($J("",12)_$J(+X,"",2),1+$L($J(+X,"",2)),12+$L($J(+X,"",2)))_$E($J("",13)_$J(+$P(RC430,U,3),"",2),1+$L($J(+$P(RC430,U,3),"",2)),13+$L($J(+$P(RC430,U,3),"",2)))_$E($J("",13),1,13-$L(Y))_$J(Y,"",2)
 .. D SL^RCDPEARL(Z,.RCCT,RCTMPND)
 . ; PRCA*4.5*276 Do not display Date Referred
 . S RCEOB=0,RCEPD="" F  S RCEOB=$O(^TMP($J,"RCSORT",RCZ,RCZ0,RCBILL,RCZ1,RCEOB)) Q:'RCEOB!RCSTOP  S RCEPD=$G(^TMP($J,"RCSORT",RCZ,RCZ0,RCBILL,RCZ1,RCEOB)) D
 .. S RCSTOP=$$NEWPG(.RCINS,RCNEW)
 .. Q:RCSTOP
 .. S RC0=$G(^IBM(361.1,RCEOB,0))
 .. S RCSTOP=$$NEWPG(.RCINS,RCNEW) Q:RCSTOP
 .. ; PRCA*4.5*276 - Row #3: Trace#, Date Rec'd, Date Posted
 .. I $G(RCDISPTY) W !,RCEX_"^"_$P(RC0,U,7)_"^"_$$FMTE^XLFDT($P(RC0,U,5),"2D")_"^"_$S(RCZ1:$$FMTE^XLFDT(+RCZ1,"2D"),1:"")_"^"_RCEPD
 .. E  D
 ... S Z="  "_$P(RC0,U,7)_$J("",50-$L($P(RC0,U,7)))_$J(RCEPD,10,2)_" "_$E($$FMTE^XLFDT($P(RC0,U,5),"2D")_$J("",8),1,8)_" "_$E($S(RCZ1:$$FMTE^XLFDT(+RCZ1,"2D"),1:"")_$J("",8),1,8)
 ... D SL^RCDPEARL(Z,.RCCT,RCTMPND)
 . I '$G(RCDISPTY) S Z="" D SL^RCDPEARL(Z,.RCCT,RCTMPND)
 ;
 Q
 ;
INCLUDE(RCINS,RCZ,TRI,CVA) ; Function returns 1 if record should be included based
 ; on ins co
 ; RCINS = array containing insurance co information
 ; RCZ = ien of the entry in file 430
 N OK,RCI,RCINM,RCAINP
 S OK=0
 S RCI=+$$INS(RCZ)
 ;
 I 'RCI G INCQ ; Not a third party bill
 ;
 I RCINS="A" S OK=1
 ;
 I RCINS="S"!(RCINS="R") D
 . I RCINS="S" S:$D(RCINS("S",RCI)) OK=1 Q
 . S RCINM=$$INSNM(RCZ) ; INS CO NAME
 . I $S(RCINM=RCINS("FR")!(RCINM]RCINS("FR")):RCINM']RCINS("TO"),1:0) S OK=1
 ; 
 I OK=0 G INCQ  ;CHAMPVA and TRICARE do not matter - do not include
 I OK=1,TRI,CVA G INCQ  ;Add check for CHAMPVA and TRICARE
 S RCAINP=$P($G(^PRCA(430,RCZ,0)),U,2)
 I 'TRI,",30,31,32,"[(","_RCAINP_",") S OK=0   ;Only exclude TRICARE
 I 'CVA,",27,28,29,"[(","_RCAINP_",") S OK=0   ;Only exclude CHAMPVA
 ;
INCQ Q OK
 ;
INSNM(RCZ) ; Returns the name of the insurance co for bill ien RCZ file 430
 N NM
 S NM=$P($G(^DIC(36,+$$INS(RCZ),0)),U)
 Q NM
 ;
INS(RCZ) ; Returns ien of insurance co for bill ien RCZ from file 430
 N RC
 S RC=$P($G(^PRCA(430,RCZ,0)),U,9) ;DEBTOR
 Q $S($P($G(^RCD(340,+RC,0)),U)'["DIC(36":"",1:+^(0))
 ;
NEWPG(RCINS,RCNEW) ; Check for new page needed, output header
 ; RCINS = ins co selection criteria
 ; RCNEW = 1 to force new page
 ; Function returns 1 if user chooses to stop output
 I RCNEW!(($Y+5)>IOSL) D
 . D:'$G(RCDISPTY) HDRLST^RCDPEARL(.RCSTOP,.RCHDR)
 Q RCSTOP
 ;
EEOB(RCZ,RCEOB,RCZRO) ; Find all non-MRA  EEOBs for bill ien RCZ
 ; Function returns 1 if any valid EEOBs found, 0 if none
 ; RCEOB(eob ien)=date posted returned for valid EEOBs found -
 ;                pass by reference
 N OK,Z,Z0,Z00,DET,SN,ZPD,ZINC
 K RCEOB
 ;
 S (Z,OK,SN,ZINC)=0
 ; IA 4051 for File #361.1
 F  S Z=$O(^IBM(361.1,"B",RCZ,Z)) Q:'Z  I $P($G(^IBM(361.1,Z,0)),U,4)'=1 D
 . ; retrieve the EEOB data from ERA Detail sub-entry
 . S (Z0,DET)=0
 . F  S Z0=$O(^RCY(344.4,"ADET",Z,Z0)) Q:'Z0  F  S DET=$O(^RCY(344.4,"ADET",Z,Z0,DET)) Q:'DET  D  ; ERA Detail
 . . ; PRCA*4.5*303 - added check for Zero paid or Paid > 0 check for report.
 . . S ZINC=0,ZPD=+$P($G(^RCY(344.4,Z0,1,DET,0)),U,3)
 . . I (RCZRO="Z"),(ZPD=0) S ZINC=1
 . . I (RCZRO="A"),(ZPD>0) S ZINC=1
 . . ; PRCA*4.5*303 - Removed looking for Receipt, include record based on ERA DETAIL POST STATUS
 . . S Z00=$P($G(^RCY(344.4,Z0,0)),U,14)
 . . ; PRCA*4.5*303 - Removed check for Receipt (If Z1 is not empty) Changed date to Piece 7 and
 . . ; added check for either 0 paid or paid >0 depending on selection. Added ERA PD AMOUNT as second piece of RCEOB array
 . . I (ZINC)&((Z00=0)!(Z00=1)!(Z00=2)!(Z00=5)) S SN=SN+1,RCEOB(Z,SN)=+$P($G(^RCY(344.4,Z0,0)),U,7)_U_ZPD,OK=1
 ;
 Q OK
 ;
SL1(RCSORT,RCZ) ; Function returns 1st sort level data from ien RCZ in file 430
 ; RCSORT = "PN" for patient name sort = "L4" for SSN last 4 sort
 N DAT
 I RCSORT="PN" S DAT=$P($G(^DPT(+$P($G(^PRCA(430,RCZ,0)),U,7),0)),U)
 I RCSORT="L4" S DAT=$P($G(^DPT(+$P($G(^PRCA(430,RCZ,0)),U,7),0)),U,9),DAT=$E(DAT,$L(DAT)-3,$L(DAT))
 Q $S($G(DAT)'="":DAT,1:" ")
 ;
SELECT(RCINS,RCSORT,RCZRO,RCMDRX) ; Select insurance co, sort criteria, Zero Payment, Bill type (Med/RX) and if output for EXCEL format is selected
 ; Function returns values selected for RCSORT and RCINS - passed by ref
 N RCQUIT,DONE,DIR,X,Y,%DT
 S (RCQUIT,DONE,RCLSTMGR)=0
 S DIR(0)="SA^A:ALL;S:SPECIFIC;R:RANGE",DIR("A")="RUN REPORT FOR (A)LL, (S)PECIFIC, OR (R)ANGE OF INSURANCE COMPANIES?: ",DIR("B")="ALL" W ! D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) G SELQ
 ;
 S RCINS=Y
 I RCINS="S" D  G:RCQUIT SELQ
 . W !
 . F  D LIST(.DIR,.RCINS) S DIR("A")="SELECT "_$S($O(RCINS("S",0)):"ANOTHER ",1:"")_"INSURANCE COMPANY"_$S($O(RCINS("S",0)):" (PRESS RETURN WHEN DONE)",1:"")_": ",DIR(0)="PAO^DIC(36,:AEMQ" D ^DIR K DIR D  Q:Y'>0
 .. I $D(DTOUT)!$D(DUOUT) S RCQUIT=1 Q
 .. I Y>0 S RCINS("S",+Y)=""
 . I '$O(RCINS("S",0)) S RCQUIT=1 W !!,"NO INSURANCE COMPANIES SELECTED - NO REPORT GENERATED" S DIR(0)="E" D ^DIR K DIR
 ;
 I RCINS="R" D  I RCQUIT W !!,"NO INSURANCE COMPANY NAME RANGE SELECTED - NO REPORT GENERATED" S DIR(0)="E" D ^DIR K DIR G SELQ
 . W !
 . S DIR("?")="ENTER 1-30 UPPERCASE CHARACTERS OF THE FIRST NAME TO INCLUDE"
 . S DIR(0)="FA^1:30^K:X'?.U X",DIR("A")="START WITH INSURANCE COMPANY NAME: " D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT) S RCQUIT=1 Q
 . S RCINS("FR")=Y
 . S DIR("?")="ENTER 1-30 UPPERCASE CHARACTERS OF THE LAST NAME TO INCLUDE"
 . S DIR(0)="FA^1:30^K:X'?.U X",DIR("A")="GO TO INSURANCE COMPANY NAME: ",DIR("B")=$E(RCINS("FR"),1,27)_"ZZZ"
 . F  W ! D ^DIR Q:$S($D(DTOUT)!$D(DUOUT):1,1:RCINS("FR")']Y)  W !,"'GO TO' NAME MUST COME AFTER 'START WITH' NAME"
 . K DIR
 . I $D(DTOUT)!$D(DUOUT) S RCQUIT=1 Q
 . S RCINS("TO")=Y
 ; PRCA*4.5*303 - Add Zero $ Prompt and Medical/Pharmacy EEOBs Prompt
 S DIR(0)="SA^A:ALL;Z:ZERO PAYMENT EEOBs",DIR("A")="RUN REPORT FOR (A)LL EEOBs or (Z)ERO PAYMENT EEOBs only: ",DIR("B")="ALL" W ! D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) G SELQ
 ;
 S RCZRO=$E(Y,1)
  S DIR(0)="SA^B:BOTH;M:MEDICAL;P:PHARMACY",DIR("A")="RUN REPORT FOR (M)EDICAL, (P)HARMACY OR (B)OTH: ",DIR("B")="BOTH" W ! D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) G SELQ
 ;
 S RCMDRX=$E(Y,1)
 ;
 S DIR(0)="SA^P:PATIENT NAME;L:LAST 4 OF PATIENT SSN",DIR("A")="WITHIN INS CO, SORT BY (P)ATIENT NAME OR (L)AST 4 OF SSN?: ",DIR("B")="PATIENT NAME" W ! D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) G SELQ
 S RCSORT=$S(Y="P":"PN",1:"L4")
 S DIR(0)="SA^F:FIRST TO LAST;L:LAST TO FIRST",DIR("A")="SORT "_$S(RCSORT="PN":"PATIENT NAME",1:"LAST 4")_" (F)IRST TO LAST OR (L)AST TO FIRST?: ",DIR("B")="FIRST TO LAST" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) G SELQ
 I Y="L" S RCSORT=RCSORT_";-"
 ;
 ; PRCA*4.5*298 - Add Date Range Prompts
 K DIR
 S DIR("?")="ENTER THE EARLIEST RECEIVED DATE TO INCLUDE ON THE REPORT"
 S DIR(0)="DAO^:"_DT_":APE",DIR("A")="START DATE (RECEIVED): ",DIR("B")="T" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") G SELQ
 S START=Y
 K DIR
 S DIR("?")="ENTER THE LATEST RECEIVED DATE TO INCLUDE ON THE REPORT"
 S DIR("B")="T"
 S DIR(0)="DAO^"_START_":"_DT_":APE",DIR("A")="END DATE (RECEIVED): " D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") G SELQ
 S END=Y
 ;
 ; PRCA*4.5*298 - Add TRICARE Prompt
 S TRIC=$$INTRICAR^RCDPEARL G:TRIC<0 SELQ
 ;
 ; PRCA*4.5*298 - Add CHAMPVA Prompt
 S CHAM=$$INCHMPVA^RCDPEARL G:CHAM<0 SELQ
 ;
 ; PRCA*4.5*276 - Determine whether to gather data for Excel report.
 S RCDISPTY=$$DISPTY^RCDPEM3 G SELQ:RCDISPTY<0
 I RCDISPTY D INFO^RCDPEM6 S DONE=1 G SELQ
 ;
 ; PRCA*4.5*298 - Add ListManager Prompts
 S RCLSTMGR=$$ASKLM^RCDPEARL G:RCLSTMGR<0 SELQ
 ;
 S DONE=1
 ;
SELQ ;
 Q DONE
 ;
LIST(DIR,RCINS) ; Sets up help array for ins co selected in DIR("?")
 N CT,Z
 S CT=1
 I '$O(RCINS("S",0)) S DIR("?")="NO INSURANCE COMPANIES SELECTED" Q
 S DIR("?",1)="INSURANCE COMPANIES ALREADY SELECTED:"
 S Z=0 F  S Z=$O(RCINS("S",Z)) Q:'Z  S CT=CT+1,DIR("?",CT)="   "_$P($G(^DIC(36,Z,0)),U)
 S DIR("?")=" "
 Q
 ;
HDRBLD ; create the report header
 ; returns RCHDR,RCPGNUM,RCSTOP
 ;   RCHDR(0) = header text line count
 ;   RCHDR("PGNUM") = page number
 ;   RCHDR("XECUTE") = M code for page number
 ;   RCHDR("RUNDATE") = date/time report generated
 ;   RCPGNUM - page counter
 ;   RCSTOP - flag to stop listing
 ;INPUT:
 ; RCDTRNG - date range filter value to be printed as part of the header
 ; RCPAY - Payer filter value(s)
 ; RCLSTMGR
 ;
 N Z0
 S Z0=""
 K RCHDR S RCHDR("RUNDATE")=$$NOW^RCDPEARL,RCPGNUM=0,RCSTOP=0
 ;
 I RCDISPTY D  Q  ; Excel format, xecute code is QUIT, null page number
 . S RCHDR(0)=1,RCHDR("XECUTE")="Q",RCPGNUM=""
 . S RCHDR(1)="PATIENT NAME^SSN^BILL#^INS CO NAME^BALANCE^AMT BILLE^AMT PAID^TRACE#^DT REC'D^DT POST^ERA PD AMT"
 ;
 N MSG,DATE,Y,DIV,HCNT
 S RCHDR(1)=$$HDRNM,HCNT=1  ; line 1 will be replaced by XECUTE code below
 S RCHDR("XECUTE")="N Y S RCPGNUM=RCPGNUM+1,Y=$$HDRNM^"_$T(+0)_"_$S(RCLSTMGR:"""",1:$J(""Page: ""_RCPGNUM,12)),RCHDR(1)=$J("" "",80-$L(Y)\2)_Y"
 ;
 S Y="RUN DATE: "_RCHDR("RUNDATE"),HCNT=HCNT+1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y
 I VAUTD=1 S Y="DIVISIONS: ALL"
 I VAUTD=0 D
 . S Z0=0,Y="DIVISIONS: " F X=1:1 S Z0=$O(VAUTD(Z0)) Q:Z0=""  S:X>1 Y=Y_", " S Y=Y_VAUTD(Z0)
 S HCNT=HCNT+1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y
 I RCINS="S" S Z=0,Z0="" F  S Z=$O(RCINS("S",Z)) Q:'Z  S Z0=Z0_$S(Z0'="":",",1:"")_$P($G(^DIC(36,Z,0)),U)
 S Z0="PAYERS: "_$S(RCINS="A":"ALL   ",RCINS="R":"RANGE FROM "_RCINS("FR")_"-"_RCINS("TO"),1:"")_Z0
 S HCNT=HCNT+1,RCHDR(HCNT)=$J("",80-$L(Z0)\2)_Z0,Z0=""
 S Z0=Z0_"DATE RANGE: "_$$FMTE^XLFDT(START,"2Z")_"-"_$$FMTE^XLFDT(END,"2Z")_"  TRICARE: "_$S(TRIC=1:"YES",1:"NO")_"  CHAMPVA: "_$S(CHAM=1:"YES",1:"NO")_"  EEOBs: "_$S(RCMDRX="M":"MEDICAL",RCMDRX="P":"PHARMACY",1:"BOTH")
 S HCNT=HCNT+1,RCHDR(HCNT)=$J("",80-$L(Z0)\2)_Z0
 ;
 S HCNT=HCNT+1,RCHDR(HCNT)=""
 S Y="PATIENT NAME               SSN    BILL#",HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y="INS CO NAME                        BALANCE   AMT BILLED        AMT PAID",HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y="   TRACE#                                           ERA PD AMT  REC'D  DT POST",HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y=$TR($J("",IOM)," ","="),HCNT=HCNT+1,RCHDR(HCNT)=Y
 S RCHDR(0)=HCNT
 Q
 ;
HDRLM ; create the list manager version of the report header
 ; returns RCHDR,RCPGNUM,RCSTOP
 ;   RCHDR(0) = header text line count
 ;   RCHDR("PGNUM") = page number
 ;   RCHDR("XECUTE") = M code for page number
 ;   RCHDR("RUNDATE") = date/time report generated
 ;   RCPGNUM - page counter
 ;   RCSTOP - flag to stop listing
 ;INPUT:
 ; RCDTRNG - date range filter value to be printed as part of the header
 ; RCPAY - Payer filter value(s)
 ; RCLSTMGR
 ;
 N Z0 S Z0=""
 K RCHDR S RCPGNUM=0,RCSTOP=0
 N MSG,DATE,Y,DIV,HCNT
 S RCHDR("TITLE")=$$HDRNM,RCHDR("XECUTE")="Q"
 S RCHDR(1)="DATE RANGE: "_$$FMTE^XLFDT(START,"2Z")_"-"_$$FMTE^XLFDT(END,"2Z")_"  TRICARE: "_$S(TRIC=1:"YES",1:"NO")_"  CHAMPVA: "_$S(CHAM=1:"YES",1:"NO")_"  EEOBs: "_$S(RCMDRX="M":"MEDICAL",RCMDRX="P":"PHARMACY",1:"BOTH"),HCNT=1
 I VAUTD=1 S Y="DIVISIONS: ALL"
 I VAUTD=0 D
 . S Z0=0,Y="DIVISIONS: " F X=1:1 S Z0=$O(VAUTD(Z0)) Q:Z0=""  S:X>1 Y=Y_", " S Y=Y_VAUTD(Z0)
 S HCNT=HCNT+1,RCHDR(HCNT)=Y
 I RCINS="S" S Z=0,Z0="" F  S Z=$O(RCINS("S",Z)) Q:'Z  S Z0=Z0_$S(Z0'="":",",1:"")_$P($G(^DIC(36,Z,0)),U)
 S Z0="PAYERS: "_$S(RCINS="A":"ALL     ",RCINS="R":"RANGE FROM "_RCINS("FR")_" - "_RCINS("TO"),1:"")_Z0
 S HCNT=HCNT+1,RCHDR(HCNT)=Z0
 I RCINS="A" S HCNT=HCNT+1,RCHDR(HCNT)=""
 ;
 S Y="PATIENT NAME               SSN    BILL#",HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y="INS CO NAME                        BALANCE   AMT BILLED        AMT PAID",HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y="   TRACE#                                           ERA PD AMT  REC'D  DT POST",HCNT=HCNT+1,RCHDR(HCNT)=Y
 S RCHDR(0)=HCNT
 Q
 ;
 ; extrinsic variable, name for header PRCA*4.5*298
HDRNM() Q "EDI LOCKBOX ACTIVE BILLS W/EEOB REPORT"
 ;
