IBCNBLE2 ;ALB/ESG - Expand ins buffer - ePharmacy entry ;14-Oct-2010
 ;;2.0;INTEGRATED BILLING;**435,822**;21-MAR-94;Build 21
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; References to BPS RESPONSES file (#9002313.03) in ICR #4813
 ;
 ; Called by IBCNBLE when expanding an ePharmacy buffer entry
 ; Variable IB0 is the 0 node of file 355.33
 ;IB*822/CKB - 'e-Pharmacy' has been changed to 'ePharmacy' throughout this routine 
 ;
EN ; Entry point
 N RESPIEN,RSPSUB,ZR,ZM,BPSR,BPSM,BPSMD,BPSMCOB,IBY,IBL,IBLINE,TEXT
 ;
 S RESPIEN=+$P(IB0,U,17) I 'RESPIEN G EX
 I '$D(^BPSR(RESPIEN,0)) G EX
 ;IB*822/CKB - moved the building of the display to DISPLAY tag
 D DISPLAY
EX ;
 Q
 ;
 ; EN1 is called by the action Pharmacy Elig (PE) under Policy Edit/View (VP)
 ; ??Variable IB0 is the 0 node of file 355.33??
 ;
EN1(RESPIEN) ;IB*822/CKB
 N BPSM,BPSMD,BPSMCOB,BPSR,IBL,IBLINE,IBPE,IBY,RSPSUB,TEXT,ZM,ZR
 ; 
 S IBPE=1
 D DISPLAY
EX1 ;
 Q
 ;
 ;------------------------------------------------------------------------------------------------
 ;
DISPLAY ;IB*822/CKB - call from EN or EN1 to display the ePharmacy
 S ZR=RESPIEN_","
 D GETS^DIQ(9002313.03,ZR,".01:999","IEN","BPSR")   ; get all fields at top level except raw data
 ;
 ;IB*822/CKB - from EN1, if BPS RESPONSE isn't found display "no data found"
 I ($G(IBPE)=1)&('$D(BPSR)) D NODATA Q
 ;
 S RSPSUB=+$O(^BPSR(RESPIEN,1000,0)),ZM=0
 I RSPSUB D
 . S ZM=RSPSUB_","_RESPIEN_","
 . D GETS^DIQ(9002313.0301,ZM,"112;503;511*;130.01*;549;550;987","IEN","BPSM")  ; get Response Status Segment data
 . Q
 ;
 D SET^IBCNBLE(" ")
 S IBY=$J("",22)_"ePharmacy Eligibility Response Data" ;IB*822/CKB - removed the '-'
 D SET^IBCNBLE(IBY,"B")
 ;
 S IBL="Transmission Status: "
 S IBY=$G(BPSR(9002313.03,ZR,501,"E"))
 S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,24,55)
 D SET^IBCNBLE(IBLINE)
 ;
 S IBL="Transaction Status: "
 S IBY=$G(BPSM(9002313.0301,ZM,112,"E"))
 S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,24,55)
 D SET^IBCNBLE(IBLINE)
 ;
 S IBL="Date of Service: "
 S IBY=$G(BPSR(9002313.03,ZR,401,"E"))
 S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,24,55)
 D SET^IBCNBLE(IBLINE)
 ;
 ; get 504 Message
 S TEXT=$G(BPSR(9002313.03,ZR,504,"E"))
 I TEXT'="" D
 . D SET^IBCNBLE(" ")
 . N IBZ,J,LEN,PCE,CHS,NEWCHS
 . S LEN=30   ; break up big words
 . F PCE=1:1 Q:PCE>$L(TEXT," ")  S CHS=$P(TEXT," ",PCE) I $L(CHS)>LEN D
 .. S NEWCHS=$E(CHS,1,LEN)_" "_$E(CHS,LEN+1,999)
 .. S $P(TEXT," ",PCE)=NEWCHS
 .. Q
 . D FSTRNG^IBJU1(TEXT,71,.IBZ)
 . S J=0 F  S J=$O(IBZ(J)) Q:'J  D
 .. S IBLINE=$$SETL^IBCNBLE("",IBZ(J),"",2,999)
 .. D SET^IBCNBLE(IBLINE)
 .. Q
 . Q
 ;
 ; display reject codes 511 if they exist
 I $D(BPSM(9002313.03511)) D
 . N ZJ
 . D SET^IBCNBLE(" ")
 . D SET^IBCNBLE("  Reject Codes:")
 . S ZJ="" F  S ZJ=$O(BPSM(9002313.03511,ZJ)) Q:ZJ=""  D SET^IBCNBLE("     "_$G(BPSM(9002313.03511,ZJ,.01,"E")))
 . Q
 ;
 ; display additional messages if they exist
 I $D(BPSM(9002313.13001)) D
 . N ZA,TEXT
 . D SET^IBCNBLE(" ")
 . D SET^IBCNBLE("  Additional Message:")
 . S ZA="" F  S ZA=$O(BPSM(9002313.13001,ZA)) Q:ZA=""  S TEXT=$G(BPSM(9002313.13001,ZA,526,"E")) I TEXT'="" D
 .. N IBZ,J,LEN,PCE,CHS,NEWCHS
 .. S LEN=30   ; break up big words
 .. F PCE=1:1 Q:PCE>$L(TEXT," ")  S CHS=$P(TEXT," ",PCE) I $L(CHS)>LEN D
 ... S NEWCHS=$E(CHS,1,LEN)_" "_$E(CHS,LEN+1,999)
 ... S $P(TEXT," ",PCE)=NEWCHS
 ... Q
 .. D FSTRNG^IBJU1(TEXT,71,.IBZ)
 .. S J=0 F  S J=$O(IBZ(J)) Q:'J  D
 ... S IBLINE=$$SETL^IBCNBLE("",IBZ(J),"",5,999)
 ... D SET^IBCNBLE(IBLINE)
 ... Q
 .. Q
 . Q
 D SET^IBCNBLE(" ")
 ;
 ; display response insurance segment data and responses patient segment data
 S IBL="Group ID: "
 S IBY=$G(BPSR(9002313.03,ZR,301,"E"))
 S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,28,51)
 I IBY'="" D SET^IBCNBLE(IBLINE)
 ;
 S IBL="Plan ID: "
 S IBY=$G(BPSR(9002313.03,ZR,524,"E"))
 S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,28,51)
 I IBY'="" D SET^IBCNBLE(IBLINE)
 ;
 S IBL="Network Reimbursement ID: "
 S IBY=$G(BPSR(9002313.03,ZR,545,"E"))
 S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,28,51)
 I IBY'="" D SET^IBCNBLE(IBLINE)
 ;
 S IBL="Cardholder ID: "
 S IBY=$G(BPSR(9002313.03,ZR,302,"E"))
 S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,28,51)
 I IBY'="" D SET^IBCNBLE(IBLINE)
 ;
 S IBL="Payer-reported First Name: "
 S IBY=$G(BPSR(9002313.03,ZR,310,"E"))
 S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,28,51)
 I IBY'="" D SET^IBCNBLE(IBLINE)
 ;
 S IBL="Payer-reported Last Name: "
 S IBY=$G(BPSR(9002313.03,ZR,311,"E"))
 S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,28,51)
 I IBY'="" D SET^IBCNBLE(IBLINE)
 ;
 S IBL="Payer-reported DOB: "
 S IBY=$G(BPSR(9002313.03,ZR,304,"E"))
 ;IB*822/CKB - if the date exists, formatted it to be readable
 I IBY'="" S IBY=$$DATE(IBY)
 S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,28,51)
 I IBY'="" D SET^IBCNBLE(IBLINE)
 ;
 S IBL="Authorization Number: "
 S IBY=$G(BPSM(9002313.0301,ZM,503,"E"))
 S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,28,51)
 I IBY'="" D SET^IBCNBLE(IBLINE)
 ;
 S IBL="Help Desk Phone: "
 S IBY=$G(BPSM(9002313.0301,ZM,550,"E"))
 ;IB*822/CKB - get the description from file for the Help Desk Phone # qual, if it exists
 I IBY'="" D
 . N BPSIEN,DESC,HDPQ
 . S HDPQ=$G(BPSM(9002313.0301,ZM,549,"E"))
 . S BPSIEN=$O(^BPS(9002313.44,"B",HDPQ,""))
 . I BPSIEN'="" D
 .. S DESC=$$GET1^DIQ(9002313.44,BPSIEN,.02)
 .. S IBY=IBY_" ("_DESC_")"
 ;I IBY'="" D
 ;. N HDPQ
 ;. S HDPQ=$G(BPSM(9002313.0301,ZM,549,"E")) Q:HDPQ=""    ; help desk phone# qualifier
 ;. S HDPQ=$S(+HDPQ=1:"Switch",+HDPQ=2:"Intermediary",+HDPQ=3:"Processor/PBM",1:"Other")
 ;. S IBY=IBY_" ("_HDPQ_")"
 ;. Q
 S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,28,51)
 I IBY'="" D SET^IBCNBLE(IBLINE)
 ;
 S IBL="URL: "
 S IBY=$G(BPSM(9002313.0301,ZM,987,"E"))
 I IBY'="" D
 . N COL,N,M,Z,URL,J
 . S COL=28     ; column to start display
 . S N=79-COL   ; max length of each line
 . S M=0        ; array subscript
 . F Z=1:N:400 S M=M+1,URL(M)=$E(IBY,Z,Z+N-1) I URL(M)="" K URL(M) Q
 . S IBLINE=$$SETL^IBCNBLE("",$G(URL(1)),IBL,COL,999)    ; display line 1 w/label
 . D SET^IBCNBLE(IBLINE)
 . S J=1 F  S J=$O(URL(J)) Q:'J  D
 .. S IBLINE=$$SETL^IBCNBLE("",URL(J),"",COL,999)        ; display the rest
 .. D SET^IBCNBLE(IBLINE)
 .. Q
 . Q
 ;
 ; Get the Response Insurance Additional Information Segment data
 ; Used only for Medicare Part D Eligibility transactions
 D GETS^DIQ(9002313.0301,ZM,"139;138;240;926;757;140;141","IEN","BPSMD")  ; get data
 I $D(BPSMD(9002313.0301)) D
 . D SET^IBCNBLE(" ")
 . D SET^IBCNBLE("  MEDICARE PART D ELIGIBILITY INFORMATION")
 . ;
 . S IBL="Coverage Code: "
 . S IBY=$G(BPSMD(9002313.0301,ZM,139,"E"))
 . ;IB*822/CKB - add description of the Coverage code, if code exists
 . I IBY'="" D
 .. N BPSIEN,BPSDESC
 .. S BPSIEN=$O(^BPS(9002313.45,"B",IBY,""))
 .. I BPSIEN'="" D
 ... S BPSDESC=$$GET1^DIQ(9002313.45,BPSIEN,.02)
 ... S IBY=IBY_" ("_BPSDESC_")"
 . S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,25,54)
 . D SET^IBCNBLE(IBLINE)
 . ;
 . S IBL="CMS LICS Level: "
 . S IBY=$G(BPSMD(9002313.0301,ZM,138,"E"))
 . S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,25,54)
 . D SET^IBCNBLE(IBLINE)
 . ;
 . S IBL="Contract Number: "
 . S IBY=$G(BPSMD(9002313.0301,ZM,240,"E"))
 . S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,25,54)
 . D SET^IBCNBLE(IBLINE)
 . ;
 . S IBL="Forumulary ID: "
 . S IBY=$G(BPSMD(9002313.0301,ZM,926,"E"))
 . S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,25,54)
 . D SET^IBCNBLE(IBLINE)
 . ;
 . S IBL="Benefit ID: "
 . S IBY=$G(BPSMD(9002313.0301,ZM,757,"E"))
 . S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,25,54)
 . D SET^IBCNBLE(IBLINE)
 . ;
 . S IBL="Next Effective Date: "
 . S IBY=$G(BPSMD(9002313.0301,ZM,140,"E"))
 . ;IB*822/CKB - if the date exists, formatted it to be readable
 . I IBY'="" S IBY=$$DATE(IBY)
 . S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,25,54)
 . D SET^IBCNBLE(IBLINE)
 . ;
 . S IBL="Next Termination Date: "
 . S IBY=$G(BPSMD(9002313.0301,ZM,141,"E"))
 . ;IB*822/CKB - if the date exists, formatted it to be readable
 . I IBY'="" S IBY=$$DATE(IBY)
 . S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,25,54)
 . D SET^IBCNBLE(IBLINE)
 . ;
 . Q
 ;
 ; Display Response COB/Other Payers segment
 ; Data stored in 9002313.035501 subfile
 D GETS^DIQ(9002313.0301,ZM,"355.01*","IEN","BPSMCOB")  ; get data
 I $D(BPSMCOB(9002313.035501)) D
 . N ZC,ZCTOT,ZCN
 . S ZC="" F ZCTOT=0:1 S ZC=$O(BPSMCOB(9002313.035501,ZC)) Q:ZC=""     ; count how many entries exist
 . S ZC="",ZCN=0 F  S ZC=$O(BPSMCOB(9002313.035501,ZC)) Q:ZC=""  D
 .. S ZCN=ZCN+1
 .. D SET^IBCNBLE(" ")
 .. D SET^IBCNBLE("  COB/OTHER PAYER INFORMATION ("_ZCN_" of "_ZCTOT_")")
 .. ;
 .. S IBL="Coverage Type: "
 .. S IBY=$G(BPSMCOB(9002313.035501,ZC,338,"E"))
 .. S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,22,57)
 .. I IBY'="" D SET^IBCNBLE(IBLINE)
 .. ;
 .. S IBL="Payer ID Qual: "
 .. S IBY=$G(BPSMCOB(9002313.035501,ZC,339,"E"))
 .. ;IB*822/CKB - add description of the Payer ID Qual code, if code exists
 .. I IBY'="" D
 ... N BPSIEN,BPSDESC
 ... S BPSIEN=$O(^BPS(9002313.43,"B",IBY,""))
 ... I BPSIEN'="" D
 .... S BPSDESC=$$GET1^DIQ(9002313.43,BPSIEN,.02)
 .... S IBY=IBY_" ("_BPSDESC_")"
 .. S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,22,57)
 .. I IBY'="" D SET^IBCNBLE(IBLINE)
 .. ;
 .. S IBL="ID: "                                       ;IB*822/CKB - changed from 'Payer ID' to 'ID'
 .. S IBY=$G(BPSMCOB(9002313.035501,ZC,340,"E"))
 .. S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,22,57)
 .. I IBY'="" D SET^IBCNBLE(IBLINE)
 .. ;
 .. S IBL="Processor Cntrl#: "
 .. S IBY=$G(BPSMCOB(9002313.035501,ZC,991,"E"))
 .. S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,22,57)
 .. I IBY'="" D SET^IBCNBLE(IBLINE)
 .. ;
 .. S IBL="Cardholder ID: "
 .. S IBY=$G(BPSMCOB(9002313.035501,ZC,356,"E"))
 .. S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,22,57)
 .. I IBY'="" D SET^IBCNBLE(IBLINE)
 .. ;
 .. S IBL="Group ID: "
 .. S IBY=$G(BPSMCOB(9002313.035501,ZC,992,"E"))
 .. S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,22,57)
 .. I IBY'="" D SET^IBCNBLE(IBLINE)
 .. ;
 .. S IBL="Person Code: "
 .. S IBY=$G(BPSMCOB(9002313.035501,ZC,142,"E"))
 .. S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,22,57)
 .. I IBY'="" D SET^IBCNBLE(IBLINE)
 .. ;
 .. S IBL="Help Desk Phone: "
 .. S IBY=$G(BPSMCOB(9002313.035501,ZC,127,"E"))
 .. S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,22,57)
 .. I IBY'="" D SET^IBCNBLE(IBLINE)
 .. ;
 .. S IBL="Patient Rel Code: "
 .. S IBY=$G(BPSMCOB(9002313.035501,ZC,143,"E"))
 .. ;IB*822/CKB - add description of the Patient Rel code, if code exists
 .. I IBY'="" D
 ... N BPSIEN,BPSDESC
 ... S BPSIEN=$O(^BPS(9002313.19,"B",IBY,""))
 ... I BPSIEN'="" D
 .... S BPSDESC=$$GET1^DIQ(9002313.19,BPSIEN,.02)
 .... S IBY=IBY_" ("_BPSDESC_")"
 .. S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,22,57)
 .. I IBY'="" D SET^IBCNBLE(IBLINE)
 .. ;
 .. S IBL="Benefit Effective: "
 .. S IBY=$G(BPSMCOB(9002313.035501,ZC,144,"E"))
 .. ;IB*822/CKB - if the date exists, formatted it to be readable
 .. I IBY'="" S IBY=$$DATE(IBY)
 .. S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,22,57)
 .. I IBY'="" D SET^IBCNBLE(IBLINE)
 .. ;
 .. S IBL="Benefit Term: "
 .. S IBY=$G(BPSMCOB(9002313.035501,ZC,145,"E"))
 .. ;IB*822/CKB - if the date exists, formatted it to be readable
 .. I IBY'="" S IBY=$$DATE(IBY)
 .. S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,22,57)
 .. I IBY'="" D SET^IBCNBLE(IBLINE)
 .. ;
 .. Q
 . Q
 ;
 ;IB*822/CKB - If called from Pharmacy Elig (PE) add a Blank line to the end
 I $G(IBPE)=1 D SET^IBCNBLE(" ")
 Q
 ;
DATE(X) ;IB*822/CKB - make the date readable, convert YYYYMMDD to MM/DD/YYYY
 Q $E(X,5,6)_"/"_$E(X,7,8)_"/"_$E(X,1,4)
 ;
NODATA ;IB*822/CKB - if BPS RESPONSE is not found display no data found
 ;Display screen heading
 D SET^IBCNBLE(" ")
 S IBY=$J("",22)_"ePharmacy Eligibility Response Data"
 D SET^IBCNBLE(IBY,"B")
 ;
 D SET^IBCNBLE(" ")
 S IBL="No ePharmacy Eligibility Data found."
 S IBLINE=$$SETL^IBCNBLE("","",IBL,24,55)
 D SET^IBCNBLE(IBLINE)
 D SET^IBCNBLE(" ")
 Q
