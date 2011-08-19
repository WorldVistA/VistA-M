PSXBPSUT ;BIR/MFR - BPS (ECME) Utilities ;13 Mar 2002  10:31 AM
 ;;2.0;CMOP;**48,63,65,69**;11 Apr 97;Build 60
 ;Reference to ^PS(52.5, supported by DBIA #1978
 ;Reference to ^PSOSULB1 supported by DBIA #2478
 ;
XMIT(REC) ; Checks if the prescription will be transmitted to CMOP or not
 ; Input:  REC  - Pointer to SUSPENSE file (#52.5)
 ; Output: XMIT - 0 - NO  /  1 - YES 
 N VADM,DFN,RX,PSXOK,PSXBAOK
 I '$D(^PS(52.5,REC,0)) Q 0
 I $P(^PS(52.5,REC,0),"^",7)="" Q 0
 S RX=$P($G(^PS(52.5,REC,0)),"^",1) I RX="" Q 0
 S DFN=$$GET1^DIQ(52,RX,2,"I") D DEM^VADPT I $G(VADM(6))'="" Q 0
 I ($P(^PS(52.5,REC,0),"^",3)'=DFN) Q 0
 S PSXOK=0 D CHKDATA^PSXMISC1 I PSXOK Q 0
 I '$$ADDROK^PSXMISC1(RX) Q 0  ;for PSX*2*69
 Q 1
 ;
EXCEL() ; - Returns whether to capture data for Excel report.
 ; Output: EXCEL = 1 - YES (capture data) / 0 - NO (DO NOT capture data)
 ;
 N EXCEL,DIR,DIRUT,DTOUT,DUOUT,DIROUT,Y
 ;
 S DIR(0)="Y",DIR("B")="NO",DIR("T")=DTIME W !
 S DIR("A")="Do you want to capture report data for an Excel document"
 S DIR("?")="^D HEXC^PSXBPSUT"
 D ^DIR K DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q "^"
 K DIROUT,DTOUT,DUOUT,DIRUT
 S EXCEL=0 I Y S EXCEL=1
 ;
 ;Display Excel display message
 I EXCEL=1 D EXMSG
 ;
 Q EXCEL
 ;
HEXC ; - 'Do you want to capture data...' prompt
 W !!,"      Enter:  'Y'    -  To capture detail report data to transfer"
 W !,"                        to an Excel document"
 W !,"              '<CR>' -  To skip this option"
 W !,"              '^'    -  To quit this option"
 Q
 ;
 ;Display the message about capturing to an Excel file format
 ; 
EXMSG ;
 W !!?5,"Before continuing, please set up your terminal to capture the"
 W !?5,"detail report data. On some terminals, this can  be  done  by"
 W !?5,"clicking  on the 'Tools' menu above, then click  on  'Capture"
 W !?5,"Incoming  Data' to save to  Desktop. This  report  may take a"
 W !?5,"while to run."
 W !!?5,"Note: To avoid  undesired  wrapping of the data  saved to the"
 W !?5,"      file, please enter '0;256;999' at the 'DEVICE:' prompt.",!
 Q
 ;
