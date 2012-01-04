MAGJUTL2 ;WIRMFO/JHC VistRad subroutines for RPC calls ; 21 Apr 2011  5:34 PM
 ;;3.0;IMAGING;**18,65,76,104**;Mar 19, 2002;Build 2225;Jul 12, 2011
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
IMGINFO(RARPT,RET) ; Fetch info from Image File for input RARPT:
 ; Input: RARPT: Rad Report pointer
 ; RET contents delimited by ^:
 ;   CT = # of images for case
 ;   ONL = Image Storage status (Y=On Magnetic disk, N=Jukebox
 ;             "n/a"  for not available, e.g., film only)
 ;             note -- if last image in group is Online, considers ALL online
 ;   MAGDT = Date/Time of Image Capture
 ;   REMOTE = 1/0 to Indicate images were remotely cached
 ;   MODALITY = Modality abbrev
 ;   PLACE = Image storage PLace (ptr to 2006.1 entry)
 ;   KEY = 1/0 ind. Key Images exist for this exam
 ; 
 N IRPT,MAGIEN,MAGIEN2,ONLCHK,NETLOC,STIEN
 N CT,ONL,MAGDT,REMOTE,MODALITY,PLACE,REMCHK,KEY,TDT
 S CT="",ONL="",MAGDT="",RET="",REMOTE="",MODALITY="",PLACE="",KEY=0 ; init return vars
 G IMGINFQ:'RARPT G IMGINFQ:'$D(^RARPT(RARPT,2005,0))
 S STIEN=$$STUDYID^MAGJUPD2("",RARPT,1)
 I STIEN S T=$O(^MAG(2005,STIEN,205,0)) I T S KEY=1
 S IRPT=0 F  S IRPT=$O(^RARPT(RARPT,2005,IRPT)) Q:'IRPT  S MAGIEN=$P(^(IRPT,0),U) D
 . Q:'$D(^MAG(2005,MAGIEN,0))
 . S TDT=$P($G(^MAG(2005,MAGIEN,100)),U,6) S:TDT="" TDT=$P($G(^(2)),U)
 . I TDT S MAGDT=$S(MAGDT="":TDT,TDT<MAGDT:TDT,1:MAGDT)
 . I $O(^MAG(2005,MAGIEN,1,0)) S CT=CT+$P(^(0),U,4),Y=$P(^(0),U,3),MAGIEN2=$P($G(^(Y,0)),U) S:(MAGIEN2]"") ONLCHK=$$ONLCHK(MAGIEN2),REMCHK=$$REMOTE(MAGIEN2) ; last image in group
 . E  S CT=CT+1,ONLCHK=$$ONLCHK(MAGIEN),REMCHK=$$REMOTE(MAGIEN)
 . S ONL=$S(ONL="":+ONLCHK,+ONL:+ONLCHK,1:0) ; NOT Online if ANY img is 0
 . S REMOTE=$S(REMOTE="":REMCHK,+REMOTE:REMCHK,1:0) ; NOT Remote if ANY img is 0
 . S X=$P(ONLCHK,U,3)
 . I MODALITY="" S MODALITY=X
 . E  I MODALITY'[X S MODALITY=MODALITY_","_X
 . I PLACE="" S PLACE=$P(ONLCHK,U,4)
IMGINFQ S ONL=$S(+ONL:"Y",ONL="":"n/a",1:"N")
 ; <*> add logic here to put multiple modalities into preferred sequence
 ; N T,TMDL S T=$P("^RF^XA^CT^CR^DX^MG^US^MR^PT^NM^AS^CD^CS^DG^EC^FA^LP^MA^ST^OT^BI^CP^DD^DM^ES^FS^LS^MS^RG^TG^HC^IO^PX",U_TMDL_U,1)
 S RET=CT_U_ONL_U_MAGDT_U_REMOTE_U_MODALITY_U_PLACE_U_KEY
 Q
 ;
ONLCHK(MAGIEN,USETGA) ;
 ; Input: MAGIEN: Image pointer
 ;        USETGA: 1/0 -- if 1, forces return of TGA (not .big) file
 ;Return: ^-delimited pieces:
 ;  1 - 1/0 for Full-Res image on Mag. Disk that is Online
 ;  2 - File type (BIG/FULL)
 ;  3 - Modality
 ;  4 - Place
 ;  5 - DFN
 ;  6 - File Name IFF this image is stored Off-Line (else null)
 ;  7 - USETGA * as calculated in the logic below
 ;  8 - PROCDT  = Img Processing DtTime
 ;  9 - ACQSITE = Acquisition site code
 ; 10 - STANUM  = Station Number where Magnetic Network Loc'n exists
 ; * USETGA is set to False (0) if a low-resolution image (TGA) is
 ;    requested, but none exists; calling routine would call by ref.
 ;
 N BIG,X,NOD,MAG0,MODALITY,RET,PLACE,DFN,FILNAM,MAG2,PROCDT,ACQSITE,MAG100,STANUM
 S USETGA=+$G(USETGA) ; Defaults to Full-Resolution image if not defined
 S RET="",MODALITY="",PLACE="",ACQSITE="",STANUM=""
 S MAG0=^MAG(2005,MAGIEN,0),BIG=$D(^("FBIG")),NOD=$S(BIG:^("FBIG"),1:MAG0)
 S MAG2=^MAG(2005,MAGIEN,2),PROCDT=$P(MAG2,U)
 S MAG100=$G(^MAG(2005,MAGIEN,100)),ACQSITE=$P(MAG100,U,3)
 I USETGA D
 . I 'BIG S USETGA=0 ; reply no low-res image available
 . I BIG S NOD=MAG0,BIG=0 ; enable correct logic inside this subroutine
 S MODALITY=$P(MAG0,U,8),DFN=$P(MAG0,U,7)
 I BIG S X=+$P(NOD,U)  ; $p 1 is Magnetic Disk/Volume (.big)
 E  S X=+$P(NOD,U,3)   ; $p 3 is Magnetic Disk/Volume (.tga)
 I X D
 . I '$D(NETLOC(X)) S NETLOC(X)=+$P(^MAG(2005.2,X,0),U,6)_U_$P(^(0),U,10)_U_$$STANUM(X)
 . S RET=+NETLOC(X),PLACE=$P(NETLOC(X),U,2),STANUM=$P(NETLOC(X),U,3) ; NETLOC is global to this subrtn
 . S FILNAM=""
 E  D
 . S RET=0,FILNAM=$P(MAG0,U,2)
 . S T=$S(BIG:$P(NOD,U,2),1:$P(NOD,U,5))
 . I T S PLACE=$P(^MAG(2005.2,T,0),U,10)
 S RET=RET_U_$S(BIG:"BIG",1:"FULL")_U_MODALITY_U_PLACE_U_DFN_U_FILNAM_U_USETGA_U_PROCDT_U_ACQSITE_U_STANUM
 Q RET
 ;
REMOTE(MAGIEN) ;Return list of remote  Cache Locations
 ;  else, return "" if none
 N RET,LOC
 S RET=""
 I $D(^MAG(2005,MAGIEN,4,"LOC")) S LOC=0 D
 . F  S LOC=$O(^MAG(2005,MAGIEN,4,"LOC",LOC)) Q:'LOC  S RET=RET_$S(RET="":"",1:",")_LOC
 Q RET
 ;
STANUM(NETLOC) ; Return Station Number for input Network Location
 N X,STANUM
 S STANUM=""
 I +$G(NETLOC) D
 . S X=$P($G(^MAG(2005.2,NETLOC,0)),"^",10)
 . I X S STANUM=$$GETSNUM^MAGDQR21(X)
 Q STANUM
 ;
IMGINF2(RARPT,RET,USETGA) ; Fetch info from Image File for input RARPT:
 ; Input: RARPT: Rad Report pointer
 ;        RET: see below
 ;        USETGA: 1/0 -- if 1, forces return of TGA (not .big) file
 ; RET holds array of return values:
 ; RET = # Images stored for the case
 ;   RET(1:n) = ^-delimited pieces:
 ;  1 - 1/0 for Full-Res image on Mag. Disk that is Online
 ;  2 - FULL/BIG
 ;  3 - Modality
 ;  4 - Image IEN
 ;  5 - Station #
 ;  6 - Routed-to Locations (IENs)
 ;  7 - PLACE
 ;  8 - DFN
 ;  9 - FileName (if OffLine)
 ; 10 - PS_Indicator -- 1=Image is on Magnetic Disk
 ;   
 ; * This subroutine may be called by other VistARad routines
 ;
 N BIG,IMG,MAGIEN,MAGIEN2,MAGPTR,NETLOC
 K RET S RET=0
 S USETGA=+$G(USETGA) ; Defaults to Full-Resolution image if not defined
 G IMGINF2Q:'RARPT S IMG=0
 F  S IMG=$O(^RARPT(RARPT,2005,IMG)) Q:'IMG  S MAGIEN=$P(^(IMG,0),U) D
 . ; use group multiple structure when present
 . Q:'$D(^MAG(2005,MAGIEN,0))  S MAGPTR=0
 . I '$O(^MAG(2005,MAGIEN,1,MAGPTR)) D  Q
 . . S T=$$ONLCHK(MAGIEN,USETGA)
 . . S RET=RET+1,RET(RET)=$P(T,U,1,3)_U_MAGIEN_U_$P(T,U,10)_U_$$REMOTE(MAGIEN)_U_$P(T,U,4,7)_U_$$PSIND(MAGIEN)_U_$P(T,U,8)_U_$P(T,U,9)
 . E  F  S MAGPTR=$O(^MAG(2005,MAGIEN,1,MAGPTR)) Q:'MAGPTR  S MAGIEN2=$P(^(MAGPTR,0),U) D
 . . S T=$$ONLCHK(MAGIEN2,USETGA)
 . . S RET=RET+1,RET(RET)=$P(T,U,1,3)_U_MAGIEN2_U_$P(T,U,10)_U_$$REMOTE(MAGIEN2)_U_$P(T,U,4,7)_U_$$PSIND(MAGIEN2)_U_$P(T,U,8)_U_$P(T,U,9)
IMGINF2Q ;
 Q
 ;
PSIND(MAGIEN) ; return Presentation State Indicator(s) for image
 ; K=Key Image PStype; I=Interpretation PStyp; U=User PStyp
 N RSL,IEN,X
 S RSL="",IEN=0
 I $D(^MAG(2005,MAGIEN,210,IEN)) F  S IEN=$O(^MAG(2005,MAGIEN,210,IEN)) Q:'IEN  S X=$P(^(IEN,0),U,2) Q:RSL[X  S RSL=RSL_$S(RSL="":"",1:",")_X
 Q:$Q RSL Q
 ;
JBFETCH(RARPT,MAGS,USETGA,NOFETCH) ; fetch this case's images from Jukebox, if necessary
 ; Input: RARPT: Rad Report pointer
 ;        MAGS: see below
 ;        USETGA: 1/0 -- if 1, forces return of TGA (not .big) file
 ;        NOFETCH: 1/0 -- if 1, metadata get only so do NOT issue Jukebox retrieve
 ; This is a function that returns a string containing:
 ;   # Images fetched from JB ^ Total # Images for Case ^ # Low Res Imgs
 ; The MAGS array will be returned to the calling
 ; routine if MAGS is provided as an input parameter
 ;   MAGS is populated by call to IMGINF2.
 ;   IF any images are stored OffLine, then this node is set here:
 ;     MAGS("OFFLN",JBOFFLN)=""  JBOFFLN = Platter ID from file 2006.033
 ;
 ; * This function may be called by other VistARad routines
 ;
 N MAGIEN,FETCH,IMAG,FILNAM,JBOFFLN,LORESCT
 S USETGA=+$G(USETGA) ; Defaults to Full-Resolution image if not defined
 S NOFETCH=+$G(NOFETCH)
 S FETCH=0,LORESCT=0
 D IMGINF2(RARPT,.MAGS,USETGA)
 I MAGS F IMAG=1:1:MAGS S X=MAGS(IMAG) D
 . I USETGA S LORESCT=LORESCT+$P(X,U,10)
 . I '+X D  ; Call params below depend on Consolidated Site status
 . . S FETCH=FETCH+1
 . . Q:NOFETCH  ; need the count of images on JB, but not retrieving them
 . . S FILNAM=$P(X,U,9)
 . . I FILNAM]"",$D(^MAGQUEUE(2006.033,"B",FILNAM)) S T=$O(^(FILNAM,"")) S JBOFFLN=$P($G(^MAGQUEUE(2006.033,T,0)),U,2),MAGS("OFFLN",JBOFFLN)="" Q  ; OffLine Image
 . . I '$G(MAGJOB("CONSOLIDATED")) S X=$$JBTOHD^MAGBAPI($P(X,U,4)_"^"_$P(X,U,2)) ; pre-consolidation vs
 . . E  S X=$$JBTOHD^MAGBAPI($P(X,U,4)_"^"_$P(X,U,2),$P(X,U,7))
JBFETCHQ Q FETCH_U_MAGS_U_LORESCT
 ;
END Q  ;
