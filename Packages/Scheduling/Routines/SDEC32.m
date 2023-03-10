SDEC32 ;ALB/SAT,DMR - VISTA SCHEDULING RPCS ;JUL 26, 2017
 ;;5.3;Scheduling;**627,643,642,658,665,672,679,781,796,797**;Aug 13, 1993;Build 8
 ;;Per VHA Directive 6402, this routine should not be modified
 Q
 ;
 ;
ERROR ;
 D ERR("VistA Error")
 Q
 ;
ERR(SDECERR) ;Error processing
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
 ;
HOSPLOC(SDECY,SDECP,MAXREC,LSUB) ;return HOSPITAL LOCATIONs
 ;HOSPLOC(SDECY)  external parameter tag is in SDEC
 ;INPUT:
 ;  SDECP  - (optional) Partial name text
 ;  MAXREC - (optional) Max number of records to return
 ;  LSUB   - (optional) subscripts from last call to pick up where left off
 ;RETURN:
 ;Global Array in which each array entry
 ;contains HOSPITAL LOCATION data separated by ^:
 ; 1. HOSPITAL_LOCATION_ID
 ; 2. HOSPITAL_LOCATION
 ; 3. DEFAULT_PROVIDER
 ; 4. STOP_CODE_NUMBER
 ; 5. INACTIVATE_DATE
 ; 6. REACTIVATE_DATE
 ; 7. LASTSUB
 N SDECI,SDECIEN,SDECNOD,SDECNOD1,SDECNAM,SDECINA,SDECREA,SDECSCOD
 N SDECIEN1,SDECPRV,SDDUP,SDNAM
 N LASTSUB,X
 K ^TMP("SDEC",$J)
 S SDECY="^TMP(""SDEC"","_$J_")"
 S SDECI=0
 S ^TMP("SDEC",$J,SDECI)="I00020HOSPITAL_LOCATION_ID^T00040HOSPITAL_LOCATION^T00030DEFAULT_PROVIDER^T00030STOP_CODE_NUMBER^D00020INACTIVATE_DATE^D00020REACTIVATE_DATE^T00030LASTSUB"_$C(30)
 ;
 S SDECP=$G(SDECP)
 S MAXREC=+$G(MAXREC)
 S LSUB=$G(LSUB)
 S:LSUB="" SDECNAM=$S(SDECP'="":$$GETSUB^SDEC56(SDECP),1:"")
 S:LSUB'="" SDECNAM=$$GETSUB^SDEC56($P(LSUB,"|",1))
 F  S SDECNAM=$O(^SC("B",SDECNAM)) Q:(SDECP'="")&(SDECNAM'[SDECP)  Q:SDECNAM=""  D  Q:(+MAXREC)&(SDECI'<MAXREC)
 . S SDECIEN=$S(LSUB'="":$P(LSUB,"|",2),1:0) S LSUB="" F  S SDECIEN=$O(^SC("B",SDECNAM,SDECIEN)) Q:SDECIEN'>0  D  Q:(+MAXREC)&(SDECI'<MAXREC)
 .. Q:'+SDECIEN>0
 .. Q:'$D(^SC(+SDECIEN,0))
 .. Q:$$INACTIVE(+SDECIEN)
 .. Q:+$$GET1^DIQ(44,SDECIEN_",",50.01,"I")=1  ;OOS?
 .. S SDECINA=$$GET1^DIQ(44,SDECIEN_",",2505) ;INACTIVATE
 .. S SDECREA=$$GET1^DIQ(44,SDECIEN_",",2506) ;REACTIVATE
 .. S SDECNOD=^SC(SDECIEN,0)
 .. Q:$D(SDDUP(+SDECIEN))
 .. S SDDUP(+SDECIEN)=""
 .. S SDNAM=$P(SDECNOD,U)
 .. S SDECSCOD=$$GET1^DIQ(44,SDECIEN_",",8) ;STOP CODE
 .. ;Calculate default provider
 .. S SDECPRV=""
 .. I $D(^SC(SDECIEN,"PR")) D
 ... S SDECIEN1=0 F  S SDECIEN1=$O(^SC(SDECIEN,"PR",SDECIEN1)) Q:'+SDECIEN1  Q:SDECPRV]""  D
 .... S SDECNOD1=$G(^SC(SDECIEN,"PR",SDECIEN1,0))
 .... S:$P(SDECNOD1,U,2)="1" SDECPRV=$$GET1^DIQ(200,$P(SDECNOD1,U),.01)
 .... Q
 ... Q
 .. S LASTSUB=SDECNAM_"|"_SDECIEN
 .. S SDECI=SDECI+1
 .. S ^TMP("SDEC",$J,SDECI)=SDECIEN_U_SDNAM_U_SDECPRV_U_SDECSCOD_U_SDECINA_U_SDECREA_U_LASTSUB_$C(30)
 .. Q
 I SDECNAM="",SDECIEN="" S $P(^TMP("SDEC",$J,SDECI),U,7)=""  ;clear lastsub for last entry if finished
 S ^TMP("SDEC",$J,SDECI)=^TMP("SDEC",$J,SDECI)_$C(31)
 K SDDUP
 Q
 ;
CLINSET(SDECY,SDNOSLOT,SDIENS,SDECP,SDNOLET,MAXREC) ;Returns CLINIC SETUP PARAMETERS for clinics that are active in the HOSPITAL LOCATION file
 ;CLINSET(SDECY,SDNOSLOT,SDIENS,SDECP,SDNOLET)  external parameter tag is in SDEC
 ;INPUT:
 ; SDNOSLOT - no slots flag - 0=return availability  1=do not return availability
 ; SDIENS - IENs for individual hospital locations separated by pipes
 ; SDNOLET - flag to include clinics with no Recall Letter defined
 ;            in RECALL REMINDERS LETTERS file
 ;             0 = yes (include all clinics including those with no Recall Letter
 ;                     defined)  [default]
 ;             1 = no (only return clinics with a Recall Letter
 ;                    defined)
 ;Returns CLINIC SETUP PARAMETERS file entries for clinics which
 ;are active in ^SC (#44)
 ;MGH Added SDIENS as input parameter to for hospital location IENs
 ;MGH Added SDECP for partial name lookup
 ;RETURN
 ; Global Array in which each array entry contains the following Clinic data separated by ^:
 ; 1. HOSPITAL_LOCATION_ID
 ; 2. HOSPITAL_LOCATION
 ; 3. CREATE_VISIT
 ; 4. VISIT_SERVICE_CATEGORY
 ; 5. MULTIPLE_CLINIC_CODES_USED?
 ; 6. VISIT_PROVIDER_REQUIRED
 ; 7. GENERATE_PCCPLUS_FORMS?
 ; 8. MAX_OVERBOOKS
 ; 9. SDECDAT
 ;10. SDECDATN
 ;11. APPTLEN              - 1912   Appointment Length Numeric 10-240
 ;12. VAPPTLEN
 ;13. SLOTS
 ;14. PRIVUSERPRESENT_BOOL
 ;15. PROTECTED
 ;16. HOUR_DISPLAY_BEGIN   - 1914   Hour Clinic Display Begins
 ;17. DISPLAY_INCREMENTS   - 1917   Display increments per hour
 ;                                  1=60-MIN
 ;                                  2=30-MIN
 ;                                  4=15-MIN
 ;                                  3=20-MIN
 ;                                  6=10-MIN
 ;18. HOLIDAYS             - 1918.5 Schedule on Holidays?  Y=YES
 ;19. SPECIAL              - 1910 SPECIAL INSTRUCTIONS separated by $C(13,10)
 ;20. CLINIC_STOP          - 8 Stop code Number pointer to CLINIC STOP in file 40.7
 ;21. ABBREVIATION         - 1 Abbrevation
 ;22. not used ??
 ;23. DEFAULT_VIEW         - Scheduling default view
 ;24. VVC Indicator        - Inicator if this clinic is considered a VVC clinic (1=Yes 0=No)
 N SDA,SDAPLEN,SDAR,SDDATA,SDF,SDFIELDS,SDI,SDJ,SDK,SDSLOTS,SDVAPL,SDECI,SDECIEN,SDECNOD,SDECNAM,SDECINA,SDECREA,SDTMP  ;alb/sat 665 - add SDF
 N SDECCRV,SDECDAT,SDECDATN,SDECVSC,SDECMULT,SDECREQ,SDECPCC,SDECMOB,SDECHPRV,SDECPROT,SDECNAM,SDCNT,SDL,SDMAX          ;alb/sat 665 - add vars
 N SDARR1,SDREF,SDXT,SDV   ;alb/sat 672
 K ^TMP("SDEC",$J)
 S (SDCNT,SDMAX)=0
 S SDF=""
 S SDV=""   ;alb/sat 672
 S SDECY="^TMP(""SDEC"","_$J_")"
 S SDECI=0
 ;              1                          2                       3                  4
 S SDTMP="I00020HOSPITAL_LOCATION_ID^T00040HOSPITAL_LOCATION^T00030CREATE_VISIT^T00030VISIT_SERVICE_CATEGORY"
 ;                     5                                 6                             7
 S SDTMP=SDTMP_"^T00030MULTIPLE_CLINIC_CODES_USED?^T00030VISIT_PROVIDER_REQUIRED^T00030GENERATE_PCCPLUS_FORMS?"
 ;                     8                   9             10             11            12             13             14
 S SDTMP=SDTMP_"^T00030MAX_OVERBOOKS^T00030SDECDAT^T00030SDECDATN^T00030APPTLEN^T00030VAPPTLEN^T00030SLOTS^B00001PRIVUSERPRESENT_BOOL"
 ;                     15              16                       17                       18
 S SDTMP=SDTMP_"^B00001PROTECTED^T00030HOUR_DISPLAY_BEGIN^T00030DISPLAY_INCREMENTS^T00030HOLIDAYS^T00030SPECIAL^T00030CLINIC_STOP"
 ;                     21         22         23
 S SDTMP=SDTMP_"^T00030ABBR^T00030MORE^T00030DEFAULT_VIEW"   ;alb/sat 672 - add DEFAULT_VIEW
 ;                     24
 S SDTMP=SDTMP_"^T00030VVC_CLINIC"   ;  VVC_Indicator
 S ^TMP("SDEC",$J,SDECI)=SDTMP_$C(30)
 ;
 S (SDECDAT,SDECDATN)=""
 S SDNOSLOT=$G(SDNOSLOT)
 S SDNOLET=$G(SDNOLET)
 S MAXREC=$G(MAXREC,50)
 ;MGH change made for individual locations
 I $G(SDIENS) D
 .F SDK=1:1:$L(SDIENS,"|") D
 ..S SDECIEN=$P(SDIENS,"|",SDK)
 ..D PROCESS(SDECIEN)
 ;MGH change made for partial name lookup
 I $G(SDECP)'="" D
 .;alb/sat 672 - begin modification; separate string and numeric lookup
 .S (SDECNAM,SDXT)=$$GETSUB^SDECU(SDECP)
 .;abbreviation as string
 .S SDF="ABBRSTR" D
 ..S SDREF="C" D PART Q
 .;abbreviation as numeric
 .S SDF="ABBRNUM",SDECNAM=SDXT_" " D
 ..S SDREF="C" D PART Q
 .;name as string
 .S SDF="FULLSTR",SDECNAM=SDXT D
 ..S SDREF="B" D PART Q
 .;name as numeric
 .S SDF="FULLNUM",SDECNAM=SDXT_" " D
 ..S SDREF="B" D PART Q
 .;alb/sat 672 - end modification; separate string and numeric lookup
 I $G(SDIENS)=""&($G(SDECP)="") S SDECIEN=0 F  S SDECIEN=$O(^SC(SDECIEN)) Q:SDECIEN'>0  D
 .D PROCESS(SDECIEN)
 S SDL=-1 F  S SDL=$O(SDAR(SDL)) Q:SDL=""  D
 .S SDI="" F  S SDI=$O(SDAR(SDL,SDI)) Q:SDI=""  D
 ..S SDJ="" F  S SDJ=$O(SDAR(SDL,SDI,SDJ)) Q:SDJ=""  D
 ...S SDTMP=SDAR(SDL,SDI,SDJ)
 ...S $P(SDTMP,U,22)=$S(+SDMAX:1,1:0)
 ...S SDECI=SDECI+1
 ...S ^TMP("SDEC",$J,SDECI)=SDTMP_$C(30)
 S ^TMP("SDEC",$J,SDECI)=^TMP("SDEC",$J,SDECI)_$C(31)
 Q
PART  ;partial name lookup  ;alb/sat 672
 Q:SDREF=""
 F  S SDECNAM=$O(^SC(SDREF,SDECNAM)) Q:SDECNAM'[SDECP  D  I SDCNT'<MAXREC S SDECNAM=$O(^SC(SDREF,SDECNAM)) S SDMAX=$S(+SDMAX:1,SDECNAM[SDECP:1,1:0) Q   ;alb/sat 658 - abbreviation lookup if characters length 7 or less
 .S SDECIEN=0 F  S SDECIEN=$O(^SC(SDREF,SDECNAM,SDECIEN)) Q:SDECIEN=""  D PROCESS(SDECIEN) I SDCNT'<MAXREC S SDMAX=+$O(^SC(SDREF,SDECNAM,SDECIEN)) Q  ;alb/sat 665 loop thru all entries
 Q
PROCESS(SDECIEN) ;Process an individual clinic
 ;MGH broke this out to do all locations or individual ones
 N SDECABR,SDECNAM,SDI,SDI1,SDDI,SDH,SDHDB,SDSP,SDSTOP
 N SDVVC,SDCRSTOP
 Q:'$D(^SC(+SDECIEN,0))
 ;Q:$$INACTIVE(+SDECIEN) ;SD,796
 I SDNOLET,'$O(^SD(403.52,"B",+SDECIEN,0)) Q
 D RESCLIN1^SDEC01B(SDECIEN)
 S SDSLOTS=""
 K SDDATA,SDMSG
 S SDFIELDS=".01;1;2;8;50.01;1912;1913;1914;1917;1918;1918.5"_$S(SDNOSLOT:"",1:";1920*")_";2503;2505;2506;2507"  ;alb/sat 665 - add abbreviation
 D GETS^DIQ(44,SDECIEN_",",SDFIELDS,"IE","SDDATA","SDMSG")
 Q:$G(SDDATA(44,SDECIEN_",",2,"I"))'="C"
 Q:+$G(SDDATA(44,SDECIEN_",",50.01,"I"))=1  ;OOS?
 Q:$D(SDARR1(SDECIEN))  ;alb/sat 672 - checking for duplicates
 S SDARR1(SDECIEN)=""   ;alb/sat 672 - checking for duplicates
 S SDA="SDDATA(44,"""_SDECIEN_","")"
 S SDAPLEN=@SDA@(1912,"E")    ;length of appointment
 S SDVAPL=@SDA@(1913,"I")     ;variable appointment length V means yes
 S SDHDB=@SDA@(1914,"E")      ;hour clinic display begins
 S:SDHDB="" SDHDB=8
 S SDDI=@SDA@(1917,"I")       ;display increments per hour
 S SDECINA=@SDA@(2505,"E") ;INACTIVATE
 S SDECREA=@SDA@(2506,"E") ;REACTIVATE
 S SDECDAT=@SDA@(2507,"I") ;DEFAULT APPOINTMENT TYPE ien
 S SDECDATN=@SDA@(2507,"E") ;DEFAULT APPOINTMENT TYPE name
 S SDSTOP=@SDA@(8,"I")      ;STOP CODE NUMBER
 S SDECNAM=@SDA@(.01,"E")
 S SDECABR=@SDA@(1,"E")  ;alb/sat 665
 S SDECNAM=$S((SDF["ABBR")&(@SDA@(1,"E")'=""):@SDA@(1,"E")_" ",1:"")_SDECNAM  ;alb/sat 665 - include abbr in name if found by C xref
 S SDECMOB=@SDA@(1918,"E")
 S SDH=@SDA@(1918.5,"I")
 S SDECCRV=1  ;$$GET1^DIQ(9009017.2,SDECIEN_",",.09)   ;Create Visit at Check-In?
 S SDECVSC=""  ;$$GET1^DIQ(9009017.2,SDECIEN_",",.12)   ;Visit Service Category
 S SDECMULT=1 ;$$GET1^DIQ(9009017.2,SDECIEN_",",.13)  ;Multiple Clinic codes used?
 S SDECREQ=1  ;$$GET1^DIQ(9009017.2,SDECIEN_",",.14)   ;Visit Provider Required
 S SDECPCC=0  ;$$GET1^DIQ(9009017.2,SDECIEN_",",.15)   ;Generate PCCPlus Forms?
 S:'SDNOSLOT SDSLOTS=$$GETSLOTS(.SDDATA)
 S SDECHPRV=$O(^SC(+SDECIEN,"SDPRIV",0))>0
 S SDECPROT=$G(^SC(+SDECIEN,"SDPROT"))="Y"
 S SDSP="" S SDI=0 F  S SDI=$O(^SC(+SDECIEN,"SI",SDI)) Q:SDI'>0  S SDI1=$G(^SC(+SDECIEN,"SI",SDI,0)) S:SDI1'="" SDSP=$S(SDSP'="":SDSP_$C(13,10),1:"")_SDI1
 S:SDECNAM'="" SDV=$$GET^XPAR("PKG.SCHEDULING","SDEC VS GUI CLINIC VIEW",SDECNAM,"B")   ;alb/sat 672
 S SDV=$S(SDV'="":$P(SDV,U,1),1:"W")  ;alb/sat 672
 S SDVVC=0
 S SDCRSTOP=@SDA@(2503,"I")      ;CREDIT STOP CODE NUMBER
 I SDSTOP S SDVVC=$$VVCSTPCD(SDSTOP)
 I 'SDVVC,SDCRSTOP S SDVVC=$$VVCSTPCD(SDCRSTOP)
 ;       1         2         3         4         5          6         7         8
 S SDTMP=SDECIEN_U_SDECNAM_U_SDECCRV_U_SDECVSC_U_SDECMULT_U_SDECREQ_U_SDECPCC_U_SDECMOB
 ;               9         10         11        12           13       14         15
 S SDTMP=SDTMP_U_SDECDAT_U_SDECDATN_U_+SDAPLEN_U_SDVAPL_U_SDSLOTS_U_SDECHPRV_U_SDECPROT
 ;               16      17     18    19     20       21       22 23
 S SDTMP=SDTMP_U_SDHDB_U_SDDI_U_SDH_U_SDSP_U_SDSTOP_U_SDECABR_U_U_SDV    ;alb/sat 672 - add SDV
 ;               24
 S SDTMP=SDTMP_U_SDVVC    ; ??? - add SDVVC
 S SDAR(SDF["FULL",SDECNAM,SDECIEN)=SDTMP
 S SDCNT=SDCNT+1
 Q
CHK(SDECP,SDECIEN)  ;alb/sat 665 - stop if 'this' record found in abbreviations  ;alb/sat 672 - removed
 Q
 N FND,SDR,SDX
 S FND=0
 S SDX=$$GETSUB^SDEC56(SDECP)
 F  S SDX=$O(^SC("C",SDX)) Q:SDX=""  Q:SDX'[SDECP  D  Q:+FND
 .S SDR=0 F  S SDR=$O(^SC("C",SDX,SDR)) Q:'+SDR  S FND=SDR=SDECIEN  Q:+FND
 Q FND
 ;
 ;
GETSLOTS(SDDATA) ;get slots - NUMBER OF PATIENTS in the AVAILABILITY multiple of file 44
 ;INPUT:
 ; SDDATA - array from GETS^DIQ against file 44 above to collect timeslots from
 N SDI,SDDT,SDSLOTS
 S SDSLOTS=""
 S SDI="" F  S SDI=$O(SDDATA(44.004,SDI)) Q:SDI=""  D
 .S SDDT=$P(SDI,",",2)                        ;get date
 .S SDDT=SDDT_"."_SDDATA(44.004,SDI,.01,"I")  ;get time
 .S SDDT=$$FMTE^XLFDT(SDDT)
 .S SDSLOTS=$S(SDSLOTS'="":SDSLOTS_"|",1:"")_SDDT_";;"_SDDATA(44.004,SDI,1,"E")
 Q SDSLOTS
 ;
INACTIVE(SDCL,SDDT) ;determine if clinic is active
 ; X=0=ACTIVE
 ; X=1=INACTIVE
 N SDNODI,N21,N25,X
 S SDDT=$G(SDDT) I SDDT="" S SDDT=DT
 S SDDT=$P(SDDT,".",1)
 S X=1
 S SDNODI=$G(^SC(SDCL,"I"))
 Q:SDNODI="" 0
 S N21=$P(SDNODI,U,1)   ;inactive date/time
 S N25=$P(SDNODI,U,2)   ;reactive date/time
 I (N21="") S X=0 Q X
 I (N21'="")&(N21>SDDT) S X=0 Q X
 I (N25'="")&(N25'>SDDT) S X=0 Q X
 Q X
 ;
PRIV(SDECY,CLINIEN,USER) ;IS this USER in the PRIVILEGED USER multiple for the clinic
 ;INPUT:
 ;  CLINIEN - pointer to HOSPITAL LOCATION file 44
 ;  USER    - pointer to NEW PERSON file 200
 ;RETURN:
 ;  A single boolean entry indicating that the USER is a PRIVILEGED USER for the clinic.
 ;    RETURNCODE - 0=NO; 1=YES; -1=error
 ;    MESSAGE
 N SDRET
 S SDECY="^TMP(""SDEC32"","_$J_",""PRIV"")"
 K @SDECY
 S @SDECY@(0)="T00030RETURNCODE^MESSAGE"_$C(30)
 S CLINIEN=$G(CLINIEN)
 I (CLINIEN="")!('$D(^SC(CLINIEN,0))) S @SDECY@(1)="-1^Invalid clinic ID."_$C(30,31) Q
 S USER=$G(USER)
 I (USER="")!('$D(^VA(200,USER,0))) S @SDECY@(1)="-1^Invalid user ID."_$C(30,31) Q
 S SDRET=$D(^SC(CLINIEN,"SDPRIV",USER,0))
 S $P(SDRET,U,2)=$S(SDRET=1:"YES",1:"NO")
 S @SDECY@(1)=SDRET_$C(30,31)
 Q
 ;
BOOKHLDY(SDECY,SDECCL) ;  Returns can book on holiday flag for a clinic.  12/1/17 wtc  679 
 ;
 ;  Returns value of field 1918.5 in file #44
 ;
 ;  SDECY  = return value
 ;  SDECCL = pointer to file #44
 ;
 S SDECY="" ;
 Q:$G(SDECCL)=""  ;
 S SDECY=$P($G(^SC(SDECCL,"SL")),"^",8) ;
 Q  ;
 ;
VVCSTPCD(STOPCD) ;
 ; Called from PROCES tag above
 ;
 ;Input:
 ; STOPCD - a stop code
 ;
 ;Return:
 ; 1 = Stop code is found in the SDEC SETTING file (#409.98) field 7 VVC STOP CODE
 Q:'$G(STOPCD)
 N RETURN,STOP
 ;
 S RETURN=0
 S STOP="" S STOP=$$GET1^DIQ(40.7,STOPCD,1)
 I STOP>0 D
 .I $D(^SDEC(409.98,1,3,"B",STOP)) S RETURN=1
 Q RETURN
