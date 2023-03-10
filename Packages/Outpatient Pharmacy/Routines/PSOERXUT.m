PSOERXUT ;ALB/MR - eRx CS utilities ;7/21/2020 9:57am
 ;;7.0;OUTPATIENT PHARMACY;**617,667,651**;DEC 1997;Build 30
 Q
 ;
CSFILTER(ERXIEN) ; Check eRx against CS Filter Prompt Answers
 ; Global variables: PSOCSERX: CS Filter Selection | PSOCSSCH: Drug Schedule Filter Selection
 ; Input: (r)ERXIEN - Pointer to ERX HOLDING QUEUE (#52.49)
 ;Output: 1 - Include the eRx | 0 - Exclude the eRx
 ;
 N DRGCSCH,ERXCSFLG
 S DRGCSCH=$$GET1^DIQ(52.49,ERXIEN,4.9,"I")
 S ERXCSFLG=+$$GET1^DIQ(52.49,ERXIEN,95.1,"I")
 I $G(PSOCSERX)="CS",'ERXCSFLG Q 0
 I $G(PSOCSERX)="Non-CS",ERXCSFLG Q 0
 I $G(PSOCSERX)="CS",+$G(PSOCSSCH)=1,DRGCSCH'="C48675" Q 0
 I $G(PSOCSERX)="CS",+$G(PSOCSSCH)=2,"C48676 C48677 C48679"'[DRGCSCH Q 0
 I $G(PSOCSERX)="B",ERXCSFLG,+$G(PSOCSSCH)=1,DRGCSCH'="C48675" Q 0
 I $G(PSOCSERX)="B",ERXCSFLG,+$G(PSOCSSCH)=2,"C48676 C48677 C48679"'[DRGCSCH Q 0
 Q 1
 ;
VALPTADD(DFN) ; Returns whether the patient has a valid address or not
 ; Input: (r)DFN - Pointer to the PATIENT file (#2)
 ;Output: 1: Valid Address on File (Zip Code or Postal Code value present) | 0: No Valid Address on File
 ;
 N VAPA,I I '$G(DFN) Q 0
 D ADD^VADPT I ((+$G(VAPA(25))=1!($G(VAPA(25))=""))&($G(VAPA(11))=""))!((+$G(VAPA(25))>1)&($G(VAPA(24))="")) Q 0
 Q 1
 ;
CSKEYS(USER) ; Checks whether the user has a valid Security Key for CS Orders
 ; Input: (r)USER - Pointer to the NEW PERSON file (#200)
 ;Output: 1 - Yes, user is authorized to edit and Validate for CS eRx's | 0: Not authorized
 ;
 I '$D(^XUSEC("PSDRPH",USER)),'$D(^XUSEC("PSO ERX ADV TECH",USER)),'$D(^XUSEC("PSO ERX TECH",USER)) Q 0
 Q 1
 ;
PRDRVAL(RESULT,ACTION,ERXIEN,PROVIEN,DRUGIEN) ; API used to Verify Provider and Drug Selection/Validation for CS Prescriptions
 ; Input:(r)ACTION  - Ation being peformed ("EP": Edit Provider | "VP": Validate Provider | "ED": Edit Drug | "VD": Validate Drug | "AC": Accept eRx)
 ;       (r)ERXIEN  - eRx IEN. Pointer to the ERX HOLDING QUEUE file (#52.49)
 ;       (o)PROVIEN - Provider IEN. Pointer to the NEW PERSON file (#200)
 ;       (o)DRUGIEN - Dispense Drug IEN. Pointer to the DRUG file (#50)
 ;Output: RESULT - 1 (Valid Selection) | 0 (Invalid Selection) ^ Compiled Restriction ("W": Warning / "B": Block)
 ;                                       RESULT(1..n)=[Invalid Selection Reason]^Restriction (e.g., RESULT(1)="eRx Provider does not have a valid DEA#.")
 N ERXPROV,DSERXFLG,ERXPRNPI,ERXPRDEA,VAPRNPI,RXWRDATE,VADRSCH,ERXDRSCH,VADEANUM,VACSDRUG,VADEADSP
 K RESULT S RESULT=1 S ERXIEN=+$G(ERXIEN),PROVIEN=+$G(PROVIEN),DRUGIEN=+$G(DRUGIEN)
 I 'PROVIEN,$$GET1^DIQ(52.49,ERXIEN,2.3,"I")>0 S PROVIEN=+$$GET1^DIQ(52.49,ERXIEN,2.3,"I")
 I 'DRUGIEN,$$GET1^DIQ(52.49,ERXIEN,3.2,"I")>0 S DRUGIEN=+$$GET1^DIQ(52.49,ERXIEN,3.2,"I")
 I 'ERXIEN!('PROVIEN&'DRUGIEN) S RESULT="0^B",RESULT(1)="Invalid Parameters" Q
 ;
 S ERXPROV=$$GET1^DIQ(52.49,ERXIEN,2.1,"I")             ; eRx Provider IEN
 S ERXPRNPI=$$GET1^DIQ(52.48,ERXPROV,1.5)               ; eRx Provider NPI
 S ERXPRDEA=$$UP^XLFSTR($$GET1^DIQ(52.48,ERXPROV,1.6))  ; eRx Provider DEA#
 S DSERXFLG=$$GET1^DIQ(52.49,ERXIEN,95.1,"I")           ; eRx Digitally Signed Flag
 S ERXDRSCH=$$ERXDRSCH(ERXIEN)                          ; eRx DEA Drug Schedule
 S RXWRDATE=$$GET1^DIQ(52.49,ERXIEN,5.9,"I")            ; eRx Written Date
 S VACSDRUG=0                                           ; VistA Drug is CS Flag
 ;
 ; Edit/Validate Provider & Accept eRx Checks
 I ACTION="EP"!(ACTION="VP")!(ACTION="AC") D  Q
 . N ERXSUFF S ERXSUFF=0
 . S VAPRNPI=$P($$NPI^XUSNPI("Individual_ID",PROVIEN),"^") S:VAPRNPI'>0 VAPRNPI=""
 . I VAPRNPI'=ERXPRNPI,ACTION'="AC" D
 . . S RESULT($O(RESULT(""),-1)+1)="Provider NPI mismatch (eRx: "_ERXPRNPI_" | VistA: "_VAPRNPI_")"
 . ; Digitally Signed Order
 . I DSERXFLG D
 . . S VADEANUM=$$UP^XLFSTR($$DEA^XUSER(0,PROVIEN,RXWRDATE)),VADEADSP=$P(VADEANUM,"^")
 . . I VADEANUM="" D
 . . . S RESULT($O(RESULT(""),-1)+1)="VistA Provider does not have a valid DEA# on file."
 . . I ERXPRDEA="" D
 . . . S RESULT($O(RESULT(""),-1)+1)="eRx Provider does not have a valid DEA#."
 . . I ERXPRDEA'="",$L(VADEANUM)>2,$P(VADEANUM,"^")'=ERXPRDEA D
 . . . I ($P(ERXPRDEA,"-")=VADEANUM) S ERXSUFF=1 Q
 . . . S RESULT($O(RESULT(""),-1)+1)="Provider DEA mismatch (eRx: "_ERXPRDEA_" | VistA: "_VADEADSP_")."
 . . ; VistA Drug Selected (Additional Checks for CS and Detox drugs)
 . . I DRUGIEN D
 . . . I $$VADRSCH(DRUGIEN)'="" D
 . . . . S VACSDRUG=1
 . . . . S VADRSCH=$$VADRSCH(DRUGIEN)
 . . . . S VADEANUM=$$UP^XLFSTR($$SDEA^XUSER(0,PROVIEN,$P(VADRSCH,"^"),RXWRDATE))
 . . . . S VADEADSP=$$DEA^XUSER(0,PROVIEN,RXWRDATE)
 . . . . I $P(VADEANUM,"^")=2 D
 . . . . . S RESULT($O(RESULT(""),-1)+1)="VistA Provider "_$$GET1^DIQ(200,PROVIEN,.01)_" is NOT authorized to write to the schedule ("_$P(VADRSCH,"^",3)_") of the VistA Drug selected."
 . . . I $$DETOX^PSSOPKI(DRUGIEN),$$DETOX^XUSER(PROVIEN,RXWRDATE)'?2A7N D
 . . . . S VACSDRUG=1
 . . . . S RESULT($O(RESULT(""),-1)+1)="VistA Provider "_$$GET1^DIQ(200,PROVIEN,.01)_" does not have a valid DETOX#."
 . ; All checks are OK
 . ; Add DEA Suffix mismatch message
 . I $G(ERXSUFF) D  Q
 . . I '$O(RESULT(0)) D SUFFWARN(.RESULT,ERXPRDEA,$S($L($G(VADEADSP)):VADEADSP,1:VADEANUM),0) S RESULT="0^W" Q
 . . I ACTION="EP"!(ACTION="VP"),'VACSDRUG D SUFFWARN(.RESULT,ERXPRDEA,$S($L($G(VADEADSP)):VADEADSP,1:VADEANUM),0) S RESULT="0^W" Q
 . . I ACTION="EP" D SUFFWARN(.RESULT,ERXPRDEA,$S($L($G(VADEADSP)):VADEADSP,1:VADEANUM),0) S RESULT="0^W" Q
 . . I ACTION="VP"!(ACTION="AC") D SUFFWARN(.RESULT,ERXPRDEA,$S($L($G(VADEADSP)):VADEADSP,1:VADEANUM),1) S RESULT="0^B" Q
 . I '$O(RESULT(0)) S RESULT=1 Q
 . ; VistA Drug is not Selected or it is not a CS Drug
 . I ACTION="EP"!(ACTION="VP"),'VACSDRUG D  Q
 . . S RESULT="0^W"
 . ; Editing Provider, VistA Drug is CS or Detox, Warning (soft stop) 
 . I ACTION="EP" D  Q
 . . S RESULT="0^W"
 . ; Validating Provider/Accept eRx, VistA Drug is CS or Detox, Block (hard stop) 
 . I ACTION="VP"!(ACTION="AC") D  Q
 . . S RESULT="0^B"
 ;
 ; Edit/Validate Drug & Accept eRx Checks
 I (ACTION="ED")!(ACTION="VD")!(ACTION="AC") D
 . S VADRSCH=$$VADRSCH(DRUGIEN) I VADRSCH'="" S VACSDRUG=1
 . I DSERXFLG,'VACSDRUG,ACTION'="AC" D
 . . S RESULT="0^W"
 . . I ERXDRSCH="" D
 . . . S RESULT($O(RESULT(""),-1)+1)="eRx was digitally signed by the prescriber and VistA Drug selected is Non-CS. Please, review and make sure you selected the correct drug."
 . . E  D
 . . . S RESULT($O(RESULT(""),-1)+1)="eRx Drug is indicated by the prescriber as CS ("_$P(ERXDRSCH,"^",2)_") and VistA Drug selected is Non-CS. Please, review and make sure you selected the correct drug."
 . I 'DSERXFLG,VACSDRUG D
 . . S RESULT="0^B"
 . . I $P(VADRSCH,"^",2)="L" D
 . . . S RESULT($O(RESULT(""),-1)+1)="eRx is not digitally signed and VistA drug is not matched to an NDF item marked with a CS Federal Schedule but is locally marked as a controlled substance ("_$P(VADRSCH,"^",3)_")."
 . . E  DO
 . . . S RESULT($O(RESULT(""),-1)+1)="eRx is not digitally signed and VistA Drug is marked as CS ("_$P(VADRSCH,"^",3)_")."
 . I VACSDRUG,ERXPRDEA="" D
 . . S RESULT="0^B"
 . . S RESULT($O(RESULT(""),-1)+1)="eRx Provider does not have a valid DEA#."
 . ; VistA Provider Selected (Additional Checks)
 . I PROVIEN D
 . . ; CS VistA Drug
 . . I VACSDRUG D
 . . . S VADEANUM=$$UP^XLFSTR($$SDEA^XUSER(0,PROVIEN,$P(VADRSCH,"^"),RXWRDATE))
 . . . S VADEADSP=$$DEA^XUSER(0,PROVIEN,RXWRDATE)
 . . . I ERXPRDEA'="",$L($P(VADEADSP,"^",1))>2,(ERXPRDEA["-"),$P(ERXPRDEA,"-")=VADEADSP,'$G(ERXSUFF) D
 . . . . S RESULT($O(RESULT(""),-1)+1)="Provider DEA suffix mismatch (eRx: "_ERXPRDEA_" | VistA: "_($G(VADEADSP))
 . . . . S RESULT=$S($G(RESULT)="0^B":RESULT,1:"0^W")
 . . . I $P(VADEANUM,"^")=1 D  Q
 . . . . S RESULT="0^B"
 . . . . S RESULT($O(RESULT(""),-1)+1)="VistA Provider "_$$GET1^DIQ(200,PROVIEN,.01)_" does not have a valid DEA# on file."
 . . . I $P(VADEANUM,"^")=2 D  Q
 . . . . S RESULT="0^"_$S(ACTION="ED"&($P($G(RESULT),"^",2)'="B"):"W",1:"B")
 . . . . S RESULT($O(RESULT(""),-1)+1)="VistA Provider "_$$GET1^DIQ(200,PROVIEN,.01)_" is NOT authorized to write to the schedule ("_$P(VADRSCH,"^",3)_") of the VistA Drug selected."
 . . . I $P(VADEANUM,"^")=4 D  Q
 . . . . S RESULT="0^"_$S(ACTION="ED"&($P($G(RESULT),"^",2)'="B"):"W",1:"B")
 . . . . S RESULT($O(RESULT(""),-1)+1)="eRx Written Date/Issue Date is after the VistA Provider DEA expiration date ("_$P(VADEANUM,"^",2)_")."
 . . . I ERXPRDEA'="",$L($P(VADEANUM,"^",1))>2,$P(VADEANUM,"^")'=$P(ERXPRDEA,"-") D
 . . . . S RESULT="0^B"
 . . . . S RESULT($O(RESULT(""),-1)+1)="Provider DEA mismatch (eRx: "_ERXPRDEA_" | VistA: "_VADEANUM_")."
 . . ; Detox VistA Drug
 . . I $$DETOX^PSSOPKI(DRUGIEN),$$DETOX^XUSER(PROVIEN,RXWRDATE)'?1"X"1A7N D
 . . . S RESULT="0^"_$S(ACTION="ED"&($P($G(RESULT),"^",2)'="B"):"W",1:"B")
 . . . S RESULT($O(RESULT(""),-1)+1)="VistA Provider "_$$GET1^DIQ(200,PROVIEN,.01)_" does not have a valid DETOX#."
 ;
 Q
 ;
ERXDRSCH(ERXIEN) ; Returns the CS Schedule for the eRx Drug (Internal^External Format)
 ; Input: (r) ERXIEN    - Pointer to the ERX HOLDING QUEUE file (52.49)
 ;Output:     ERXDRSCH  - eRx DEA Schedule ^ Formatted eRx DEA Schedule (e.g., "2^[C-II]", "4^[C-IV], "", etc...)
 ;
 N ERXDRSCH
 I '$G(ERXIEN) Q ""
 S ERXDRSCH=$$GET1^DIQ(52.49,+ERXIEN,4.9) I ERXDRSCH="" Q ""
 Q (ERXDRSCH_"^[C-"_$S(ERXDRSCH="C48675":"II",ERXDRSCH="C48676":"III",ERXDRSCH="C48677":"IV",ERXDRSCH="C48679":"V",1:"")_"]")
 ;
VADRSCH(DRUGIEN) ; Returns the CS Schedule for the VistA Dispense Drug (Internal^External Format)
 ; Input: (r) DRUGIEN - Pointer to the DRUG file (#50)
 ;Output:     VADRSCH - P1: Schedule (2, 2n, 3, ..5) | P2: "F"ederal or "L"ocally Marked CS | P3: Formatted eRx DEA Schedule (e.g., "3n^F^[C-II]", "5^L^[C-V]", "", etc...)
 ;
 N VADRSCH,VAPRDIEN
 I '$G(DRUGIEN) Q ""
 S VAPRDIEN=+$$GET1^DIQ(50,+DRUGIEN,22,"I")
 S VADRSCH=$S(VAPRDIEN:$$GET1^DIQ(50.68,VAPRDIEN,19,"I"),1:+$$GET1^DIQ(50,DRUGIEN,3))
 I VADRSCH<1!(VADRSCH>5) Q ""
 Q (VADRSCH_"^"_$S(VAPRDIEN:"F",1:"L")_"^[C-"_$S(VADRSCH=2:"II",VADRSCH="2n":"IIn",VADRSCH=3:"III",VADRSCH="3n":"IIIn",+VADRSCH=4:"IV",+VADRSCH=5:"V",1:"")_"]")
 ;
PAUSE ; Pauses screen until user hits Return
 K DIR S DIR("A")="Press Return to continue",DIR(0)="E" D ^DIR
 Q
 ;
ERXIEN(PORXIEN) ; Given the Pending Order (#52.41) or Prescription (#52) IEN, returns the eRx (#52.49) IEN or "" (null)
 ; Input: (r) PORXIEN - Pointer to either the PENDING ORDERS file (#52.41) (e.g., "139839P") or PRESCRIPTION file (#52) (e.g., 12930984)
 ;Output:      ERXIEN - Pointer to the ERX HOLDING QUEUE file (#52.49) or "" (Not an eRx prescription)
 ;
 N OR100IEN
 I '$G(PORXIEN) Q ""
 I PORXIEN'["P" S OR100IEN=$$GET1^DIQ(52,+PORXIEN,39.3,"I")
 I PORXIEN["P" S OR100IEN=+$$GET1^DIQ(52.41,+PORXIEN,.01,"I")
 I '$G(OR100IEN) Q ""
 Q $S($$CHKERX^PSOERXU1(OR100IEN):$$CHKERX^PSOERXU1(OR100IEN),1:"")
 ;
AUDLOG(ERXIEN,FIELD,EDITBY,NEWVAL) ; Sets eRx Edit Audit Log
 ; Input: (r) ERXIEN - Pointer to ERX HOLDING QUEUE File (#52.49). eRx record being edited.
 ;        (r) FIELD  - Freetext eRx Field Name (e.g.,"DRUG", "PROVIDER", "PATIENT", Etc...). Field being edited.
 ;        (r) EDITBY - Pointer to NEW PERSON File (#200). User who made the edit.
 ;        (r) NEWVAL - Array containing the new value for the field being edited (Passed in by Reference)
 ;
 N AUDLOG,SAVERES
 S ERXIEN=+$G(ERXIEN),EDITBY=+$G(EDITBY)
 I '$D(^PS(52.49,ERXIEN,0)) Q  ; Invalid eRx IEN
 I $G(FIELD)="" Q              ; Invalid Field Name
 I '$D(^VA(200,EDITBY,0)) Q    ; Invalid Edit By value
 I '$D(NEWVAL) Q               ; No New Value
 ;
 ; Old value and new value are the same (no edit)
 I $$EQUAL(ERXIEN,FIELD,.NEWVAL) Q
 ;
 ; Saving Data Element
 S AUDLOG(52.4920,"+1,"_ERXIEN_",",.01)=$$NOW^XLFDT() ;Audit Log Date/Time
 S AUDLOG(52.4920,"+1,"_ERXIEN_",",.02)=FIELD         ;Element Name
 S AUDLOG(52.4920,"+1,"_ERXIEN_",",.03)=EDITBY        ;Data Format
 S AUDLOG(52.4920,"+1,"_ERXIEN_",",.04)="NEWVAL"      ;New Value 
 D UPDATE^DIE("","AUDLOG","SAVERES","")
 Q
 ;
EQUAL(ERXIEN,FIELD,NEWVAL) ; Compare if the OLD and NEW values are the same
 ;Input: (r) ERXIEN   - Pointer to ERX HOLDING QUEUE File (#52.49). eRx record being edited.
 ;       (r) FIELD  - Freetext eRx Field Name (e.g.,"DRUG", "PROVIDER", "PATIENT", Etc...). Field being edited.
 ;       (r) NEWVAL - Array containing the new/current value for the field (Passed by Reference)
 ;Output: 1 - Values are equal | 0 - Values are different
 ;
 N EQUAL,OLDVAL,I S EQUAL=1
 ; Retrieving the old/previous value
 D OLDVAL(ERXIEN,FIELD,,.OLDVAL)
 F I=1:1 Q:'$D(OLDVAL(I))  I $G(OLDVAL(I))'=$G(NEWVAL(I)) S EQUAL=0
 I EQUAL F I=1:1 Q:'$D(NEWVAL(I))  I $G(NEWVAL(I))'=$G(OLDVAL(I)) S EQUAL=0
 Q EQUAL
 ;
OLDVAL(ERXIEN,FIELD,STRTFROM,OLDVAL) ; Retrieves the Previous/Old Value for the eRx Field
 ; Input: (r) ERXIEN   - Pointer to ERX HOLDING QUEUE File (#52.49). eRx record being edited.
 ;        (r) FIELD    - Freetext eRx Field Name (e.g.,"DRUG", "PROVIDER", "PATIENT", Etc...). Field being edited.
 ;        (o) STRTFROM - Start From Audit Log IEN. Default: Lastest value for the field.
 ;Output:     OLDVAL   - Array containing the old/previous value for the field (Returned by Reference)
 ;
 N AUDLOG,X K OLDVAL
 S AUDLOG=$S(+$G(STRTFROM):STRTFROM,1:999999999)
 F  S AUDLOG=$O(^PS(52.49,ERXIEN,"AUD",AUDLOG),-1)  Q:'AUDLOG  D  I $O(OLDVAL(0)) Q
 . I $$GET1^DIQ(52.4920,AUDLOG_","_ERXIEN,.02)=FIELD D
 . . F I=1:1 Q:'$D(^PS(52.49,ERXIEN,"AUD",AUDLOG,"VAL",I))  D
 . . . S OLDVAL(I)=^PS(52.49,ERXIEN,"AUD",AUDLOG,"VAL",I,0)
 Q
 ;
PROXYDUZ() ; Returns the Proxy DUZ for Audit Log entries from Auto-Matching
 ; Output: PROXYDUZ - Pointer to NEW PERSON file (#200)
 N DIC,X,Y
 S DIC="^VA(200,",DIC(0)="X",X="PSOAPPLICATIONPROXY,PSO" D ^DIC
 Q $S(+$G(Y):+$G(Y),1:.5)
 ;
DONOTFIL(ERXIEN) ; Do Not Fill record
 ; Input: (r) ERXIEN   - Pointer to ERX HOLDING QUEUE File (#52.49). eRx record being edited.
 ;Output: 1: 'Do Not Fill' eRx Record (Display Message on the Scrren) ! 0: Not a 'Do Not Fill' eRx Record
 ;
 I $$GET1^DIQ(52.49,+$G(ERXIEN),10.5,"I")=2 D  Q 1
 . W !!,"This is a DO NOT FILL record. The only actions available are REMOVE or REJECT.",$C(7)
 . D PAUSE^VALM1
 Q 0
 ;
SUFFWARN(RESULT,ERXPRDEA,VADEADSP,HEADER) ; Append suffix warning to end of RESULT array
 ; Input: (r) ERXPRDEA - eRx DEA number
 ;        (r) VADEADSP - VA DEA #
 ;        (o) HEADER - Print Message Heading
 ; Output: RESULT - DEA Number suffix mismatch warning text
 I $G(HEADER) D
 . S RESULT($O(RESULT(""),-1)+1)="*******************************  WARNING(S)  *******************************"
 S RESULT($O(RESULT(""),-1)+1)="Provider DEA suffix mismatch (eRx: "_ERXPRDEA_" | VistA: "_VADEADSP_")."
 Q
 ;
DEFROUTE(OIIEN) ; Returns the Default Route for Orderable Item
 ; Input: OIIEN    - Orderable Item IEN - Pointer to PHARMACY ORDERABLE ITEM file (#50.7)
 ;Output: DEFROUTE - Default Route (e.g., "ORAL", "TOPICAL", etc..) or "" (No default route found)
 I '$G(OIIEN)!'$D(^PS(50.7,+$G(OIIEN))) Q ""
 N DEFROUTE,DFIEN,RTIEN S DEFROUTE=""
 I $$GET1^DIQ(50.7,OIIEN,10,"I")="N" D                ; OI uses Possible Med Route(s)
 . S RTIEN=$O(^PS(50.7,OIIEN,3,0)) I 'RTIEN Q         ; No Possible Routes Found
 . I $O(^PS(50.7,OIIEN,3,RTIEN)) Q                    ; More than one Possible Med Route Found
 . S DEFROUTE=$$GET1^DIQ(50.711,RTIEN_","_OIIEN,.01)
 I $$GET1^DIQ(50.7,OIIEN,10,"I")="Y" D                ; OI uses Dosage Form Med Route(s)
 . S DFIEN=$$GET1^DIQ(50.7,OIIEN,.02,"I") I 'DFIEN Q  ; No Dosage Form pointer Found
 . S RTIEN=$O(^PS(50.606,DFIEN,"MR",0)) I 'RTIEN Q    ; No Med Route for Dosage Form Found
 . I $O(^PS(50.606,DFIEN,"MR",RTIEN)) Q               ; More than one Med Route Found  
 . S DEFROUTE=$$GET1^DIQ(50.6061,RTIEN_","_DFIEN,.01)
 ;
 ; No Route Found above and Orderable Item has a Default Route
 I DEFROUTE="",$$GET1^DIQ(50.7,OIIEN,.06)'="" Q $$GET1^DIQ(50.7,OIIEN,.06)
 ; Orderable Item has a Default Route that does not match the one found
 I DEFROUTE'="",$$GET1^DIQ(50.7,OIIEN,.06)'="",DEFROUTE'=$$GET1^DIQ(50.7,OIIEN,.06) Q ""
 ;
 Q DEFROUTE
 ;
ERXSIG(ERXIEN) ; Returns the eRx SIG
 ; Input: (r) ERXIEN - Pointer to ERX HOLDING QUEUE File (#52.49)
 ;Output:     ERXSIG - eRx SIG in one string
 ;
 N ERXSIG,SIG,I,S2017,MTYPE,MEDIEN
 S ERXSIG=""
 I '$D(^PS(52.49,+$G(ERXIEN),0)) Q ERXSIG
 S S2017=$$GET1^DIQ(52.49,ERXIEN,312.1,"I")
 S MTYPE=$$GET1^DIQ(52.49,ERXIEN,.08,"I")
 I S2017,MTYPE'="RE" D
 . S MEDIEN=$O(^PS(52.49,ERXIEN,311,"C","P",0))
 . S SIG=$$GET1^DIQ(52.49311,MEDIEN_","_ERXIEN_",",8,"","SIG")
 . F I=1:1 Q:'$D(SIG(I))  D
 . . S ERXSIG=ERXSIG_SIG(I)
 I 'S2017 D
 . S ERXSIG=$$GET1^DIQ(52.49,ERXIEN,7,"E")
 Q ERXSIG
