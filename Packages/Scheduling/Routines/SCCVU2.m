SCCVU2 ;ALB/RMO,TMP - SCHED VISITS CONVERT/ARCHIVE UTILITIES; [ 10/10/95  2:39 PM ]
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
VERDT(SCSTDT,SCENDT,SCLOG,SCERRMSG) ;Verify date range is valid
 ; Input  -- SCSTDT   Start date
 ;           SCENDT   End date
 ;           SCLOG    CST log IEN  [optional]
 ; Output -- #=Error number and 0=No Error
 ;           SCERRMSG Error message
 N SCERRNB,SCNVPAR
 S SCERRNB=0
 S SCNVPAR=$G(^SD(404.91,1,"CNV"))
 ;
 ;Check start date
 I SCSTDT D
 . I SCSTDT<+SCNVPAR D  ;start dt cannot be before earliest encounter dt
 . . N SCERRIP,Y
 . . S SCERRNB=4049001.001
 . . S Y=+SCNVPAR D D^DIQ S SCERRIP(1)=Y
 . . D GETERR^SCCVLOG1(SCERRNB,"",.SCERRIP,$G(SCLOG),1,.SCERRMSG)
 ;
 ;Check end date
 I 'SCERRNB,SCENDT D
 . I SCENDT<+SCNVPAR D  ;end dt cannot be before earliest encounter dt
 . . N SCERRIP,Y
 . . S SCERRNB=4049001.004
 . . S Y=+SCNVPAR D D^DIQ S SCERRIP(1)=Y
 . . D GETERR^SCCVLOG1(SCERRNB,"",.SCERRIP,$G(SCLOG),1,.SCERRMSG)
 ;
 ;Check date range
 I 'SCERRNB,SCSTDT,SCENDT D
 . I SCSTDT>SCENDT D  ;start date cannot be after end date
 . . S SCERRNB=4049001.005
 . . D GETERR^SCCVLOG1(SCERRNB,"","",$G(SCLOG),1,.SCERRMSG)
 . I 'SCERRNB,SCENDT<SCSTDT D  ;end date cannot be before start date
 . . S SCERRNB=4049001.006
 . . D GETERR^SCCVLOG1(SCERRNB,"","",$G(SCLOG),1,.SCERRMSG)
 ;
 ;Check for 1 year limit if parameter set
 I 'SCERRNB,$P(SCNVPAR,U,5),$$FMADD^XLFDT(SCSTDT,365)<SCENDT D
 . S SCERRNB=4049001.007
 . D GETERR^SCCVLOG1(SCERRNB,"","",$G(SCLOG),1,.SCERRMSG)
 Q SCERRNB
 ;
CHKDUP(SCCVTYP,SCSTDT,SCENDT,SCLOG,SCERRMSG) ;Check for duplicate type and date range for conversion entry
 ; Input  -- SCCVTYP  Conversion type
 ;           SCSTDT   Start date
 ;           SCENDT   End date
 ;           SCLOG    CST log IEN
 ; Output -- #=Error number and 0=No Error
 ;           SCERRMSG Error message
 N SCERRNB,SCLOGX,SCCV0,SCDTS,SCDTE
 S (SCERRNB,SCLOGX)=0
 F  S SCLOGX=$O(^SD(404.98,"TYP",SCCVTYP,SCLOGX)) Q:'SCLOGX!(SCERRNB)  I SCLOG'=SCLOGX D
 . S SCCV0=$G(^SD(404.98,SCLOGX,0)),SCDTS=$P(SCCV0,U,3),SCDTE=$P(SCCV0,U,4)
 . Q:$P(SCCV0,U,9)  ;Template canceled
 . ;
 . ; -- 'IF SCDTE<SCSTDT!(SCDTS>SCENDT) Q'
 . ;    If (end < new start) or (start > new end) then ok and quit
 . ;    Next line is boolean negative of above 'If'
 . ;
 . I SCDTE'<SCSTDT,SCDTS'>SCENDT D  ;date range overlap
 . . N SCERRIP
 . . S SCERRNB=4049001.01
 . . S SCERRIP(1)=SCLOGX
 . . D GETERR^SCCVLOG1(SCERRNB,"",.SCERRIP,$G(SCLOG),1,.SCERRMSG)
 ;
 Q SCERRNB
 ;
PROCSEL(SCRESULT,SC) ; -- Process Archive SELECT request - not used
 ; Input  -- SC       Array:
 ;                    SC("TEMPLNO")    Template number ien
 ;                      ("REQNUM")     Request number ien
 ; Output -- SCRESULT (#=Error number | 0=No Error)^Message
 ;
 Q
 N SCERRMSG,SCERRNB,SCLOG,SCREQ,SCREQACT
 S SCERRNB=0
 ;
 S SCLOG=$G(SC("TEMPLNO"))
 S SCREQ=$G(SC("REQNUM"))
 ;
 ;Quit if Template number ien or request ien are not defined
 I 'SCLOG!('SCREQ) D
 . S SCERRNB=4049007.003
 . D GETERR^SCCVLOG1(SCERRNB,"","","",1,.SCERRMSG)
 ;
 S SCRESULT=$S('SCERRNB:0,1:SCERRNB_U_$$BLDSTR^SCCVU1(.SCERRMSG))
 ;
 G:SCERRNB PROCSELQ
 ;
 ; Set request action
 S SCREQACT=$P($G(^SD(404.99,SCLOG,"R",SCREQ,0)),U,2)
 ;
 ; Queue archive select request
 ;D QSEL^SCCVAST1(SCLOG,SCREQ)
 ;
PROCSELQ Q
 ;
OTHERR(ERRNO) ; Returns text of specific errors for error log
 N X
 S ERRNO=ERRNO+1
 S X=$P($T(ERRLIST+ERRNO),";;",3,99)
 Q X
 ;
ERRLIST ; List of 'OTHER' specific errors  ;;ERROR # (OFFSET-1);;ERROR TEXT
 ;;0;;Unknown
 ;;1;;Appointment does not exist in clinic file
 ;;2;;Encounter was not created for appointment
 ;;3;;Visit was not created for appointment
 ;;4;;Add/edit's top level 0-node does not exist
 ;;5;;Add/edit does not have a valid patient DFN
 ;;6;;Add/edit does not have a valid division 
 ;;7;;Add/edit does not have a valid clinic stop
 ;;8;;Disposition does not have a valid hospital location
 ;;9;;Add/edit's "CS" level 0-node does not exist
 ;
