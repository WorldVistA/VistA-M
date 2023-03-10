RCTAS10I ;HAF/PJH; MCCF Date Index Logic;4/20/20 2:50pm
 ;;4.5;Accounts Receivable;**371**;Mar 20, 1995;Build 29
 ;Per VA Directive 6402, this routine should not be modified.
 Q
RECEIPT(RCPTIEN) ; File #344 Action AMCCF to update ERA or EFT DETAIL indexes
 ; INPUT - RCPTIEN - Receipt #344 IEN
 ; OUTPUT - Update MCCF index on ##344.4 or #344.31
 ;
 ; No action if this is not EDI receipt
 Q:$$GET1^DIQ(344,RCPTIEN_",",.04,"E")'="EDI LOCKBOX"
 ;
 N RCDOC,RCEFT
 ; Get document
 S RCDOC=$$GET1^DIQ(344,RCPTIEN_",",200,"E")
 ; Check if EFT exists
 S RCEFT=$O(^RCY(344.31,"MCCFR",RCPTIEN,""))
 ; If this is CR receipt for an EFT
 I $E(RCDOC,1,2)="CR",RCEFT D  Q
 .; Update #344.31 MCCF index
 .N DA,FDA,MSG,DIERR
 .S DA=RCEFT
 .S FDA(344.31,DA_",",9)="NOW"
 .D FILE^DIE("E","FDA","MSG")
 ;
 ; If ERA type receipt TR for EFT or CR for ERA matched to paper
 N RCERA
 ;Get ERA ien
 S RCERA=$$GET1^DIQ(344,RCPTIEN_",",.18,"I")
 I RCERA D  Q
 .; Update #344.4 MCCF index
 .N DA,FDA,MSG,DIERR
 .S DA=RCERA
 .S FDA(344.4,DA_",",9)="NOW"
 .D FILE^DIE("E","FDA","MSG")
 Q
 ;
ACCOUNT(RCACCNT) ; File #430 Action AMCCF to update ERA indexes
 ;
 ; INPUT - RCACCNT - AR Acccount #430 IEN
 ; OUTPUT - Update MCCF index on #344.4
 ;
 N RCCLAIM,RCERA
 ; External format claim number
 S RCCLAIM=$$GET1^DIQ(430,RCACCNT_",",.01,"E") Q:'RCCLAIM
 S:RCCLAIM["-" RCCLAIM=$P(RCCLAIM,"-",2)
 S RCERA=""
 ; Search scratchpad index for ERA containing this claim
 F  S RCERA=$O(^RCY(344.49,"D",RCCLAIM,RCERA)) Q:'RCERA  D
 .; Update #344.4 MCCF index (DINUM)
 .N DA,FDA,MSG,DIERR
 .S DA=RCERA
 .S FDA(344.4,DA_",",9)="NOW"
 .D FILE^DIE("E","FDA","MSG")
 Q
 ;
EOB(RCEOB) ; File #361.1 Action AMCCF to update ERA indexes
 ;
 ; INPUT - RCEOB - EOB #361.1 IEN
 ; OUTPUT - Update MCCF index on #344.4
 ;
 N RCERA
 S RCERA=""
 ; Search scratchpad index for ERA containing this claim
 F  S RCERA=$O(^RCY(344.4,"ADET",RCEOB,RCERA)) Q:'RCERA  D
 .; Update #344.4 MCCF index (DINUM)
 .N DA,FDA,MSG,DIERR
 .S DA=RCERA
 .S FDA(344.4,DA_",",9)="NOW"
 .D FILE^DIE("E","FDA","MSG")
 Q
 ;
FMSSTAT(IEN347) ; Get receipt for FMS Document and mark EFT or ERA as updated
 ; INPUT - IEN347 = AR FMS DOCUMENT file #347 IEN
 ; OUTPUT - Update MCCF index on #344.4 or #344.31
 N RCPTIEN,FMSDOC
 ; Get document number
 S FMSDOC=$$GET1^DIQ(347,IEN347_",",.09)
 ; Skip if not found
 Q:FMSDOC=""
 ; Find Receipt
 S RCPTIEN=$O(^RCY(344,"ADOC",FMSDOC,"")) Q:'RCPTIEN
 ; Mark EFT DETAIL or ERA as updated
 D RECEIPT(RCPTIEN)
 Q
 ;
