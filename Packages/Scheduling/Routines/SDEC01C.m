SDEC01C ;ALB/AJF - VISTA SCHEDULING RPCS ;FEB 22, 2018
 ;;5.3;Scheduling;**686**;;Build 53
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
 ;   2. HOSPITALID - Pointer to the HOSPITAL LOCATION file 44
 ;   3. CLINNAME   - Clinic Name from HOSPITAL LOCATION file 44
 ;   4. ABBR       - Abbreviation
 ;   5. RESOURCE_NAME - NAME from SDEC RESOURCE file
 ;
 ;
 N SDA,SDCL,SDDATA,SDMSG,SDECERR,SDECRET,SDECIEN,SDECRES,SDECDEP,SDECDDR,SDECDEPN,SDECRDAT,SDECRNOD,SDECI,SDEC,SDECLTR
 N ABBR,SDECNOS,SDECCAN,SDF,SDTYPR,SDX,SDPRO,PRO,SDH,SDK,SDRT,SDT,SDXT,SDCN,SDHL
 S (SDF,SDRT,SDT,SDX)="",SDPRO=0
 S SDECY="^TMP(""SDEC01C"","_$J_",""RESOURCE"")"
 K @SDECY
 S SDECI=0
 S (SDECERR,SDTYPR)=""
 ;                       1                       2                   3       
 S @SDECY@(SDECI)="I00010RESOURCEID^I00010HOSPITAL_LOCATION_ID^T00030CLINNAME^T00030ABBR^T00030RESOURCE_NAME"_$C(30)
 ;validate user
 S SDECDUZ=$G(SDECDUZ)
 I '+SDECDUZ S SDECDUZ=DUZ
 ;validate active
 S SDACT=1
 ;S SDACT=$G(SDACT)
 ;S SDACT=$S(SDACT=1:1,SDACT="YES":1,1:0)
 ;validate type
 S SDTYPE="H"
 ;MGH added new type
 ;I SDTYPE="PH" S SDPRO=1
 S SDTYPE=$S(SDTYPE="H":"SC(",SDTYPE="P":"VA(200",SDTYPE="A":"SDEC",1:"")
 ;validate MAXREC
 S MAXREC=$G(MAXREC,9999999)
 ;validate LASTSUBI
 S LASTSUBI=$G(LASTSUBI)
 ;validate SDIEN
 ;MGH changed to allow multiple IENS
 S SDIEN=$G(SDIEN)
 I SDIEN'="",'$D(^SDEC(409.831,+SDIEN,0)) S SDIEN=""
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
 .S (SDX,SDXT)=$S($P(LASTSUBI,"|",2)'="":$$GETSUB^SDEC56($P(LASTSUBI,"|",2)),1:$$GETSUB^SDEC56(SDECP))
 .I ($P(LASTSUBI,"|",1)="")!($P(LASTSUBI,"|",1)="ABBR") S SDF="ABBR" F  S SDX=$O(^SDEC(409.831,"C",SDX)) Q:SDX=""  Q:SDX'[SDECP  D  Q:(+MAXREC)&(SDECI'<MAXREC)
 ..S (SDECRES,SDRT)=$S($P(LASTSUBI,"|",3)'="":$P(LASTSUBI,"|",3),1:0)
 ..S LASTSUBI="" F  S SDECRES=$O(^SDEC(409.831,"C",SDX,SDECRES)) Q:'+SDECRES  D RES1  Q:(+MAXREC)&(SDECI'<MAXREC)
 .I ($P(LASTSUBI,"|",1)="")!($P(LASTSUBI,"|",1)="FULL") S SDF="FULL",SDX=SDXT F  S SDX=$O(^SDEC(409.831,"B",SDX)) Q:SDX=""  Q:SDX'[SDECP  D  Q:(+MAXREC)&(SDECI'<MAXREC)
 ..S (SDECRES,SDRT)=$S($P(LASTSUBI,"|",3)'="":$P(LASTSUBI,"|",3),SDRT'="":SDRT,1:0)
 ..S LASTSUBI="" F  S SDECRES=$O(^SDEC(409.831,"B",SDX,SDECRES)) Q:'+SDECRES  D RES1  Q:(+MAXREC)&(SDECI'<MAXREC)
 ;$O THRU SDEC RESOURCE File
 I SDECP="",'+SDIEN S SDECRES=$S($P(LASTSUBI,"|",2)'="":$P(LASTSUBI,"|",2),1:0) F  S SDECRES=$O(^SDEC(409.831,SDECRES)) Q:'+SDECRES  D  Q:(+MAXREC)&(SDECI'<MAXREC)
 .D RES1
RESX ;
 S @SDECY@(SDECI)=@SDECY@(SDECI)_$C(31)
 Q
RES1 ; get data for 1 resource
 N FND
 S FND=0
 Q:'$D(^SDEC(409.831,SDECRES,0))
 I SDF="FULL",SDECP'="" S FND=$$CHK(SDECP,SDECRES) Q:+FND   ;alb/sat 658 - stop if 'this' record found in abbreviations
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
 K SDECRDAT
 ;alb/sat 658 - begin mod
 ;
 S $P(SDECRDAT,U,1)=$P(SDECRNOD,U,1)
 S $P(SDECRDAT,U,2)=$P(SDECRNOD,U,2)
 S $P(SDECRDAT,U,3)=$P(SDECRNOD,U,3)
 S $P(SDECRDAT,U,4)=$P(SDECRNOD,U,4)
 S SDHL=$P(SDECRNOD,U,4)
 S SDCN=$$GET1^DIQ(44,SDHL_",",.01)  ;clinic name
 ;alb/sat 658 - end mod
 S SDECRDAT=SDECRES_U_SDECRDAT   ;1,2-5
 S SDCL=$P(SDECRDAT,U,5)
 Q:+$$GET1^DIQ(44,SDCL_",",50.01,"I")=1  ;OOS?
 S PRO=0
 ;MGH code for new type to only contain prohibited clinics
 Q:$G(SDCL)=""&(SDPRO=1)
 Q:$G(SDCL)&(SDPRO=1)&($$GET1^DIQ(44,SDCL_",",2500)'="YES")
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
 K SDDATA D GETS^DIQ(409.831,SDECRES_",",".01:.04","IE","SDDATA","SDMSG")
 S SDA="SDDATA(409.831,"""_SDECRES_","")"
 S ABBR=@SDA@(.011,"E")   ;abbreviation
 ;AJF ; 022718 ; Only return 7 variables
 S SDECRDAT=SDECRES_U_SDHL_U_SDCN_U_ABBR_U_$P(SDECRNOD,U)
 ;S SDECRDAT=SDECRES_U_SDHL_U_SDCN
 S $P(SDECRDAT,U,4)=@SDA@(.011,"E")   ;abbreviation
 S $P(SDECRDAT,U,5)=$S(($G(SDF)="ABBR")&(@SDA@(.011,"E")'=""):@SDA@(.011,"E")_" ",1:"")_$P(SDECRDAT,U,5)  ;alb/sat 658 - include abbr in name if found by C xref
 ;S $P(SDECRDAT,U,6)=SDF_"|"_SDX_"|"_SDECRES   ;LASTSUB
 S SDECI=SDECI+1
 S @SDECY@(SDECI)=SDECRDAT_$C(30)
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
 ;
CHK(SDECP,SDECRES)  ;alb/sat 658 - stop if 'this' record found in abbreviations
 N FND,SDR,SDX
 S FND=0
 S SDX=$$GETSUB^SDEC56(SDECP)
 F  S SDX=$O(^SDEC(409.831,"C",SDX)) Q:SDX=""  Q:SDX'[SDECP  D  Q:+FND
 .S SDR=0 F  S SDR=$O(^SDEC(409.831,"C",SDX,SDR)) Q:'+SDR  S FND=SDR=SDECRES  Q:+FND
 Q FND
