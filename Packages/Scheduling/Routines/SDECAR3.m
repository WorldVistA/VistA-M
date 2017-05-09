SDECAR3 ;ALB/SAT/JSM - VISTA SCHEDULING RPCS ;MAR 15, 2017
 ;;5.3;Scheduling;**658**;Aug 13, 1993;Build 23
 ;
 Q
 ;
 ;SDECAR3 AREDIT
AREDIT(RET,TYP,IEN,ATYPE,REQBY,PROV,COMMENT,FAST,LOA,SDCL,SDSTOP) ;Appointment Request Set
 ; TYP     - (required) Request type to edit
 ;                      ;  A = APPT     (SDEC APPT REQUEST)
 ;                      ;  E = EWL      (SD WAIT LIST)
 ;                      ;  R = RECALL   (RECALL REMINDERS)
 ; IEN     - (required) id pointer to:
 ;                      ; A = SDEC APPT REQUEST file (#409.85)
 ;                      ; E = SD WAIT LIST file (#409.3)
 ;                      ; R = RECALL REMINDERS file (#403.5)
 ; ATYPE   - (optional) Appointment Type ID pointer to APPOINTMENT TYPE file 409.1 for APPT and EWL types,
 ;                      ID pointer to Recall Reminders Appt Type file 403.51 for RECALL type
 ; REQBY   - (optional) Requested by: 1 = Provider, 2 = Patient
 ; PROV    - (optional) Provider ID pointer to NEW PERSON file (#200) for APPT and EWL types,
 ;                      ID pointer to RECALL REMINDERS PROVIDERS file (#403.54) for RECALL REMINDER type
 ; COMMENT - (optional) comment must be 1-60 characters
 ; FAST    - (optional) Fasting: f = Fasting, n = Non-fasting
 ; LOA     - (optional) Length of Appt. must be a number between 10 and 120, 0 decimal digits
 ; SDCL    - (optional) Clinic code - Pointer to HOSPITAL LOCATION file
 ; SDSTOP  - (optional) CLINIC STOP or Service/Specialty name - NAME from the SD WL SERVICE/SPECIALTY file - looks for 1st active
 ;                       OR - Pointer to the CLINIC STOP file
 ;RETURN:
 ;  CODE ^ MESSAGE
 ;   CODE =  IEN of updated record or -1 if error
 ;
 N ERRFLG,FIELDS,SDDFN,SDNE
 S ERRFLG=0,SDNE=""
 S RET=$NA(^TMP("SDECAR3",$J,"AREDIT"))
 K @RET
 S @RET@(0)="I00020CODE^T00030MESSAGE"_$C(30)
 ;validate TYP
 S TYP=$G(TYP)
 I "AER"'[TYP S @RET@(1)="-1^Invalid Request Type "_TYP_"."_$C(30,31) Q
 ;validate FAST
 S FAST=$G(FAST)
 I FAST'="","fnFN"'[FAST S @RET@(1)="-1^Invalid Fasting Code "_FAST_"."_$C(30,31) Q
 ;validate LOA is a number between 10 and 120
 S LOA=$G(LOA)
 I +LOA,(LOA>120)!(LOA<10) S @RET@(1)="-1^Invalid Length of Appt. Number should be between 10 and 120 - "_LOA_"."_$C(30,31) Q
 ;Validate Clinic Code
 S SDCL=$G(SDCL)
 I SDCL'="",'$D(^SC(SDCL,0)) S @RET@(1)="-1^Invalid Clinic ID "_SDCL_"."_$C(30,31) Q
 ;Validate Service/Specialty
 S SDSTOP=$G(SDSTOP)
 I +SDSTOP,'$D(^DIC(40.7,SDSTOP,0)) S @RET@(1)="-1^Invalid Clinic ID "_SDCL_"."_$C(30,31) Q
 S ATYPE=$G(ATYPE)
 ;If REQBY is Patient (2), then clear PROV
 S REQBY=$G(REQBY) I REQBY=2 S PROV=""
 ;validate COMMENT does not contain '^'
 S COMMENT=$TR($G(COMMENT),"^"," ")
 ;validate IEN
 S IEN=$G(IEN)
 I IEN="" S @RET@(1)="-1^Request Type ien is required."_$C(30,31) Q
 D APPT:(TYP="A"),EWL:(TYP="E"),RECALL:(TYP="R")
 ;
 ; EXIT
 I ERRFLG=0 S @RET@(1)=IEN_"^SUCCESS"_$C(30,31)
 K ERRFLG,SDDFN,SDNE
 Q
 ;
 ;type A. If IEN is valid in SDEC APPT REQUEST file (#409.85) and data has changed,
 ; then save the edits
APPT  ;
 ;Validate IEN exists
 I '$D(^SDEC(409.85,IEN,0)) S @RET@(1)="-1^Invalid APPT id "_IEN_"."_$C(30,31),ERRFLG=1 Q
 ;Validate Provider IEN exists
 I REQBY=1,'$D(^VA(200,PROV,0)) S @RET@(1)="-1^Invalid PROV id for APPT REQ "_PROV_"."_$C(30,31),ERRFLG=1 Q
 ;check for edits/changes to REQ APPT TYPE, REQUEST BY, PROVIDER, and COMMENTS
 K ARDATA,ARERR
 S FIELDS=".01;.02;8;8.5;8.7;11;12;25"
 D GETS^DIQ(409.85,IEN,FIELDS,"IE","ARDATA","ARERR")
 I $D(ARERR) M ARMSG=ARERR K FDA Q
 S FDA=$NA(FDA(409.85,IEN))
 K @FDA,ARMSG
 ;setup SDDFN
 S SDDFN=ARDATA(409.85,IEN_",",.01,"I")
 ;If clinic or service/specialty changed, determine if patient is new or established
 I +SDCL,SDCL'=ARDATA(409.85,IEN_",",8,"I") D PCSTGET^SDEC50(.SDRET,SDDFN,SDCL) S @FDA@(8)=SDCL
 I +SDSTOP,SDSTOP'=ARDATA(409.85,IEN_",",8.5,"I") D PCST2GET^SDEC50(.SDRET,SDDFN,SDSTOP) S @FDA@(8.5)=SDSTOP
 I $D(SDRET) S SDNE=$P($P(SDRET(1),U,2),$C(30,31),1),SDNE=$S(SDNE="YES":"N",1:"E")
 K SDRET
 ;setup FDA for the updated inputs
 I ATYPE'=ARDATA(409.85,IEN_",",12,"I") S @FDA@(12)=ATYPE
 I REQBY'=ARDATA(409.85,IEN_",",11,"I") S @FDA@(11)=REQBY
 I PROV'=ARDATA(409.85,IEN_",",8.7,"I") S @FDA@(8.7)=PROV
 I COMMENT'=ARDATA(409.85,IEN_",",25,"I") S @FDA@(25)=COMMENT
 I SDNE'=ARDATA(409.85,IEN_",",.02,"I") S @FDA@(.02)=SDNE
 ;update the SDEC APPT REQUEST file (#409.85)
 D:$D(@FDA) UPDATE^DIE("","FDA",,"ARMSG")
 I $D(ARMSG) S @RET@(1)="-1^Unable to store the changed data"_$C(30,31),ERRFLG=1 Q
 Q
 ;
 ;
 ;type E. If IEN is valid in SD WAIT LIST file (#409.3) and data has changed,
 ; then save edits
EWL  ;
 ; Validate IEN exists
 I '$D(^SDWL(409.3,IEN,0)) S @RET@(1)="-1^Invalid Wait List id "_IEN_"."_$C(30,31),ERRFLG=1 Q
 ;Validate Provider IEN exists
 I REQBY=1,'$D(^VA(200,PROV,0)) S @RET@(1)="-1^Invalid PROV id for EWL "_PROV_"."_$C(30,31),ERRFLG=1 Q
 ;check for edits/changes to REQ APPT TYPE, REQUEST BY, PROVIDER, and COMMENTS
 K ARDATA,ARERR
 S FIELDS="8.7;11;12;25"
 D GETS^DIQ(409.3,IEN,FIELDS,"IE","ARDATA","ARERR")
 I $D(ARERR) M ARMSG=ARERR K FDA Q
 S FDA=$NA(FDA(409.3,IEN))
 K @FDA,ARMSG
 ;setup FDA for the updated inputs
 I ATYPE'=ARDATA(409.3,IEN_",",12,"I") S @FDA@(12)=ATYPE
 I REQBY'=ARDATA(409.3,IEN_",",11,"I") S @FDA@(11)=REQBY
 I PROV'=ARDATA(409.3,IEN_",",8.7,"I") S @FDA@(8.7)=PROV
 I COMMENT'=ARDATA(409.3,IEN_",",25,"I") S @FDA@(25)=COMMENT
 ;update the SD WAIT LIST file (#409.3)
 D:$D(@FDA) UPDATE^DIE("","FDA",,"ARMSG")
 I $D(ARMSG) S @RET@(1)="-1^Unable to store the changed data"_$C(30,31),ERRFLG=1 Q
 Q
 ;
 ;type R. If IEN is valid in RECALL REMINDERS file (#403.5) and data has changed,
 ; then save edits
RECALL  ;
 ; Validate IEN exists
 I '$D(^SD(403.5,IEN,0)) S @RET@(1)="-1^Invalid Recall id "_IEN_"."_$C(30,31),ERRFLG=1 Q
 ;Validate Provider IEN exists
 I REQBY=1,'$D(^SD(403.54,PROV,0)) S @RET@(1)="-1^Invalid PROV id for RECALL REMINDERS PROVIDER "_PROV_"."_$C(30,31),ERRFLG=1 Q
 ;Ensure FAST is lowercase
 S FAST=$$LOW^XLFSTR(FAST)
 ;check for edits/changes to PROVIDER and COMMENTS
 K ARDATA,ARERR
 S FIELDS="2.5;2.6;4.5;4.7;3;4"
 D GETS^DIQ(403.5,IEN,FIELDS,"IE","ARDATA","ARERR")
 I $D(ARERR) M ARMSG=ARERR K FDA Q
 S FDA=$NA(FDA(403.5,IEN))
 K @FDA,ARMSG
 ;setup FDA for the updated inputs
 I ATYPE'=ARDATA(403.5,IEN_",",3,"I") S @FDA@(3)=ATYPE
 I PROV'=ARDATA(403.5,IEN_",",4,"I") S @FDA@(4)=PROV
 I FAST'=ARDATA(403.5,IEN_",",2.6,"I") S @FDA@(2.6)=FAST
 I COMMENT'=ARDATA(403.5,IEN_",",2.5,"I") S @FDA@(2.5)=COMMENT
 I SDCL'=ARDATA(403.5,IEN_",",4.5,"I") S @FDA@(4.5)=SDCL
 I LOA'=ARDATA(403.5,IEN_",",4.7,"I") S @FDA@(4.7)=LOA
 ;update the RECALL REMINDERS file (#403.5)
 D:$D(@FDA) UPDATE^DIE("","FDA",,"ARMSG")
 I $D(ARMSG) S @RET@(1)="-1^Unable to store the changed data"_$C(30,31),ERRFLG=1 Q
 Q
