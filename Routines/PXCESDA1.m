PXCESDA1 ;ISL/dee - PCE List Manager display of appointments by patient ;6/20/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;;Aug 12, 1996
 ;;
 ;Developed using code from:
SDAM1 ;MJK/ALB - Appt Mgt (Patient); 12/1/91
 ;;5.3;Scheduling;;Aug 13, 1993
 Q
 ;
 ;This is the INIT in SDAM1
INTSDAM1 ; -- get init pat appt data
 ;  input:          DFN := ifn of pat
 ; output:  ^TMP("SDAM" := appt array
 ;SDBEG and SDEND are already set.
 D SETSDAM1
 D LIST^SDAM
 Q
 ;
PATSDAM1 ; -- change pat
 D SETSDAM1
 D BLD^SDAM1
PATQ Q
 ;
SETSDAM1 ;
 S SDAMTYP="P" ;                                         Type is Patient
 S SDFN=PXCEPAT ;                       Pointer to the Patient file (#2)
 K SDCLN ;                No pointer to the Hospital Location file (#44)
 D CHGCAP^VALM("NAME","Clinic")
 S X="ALL"
 Q
 ;
