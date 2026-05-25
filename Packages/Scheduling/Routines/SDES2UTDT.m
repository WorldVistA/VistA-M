SDES2UTDT ;ALB/TAW,TAW,TAW -Scheduling Encapsulation Utilities ;NOV 18,2025
 ;;5.3;Scheduling;**922,928**;13 Aug 1993;Build 5
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
FMTISO(SDGMT,SDFMDT,SDCLINIC) ;convert internal fileman format to extended GMT
 ;INPUT  SDFMDT - Fileman date/time
 ;       SDCLINIC - OPT IEN from file 44
 ;OUTPUT -1 error occurred in translation
 ;       GMT date/time in ISO 8601 extended format (No Errors)
 ;
 N SDDTM,SDTIME,SDOFFSET,OFFSET
 I +$G(SDFMDT)=0 S SDGMT="" Q
 S SDGMT=-1
 S SDTIME=$P(SDFMDT,".",2)
 I $E(SDTIME)>2 Q
 I $E(SDTIME,1,2)>24 Q
 I $E(SDTIME,1,2)=24,+$E(SDTIME,3,6)>0 Q
 I $E(SDTIME,3,4)>59 Q
 I $E(SDTIME,5,6)>59 Q
 D FILEMANTOHL7^SDES2UTIL(.SDFMDT,.SDDTM)
 I SDDTM<0 Q
 S SDCLINIC=$G(SDCLINIC)
 ;Extract out date and convert to ISO 8601 extended format
 S SDGMT=$E(SDDTM,1,4)_"-"_$E(SDDTM,5,6)_"-"_$E(SDDTM,7,8)
 ;if time is included, extract and convert to ISO 8601 external format
 I $L(SDDTM)>8 D
 .S SDTIME=$E(+SDDTM,9,99)
 .;S SDTIME=$$REMOVEOFFSET(SDTIME)
 .S SDTIME=$P(SDTIME,"-")
 .S SDTIME=$P(SDTIME,"+")
 .S SDTIME=$P(SDTIME,"Z")
 .;append hour and min
 .S SDGMT=SDGMT_"T"_$E(SDTIME,1,2)_":"_$E(SDTIME,3,4)
 .;include seconds
 .I $L(SDTIME)>4 S SDGMT=SDGMT_":"_$E(SDTIME,5,6)
 .;
 .D GETTZOFFSET^SDES2UTIL(.OFFSET,SDFMDT,1,SDCLINIC)
 .I OFFSET=-1 S OFFSET=-9999
 .;
 .S SDGMT=SDGMT_OFFSET
 I SDGMT["-9999" S SDGMT=-1
 Q
 ;
ISOTFM(SDFMDTM,SDGMTDT,SDCLINIC) ;convert ISO 8601 extended GMT date/time to fileman format
 ;INPUT  SDGMTDT - ISO 8601 extended GMT date/time
 ;       SDCLINIC - OPT IEN from file 44
 ;OUTPUT -1 error occurred in translation
 ;       FM date/time (No Errors)
 ;
 N SDFM,SDTIME,X,Y,%DT,POP,TMPFM,SDOFFSET,SDISOOFFSET,VALID,SDISOTIME,ISOOFFSET
 S (POP,SDOFFSET,TMPFM)=""
 I $G(SDGMTDT)="" S SDFMDTM="" Q
 ;pattern match date(/time) for correctness
 D VALIDISO(.VALID,SDGMTDT)
 I 'VALID S SDFMDTM=-1 Q
 S SDCLINIC=$G(SDCLINIC)
 ;extract out date, removing punctuation
 S SDFM=$TR($P(SDGMTDT,"T"),"-")
 ;set parameters to validate date/time
 S %DT="TXS"
 ;extract out time if entered, removing all punctuation except for TZ offset
 S (SDTIME,SDISOTIME)=$P(SDGMTDT,"T",2)
 I SDTIME'="" D
 .;Must have a time zone offset
 .I SDTIME'["Z",SDTIME'["+",SDTIME'["-" S POP=1 Q
 .;exclude time if 0's else FMTE returns previous date with .24
 .;S SDTIME=$$REMOVEOFFSET(SDTIME)
 .S SDTIME=$P(SDTIME,"-")
 .S SDTIME=$P(SDTIME,"+")
 .S SDTIME=$P(SDTIME,"Z")
 .S SDTIME=$P(SDTIME,".")  ;No ractional seconds
 .S SDTIME=$TR(SDTIME,":")
 .I +SDTIME=0 Q
 .;Get the correct offset
 .;S TMPFM=$$CVTTOFM(SDGMTDT)  ;Need a FM format of the ISO date that is passed in
 .N X,Y,%DT
 .S %DT=""
 .S X=SDFM
 .D ^%DT
 .S TMPFM=Y_"."_SDTIME
 .I Y=-1 Q  ;vse-2645 date is invalid so leave do dot logic and quit below
 .; IF ZULU reset SDGMTDT to match system time
 .I SDGMTDT["Z"!(SDGMTDT["+0000") D
 ..;S SDOFFSET=$$GETOFFSET(TMPFM,SDCLINIC)
 ..D GETTZOFFSET^SDES2UTIL(.SDOFFSET,TMPFM,1,SDCLINIC)
 ..I SDOFFSET=-1 S SDOFFSET=-9999 Q
 ..D ADJUSTOFFSET(TMPFM,.SDOFFSET,SDCLINIC)
 .E  D
 ..;S SDISOOFFSET=$$GETISOOFFSET(SDGMTDT)
 ..S ISOOFFSET=$P(SDGMTDT,"+",2),SDISOOFFSET=""
 ..I ISOOFFSET'="" S SDISOOFFSET="+"_ISOOFFSET
 ..I SDISOOFFSET="" S SDISOOFFSET="-"_$P(SDISOTIME,"-",2)
 ..S SDISOOFFSET=$TR(SDISOOFFSET,":")
 ..;
 ..D GETOFFSETDIFF(.SDOFFSET,TMPFM,SDCLINIC,SDISOOFFSET,1)
 .;Build HLT formatted date with offset (Flip the sign on offset)
 .D FLIPOFFSET(.SDOFFSET)
 .S SDFM=SDFM_SDTIME_SDOFFSET
 I TMPFM=-1 S SDFMDTM=-1 Q
 I SDFM["-9999"!(POP) S SDFMDTM=-1 Q
 ;
 ;convert date(/time) from HL7 format back to Fileman
 I +SDOFFSET S SDFMDTM=$$HL7TFM^XLFDT(SDFM,"U")
 I '(+SDOFFSET) S SDFMDTM=$$HL7TFM^XLFDT(SDFM)
 Q:SDFMDTM<0  ;error occurred in conversion
 ;check validity of date (including leap year check)
 S X=$$FMTE^XLFDT(SDFMDTM)
 D ^%DT
 S:Y<0 SDFMDTM=-1 ;date(/time) not valid
 Q
 ;
REMOVEOFFSET(TIME,RETURN) ;
 S RETURN=$P(TIME,"-")
 S RETURN=$P(RETURN,"+")
 S RETURN=$P(RETURN,"Z")
 Q
 ;
GETISOOFFSET(DATE,ISOFOOSET) ;
 N OFFSET
 S ISOOFFSET=""
 S OFFSET=$P(DATE,"+",2)
 I OFFSET'="" S ISOOFFSET="+"_OFFSET
 I ISOOFFSET="" S ISOOFFSET="-"_$P($P(DATE,"T",2),"-",2)
 S ISOOFFSET=$TR(ISOOFFSET,":")
 Q
GETOFFSET(DATE,SDCLINIC) ;
 N OFFSET
 S OFFSET=""
 ;Clinc can be in a different time zone
 I $G(SDCLINIC) S OFFSET=$$GETTZOFFSET^SDESUTIL(DATE,SDCLINIC)
 ;get offset for VistA Instance
 I OFFSET="" S OFFSET=$$GETTZOFFSET^SDESUTIL(DATE)
 I OFFSET=-1 S OFFSET="BAD OFFSET"
 Q OFFSET
 ;
GETOFFSETDIFF(OFFSET,DATE,SDCLINIC,SDISOOFFSET,VALIDDATE) ;Compare offsets and return the difference
 N SDCLNOFFSET,SDSYSOFFSET,TMPOFFSET
 S (OFFSET,SDCLNOFFSET)=""
 ;S (TMPOFFSET,SDSYSOFFSET)=$$GETOFFSET(DATE)
 D GETTZOFFSET^SDES2UTIL(.SDSYSOFFSET,DATE,$G(VALIDDATE))
 S TMPOFFSET=SDSYSOFFSET
 ;I $G(SDCLINIC) S (TMPOFFSET,SDCLNOFFSET)=$$GETOFFSET(DATE,SDCLINIC)
 I $G(SDCLINIC) D GETTZOFFSET^SDES2UTIL(.SDCLNOFFSET,DATE,1,SDCLINIC) S TMPOFFSET=SDCLNOFFSET
 I TMPOFFSET=-1 Q "-9999"
 I $E(SDISOOFFSET)?1N S SDISOOFFSET="+"_SDISOOFFSET
 ;If called from ISOTFM and ISO offset is different from the Clinic/System offset
 I $G(SDISOOFFSET)'="",SDISOOFFSET'=TMPOFFSET D
 .S OFFSET=TMPOFFSET-SDISOOFFSET
 ;
 I $G(SDISOOFFSET)="",SDSYSOFFSET'=SDCLNOFFSET D
 .S OFFSET=SDCLNOFFSET-SDSYSOFFSET
 S:OFFSET=0 OFFSET=""
 Q
 ;
FLIPOFFSET(OFFSET) ;Need to flip the sign because HL7TFM will flip it back.
 Q:+OFFSET=0 ""
 I $E(OFFSET)="-" D
 .S OFFSET=OFFSET*-1
 .S OFFSET="+"_$E(10000+OFFSET,2,5)
 E  D
 .S OFFSET="-"_$E(10000+OFFSET,2,5)
 Q
 ;
CVTTOFM(D) ;
 N X,Y,%DT
 S %DT=""
 S X=$P(D,"T")
 D ^%DT
 Q Y
 ;
 ;
FMTGMT(SDFMDT) ;convert internal fileman format to extended GMT
 ;initialize variables
 ;*****************************************************************
 ;INPUT  SDFMDT - Fileman date/time
 ;OUTPUT -1 error occurred in translation
 ;       GMT date/time in ISO 8601 extended format (No Errors)
 ;*****************************************************************
 N SDDTM,SDGMT,SDTIME,SDOFFSET
 S SDDTM=$$FMTHL7^XLFDT(SDFMDT)
 Q:SDDTM<0 -1
 ;extract out date and convert to ISO 8601 extended format
 S SDGMT=$E(SDDTM,1,4)_"-"_$E(SDDTM,5,6)_"-"_$E(SDDTM,7,8)
 ;if time is included, extract and convert to ISO 8601 external format
 I $L(SDDTM)>8 D
 .S SDTIME=$E(+SDDTM,9,99),SDOFFSET=$$TZ^XLFDT()
 .;determine if seconds are included in time
 .I $L(SDTIME)<5 D
 ..;no seconds included in date/time
 ..S SDGMT=SDGMT_"T"_$E(SDDTM,9,10)_":"_$E(SDDTM,11,99)
 .;seconds included in date/time
 .E  S SDGMT=SDGMT_"T"_$E(SDTIME,1,2)_":"_$E(SDTIME,3,4)_":"_$E(SDTIME,5,6)_SDOFFSET
 Q SDGMT
 ;
GMTTFM(SDGMTDT) ;convert ISO 8601 extended GMT date/time to fileman format
 ;initialize variables
 ;*****************************************************************
 ;INPUT  SDGMTDT - ISO 8601 extended GMT date/time
 ;OUTPUT -1 error occurred in translation
 ;       FM date/time (No Errors)
 ;*****************************************************************
 N SDFM,SDTIME,SDOFFSET,SDFMDTM,X,Y,%DT
 ;get offset for VistA Instance
 S SDOFFSET=$$TZ^XLFDT()
 ;pattern match date(/time) for correctness
 Q:((SDGMTDT["T")&'(SDGMTDT?4N1"-"2N1"-"2N1"T"2N1":"2N.E)) -1
 Q:((SDGMTDT'["T")&'(SDGMTDT?4N1"-"2N1"-"2N)) -1
 ;extract out date, removing punctuation
 S SDFM=$E(SDGMTDT,1,4)_$E(SDGMTDT,6,7)_$E(SDGMTDT,9,10)
 ;set parameters to validate date/time
 S %DT="TXS"
 ;extract out time if entered, removing all punctuation except for TZ offset
 I SDGMTDT>10 D
 .S SDTIME=$P($E(SDGMTDT,12,99),$E(SDOFFSET,1,1))
 .;exclude time if 0's else FMTE returns previous date with .24
 .Q:((SDTIME["00:00")!(SDTIME["00:00:00"))
 .;determine if seconds are included in time
 .I $L(SDTIME)<6 D
 ..;no seconds include in date/time
 ..S SDFM=SDFM_$E(SDGMTDT,12,13)_$E(SDGMTDT,15,99)
 .;seconds included in date/time
 .E  S SDFM=SDFM_$E(SDTIME,1,2)_$E(SDTIME,4,5)_$E(SDTIME,7,8)_"-"_SDOFFSET
 ;convert date(/time) from HL7 format back to Fileman
 S SDFMDTM=$$HL7TFM^XLFDT(SDFM)
 Q:SDFMDTM<0 SDFMDTM ;error occurred in conversion
 ;check validity of date (including leap year check)
 S X=$$FMTE^XLFDT(SDFMDTM)
 D ^%DT
 Q:Y<0 -1 ;date(/time) not valid
 Q SDFMDTM
 ;
VALIDFMFORMAT(VALID,DATE) ;Is DATE a valind FileMan format
 ;Return 1=Yes
 ;       0=No
 N X,Y,%DT
 S %DT="T",VALID=0
 I $G(DATE)="" Q
 I $$FR^XLFDT(DATE) Q
 S X=DATE D ^%DT
 I Y=-1 Q
 S VALID=1
 Q
 ;
VALIDISO(VALID,DATE) ;Is DATE a valid ISO8601 format (e.g., 2022-01-12T13:21)
 ; Return
 ; 0 = not ISO8601 format
 ; 1 = ISO8601 format
 N SDDATE,SDTIME,SDOFFSET,KEEPSDTIME
 S VALID=0
 I $G(DATE)="" Q
 S SDDATE=$P(DATE,"T")
 I SDDATE D
 .;Validate date
 .;   YYYYMMDD, YYYY-MM-DD or YYYY-MM
 .I SDDATE?6N Q  ;YYYY-MM is not allowed
 .S SDDATE=$TR(SDDATE,"-")
 .I SDDATE?8N!(SDDATE?6N) S VALID=1
 ;
 S (SDTIME,KEEPSDTIME)=$P(DATE,"T",2)
 I VALID,SDTIME'="" D
 .;Validate time (ignore seconds)
 .;  THH
 .;  THHMM or THH:MM
 .;  THHMMSS or THH:MM:SS
 .S SDTIME=$P(SDTIME,"-")
 .S SDTIME=$P(SDTIME,"+")
 .S SDTIME=$P(SDTIME,"Z")
 .S SDTIME=$P(SDTIME,".")  ;Ignore seconds
 .S SDTIME=$TR(SDTIME,":")
 .I SDTIME'?6N,SDTIME'?4N,SDTIME'?2N S VALID=0 Q
 .;Validate offset
 .;   Z
 .;   + or - followed by HH
 .;   + or - followed by HHMM or HH:MM
 .I $E(DATE,$L(DATE))="Z" S VALID=1 Q
 .S SDTIME=$TR(KEEPSDTIME,":")
 .S SDOFFSET=$P(SDTIME,"+",2)
 .I SDOFFSET'="" D  Q
 ..I SDOFFSET'?2N,SDOFFSET'?4N S VALID=0
 .S SDOFFSET=$P(SDTIME,"-",2)
 .I SDOFFSET'="" D  Q
 ..I SDOFFSET'?2N,SDOFFSET'?4N S VALID=0
 Q
ADJUSTOFFSET(FMDTTM,OFFSET,CLINIC) ;
 N MONTH,TZDATA,YEAR,TIME,TIMEDIFF,DSTADJUST,DSTDATE
 S MONTH=$E(FMDTTM,4,5)
 I +MONTH'=3,MONTH'=11 Q
 S CLINIC=$G(CLINIC)
 S TZDATA=$$TIMEZONEDATA^SDES2UTIL(CLINIC)
 I $P(TZDATA,"^",6)'="DST" Q
 S YEAR=$E(FMDTTM,2,3)
 I +MONTH=3 S DSTDATE=$$DSTSTART^SDES2UTIL(YEAR,"DST"),DSTADJUST=4
 I +MONTH=11 S DSTDATE=$$DSTEND^SDES2UTIL(YEAR,"DST"),DSTADJUST=5
 I $P(FMDTTM,".",1)'=DSTDATE Q
 S TIME=$P(FMDTTM,".",2)
 S TIME=$E(TIME_"0000",1,4)
 S TIMEDIFF=TIME+OFFSET
 ; TIME=0600 OFFSET=-0500
 I TIMEDIFF>59 Q
 S OFFSET=$P(TZDATA,"^",DSTADJUST)
 Q
