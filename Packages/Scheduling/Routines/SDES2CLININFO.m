SDES2CLININFO ;ALB/TJB,JAS,TJB,MCB,JDJ,JAS - Get Clinic Info based on Clinic IEN ;DEC 26,2025
 ;;5.3;Scheduling;**893,895,898,907,927,909**;Aug 13, 1993;Build 12
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Documented API's and Integration Agreements
 ; -------------------------------------------
 ; Reference to $$GETS^DIQ is supported by IA #2056
 ; Reference to $$GETS1^DIQ is supported by IA #2056
 ; Reference to DUZ^XUP is supported by IA #7487
 ;
 ; copy of SDESRTVCLN
 ;
 Q
 ;
ENTRY(SDRETURN,SDCONTEXT,SDPARAM) ;SDES2 GET CLINIC INFO
 ;INPUT - SDPARAM("CLINICIEN")={Clinic IEN} - required
 ;      - SDPARAM("HASHFLAG")={0|1} - Flag to update hash value for clinic (0 - no (default), 1- yes )
 ;RETURN PARAMETER:
 ;
 ;{"Clinic": {
 ;"Abbreviation": "STPDN-M",
 ;"AdminInpatientMeds": "",
 ;"AllowPatScheduling": "",
 ;"AllowableConsecutiveNoShows": "",
 ;"ApptCancelLetter": "",
 ;"CHAR4": "",
 ;"CancelLetter": "",
 ;"CheckinCheckoutTime": "",
 ;"ClinicIEN": 2174,
 ;"ClinicName": "STPDN-M",
 ;"ClinicStatus": "ACTIVE" or "INACTIVE"
 ;"CreditStopCodeAMISNum": "",
 ;"CreditStopCodeName": "",
 ;"CreditStopCodeNum": "",
 ;"DefaultApptType": "",
 ;"DefaultToPCPractitioner": "",
 ;"Diagnosis": {
 ; "Code":"",
 ; "DefaultForClinic":""},
 ;"DisplayClinicAppt": "",
 ;"DivisionIEN": 1,
 ;"DivisionName": "CHEYENNE VAMROC",
 ;"ECheckinAllowed": "",
 ;"Hash": "F712AC20443E444B4CBF3ECD95AA3B2706BC2964",
 ;"HolidaySchedule": "",
 ;"HourClinicDisplayBegins": 8,
 ;"Inactivate Date": "",
 ;"IncrementsPerHr": "",
 ;"LastHashTimestamp": 3220901.160618,
 ;"LengthOfAppt": "",
 ;"MaxDaysForFutureBooking": "",
 ;"MeetsAtThisFacility": "",
 ;"NoShowLetter": "",
 ;"NoShowLetterIEN": "",
 ;"NonCountClinic": "",
 ;"OverbooksPerDayMax": "",
 ;"PatientFriendlyName": "",
 ;"PhysicalLocation": "",
 ;"PreApptLetter": "",
 ;"PreCheckinAllowed": "",
 ;"Principal": "",
 ;"PrivilegedUser": {
 ; "Name":"",
 ; "IEN":""},
 ;"ProhibitAccessToClinic": "",
 ;"Provider": {
 ; "DefaultForClinic": "",
 ; "IEN": "",
 ; "Name": ""
 ; "Title": ""},
 ;"Reactivate Date": "",
 ;"ReqActionProfiles": "",
 ;"ReqXrayFilms": "",
 ;"Service": "",
 ;"StationNumber": 442,
 ;"StopCodeAMISNum": "",
 ;"StopCodeName": "",
 ;"StopCodeNum": "",
 ;"Subspecialty": {
 ; "ID": "",
 ; "Name": "",
 ; "Tier": "",
 ; "Parent": ""},
 ;"Telephone": "",
 ;"TelephoneExtension": "",
 ;"Timezone": "EASTERN",
 ;"TimezoneException": 1,
 ;"VariableApptLength": "",
 ;"VeteranSelfCancel": "",
 ;"WorkloadValidationCheckout": ""}}
 ;
 N RETURN,HASFIELDS,ELGFIELDSARRAY,ELGRETURN,SDECI,ERRORS,SDCLNJSON,DIERR
 S (RETURN,ELGFIELDSARRAY,HASFIELDS)=""
 ;
 ; validate context array
 D VALCONTEXT^SDES2VALCONTEXT(.ERRORS,.SDCONTEXT)
 I $D(ERRORS) S ERRORS("Clinic")="" D BUILDJSON^SDES2JSON(.SDRETURN,.ERRORS) Q
 I $G(SDCONTEXT("USER DUZ"))'="" N DUZ D DUZ^XUP(SDCONTEXT("USER DUZ"))
 ;
 D VALCLINIEN^SDES2VAL44(.ERRORS,$G(SDPARAM("CLINICIEN")),1)
 I $D(ERRORS) S ERRORS("Clinic")="" D BUILDJSON^SDES2JSON(.SDRETURN,.ERRORS) Q
 D VALIDATEHASHFLG(.ERRORS,$G(SDPARAM("HASHFLAG")))
 I $D(ERRORS) S ERRORS("Clinic")="" D BUILDJSON^SDES2JSON(.SDRETURN,.ERRORS) Q
 ;
 S HASFIELDS=$$BLDCLNREC(.ELGFIELDSARRAY,$G(SDPARAM("CLINICIEN")))
 I HASFIELDS M RETURN=ELGFIELDSARRAY
 ;
 D BUILDJSON^SDES2JSON(.SDCLNJSON,.RETURN) ;build json without hash
 I $D(ERRORS) M RETSDCLNJSON=SDCLNJSON
 I HASFIELDS D
 .D ADDHASH($G(SDPARAM("CLINICIEN")),.ELGFIELDSARRAY,.SDCLNJSON,$G(SDPARAM("HASHFLAG")))
 .K RETURN
 .M RETURN=ELGFIELDSARRAY
 .D BUILDJSON^SDES2JSON(.SDRETURN,.RETURN) ;json includes hash
 D CLEANUP
 Q
 ;
 ; Get by clinic list by IEN
 ; SDPARAM("CLINICIEN",1)={Clinic IEN} - One is required multiple allowed
 ; SDPARAM("CLINICIEN",n)={Clinic IEN}
CLINICLIST(SDRETURN,SDCONTEXT,SDPARAM) ;RPC: SDES2 GET CLINICS BY CLIN LIST
 N NODE,SEQUENCE,IEN,SDEAS,HASHFLG,RETURNDATA,CLINICLIST,ERRORS,SDCLNJSON,RETSDCLNJSON,DIERR
 S (NODE,IEN,SDEAS,RETURNDATA,CLINICLIST)=""
 S (HASHFLG,SEQUENCE)=0
 D VALCONTEXT^SDES2VALCONTEXT(.ERRORS,.SDCONTEXT)
 I $D(ERRORS) S ERRORS("Clinic")="" D BUILDJSON^SDES2JSON(.SDRETURN,.ERRORS) Q
 I $G(SDCONTEXT("USER DUZ"))'="" N DUZ D DUZ^XUP(SDCONTEXT("USER DUZ"))
 ;
 S NODE=""
 F  S NODE=$O(SDPARAM("CLINICIEN",NODE)) Q:NODE=""  D
 . S IEN=$G(SDPARAM("CLINICIEN",NODE))
 . S SEQUENCE=SEQUENCE+1
 . I SEQUENCE>50 D ERRLOG^SDES2JSON(.ERRORS,381)
 . I $D(ERRORS) M CLINICLIST("Error","Max")=ERRORS("Error") Q
 . I IEN="" S CLINICLIST("Error","ClinicIEN")=$$GET1^DIQ(409.93,19,1,"E") Q
 . I '$D(^SC(IEN,0)) S CLINICLIST("Error","ClinicIEN "_IEN)=$$GET1^DIQ(409.93,20,1,"E") Q
 . ;
 . K RETURNDATA,ELGFIELDSARRAY
 . S HASFIELDS=$$BLDCLNREC(.ELGFIELDSARRAY,$G(SDPARAM("CLINICIEN",NODE)))
 . I HASFIELDS M RETURNDATA=ELGFIELDSARRAY
 . K SDCLNJSON
 . D BUILDJSON^SDES2JSON(.SDCLNJSON,.RETURNDATA) ;build json without hash
 . I HASFIELDS D
 .. D ADDHASH($G(SDPARAM("CLINICIEN",NODE)),.ELGFIELDSARRAY,.SDCLNJSON,$G(SDPARAM("HASHFLAG",NODE)))
 .. K RETURNDATA
 .. M RETURNDATA=ELGFIELDSARRAY
 . I $D(RETURNDATA("Error")) M CLINICLIST("Error","ClinicIEN "_IEN)=RETURNDATA("Error")
 . I '$D(RETURNDATA("Error")) M CLINICLIST("Clinic",SEQUENCE)=RETURNDATA("Clinic")
 . Q
 D BUILDJSON^SDES2JSON(.SDRETURN,.CLINICLIST)
 D CLEANUP
 Q
ADDHASH(SDCLIN,ELGFIELDSARRAY,SDCLNJSON,HASHFLG) ;Add hash to output
 NEW HASH,HASHDATE
 D:+$G(HASHFLG)'=0 UPDATECLINICHASH(SDCLIN,.HASH,.HASHDATE,.SDCLNJSON)
 S HASH=$$GET1^DIQ(44,SDCLIN_",",2900)
 S HASHDATE=$$FMTISO^SDAMUTDT($$GET1^DIQ(44,SDCLIN,2901,"I"),SDCLIN)
 S ELGFIELDSARRAY("Clinic","LastHashTimestamp")=HASHDATE
 S ELGFIELDSARRAY("Clinic","Hash")=HASH
 Q
 ;
UPDATECLINICHASH(CLIN,HASH,HASHDATE,SDCLNJSON) ;update clinic with new hash
 N FDA,FDAERR
 S HASH=$$SHAN^XLFSHAN(160,SDCLNJSON(1))
 S HASHDATE=$$NOW^XLFDT
 S FDA(44,CLIN_",",2900)=HASH
 S FDA(44,CLIN_",",2901)=HASHDATE
 D FILE^DIE(,"FDA","FDAERR") K FDA
 Q
 ;
ADDHASH2CLIN(IEN) ; add HASH to clinic after creation of clinic
 N HASH,HASHDATE,SDCLNJSON,SDCLNSREC
 D BLDCLNREC(.SDCLNSREC,IEN)
 D BUILDJSON^SDES2JSON(.SDCLNJSON,.SDCLNSREC)
 D UPDATECLINICHASH(IEN,.HASH,.HASHDATE,.SDCLNJSON)
 Q
 ;
VALIDATEHASHFLG(ERRORS,HASHFLG) ;
 S HASHFLG=$SELECT($G(HASHFLG)="":0,1:HASHFLG)
 I (HASHFLG'=0)&(HASHFLG'=1) D ERRLOG^SDES2JSON(.ERRORS,267)
 Q
 ;
BLDCLNREC(SDCLNSREC,SDCLNIEN) ;Get Clinic data
 ;
 N SDFIELDS,SDDATA,SDMSG,SDX,SDC,TIMEZONE,TIMEZONEEXC,USRCNT,USRIEN,STATUS,SDSTATUS,RESIEN,COUNT,COMMENTSUBIEN
 S SDECI=$G(SDECI,0)
 S SDFIELDS=".01;1;3.5;8;9;10;24;60;61;62;200;1914;2502;2504;2505;2506;2507;2802;99;99.1;2000;2000.5;2508;2509;2510;2511;2801;30;2001;2002;1918.5;2503;2500;1916;1918;20;21;1912;1913;1917"
 D GETS^DIQ(44,SDCLNIEN_",",SDFIELDS,"IE","SDDATA","SDMSG")
 S SDECI=SDECI+1
 S SDCLNSREC("Clinic","ClinicIEN")=$G(SDCLNIEN) ;Clinic IEN
 S SDCLNSREC("Clinic","ClinicName")=$G(SDDATA(44,SDCLNIEN_",",.01,"E")) ;Clinic Name
 S SDCLNSREC("Clinic","Abbreviation")=$G(SDDATA(44,SDCLNIEN_",",1,"E")) ;Clinic Abbreviation
 S SDCLNSREC("Clinic","PatientFriendlyName")=$G(SDDATA(44,SDCLNIEN_",",60,"E")) ;Patient Friendly Name
 S SDCLNSREC("Clinic","StationNumber")=$$STATIONNUMBER^SDES2UTIL(SDCLNIEN) ;Clinic station number
 S SDCLNSREC("Clinic","MeetsAtThisFacility")=$G(SDDATA(44,SDCLNIEN_",",2504,"E")) ;Clinic meets at this facility?
 S SDCLNSREC("Clinic","AllowPatScheduling")=$G(SDDATA(44,SDCLNIEN_",",61,"E")) ;Allow Direct Patient Scheduling?
 S SDCLNSREC("Clinic","DisplayClinicAppt")=$G(SDDATA(44,SDCLNIEN_",",62,"E")) ;DISPLAY CLIN APPT TO PATIENTS?
 S SDCLNSREC("Clinic","Service")=$G(SDDATA(44,SDCLNIEN_",",9,"E")) ;Service
 S SDCLNSREC("Clinic","NonCountClinic")=$G(SDDATA(44,SDCLNIEN_",",2502,"E")) ;NON-COUNT CLINIC? (Y OR N)
 S SDCLNSREC("Clinic","DivisionIEN")=$G(SDDATA(44,SDCLNIEN_",",3.5,"I")) ;Division
 S SDCLNSREC("Clinic","DivisionName")=$G(SDDATA(44,SDCLNIEN_",",3.5,"E")) ;Division
 S STATUS=$$INACTIVE^SDES2UTIL(SDCLNIEN,DT),SDSTATUS=$S(STATUS=0:"ACTIVE",1:"INACTIVE") ;Get status of clinic
 S SDCLNSREC("Clinic","ClinicStatus")=SDSTATUS
 S SDCLNSREC("Clinic","StopCodeName")=$G(SDDATA(44,SDCLNIEN_",",8,"E")) ;Stop Code Name
 S SDCLNSREC("Clinic","StopCodeNum")=$G(SDDATA(44,SDCLNIEN_",",8,"I")) ;Stop Code IEN
 S SDCLNSREC("Clinic","StopCodeAMISNum")=$$GET1^DIQ(40.7,$G(SDDATA(44,SDCLNIEN_",",8,"I")),1) ;Stop Code AMIS Number
 S SDCLNSREC("Clinic","DefaultApptType")=$G(SDDATA(44,SDCLNIEN_",",2507,"E")) ;Default Appointment type
 S SDCLNSREC("Clinic","AdminInpatientMeds")=$G(SDDATA(44,SDCLNIEN_",",2802,"E")) ;ADMINISTER INPATIENT MEDS?
 S SDCLNSREC("Clinic","Telephone")=$G(SDDATA(44,SDCLNIEN_",",99,"E")) ;TELEPHONE
 S SDCLNSREC("Clinic","TelephoneExtension")=$G(SDDATA(44,SDCLNIEN_",",99.1,"E")) ;TELEPHONE Extension
 S SDCLNSREC("Clinic","ReqXrayFilms")=$G(SDDATA(44,SDCLNIEN_",",2000,"E")) ;REQUIRE X-RAY FILMS?
 S SDCLNSREC("Clinic","ReqActionProfiles")=$G(SDDATA(44,SDCLNIEN_",",2000.5,"E")) ;REQUIRE ACTION PROFILES?
 S SDCLNSREC("Clinic","NoShowLetter")=$G(SDDATA(44,SDCLNIEN_",",2508,"E")) ;NO SHOW LETTER
 S SDCLNSREC("Clinic","NoShowLetterIEN")=$G(SDDATA(44,SDCLNIEN_",",2508,"I")) ;NO SHOW IEN
 S SDCLNSREC("Clinic","PreApptLetter")=$G(SDDATA(44,SDCLNIEN_",",2509,"E")) ;PRE-APPOINTMENT LETTER
 S SDCLNSREC("Clinic","PreApptLetterIEN")=$G(SDDATA(44,SDCLNIEN_",",2509,"I")) ;PRE-APPOINTMENT LETTER IEN
 S SDCLNSREC("Clinic","CancelLetter")=$G(SDDATA(44,SDCLNIEN_",",2510,"E")) ;CLINIC CANCELLATION LETTER
 S SDCLNSREC("Clinic","CancelLetterIEN")=$G(SDDATA(44,SDCLNIEN_",",2510,"I")) ;CLINIC CANCELLATION LETTER IEN
 S SDCLNSREC("Clinic","ApptCancelLetter")=$G(SDDATA(44,SDCLNIEN_",",2511,"E")) ;APPT. CANCELLATION LETTER
 S SDCLNSREC("Clinic","ApptCancelLetterIEN")=$G(SDDATA(44,SDCLNIEN_",",2511,"I")) ;APPT. CANCELLATION LETTER IEN
 S SDCLNSREC("Clinic","CheckinCheckoutTime")=$G(SDDATA(44,SDCLNIEN_",",24,"E")) ;ASK FOR CHECK IN/OUT TIME
 S SDCLNSREC("Clinic","DefaultToPCPractitioner")=$G(SDDATA(44,SDCLNIEN_",",2801,"E")) ;DEFAULT TO PC PRACTITIONER?
 S SDCLNSREC("Clinic","WorkloadValidationCheckout")=$G(SDDATA(44,SDCLNIEN_",",30,"E")) ;WORKLOAD VALIDATION AT CHK OUT
 S SDCLNSREC("Clinic","AllowableConsecutiveNoShows")=$G(SDDATA(44,SDCLNIEN_",",2001,"E")) ;ALLOWABLE CONSECUTIVE NO-SHOWS
 S SDCLNSREC("Clinic","MaxDaysForFutureBooking")=$G(SDDATA(44,SDCLNIEN_",",2002,"E")) ;MAX # DAYS FOR FUTURE BOOKING
 S SDCLNSREC("Clinic","HolidaySchedule")=$G(SDDATA(44,SDCLNIEN_",",1918.5,"E")) ;SCHEDULE ON HOLIDAYS?
 S SDCLNSREC("Clinic","CreditStopCodeNum")=$G(SDDATA(44,SDCLNIEN_",",2503,"I")) ;CREDIT STOP IEN
 S SDCLNSREC("Clinic","CreditStopCodeName")=$G(SDDATA(44,SDCLNIEN_",",2503,"E")) ;CREDIT STOP NAME
 S SDCLNSREC("Clinic","CreditStopCodeAMISNum")=$$GET1^DIQ(40.7,$G(SDDATA(44,SDCLNIEN_",",2503,"I")),1) ;Credit Stop Code AMIS Number
 S SDCLNSREC("Clinic","ProhibitAccessToClinic")=$G(SDDATA(44,SDCLNIEN_",",2500,"E")) ;PROHIBIT ACCESS TO CLINIC?
 S SDCLNSREC("Clinic","PhysicalLocation")=$G(SDDATA(44,SDCLNIEN_",",10,"E")) ;PHYSICAL LOCATION
 S SDCLNSREC("Clinic","Principal")=$G(SDDATA(44,SDCLNIEN_",",1916,"E")) ;PRINCIPAL Clinic
 S SDCLNSREC("Clinic","OverbooksPerDayMax")=$G(SDDATA(44,SDCLNIEN_",",1918,"E")) ;OVERBOOKS/DAY MAXIMUM
 S SDCLNSREC("Clinic","ECheckinAllowed")=$G(SDDATA(44,SDCLNIEN_",",20,"E")) ;E-CHECKIN ALLOWED
 S SDCLNSREC("Clinic","PreCheckinAllowed")=$G(SDDATA(44,SDCLNIEN_",",21,"E")) ;PRE-CHECKIN ALLOWED NO
 S SDCLNSREC("Clinic","LengthOfAppt")=$G(SDDATA(44,SDCLNIEN_",",1912,"E")) ;LENGTH OF APP'T
 S SDCLNSREC("Clinic","VariableApptLength")=$G(SDDATA(44,SDCLNIEN_",",1913,"E")) ;VARIABLE APP'NTMENT LENGTH
 S SDCLNSREC("Clinic","IncrementsPerHr")=$G(SDDATA(44,SDCLNIEN_",",1917,"E")) ;DISPLAY INCREMENTS PER HOUR
 S SDCLNSREC("Clinic","HourClinicDisplayBegins")=$S($G(SDDATA(44,SDCLNIEN_",",1914,"E"))'="":$G(SDDATA(44,SDCLNIEN_",",1914,"E")),1:8) ; HOUR CLINIC DISPLAY BEGINS
 S TIMEZONE=$$TIMEZONEDATA^SDES2UTIL($G(SDCLNIEN)),TIMEZONEEXC=$P($G(TIMEZONE),U,3),TIMEZONE=$P($G(TIMEZONE),U)
 S SDCLNSREC("Clinic","Timezone")=TIMEZONE
 S SDCLNSREC("Clinic","TimezoneException")=TIMEZONEEXC
 S SDCLNSREC("Clinic","InactivateDate")=$$FMTISO^SDAMUTDT($G(SDDATA(44,SDCLNIEN_",",2505,"I"))) ;Inactivate Date
 S SDCLNSREC("Clinic","ReactivateDate")=$$FMTISO^SDAMUTDT($G(SDDATA(44,SDCLNIEN_",",2506,"I"))) ;Reactivate Date
 S SDCLNSREC("Clinic","PbspID")=$G(SDDATA(44,SDCLNIEN_",",200,"E"))
 S SDCLNSREC("Clinic","VeteranSelfCancel")=$$GET1^DIQ(44,SDCLNIEN,63,"E")
 ; Get CHAR4 Data
 N CHAR4
 S CHAR4=$$CHAR4^SDES2UTIL($G(SDDATA(44,SDCLNIEN_",",.01,"E")))
 S SDCLNSREC("Clinic","CHAR4")=CHAR4
 ; Special Instructions Multiple
 S COMMENTSUBIEN=0,COUNT=0
 F  S COMMENTSUBIEN=$O(^SC(SDCLNIEN,"SI",COMMENTSUBIEN)) Q:'COMMENTSUBIEN  D
 .S COUNT=COUNT+1
 .S SDCLNSREC("Clinic","SpecialInstructions",COUNT,"Instruction")=$$GET1^DIQ(44.03,COMMENTSUBIEN_","_SDCLNIEN_",",.01)
 .S SDCLNSREC("Clinic","SpecialInstructions",COUNT,"InstructionID")=COMMENTSUBIEN
 I '$D(SDCLNSREC("Clinic","SpecialInstructions")) S SDCLNSREC("Clinic","SpecialInstructions")=""
 ;
 ; get subspecialties
 N SSFN,SUBSPECIEN
 S COUNT=0
 F SSFN=301:1:302 D
 . S SUBSPECIEN=0
 . F  S SUBSPECIEN=$O(^SC(SDCLNIEN,SSFN,"B",SUBSPECIEN)) Q:'SUBSPECIEN  D
 . . S COUNT=COUNT+1
 . . S SDCLNSREC("Clinic","Subspecialty",COUNT,"ID")=$$GET1^DIQ(409.94,SUBSPECIEN_",",.01,"E")
 . . S SDCLNSREC("Clinic","Subspecialty",COUNT,"Name")=$$GET1^DIQ(409.94,SUBSPECIEN_",",1)
 . . S SDCLNSREC("Clinic","Subspecialty",COUNT,"Tier")=$$GET1^DIQ(409.94,SUBSPECIEN_",",2,"E")
 . . S SDCLNSREC("Clinic","Subspecialty",COUNT,"Parent")=$$GET1^DIQ(409.94,SUBSPECIEN_",",3,"E")
 I '$D(SDCLNSREC("Clinic","Subspecialty")) S SDCLNSREC("Clinic","Subspecialty",1)=""
 ;
 ; Providers Multiple
 S SDX="",SDC=0
 S SDFIELDS="2600*"
 K SDDATA,SDMSG
 D GETS^DIQ(44,SDCLNIEN_",",SDFIELDS,"IE","SDDATA","SDMSG")
 F  S SDX=$O(SDDATA(44.1,SDX)) Q:SDX=""  D
 . S SDC=SDC+1
 . S SDCLNSREC("Clinic","Provider",SDC,"Name")=$G(SDDATA(44.1,SDX,.01,"E"))
 . S SDCLNSREC("Clinic","Provider",SDC,"IEN")=$G(SDDATA(44.1,SDX,.01,"I"))
 . S SDCLNSREC("Clinic","Provider",SDC,"Title")=$$GET1^DIQ(200,$G(SDDATA(44.1,SDX,.01,"I"))_",",8,"E")
 . S SDCLNSREC("Clinic","Provider",SDC,"DefaultForClinic")=$G(SDDATA(44.1,SDX,.02,"E"))
 I '$D(SDCLNSREC("Clinic","Provider")) S SDCLNSREC("Clinic","Provider",1)=""
 ; Diagnosis Multiple
 S SDX="",SDC=0
 S SDFIELDS="2700*"
 K SDDATA,SDMSG
 D GETS^DIQ(44,SDCLNIEN_",",SDFIELDS,"E","SDDATA","SDMSG")
 F  S SDX=$O(SDDATA(44.11,SDX)) Q:SDX=""  D
 . S SDC=SDC+1
 . S SDCLNSREC("Clinic","Diagnosis",SDC,"Code")=$G(SDDATA(44.11,SDX,.01,"E"))
 . S SDCLNSREC("Clinic","Diagnosis",SDC,"DefaultForClinic")=$G(SDDATA(44.11,SDX,.02,"E"))
 I '$D(SDCLNSREC("Clinic","Diagnosis")) S SDCLNSREC("Clinic","Diagnosis",1)=""
 ; Return all Privileged Users
 S (USRCNT,USRIEN)=0
 F  S USRIEN=$O(^SC(SDCLNIEN,"SDPRIV",USRIEN)) Q:'USRIEN  D
 .S USRCNT=USRCNT+1
 .S SDCLNSREC("Clinic","PrivilegedUser",USRCNT,"IEN")=USRIEN
 .S SDCLNSREC("Clinic","PrivilegedUser",USRCNT,"Name")=$$GET1^DIQ(44.04,USRIEN_","_SDCLNIEN,.01)
 I '$D(SDCLNSREC("Clinic","PrivilegedUser")) S SDCLNSREC("Clinic","PrivilegedUser",1)=""
 ;
 ; get resource IEN
 S RESIEN=""
 F  S RESIEN=$O(^SDEC(409.831,"ALOC",$G(SDCLNIEN),RESIEN)) Q:(RESIEN="")!$D(SDCLNSREC("Clinic","Resource IEN"))  D
 . I $$GET1^DIQ(409.831,RESIEN,.012,"E")="CLINIC" D
 . . S SDCLNSREC("Clinic","Resource IEN")=RESIEN
 S RESIEN=$O(^SDEC(409.831,"ALOC",$G(SDCLNIEN),RESIEN))
 ;
 I $D(SDCLNSREC("Clinic")) Q 1
 S SDCLNSREC("Clinic")=""
 Q 0
 ;
CLEANUP ; kill vars
 K RETURN,HASFIELDS,ELGFIELDSARRAY,ELGRETURN,SDECI,ERRORS
 Q
 ;
