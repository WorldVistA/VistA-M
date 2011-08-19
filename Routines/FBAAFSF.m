FBAAFSF ;WCIOFO/dmk,SAB-OUTPATIENT 75TH PERCENTILE FEE SCHEDULE ;5/18/1999
 ;;3.5;FEE BASIS;**4**;JAN 30, 1995
 ;
 Q
 ;
PRCTL(CPT,MODL,DOS) ; Calculate 75th Percentile Fee Schedule Amount
 ; input
 ;   CPT    - CPT/HCPCS code, external, required
 ;   MODL   - list of optional CPT/HCPCS modifiers (external values)
 ;            delimited by commas
 ;   DOS    - date of service, fileman format, required
 ; returns $ amount or null if not on schedule
 N FBAMT,FBERR
 ;
 ; initialize
 S FBAMT=""
 K FBERR
 ;
 ;validate parameters
 S CPT=$G(CPT)
 S DOS=$G(DOS)
 I CPT="" D ERR^FBAAFS("Missing CPT")
 I DOS'?7N D ERR^FBAAFS("Invalid Date of Service")
 ;
 I '$D(FBERR) D
 . ; get data from 163.99 (stored in previous fiscal year)
 . N FBDA,FBFY,FBI,FBMOD,FBMODA,FBMODLE,FBX
 . S FBFY=$E(DOS,1,3)+1700+$E(DOS,4) ; fiscal year of service
 . ;
 . ; build a sorted list of the CPT modifiers
 . F FBI=1:1 S FBMOD=$P(MODL,",",FBI) Q:FBMOD=""  S FBMODA(FBMOD)=""
 . S (FBMOD,FBMODLE)=""
 . F  S FBMOD=$O(FBMODA(FBMOD)) Q:FBMOD=""  S FBMODLE=FBMODLE_","_FBMOD
 . S:$E(FBMODLE)="," FBMODLE=$E(FBMODLE,2,999)
 . ;
 . ; build lookup value from CPT and sorted list of modifiers
 . S FBX=CPT_$S(FBMODLE]"":"-"_FBMODLE,1:"")
 . ; look in file
 . S FBDA=$O(^FBAA(163.99,"B",FBX,0))
 . I FBDA S FBAMT=$P($G(^FBAA(163.99,FBDA,"FY",FBFY-1,0)),U,5)
 ;
 ; return result
 Q FBAMT
 ;
 ;FBAAFSF
