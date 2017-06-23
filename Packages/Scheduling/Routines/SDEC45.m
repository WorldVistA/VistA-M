SDEC45 ;ALB/SAT - VISTA SCHEDULING RPCS ;MAR 15, 2017
 ;;5.3;Scheduling;**627,642,658**;Aug 13, 1993;Build 23
 ;
 Q
 ;
CLINSTOP(SDECY,SDP) ;CLINIC STOP remote procedure   ;alb/sat 658 - add SDP for Partial Name input
 ;return entries from the CLINIC STOP file (#40.7)
 N SDECC,SDECI,SDECNOD,SDIEN
 ;
 S SDECI=0
 K ^TMP("SDEC",$J)
 S SDECY="^TMP(""SDEC"","_$J_")"
 S ^TMP("SDEC",$J,0)="T00020CLINIC_STOP_IEN^T00020CODE^T00020NAME"_$C(30)
 S SDP=$G(SDP)  ;alb/sat 658
 S SDECN=$S(SDP'="":$$GETSUB^SDECU(SDP),1:"")   ;alb/sat 658 - set SDECN to partial name
 F  S SDECN=$O(^DIC(40.7,"B",SDECN)) Q:SDECN=""  Q:(SDP'="")&(SDECN'[SDP)  D   ;alb/sat 658 - check if within partial name bounds
 .S SDECC="" F  S SDECC=$O(^DIC(40.7,"B",SDECN,SDECC)) Q:SDECC=""  D
 ..S SDECNOD=^DIC(40.7,SDECC,0)
 ..I $P(SDECNOD,U,3)'="",$P($P(SDECNOD,U,3),".",1)'>$P($$NOW^XLFDT,".",1) Q
 ..S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=SDECC_U_$P(SDECNOD,U,2)_U_$P(SDECNOD,U,1)_$C(30)
 S ^TMP("SDEC",$J,SDECI)=^TMP("SDEC",$J,SDECI)_$C(31)
 Q
 ;
CANREAS(SDECY,SDECIN) ;return active/inactive entries from the CANCELLATION REASONS file 409.2
 ;CANREAS(SDECY,SDECIN)  external parameter tag is in SDEC
 ; INPUT:  SDECIN - (optional) Flag: show inactive  0=active only (default); 1=show active and inactive
 N SDECC,SDECI,SDECNOD,SDTYPE
 ;
 S SDECI=0
 K ^TMP("SDEC",$J)
 S SDECY="^TMP(""SDEC"","_$J_")"
 S ^TMP("SDEC",$J,0)="T00020CANCELLATION_REASONS_IEN^T00020NAME^T00030TYPE"_$C(30)
 S:($G(SDECIN)="")!("01"'[$G(SDECIN)) SDECIN=0  ;default to active only
 S SDECN=""
 F  S SDECN=$O(^SD(409.2,"B",SDECN)) Q:SDECN=""  D
 . S SDECC=$O(^SD(409.2,"B",SDECN,""))
 . S SDECNOD=^SD(409.2,SDECC,0)
 . I SDECIN!($P($G(SDECNOD),U,4)'=1) D
 . . S SDTYPE=$S($P(SDECNOD,U,2)="P":"PATIENT",$P(SDECNOD,U,2)="C":"CLINIC",$P(SDECNOD,U,2)="B":"BOTH",1:"")
 . . S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=SDECC_U_$P(SDECNOD,U,1)_U_SDTYPE_$C(30)
 S ^TMP("SDEC",$J,SDECI)=^TMP("SDEC",$J,SDECI)_$C(31)
 Q
 ;
NEWPERS(SDECY,SDCLASS,SDPART,MAXREC,LSUB,INACT) ;return entries from the USR CLASS MEMBERSHIP file that have the 'PROVIDER' USR CLASS
 ;NEWPERS(SDECY,SDCLASS)  external parameter tag is in SDEC
 ; INPUT:
 ;   SDCLASS - (not used) usr class ID pointer to USR CLASS file 8930
 ;                        default is the 'PROVIDER' USR CLASS
 ;   SDPART  - (optional) Partial user name
 ;   MAXREC  - (optional) Max records returned
 ;   LSUB    - (optional) Last subscripts from previous call
 ;   INACT   - (optional) inactive flag
 ;                         0=return only active users that do not have an active PERSON CLASS
 ;                         1=return active AND inactive users
 N SDECI,SDECN,SDIEN,SDINACT
 N SDACT
 S INACT=$G(INACT)
 S SDECI=0
 S SDECY="^TMP(""SDEC"","_$J_")"
 K @SDECY
 S @SDECY@(SDECI)="T00020NEW_PERSON_IEN^T00020NAME^T00030LASTSUB^T00030INACTIVE"_$C(30)
 S SDPART=$G(SDPART)
 S MAXREC=$G(MAXREC)
 S LSUB=$G(LSUB)
 D NP2
 S ^TMP("SDEC",$J,SDECI)=^TMP("SDEC",$J,SDECI)_$C(31)
 Q
NP2 ;partial name lookup
 N SDCLS,SDECC,SDECN,SDECNPS,SDTMP
 S SDECN=$S($P(LSUB,"|",1)'="":$$GETSUB^SDECU($P(LSUB,"|",1)),SDPART'="":$$GETSUB^SDECU(SDPART),1:"")
 F  S SDECN=$O(^VA(200,"B",SDECN)) Q:SDECN=""  Q:(SDPART'="")&(SDECN'[SDPART)  D  Q:(+MAXREC)&(SDECI'<MAXREC)
 .S SDECC=$S($P(LSUB,"|",2)'="":$P(LSUB,"|",2),1:0)
 .S LSUB=""
 .F  S SDECC=$O(^VA(200,"B",SDECN,SDECC)) Q:SDECC'>0  D  Q:(+MAXREC)&(SDECI'<MAXREC)
 ..I $$PC(SDECC),'INACT D USRDG^SDEC01B(SDECC) Q   ;$$ISTERM^USRLM(SDECC) Q
 ..S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=SDECC_U_SDECN_U_SDECN_"|"_SDECC_U_$$PC(SDECC)_$C(30)
 I (SDECI>0),('MAXREC)!(SDECI<MAXREC) D
 .S SDTMP=$P(^TMP("SDEC",$J,SDECI),$C(30),1)
 .S $P(SDTMP,U,3)=""
 .S ^TMP("SDEC",$J,SDECI)=SDTMP_$C(30)
 Q
PC(USR,SDT,EFFDT,EXPDT,SDF) ;is USR active - does USR have an active PERSON CLASS
 ;PC called from NP2 above and SDEC1A
 ;  USR - (required) pointer to NEW PERSON file 200
 ;  SDT - (optional) date in FM format to determine active status; default to 'today'
 ;  SDF - (optional) flags
 ;                   1. do not check TERMINATION DATE
 ;RETURN:
 ; 0=active; 1=inactive
 ; .EFFDT - latest effective date
 ; .EXPDT - latest expiration date; "" if no expiration against current active
 N RET,SDI,TD,EFF,EXP
 S SDF=$G(SDF,0)
 S RET=1
 I '$E(SDF) S TD=$$GET1^DIQ(200,USR_",",9.2,"I") I TD'="",TD'>DT G:+RET PCX
 S (EFFDT,EXPDT)=""
 I $G(USR)="" Q 1
 S SDT=$G(SDT) I SDT="" S SDT=DT
 I SDT'?7N Q RET
 S SDI=0 F  S SDI=$O(^VA(200,USR,"USC1",SDI)) Q:SDI'>0  D  Q:RET=0
 .S EFF=$P(^VA(200,USR,"USC1",SDI,0),U,2)
 .S EXP=$P(^VA(200,USR,"USC1",SDI,0),U,3)
 .I EFF'="",EFF>EFFDT S EFFDT=EFF
 .I EXP'="",EXP>EXPDT S EXPDT=EXP
 .I SDT'<EFF,(EXP="")!(SDT<EXP) S RET=0 S EFFDT=EFF S EXPDT=$S(EXP'="":EXP,1:"")
PCX ;
 Q RET
 ;
 ;S SDIEN=0 F  S SDIEN=$O(^XUSEC("PROVIDER",SDIEN)) Q:SDIEN'>0  D
 ;.S SDINACT=$$GET1^DIQ(200,SDIEN_",",53.4,"I")
 ;.I SDINACT'="" S:SDINACT>$$NOW^XLFDT SDINACT=""
 ;.I SDINACT="" D
 ;..S SDECN=$$GET1^DIQ(200,SDIEN_",",.01)
 ;..S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=SDIEN_U_SDECN_$C(30)
 ;S ^TMP("SDEC",$J,SDECI)=^TMP("SDEC",$J,SDECI)_$C(31)
 ;Q
 ;
 ;Q
 ;
ACCTYPE(SDECY) ;return active entries from the SDEC ACCESS TYPE file 409.823
 ;ACCTYPE(SDECY)  external parameter tag is in SDEC
 ; INPUT:  none
 N SDECC,SDECI,SDECN,SDECNOD
 S SDECI=0
 K ^TMP("SDEC",$J)
 S SDECY="^TMP(""SDEC"","_$J_")"
 S ^TMP("SDEC",$J,0)="T00020SDEC_ACCESS_TYPE_IEN^T00020NAME^T00020INACTIVE^T00020DEPARTMENT_NAME^T00020DISPLAY_COLOR^T00020RED^T00020GREEN^T00020BLUE^T00020PREVENT_ACCESS"_$C(30)
 S SDECN=""
 F  S SDECN=$O(^SDEC(409.823,"B",SDECN)) Q:SDECN=""  D
 . S SDECC=$O(^SDEC(409.823,"B",SDECN,""))
 . S SDECIN=$$GET1^DIQ(409.823,SDECC_",",.02)
 . I SDECIN'="YES" D
 . . S SDECNOD=SDECC_U_$$GET1^DIQ(409.823,SDECC_",",.01)_U_SDECIN
 . . S SDECNOD=SDECNOD_U_$$GET1^DIQ(409.823,SDECC_",",.03)_U_$$GET1^DIQ(409.823,SDECC_",",.04)_U_$$GET1^DIQ(409.823,SDECC_",",.05)
 . . S SDECNOD=SDECNOD_U_$$GET1^DIQ(409.823,SDECC_",",.06)_U_$$GET1^DIQ(409.823,SDECC_",",.07)_U_$$GET1^DIQ(409.823,SDECC_",",.08)
 . . S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=SDECNOD_$C(30)
 S ^TMP("SDEC",$J,SDECI)=^TMP("SDEC",$J,SDECI)_$C(31)
 Q
 ;
ACCGROUP(SDECY) ;return active entries from the SDEC ACCESS GROUP file 409.822
 ;ACCGROUP(SDECY)  external parameter tag is in SDEC
 ; INPUT:  none
 N SDECC,SDECI,SDECN,SDECNOD
 S SDECI=0
 K ^TMP("SDEC",$J)
 S SDECY="^TMP(""SDEC"","_$J_")"
 S ^TMP("SDEC",$J,0)="T00020SDEC_ACCESS_GROUP_IEN^T00020NAME"_$C(30)
 S SDECN=""
 F  S SDECN=$O(^SDEC(409.822,"B",SDECN)) Q:SDECN=""  D
 . S SDECC=$O(^SDEC(409.822,"B",SDECN,""))
 . S SDECNOD=SDECC_U_$$GET1^DIQ(409.822,SDECC_",",.01)
 . S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=SDECNOD_$C(30)
 S ^TMP("SDEC",$J,SDECI)=^TMP("SDEC",$J,SDECI)_$C(31)
 Q
 ;
RESUSER(SDECY,SDRES) ;SDEC RESOURCE USER remote procedure returns all entries from the SDEC RESOURCE USER file 409.833
 ;RESUSER(SDECY,SDRES) external parameter tag is in SDEC
 ; INPUT:
 ; SDRES = Resource ID pointer to SDEC RESOURCE file 409.831
 ;RETURN:
 ; Returns a Global Array in which each array entry contains data from the SDEC RESOURCE USER file separated by ^:
 ; 1. SDEC_RESOURCE_USER_IEN
 ; 2. RESOURCE_NAME
 ; 3. RESOURCE_ID
 ; 4. OVERBOOK
 ; 5. MODIFY_SCHEDULE
 ; 6. MODIFY_APPTS
 ; 7. USERNAME
 ; 8. USER_ID
 ; 9. MASTEROVERBOOK
 N SDECC,SDECI,SDECN,SDECNOD
 S SDECI=0
 K ^TMP("SDEC",$J)
 S SDECY="^TMP(""SDEC"","_$J_")"
 ; 1 2 3 4 5
 S SDECTMP="T00020SDEC_RESOURCE_USER_IEN^T00020RESOURCE_NAME^T00020RESOURCE_ID^T00020OVERBOOK^T00020MODIFY_SCHEDULE^"
 ; 6 7 8 9
 S SDECTMP=SDECTMP_"T00020MODIFY_APPTS^T00020USERNAME^T00020USER_ID^T00020MASTEROVERBOOK"_$C(30)
 S ^TMP("SDEC",$J,0)=SDECTMP
 S SDRES=$G(SDRES)
 I SDRES'="",'$D(^SDEC(409.831,+SDRES,0)) S ^TMP("SDEC",$J,1)="-1^Invalid Resource ID." Q
 I SDRES'="" S SDECC=0 F  S SDECC=$O(^SDEC(409.833,"B",+SDRES,SDECC)) Q:SDECC'>0  D GET1
 I SDRES="" S SDECC=0 F  S SDECC=$O(^SDEC(409.833,SDECC)) Q:SDECC'>0  D GET1
 S ^TMP("SDEC",$J,SDECI)=^TMP("SDEC",$J,SDECI)_$C(31)
 Q
GET1 ;
 N TD
 S SDECNOD=^SDEC(409.833,SDECC,0)
 ;Q:$$PC($P(SDECNOD,U,2))
 S TD=$$GET1^DIQ(200,$P(SDECNOD,U,2)_",",9.2,"I") I TD'="",TD'>DT Q
 S SDECTMP=SDECC                                           ;1. resource user ID
 S SDECTMP=SDECTMP_U_$$GET1^DIQ(409.833,SDECC_",",.01)     ;2. resource name
 S SDECTMP=SDECTMP_U_$P(SDECNOD,U,1)                       ;3. resource ID - pointer to SDEC RESOURCE
 S SDECTMP=SDECTMP_U_$$GET1^DIQ(409.833,SDECC_",",.03)     ;4. overbook
 S SDECTMP=SDECTMP_U_$$GET1^DIQ(409.833,SDECC_",",.04)     ;5. modify schedule
 S SDECTMP=SDECTMP_U_$$GET1^DIQ(409.833,SDECC_",",.05)     ;6. modify appointments
 S SDECTMP=SDECTMP_U_$$GET1^DIQ(409.833,SDECC_",",.02)     ;7. user name
 S SDECTMP=SDECTMP_U_$P(SDECNOD,U,2)                       ;8. user ID
 S SDECTMP=SDECTMP_U_$$GET1^DIQ(409.833,SDECC_",",.06)     ;9. master overbook
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=SDECTMP_$C(30)
 Q
 ;
HOLIDAY(SDECY,SDECBD) ;return all entries from the HOLIDAY file 40.5
 ;HOLIDAY(SDECY,SDECBD)  external parameter tag is in SDEC
 ; INPUT:  SDECBD = begin date in external format (defaults to 'today')
 N SDECC,SDECI,SDECN,SDECNOD,SDECTMP,%DT,X,Y
 S SDECI=0
 K ^TMP("SDEC",$J)
 S SDECY="^TMP(""SDEC"","_$J_")"
 I $G(SDECBD)'=""&(SDECBD'="1/1/0001@00:00") D
 . S X=$P(SDECBD,"@",1)
 . S %DT=""
 . D ^%DT
 . S SDECBD=Y
 I SDECBD=-1 D ERR("SDEC45: Invalid date specified.") Q
 I $G(SDECBD)="" S SDECBD=$$DT^XLFDT()      ;default to 'today'
 I $$FR^XLFDT(SDECBD) S SDECBD=$$DT^XLFDT() ;check if date in valid range
 S ^TMP("SDEC",$J,0)="T00020SDEC_HOLIDAY_DATE^T00020HOLIDAY_NAME"_$C(30)
 S SDECN=SDECBD-1
 F  S SDECN=$O(^HOLIDAY("B",SDECN)) Q:SDECN=""  D
 . S SDECC=$O(^HOLIDAY("B",SDECN,""))
 . S SDECTMP=$$FMTE^XLFDT($P(^HOLIDAY(SDECC,0),"^",1),5)  ;holiday date
 . S SDECTMP=SDECTMP_U_$$GET1^DIQ(40.5,SDECC_",",2)       ;holiday name
 . S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=SDECTMP_$C(30)
 S ^TMP("SDEC",$J,SDECI)=^TMP("SDEC",$J,SDECI)_$C(31)
 Q
 ;
CLINPROV(SDECY,SDECCL) ;return all providers for a given clinic from the HOSPITAL LOCATION file 44
 ;CLINPROV(SDECY,SDECCL)  external parameter tag is in SDEC
 ; INPUT:  SDECCL = Clinic (Hospital Location) IEN from file 44 ^SC
 N SDECC,SDECI,SDECN,SDECNOD,SDECTMP
 S SDECI=0
 K ^TMP("SDEC",$J)
 S SDECY="^TMP(""SDEC"","_$J_")"
 ;check inputs
 S ^TMP("SDEC",$J,0)="T00020ERRORID"_$C(30)
 I $G(SDECCL)="" D ERR("SDEC45: Clinic not specified.") Q
 I '$D(^SC(SDECCL)) D ERR("SDEC45: Invalid clinic specified.") Q
 S ^TMP("SDEC",$J,0)="T00020PROVIDER_IEN^T00020PROVIDER_NAME^T00030DEFAULT"_$C(30)
 S SDECC=0
 F  S SDECC=$O(^SC(SDECCL,"PR",SDECC)) Q:SDECC'>0  D
 . S SDECNOD=^SC(SDECCL,"PR",SDECC,0)
 . S SDECTMP=$P(SDECNOD,U,1)                            ;provider IEN
 . D RESPRV1^SDEC01B(SDECTMP,SDECCL)
 . S $P(SDECTMP,U,2)=$$GET1^DIQ(200,SDECTMP_",",.01)    ;provider name
 . S $P(SDECTMP,U,3)=$S($P(SDECNOD,U,2)=1:"YES",1:"NO") ;default provider
 . S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=SDECTMP_$C(30)
 S ^TMP("SDEC",$J,SDECI)=^TMP("SDEC",$J,SDECI)_$C(31)
 Q
 ;
PROVALL(SDECY,SDECCL) ;return all providers for a given clinic from the HOSPITAL LOCATION file 44
 ;PROVALL(SDECY,SDECCL)  external parameter tag is in SDEC
 ; INPUT:  SDECCL = Clinic (Hospital Location) IEN from file 44 ^SC
 N SDECC,SDECI,SDECN,SDECNOD,SDECTMP,SDECARRI,SDECCL,SDECARRN,SDECPRNM,SDECIEN
 S SDECI=0
 K ^TMP("SDEC",$J)
 S SDECY="^TMP(""SDEC"","_$J_")"
 ;check inputs
 S ^TMP("SDEC",$J,0)="T00020PROVIDER_IEN^T00030PROVIDER_NAME"_$C(30)
 S SDECCL=0
 F  S SDECCL=$O(^SC(SDECCL)) Q:'SDECCL  D
 . S SDECC=0
 . F  S SDECC=$O(^SC(SDECCL,"PR",SDECC)) Q:SDECC'>0  D
 . . S SDECNOD=^SC(SDECCL,"PR",SDECC,0)
 . . S SDECTMP=$P(SDECNOD,U,1)                           ;provider IEN
 . . D RESPRV1^SDEC01B(SDECTMP,SDECCL)
 . . S SDECARRI(SDECTMP)="" ; Save array of Provider IENs
 S SDECTMP="" F  S SDECTMP=$O(SDECARRI(SDECTMP)) Q:SDECTMP=""  D
 . S SDECPRNM=$$GET1^DIQ(200,SDECTMP_",",.01)
 . S:SDECPRNM'="" SDECARRN(SDECPRNM)=SDECTMP
 S SDECPRNM="" F  S SDECPRNM=$O(SDECARRN(SDECPRNM)) Q:SDECPRNM=""  D
 . S SDECIEN=SDECARRN(SDECPRNM)
 . S SDECI=SDECI+1
 . S ^TMP("SDEC",$J,SDECI)=SDECIEN_U_SDECPRNM_$C(30)
 S ^TMP("SDEC",$J,SDECI)=^TMP("SDEC",$J,SDECI)_$C(31)
 Q
 ;
PROVCLIN(SDECY,SDECPRV) ;PROVIDER CLINICS remote procedure
 ;PROVCLIN(SDECY,SDECPRV)  external parameter tag is in SDEC
 ; return all clinics for a given provider from the NEW PERSON file 200
 ; INPUT:  SDECPRV = Provider (NEW PERSON) IEN from file 200
 N SDECC,SDECI,SDECN,SDECNOD,SDECTMP
 S SDECI=0
 K ^TMP("SDEC",$J)
 S SDECY="^TMP(""SDEC"","_$J_")"
 ;check inputs
 S ^TMP("SDEC",$J,0)="T00020ERRORID"_$C(30)
 I $G(SDECPRV)="" D ERR("SDEC45: Provider not specified.") Q
 I '$D(^VA(200,SDECPRV)) D ERR("SDEC45: Invalid provider specified.") Q
 S ^TMP("SDEC",$J,0)="T00020CLINIC_IEN^T00020CLINIC_NAME"_$C(30)
 D CLINICS
 S ^TMP("SDEC",$J,SDECI)=^TMP("SDEC",$J,SDECI)_$C(31)
 Q
 ;
CLINICS ; -- sets ^TMP for provider's clinics
 NEW CLN,IEN,NAME
 S CLN=0 F  S CLN=$O(^SC("AVADPR",SDECPRV,CLN)) Q:'CLN  D
 . S IEN=0 F  S IEN=$O(^SC("AVADPR",SDECPRV,CLN,IEN)) Q:'IEN  D
 .. ;I ^SC("AVADPR",SDECPRV,CLN,IEN)'=1 Q   ;not default provider
 .. Q:$$GET1^DIQ(44,CLN_",",50.01,"I")=1   ;OOS?
 .. D RESPRV1^SDEC01B(SDECPRV,IEN)
 .. S NAME=$$GET1^DIQ(44,CLN,.01)
 .. S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=CLN_U_NAME_$C(30)
 Q
 ;
HIDE(SDECY) ; --- Returns list of clinics that are Hidden
 N IEN,NAME,SDECI
 S SDECI=0
 K ^TMP("SDEC",$J)
 S SDECY="^TMP(""SDEC"","_$J_")"
 S ^TMP("SDEC",$J,0)="T00020CLINIC_IEN^T00020CLINIC_NAME"_$C(30,31)
 Q
ERROR ;
 D ERR("VISTA Error")
 Q
 ;
ERR(ERRNO) ;Error processing
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=ERRNO_$C(30,31)
 Q
