BPSOSSG ;BHAM ISC/SD/lwj/FLS - Special gets for formats ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
FLD439 ;Reason for service code
 ;Called by SET logic in BPS NCPDP Field DEFS for field 439
 ;DUR is newed in BPSOSHF
 I ^BPS(9002313.99,1,"CERTIFIER")=DUZ S DUR=1
 S $P(^BPSC(BPS(9002313.02),400,BPS(9002313.0201),473.01,DUR,0),U,2)=BPS("X")
 Q
 ;
FLD440 ;Professional Service Code
 ;Called by set logic in BPS NCPDP Field DEFS for field 440
 ;DUR is newed in BPSOSHF
 I ^BPS(9002313.99,1,"CERTIFIER")=DUZ S DUR=1
 S $P(^BPSC(BPS(9002313.02),400,BPS(9002313.0201),473.01,DUR,0),U,3)=BPS("X")
 Q
 ;
FLD441 ;Result of Service Code
 ;Called by SET logic in BPS NCPDP Field DEFS for field 441
 ;DUR is newed in BPSOSHF
 I ^BPS(9002313.99,1,"CERTIFIER")=DUZ S DUR=1
 S $P(^BPSC(BPS(9002313.02),400,BPS(9002313.0201),473.01,DUR,0),U,4)=BPS("X")
 Q
 ;
FLD473 ;DUR/PPS code counter - called from SET logic in BPS NCPDP Field Defs
 ;DUR is newed in BPSOSHF
 I ^BPS(9002313.99,1,"CERTIFIER")=DUZ S DUR=1
 S $P(^BPSC(BPS(9002313.02),400,BPS(9002313.0201),473.01,DUR,0),U,1)=BPS("X")
 S ^BPSC(BPS(9002313.02),400,BPS(9002313.0201),473.01,"B",BPS("X"),DUR)=""
 Q
FLD474 ;DUR/PPS level of effort - called from set logic in BPS NCPDP Field
 ;DUR is newed in BPSOSHF
 I ^BPS(9002313.99,1,"CERTIFIER")=DUZ S DUR=1
 S $P(^BPSC(BPS(9002313.02),400,BPS(9002313.0201),473.01,DUR,0),U,5)=BPS("X")
 Q
 ;
FLD475 ;DUR Co-agent ID Qualifier - called from set logic in BPS NCPDP Field
 ;DUR is newed in BPSOSHF
 I ^BPS(9002313.99,1,"CERTIFIER")=DUZ S DUR=1
 S $P(^BPSC(BPS(9002313.02),400,BPS(9002313.0201),473.01,DUR,0),U,6)=BPS("X")
 Q
 ;
FLD476 ;DUR Co-agent ID - called from set logic in BPS NCPDP Field
 ;DUR is newed in BPSOSHF
 I ^BPS(9002313.99,1,"CERTIFIER")=DUZ S DUR=1
 S $P(^BPSC(BPS(9002313.02),400,BPS(9002313.0201),473.01,DUR,0),U,7)=BPS("X")
 Q
 ;
FLD480 ;Other Amount Claimed Submitted field
 ;Called by set logic in BPS NCPDP Field DEFS for field 480
 ;Sets fields 478, 479, and 480 in BPS Claims
 Q:BPS("X")=""!(BPS("X")=0)!($TR(BPS("X"),"{}0.H7H8H9")="")
 N FDA,MSG
 S FDA(9002313.0601,"+1,"_BPS(9002313.0201)_","_BPS(9002313.02)_",",.01)="H7"_1
 S FDA(9002313.0601,"+1,"_BPS(9002313.0201)_","_BPS(9002313.02)_",",480)=BPS("X")
 S FDA(9002313.0601,"+1,"_BPS(9002313.0201)_","_BPS(9002313.02)_",",479)="H8"_$G(BPS("Insurer","Other Amt Claim Sub Qual"))
 D UPDATE^DIE("","FDA","BPS(9002313.0601)","MSG")
 I $D(MSG) D
 . D LOG2CLM^BPSOSL(BPS(9002313.02),$T(+0)_"-Failed to update NCPDP field 480 and/or 479")
 . D LOGARAY2^BPSOSL(BPS(9002313.02),"MSG")
 Q
 ;
EMPL ;Get employer info
 ; This by GET logic in BPS NCPDP Field Defs for field 315 (Employer Name)
 ; DMB 11/13/2006 - It makes some sense to only set these fields if
 ;   they exist on the payer sheet.  However, it assumes that the
 ;   employer name field will always be before the other fields and
 ;   that the other fields will not exist without the Employer Name
 ;   field.  For now, leave this be as these fields are on the
 ;   Worker's Comp segment, which we do not do.  We may want to evaluate
 ;   if we were to ever add the Worker's Comp segment
 Q:'$G(BPS("Patient","IEN"))
 D GETS^DIQ(2,BPS("Patient","IEN"),".3111;.3112;.3113;.3115;.3116;.3117;.3118;.3119","","EMPL")
 S BPS("Employer","Name")=EMPL(2,BPS("Patient","IEN")_",",.3111)
 S:EMPL(2,BPS("Patient","IEN")_",",.3111)=""&(EMPL(2,BPS("Patient","IEN")_",",.3112)'="") BPS("Employer","Name")=EMPL(2,BPS("Patient","IEN")_",",.3112)
 S BPS("Employer","Address")=EMPL(2,BPS("Patient","IEN")_",",.3113)
 S BPS("Employer","City")=EMPL(2,BPS("Patient","IEN")_",",.3116)
 S BPS("Employer","State")=EMPL(2,BPS("Patient","IEN")_",",.3117)
 I BPS("Employer","State")'="" D
 . S STATEIEN="",STATEIEN=$O(^DIC(5,"B",BPS("Employer","State"),STATEIEN)),BPS("Employer","State")=$P($G(^DIC(5,STATEIEN,0)),"^",2)
 S BPS("Employer","Zip Code")=EMPL(2,BPS("Patient","IEN")_",",.3118)
 S BPS("Employer","Phone")=EMPL(2,BPS("Patient","IEN")_",",.3119)
 K EMPL,STATEIEN
 Q
 ;
STLIC(STATE) ; Retrieve the state license number.
 ;  This can be called by the special code in the payer sheet
 ;  References to State file (DIC(5)) covered by IA 10056
 ;  References to New Person file (VA(200)) covered by IA 10060
 ;  
 ;
 ; Validate the STATE parameter
 I $G(STATE)="" Q ""
 ;
 ; Get state IEN and make sure it exists
 N STIEN
 S STIEN=$O(^DIC(5,"C",STATE,0))
 I STIEN="" Q ""
 ;
 ; Get Provider IEN and make sure it exist
 N PROVIEN
 S PROVIEN=$G(BPS("RX",BPS(9002313.02),"Prescriber IEN"))
 I PROVIEN="" Q ""
 ;
 ; Get the expiration date and compare to the date of service
 N EXPDT
 S EXPDT=$$GET1^DIQ(200.541,STIEN_","_PROVIEN_",",2)
 I EXPDT,EXPDT+17000000<$G(BPS("RX",BPS(9002313.02),"Date Filled")) Q ""
 ;
 ; Get the license number
 Q $$GET1^DIQ(200.541,STIEN_","_PROVIEN_",",1)
 ;
STDEA(STATE) ; Retrieve the state DEA number.
 ;  This can be called by the special code in the payer sheet
 ;  References to State file (DIC(5)) covered by IA 10056
 ;  References to New Person file (VA(200)) covered by IA 10060
 ;
 ; Validate the STATE parameter
 I $G(STATE)="" Q ""
 ;
 ; Get state IEN and make sure it exists
 N STIEN
 S STIEN=$O(^DIC(5,"C",STATE,0))
 I STIEN="" Q ""
 ;
 ; Get Provider IEN and make sure it exist
 N PROVIEN
 S PROVIEN=$G(BPS("RX",BPS(9002313.02),"Prescriber IEN"))
 I PROVIEN="" Q ""
 ;
 ; Get the license number
 Q $$GET1^DIQ(200.55,STIEN_","_PROVIEN_",",1)
