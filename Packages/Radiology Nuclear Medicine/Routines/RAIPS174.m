RAIPS174 ;Hines OIFO/GJC-Rad/NM Post-init Driver, patch 174; Oct 01, 2020@13:32:40
 ;;5.0;Radiology/Nuclear Medicine;**174**;Mar 16, 1998;Build 2
 ;New standardized Cerner Millinium cancel reason
 ;
EN      ;start here
 N RAERR,RAFDA,RANOA,RANTL,RAREA,RAR,RASYN,RATXT,RATYP
 S RAR="RAFDA(75.2,""?+1,"")" ;add only if new
 S RAREA="MILLENNIUM CONVERSION",RASYN="CERNER CUTOVER"
 S RATYP=1,RANOA="i",RANTL="Y"
 S @RAR@(.01)=RAREA ;Reason
 S @RAR@(2)=RATYP   ;Type of Reason (1=cancel)
 S @RAR@(3)=RASYN   ;Synonym
 S @RAR@(4)=RANOA   ;Nature of Order Activity: 'i' = 'Policy'
 S @RAR@(5)=RANTL   ;NATIONAL flag = YES
 D UPDATE^DIE(,"RAFDA","","RAERR(175)") ;only internal FM values
 I $D(RAERR(175,"DIERR"))#2 S RATXT="Error when filing data for "_RAREA
 E  S RATXT=RAREA_" filed."
 D MES^XPDUTL(RATXT)
 Q
 ;
