BPSNCPD2 ;BHAM ISC/LJE - Continuation of BPSNCPDP (IB Billing Determination) ;11/7/07  16:01
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,6,7,8,10,11**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;External reference $$RX^IBNCPDP supported by DBIA 4299
 ;
 ; EN - Call IB Billing Determination.  If good to go, update MOREDATA array
 ; Notes about variables
 ;Input:
 ;   DFN - PATIENT file #2 ien
 ;   BWHERE - Where the code is called from and what needs to be done
 ;   MOREDATA - Initialized by BPSNCPDP and more data is added here.
 ;              Should be passed by reference.
 ;   BPSARRY  - Created by STARRAY^BPSNCPD1 and used for IB Determination
 ;   IB - Returned to calling routine. Should be passed by reference.
 ;        1 = Billable
 ;        0 or 2 - Not Billable
 ;
 ; Variable used/needed but not passed in as a parameter
 ;   CERTIEN - BPS Certification IEN - Not passed but newed/set in BPSNCPDP
 ;   BPJOBFLG - Not passed in but newed/set in BPSNCPCP
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
 . S IB=1
 . M MOREDATA("IBDATA")=BPSARRY("INS")
 . S MOREDATA("PATIENT")=$G(DFN)
 . S MOREDATA("RX")=$G(BPSARRY("IEN"))
 . S $P(MOREDATA("BPSDATA",1),U,1)=$G(BPSARRY("NCPDP QTY"))
 . S $P(MOREDATA("BPSDATA",1),U,2)=$G(BPSARRY("COST"))
 . S $P(MOREDATA("BPSDATA",1),U,3)=$G(BPSARRY("NDC"))
 . S $P(MOREDATA("BPSDATA",1),U,4)=$G(BPSARRY("FILL NUMBER"))
 . S $P(MOREDATA("BPSDATA",1),U,5)=""  ; Certification Mode
 . S $P(MOREDATA("BPSDATA",1),U,6)=""  ; Certification IEN
 . S $P(MOREDATA("BPSDATA",1),U,7)=$G(BPSARRY("NCPDP UNITS"))
 . S $P(MOREDATA("BPSDATA",1),U,8)=$G(BPSARRY("QTY"))    ; Billing Quantity
 . S $P(MOREDATA("BPSDATA",1),U,9)=$G(BPSARRY("UNITS"))  ; Billing Units
 ;
 ; If certification mode on and no IB result (somewhat redundant since IB is not called
 ;   for certification), get data from BPS Certification table
 I $G(CERTIEN),'$G(IB) D
 . N NODE,FLD,NFLD,CERTARY
 . S MOREDATA("IBDATA",1,1)="",MOREDATA("IBDATA",1,2)=""
 . S MOREDATA("IBDATA",1,3)="",MOREDATA("BPSDATA",1)=""
 . S MOREDATA("BILL")="1^^V",IB=1
 . S MOREDATA("PATIENT")=$$GET1^DIQ(9002313.31,CERTIEN,903,"I")  ;Patient from certification record
 . I 'MOREDATA("PATIENT") S MOREDATA("PATIENT")=$G(DFN) ; Patient
 . S MOREDATA("RX")=$G(BPSARRY("IEN")) ; RX
 . S MOREDATA("ELIG")="V"    ; Eligibility
 . S $P(MOREDATA("BPSDATA",1),U,5)=1   ;Certify Mode
 . S $P(MOREDATA("BPSDATA",1),U,6)=CERTIEN  ;Cert IEN
 . S $P(MOREDATA("BPSDATA",1),U,8)=""  ; Billing Quantity
 . S $P(MOREDATA("BPSDATA",1),U,9)=""  ; Billing Units
 . S $P(MOREDATA("IBDATA",1,1),U,1)=1  ;Plan IEN
 . S $P(MOREDATA("IBDATA",1,1),U,4)=$$GET1^DIQ(9002313.31,CERTIEN,.04,"E")  ;Billing Payer Sheet Name
 . S $P(MOREDATA("IBDATA",1,1),U,10)="01"  ;Home State Plan
 . S $P(MOREDATA("IBDATA",1,1),U,11)=$$GET1^DIQ(9002313.31,CERTIEN,.05,"E") ;Reversal Payer Sheet Name
 . S $P(MOREDATA("IBDATA",1,1),U,12)=""  ;Rebill Payer Sheet Name
 . S $P(MOREDATA("IBDATA",1,1),U,14)=""  ;Plan Name
 . S $P(MOREDATA("IBDATA",1,1),U,15)=$$GET1^DIQ(9002313.31,CERTIEN,.08,"E") ;Eligibility Payer Sheet Name
 . S $P(MOREDATA("IBDATA",1,1),U,16)=$$GET1^DIQ(9002313.31,CERTIEN,.04,"I") ;Billing Payer Sheet IEN
 . S $P(MOREDATA("IBDATA",1,1),U,17)=$$GET1^DIQ(9002313.31,CERTIEN,.05,"I") ;Reversal Payer Sheet IEN
 . S $P(MOREDATA("IBDATA",1,1),U,18)=""  ; Rebill Payer Sheet IEN
 . S $P(MOREDATA("IBDATA",1,1),U,19)=$$GET1^DIQ(9002313.31,CERTIEN,.08,"I") ;Eligibility Payer Sheet IEN
 . S $P(MOREDATA("IBDATA",1,2),U,5)=0    ;Admin Fee
 . S $P(MOREDATA("IBDATA",1,3),U,1)=""   ;Group Name
 . S $P(MOREDATA("IBDATA",1,3),U,2)=""   ;Insurance Company Phone Number
 . S $P(MOREDATA("IBDATA",1,3),U,3)="T00010"   ;Plan ID
 . S $P(MOREDATA("IBDATA",1,3),U,4)="V"   ;Plan Type
 . S $P(MOREDATA("IBDATA",1,3),U,5)=""   ;Insurance Company IEN
 . S $P(MOREDATA("IBDATA",1,3),U,6)=$$GET1^DIQ(9002313.31,CERTIEN,.07,"I") ;COB Indicator
 . I $P(MOREDATA("IBDATA",1,3),U,6)="" S $P(MOREDATA("IBDATA",1,3),U,6)=1
 . S $P(MOREDATA("IBDATA",1,3),U,7)=1    ;Policy Number (needed for eligibility transmissions)
 . S $P(MOREDATA("IBDATA",1,3),U,8)=1    ;Maximum Transactions
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
 .... I NFLD=442 S $P(MOREDATA("BPSDATA",1),U,1)=CERTARY(9002313.3121,NODE,.02)   ;Quantity Dispensed
 .... I NFLD=409 S $P(MOREDATA("BPSDATA",1),U,2)=CERTARY(9002313.3121,NODE,.02)   ;Unit Cost
 .... I NFLD=407 S $P(MOREDATA("BPSDATA",1),U,3)=CERTARY(9002313.3121,NODE,.02)   ;NDC
 .... I NFLD=403 S $P(MOREDATA("BPSDATA",1),U,4)=+CERTARY(9002313.3121,NODE,.02)  ;Fill #
 .... I NFLD=600 S $P(MOREDATA("BPSDATA",1),U,7)=CERTARY(9002313.3121,NODE,.02)   ;Unit of Measure
 . ;
 . ; If Gross Amt Due is missing, use Usual and Customary
 . I $P(MOREDATA("IBDATA",1,2),U,4)="" S $P(MOREDATA("IBDATA",1,2),U,4)=$P(MOREDATA("IBDATA",1,2),U,3)
 ;
 ; The code below checks if Sequence one is missing and move the next number down if needed.
 ; This can happen when the COB indicator in IB has multiple insurances assigned as secondary but none are
 ;   assigned as primary
 I '$D(MOREDATA("IBDATA",1)) D
 . N WW
 . S WW=$O(MOREDATA("IBDATA",""))
 . I WW'="" M MOREDATA("IBDATA",1)=MOREDATA("IBDATA",WW) K MOREDATA("IBDATA",WW)
 ;
 ; Uppercase the IBDATA
 ; DMB - Existing Code.  Not sure if it is needed.
 S MOREDATA("IBDATA",1,1)=$TR($G(MOREDATA("IBDATA",1,1)),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 S MOREDATA("IBDATA",1,2)=$TR($G(MOREDATA("IBDATA",1,2)),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 S MOREDATA("BPSDATA",1)=$TR($G(MOREDATA("BPSDATA",1)),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
 Q
