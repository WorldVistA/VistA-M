MAGIP119 ;WOIFO/BT,NST - INSTALL CODE FOR MAG*3.0*119 ; 3/18/13 1:15pm
 ;;3.0;IMAGING;**119**;Mar 19, 2002;Build 4396;Apr 19, 2013
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ; There are no environment checks here but the MAGIP119 has to be
 ; referenced by the "Environment Check Routine" field of the KIDS
 ; build so that entry points of the routine are available to the
 ; KIDS during all installation phases.
 Q
 ;
 ;+++++ INSTALLATION ERROR HANDLING
ERROR ;
 S:$D(XPDNM) XPDABORT=1
 ;--- Display the messages and store them to the INSTALL file
 D DUMP^MAGUERR1(),ABTMSG^MAGKIDS()
 Q
 ;
 ;***** POST-INSTALL CODE
POS ;
 N CALLBACK
 D CLEAR^MAGUERR(1)
 ;
 ;--- Various Updates
 I $$CP^MAGKIDS("MAG P119 UPDATE","$$UPDATE^"_$T(+0))<0  D ERROR  Q
 ;
 ;--- Build new index in file #2005.1
 I $$CP^MAGKIDS("MAG IMAGE INDEX","$$UPD20051^MAGGTUX5")<0 D ERROR  Q
 ;
 ;--- Send the notification e-mail
 I $$CP^MAGKIDS("MAG NOTIFICATION","$$NOTIFY^MAGKIDS1")<0  D ERROR  Q
 Q
 ;
 ;+++++ Various updates
UPDATE() ;
 D EN^MAGGDEV  ; Update TERMINAL TYPE file (#3.2)
 Q 0
 ;
 ;***** PRE-INSTALL CODE
PRE ;
 Q
