SDES30 ;ALB/ANU - VISTA SCHEDULING RPCS ;JUN 08, 2021
 ;;5.3;Scheduling;**790**;Aug 13, 1993;Build 11
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
 Q
 ;
SPACEBAR(SDESY,SDESDIC,SDESVAL) ;Update ^DISV with most recent lookup value SDESVAL from file SDESDIC
 ;SPACEBAR(SDESY,SDESDIC,SDESVAL)  external parameter tag is in SDES
 ;SDESDIC is the data global in the form GLOBAL(
 ;SDESVAL is the entry number (IEN) in the file
 ;
 ;Return Status = 1 if success, 0 if fail
 ;
 S SDESY="^TMP(""SDES"","_$J_")"
 K @SDESY
 N SDES1,SDESRES
 S SDESI=0
 I (SDESDIC="")!('+$G(SDESVAL)) D ERR(SDESI+1,99) Q
 S SDESDIC="^"_SDESDIC
 S ^TMP("SDES",$J,0)="T00020ERRORID"_$C(30)
 I $D(@(SDESDIC_"SDESVAL,0)")),'$D(^(-9)) D     ;Note:  Naked reference is immediately preceded by the full global reference per SAC 2.2.2.8
 . S ^DISV(DUZ,SDESDIC)=SDESVAL
 . S SDESRES=1
 E  S SDESRES=0
 S SDESI=SDESI+1
 S ^TMP("SDES",$J,SDESI)=SDESRES_$C(30)_$C(31)
 Q
 ;
ERR(SDESI,SDESERR) ;Error processing
 S SDESI=SDESI+1
 S ^TMP("SDES",$J,SDESI)=SDESERR_$C(30)
 S SDESI=SDESI+1
 S ^TMP("SDES",$J,SDESI)=$C(31)
 Q
 ;
ETRAP ;EP Error trap entry
 I '$D(SDESI) N SDESI S SDESI=999
 S SDESI=SDESI+1
 D ERR(99,0)
 Q
 ;
