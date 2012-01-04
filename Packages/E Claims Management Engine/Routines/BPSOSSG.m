BPSOSSG ;BHAM ISC/SD/lwj/FLS - Special gets for formats ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,10**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
FLD420 ; Submission Clarification Code
 ; place fields 354 and 420 into BPS CLAIMS
 ; called by SET CODE in BPS NCPDPD FIELD DEFS for field 420
 ;
 Q:'$G(BPS(9002313.0201))  ; must have entry IEN
 ;
 N BPSCNTR,CNT,FDA,MSG,FLDIEN,SCC,I
 K BPS(9002313.0354)  ; results from UPDATE^DIE
 S FLDIEN=$O(^BPSF(9002313.91,"B",420,""))  ;Get IEN for field 420 from NCPDP BPS FIELD DEFS
 ; Are there overrides?
 I $G(FLDIEN),$D(BPS("OVERRIDE","RX",BPS(9002313.0201),FLDIEN)) D
 . K BPS("RX",BPS(9002313.0201),"Submission Clarif Code")
 . S SCC=BPS("OVERRIDE","RX",BPS(9002313.0201),FLDIEN)
 . F I=1:1:$S($G(BPS("NCPDP","Version"))="51":1,1:3) S BPS("RX",BPS(9002313.0201),"Submission Clarif Code",I)=$P(SCC,"~",I)
 Q:'$O(BPS("RX",BPS(9002313.0201),"Submission Clarif Code",0))  ; no values found
 S (CNT,BPSCNTR)=0
 F  S CNT=$O(BPS("RX",BPS(9002313.0201),"Submission Clarif Code",CNT)) Q:'CNT  D
 .I BPS("RX",BPS(9002313.0201),"Submission Clarif Code",CNT)="" Q
 .S BPSCNTR=BPSCNTR+1  ; ien for (#354.01) SUBMISSION CLARIFICATION MLTPL
 .S FDA(9002313.02354,"+"_BPSCNTR_","_BPS(9002313.0201)_","_BPS(9002313.02)_",",.01)=BPSCNTR
 .; 420-DK Submission Clarification Code
 .S FDA(9002313.02354,"+"_BPSCNTR_","_BPS(9002313.0201)_","_BPS(9002313.02)_",",420)="DK"_$$NFF^BPSECFM(BPS("RX",BPS(9002313.0201),"Submission Clarif Code",CNT),2)
 ;
 I BPSCNTR D UPDATE^DIE("","FDA","BPS(9002313.0354)","MSG")
 I $D(MSG) D  Q  ; if error, log it and quit
 .D LOG2CLM^BPSOSL(BPS(9002313.02),$T(+0)_"-Failed to update NCPDP field 420")
 .D LOGARAY2^BPSOSL(BPS(9002313.02),"MSG")
 ;
 ; 354-NX Submission Clarification Code Count
 I BPSCNTR S $P(^BPSC(BPS(9002313.02),400,BPS(9002313.0201),350),U,4)="NX"_$$NFF^BPSECFM(BPSCNTR,1)
 ;
 Q
 ;
FLD439 ;Reason for service code
 ;Called by SET logic in BPS NCPDP Field DEFS for field 439
 ;DUR is newed/set in BPSOSHF
 S $P(^BPSC(BPS(9002313.02),400,BPS(9002313.0201),473.01,DUR,0),U,2)=BPS("X")
 Q
 ;
FLD440 ;Professional Service Code
 ;Called by set logic in BPS NCPDP Field DEFS for field 440
 ;DUR is newed/set in BPSOSHF
 S $P(^BPSC(BPS(9002313.02),400,BPS(9002313.0201),473.01,DUR,0),U,3)=BPS("X")
 Q
 ;
FLD441 ;Result of Service Code
 ;Called by SET logic in BPS NCPDP Field DEFS for field 441
 ;DUR is newed/set in BPSOSHF
 S $P(^BPSC(BPS(9002313.02),400,BPS(9002313.0201),473.01,DUR,0),U,4)=BPS("X")
 Q
 ;
FLD473 ;DUR/PPS code counter - called from SET logic in BPS NCPDP Field Defs
 ;DUR is newed/set in BPSOSHF
 S $P(^BPSC(BPS(9002313.02),400,BPS(9002313.0201),473.01,DUR,0),U,1)=BPS("X")
 S ^BPSC(BPS(9002313.02),400,BPS(9002313.0201),473.01,"B",BPS("X"),DUR)=""
 Q
 ;
FLD474 ;DUR/PPS level of effort - called from set logic in BPS NCPDP Field
 ;DUR is newed/set in BPSOSHF
 S $P(^BPSC(BPS(9002313.02),400,BPS(9002313.0201),473.01,DUR,0),U,5)=BPS("X")
 Q
 ;
FLD475 ;DUR Co-agent ID Qualifier - called from set logic in BPS NCPDP Field
 ;DUR is newed/set in BPSOSHF
 S $P(^BPSC(BPS(9002313.02),400,BPS(9002313.0201),473.01,DUR,0),U,6)=$S($G(BPS("NCPDP","Version"))=51:BPS("X"),1:"")
 Q
 ;
FLD476 ;DUR Co-agent ID - called from set logic in BPS NCPDP Field
 ;DUR is newed/set in BPSOSHF
 S $P(^BPSC(BPS(9002313.02),400,BPS(9002313.0201),473.01,DUR,0),U,7)=$S($G(BPS("NCPDP","Version"))=51:BPS("X"),1:"")
 Q
 ;
FLD480 ; Other Amount Claimed Submitted field
 ; Called by set logic in BPS NCPDP Field DEFS for field 480
 ; Sets fields 478, 479, and 480 into BPS Claims
 ;   479-H8 Other Amount Claimed Submitted Qualifier
 ;   480-H9 Other Amount Claimed Submitted
 ;
 Q:'$G(BPS(9002313.0201))  ; must have entry IEN
 Q:'$O(BPS("Insurer","Other Amt Value",0))  ; nothing to do
 ;
 N BPSCNTR,CNT,FDA,MSG
 K BPS(9002313.0601)  ; results from UPDATE^DIE
 S (CNT,BPSCNTR)=0
 F  S CNT=$O(BPS("Insurer","Other Amt Value",CNT)) Q:'CNT  D
 . I +BPS("Insurer","Other Amt Value",CNT)=0 Q
 . S BPSCNTR=BPSCNTR+1  ; ien for "PRICING REPEATING FIELDS SUB-FIELD^^480^3"
 . S FDA(9002313.0601,"+"_BPSCNTR_","_BPS(9002313.0201)_","_BPS(9002313.02)_",",.01)=BPSCNTR
 . S FDA(9002313.0601,"+"_BPSCNTR_","_BPS(9002313.0201)_","_BPS(9002313.02)_",",479)="H8"_$$ANFF^BPSECFM($G(BPS("Insurer","Other Amt Qual",CNT)),2)
 . S FDA(9002313.0601,"+"_BPSCNTR_","_BPS(9002313.0201)_","_BPS(9002313.02)_",",480)="H9"_$$DFF^BPSECFM($G(BPS("Insurer","Other Amt Value",CNT)),8)
 ;
 I BPSCNTR D UPDATE^DIE("","FDA","BPS(9002313.0601)","MSG")
 I $D(MSG) D  Q
 . D LOG2CLM^BPSOSL(BPS(9002313.02),$T(+0)_"-Failed to update NCPDP field 480 and/or 479")
 . D LOGARAY2^BPSOSL(BPS(9002313.02),"MSG")
 ; 478-H7 Other Amount Claimed Submitted Count
 I BPSCNTR S $P(^BPSC(BPS(9002313.02),400,BPS(9002313.0201),470),U,8)="H7"_$$NFF^BPSECFM(BPSCNTR,1)
 ;
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
