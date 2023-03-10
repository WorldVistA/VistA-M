BPSTEST2 ;AITC/CKB - ECME TESTING TOOL ;5/31/2018
 ;;1.0;E CLAIMS MGMT ENGINE;**24,26,28**;JUN 2004;Build 22
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
SETOVER ;
 ; the following code was from SETOVER^BPSTEST and is called by SETOVER^BPSTEST
 ;
 ; If a eligibility, check for specific reversal overrides and set
 I BPSTYPE="E1" D  Q
 . S BPSRRESP=$$GET1^DIQ(9002313.32,BPSTIEN_",",.08,"I")
 . ;
 . ; If the response is Stranded, force an <UNDEF> error
 . I BPSRRESP="T" S BPSXXXX=BPSUNDEF
 . I BPSRRESP]"" S BPSDATA(1,112)=BPSRRESP
 . S BPSDATA(9002313.03,9002313.03,"+1,",501)=$S(BPSRRESP="R":"R",1:"A")
 . ; 
 . ; If the response is accepted, delete the reject code count and codes
 . I BPSRRESP="A" K BPSDATA(1,510),BPSDATA(1,511)
 . ; 
 . ; If the response is rejected, delete the rejections returned by payers
 . ;   and put in the ones entered by the user
 . I BPSRRESP="R" D
 .. K BPSDATA(1,509),BPSDATA(1,511)
 .. S BPSRCNT=0
 .. S BPSRIEN=0 F  S BPSRIEN=$O(^BPS(9002313.32,BPSTIEN,1,BPSRIEN)) Q:+BPSRIEN=0  D
 ... S BPSRCODE=$P($G(^BPS(9002313.32,BPSTIEN,1,BPSRIEN,0)),"^",1)
 ... ; Increment counter and store
 ... I BPSRCODE]"" D
 .... S BPSRCD=$$GET1^DIQ(9002313.93,BPSRCODE_",",.01,"E")
 .... I BPSRCD]"" S BPSRCNT=BPSRCNT+1,BPSDATA(1,511,BPSRCNT)=BPSRCD
 .. ; Store total number of rejections
 .. S BPSDATA(1,510)=BPSRCNT
 ;
 ; If a reversal, check for specific reversal overrides and set
 I BPSTYPE="B2" D
 . S BPSRRESP=$$GET1^DIQ(9002313.32,BPSTIEN_",",.05,"I")
 . ;
 . ; If the response is Stranded, force an <UNDEF> error
 . I BPSRRESP="T" S BPSXXXX=BPSUNDEF
 . I BPSRRESP]"" S BPSDATA(1,112)=$S(BPSRRESP="D":"T",1:BPSRRESP)
 . S BPSDATA(9002313.03,9002313.03,"+1,",501)=$S(BPSRRESP="R":"R",1:"A")
 . ;
 . ; If the response is accepted or duplicate, kill the reject code count and codes
 . I BPSRRESP="A"!(BPSRRESP="D")!(BPSRRESP="Q")!(BPSRRESP="S") K BPSDATA(1,510),BPSDATA(1,511)
 . ;
 . ; If the response is rejected, set the reject codes
 . I BPSRRESP="R" D SETREJ^BPSTEST(BPSTRANS)
 ;
 ; If a submission, check for specific submission overrides and set
 I BPSTYPE="B1" D
 . ; Get submission response
 . S BPSSRESP=$$GET1^DIQ(9002313.32,BPSTIEN_",",.03,"I")
 . ;
 . ; If the response is Stranded, force an <UNDEF> error
 . I BPSSRESP="T" S BPSXXXX=BPSUNDEF
 . ;
 . ; If BPSSRESP exists, file it
 . I BPSSRESP]"" D
 .. S BPSDATA(1,112)=BPSSRESP
 .. S BPSDATA(9002313.03,9002313.03,"+1,",501)=$S(BPSSRESP="R":"R",1:"A")
 .. ; If payable or duplicate, get the BPSPAID amount and file it if it
 .. ; exists.  Also delete any reject codes
 .. I BPSSRESP="P"!(BPSSRESP="D")!(BPSSRESP="Q")!(BPSSRESP="S") D
 ... ;
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",2.1,"I")             ; 505-F5 Patient Pay Amount
 ... I BPSX]"" S BPSDATA(1,505)=$$DFF^BPSECFM(BPSX,10)
 ... ;
 ... S BPSPAID=$$GET1^DIQ(9002313.32,BPSTIEN_",",.04,"I")
 ... I BPSPAID]"" S BPSDATA(1,509)=$$DFF^BPSECFM(BPSPAID,8)         ; 509 Total amount paid
 ... ;
 ... K BPSDATA(1,510),BPSDATA(1,511)      ; kill Reject Count (510) and Reject Code (511)
 ... ;
 ... S BPSCOPAY=$$GET1^DIQ(9002313.32,BPSTIEN_",",.06,"I")
 ... I BPSCOPAY]"" S BPSDATA(1,518)=$$DFF^BPSECFM(BPSCOPAY,8)       ; 518 Copay Amount
 ... ;
 ... S BPS506=$$GET1^DIQ(9002313.32,BPSTIEN_",",.15,"I")
 ... I BPS506]"" S BPSDATA(1,506)=$$DFF^BPSECFM(BPS506,8)           ; 506 Ingredient Cost Paid
 ... ;
 ... S BPS507=$$GET1^DIQ(9002313.32,BPSTIEN_",",.16,"I")
 ... I BPS507]"" S BPSDATA(1,507)=$$DFF^BPSECFM(BPS507,8)           ; 507 Dispensing Fee Paid
 ... ;
 ... S BPS513=$$GET1^DIQ(9002313.32,BPSTIEN_",",.17,"I")
 ... I BPS513]"" S BPSDATA(1,513)=$$DFF^BPSECFM(BPS513,8)           ; 513 Remaining Deductible Amount
 ... ;
 ... S BPS517=$$GET1^DIQ(9002313.32,BPSTIEN_",",.18,"I")
 ... I BPS517]"" S BPSDATA(1,517)=$$DFF^BPSECFM(BPS517,8)           ; 517 Amount Applied to Periodic Deductible
 ... Q
 .. ;
 .. ;if not Stranded (BPSSRESP="T") prompt for the following fields
 .. I BPSSRESP'="T" D
 ... ; D1-D9 fields (BPS*1*15)
 ... S BPSAJPAY=$$GET1^DIQ(9002313.32,BPSTIEN_",",.1,"I")           ; Adjudicated Payment Type
 ... I BPSAJPAY]"" S BPSDATA(1,1028)=$$NFF^BPSECFM(BPSAJPAY,2)
 ... S BPSNFLDT=$$GET1^DIQ(9002313.32,BPSTIEN_",",.09,"I")          ; Override Next Available Fill
 ... I BPSNFLDT]"" S BPSDATA(1,2004)=$$DTF1^BPSECFM(BPSNFLDT)
 ... ;
 ... ; E0-E6 overrides (BPS*1*19)
 ... ; PERCENTAGE SALES TAX BASIS PAID
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",2.01,"I")
 ... I BPSX]"" S BPSDATA(1,561)=BPSX
 ... ; OTHER AMOUNT PAID QUALIFIER and associated field
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",2.02,"I")
 ... I BPSX]"" S BPSDATA(1,564,1)=$$NFF^BPSECFM(BPSX,2),BPSDATA(1,565,1)=$$DFF^BPSECFM(5.64,8),BPSDATA(1,563)=1
 ... ; PAYER ID QUALIFIER
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",2.03,"I")
 ... I BPSX]"" S BPSDATA(9002313.03,9002313.03,"+1,",568)=BPSX
 ... ; HELP DESK TELEPHONE NUMBER EXTENSION
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",2.04,"I")
 ... I BPSX]"" S BPSDATA(1,2022)=$$NFF^BPSECFM(BPSX,8)
 ... ; PROFESSIONAL SERVICE FEE CONTRACTED/REIMURSEMENT AMOUNT
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",2.05,"I")
 ... I BPSX]"" S BPSDATA(1,2033)=$$DFF^BPSECFM(BPSX,8)
 ... ; OTHER PAYER HELPDESK TELEPHONE EXTENSION
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",2.06,"I")
 ... I BPSX]"" S BPSDATA(1,2023,1)=$$NFF^BPSECFM(BPSX,8),BPSDATA(1,338,1)="01"
 ... ; RESPONSE INTERMEDIARY AUTHORIZATION TYPE ID and associated fields
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",2.07,"I")
 ... I BPSX]"" S BPSDATA(1,2053,1)=$$NFF^BPSECFM(BPSX,2),BPSDATA(1,2052)=1
 ... ; RESPONSE INTERMEDIARY AUTHORIZATION ID and associated fields
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",2.08,"I")
 ... I BPSX]"" S BPSDATA(1,2054,1)=$$ANFF^BPSECFM(BPSX,20),BPSDATA(1,2052)=1
 ... ; INTERMEDIARY MESSAGE and associated fields
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",3.01,"I")
 ... I BPSX]"" S BPSDATA(1,2051,1)=$$ANFF^BPSECFM(BPSX,200),BPSDATA(1,2052)=1
 ... ; (BPS*1*22)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",2.09,"I") ; B98-34 reconciliation id
 ... I BPSX]"" S BPSDATA(1,2098)=$$ANFF^BPSECFM(BPSX,30)
 ... ;
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",2.11,"E") ; 439-E4 reason for service code
 ... I BPSX]"" S BPSDATA(1,439,1)=$$ANFF^BPSECFM(BPSX,4),BPSDATA(1,567,1)=1
 ... ;
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",4.01,"I") ; 931-F8 maximum age qualifier
 ... I BPSX]"" S BPSDATA(1,931)=$$ANFF^BPSECFM(BPSX,1)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",4.02,"I") ; 932-GA maximum age
 ... I BPSX]"" S BPSDATA(1,932)=$$NFF^BPSECFM(BPSX,3)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",4.03,"I") ; 933-GB maximum amount
 ... I BPSX]"" S BPSDATA(1,933)=$$NFF^BPSECFM(BPSX,10)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",4.04,"I") ; 934-GC maximum amt qualifier
 ... I BPSX]"" S BPSDATA(1,934)=$$ANFF^BPSECFM(BPSX,2)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",4.05,"I") ; 935-GF maximum amt time period
 ... I BPSX]"" S BPSDATA(1,935)=$$ANFF^BPSECFM(BPSX,2)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",4.06,"I") ; 936-GG maximum amt time period start date
 ... I BPSX]"" S BPSDATA(1,936)=$$DTF1^BPSECFM(BPSX)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",4.07,"I") ; 937-GH maximum amt time period end date
 ... I BPSX]"" S BPSDATA(1,937)=$$DTF1^BPSECFM(BPSX)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",4.08,"I") ; 938-GJ maximum amt time period units
 ... I BPSX]"" S BPSDATA(1,938)=$$NFF^BPSECFM(BPSX,4)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",4.09,"I") ; 943-GQ minimum age qualifier
 ... I BPSX]"" S BPSDATA(1,943)=$$ANFF^BPSECFM(BPSX,1)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",4.1,"I") ; 944-GR minimum age
 ... I BPSX]"" S BPSDATA(1,944)=$$NFF^BPSECFM(BPSX,3)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",4.11,"I") ; C47-9T other payer adjudicate prog type
 ... I BPSX]"" S BPSDATA(1,2147)=$$ANFF^BPSECFM(BPSX,30)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",4.12,"I") ; C93-KN patient pay component amount
 ... I BPSX]"" S BPSDATA(1,2193)=$$DFF^BPSECFM(BPSX,8)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",4.13,"I") ; C94-KP patient pay component count
 ... I BPSX]"" S BPSDATA(1,2194)=$$NFF^BPSECFM(BPSX,4)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",4.14,"I") ; C95-KQ patient payer component qualifier
 ... I BPSX]"" S BPSDATA(1,2195)=$$ANFF^BPSECFM(BPSX,2)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",4.15,"I") ; D19-M1 minimum amount
 ... I BPSX]"" S BPSDATA(1,2219)=$$NFF^BPSECFM(BPSX,10)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",4.16,"I") ; D20-M2 minimum amount qualifier
 ... I BPSX]"" S BPSDATA(1,2220)=$$ANFF^BPSECFM(BPSX,3)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",4.17,"I") ; D23-M5 other payer name
 ... I BPSX]"" S BPSDATA(1,2223)=$$ANFF^BPSECFM(BPSX,30)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",4.18,"I") ; D24-M6 remaining amount
 ... I BPSX]"" S BPSDATA(1,2224)=$$NFF^BPSECFM(BPSX,10)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",4.19,"I") ; D25-M7 remaining amount qualifier
 ... I BPSX]"" S BPSDATA(1,2225)=$$ANFF^BPSECFM(BPSX,3)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",4.2,"I") ; D41-PA other payer relationship type
 ... I BPSX]"" S BPSDATA(1,2241)=$$ANFF^BPSECFM(BPSX,3)
 ... ;
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",5.01,"I") ; E87-ZV invalid provider data source
 ... I BPSX]"" S BPSDATA(1,2387)=$$ANFF^BPSECFM(BPSX,2)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",5.02,"I") ; E89-ZO formulary alternative eff date
 ... I BPSX]"" S BPSDATA(1,2389)=$$DTF1^BPSECFM(BPSX)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",5.03,"I") ; E93-ZC dur/due co-agent description
 ... I BPSX]"" S BPSDATA(1,2393)=$$ANFF^BPSECFM(BPSX,40)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",5.04,"I") ; E94-ZA unit of prior dispensed qty
 ... I BPSX]"" S BPSDATA(1,2394)=$$ANFF^BPSECFM(BPSX,3)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",5.05,"I") ; E95-Z9 other pharmacy id qualifier
 ... I BPSX]"" S BPSDATA(1,2395)=$$ANFF^BPSECFM(BPSX,2)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",5.06,"I") ; E97-Z7 other pharmacy name
 ... I BPSX]"" S BPSDATA(1,2397)=$$ANFF^BPSECFM(BPSX,70)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",5.07,"I") ; E98-Z6 other pharmacy telephone 
 ... I BPSX]"" S BPSDATA(1,2398)=$$NFF^BPSECFM(BPSX,10)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",5.08,"I") ; E99-Z5 other prescriber last name
 ... I BPSX]"" S BPSDATA(1,2399)=$$ANFF^BPSECFM(BPSX,35)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",5.09,"I") ; F01-Z4 other prescriber id qualifier
 ... I BPSX]"" S BPSDATA(1,2401)=$$ANFF^BPSECFM(BPSX,2)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",5.10,"I") ; F02-Z3 other prescriber id
 ... I BPSX]"" S BPSDATA(1,2402)=$$ANFF^BPSECFM(BPSX,35)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",5.11,"I") ; F03-Z2 other prescriber phone number
 ... I BPSX]"" S BPSDATA(1,2403)=$$NFF^BPSECFM(BPSX,10)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",5.12,"I") ; F04-Z1 dur/due compound product id
 ... I BPSX]"" S BPSDATA(1,2404)=$$ANFF^BPSECFM(BPSX,40)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",5.13,"I") ; F05-Z0 dur/due compound product id qualifier
 ... I BPSX]"" S BPSDATA(1,2405)=$$ANFF^BPSECFM(BPSX,2)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",5.14,"I") ; F06-YO dur/due maximum daily dose qty
 ... I BPSX]"" S BPSDATA(1,2406)=$$NFF^BPSECFM(BPSX,10)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",5.15,"I") ; F07-YL dur/due max daily dose - unit
 ... I BPSX]"" S BPSDATA(1,2407)=$$ANFF^BPSECFM(BPSX,3)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",5.16,"I") ; F08-YJ dur/due minimum daily dose qty
 ... I BPSX]"" S BPSDATA(1,2408)=$$NFF^BPSECFM(BPSX,10)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",5.17,"I") ; F09-YI dur/due min daily dose - unit
 ... I BPSX]"" S BPSDATA(1,2409)=$$ANFF^BPSECFM(BPSX,3)
 ... ;
 ... ; E7 overrides (BPS*1*20)
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",.11,"I") I BPSX'="" D     ; B88-3R quantity limit per spec time period
 .... S BPSDATA(1,2087)=1                          ; count field
 .... S BPSDATA(1,2088,1)=$$NFF^BPSECFM(BPSX,10)   ; data from override file
 .... Q
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",.12,"I") I BPSX'="" D     ; B89-3S quantity limit time period
 .... S BPSDATA(1,2087)=1                          ; count field
 .... S BPSDATA(1,2089,1)=$$NFF^BPSECFM(BPSX,5)    ; data from override file
 .... Q
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",.13,"I") I BPSX'="" D     ; B91-3W days supply limit per spec time period
 .... S BPSDATA(1,2090)=1                          ; count field
 .... S BPSDATA(1,2091,1)=$$NFF^BPSECFM(BPSX,3)    ; data from override file
 .... Q
 ... S BPSX=$$GET1^DIQ(9002313.32,BPSTIEN_",",.14,"I") I BPSX'="" D     ; B92-3X days supply limit time period
 .... S BPSDATA(1,2090)=1                          ; count field
 .... S BPSDATA(1,2092,1)=$$NFF^BPSECFM(BPSX,5)    ; data from override file
 .... Q
 ... Q
 .. ;
 .. ; If rejected, get the rejection code and file them
 .. ; Also, delete the BPSPAID amount
 .. I BPSSRESP="R" D
 ... ; Delete old rejections and BPSPAID amount
 ... K BPSDATA(1,509),BPSDATA(1,511)
 ... ; Loop through rejections and store
 ... S BPSRCNT=0
 ... S BPSRIEN=0 F  S BPSRIEN=$O(^BPS(9002313.32,BPSTIEN,1,BPSRIEN)) Q:+BPSRIEN=0  D
 .... S BPSRCODE=$P($G(^BPS(9002313.32,BPSTIEN,1,BPSRIEN,0)),"^",1)
 .... ; Increment counter and store
 .... I BPSRCODE]"" D
 ..... S BPSRCD=$$GET1^DIQ(9002313.93,BPSRCODE_",",.01,"E")
 ..... I BPSRCD]"" S BPSRCNT=BPSRCNT+1,BPSDATA(1,511,BPSRCNT)=BPSRCD
 ... ; Store total number of rejections
 ... S BPSDATA(1,510)=BPSRCNT
 ;
 Q
