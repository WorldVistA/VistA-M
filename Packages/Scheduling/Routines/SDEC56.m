SDEC56 ;ALB/SAT - VISTA SCHEDULING RPCS ;JUN 21, 2017
 ;;5.3;Scheduling;**627,642,651,665**;Aug 13, 1993;Build 14
 ;
 Q
 ;
REP1GET(SDECY,MAXREC,LASTSUB,PNAME)   ;GET clinic data for report
 ;INPUT:
 ;  MAXREC   - (optional) Max records returned
 ;  LASTSUB  - (optional) last subscripts from previous call
 ;  PNAME    - (optional) partial name
 ;RETURN:
 ;  1. CLINIEN  - clinic ID pointer to HOSPITAL LOCATION file 44
 ;  2. CLINNAME - clinic NAME from HOSPITAL LOCATION file 44
 ;  3. TYPE     - clinic type - only valid value is 'CLINIC'
 ;  4. INSTIEN  - institution ID pointer to INSTITUTION file
 ;  5. INSTNAME - institution NAME from INSTITUTION file
 ;  6. DIVIEN   - division ID pointer to MEDICAL CENTER DIVISION file 40.8
 ;  7. DIVNAME  - division NAME from MEDICAL CENTER DIVISION file
 ;  8. STOP_CODE_ID     - stop code ID pointer to CLINIC STOP file 40.7
 ;  9. STOP_CODE_NUMBER - stop code number
 ; 10. SERVICE  - service assigned - valid values:
 ;                 MEDICINE
 ;                 SURGERY
 ;                 PSYCHIATRY
 ;                 REHAB MEDICINE
 ;                 NEUROLOGY
 ;                 NONE
 ; 11. TREATSPECID   - treating specialty ID pointer to FACILITY TREATING SPECIALTY file 45.7
 ; 12. TREATSPECNAME - treating specialty NAME from FACILITY TREATING SPECIALTY file
 ; 13. PROVIEN  - default provider ID pointer to NEW PERSON file 200
 ; 14. PROVNAME - default provider NAME from NEW PERSON file
 ; 15. AGENCYID   - agency ID pointer to AGENCY file 4.11
 ; 16. AGENCYNAME - agency NAME from AGENCY file
 ; 17. APPTLEN    - length of app't numeric 10-240 and multiple of 10 or 15
 ; 18. VAPPTLEN   - variable appointment length  'V' means "YES, VARIABLE LENGTH"; otherwise null
 ; 19. PROHIBITACC - prohibit access to clinic?  'YES'  or null
 ; 20. NON-COUNT  - non-count clinic?  'YES'  'NO'
 ; 21. INACTIVATE_DT - inactivate date in external format - date clinic was inactivated
 ; 22. REACTIVATE_DT - reactivate date in external format - date clinic was reactivated
 ; 23. DEF-APPT-TYPE_ID   - default appointment type ID pointer to APPOINTMENT TYPE file 409.1
 ; 24. DEF-APPT-TYPE_NAME - default appointment type NAME from APPOINTMENT TYPE file
 ; 25. PROVIDERS - Providers separated by pipe.
 ;       Each pipe piece contains the following ;; pieces:
 ;         1. provider ID pointer to NEW PERSON FILE 200
 ;         2. provider NAME from NEW PERSON file
 ;         3. default provider?  'NO'  'YES'
 ; 26. CLIN-SVCS-RES_ID   - clinic services resource ID pointer to
 ; 27. CLIN-SVCS-RES_NAME - clinic services resource NAME
 ; 28. CLINIC-GRP_ID   - clinic group (reports) ID pointer to CLINIC GROUP file 409.67
 ; 29. CLINIC-GRP_NAME - clinic group (reports) NAME from CLINIC GROUP file
 ; 30. DATE            - Date/Time this Clinic was created in external format
 ; 31. MAXDAYS - max # days for future booking  2002
 ; 32. LASTSUB - last subscripts of data in the return.
 ;               Pass this as LASTSUB in the next call to continue
 ;               collecting data.
 N SDA,SDAUD,SDAUDNOD,SDCL,SDCLN,SDDATA,SDFIELDS,SDECI,SDI,SDMSG,SDTMP
 N SDARR,SDCNT,SDECNAM,SDF,SDL,SDMORE   ;alb/sat 665
 S SDECY="^TMP(""SDEC56"","_$J_",""HLREP1"")"
 K @SDECY
 ;              1             2              3          4             5
 S SDTMP="T00030CLINIEN^T00030CLINNAME^T00030TYPE^T00030INSTIEN^T00030INSTNAME"
 ;                     6            7             8                  9
 S SDTMP=SDTMP_"^T00030DIVIEN^T00030DIVNAME^T00030STOP_CODE_ID^T00030STOP_CODE_NUMBER"
 ;                     10            11                12
 S SDTMP=SDTMP_"^T00030SERVICE^T00030TREATSPECID^T00030TREATSPECNAME"
 ;                     13            14             15             16               17
 S SDTMP=SDTMP_"^T00030PROVIEN^T00030PROVNAME^T00030AGENCYID^T00030AGENCYNAME^T00030APPTLEN"
 ;                     18             19                20              21
 S SDTMP=SDTMP_"^T00030VAPPTLEN^T00030PROHIBITACC^T00030NON-COUNT^T00030INACTIVATE_DT"
 ;                     22                  23                     24
 S SDTMP=SDTMP_"^T00030REACTIVATE_DT^T00030DEF-APPT-TYPE_ID^T00030DEF-APPT-TYPE_NAME"
 ;                     25              26                     27
 S SDTMP=SDTMP_"^T00030PROVIDERS^T00030CLIN-SVCS-RES_ID^T00030CLIN-SVCS-RES_NAME"
 ;                     28                  29                    30
 S SDTMP=SDTMP_"^T00030CLINIC-GRP_ID^T00030CLINIC-GRP_NAME^T00030DATE^T00030MAXDAYS^T00030LASTSUB^T00030ABBR"  ;alb/sat 655 - add ABBR
 S SDECI=0
 S @SDECY@(SDECI)=SDTMP_$C(30)
 S (SDCNT,SDF,SDMORE)=0   ;alb/sat 665
 S MAXREC=+$G(MAXREC,50)  ;alb/sat 665 - change from 200 to 50
 S LASTSUB=$G(LASTSUB)
 S PNAME=$G(PNAME)
 I $G(PNAME)'="" D
 .I ($P(LASTSUB,"|",1)="")!($P(LASTSUB,"|",1)="ABBR") D
 ..S SDF="ABBR"
 ..S SDECNAM=$$GETSUB^SDECU($S($P(LASTSUB,"|",2)'="":$P(LASTSUB,"|",2)'="",1:PNAME))
 ..F  S SDECNAM=$O(^SC("C",SDECNAM)) Q:SDECNAM'[PNAME  D  I SDCNT'<MAXREC S SDECNAM=$O(^SC("C",SDECNAM)) S SDMORE=$S(+SDMORE:1,SDECNAM[PNAME:1,1:0) Q   ;alb/sat 658 - abbreviation lookup if characters length 7 or less
 ...S SDCL=$S($P(LASTSUB,"|",3)'="":$P(LASTSUB,"|",3),1:0)
 ...S LASTSUB=""
 ...F  S SDCL=$O(^SC("C",SDECNAM,SDCL)) Q:SDCL=""  D GET1 I SDCNT'<MAXREC S SDMORE=+$O(^SC("C",SDECNAM,SDCL)) Q  ;alb/sat 665 loop thru all entries
 .I ($P(LASTSUB,"|",1)="")!($P(LASTSUB,"|",1)="FULL") D
 ..S SDF="FULL"
 ..S SDECNAM=$$GETSUB^SDECU($S($P(LASTSUB,"|",2)'="":$P(LASTSUB,"|",2)'="",1:PNAME))
 ..F  S SDECNAM=$O(^SC("B",SDECNAM)) Q:SDECNAM'[PNAME  D  I SDCNT'<MAXREC S SDECNAM=$O(^SC("B",SDECNAM)) S SDMORE=$S(+SDMORE:1,SDECNAM[PNAME:1,1:0) Q  ;alb/sat 658 - name lookup if character length is >5
 ...S SDCL=$S($P(LASTSUB,"|",3)'="":$P(LASTSUB,"|",3),1:0)
 ...S LASTSUB=""
 ...F  S SDCL=$O(^SC("B",SDECNAM,SDCL)) Q:SDCL=""  D GET1 I SDCNT'<MAXREC S SDMORE=+$O(^SC("B",SDECNAM,SDCL)) Q  ;alb/sat 665 loop thru all entries
 I PNAME="" D
 .S SDECNAM=$S($P(LASTSUB,"|",2)'="":$$GETSUB($P(LASTSUB,"|",2)),PNAME'="":$$GETSUB(PNAME),1:"")
 .F  S SDECNAM=$O(^SC("AG","C",SDECNAM)) Q:SDECNAM=""  D  I SDCNT'<MAXREC S SDECNAM=$O(^SC("AG","C",SDECNAM)) S SDMORE=$S(+SDMORE:1,SDECNAM'="":1,1:0) Q
 ..S SDCL=$S($P(LASTSUB,"|",3)'="":$P(LASTSUB,"|",3),1:0)
 ..S LASTSUB=""
 ..F  S SDCL=$O(^SC("AG","C",SDECNAM,SDCL)) Q:SDCL'>0  D  I SDCNT'<MAXREC S SDMORE=$O(^SC("AG","C",SDECNAM,SDCL)) Q
 ...D GET1
 S SDL=-1 F  S SDL=$O(SDARR(SDL)) Q:SDL=""  D
 .S SDI="" F  S SDI=$O(SDARR(SDL,SDI)) Q:SDI=""  D
 ..S SDTMP=SDARR(SDL,SDI)
 ..S $P(SDTMP,U,32)=SDF_"|"_SDECNAM_"|"_SDCL
 ..S SDECI=SDECI+1 S @SDECY@(SDECI)=SDTMP_$C(30)
 S:(SDECI>0)&('+SDMORE) $P(@SDECY@(SDECI),U,32)=""
 S @SDECY@(SDECI)=@SDECY@(SDECI)_$C(31)
 Q
GET1 ;get1 record
 N FND
 K SDDATA,SDMSG
 S SDFIELDS=".01;1;2;3;3.5;8;9;9.5;16;23;29;31;50.01;1912;1913;2002;2500;2502;2505;2506;2507"
 D GETS^DIQ(44,SDCL_",",SDFIELDS,"IE","SDDATA","SDMSG")
 S SDA="SDDATA(44,"""_SDCL_","")"
 Q:@SDA@(2,"I")'="C"
 Q:+$G(@SDA@(50.01,"I"))=1  ;OOS?
 S SDTMP=""
 S $P(SDTMP,U,1)=SDCL              ;clinic ID
 S $P(SDTMP,U,2)=@SDA@(.01,"E")    ;clinic name
 S $P(SDTMP,U,33)=@SDA@(1,"E")     ;clinic abbreviation
 I SDF="ABBR",$P(SDTMP,U,33)'="" S $P(SDTMP,U,2)=$P(SDTMP,U,33)_" "_$P(SDTMP,U,2)
 I SDF="FULL",PNAME'="" S FND=$$CHK^SDEC32(PNAME,SDCL) Q:+FND
 S $P(SDTMP,U,3)=@SDA@(2,"E")      ;clinic type
 S $P(SDTMP,U,4)=@SDA@(3,"I")      ;institution ID
 S $P(SDTMP,U,5)=@SDA@(3,"E")      ;institution name
 S $P(SDTMP,U,6)=@SDA@(3.5,"I")    ;division ID
 S $P(SDTMP,U,7)=@SDA@(3.5,"E")    ;division NAME
 S:@SDA@(8,"I") $P(SDTMP,U,8)=$$GET1^DIQ(40.7,@SDA@(8,"I"),1)      ;stop code ID  ;alb/sat 651
 S $P(SDTMP,U,9)=@SDA@(8,"E")      ;stop code number
 S $P(SDTMP,U,10)=@SDA@(9,"E")     ;service
 S $P(SDTMP,U,11)=@SDA@(9.5,"I")   ;treating specialty ID
 S $P(SDTMP,U,12)=@SDA@(9.5,"E")   ;treating specialty name
 S $P(SDTMP,U,13)=@SDA@(16,"I")    ;default provider ID
 S $P(SDTMP,U,14)=@SDA@(16,"E")    ;default provider name
 S $P(SDTMP,U,15)=@SDA@(23,"I")    ;agency ID
 S $P(SDTMP,U,16)=@SDA@(23,"E")    ;agency name
 S $P(SDTMP,U,17)=+@SDA@(1912,"E")  ;length of appointment
 S $P(SDTMP,U,18)=@SDA@(1913,"I")  ;variable appointment
 S $P(SDTMP,U,19)=@SDA@(2500,"E")  ;prohibit access to clinic
 S $P(SDTMP,U,20)=@SDA@(2502,"E")  ;non-count clinic?
 S $P(SDTMP,U,21)=@SDA@(2505,"E")  ;inactivate date
 S $P(SDTMP,U,22)=@SDA@(2506,"E")  ;reactivate date
 S $P(SDTMP,U,23)=@SDA@(2507,"I")  ;default appointment type ID
 S $P(SDTMP,U,24)=@SDA@(2507,"E")  ;default appointment type name
 S $P(SDTMP,U,25)=$$GETPRV(SDCL)   ;providers - IEN ;; NAME ;; DEF? | ...
 S $P(SDTMP,U,26)=@SDA@(29,"I")    ;clinic services resource ID
 S $P(SDTMP,U,27)=@SDA@(29,"E")    ;clinic services resource name
 S $P(SDTMP,U,28)=@SDA@(31,"I")    ;clinic group (reports) ID
 S $P(SDTMP,U,29)=@SDA@(31,"E")    ;clinic group (reports) name
 S SDAUD=$O(^DIA(44,"B",SDCL,0))
 S SDAUDNOD=$G(^DIA(44,+SDAUD,0))
 I $P(SDAUDNOD,U,5)="A" S $P(SDTMP,U,30)=$$FMTE^XLFDT($P(SDAUDNOD,U,2),"M")
 S $P(SDTMP,U,31)=@SDA@(2002,"E")  ;max # days for future booking
 S $P(SDTMP,U,32)=""               ;LASTSUB setup after the loop in last record
 ;
 S SDARR(SDF="FULL",$P(SDTMP,U,2))=SDTMP,SDCNT=SDCNT+1
 ;S SDECI=SDECI+1 S @SDECY@(SDECI)=SDTMP_$C(30)
 Q
 ;
GETPRV(SDCL)  ;get providers from PROVIDER multiple in file 44
 ;INPUT:
 ; SDCL - clinic ID pointer to HOSPITAL LOCATION file 44
 ;RETURN:
 ; PROVIDERS - Providers separated by pipe.
 ;       Each pipe piece contains the following ;; pieces:
 ;         1. provider ID pointer to NEW PERSON FILE 200
 ;         2. provider NAME from NEW PERSON file
 ;         3. default provider?  'NO'  'YES'
 N SDI,SDNOD,SDRET
 S SDRET=""
 S SDI=0 F  S SDI=$O(^SC(SDCL,"PR",SDI)) Q:SDI'>0  D
 .S SDNOD=$G(^SC(SDCL,"PR",SDI,0))
 .S SDRET=$S(SDRET'="":SDRET_"|",1:"")_$P(SDNOD,U,1)_";;"_$$GET1^DIQ(200,$P(SDNOD,U,1)_",",.01)_";;"_$S($P(SDNOD,U,2)=1:"YES",1:"NO")
 Q SDRET
 ;
GETSUB(TXT)  ;
 Q $$GETSUB^SDECU(TXT)   ;alb/sat 665
