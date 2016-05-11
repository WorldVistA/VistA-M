SDEC52A ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
RECSET(SDECY,INP) ; SET/EDIT an entry to the RECALL REMINDERS file 403.5
 ;RECSET(SDECY,INP...)  external parameter tag is in SDEC
 ;INPUT:
 ;  INP - Input array
 ;   INP(1) - (optional) IEN pointer to RECALL REMINDERS
 ;                       a new entry will be added if null
 ;   INP(2) - (required) DFN Pointer to PATIENT file
 ;   INP(3) - (optional) Accession # (free-text 1-25 characters)
 ;   INP(4) - (optional) COMMENT (free-text 1-80 characters)
 ;   INP(5) - (optional) FAST/NON-FASTING  valid values:
 ;                                           FASTING
 ;                                           NON-FASTING
 ;   INP(6) - (required) Test/App pointer to RECALL REMINDERS APPT TYPE file 403.51
 ;   INP(7) - (required) Provider - Pointer to RECALL REMINDERS PROVIDERS file 403.54
 ;   INP(8) - (required) Clinic pointer to HOSPITAL LOCATION file
 ;   INP(9) - (optional) Length of Appointment  numeric between 10 and 120
 ;   INP(10) - (required) Recall Date in external format (no time)
 ;   INP(11)- (optional) Recall Date (Per patient) in external format (no time)
 ;   INP(12)- (optional) Date Reminder Sent in external format (no time)
 ;   INP(13)- (optional) User Who Entered Recall pointer to NEW PERSON file; default to current user
 ;   INP(14)- (optional) Second Print Date in external format (no time)
 ;   INP(15)- (optional) DATE/TIME Recall Added in external format
 ;RETURN:
 ; Successful Return:
 ;   Single Value return in the format "0^<Recall Reminders ien>"
 ; Caught Exception Return:
 ;   A single entry in the Global Array in the format "-1^<error text>"
 ;   "T00020RETURNCODE^T00100TEXT"
 ; Unexpected Exception Return:
 ;     Handled by the RPC Broker.
 ;     M errors are trapped by the use of M and Kernel error handling.
 ;     The RPC execution stops and the RPC Broker sends the error generated
 ;     text back to the client.
 ;
 N APPTLEN,CLINIEN,DATE1,DATE,DATE2,DATE3,DAPTDT,DFN,FASTING,ORGDT
 N PROVIEN,RECALLIEN,RRAPPTYP,RRNOD,RRPROVIEN
 N SDFDA,SDIEN,SDMSG,SDRET
 N X,Y,%DT
 K ^TMP("SDEC52",$J,"RECSET")
 ; data header
 S SDECY="I00020ERRORID^T00030ERRORTEXT"_$C(30)
 ;
 ;check IEN of RECALL REMINDERS if passed in (optional)
 S RECALLIEN=$G(INP(1))
 I RECALLIEN'="" I '$D(^SD(403.5,+RECALLIEN)) S SDECY=SDECY_"-1^Invalid RECALL REMINDERS id."_$C(30,31) Q
 I RECALLIEN'="" S RRNOD=$G(^SD(403.5,+RECALLIEN,0))
 I RECALLIEN="" S RECALLIEN="+1"
 ;
 ;check provider (required)
 S RRPROVIEN=$G(INP(7))
 I +RRPROVIEN I '$D(^SD(403.54,+RRPROVIEN)) S SDECY=SDECY_"-1^Invalid RECALL REMINDERS PROVIDERS id."_$C(30,31) Q
 I '+RRPROVIEN,RECALLIEN="+1" S SDECY=SDECY_"-1^RECALL REMINDERS PROVIDERS id is required."_$C(30,31) Q
 ;check that user has the correct security key
 S SDRET=$$KEY(RRPROVIEN) I SDRET S SDECY=SDECY_SDRET_$C(30,31) Q
 ;check for valid Patient (required)
 S DFN=$G(INP(2))
 I +DFN I '$D(^DPT(+DFN,0)) S SDECY=SDECY_"-1^Invalid Patient ID."_$C(30,31) Q
 I '+DFN,RECALLIEN="+1" S SDECY=SDECY_"-1^Patient ID is required."_$C(30,31) Q
 ;check Test/App pointer (required)
 S RRAPPTYP=$G(INP(6))
 I +RRAPPTYP I '$D(^SD(403.51,+RRAPPTYP)) S SDECY=SDECY_"-1^Invalid RECALL REMINDERS APPT TYPE id."_$C(30,31) Q
 I '+RRAPPTYP,RECALLIEN="+1" S SDECY=SDECY_"-1^RECALL REMINDERS APPT TYPE is required."_$C(30,31) Q
 ;check Clinic (required)
 S CLINIEN=$G(INP(8))
 I +CLINIEN I '$D(^SC(+CLINIEN)) S SDECY=SDECY_"-1^Invalid Clinic id."_$C(30,31) Q
 I '+CLINIEN,RECALLIEN="+1" S SDECY=SDECY_"-1^Clinic ID is required."_$C(30,31) Q
 ;check Recall Date (required)
 S DATE=$G(INP(10))
 I DATE'="" S %DT="" S X=$P(DATE,"@",1) D ^%DT S DATE=Y I Y=-1 S SDECY=SDECY_"-1^Invalid Recall Date."_$C(30,31) Q
 I DATE="",RECALLIEN="+1" S SDECY=SDECY_"-1^Recall Date is required."_$C(30,31) Q
 ;
 ;check FAST/NON-FASTING (optional)
 S FASTING=$G(INP(5))
 I FASTING'="" S FASTING=$S($$UP^XLFSTR(FASTING)="FASTING":"f",$$UP^XLFSTR(FASTING)="NON-FASTING":"n",$$UP^XLFSTR(FASTING)="F":"f",$$UP^XLFSTR(FASTING)="N":"n",1:"")
 ;check Length of Appointment (optional)
 S APPTLEN=$G(INP(9))
 I APPTLEN'="" I APPTLEN<10,APPTLEN>120 S APPTLEN=""
 ;check Recall Date (per Patient) (optional)
 S DATE1=$G(INP(11))
 I DATE1'="" S %DT="" S X=$P(DATE1,"@",1) D ^%DT S DATE1=Y I Y=-1 S DATE1=""
 ;check date reminder sent (optional)
 S DAPTDT=$G(INP(12))
 I DAPTDT'="" S %DT="" S X=$P(DAPTDT,"@",1) D ^%DT S DAPTDT=Y I Y=-1 S ORGDT=""
 ;check User Who Entered Recall (optional) default to current
 S PROVIEN=$G(INP(13))
 I (PROVIEN="")!('$D(^VA(200,+PROVIEN))) S PROVIEN=DUZ
 ;check Second Print date (optional)
 S DATE2=$G(INP(14))
 I DATE2="" S %DT="" S X=$P(DATE2,"@",1) D ^%DT S DATE2=Y I Y=-1 S DATE2=""
 ;check DATE/TIME RECALL ADDED (optional)
 S DATE3=$G(INP(15))
 I DATE3'="" S %DT="" S X=$P(DATE3,"@",1) D ^%DT S DATE3=Y I Y=-1 S DATE3=""
 I DATE3'="",$G(RRNOD)'="",$P(RRNOD,U,14)'="" S DATE3=""   ;only add DATE/TIME RECALL ADDED if it is not already there
 ;
 S SDFDA=$NA(SDFDA(403.5,RECALLIEN_","))
 S @SDFDA@(.01)=DFN
 S:$G(INP(3))'="" @SDFDA@(2)=$E(INP(3),1,25)
 S:$G(INP(4))'="" @SDFDA@(2.5)=$E(INP(4),1,80)
 S:$G(FASTING)'="" @SDFDA@(2.6)=FASTING
 S @SDFDA@(3)=RRAPPTYP
 S @SDFDA@(4)=RRPROVIEN
 S @SDFDA@(4.5)=CLINIEN
 S:APPTLEN'="" @SDFDA@(4.7)=APPTLEN
 S @SDFDA@(5)=DATE
 S:DATE1'="" @SDFDA@(5.5)=DATE1
 S:DAPTDT'="" @SDFDA@(6)=DAPTDT
 S @SDFDA@(7)=PROVIEN
 S:DATE3'="" @SDFDA@(7.5)=DATE3
 S:DATE2'="" @SDFDA@(8)=DATE2
 D UPDATE^DIE("","SDFDA","SDIEN","SDMSG")
 S:RECALLIEN="+1" RECALLIEN=SDIEN(1)
 I $D(SDMSG) S SDECY=SDECY_"-1^Error updating RECALL REMINDERS file"_$C(30,31)
 I '$D(SDMSG) S SDECY=SDECY_"0^"_$S(RECALLIEN'="":RECALLIEN,1:SDIEN(1))_$C(30,31)
 Q
 ;
RECDSET(SDECY,RECALLIEN,SDRRFTR,SDCOMM) ; DELETE an entry to the RECALL REMINDERS file 403.5
 ;RECDSET(SDECY,RECALLIEN,SDRRFTR,SDCOMM)  external parameter tag is in SDEC
 ;INPUT:
 ;  INP - Input array
 ;   RECALLIEN - (required) IEN pointer to RECALL REMINDERS
 ;   SDRRFTR   - (optional) Recall Disposition used to populate the
 ;                          DELETE REASON field in the RECALL REMINDERS
 ;                          REMOVED file 403.56 when an entry is removed
 ;                          from RECALL REMINDERS file. Valid Values are:
 ;                            FAILURE TO RESPOND
 ;                            MOVED
 ;                            DECEASED
 ;                            DOESN'T WANT VA SERVICES
 ;                            RECEIVED CARE AT ANOTHER VA
 ;                            OTHER
 ;                            APPT SCHEDULED
 ;   SDCOMM  - (optional) Text to replace the text in the COMMENT
 ;                        Field 2.5 in RECALL REMINDERS prior to the
 ;                       delete which moves the data including this
 ;                       comment to RECALL REMINDERS REMOVED
 ;RETURN:
 ; Successful Return:
 ;   Single Value return in the format "0^<Recall Reminders ien>"
 ; Caught Exception Return:
 ;   Single Value return in the format "-1^<error text>"
 ;   "T00020ERRORID^T00100ERRORTEXT"
 ; Unexpected Exception Return:
 ;     Handled by the RPC Broker.
 ;     M errors are trapped by the use of M and Kernel error handling.
 ;     The RPC execution stops and the RPC Broker sends the error generated
 ;     text back to the client.
 ;
 N APPTLEN,DATE1,DATE,DATE2,DAPTDT,DFN,FASTING,PROVIEN,RRAPPTYP,SDFDA,SDIEN,SDMSG,SDRET
 ; data header
 S SDECY="I00020ERRORID^T00030ERRORTEXT"_$C(30)
 ;
 ;check IEN of RECALL REMINDERS (required)
 I (RECALLIEN="")!('$D(^SD(403.5,+RECALLIEN))) S SDECY=SDECY_"-1^Invalid RECALL REMINDERS id."_$C(30,31) Q
 ;check disposition (optional)
 S SDRRFTR=$G(SDRRFTR)
 I SDRRFTR'="" S SDRRFTR=$S(SDRRFTR="FAILURE TO RESPOND":1,SDRRFTR="MOVED":2,SDRRFTR="DECEASED":3,SDRRFTR="DOESN'T WANT VA SERVICES":4,SDRRFTR="RECEIVED CARE AT ANOTHER VA":5,SDRRFTR="OTHER":6,SDRRFTR="APPT SCHEDULED":7,1:"")
 I SDRRFTR="" K SDRRFTR
 ;
 ;check provider (required)
 ;I +RRPROVIEN I '$D(^SD(403.54,+RRPROVIEN)) S SDECY=SDECY_"-1^Invalid RECALL REMINDERS PROVIDERS id."_$C(30,31) Q
 ;I '+RRPROVIEN S SDECY=SDECY_"-1^RECALL REMINDERS PROVIDERS id is required."_$C(30,31) Q
 S RRPROVIEN=$P($G(^SD(403.5,+RECALLIEN,0)),U,5)
 I '$D(^SD(403.54,+RRPROVIEN)) S SDECY=SDECY_"-1^Invalid RECALL REMINDERS PROVIDERS defined in RECALL REMINDERS file for id "_RECALLIEN_"."_$C(30,31) Q
 ;
 ;verify comment (optional)
 S SDCOMM=$G(SDCOMM)
 I SDCOMM'="" D  ;replace existing comment before calling move/delete
 .K SDFDA
 .S SDFDA(403.5,RECALLIEN_",",2.5)=$E(SDCOMM,1,80)
 .D UPDATE^DIE("","SDFDA")
 ;
 S SDRET=$$RECSETD(RECALLIEN,RRPROVIEN)
 S SDECY=SDECY_SDRET_$C(30,31)
 Q
 ;
RECSETD(RECALLIEN,RRPROVIEN) ;delete entry
 ;INPUT
 ; RECALLIEN - Pointer to RECALL REMINDERS file
 ; RRPROVIEN
 ;RETURN
 ; "0^<TEXT>"  = delete successful
 ; "-1^<TEXT>" = delete unsuccessful
 N RET,SDFDA,SDIEN,SDMSG
 S RET=$$KEY(RECALLIEN,RRPROVIEN)
 Q:RET RET
 S SDFDA=$NA(SDFDA(403.5,RECALLIEN_","))
 S @SDFDA@(.01)="@"
 D UPDATE^DIE("","SDFDA","SDIEN","SDMSG")
 I $D(SDMSG) S RET="-1^Error deleting RECALL REMINDERS file"_$C(30,31)
 I '$D(SDMSG) S RET="0^"_RECALLIEN
 Q RET
 ;
KEY(RECALLIEN,RRPROVIEN) ;check that user has the correct SECURITY KEY
 ;INPUT:
 ; RRPROVIEN - Pointer to RECALL REMINDERS PROVIDERS file 403.54
 ;RETURN
 ;  0=User has the correct SECURITY KEY
 ;  "-1^<text>" = User does not have the correct SECURITY KEY
 N KEY,KY,RET,SDPRV,SDFLAG
 S RET="-1^THE PROVIDER ASSIGNED TO THIS RECALL REMINDER IS ASSIGNED A SECURITY KEY WHICH YOU DO NOT HAVE. PLEASE CONTACT YOUR RECALL COORDINATOR."
 S (SDPRV,KEY,SDFLAG)="" S SDPRV=$P($G(^SD(403.5,+RECALLIEN,0)),U,5) D
 .I SDPRV="" S RET=0
 .I SDPRV'="" S KEY=$P($G(^SD(403.54,SDPRV,0)),U,7) D
 ..I KEY="" S RET=0 Q
 ..N VALUE
 ..S VALUE=$$LKUP^XPDKEY(KEY) K KY D OWNSKEY^XUSRB(.KY,VALUE,DUZ)
 ..I $G(KY(0))'=0 S RET=0
 Q RET
