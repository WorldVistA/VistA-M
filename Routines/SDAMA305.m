SDAMA305 ;BPOIFO/ACS-Filter API Get Data ; 6/21/05 1:50pm
 ;;5.3;Scheduling;**301,347,508**;13 Aug 1993
 ;PER VHA DIRECTIVE 2004-038, DO NOT MODIFY THIS ROUTINE
 ;
 ;*****************************************************************
 ;              CHANGE LOG
 ;
 ;  DATE      PATCH       DESCRIPTION
 ;--------  ----------    -----------------------------------------
 ;12/04/03  SD*5.3*301    ROUTINE COMPLETED
 ;08/06/04  SD*5.3*347    ADDITION OF A NEW FILTER - DATE APPOINTMENT
 ;                        MADE (FIELD #16) AND 2 NEW FIELDS TO RETURN:
 ;                        1) AUTO-REBOOKED APPT DATE/TIME (FIELD #24)
 ;                        2) NO-SHOW/CANCEL APPT DATE/TIME (FIELD #25)
 ;                        RENAME ENTRY POINT TO ROUTINE
 ;02/22/07  SD*5.3*508    SEE SDAMA301 FOR CHANGE LIST
 ;*****************************************************************
 ;
 ;*****************************************************************
 ;              GET APPOINTMENT DATA FROM VISTA            
 ;INPUT
 ;  SDARRAY    Appointment Filter array
 ;  
 ;OUTPUT
 ;  ^TMP($J,"SDAMA301",SORT1,SORT2,APPT D/T)
 ;*****************************************************************
SETARRAY(SDARRAY) ;
 ;Initialize local variables
 N SDI,SDIEN,SDNAME,SDFLDS,SDDATA,SDCOUNT,SDFIELD,SDCLIEN,SDDV,SDSCRTCH
 S SDFLDS=SDARRAY("FLDS")
 S SDCOUNT=$L(SDFLDS,";")
 ;Add 1 to appointment count
 S SDARRAY("CNT")=(SDARRAY("CNT")+1)
 ;For each appoitment field requested
 F SDI=1:1:SDCOUNT D
 . S (SDIEN,SDNAME,SDDATA)=""
 . S SDFIELD=$P(SDFLDS,";",SDI)
 . ;get data
 . D @SDFIELD
 . ;nodes in output global can't be null
 . I $G(SDARRAY("SORT1"))="" S SDARRAY("SORT1")="X"_SDARRAY("CNT")
 . I $G(SDARRAY("SORT2"))="" S SDARRAY("SORT2")="Y"_SDARRAY("CNT")
 . ;add data to output array
 . ;Store information with just Patient IEN (No Clinic IEN) in the global reference
 . I $G(SDARRAY("SORT"))="P" D
 . .S:(SDFIELD<28) $P(^TMP($J,"SDAMA301",$G(SDARRAY("PAT")),SDARRAY("DATE")),"^",SDFIELD)=$S(SDFIELD=6:"",1:$G(SDDV(SDFIELD)))
 . .S:(SDFIELD>27) $P(^TMP($J,"SDAMA301",$G(SDARRAY("PAT")),SDARRAY("DATE"),0),"^",(SDFIELD#27))=$G(SDDV(SDFIELD))
 . .S:(SDFIELD=6) ^TMP($J,"SDAMA301",$G(SDARRAY("PAT")),SDARRAY("DATE"),"C")=$G(SDDV(SDFIELD))
 . ;Store information with Patient and Clinic IEN (Sort1, Sort2) in the global reference
 . I $G(SDARRAY("SORT"))'="P" D
 . .S:(SDFIELD<28) $P(^TMP($J,"SDAMA301",SDARRAY("SORT1"),SDARRAY("SORT2"),SDARRAY("DATE")),"^",SDFIELD)=$S(SDFIELD=6:"",1:$G(SDDV(SDFIELD)))
 . .S:(SDFIELD>27) $P(^TMP($J,"SDAMA301",SDARRAY("SORT1"),SDARRAY("SORT2"),SDARRAY("DATE"),0),"^",(SDFIELD#27))=$G(SDDV(SDFIELD))
 . .S:(SDFIELD=6) ^TMP($J,"SDAMA301",SDARRAY("SORT1"),SDARRAY("SORT2"),SDARRAY("DATE"),"C")=$G(SDDV(SDFIELD))
 Q
1 ;Appt date/time
 S SDDV(SDFIELD)=SDARRAY("DATE")
 Q
2 ;Clinic IEN and Name
 S SDIEN=+$G(SDARRAY("DPT0"))
 I '$G(SDIEN) S SDNAME=""
 E  S SDNAME=$P($G(^SC(SDIEN,0)),"^",1)
 S SDDV(SDFIELD)=$G(SDIEN)_";"_$G(SDNAME)
 Q
3 ;Appt Status and Status Description
 N SDSTAT
 S SDSTAT=$P($G(SDARRAY("DPT0")),"^",2)
 I $G(SDSTAT)="" S SDDATA="R;SCHEDULED/KEPT"
 E  D
 . S SDDATA=$S(SDSTAT="I":"I;INPATIENT",SDSTAT="C":"CC;CANCELLED BY CLINIC",1:"X")
 . I SDDATA="X" S SDDATA=$S(SDSTAT="CA":"CCR;CANCELLED BY CLINIC & RESCHEDULED",SDSTAT="PC":"CP;CANCELLED BY PATIENT",1:"X")
 . I SDDATA="X" S SDDATA=$S(SDSTAT="PCA":"CPR;CANCELLED BY PATIENT & RESCHEDULED",SDSTAT="N":"NS;NO-SHOW",1:"X")
 . I SDDATA="X" S SDDATA=$S(SDSTAT="NA":"NSR;NO-SHOW & RESCHEDULED",SDSTAT="NT":"NT;NO ACTION TAKEN",1:SDSTAT_";UNKNOWN")
 S SDDV(SDFIELD)=SDDATA
 Q
4 ;Patient IEN and Name
 S SDIEN=$G(SDARRAY("PAT"))
 S SDNAME=$P($G(^DPT(SDIEN,0)),"^",1)
 S SDDV(SDFIELD)=$G(SDIEN)_";"_$G(SDNAME)
 Q
5 ;Length of Appt
 S SDDV(SDFIELD)=$P($G(SDARRAY("SC0")),"^",2)
 Q
6 ;Comments
 S SDDV(SDFIELD)=$P($G(SDARRAY("SC0")),"^",4)
 Q
7 ;Overbook (return null if appt cancelled)
 I $G(SDARRAY("SC0"))'="" D
 . S SDDATA=$P($G(SDARRAY("SCOB")),"^",1)
 . S SDDV(SDFIELD)=$S($G(SDDATA)="O":"Y",1:"N")
 Q
8 ;Local & National Eligiblity of Visit Codes and Names
 N SDELIG,SDPELIG,SDASTS,DFN,VAROOT,VAERR
 S VAERR=0,SDDATA=$P($G(SDARRAY("SC0")),"^",10)
 S SDASTS=$P($G(SDARRAY("DPT0")),"^",2)
 ;if eligibility is null, get patients primary eligibility
 ;  * only if appointment status is not cancelled *
 I (($G(SDDATA)']"")&($G(SDASTS)'["C")) D
 . S VAROOT="SDPELIG",DFN=$G(SDARRAY("PAT")) D ELIG^VADPT
 . S SDDATA=$P(SDPELIG(1),"^")
 ;get local/national eligibility to add to output if
 ;ELIG^VADPT did not error and the ien is not null
 I (('VAERR)&($G(SDDATA)]"")) D
 . S SDELIG=$G(^DIC(8,SDDATA,0))
 . ;Append Local Eligibility IEN and Name
 . S SDDV(SDFIELD)=$G(SDDATA)_";"_$P(SDELIG,"^")
 . ;Append National Eligibility IEN and Name
 . S SDIEN=$P(SDELIG,"^",9)
 . I $G(SDIEN) D
 .. S SDNAME=$P($G(^DIC(8.1,SDIEN,0)),"^",1)
 .. S SDDV(SDFIELD)=SDDV(SDFIELD)_";"_$G(SDIEN)_";"_$G(SDNAME)
 Q
9 ;Check-In Date/time
 S SDSCRTCH=$P($G(SDARRAY("SCC")),"^",1)
 S SDDV(SDFIELD)=$S($L(SDSCRTCH)<13:SDSCRTCH,1:$E(SDSCRTCH,1,12))
 Q
10 ;Appt Type IEN and Name
 S SDIEN=$P($G(SDARRAY("DPT0")),"^",16)
 I $G(SDIEN)]"" D
 . S SDNAME=$P($G(^SD(409.1,SDIEN,0)),"^",1)
 . S SDDV(SDFIELD)=$G(SDIEN)_";"_$G(SDNAME)
 Q
11 ;Check-Out date/time
 S SDSCRTCH=$P($G(SDARRAY("SCC")),"^",3)
 S SDDV(SDFIELD)=$S($L(SDSCRTCH)<13:SDSCRTCH,1:$E(SDSCRTCH,1,12))
 Q
12 ;Outpatient Encounter
 S SDDV(SDFIELD)=$P($G(SDARRAY("DPT0")),"^",20)
 Q
13 ;Primary Stop Code IEN and AMIS STOP CODE
 N SDCODES
 S SDCLIEN=+SDARRAY("DPT0")
 I $G(SDCLIEN)]"" D
 . S SDCODES=$$GETSTOP(SDCLIEN)
 . I SDCODES'=-1 S SDDV(SDFIELD)=$P(SDCODES,"^",1)
 Q
14 ;Credit Stop Code IEN and AMIS STOP CODE
 S SDCLIEN=+SDARRAY("DPT0")
 I $G(SDCLIEN)]"" D
 . S SDCODES=$$GETSTOP(SDCLIEN)
 . I SDCODES'=-1 S SDDV(SDFIELD)=$P(SDCODES,"^",2)
 Q
15 ;Workload Non-Count
 S SDCLIEN=+SDARRAY("DPT0")
 I $G(SDCLIEN)]"" D
 . S SDCODES=$$GETSTOP(SDCLIEN)
 . I SDCODES'=-1 S SDDV(SDFIELD)=$P($G(SDCODES),"^",3)
 Q
16 ;Date Appt Made
 S SDDV(SDFIELD)=$P($P($G(SDARRAY("DPT0")),"^",19),".")
 Q
17 ;Desired Date of Appt
 S SDDV(SDFIELD)=$P($P($G(SDARRAY("DPT1")),"^",1),".")
 Q
18 ;Purpose of Visit
 S SDDATA=$P($G(SDARRAY("DPT0")),"^",7)
 I $G(SDDATA)'="" D
 . S SDDATA=SDDATA_$S(SDDATA="1":";C&P",SDDATA="2":";10-10",SDDATA="3":";SV",SDDATA="4":";UV",1:";")
 . S SDDV(SDFIELD)=SDDATA
 Q
19 ;EKG Date/time
 S SDSCRTCH=$P($G(SDARRAY("DPT0")),"^",5)
 S SDDV(SDFIELD)=$S($L(SDSCRTCH)<13:SDSCRTCH,1:$E(SDSCRTCH,1,12))
 Q
20 ;X-Ray Date/time
 S SDSCRTCH=$P($G(SDARRAY("DPT0")),"^",4)
 S SDDV(SDFIELD)=$S($L(SDSCRTCH)<13:SDSCRTCH,1:$E(SDSCRTCH,1,12))
 Q
21 ;Lab Date/time
 S SDSCRTCH=$P($G(SDARRAY("DPT0")),"^",3)
 S SDDV(SDFIELD)=$S($L(SDSCRTCH)<13:SDSCRTCH,1:$E(SDSCRTCH,1,12))
 Q
22 ;Status 
 ;   (Status IEN; Status Description; Print Status; Checked In Date/Time; 
 ;       Checked Out Date/Time; Admission Movement IEN)       
 ;convert to new appt status code
 D 3
 S SDDV(SDFIELD)=$$STATUS^SDAMA308(+$G(SDARRAY("PAT")),+$G(SDARRAY("DATE")),+$G(SDARRAY("DPT0")),$P(SDDV(SDFIELD),";"),$P($G(SDARRAY("SCC")),"^"),$P($G(SDARRAY("SCC")),"^",3),$P($G(SDARRAY("DPT0")),"^",20))
 Q
23 ;X-Ray Films
 N SDRECS
 ;Get Clinic IEN, X-Ray Films Required
 S SDIEN=+$G(SDARRAY("DPT0"))
 S SDRECS=$P($G(^SC(SDIEN,"RAD")),"^")
 ;Translate Lower Case to Upper
 S SDRECS=$TR(SDRECS,"ny","NY")
 S SDDATA=$S(SDRECS["Y":"Y",1:"N")
 S SDDV(SDFIELD)=SDDATA
 Q
24 ;Auto-Rebooked Appt. Date/Time
 S SDSCRTCH=$P($G(SDARRAY("DPT0")),"^",10)
 S SDDV(SDFIELD)=$S($L(SDSCRTCH)<13:SDSCRTCH,1:$E(SDSCRTCH,1,12))
 Q
25 ;No-Show/Cancel Date/Time
 S SDSCRTCH=$P($G(SDARRAY("DPT0")),"^",14)
 S SDDV(SDFIELD)=$S($L(SDSCRTCH)<13:SDSCRTCH,1:$E(SDSCRTCH,1,12))
 Q
 ;This field is only associated with appt info from RSA 
 ;(No VistA Scheduling Value Exists)
26 ;RSA Appointment ID
 Q
27 ;2507 Request IEN
 ;N SDREQ
 ;retrieve 2507 request for patient's appt
 ;S SDREQ=$$GET2507^DVBCMKLK(+$G(SDARRAY("PAT")),$G(SDARRAY("DATE")))
 ;S SDDV(SDFIELD)=$S((SDREQ>0):SDREQ,1:"")
 Q
28 ;Data Entry Clerk DUZ and Name
 N SDSTAT
 S SDSTAT=$P($G(SDARRAY("DPT0")),"^",2)  ;determine appt status
 ;Appt is deleted from ^SC when appt is cancelled
 S SDSCRTCH=$S(SDSTAT["C":$P($G(SDARRAY("DPT0")),"^",18),1:$P($G(SDARRAY("SC0")),"^",6))
 S:(+SDSCRTCH) SDDV(SDFIELD)=SDSCRTCH_";"_$$GET1^DIQ(200,SDSCRTCH,.01)
 Q
29 ;No-Show/Cancelled By DUZ and Name
 S SDSCRTCH=$P($G(SDARRAY("DPT0")),"^",12)
 S:(+SDSCRTCH) SDDV(SDFIELD)=SDSCRTCH_";"_$$GET1^DIQ(200,SDSCRTCH,.01)
 Q
30 ;Check-In User DUZ and Name
 S SDSCRTCH=$P($G(SDARRAY("SCC")),"^",2)
 S:(+SDSCRTCH) SDDV(SDFIELD)=SDSCRTCH_";"_$$GET1^DIQ(200,SDSCRTCH,.01)
 Q
31 ;Check-Out User DUZ and Name
 S SDSCRTCH=$P($G(SDARRAY("SCC")),"^",4)
 S:(+SDSCRTCH) SDDV(SDFIELD)=SDSCRTCH_";"_$$GET1^DIQ(200,SDSCRTCH,.01)
 Q
32 ;Cancellation Reason IEN and Name
 S SDSCRTCH=$P($G(SDARRAY("DPT0")),"^",15)
 S:(+SDSCRTCH) SDDV(SDFIELD)=SDSCRTCH_";"_$$GET1^DIQ(409.2,SDSCRTCH,.01)
 Q
33 ;Consult Link IEN
 S SDDV(SDFIELD)=$G(SDARRAY("SCONS"))
 Q
GETSTOP(SDCLIEN) ;Primary Stop Code, Credit Stop Code, Non-Count
 ; return codes or -1 if bad clinic
 N SDPSC,SDPSCIEN,SDCSC,SDCSCIEN,SDNC,SDCODES
 I +$G(SDCLIEN)=0 S SDCODES=-1
 I +$G(SDCLIEN)'=0 D
 . ;make sure clinic is on ^SC
 . I '$D(^SC(SDCLIEN)) S SDCODES=-1 Q
 . ;get primary stop code ien
 . S SDPSCIEN=$P($G(^SC(SDCLIEN,0)),"^",7)
 . ;get credit stop code ien
 . S SDCSCIEN=$P($G(^SC(SDCLIEN,0)),"^",18)
 . I $G(SDPSCIEN) S SDPSC=$P($G(^DIC(40.7,SDPSCIEN,0)),"^",2)
 . I $G(SDCSCIEN) S SDCSC=$P($G(^DIC(40.7,SDCSCIEN,0)),"^",2)
 . ;get workload non-count
 . S SDNC=$P($G(^SC(SDCLIEN,0)),"^",17)
 . S SDNC=$S($G(SDNC)="Y":"Y",1:"N")
 . S SDCODES=$G(SDPSCIEN)_";"_$G(SDPSC)_"^"_$G(SDCSCIEN)_";"_$G(SDCSC)_"^"_SDNC
 Q SDCODES
