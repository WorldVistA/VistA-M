MAGIP104  ;WOIFO/NST - INSTALL CODE FOR MAG*3.0*104 ; 20 Oct 2010 3:22 PM
 ;;3.0;IMAGING;**104**;Mar 19, 2002;Build 2225;Jul 12, 2011
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
 ; There are no environment checks here but the MAGIP104 has to be
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
 ;--- Restart the Imaging Utilization Report task
 I $$CP^MAGKIDS("MAG REPORT TASK","$$RPTSKCP^"_$T(+0))<0  D ERROR  Q
 ;
 ;--- Send the notification e-mail
 I $$CP^MAGKIDS("MAG NOTIFICATION","$$NOTIFY^MAGKIDS1")<0  D ERROR  Q
 Q
 ;
 ;***** PRE-INSTALL CODE
PRE ;
 ;---
 Q
 ;
 ;+++++ RESTARTS THE IMAGING UTILIZATION REPORT TASK
RPTSKCP() ;
 D REMTASK^MAGQE4,STTASK^MAGQE4
 Q 0
