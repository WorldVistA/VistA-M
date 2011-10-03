FBGMT2 ;WOIFO/SS-FEE BASIS PORTION OF GMT2 ;2/27/03
 ;;3.5;FEE BASIS;**54**;JAN 30, 1995
 ;
 Q
 ;Check for Fee basis encounters
 ;
 ;function returns 0 or the date in File Man format. 
 ;"0" return value indicates that there is no any authorization 
 ;for this patient in Fee Basis. Otherwise the return value is 
 ;the TO DATE of Fee Basis authorization for the patient. If 
 ;the patient has more than one authorization then return value 
 ;will contain the TO DATE of the authorization with the latest 
 ;TO DATE for the patient.
AUTH(FBDFN) ;
 N FBDATE,FBNODE,FBTDATE
 S (FBDATE,FBNODE)=0
 F  S FBNODE=$O(^FBAAA(FBDFN,1,FBNODE)) Q:+FBNODE=0  D
 . S FBTDATE=$P($G(^FBAAA(FBDFN,1,FBNODE,0)),"^",2)
 . I FBTDATE>FBDATE S FBDATE=FBTDATE
 Q FBDATE
 ;
 ;called from crossref of field #.02 of #161.01 to notify
 ;Enrollment about change of TODATE of patient's authorization
 ;sends patient's IEN and TODATE of the authorization with the 
 ;latest TODATE (see IA #3989)
ENRLLMNT(FBDFN) ;
 N FBTODT S FBTODT=$$AUTH(FBDFN)
 D:FBTODT>0 FBAUTH^EASUER(FBDFN,FBTODT)
 Q
 ;
