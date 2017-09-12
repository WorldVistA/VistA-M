MAGIP151 ;WOIFO/GEK - INSTALL CODE FOR MAG*3.0*151 - Scanning issues ;
 ;;3.0;IMAGING;**151**;Mar 19, 2002;Build 21;Dec 19, 2016
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
 ; There are no environment checks here but the MAGIP151 has to be
 ; referenced by the "Environment Check Routine" field of the KIDS
 ; build so that entry points of the routine are available to the
 ; KIDS during all installation phases.
 ;
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
 N I,HUD,HUC
 D CLEAR^MAGUERR(1)
 ;
 ;--- Link new remote procedures to the Broker context option
 ;*** None for 151 **
 ;S CALLBACK="$$ADDRPCS^"_$NA(MAGKIDS1("RPCLST^"_$T(+0),"MAG WINDOWS"))
 ;I $$CP^MAGKIDS("MAG ATTACH RPCS",CALLBACK)<0  D ERROR  Q
 ;
 ;
 ;--- Misc Updates
 ;*** None for 151 **
 ;I $$CP^MAGKIDS("MAG 151 MISC UPDATES ","$$UPDATE^"_$T(+0))<0 D ERROR Q
 ;
 ;--- Add Display and Capture User Manual url's to the IMAGING SITE PARAMETERS File.
 ;   #(2006.1)
 S HUD="http://vaww.oed.portal.domain.ext/applications/VistAImaging/VistA%20Enterprise%20Documents/User%20Manuals/MAG_Display_User_Manual.pdf"
 S HUC="http://vaww.oed.portal.domain.ext/applications/VistAImaging/VistA%20Enterprise%20Documents/User%20Manuals/MAG_Capture_User_Manual.pdf"
 S I=0 
 F  S I=$O(^MAG(2006.1,I)) Q:'I  D  ;
 . S ^MAG(2006.1,I,"HELPD")=HUD
 . S ^MAG(2006.1,I,"HELPC")=HUC
 . Q
 ;--- Send the notification e-mail
 D BMES^XPDUTL("Post Install Mail Message: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D INS^MAGQBUT4(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 ;
 Q
 ;
 ;***** PRE-INSTALL CODE
PRE ;
 ;
 Q
