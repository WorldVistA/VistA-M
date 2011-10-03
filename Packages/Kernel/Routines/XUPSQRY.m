XUPSQRY ;EDS/GRR - Query New Person file ;4/9/04  10:40
 ;;8.0;KERNEL;**325**; Jul 10, 1995
 ;;Input Parameter:
 ;;   XUPSVPID - VPID of the user (Required for lookup by VPID)
 ;;   XUPSLNAM - Part or all of the last name to use for basis
 ;;              of query (Required for lookup by name)
 ;;   XUPSFNAM - Part or all of the first name to use for basis
 ;;              of query filter (optional, can be null)
 ;;   XUPSSSN  - Social Security Number (null or full 9 digits) to
 ;;              use as additional filter for query
 ;;   XUPSPROV - If value set to "P", screen for only providers
 ;;              (only persons with active person class)
 ;;   XUPSSTN  - Filter persons based on station number entered
 ;;              (optional, can be null)
 ;;   XUPSMNM  - Maximum Number of entries to return
 ;;              (Number between 1 and 50.  Null defaults to 50)
 ;;   XUPSDATE - Date to be used to determine whether person has
 ;;              active person class.  If null, current date is used.
 ;;
 ;;Output:
 ;;   RESULT - Name of global array were output data is stored
 ;;            ^TMP($J,"XUPSQRY",1) - 1 if found, 0 if not found
 ;;            ^TMP($J,"XUPSQRY",n,0) - VPID^IEN^Last Name~First Name~
 ;;                                      Middle Name^SSN^DOB^SEX^
 ;;            ^TMP($J,"XUPSQRY",n,1) - Provider Type^
 ;;            ^TMP($J,"XUPSQRY",n,2) - Provider Classification^
 ;;            ^TMP($J,"XUPSQRY",n,3) - Provider Area of Specialization^
 ;;            ^TMP($J,"XUPSQRY",n,4) - VA CODE^X12 CODE^Specialty Code^
 ;;                                      end-of-record character "|"
 ;;
EN1(RESULT,XUPSVPID,XUPSLNAM,XUPSFNAM,XUPSSSN,XUPSPROV,XUPSSTN,XUPSMNM,XUPSDATE) ;
 N %,XUPSNDAT
 K ^TMP($J,"XUPSQRY")
 K RESULT
 S RESULT=$NA(^TMP($J,"XUPSQRY")) ;set variable to name of global array where output data will be stored 
 S ^TMP($J,"XUPSQRY",1)=0 ;initialize to not found
 I $G(XUPSLNAM)="",($G(XUPSVPID)="") Q  ;last name parameter empty, and is required
 S XUPSFNAM=$G(XUPSFNAM)  ;Set to null if missing
 S XUPSSSN=$G(XUPSSSN)  ;Set to null if missing
 S XUPSPROV=$G(XUPSPROV)  ;Set to null if missing
 S XUPSSTN=$G(XUPSSTN)  ;Set to null if missing
 I $G(XUPSDATE)="" S XUPSDATE="" ;set to null if missing
 D NOW^%DTC S XUPSNDAT=%\1 ;set date to today and truncate time
 S XUPSDATE=$S(XUPSDATE="":XUPSNDAT,1:$$FMDATE^HLFNC(XUPSDATE)) ;change date from hl7 format to fileman format
 N XUPSCNT,XUPSNAME,XUPSIEN,XUPSDOB,XUPSSEX,XUPSPC,XUPSX12,XUPSPASS ;initialize new set of variables
 S:$G(XUPSMNM)="" XUPSMNM=50 ;set to default
 S XUPSCNT=0 ;Initialize variable
 ;
 ;Lookup by VPID
 I $G(XUPSVPID)'="" D  Q
 .S XUPSIEN=$$IEN^XUPS(XUPSVPID)
 .I +XUPSIEN>0 D
 ..D FILTER
 ..Q:XUPSPASS=0
 ..S XUPSCNT=XUPSCNT+1
 ..D FOUND(XUPSCNT,XUPSIEN,XUPSDATE) ;set array with person data
 ;
 S XUPSIEN=0,XUPSNAME=XUPSLNAM ;initialize variables
 ;;
 ;;Loop through the Name index, quit if name is null or beginning portion of name not equal parameter passed or maximum number of entries reached
 ;;
 F  S XUPSNAME=$O(^VA(200,"B",XUPSNAME)) Q:XUPSNAME=""!($E(XUPSNAME,1,$L(XUPSLNAM))'[XUPSLNAM)!(XUPSCNT+1>XUPSMNM)  S XUPSIEN=0 F  S XUPSIEN=$O(^VA(200,"B",XUPSNAME,XUPSIEN)) Q:XUPSIEN=""  D
 .D FILTER
 .Q:XUPSPASS=0
 .S XUPSCNT=XUPSCNT+1
 .D FOUND(XUPSCNT,XUPSIEN,XUPSDATE) ;set array with person data
 Q
FILTER ;
 S XUPSPASS=1 ;initialize found flag to found
 I '$$ACTIVE^XUSER(XUPSIEN),($O(^VA(200,XUPSIEN,8910,0))>0) S XUPSPASS=0 Q  ;skip visitors
 I XUPSFNAM]"" S XUPSPASS=$$NMATCH^XUPSUTL1(XUPSIEN,XUPSFNAM) ;check if matches name filter
 Q:'XUPSPASS  ;failed to match
 I XUPSSSN]"",($P($G(^VA(200,XUPSIEN,1)),"^",9)'=XUPSSSN) S XUPSPASS=0 Q  ;check ssn filter
 I XUPSSTN]"" S XUPSPASS=$$STNMAT^XUPSUTL1(XUPSIEN,XUPSSTN) ;check station number
 Q:'XUPSPASS  ;failed match
 I XUPSPROV]"",($$GET^XUA4A72(XUPSIEN,XUPSDATE)<0) S XUPSPASS=0 Q  ;check if active person class
 Q
FOUND(XUPSCNT,XUPSIEN,XUPSDATE) ;format output array
 N XUPSNAME,XUPSSSN,XUPSVPID,XUPSSEX,XUPSDOB,I,Y
 S Y=$P(^VA(200,XUPSIEN,0),"^",1) ;get full name
 S XUPSNAME=$$HLNAME^HLFNC(Y,"~|\/") ;format name into last name~first name~middle name
 I $L(XUPSNAME,"~")<3 S $P(XUPSNAME,"~",3)="" ;make sure formatted name has all 3 pieces
 S Y=$G(^VA(200,XUPSIEN,1)) ;get ssn,dob,sex
 S XUPSSSN=$P(Y,"^",9) ;ssn
 S XUPSVPID=$P($G(^VA(200,XUPSIEN,"VPID")),"^",1)
 S XUPSSEX=$P(Y,"^",2) ;sex
 S XUPSDOB=$P(Y,"^",3) ;dob fileman format
 I XUPSDOB]"" S XUPSDOB=$$HLDATE^HLFNC(XUPSDOB,"DT") ;format dob to correct hl7 format yyyymmdd
 S ^TMP($J,"XUPSQRY",1)=1 ;set to indicate match found
 S ^TMP($J,"XUPSQRY",XUPSCNT,0)=XUPSVPID_"^"_XUPSIEN_"^"_XUPSNAME_"^"_XUPSSSN_"^"_XUPSDOB_"^"_XUPSSEX_"^"
 S XUPSPC=$$GET^XUA4A72(XUPSIEN,XUPSDATE) ;get active person class data
 S:XUPSPC<0 XUPSPC="" ;no active person class
 F I=1:1:3 S ^TMP($J,"XUPSQRY",XUPSCNT,I)=$P(XUPSPC,"^",(1+I))_"^" ;put provider type, provider class, and are of specialization in output array
 S XUPSX12=$S(XUPSPC="":"",1:$P(^USC(8932.1,+XUPSPC,0),"^",7)) ;get x12 code which is not returned by api
 S ^TMP($J,"XUPSQRY",XUPSCNT,4)=$P(XUPSPC,"^",7)_"^"_XUPSX12_"^"_$P(XUPSPC,"^",8)_"^|" ;put va code, x12 code, specialty code, and end-of-record character in output array
 Q
