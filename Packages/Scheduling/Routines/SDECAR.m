SDECAR ;ALB/SAT - VISTA SCHEDULING RPCS ;APR 08, 2016
 ;;5.3;Scheduling;**627,642**;Aug 13, 1993;Build 23
 ;
 Q
 ;
ARCLOSE(RET,INP) ;Appointment Request Close
 ;ARCLOSE(RET,INP...)  external parameter tag in SDEC
 ; INP - Input parameters array
 ;     INP(1) - Request ID - Pointer to SDEC APPT REQUEST file
 ;     INP(2) - Disposition
 ;     INP(3) - User Id - Pointer to NEW PERSON file
 ;     INP(4) - Date Dispositioned in external form
 N MI,ARDISP,ARDISPBY,ARDISPDT,ARFDA,ARIEN,ARMSG,ARRET
 S RET="I00020ERRORID^T00256ERRORTEXT"_$C(30)
 ;validate IEN
 S ARIEN=$G(INP(1)) I ARIEN="" S RET=RET_"-1^Missing IEN"_$C(30,31) Q
 ;validate DISPOSITION
 S ARDISP=$G(INP(2))
 ;MC:MRTC PARENT CLOSED
 I (ARDISP'="D"),(ARDISP'="NC"),(ARDISP'="SA"),(ARDISP'="CC"),(ARDISP'="NN"),(ARDISP'="ER"),(ARDISP'="TR"),(ARDISP'="CL"),(ARDISP'="MC") D
 .S:ARDISP="DEATH" ARDISP="D"
 .S:ARDISP="REMOVED/NON-VA CARE" ARDISP="NC"
 .S:ARDISP="REMOVED/SCHEDULED-ASSIGNED" ARDISP="SA"
 .S:ARDISP="REMOVED/VA CONTRACT CARE" ARDISP="CC"
 .S:ARDISP="REMOVED/NO LONGER NECESSARY" ARDISP="NN"
 .S:ARDISP="ENTERED IN ERROR" ARDISP="ER"
 .S:ARDISP="TRANSFERRED TO EWL" ARDISP="TR"
 .S:ARDISP="CHANGED CLINIC" ARDISP="CL"
 .S:ARDISP="MRTC PARENT CLOSED" ARDISP="MC"
 I ARDISP="" S RET=RET_"-1^Missing value for DISPOSITION"_$C(30,31) Q
 I (ARDISP'="D"),(ARDISP'="NC"),(ARDISP'="SA"),(ARDISP'="CC"),(ARDISP'="NN"),(ARDISP'="ER"),(ARDISP'="TR"),(ARDISP'="CL"),(ARDISP'="MC") D
 .S RET=RET_"-1^Invalid value for DISPOSITION"_$C(30,31) Q
 ;validate DISPOSITIONED BY
 S ARDISPBY=$G(INP(3),DUZ)
 I '+ARDISPBY S ARDISPBY=$O(^VA(200,"B",ARDISPBY,0))
 I '$D(^VA(200,+ARDISPBY,0)) S RET=RET_"-1^Invalid 'DISPOSITIONED BY' user"_$C(30,31) Q
 ;validate DATE DISPOSITIONED
 S ARDISPDT=$G(INP(4),DT) I ARDISPDT'="" S %DT="" S X=ARDISPDT D ^%DT S ARDISPDT=Y
 I Y=-1 S RET=RET_"-1^Invalid 'DATE DISPOSITIONED'"_$C(30,31) Q
 S ARFDA=$NA(ARFDA($$FNUM,ARIEN_","))
 S @ARFDA@(19)=ARDISPDT
 S @ARFDA@(20)=ARDISPBY
 S @ARFDA@(21)=ARDISP
 S @ARFDA@(23)="C"
 D UPDATE^DIE("","ARFDA","ARRET","ARMSG")
 I $D(ARMSG("DIERR")) D
 . F MI=1:1:$G(ARMSG("DIERR")) S RET=RET_"-1^"_$G(ARMSG("DIERR",MI,"TEXT",1))_$C(30)
 S RET=RET_$C(31)
 Q
 ;
AROPEN(RET,ARAPP,ARIEN,ARDDT) ;SET Appointment Request Open/re-open
 ;AROPEN(RET,ARAPP,ARIEN,ARDDT)  external parameter tag in SDEC
 ;INPUT:
 ;     ARAPP - (required if no ARIEN) Appointment ID pointer to
 ;                                    SDEC APPOINTMENT file 409.84
 ;     ARIEN - (required if no ARAPP) Request ID - Pointer to
 ;                                    SDEC APPOINTMENT REQUEST file
 ;     ARDDT - (optional) Desired Date of appointment in external format
 N SDART,SDECI,SDQ,ARFDA,ARMSG,X,Y,%DT
 S RET="^TMP(""SDECAR"","_$J_",""AROPEN"")"
 K @RET
 S (SDECI,SDQ)=0
 S @RET@(SDECI)="T00030ERRORID^T00030ERRTEXT"_$C(30)
 ;validate ARAPP (required if ARIEN not passed it)
 S ARAPP=$G(ARAPP)
 I ARAPP'="" I $D(^SDEC(409.84,ARAPP,0)) D
 .S SDART=$$GET1^DIQ(409.84,ARAPP_",",.22,"I")
 .I $P(SDART,";",2)'="SDEC(409.85," S SDECI=SDECI+1 S @RET@(SDECI)="-1^Not a Requested appointment."_$C(30),SDQ=1 Q
 .I $G(ARIEN)'="",ARIEN'=$P(SDART,";",1) S SDECI=SDECI+1 S @RET@(SDECI)="-1^Appointment Request does not match item passed in."_$C(30),SDQ=1 Q
 .S ARIEN=$P(SDART,";",1)
 G:SDQ ARX
 ;validate ARIEN
 S ARIEN=$G(ARIEN)
 I ARIEN="" S SDECI=SDECI+1 S @RET@(SDECI)="-1^Appointment Request ID or Appointment ID is required."_$C(30,31) Q
 I '$D(^SDEC(409.85,ARIEN,0)) S SDECI=SDECI+1 S @RET@(SDECI)="-1^Invalid Appt Request ID."_$C(30,31) Q
 ;validate ARDDT
 S ARDDT=$P($G(ARDDT),"@",1)
 I $G(ARDDT)'="" S %DT="" S X=ARDDT D ^%DT I Y=-1 S SDECI=SDECI+1 S @RET@(SDECI)="-1^Invalid desired date of appointment."_$C(30,31) Q
 ;
 S ARFDA=$NA(ARFDA(409.85,ARIEN_","))
 S @ARFDA@(19)=""
 S @ARFDA@(20)=""
 S @ARFDA@(21)=""
 S:ARDDT'="" @ARFDA@(22)=ARDDT
 S @ARFDA@(23)="OPEN"
 D UPDATE^DIE("E","ARFDA","ARRET","ARMSG")
 I $D(ARMSG("DIERR")) D
 . F MI=1:1:$G(ARMSG("DIERR")) S SDECI=SDECI+1 S @RET@(SDECI)="-1^"_$G(ARMSG("DIERR",MI,"TEXT",1))_$C(30)
 I '$D(ARMSG("DIERR")) S SDECI=SDECI+1 S @RET@(SDECI)="0^"_ARIEN_$C(30)
ARX S @RET@(SDECI)=@RET@(SDECI)_$C(31)
 Q
 ;
FNUM(RET) ;file number
 S RET=409.85
 Q RET
 ;
 ;
ARPCSET(SDECY,INP,ARIEN) ;SET update patient contacts in SDEC APPT REQUEST file
 ;ARSETPC(SDECY,INP,ARIEN)  external parameter tag in SDEC
 ;  INP = Patient Contacts separated by ::
 ;            Each :: piece has the following ~~ pieces:  (same as they are passed into SDEC ARLSET)
 ;            1) = (required)    DATE ENTERED external date/time
 ;            2) = (optional)    PC ENTERED BY USER ID or NAME - Pointer to NEW PERSON file or NAME
 ;            4) = (optional)    ACTION - valid values are:
 ;                               CALLED   MESSAGE LEFT   LETTER
 ;            5) = (optional)    PATIENT PHONE Free-Text 4-20 characters
 ;            6) = NOT USED (optional) Comment 1-160 characters
 ;  ARIEN = (required) pointer to SDEC APPT REQUEST file 409.85
 N SDECI,SDTMP,ARMSG1
 S SDECY="^TMP(""SDECAR"","_$J_",""ARSETPC"")"
 K @SDECY
 S SDECI=0
 S @SDECY@(SDECI)="T00030RETURNCODE^T00030TEXT"_$C(30)
 S ARIEN=$G(ARIEN)
 I (ARIEN="")!('$D(^SDEC(409.85,ARIEN,0))) D ERR1^SDECERR(-1,"Invalid wait list ID "_ARIEN_".",SDECI,SDECY) Q
 D AR23^SDECAR2(INP,ARIEN)
 I $D(ARMSG1) D ERR1^SDECERR(-1,"Error storing patient contacts.",SDECI,SDECY) Q
 S SDECI=SDECI+1 S @SDECY@(SDECI)="0^SUCCESS"_$C(30,31)
 Q
 ;
ARDGET(SDECY) ;get values for disposition field of SDEC APPT REQUEST file
 ;ARDGET(SDECY)  external parameter tag is in SDEC
 ;INPUT: none
 ;RETURN:
 ; Successful Return:
 ;  Global array containing a list of the valid DISPOSITION values in which
 ;  each array entry contains the disposition text.
 ; Caught Exception Return:
 ;   A single entry in the Global Array in the format "-1^<error text>"
 ;   "T00020RETURNCODE^T00100TEXT"
 ; Unexpected Exception Return:
 ;     Handled by the RPC Broker.
 ;     M errors are trapped by the use of M and Kernel error handling.
 ;     The RPC execution stops and the RPC Broker sends the error generated
 ;     text back to the client.
 N SDI,SDX,SDXI,SDECI
 S SDECI=0
 K ^TMP("SDEC",$J)
 S SDECY="^TMP(""SDEC"","_$J_")"
 ; data header
 S @SDECY@(SDECI)="T00030TEXT"_$C(30)
 S SDX=$P($G(^DD(409.85,21,0)),U,3)
 F SDI=1:1:$L(SDX,";") D
 .S SDXI=$P(SDX,";",SDI)
 .Q:SDXI=""
 .S SDECI=SDECI+1 S @SDECY@(SDECI)=$P(SDXI,":",2)_$C(30)
 S @SDECY@(SDECI)=@SDECY@(SDECI)_$C(31)
 Q
 ;
ARMRTGET(SDECY,ARIEN) ;GET number of entries and values in MRTC CALC PREF DATES
 ;ARMRTGET(SDECY,ARIEN)
 ;INPUT:
 ; ARIEN - (required) pointer to SDEC APPT REQUEST file
 ;RETURN:
 ; 1st entry contains a count of the number of dates in MRTC CALC PREF DATES
 ; 2-n entry contains each date
 N ARDATA,SDC,SDECI,SDI
 S SDC=0
 S SDECI=1  ;save position 1 for count in SDC
 S SDECY="^TMP(""SDECAR"","_$J_",""ARMRTGET"")"
 K @SDECY
 ; data header
 S @SDECY@(0)="T00030ERRORCODE^T00030MESSAGE"_$C(30)
 S ARIEN=$G(ARIEN)
 I ARIEN="" S @SDECY@(1)="-1^SDEC APPT REQUEST id is required." Q
 I '$D(^SDEC(409.85,+ARIEN,0)) S @SDECY@(1)="-1^Invalid SDEC APPT REQUEST id." Q
 D GETS^DIQ(409.85,+ARIEN,"43.5*","E","ARDATA")
 S SDI=0 F  S SDI=$O(ARDATA(409.851,SDI)) Q:SDI=""  D
 .S SDC=SDC+1
 .S SDECI=SDECI+1 S @SDECY@(SDECI)=ARDATA(409.851,SDI,.01,"E")_$C(30)
 S @SDECY@(1)=SDC_$C(30)
 S @SDECY@(SDECI)=@SDECY@(SDECI)_$C(31)
 Q
 ;
ARMULT(SDECY,ARIEN,MULT)  ;SET MULT APPTS MADE multiple in SDEC APPT REQUEST file. All entries are removed and replaced by the values in MULT
 ;INPUT:
 ; ARIEN - (required) pointer to SDEC APPT REQUEST file (usualy a parent request)
 ; MULT - (optional) list of child pointers to SDEC APPOINTMENT and/or
 ;                    SDEC APPT REQUEST files separated by pipe
 ;        each pipe piece contains the following ~ pieces:
 ;     1. (optional) Appointment Id pointer to SDEC APPOINTMENT
 ;                   file 409.84
 ;     2. (optional) Request Id pointer to SDEC APPT REQUEST
 ;                   file 409.85
 ;RETURN:
 ; ERRORCODE^MESSAGE
 ;
 N MULT1,SDI
 S SDECY="^TMP(""SDECAR"","_$J_",""ARMRTSET"")"
 K @SDECY
 ; data header
 S @SDECY@(0)="T00030ERRORCODE^T00030MESSAGE"_$C(30)
 S ARIEN=$G(ARIEN)
 I ARIEN="" S @SDECY@(1)="-1^SDEC APPT REQUEST id is required." Q
 I '$D(^SDEC(409.85,+ARIEN,0)) S @SDECY@(1)="-1^Invalid SDEC APPT REQUEST id." Q
 S MULT=$G(MULT)
 D MT1(ARIEN)
 I MULT="" S @SDECY@(0)=@SDECY@(0)_$C(31) Q   ;nothing to do
 F SDI=1:1:$L(MULT,"|") D
 .S MULT1=$TR($P(MULT,"|",SDI),"^","~")
 .D AR433^SDECAR2(ARIEN,MULT1)
 S @SDECY@(1)="0^SUCCESS"_$C(30,31)
 Q
ARMRTSET(SDECY,ARIEN,MRTC) ;SET MRTC CALC PREF DATES dates - clears the multiple and sets the new ones that are passed into MRTC
 ;ARMRTSET(SDECY,ARIEN,MRTC)
 ;INPUT:
 ; ARIEN - (required) pointer to SDEC APPT REQUEST file
 ; MRTC  - (optional) MRTC calculated preferred dates separated by pipe |:
 ;                    Each date can be in external format with no time.
 ;RETURN:
 ; ERRORCODE^MESSAGE
 N SDI,MRTC1
 S SDECY="^TMP(""SDECAR"","_$J_",""ARMRTSET"")"
 K @SDECY
 ; data header
 S @SDECY@(0)="T00030ERRORCODE^T00030MESSAGE"_$C(30)
 S ARIEN=$G(ARIEN)
 I ARIEN="" S @SDECY@(1)="-1^SDEC APPT REQUEST id is required." Q
 I '$D(^SDEC(409.85,+ARIEN,0)) S @SDECY@(1)="-1^Invalid SDEC APPT REQUEST id." Q
 S MRTC=$G(MRTC)
 I MRTC="" S @SDECY@(1)="0"_$C(30,31) Q  ;not an error, just nothing to do
 D MT(ARIEN)
 D AR435^SDECAR2(MRTC,ARIEN)
 S @SDECY@(1)="0"_$C(30,31)
 Q
MT(ARIEN)  ; clear out existing MRTC CALC PREF DATES
 N DA,DIK,SDI
 S SDI=0 F  S SDI=$O(^SDEC(409.85,ARIEN,5,SDI)) Q:SDI'>0  D
 .S DIK="^SDEC(409.85,"_ARIEN_",5,"
 .S DA=SDI
 .S DA(1)=ARIEN
 .D ^DIK
 Q
MT1(ARIEN)  ; clear out existing MULT APPTS MADE
 N DA,DIK,SDI
 S SDI=0 F  S SDI=$O(^SDEC(409.85,ARIEN,2,SDI)) Q:SDI'>0  D
 .S DIK="^SDEC(409.85,"_ARIEN_",2,"
 .S DA=SDI
 .S DA(1)=ARIEN
 .D ^DIK
 Q
 ;
ARMRTC(RET,ARIEN) ;GET the number of MRTC appointments made for this request
 ;INPUT:
 ;  ARIEN - (required) pointer to SDEC APPT REQUEST file 409.85
 ;RETURN
 ;  Global array with 1 entry containing the count of appointments made under the COUNT header
 N SDC,SDECI,SDI
 S RET="^TMP(""SDECAR1"","_$J_",""ARMRTC"")"
 K @RET
 S (SDC,SDECI)=0
 S ARIEN=$G(ARIEN)
 I '$D(^SDEC(409.85,ARIEN,0)) S @RET@(1)="-1^Invalid ID"_$C(30,31) Q
 S @RET@(SDECI)="T00030COUNT"_$C(30)
 S @RET@(1)=$$MRTC(ARIEN)_$C(30,31)
 Q
MRTC(ARIEN) ;
 N SDC,SDI
 S SDC=0
 S SDI=0 F  S SDI=$O(^SDEC(409.85,ARIEN,2,SDI)) Q:SDI'>0  D
 .S SDC=SDC+1
 Q SDC
 ;
ARAPPT(SDECY,SDAPPT) ;GET appointment request for given SDEC APPOINTMENT id
 ;INPUT:
 ;  SDAPPT - (required) pointer to SDEC APPOINTMENT file 409.84
 ;RETURN
 ;  Global array with 1 entry containing the REQUEST TYPE and IEN of the associated appointment separated by pipe |:
 ;    1. Request Type - A  APPT
 ;                      C  Consult
 ;                      E  EWL
 ;                      R  Recall
 ;    2. IEN - pointer to either the SDEC APPT REQUEST, REQUEST/CONSULTATION, SD WAIT LIST, or RECALL REMINDERS file
 ;
 N SDECI,SDTYP,SDX,SDY
 S SDECY="^TMP(""SDECAR"","_$J_",""ARAPPT"")"
 K @SDECY
 S SDECI=0
 S @SDECY@(SDECI)="T00030SDAPTYP"_$C(30)
 S SDAPPT=$G(SDAPPT)
 I SDAPPT="" S @SDECY@(1)="-1^SDEC APPOINTMENT id is required."_$C(30,31) Q
 I '$D(^SDEC(409.84,+SDAPPT,0)) S @SDECY@(1)="-1^Invalid SDEC APPOINTMENT ID."_$C(30,31) Q
 S SDX=$$GET1^DIQ(409.84,SDAPPT_",",.22,"I")
 S SDY=$P(SDX,";",2)
 S SDTYP=$S(SDY="SDWL(409.3,":"E|",SDY="GMR(123,":"C|",SDY="SD(403.5,":"R|",SDY="SDEC(409.85,":"A|",1:"")_$P(SDX,";",1)  ;appt request type
 S SDECI=SDECI+1 S @SDECY@(SDECI)=SDTYP_$C(30,31)
 Q
 ;
AUDITGET(SDECY,ARIEN)  ;GET entries from VS AUDIT field of SDEC APPT REQUEST file 409.85
 N ARDATA,SDECI,SDI,SDTMP,SDX
 S SDECY="^TMP(""SDECAR"","_$J_",""AUDITGET"")"
 K @SDECY
 S SDECI=0
 S SDTMP="T00030IEN^T00030ID^T00030DATE^T00030USERIEN^T00030USERNAME"
 S SDTMP=SDTMP_"^T00030CLINIEN^T00030CLINNAME^T00030STOPIEN^T00030STOPNAME"
 S @SDECY@(SDECI)=SDTMP_$C(30)
 ;validate ARIEN
 S ARIEN=$G(ARIEN)
 I '+$D(^SDEC(409.85,+ARIEN,0)) S @SDECY@(1)="-1^Invalid SDEC APPT REQUEST id."_$C(30,31) Q
 S SDI=0 F  S SDI=$O(^SDEC(409.85,+ARIEN,6,SDI)) Q:SDI'>0  D
 .K ARDATA
 .D GETS^DIQ(409.8545,SDI_","_ARIEN_",","**","IE","ARDATA")
 .S SDX="ARDATA(409.8545,"""_SDI_","_ARIEN_","")"
 .S SDTMP=ARIEN_U_SDI_U_@SDX@(.01,"E")_U_@SDX@(1,"I")_U_@SDX@(1,"E")
 .S SDTMP=SDTMP_U_@SDX@(2,"I")_U_@SDX@(2,"E")_U_@SDX@(3,"I")_U_@SDX@(3,"E")
 .S SDECI=SDECI+1 S @SDECY@(SDECI)=SDTMP_$C(30)
 S @SDECY@(SDECI)=@SDECY@(SDECI)_$C(31)
 Q
