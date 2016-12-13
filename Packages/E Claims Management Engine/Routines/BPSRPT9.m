BPSRPT9 ;BHAM ISC/BNT - ECME REPORTS ;19-SEPT-08
 ;;1.0;E CLAIMS MGMT ENGINE;**8,18,20**;01-JUN-04;Build 27
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ; Front End for Potential Secondary and Dual Eligible Claims Reports
 ; Input variable: BPRTYPE -> 8 = Potential Dual Eligible
 ;                            9 = Potential Secondary
 ;
 ; Passed variables - The following local variables are passed around the BPSRPT* routines
 ;                    and are not passed as parameters but are assumed to be defined:
 ;                    BPACREJ,BPAUTREV,BPBEGDT,BPBLINE,BPCCRSN,BPDRGCL,BPDRUG,BPENDDT,BPEXCEL,
 ;                    BPINSINF,BPGRPLN,BPMWC,BPNOW,BPPAGE,BPPHARM,BPQ,BPQSTDRG,
 ;                    BPRLNRL,BPRTBCK,BPSDATA,BPSUMDET,BPRTYPE
 ;
EN(BPRTYPE) ;
 N BPREJCD,BPRLNRL,BPRPTNAM,BPRTBCK,BPSCR,BPSUMDET,CODE,POS,STAT,X,Y,BPINS,BPARR
 N BPSORT,BPCRON,BPSEL,BPS1,BPS2,BPS3,BPS4,BPS5,BPDT,BPPHARM,BPDIVS,BPELIG1
 ;
 ;Verify that a valid report has been requested
 I ",8,9,"'[(","_$G(BPRTYPE)_",") D EN^DDIOL("<Invalid Menu Definition - Report Undefined>") H 3 Q
 ;
 D EN^DDIOL("SELECTION CRITERIA","","!")
 ;Prompt for ECME Pharmacy Division(s) (No Default)
 ;Sets up BPPHARM variable and array, BPPHARM =0 ALL or BPPHARM=1,BPPHARM(ptr) for list
 S X=$$SELPHARM^BPSRPT3() I X="^" Q
 ;
 I BPRTYPE=8 S X=$$SELELIG(.BPELIG1) I X="^" Q
 ;
 ;Prompt to select Date Range
 ;Returns (Start Date^End Date)
 S BPDT=$$SELDATE() I BPDT="^" Q
 ;
 ;Get sort criteria
 I $$GETSORT(BPRTYPE)=-1 Q
 ;
 D DEV("RUN^BPSRPT9",BPRTYPE)
 Q
 ;
RUN ; Process Report - runs in the background or foreground
 N BPRPTARR
 I BPRTYPE=9 D GETSEC^BPSRPT9A(BPDT,.BPRPTARR)  ; Collect Potential Secondary Rx Claims data
 I BPRTYPE=8 D GETTRI^BPSRPT9A(BPDT,.BPRPTARR)  ; Collect Potential Dual Eligible Claims data
 ;
 U IO
 I BPRTYPE=8 D PRNTTRI(.BPRPTARR)
 I BPRTYPE=9 D PRNTSEC(.BPRPTARR)
 ;
 D ^%ZISC    ; close the device
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
 ; Print Dual Eligible Report
PRNTTRI(BPARR) ;
 N BPG,BPQUIT,CNT,RX,FILL,FILLDT,PATNAME,COB,ELIG,PAYER,INSC,PSRT,PSRTID,SSRT,TSRT,DATA
 N SSRTTYP,TSRTTYP
 S SSRTTYP=$P($P(BPSORT,U,2),":")
 S TSRTTYP=$P($P(BPSORT,U,3),":")
 S (BPG,BPQUIT,CNT)=0
 ;
 ; if no data found, display header and message and then get out
 I '$D(BPARR) D  Q
 . D HDR(BPRTYPE)
 . W !!?5,"No potential claims available for date range"
 . Q
 ;
 S PSRT=-DT-1
 D HDR(BPRTYPE)
 F  S PSRT=$O(BPARR(PSRT)) Q:PSRT=""  D  Q:BPQUIT
 . S PSRTID=$S($P($P(BPSORT,U),":")="N":"Patient Name: ",$P($P(BPSORT,U),":")="P":"Payer: ",$P($P(BPSORT,U),":")="S":"Date of Service: ",$P($P(BPSORT,U),":")="O":"Payer Sequence: ",$P($P(BPSORT,U),":")="E":"Patient Eligibility: ",1:"Division: ")
 . I PSRT'=0 W !!,PSRTID,$S($P($P(BPSORT,U),":")="S":$$FMTE^XLFDT($$ABS^XLFMTH(PSRT),"2D"),1:PSRT)
 . S SSRT=-DT-1 F  S SSRT=$O(BPARR(PSRT,SSRT)) Q:SSRT=""  D  Q:BPQUIT
 . . I SSRTTYP="D" W !,"   Division: ",SSRT
 . . S TSRT=-DT-1 F  S TSRT=$O(BPARR(PSRT,SSRT,TSRT)) Q:TSRT=""  D  Q:BPQUIT
 . . . I TSRTTYP="D" W !,"   Division: ",TSRT
 . . . S CNT=0 F  S CNT=$O(BPARR(PSRT,SSRT,TSRT,CNT)) Q:CNT=""  D  Q:BPQUIT
 . . . . S DATA=BPARR(PSRT,SSRT,TSRT,CNT)
 . . . . S RX=$P(DATA,U,2),FILL=$P(DATA,U,3),FILLDT=$P(DATA,U,4),PATNAME=$P(DATA,U,5)
 . . . . S INSC=0 F  S INSC=$O(BPARR(PSRT,SSRT,TSRT,CNT,"INS",INSC)) Q:INSC=""  D
 . . . . . S COB=$S(INSC=1:"p",INSC=2:"s",1:"t")
 . . . . . S ELIG=$P(BPARR(PSRT,SSRT,TSRT,CNT,"ELIG"),U)
 . . . . . ; BPS*1*18:  Modify ePharmacy Screens/Reports to Include the Validated HPID/OEID
 . . . . . S PAYER=$E($P(BPARR(PSRT,SSRT,TSRT,CNT,"INS",INSC),U)_"-"_$P(BPARR(PSRT,SSRT,TSRT,CNT,"INS",INSC),U,2),1,16)
 . . . . . I $Y>(IOSL-4) D HDR(BPRTYPE) Q:BPQUIT
 . . . . . ; BPS*1*18:  Modify ePharmacy Screens/Reports to Include the Validated HPID/OEID
 . . . . . W !,RX,?10,FILL,?13,FILLDT,?22,$E(PATNAME,1,15),?38,$P(DATA,U,6),?44,COB,?47,ELIG,?52,PAYER,?69,$P(BPARR(PSRT,SSRT,TSRT,CNT,"INS",INSC),U,3)
 . . . . . S ELIG=$S($P(BPARR(PSRT,SSRT,TSRT,CNT,"ELIG"),U,2)]"":$P(BPARR(PSRT,SSRT,TSRT,CNT,"ELIG"),U,2),1:"")
 . . . . . ; BPS*1*18:  Modify ePharmacy Screens/Reports to Include the Validated HPID/OEID
 . . . . . I ELIG]"" W !,?47,ELIG
 Q
 ;
 ; Print Secondary Report
PRNTSEC(BPARR) ;
 N BPG,BPQUIT,CNT,INSC,PAYER,PSRT,PSRTID,SSRT,TSRT,DATA,INSDATA,LGFLG1,LGFLG2
 N SSRTTYP,TSRTTYP
 S SSRTTYP=$P($P(BPSORT,U,2),":")
 S TSRTTYP=$P($P(BPSORT,U,3),":")
 S (BPG,BPQUIT)=0
 ;
 ; if no data found, display header and message and then get out
 I '$D(BPARR) D  Q
 . D HDR(BPRTYPE)
 . W !!?5,"No potential secondary Rx claims available for date range"
 . Q
 ;
 S PSRT=-DT-1
 D HDR(BPRTYPE)
 F  S PSRT=$O(BPARR(PSRT)) Q:PSRT=""  D  Q:BPQUIT
 . S PSRTID=$S($P($P(BPSORT,U),":")="N":"Patient Name: ",$P($P(BPSORT,U),":")="P":"Payer: ",$P($P(BPSORT,U),":")="S":"Date of Service: ",$P($P(BPSORT,U),":")="O":"Payer Sequence: ",1:"Division: ")
 . I PSRT'=0 W !!,PSRTID,$S($P($P(BPSORT,U),":")="S":$$FMTE^XLFDT($$ABS^XLFMTH(PSRT),"2D"),1:PSRT)
 . S SSRT=-DT-1 F  S SSRT=$O(BPARR(PSRT,SSRT)) Q:SSRT=""  D  Q:BPQUIT
 . . I SSRTTYP="D" W !,"   Division: ",SSRT
 . . S TSRT=-DT-1 F  S TSRT=$O(BPARR(PSRT,SSRT,TSRT)) Q:TSRT=""  D  Q:BPQUIT
 . . . I TSRTTYP="D" W !,"   Division: ",TSRT
 . . . S CNT=0 F  S CNT=$O(BPARR(PSRT,SSRT,TSRT,CNT)) Q:CNT=""  D  Q:BPQUIT
 . . . . S DATA=$G(BPARR(PSRT,SSRT,TSRT,CNT))
 . . . . I $Y>(IOSL-4) D HDR(BPRTYPE) Q:BPQUIT
 . . . . ; BPS*1*18:  Modify ePharmacy Screens/Reports to Include the Validated HPID/OEID
 . . . . I DATA]"" W !,$P(DATA,U,2),?11,$P(DATA,U,3),?21,$P(DATA,U,4),?26,$E($P(DATA,U,6),1,10),?37,$P(DATA,U,9),?43,$P(DATA,U,7),?46,$P(DATA,U,5),?55,$E($P(DATA,U,8),1,13),?69,$P(DATA,U,10)
 . . . . ;
 . . . . ; If the bill# contains "(P)" it is a primary ECME reject, flag it for the legend
 . . . . I $P(DATA,U,2)["(P)" S LGFLG1=1
 . . . . S INSC=0 F  S INSC=$O(BPARR(PSRT,SSRT,TSRT,CNT,INSC)) Q:INSC=""  D  Q:BPQUIT
 . . . . . S INSDATA=BPARR(PSRT,SSRT,TSRT,CNT,INSC)
 . . . . . I $Y>(IOSL-4) D HDR(BPRTYPE) Q:BPQUIT
 . . . . . ; BPS*1*18:  Modify ePharmacy Screens/Reports to Include the Validated HPID/OEID
 . . . . . W !,?43,$P(INSDATA,U),?55,$E($P(INSDATA,U,2),1,13),?69,$P(INSDATA,U,3)
 . . . . . I $P(INSDATA,U,1)["-" S LGFLG2=1
 ;
 Q:BPQUIT
 I '$G(LGFLG1),'$G(LGFLG2) Q
 ; display the legend at the end of the report
 I $Y>(IOSL-4) D HDR(BPRTYPE) Q:BPQUIT
 W !
 I $G(LGFLG1) W !,"Bill# ""(P) Rej"" indicates a rejected/closed primary ECME claim"
 I $G(LGFLG2) W !,"COB ""-"" indicates a blank COB field in the pt. ins. policy"
 Q
 ;
 ; Prompt for sort order
GETSORT(BPRTYPE) N DIR,DIRUT,DTOUT,DUOUT,X,Y,BPS1,BPS2,BPS3,BPS4,BPS5,BPSEL
 ;
 S BPSORT="^^",BPCRON=1
 S BPS1="N:Patient Name;",BPS2="P:Payer;",BPS3="S:Date Of Service;",BPS4="D:Division;"
 I BPRTYPE=8 S BPS5="E:Patient Eligibility;"
 ;
 D EN^DDIOL("SORT CRITERIA","","!")
 S BPSEL=BPS1_BPS2_BPS3_BPS4
 I BPRTYPE=8 S BPSEL=BPSEL_BPS5
 ;Set Primary Sort
 S DIR(0)="SB^"_BPSEL
 S DIR("?")="Enter a code from the list to indicate the Primary sort order."
 S DIR("A")="Primary Sort"
 S DIR("B")="Division"
 D ^DIR K DIR
 I ($G(DUOUT)=1)!($G(DTOUT)=1) Q -1
 I BPRTYPE=9 S $P(BPSORT,U)=$S(Y=$P(BPS1,":"):BPS1,Y=$P(BPS2,":"):BPS2,Y=$P(BPS3,":"):BPS3,1:BPS4)
 I BPRTYPE=8 S $P(BPSORT,U)=$S(Y=$P(BPS1,":"):BPS1,Y=$P(BPS2,":"):BPS2,Y=$P(BPS3,":"):BPS3,Y=$P(BPS4,":"):BPS4,1:BPS5)
 I Y="S" S BPCRON=$$ASKCRON() I BPCRON="^" Q -1
 ;
 ;Get Secondary Sort
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S BPSEL=$$SRTORD($P($P(BPSORT,U),":"))
 S DIR(0)="SOB^"_BPSEL
 S DIR("?")="Enter a code from the list to indicate the Secondary sort order."
 S DIR("A")="Secondary Sort"
 D ^DIR K DIR
 I ($G(DUOUT)=1)!($G(DTOUT)=1) Q -1
 I BPRTYPE=9 S $P(BPSORT,U,2)=$S(Y=$P(BPS1,":"):BPS1,Y=$P(BPS2,":"):BPS2,Y=$P(BPS3,":"):BPS3,1:BPS4)
 I BPRTYPE=8 S $P(BPSORT,U,2)=$S(Y=$P(BPS1,":"):BPS1,Y=$P(BPS2,":"):BPS2,Y=$P(BPS3,":"):BPS3,Y=$P(BPS4,":"):BPS4,1:BPS5)
 I Y="S" S BPCRON=$$ASKCRON() I BPCRON="^" Q -1
 ;
 ;Get Tertiary Sort
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S BPSEL=$$SRTORD($P($P(BPSORT,U,2),":"))
 S DIR(0)="SOB^"_BPSEL
 S DIR("A")="Tertiary Sort"
 S DIR("?")="Enter a code from the list to indicate the Tertiary sort order."
 D ^DIR K DIR
 I ($G(DUOUT)=1)!($G(DTOUT)=1) Q -1
 I BPRTYPE=9 S $P(BPSORT,U,3)=$S(Y=$P(BPS1,":"):BPS1,Y=$P(BPS2,":"):BPS2,Y=$P(BPS3,":"):BPS3,1:BPS4)
 I BPRTYPE=8 S $P(BPSORT,U,3)=$S(Y=$P(BPS1,":"):BPS1,Y=$P(BPS2,":"):BPS2,Y=$P(BPS3,":"):BPS3,Y=$P(BPS4,":"):BPS4,1:BPS5)
 I Y="S" S BPCRON=$$ASKCRON() I BPCRON="^" Q -1
 Q 0
 ;
 ;Ask if Date should be displayed in chronological order
ASKCRON() ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="Y"
 S DIR("A")="     Display oldest date first"
 S DIR("B")="YES"
 D ^DIR K DIR
 I ($G(DUOUT)=1)!($G(DTOUT)=1)!($D(DIRUT)) Q "^"
 Q Y
 ;
 ;Handle the sort order display
SRTORD(Y) ;
 I Y="N" S BPS1=""
 I Y="P" S BPS2=""
 I Y="S" S BPS3=""
 I Y="D" S BPS4=""
 I BPRTYPE=8,Y="E" S BPS5=""
 S BPSEL=BPS1_BPS2_BPS3_BPS4
 I BPRTYPE=8 S BPSEL=BPSEL_BPS5
 Q BPSEL
 ;
 ; Enter Date Range
 ;
 ; Return Value -> P1^P2
 ; 
 ;           where P1 = Earliest Date
 ;                    = ^ Exit
 ;                 P2 = Latest Date
 ;                    = blank for Exit
SELDATE() ;
 N BPSIBDT,DIR,DIRUT,DTOUT,DUOUT,VAL,X,Y
 S VAL="",DIR(0)="DA^:DT:EX",DIR("A")="EARLIEST DATE: "
 W ! D ^DIR
 ;
 ;Check for "^", timeout, or blank entry
 I ($G(DUOUT)=1)!($G(DTOUT)=1)!($G(X)="") S VAL="^"
 ;
 I VAL="" D
 .S $P(VAL,U)=Y
 .S DIR(0)="DA^"_VAL_":DT:EX",DIR("A")="  LATEST DATE: ",DIR("B")="T"
 .D ^DIR
 .;
 .;Check for "^", timeout, or blank entry
 .I ($G(DUOUT)=1)!($G(DTOUT)=1)!($G(X)="") S VAL="^" Q
 .;
 .;Define Entry
 .S $P(VAL,U,2)=Y
 ;
 Q VAL
 ;
 ;
 ;Device Selection
 ;Input: BPR = Routine
 ;       BPRTYPE = Report Type used to identify Task name
DEV(BPR,BPRTYPE) ;
 N %ZIS,ZTSK,ZTSAVE,POP,ZTRTN,ZTDESC
 S %ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . S ZTRTN=BPR,ZTDESC=$$RPTNAME(BPRTYPE),ZTSAVE("BP*")=""
 . D ^%ZTLOAD,HOME^%ZIS K IO("Q") W !,"QUEUED TASK #",ZTSK
 D @BPR
 Q
 ;
RPTNAME(BPRTYPE) ;
 ;Verify that a valid report has been requested
 Q $S(BPRTYPE=8:"Potential Claims Report for Dual Eligible",BPRTYPE=9:"Potential Secondary Rx Claims Report",1:"")
 ;
 ;Print the report Header
 ;Input: BPRTYPE = Report Type
HDR(BPRTYPE) ;
 ; BPG is assumed for page #
 Q:BPQUIT
 N DIR,X,Y,BPDIV
 I $E(IOST,1,2)="C-",BPG S DIR(0)="E" D ^DIR K DIR I $D(DIRUT)!($D(DUOUT)) S BPQUIT=1 K DIRUT,DTOUT,DUOUT Q
 S BPG=BPG+1
 W @IOF
 F X=1:1:IOM W "="
 W $$RPTNAME(BPRTYPE),"     ",$$FMTE^XLFDT($P(BPDT,U),"2D")," - ",$$FMTE^XLFDT($P(BPDT,U,2),"2D"),?IOM-10," Page: ",BPG
 W !,"Selected Divisions: "
 I 'BPPHARM W "ALL"
 I BPPHARM S X=0 F  S X=$O(BPPHARM(X)) Q:X=""  W $P(BPPHARM(X),U,2),"; "
 I BPRTYPE=8 D
 .W !,"Selected Patient Eligibility: "
 .I BPELIG1=0 W "ALL" Q
 .I $D(BPELIG1("C")) W "CHAMPVA"
 .I $D(BPELIG1("C")),$D(BPELIG1("T")) W "; "
 .I $D(BPELIG1("T")) W "TRICARE"
 W !,"Sorted By: "_$P($P(BPSORT,U),":",2)_" "_$P($P(BPSORT,U,2),":",2)_" "_$P($P(BPSORT,U,3),":",2)
 ; BPS*1*18:  Modify ePharmacy Screens/Reports to Include the Validated HPID/OEID
 W !,"'*' indicates the HPID/OEID failed validation checks"
 ; Write header for Potential Secondary Claims Rpt
 I BPRTYPE=9 D
 . ; BPS*1*18:  Modify ePharmacy Screens/Reports to Include the Validated HPID/OEID
 . W !,"Bill#",?11,"RX#",?21,"Fill",?26,"Patient",?36,"PatID",?42,"COB",?46,"Date",?55,"Payers",?69,"HPID/OEID",!
 ; Write header for Potential Dual Eligible Claims Rpt
 I BPRTYPE=8 D
 . ; BPS*1*18:  Modify ePharmacy Screens/Reports to Include the Validated HPID/OEID
 . W !,"RX#",?9,"Fill",?14,"Date",?22,"Patient",?37,"PatID",?43,"COB",?47,"Elig",?53,"Payers",?69,"HPID/OEID",!
 F X=1:1:IOM W "-"
 Q
 ;
SELELIG(BPELIG1) ;Select Eligibility Types
 N DIR,X
 ;
 S DIR(0)="SO^T:TRICARE;C:CHAMPVA;A:ALL"
 S DIR("A")="Display (T)RICARE or (C)HAMPVA or (A)LL Entries"
 S DIR("B")="A"
 ;
 S X=$$SELMULTI^BPSOPR(.DIR,.BPELIG1)
 Q X
 ;
