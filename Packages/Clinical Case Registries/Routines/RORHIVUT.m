RORHIVUT ;HCIOFO/SG - HIV UTILITIES ;9/14/05 8:15am
 ;;1.5;CLINICAL CASE REGISTRIES;**14**;Feb 17, 2006;Build 24
 ;
 Q
 ;******************************************************************************
 ;******************************************************************************
 ;                 --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*14   APR  2011   A SAUNDERS   CLINAIDS: also quit if 'unknown'
 ;******************************************************************************
 ;******************************************************************************
 ;
 ;***** RETURNS THE CATEGORY SUBSCRIPT AND HEADER
CAT(I) ;
 ;;ALL^AIDS^HIV
 ;;All Patients^AIDS OI^HIV+ (no AIDS OI)
 ;
 Q $P($P($T(CAT+1),";;",2),U,I)_U_$P($P($T(CAT+2),";;",2),U,I)
 ;
 ;***** RETURNS CLINICAL AIDS STATUS OF THE PATIENT
 ;
 ; IEN           IEN of the registry record
 ;
 ; [DATE]        Date that the status should be determined on.
 ;
 ;               If not defined or not greater than 0 then the
 ;               date of Clinical AIDS is not checked.
 ;
 ; Return Values:
 ;        0  No Clinical AIDS
 ;        1  Clinical AIDS. The second "^"-piece will
 ;           contain the Clinical AIDS date
 ;
CLINAIDS(IEN,DATE) ;
 N X  S X=$P($G(^RORDATA(799.4,+IEN,0)),U,2,3)
 Q:'X 0 ;quit if 'no' or null in first piece (clinical aids indicator)
 I +$G(X)=9 Q 0  ;quit if 'unknown'
 I $G(DATE)>0  Q:$P(X,U,2)\1>DATE 0
 Q "1"_U_$P(X,U,2)
 ;
 ;***** CHECKS IF THE ICR RECORD EXISTS
 ;
 ; IEN           IEN of the registry record
 ;
 ; Return Values:
 ;        0  Record does not exist
 ;        1  The ICR record exists
 ;
ICRDEF(IEN) ;
 Q $G(^RORDATA(799.4,+IEN,0))>0
 ;
 ;***** RETURNS NUMBER OF AVAILABLE CATEGORIES
NCAT() ;
 Q $L($P($T(CAT+1),";;",2),U)
