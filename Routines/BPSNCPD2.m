BPSNCPD2 ;BHAM ISC/LJE - Continuation of BPSNCPDP (IB Billing Determination) ;11/7/07  16:01
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,6,7,8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;External reference $$RX^IBNCPDP supported by DBIA 4299
 ;External reference to $$NCPDPQTY^PSSBPSUT supported by IA4992
 ;
 ;
 ; EN - Call IB Billing Determination.  If good to go, update MOREDATA array
 ; Notes about variables
 ;input:
 ;   DFN - PATIENT file #2 ien
 ;   BWHERE - shows where the code is called from and what needs to be done
 ;   the following should be passed by reference:
 ;   MOREDATA - Initialized by BPSNCPDP and more data is added here
 ;   BPSARRY  - Created by STARRAY^BPSNCPD1 and used for IB Determination
 ;   IB    - Returned to BPSNCPDP
 ;   CERTIEN - BPS Certification IEN - Not passed but newed/set in BPSNCPDP
 ;
EN(DFN,BWHERE,MOREDATA,BPSARRY,IB) ;
 I '$G(CERTIEN) D  I IB=2 Q
 . ;
 . ;For NCPDP IB call to see if we need to 3rd Party Bill and if so, get insurance/payer sheet info
 . S MOREDATA("BILL")=$$RX^IBNCPDP(DFN,.BPSARRY)  ;IB CALL
 . Q:'$D(MOREDATA("BILL"))
 . ;
 . ; If calling program is the ECME user screen and we can't bill because of NEEDS SC DETERMINATION
 . ; or EI, then prompt the user to see if they want to bill
 . I BWHERE="ERES",$P(MOREDATA("BILL"),U,1)=0,$G(BPSARRY("SC/EI NO ANSW"))]"",$G(BPJOBFLG)'="B" D
 .. N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,I,BPEISC
 .. F I=1:1:$L($G(BPSARRY("SC/EI NO ANSW")),",") S BPEISC=$P($G(BPSARRY("SC/EI NO ANSW")),",",I) I BPEISC]"" D
 ... W !,"The prescription is potentially ",BPEISC,"-related and needs ",BPEISC," determination."
 ... W !,"Prescriptions related to ",BPEISC," cannot be billed to Third Party Insurance.",!
 .. S DIR(0)="Y",DIR("A")="Are you sure you want to bill this prescription"
 .. S DIR("B")="NO"
 .. S DIR("?")="If you want to bill this prescription, enter 'Yes' - otherwise, enter 'No'"
 .. W ! D ^DIR K DIR
 .. I '+Y Q
 .. S BPSARRY("SC/EI OVR")=1
 .. S MOREDATA("BILL")=$$RX^IBNCPDP(DFN,.BPSARRY)  ;Call IB again
 . ;
 . ; Quit if no response from IB call
 . Q:'$D(MOREDATA("BILL"))
 . S MOREDATA("ELIG")=$P(MOREDATA("BILL"),"^",3)
 . I $P(MOREDATA("BILL"),U,1)=0 S IB=2 Q  ;IB says not to bill
 . ;
 . ; esg - 4/28/10 - after the above $$RX^IBNCPDP calls to billing, now get the NCPDP quantity and units for ECME (*8)
 . N QTY
 . S QTY=$$NCPDPQTY^PSSBPSUT($G(BPSARRY("DRUG")),$G(BPSARRY("QTY")))      ; DBIA# 4992
 . S BPSARRY("QTY")=$P(QTY,U,1)                                           ; NCPDP BILLING QUANTITY
 . S BPSARRY("UNITS")=$P(QTY,U,2)                                         ; NCPDP DISPENSE UNIT
 . ;
 . S IB=1
 . M MOREDATA("IBDATA")=BPSARRY("INS")
 . S $P(MOREDATA("BPSDATA",1),U,1)=BPSARRY("QTY")
 . S $P(MOREDATA("BPSDATA",1),U,2)=BPSARRY("COST")
 . S $P(MOREDATA("BPSDATA",1),U,3)=BPSARRY("NDC")
 . S $P(MOREDATA("BPSDATA",1),U,4)=BFILL
 . S $P(MOREDATA("BPSDATA",1),U,5)=""  ; Certify Mode
 . S $P(MOREDATA("BPSDATA",1),U,6)=""  ; Cert IEN
 . S $P(MOREDATA("BPSDATA",1),U,7)=BPSARRY("UNITS")
 ;
 ; If certification mode on and no IB result (somewhat redundant since IB is not called
 ;   for certification), get data from BPS Certification table
 I $G(CERTIEN),'$G(IB) D
 . N NODE,FLD,NFLD,CERTARY
 . S MOREDATA("BILL")=1
 . S MOREDATA("IBDATA",1,1)="",MOREDATA("IBDATA",1,2)="",MOREDATA("BPSDATA",1)=""
 . S $P(MOREDATA("BPSDATA",1),U,5)=1  ;Certify Mode
 . S $P(MOREDATA("BPSDATA",1),U,6)=CERTIEN  ;Cert IEN
 . S $P(MOREDATA("IBDATA",1,1),U,1)=1  ;Plan IEN
 . S $P(MOREDATA("IBDATA",1,1),U,4)=$$GET1^DIQ(9002313.31,CERTIEN,.04,"E")  ;Payer Sheet
 . S $P(MOREDATA("IBDATA",1,1),U,10)="01"  ;Home State Plan
 . S $P(MOREDATA("IBDATA",1,1),U,11)=""  ;B2 Payer Sheet (reversal)
 . S $P(MOREDATA("IBDATA",1,1),U,12)=""  ;B3 Payer Sheet (rebill)
 . S $P(MOREDATA("IBDATA",1,1),U,14)=""  ;Plan Name
 . S $P(MOREDATA("IBDATA",1,2),U,5)=0    ;Admin Fee
 . ;
 . ;Get data from non-multiple fields and add to MOREDATA
 . K CERTARY D GETS^DIQ(9002313.31,CERTIEN_",","1*","","CERTARY")
 . S NODE="" F  S NODE=$O(CERTARY(9002313.311,NODE)) Q:NODE=""  D
 .. S FLD="" F  S FLD=$O(CERTARY(9002313.311,NODE,FLD)) Q:FLD=""  D
 ... I FLD=.01 S NFLD=CERTARY(9002313.311,NODE,FLD) D
 .... I NFLD=101 S $P(MOREDATA("IBDATA",1,1),U,2)=CERTARY(9002313.311,NODE,.02) ;BIN
 .... I NFLD=104 S $P(MOREDATA("IBDATA",1,1),U,3)=CERTARY(9002313.311,NODE,.02)  ;PCN
 .... I NFLD=110 S $P(MOREDATA("IBDATA",1,1),U,13)=CERTARY(9002313.311,NODE,.02)  ;Certification ID
 . ;
 . ;Get data from multiple fields and add to MOREDATA
 . K CERTARY D GETS^DIQ(9002313.31,CERTIEN_",","2*","","CERTARY")
 . S NODE="" F  S NODE=$O(CERTARY(9002313.3121,NODE)) Q:NODE=""  D
 ..  S FLD="" F  S FLD=$O(CERTARY(9002313.3121,NODE,FLD)) Q:FLD=""  D
 ... I FLD=.01 S NFLD=CERTARY(9002313.3121,NODE,FLD) D
 .... I NFLD=301 S $P(MOREDATA("IBDATA",1,1),U,5)=CERTARY(9002313.3121,NODE,.02)  ;Group ID
 .... I NFLD=302 S $P(MOREDATA("IBDATA",1,1),U,6)=CERTARY(9002313.3121,NODE,.02)  ;Cardholder ID
 .... I NFLD=306 S $P(MOREDATA("IBDATA",1,1),U,7)=CERTARY(9002313.3121,NODE,.02)  ;Patient Rel Code
 .... I NFLD=312 S $P(MOREDATA("IBDATA",1,1),U,8)=CERTARY(9002313.3121,NODE,.02)  ;Cardholder First Name
 .... I NFLD=313 S $P(MOREDATA("IBDATA",1,1),U,9)=CERTARY(9002313.3121,NODE,.02)  ;Cardholder Last Name
 .... I NFLD=412 S $P(MOREDATA("IBDATA",1,2),U,1)=CERTARY(9002313.3121,NODE,.02)  ;Dispensing Fee
 .... I NFLD=423 S $P(MOREDATA("IBDATA",1,2),U,2)=CERTARY(9002313.3121,NODE,.02)  ;Basis of Cost Determination
 .... I NFLD=426 S $P(MOREDATA("IBDATA",1,2),U,3)=CERTARY(9002313.3121,NODE,.02)  ;Usual & Customary - Base Price
 .... I NFLD=430 S $P(MOREDATA("IBDATA",1,2),U,4)=CERTARY(9002313.3121,NODE,.02)  ;Gross Amt Due
 .... I NFLD=442 S $P(MOREDATA("BPSDATA",1),U,1)=CERTARY(9002313.3121,NODE,.02)  ;Qty
 .... I NFLD=409 S $P(MOREDATA("BPSDATA",1),U,2)=CERTARY(9002313.3121,NODE,.02)  ;Unit Cost
 .... I NFLD=407 S $P(MOREDATA("BPSDATA",1),U,3)=CERTARY(9002313.3121,NODE,.02)  ;NDC
 .... I NFLD=403 S $P(MOREDATA("BPSDATA",1),U,4)=CERTARY(9002313.3121,NODE,.02)  ;Fill #
 .... I NFLD=600 S $P(MOREDATA("BPSDATA",1),U,7)=CERTARY(9002313.3121,NODE,.02)  ;Unit of Measure
 . ;
 . ; If Gross Amt Due is missing, use Usual and Customary
 . I $P(MOREDATA("IBDATA",1,2),U,4)="" S $P(MOREDATA("IBDATA",1,2),U,4)=$P(MOREDATA("IBDATA",1,2),U,3)
 ;
 ; The code below checks if Sequence one is missing and move the next number down if needed.
 ; DMB - This is existing code so I am not sure if it is needed or not.
 ; SS - This code is important for secondary claims processing
 I '$D(MOREDATA("IBDATA",1)) D
 . N WW
 . S WW=$O(MOREDATA("IBDATA",""))
 . I WW'="" M MOREDATA("IBDATA",1)=MOREDATA("IBDATA",WW) K MOREDATA("IBDATA",WW)
 ;
 ; Uppercase the IBDATA
 ; DMB - Assume this was adding in case any of the BPS Certification data was entered as lowercase
 S MOREDATA("IBDATA",1,1)=$TR(MOREDATA("IBDATA",1,1),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 S MOREDATA("IBDATA",1,2)=$TR(MOREDATA("IBDATA",1,2),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 S MOREDATA("BPSDATA",1)=$TR(MOREDATA("BPSDATA",1),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
 Q
