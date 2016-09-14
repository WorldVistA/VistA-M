SDEC49 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
PREFSET(SDECY,DFN,PREF) ; Set values to SDEC PREFERENCES AND SPECIAL NEEDS file
 ;PREFSET(SDECY,DFN,PREF)  external parameter tag is in SDEC
 ;INPUT:
 ;  DFN  = (integer) Patient ID - Pointer to the PATIENT file 2  (lookup by name is not accurate if duplicates)
 ;  PREF = List of preference data separated by ^
 ;         Each ^ piece contains the following Pipe pieces |:
 ;          1. (required)       Preference text; precede text with @ to delete
 ;                              use SDEC PREFGETV to get current valid values.
 ;                              Valid values at this time are:
 ;                                GENDER SPECIFIC PROVIDER
 ;                                HEARING IMPAIRED
 ;                                LANGUAGE PREFERENCE
 ;                                NEEDS ESCORT
 ;                                ON STRETCHER
 ;                                SPECIAL MODE OF TRANSPORTATION
 ;                                MORNING
 ;                                AFTERNOON
 ;                                MONDAY
 ;                                TUESDAY
 ;                                WEDNESDAY
 ;                                THURSDAY
 ;                                FRIDAY
 ;          2. (optional)       Date/Time preference added in external format - defaults to NOW (new entry only)
 ;          3. (optional)       Added by User - Pointer to NEW PERSON file - defaults to Current User (new entry only)
 ;          4. (optional)       Date/Time Inactivated in external format  default to NOW if active flag set to inactive
 ;          5. (optional)       Inactivated by user - Pointer to NEW PERSON file default to current user if active flag set to inactive
 ;          6. (optional )      Remarks single string of text will be converted to word processor format.
 ;                              @ deletes previous Remark
 ;          7. (optional)       active flag 0=inactive; 1=active; default to active
 ;RETURN:
 ; Successful Return:
 ;   A single entry in the Global Array in the format "0^<optional msg text>"
 ;   "T00020RETURNCODE^T00100TEXT"
 ; Caught Exception Return:
 ;   A single entry in the Global Array in the format "-1^<error text>"
 ;   "T00020RETURNCODE^T00100TEXT"
 ; Unexpected Exception Return:
 ;     Handled by the RPC Broker.
 ;     M errors are trapped by the use of M and Kernel error handling.
 ;     The RPC execution stops and the RPC Broker sends the error generated
 ;     text back to the client.
 ;
 N PIEN,PIEN1,SDFDA,SDI,SDIEN,SDACT,SDINOD,SDINOD1,SDMSG,SDPREF,SDQUIT,SDREMARK,X,Y,%DT
 S SDECI=0
 K ^TMP("SDEC",$J)
 S SDECY="^TMP(""SDEC"","_$J_")"
 ; data header
 S @SDECY@(0)="T00020RETURNCODE^T00100TEXT"_$C(30)
 ;check for valid Patient
 I '+DFN D ERR1^SDECERR(1,"Invalid Patient ID.",.SDECI,SDECY) Q
 I '$D(^DPT(DFN,0)) D ERR1^SDECERR(1,"Invalid Patient ID.",.SDECI,SDECY) Q
 ;check for existing patient entry
 S PIEN=$O(^SDEC(409.845,"B",DFN,0))
 ;add new patient entry
 I 'PIEN D
 .S SDFDA(409.845,"+1,",.01)=DFN
 .D UPDATE^DIE("","SDFDA","SDIEN","SDMSG")
 .S PIEN=$G(SDIEN(1))
 I 'PIEN D ERR1^SDECERR(1,"Error adding patient "_DFN_" to SDEC PREFERENCES AND SPECIAL NEEDS file.",.SDECI,SDECY) Q
 ;get list of valid preferences
 D PREF(.SDPREF)   ;SDPREF(<TEXT>)=<CODE>
 ;add preference data
 F SDI=1:1:$L(PREF,"^") D
 .S SDINOD=$P(PREF,"^",SDI)
 .Q:SDINOD=""
 .I $E($P(SDINOD,"|",1),1)="@" D  Q
 ..I $D(SDPREF($P($P(SDINOD,"|",1),"@",2))) D  Q
 ...;delete this preference if @
 ...K SDFDA,SDMSG
 ...S PIEN1=$O(^SDEC(409.845,PIEN,1,"B",SDPREF($P($P(SDINOD,"|",1),"@",2)),0))
 ...Q:'PIEN1
 ...S SDFDA=$NA(SDFDA(409.8451,PIEN1_","_PIEN_","))
 ...S @SDFDA@(.01)="@"
 ...D UPDATE^DIE("","SDFDA","","SDMSG")
 .I '$D(SDPREF($P(SDINOD,"|",1))) Q
 .S PIEN1=$O(^SDEC(409.845,PIEN,1,"B",SDPREF($P(SDINOD,"|",1)),0))
 .;quit if no changes to this preference
 .;I PIEN1="",$P(SDINOD,"|",7)'=1 Q
 .S SDQUIT=0
 .;I PIEN1'="" D
 .;.D GETS^DIQ(409.8451,PIEN1_","_PIEN_",","**","IE","SDINOD1","WLMSG")
 .;.S SDACT=SDINOD1(409.8451,PIEN1_","_PIEN_",",4,"I")'=""   ;)&(SDINOD1(409.8451,PIEN1_","_PIEN_",",5,"I")="")
 .;.S SDQUIT=$S((SDACT=1)&($P(SDINOD,"|",7)=1):1,(SDACT'=1)&($P(SDINOD,"|",7)'=1):1,1:0)
 .Q:+SDQUIT
 .;edit preference record
 .I +PIEN1 D
 ..K SDFDA,SDIEN,SDMSG
 ..S SDFDA=$NA(SDFDA(409.8451,PIEN1_","_PIEN_","))
 ..;I $P(SDINOD,"|",2)'="" S %DT="TX" S X=$P(SDINOD,"|",2) D ^%DT S @SDFDA@(2)=$S(Y=-1:$$NOW^XLFDT,1:Y)  ;date/time added
 ..;I $P(SDINOD,"|",3)'="" S @SDFDA@(3)=$S(+$P(SDINOD,"|",3):+$P(SDINOD,"|",3),1:DUZ)     ;added by user
 ..S @SDFDA@(4)=$S($P(SDINOD,"|",7)=1:"",1:$$TIME($P(SDINOD,"|",4)))  ;1=active
 ..S @SDFDA@(5)=$S($P(SDINOD,"|",7)=1:"",1:$$USER($P(SDINOD,"|",5)))  ;1=active
 ..D UPDATE^DIE("","SDFDA","","SDMSG")
 .;
 .;add new preference record
 .I '+PIEN1 D
 ..K SDFDA,SDIEN,SDMSG
 ..S SDFDA=$NA(SDFDA(409.8451,"+1,"_PIEN_","))
 ..S @SDFDA@(.01)=SDPREF($P(SDINOD,"|",1))   ;preference code
 ..S %DT="TX" S X=$P(SDINOD,"|",2) D ^%DT S @SDFDA@(2)=$S(Y=-1:$$NOW^XLFDT,1:Y)  ;date/time added
 ..S @SDFDA@(3)=$S(+$P(SDINOD,"|",3):+$P(SDINOD,"|",3),1:DUZ)     ;added by user
 ..S @SDFDA@(4)=$S($P(SDINOD,"|",7)=1:"",1:$$TIME($P(SDINOD,"|",4)))
 ..S @SDFDA@(5)=$S($P(SDINOD,"|",7)=1:"",1:$$USER($P(SDINOD,"|",5)))
 ..;I $P(SDINOD,"|",4)'="" S %DT="TX" S X=$P(SDINOD,"|",4) D ^%DT I Y'=-1 S @SDFDA@(4)=Y
 ..;I +$P(SDINOD,"|",5) S @SDFDA@(5)=+$P(SDINOD,"|",5)
 ..D UPDATE^DIE("","SDFDA","SDIEN","SDMSG")
 ..S PIEN1=SDIEN(1)
 .;add/edit remark
 .I +PIEN1,$P(SDINOD,"|",6)'="" D
 ..K SDMSG
 ..S SDREMARK=$P(SDINOD,"|",6)
 ..I SDREMARK]"" S SDREMARK(.5)=SDREMARK,SDREMARK="" D
 ...D WP^DIE(409.8451,PIEN1_","_PIEN_",",6,"","SDREMARK","SDMSG")
 ;
 S SDECI=SDECI+1 S @SDECY@(SDECI)="0^COMPLETED"_$C(30,31)
 Q
 ;
 ;===============================================================
 ;
PREFGET(SDECY,DFN,INAC) ; Get values from SDEC PREFERENCES AND SPECIAL NEEDS file
 ;PREFGET(SDECY,DFN,INAC)  external parameter tag is in SDEC
 ;INPUT:
 ;  DFN  = (integer) Patient ID - Pointer to the PATIENT file 2  (lookup by name is not accurate if duplicates)
 ;  INAC = (optional) include inactive entries
 ;RETURN:
 ; Successful Return:
 ;  Global array containing a list of preferences in which each array entry contains preference data separated by ^:
 ;         the ^ pieces are as follows:
 ;          1. (integer)        Patient ID - pointer to PATIENT file
 ;          2. (text)           Preference text
 ;          3. (date/time)      Date/Time preference added in external format - defaults to NOW
 ;          4. (integer)        Added by User - Pointer to NEW PERSON file - defaults to Current User
 ;          5. (text)           Added by User Name
 ;          6. (date/time)      Date/Time Inactivated in external format
 ;          7. (integer)        Inactivated by user - Pointer to NEW PERSON file
 ;          8. (text)           Inactivated by user Name
 ;          9. (text)      Remarks are returned as a single string of text that may be delimited by carriage return/line feed $c(13,10).
 ;             1         2               3                4
 ;      "T00020DFN^T00030PREF_TEXT^T00020DATE_ADDED^T00030ADDED_BY_USER_IEN"
 ;              5                        6                      7
 ;       ^T00030ADDED_BY_USER_NAME^T00020DATE_INACTIVATED^T00030INACTIVATED_BY_USER_IEN"
 ;              8                              9
 ;       ^T00030INACTIVATED_BY_USER_NAME^T00100REMARKS"_$C(30)
 ; Caught Exception Return:
 ;   A single entry in the Global Array in the format "-1^<error text>"
 ;   "T00020RETURNCODE^T00100TEXT"
 ; Unexpected Exception Return:
 ;     Handled by the RPC Broker.
 ;     M errors are trapped by the use of M and Kernel error handling.
 ;     The RPC execution stops and the RPC Broker sends the error generated
 ;     text back to the client.
 ;
 N PIEN,PIEN1,PIEN1NOD
 N SDFDA,SDI,SDIEN,SDINOD,SDMSG,SDPREF,SDREMARK,SDTMP,SDWP,SDWPA
 N X
 S SDECI=0
 K ^TMP("SDEC",$J)
 S SDECY="^TMP(""SDEC"","_$J_")"
 ; data header
 S @SDECY@(SDECI)="T00020RETURNCODE^T00100TEXT"_$C(30)
 ;check for valid Patient
 I '+$G(DFN) D ERR1^SDECERR(-1,"Invalid Patient ID.",.SDECI,SDECY) Q
 I '$D(^DPT(DFN,0)) D ERR1^SDECERR(-1,"Invalid Patient ID.",.SDECI,SDECY) Q
 ;              1         2               3                4
 S SDTMP="T00020DFN^T00030PREF_TEXT^T00020DATE_ADDED^T00030ADDED_BY_USER_IEN"
 ;                     5                        6                      7
 S SDTMP=SDTMP_"^T00030ADDED_BY_USER_NAME^T00020DATE_INACTIVATED^T00030INACTIVATED_BY_USER_IEN"
 ;                     8                              9
 S SDTMP=SDTMP_"^T00030INACTIVATED_BY_USER_NAME^T00100REMARKS"_$C(30)
 S @SDECY@(SDECI)=SDTMP
 ;check for existing patient entry in SDEC PREFERENCES AND SPECIAL NEEDS file
 S PIEN=$O(^SDEC(409.845,"B",DFN,0))
 I '+PIEN S @SDECY@(SDECI)=@SDECY@(SDECI)_$C(31) Q
 D PREF1(.SDPREF)    ;SDPREF(<CODE>)=<TEXT>
 S PIEN1=0 F  S PIEN1=$O(^SDEC(409.845,PIEN,1,PIEN1)) Q:PIEN1'>0  D
 .S PIEN1NOD=^SDEC(409.845,PIEN,1,PIEN1,0)
 .I '+$G(INAC) Q:$P(PIEN1NOD,U,4)'=""
 .S SDTMP=DFN_U_SDPREF($P(PIEN1NOD,U,1))_U_$$FMTE^XLFDT($P(PIEN1NOD,U,2),8)_U_$P(PIEN1NOD,U,3)_U_$P($G(^VA(200,+$P(PIEN1NOD,U,3),0)),U,1)
 .S SDTMP=SDTMP_U_$S($P(PIEN1NOD,U,4)'="":$$FMTE^XLFDT($P(PIEN1NOD,U,4),8),1:"")_U_$P(PIEN1NOD,U,5)
 .S SDTMP=SDTMP_U_$S($P(PIEN1NOD,U,5)'="":$P($G(^VA(200,+$P(PIEN1NOD,U,5),0)),U,1),1:"")
 .;get remark
 .K SDWP S X=$$GET1^DIQ(409.8451,PIEN1_","_PIEN_",",6,"","SDWP","SDMSG")
 .S SDWPA=""
 .S SDI=0 F  S SDI=$O(SDWP(SDI)) Q:SDI=""  D
 ..S SDWPA=$S(SDWPA'="":SDWPA_$C(13,10),1:"")_SDWP(SDI)
 .S:SDWPA'="" SDTMP=SDTMP_U_SDWPA
 .S SDECI=SDECI+1 S @SDECY@(SDECI)=SDTMP_$C(30)
 S @SDECY@(SDECI)=@SDECY@(SDECI)_$C(31)
 Q
 ;
 ;=================================================
 ;
PREFGETV(SDECY) ;
 ;PREFGETV(SDECY)  external parameter tag is in SDEC
 ;INPUT: none
 ;RETURN:
 ; Successful Return:
 ;  Global array containing a list of the valid Preferences in which each array entry contains the preference text.
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
 S SDX=$P($G(^DD(409.8451,.01,0)),U,3)
 F SDI=1:1:$L(SDX,";") D
 .S SDXI=$P(SDX,";",SDI)
 .Q:SDXI=""
 .S SDECI=SDECI+1 S @SDECY@(SDECI)=$P(SDXI,":",2)_$C(30)
 S @SDECY@(SDECI)=@SDECY@(SDECI)_$C(31)
 Q
 ;
 ;=================================================
 ;
PREF(PREF) ;
 N SDI,SDX,SDXI
 S SDX=$P($G(^DD(409.8451,.01,0)),U,3)
 F SDI=1:1:$L(SDX,";") D
 .S SDXI=$P(SDX,";",SDI)
 .Q:SDXI=""
 .S PREF($P(SDXI,":",2))=$P(SDXI,":",1)
 Q
 ;
PREF1(PREF) ;
 N SDI,SDX,SDXI
 S SDX=$P($G(^DD(409.8451,.01,0)),U,3)
 F SDI=1:1:$L(SDX,";") D
 .S SDXI=$P(SDX,";",SDI)
 .Q:SDXI=""
 .S PREF($P(SDXI,":",1))=$P(SDXI,":",2)
 Q
 ;
TIME(TIME)  ;
 ;INPUT:
 ; TIME = date/time in external form
 N RET,X,Y,%DT
 S RET=""
 S TIME=$G(TIME)
 I TIME'="" S %DT="TX" S X=TIME D ^%DT S RET=Y I Y=-1 S RET=""
 I RET="" S RET=$E($$NOW^XLFDT,1,12)
 Q RET
 ;
USER(USER)  ;
 ;INPUT:
 ; USER = user pointer to NEW PERSON file
 N RET
 S RET=""
 S USER=$G(USER)
 I USER'="" I $D(^VA(200,USER,0)) S RET=USER
 I RET="" S RET=DUZ
 Q RET
