IBCNBLE2 ;ALB/ESG - Expand ins buffer - e-Pharmacy entry ;14-Oct-2010
 ;;2.0;INTEGRATED BILLING;**435**;21-MAR-94;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; References to BPS RESPONSES file (#9002313.03) supported by IA 4813
 ; Called by IBCNBLE when expanding an e-Pharmacy buffer entry
 ; Variable IB0 is the 0 node of file 355.33
 ;
EN ; Entry point
 N RESPIEN,RSPSUB,ZR,ZM,BPSR,BPSM,BPSMD,BPSMCOB,IBY,IBL,IBLINE,TEXT
 ;
 S RESPIEN=+$P(IB0,U,17) I 'RESPIEN G EX
 I '$D(^BPSR(RESPIEN,0)) G EX
 S ZR=RESPIEN_","
 D GETS^DIQ(9002313.03,ZR,".01:999","IEN","BPSR")   ; get all fields at top level except raw data
 ;
 S RSPSUB=+$O(^BPSR(RESPIEN,1000,0)),ZM=0
 I RSPSUB D
 . S ZM=RSPSUB_","_RESPIEN_","
 . D GETS^DIQ(9002313.0301,ZM,"112;503;511*;130.01*;549;550;987","IEN","BPSM")  ; get Response Status Segment data
 . Q
 ;
 D SET^IBCNBLE(" ")
 S IBY=$J("",22)_"e-Pharmacy Eligibility Response Data"
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
 I IBY'="" D
 . N HDPQ
 . S HDPQ=$G(BPSM(9002313.0301,ZM,549,"E")) Q:HDPQ=""    ; help desk phone# qualifier
 . S HDPQ=$S(+HDPQ=1:"Switch",+HDPQ=2:"Intermediary",+HDPQ=3:"Processor/PBM",1:"Other")
 . S IBY=IBY_" ("_HDPQ_")"
 . Q
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
 . S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,25,54)
 . D SET^IBCNBLE(IBLINE)
 . ;
 . S IBL="Next Termination Date: "
 . S IBY=$G(BPSMD(9002313.0301,ZM,141,"E"))
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
 .. S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,22,57)
 .. I IBY'="" D SET^IBCNBLE(IBLINE)
 .. ;
 .. S IBL="Payer ID: "
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
 .. S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,22,57)
 .. I IBY'="" D SET^IBCNBLE(IBLINE)
 .. ;
 .. S IBL="Benefit Effective: "
 .. S IBY=$G(BPSMCOB(9002313.035501,ZC,144,"E"))
 .. S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,22,57)
 .. I IBY'="" D SET^IBCNBLE(IBLINE)
 .. ;
 .. S IBL="Benefit Term: "
 .. S IBY=$G(BPSMCOB(9002313.035501,ZC,145,"E"))
 .. S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,22,57)
 .. I IBY'="" D SET^IBCNBLE(IBLINE)
 .. ;
 .. Q
 . Q
 ;
EX ;
 Q
 ;
