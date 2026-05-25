DGRTAUPD ;ALB/JAM - Real-time update of address and other contact info ;15 May 2025  10:33 AM
 ;;5.3;Registration;**1143**;Aug 13, 1993;Build 36
 ;
 Q
EN(DFN,DGERRS,DGADDGRP1,DGADDGRP2,DGADDGRP3,DGADDGRP4,DGADDGRP5) ; Entry point for address update for Real-Time updating to ES
 ; Input:  DFN (Required) - Patient DFN
 ;         DGADDGRP1-5 (pass by reference) - Arrays of patient contact data entered by the user (addresses, phone numbers and email)
 ;                                           corresponding to the five data groups in screen 1.1.
 ;                                           One or all of these arrays are passed in from screen 1.1 logic or other places where contact data is edited (e.g DG ADDRESS UPDATE).
 ;                                           (Group 1:Residential address and work/home phone, 2:Mailing address which may contain work/home phone, 3:Temp address and phone, 
 ;                                                  4:Confidential address and phone, 5:Cell/email)
 ;                                         - Other packages may also call code (using approved ICRs) to edit contact data.
 ;                                           e.g. ^DGRPU1 provides for external packages to update contact data which will send one of more groups.
 ;                                         - Format of the group arrays: DGADDGRPn(field_number)=field_value  e.g.  DGADDGRP1(.1151)="100 MAIN STREET"
 ;
 ; Output: DGERRS (pass by reference) - If an error was encountered, this contains the array of message lines to display to the user
 ;
 ; Return: 0 - error has been encountered
 ;         1 - success
 ; ICRs:
 ; Reference to $$FMADD^XLFDT supported by ICR #10103 
 ; Reference to MPINODE^MPIFAPI supported by ICR #2702
 ;
 I $G(DFN)="" Q 0
 ;
 N DGCONTACTINFODTO,DGADDRESSDTO,DGPHONEDTO,DGEMAILDTO,DGCONFCATDTO,DGCDT,DGUSERNAME,DGTS,DGDTOS,DGDTONAMES,%,DGCNTRY,DGICN,DGST,DGCNTY,DGCNT,DGBAI
 ;
 ; Get Fileman timestamp for NOW and convert the date/time to HL7 format
 D NOW^%DTC S DGTS=$$HLDATE^HLFNC(%)
 ; The function above puts the UTC offset onto the time - strip off the UTC offset
 S DGTS=$P(DGTS,"-",1)
 ; DGTS format is YYYYMMDDHHMMSS
 ; Add in trailing zeros to the time portion to fill out the timestamp to a length of 14
 S DGTS=DGTS_$E("000000",1,14-$L(DGTS))
 ; Format the Timestamp: YYYY-MM-DD"T"HH:MM:SS
 S DGTS=$E(DGTS,1,4)_"-"_$E(DGTS,5,6)_"-"_$E(DGTS,7,8)_"T"_$E(DGTS,9,10)_":"_$E(DGTS,11,12)_":"_$E(DGTS,13,14)
 ; Set current date to YYYY-MM-DD format
 S DGCDT=$P(DGTS,"T",1)
 ;
 ; Get the username 
 I $G(DUZ) S DGUSERNAME=$$GET1^DIQ(200,DUZ,.01)
 I $D(DGADDGRP1) D
 . ; Residential Address and Home,Office phones
 . ; Fill data from the array into DGADDRESSDTO("RES")
 . D FILLDTO("RES",.DGADDGRP1,.DGADDRESSDTO)
 . S DGADDRESSDTO("RES","addressType")="RESIDENTIAL"
 . S DGADDRESSDTO("RES","addressChangeSrcType")="VAMC"
 . S DGADDRESSDTO("RES","overrideIndicator")=$G(DGADDRESSDTO("RES","validationKey"))'=""
 . ; Residential address only has ZIP+4 which contains the entire zip code - break this up into the 2 fields
 . S DGADDRESSDTO("RES","zipCode")=$E($G(DGADDRESSDTO("RES","zipPlus4")),1,5)
 . S DGADDRESSDTO("RES","zipPlus4")=$E($G(DGADDRESSDTO("RES","zipPlus4")),6,9)
 . ; DGPHONEDTO for Home phone
 . D FILLDTO("HOMEPH",.DGADDGRP1,.DGPHONEDTO)
 . S DGPHONEDTO("HOMEPH","phoneType")="HOME"
 . S DGPHONEDTO("HOMEPH","sourceType")="VAMC"
 . ; DGPHONEDTO for Office phone
 . D FILLDTO("OFFICEPH",.DGADDGRP1,.DGPHONEDTO)
 . S DGPHONEDTO("OFFICEPH","phoneType")="BUSINESS"
 . S DGPHONEDTO("OFFICEPH","sourceType")="VAMC"
 ;
 I $D(DGADDGRP2) D
 . ; Mailing address (which may also include work/home phone)
 . ; Fill data from the array into DGADDRESSDTO("MAIL")
 . D FILLDTO("MAIL",.DGADDGRP2,.DGADDRESSDTO)
 . ; Set the proper enum value for addressInvalidType (Vista's Bad Address Indicator)
 . S DGBAI=$G(DGADDRESSDTO("MAIL","addressInvalidType"))
 . S DGBAI=$S(DGBAI=1:"MAIL_WAS_RETURNED_OR_IS_OTHERWISE_KNOWN_TO_BE_UNDELIVERABLE",DGBAI=2:"VETERAN_HAS_NO_KNOWN_ADDRESS",DGBAI=3:"ADDRESS_COULD_NOT_BE_SHARED_FOR_SOME_REASON_OTHER_THAN_HOMELESS_OR_UNDELIVERABLE",1:"")
 . S DGADDRESSDTO("MAIL","addressInvalidType")=DGBAI
 . S DGADDRESSDTO("MAIL","addressType")="PERMANENT"
 . S DGADDRESSDTO("MAIL","addressChangeSrcType")="VAMC"
 . S DGADDRESSDTO("MAIL","overrideIndicator")=$G(DGADDRESSDTO("MAIL","validationKey"))'=""
 . ; Mailing address has ZIP+4 which contains the entire zip code - break this up into the 2 fields
 . S DGADDRESSDTO("MAIL","zipCode")=$E($G(DGADDRESSDTO("MAIL","zipPlus4")),1,5)
 . S DGADDRESSDTO("MAIL","zipPlus4")=$E($G(DGADDRESSDTO("MAIL","zipPlus4")),6,9)
 . ; Group 2 may include Home/office phone numbers (certain ICRs are used to edit this address and the phone numbers)
 . I $D(DGADDGRP2(.131)) D
 . . ; DGPHONEDTO for Home phone
 . . D FILLDTO("HOMEPH",.DGADDGRP2,.DGPHONEDTO)
 . . S DGPHONEDTO("HOMEPH","phoneType")="HOME"
 . . S DGPHONEDTO("HOMEPH","sourceType")="VAMC"
 . I $D(DGADDGRP2(.132)) D
 . . ; DGPHONEDTO for Office phone
 . . D FILLDTO("OFFICEPH",.DGADDGRP2,.DGPHONEDTO)
 . . S DGPHONEDTO("OFFICEPH","phoneType")="BUSINESS"
 . . S DGPHONEDTO("OFFICEPH","sourceType")="VAMC"
 ;
 I $D(DGADDGRP3) D
 . ; Temporary address and phone
 . ; Fill data from the array into DGADDRESSDTO("TEMP")
 . D FILLDTO("TEMP",.DGADDGRP3,.DGADDRESSDTO)
 . S DGADDRESSDTO("TEMP","addressType")="TEMPORARY"
 . S DGADDRESSDTO("TEMP","addressChangeSrcType")="VAMC"
 . ; Temporary address has ZIP+4 which contains the entire zip code - break this up into the 2 fields
 . S DGADDRESSDTO("TEMP","zipCode")=$E($G(DGADDRESSDTO("TEMP","zipPlus4")),1,5)
 . S DGADDRESSDTO("TEMP","zipPlus4")=$E($G(DGADDRESSDTO("TEMP","zipPlus4")),6,9)
 . ; Group 3 array includes the Temporary address phone number
 . ; DGPHONEDTO for Temp phone
 . D FILLDTO("TEMPPH",.DGADDGRP3,.DGPHONEDTO)
 . S DGPHONEDTO("TEMPPH","phoneType")="TEMPORARY"
 . S DGPHONEDTO("TEMPPH","sourceType")="VAMC"
 . ; If Temp address Active flag is NO, modify the DTO objects as needed
 . I $G(DGADDGRP3(.12105))="N" D
 . . ; "DELETE" node is set in DGLOCK to indicate if the temporary data is being deleted
 . . ; If DELETE=0, Address data was not deleted, (address is just "inactive") - set the END DATE to TODAY
 . . ;  and delete the phoneDTO - don't send phone DTO for inactive temp address
 . . I $G(DGADDGRP3("DELETE"))=0 S DGADDRESSDTO("TEMP","addressEndDate")=DGCDT K DGPHONEDTO("TEMPPH")
 . . ; Otherwise, set the delete indicator for the address and phone, and remove the phoneNumber field from the DTO
 . . ELSE  S DGADDRESSDTO("TEMP","deleteIndicator")=1,DGPHONEDTO("TEMPPH","deleteIndicator")=1 K DGPHONEDTO("TEMPPH","phoneNumber")
 ;
 I $D(DGADDGRP4) D
 . ; Confidential address and phone
 . ; Fill data from the array into DGADDRESSDTO("CONF")
 . D FILLDTO("CONF",.DGADDGRP4,.DGADDRESSDTO)
 . S DGADDRESSDTO("CONF","addressType")="CONFIDENTIAL"
 . S DGADDRESSDTO("CONF","addressChangeSrcType")="VAMC"
 . S DGADDRESSDTO("CONF","overrideIndicator")=$G(DGADDRESSDTO("CONF","validationKey"))'=""
 . ; Confidential address has ZIPCODE which contains the entire zip code - break this up into the 2 fields
 . S DGADDRESSDTO("CONF","zipPlus4")=$E($G(DGADDRESSDTO("CONF","zipCode")),6,9)
 . S DGADDRESSDTO("CONF","zipCode")=$E($G(DGADDRESSDTO("CONF","zipCode")),1,5)
 . ;
 . ; DGPHONEDTO for Confidential phone
 . D FILLDTO("CONFPH",.DGADDGRP4,.DGPHONEDTO)
 . S DGPHONEDTO("CONFPH","phoneType")="VA_CONFIDENTIAL_RESIDENCE"
 . S DGPHONEDTO("CONFPH","sourceType")="VAMC"
 . ;
 . ; Load the Confidential Address Categories DTO from DGADDGRP4("CCATS",2.141)
 . ; Put in the common fields into the DTO array
 . N DGIEN,DGCATID,DGCATNAME
 . S (DGIEN,DGCNT,DGCATID)=0
 . F  S DGIEN=$O(DGADDGRP4("CCATS",2.141,DGIEN)) Q:'DGIEN  D
 . . S DGCNT=DGCNT+1
 . . S DGCONFCATDTO(DGCNT,"changeEffectiveDate")=DGTS
 . . S DGCONFCATDTO(DGCNT,"srcChgDuz")=$G(DUZ)
 . . I $G(DUZ)'="" S DGCONFCATDTO(DGCNT,"srcChgUsername")=DGUSERNAME
 . . ; Replace spaces and slashes in the category name with "_"
 . . S DGCATNAME=$TR(DGADDGRP4("CCATS",2.141,DGIEN,.01,"E")," /","__")
 . . S DGCONFCATDTO(DGCNT,"confidentialAddressType")=DGCATNAME
 . . ; If the category is Inactive, set the deleteIndicator in the DTO
 . . I DGADDGRP4("CCATS",2.141,DGIEN,1,"E")="NO" S DGCONFCATDTO(DGCNT,"deleteIndicator")=1
 . . ; Handle deleted categories in DGADDGRP4("CCATS","DELETE")
 . S DGCATID=""
 . F  S DGCATID=$O(DGADDGRP4("CCATS","DELETE",DGCATID)) Q:'DGCATID  D
 . . S DGCNT=DGCNT+1
 . . S DGCONFCATDTO(DGCNT,"changeEffectiveDate")=DGTS
 . . S DGCONFCATDTO(DGCNT,"srcChgDuz")=$G(DUZ)
 . . I $G(DUZ)'="" S DGCONFCATDTO(DGCNT,"srcChgUsername")=DGUSERNAME
 . . ; Replace spaces and slashes in the category name with "_"
 . . S DGCATNAME=$TR(DGADDGRP4("CCATS","DELETE",DGCATID)," /","__")
 . . S DGCONFCATDTO(DGCNT,"confidentialAddressType")=DGCATNAME
 . . S DGCONFCATDTO(DGCNT,"deleteIndicator")=1
 . ;
 . ; If Confidential address Active flag is NO modify the DTO objects as needed
 . I $G(DGADDGRP4(.14105))="N" D
 . . ; "DELETE" node set in DGLOCK3 to indicate if the Confidential data is being deleted
 . . ; If DELETE=0, Address data was not deleted, (address is just "inactive") - set the END DATE to TODAY
 . . ;  and delete the phoneDTO - don't send phone DTO for inactive address
 . . I $G(DGADDGRP4("DELETE"))=0 S DGADDRESSDTO("CONF","addressEndDate")=DGCDT K DGPHONEDTO("CONFPH")
 . . ; Otherwise set the delete indicator for the address and phone, and remove the phoneNumber field from the DTO
 . . ELSE  S DGADDRESSDTO("CONF","deleteIndicator")=1,DGPHONEDTO("CONFPH","deleteIndicator")=1 K DGPHONEDTO("CONFPH","phoneNumber")
 ;
 I $D(DGADDGRP5) D
 . ; Group 5 data - cell phone and email
 . ; Required fields/format of group
 . ;  DGADDGRP5(.133)=email_address
 . ;  DGADDGRP5(.134)=cell_phone_number
 . ;
 . ; DGPHONEDTO for Cell phone
 . D FILLDTO("CELLPH",.DGADDGRP5,.DGPHONEDTO)
 . S DGPHONEDTO("CELLPH","phoneType")="MOBILE"
 . S DGPHONEDTO("CELLPH","sourceType")="VAMC"
 . ; DGEMAILDTO
 . D FILLDTO("EMAIL",.DGADDGRP5,.DGEMAILDTO)
 . S DGEMAILDTO("EMAIL","emailType")="PERSONAL"
 . S DGEMAILDTO("EMAIL","sourceType")="VAMC"
 ;
 ; Check for all phone extensions
 D CHKEXT^DGRTAUPD1(DFN)
 ;
 ; Set data for the top-level DGCONTACTINFODTO array
 ; ICN and Station ID
 ; This is cloned from VAFCQRY1 to mimic how the ICN is retrieved for the Z07
 S DGICN=$$MPINODE^MPIFAPI(DFN)
 I DGICN<0 Q "1^Patient ICN could not be found."
 SET DGCONTACTINFODTO("icnOrVpid")=$P(DGICN,"^")_"V"_$P(DGICN,"^",2)
 SET DGCONTACTINFODTO("originatingFacilityId")=$P($$SITE^VASITE(),"^",3)
 ;
 ; If any of the phone or email DTOs have deleteIndicator = 0, remove the DTO - it will not be sent
 I $G(DGPHONEDTO("HOMEPH","deleteIndicator"))=0 K DGPHONEDTO("HOMEPH")
 I $G(DGPHONEDTO("OFFICEPH","deleteIndicator"))=0 K DGPHONEDTO("OFFICEPH")
 I $G(DGPHONEDTO("TEMPPH","deleteIndicator"))=0 K DGPHONEDTO("TEMPPH")
 I $G(DGPHONEDTO("CONFPH","deleteIndicator"))=0 K DGPHONEDTO("CONFPH")
 I $G(DGPHONEDTO("CELLPH","deleteIndicator"))=0 K DGPHONEDTO("CELLPH")
 I $G(DGEMAILDTO("EMAIL","deleteIndicator"))=0 K DGEMAILDTO("EMAIL")
 ;
 ; Errors returned by the webservice refer to the DTO that contains the error as: addresses[0], addresses[1]... phone[0], phone[1].., etc.  
 ; The array built below will map DTO error names to the DTO full name.  eg DGDTOS("addresses","address[0]")="Residential Address"
 N DGTYPE
 S DGTYPE=""
 F DGCNT=0:1 S DGTYPE=$O(DGADDRESSDTO(DGTYPE)) Q:DGTYPE=""  S DGDTOS("addresses"_"["_DGCNT_"]")=DGDTONAMES(DGTYPE)
 F DGCNT=0:1 S DGTYPE=$O(DGPHONEDTO(DGTYPE)) Q:DGTYPE=""  S DGDTOS("phones"_"["_DGCNT_"]")=DGDTONAMES(DGTYPE)
 ;
 ; Invoke the webservice routine passing the DTO arrays and the return array for error messages
 N DGSTAT
 S DGSTAT=$$EN^DGRTAUWS(.DGCONTACTINFODTO,.DGADDRESSDTO,.DGPHONEDTO,.DGEMAILDTO,.DGCONFCATDTO,.DGERRS)
 I 'DGSTAT D FORMATERR(.DGERRS)
 QUIT DGSTAT
 ;
FORMATERR(DGERRS) ; Format the return error message into user-readable message
 ; In the error messages returned, the DTOs that have an error are referred to as address[0] or phone[0], phone[1} etc
 ; This code will translate those names to the user-readable name (eg phone[0] -> Home Phone)
 N DGCNT,DGLINE,DGWSDTO,DGTYPE,DGNAME
 ; Step through each line of the return message. Each line corresponds to an error condition in a DTO
 S DGCNT="" F  S DGCNT=$O(DGERRS(DGCNT)) Q:DGCNT=""  D
 . S DGLINE=DGERRS(DGCNT)
 . ; Loop over the DGDTOS array of DTO error names
 . S DGWSDTO=""
 . F  S DGWSDTO=$O(DGDTOS(DGWSDTO)) Q:DGWSDTO=""  D
 . . ; If the error message text does not contain this DTO error name, quit
 . . Q:DGLINE'[DGWSDTO
 . . ; Get the full name of the DTO
 . . S DGNAME=DGDTOS(DGWSDTO)
 . . ; Replace the DTO error name with the DTO full name
 . . S DGERRS(DGCNT)=$$REPLACE(DGLINE,DGWSDTO,DGNAME)
 Q
 ;
FILLDTO(DGTYPE,DGINPUT,DGDTO) ; Move the data from the DGINPUT group array into the return array DGDTO(DGTYPE) array with data for all the fields in the list
 ; Input:
 ;     DGTYPE - The type of DTO array to be created: Address, Phone, or email
 ;     DGINPUT - pass by reference - array that contains the contact data for each field to be moved to DGDTO
 ; Returns: 
 ;      DGDTO(DGTYPE) - pass by reference - array that will contain the data for DGTYPE fields
 ;
 N DGCNT,DGFCNT,DGLINE,DGFIELDS,DGFLD,DGFNAME,DGFNUM,DGDELFLAG,DGDTFLAG,DGVALUE
 F DGCNT=1:1 S DGLINE=$P($T(FIELDS+DGCNT),";;",2,999) Q:$P(DGLINE,";;",1)="QUIT"  D
 . Q:$P(DGLINE,";;",1)'=DGTYPE
 . ; Build an array to map each DTO type to its full name - used for error message processing
 . S DGDTONAMES(DGTYPE)=$P(DGLINE,";;",2)
 . ; Get the list of fields
 . S DGFIELDS=$P(DGLINE,";;",3)
 . S DGFCNT=0
 . ; Loop over the fields in the line - quit if the deleteIndicator field is set
 . F DGFCNT=1:1 S DGFLD=$P(DGFIELDS,";",DGFCNT) Q:DGFLD=""  D  Q:$G(DGDTO(DGTYPE,"deleteIndicator"))'=""
 . . ; Get the field name, number, data type flag, and delete-check flag
 . . S DGFNAME=$P(DGFLD,"^",1)
 . . S DGFNUM=$P(DGFLD,"^",2)
 . . S DGDTFLAG=$P(DGFLD,"^",3)
 . . S DGDELFLAG=$P(DGFLD,"^",4)
 . . S DGVALUE=$G(DGINPUT(DGFNUM))
 . . ; for Dates, translate Fileman dates into YYYY-MM-DD format
 . . I DGDTFLAG="D" I DGVALUE'="" S DGVALUE=(1700+$E(DGVALUE,1,3))_"-"_$E(DGVALUE,4,5)_"-"_$E(DGVALUE,6,7)
 . . ; If the field value null and the delete-check flag is set, check if this is a field being deleted
 . . I DGVALUE="",DGDELFLAG=1 D
 . . . ; If there is no value currently in the DB, then this field is null - set delete indicator to zero - this DTO will not be sent
 . . . I $$GET1^DIQ(2,DFN,DGFNUM)="" S DGDTO(DGTYPE,"deleteIndicator")=0 Q
 . . . ; There is a value currently in the DB, this field is being deleted - set delete indicator
 . . . S DGDTO(DGTYPE,"deleteIndicator")=1
 . . ; If a phone or email is being deleted, Quit - do not set the field in the DTO array
 . . I DGFNAME="phoneNumber",$G(DGDTO(DGTYPE,"deleteIndicator"))=1 Q
 . . I DGFNAME="emailAddress",$G(DGDTO(DGTYPE,"deleteIndicator"))=1 Q
 . . S DGDTO(DGTYPE,DGFNAME)=DGVALUE
 ; Get the countryCode field - if none, this is not an address DTO
 S DGCNTRY=$G(DGDTO(DGTYPE,"countryCode"))
 ; For address DTO, swap the internal codes for country, state, country, with external names
 I DGCNTRY'="" D
 . ; Get 3 letter country code
 . S DGDTO(DGTYPE,"countryCode")=$$GET1^DIQ(779.004,DGCNTRY,.01)
 . ; Get state code - if none, this is a foreign address, quit
 . S DGST=$G(DGDTO(DGTYPE,"stateCode"))
 . I DGST="" Q
 . ; Swap internal state and county codes for state abbrev and county name
 . S DGDTO(DGTYPE,"stateCode")=$$GET1^DIQ(5,DGST,1)
 . S DGCNTY=$G(DGDTO(DGTYPE,"countyCode"))
 . I DGCNTY="" Q
 . ; Get county name
 . S DGCNTY=$P($$CNTY^DGREGAZL(DGST,DGCNTY),"^",1)
 . S DGDTO(DGTYPE,"countyCode")=DGCNTY
 ; Put in the common fields into the DTO array
 S DGDTO(DGTYPE,"changeEffectiveDate")=DGTS
 S DGDTO(DGTYPE,"srcChgDuz")=$G(DUZ)
 I $G(DUZ)'="" SET DGDTO(DGTYPE,"srcChgUsername")=DGUSERNAME
 Q
 ;
REPLACE(DGX,DGOLD,DGNEW) ; Function to replace DGOLD with DGNEW in string DGX
 N %,DGC
 S DGC=$L(DGNEW)-$L(DGOLD)
 F %=0:0 S %=$F(DGX,DGOLD,%) Q:%<1  D
 . I $E(DGX,%-$L(DGOLD)-1)'?1N S DGX=$E(DGX,1,%-$L(DGOLD)-1)_DGNEW_$E(DGX,%,9999),%=%+DGC
 Q DGX
 ;
FIELDS ; Format:  ;;DTO_object_type;;Full_DTO_Name;;fieldname^number^data_type_flag^delete-check_flag;...
 ;;RES;;Residential Address;;addressLine1^.1151;addressLine2^.1152;addressLine3^.1153;city^.1154;stateCode^.1155;zipPlus4^.1156;countyCode^.1157;countryCode^.11573;postalCode^.11572;province^.11571;validationKey^.11591;
 ;;MAIL;;Mailing Address;;addressLine1^.111;addressLine2^.112;addressLine3^.113;city^.114;stateCode^.115;zipCode^.116;zipPlus4^.1112;countyCode^.117;countryCode^.1173;postalCode^.1172;province^.1171;validationKey^.1119;addressInvalidType^.121;
 ;;TEMP;;Temporary Address;;addressLine1^.1211;addressLine2^.1212;addressLine3^.1213;city^.1214;stateCode^.1215;zipCode^.1216;zipPlus4^.12112;countyCode^.12111;countryCode^.1223;
 ;;TEMP;;Temporary Address;;postalCode^.1222;province^.1221;addressStartDate^.1217^D;addressEndDate^.1218^D;
 ;;CONF;;Confidential Address;;addressLine1^.1411;addressLine2^.1412;addressLine3^.1413;city^.1414;stateCode^.1415;zipCode^.1416;countyCode^.14111;countryCode^.14116;
 ;;CONF;;Confidential Address;;postalCode^.14115;province^.14114;addressStartDate^.1417^D;addressEndDate^.1418^D;validationKey^.141201;
 ;;HOMEPH;;Residential Phone;;phoneNumber^.131^P^1;
 ;;OFFICEPH;;Office Phone;;phoneNumber^.132^P^1;
 ;;TEMPPH;;Temporary Address Phone;;phoneNumber^.1219^P^1;
 ;;CONFPH;;Confidential Address Phone;;phoneNumber^.1315^P^1;
 ;;CELLPH;;Cell Phone;;phoneNumber^.134^P^1;
 ;;EMAIL;;Email Address;;emailAddress^.133^E^1;
 ;;QUIT;;QUIT
 ;
ISRTAUON() ; Function to determine if the Real-time address update webservice is active
 ; Returns:  1 - (TRUE) - the webservice is active
 ;           0 - (FALSE) - the webservice is not active
 ;  MAS PARAMETERS field 1403 (ENABLE REALTIME ADDRESS UPDATE) is the switch indicating if the service is enabled.
 I $$GET1^DIQ(43,1,1403)="NO" Q 0
 Q 1
