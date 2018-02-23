SDEC01A ;ALB/SAT - VISTA SCHEDULING RPCS ;JUL 26, 2017
 ;;5.3;Scheduling;**627,642,658,665,672**;Aug 13, 1993;Build 9
 ;
 Q
 ;
RESOURCE(SDECY,SDECDUZ,SDACT,SDTYPE,MAXREC,LASTSUBI,SDIEN,SDECP) ;Returns ADO Recordset with ALL RESOURCE names
 ;   SDECDUZ = (optional) pointer to NEW PERSON file
 ;                       Defaults to current user
 ;                       checks that overbook is allowed
 ;   SDACT   = (optional) 1 or YES will return only active resources
 ;                       0, NO, or null will include inactive
 ;   SDTYPE    = (optional) null will return all resource types
 ;            H will only return HOSPITAL LOCATION (clinic) resources
 ;            P will only return NEW PERSON (Provider) resources
 ;            A will only return SDEC ADDITIONAL RESOURCE resources
 ;            PH will only return prohibited clinics
 ;   MAXREC   - (optional) Max records returned
 ;   LASTSUBI - (optional) last subscripts from previous call
 ;   SDIEN    - (optional) pointer to SDEC RESOURCE file
 ;                         only 1 record will be returned if SDIEN is present
 ;   SDECP  - (optional) Partial name text
 ;RETURN:
 ;  Successful Return:
 ;   a global array in which each array entry contains data from the
 ;      SDEC RESOURCE file
 ;   1. RESOURCEID - Pointer to the SDEC RESOURCE file
 ;   2. RESOURCE_NAME - NAME from SDEC RESOURCE file
 ;   3. INACTIVE   - inactive Clinic - Returned values will be NO YES
 ;   4. TIMESCALE - Valid Values:
 ;                    5, 10, 15, 20, 30, 60
 ;   5. HOSPITAL_LOCATION_ID
 ;   6. <NOT USED> LETTER_TEXT
 ;   7. <NOT USED> NO_SHOW_LETTER
 ;   8. <NOT USED> CLINIC_CANCELLATION_LETTER
 ;   9. VIEW - User can VIEW 1=YES; 0=NO
 ;  10. OVERBOOK - User can OVERBOOK  1=YES; 0=NO
 ;  11. MODIFY_SCHEDULE - User can Modify Schedule  1=YES; 0=NO
 ;  12. MODIFY_APPOINTMENTS User can modify appointments  1=YES; 0=NO
 ;  13. RESOURCETYPE - 3 pipe pieces:
 ;          1. type H, P, or A
 ;          2. IEN - pointer to [H] HOSPITAL LOCATION, [P] NEW PERSON,
 ;                   or [A] SDEC ADDITIONAL RESOURCE file
 ;          3. Name - name from the appropriate type file
 ;  14. DATE      - Date/Time entered in external format
 ;  15. USERIEN   - Entered By User ID pointer to NEW PERSON file 200
 ;  16. USERNAME  - Entered By User name from NEW PERSON file
 ;  17. DATE1     - Inactive Date/Time in external format
 ;  18. USERIEN1  - Inactivating User ID pointer to NEW PERSON file
 ;  19. USERNAME1 - Inactivating User Name from NEW PERSON file
 ;  20. DATE2     - Reactivated Date/Time in external format
 ;  21. USERIEN2  - Reactivating User ID pointer to NEW PERSON file
 ;  22. USERNAME2 - Reactivating User Name from NEW PERSON file
 ;  23. CLINNAME  - Clinic Name from HOSPITAL LOCATION file 44
 ;  24. PROVCLIN  - Boolean indicating 'this' P type resource is a provider for a clinic
 ;                  0  = not a provider (not found in the AVADPR index for file 44)
 ;                  1  = is a provider
 ;  25. PRIVLOC   - Boolean indicating presence of privileged users for hospital location
 ;  26. PRHBLOC   - Boolean indicating if location is a Prohibit Access clinic
 ;  27. LASTSUB   - Last subscript in return data. Used in next call to
 ;                  SDEC RESOURCE to get additional records
 ;  28. ABBR      - Abbreviation
 ;
 ;
 N SDA,SDCL,SDDATA,SDMSG,SDECERR,SDECRET,SDECIEN,SDECRES,SDECDEP,SDECDDR,SDECDEPN,SDECRDAT,SDECRNOD,SDECI,SDEC,SDECLTR
 N ABBR,SDECNOS,SDECCAN,SDF,SDTYPR,SDX,SDPRO,PRO,SDH,SDK,SDRT,SDT,SDXT
 N SDARR,SDARR1,SDCNT,SDMORE,SDNAM,SDREF          ;alb/sat 665  ;alb/sat 672 add SDARR1,SDREF
 N SDVW  ;alb/sat 672
 S (SDRT,SDT,SDX)="",SDPRO=0
 S (SDCNT,SDF,SDMORE)=0
 S SDVW=""  ;alb/sat 672
 S SDECY="^TMP(""SDEC01A"","_$J_",""RESOURCE"")"
 K @SDECY
 S SDECI=0
 S (SDECERR,SDTYPR)=""
 ;                       1                2                   3              4               5                          6                 7
 S @SDECY@(SDECI)="I00010RESOURCEID^T00030RESOURCE_NAME^T00010INACTIVE^I00010TIMESCALE^I00010HOSPITAL_LOCATION_ID^T00030LETTER_TEXT^T00030NO_SHOW_LETTER"
 ;                                 8                                9          10             11                    12
 S @SDECY@(SDECI)=^(SDECI)_"^T00030CLINIC_CANCELLATION_LETTER^I00010VIEW^I00010OVERBOOK^I00010MODIFY_SCHEDULE^I00010MODIFY_APPOINTMENTS"
 ;                                 13                 14         15            16
 S @SDECY@(SDECI)=^(SDECI)_"^T00030RESOURCETYPE^T00030DATE^T00030USERIEN^T00030USERNAME"
 ;                                 17          18             19              20          21             22
 S @SDECY@(SDECI)=^(SDECI)_"^T00030DATE1^T00030USERIEN1^T00030USERNAME1^T00030DATE2^T00030USERIEN2^T00030USERNAME2"
 ;                                 23             24           25              26            27
 S @SDECY@(SDECI)=^(SDECI)_"^T00030CLINNAME^T00030PROVCLIN^T00030PRIVLOC^T00030PRHBLOC^T00030LASTSUB^T00030ABBR"
 S @SDECY@(SDECI)=^(SDECI)_"^T00030DEFAULT_VIEW"_$C(30)  ;alb/sat 672 - add DEFAULT_VIEW
 ;validate user
 S SDECDUZ=$G(SDECDUZ)
 I '+SDECDUZ S SDECDUZ=DUZ
 ;validate active
 S SDACT=$G(SDACT)
 S SDACT=$S(SDACT=1:1,SDACT="YES":1,1:0)
 ;validate type
 S SDTYPE=$G(SDTYPE)
 ;MGH added new type
 I SDTYPE="PH" S SDPRO=1
 S SDTYPE=$S(SDTYPE="H":"SC(",SDTYPE="P":"VA(200",SDTYPE="A":"SDEC",1:"")
 ;validate MAXREC
 S MAXREC=$G(MAXREC,9999999)
 ;validate LASTSUBI
 S LASTSUBI=$G(LASTSUBI)
 ;validate SDIEN
 ;MGH changed to allow multiple IENS
 ;S SDIEN=$G(SDIEN)
 ;I SDIEN'="",'$D(^SDEC(409.831,+SDIEN,0)) S SDIEN=""
 I $G(SDIEN) D  G RESX
 .F SDK=1:1:$L(SDIEN,"|") D
 ..S SDECIEN=$P(SDIEN,"|",SDK)
 ..Q:'$D(^SDEC(409.831,+SDECIEN,0))
 ..S SDECRES=SDECIEN
 ..D RES1
 ;ien lookup
 ;I +SDIEN S SDECRES=+SDIEN D RES1 G RESX
 ;validate SDECP
 S SDECP=$G(SDECP)
 ;partial name lookup
 I SDECP'="" D
 .S SDF=$S($P(LASTSUBI,"|",1)'="":$P(LASTSUBI,"|",1),1:"")
 .;alb/sat 672 - begin modification; separate string and numeric lookup
 .S (SDX,SDXT)=$S($P(LASTSUBI,"|",2)'="":$$GETSUB^SDECU($P(LASTSUBI,"|",2)),1:$$GETSUB^SDECU(SDECP))
 .;abbreviation as string
 .I ($P(LASTSUBI,"|",1)="")!($P(LASTSUBI,"|",1)="ABBRSTR") S SDF="ABBRSTR" D
 ..S SDREF="C" D PART Q
 .;abbreviation as numeric
 .I ($P(LASTSUBI,"|",1)="")!($P(LASTSUBI,"|",1)="ABBRNUM"),(+SDXT=SDXT) S SDF="ABBRNUM",SDX=SDXT_" " D
 ..S SDREF="C" D PART Q
 .;name as string
 .I ($P(LASTSUBI,"|",1)="")!($P(LASTSUBI,"|",1)="FULLSTR") S SDF="FULLSTR",SDX=SDXT D
 ..S SDREF="B" D PART Q
 .;name as numeric
 .I ($P(LASTSUBI,"|",1)="")!($P(LASTSUBI,"|",1)="FULLNUM"),(+SDXT=SDXT) S SDF="FULLNUM",SDX=SDXT_" " D
 ..S SDREF="B" D PART Q
 .;alb/sat 672 - end modification; separate string and numeric lookup
 ;$O THRU SDEC RESOURCE File
 I SDECP="",'+SDIEN S SDECRES=$S($P(LASTSUBI,"|",2)'="":$P(LASTSUBI,"|",2),1:0) F  S SDECRES=$O(^SDEC(409.831,SDECRES)) Q:'+SDECRES  D  I (+MAXREC)&(SDCNT'<MAXREC) S SDECRES=$O(^SDEC(409.831,SDECRES)) S SDMORE=$S(+SDECRES:1,1:0) Q
 .D RES1
RESX ;
 S SDF=-1 F  S SDF=$O(SDARR(SDF)) Q:SDF=""  D
 .S SDNAM="" F  S SDNAM=$O(SDARR(SDF,SDNAM)) Q:SDNAM=""  D
 ..S SDECI=SDECI+1 S @SDECY@(SDECI)=SDARR(SDF,SDNAM)_$C(30)
 I SDECI>0,'+SDMORE S $P(@SDECY@(SDECI),U,27)=""
 S @SDECY@(SDECI)=@SDECY@(SDECI)_$C(31)
 Q
PART  ;partial name lookup  ;alb/sat 672
 Q:SDREF=""
 F  S SDX=$O(^SDEC(409.831,SDREF,SDX)) Q:SDX=""  Q:SDX'[SDECP  D  I (+MAXREC)&(SDCNT'<MAXREC) S SDX=$O(^SDEC(409.831,SDREF,SDX)) S SDMORE=$S(+SDMORE:1,SDX[SDECP:1,1:0) Q
 .S (SDECRES,SDRT)=$S($P(LASTSUBI,"|",3)'="":$P(LASTSUBI,"|",3),1:0)
 .S LASTSUBI="" F  S SDECRES=$O(^SDEC(409.831,SDREF,SDX,SDECRES)) Q:'+SDECRES  D RES1  I (+MAXREC)&(SDCNT'<MAXREC) S SDMORE=+$O(^SDEC(409.831,SDREF,SDX,SDECRES)) Q
 Q
RES1 ; get data for 1 resource
 N FND
 S FND=0
 Q:'$D(^SDEC(409.831,SDECRES,0))
 I SDECP'="" S SDH=0 F  S SDH=$O(^SDEC(409.831,"C",SDECP,SDH)) Q:SDH=""  S FND=SDH=SDECRES  Q:FND
 S SDECRNOD=^SDEC(409.831,SDECRES,0)
 I SDTYPE'="" Q:$P(SDECRNOD,U,11)'[SDTYPE
 S SDTYPR=$P(SDECRNOD,U,11)
 S $P(SDTYPR,"|",1)=$S($P(SDTYPR,";",2)="SC(":"H",$P(SDTYPR,";",2)="VA(200,":"P",$P(SDTYPR,";",2)="SDEC(409.834,":"A",1:"")
 S $P(SDTYPR,"|",2)=$P($P(SDECRNOD,U,11),";",1)
 S $P(SDTYPR,"|",3)=$$GET1^DIQ(409.831,SDECRES_",",.012)
 I $P(SDTYPR,"|",1)="P" D RESPRV1^SDEC01B($P(SDTYPR,"|",2),$P(SDECRNOD,U,4))  ;do not include provider resource if NEW PERSON is not active
 I $P(SDTYPR,"|",1)="H" D CHKC^SDEC01B($P(SDTYPR,"|",2),SDECRES)
 I +SDACT,$$GET1^DIQ(409.831,SDECRES_",",.02)="YES" Q   ;do not include inactive entries
 D GETACC(.SDECACC,SDECDUZ,SDECRES)
 ;I SDACT Q:$$GET1^DIQ(409.831,SDECRES_",",.02)'="YES"  ;do not include inactive entries
 K SDECRDAT
 ;alb/sat 658 - begin mod
 S $P(SDECRDAT,U,1)=$P(SDECRNOD,U,1)
 S $P(SDECRDAT,U,2)=$P(SDECRNOD,U,2)
 S $P(SDECRDAT,U,3)=$P(SDECRNOD,U,3)
 S $P(SDECRDAT,U,4)=$P(SDECRNOD,U,4)
 ;F SDEC=1:1:4 S $P(SDECRDAT,U,SDEC)=$P(SDECRNOD,U,SDEC)
 ;alb/sat 658 - end mod
 S SDECRDAT=SDECRES_U_SDECRDAT   ;1,2-5
 S SDCL=$P(SDECRDAT,U,5)
 Q:+$$GET1^DIQ(44,SDCL_",",50.01,"I")=1  ;OOS?
 S PRO=0
 ;MGH code for new type to only contain prohibited clinics
 Q:$G(SDCL)=""&(SDPRO=1)
 Q:$G(SDCL)&(SDPRO=1)&($$GET1^DIQ(44,SDCL_",",2500)'="YES")
 Q:$D(SDARR1(SDECRES))  ;alb/sat 672 - checking for duplicates
 S SDARR1(SDECRES)=""   ;alb/sat 672 - checking for duplicates
 S $P(SDECRDAT,U,3)=$$GET1^DIQ(409.831,SDECRES_",",.02)
 ;Get letter text from wp field
 S SDECLTR=""
 I 0,$D(^SDEC(409.831,SDECRES,1)) D
 . S SDECIEN=0
 . F  S SDECIEN=$O(^SDEC(409.831,SDECRES,1,SDECIEN)) Q:'+SDECIEN  D
 . . S SDECLTR=SDECLTR_$G(^SDEC(409.831,SDECRES,1,SDECIEN,0))
 . . S SDECLTR=SDECLTR_$C(13)_$C(10)
 S SDECNOS=""
 I 0,$D(^SDEC(409.831,SDECRES,12)) D
 . S SDECIEN=0 F  S SDECIEN=$O(^SDEC(409.831,SDECRES,12,SDECIEN)) Q:'+SDECIEN  D
 . . S SDECNOS=SDECNOS_$G(^SDEC(409.831,SDECRES,12,SDECIEN,0))
 . . S SDECNOS=SDECNOS_$C(13)_$C(10)
 S SDECCAN=""
 I 0,$D(^SDEC(409.831,SDECRES,13)) D
 . S SDECIEN=0 F  S SDECIEN=$O(^SDEC(409.831,SDECRES,13,SDECIEN)) Q:'+SDECIEN  D
 . . S SDECCAN=SDECCAN_$G(^SDEC(409.831,SDECRES,13,SDECIEN,0))
 . . S SDECCAN=SDECCAN_$C(13)_$C(10)
 N SDECACC,SDECMGR
 S SDECACC="0^0^0^0"
 S SDECMGR=$O(^DIC(19.1,"B","SDECZMGR",0))
 I +SDECMGR,$D(^VA(200,SDECDUZ,51,SDECMGR)) S SDECACC="1^1^1^1"
 I SDECACC="0^0^0^0" D
 . N SDECNOD,SDECRUID
 . S SDECRUID=0
 . ;Get entry for this user and resource
 . F  S SDECRUID=$O(^SDEC(409.833,"AC",SDECDUZ,SDECRUID)) Q:'+SDECRUID  I $D(^SDEC(409.833,SDECRUID,0)),$P(^(0),U)=SDECRES Q
 . Q:'+SDECRUID
 . S $P(SDECACC,U)=1
 . S SDECNOD=$G(^SDEC(409.833,SDECRUID,0))
 . S $P(SDECACC,U,2)=+$P(SDECNOD,U,3)
 . S $P(SDECACC,U,3)=+$P(SDECNOD,U,4)
 . S $P(SDECACC,U,4)=+$P(SDECNOD,U,5)
 ;                     6         7         8         9-12
 S SDECRDAT=SDECRDAT_U_SDECLTR_U_SDECNOS_U_SDECCAN_U_SDECACC_U_SDTYPR
 ;D GETS^DIQ(409.831,SDECRES_",","**","IE","SDDATA","SDMSG")
 K SDDATA D GETS^DIQ(409.831,SDECRES_",",".01:.04","IE","SDDATA","SDMSG")
 S SDA="SDDATA(409.831,"""_SDECRES_","")"
 S $P(SDECRDAT,U,14)=@SDA@(.015,"E")   ;date/time entered
 S $P(SDECRDAT,U,15)=@SDA@(.016,"I")   ;entered by user id
 S $P(SDECRDAT,U,16)=@SDA@(.016,"E")   ;entered by user name
 S $P(SDECRDAT,U,17)=@SDA@(.021,"E")   ;inactive date/time
 S $P(SDECRDAT,U,18)=@SDA@(.022,"I")   ;inactivated by user ID
 S $P(SDECRDAT,U,19)=@SDA@(.022,"E")   ;inactivated by user name
 S $P(SDECRDAT,U,20)=@SDA@(.025,"E")   ;reactivated date/time
 S $P(SDECRDAT,U,21)=@SDA@(.026,"I")   ;reactivating user ID
 S $P(SDECRDAT,U,22)=@SDA@(.026,"E")   ;reactivating user name
 S $P(SDECRDAT,U,23)=$$GET1^DIQ(44,SDCL_",",.01)  ;clinic name
 S $P(SDECRDAT,U,24)=$S($P(SDTYPR,"|",1)="P":''$O(^SC("AVADPR",+$P(SDTYPR,"|",2),0)),1:0)
 S:$G(SDCL) $P(SDECRDAT,U,25)=$S($G(SDCL):$P($G(^SC(SDCL,"SDPRIV",0)),U,4)>0,1:0)  ;contains privileged users
 S:$G(SDCL) $P(SDECRDAT,U,26)=$$GET1^DIQ(44,SDCL_",",2500)["Y"  ;prohibited clinic
 S $P(SDECRDAT,U,27)=SDF_"|"_SDX_"|"_SDECRES   ;LASTSUB
 S $P(SDECRDAT,U,28)=@SDA@(.011,"E")   ;abbreviation
 S:$P(SDECRDAT,U,23)'="" SDVW=$$GET^XPAR("PKG.SCHEDULING","SDEC VS GUI CLINIC VIEW",$P(SDECRDAT,U,23),"B")   ;alb/sat 672
 S $P(SDECRDAT,U,29)=$S(SDVW'="":$P(SDVW,U,1),1:"W")  ;alb/sat 672
 S $P(SDECRDAT,U,2)=$S(($G(SDF)["ABBR")&(@SDA@(.011,"E")'=""):@SDA@(.011,"E")_" ",1:"")_$P(SDECRDAT,U,2)  ;alb/sat 658 - include abbr in name if found by C xref
 S SDARR(SDF["FULL",$P(SDECRDAT,U,2))=SDECRDAT,SDCNT=SDCNT+1
 Q
 ;
GETACC(SDECACC,SDECDUZ,SDECRES) ;get view, overbook, modify appt, and modify schedule abilities
 ;INPUT:
 ; SDECDUZ = user ID pointer to NEW PERSON file
 ; SDECRES = resource ID pointer to SDEC RESOURCE file
 ;RETURN:
 ; .SDECACC  = access separated by ^:
 ;   1. VIEW - User can VIEW 1=YES; 0=NO
 ;   2. OVERBOOK - User can OVERBOOK  1=YES; 0=NO
 ;   3. MODIFY SCHEDULE - User can Modify Schedule  1=YES; 0=NO
 ;   4. MODIFY APPOINTMENTS User can modify appointments  1=YES; 0=NO
 N SDECMGR
 S SDECACC="0^0^0^0"
 S SDECMGR=$O(^DIC(19.1,"B","SDECZMGR",0))
 I +SDECMGR,$D(^VA(200,SDECDUZ,51,SDECMGR)) S SDECACC="1^1^1^1"
 I SDECACC="0^0^0^0" D
 . N SDECNOD,SDECRUID
 . S SDECRUID=0
 . ;Get entry for this user and resource
 . F  S SDECRUID=$O(^SDEC(409.833,"AC",SDECDUZ,SDECRUID)) Q:'+SDECRUID  I $D(^SDEC(409.833,SDECRUID,0)),$P(^(0),U)=SDECRES Q
 . Q:'+SDECRUID
 . S $P(SDECACC,U)=1
 . S SDECNOD=$G(^SDEC(409.833,SDECRUID,0))
 . S $P(SDECACC,U,2)=+$P(SDECNOD,U,3)
 . S $P(SDECACC,U,3)=+$P(SDECNOD,U,4)
 . S $P(SDECACC,U,4)=+$P(SDECNOD,U,5)
 Q
 ;
GETLTRS(SDECLTR,SDECNOS,SDECCAN,SDECRES,SDCL) ;get resource letters
 ;INPUT:
 ; SDECRES = resource ID pointer to SDEC RESOURCE file
 ; SDCL    = clinic ID pointer to HOSPITAL LOCATION file
 ;RETURN:
 ; .SDECLTR = LETTER TEXT
 ; .SDECNOS = NO SHOW LETTER
 ; .SDECCAN = CLINIC CANCELLATION LETTER
 ; .Get letter text from wp field
 N SDECIEN
 S SDECLTR=""
 I $D(^SDEC(409.831,SDECRES,2,SDCL,1)) D
 . S SDECIEN=0 F  S SDECIEN=$O(^SDEC(409.831,SDECRES,2,SDCL,1,SDECIEN)) Q:'+SDECIEN  D
 . . S SDECLTR=SDECLTR_$G(^SDEC(409.831,SDECRES,2,SDCL,1,SDECIEN,0))
 . . S SDECLTR=SDECLTR_$C(13)_$C(10)
 S SDECNOS=""
 I $D(^SDEC(409.831,SDECRES,2,SDCL,12)) D
 . S SDECIEN=0 F  S SDECIEN=$O(^SDEC(409.831,SDECRES,2,SDCL,12,SDECIEN)) Q:'+SDECIEN  D
 . . S SDECNOS=SDECNOS_$G(^SDEC(409.831,SDECRES,2,SDCL,12,SDECIEN,0))
 . . S SDECNOS=SDECNOS_$C(13)_$C(10)
 S SDECCAN=""
 I $D(^SDEC(409.831,SDECRES,13)) D
 . S SDECIEN=0 F  S SDECIEN=$O(^SDEC(409.831,SDECRES,2,SDCL,13,SDECIEN)) Q:'+SDECIEN  D
 . . S SDECCAN=SDECCAN_$G(^SDEC(409.831,SDECRES,2,SDCL,13,SDECIEN,0))
 . . S SDECCAN=SDECCAN_$C(13)_$C(10)
 Q
