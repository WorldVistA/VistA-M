SDEC52 ;ALB/SAT - VISTA SCHEDULING RPCS ;APR 08, 2016
 ;;5.3;Scheduling;**627,642**;Aug 13, 1993;Build 23
 ;
 Q
 ;
RECGET(SDECY,DFN,SDBEG,SDEND,MAXREC,LASTSUB,RECIEN,SDSTOP) ; GET entries from the RECALL REMINDERS file 403.5 for a given Patient and Recall Date range.
RECGETA ;
 ;RECGET(SDECY,DFN,SDBEG,SDEND,MAXREC,LASTSUB,RECIEN,SDSTOP)  external parameter tag is in SDEC
 ;INPUT:
 ;  DFN    = (optional) pointer to PATIENT file 2; returns all data if null
 ;  SDBEG  = (optional) Begin Date range in external format to search RECALL DATE range. (no time)
 ;  SDEND  = (optional) End Date range in external format to search RECALL DATE range. (no time)
 ;  MAXREC -  (optional) maximum number of records to return
 ;  LASTSUB - (optional) last subscripts from previous call;
 ;                          Used to collect the data in multiple
 ;                          background calls
 ;  RECIEN  - (optional)  Recall Reminders ID pointer to RECALL REMINDERS file
 ;                       returns the single record pointed to by RECIEN
 ;  SDTOP    - (optional) runs through the xrefs in reverse using -1 in $O  0=forward; 1=reverse
 ;
 ;RETURN:
 ; Successful Return:
 ;   Global Array in which each array entry contains data from the RECALL REMINDERS file 403.5.
 ;   Data is separated by ^:
 ;     1. IEN        - pointer to RECALL REMINDERS
 ;     2. DFN        - Pointer to PATIENT file
 ;     3. NAME       - Patient NAME from PATIENT file
 ;     4. HRN
 ;     5. DOB        - Date of Birth in external format
 ;     6. SSN        - Social Security Number
 ;     7. GENDER
 ;     8  INSTIEN    - INSTITUTION ien
 ;     9  INSTNAME   - INSTITUTION NAME
 ;    10. ACCESION   - Accession # (free-text 1-25 characters)
 ;    11. COMM       - COMMENT (free-text 1-80 characters)
 ;    12. FASTING    - FAST/NON-FASTING  valid values:
 ;                           FASTING
 ;                           NON-FASTING
 ;    13. RRAPPTYP    - Test/App pointer to RECALL REMINDERS APPT TYPE file 403.51
 ;    14. RRPROVIEN  - Provider - Pointer to RECALL REMINDERS PROVIDERS file 403.54
 ;    15. PROVNAME   - Provider NAME of Provider in RECALL REMINDERS PROVIDERS file
 ;    16. CLINIEN    - Clinic pointer to HOSPITAL LOCATION file
 ;    17. CLINNAME   - Clinic NAME from HOSPITAL LOCATION file
 ;    18. APPTLEN    - Length of Appointment  numeric between 10 and 120
 ;    19. DATE       - Recall Date in external format (no time)
 ;    20. DATE1      - Recall Date (Per patient) in external format (no time)
 ;    21. DAPTDT     - Date Reminder Sent in external format (no time)
 ;    22. USERIEN    - User Who Entered Recall pointer to NEW PERSON file
 ;    23. USERNAME   - User Who Entered Recall NAME from NEW PERSON file
 ;    24. DATE2      - Second Print Date in external format (no time)
 ;    25. PRIGRP     - ENROLLMENT PRIORITY text from PATIENT ENROLLMENT file
 ;                      Valid Values:
 ;                       GROUP 1
 ;                       GROUP 2
 ;                       GROUP 3
 ;                       GROUP 4
 ;                       GROUP 5
 ;                       GROUP 6
 ;                       GROUP 7
 ;                       GROUP 8
 ;    26. ELIGIEN    - Pointer to MAS ELIGIBILITY CODE file 8.1
 ;    27. ELIGNAME   - NAME from MAS ELIGIBILITY CODE file
 ;    28. SVCCONN    - SERVICE CONNECTED field from PATIENT ENROLLMENT file
 ;                      Valid values:
 ;                      YES
 ;                      NO
 ;    29. SVCCONNP   - SERVICE CONNECTED PERCENTAGE field from PATIENT ENROLLMENT file
 ;                      Numeric between 0-100
 ;    30. TYPEIEN    - Pointer to TYPE OF PATIENT file 391
 ;    31. TYPENAME   - NAME from TYPE OF PATIENT file 391
 ;    32. DATE3      - DATE/TIME RECALL ADDED from RECALL REMINDERS file 403.5
 ;    33. PADDRES1   - Patient Address line 1
 ;    34. PADDRES2   - Patient Address line 2
 ;    35. PADDRES3   - Patient Address line 3
 ;    36. PCITY      - Patient City
 ;    37. PSTATE     - Patient state name
 ;    38. PCOUNTRY   - Patient country pointer to COUNTRY CODE file 779.004
 ;    39. PZIP4      - Patient Zip+4
 ;    40. GAF        - <text> | <GAF score> | <GAF date> | <diagnosis by IEN> | <diagnosis by name>
 ;    41. SENSITIVE - Sensitive Record Access data
 ;                separated by pipe |:
 ;           1. return code:
 ;              -1 -RPC/API failed
 ;                  Required variable not defined
 ;               0 -No display/action required
 ;                  Not accessing own, employee, or sensitive record
 ;               1 -Display warning message
 ;                  Sensitive and DG SENSITIVITY key holder
 ;                  or Employee and DG SECURITY OFFICER key holder
 ;               2 -Display warning message/require OK to continue
 ;                  Sensitive and not a DG SENSITIVITY key holder
 ;                  Employee and not a DG SECURITY OFFICER key holder
 ;               3 -Access to record denied
 ;                  Accessing own record
 ;               4 -Access to Patient (#2) file records denied
 ;                  SSN not defined
 ;           2. display text/message
 ;           3. display text/message
 ;           4. display text/message
 ; 42. LASTSUB - last subscripts of data in the return.
 ;               Will only be in the last record of the return.
 ;               Pass this as LASTSUB in the next call to continue
 ;               collecting data.
 ; 43. PTPHONE ? Patient Phone number ? Free-text 4-20 characters
 ; 44. PRACE  - Patient Race pointer to RACE file 10 | separates entries
 ; 45. PRACEN - Patient Race name from RACE file | separates entries
 ; 46. PETH   - Patient Ethnicity list separated by pipe |
 ;               Pointer to ETHNICITY file 10.2
 ; 47. PETHN  - Patient Ethnicity names separated by pipe |
 ; 48. PRHBLOC - Boolean indicating if location is a
 ;               Prohibit Access clinic
 ;
 ; Caught Exception Return:
 ;   A single entry in the Global Array in the format "-1^<error text>"
 ;   "T00020RETURNCODE^T00100TEXT"
 ; Unexpected Exception Return:
 ;     Handled by the RPC Broker.
 ;     M errors are trapped by the use of M and Kernel error handling.
 ;     The RPC execution stops and the RPC Broker sends the error generated
 ;     text back to the client.
 N SDDATA,SDECI,SDDEMO,SDMSG,SDTMP
 N ACCESION,APPTLEN,CLINIEN,CLINNAME,COMM,DAPTDT,DATE,DATE1,DATE2,DATE3,DOB,ELIGIEN,ELIGNAME,FASTING
 N GAF,GENDER,HRN,IEN,INSTIEN,INSTNAME,NAME,PD,PM,PRIGRP,RRAPPTYP,RRPROVNAME,PTINFO,RRPROVIEN,SSN
 N SVCCONNP,SVVCCONN,SDDFN
 N PADDRES1,PADDRES2,PADDRES3,PCITY,PSTATE,PCOUNTRY,PTPHONE,PZIP4
 N SDCNT,SDI,SDSENS,SDSUB,TYPEIEN,TYPENAME,USERIEN,USERNAME,X,Y,%DT
 S SDSUB=""
 S SDECY="^TMP(""SDEC52"","_$J_",""RECGET"")"
 K @SDECY
 S SDECI=0
 D HDR
 ;validate RECIEN (optional)
 S RECIEN=$G(RECIEN)
 I RECIEN'="" I '$D(^SD(403.5,RECIEN,0)) D ERR1^SDECERR(-1,"Invalid Recall Reminders ID.",SDECI,SDECY) Q
 I RECIEN'="" D RECIEN1 G RECX
 S SDCNT=0
 ;validate SDBEG
 S SDBEG=$G(SDBEG)
 I $G(SDBEG)'="" S %DT="" S X=$P($G(SDBEG),"@",1) D ^%DT S SDBEG=Y I Y=-1 S SDBEG=$$FMADD^XLFDT($P($$NOW^XLFDT,".",1),-1825)
 I $G(SDBEG)="" S SDBEG=$$FMADD^XLFDT($P($$NOW^XLFDT,".",1),-1825)
 ;validate SDEND (optional)
 S SDEND=$G(SDEND)
 I SDEND'="" S %DT="" S X=$P($G(SDEND),"@",1) D ^%DT S SDEND=Y I Y=-1 S SDEND=$$FMADD^XLFDT($P($$NOW^XLFDT,".",1),-90)
 I SDEND="" S SDEND=$$FMADD^XLFDT($P($$NOW^XLFDT,".",1),-90)
 ;validate SDSTOP (optional)
 S SDSTOP=$G(SDSTOP)
 ;validate DFN (optional)
 S DFN=$G(DFN)
 I DFN'="" I '$D(^DPT(DFN,0)) S DFN=""
 ;get all records for a specific patient
 I +DFN D RECGET1(DFN,,SDBEG,SDEND) G RECX
 ;get records in specified date range
 ;validate MAXREC (optional)
 S MAXREC=$G(MAXREC) I 'MAXREC S MAXREC=9999999
 ;validate LASTSUB (optional)
 S LASTSUB=$G(LASTSUB)
 D RECGETD
RECX S SDTMP=@SDECY@(SDECI) S SDTMP=$P(SDTMP,$C(30),1)
 S:$G(SDSUB)'="" $P(SDTMP,U,42)=SDSUB
 S @SDECY@(SDECI)=SDTMP_$C(30,31)
 Q
 ;
HDR ;Print out the header
 S SDTMP="T00030IEN^T00030DFN^T00030NAME^T00030HRN^T00030DOB^T00030SSN^T00030GENDER^T00030INSTIEN^T00030INSTNAME"
 S SDTMP=SDTMP_"^T00030ACCESION^T00080COMM^T00030FASTING^T00030RRAPPTYP"
 S SDTMP=SDTMP_"^T00030RRPROVIEN^T00030PROVNAME^T00030CLINIEN^T00030CLINNAME^T00030APPTLEN"
 S SDTMP=SDTMP_"^T00030DATE^T00030DATE1^T00030DAPTDT^T00030USERIEN^T00030USERNAME^T00030DATE2"
 S SDTMP=SDTMP_"^T00030PRIGRP^T00030ELIGIEN^T00030ELIGNAME^T00030SVCCONN^T00030SVCCONNP"
 S SDTMP=SDTMP_"^T00030TYPEIEN^T00030TYPENAME^T00030DATE3^T00030PADDRES1^T00030PADDRES2^T00030PADDRES3"
 S SDTMP=SDTMP_"^T00030PCITY^T00030PSTATE^T00030PCOUNTRY^T00030PZIP4^T00030GAF^T00100SENSITIVE^T00030LASTSUB^T00030PTPHONE"
 S SDTMP=SDTMP_"^T00030PRACE^T00030PRACEN^T00030PETH^T00030PETHN^T00030PRHBLOC"
 S @SDECY@(SDECI)=SDTMP_$C(30)
 Q
 ;
RECGET1(DFN,IEN,SDBEG,SDEND) ;get all recall data for 1 patient
 ; DFN = (required) patient ID pointer to PATIENT file 2
 ; IEN - (optional) recall ID pointer to RECALL REMINDERS file
 ;                  all records in date range will be return if IEN=""
 N X,Y,%DT
 ;check for valid Patient (required)
 I '$D(^DPT(+$G(DFN),0)) D ERR1^SDECERR(-1,"Invalid Patient ID",SDECI,SDECY) Q
 ;check begin date (optional)
 I $G(SDBEG)'="" S %DT="" S X=$P($G(SDBEG),"@",1) D ^%DT S SDBEG=Y I Y=-1 S SDBEG=1000101
 I $G(SDBEG)="" S SDBEG=1000101
 ;check end date (optional)
 I $G(SDEND)'="" S %DT="" S X=$P($G(SDEND),"@",1) D ^%DT S SDEND=Y I Y=-1 S SDEND=$$FMADD^XLFDT($P($$NOW^XLFDT,".",1),-90)   ;9991231
 I $G(SDEND)="" S SDEND=$$FMADD^XLFDT($P($$NOW^XLFDT,".",1),-90)   ;9991231
 ;get PATIENT data
 D RECGETP(DFN)
 ;get RECALL REMINDERS data
 S IEN=$G(IEN)
 I IEN'="" D GET1 Q
 I IEN="" F  S IEN=$O(^SD(403.5,"B",DFN,IEN)) Q:IEN=""  D GET1
 Q
 ;
RECGETD ;get recall data for date range
 I 'SDSTOP D
 .S SDI=$S($P(LASTSUB,"|",1)'="":$P(LASTSUB,"|",1)-1,1:SDBEG-1) F  S SDI=$O(^SD(403.5,"D",SDI)) Q:SDI'>0  Q:SDI>$P(SDEND,".",1)  D  I SDECI>(MAXREC-1) S SDSUB=SDI_"|"_$S(SDDFN>0:SDDFN,1:"") Q
 ..S SDDFN=$S($P(LASTSUB,"|",2)'="":$P(LASTSUB,"|",2),1:"") S LASTSUB="" F  S SDDFN=$O(^SD(403.5,"D",SDI,SDDFN)) Q:SDDFN'>0  D  Q:SDECI>(MAXREC-1)
 ...S DFN=$$GET1^DIQ(403.5,SDDFN_",",.01,"I")  D RECGET1(DFN,SDDFN,SDBEG,SDEND)
 I +SDSTOP D
 .S SDI=$S($P(LASTSUB,"|",1)'="":$P(LASTSUB,"|",1)+1,1:SDEND+1) F  S SDI=$O(^SD(403.5,"D",SDI),-1) Q:SDI'>0  Q:SDI<$P(SDBEG,".",1)  D  I SDECI>(MAXREC-1) S SDSUB=SDI_"|"_$S(SDDFN>0:SDDFN,1:"") Q
 ..S SDDFN=$S($P(LASTSUB,"|",2)'="":$P(LASTSUB,"|",2),1:999999999) S LASTSUB="" F  S SDDFN=$O(^SD(403.5,"D",SDI,SDDFN),-1) Q:SDDFN'>0  D  Q:SDECI>(MAXREC-1)
 ...S DFN=$$GET1^DIQ(403.5,SDDFN_",",.01,"I")  D RECGET1(DFN,SDDFN,SDBEG,SDEND)
 Q
RECIEN(SDECY,RECIEN) ;Get recall data for one entry
RECIEN1 ;
 ;Input is IEN to retieve data on
 N ACCESION,APPTLEN,CLINIEN,CLINNAME,COMM,DAPTDT,DATE,DATE1,DATE2,DATE3,DOB,ELIGIEN,ELIGNAME,FASTING
 N GAF,GENDER,HRN,IEN,INSTIEN,INSTNAME,NAME,PD,PM,PRIGRP,RRAPPTYP,RRPROVNAME,PTINFO,RRPROVIEN,SSN
 N SVCCONNP,SVVCCONN,SDBEG,SDEND
 N PADDRES1,PADDRES2,PADDRES3,PCITY,PSTATE,PCOUNTRY,PZIP4
 N SDCNT,SDI,SDSENS,SDSUB,TYPEIEN,TYPENAME,USERIEN,USERNAME,X,Y,%DT
 S SDSUB=""
 S SDECY="^TMP(""SDEC52"","_$J_",""RECGET"")"
 K @SDECY
 S SDECI=0
 D HDR
 S SDBEG=1000101
 S SDEND=9991231
 S DFN=$$GET1^DIQ(403.5,RECIEN_",",.01,"I")  I +DFN D
 .D RECGETP(DFN)
 .D RECGET1(DFN,RECIEN,SDBEG,SDEND)
 Q
 ;
RECGETP(DFN) ;get patient data
 ;collect demographics
 D PDEMO^SDECU2(.SDDEMO,DFN)
 S NAME=SDDEMO("NAME")
 S DOB=SDDEMO("DOB")
 S GENDER=SDDEMO("GENDER")
 S HRN=SDDEMO("HRN")
 S SSN=SDDEMO("SSN")
 S INSTIEN=SDDEMO("INSTIEN")
 S INSTNAME=SDDEMO("INSTNAME")
 S PRIGRP=SDDEMO("PRIGRP")       ;25
 S ELIGIEN=SDDEMO("ELIGIEN")     ;26
 S ELIGNAME=SDDEMO("ELIGNAME")   ;27
 S SVVCCONN=SDDEMO("SVCCONN")    ;28
 S SVCCONNP=SDDEMO("SVCCONNP")   ;29
 S TYPEIEN=SDDEMO("TYPEIEN")     ;30
 S TYPENAME=SDDEMO("TYPENAME")   ;31
 S PADDRES1=SDDEMO("PADDRES1")   ;33   - Patient Address line 1
 S PADDRES2=SDDEMO("PADDRES2")   ;34   - Patient Address line 2
 S PADDRES3=SDDEMO("PADDRES3")   ;35  - Patient Address line 3
 S PCITY=SDDEMO("PCITY")         ;36   - Patient City
 S PSTATE=SDDEMO("PSTATE")       ;37   - Patient state name
 S PCOUNTRY=SDDEMO("PCOUNTRY")   ;38   - Patient country name
 S PZIP4=SDDEMO("PZIP+4")        ;39   - Patient Zip+4
 S PTPHONE=SDDEMO("HPHONE")      ;43   - Patient Phone
 S GAF=$$GAF^SDECU2(DFN)         ;40
 S SDSENS=$$PTSEC^SDECUTL(DFN)   ;41
 Q
 ;
GET1 ;
 N PRACE,PRACEN,PETH,PETHN,PRHBLOC,PROVNAME
 K SDDATA,SDMSG
 S PRHBLOC=0
 D GETS^DIQ(403.5,IEN,"**","IE","SDDATA","SDMSG")
 S DATE=SDDATA(403.5,IEN_",",5,"I")
 Q:(DATE<SDBEG)!(DATE>SDEND)
 S ACCESION=SDDATA(403.5,IEN_",",2,"E")   ;    10. Accession # (free-text 1-25 characters)
 S COMM=SDDATA(403.5,IEN_",",2.5,"E")     ;    11. COMMENT (free-text 1-80 characters)
 S FASTING=SDDATA(403.5,IEN_",",2.6,"I")  ;    12. FASTING/NON-FASTING
 S RRAPPTYP=SDDATA(403.5,IEN_",",3,"I")   ;    13. Test/App pointer to RECALL REMINDERS APPT TYPE file 403.51
 S RRPROVIEN=SDDATA(403.5,IEN_",",4,"I")  ;    14. Pointer to RECALL REMINDERS PROVIDERS file 403.54
 S PROVNAME=SDDATA(403.5,IEN_",",4,"E")   ;    15. Provider NAME of Provider in RECALL REMINDERS PROVIDERS file
 S CLINIEN=SDDATA(403.5,IEN_",",4.5,"I")  ;    16. Clinic pointer to HOSPITAL LOCATION file
 S CLINNAME=SDDATA(403.5,IEN_",",4.5,"E") ;    17. Clinic NAME from HOSPITAL LOCATION file
 I CLINIEN'="",$$GET1^DIQ(44,CLINIEN_",",50.01,"I")=1 Q   ;check OOS?
 S:CLINIEN'="" PRHBLOC=$S($$GET1^DIQ(44,+CLINIEN_",",2500,"I")="Y":1,1:0)
 S APPTLEN=SDDATA(403.5,IEN_",",4.7,"E")  ;    18. Length of Appointment  numeric between 10 and 120
 S DATE=SDDATA(403.5,IEN_",",5,"I") S DATE=$$FMTE^XLFDT(DATE)           ;19. Recall Date in external format (no time)
 S DATE1=SDDATA(403.5,IEN_",",5.5,"I") S DATE1=$$FMTE^XLFDT(DATE1)      ;20. Recall Date (Per patient) in external format (no time)
 S DAPTDT=SDDATA(403.5,IEN_",",6,"I") S DAPTDT=$$FMTE^XLFDT(DAPTDT)     ;21. Date Reminder Sent in external format (no time)
 S USERIEN=SDDATA(403.5,IEN_",",7,"I")    ;    22. User Who Entered Recall pointer to NEW PERSON file
 S USERNAME=SDDATA(403.5,IEN_",",7,"E")   ;    23. User Who Entered Recall NAME from NEW PERSON file
 S DATE3=SDDATA(403.5,IEN_",",7.5,"E")     ;    32. DATE/TIME RECALL ADDED
 S:DATE3="" DATE3=DATE
 S DATE2=SDDATA(403.5,IEN_",",8,"I") S DATE2=$$FMTE^XLFDT(DATE2)        ;24. Second Print Date in external format (no time)
 D RACELST^SDECU2(DFN,.PRACE,.PRACEN)
 D ETH^SDECU2(DFN,.PETH,.PETHN)   ;get ethnicity
 S SDTMP=IEN_U_DFN_U_NAME_U_HRN_U_DOB_U_SSN_U_GENDER_U_INSTIEN_U_INSTNAME      ; 9
 S SDTMP=SDTMP_U_ACCESION_U_COMM_U_FASTING_U_RRAPPTYP                          ;13
 S SDTMP=SDTMP_U_RRPROVIEN_U_PROVNAME_U_CLINIEN_U_CLINNAME_U_APPTLEN           ;18
 S SDTMP=SDTMP_U_DATE_U_DATE1_U_DAPTDT_U_USERIEN_U_USERNAME_U_DATE2            ;24
 S SDTMP=SDTMP_U_PRIGRP_U_ELIGIEN_U_ELIGNAME_U_SVVCCONN_U_SVCCONNP             ;29
 S SDTMP=SDTMP_U_TYPEIEN_U_TYPENAME_U_DATE3_U_PADDRES1_U_PADDRES2_U_PADDRES3   ;35
 S SDTMP=SDTMP_U_PCITY_U_PSTATE_U_PCOUNTRY_U_PZIP4_U_GAF_U_SDSENS              ;41
 S SDTMP=SDTMP_U_U_PTPHONE_U_PRACE_U_PRACEN_U_PETH_U_PETHN_U_PRHBLOC           ;47
 S SDECI=SDECI+1 S @SDECY@(SDECI)=SDTMP_$C(30)
 Q
