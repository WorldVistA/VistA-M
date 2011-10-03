PXCESDA3 ;ISL/dee - PCE List Manager display of appointments by hospital location ;6/20/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;;Aug 12, 1996
 ;;
 ;Developed using code from:
SDAM3 ;MJK/ALB - Appt Mgt (Clinic) ; 12/1/91
 ;;5.3;Scheduling;;Aug 13, 1993
 Q
 ;
 ;This is the INIT in SDAM3
INTSDAM3 ; -- get init clinic appt data
 ;  input:        SDCLN := ifn of pat
 ; output:  ^TMP("SDAM" := appt array
 ;SDBEG and SDEND are already set.
 D SETSDAM3
 D LIST^SDAM
 K VALMB,VALMBEG,VALMEND
 Q
 ;
CLNSDAM3 ; -- change clinic
 D SETSDAM3
 D BLD^SDAM3
CLNQ Q
 ;
SETSDAM3 ;
 S SDAMTYP="C" ;                                          Type is clinic
 S SDCLN=PXCEHLOC ;          Pointer to the Hospital Location file (#44)
 K SDFN ;                            No pointer to the patient file (#2)
 D CHGCAP^VALM("NAME","Patient")
 S X="ALL"
 Q
 ;
