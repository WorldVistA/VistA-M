MAGUTERR ;WOIFO/MLH - Imaging - utility - error trap / log with Unix-style codes ; 2/22/2013 9:24 am
 ;;3.0;IMAGING;**138**;Mar 19, 2002;Build 5380;Sep 03, 2013
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
 Q  ;
 ;  Based on MAGGTERR by GEK
 ;  Imaging routines should have this code for setting a Unix-style
 ;  error code (-1) and logging it in the error trap
 ;To set into MAGRY()     (local array by direct literal reference)
 ;N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGUTERR"
 ;
 ;To set into @MAGRY@()   (local or global array by partial indirection)
 ;N $ETRAP,$ESTACK S $ETRAP="D AERRA^MAGUTERR"
 ;
 ;To set into MAGRY       (scalar by direct literal reference)
 ;N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGUTERR"
 ;
 Q
ERRA ; ERROR TRAP FOR Array Return variables
 N ERR S ERR=$$EC^%ZOSV
 S MAGRY(0)="-1^^ERROR "_ERR
 D LOGERR(ERR)
 D @^%ZOSF("ERRTN")
 Q
 ;
AERRA ; ERROR TRAP FOR Global Return Variables
 N ERR S ERR=$$EC^%ZOSV
 S @MAGRY@(0)="-1^^ERROR "_ERR
 D LOGERR(ERR)
 D @^%ZOSF("ERRTN")
 Q
ERR ; ERROR TRAP FOR String Return variables
 N ERR S ERR=$$EC^%ZOSV
 S MAGRY="-1^^ERROR "_ERR
 D LOGERR(ERR)
 D @^%ZOSF("ERRTN")
 Q
LOGERR(ERROR) ;
 Q:'$G(MAGJOB("SESSION"))
 N SESS,WRKS,ERR
 S SESS=$G(MAGJOB("SESSION"))
 ; Quit if No entry in Session File.
 Q:'$D(^MAG(2006.82,SESS,0))
 I '$D(^MAG(2006.82,SESS,"ERR",0)) S ^MAG(2006.82,SESS,"ERR",0)="^2006.823A^0^0"
 S ERR=$O(^MAG(2006.82,SESS,"ERR"," "),-1)+1
 S ^MAG(2006.82,SESS,"ERR",ERR,0)=ERROR
 S $P(^MAG(2006.82,SESS,"ERR",0),"^",3,4)=ERR_"^"_ERR
 ;
 Q:'$G(MAGJOB("WRKSIEN"))
 S WRKS=$G(MAGJOB("WRKSIEN"))
 ; Quit if No entry in Workstation File.
 Q:'$D(^MAG(2006.81,WRKS,0))
 S $P(^MAG(2006.81,WRKS,0),"^",11)=ERR
 Q
