DG53858P ;ALB/BDB - VFA PROJECT POST-INSTALL;8/30/12
 ;;5.3;Registration;**858**;Aug 13, 1993;Build 30
 ;
 ; This routine will set the VFA Start Date into the
 ;  MAS PARAMETERS file (#43)
 ;
EN ; Entry point for post-install
 D VFA
 Q
 ;
VFA ; Set the VFA Start Date equal to January 1, 2013
 D BMES^XPDUTL(">>>VFA Start Date set to January 1, 2013.")
 S ^DG(43,1,"VFA")="3130101"
 Q
 ;
