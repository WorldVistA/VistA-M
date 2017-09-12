MAGIPS96 ;Post init routine to queue site activity at install ; 16 Feb 2004  2:41 PM
 ;;3.0;IMAGING;**96**;April 29, 2008;Build 9
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
POST ;
 ; create and send the site installation message
 D VERCHKON ; Turn on Version Checking
 D REMTASK^MAGQE4
 D STTASK^MAGQE4
 D INS^MAGQBUT4(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 Q
VERCHKON ; Turn on Version Checking at the Sites.
 ; We aren't forcing it to stay on, sites can turn it back off.
 N MAGIEN,MAGSITE,VERCHK,MSG
 S MAGIEN=0
 F  S MAGIEN=$O(^MAG(2006.1,MAGIEN)) Q:'MAGIEN  D
 . S MSG="is already ON, no action taken"
 . S MAGSITE=$P($G(^MAG(2006.1,MAGIEN,0)),"^",1)
 . S VERCHK=$P($G(^MAG(2006.1,MAGIEN,"KEYS")),"^",5)
 . I 'VERCHK S $P(^MAG(2006.1,MAGIEN,"KEYS"),"^",5)=1 S MSG="has been turned ON"
 . D MES^XPDUTL("Patch 96 is turning Version Checking ON...")
 . D MES^XPDUTL("Version Checking "_MSG_" for Site: "_MAGSITE)
 Q
