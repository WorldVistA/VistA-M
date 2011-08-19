DGRODEBR ;DJH/AMA,TDM - ROM DATA ELEMENT BUSINESS RULES ; 4/7/10 4:16pm
 ;;5.3;Registration;**533,572,754**;Aug 13, 1993;Build 46
 ;
 ;BUSINESS RULES TO BE CHECKED JUST BEFORE FILING THE
 ;PATIENT DATA RETRIEVED FROM THE LAST SITE TREATED (LST)
 ;
 ;* DG*5.3*572 changed "I"nternal references to "E"xternal references
POW(DGDATA,DFN,LSTDFN) ;POW STATUS INDICATED?
 ;   DGDATA - Data element array from LST, ^TMP("DGROFDA",$J)
 ;      DFN - Pointer to the PATIENT (#2) file
 ;   LSTDFN - Pointer to the patient data from the LST, in DGDATA
 N RSPOW    ;REQUESTING SITE POW STATUS INDICATED
 N LSTPOW   ;LAST SITE TREATED POW STATUS INDICATED
 S RSPOW=$$GET1^DIQ(2,DFN,.525)
 S LSTPOW=$G(@DGDATA@(2,LSTDFN_",",.525,"E"))
 ;If either of the POW STATUS INDICATED? flags
 ;are "N"o, don't file the POW data element(s)
 I (RSPOW="NO")!(LSTPOW="NO") D
 . N FIELD
 . F FIELD=.525:.001:.528 K @DGDATA@(2,LSTDFN_",",FIELD)
 Q
 ;
AO(DGDATA,DFN,LSTDFN) ;AGENT ORANGE EXPOSURE INDICATED?
 ;   DGDATA - Data element array from LST, ^TMP("DGROFDA",$J)
 ;      DFN - Pointer to the PATIENT (#2) file
 ;   LSTDFN - Pointer to the patient data from the LST, in DGDATA
 N RSAO    ;R.S. AGENT ORANGE EXPOSURE INDICATED
 N LSTAO   ;LST AGENT ORANGE EXPOSURE INDICATED
 S RSAO=$$GET1^DIQ(2,DFN,.32102)
 S LSTAO=$G(@DGDATA@(2,LSTDFN_",",.32102,"E"))
 ;If either of the AGENT ORANGE EXPOSURE INDICATED?
 ;flags are "N"o, delete the AO data element(s)
 I (RSAO="NO")!(LSTAO="NO") D
 . N FIELD
 . ;added AO LOCATION OF EXPOSURE (2/.3213) for DG*5.3*572  DJH
 . F FIELD=.32102,.32107,.32108,.32109,.3211,.3213 K @DGDATA@(2,LSTDFN_",",FIELD)
 Q
 ;
IR(DGDATA,DFN,LSTDFN) ;RADIATION EXPOSURE INDICATED?
 ;   DGDATA - Data element array from LST, ^TMP("DGROFDA",$J)
 ;      DFN - Pointer to the PATIENT (#2) file
 ;   LSTDFN - Pointer to the patient data from the LST, in DGDATA
 N RSIR    ;R.S. RADIATION EXPOSURE INDICATED
 N LSTIR   ;LST RADIATION EXPOSURE INDICATED
 S RSIR=$$GET1^DIQ(2,DFN,.32103)
 S LSTIR=$G(@DGDATA@(2,LSTDFN_",",.32103,"E"))
 ;If either of the RADIATION EXPOSURE INDICATED
 ;flags are "N"o, delete the IR data elements
 I (RSIR="NO")!(LSTIR="NO") D
 . N FIELD
 . F FIELD=.32103,.32111,.3212 K @DGDATA@(2,LSTDFN_",",FIELD)
 Q
 ;
INC(DGDATA,DFN,LSTDFN) ;RATED INCOMPETENT (Y/N)
 ;   DGDATA - Data element array from LST, ^TMP("DGROFDA",$J)
 ;      DFN - Pointer to the PATIENT (#2) file
 ;   LSTDFN - Pointer to the patient data from the LST, in DGDATA
 N RSIN    ;RATED INCOMPETENT (Y/N)
 N LSTIN   ;LST RATED INCOMPETENT (Y/N)
 S RSIN=$$GET1^DIQ(2,DFN,.293)
 S LSTIN=$G(@DGDATA@(2,LSTDFN_",",.293,"E"))
 ;If either of the RATED INCOMPETENT
 ;flags are "N"o, delete the IR data elements
 I (RSIN="NO")!(LSTIN="NO") D
 . N FIELD
 . F FIELD=.292,.293 K @DGDATA@(2,LSTDFN_",",FIELD)
 Q
 ;
INE(DGDATA,DFN,LSTDFN) ;INELIGIBLE DATA
 ;   DGDATA - Data element array from LST, ^TMP("DGROFDA",$J)
 ;      DFN - Pointer to the PATIENT (#2) file
 ;   LSTDFN - Pointer to the patient data from the LST, in DGDATA
 ;
 N LSTID ;INELIGIBLE DATE
 S LSTID=$G(@DGDATA@(2,LSTDFN_",",.152,"E"))
 ;
 ;If no INELIGIBLE DATE from LST don't upload ineligible fields.
 I LSTID="" D
 . N FIELD
 . F FIELD=.152,.307,.1651,.1653,.1654,.1656 K @DGDATA@(2,LSTDFN_",",FIELD)
 Q
 ;
DOD(DGDATA,DFN,LSTDFN) ;DATE OF DEATH
 ;Retrieve all DATE OF DEATH data elements, but instead of being filed,
 ;they will be placed into a mail message to the appropriate group.
 ;
 ;   DGDATA - Data element array from LST, ^TMP("DGROFDA",$J)
 ;      DFN - Pointer to the PATIENT (#2) file
 ;   LSTDFN - Pointer to the patient data from the LST, in DGDATA
 ;
 N DGMSG,FLD
 ;Only send messages if actual DOD is defined (field # .351) ;DG*5.3*572
 I $D(@DGDATA@(2,LSTDFN_",",.351)) D
 . D DODMAIL^DGROMAIL(DGDATA,DFN,LSTDFN)
 . S DGMSG(1)=" "
 . S DGMSG(2)="Date of Death information has been retrieved from the LST."
 . S DGMSG(3)="This information has NOT been filed into the patient's record."
 . S DGMSG(4)="A mail message has been sent to the Register Once mail group."
 . D EN^DDIOL(.DGMSG) R A:5
 ;Delete DoD fields from FDA array so they're not filed.
 F FLD=.351:.001:.355 K @DGDATA@(2,LSTDFN_",",FLD)   ;DG*5.3*572 - added .355
 Q
 ;
TA(DGDATA,LSTDFN) ;TEMPORARY ADDRESS
 ;   DGDATA - Data element array from LST, ^TMP("DGROFDA",$J)
 ;   LSTDFN - Pointer to the patient data from the LST, in DGDATA
 N LSTTAED ;LST TEMPORARY ADDRESS END DATE (EXTERNAL)
 N LSTTAEDF ;LST TEMPORARY ADDRESS END DATE FILEMAN (DG*5.3*572)
 S LSTTAED=$G(@DGDATA@(2,LSTDFN_",",.1218,"E"))
 ;*Convert External LST date to Fileman date (DG*5.3*572)
 S X=LSTTAED
 S %DT="RSN"
 D ^%DT
 S LSTTAEDF=Y
 ;If the TEMPORARY ADDRESS END DATE is less than the
 ;date of the query, delete the TA data elements
 I (LSTTAEDF>0),(LSTTAEDF<DT) D
 . N FIELD
 . F FIELD=.12105,.12111,.12112,.1211:.0001:.1219 K @DGDATA@(2,LSTDFN_",",FIELD)
 K X,%DT,Y
 Q
 ;
SP(DGDATA,DFN,LSTDFN) ;SENSITIVE PATIENT
 ;   DGDATA - Data element array from LST, ^TMP("DGROFDA",$J)
 ;      DFN - Pointer to the PATIENT (#2) file
 ;   LSTDFN - Pointer to the patient data from the LST, in DGDATA
 ;
 N RSSP    ;R.S. SENSITIVE PATIENT
 N LSTSP   ;LST SENSITIVE PATIENT
 S RSSP=$$GET1^DIQ(38.1,DFN,2)
 S LSTSP=$G(@DGDATA@(38.1,LSTDFN_",",2,"E"))
 ;
 ;* Remove code deleting Primary Eligibility Code (DG*5.3*572)
 ;* In all cases, delete Patient Type
 K @DGDATA@(2,LSTDFN_",",391)
 ;
 ;If the SENSITIVE PATIENT flag is received from the HEC -- OR -- if the
 ;flag is NOT received from both the HEC and LST, retrieve and file all
 ;Sensitive data elements, but NOT the fields for the Security Log file.
 I '((RSSP'="SENSITIVE")&(LSTSP="SENSITIVE")) D  I 1
 . K @DGDATA@(38.1)
 E  D
 . ;Otherwise (flag not received from the HEC but is from the LST),
 . ;send a mail message to the ISO and the "Register Once" mail
 . ;group that this patient is listed as Sensitive
 . D SPMAIL^DGROMAIL(DFN)
 . N DGMSG
 . S DGMSG(1)=" "
 . S DGMSG(2)="Sensitive Patient information has been retrieved from the LST."
 . S DGMSG(3)="This information has been filed into the patient's record."
 . S DGMSG(4)="A mail message has been sent to the Register Once mail group"
 . S DGMSG(5)="and the ISO explaining that this information has been received."
 . D EN^DDIOL(.DGMSG) R A:5
 Q
 ;
SWA(DGDATA,DFN,LSTDFN) ;SOUTHWEST ASIA CONDITIONS
 ;   DGDATA - Data element array from LST, ^TMP("DGROFDA",$J)
 ;      DFN - Pointer to the PATIENT (#2) file
 ;   LSTDFN - Pointer to the patient data from the LST, in DGDATA
 N RSSWA    ;REQUESTING SITE SOUTHWEST ASIA CONDITIONS
 N LSTSWA   ;LAST SITE TREATED SOUTHWEST ASIA CONDITIONS
 S RSSWA=$$GET1^DIQ(2,DFN,.322013)
 S LSTSWA=$G(@DGDATA@(2,LSTDFN_",",.322013,"E"))
 ;If either of the SOUTHWEST ASIA CONDITIONS flags
 ;are "N"o, don't file the SOUTWEST ASIA CONDITION data element(s)
 I (RSSWA="NO")!(LSTSWA="NO") D
 . N FIELD
 . F FIELD=.322013,322014,322015 K @DGDATA@(2,LSTDFN_",",FIELD)
 Q
 ;
RE ;RACE AND ETHNICITY
 ;If the RACE AND ETHNICITY data not already
 ;populated, file it (already the basic rule)
 Q
 ;
CA(DGDATA,LSTDFN) ;CONFIDENTIAL ADDRESS
 ;   DGDATA - Data element array from LST, ^TMP("DGROFDA",$J)
 ;   LSTDFN - Pointer to the patient data from the LST, in DGDATA
 N LSTCAAF   ;LST CONFIDENTIAL ADDRESS ACTIVE FLAG
 N LSTCAED   ;LST CONFIDENTIAL ADDRESS END DATE
 N LSTCAEDF ;LST CONFIDENTIAL ADDRESS END DATE FILEMAN (DG*5.3*572)
 S LSTCAAF=$G(@DGDATA@(2,LSTDFN_",",.14105,"E"))
 S LSTCAED=$G(@DGDATA@(2,LSTDFN_",",.1418,"E"))
 ;*Convert LSTCAED to Fileman format date for compare (DG*5.3*572)
 S X=LSTCAED
 S %DT="SN"
 D ^%DT
 S LSTCAEDF=Y
 ;If the CONFIDENTIAL ADDRESS FLAG from the Last Site Treated is "N"o,
 ;  OR  if the C.A. END DATE from the LST is less than the Query date,
 ;delete the C.A. data elements
 I (LSTCAAF'="YES")!((LSTCAEDF>0)&(LSTCAEDF<DT)) D
 . N FIELD
 . F FIELD=.1315,.14105,.14111:.00001:.14116,.1411:.0001:.1418 K @DGDATA@(2,LSTDFN_",",FIELD)
 . K @DGDATA@(2.141)
 ;Else the Confidential Address information will be filed
 ;and a User Interface message will be displayed.
 E  D
 . N DGMSG
 . N DATEFM ;*DATE converted to Fileman format (DG*5.3*572)
 . S DGMSG(1)=" "
 . S DGMSG(2)="Confidential Address information has been retrieved from the LST."
 . S DGMSG(3)="This information has been filed into the patient's record."
 . S DATE=$G(@DGDATA@(2,LSTDFN_",",.1417,"E"))
 . ;* Convert DATE to FM format (DG*5.3*572)
 . K X,%DT,Y
 . S X=DATE
 . S %DT="SN"
 . D ^%DT
 . S DATEFM=Y
 . I DATEFM>DT D
 . . S DGMSG(4)="   NOTE:  Confidential Address Start Date is in the future, "_DATE
 . . S DGMSG(5)=" "
 . D EN^DDIOL(.DGMSG) R A:5
 K X,%DT,Y
 Q
 ;
PA(DGDATA,LSTDFN) ;PERMANENT ADDRESS
 ;   DGDATA - Data element array from LST, ^TMP("DGROFDA",$J)
 ;   LSTDFN - Pointer to the patient data from the LST, in DGDATA
 N LSTBAI   ;LST BAD ADDRESS INDICATOR
 S LSTBAI=$G(@DGDATA@(2,LSTDFN_",",.121,"E"))
 ;If the BAD ADDRESS INDICATOR from LST is NOT null,
 ;delete the PERMANENT ADDRESS data elements
 I LSTBAI'="" D
 . N FIELD
 . F FIELD=.1112,.111:.001:.119,.12,.121 K @DGDATA@(2,LSTDFN_",",FIELD)
 Q
 ;
RDOC(DGDATA,DFN,LSTDFN) ;RECENT DATE(S) OF CARE
 ;   DGDATA - Data element array from LST, ^TMP("DGROFDA",$J)
 ;      DFN - Pointer to the PATIENT (#2) file
 ;   LSTDFN - Pointer to the patient data from the LST, in DGDATA
 N LSTRCP     ;LST RECEIVED VA CARE PREVIOUSLY?
 N LSTLOC1    ;LST MOST RECENT LOCATION OF CARE
 S LSTRCP=$G(@DGDATA@(2,LSTDFN_",",1010.15,"E"))
 S LSTLOC1=$G(@DGDATA@(2,LSTDFN_",",1010.152,"E"))
 ;
 ;If the RECEIVED VA CARE PREVIOUSLY? from LST is not YES,
 ;  OR  the MOST RECENT LOCATION OF CARE from LST is NULL,
 ;delete all the RDOC fields.
 I (LSTRCP'="YES")!(LSTLOC1="") D
 . N FIELD
 . F FIELD=1010.15,1010.151,1010.152,1010.153,1010.154 K @DGDATA@(2,LSTDFN_",",FIELD)
 Q
