PSXERR ;BIR/BAB,WPB,HTW,PWC-Error Processing Utility ;MAR 1,2002@13:13:34
 ;;2.0;CMOP;**1,3,28,30,42,41,52,54,58**;11 Apr 97;Build 2
 ; Reference to ^PS(59,  supported by DBIA #1976
 ; Reference to file #52 supported by DBIA #1977
 ; This routine will be used to send mail messages when errors
 ; have occurred during the processing of prescription data for
 ; the Consolidated Mail Outpatient Pharmacy system.
EN S ERRTXT(1)="An error has been encountered while processing prescription data for the"
 S ERRTXT(2)="Consolidated Mail Outpatient Pharmacy system."
 S X=PSXJOB,XMSUB="CMOP Error Encountered"
 I $G(PSOSITE) S XMSUB=$$GET1^DIQ(59,PSOSITE,.06)_" "_XMSUB
 S XY=$S(X=1:"Transmission of Batch Data",X=2:"Re-Transmission of Batch Data",X=3:"Purge of CMOP RX QUEUE file",X=4:"Filing of CMOP Dispense Data",X=5:"Background Auto-transmission of Data",X=6:"Release Data",X=7:"Data Validation",1:"")
 D NOW^%DTC S Y=% X ^DD("DD") S DTTM=$P(Y,":",1,2) K Y
 S ERRTXT(3)=""
 S ERRTXT(4)="Date/Time    :  "_DTTM
 S ERRTXT(5)="Process      :  "_XY
 S ERRTXT(6)="Error Type   :  "_TYPE
 S ERRTXT(7)=""
 S ERRTXT(8)="Description  :  "_$G(DESCRTN)
 S ERRTXT(9)=""
 S ERRTXT(PSXCT+2)="Action Taken:  "_ACTION,ERRTXT(PSXCT+3)=""
 S ERRTXT(PSXCT+4)="Recommended action:  "_RECM
 D MAIL
EXIT K ERRTXT,PSXM,PSXCT,PSXGRP,XMSUB,XMY,XMTEXT,XMDUZ,%,XMDUN,XMZ,ACTION,DESCRTN,DTTM,ERROR,FILL,FLG,MSG,P1,P2,PSXCT,RECM,RXP,TYPE,X,PSXJOB,PSXREF,XY
 Q
ER1 ;errors encountered while building the mail message for transmission
 Q:$P($G(PSXER),"^",2)=""
 S ERRTXT(10)="The following data is missing in the OUTPATIENT SITE file (#59).",ERRTXT(11)=""
 S PSXCT=11,PSXCT=PSXCT+1,PSXJOB=1
 F XX=2:1 Q:$P(PSXER,"^",XX)=""  D
 .S ERR=$P(PSXER,"^",XX),PSXCT=PSXCT+1,MSG=$P($T(DERR+ERR),";;",2) S ERRTXT(PSXCT)=MSG
 S PSXCT=PSXCT+1,ERRTXT(PSXCT)=""
 S PSXERFLG=1,ACTION="No data transmission will occur without this information.",RECM="Correct invalid data.",TYPE="Invalid or missing data"
 D EN
 Q
ER2 ;errors encountered while building the mail message for retransmission
 S P1=$P($G(PSXERR),U,1),P2=$P($G(PSXERR),U,2)
 S ERROR=$P($T(DATAERR+10),";;",2)
 I P1=2 S PSXCT=PSXCT+1,ERRTXT(PSXCT)=$P($G(ERROR),"^",1)_$P($G(ERROR),"^",P2)
 S PSXCT=PSXCT+1,ERRTXT(PSXCT)=""
 S PSXCT=PSXCT+1,ERRTXT(PSXCT)=$S(P2=5:"The retransmitted batch will be placed in a hold status.  Please release the correct batch when ready.",P2'=5:"The retransmitted batch was not downloaded into the files.",1:"")
 K PSXERR
 Q
ER4 S PSXCT=11
 S RECM="Call IRM to check data and correct"
 S TYPE="Missing Data - No match found for return data."
 S ACTION="Return data not filed for Rx listed, background release not performed."
 S ERRTXT(PSXCT)=" RX#    FILL#    BATCH#   SEQUENCE#  "
 F I=1:1 S PSXCT=PSXCT+1 Q:$G(PSXER(I))']""  S ERRTXT(PSXCT)=PSXER(I)
 D EN
 K PSXER,I
 Q
ER6 S PSXCT=11
 S RECM="Call IRM to check data and correct"
 S TYPE="Invalid data "
 S DESCRTN="During processing of Vendor return data, CMOP attempted to release the following Rx.  This Rx has already been Released locally!.  This will invalidate your stock levels for this drug!"
 S ACTION="Rx was not released by CMOP."
 S ERRTXT(PSXCT)="RX#  "_$P(^PSRX(RXP,0),"^")_"     FILL#  "_$G(PSXREF)
 D EN
 Q
ER7 ;Set up prescription data for message.
 Q:$P($G(PSXRXERR),"^",3)=""
 N DFN,RX,VA
 S ERRTXT(10)="RX #       Fill       Data Field         SSN          NAME"
 S ERRTXT(11)=""
 S:PSXERFLG=0 PSXCT=11
 S RXNM=$P(PSXRXERR,"^",1),FILL=$P(PSXRXERR,"^",2)
 S RXF=$S(FILL=0:"Original ",FILL>0:"Refill #"_FILL,1:"")
 S PSXCT=PSXCT+1,FLG=0,BLANK=$J(" ",50)
 F XX=3:1 Q:$P(PSXRXERR,"^",XX)=""  D
 .S RX(2,"E")=$$GET1^DIQ(52,RXN,2)      ; patient name
 .S RX(2,"I")=$$GET1^DIQ(52,RXN,2,"I")  ; DFN
 .S DFN=RX(2,"I") D PID^VADPT
 .S ERR=$P(PSXRXERR,"^",XX),PSXCT=PSXCT+1,CNT=ERR-1
 .S MSG=$P($T(DATAERR+CNT),";;",2)
 .I FLG=0 S ERRTXT(PSXCT)=RXNM_"  "_RXF_"  "_$E(MSG_BLANK,1,17)_"  "_VA("PID")_" "_(RX(2,"E")),FLG=1 Q
 .I FLG=1 S ERRTXT(PSXCT)="                         "_MSG,FLG=1 Q
 S PSXCT=PSXCT+1,ERRTXT(PSXCT)=""
 K PSXRXERR,RXNM,RXF,DAYS,CNT,ERR,DRUG,FDATE,PHAR,PHY,PSTAT,QTY,REF,RXERR,SIG,XX,BLANK
 S PSXERFLG=1,ACTION="Rx's not sent to CMOP but still suspended for transmission.",RECM="Correct invalid data.",TYPE="Invalid or missing data"
 I '$G(PSXGOOD) S ACTION="Rx's not sent to CMOP. If Bad Address Indicator or foreign address, will remain on suspense for CMOP, but will only show on reject log once." K PSXGOOD
 Q
MAIL ;Transmit.
 S XMDUZ=.5,XMTEXT="ERRTXT("
 K XMY ; get mail group to notify and save in PSXGRP
 D GRP^PSXNOTE
 D ^XMD
 Q
 ;
DATAERR ;list of errrors that can occur while checking the rx prior to transmit
 ;;Quantity
 ;;Prescribing Physician
 ;;Days supply
 ;;Drug id
 ;;SIG
 ;;Patient status
 ;;Fill date
 ;;Clerk not entered
 ;;Patient Address
 ;;Original batch ^not on file.^is currently processing.^is closed.^is already on hold.
 ;;Fill has already been transmitted
 ;;Spaces in Rx number
 ;;Duplicate Rx
 ;;Patient Mail Status Change
 ;;Drug Warnings >11 Characters
 ;;Patient in the Merging Process
 ;;RX OERR/CPRS Locked
 ;;Test Patient
 ;;Bad Address Indicator no active temporary address
DERR ;list of errors for transmission
 ;;State
 ;;Site
 ;;Name
 ;;Street Address
 ;;City
 ;;Zip Code
 ;;Area Code
 ;;Phone Number
 ;;Refillable Instructions
 ;;Nonrefillable Instructions
 ;;Station number is missing in the Institution file
 ;;Package file entry for Outpatient Pharmacy is bad
 Q
