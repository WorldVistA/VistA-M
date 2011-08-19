DGQEDD ;ALB/RPM - VIC REPLACEMENT DATA DICTIONARY UTILITIES ; 12/30/03
 ;;5.3;Registration;**571**;Aug 13, 1993
 ;
 Q  ;no direct entry
 ;
XMITON(DGIEN) ;turn on the TRANSMISSION REQUIRED flag
 ; This procedure sets the TRANSMISSION REQUIRED (#.05) field of the
 ; VIC REQUEST (#39.6) file to "YES".
 ; The procedure is used by the ASTAT2XMIT trigger on the CARD PRINT
 ; RELEASE STATUS (#.03) field of the VIC REQUEST (#39.6) file.
 ;
 ;  Input:
 ;    DGIEN - pointer to VIC REQUEST (#39.6) file
 ;
 ;  Output:
 ;    none
 ;
 N DGERR
 N DGFDA
 ;
 S DGFDA(39.6,DGIEN_",",.05)="Y"
 D FILE^DIE("","DGFDA","DGERR")
 Q
 ;
 ;
XMITOFF(DGIEN) ;turn off the TRANSMISSION REQUIRED flag
 ; This procedure sets the TRANSMISSION REQUIRED (#.05) field of the
 ; VIC REQUEST (#39.6) file to "NO".
 ; The procedure is used by the ASTAT2XMIT trigger on the CARD PRINT
 ; RELEASE STATUS (#.03) field of the VIC REQUEST (#39.6) file.
 ;
 ;  Input:
 ;    DGIEN - pointer to VIC REQUEST (#39.6) file
 ;
 ;  Output:
 ;    none
 ;
 N DGERR
 N DGFDA
 ;
 S DGFDA(39.6,DGIEN_",",.05)="N"
 D FILE^DIE("","DGFDA","DGERR")
 Q
