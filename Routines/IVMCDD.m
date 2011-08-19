IVMCDD ;ALB/CJM - DATA DICTIONARY FUNCTIONS ; 01/30/2004
 ;;2.0;INCOME VERIFICATION MATCH;**17,89**;21-OCT-94
 ;
FUTMT(IVMPAT,MTIEN) ;
 ;Sets the "AC" x-ref on the IVM Patient file
 ;Input - 
 ;  IVMPAT - ien of IVM Patient file record
 ;  MTIEN - ien of record in Annual Means Test file
 ;
 Q:'$G(IVMPAT)
 Q:'$G(MTIEN)
 Q:'(+$G(^DGMT(408.31,MTIEN,0)))
 Q:+$G(^DGMT(408.31,MTIEN,0))'>DT
 S ^IVM(301.5,"AC",+$G(^DGMT(408.31,MTIEN,0)),IVMPAT,MTIEN)=""
 Q
 ;
NOFUTMT(IVMPAT,MTIEN) ;
 ;Kill logic for the "AC" x-ref on the IVM Patient file
 ;Input - 
 ;  IVMPAT - ien of IVM Patient file record
 ;  MTIEN - ien of record in Annual Means Test file
 ;
 Q:'$G(IVMPAT)
 Q:'$G(MTIEN)
 Q:'(+$G(^DGMT(408.31,MTIEN,0)))
 K ^IVM(301.5,"AC",+$G(^DGMT(408.31,MTIEN,0)),IVMPAT,MTIEN)
 Q
 ;
FUTRX(IVMPAT,MTIEN) ;
 ;Sets the "AD" x-ref on the IVM Patient file
 ;Input - 
 ;  IVMPAT - ien of IVM Patient file record
 ;  MTIEN - ien of record in Annual Means Test file
 ;
 Q:'$G(IVMPAT)
 Q:'$G(MTIEN)
 Q:'(+$G(^DGMT(408.31,MTIEN,0)))
 Q:+$G(^DGMT(408.31,MTIEN,0))'>DT
 S ^IVM(301.5,"AD",+$G(^DGMT(408.31,MTIEN,0)),IVMPAT,MTIEN)=""
 Q
 ;
NOFUTRX(IVMPAT,MTIEN) ;
 ;Kill logic for the "AD" x-ref on the IVM Patient file
 ;Input - 
 ;  IVMPAT - ien of IVM Patient file record
 ;  MTIEN - ien of record in Annual Means Test file
 ;
 Q:'$G(IVMPAT)
 Q:'$G(MTIEN)
 Q:'(+$G(^DGMT(408.31,MTIEN,0)))
 K ^IVM(301.5,"AD",+$G(^DGMT(408.31,MTIEN,0)),IVMPAT,MTIEN)
 Q
AESET(IVMPAT,MTIEN) ;
 ;Sets the "AE" x-ref on the IVM Patient file
 ;Input - 
 ;  IVMPAT - ien of IVM Patient file record
 ;  MTIEN - ien of record in Annual Means Test file
 ;
 ;s ^IVM(301.5,"AE",dfn,date of means test,means test ien,ivm patient ien)
 Q:'$G(IVMPAT)
 Q:'$G(MTIEN)
 Q:'(+$G(^IVM(301.5,IVMPAT,0)))
 Q:'(+$G(^DGMT(408.31,MTIEN,0)))
 Q:+$G(^DGMT(408.31,MTIEN,0))'>DT
 S ^IVM(301.5,"AE",+$G(^IVM(301.5,IVMPAT,0)),+$G(^DGMT(408.31,MTIEN,0)),MTIEN,IVMPAT)=""
 Q
 ;
AEKILL(IVMPAT,MTIEN) ;
 ;Kill logic for the "AE" x-ref on the IVM Patient file
 ;Input - 
 ;  IVMPAT - ien of IVM Patient file record
 ;  MTIEN - ien of record in Annual Means Test file
 ;
 ;K ^IVM(301.5,"AE",dfn,date of means test,means test ien,ivm patient ien)
 Q:'$G(IVMPAT)
 Q:'$G(MTIEN)
 Q:'(+$G(^DGMT(408.31,MTIEN,0)))
 Q:'(+$G(^IVM(301.5,IVMPAT,0)))
 K ^IVM(301.5,"AE",+$G(^IVM(301.5,IVMPAT,0)),+$G(^DGMT(408.31,MTIEN,0)),MTIEN,IVMPAT)
 Q
 ;
AFSET(IVMPAT,MTIEN) ;
 ;Sets the "AF" x-ref on the IVM Patient file
 ;Input - 
 ;  IVMPAT - ien of IVM Patient file record
 ;  MTIEN - ien of record in Annual Means Test file
 ;
 ;s ^IVM(301.5,"AF",dfn,date of copay test,copay test ien,ivm patient ien)
 Q:'$G(IVMPAT)
 Q:'$G(MTIEN)
 Q:'(+$G(^DGMT(408.31,MTIEN,0)))
 Q:'(+$G(^IVM(301.5,IVMPAT,0)))
 Q:+$G(^DGMT(408.31,MTIEN,0))'>DT
 S ^IVM(301.5,"AF",+$G(^IVM(301.5,IVMPAT,0)),+$G(^DGMT(408.31,MTIEN,0)),MTIEN,IVMPAT)=""
 Q
 ;
AFKILL(IVMPAT,MTIEN) ;
 ;Kill logic for the "AF" x-ref on the IVM Patient file
 ;Input - 
 ;  IVMPAT - ien of IVM Patient file record
 ;  MTIEN - ien of record in Annual Means Test file
 ;
 ;K ^IVM(301.5,"AF",dfn,date of copay test,copay test ien,ivm patient ien)
 Q:'$G(IVMPAT)
 Q:'$G(MTIEN)
 Q:'(+$G(^DGMT(408.31,MTIEN,0)))
 Q:'(+$G(^IVM(301.5,IVMPAT,0)))
 K ^IVM(301.5,"AF",+$G(^IVM(301.5,IVMPAT,0)),+$G(^DGMT(408.31,MTIEN,0)),MTIEN,IVMPAT)
 Q
