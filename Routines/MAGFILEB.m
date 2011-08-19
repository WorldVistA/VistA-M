MAGFILEB ;WOIFO/RED - CREATE FILE REFERENCE FROM ^MAG(2005) ; 10/22/2002  06:39
 ;;3.0;IMAGING;**8,48,39**;Mar 19, 2002;Build 2010;Mar 08, 2011
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
 ; CALL WITH MAGXX=IEN NUMBER IN IMAGE FILE (2005)
 ;Calling FINDFILE requires FILETYPE to be defined ["FULL"|"ABSTRACT"|"BIG"|"TEXT"]
 ;   returns : 
 ; ..MAGFILE1 =          FILENAME ONLY
 ; ..MAGFILE1(.01)=      .01 FIELD OF FILE (2005)
 ; ..MAGFILE1("ERROR") = Message if NetWork device is offline and Image Not On JB
 ; ..MAGINST =                   Pointer to Institution File (Consolidated)
 ; ..                      OR  IEN of Imaging Site Parameters only entry (Non-Consolidated)
 ; ..MAGJBOL =                   NULL("")  OR " ** "_Name of Platter that is Offline"_" ** "
 ; ..MAGOFFLN =                  NULL("")  OR "1"   "1" means image is on platter that is offline.
 ; ..MAGPLACE =                  PLACE of Image. (IEN of IMAGING SITE PARAMETERS FILE)
 ; ..                                      Determined from Network Location file                 
 ; ..MAGPREF  =          Full Path of Image Network (or Jukebox) Directory 
 ;
 ;Calling other TAGS (VST,VSTNOCP,ABS,ABSNOCP,BIG,BIGNOCP,FULL,ABSTRACT,BIGFILE)      
 ;   return all of above and : 
 ; ..MAGFILE  =          FILE NAME WITH FULL PATH FOLLOWED BY $C(0)
 ; ..MAGFILE2 =          FILE NAME WITH FULL PATH W/O $C(0)
 ; .. Deletes MAGXX
 ; .. Does not Return MAGPREF
 ; Modified to handle hierarchical directory hash 4/23/98 -- PMK
 ;
 Q
VST ; Entry point to get a full size image with copying from JB to MAG DISK
 N MAGPREF,MAGJBCP S MAGJBCP=1 G FULL
 ;
VSTNOCP ; Entry point to get a full size image without copying it from the JB
 N MAGPREF,MAGJBCP S MAGJBCP=0 G FULL
 ;
ABS ; Entry point to get an image abstract with copying from JB to MAG DISK
 N MAGPREF,MAGJBCP S MAGJBCP=1 G ABSTRACT
 ;
ABSNOCP ; Entry point to get an image abstract without copying it from the JB
 N MAGPREF,MAGJBCP S MAGJBCP=0 G ABSTRACT
 ;
BIG ; Entry point to get a big file with copying from JB to MAG DISK
 N MAGPREF,MAGJBCP S MAGJBCP=1 G BIGFILE
 ;
BIGNOCP ; Entry point to get a big without copying it from the JB
 N MAGPREF,MAGJBCP S MAGJBCP=0 G BIGFILE
 ;
FULL N FILETYPE,MAGTYPE S FILETYPE="FULL" D FINDFILE G EXIT
 ;
ABSTRACT N FILETYPE,MAGTYPE S FILETYPE="ABSTRACT" D FINDFILE G EXIT
 ;
BIGFILE N FILETYPE,MAGTYPE S FILETYPE="BIG" D FINDFILE G EXIT
 ;
EXIT S MAGPREF=$G(MAGPREF)
 S MAGFILE2=MAGPREF_MAGFILE1,MAGFILE=MAGFILE2_$C(0)
 K MAGXX Q
 ;
FINDFILE ;
 N MAG0,MAGERR,MAGREF,MAGSTORE,CNDBMP
 K MAGPREF,MAGFILE1("ERROR") S (MAGJBOL,MAGERR,MAGTYPE,MAGOFFLN,MAGREF)=""
 I '$D(^MAG(2005,+MAGXX,0)) S MAGFILE1="-13,Image "_MAGXX_" is deleted",MAGERR=1 Q
 S MAG0=^MAG(2005,+MAGXX,0),MAGFILE1=$P(MAG0,"^",2)
 S MAGFILE1(.01)=$P(MAG0,"^") ; for MAILMAN interface
 S MAGFILE1=$P(MAGFILE1,"\",$L(MAGFILE1,"\"))
 ; 
 I FILETYPE="TEXT" S FILETYPE="FULL" S $P(MAGFILE1,".",2)="TXT"
 ;
 I FILETYPE="FULL" D  ; code for full size image
 . S MAGREF=$P(MAG0,"^",3)
 . I MAGREF="" S MAGJB=1,MAGREF=$P(MAG0,"^",5) ; get file from jukebox
 . Q
 ;
 I FILETYPE="ABSTRACT" D  Q:MAGERR  ; code for abstract
 . ;  gek 8/26/02 not sending full as the abstract for Documents.
 . ;  If Abs doesn't exist for Document (TIF) we'll Queue it. (don't know if it's on JB)
 . S MAGREF=$P(MAG0,"^",4)
 . I (MAGREF="") D  Q:MAGERR
 . . D RSLVABS^MAGGTU3(MAGXX,.CNDBMP)
 . . I $L(CNDBMP) S MAGFILE1=CNDBMP,MAGERR=1 Q
 . . S MAGJB=1,MAGREF=$P(MAG0,"^",5) ; get file from jukebox
 . . ;Patch 48 stop queing abstracts.
 . . ;I $P(MAG0,"^",6)=15 S X=$$ABSTRACT^MAGBAPI(+MAGXX)
 . . Q
 . S $P(MAGFILE1,".",2)="ABS"
 . Q
 ;
 I FILETYPE="BIG" D  Q:MAGERR  ; code for big file
 . N EXT,FBIG  ;
 . S FBIG=$G(^MAG(2005,MAGXX,"FBIG"))
 . I FBIG="" D  Q  ; no big file exists
 . . S MAGPREF="",MAGFILE1="-1~BIG File Does NOT Exist",MAGERR=1
 . . Q
 . S EXT=$P(FBIG,"^",3) I EXT="" S EXT="BIG"
 . S $P(MAGFILE1,".",2)=EXT
 . S MAGREF=$P(FBIG,"^") ; get file from magnetic disk, if possible
 . I MAGREF="" S MAGREF=$P(FBIG,"^",2) ; get file from jukebox
 . Q
 ;
 I MAGREF="" D  Q  ;NO NETWORK LOCATION
 . S MAGFILE1="-1~NO NETWORK OR JUKEBOX LOCATION DEFINED"
 ;
 I '$D(^MAG(2005.2,MAGREF,0)) D  Q  ; BAD POINTER
 . S MAGFILE1="-1~INVALID NETWORK LOCATION POINTER ->"_MAGREF
 ;
 S MAGSTORE=^MAG(2005.2,MAGREF,0),MAGTYPE=$P(MAGSTORE,"^",7)
 I MAGTYPE="" S MAGTYPE=$E(MAGSTORE,1,4) ; in case the type is null
 ;
 S MAGERR=""
 I '$P(MAGSTORE,"^",6) D  Q:MAGERR  ; the network device is off-line
 . I MAGTYPE["MAG" D  Q:MAGERR  ; get the jukebox device
 . . S MAGSTORE=$P(MAG0,"^",5)
 . . I 'MAGSTORE D NOWHERE S MAGERR=1 Q  ;big trouble:nowhere on jbox
 . . S MAGSTORE=^MAG(2005.2,MAGSTORE,0) ; get the file from the jbox
 . . Q
 . I '$P(MAGSTORE,"^",6) D OFFLINE S MAGERR=1 Q  ;jbox cartridge offline
 . S MAGREF=$P(MAG0,"^",5)
 . Q
 ;
 S MAGPREF=""
 I MAGTYPE["MAG" S MAGPREF=$P(MAGSTORE,"^",2)
 ;
 I MAGTYPE?1"WORM".E D  ; code for Jukeboxes
 . I MAGTYPE=("WORM-OTG") S MAGPREF=$P(MAGSTORE,"^",2)
 . E  I MAGTYPE="WORM-PDT" S MAGPREF=$P(MAGSTORE,"^",2)
 . E  I MAGTYPE["WORM-DG" D  ; this code is for DG/SONY jukebox
 . . N SUBDIR ; the subdirectory is the last two digits of the file name
 . . S SUBDIR=$P(MAGFILE1,".")
 . . S SUBDIR=$E(100+$E(SUBDIR,$L(SUBDIR)-1,999),2,3)_"\"
 . . S MAGPREF=$P(MAGSTORE,"^",2)_SUBDIR
 . . Q
 . ; The following is for tracking offline images
 . I $$IMOFFLN(MAGFILE1) S MAGOFFLN=1
 . I MAGJBCP D  ; add the image to the JukeBox TO Hard Disk copy queue
 . . S X=$$JBTOHD^MAGBAPI(MAGXX_"^"_FILETYPE,$$GET1^DIQ(2005.2,MAGREF,.04,"I")) ; DBI - SEB Patch 4
 . . Q
 . Q
 ;
 S MAGPREF=MAGPREF_$$DIRHASH^MAGFILEB(MAGFILE1,MAGREF)
 ;
 Q
 ;
DIRHASH(FILENAME,NETLOCN) ; determine the hierarchical file directory hash 
 ;
 ; Input Variables:
 ; FILENAME -- the name of the file, with or without the extension
 ; NETLOCN --- the network location file internal entry number
 ; Return Value: the hierarchical file directory hash
 ;
 N FN,HASHFLAG,HASH,I
 S HASHFLAG=$P(^MAG(2005.2,NETLOCN,0),"^",8)
 I HASHFLAG="Y" D  ; calculate the hierarchical directory hash
 . ; for an 8.3 filename AB123456.XYZ, the directory hash is AB\12\34
 . ; for a 14.3 filename BALT1234567890.XYZ, its BALT\12\34\56\78
 . S FN=$P(FILENAME,".") ; strip off the extension
 . I $L(FN)=8 S HASH=$E(FN,1,2)_"\"_$E(FN,3,4)_"\"_$E(FN,5,6)
 . E  S HASH=$E(FN,1,4) F I=5,7,9,11 S HASH=HASH_"\"_$E(FN,I,I+1)
 . S HASH=HASH_"\" ; add the trailing directory separator
 . Q
 E  S HASH="" ; flat directory structure, no hierarchical hashing 
 Q HASH
 ; 
NOWHERE ; File is not anywhere on the jukebox -- output error message
 ; Requested image file is not on the Jukebox
 S MAGPREF="",MAGFILE1="-1^"_MAGXX_"^^NOWHERE"
 S MAGFILE1("ERROR")="-1~Network device Off-Line and Image not on JukeBox"
 Q
 ;
OFFLINE ; Jukebox Cartridge is off-line -- output error message
 ; Jukebox Cartridge with image file is off-line."
 S MAGPREF="",MAGFILE1="-1^"_MAGXX_"^"_$P(MAG0,"^",5)_"^OFFLINE"
 Q
IMOFFLN(FILE) ;Check to see if image is offline (jb platter removed)
 N XX,X,Y
 I '$L(FILE) Q 0
 S X=FILE X ^%ZOSF("UPPERCASE") S FILE=Y
 I $D(^MAGQUEUE(2006.033,"B",FILE)) D   Q 1
 . S XX="",XX=$O(^MAGQUEUE(2006.033,"B",FILE,XX))
 . S MAGJBOL=" ** "_$P(^MAGQUEUE(2006.033,XX,0),"^",2)_" **"
 Q 0
