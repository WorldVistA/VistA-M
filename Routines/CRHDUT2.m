CRHDUT2 ; CAIRO/CLC - GET THE PATIENT DATA ELEMENTS FOR HANDOFF LIST CONTINUED;04-Mar-2008 16:00;CLC
 ;;1.0;CRHD;****;Jan 28, 2008;Build 19
 ;=================================================================
PATDEMO(CRHDDATA,CRHDSTR) ;GET PATIENTS DEMOGRAPHICS
 ;DFN  - patient internal entry number to the Patient file
 ;P    - pieces to return from retrieve data string
 ;CRHDLEN  - max length of returned items, defaults to 18
 ;LABELS - 0 or 1
 ;Output
 ;CRHDRTN
 ;DFN - Piece  1             NAME     Piece 2
 ;SSN          3 (full ssn)  DOB            4
 ;SSN          5 (last 4ssn) AGE            6
 ;SEX          7             RM             8
 ;TSP          9             ATN           10
 ;PCP         11             LOC           12
 ;ADMDT       13 (adm date)  DAY w/i ADM   14
 ;ADMDX       15 (admission Diagnosis)
 ;
 N VAIN,VAIP,VADM,CRHDNAME,CRHDSSN,CRHDDOB,CRHDAGE,CRHDSEX,CRHDRM,CRHDTSP,CRHDATTN,CRHDRTN,CRHDLEN,CRHDLBLS
 N CRHDPCP,CRHDWARD,CRHDADMD,CRHDADAY,CRHDADX,CRHDI,CRHDTRG,CRHDNUM,CRHDP,DFN
 K CRHDDATA
 S CRHDTRG="^TMP(""CRHD_ORDATA"",$J)"
 K @CRHDTRG,CRHDRTN
 S CRHDNUM=0
 S DFN=+CRHDSTR
 S CRHDP=$P(CRHDSTR,U,2)
 I CRHDP=""!(CRHDP="ALL") S CRHDP="1,2,3,4,5,6,7,8,9,10,11,12,13,14,15"
 S CRHDLEN=$P(CRHDSTR,U,3)
 I 'CRHDLEN S CRHDLEN=18
 S CRHDLBLS=$P(CRHDSTR,U,4)
 Q:'DFN
 D DEM^VADPT
 S CRHDNAME=VADM(1),CRHDSSN=$P(VADM(2),U,1),CRHDDOB=$P(VADM(3),U,2)
 S CRHDAGE=VADM(4),CRHDSEX=$P(VADM(5),U,1)
 D INP^VADPT
 S CRHDRM=$G(VAIN(5))                              ;Room/Bed
 S CRHDTSP=$P($G(VAIN(3)),U,2)                     ;Team (Treating Specialty)
 S CRHDATTN=$P($G(VAIN(11)),U,2)                   ;Attending Physicial
 S CRHDPCP=$P($$OUTPTPR^SDUTL3(DFN,DT),U,2)        ;Primary Care Provider
 S CRHDWARD=$P($G(VAIN(4)),U,2)                    ;Ward Location
 S CRHDADMD=$P($G(VAIN(7)),U,2)                   ;Admission Date
 S:+$G(VAIN(7))>0 CRHDADAY=$$FMDIFF^XLFDT(+$$DT^XLFDT,+$G(VAIN(7)),1)   ;Day within Admission
 S CRHDADX=$G(VAIN(9))                           ;Admission Diagnosis
 I $G(CRHDLBLS) D
 .S CRHDRTN=DFN_U_$E(CRHDNAME,1,CRHDLEN)_U_"SSN: "_CRHDSSN_U_"DOB: "_CRHDDOB
 .S CRHDRTN=CRHDRTN_U_"SSN: "_$E(CRHDSSN,6,9)_U_"AGE: "_CRHDAGE_U_"SEX: "_CRHDSEX
 .S CRHDRTN=CRHDRTN_U_"RM : "_CRHDRM_U_"TM: "_$E(CRHDTSP,1,CRHDLEN-4)
 .S CRHDRTN=CRHDRTN_U_"ATN: "_$E(CRHDATTN,1,CRHDLEN-5)_U_"PCP: "_$E(CRHDPCP,1,CRHDLEN-5)
 .S CRHDRTN=CRHDRTN_U_"LOC: "_CRHDWARD_U_CRHDADMD_U_"DAY OF ADM: "_$G(CRHDADAY)_U_"ADM DX: "_$E(CRHDADX,1,CRHDLEN)
 .F CRHDI=1:1:$L(CRHDP,",") I $P(CRHDRTN,"^",$P(CRHDP,",",CRHDI))'="" S CRHDDATA=$G(CRHDDATA)_$P(CRHDRTN,"^",$P(CRHDP,",",CRHDI)) S:CRHDI<$L(CRHDP,",") CRHDDATA=CRHDDATA_"^"
 E  D
 .S CRHDRTN=DFN_U_$E(CRHDNAME,1,CRHDLEN)_U_CRHDSSN_U_CRHDDOB_U_$E(CRHDSSN,6,9)_U_CRHDAGE_U_CRHDSEX_U_CRHDRM_U_$E(CRHDTSP,1,CRHDLEN)_U_$E(CRHDATTN,1,CRHDLEN-5)_U_$E(CRHDPCP,1,CRHDLEN-5)_U_CRHDWARD_U_CRHDADMD_U_$G(CRHDADAY)_U_$E(CRHDADX,1,CRHDLEN)
 .F CRHDI=1:1:$L(CRHDP,",") S CRHDDATA=$G(CRHDDATA)_$P(CRHDRTN,"^",$P(CRHDP,",",CRHDI)) S:CRHDI<$L(CRHDP,",") CRHDDATA=CRHDDATA_"^"
 Q
AUSRINFO(CRHDRTN,CRHDUSR) ;retrieve additional user information
 N X,Y
 K CRHDRTN
 S CRHDRTN(1)=0
 S CRHDRTN(1)=$$GET1^DIQ(200,CRHDUSR_",",.132,"E")_"^"_$$GET1^DIQ(200,CRHDUSR_",",.138,"E")_"^"_$$GET^XPAR("USR.`"_CRHDUSR,"ORLP DEFAULT TEAM",1,"I")
 Q
