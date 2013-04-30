MAGDTR05 ;WOIFO/PMK/JSL/SAF - Read a DICOM image file ; 25 Sep 2008 10:53 AM
 ;;3.0;IMAGING;**46,54,123**;Mar 19, 2002;Build 67;Jul 24, 2012
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
LOOKUP(OUT,STATNUMB,ISPECIDX,IPROCS,STARTING,DUZREAD,DUZREAD2,LOCKTIME,STATLIST) ; RPC = MAG DICOM CON UNREADLIST GET
 ; entry point to lookup entries in file
 ; 
 ; OUT ------- Return array
 ; STATNUMB -- Acquisition Station Number
 ; ISPECIDX -- Index to Specialties (2005.84)
 ; IPROCS ---- Indexes to Procedures (2005.85) - this is a comma-delimited list
 ; STARTING -- Fileman date/time to begin sequential search
 ; DUZREAD --- User's DUZ at the Reading Site
 ; DUZREAD2 -- DIC(4) pointer to Reading Site
 ; LOCKTIME -- timeout value for LOCKTIME
 ; STATLIST -- status of entry (C, L, R, U, or W, in any combination)
 ; 
 N ACQSITE ;- site index in Unread List
 N ISTATUS ;-- counter to the status in STATLIST
 N IPROC ;---- counter to IPROCS
 N IPROCIDX ;- index to procedures (2005.85)
 N TIMESTMP ;- last activity date/time for the entry
 N SITENAME ;- name of acquisition site
 N STATUS1 ;-- one status out of the STATLIST
 N UNREAD ;--- pointer to entry in unread list
 ;
 S DUZREAD=$G(DUZREAD,0),DUZREAD2=$G(DUZREAD2,0),LOCKTIME=$G(LOCKTIME,0)
 S STATLIST=$$UP^MAGDFCNV($G(STATLIST))
 I STATLIST="" S STATLIST="CDLRUW" ; default to all STATUS values
 ;
 S ACQSITE=$$ACQSITE^MAGDTR06(STATNUMB)
 I ACQSITE<0  S OUT="-1, ACQUISITION STATION NUMBER "_STATNUMB_" IS NOT DEFINED IN FILE 4" Q
 S SITENAME=$P(ACQSITE,"^",2),ACQSITE=$P(ACQSITE,"^",1)
 ;
 I LOCKTIME,DUZREAD2 D UNLOCKER ; automatically unlock timed out studies
 ;
 K OUT
 I STARTING=0 D  ; loop through the STATUS index because it is faster
 . S STATLIST=$TR(STATLIST,"D") ; remove the DELETED status from STATLIST
 . F ISTATUS=1:1:$L(STATLIST) S STATUS1=$E(STATLIST,ISTATUS) D
 . . F IPROC=1:1:$L(IPROCS,",") S IPROCIDX=$P(IPROCS,",",IPROC) D
 . . . S UNREAD=""
 . . . F  S UNREAD=$O(^MAG(2006.5849,"D",ACQSITE,ISPECIDX,IPROCIDX,STATUS1,UNREAD)) Q:UNREAD=""  D
 . . . . D LOOKUP1(UNREAD)
 . . . . Q
 . . . Q
 . . Q
 . Q
 E  D  ; retrieve just the latest events
 . F IPROC=1:1:$L(IPROCS,",") S IPROCIDX=$P(IPROCS,",",IPROC) D
 . . S TIMESTMP=STARTING ; reinitialize the starting date & time for each index to procedures
 . . F  S TIMESTMP=$O(^MAG(2006.5849,"AC",ACQSITE,ISPECIDX,IPROCIDX,TIMESTMP)) Q:TIMESTMP=""  D
 . . . S UNREAD=""
 . . . F  S UNREAD=$O(^MAG(2006.5849,"AC",ACQSITE,ISPECIDX,IPROCIDX,TIMESTMP,UNREAD)) Q:UNREAD=""  D
 . . . . D LOOKUP1(UNREAD)
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q
 ;
LOOKUP1(UNREAD) ; retrieve one entry from the unread list
 N GMRCIEN
 N DFN
 N VADM
 N ICN
 N IFCSITE,IFCIEN,IFCSITEA,IFCRTIME,IFCLTIME,IFCETIME
 N LISTDATA ;- read/unread list data
 N QUIT
 N READER
 N SHORTID
 N STATUS
 N VA,VADM,VAERR
 N VIPSTS ; VIP status
 N I,LAST,X,Z
 ;
 S LISTDATA=$G(^MAG(2006.5849,UNREAD,0))
 S STATUS=$P(LISTDATA,"^",11) ; status
 Q:STATLIST'[STATUS  ; skip the entry if it is not the right STATUS
 ;
 S GMRCIEN=$P(LISTDATA,"^",1)
 S IFCSITE=$$GET1^DIQ(123,GMRCIEN,.07,"I") ; Routing Facility
 ;
 ; check if this consult can it be displayed to the reader
 S QUIT=0
 I DUZREAD D  Q:QUIT
 . I IFCSITE D  Q:QUIT  ; IFC reading site
 . . I IFCSITE'=DUZREAD2 S QUIT=1
 . . Q
 . I STATUS="W" S QUIT=2 Q
 . I STATUS="L" D  Q:QUIT
 . . S READER=$P(LISTDATA,"^",15) ; reader
 . . I READER,READER'=DUZREAD S QUIT=3
 . . Q
 . Q
 ;
 ; acquisition site identification
 S Z=UNREAD_"|"_GMRCIEN_"|"_STATNUMB_"|"_SITENAME
 ; patient information
 S DFN=$$GET1^DIQ(123,GMRCIEN,.02,"I")
 D DEM^VADPT,PTSEC^DGSEC4(.VIPSTS,DFN)
 S ICN=$S($T(GETICN^MPIF001)'="":$$GETICN^MPIF001(DFN),1:"-1^NO MPI")  ;p123
 S X=$TR(VA("PID"),"-",""),SHORTID=$E(VADM(1),1)_$E(X,$L(X)-3,$L(X)) ;P123
 S Z=Z_"|"_VADM(1)_"|"_VA("PID")_"|"_ICN_"|"_SHORTID ;P123
 S Z=Z_"|"_VIPSTS(1) ; VIP status
 S Z=Z_"|"_$P(^MAG(2005.84,ISPECIDX,0),"^",1)_"|"_$P(^MAG(2005.84,ISPECIDX,2),"^",1)
 S Z=Z_"|"_$P(^MAG(2005.85,IPROCIDX,0),"^",1)_"|"_$P(^MAG(2005.85,IPROCIDX,2),"^",1)
 ; time stamps and image acquisition statistics
 S Z=Z_"|"_$P(LISTDATA,"^",7) ; time of first image
 S Z=Z_"|"_$P(LISTDATA,"^",8) ; time of last image
 S Z=Z_"|"_$P(LISTDATA,"^",9) ; time of last activity
 S Z=Z_"|"_(+$P(LISTDATA,"^",10)) ; #images
 S Z=Z_"|"_STATUS
 S Z=Z_"|"_$$GET1^DIQ(123,GMRCIEN,13,"I") ; consult/procedure flag
 S Z=Z_"|"_$P($$GET1^DIQ(123,GMRCIEN,5)," - ",2) ; GMRC urgency
 ;
 ; get inter-facility consult data
 S IFCSITE=$$GET1^DIQ(123,GMRCIEN,.07,"I") ; Routing Facility
 I IFCSITE D  ; inter-facility consult
 . S IFCIEN=$$GET1^DIQ(123,GMRCIEN,.06,"I") ; remote consult file entry
 . ; get IFC site abbreviation
 . S I=$O(^MAG(2006.19,"D",IFCSITE,""))
 . S IFCSITEA=$S(I:$P($G(^MAG(2006.19,I,0)),"^",4),1:"?")
 . S IFCLTIME=$P(LISTDATA,"^",5),IFCRTIME=$P(LISTDATA,"^",6)
 . I IFCLTIME,IFCRTIME S IFCETIME=$$FMDIFF^XLFDT(IFCRTIME,IFCLTIME,2)
 . E  S IFCETIME=""
 . Q
 E  D  ; local consult
 . S (IFCIEN,IFCSITEA,IFCRTIME,IFCLTIME,IFCETIME)=""
 . Q
 S Z=Z_"|"_IFCSITE_"|"_IFCSITEA_"|"_IFCIEN
 S Z=Z_"|"_IFCLTIME_"|"_IFCRTIME_"|"_IFCETIME
 F I=12:1:16 S Z=Z_"|"_$P(LISTDATA,"^",I) ; reader identification
 S Z=Z_"|"_$P(LISTDATA,"^",17) ; start of reading
 S Z=Z_"|"_$P(LISTDATA,"^",18) ; end of reading
 S LAST=$G(OUT(1),1) ; first element in the array is the counter
 S LAST=LAST+1,OUT(LAST)=Z,OUT(1)=LAST
 Q
 ;
UNLOCKER ; automatically unlock any timed out studies
 N GMRCIEN
 N IFCSITE
 N SECONDS ;-- date/time in seconds
 N STATUS
 N UNLOCKTM ;- earliest date/time for a lock (FM format)
 N UNREAD ;--- pointer to entry in unread list
 N X
 ;
 ; calculate the earliest automatic unlock date/time
 S SECONDS=86400*$H+$P($H,",",2)-(60*LOCKTIME)
 ; convert to FM format
 S UNLOCKTM=$$HTFM^XLFDT((SECONDS\86400)_","_(SECONDS#86400),0)
 ;
 ; traverse the "lock list" and unlock those that have timed out
 F IPROC=1:1:$L(IPROCS,",") S IPROCIDX=$P(IPROCS,",",IPROC) D
 . S UNREAD=""
 . F  S UNREAD=$O(^MAG(2006.5849,"D",ACQSITE,ISPECIDX,IPROCIDX,"L",UNREAD)) Q:UNREAD=""  D
 . . S LISTDATA=$G(^MAG(2006.5849,UNREAD,0))
 . . ; check for a lock timeout
 . . I $P(LISTDATA,"^",17)<UNLOCKTM D  ; lock timeout
 . . . ; only unlock studies that are to be done at the reading site
 . . . I DUZREAD2=$P(LISTDATA,"^",16) D UNLOCK^MAGDTR04(UNREAD,.STATUS)
 . . . Q
 . . Q
 . Q
 Q
