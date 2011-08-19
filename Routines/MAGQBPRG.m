MAGQBPRG ;WOIOFO/RMP - Magnetic Server Purge processes ; 24 Jan 2011 3:55 PM
 ;;3.0;IMAGING;**7,3,8,20,81,39**;Mar 19, 2002;Build 2010;Mar 08, 2011
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
FILEREF(RESULT,FILEPATH,FNAM,EXT,NETLOC) ; RPC[MAGQBP FREF]
 ;VALIDATES THAT THE FILEPATH IS CONSISTENT WITH VISTA MAGFILE REFERENCE
 ;SET THE SECOND PIECE TO "PACS" IF IT REPRESENTS DICOM
 ;VALIDATES THAT A JUKEBOX POINTER EXISTS
 ;RESULT VALUES
 ;PIECE  1:-3 = FOREIGN FILE, DO NOT PURGE
 ;         -2 = QUEUED FOR JUKEBOX COPY, DO NOT PURGE
 ;         -1 = DO NOT PURGE
 ;        **0 = PURGE('MAG 2005 ENTRY)!('JUKEBOX PTRS )
 ;          1 = PURGE GIVEN NORMAL DATE CRITERIA (NDC) + CONFIRMED ON JB
 ;        **2 = PURGE GIVEN NDC IF TGA PRESENT
 ;          3 = PURGE IF FILE IS AT ALTERNATE NETWORK LOCATION SITE
 ;              ELSE PURGE IF AGED & UPDATE FILE REFERENCES
 ;        **4 = (**NA**)AGE PURGE IF ON JUKEBOX, UPDATE FILE REFERENCES
 ;              ELSE UPDATE FILEREFENCES, QUEUE JUKEBOX COPY
 ;          5 = PURGE IF AT ALTERNATE SITE,QUEUE JUKEBOX IF NOT ON JB
 ;        **6 = PURGE GIVEN NORMAL DATE CRITERIA
 ;PIECE   ** 2:  FILETYPE
 ;                   0 = foreign
 ;                   1 = abstract
 ;                   2 = full
 ;                   3 = big
 ;                   4 = photo id
 ;PIECE    3: RECORD CATEGORY
 ;         1 = 'NO 2005 ENTRY
 ;       **2 = RADIOLOGY HOLD
 ;         3 = NO JUKEBOX/JUKEBOX PTRS
 ;         4 = JUKEBOX - NO JUKEBOX PTRS (P/EXCEPT)ELSE QUEUE
 ;         5 = JUKEBOX/JUKEBOX PTRS, NO CACHE PTRS,PURGE IF CONFIRMED
 ;         6 = JUKEBOX/JUKEBOX PTRS, WRONG CACHE PTRS PURGE IF AT ALT
 ;         7 = JUKEBOX/JUKEBOX PTRS, NO CACHE PTRS, FIX PTRS
 ;         8 = JUKEBOX/JUKEBOX PTRS, CACHE PTRS, AGE (IF CONFIRMED)
 ;         9 = RECORD NOT IN THE IMAGE FILE
 ;        10 = FOREIGN IMAGE FILE
 ;        11 = NOT AN IMAGE FILE
 ;        12 = FILE LOCATION NOT VALID 
 ;        13 = DELETE 2005 ENTRY (LAST LOCATION REFERENCED)
 ;        14 = Duplicate 2005/2005.1 entry
 ;        15 = Foreign Place
 ;        16 = Record in Archive file
 ;        17 = Jukebox offline
 N FILEXT,IEN,SITEID,MAGXX,MAGFILE,MAGFILE1,MAGFILE2,RIEN,ZNODE
 N FTYPE,CPTR,JBPTR,CPOK,BNODE,ALTPATH,NMSPC,PLACE,XX,FT
 N X S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 S PLACE=$$PLACE^MAGBAPI(+$G(DUZ(2)))
 S U="^",(MAGFILE2,RESULT)=""
 S FNAM=$$UPPER^MAGQE4(FNAM)
 S ^TMP("MAGQ",$J,"PRG","LAST")=FILEPATH_U_FNAM_U_EXT_U_NETLOC
 I FNAM'?1.5A1.13N1"."1.3E  D  Q  ;LATER ADD EXT VERIFY USING 2005.02
 . D ELOG(FNAM,FILEPATH,"Not a VistA Imaging file") S RESULT="-3^0^11" Q  ;'IMAGE FILE
 S SITEID=$$UPPER^MAGQE4($$INIS^MAGQBPG2(PLACE))
 S NMSPC=$TR($P(FNAM,"."),"0123456789","")
 S FILEPATH=$$UPPER^MAGQE4(FILEPATH)
 I SITEID'[NMSPC D ELOG(FNAM,FILEPATH,"Foreign Image file") S RESULT="-3^0^10" Q  ;FOREIGN FILE
 S IEN=$O(^MAG(2005,"F",$P(FNAM,"."),""))
 I 'IEN  S IEN=$O(^MAG(2005.1,"F",$P(FNAM,"."),""))
 ; Patch 39 - added logging
 I 'IEN D  Q
 . D ELOG(FNAM,FILEPATH,"Record neither in 2005 nor 2005.1")
 . S RESULT="-3^0^9^^^"_IEN
 . Q
 S FTYPE=$$FTYPE(EXT,IEN)
 S FT=$S(FTYPE="ABS":"1",FTYPE="FULL":"2",FTYPE="BIG":"3",FTYPE="PHOTOID":"4",1:"2")
 S JBPTR=$$JBPTR(IEN,FTYPE)
 ;PURGE UNCONDITIONALLY IF NO 2005 or 2005.1 ENTRY
 I '$D(^MAG(2005,IEN,0)) D  Q
 . I $D(^MAG(2005.1,IEN,0)) D  Q
 . . I ('JBPTR&($P($G(^MAG(2005.2,+$$JBPTR^MAGBAPI(PLACE),0)),U,6)="1"))  D
 . . . S XX=$$JUKEBOX^MAGBAPI(IEN,PLACE)
 . . . S RESULT="-2^"_FT_"^9^^^"_IEN
 . . . Q
 . . E  D 
 . . . I JBPTR S RESULT="5^"_FT_"^16^"_$$JBPATH(FNAM,JBPTR)_U_$$JBPATH(FNAM,JBPTR)_U_IEN
 . . . E  S RESULT="-1^"_FT_"^17"
 . . . Q
 . E  S RESULT="1^"_FT_"^9^^^"_IEN
 . Q
 I PLACE'=$$PLACE^MAGBAPI(+$P($G(^MAG(2005,IEN,100)),U,3)) D  Q
 . S RESULT="-3^"_FT_"^15" Q  ;Foreign Place
 S ZNODE=^MAG(2005,IEN,0)
 I $P(ZNODE,U,12)="1" S RESULT="-1^"_FT_"^14" Q  ; Duplicate Image/Archive entry 
 S BNODE=$S(FTYPE="BIG":$G(^MAG(2005,IEN,"FBIG")),1:"")
 ; NEXT PROCESS MAGNETIC PTR~LESS
 S CPTR=$$CHKCP($S(FTYPE="BIG":BNODE,1:ZNODE),FTYPE,EXT)
 I 'CPTR D  Q
 . D CPUPD(FTYPE,IEN,FILEPATH,FNAM,EXT)
 . I 'JBPTR,$P($G(^MAG(2005.2,+$$JBPTR^MAGBAPI(PLACE),0)),U,6)="1" D
 . . S XX=$$JUKEBOX^MAGBAPI(IEN,PLACE)
 . S RESULT="-1^"_FT_"^7^^"_JBPTR_U_IEN ;$S(JBPTR:JBPTR,1:XX)_U_IEN
 S CPOK=$S('CPTR:0,1:$$CPOK(FTYPE,.ALTPATH,FILEPATH,IEN))
 S ALTPATH=ALTPATH_FNAM
 I 'CPOK,JBPTR D  Q
 . S RESULT="3^"_FT_"^6^"_ALTPATH_U_$$JBPATH(FNAM,JBPTR)_U_IEN
 I 'JBPTR D  Q
 . I $P($G(^MAG(2005.2,+$$JBPTR^MAGBAPI(PLACE),0)),U,6)="1" D
 . . S XX=$$JUKEBOX^MAGBAPI(IEN,PLACE)
 . . S RESULT="-1^"_FT_"^7^^"_JBPTR_U_IEN ;$S(JBPTR:JBPTR,1:XX)_U_IEN
 . . Q
 . E  S RESULT="-1^"_FT_"^17"
 . Q
 S RESULT="1^"_FT_"^8^^"_$$JBPATH(FNAM,JBPTR)_U_IEN
 Q
 ;
LASTNP(TYPE) ;
 I TYPE="BIG" Q $S($P(ZNODE,U,3,4)="^":1,1:0)
 I TYPE="ABS" Q $S((($P(ZNODE,U,3)="")&($P(BNODE,U)="")):1,1:0)
 Q $S((($P(ZNODE,U,4)="")&($P(BNODE,U)="")):1,1:0)
JBPATH(FN,NL) ;
 Q $P($G(^MAG(2005.2,NL,0)),U,2)_$$DIRHASH^MAGFILEB(FN,NL)_FN
FTYPE(FEXT,IEN) ;
 ; Patch 39 : checking for ABS in FULL
 N FILE
 S FILE=$S($D(^MAG(2005,IEN,0)):"2005",1:"2005.1")
 I $P($G(^MAG(FILE,IEN,40)),U,3)=$O(^MAG(2005.83,"B","PHOTO ID","")) Q "PHOTOID"
 I $$UPPER^MAGQE4($P($G(^MAG(FILE,IEN,0)),U,2))[".ABS" Q "FULL"
 S FEXT=$$UPPER^MAGQE4(FEXT)
 I "^ABS^"[("^"_FEXT_"^") Q "ABS"
 I "^BIG^"[("^"_FEXT_"^") Q "BIG"
 I "^"_$P($G(^MAG(FILE,IEN,"FBIG")),U,3)_"^"[("^"_FEXT_"^") Q "BIG"
 Q "FULL"
CHKCP(NODE,TYPE,EXT) ;
 N PIECE,CP
 S PIECE=$S(TYPE="ABS":4,TYPE="BIG":1,TYPE="FULL":3,(TYPE="PHOTOID"&(EXT="ABS")):4,TYPE="PHOTOID":3,1:0)
 Q $P(NODE,U,PIECE)
JBPTR(MAGIEN,TYPE) ;
 N PTR
 I TYPE="BIG" D
 . S PTR=+$P($G(^MAG(2005,MAGIEN,"FBIG")),"^",2)
 . S:'PTR PTR=+$P($G(^MAG(2005.1,MAGIEN,"FBIG")),"^",2)
 E  D
 . S PTR=+$P($G(^MAG(2005,MAGIEN,0)),"^",5)
 . S:'PTR PTR=+$P($G(^MAG(2005.1,MAGIEN,"FBIG")),"^",2)
 Q $S($P($G(^MAG(2005.2,PTR,0)),U,6)=1:PTR,1:0)
CPOK(TYPE,ALTPATH,FILEPATH,IEN) ;
 ; Patch 39: initializing ALTPATH, checking nodes of either 2005 or 2005.1
 N MAGXX,PIECE,NODE,LOC,FILE
 S MAGXX=IEN
 S ALTPATH=""
 S PIECE=$S(TYPE="ABS":4,TYPE="BIG":1,TYPE="FULL":3,(TYPE="PHOTOID"&(EXT="ABS")):4,TYPE="PHOTOID":3,1:0)
 S NODE=$S(TYPE="BIG":"FBIG",1:0)
 S FILE=$S($D(^MAG(2005,IEN,0)):"2005",1:"2005.1")
 S LOC=$P($G(^MAG(FILE,IEN,NODE)),U,PIECE)
 Q:'$D(^MAG(2005.2,+LOC,0)) 0
 S ALTPATH=$$UPPER^MAGQE4($P($G(^MAG(2005.2,LOC,0)),U,2)_$$DIRHASH^MAGFILEB(FNAM,LOC))
 Q $S(ALTPATH=FILEPATH:1,1:0)
CPUPD(TYPE,IEN,FP,FN,EXT) ;
 ; Patch 39 - Update : Error log type, and using FILE in case an Archive file
 N PIECE,CP,NODE,LOC,FILE
 S EXT=$S('$D(EXT):"",1:$$UPPER^MAGQE4(EXT))
 S PIECE=$S(TYPE="ABS":4,TYPE="BIG":1,TYPE="FULL":3,(TYPE="PHOTOID"&(EXT="ABS")):4,TYPE="PHOTOID":3,1:0)
 S NODE=$S(TYPE="BIG":"FBIG",1:0)
 S LOC=$$UNHASH(FN,FP)
 I (PIECE=0)!(+LOC=0) D ELOG(FN,FP,"RAID pointer indeterminate") Q
 S FILE=$S($D(^MAG(2005,IEN,0)):"2005",1:"2005.1")
 S $P(^MAG(FILE,IEN,NODE),U,PIECE)=LOC
 Q
CUPD(RESULT,FILEPATH,FILENAME,EXT,IEN) ; RPC[MAGQ CUPDTE]
 N TYPE ; called from the BP Purge
 N X S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 S TYPE=$$FTYPE(EXT,IEN)
 D CPUPD(TYPE,IEN,FILEPATH,FILENAME,EXT)
 Q
UNHASH(FN,FP) ; RETURN NETWORK LOCATION NUMBER
 N SHARE,HASH
 S SHARE=$S(FP[":":$P(FP,"\",1,2)_"\",1:$P(FP,"\",1,4)_"\")
 S HASH=$S($P(FP,SHARE,2)["\":"Y",1:"")
 Q $$SHNAM(SHARE,HASH)
ELOG(FN,FP,MESSAGE) ;
 N INDX
 N X S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 S INDX=+$O(^TMP("MAGQ",$J,"PRG",99999),-1)+1
 S ^TMP("MAGQ",$J,"PRG",INDX)=MESSAGE_"^"_FN_"^"_FP
 Q
ELOGR(RESULT,LIMIT) ;[MAGQ ELOGR] - Error log report and purge
 ; Please test this
 N FN,INDX,CNT
 N X S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 S CNT=0,INDX=""
 F  S INDX=$O(^TMP("MAGQ",$J,"PRG",INDX)) Q:INDX'?1N.N  Q:CNT=LIMIT  D
 . S CNT=CNT+1,RESULT(CNT)=^TMP("MAGQ",$J,"PRG",INDX)
 . K ^TMP("MAGQ",$J,"PRG",INDX)
 . Q
 S RESULT(0)=CNT
 S INDX=$O(^TMP("MAGQ",$J,"PRG",""))
 I INDX?1N.N S RESULT(0)=RESULT(0)_U_"MORE"
 Q
SHNAM(SHARE,HASH) ;
 N NUM,ONLINE,ZNODE
 S (NUM,ONLINE)=0
 Q:((SHARE="")!(SHARE[":")) ""
 F  S NUM=$O(^MAG(2005.2,"AC",SHARE,NUM)) Q:'NUM  D  Q:ONLINE
 . S ZNODE=^MAG(2005.2,NUM,0)
 . Q:($P(ZNODE,"^",6)'="1")
 . Q:($P(ZNODE,"^",8)'=HASH)
 . S ONLINE="1"
 Q NUM
