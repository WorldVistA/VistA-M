RCDPTPLI ;WISC/RFJ - transaction profile init to build array ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,153,365,372,392**;Mar 20, 1995;Build 10
 ;;Per VA Directive 6402, this routine should not be modified.
 ; Reference to FILE #350 in ICR #4541
 Q
 ;
 ;
INIT ;  initialization for list manager list
 ;  requires rctranda
 N %,COMMDA,DATA,DATA3,DATA8,RCDPDATA,RCFYDA,RCLINE,RCSPACE,RCX,SHOWBAL,SHOWCOL,TOTAL3,TOTAL8,TRANTYPE,RCTOC
 K ^TMP("RCDPTPLM",$J),^TMP("VALM VIDEO",$J)
 ;
 D DIQ433^RCDPTPLM(RCTRANDA,".01;.03;5.02;5.03;11;12;13;14;15;17;19;42;86;88;")
 S TRANTYPE=RCDPDATA(433,RCTRANDA,12,"I")
 ;
 S RCSPACE="",$P(RCSPACE," ",81)=""
 ;
 ;  set the listmanager line number 1
 S RCLINE=1
 D SET("Transaction",RCLINE,1,40,.01)
 D SET("Type",RCLINE,41,80,12)
 ;
 S RCLINE=RCLINE+1
 D SET("  TransDate",RCLINE,1,80,11)
 ;  increase/decrease adjustment
 I TRANTYPE=1!(TRANTYPE=35) D
 .   I RCDPDATA(433,RCTRANDA,88,"I") D SET("Contract Adj",RCLINE,47,80)
 .   D SET("Adjustment",RCLINE,64,80,14)
 ;  payment
 I TRANTYPE=2!(TRANTYPE=34) D SET("Receipt",RCLINE,38,80,13)
 ;  terminated
 I TRANTYPE=8!(TRANTYPE=9) D SET("TermReason",RCLINE,35,80,17)
 ;
 S RCLINE=RCLINE+1
 D SET("  Processed",RCLINE,1,80,19)
 D SET("  By",RCLINE,41,80,42)
 ;
 S RCLINE=RCLINE+1
 D SET("  Trans Amt: "_$J(RCDPDATA(433,RCTRANDA,15,"E"),0,2),RCLINE,1,80)
 ;
 S RCLINE=RCLINE+1 D SET(" ",RCLINE,1,80)
 ;
 ;  fiscal year multiple
 S RCLINE=RCLINE+1
 D SET("Fiscal Year",RCLINE,28,40,0,IOUON,IOUOFF)
 D SET("Principal Amount",RCLINE,44,60,0,IOUON,IOUOFF)
 D SET("FY Trans Amount",RCLINE,64,80,0,IOUON,IOUOFF)
 S RCFYDA=0 F  S RCFYDA=$O(^PRCA(433,RCTRANDA,4,RCFYDA)) Q:'RCFYDA  D
 .   S DATA=$G(^PRCA(433,RCTRANDA,4,RCFYDA,0))
 .   S RCLINE=RCLINE+1
 .   D SET($J($P(DATA,"^"),38),RCLINE,1,80)     ;fiscal year
 .   D SET($J($P(DATA,"^",2),19,2),RCLINE,41,60)   ;prin amt
 .   D SET($J($P(DATA,"^",5),19,2),RCLINE,60,80)   ;fy trans amt
 ;
 ;  admin cost/charge
 I TRANTYPE=12!(TRANTYPE=13)!(TRANTYPE=14) D
 .   S RCLINE=RCLINE+1 D SET(" ",RCLINE,1,80)
 .   S DATA=$P($G(^PRCA(433,RCTRANDA,2)),"^",1,9)
 .   I $TR(DATA,"^0")="" Q
 .   S RCLINE=RCLINE+1 D SET("Administrative Cost Charge:",RCLINE,1,80,0,IOUON,IOUOFF)
 .   I $P(DATA,"^",1) S RCLINE=RCLINE+1 D SET("    IRS Locator: "_$J($P(DATA,"^",1),10,2),RCLINE,1,80)
 .   I $P(DATA,"^",2) S RCLINE=RCLINE+1 D SET("  Credit Agency: "_$J($P(DATA,"^",2),10,2),RCLINE,1,80)
 .   I $P(DATA,"^",3) S RCLINE=RCLINE+1 D SET("    DMV Locator: "_$J($P(DATA,"^",3),10,2),RCLINE,1,80)
 .   I $P(DATA,"^",4) S RCLINE=RCLINE+1 D SET("   Consumer Rep: "_$J($P(DATA,"^",4),10,2),RCLINE,1,80)
 .   I $P(DATA,"^",5) S RCLINE=RCLINE+1 D SET("   Marshall Fee: "_$J($P(DATA,"^",5),10,2),RCLINE,1,80)
 .   I $P(DATA,"^",6) S RCLINE=RCLINE+1 D SET("     Court Cost: "_$J($P(DATA,"^",6),10,2),RCLINE,1,80)
 .   I $P(DATA,"^",7) S RCLINE=RCLINE+1 D SET("Interest Charge: "_$J($P(DATA,"^",7),10,2),RCLINE,1,80)
 .   I $P(DATA,"^",8) S RCLINE=RCLINE+1 D SET("   Admin Charge: "_$J($P(DATA,"^",8),10,2),RCLINE,1,80)
 .   I $P(DATA,"^",9) S RCLINE=RCLINE+1 D SET(" Penalty Charge: "_$J($P(DATA,"^",9),10,2),RCLINE,1,80)
 ;
 ;
 ;  collections and balances
 ;  set flag to display balances if there are any
 S DATA8=$P($G(^PRCA(433,RCTRANDA,8)),"^",1,5)
 S SHOWBAL=1 I $TR(DATA8,"^0")="" S SHOWBAL=0
 ;  set flag to display collections if there are any
 S DATA3=$P($G(^PRCA(433,RCTRANDA,3)),"^",1,5)
 S SHOWCOL=1 I $TR(DATA3,"^0")="" S SHOWCOL=0
 ;  show data
 I SHOWBAL!(SHOWCOL) D
 .   S RCLINE=RCLINE+1 D SET(" ",RCLINE,1,80)
 .   F %=1:1:5 S TOTAL3=$G(TOTAL3)+$P(DATA3,"^",%),TOTAL8=$G(TOTAL8)+$P(DATA8,"^",%)
 .   S RCLINE=RCLINE+1 D SET("Balances",RCLINE,19,26,0,IOUON,IOUOFF)
 .   I SHOWCOL D SET("Collections",RCLINE,34,55,0,IOUON,IOUOFF)
 .   S RCLINE=RCLINE+1 D SET("     Principal: "_$J($P(DATA8,"^",1),10,2),RCLINE,1,80)
 .   I SHOWCOL D SET($J($P(DATA3,"^",1),10,2),RCLINE,35,55)
 .   S RCLINE=RCLINE+1 D SET("      Interest: "_$J($P(DATA8,"^",2),10,2),RCLINE,1,80)
 .   I SHOWCOL D SET($J($P(DATA3,"^",2),10,2),RCLINE,35,55)
 .   S RCLINE=RCLINE+1 D SET("Administrative: "_$J($P(DATA8,"^",3),10,2),RCLINE,1,80)
 .   I SHOWCOL D SET($J($P(DATA3,"^",3),10,2),RCLINE,35,55)
 .   S RCLINE=RCLINE+1 D SET("  Marshall Fee: "_$J($P(DATA8,"^",4),10,2),RCLINE,1,80)
 .   I SHOWCOL D SET($J($P(DATA3,"^",4),10,2),RCLINE,35,55)
 .   S RCLINE=RCLINE+1 D SET("    Court Cost: "_$J($P(DATA8,"^",5),10,2),RCLINE,1,80,0,IOUON,IOUOFF)
 .   I SHOWCOL D SET($J($P(DATA3,"^",5),10,2),RCLINE,35,55,0,IOUON,IOUOFF)
 .   S RCLINE=RCLINE+1 D SET("         Total: "_$J(TOTAL8,10,2),RCLINE,1,80)
 .   I SHOWCOL D SET($J(TOTAL3,10,2),RCLINE,35,55)
 ;
 ;  brief comments, followup date
 S RCLINE=RCLINE+1 D SET(" ",RCLINE,1,80)
 S RCLINE=RCLINE+1 D SET("Brief Comment",RCLINE,1,80,5.02)
 D SET("Follow-up Date",RCLINE,51,80,5.03)
 ;
 ;  comments
 S RCLINE=RCLINE+1 D SET(" ",RCLINE,1,80)
 S RCLINE=RCLINE+1 D SET("Comments:",RCLINE,1,80,0,IOUON,IOUOFF)
 I RCDPDATA(433,RCTRANDA,86,"E")'="" S RCLINE=RCLINE+1 D SET("",RCLINE,1,80,86)
 S COMMDA=0 F  S COMMDA=$O(^PRCA(433,RCTRANDA,7,COMMDA)) Q:'COMMDA  D
 .   S RCX=^PRCA(433,RCTRANDA,7,COMMDA,0)
 .   S RCLINE=RCLINE+1 D SET($E(RCX,1,79),RCLINE,1,80)
 .   I $E(RCX,80,159)'="" S RCLINE=RCLINE+1 D SET($E(RCX,80,159),RCLINE,1,80)
 .   I $E(RCX,160,239)'="" S RCLINE=RCLINE+1 D SET($E(RCX,160,239),RCLINE,1,80)
 S RCLINE=RCLINE+1 D SET(" ",RCLINE,1,80)
 ;
 ;  show integrated billing data
 N BILLCAT,BILLDA,BILLNO,IBATYP,IBDA,IBZ,N0,RCDSPFLG,TMPDT,TRCARE
 S BILLDA=+$P(^PRCA(433,RCTRANDA,0),"^",2),TRCARE=0
 S N0=$G(^PRCA(430,BILLDA,0)),BILLNO=$P(N0,U),BILLCAT=$P(N0,U,2)  ; PRCA*4.5*392
 ;
 ;PRCA*4.5*365 - moved vaild AR Category check to the field DISPLAY ON BILL PROFILE? field
 ;               in the AR Category (430.2) file.  If RCDSPFLG contains NULL or 0, no IB info
 ;               will display.  Otherwise it contains a code that will determine what info is
 ;               displayed.
 S RCDSPFLG=$$GET1^DIQ(430.2,BILLCAT_",",1.04,"I")
 I BILLCAT=18 D
 .S RCTOC=$P(^PRCA(430,BILLDA,0),"^",16)
 .S RCDSPFLG=$$GET1^DIQ(430.2,RCTOC_",",1.04,"I")
 .Q
 I BILLCAT=31 D  ; Tricare Patient category is a special case  PRCA*4.5*392
 .S IBZ=$O(^IB("ABIL",BILLNO,""),-1)  ; get last IB action
 .S IBATYP=$$GET1^DIQ(350,IBZ_",",.03,"I")  ; get IB action type (file 350.1 ien)
 .I "^68^71^"[(U_IBATYP_U) S RCDSPFLG=5,TRCARE=1  ; Tricare RX
 .I "^69^72^"[(U_IBATYP_U) S RCDSPFLG=2,TRCARE=1  ; Tricare outpatient
 .I "^70^73^"[(U_IBATYP_U) S RCDSPFLG=4,TRCARE=1  ; Tricare inpatient
 .Q
 I +$G(RCDSPFLG) D
 .D STMT^IBRFN1(RCTRANDA)
 .I '$D(^TMP("IBRFN1",$J)) Q
 .;  start on 2nd screen if not there already
 .F RCLINE=RCLINE:1:15 D SET(" ",RCLINE,1,80)
 .S RCLINE=RCLINE+1 D SET("Integrated Billing Data",RCLINE,1,80,0,IOUON,IOUOFF)
 .S IBDA=0 F  S IBDA=$O(^TMP("IBRFN1",$J,IBDA)) Q:'IBDA  D
 ..S DATA=^TMP("IBRFN1",$J,IBDA)
 ..;Start PRCA*4.5*372
 ..; If piece 7 is not filled in, and it is a pharmacy transaction, the transaction was manually created.  Treat like a CC RX.
 ..I RCDSPFLG=1,$P(DATA,U,7)="" S RCDSPFLG="MVA"
 ..;end PRCA*4.5*372
 ..;if more than one ib data transaction to display, skip a line
 ..I IBDA>1 S RCLINE=RCLINE+1 D SET(" ",RCLINE,1,80)
 ..S RCLINE=RCLINE+1 D SET("IB Ref #: "_$P(DATA,"^"),RCLINE,1,80)
 ..;  show VA RX via ECME (RCDSPFLG=1)
 ..I RCDSPFLG=1 D  Q
 ...D SET("Pharmacy",RCLINE,28,80)
 ...D SET("Charge Amt: "_$J($P(DATA,U,8),0,2),RCLINE,60,80)
 ...S RCLINE=RCLINE+1
 ...D SET("     Rx#: "_$P(DATA,U,2),RCLINE,1,80)
 ...D SET("Drug: "_$P(DATA,U,3),RCLINE,22,80)
 ...S TMPDT=$$FMTE^XLFDT($P(DATA,U,7),"2DZ") D SET("Re/Fill Date: "_TMPDT,RCLINE,58,80)  ; PRCA*4.5*392
 ...S RCLINE=RCLINE+1
 ...D SET("                Physician: "_$P(DATA,U,5),RCLINE,1,48)
 ...D SET("Days Supply: "_$P(DATA,U,4),RCLINE,48,80)
 ...D SET("Qty: "_$P(DATA,U,6),RCLINE,67,80)
 ...Q
 ..;  show outpatient (type of care 430.2 = 4 outpatient care), OR RCDSPFLG=2 (Other Outpatient) or 5 (CC RX)
 ..;Start PRCA*4.5*372
 ..;Manually billed RX
 ..I RCDSPFLG="MVA" D  Q
 ...D SET("Pharmacy",RCLINE,25,80)
 ...S TMPDT=$$FMTE^XLFDT($P(DATA,U,3),"2DZ") D SET("Fill Date: "_TMPDT,RCLINE,38,80)  ; PRCA*4.5*392
 ...D SET("Charge Amt: "_$J($P(DATA,U,8),0,2),RCLINE,60,80)
 ...Q
 ..;end PRCA*4.5*372
 ..I ($P(^PRCA(430,BILLDA,0),U,16)=4)!(RCDSPFLG=2)!(RCDSPFLG=5) D  Q
 ...;Start PRCA*4.5*372
 ...I RCDSPFLG=5 D  Q
 ....D SET($S(TRCARE:"Tricare RX",1:"Comm Care RX"),RCLINE,25,80)  ; PRCA*4.5*392
 ....I TRCARE S $P(DATA,U,3)=$P(DATA,U,2)  ; special case for Tricare RX - move fill date to the correct piece  PRCA*4.5*392
 ....S TMPDT=$$FMTE^XLFDT($P(DATA,U,3),"2DZ") D SET("Fill Date: "_TMPDT,RCLINE,38,80)  ; PRCA*4.5*392
 ....D SET("Charge Amt: "_$J($P(DATA,U,8),0,2),RCLINE,60,80)
 ....Q
 ...;end PRCA*4.5*372
 ...D SET("Outpatient",RCLINE,26,80)
 ...S TMPDT=$$FMTE^XLFDT($P(DATA,U,2),"2DZ") D SET("Visit Date: "_TMPDT,RCLINE,37,80)  ; PRCA*4.5*392
 ...D SET("Charge Amt: "_$J($P(DATA,U,8),0,2),RCLINE,60,80)
 ...Q
 ..;Start PRCA*4.5*372
 ..;  show inpatient  [ RCDSPFLG=3 (LTC) or 4 (inpatient) ]
 ..D:RCDSPFLG=3 SET("Long Term Care",RCLINE,28,80)
 ..D:RCDSPFLG'=3 SET("Inpatient",RCLINE,28,80)
 ..;end PRCA*4.5*372
 ..D SET("Charge Amt: "_$J($P(DATA,U,8),0,2),RCLINE,60,80)
 ..S RCLINE=RCLINE+1
 ..S TMPDT=$$FMTE^XLFDT($P(DATA,U,2),"2DZ") D SET("          Admission Date: "_TMPDT,RCLINE,1,80)  ; PRCA*4.5*392
 ..S TMPDT=$$FMTE^XLFDT($P(DATA,U,5),"2DZ") D SET("Discharge Date: "_TMPDT,RCLINE,56,80)  ; PRCA*4.5*392
 ..S RCLINE=RCLINE+1
 ..S TMPDT=$$FMTE^XLFDT($P(DATA,U,3),"2DZ") D SET("   Bill Cycle Begin Date: "_TMPDT,RCLINE,1,80)
 ..S TMPDT=$$FMTE^XLFDT($P(DATA,U,4),"2DZ") D SET("End Date: "_TMPDT,RCLINE,62,80)
 ..Q
 .K ^TMP("IBRFN1",$J)
 .Q
 ;  set valmcnt to number of lines in the list
 S VALMCNT=RCLINE
 Q
 ;
 ;
SET(STRING,LINE,COLBEG,COLEND,FIELD,ON,OFF) ;  set array
 I $G(FIELD) S STRING=STRING_$S(STRING="":"",1:": ")_$G(RCDPDATA(433,RCTRANDA,FIELD,"E"))
 I STRING="",'$G(FIELD) Q
 I '$D(@VALMAR@(LINE,0)) D SET^VALM10(LINE,$J("",80))
 D SET^VALM10(LINE,$$SETSTR^VALM1(STRING,@VALMAR@(LINE,0),COLBEG,COLEND-COLBEG+1))
 I $G(ON)]""!($G(OFF)]"") D CNTRL^VALM10(LINE,COLBEG,$L(STRING),ON,OFF)
 Q
 ;
