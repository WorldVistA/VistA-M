BPSRCRI  ;BHAM ISC/NSS - ECME REPORTS ;08-FEB-07
 ;;1.0;E CLAIMS MGMT ENGINE;**5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
 ;ECME Claims Response Inquiry Report
 ; 
 ;User input prompts
EN ; Routine entry point
 N BPCFILE,BP02,BP03,BPSCR,BPQ,BPX,BPVAX,ZTQUEUED
 S BPCFILE=9002313.02
 I $D(IOF) W @IOF
 W !,"ECME Claims-Response Inquiry Report",!
 ;
 ;User selects VA CLAIM ID
 S BP02=$$BPIEN(BPCFILE)
 I BP02=-1 G EXIT
 S BPVAX=$P(BP02,U,2),BP02=+BP02
 ;
 ;Select device
 I $$DEVICE=-1 G EXIT
 ;
 ;Run the reports
 D RUNRPT
 ;
 ;Prompt user to retrieve Claim IEN
 ;Input
 ;  BPCFILE (9002313.02) user inputs VA ID#
 ;Output
 ;  -1 (not found) or File IEN
BPIEN(BPCFILE) ; User is prompted for input, cross-ref "B" lookup
 N DIC,Y,DUOUT,DTOUT,DIROUT
 S DIC=$$ROOT^DILFD(BPCFILE)
 S DIC("A")="Select VA Claim ID: "
 S DIC(0)="ABEQ"
 D ^DIC
 I (Y=-1)!$D(DIROUT)!$D(DUOUT)!$D(DTOUT) Q -1
 Q Y
 ;
 ;Select the output Device
DEVICE() ; 
 N %ZIS,ZTSK,ZTRTN,ZTIO,ZTSAVE,ZTDESC,POP,BPQ
 S BPQ=0
 S %ZIS="QM"
 W !!,"Note: This report contains three separate sections - transaction data, claims"
 W !,"      data, and response data.  There will be a page break/form feed after"
 W !,"      each section regardless of the page length specified in the device input.",!
 D ^%ZIS
 I POP Q -1
 S BPSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 I $D(IO("Q")) D  S BPQ=-1
 . S ZTRTN="RUNRPT^BPSRCRI"
 . S ZTIO=ION
 . S ZTSAVE("*")=""
 . S ZTDESC="ECME CLAIMS RESPONSE INQUIRY REPORT"
 . D ^%ZTLOAD
 . W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 . D HOME^%ZIS
 U IO
 Q BPQ
 ;
 ; Print or display the report
RUNRPT ; 
 N BPLARR,BP57,BP59,BPQ
 D BPFLDS ; BPS TRANSACTIONS/LOG OF TRANSACTIONS
 D PRNTRPT
 Q
 ;
 ;Collect data from Transactions file #59 or Transactions Log file #57
BPFLDS ; Build BPLARR array of data
 N BPL0,BPL1,BP902
 S BP03=0,BPX=""
 ;Determine if claim is reversal or not
 I $D(^BPST("AE",BP02))!($D(^BPSTL("AE",BP02))) D
 . S BPX="AE" ;Not a reversal
 . S BPLARR(9)="  CLAIM IEN (c): "
 . S BPLARR(10)="RESPONSE IEN (c): "
 I BPX="",($D(^BPST("AER",BP02))!($D(^BPSTL("AER",BP02)))) D
 . S BPX="AER" ;Reversal
 . S BPLARR(10)="REVERSAL RESPONSE IEN (c): "
 . S BPLARR(9)="  REVERSAL CLAIM IEN (c): "
 I BPX="" Q
 S (BP57,BP59)=0
 S BP59=$O(^BPST(BPX,BP02,""),-1)
 I BP59="" S BP59=0
 ;
 I BP59'=0 D  ;Find claim in BPS Transactions file
 . S BPL0=$G(^BPST(BP59,0)),BPL1=$G(^BPST(BP59,1))
 . I BPX="AE" S BP03=$P($G(^BPST(BP59,0)),U,5)
 . I BPX="AER" S BP03=$P($G(^BPST(BP59,4)),U,2)
 . S BPLARR(4)="PRESCRIPTION #: "_+$$GET1^DIQ(9002313.59,BP59,1.11)
 . D GETS^DIQ(9002313.59902,1_","_BP59,"902;902.24;902.27","E","BP902","ERROR")
 . S BPLARR(7)="  PLAN NAME: "_$G(BP902(9002313.59902,"1,"_BP59_",",902.24,"E"))
 . S BPLARR(8)="PHARMACY PLAN ID: "_$G(BP902(9002313.59902,"1,"_BP59_",",902.27,"E"))
 ;
 I BP59=0 D  ;;Find claim in BPS Log of Transactions file
 . S BP57=$O(^BPSTL(BPX,BP02,""),-1)
 . I BP57="" S BP57=0 Q
 . S BPL0=$G(^BPSTL(BP57,0)),BPL1=$G(^BPSTL(BP57,1)),BP59=$P($G(BPL0),U)
 . I BPX="AE" S BP03=$P($G(^BPSTL(BP57,0)),U,5)
 . I BPX="AER" S BP03=$P($G(^BPSTL(BP57,4)),U,2)
 . S BPLARR(4)="PRESCRIPTION #: "_+$$GET1^DIQ(9002313.57,BP57,1.11)
 . D GETS^DIQ(9002313.57902,1_","_BP57,"902;902.24;902.27","E","BP902","ERROR")
 . S BPLARR(7)="  PLAN NAME: "_$G(BP902(9002313.59902,"1,"_BP57_",",902.24,"E"))
 . S BPLARR(8)="PHARMACY PLAN ID: "_$G(BP902(9002313.59902,"1,"_BP57_",",902.27,"E"))
 ;
 I BP59=0,BP57=0 Q
 ;Build rest of array components
 S BPLARR(1)="ENTRY#: "_BP59
 S BPLARR(2)="STATUS: "_+$P($G(BPL0),U,2)
 S BPX=$P($G(BPL1),U,7)
 S BPLARR(3)="  PHARMACY: "_$P($G(^BPS(9002313.56,+BPX,0)),"^")
 S BPLARR(5)="  RXI-INTERNAL (c): "_$P($G(BPL1),U,11)
 S BPLARR(9)=BPLARR(9)_BP02
 S BPLARR(10)=BPLARR(10)_BP03
 Q
 ;
PRNTRPT ; Output the reports
 N BPQ,ZTREQ
 S BPQ=0
 W @IOF
 D CHKP(1) I BPQ Q
 W "ECME Claims-Response Inquiry Report"
 W ?48,"Print Date: "_$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
 W !,"VA CLAIM ID: "_BPVAX,!
 D PRTTRANS ; BPS Transaction (or Transaction log) file fields
 I 'BPSCR W !,@IOF
 E  I 'BPQ D PAUSE
 Q:BPQ
 D PRT02 ; BPS CLAIMS FILE
 I 'BPSCR W !,@IOF
 E  I 'BPQ D PAUSE
 Q:BPQ
 D PRT03 ; BPS RESPONSE FILE
 Q:BPQ
 I 'BPSCR W !,@IOF
 E  I 'BPQ D PAUSE2
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 Q
 ;
 ; Display transaction log fields
PRTTRANS ; Print transaction file report
 W !,"BPS TRANSACTION/BPS LOG OF TRANSACTION DATA: ",!
 I BPX="" W !,"NO TRANSACTION MATCHES FOUND",!! Q
 ;
 ;Loop through the array
 N BPX
 S BPX=0 F  S BPX=$O(BPLARR(BPX)) Q:'BPX  D  I BPQ Q
 . D CHKP(1) I BPQ Q
 . I BPX=1 W !,BPLARR(BPX) Q
 . I BPX#2=0 W ?40,BPLARR(BPX) Q
 . W !,BPLARR(BPX)
 Q
 ;
 ;Run claim file data report #9002313.02
PRT02  ; Claims file output
 W !,"BPS CLAIMS FILE DATA: "
 N DIC,DR,DA,DIQ,DTOUT,DIRUT
 S DIC=$$ROOT^DILFD(BPCFILE),DA=BP02
 I $D(IOF) W @IOF
 D EN^DIQ
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S BPQ=1
 Q
 ;
 ;Run response file data report #9002313.03
PRT03 ; Response file output
 W !!,"BPS RESPONSE FILE DATA: ",!
 I BP03=0!(BP03="") W !,"NO RESPONSE FILE DATA FOUND",!! Q
 N DIC,DR,DA,DIQ,DTOUT,DIRUT
 S DIC=$$ROOT^DILFD(9002313.03),DA=BP03
 D EN^DIQ
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S BPQ=1
 Q
 ;
 ;Check for End of Page
 ; Input variable -> BPLINES - Number of lines from bottom
 ;                      CONT - 0 = New Entry, 1 = Continue Entry
CHKP(BPLINES) ;
 S BPLINES=BPLINES+1
 I $G(BPSCR) S BPLINES=BPLINES+1
 I $Y>(IOSL-BPLINES) D:$G(BPSCR) PAUSE Q:$G(BPQ) 0 Q 1
 Q 0
 ;
PAUSE ;
 N X
 U IO(0)
 R !!,"Press RETURN to continue, '^' to exit: ",X:DTIME
 I '$T S X="^"
 I X["^" S BPQ=1
 U IO
 Q
 ;
PAUSE2 ;
 N X
 U IO(0)
 R !,"Press RETURN to continue: ",X:DTIME
 U IO
 Q
 ;
 ;EXIT
EXIT ;
 Q
 ;
