SDECUTL ;ALB/SAT - VISTA SCHEDULING RPCS ;MAR 15, 2017
 ;;5.3;Scheduling;**627,658**;Aug 13, 1993;Build 23
 ;
 ;Reference is made to ICR #4837
 Q
 ;
SYSSTAT(SDECY)   ; SYSTEM STATUS
 ;SYSSTAT(SDECY)  external parameter tag in SDEC
 N SDECCNT,SDECD,SDECH,SDECII,SDECROW,SDECROW1,SDECYA
 S SDECII=0
 S SDECY=$NA(^TMP("SDEC",$J)) K @SDECY
 ;S SDECYA=$NA(^SDECTMPA($J)) K @SDECYA
 S @SDECY@(SDECII)="T00080ERROR_ID^T00080ERROR_TEXT"_$C(30)
 S SDECII=SDECII+1 S @SDECY@(SDECII)=$C(30,31)
 Q
 ;
STRIP(SDECSTR) ;
 ; SDECSTR = input string to parse
 N SDECDN,SDECI,SDECPC,SDECPCNT,SDECPDN,SDECRET
 Q:$E(SDECSTR,1,8)="        " ""
 S SDECI=""
 S SDECRET=""
 S SDECPCNT=""
 S SDECDN=""
 F  Q:SDECDN  D
 . S SDECI=SDECI+1
 . Q:$E(SDECSTR,SDECI)=" "
 . S SDECPCNT=SDECPCNT+1
 . S SDECPC=""
 . S SDECPDN=""
 . F  Q:SDECPDN  D
 . . S SDECPC=SDECPC_$E(SDECSTR,SDECI)
 . . S SDECI=SDECI+1
 . . I ($E(SDECSTR,SDECI)=" ")!(SDECI>$L(SDECSTR)) S SDECPDN=1
 . ;
 . S SDECRET=$S(SDECPCNT'=1:SDECRET_U,1:"")_$S(SDECPCNT=4:$E(SDECPC,1,8),1:SDECPC)
 . I (SDECPCNT=4)!(SDECI>$L(SDECSTR)) S SDECDN=1
 ;
 Q SDECRET
 ;
FL(SDECSTR,SDECW,SDECD) ;EP
 ;format line
 ; SDECSTR = Text String to be formatted
 ; SDECW   = Maximum width of text line
 ; SDECD   = Delimiter; defaults to double pipe "||" to be used as the line separator
 ;
 ;RETURNS string delimited by double pipe "||" to be used as line separator
 N SDECOUT,SDECPTR,SDECTMP
 I $G(SDECW)="" S SDECW=80
 I '+SDECW S SDECW=80
 I $L(SDECSTR)<=SDECW Q SDECSTR
 I $G(SDECD)="" S SDECD="||"
 S SDECOUT=""
 S SDECPTR=SDECW
 ;handle no spaces in the string
 I SDECSTR'[" " D
 . F  Q:SDECSTR=""  D
 . . I $L(SDECSTR)<=SDECW D
 . . . S SDECOUT=$S(SDECOUT'="":SDECOUT_SDECD,1:"")_SDECSTR
 . . . S SDECSTR=""
 . . I $L(SDECSTR)>SDECW D
 . . . S SDECOUT=$S(SDECOUT'="":SDECOUT_SDECD,1:"")_$E(SDECSTR,1,SDECW)
 . . . S SDECSTR=$E(SDECSTR,SDECW+1,$L(SDECSTR))
 ;string does contain a space
 I SDECSTR[" " D
 . F  Q:SDECSTR=""  D
 . . I $L(SDECSTR)<=SDECW D
 . . . S SDECOUT=$S(SDECOUT'="":SDECOUT_SDECD,1:"")_SDECSTR
 . . . S SDECSTR=""
 . . I $L(SDECSTR)>SDECW D
 . . . F  Q:$E(SDECSTR,SDECPTR)=" "  D
 . . . . S SDECPTR=SDECPTR-1
 . . . S SDECOUT=$S(SDECOUT'="":SDECOUT_SDECD,1:"")_$E(SDECSTR,1,SDECPTR-1)
 . . . S SDECSTR=$E(SDECSTR,SDECPTR+1,$L(SDECSTR))
 . . . S SDECPTR=SDECW
 Q SDECOUT
 ;
 ; Check and validate visit
CHKVISIT(VIEN,DFN,CAT) ;EP
 N RET,X0
 S RET=$$ISLOCKED(VIEN)
 Q:RET $S(RET<0:$$ERR^SDEC44("Visit "_VIEN_" not found."),1:$$ERR^SDEC44("Visit "_VIEN_" is locked."))
 S X0=$G(^AUPNVSIT(VIEN,0))
 I $G(DFN),$P(X0,U,5)'=DFN S RET=$$ERR^SDEC44("Visit "_VIEN_" does not belong to Patient "_DFN_".")
 E  I $P(X0,U,11) S RET=$$ERR^SDEC44("Visit "_VIEN_" has been deleted.")
 E  I $L($G(CAT)),CAT'[$P(X0,U,7) S RET=$$ERR^SDEC44("Service Category of Visit "_VIEN_" is not "_CAT_".",$$EXTERNAL^DILFD(9000010,.07,,$P(X0,U,7)))
 Q RET
 ;
 ; Returns visit lock status:
 ;  -1:  Visit not found
 ;   0:  Visit is not locked
 ;   1:  Visit is locked
ISLOCKED(IEN) ;PEP - Is visit locked?
 N DAT,DAYS,EXPDT
 S DAT=$$VISREFDT(IEN)
 Q:'DAT -1
 ;IHS/MSC/PLS - 02/18/09 - Parameter now holds lock expiration date
 ;S EXPDT=$$GET^XPAR("USR","BEHOENCX VISIT LOCK OVERRIDE","`"_IEN)
 ;Q:EXPDT'<$$DT^XLFDT() 0
 ;D:EXPDT DEL^XPAR("USR","BEHOENCX VISIT LOCK OVERRIDE","`"_IEN)  ; remove expired locked
 ;Q:$$GET^XPAR("USR","BEHOENCX VISIT LOCK OVERRIDE","`"_IEN) 0
 ;S DAYS=$$GET^XPAR("ALL","BEHOENCX VISIT LOCKED")
 Q $$FMDIFF^XLFDT(DT,DAT)>1   ;$S(DAYS<1:1,1:DAYS)
 ; Returns reference date for visit lock check
VISREFDT(IEN) ;
 N ADM,DIS,DAT
 S DAT=$P($G(^AUPNVSIT(+IEN,0)),U,2)
 Q:'DAT ""
 S ADM=$O(^DGPM("AVISIT",IEN,0))
 Q:'ADM DAT
 S DIS=$P($G(^DGPM(ADM,0)),U,17)
 Q $S(DIS:$P($G(^DGPM(DIS,0)),U),1:DT)
 ;
 ; Add/edit a file entry
UPDATE(FDA,FLG,IEN) ;EP
 N ERR,DFN,X
 I $G(FLG)["@" S FLG=$TR(FLG,"@")
 E  D
 .S X="FDA"
 .F  S X=$Q(@X) Q:'$L(X)  K:'$L(@X) @X
 Q:$D(FDA)'>1 ""
 D UPDATE^DIE(.FLG,"FDA","IEN","ERR")
 K FDA
 Q $S($G(ERR("DIERR",1)):-ERR("DIERR",1)_U_ERR("DIERR",1,"TEXT",1),1:"")
 ;
ISACTIVE(ADT,IDT,CDT)  ;is CDT an active date given an active date and inactive date
 ;INPUT:
 ; ADT = Activation date in FM format
 ; IDT = Inactivation date in FM format
 ; CDT = date to check - default to 'today'
 ;RETURN:
 ; 0=inactive
 ; 1=active
 ; 2=ADT & IDT null; calling routine can decide if default to active or inactive
 ; 3=date to check is before both activation and inactivation; calling routine can decide if default to active or inactive
 N RET
 S RET=""
 S ADT=$S($P($G(ADT),".",1)?7N:$P(ADT,".",1),1:"")
 S IDT=$S($P($G(IDT),".",1)?7N:$P(IDT,".",1),1:"")
 S CDT=$S($P($G(CDT),".",1)?7N:$P(CDT,".",1),1:$P($$NOW^XLFDT,".",1))
 ;0 0
 I ADT="",IDT="" S RET=2
 Q:RET'="" RET
 ;1 0
 I ADT'="",IDT="" D
 .S RET=1   ;TODO: what if 'today' or CDT is before ADT
 Q:RET'="" RET
 ;0 1
 I ADT="",IDT'="" S RET=0   ;TODO: what if 'today' or CDT is before IDT
 Q:RET'="" RET
 ;1 1
 ; active < T < inactive
 I CDT>=ADT,CDT<=IDT S RET=1
 Q:RET'="" RET
 ; active < inactive < T
 I ADT<IDT,IDT<CDT S RET=0
 Q:RET'="" RET
 ; inactive < T < active
 I IDT<CDT,CDT<ADT S RET=0
 Q:RET'="" RET
 ; inactive < active < T
 I IDT<ADT,ADT<CDT S RET=1
 Q:RET'="" RET
 ;T < active < inactive AND T < inactive < active
 I RET="" S RET=3  ;should not get here
 Q RET
 ;
APPTGET(DFN,SDBEG,SDCL,SDRES) ;get SDEC APPOINTMENT for given patient, time, and clinic
 N SDAPPT,SDI,SDNOD,SDRCL,SDARES
 S SDAPPT=""
 S SDCL=$G(SDCL)
 S SDRES=$G(SDRES)
 S SDI=0 F  S SDI=$O(^SDEC(409.84,"CPAT",DFN,SDI)) Q:SDI'>0  D  Q:SDAPPT'=""
 .S SDNOD=$G(^SDEC(409.84,SDI,0))
 .Q:SDBEG'=$P(SDNOD,U,1)
 .I +SDRES Q:+SDRES'=$P(SDNOD,U,7)
 .I 'SDRES S SDARES=$P(SDNOD,U,7) S SDRCL=$P($G(^SDEC(409.831,+SDARES,0)),U,4) Q:SDRCL'=SDCL
 .S SDAPPT=SDI
 Q SDAPPT
 ;
GETRES(SDCL,INACT)  ;get resource for clinic - SDEC RESOURCE
 N SDHLN,SDI,SDNOD,SDRES,SDRES1
 S (SDRES,SDRES1)=""
 S SDHLN=$P($G(^SC(SDCL,0)),U,1)
 Q:SDHLN="" ""
 S SDI="" F  S SDI=$O(^SDEC(409.831,"ALOC",SDCL,SDI)) Q:SDI=""  D  Q:SDRES'=""
 .S SDNOD=$G(^SDEC(409.831,SDI,0))
 .I '$G(INACT) Q:$$GET1^DIQ(409.831,SDI_",",.02)="YES"
 .S:SDRES1="" SDRES1=SDI
 .Q:$P($P(SDNOD,U,11),";",2)'="SC("
 .S SDRES=SDI
 .;I $$UP^XLFSTR($P(SDNOD,U,1))=SDHLN S SDRES=SDI
 I SDRES="",SDRES1'="" S SDRES=SDRES1
 Q SDRES
 ;
RECALL(DFN,SDT,SDCL)  ;is this appointment for RECALL
 ;INPUT:
 ; DFN  = Patient ID pointer to PATIENT file 2
 ; SDT  = Appointment date/time in fm format
 N SDI,SDNOD1,SDRET
 S SDRET=""
 S SDI=0 F  S SDI=$O(^SD(403.56,"B",DFN,SDI)) Q:SDI'>0  D  Q:SDRET'=""
 .S SDNOD1=$G(^SD(403.56,SDI,1))
 .Q:$P(SDNOD1,U,1)'=SDT
 .Q:$P(SDNOD1,U,2)'=SDCL
 .S SDRET=SDI
 Q SDRET
 ;
SDCL(SDAPID)  ;get clinic for given SDEC APPOINTMENT id
 ;INPUT:
 ; SDAPID - appt ID pointer to SDEC APPOINTMENT file 409.84
 ;RETURN:
 ; Clinic ID pointer to HOSPITAL LOCATION file 44
 N SDAPTYP,SDCL
 S SDCL=""
 S SDAPTYP=$$GET1^DIQ(409.84,SDAPID_",",.22,"I")
 S:$P(SDAPTYP,"|",2)="SDWL(409.3," SDCL=$$GET1^DIQ(409.3,$P(SDAPTYP,"|",2)_",",13.2,"I")
 S:$P(SDAPTYP,"|",1)="SD(403.5," SDCL=$$GET1^DIQ(403.5,$P(SDAPTYP,"|",2)_",",4.5,"I")
 S:$P(SDAPTYP,"|",1)="GMR(123," SDCL=$$GET1^DIQ(123,$P(SDAPTYP,"|",2)_",",.04,"I")    ;ICR 4837
 Q SDCL
 ;
PTSEC(DFN)  ;patient sensitive & record access checks; calls DG SENSITIVE RECORD ACCESS api
 ;INPUT:
 ; DFN - patient ID pointer to PATIENT file 2
 ;RETURN:
 ; RESULT - the following pipe pieces:
 ;   1. return code:
 ;               -1-RPC/API failed
 ;                  Required variable not defined
 ;                0-No display/action required
 ;                  Not accessing own, employee, or sensitive record
 ;                1-Display warning message
 ;                  Sensitive and DG SENSITIVITY key holder
 ;                  or Employee and DG SECURITY OFFICER key holder
 ;                2-Display warning message/require OK to continue
 ;                  Sensitive and not a DG SENSITIVITY key holder
 ;                  Employee and not a DG SECURITY OFFICER key holder
 ;                3-Access to record denied
 ;                  Accessing own record
 ;                4-Access to Patient (#2) file records denied
 ;                  SSN not defined
 ;   2. display text/message
 ;   3. display text/message
 ;   4. display text/message
 ;
 N SDI,SDLINE,SDRET,SDSEC,SDTXT
 K SDRET,SDSEC
 S SDRET=""
 ;D PTSEC^DGSEC4(.SDSEC,DFN,0)  ;alb/sat 658
 D PTSEC4(.SDSEC,DFN,0)
 S $P(SDRET,"|",1)=SDSEC(1)
 S:$G(SDSEC(2))'="" $P(SDRET,"|",2)=SDSEC(2)  ;I DUZ=51 S:$G(SDSEC(2))'="" $P(SDRET,"|",2)=$$STRIP1(SDSEC(2))
 S:$G(SDSEC(3))'="" $P(SDRET,"|",3)=SDSEC(3)  ;I DUZ=51 S:$G(SDSEC(3))'="" $P(SDRET,"|",3)=$$STRIP1(SDSEC(3))
 S SDTXT=""
 S SDI=3 F  S SDI=$O(SDSEC(SDI)) Q:SDI=""  D
 .S SDLINE=$$STRIP1(SDSEC(SDI))
 .Q:SDLINE?." "
 .S SDTXT=$S(SDTXT'="":SDTXT,1:"")_SDLINE
 S:SDTXT'="" $P(SDRET,"|",4)=SDTXT
 Q SDRET
PTSEC4(RESULT,DFN,DGMSG,DGOPT) ;RPC/API entry point for patient sensitive & record access checks  ;alb/sat 658
 ;Output array (Required)
 ;    RESULT(1)= -1-RPC/API failed
 ;                  Required variable not defined
 ;                0-No display/action required
 ;                  Not accessing own, employee, or sensitive record
 ;                1-Display warning message
 ;                  Sensitive and DG SENSITIVITY key holder
 ;                  or Employee and DG SECURITY OFFICER key holder
 ;                2-Display warning message/require OK to continue
 ;                  Sensitive and not a DG SENSITIVITY key holder
 ;                  Employee and not a DG SECURITY OFFICER key holder
 ;                3-Access to record denied
 ;                  Accessing own record
 ;                4-Access to Patient (#2) file records denied
 ;                  SSN not defined
 ;   RESULT(2-10) = error or display messages
 ;
 ;Input parameters: DFN = Patient file entry (Required)
 ;                  DGMSG = If 1, generate message (optional)
 ;                  DGOPT  = Option name^Menu text (Optional)
 ;
 K RESULT
 I $G(DFN)="" D  Q
 .S RESULT(1)=-1
 .S RESULT(2)="Required variable missing."
 S DGMSG=$G(DGMSG,0)
 D OWNREC^DGSEC4(.RESULT,DFN,$G(DUZ),DGMSG)
 I RESULT(1)=1 S RESULT(1)=3 Q
 I RESULT(1)=2 S RESULT(1)=4 Q
 K RESULT
 D SENS^DGSEC4(.RESULT,DFN,$G(DUZ))
 I RESULT(1)=1 D
 .I $G(DUZ)="" D  Q
 ..;DUZ must be defined to access sensitive record & update DG Security log
 ..S RESULT(1)=-1
 ..S RESULT(2)="Your user code is undefined.  This must be defined to access a restricted patient record."
 .;D SETLOG1^DGSEC(DFN,DUZ,,$G(DGOPT))
 Q
 ;
STRIP1(SDTXT)  ;strip out "*"
 N SDI
 S SDTXT=$TR(SDTXT,"*","")
 F SDI=$L(SDTXT):-1:1 Q:$E(SDTXT,SDI)'=" "  S SDTXT=$E(SDTXT,1,$L(SDTXT)-1)
 Q SDTXT
 ;
WP(RET,STR,CH) ;Convert string STR to Word Processing array   ;alb/sat 658
 ;INPUT:
 ; STR - String to convert
 ; CH  - Max characters per line
 ;RETURN:
 ; RET - WP Array   RET(<line cnt>,0)=<text>
 N CH1,CNT,BEG,END,LCNT
 K RET
 Q:$G(STR)=""
 I '+$G(CH) S CH=80
 S (END,LCNT)=0
 S BEG=1
 F CNT=1:1:$L(STR) S CH1=$E(STR,CNT) D
 .I CH1=" " S END=CNT
 .I CNT'=BEG,'((CNT-BEG)#CH) D
 ..S LCNT=LCNT+1 S RET(LCNT,0)=$E(STR,BEG,$S(END'=0:END,1:CNT))
 ..S BEG=$S(END'=0:END,1:CNT)+1
 ..S END=0
 I CNT'=BEG S LCNT=LCNT+1 S RET(LCNT,0)=$E(STR,BEG,$L(STR))
 Q
WPSTR(ARR)  ;convert WP field array to single string   ;alb/sat 658
 N RET,WPI
 S RET=""
 Q:'$D(ARR) RET
 S WPI=0 F  S WPI=$O(ARR(WPI)) Q:WPI=""  D
 .S RET=RET_ARR(WPI)
 Q RET
PF(STRING,SUB,DI)  ;piece find
 N SDI
 S STRING=$G(STRING) Q:STRING="" ""
 S SUB=$G(SUB) Q:SUB="" ""
 S DI=$G(DI) S:DI="" DI=U
 F SDI=1:1:$L(STRING,DI) Q:$P(STRING,DI,SDI)=SUB
 Q SDI
PD(STRING,PC,DI)  ;piece delete
 N SDI,NSTR
 S NSTR=""
 S STRING=$G(STRING) Q:STRING="" STRING
 S PC=$G(PC) Q:'PC STRING
 S DI=$G(DI) S:DI="" DI=U
 F SDI=1:1:$L(STRING,DI) D
 .Q:SDI=PC
 .S NSTR=NSTR_$S(NSTR'="":DI,1:"")_$P(STRING,DI,SDI)
 Q NSTR
PFD(STRING,SUB,DI)  ;piece find/delete  delete all pieces with matching SUB values
 N SDI,NSTR
 S NSTR=""
 S STRING=$G(STRING) Q:STRING="" STRING
 S SUB=$G(SUB) Q:SUB="" STRING
 S DI=$G(DI) S:DI="" DI=U
 F SDI=1:1:$L(STRING,DI) S:$P(STRING,DI,SDI)'=SUB NSTR=NSTR_$S(NSTR'="":DI,1:"")_$P(STRING,DI,SDI)
 Q NSTR
