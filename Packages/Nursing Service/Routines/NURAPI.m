NURAPI ;HCIOFO/FT,AL-APIs ;8/14/02  08:43
 ;;4.0;NURSING SERVICE;**37**;Apr 25, 1997
 ; 
 ; The entry points in this routine are documented in IA #3227.
 ;
 ; This routine uses the following IAs:
 ; #10035 - ^DPT( references       (supported)
 ;
ACTLOCS(ARRAY) ; Returns all active nursing locations from the NURS LOCATION
 ; file (#211.4) in the array specified. FILE 211.4 points to HOSPITAL
 ; LOCATION file (#44).
 ;  input: ARRAY - (Required) The name of the array to store the entries
 ; output: ARRAY(sequence #)=File 211.4 ien^File 44 name (for 211.4 ien) 
 ;
 N NURCNT,NURI,NURIEN,NURNAME
 D LIST^DIC(211.4,"","","","*","","","","I $S('$D(^NURSF(211.4,""D"",""I"",+Y)):1,$P(^NURSF(211.4,+Y,1),U)=""I"":0,1:1)","")
 I +$P($G(^TMP("DILIST",$J,0)),U,1)=0 S ARRAY(1)="NO UNIT"
 S (NURCNT,NURI)=0
 F  S NURI=$O(^TMP("DILIST",$J,1,NURI)) Q:'NURI  D
 .S NURNAME=$P($G(^TMP("DILIST",$J,1,NURI)),U,1)
 .S NURIEN=+$P($G(^TMP("DILIST",$J,2,NURI)),U,1)
 .Q:'NURIEN
 .S NURCNT=NURCNT+1
 .S ARRAY(NURCNT)=NURIEN_U_NURNAME
 .Q
 K ^TMP("DILIST",$J)
 Q
PTCHK(LOC) ; This function returns a value that indicates if any patients
 ; (active or inactive) are associated with the Nursing location
 ; identified.
 ;  input: LOC - (Required) NURS LOCATION file (#211.4) ien
 ; output:   0 - no patients associated with this location
 ;           1 - yes, patients are associated with this location 
 ;          -1 - (minus 1) LOC is undefined or not found
 ;I $G(LOC)="" Q -1
 I '$D(^NURSF(211.4,+LOC,0)) Q -1
 I '$D(^NURSF(214,"E",LOC)) Q 0  ;FILE 214 is the NURS PATIENT file
 Q 1
 ;
APTCHK(LOC) ; This function returns a value that indicates if active
 ; patients are associated with the Nursing location identified.
 ;  input: LOC - (Required) NURS LOCATION file (#211.4) ien
 ; output:   0 - no active patients associated with this location
 ;           1 - yes, active patients are associated with this location 
 ;          -1 - (minus 1) LOC is undefined or not found
 ;I $G(LOC)="" Q -1
 I '$D(^NURSF(211.4,+LOC,0)) Q -1
 I '$D(^NURSF(214,"AF","A",LOC)) Q 0  ;FILE 214 is the NURS PATIENT file
 Q 1
 ;
PTLIST(LOC,ARRAY) ; Returns a list of all (active and inactive) patients
 ; for a nursing location in the array specified.
 ;  input:   LOC - (Required) NURS LOCATION file (#211.4) ien
 ;  input: ARRAY - (Required) Name of array to return entries in
 ; output: ARRAY - Subscripted by sequential number with DFN in first
 ;                 piece and patient name in second piece.
 ;         example: ARRAY(#)=DFN^patient name
 ;
 ; If LOC is undefined or not found, then returns ARRAY(1)=-1
 ; If no patients on the Location, then returns ARRAY(1)="^No Patients"
 ;
 ;I $G(LOC)="" S ARRAY(1)=-1 Q
 I '$D(^NURSF(211.4,+LOC,0)) S ARRAY(1)=-1 Q
 N DFN,PATNAME,NURCNT
 S (DFN,NURCNT)=0
 F  S DFN=$O(^NURSF(214,"E",LOC,DFN)) Q:DFN'>0  D
 . S PATNAME=$P($G(^DPT(DFN,0)),"^")
 . Q:PATNAME=""
 . S NURCNT=NURCNT+1
 . S ARRAY(NURCNT)=DFN_U_PATNAME
 . Q
 I NURCNT=0 S ARRAY(1)="^No Patients"
 Q
APTLIST(LOC,ARRAY) ; Returns a list of active patients for a nursing
 ; location in the array specified.
 ;  input:   LOC - (Required) NURS LOCATION file (#211.4) ien
 ;  input: ARRAY - (Required) Name of the array to return entries in
 ; output: ARRAY - Subscripted by sequential number with DFN in first
 ;                 piece and patient name in second piece.
 ;         example: ARRAY(#)=DFN^patient name
 ;
 ; If LOC is undefined or not found, then returns ARRAY(1)=-1
 ; If no patients on the Location, then returns ARRAY(1)="^No Patients"
 ;
 ;I $G(LOC)="" S ARRAY(1)=-1 Q
 I '$D(^NURSF(211.4,+LOC,0)) S ARRAY(1)=-1 Q
 N DFN,NURCNT,PATNAME
 S (DFN,NURCNT)=0
 F  S DFN=$O(^NURSF(214,"AF","A",LOC,DFN)) Q:DFN'>0  D
 .S PATNAME=$P($G(^DPT(DFN,0)),"^")
 .Q:PATNAME=""
 .S NURCNT=NURCNT+1
 .S ARRAY(NURCNT)=DFN_U_PATNAME
 .Q
 I NURCNT=0 S ARRAY(1)="^No Patients"
 Q
FINDNLOC(LOC) ; This function returns the NURS LOCATION file (#211.4) ien
 ; and the ien of the location (File 44, Field .01).
 ;  input: LOC - (Required) Name of the Nursing location (as it appears
 ;               in File 44).
 ;               The name should begin with the characters 'NUR '.
 ;               If not, 'NUR<space>' will be appended to the beginning
 ;               of LOC. If LOC is undefined, then returns -1.
 ; output: File 211.4 ien^File 44 ien
 ;
 ; If LOC is undefined, then returns -1
 ; If LOC is not found, then returns "^Location not found"
 ;
 I $G(LOC)="" Q -1
 N NUROUT,NURWARD,NURVHLOC
 I LOC'?1"NUR ".E S LOC="NUR "_LOC
 D FIND^DIC(211.4,"","","X",LOC,"","","","","NUROUT")
 S NUROUT(1)=+$P($G(NUROUT("DILIST",0)),"^")
 I NUROUT(1)'>0 Q "^Location not found"
 S NURWARD=+$P(NUROUT("DILIST",2,1),"^"),NURVHLOC=+$P(NUROUT("DILIST",1,1),"^")
 S LOC=NURWARD_"^"_NURVHLOC
 Q LOC
 ;
MASWARDS(LOC,ARRAY) ; Returns the MAS wards associated with this Nursing
 ; location in the array specified. The .01 field of the MAS WARD
 ; multiple of the NURS LOCATION file points to the WARD LOCATION
 ; file (#42).
 ;  input:   LOC - (Required) NURS LOCATION file (#211.4) ien
 ;  input: ARRAY - (Required) Name of array to return entries in
 ; output: ARRAY subscripted by the MAS WARD value.
 ;         example: ARRAY($P(^NURSF(211.4,LOC,3,D1,0),U,1))=""
 ;         If LOC is null or not found, then ARRAY(1)=-1
 ;
 I '$D(^NURSF(211.4,+LOC,0)) S ARRAY(1)=-1 Q
 N GMVD1
 I $D(^NURSF(211.4,LOC,3)) D
 .S GMVD1=0
 .F  S GMVD1=$O(^NURSF(211.4,LOC,3,GMVD1)) Q:GMVD1'>0  S ARRAY($P(^NURSF(211.4,LOC,3,GMVD1,0),U,1))=""
 .Q
 I $O(ARRAY(0))="" S ARRAY(1)=-1
 Q
