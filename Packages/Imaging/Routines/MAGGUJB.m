MAGGUJB ;WOIFO/GEK - Create file reference ; 20 Jan 2011 1:14 PM
 ;;3.0;IMAGING;**117**;Mar 19, 2002;Build 2238;Jul 15, 2011
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
 Q
 ;***** Returns the Juke Box path to an image
 ; RPC: MAGG JUKE BOX PATH
 ;
 ; Input Parameters
 ; ================
 ;   MAGIEN is IEN number in IMAGE file (#2005) or IMAGE AUDIT file (#2005.1)
 ;
 ; Return Values
 ; =============
 ; if error MAGRY = 0^error message
 ; if success MAGRY = 1^full juke box path
 ;                              
JB(MAGRY,MAGIEN) ; RPC [MAGG JUKE BOX PATH] 
 ; RETURN THE PATH TO THE JB OF THE IMAGE... DELETED OR NOT.
 N MAGFILE,MAGPREF,MAGSUFF,MAGFILE1
 S MAGFILE=$$FILE^MAGGI11(MAGIEN)
 I MAGFILE'>0 S MAGRY="0^Invalid IEN" Q  ; problem getting file number
 S (MAGPREF,MAGSUFF,MAGFILE1)=""
 D FINDFILE
 S MAGRY=MAGPREF_"^"_MAGFILE1
 I MAGSUFF]"" S MAGRY=MAGRY_"^"_MAGSUFF
 S MAGRY="1^"_MAGIEN_"^"_MAGRY
 Q
 ; 
FINDFILE ;
 ;;; NOTE : in Clinical Display application, we sometimes use the JB Path. If the
 ;;; Image Server is offline, or doesn't exist the JB path is returned.
 ;;; Then a JB Copy Queue is created so that the JB Copy of the image 
 ;;; is put on RAID for quicker access next time.
 ;;; in 117 we always want to return the JB path, but we still need the tests for 
 ;;; offline, invalid network location , etc.
 N MAG0,MAGREF,MAGSTORE,MAGTYPE
 S (MAGTYPE,MAGREF)=""
 S MAG0=^MAG(MAGFILE,+MAGIEN,0)
 S MAGFILE1=$P(MAG0,"^",2)
 S MAGFILE1=$P(MAGFILE1,"\",$L(MAGFILE1,"\"))
 ; 
 S MAGREF=$P(MAG0,"^",5)
 I MAGREF="" S MAGFILE1="-1~NO JUKEBOX LOCATION DEFINED" Q
 I '$D(^MAG(2005.2,MAGREF,0)) S MAGFILE1="-1~INVALID NETWORK LOCATION POINTER ->"_MAGREF Q
 S MAGSTORE=^MAG(2005.2,MAGREF,0)
 S MAGTYPE=$P(MAGSTORE,"^",7)
 I MAGTYPE="" S MAGTYPE=$E(MAGSTORE,1,4) ; in case the type is null
 ;
 ;; In case the JB is defined to be OffLine, we still want to return the path.
 I '$P(MAGSTORE,"^",6) D  ;jbox cartridge offline
 . S MAGSUFF="JB Location: "_MAGREF_" is OFFLINE"
 . Q
 ;
 S MAGPREF=""
 I MAGTYPE?1"WORM".E D  ; code for Jukeboxes
 . I MAGTYPE=("WORM-OTG") S MAGPREF=$P(MAGSTORE,"^",2)
 . E  I MAGTYPE="WORM-PDT" S MAGPREF=$P(MAGSTORE,"^",2)
 . E  I MAGTYPE["WORM-DG" D  ; this code is for DG/SONY jukebox
 . . N SUBDIR ; the subdirectory is the last two digits of the file name
 . . S SUBDIR=$P(MAGFILE1,".")
 . . S SUBDIR=$E(100+$E(SUBDIR,$L(SUBDIR)-1,999),2,3)_"\"
 . . S MAGPREF=$P(MAGSTORE,"^",2)_SUBDIR
 . . Q
 . Q
 S MAGPREF=MAGPREF_$$DIRHASH^MAGFILEB(MAGFILE1,MAGREF)
 Q
