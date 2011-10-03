SDAMA300 ;BPOIFO/ACS-Filter API Validate Filters ; 9/14/05 7:49am
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
 ;02/22/07  SD*5.3*508    SEE SDAMA301 FOR CHANGE LIST
 ;*****************************************************************
 ;
 ;*****************************************************************
 ;
 ;              VALIDATE FILTER ARRAY CONTENTS
 ;INPUT
 ;  SDARRAY    Appointment filters
 ;  SDFLTR     Filter Flag array
 ;
 ;OUTPUT
 ;  -1 if error
 ;   1 if no errors
 ;
 ;*****************************************************************
VALARR(SDARRAY,SDFLTR) ;
 ;Initialize local variables
 N SDI,SDX,SDQUIT,SDDATA,SDCOUNT,SDERR
 S SDQUIT=0,SDERR=115
 ;
 ;Set filter flags and validate input array entries
 F SDI="MAX","FLDS","FLTRS","SORT","VSTAPPTS","PURGED" Q:SDQUIT  D @SDI
 Q:(SDARRAY("CNT")=-1) -1
 ;filters allowed on these fields
 F SDI=1:1:4,13,16 Q:SDQUIT  D
 . I $G(SDARRAY(SDI))']"" S SDFLTR(SDI)=0
 . E  S SDFLTR(SDI)=1 D
 .. S SDCOUNT=$L(SDARRAY(SDI),";")
 .. S SDQUIT=0
 .. D @SDI
 ;
 I SDQUIT=0 D
 . ;filters not allowed on these fields
 . F SDI=5:1:12,14,15,17:1:26,28:1:SDARRAY("FC") Q:SDQUIT  D NOFIL
 Q SDARRAY("CNT")
 ;
 ;*****************************************************************
 ;
1 ;SDARRAY(1): Appt dates
 ;validate from/to date(/time)s
 D CHKDTES($G(SDARRAY("FR")),$G(SDARRAY("TO")))
 Q:SDQUIT
 ;allow seconds in date/time filter!
 I $L(SDARRAY("FR"))>14 D ERROR(SDERR)
 Q:SDQUIT
 I $L(SDARRAY("TO"))>14 D ERROR(SDERR)
 Q
2 ;SDARRAY(2): Clinic IEN
 ;Clinic must be on ^SC
 ;Clinic list is not in global
 I SDARRAY("CLNGBL")'=1 D
 . ; get each clinic IEN in the string and validate
 . F SDX=1:1:SDCOUNT Q:SDQUIT  D
 .. S SDDATA=$P(SDARRAY(2),";",SDX)
 .. I ($G(SDDATA)=""!'$D(^SC(SDDATA,0))) D ERROR(SDERR) Q
 .. D:$$CHKRSACL(SDDATA) ERROR(SDERR)    ;validate RSA Clinic (Type R)
 ;Clinic list is in global or local array
 I SDARRAY("CLNGBL")=1 D
 . Q:SDARRAY(2)="^SC("   ; no validation required if clinic global
 . S SDX=SDARRAY(2)
 . ;check for existence of IENs
 . N SDIEN S SDIEN=$O(@(SDX_"0)")) I +$G(SDIEN)=0 D ERROR(SDERR)
 . Q:SDQUIT
 . S SDDATA=0
 . ; get each IEN in the array and validate
 . F  S SDDATA=$O(@(SDX_"SDDATA)")) Q:(($G(SDDATA)="")!(SDQUIT))  D
 .. I '$D(^SC(SDDATA,0)) D ERROR(SDERR) Q
 .. D:$$CHKRSACL(SDDATA) ERROR(SDERR)    ;validate RSA Clinic (Type R)
 Q
3 ;SDARRAY(3): Appointment Status Code
 F SDX=1:1:SDCOUNT Q:SDQUIT  D
 . S SDDATA=";"_$P(SDARRAY(3),";",SDX)_";"
 . I ";I;R;NT;NS;NSR;CC;CCR;CP;CPR;"'[(SDDATA) D ERROR(SDERR)
 Q
4 ;SDARRAY(4): Patient DFN
 ;patient must be on ^DPT
 ;DFN list is not in global
 I SDARRAY("PATGBL")'=1 D
 . ; get each DFN in the string and validate
 . F SDX=1:1:SDCOUNT Q:SDQUIT  D
 .. S SDDATA=$P(SDARRAY(4),";",SDX)
 .. I $G(SDDATA)="" D ERROR(SDERR)
 .. Q:SDQUIT
 .. I '$D(^DPT(SDDATA)) D ERROR(SDERR)
 .. Q:SDQUIT
 ;DFN list is in global or local array
 I SDARRAY("PATGBL")=1 D
 . Q:SDARRAY(4)="^DPT("
 . S SDX=SDARRAY(4)
 . ;check for existence of DFNs
 . N SDDFN S SDDFN=$O(@(SDX_"0)")) I +$G(SDDFN)=0 D ERROR(SDERR)
 . Q:SDQUIT
 . S SDDATA=0
 . ; get each DFN in the array and validate
 . F  S SDDATA=$O(@(SDX_"SDDATA)")) Q:(($G(SDDATA)="")!(SDQUIT))  D
 .. I '$D(^DPT(SDDATA)) D ERROR(SDERR)
 .. Q:SDQUIT
 Q
12 ;SDARRAY(12): Encounter Exists
 ;Unpublished and should not be used by other applications
 ;validate value
 ;S SDQUIT=$S(SDARRAY("ENCTR")="":0,SDARRAY("ENCTR")="Y":0,SDARRAY("ENCTR")="N":0,1:1)
 ;D:SDQUIT ERROR(SDERR)
 Q
13 ;SDARRAY(13): Primary Stop Code
 ;primary stop code must exist on ^DIC(40.7,"C"
 F SDX=1:1:SDCOUNT Q:SDQUIT  D
 . S SDDATA=$P(SDARRAY(13),";",SDX)
 . I '+SDDATA D ERROR(SDERR) Q
 . I '$D(^DIC(40.7,"C",SDDATA)) D ERROR(SDERR) Q
 Q
16 ;SDARRAY(16): Date Appointment Made
 ;validate from/to date(s)
 D CHKDTES($G(SDARRAY("DAMFR")),$G(SDARRAY("DAMTO")))
 Q:SDQUIT
 ;ensure time not entered
 I $L(SDARRAY("DAMFR"))>7 D ERROR(SDERR)
 Q:SDQUIT
 I $L(SDARRAY("DAMTO"))>7 D ERROR(SDERR)
 Q
CHKRSACL(SDCL) ;validate RSA clinics
 ;
 ;Input     SDCL - IEN of the clinic
 ;Output    0 - Clinic OK
 ;          1 - Clinic Error (Missing either Local Appointment
 ;              purpose Id or Resource Id entry)
 ;              
 ;initialize variables
 N SDRSA,SDRNODE,SDERR
 S SDERR=0
 ;quit if clinic is not of type "C" (Clinic)
 ; - RSA Clinic that has not completed migration
 Q:($P($G(^SC(SDCL,0)),"^",3)'="C") SDERR
 ;determine clinic (RSA or VistA)
 S SDRSA=$$RSACLNC^SDAMA307(SDCL)
 Q:SDRSA SDERR  ;valid RSA clinic (has both Resource/LAP Ids)
 ;check to ensure valid VistA clinic
 S SDRNODE=$G(^SC(SDCL,"RSA"))
 ;error if either resource or lap defined
 S SDERR=$S((($P(SDRNODE,"^",4)="")&($P(SDRNODE,"^",5)="")):0,1:1)
 Q SDERR
VSTAPPTS ;validate parameter for retrieving only VistA Appointments
 ;This flag supports the RPC View for RSA - unpublished feature
 Q:($G(SDARRAY("VSTAPPTS"))="")
 D:($G(SDARRAY("VSTAPPTS"))'=1) ERROR(SDERR)
 Q
PURGED ;validate parameter for retrieving PURGED VistA appts
 Q:($G(SDARRAY("PURGED"))="")  ;parameter not set/used
 D:($G(SDARRAY("PURGED"))'=1) ERROR(SDERR)
 Q:(SDQUIT)  ;quit if parameter not set correctly
 ;throw error if patient filter not defined or invalid field requested
 D:($G(SDARRAY(4))']"") ERROR(SDERR)
 Q:(SDQUIT)
 N SDI F SDI=5:1:9,11,22,28,30,31,33 Q:(SDQUIT)  D
 .D:((";"_$G(SDARRAY("FLDS"))_";")[(";"_SDI_";")) ERROR(SDERR)
 Q
NOFIL ;No filter allowed
 I $G(SDARRAY(SDI))]"" D ERROR(SDERR)
 Q
FMDATE(SDDATE,SDERR) ;
 ;dates must be valid internal FileMan format
 N X,Y,%H,%T,%Y
 S Y=SDDATE D DD^%DT I Y=-1 D ERROR(SDERR)
 Q:SDQUIT
 ;dates cannot be imprecise
 S X=SDDATE D H^%DTC I %H=0 D ERROR(SDERR)
 Q
CHKDTES(SDFROM,SDTO) ;validate date(/time)s
 N SDI,X,Y,%DT
 S %DT="STX"
 F SDI=SDFROM,SDTO Q:SDQUIT  D
 .;valid fileman format
 .I $G(SDI)'="" D
 ..D FMDATE(SDI,SDERR)
 ..Q:SDQUIT
 ..;check for valid dates / leap yr dates
 ..I SDI'[9999999 D
 ...S X=$$FMTE^XLFDT(SDI)
 ...D ^%DT
 ...I Y<0 D ERROR(SDERR)
 .Q:SDQUIT
 Q:SDQUIT
 ;from date(/time) can't be after to  date(/time)
 I SDFROM>SDTO D ERROR(SDERR)
 Q
MAX ;Maximum number of appointments requested
 ;max can't be 0
 N SDMAXAPT,SDPCOUNT,SDCCOUNT
 S SDMAXAPT=$G(SDARRAY("MAX"))
 S (SDPCOUNT,SDCCOUNT)=0
 I $G(SDMAXAPT)]"" D
 . ;Check Max Entry
 . I +SDMAXAPT'=SDMAXAPT S SDQUIT=1 Q
 . I SDMAXAPT=0 S SDQUIT=1 Q
 . I SDMAXAPT["." S SDQUIT=1 Q
 . ;Verify a SINGLE valid PATIENT &/OR CLINIC Entry
 . ;Get Number of Patients passed in
 . I SDARRAY("PATGBL")=1 S SDPCOUNT=$$CHKGBL(SDARRAY(4))
 . I SDARRAY("PATGBL")=0 S SDPCOUNT=$L(SDARRAY(4),";")
 . ;Get Number of Clinics passed in
 . I SDARRAY("CLNGBL")=1 S SDCCOUNT=$$CHKGBL(SDARRAY(2))
 . I SDARRAY("CLNGBL")=0 S SDCCOUNT=$L(SDARRAY(2),";")
 . I (SDPCOUNT>1)!(SDCCOUNT>1) S SDQUIT=1 Q
 . I SDPCOUNT=0,SDCCOUNT=0 S SDQUIT=1
 I SDQUIT D ERROR(SDERR)
 Q
 ;
FLDS ;Quit if field list is null
 N SDFIELDS,SDFIELD
 I $G(SDARRAY("FLDS"))="" D ERROR(SDERR)
 Q:SDQUIT
 S SDFIELDS=SDARRAY("FLDS")
 S SDCOUNT=$L(SDFIELDS,";")
 F SDI=1:1:SDCOUNT Q:SDQUIT  D
 . S SDFIELD=$P(SDFIELDS,";",SDI)
 . I (($G(SDFIELD)'?.N)!($G(SDFIELD)<1)!($G(SDFIELD)=27)!($G(SDFIELD)>SDARRAY("FC"))) D ERROR(SDERR) S SDQUIT=1
 Q
 ;
FLTRS ;Quit if max filters exceeded
 N SDFCNT S SDFCNT=0
 F SDI=1:1:SDARRAY("FC") D
 . I $G(SDARRAY(SDI))]"" S SDFCNT=SDFCNT+1
 I SDFCNT>SDARRAY("MF") D ERROR(SDERR) S SDQUIT=1
 Q
 ;
SORT ;Quit if SORT Filter is a value other than P or null
 N SDSORT
 S SDSORT=$G(SDARRAY("SORT"))
 I $G(SDSORT)="" Q
 I '($G(SDSORT)="P") D ERROR(SDERR)
 Q
 ;
ERROR(SDERRNUM) ;Generate Error and put in ^TMP global
 S SDARRAY("CNT")=-1,SDQUIT=1
 S $P(^TMP($J,"SDAMA301",SDERRNUM),"^",1)=$P($T(@SDERRNUM),";;",2)
 Q
 ;
101 ;;DATABASE IS UNAVAILABLE
115 ;;INVALID INPUT ARRAY ENTRY
116 ;;DATA MISMATCH
117 ;;Fatal RSA error. See SDAM RSA ERROR LOG file.
 ;
CHKGBL(SDGBL) ;Check Global for number of entries
 N SDIEN,SDCOUNT
 S (SDIEN,SDCOUNT)=0
 F  S SDIEN=$O(@(SDGBL_"SDIEN)"))  Q:(+$G(SDIEN)=0)!(SDCOUNT>2)  D
 .S SDCOUNT=SDCOUNT+1
 Q SDCOUNT
