DGRRLU4 ;BPFO/MM RPCs for Division preferences - ;11/15/04  11:38
 ;;5.3;Registration;**538**;Aug 13, 1993
 ;
START(RESULT,PARAMS) ;Generates division/package preferences in xml format
 ;
 ;Called from DGRR PATIENT LKUP PREFERENCES remote procedure call
 ;
 ;Input:  PARAMS("stationNumber")= station number for institution
 ;              If not defined, defaults to package parameter values.
 ;
 ;Output: RESULT contains the preferences for the division.  If not
 ;        specified contains the default package parameters.
 ; 
 N LINE,DGRRI,DGRRVAL,DGRRATT,DGRRDIV,DGRRDIVN,DGRRLINE,DGRRESLT
 S DGRRDIVN=$G(PARAMS("stationNumber"))
 S DGRRDIV=$$IEN^XUAF4(DGRRDIVN)
 S DGRRLINE=0
 K ^TMP($J,"PLU-DIVPREF")
 S DGRRESLT="^TMP($J,""PLU-DIVPREF"")"
 S RESULT=$NA(@DGRRESLT)
 D ADD^DGRRUTL($$XMLHDR^DGRRUTL())
 D ADD^DGRRUTL("<preferences>")
 D ADD^DGRRUTL("<error/>")
 D ADD^DGRRUTL("<institutionPreferences>")
 D ADD^DGRRUTL("<stationNumber>"_$$CHARCHK^DGRRUTL($G(DGRRDIVN))_"</stationNumber>")
 ;
 ; Gather preference values and build xml file
 F DGRRI=1:1 S LINE=$P($T(PREF+DGRRI),";;",2) Q:LINE="QUIT"  D
 .;Return preferences in precedence order set in Parameter Definition.
 .;Will return division values if found.  If not defined, returns
 .;package default values
 .S DGRRVAL=$$GET^XPAR("ALL^DIV.`"_DGRRDIV,$P(LINE,U),1,"E")
 .S DGRRATT=$P(LINE,U,2)
 .D ADD^DGRRUTL("<"_DGRRATT_">"_$$CHARCHK^DGRRUTL(DGRRVAL)_"</"_DGRRATT_">")
 D ADD^DGRRUTL("</institutionPreferences>")
 D ADD^DGRRUTL("</preferences>")
 Q
 ;
UPDATE(RESULT,PARAMS) ;Entry point to add or change preference values
 ;
 ;Input: PARAMS("stationNumber")=Station # for the institution (Required)
 ;       PARAMS("divPreference",Preference Name)=Value (Required)
 ;
 ;Output:  Results in xml format 
 ;
 N DGRRARY,DGRRDIV,DGRRDIVN,DGRRERR,DGRRI,DGRRESLT,DGRRPREF,DGRRUPD,LINE
 S DGRRDIVN=$G(PARAMS("stationNumber"))
 S DGRRDIV=+$$IEN^XUAF4(DGRRDIVN)
 K ^TMP($J,"PLU-DIVPREF-UPD")
 S RESULT=$NA(^TMP($J,"PLU-DIVPREF-UPD"))
 ; Log error for xml document and quit if invalid station number passed to call.
 I 'DGRRDIV D  Q
 .S DGRRERR="Invalid stationNumber"
 .S DGRRUPD="false"
 .D XML(DGRRERR,DGRRUPD,RESULT)
 ; Build array of preferences from parameter preference names.
 F DGRRI=1:1 S LINE=$P($T(PREF+DGRRI),";;",2) Q:LINE="QUIT"  D
 .S DGRRARY($P(LINE,U,2))=$P(LINE,U)
 S DGRRPREF=""
 F DGRRI=1:1 S DGRRPREF=$O(DGRRARY(DGRRPREF)) Q:DGRRPREF=""  D  Q:DGRRUPD="false"
 .N DGRRPR,DGRRVAL,ERR
 .S (DGRRERR,DGRRUPD)=""
 .S DGRRPR=$G(DGRRARY(DGRRPREF))
 .S DGRRVAL=$G(PARAMS(DGRRPREF))
 .;Value and Preference must be defined
 .I DGRRPR=""!(DGRRVAL="") D  Q
 ..S DGRRUPD="false"
 ..S DGRRERR="Invalid Preference "_$S(DGRRPR="":"Name",1:"Value")
 .D EN^XPAR("DIV.`"_DGRRDIV,DGRRPR,1,DGRRVAL,.ERR)
 .; If no errors, ERR=0.  Errors are returned in the format:
 .; internal entry number in Dialog file^error text describing error
 .I ERR'=0 D  Q
 ..S DGRRUPD="false"
 ..S DGRRERR=$P(ERR,U,2)
 .S DGRRUPD="true"
 D XML(DGRRERR,DGRRUPD,RESULT)
 Q
XML(DGRRERR,DGRRUPD,DGRRESLT) ;Builds xml document
 N DGRRLINE
 S DGRRERR=$G(DGRRERR)
 S DGRRUPD=$G(DGRRUPD)
 S DGRRLINE=0
 K @DGRRESLT
 D ADD^DGRRUTL($$XMLHDR^DGRRUTL())
 D ADD^DGRRUTL("<preferences>")
 D ADD^DGRRUTL("<error>"_$$CHARCHK^DGRRUTL(DGRRERR)_"</error>")
 D ADD^DGRRUTL("<institutionPreferences>")
 D ADD^DGRRUTL("<stationNumber>"_$$CHARCHK^DGRRUTL($G(DGRRDIVN))_"</stationNumber>")
 D ADD^DGRRUTL("<preferencesUpdated>"_$$CHARCHK^DGRRUTL(DGRRUPD)_"</preferencesUpdated>")
 D ADD^DGRRUTL("</institutionPreferences>")
 D ADD^DGRRUTL("</preferences>")
 Q
 ;
PREF ;Parameter definition^divPref received from/returned to calling app
 ;;DGRR PL MAX NUM PATIENTS RET^maxNumPatients
 ;;DGRR PL NUM PATIENTS PER PAGE^patientsPerPage
 ;;DGRR PL PATIENT TYPE^patientType
 ;;DGRR PL GENDER^gender
 ;;DGRR PL PRIMARY ELIGIBILITY^primaryEligibility
 ;;DGRR PL ROOM BED^roomBed
 ;;DGRR PL SERVICE CONNECTED^serviceConnected
 ;;DGRR PL VETERAN STATUS^veteranStatus
 ;;DGRR PL WARD^ward
 ;;DGRR PL VETERAN IMAGE^veteranImage
 ;;QUIT
 Q
