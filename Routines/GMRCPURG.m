GMRCPURG ;SLC/DLT,DCM - Purge orders from the Order File 100 ;10/21/98  09:07
 ;;3.0;CONSULT/REQUEST TRACKING;**1**;DEC 27, 1997
CPRSPURG(GMRCO) ;Purge File 100 record number from file 123 upon request from ORDER ENTRY/RESULTS REPORTING
 ;Called from GMRCHL7A when HL-7 control code is GMRCTRLC="Z@"
 ;GMRCO=IEN from file 123 which is to have file 100 pointer deleted
 ;
 Q  ; This functionality will be introduced with a later patch
 ;
