MAGVCQRY ;;WOIFO/MAT - DICOM Storage Commit RPCs  ; 19 Jul 2013  5:59 PM
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
 Q
 ;
 ; /* Query each serially, < MAG*3.0*34 structure first. Order may
 ;    change if we determine that modalities are able & configured
 ;    to use Storage Commit are stacked heavily in favor of the SOP
 ;    Classes supported by *34.
 ;    */
 ;
 ;+++ Process ad hoc queries from MAGVC WI GET for existing work items.
 ;
MAIN(RETURN,WIIEN) ;
 ;
 N FILE S FILE=2006.941
 ;
 ;--- Validate incoming items.
 Q:$G(WIIEN)="" -1_"`"_"WORK ITEM IEN Not Provided."
 ;
 Q:('$D(^MAGV(FILE,WIIEN))) -2_"`"_"WORK ITEM IEN Not Found."
 ;
 ;--- Process STATUS=RECEIVED; FAILED only? Do not process "IN PROGRESS","SUCCESS".
 N SCSTATUS S SCSTATUS=1
 ;
 ;--- Lock Work Item.
 L +^MAGV(FILE,WIIEN):5 I $T D
 . ;
 . ;--- Set WI Status to "IN PROGRESS"
 . N STATSET S STATSET=$$ZUPD8STS(WIIEN,"IN PROGRESS")
 . I +STATSET<0 D
 . . ;
 . . ;--- Watch locking...
 . . Q
 . ;--- Loop through items & check archive status.
 . N CTITEM S CTITEM=$P(^MAGV(FILE,WIIEN,2,0),U,4)
 . N CT
 . F CT=1:1:CTITEM D
 . . ;
 . . N UIDSOP S UIDSOP=$P(^MAGV(FILE,WIIEN,2,CT,0),"~",2)
 . . ;--- Query < MAG*3.0*34 structure.
 . . N STATUS S STATUS=$$QRYLEGAC^MAGVCQRY(UIDSOP)
 . . ;--- Query >= MAG*3.0*34 structure.
 . . I 'STATUS S STATUS=$$QRYCURNT^MAGVCQRY(UIDSOP)
 . . ;
 . . I STATUS D
 . . . S $P(^MAGV(FILE,WIIEN,2,CT,0),"~",3,4)="C"
 . . . Q
 . . E  D
 . . . S $P(^MAGV(FILE,WIIEN,2,CT,0),"~",3,4)="U~U"
 . . . S SCSTATUS=0
 . . . Q
 . ;--- Set aggregate STATUS and unlock WI.
 . N WISTATUS S WISTATUS=$S(SCSTATUS=0:"FAILURE",1:"SUCCESS")
 . S RETURN(0)=$$ZUPD8STS(WIIEN,WISTATUS)
 . L -^MAGV(FILE,WIIEN)
 . Q
 ;--- Else error nolock.
 E  D
 . S RETURN(0)="-1`Unable to Lock Work Item "_WIIEN
 . Q
 ;--- Return Status [??? No; the re-sent WI handles that] and Reason
 Q RETURN(0)
 ;
 ;+++++ Query a single MAG*3.0*34 introduced IMAGE SOP INSTANCE.
 ;
QRYCURNT(UIDSOP) ;
 ;
 N YNCURNT S YNCURNT=0
 N SOPUID S SOPUID=UIDSOP
 ;
 ;--- Check STATUS (#15) is 'A'ccessible in IMAGE SOP INSTANCE file (#2005.54).
 ;      Returns '0' if 'I'naccessible, IEN in IMAGE SOP INSTANCE file if 'A'ccessible.
 N IENIMGSOP S IENIMGSOP=$$QRYSOPIN(SOPUID)
 D
 . Q:'IENIMGSOP
 . ;
 . ;--- Return ARTIFACT TOKEN of IMAGE INSTANCE file (#2005.65) for input IEN
 . ;      of IMAGE SOP INSTANCE file (#2005.54)
 . N TKNARTIF S TKNARTIF=$$QRYIMGIN(IENIMGSOP)
 . Q:TKNARTIF=""  D
 . . ;
 . . ;--- Return IEN of ARTIFACT INSTANCE file (#2006.918) given ARTIFACT TOKEN
 . . N IENARTIF S IENARTIF=$$QRYARTIF(TKNARTIF)
 . . Q:'IENARTIF  D
 . . . ;
 . . . ;--- Return ARCHIVE status of STORAGE PROVIDER file (#2006.917) given IENARTIN.
 . . . N ARCHSTAT S ARCHSTAT=$$QRYARTIN(IENARTIF)
 . . . Q:'ARCHSTAT  S YNCURNT=ARCHSTAT
 Q YNCURNT
 ;
 ;+++ Level 1: Query IMAGE SOP INSTANCE file (#2005.64) for accessibility.
 ;
 ;    Note: "ORIGINAL [old] SOP INSTANCE UID" is field #1 at 0;2
 ;
 ;    Note: "ARTIFACT ON FILE" (#12) description says "at least one Object";
 ;                  Is there only one object per IMGSOPIN.
 ;
QRYSOPIN(IMGSOPIN) ;
 ;
 N RETURN S RETURN=0
 N IENIMGSOP S IENIMGSOP=$O(^MAGV(2005.64,"B",IMGSOPIN,""))
 D
 . Q:IENIMGSOP=""
 . ;
 . ;--- Check STATUS (#40) as "A"ccessible or "I"naccessible.
 . Q:$P($G(^MAGV(2005.64,IENIMGSOP,11)),U,1)'="A"
 . S RETURN=IENIMGSOP
 . Q
 Q RETURN
 ;
 ;+++ Level 2: Lookup ARTIFACT TOKEN (#.01) via IMAGE INSTANCE file (#2005.65)
 ;
QRYIMGIN(IENIMGSOP) ;
 ;
 N IENARTIF,TKNARTIF S (IENARTIF,TKNARTIF)=0
 D
 . ;--- SOP INSTANCE REFERENCE (#11) points to IMAGE SOP INSTANCE (#2005.64)
 . N IENIMGIN S IENIMGIN=""
 . F  S IENIMGIN=$O(^MAGV(2005.65,"C",IENIMGSOP,IENIMGIN)) Q:IENIMGIN=""  D
 . . ;
 . . ;--- Select the object w/ ORIGINAL SOP INSTANCE=1 (not 'derived').
 . . S:+$P(^MAGV(2005.65,IENIMGIN,1),U,2) TKNARTIF=$P(^MAGV(2005.65,IENIMGIN,0),U)
 . . Q
 . Q
 Q TKNARTIF
 ;
 ;+++ Level 3: Query ARTIFACT file (#2006.916)
 ;
 ; POINTED TO BY: ARTIFACT REFERENCE field (#.02) of the IMAGE INSTANCE FILE File (#2005.65) 
 ;                ARTIFACT           field (#.01) of the ARTIFACT INSTANCE File (#2006.918)
 ;
 ; /* Based on the above, can bypass the ARTIFACT file. Else use ARTIFACT TOKEN?
 ;    */
 ;                ARTIFACT           field (#.01) of the ARTIFACT RETENTION POLICY File (#2006.921) 
 ;                ARTIFACT           field (#5  ) of the STORAGE TRANSACTION File (#2006.926) 
 ;
QRYARTIF(TKNARTIF) ;
 ;
 N IENARTIF S IENARTIF=$O(^MAGV(2006.916,"B",TKNARTIF,""))
 Q IENARTIF
 ;
 ;+++ Level 4: Query ARTIFACT INSTANCE file (#2006.918) for STORAGE PROVIDER
 ;
QRYARTIN(IENARTIF) ;
 ;
 N FILE S FILE=2006.918
 N ARCHSTAT S ARCHSTAT=0
 N IENPROVD
 D
 . N IENARTIN S IENARTIN=""
 . F  S IENARTIN=$O(^MAGV(FILE,"B",IENARTIF,IENARTIN)) Q:IENARTIN=""  Q:ARCHSTAT  D
 . . ;
 . . S IENPROVD=$P(^MAGV(FILE,IENARTIN,0),U,2)
 . . I IENPROVD'="" S ARCHSTAT=$$YNSTOPRV(IENPROVD)
 . . Q
 . Q
 Q ARCHSTAT
 ;
 ;+++ Level 5: Query STORAGE PROVIDER file (#2006.917)
 ;
 ;    Note: Depending on number of these, may best array them first.
 ;
 ; INPUT:  PROVDIEN  -- IEN of entry in the STORAGE PROVIDER file (#2006.917)
 ; OUTPUT: YN        -- 1 if ARCHIVE field (#4) is 1 (YES)
 ;                      0 else.
YNSTOPRV(IENPROVD) ;
 ;
 N YN S YN=0
 N ARCH S ARCH=$P($G(^MAGV(2006.917,IENPROVD,0)),U,4)
 S:ARCH YN=ARCH
 Q YN
 ;
ZUPD8STS(WIIEN,STATUS) ;
 N RETURN S RETURN=0
 N FDA S FDA(2006.941,WIIEN_",",3)=STATUS
 N MAGERR
 D FILE^DIE("E","FDA","MAGERR")
 ;--- Trap UPDATER Error
 I $D(MAGERR) S RETURN=-6_"`"_MAGERR("DIERR",1,"TEXT",1)
 Q RETURN
 ;
 ;+++ Process an object in legacy structure (<MAG*3.0*34).
 ;
QRYLEGAC(UIDSOP) ;
 ;
 N RETURN S RETURN=0
 D
 . Q:($D(^MAG(2005,"P",UIDSOP))="")
 . ;
 . N MAGIEN S MAGIEN=$$WMAGIEN(UIDSOP)
 . Q:MAGIEN=""
 . ;
 . ;--- Check the STATUS (#113) field ... ,D0,100) [8S]
 . N VIEWSTAT S VIEWSTAT=$$WMAGSTAT(MAGIEN)
 . Q:'VIEWSTAT
 . ;
 . N NEXTVAR S NEXTVAR=$$WRMVOL(MAGIEN)
 . Q:NEXTVAR=""
 . ;
 . N ISWORM S ISWORM=$$YNWORM(NEXTVAR)
 . Q:ISWORM=""
 . ;
 . S:ISWORM RETURN=1
 . Q
 Q RETURN
 ;
 ; # 60 -- PACS UID              ,D0,"PACS") [60F] ... "P" Cross-reference
 ;
 ;         for a  group entry: is (0020,000D), Study Instance UID
 ;         for an image entry: is (0008,0018), SOP Instance UID
 ;
 ; #252 -- NEW SOP INSTANCE UID  ,D0,"SOP")  [2F] ... "P" Cross-reference
 ;
 ;         the VA's new SOP instance UID for the corrected image.
 ;
 ;--- Check the STATUS (#113) field ... ,D0,100) [8S]
 ;
 ;  By default, all images are viewable. Images w/ no status are viewable.
 ;  Status 12 --> Deleted
 ;
WMAGSTAT(MAGIEN) ;
 N YNMAGST S YNMAGST=$P(^MAG(2005,MAGIEN,100),U,8)
 S YNMAGST=$S(0:YNMAGST=12,1:1)
 Q YNMAGST
 ;
 ;--- Return IMAGE file (#2005) IEN. Caller QUITs if null.
 ;
WMAGIEN(UIDSOP) ;
 N MAGIEN S MAGIEN=$O(^MAG(2005,"P",UIDSOP,""))
 Q MAGIEN
 ;
WRMVOL(MAGIEN) ;
 N PTNETLOC S PTNETLOC=$P(^MAG(2005,MAGIEN,0),U,5)
 Q PTNETLOC
 ;
 ;+++ Is NETWORK LOCATION file (#2005.2) STORAGE TYPE field (#6) "WORM"?
 ;
YNWORM(IENETLOC) ;
 ;
 N ISWORM S ISWORM=0
 N TMP S TMP=$P(^MAG(2005.2,IENETLOC,0),U,7)
 S:($E(TMP,1,4)="WORM") ISWORM=1
 Q ISWORM
 ;
 ; MAGVCQRY
