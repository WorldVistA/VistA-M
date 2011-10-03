GMVUTL1 ;HOIFO/YH,FT-EXTRACT CLINIC LIST AND MARK VITALS ENTERED IN ERROR ;6/11/03  09:25
 ;;5.0;GEN. MED. REC. - VITALS;**1,3**;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ;  #1246 - WIN^DGPMDDCF           (supported)
 ; #10039 - FILE 42 references     (supported)
 ; #10040 - ^SC( references        (supported)
 ; #10060 - FILE 200 fields        (supported)
 ; #10090 - FILE 4 references      (supported)
 ; #10104 - ^XLFSTR calls          (supported)
 ;
 ; This routine supports the following IAs:
 ; #4414 - GMV MARK ERROR RPC is called at ERROR (private)
 ;
ERROR(RESULT,GMVDATA)  ;GMV MARK ERROR [RPC entry point]
 ;GMVDATA CONSISTS OF THE FOLLOWING DATA:
 ;FILE # 120.5 IEN^DUZ^INCORRECT DATE/TIME^INCORRECT READING^INCORRECT
 ;PATIENT^INVALID RECORD
 N GMVFDA,GMVIEN,GMVIENS
 I '$D(^GMR(120.5,+GMVDATA,0))#2 S RESULT="ERROR: Record Not Found" Q
 S GMVIENS=(+GMVDATA)_","
 S GMVFDA(120.5,GMVIENS,2)=1
 S GMVFDA(120.5,GMVIENS,3)=$P(GMVDATA,"^",2)
 S GMVFDA(120.506,"+1,"_GMVIENS,.01)=$P(GMVDATA,"^",3)
 D UPDATE^DIE("","GMVFDA","GMVIEN")
 S RESULT="OK"
 Q
 ;
ACTLOC(LOC) ; Function: returns TRUE if active hospital location
 N D0,X I +$G(^SC(LOC,"OOS")) Q 0                ; screen out OOS entry
 S D0=+$G(^SC(LOC,42)) I D0 D WIN^DGPMDDCF Q 'X  ; chk out of svc wards
 S X=$G(^SC(LOC,"I")) I +X=0 Q 1                 ; no inactivate date
 I DT>$P(X,U)&($P(X,U,2)=""!(DT<$P(X,U,2))) Q 0  ; chk reactivate date
 Q 1                                             ; must still be active
 ;
PERSON(X) ;RETURN PERSON'S NAME FROM FILE #200.
 N GMVNAME
 Q:'X ""
 S GMVNAME=$$GET1^DIQ(200,X,.01,"E")
 Q $S(GMVNAME'="":GMVNAME,1:"")
FILLER(L,S,STRING)     ; Returns the number of filler characters desired.
 ; L - larger number
 ; S - smaller number
 ; STRING - string of same characters (e.g., spaces)
 ; Use spaces if STRING is not defined.
 I $L(STRING)=0 S STRING=$$REPEAT^XLFSTR(" ",79) ;line of spaces
 Q $E(STRING,1,L-S)
 ;
HOSPLOC(GMVWARD) ; Function returns Hospital Location IEN for a ward
 ; Input:
 ;  GMVWARD - Ward (FILE 42) IEN
 ; Returns:
 ;  Hospital Location (FILE 44) IEN for the ward
 ;  If GMVWARD'>0 or not found, then returns "" (null)
 I $G(GMVWARD)'>0 Q ""  ;illegal ward ien
 Q $P($G(^DIC(42,+GMVWARD,44)),"^")
 ;
DIVISION(GMVLOC) ; Function returns Division name for Hospital Location
 ; (FILE 44) IEN
 ; Input:
 ;  GMVLOC - Hospital Location (FILE 44) IEN
 ; Returns:
 ;  Division name (FILE 4) associated with that Hospital Location
 ;  If GMVLOC'>0 or not found, then returns "" (null)
 I $G(GMVLOC)'>0 Q ""  ;illegal hospital location
 Q $S(GMVLOC>0:$$GET1^DIQ(4,+$$GET1^DIQ(44,+GMVLOC,3,"I"),.01,"I"),1:"")
 ;
