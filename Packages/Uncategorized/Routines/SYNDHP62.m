SYNDHP62 ;DHP/ART -  Write Problems, Appointments To VistA ;05/29/2018
 ;;0.2;VISTA SYN DATA LOADER;;Feb 07, 2019;Build 10
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of DXC Technology 2017-2018
 ;
 QUIT
 ;
 ; -------- Problem/Condition update
 ;
PRBUPDT(RETSTA,DHPPAT,DHPVST,DHPROV,DHPONS,DHPABT,DHPCLNST,DHPSCT) ;Problem/Condition update
 ;
 ; Input:
 ;   DHPPAT   - Patient ICN
 ;   DHPVST   - Visit ID
 ;   DHPROV   - Provider ID (NPI)
 ;   DHPONS   - Onset Date (HL7 format)
 ;   DHPABT   - Abatement Date (HL7 format)
 ;   DHPCLNST - Clinical Status ?   (A or I)
 ;   DHPSCT   - SNOMED CT code
 ;
 ; Output:   RETSTA
 ;  1 - success
 ; -1 - failure -1^message
 ;
 I '$D(^DPT("AFICN",DHPPAT)) S RETSTA="-1^Patient not recognised" Q
 ;
 I $G(DHPSCT)="" S RETSTA="-1^SNOMED CT code is required" Q
 I $G(DHPVST)="" S RETSTA="-1^Visit IEN is required" Q
 I $G(DHPONS)="" S RETSTA="-1^onset date is required" Q
 I '$D(^AUPNVSIT(DHPVST)) S RETSTA="-1^Visit not found" Q
 ;
 N PACKAGE,SOURCE,USER,ERRDISP,ZZERR,PPEDIT,ZZERDESC,ACCOUNT
 N PROBDATA,PRBPRIEN,STATII,MAPVUID,P,DHPICD,DHPCS,MAPPING
 ;
 S PACKAGE=$$FIND1^DIC(9.4,,"","PCE")
 S SOURCE="DHP DATA INGEST"
 S USER=$$DUZ^SYNDHP69
 S ERRDISP=""
 I $G(DEBUG)=1 S ERRDISP=1
 S PPEDIT=""
 S ACCOUNT=""
 S P="|"
 ;
 S RETSTA=1
 ;
 S PROBDATA("DX/PL",1,"PL ADD")=1
 S DHPONS=$P($$HL7TFM^XLFDT(DHPONS),".",1)
 ;20130526110511-0400
 ;date portion only, active problems can not have a date resolved
 S PROBDATA("DX/PL",1,"PL ONSET DATE")=DHPONS
 S:$G(DHPABT)'="" PROBDATA("DX/PL",1,"PL RESOLVED DATE")=$P($$HL7TFM^XLFDT(DHPABT),".",1)
 ;
 ;S MAPVUID=5217693 ; VUID for SNOMED CT to ICD-10-CM mapping
 ;K LEX
 ;S DHPICD=$$GETASSN^LEXTRAN1(DHPSCT,MAPVUID)
 ;S DHPICD=$O(LEX(1,""))
 ;I DHPICD="" S DHPICD="R69."
 ;S DHPICD=+$$ICDDX^ICDEX(DHPICD,30) ;30=ICD-10
 ;S PROBDATA("DX/PL",1,"DIAGNOSIS")=DHPICD
 ;S PROBDATA("DX/PL",1,"DIAGNOSIS")=DHPSCT
 ;
 ; next line determines whether to use ICD10 or ICD9 map
 S MAPPING=$S(DHPONS>3150930:"sct2icd",1:"sct2icdnine")
 ;
 ;W !!,">>>> DHPONS ",DHPONS
 ;W !,">>>> MAPPING ",MAPPING,!!
 ;
 ;
 S DHPICD=$$MAP^SYNDHPMP(MAPPING,DHPSCT)
 I +DHPICD=-1 S RETSTA="-1^SNOMED CT CODE "_DHPSCT_" not mapped" Q
 S DHPCS=$S(DHPONS>3150930:30,1:1)
 S DHPICD=$P(DHPICD,U,2) ; DHPICD now contains ICD code from mapping return
 N ICDTX
 S ICDTX=$$ICDDX^ICDEX(DHPICD,DHPCS)
 ;
 S DHPICD=+ICDTX ; DHPICD now contains ICD code IEN
 I +DHPICD=-1 S RETSTA="-1^ICD Code "_DHPICD_" not on file" Q
 S DHPDXNR=$P(ICDTX,U,4)
 S PROBDATA("DX/PL",1,"DIAGNOSIS")=DHPICD
 S PROBDATA("DX/PL",1,"NARRATIVE")=DHPDXNR
 N SERCAT
 S SERCAT="A" ; $S(DHPONS\1<$$DT^XLFDT:"E",1:"A")
 S PROBDATA("DX/PL",1,"SERVICE CATEGORY")=SERCAT ; A for current E for historical
 S DHPDXF=$$PRMDX(DHPVST,DHPICD)
 I DHPDXF=-1 S RETSTA="-1^Problem with DX code "_DHPICD_" already exists for visit "_DHPVST Q
 S PROBDATA("DX/PL",1,"PRIMARY")=DHPDXF
 ;
 I $G(DHPROV)'="" D
 . S PRBPRIEN=$O(^VA(200,"ANPI",DHPROV,""))
 . QUIT:PRBPRIEN=""
 . S PROBDATA("DX/PL",1,"ENC PROVIDER")=PRBPRIEN
 ;
 S STATII=P_"A"_P_"I"_P
 S:$G(DHPCLNST)'="" PROBDATA("DX/PL",1,"PL ACTIVE")=$S(STATII[(P_$G(DHPCLNST)_P):DHPCLNST,1:"A")
 ;
 S RETSTA=$$DATA2PCE^PXAI("PROBDATA",PACKAGE,SOURCE,.DHPVST,USER,$G(ERRDISP),.ZZERR,$G(PPEDIT),.ZZERDESC,.ACCOUNT)
 ;I $D(ZZERR) ZWRITE ZZERR
 S RETSTA=RETSTA_"^"_$G(DHPVST)
 I $D(ZZERDESC) M RETSTA("ZZERDESC")=ZZERDESC
 I $D(ZZERR) M RETSTA("ZZERR")=ZZERR
 M RETSTA("PROBDATA")=PROBDATA
 ;
 ; $$DATA2PCE Output:
 ;+   1  if no errors and processed completely
 ;+  -1  if errors occurred but processed completely as possible
 ;+  -2  if could not get a visit
 ;+  -3  if called incorrectly
 QUIT
 ;
PRMDX(X,D) ; Check if primary diagnosis
 ; Input:
 ;   X - visit IEN
 ;   D - DX code IEN
 ; Output
 ;   1 if code D can be filed as primary DX
 ;   0 if code D can be filed as secondary DX
 ;  -1 if there is already a problem with DX code D files for the visit
 ;
 N IND,PRMDX,DIAG
 S IND=0
 F  S IND=$O(^AUPNVPOV("AD",X,IND)) Q:IND=""  D
 .I $P(^AUPNVPOV(IND,0),U,12)="P" D
 ..S DIAG=$P(^AUPNVPOV(IND,0),U,1)
 ..S PRMDX(DIAG)=""
 I '$D(PRMDX) Q 1  ; D is the primary DX
 I '$D(PRMDX(D)) Q 0  ; D is a secondary DX
 Q -1  ; problem with DX D already exists for visit
 ;
 ; -------- Appointment create
 ;
APPTADD(RETSTA,DHPPAT,DHPCLIN,DHPAPTDT,DHPLEN) ;Create appointment
 ;
 ;     - past appointments are created as Walk-in, NSC, Regular appointments
 ;     - future appointments are created as NSC, Regular appointments
 ;
 ; Input:
 ;   DHPPAT   - Patient ICN (required)
 ;   DHPCLIN  - Clinic Name (required)
 ;   DHPAPTDT - Appointment Date & Time (required) all dates received in HL7 format
 ;   DHPLEN   - Appointment length as minutes (optional, defaults to 15 mins.)
 ;
 ; Output:   RETSTA("APPT")
 ;  1 - success
 ; -1 - failure -1^message
 ;
 N PATDFN,APPTDT,APPTLEN,CHKINDT,CHKOUTDT,COFLG,CLINIEN,INACTDT,REACTDT
 N Y,EXDATE,BADDATE,RESULT,MSG
 ;
 I $G(DHPPAT)="" S RETSTA("APPT")="-1^Missing patient identifier (#2)." QUIT
 I $G(DHPCLIN)="" S RETSTA("APPT")="-1^Missing appt. location (#44)." QUIT
 I $G(DHPAPTDT)="" S RETSTA("APPT")="-1^Missing date/time for appt." QUIT
 ;
 I '$D(^DPT("AFICN",DHPPAT)) S RETSTA("APPT")="-1^Patient not recognised" QUIT
 S PATDFN=$O(^DPT("AFICN",DHPPAT,""))
 ;
 ; -- Check appointment date/time --
 S APPTDT=$$HL7TFM^XLFDT(DHPAPTDT)
 I $P(APPTDT,".",2)="" S RETSTA("APPT")="-1^Missing time for appt." QUIT
 ;convert to external and check date/time against Fileman date/time field
 S Y=APPTDT
 D DD^%DT
 S EXDATE=Y ;Convert to external
 D CHK^DIE(2.98,.001,"",EXDATE,.RESULT,.MSG)
 I RESULT="^" S RETSTA("APPT")="-1^Invalid appt date/time." QUIT
 ;
 S USER=$$DUZ^SYNDHP69
 ;
 S:$G(DHPLEN)="" APPTLEN=15 ;default appointment length
 ;
 ; -- Check Clinic --
 S CLINIEN=$O(^SC("B",DHPCLIN,""))
 I CLINIEN="" S RETSTA("APPT")="-1^Invalid clinic name (#44)." QUIT
 S INACTDT=$$GET1^DIQ(44,CLINIEN_",",2505,"I") ;inactivate date
 S REACTDT=$$GET1^DIQ(44,CLINIEN_",",2506,"I") ;reactivate date
 I INACTDT'="",REACTDT="",INACTDT<APPTDT S RETSTA("APPT")="-1^Clinic inactive on appt. date (#44)." QUIT
 I REACTDT'="",REACTDT>INACTDT,REACTDT>APPTDT S RETSTA("APPT")="-1^Clinic inactive on appt. date (#44)." QUIT
 I REACTDT'="",REACTDT<INACTDT,INACTDT<APPTDT S RETSTA("APPT")="-1^Clinic inactive on appt. date (#44)." QUIT
 ;
 ; -- Check for Clinic stop code --
 I $$GET1^DIQ(44,CLINIEN_",",8)="" D  QUIT
 . S RETSTA("APPT")="-1^Clinic missing STOP CODE NUMBER (#44,8)."
 ;
 I $G(DEBUG)=1 D
 . W "Create Appointment  APPTADD^SYNDHP62",!
 . W "ICN: ",DHPPAT,"   DFN: ",PATDFN,!
 . W "CLINIC: ",DHPCLIN,"   IEN: ",CLINIEN,!
 . W "APPT D/T: ",DHPAPTDT,"   ",APPTDT,!
 ;
 I $D(^DPT(PATDFN,"S",APPTDT,0)),$P($G(^DPT(PATDFN,"S",APPTDT,0)),U,2)'="C" D  QUIT
 . S RETSTA("APPT")="-1^Duplicate Appointment"
 ;
 ; -- create patient appointment --
 N FDA,ERRMSG,IENS,IENROOT
 S IENS="+1,"_PATDFN_","
 S FDA(2.98,IENS,.001)=APPTDT ;appointment date/time
 S FDA(2.98,IENS,.01)=CLINIEN ;clinic
 S FDA(2.98,IENS,3)="" ;status
 S FDA(2.98,IENS,9.5)=9 ;appointment type (9=regular)
 S FDA(2.98,IENS,19)=DUZ ;data entry clerk
 S FDA(2.98,IENS,20)=DT ;date appointment made
 S FDA(2.98,IENS,21)="" ;pointer to Encounter record (409.68)
 I APPTDT<$$NOW^XLFDT() D
 . S FDA(2.98,IENS,9)=4 ;purpose of visit (4=unscheduled visit)
 . S FDA(2.98,IENS,25)="W" ;sched request type (W=walk-in)
 . S FDA(2.98,IENS,26)=0 ;next available appt indicator
 E  D
 . S FDA(2.98,IENS,9)=3 ;purpose of visit (3=scheduled visit)
 . S FDA(2.98,IENS,25)="N" ;sched request type (N=next available)
 . S FDA(2.98,IENS,26)=1 ;next available appt indicator
 . S FDA(2.98,IENS,27)=$P(APPTDT,".",1) ;desired date of appointment
 . S FDA(2.98,IENS,28)=0 ;follow-up visit (0=no)
 D UPDATE^DIE("","FDA","IENROOT","ERRMSG")
 I $D(ERRMSG) D  QUIT
 . S RETSTA("APPT")="-1^Problem saving patient appointment info (#2.98) - "_$G(ERRMSG("DIERR",1,"TEXT",1))
 ;
 ; -- create clinic appointment --
 N FDA,IENS,ERRMSG,ERROR
 S IENS="+2,"_CLINIEN_","
 S IENS(2)=+APPTDT
 S ERROR=0
 I '$D(^SC(CLINIEN,"S",APPTDT,0)) D
 . S FDA(44.001,IENS,.01)=+APPTDT ;appointment date/time
 . D UPDATE^DIE("","FDA","IENS","ERRMSG")
 . I $D(ERRMSG) D  QUIT
 . . S RETSTA("APPT")="-1^Problem saving clinic appointment date (#44.001) - "_$G(ERRMSG("DIERR",1,"TEXT",1))
 . . S ERROR=1
 ;ZWRITE IENS
 QUIT:ERROR
 S APPTDT=$G(IENS(2))
 N FDA,IENS,ERRMSG
 S IENS="?+1,"_+APPTDT_","_CLINIEN_","
 S FDA(44.003,IENS,.01)=PATDFN ;patient dfn
 S FDA(44.003,IENS,1)=APPTLEN ;appointment length
 S FDA(44.003,IENS,7)=DUZ ;data entry clerk
 S FDA(44.003,IENS,8)=$P($$NOW^XLFDT,".",1) ;date appointment made
 D UPDATE^DIE("","FDA","IENS","ERRMSG")
 ;ZWRITE IENS
 I $D(ERRMSG) D  QUIT
 . S RETSTA("APPT")="-1^Problem saving clinic appointment (#44.003) - "_$G(ERRMSG("DIERR",1,"TEXT",1))
 ;
 S RETSTA("APPT")=1
 ;
 QUIT
 ;
 ; -------- Appointment check-in
 ;
APPTCKIN(RETSTA,DHPPAT,DHPCLIN,DHPAPTDT,DHPCIDT) ;Check-in appointment
 ;
 ; Input:
 ;   DHPPAT   - Patient ICN (required)
 ;   DHPCLIN  - Clinic Name (required)
 ;   DHPAPTDT - Appointment Date & Time (required) all dates received in HL7 format
 ;   DHPCIDT  - Check-in Date & Time (optional, will default to appointment date/time)
 ;
 ; Output:   RETSTA("CKIN")
 ;  1 - success
 ; -1 - failure -1^message
 ;
 N Y,PATDFN,APPTDT,CHKINDT,CLINIEN,EXDATE,BADDATE,RESULT,MSG,HIT,CLAPTIEN,ELIGCODE
 ;
 I $G(DHPPAT)="" S RETSTA("CKIN")="-1^Missing patient identifier (#2)." QUIT
 I $G(DHPCLIN)="" S RETSTA("CKIN")="-1^Missing appt. location (#44)." QUIT
 I $G(DHPAPTDT)="" S RETSTA("CKIN")="-1^Missing date/time for appt." QUIT
 ;
 I '$D(^DPT("AFICN",DHPPAT)) S RETSTA("CKIN")="-1^Patient not recognised" QUIT
 S PATDFN=$O(^DPT("AFICN",DHPPAT,""))
 ;
 ; -- Check Clinic --
 S CLINIEN=$O(^SC("B",DHPCLIN,""))
 I CLINIEN="" S RETSTA("CKIN")="-1^Invalid clinic name (#44)." QUIT
 ;
 ; -- Check appointment date/time --
 S APPTDT=$$HL7TFM^XLFDT(DHPAPTDT)
 I $P(APPTDT,".",2)="" S RETSTA("CKIN")="-1^Missing time for appt." QUIT
 ;convert to external and check date/time against Fileman date/time field
 S Y=APPTDT
 D DD^%DT
 S EXDATE=Y ;Convert to external
 D CHK^DIE(2.98,.001,"",EXDATE,.RESULT,.MSG)
 I RESULT="^" S RETSTA("CKIN")="-1^Invalid appt date/time." QUIT
 ;
 ; -- Check check-in date/time --
 N RESULT,MSG
 S BADDATE=0
 I $G(DHPCIDT)="" D
 . S CHKINDT=APPTDT
 E  D
 . S CHKINDT=$$HL7TFM^XLFDT(DHPCIDT)
 . I $P(CHKINDT,".",2)="" S RETSTA("CKIN")="-1^Missing time for check-in.",BADDATE=1 QUIT
 . ;convert to external and check date/time against Fileman date/time field
 . S Y=CHKINDT
 . D DD^%DT
 . S EXDATE=Y
 . D CHK^DIE(2.98,.001,"",EXDATE,.RESULT,.MSG)
 . I RESULT="^" S RETSTA("CKIN")="-1^Invalid check-in date/time.",BADDATE=1 QUIT
 QUIT:BADDATE
 ;
 ;check that there are both patient and clinic appointment records
 I '$D(^DPT(PATDFN,"S",APPTDT,0)) D  QUIT
 . S RETSTA("CKIN")="-1^Patient Appointment record was not found"
 ;
 S HIT=0
 S CLAPTIEN=0
 F  S CLAPTIEN=$O(^SC(CLINIEN,"S",APPTDT,1,CLAPTIEN)) QUIT:CLAPTIEN=""  D  QUIT:HIT
 . S:$P(^SC(CLINIEN,"S",APPTDT,1,CLAPTIEN,0),U,1)=PATDFN HIT=1
 I 'HIT D  QUIT
 . S RETSTA("CKIN")="-1^Clinic Appointment record was not found"
 ;
 I $G(DEBUG)=1 D
 . W "Appointment Check-in  APPTCKIN^SYNDHP62",!
 . W "ICN:             ",DHPPAT,"   DFN: ",PATDFN,!
 . W "CLINIC:          ",DHPCLIN,"   IEN: ",CLINIEN,!
 . W "CLINIC,APPT,IEN: ",CLAPTIEN,!
 . W "APPT D/T:        ",DHPAPTDT,"   ",APPTDT,!
 . W "CHK-IN D/T:      ",DHPCIDT,"   ",CHKINDT,!
 ;
 ; -- appointment check-in updates --
 ;
 ; clinic appointment record
 ;  30 - eligibility of visit 0;10
 ;      10 = NSC
 ;      11 = NSC, VA PENSION
 ;      15 = SC LESS THAN 50%
 ;      16 = SERVICE CONNECTED 50% to 100%
 ;  309 - checked-in (date) C;1
 ;  302 - check in user C;2 P200
 ;  305 - check in entered (date) C;5
 ;
 S ELIGCODE=$$GET1^DIQ(2,DHPPAT_",",.361,"I")
 S:ELIGCODE="" ELIGCODE=10
 N IENS,FDA,ERRMSG
 S IENS=CLAPTIEN_","_APPTDT_","_CLINIEN_","
 S FDA(44.003,IENS,30)=ELIGCODE ;eligibility of visit
 S FDA(44.003,IENS,309)=CHKINDT ;checked-in (date)
 S FDA(44.003,IENS,302)=DUZ ;check in user
 S FDA(44.003,IENS,305)=CHKINDT ;check in entered (date)
 D FILE^DIE("K","FDA","ERRMSG")
 I $D(ERRMSG) D  QUIT
 . S RETSTA("CKIN")="-1^Problem updating clinic appointment check-in info (#44.003) - "_$G(ERRMSG("DIERR",1,"TEXT",1))
 ;
 S RETSTA("CKIN")=1
 ;
 QUIT
 ;
 ; -------- Appointment check-out
 ;
APTCKOUT(RETSTA,DHPPAT,DHPCLIN,DHPAPTDT,DHPCODT) ;Check-out appointment
 ;>>>>>> This API currently will ONLY work for synthetic data ingest <<<<<<<
 ;>>>>>>  where Outpatient Encounters and Visits are created first   <<<<<<<
 ; Input:
 ;   DHPPAT   - Patient ICN (required)
 ;   DHPCLIN  - Clinic Name (required)
 ;   DHPAPTDT - Appointment Date & Time (required) all dates received in HL7 format
 ;   DHPCODT  - Check-out Date & Time (optional, will default to check-in date/time + 30 minutes)
 ;
 ; Output:   RETSTA("CKOUT")
 ;  1 - success
 ; -1 - failure -1^message
 ;
 N Y,PATDFN,APPTDT,CHKINDT,CHKOUTDT,CLINIEN,EXDATE,BADDATE,RESULT,MSG,HIT,CLAPTIEN,IENS
 ;
 I $G(DHPPAT)="" S RETSTA("CKOUT")="-1^Missing patient identifier (#2)." QUIT
 I $G(DHPCLIN)="" S RETSTA("CKOUT")="-1^Missing appt. location (#44)." QUIT
 I $G(DHPAPTDT)="" S RETSTA("CKOUT")="-1^Missing date/time for appt." QUIT
 ;
 I '$D(^DPT("AFICN",DHPPAT)) S RETSTA("CKOUT")="-1^Patient not recognised" QUIT
 S PATDFN=$O(^DPT("AFICN",DHPPAT,""))
 ;
 ; -- Check Clinic --
 S CLINIEN=$O(^SC("B",DHPCLIN,""))
 I CLINIEN="" S RETSTA("CKOUT")="-1^Invalid clinic name (#44)." QUIT
 ;
 ; -- Check appointment date/time --
 S APPTDT=$$HL7TFM^XLFDT(DHPAPTDT)
 I $P(APPTDT,".",2)="" S RETSTA("CKOUT")="-1^Missing time for appt." QUIT
 ;convert to external and check date/time against Fileman date/time field
 S Y=APPTDT
 D DD^%DT
 S EXDATE=Y ;Convert to external
 D CHK^DIE(2.98,.001,"",EXDATE,.RESULT,.MSG)
 I RESULT="^" S RETSTA("CKOUT")="-1^Invalid appt date/time." QUIT
 ;
 ;check that there are both patient and clinic appointment records
 I '$D(^DPT(PATDFN,"S",APPTDT,0)) D  QUIT
 . S RETSTA("CKOUT")="-1^Patient Appointment record was not found"
 ;
 S HIT=0
 S CLAPTIEN=0
 F  S CLAPTIEN=$O(^SC(CLINIEN,"S",APPTDT,1,CLAPTIEN)) QUIT:CLAPTIEN=""  D  QUIT:HIT
 . S:$P(^SC(CLINIEN,"S",APPTDT,1,CLAPTIEN,0),U,1)=PATDFN HIT=1
 I 'HIT D  QUIT
 . S RETSTA("CKOUT")="-1^Clinic Appointment record was not found"
 ;
 ; -- Get check-in date/time --
 S IENS=CLAPTIEN_","_APPTDT_","_CLINIEN_","
 S CHKINDT=$$GET1^DIQ(44.003,IENS,309,"I")
 I CHKINDT="" D  QUIT
 . S RETSTA("CKOUT")="-1^Appointment has not been checked-in"
 ;
 ; -- Check check-out date/time --
 N RESULT,MSG
 S BADDATE=0
 I $G(DHPCODT)="" D
 . S CHKOUTDT=$$FMADD^XLFDT(CHKINDT,0,0,30)
 E  D
 . S CHKOUTDT=$$HL7TFM^XLFDT(DHPCODT)
 . I $P(CHKOUTDT,".",2)="" S RETSTA("CKOUT")="-1^Missing time for check-out.",BADDATE=1 QUIT
 . ;convert to external and check date/time against Fileman date/time field
 . S Y=CHKOUTDT
 . D DD^%DT
 . S EXDATE=Y
 . D CHK^DIE(2.98,.001,"",EXDATE,.RESULT,.MSG)
 . I RESULT="^" S RETSTA("CKOUT")="-1^Invalid check-out date/time.",BADDATE=1 QUIT
 QUIT:BADDATE
 I CHKOUTDT'>CHKINDT S RETSTA("CKOUT")="-1^Check-out date/time must greater than check-in date." QUIT
 ;
 ;check requirements for completing check-out of appointment
 N COERRMSG,IDX
 S COERRMSG=1
 D CHECKCO(.COERRMSG,PATDFN,APPTDT)
 I COERRMSG=-1 D  QUIT
 . S RETSTA("CKOUT")=-1
 . S IDX=""
 . F  S IDX=$O(COERRMSG(IDX)) QUIT:IDX=""  D
 . . S RETSTA("CKOUT")=RETSTA("CKOUT")_"^"_COERRMSG(IDX)
 ;
 I $G(DEBUG)=1 D
 . W "Appointment Check-in  APTCKOUT^SYNDHP62",!
 . W "ICN:             ",DHPPAT,"   DFN: ",PATDFN,!
 . W "CLINIC:          ",DHPCLIN,"   IEN: ",CLINIEN,!
 . W "CLINIC,APPT,IEN: ",CLAPTIEN,!
 . W "APPT D/T:        ",DHPAPTDT,"   ",APPTDT,!
 . W "CHK-IN D/T:      ",CHKINDT,!
 . W "CHK-OUT D/T:     ",DHPCODT,"   ",CHKOUTDT,!
 ;
 ; -- appointment check-out updates --
 ;
 ; patient appointment record
 ;  update appt record with outpatient encounter ien
 ;    21 - outpatient encounter 0;20 P409.68
 ;
 ;get the outpatient encounter IEN for the appt. encounter record, not the stop code record
 N SCEIEN
 S SCEIEN=$O(^SCE("ADFN",PATDFN,APPTDT,""))
 I SCEIEN="" D  QUIT
 . S RETSTA("CKOUT")="-1^Could not find the outpatient encounter record."
 ;
 ; patient appointment record
 ;  update appt record with outpatient encounter ien
 ;    21 - outpatient encounter 0;20 P409.68
 ;
 N IENS,FDA,ERRMSG
 S IENS=APPTDT_","_PATDFN_","
 S FDA(2.98,IENS,21)=SCEIEN ;outpatient encounter
 D FILE^DIE("K","FDA","ERRMSG")
 I $D(ERRMSG) D  QUIT
 . S RETSTA("CKOUT")="-1^Problem updating patient appointment Outpat Enc pointer (#2.98) - "_$G(ERRMSG("DIERR",1,"TEXT",1))
 ;
 ; clinic appointment record
 ;  303 - checked out (date) C;3
 ;  304 - check out user C;4 P200
 ;  306 - check out entered (date) C;6
 ;
 N IENS,FDA,ERRMSG
 S IENS=CLAPTIEN_","_APPTDT_","_CLINIEN_","
 S FDA(44.003,IENS,303)=CHKOUTDT ;checked out (date)
 S FDA(44.003,IENS,304)=DUZ ;check out user
 S FDA(44.003,IENS,306)=CHKOUTDT ;check out entered (date)
 D FILE^DIE("K","FDA","ERRMSG")
 I $D(ERRMSG) D  QUIT
 . S RETSTA("CKOUT")="-1^Problem updating clinic appointment check-out info (#44.003) - "_$G(ERRMSG("DIERR",1,"TEXT",1))
 ;
 ; outpatient encounter records
 ;
 N IENS,FDA,ERRMSG
 S IENS=SCEIEN_","
 S FDA(409.68,IENS,.07)=CHKOUTDT ;check out process completion
 S FDA(409.68,IENS,.1)=11 ;appointment type
 S FDA(409.68,IENS,.12)=2 ;status
 D FILE^DIE("K","FDA","ERRMSG")
 I $D(ERRMSG) D  QUIT
 . S RETSTA("CKOUT")="-1^Problem updating outpatient encounter (#409.68) - "_$G(ERRMSG("DIERR",1,"TEXT",1))
 ;
 N IENS,FDA,ERRMSG
 S IENS=$O(^SCE("APAR",SCEIEN,""))_","
 S FDA(409.68,IENS,.1)=11 ;appointment type
 D FILE^DIE("K","FDA","ERRMSG")
 I $D(ERRMSG) D  QUIT
 . S RETSTA("CKOUT")="-1^Problem updating outpatient encounter (#409.68) - "_$G(ERRMSG("DIERR",1,"TEXT",1))
 ;
 ; visit records - no update required
 ;
 S RETSTA("CKOUT")=1
 ;
 QUIT
 ;
CHECKCO(COERRMSG,PATDFN,APPTDT) ;
 ;
 N ECNT,SCEIENP,SCEIENS,INVDATE,VIENP,VIENS,VPROV,VPOV,VCPT
 S ECNT=0
 ;
 S SCEIENP=$O(^SCE("ADFN",PATDFN,APPTDT,""))
 I SCEIENP="" D
 . S ECNT=ECNT+1
 . S COERRMSG=-1
 . S COERRMSG(ECNT)="No Outpatient Encounter record"
 ;
 I SCEIENP'="" D
 . S SCEIENS=$O(^SCE("APAR",SCEIENP,""))
 . I SCEIENS="" D
 . . S ECNT=ECNT+1
 . . S COERRMSG=-1
 . . S COERRMSG(ECNT)="No Outpatient Encounter stop code record"
 ;
 S INVDATE=9999999-$P(+APPTDT,".",1)_$S($P(+APPTDT,".",2)'="":"."_$P(+APPTDT,".",2),1:"")
 S VIENP=$O(^AUPNVSIT("AA",PATDFN,INVDATE,""))
 I VIENP="" D
 . S ECNT=ECNT+1
 . S COERRMSG=-1
 . S COERRMSG(ECNT)="No Visit record"
 ;
 I VIENP'="" D
 . S VIENS=$O(^AUPNVSIT("AD",VIENP,""))
 . I VIENS="" D
 . . S ECNT=ECNT+1
 . . S COERRMSG=-1
 . . S COERRMSG(ECNT)="No Visit stop code record"
 . ;
 . S VPROV=$O(^AUPNVPRV("AD",VIENP,""))
 . I VPROV="" D
 . . S ECNT=ECNT+1
 . . S COERRMSG=-1
 . . S COERRMSG(ECNT)="No V Provider record for Visit"
 . ;
 . S VPOV=$O(^AUPNVPOV("AD",VIENP,""))
 . I VPOV="" D
 . . S ECNT=ECNT+1
 . . S COERRMSG=-1
 . . S COERRMSG(ECNT)="No V POV record for Visit"
 . ;
 . S VCPT=$O(^AUPNVCPT("AD",VIENP,""))
 . I VCPT="" D
 . . S ECNT=ECNT+1
 . . S COERRMSG=-1
 . . S COERRMSG(ECNT)="No V CPT record for Visit"
 . ;
 QUIT
 ;
TEST ;
T1 S ERRDISP=1
 D PRBUPDT(.ZXC,"5482156687V807096",2,9990006675,,"A","5OO_EXT",267036007)
 Q
 ;"PAT":"5482156687V807096","VST":"17004","ROV":"9990006675","ONS":"20130117","ABT":"20131021","CLNST":"I","SCT":"267036007"
T2 S ERRDISP=1
 D PRBUPDT(.ZXC,"11004V412157",17003,9990006675,20160117,20161021,"I",1657008)
 Q
T3 ;
 S ERRDISP=1
 D PRBUPDT(.ZXC,"11004V412157",,9990006675,20160117,20161021,"I",1657008)
 Q
T4 ; ICD9 code that was valid at 20130117
 S ERRDISP=1
 D PRBUPDT(.ZXC,"11004V412157",17003,9990006675,20130117,20161021,"I",2251002)
