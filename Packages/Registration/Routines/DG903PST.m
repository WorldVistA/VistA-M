DG903PST ;ALB/JCH - DG*5.3*903 POST INSTALL ; 11/10/14 9:51am
 ;;5.3;Registration;**903**;Aug 13, 1993;Build 82
 ;
 ; Submitted to OSEHRA 04/02/2015 by HP
 ; PCHK entry points authored by James Harris 2014-2015
 ;
 Q
POST  ; Add entry 315 in INCONSISTENT DATA ELEMENTS file (#38.6)
 ; and Enable MyHeatheVet in the MAS PARAMETERS (#43) File.
 ;
 D PCHK
 ; Enable MyHealtheVet Prompts? (#1100.07) field in the the MAS PARAMETERS (#43) File
 ; is set to "NO" which disables the "Increase Engagement in My HealtheVet" Pre-Register
 ; Patient Interface.
 N DIE,DR,DA
 S DIE="^DG(43,",DA=1,DR="1100.07///0" D ^DIE
 Q
 ;
PCHK  ; File new INCONSISTENT DATA ELEMENTS (#38.6) file entry for missing MHV Registration status
 N DIE,X,Y,DR,DA,DIC,DGFILE,DGIENS,DGFIELD,DGWROOT,DGMROOT,DGMSG,DGTXT
 Q:$D(^DGIN(38.6,315))  ; Rule #315 already exists. Can't overwrite different rule, but rule #'s are hard coded in DGRPC*
 S DIE="^DGIN(38.6,",DA=315,DR=".01////MHV REGISTRATION STATUS ABSENT;2////MY HEALTHEVET REGISTRATION STATUS ABSENT/MISSING;3////0;4////0;5////1" D ^DIE
 N DIE,X,Y,DR,DA,DIC
 S DGFILE="38.6",DGIENS="315,",DGFIELD=50,DGWROOT="DGTXT",DGMROOT="DGMSG",DGMSG=""
 S DGTXT(1)="This check ensures a patient has been asked about their registration, or "
 S DGTXT(2)="interest in registration, in My HealtheVet.  It will only be checked if the "
 S DGTXT(3)="'Enable MyHealtheVet Prompts?' (#1100.07) field in the MAS PARAMETERS (#43)"
 S DGTXT(4)="file is set to 'YES'."
 D WP^DIE(DGFILE,DGIENS,DGFIELD,,DGWROOT,DGMROOT)
 Q 
 ;
