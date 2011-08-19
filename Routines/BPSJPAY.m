BPSJPAY ;BHAM ISC/DMB - e-Pharmacy Payer Sheet Code ;28-SEP-2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1**;JUN 2004
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ; Fileman access to VA(200) supported by DBIA 10060
 ;
 ; Must enter at tag STLIC
 Q
 ;
 ; Subroutine to get State DEA and State Credentialing License Numbers
STLIC(MEDN,PIEN,DOS) ;
 ; Input variable:
 ;    MEDN - Index number indicating what medication is being processed (parameter)
 ;    PIEN - Provider IEN for provider being processed (parameter)
 ;    DOS  - Service Date (parameter)
 ;    U    - Delimiter (System variable)
 ; Output variables
 ;    State DEA License - 
 ;        BPS("RX",RX number,"Prescriber State DEA #",State Abbrev)=ID
 ;    State Credentialling ID -
 ;        BPS("RX",RX number,"Prescriber State License #",State Abbrev)=ID
 ;
 ; Check that first two parameters are not null
 I MEDN=""!(PIEN="") G STLIC2
 N IEN,X,STATE,ID,EXPDT,BPSVA,DISYS
 ;
 ; Get IDs from New Person File
 D GETS^DIQ(200,PIEN_",","54.1*;54.2*","I","BPSVA")
 ;
 ; State Issued DEA number
 S IEN="" F  S IEN=$O(BPSVA(200.55,IEN)) Q:IEN=""  D
 . S STATE=$G(BPSVA(200.55,IEN,.01,"I"))
 . S ID=$G(BPSVA(200.55,IEN,1,"I"))
 . I STATE=""!(ID="") Q
 . S STATE=$P($G(^DIC(5,STATE,0)),"^",2)
 . I STATE="" Q
 . S BPS("RX",MEDN,"Prescriber State DEA #",STATE)=ID
 ;
 ; Get State Credentialing License Number
 I DOS="" G STLIC2
 S IEN="" F  S IEN=$O(BPSVA(200.541,IEN)) Q:IEN=""  D
 . S STATE=$G(BPSVA(200.541,IEN,.01,"I"))
 . S ID=$G(BPSVA(200.541,IEN,1,"I"))
 . S EXPDT=$G(BPSVA(200.541,IEN,2,"I"))
 . I STATE=""!(ID="") Q
 . ; If there is a expiration date, check to see if the license is valid
 . ;   as of the service date
 . I EXPDT,EXPDT+17000000<DOS Q
 . S STATE=$P($G(^DIC(5,STATE,0)),"^",2)
 . I STATE="" Q
 . S BPS("RX",MEDN,"Prescriber State License #",STATE)=ID
STLIC2 Q
