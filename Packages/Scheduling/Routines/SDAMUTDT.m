SDAMUTDT ;BPOIFO/JFW-Scheduling Encapsulation Utilities ; 5/17/04 1:00pm
 ;;5.3;Scheduling;**266**;13 Aug 1993
 ;
 ;*****************************************************************
 ;              CHANGE LOG
 ;
 ;  DATE      PATCH       DESCRIPTION
 ;--------  ----------    -----------------------------------------
 ;1/24/06   SD*5.3*413    ROUTINE COMPLETED
 ;
 ;*****************************************************************
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
 ;
