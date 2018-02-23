SDECWL ;ALB/SAT - VISTA SCHEDULING RPCS ;JUL 26, 2017
 ;;5.3;Scheduling;**627,642,665,672**;Aug 13, 1993;Build 9
 ;
 Q
 ;
 ; entry points for Clinical Scheduling/Wait List related Remote Procedures
APPTGET(RET,WLIEN) ; EP for SDEC WLGET remote procedure
 S RET="I00020ERRORID^T00256ERRORTEXT"_$C(30)
 S RET="-1^Not yet implemented"_$C(30,31)
 Q
 ;------------------------------------------------
DEL(RET,INP)  ;not used
 S RET="I00020ERRORID^T00256ERRORTEXT"_$C(30)
 S RET="-1^Not yet implemented"_$C(30,31)
 Q
 ;
WLCLOSE(RET,INP) ;Waitlist Close
 ; INP - Input parameters array
 ;     INP(1) - Waitlist ID - Pointer to SD WAIT LIST file
 ;     INP(2) - Disposition
 ;     INP(3) - User Id - Pointer to NEW PERSON file
 ;     INP(4) - Date Dispositioned in external form
 N MI,WLDISP,WLDISPBY,WLDISPDT,WLFDA,WLIEN,WLMSG,WLRET
 S RET="I00020ERRORID^T00256ERRORTEXT"_$C(30)
 ;validate IEN
 S WLIEN=$G(INP(1)) I WLIEN="" S RET=RET_"-1^Missing IEN"_$C(30,31) Q
 ;validate DISPOSITION
 S WLDISP=$G(INP(2))
 I (WLDISP'="D"),(WLDISP'="NC"),(WLDISP'="SA"),(WLDISP'="CC"),(WLDISP'="NN"),(WLDISP'="ER"),(WLDISP'="TR"),(WLDISP'="CL") D
 .S:WLDISP="DEATH" WLDISP="D"
 .S:WLDISP="REMOVED/NON-VA CARE" WLDISP="NC"
 .S:WLDISP="REMOVED/SCHEDULED-ASSIGNED" WLDISP="SA"
 .S:WLDISP="REMOVED/VA CONTRACT CARE" WLDISP="CC"
 .S:WLDISP="REMOVED/NO LONGER NECESSARY" WLDISP="NN"
 .S:WLDISP="ENTERED IN ERROR" WLDISP="ER"
 .S:WLDISP="TRANSFERRED" WLDISP="TR"
 .S:WLDISP="CHANGED CLINIC" WLDISP="CL"
 I WLDISP="" S RET=RET_"-1^Missing value for DISPOSITION"_$C(30,31) Q
 I (WLDISP'="D"),(WLDISP'="NC"),(WLDISP'="SA"),(WLDISP'="CC"),(WLDISP'="NN"),(WLDISP'="ER"),(WLDISP'="TR"),(WLDISP'="CL") D
 .S RET=RET_"-1^Invalid value for DISPOSITION"_$C(30,31) Q
 ;validate DISPOSITIONED BY
 S WLDISPBY=$G(INP(3),DUZ)
 I '+WLDISPBY S WLDISPBY=$O(^VA(200,"B",WLDISPBY,0))
 I '+WLDISPBY S RET=RET_"-1^Invalid 'DISPOSITIONED BY' user"_$C(30,31) Q
 ;validate DATE DISPOSITIONED
 S WLDISPDT=$G(INP(4),DT) I WLDISPDT'="" S %DT="" S X=WLDISPDT D ^%DT S WLDISPDT=Y
 I Y=-1 S RET=RET_"-1^Invalid 'DATE DISPOSITIONED'"_$C(30,31) Q
 S WLFDA=$NA(WLFDA($$FNUM,WLIEN_","))
 S @WLFDA@(19)=WLDISPDT
 S @WLFDA@(20)=WLDISPBY
 S @WLFDA@(21)=WLDISP
 S @WLFDA@(23)="C"
 D UPDATE^DIE("","WLFDA","WLRET","WLMSG")
 I $D(WLMSG("DIERR")) D
 . F MI=1:1:$G(WLMSG("DIERR")) S RET=RET_"-1^"_$G(WLMSG("DIERR",MI,"TEXT",1))_$C(30)
 S RET=RET_$C(31)
 Q
 ;
WLOPEN(RET,WLAPP,WLIEN,WLDDT) ;SET Waitlist Open/re-open
 ;WLOPEN(RET,WLAPP,WLIEN,WLDDT)  external parameter tag in SDEC
 ;INPUT:
 ;     WLAPP - (required if no WLIEN) Appointment ID pointer to
 ;                                    SDEC APPOINTMENT file 409.84
 ;     WLIEN - (required if no WLAPP) Waitlist ID - Pointer to
 ;                                    SD WAIT LIST file
 ;     WLDDT - (optional) Desired Date of appointment in external format
 N SDART,SDECI,SDQ,WLFDA,WLMSG,X,Y,%DT
 S RET="^TMP(""SDECWL"","_$J_",""WLOPEN"")"
 K @RET
 S (SDECI,SDQ)=0
 S @RET@(SDECI)="T00030ERRORID^T00030ERRTEXT"_$C(30)
 ;validate WLAPP (required if WLIEN not passed it)
 S WLAPP=$G(WLAPP)
 I WLAPP'="" I $D(^SDEC(409.84,WLAPP,0)) D
 .S SDART=$$GET1^DIQ(409.84,WLAPP_",",.22,"I")
 .I $P(SDART,";",2)'="SDWL(409.3," S SDECI=SDECI+1 S @RET@(SDECI)="-1^Not an EWL appointment."_$C(30),SDQ=1 Q
 .I $G(WLIEN)'="",WLIEN'=$P(SDART,";",1) S SDECI=SDECI+1 S @RET@(SDECI)="-1^Appointment EWL does not match passed in EWL."_$C(30),SDQ=1 Q
 .S WLIEN=$P(SDART,";",1)
 G:SDQ WLX
 ;validate WLIEN
 S WLIEN=$G(WLIEN)
 I WLIEN="" S SDECI=SDECI+1 S @RET@(SDECI)="-1^Wait List ID or Appointment ID is required."_$C(30,31) Q
 I '$D(^SDWL(409.3,WLIEN,0)) S SDECI=SDECI+1 S @RET@(SDECI)="-1^Invalid wait list ID."_$C(30,31) Q
 ;validate WLDDT
 S WLDDT=$P($G(WLDDT),"@",1)
 I $G(WLDDT)'="" S %DT="" S X=WLDDT D ^%DT I Y=-1 S SDECI=SDECI+1 S @RET@(SDECI)="-1^Invalid desired date of appointment."_$C(30,31) Q
 ;
 S WLFDA=$NA(WLFDA(409.3,WLIEN_","))
 S @WLFDA@(19)=""
 S @WLFDA@(20)=""
 S @WLFDA@(21)=""
 S:WLDDT'="" @WLFDA@(22)=WLDDT
 S @WLFDA@(23)="OPEN"
 D UPDATE^DIE("E","WLFDA","WLRET","WLMSG")
 I $D(WLMSG("DIERR")) D
 . F MI=1:1:$G(WLMSG("DIERR")) S SDECI=SDECI+1 S @RET@(SDECI)="-1^"_$G(WLMSG("DIERR",MI,"TEXT",1))_$C(30)
 I '$D(WLMSG("DIERR")) S SDECI=SDECI+1 S @RET@(SDECI)="0^"_WLIEN_$C(30)
WLX  S @RET@(SDECI)=@RET@(SDECI)_$C(31)
 Q
 ;
FNUM(RET)   ;file number
 S RET=409.3
 Q RET
 ;
CLINALL(RET,MAXREC,SDECP) ;Return the IEN and NAME for all entries in the SD WL CLINIC LOCATION file
 ;CLINALL(RET)  external parameter tag is in SDEC
 N CLINARR,CLINIEN,CLINNAME,COUNT,GLOREF,INACTIVE,LOCIEN,X
 N CLINABR,SDCNT,SDECIEN,SDECNAM,SDF,SDMAX,SDTMP   ;alb/sat 665
 N SDARR1,SDREF,SDXT   ;alb/sat 672
 S SDF=""
 S (SDCNT,SDMAX)=0  ;alb/sat 665
 S RET="^TMP(""SDEC"","_$J_")"
 K @RET
 S @RET@(0)="T00020CLINIC_IEN^T00030CLINIC_NAME^T00020HOSPITAL_LOCATION_ID^T00030ABBR^T00030MORE"_$C(30)
 S MAXREC=$G(MAXREC,50)
 S SDECP=$G(SDECP)
 ;Search for entries using partial name
 I SDECP'="" D
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
 ;Search for all SD WL CLINIC LOCATION entries
 I SDECP="" S CLINIEN=0 F  S CLINIEN=$O(^SDWL(409.32,CLINIEN)) Q:'CLINIEN  D PROCESS  I SDCNT'<MAXREC S SDMAX=+$O(^SDWL(409.32,CLINIEN)) Q
 ;
 S COUNT=0
 S SDF=-1 F  S SDF=$O(CLINARR(SDF)) Q:SDF=""  D
 .S CLINNAME="" F  S CLINNAME=$O(CLINARR(SDF,CLINNAME)) Q:CLINNAME=""  D
 ..S SDTMP=$P(CLINARR(SDF,CLINNAME),U)_U_CLINNAME_U_$P(CLINARR(SDF,CLINNAME),U,2)_U_$P(CLINARR(SDF,CLINNAME),U,3)_U_$S(+SDMAX:1,1:0)
 ..S COUNT=COUNT+1,@RET@(COUNT)=SDTMP_$C(30)
 S @RET@(COUNT)=@RET@(COUNT)_$C(31)
 Q
PART  ;partial name lookup  ;alb/sat 672
 Q:SDREF=""
 F  S SDECNAM=$O(^SC(SDREF,SDECNAM)) Q:SDECNAM'[SDECP  D  I SDCNT'<MAXREC S SDECNAM=$O(^SC(SDREF,SDECNAM)) S SDMAX=$S(+SDMAX:1,SDECNAM[SDECP:1,1:0) Q   ;alb/sat 658 - abbreviation lookup if characters length 7 or less
 .S SDECIEN=0 F  S SDECIEN=$O(^SC(SDREF,SDECNAM,SDECIEN)) Q:SDECIEN=""  D  I SDCNT'<MAXREC S SDMAX=$S(+SDMAX:+SDMAX,1:+$O(^SC(SDREF,SDECNAM,SDECIEN))) Q  ;alb/sat 665 loop thru all entries
 ..S CLINIEN=0 F  S CLINIEN=$O(^SDWL(409.32,"B",SDECIEN,CLINIEN)) Q:CLINIEN=""  D PROCESS I SDCNT'<MAXREC S SDMAX=+$O(^SDWL(409.32,"B",SDECIEN,CLINIEN)) Q  ;alb/sat 665 loop thru all entries
 Q
PROCESS ;get 1 record ;alb/sat 665
 N CLINABR,INACTIVE,LOCIEN
 S INACTIVE=$$GET1^DIQ(409.32,CLINIEN_",",3,"I")
 I (INACTIVE'="")&($P(INACTIVE,".",1)'>$P($$NOW^XLFDT,".",1)) Q
 S LOCIEN=$P(^SDWL(409.32,CLINIEN,0),U)
 S CLINNAME=$P($G(^SC(LOCIEN,0)),U)
 S CLINABR=$P($G(^SC(LOCIEN,0)),U,2)
 S:SDF["ABBR" CLINNAME=CLINABR_" "_CLINNAME
 Q:$$GET1^DIQ(44,LOCIEN_",",50.01,"I")=1  ;OOS?
 Q:$D(SDARR1(CLINIEN))  ;alb/sat 672 - checking for duplicates
 S SDARR1(CLINIEN)=""   ;alb/sat 672 - checking for duplicates
 I CLINNAME'="" S CLINARR(SDF["FULL",CLINNAME)=CLINIEN_U_LOCIEN_U_CLINABR,SDCNT=SDCNT+1
 Q
 ;
SVSPALL(RET) ;return IEN and NAME for all entries in the SD WL SERVICE/SPECIALTY file
 ;SVSPALL(RET)  external parameter tag is in SDEC
 N COUNT,GLOREF,CLSTPIEN,SVSPARR,SVSPIEN,SVSPNAME,X
 S RET="^TMP(""SDEC"","_$J_")"
 K @RET
 S @RET@(0)="T00020SERVICESPECIALTY_IEN^T00030SERVICESPECIALTY_NAME"_$C(30)
 S GLOREF=$NA(^SDWL(409.31))
 ; Search for all SD WL SERVICE/SPECIALTY entries
 ; Lookup the CLINIC STOP name
 ; Save the names in a local array so the return array will be sorted by Name
 S SVSPIEN=0
 F  S SVSPIEN=$O(@GLOREF@(SVSPIEN)) Q:'SVSPIEN  D
 . S CLSTPIEN=$P(@GLOREF@(SVSPIEN,0),U)
 . S SVSPNAME=$P($G(^DIC(40.7,CLSTPIEN,0)),U)
 . I SVSPNAME'="" S SVSPARR(SVSPNAME)=SVSPIEN
 S SVSPNAME="",COUNT=0
 F  S SVSPNAME=$O(SVSPARR(SVSPNAME)) Q:SVSPNAME=""  D
 . S COUNT=COUNT+1,@RET@(COUNT)=SVSPARR(SVSPNAME)_U_SVSPNAME_$C(30)
 ;S COUNT=COUNT+1,@RET@(COUNT)=$C(31)
 S @RET@(COUNT)=@RET@(COUNT)_$C(31)
 Q
 ;
APPTYPES(RET,DFN) ; EP for SDEC APPTYPES
 ;APPTYPES(RET,DFN)  external parameter tag is in SDEC
 ; Return the different appointment types
 N APTYDATA,APTYIEN,APTYINAC,APTYNAME,COUNT,GLOREF
 N ISVET,PTYPE,SDEC,SDI
 S PTYPE=""
 S ISVET=1   ;0=not a vet; 1=is a vet
 S RET=$NA(^TMP("SDEC",$J)),COUNT=0
 K @RET
 S @RET@(0)="T00020APPTTYPE_IEN^T00030APPTTYPE_NAME"_$C(30)
 S DFN=$G(DFN) I DFN'="" S:'$D(^DPT(+DFN,0)) DFN=""
 S GLOREF=$NA(^SD(409.1))
 I '+DFN D
 .S APTYNAME="" F  S APTYNAME=$O(@GLOREF@("B",APTYNAME)) Q:APTYNAME=""  D
 ..S APTYIEN=0 F  S APTYIEN=$O(@GLOREF@("B",APTYNAME,APTYIEN)) Q:'APTYIEN  D
 ...S APTYDATA=$G(@GLOREF@(APTYIEN,0))
 ...Q:$P(APTYDATA,U,3)
 ...S COUNT=COUNT+1,@RET@(COUNT)=APTYIEN_U_APTYNAME_$C(30)
 ;
 I +DFN D
 .N VAEL D ELIG^VADPT
 .S SDEC=$S($D(^DIC(8,+VAEL(1),0)):$P(^(0),U,5),1:"")
 .S APTYNAME="" F  S APTYNAME=$O(@GLOREF@("B",APTYNAME)) Q:APTYNAME=""  D
 ..S APTYIEN=0 F  S APTYIEN=$O(@GLOREF@("B",APTYNAME,APTYIEN)) Q:'APTYIEN  D
 ...S APTYDATA=$G(@GLOREF@(APTYIEN,0))
 ...Q:$P(APTYDATA,U,3)
 ...I $S(SDEC["Y":1,1:$P(APTYDATA,U,5)),$S('$P(APTYDATA,U,6):1,$D(VAEL(1,+$P(APTYDATA,U,6))):1,+VAEL(1)=$P(APTYDATA,U,6):1,1:0) D
 ....S COUNT=COUNT+1,@RET@(COUNT)=APTYIEN_U_APTYNAME_$C(30)
 ;
 S @RET@(COUNT)=@RET@(COUNT)_$C(31)
 Q
 ;
WLPCSET(SDECY,INP,WLIEN)  ;SET update patient contacts in SD WAIT LIST file
 ;WLSETPC(SDECY,INP,WLIEN)  external parameter tag in SDEC
 ;  INP = Patient Contacts separated by ::
 ;            Each :: piece has the following ~~ pieces:  (same as they are passed into SDEC WLSET)
 ;            1) = (required)    DATE ENTERED external date/time
 ;            2) = (optional)    PC ENTERED BY USER ID or NAME - Pointer to NEW PERSON file or NAME
 ;            4) = (optional) ACTION - valid values are:
 ;                              CALLED
 ;                              MESSAGE LEFT
 ;                              LETTER
 ;            5) = (optional)    PATIENT PHONE Free-Text 4-20 characters
 ;            6) = NOT USED (optional) Comment 1-160 characters
 ;  WLIEN = (required) Wait List Id pointer to SDEC WAIT LIST file 409.3
 N SDECI,SDTMP,WLMSG1
 S SDECY="^TMP(""SDECWL"","_$J_",""WLSETPC"")"
 K @SDECY
 S SDECI=0
 S @SDECY@(SDECI)="T00030RETURNCODE^T00030TEXT"_$C(30)
 S WLIEN=$G(WLIEN)
 I (WLIEN="")!('$D(^SDWL(409.3,WLIEN,0))) D ERR1^SDECERR(-1,"Invalid wait list ID "_WLIEN_".",SDECI,SDECY) Q
 D WL23^SDECWL2(INP,WLIEN)
 I $D(WLMSG1) D ERR1^SDECERR(-1,"Error storing patient contacts.",SDECI,SDECY) Q
 S SDECI=SDECI+1 S @SDECY@(SDECI)="0^SUCCESS"_$C(30,31)
 Q
 ;
AUDITGET(SDECY,WLIEN)  ;GET entries from VS AUDIT field of SD WAIT LIST file 409.3
 N WLDATA,SDECI,SDI,SDTMP,SDX
 S SDECY="^TMP(""SDECWL"","_$J_",""AUDITGET"")"
 K @SDECY
 S SDECI=0
 S SDTMP="T00030IEN^T00030ID^T00030DATE^T00030USERIEN^T00030USERNAME"
 S SDTMP=SDTMP_"^T00030WLCINIEN^T00030WLCINNAME^T00030CLINIEN^T00030CLINNAME"
 S SDTMP=SDTMP_"^T00030STOPIEN^T00030STOPNAME"
 S @SDECY@(SDECI)=SDTMP_$C(30)
 ;validate WLIEN
 S WLIEN=$G(WLIEN)
 I '+$D(^SDWL(409.3,+WLIEN,0)) S @SDECY@(1)="-1^Invalid SD WAIT LIST id."_$C(30,31) Q
 S SDI=0 F  S SDI=$O(^SDWL(409.3,+WLIEN,6,SDI)) Q:SDI'>0  D
 .K WLDATA
 .D GETS^DIQ(409.345,SDI_","_WLIEN_",","**","IE","WLDATA")
 .S SDX="WLDATA(409.345,"""_SDI_","_WLIEN_","")"
 .S SDTMP=WLIEN_U_SDI_U_@SDX@(.01,"E")_U_@SDX@(1,"I")_U_@SDX@(1,"E")
 .S SDTMP=SDTMP_U_@SDX@(2,"I")_U_@SDX@(2,"E")_U_@SDX@(3,"I")_U_@SDX@(3,"E")
 .S SDTMP=SDTMP_U_@SDX@(4,"I")_U_@SDX@(4,"E")
 .S SDECI=SDECI+1 S @SDECY@(SDECI)=SDTMP_$C(30)
 S @SDECY@(SDECI)=@SDECY@(SDECI)_$C(31)
 Q
