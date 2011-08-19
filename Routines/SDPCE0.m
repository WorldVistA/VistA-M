SDPCE0 ;MJK/ALB - Process PCE Event Data ;01 APR 1993
 ;;5.3;Scheduling;**27**;08/13/93
 ;
 ; -- Variable definitions for SDPCE routines
 ; SDVIST    - visit file ien
 ; SDVIST()  - visit data array
 ;  subscripts:
 ;    BEFORE - PCE event data 'before' value of visit ien 0th node
 ;    AFTER  - PCE event data 'after' value of visit ien 0th node
 ; SDSCB     - stop code ien from PCE event 'before' data (piece 8) 
 ; SDSCA     - stop code ien from PCE event 'after' data (piece 8) 
 ; SCSC      - stop code ien of clinc
 ;             (no before/after - since clinic can't change)
 ; SD800B    - PCE event data 'before' value of visit ien 800 node
 ; SD800A    - PCE event data 'after' value of visit ien 800 node
 ; SDEVENT   - array that holds data for api
 ; SDEVENT() - subscripted as defined by api
 ; SDERR     - array that holds errors/warnings from api
 ; SDTYPR    - type of error message (ERROR or WARNING)
 ; DFN       - paitent file ien
 ; SDT       - encounter date/time
 ; SDCL      - hospital location file ien
 ; CLASS     - classification abbrevation code (ie. 'SC','AO','IR','EC')
 ; SDI       - general count increment variable
 ; SDB       - general variable to hold 'B'efore value
 ; SDA       - general variable to hold 'A'fter value
 ; SDPRVI    - V-Provider ien
 ; SDPRVB    - 'Before' value of V-Provider 0th node
 ; SDPRVA    - 'After' value of V-Provider 0th node
 ; SDCPTI    - V-CPT ien
 ; SDCPTB    - 'Before' value of V-CPT 0th node
 ;             Also used for 'before' value of 'level of care' field
 ;             from 0th node of visit
 ; SDCPTA    - 'After' value of V-CPT 0th node
 ;             Also used for 'after' value of 'level of care' field
 ;             from 0th node of visit
 ; SDPOVI    - V-POV ien
 ; SDPOV     - V-POV ien
 ; SDPOVB    - 'Before' value of V-POV 0th node
 ; SDPOVA    - 'After' value of V-POV 0th node
 ; CODE      - CPT code value
 ;             IDC9 code value
 ; ACTION    - action node value for api (ADD/CHANGE/DELETE)
 ; VAREA     - V-file related area that corresponds to the api's
 ;             SDEVENT node (ie. 'PROCEDURE', 'DIAGNOSIS')
 ; ITEM      - Detail node related to VAREA desendents
 ;             (ie. actual CPT code, ICD9 code)
 ; ADD       - 'ADD' node value of CPT code in SDEVENT array
 ; DEL       - 'DELETE' node value of CPT code in SDEVENT array
