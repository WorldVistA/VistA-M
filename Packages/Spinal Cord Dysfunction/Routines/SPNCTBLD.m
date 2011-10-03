SPNCTBLD ;WDE/SD BUILD UTILITY WITH CARE TYPE/S ;6/27/02  05:15
 ;;2.0;Spinal Cord Dysfunction;**19**;01/02/1997
 ;
 ; 
 ; Build utility with care type in patient /out patient /annl /cont
 ;  passing 10 into this routine means that they want to see all
 ;  care types on file for the patient
 ;
EN(SPNCTYP,SPNDFN) ;
 K ^UTILITY($J),^TMP($J)
 S SPNIEN=0 F  S SPNIEN=$O(^SPNL(154.1,"B",SPNDFN,SPNIEN)) Q:(SPNIEN="")!('+SPNIEN)  D
 .S SPNDATA=$G(^SPNL(154.1,SPNIEN,8))
 .Q:SPNDATA=""
 .S SPNSET=0
 .I $P(SPNDATA,U,3)=""  Q  ;no record type on file old record
 .I SPNCTYP=10 S SPNSET=1
 .I SPNCTYP'=10 I $P($G(SPNDATA),U,3)=SPNCTYP S SPNSET=1
 .Q:SPNSET=0
 .S (SPNW,SPNX,SPNY)=""
 .S SPNW=$P($G(SPNDATA),U,1) Q:SPNW=""  ;care start date
 .;S SPNX=$P($G(^SPNL(154.1,SPNIEN,0)),U,2) Q:SPNX=""  ;outcome type
 .S SPNY=$P($G(^SPNL(154.1,SPNIEN,0)),U,4) Q:SPNY=""  ;date recorded
 .S SPNZ=$P($G(SPNDATA),U,3)  ;care type
 .;S ^UTILITY($J,SPNZ,SPNW,SPNX,SPNY,SPNIEN)=SPNDATA
 .S ^UTILITY($J,SPNZ,SPNW,SPNY,SPNIEN)=SPNDATA
 .Q
 Q
OTHER(SPNCTYP,SPNDFN) ;
 ;         This tag is used to build the Annuals and Continuum of 
 ;         care care types.  These don't have a care start/end date.
 ;         They will be build right into tmp($j 
 K ^TMP($J),^UTILITY($J)
 S (SPNX,SPNY,SPNCNT,SPNEXIT)=0
 S SPNIEN=0 F  S SPNIEN=$O(^SPNL(154.1,"B",SPNDFN,SPNIEN)) Q:(SPNIEN="")!('+SPNIEN)  D
 .S SPNDATA=$G(^SPNL(154.1,SPNIEN,8))
 .Q:SPNDATA=""
 .S SPNSET=0
 .I $P(SPNDATA,U,3)=""  ;no care type
 .I $P(SPNDATA,U,3)=SPNCTYP S SPNSET=1
 .Q:SPNSET=0
 .S SPNY=$P($G(^SPNL(154.1,SPNIEN,0)),U,4) Q:SPNY=""  ;date recorded
 .S ^UTILITY($J,SPNY,SPNIEN)=SPNIEN
 S SPNCNT=0
 S SPNY=0 F  S SPNY=$O(^UTILITY($J,SPNY)) Q:SPNY=""  S SPNIEN=0 F  S SPNIEN=$O(^UTILITY($J,SPNY,SPNIEN)) Q:SPNIEN=""  D
 .S SPNCNT=SPNCNT+1
 .S ^TMP($J,SPNCNT,SPNY,SPNIEN)=SPNIEN
 .S $P(^TMP($J,0),U,1)=SPNCNT
 ;                             set the 4th piece to the care type
 S $P(^TMP($J,0),U,4)=SPNCTYP
 Q
