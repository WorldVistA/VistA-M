RCDMCR5B ;HAF/ASF - First Party Charge IB Cancellation Reconciliation Report - Collect Data; Apr 9, 2019@21:06
 ;;4.5;Accounts Receivable;**347,361**;Mar 20, 1995;Build 6
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; DBIA 4858 - GET1^PSOSI routine calls
 ; DBIA 4538 - Action Type File (350.1) lookup
 ; DBIA 4541 - Integrated Billing Action File lookups
 ; DBIA 5040 - Outpatient event date lookup for file 409.68
 ; DBIA 4434 - Action Status lookup
 ;
 ; See RCDMCR5A for detailed description
 ;
COLLECT(STOPIT,CANBEGDT,CANENDDT,BILLPAYS) ; Get the report data
 ;Input
 ;   STOPIT - Passed Variable to determine if process is to be terminated
 ;   CANBEGDT - Cancellation Begin Date
 ;   CANENDDT - Cancellation End Date
 ;Output
 ;   STOPIT - Passed Variable set to 1 if process is to be terminated
 ;   ^TMP($J,"RCDMCR5B") with report data and summary data
 N DFN,IBIEN,IB0,IB1,CTR,ARIEN,ACTTYPE,BILGROUP,RESULT,IBDATA
 N SERVDT,RXDT,NAME,SSN,RXDT,CHGAMT,BILLFRDT,PAID,TRIEN
 N BILLNO,RXNUM,RXNAM,CANCDT,CANCUSER,CANCREAS,PARENTE
 N VAERR,VADM,VAIP
 N APPR,RSC
 ;Quit if passed parameter variables not populated
 I $G(CANBEGDT)'>0,$G(CANENDDT)'>0 Q
 S CANCDT=CANBEGDT-.000001
 F  S CANCDT=$O(^IB("D",CANCDT)) Q:CANCDT=""  Q:CANCDT>(CANENDDT+1)  D  Q:$G(STOPIT)>0
 . S IBIEN=""
 . F  S IBIEN=$O(^IB("D",CANCDT,IBIEN)) Q:IBIEN=""  D  Q:$G(STOPIT)>0
 . . S IB0=$G(^IB(IBIEN,0)),IB1=$G(^IB(IBIEN,1))
 . . S ACTTYPE=$P(IB0,U,3)
 . . I ACTTYPE="" Q
 . . ; SEQUENCE NUMBER (file 350.1, field .05) of 2 is CANCEL
 . . I $P($G(^IBE(350.1,ACTTYPE,0)),U,5)'=2 Q
 . . S DFN=$P(IB0,U,2)
 . . S CTR=$G(CTR)+1 ;Counter
 . . I CTR#500=0 S STOPIT=$$STOPIT^RCDMCUT2() Q:STOPIT
 . . S BILLNO=$P(IB0,U,11)
 . . I BILLNO="" Q
  . . ; ASF 8/10/19
 . . S ARIEN=$O(^PRCA(430,"B",BILLNO,""))
 . . I ARIEN'>0 Q
 . . ;Grab the existing Fund.  If it doesn't exist, calculate it.
 . . S APPR=$$GET1^DIQ(430,ARIEN_",",203)
 . . I APPR="" S APPR=$$GETFUNDB^RCXFMSUF(ARIEN,1)
 . . ;Grab the existing RSC.  If it doesn't exist, calculate it.
 . . S RSC=$$GET1^DIQ(430,ARIEN_",",255.1)       ;Check for accrued RSC
 . . S:RSC="" RSC=$$GET1^DIQ(430,ARIEN_",",255)  ;if no accrued RSC, check for non-accrued.
 . . S:RSC="" RSC=$$CALCRSC^RCXFMSUR(ARIEN)      ;if neither present, calculate
 . . ; only look at 1st party bills
 . . I '$$FIRSTPAR^RCDMCUT1(ARIEN) Q
 . . ; BILLPAYS of 1 means only bills with an IB Bill Status of Cancelled and an AR status of Closed/Collected
 . . ; Otherwise, show all bills regardless of the payment status  (IB Cancelled, and with any AR Status)
 . . ; Note: we no longer check Collected/Closed as per customer.   Instead, we check if any transactions associated
 . . ; with this bill are payments.
 . . I BILLPAYS S PAID=0 D  Q:'PAID
 . . . S TRIEN=""
 . . . F  S TRIEN=$O(^PRCA(433,"C",ARIEN,TRIEN)) Q:TRIEN=""  I $$GET1^DIQ(433,TRIEN_",",12,"E")?1"PAYMENT (".E S PAID=1 Q
 . . D DEM^VADPT
 . . I $G(VAERR)>0 D KVAR^VADPT Q
 . . S NAME=$G(VADM(1))
 . . I NAME']"" Q
 . . S SSN=$P(VADM(2),U,1)
 . . I SSN']"" Q
 . . S SERVDT="",RXDT="",RXNUM="",RXNAM="",CANCREAS="",CANCUSER="" K IBDATA
 . . S IENS=IBIEN_","
 . . D GETS^DIQ(350,IENS,".1;11","E","IBDATA")   ;dbia 4541
 . . S BILLFRDT=$P(IB0,U,14)
 . . S CANCREAS=$G(IBDATA(350,IENS,.1,"E"))
 . . S CANCUSER=$G(IBDATA(350,IENS,11,"E"))
 . . I CANCUSER="" S CANCUSER="/"_$P(IB1,U)
 . . S BILGROUP=$$GET1^DIQ(350.1,+ACTTYPE_",",.11,"I")  ;dbia 4538
 . . S RESULT=$P(IB0,U,4)
 . . S CHGAMT=$$GET1^DIQ(350,$$PARENTC(IBIEN)_",",.07)  ;dbia 4541
 . . S PARENTE=$$PARENTE(IBIEN),RESULT=$$GET1^DIQ(350,PARENTE_",",.04,"I"),IENS=PARENTE_","    ;dbia 4541
 . . S SERVDT=""
 . . ;Inpatient Event
 . . I $P(RESULT,":",1)=405!($P(RESULT,":",1)=45) D
 . . . S VAIP("E")=$P($P(RESULT,";",1),":",2)
 . . . ;Call to get Inpatient data
 . . . D IN5^VADPT
 . . . Q:VAERR>0
 . . . S SERVDT=$P($G(VAIP(17,1)),U,1)
 . . . D KVAR^VADPT
 . . ;Outpatient Event
 . . I BILGROUP=4!($P(RESULT,":",1)=44)!($P(RESULT,":",1)=409.68) D
 . . . I $P(RESULT,":",1)=44 S SERVDT=$P($P(RESULT,";",2),":",2)
 . . . I $P(RESULT,":",1)=409.68 S SERVDT=$$GET1^DIQ(409.68,+$P(RESULT,":",2)_",",.01,"I")  ;dbia 5040
 . . . I $G(SERVDT)'>0 S SERVDT=BILLFRDT
 . . I SERVDT="" S SERVDT=$$GET1^DIQ(350,IENS,.17,"I")   ;dbia 4538
 . . ;RX Event
 . . I $P(RESULT,":",1)=52 D
 . . . N IENS
 . . . ;Set up for RX Refills
 . . . I $P(RESULT,";",2)]"" D
 . . . . S IENS=+$P($P(RESULT,";",2),":",2)_","_+$P($P(RESULT,";",1),":",2)_","
 . . . . S RXDT=$$GET1^PSODI(52.1,IENS,17,"I")   ;dbia 4858
 . . . . S:$P(RXDT,U,2)'?7N.E RXDT=$$GET1^PSODI(52.1,IENS,.01,"I")   ;dbia 4858
 . . . . I 'RXDT S RXDT="^"
 . . . . S RXNUM=$$GET1^PSODI(52,$P($P(RESULT,";",1),":",2)_",",.01,"I")   ;dbia 4858
 . . . . I 'RXNUM S RXNUM="^"
 . . . . S RXNAM=$$GET1^PSODI(52,$P($P(RESULT,";",1),":",2)_",",6,"E")   ;dbia 4858
 . . . . I 'RXNAM S RXNAM="^"
 . . . ;Set up for RX Data (No refill)
 . . . I $P(RESULT,";",2)']"" D
 . . . . S IENS=+$P($P(RESULT,";",1),":",2)_","
 . . . . S RXDT=$$GET1^PSODI(52,IENS,31,"I")
 . . . . S:$P(RXDT,U,2)'?7N.E RXDT=$$GET1^PSODI(52,IENS,22,"I")   ;dbia 4858
 . . . . I 'RXDT S RXDT="^"
 . . . . S RXNUM=$$GET1^PSODI(52,IENS,.01,"I")   ;dbia 4858
 . . . . I 'RXNUM S RXNUM="^"
 . . . . S RXNAM=$$GET1^PSODI(52,IENS,6,"E")   ;dbia 4858
 . . . . I 'RXNAM S RXNAM="^"
 . . ; ASF 8/10/19 
 . . S ^TMP($J,"RCDMCR5B","DETAIL",NAME,SSN,BILLNO,IBIEN)=SERVDT_U_$P(RXDT,U,2)_U_CHGAMT_U_$P(RXNUM,U,2)_U_$P(RXNAM,U,2)_U_CANCDT_U_CANCREAS_U_CANCUSER_U_APPR_U_RSC
 Q
PARENTE(IBIEN) ; Go up the parenting event chain of IBIEN and return the original "parent" 
 N NZ
 S NZ=$G(^IB(IBIEN,0))
 I $P(NZ,U,16)'="" Q $S(IBIEN=$P(NZ,U,16):IBIEN,1:$$PARENTE($P(NZ,U,16)))
 I $P(NZ,U,9)'="" Q $S(IBIEN=$P(NZ,U,9):IBIEN,1:$$PARENTE($P(NZ,U,9)))
 I $P(NZ,U,4)?1"350:".E Q $S(IBIEN=(+$P($P(NZ,U,4),":",2)):IBIEN,1:$$PARENTE($P($P(NZ,U,4),":",2)+0))
 Q IBIEN
PARENTC(IBIEN) ; Go up the parenting charge chain of IBIEN and return the original "parent" charge
 N NZ
 S NZ=$G(^IB(IBIEN,0))
 I $P(NZ,U,9)'="" Q $S(IBIEN=$P(NZ,U,9):IBIEN,1:$$PARENTC($P(NZ,U,9)))
 I $P(NZ,U,4)?1"350:".E Q $S(IBIEN=(+$P($P(NZ,U,4),":",2)):IBIEN,1:$$PARENTC($P($P(NZ,U,4),":",2)+0))
 Q IBIEN
