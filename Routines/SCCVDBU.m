SCCVDBU ;ALB/RMO,TMP - Database Update Utilities; [ 03/23/95  11:08 AM ]
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
UPD(SCFILE,SCIENS,SCDATA,SCERR) ;File data into an existing entry
 ; Input  -- SCFILE   File or sub-file number
 ;           SCIENS   Internal entry number(s)
 ;           SCDATA   Data array to file
 ; Output -- SCERR     DEFINED=error
 N SCFDA,SCFIELD
 S SCFIELD=0
 F  S SCFIELD=$O(SCDATA(SCFIELD)) Q:'SCFIELD  D
 . S SCFDA(SCFILE,SCIENS_",",SCFIELD)=$G(SCDATA(SCFIELD))
 D FILE^DIE("K","SCFDA","")
 I $G(DIERR) S SCERR=U_$G(^TMP("DIERR",$J,$P(DIERR,U,2),"TEXT",1))
 D CLEAN^DILF
UPDQ Q
 ;
ADD(SCFILE,SCIENS,SCDATA,SCERR) ;File data into a new or existing entry
 ; Input  -- SCFILE   File or sub-file number
 ;           SCIENS   Internal entry number(s)
 ;           SCDATA   Data array to file
 ; Output -- SCERR    DEFINED=error
 N SCFDA,SCFIELD
 S SCFIELD=0
 F  S SCFIELD=$O(SCDATA(SCFIELD)) Q:'SCFIELD  D
 . S SCFDA(SCFILE,SCIENS_",",SCFIELD)=$G(SCDATA(SCFIELD))
 D UPDATE^DIE("","SCFDA","","")
 I $G(DIERR) S SCERR=U_$G(^TMP("DIERR",$J,$P(DIERR,U,2),"TEXT",1))
 D CLEAN^DILF
ADDQ Q
 ;
WP(SCFILE,SCIENS,SCFIELD,SCDATA) ;File data into a single word processing field
 ; Input  -- SCFILE   File or sub-file number
 ;           SCIENS   Internal entry number(s)
 ;           SCFIELD  Field number
 ;           SCDATA   Data array to file
 ; Output -- ;add- SCERR     0=error and 1=no error
 D WP^DIE(SCFILE,SCIENS_",",SCFIELD,"AK","SCDATA(""WP"")","")
 D CLEAN^DILF
WPQ Q
