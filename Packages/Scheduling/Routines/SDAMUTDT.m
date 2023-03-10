SDAMUTDT ;BPOIFO/JFW,TAW,KML-TESTING-Scheduling Encapsulation Utilities ;March 21, 2022
 ;;5.3;Scheduling;**266,805,809,813**;13 Aug 1993;Build 6
 ;
 ;*****************************************************************
 ;              CHANGE LOG
 ;
 ;  DATE      PATCH       DESCRIPTION
 ;--------  ----------    -----------------------------------------
 ;1/24/06   SD*5.3*413    ROUTINE COMPLETED
 ;1/13/22   SD^5.3*805    Add FMTISO and ISOTFM to support clinic time zone different from system
 ;
 ;*****************************************************************
FMTISO(SDFMDT,SDCLINIC) ;convert internal fileman format to extended GMT
 ;initialize variables
 ;*****************************************************************
 ;INPUT  SDFMDT - Fileman date/time
 ;       SDCLINIC - OPT IEN from file 44
 ;OUTPUT -1 error occurred in translation
 ;       GMT date/time in ISO 8601 extended format (No Errors)
 ;*****************************************************************
 N SDDTM,SDGMT,SDTIME,SDOFFSET,HH,MM
 I +$G(SDFMDT)=0 Q ""
 S SDDTM=$$FMTHL7^XLFDT(SDFMDT)
 Q:SDDTM<0 -1
 S SDCLINIC=$G(SDCLINIC)
 ;If clinic offset is differnt from system, adjust SDFMDT
 ;I SDCLINIC D
 ;.S SDOFFSET=$$GETOFFSETDIFF(SDFMDT,SDCLINIC)
 ;.Q:SDOFFSET=""  ;Clinic and system are the same
 ;.S HH=$EXTRACT(SDOFFSET,2,3)
 ;.S MM=$EXTRACT(SDOFFSET,4,5)
 ;.I $EXTRACT(SDOFFSET)="-" S HH=-HH,MM=-MM
 ;.S SDFMDT=$$FMADD^XLFDT(SDFMDT,,HH,MM)
 ;.S SDDTM=$$FMTHL7^XLFDT(SDFMDT)
 ;Gextract out date and convert to ISO 8601 extended format
 S SDGMT=$E(SDDTM,1,4)_"-"_$E(SDDTM,5,6)_"-"_$E(SDDTM,7,8)
 ;if time is included, extract and convert to ISO 8601 external format
 I $L(SDDTM)>8 D
 .S SDTIME=$E(+SDDTM,9,99)
 .S SDTIME=$$REMOVEOFFSET(SDTIME)
 .;append hour and min
 .S SDGMT=SDGMT_"T"_$E(SDTIME,1,2)_":"_$E(SDTIME,3,4)
 .;include seconds
 .I $L(SDTIME)>4 S SDGMT=SDGMT_":"_$E(SDTIME,5,6)
 .S SDGMT=SDGMT_$$GETOFFSET(SDFMDT,SDCLINIC)
 I SDGMT["-9999" S SDGMT=-1
 Q SDGMT
 ;
ISOTFM(SDGMTDT,SDCLINIC) ;convert ISO 8601 extended GMT date/time to fileman format
 ;initialize variables
 ;*****************************************************************
 ;INPUT  SDGMTDT - ISO 8601 extended GMT date/time
 ;       SDCLINIC - OPT IEN from file 44
 ;OUTPUT -1 error occurred in translation
 ;       FM date/time (No Errors)
 ;*****************************************************************
 N SDFM,SDTIME,SDFMDTM,X,Y,%DT,SDFMTMP,POP,TMPFM,TMPDT,SDOFFSET,SDISOOFFSET
 S (POP,SDOFFSET,TMPFM)=""
 I $G(SDGMTDT)="" Q ""
 ;pattern match date(/time) for correctness
 I '$$VALIDISO^SDECDATE(SDGMTDT) Q -1
 ;I $P(SDGMTDT,"T",2)="" Q -1
 S SDCLINIC=$G(SDCLINIC)
 ;extract out date, removing punctuation
 S SDFM=$TR($P(SDGMTDT,"T"),"-")
 ;set parameters to validate date/time
 S %DT="TXS"
 ;extract out time if entered, removing all punctuation except for TZ offset
 I $P(SDGMTDT,"T",2)'="" D
 .S SDTIME=$P(SDGMTDT,"T",2)
 .;Must have a time zone offset
 .I SDTIME'["Z",SDTIME'["+",SDTIME'["-" S POP=1 Q
 .;exclude time if 0's else FMTE returns previous date with .24
 .S SDTIME=$$REMOVEOFFSET(SDTIME)
 .S SDTIME=$P(SDTIME,".")  ;No ractional seconds
 .S SDTIME=$TR(SDTIME,":")
 .I +SDTIME=0 Q
 .;Get the correct offset
 .S TMPFM=$$CVTTOFM(SDGMTDT)  ;Need a FM format of the ISO date that is passed in
 .Q:TMPFM=-1  ;vse-2645 date is invalid so leave do dot logic and quit below
 .; IF ZULU reset SDGMTDT to match system time
 .I SDGMTDT["Z"!(SDGMTDT["+0000") D
 ..S SDOFFSET=$$GETOFFSET(TMPFM,SDCLINIC)
 .E  D
 ..S SDISOOFFSET=$$GETISOOFFSET(SDGMTDT)
 ..S SDOFFSET=$$GETOFFSETDIFF(TMPFM,SDCLINIC,SDISOOFFSET)
 .;Build HLT formatted date with offset (Flip the sign on offset)
 .S SDFM=SDFM_SDTIME_$$FLIPOFFSET(SDOFFSET)
 I TMPFM=-1 Q -1
 I SDFM["-9999"!(POP) Q -1
 ;
 ;convert date(/time) from HL7 format back to Fileman
 I SDOFFSET'="" S SDFMDTM=$$HL7TFM^XLFDT(SDFM,"U")
 I SDOFFSET="" S SDFMDTM=$$HL7TFM^XLFDT(SDFM)
 Q:SDFMDTM<0 SDFMDTM ;error occurred in conversion
 ;check validity of date (including leap year check)
 S X=$$FMTE^XLFDT(SDFMDTM)
 D ^%DT
 Q:Y<0 -1 ;date(/time) not valid
 Q SDFMDTM
 ;
REMOVEOFFSET(TIME) ;
 S TIME=$P(TIME,"-")
 S TIME=$P(TIME,"+")
 S TIME=$P(TIME,"Z")
 Q TIME
GETISOOFFSET(DATE) ;
 N ISOOFFSET
 S ISOOFFSET=""
 I $P(DATE,"+",2)'="" S ISOOFFSET="+"_$P(DATE,"+",2)
 I ISOOFFSET="" S ISOOFFSET="-"_$P($P(DATE,"T",2),"-",2)
 Q $TR(ISOOFFSET,":")
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
GETOFFSETDIFF(DATE,SDCLINIC,SDISOOFFSET) ;Compare offsets and return the difference
 N SDCLNOFFSET,SDSYSOFFSET,OFFSET,TMPOFFSET
 S (OFFSET,SDCLNOFFSET)=""
 S (TMPOFFSET,SDSYSOFFSET)=$$GETOFFSET(DATE)
 I $G(SDCLINIC) S (TMPOFFSET,SDCLNOFFSET)=$$GETOFFSET(DATE,SDCLINIC)
 I TMPOFFSET=-1 Q "-9999"
 I $E(SDISOOFFSET)?1N S SDISOOFFSET="+"_SDISOOFFSET
 ;If called from ISOTFM and ISO offset is different from the Clinic/System offset
 I $G(SDISOOFFSET)'="",SDISOOFFSET'=TMPOFFSET D
 .S OFFSET=TMPOFFSET-SDISOOFFSET
 ;
 I $G(SDISOOFFSET)="",SDSYSOFFSET'=SDCLNOFFSET D
 .S OFFSET=SDCLNOFFSET-SDSYSOFFSET
 S:OFFSET=0 OFFSET=""
 Q OFFSET
 ;
FLIPOFFSET(OFFSET) ;Need to flip the sign because HL7TFM will flip it back.
 Q:+OFFSET=0 ""
 I $E(OFFSET)="-" D
 .S OFFSET=OFFSET*-1
 .S OFFSET="+"_$E(10000+OFFSET,2,5)
 E  D
 .S OFFSET="-"_$E(10000+OFFSET,2,5)
 Q OFFSET
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
SDAPIERR() ; SDAPI Error Messages.
 ;*****************************************************************
 ;INPUT  N/A
 ;OUTPUT Extrinsic call returns error message
 ;*****************************************************************
 N SDERR S SDERR=$O(^TMP($J,"SDAMA301",""))
 I SDERR="" Q ""
 I +SDERR=101 Q "Error 101: The Appointment Database is not currently available.  Please try again later."
 I +SDERR=115 Q "Error 115: Appointment request contains invalid values.  Please contact National Help Desk."
 Q "Error 117: An error has occurred, check the RSA Error Log."
