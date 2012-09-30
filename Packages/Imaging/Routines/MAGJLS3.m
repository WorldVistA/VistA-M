MAGJLS3 ;WIRMFO/JHC - VistARad RPC calls ; 2 Jan 2012  11:46 AM
 ;;3.0;IMAGING;**16,22,18,101,90,120**;Mar 19, 2002;Build 27;May 23, 2012
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
 ; EPs:
 ; BLDACTV
 ;
BLDACTV(MAGGRY,DATA,MAGLST) ; get subset of Active Exams; called from MAGJLS2
 ;MAGGRY - Indirect Global ref of return array
 ;DATA: Listyp ^ Imaging Types
 ;Listyp = U  -- UNREAD Exams (Status Category=E)
 ;   = R  -- RECENT (Sts Cat's D & T)
 ;   = A  -- ALL Active (Cat's E, D, & T)
 ;   = P  -- PENDING (Cat W)
 ;   = N  -- Newly Interpreted Exams (No Cat.-Internal use only)
 ;ImgTypes = List of Imaging Types to process, or "ALL" for all
 ; MAGLST = $NA ref to return global; references to it use subscript indirection
 ; MAGLST optional: input to specify return global to use
 ; 
 ;* This subrtn can receive U/R/A/P/N (LSTREQ)-- ^_delim list of ImgTypes (IMTYPS)
 N RADFN,RADTI,RACNI,REMX
 N HDR,HDRLST,MAGIMGTY,MAGRACNT,MAGRET,LSTREQ,LISTYP,LISCAT,IMTYPS
 N REPLY,STAT,TYP,SORTMAG,DIQUIET,STATCHK,LASTDT,IMGSONLY,URGORD,REMONLY
 S DIQUIET=1 D DT^DICRW
 I $G(MAGLST)="" S MAGLST=$NA(^TMP($J,"MAGJACTIVE")) ; default loc'n if not passed in
 K ^TMP($J,"MAGRAEX"),@MAGLST
 S LSTREQ=$P(DATA,U),IMTYPS=$P(DATA,U,2,99)
 I LSTREQ="U"!(LSTREQ="R")!(LSTREQ="A")!(LSTREQ="P")!(LSTREQ="N")!(LSTREQ="H")
 E  S REPLY="0^4~Invalid Request (List Type="_LSTREQ_")" G BLDACTVZ
 S MAGRACNT=0
 S X=$G(^MAG(2006.69,1,0)),IMGSONLY=+$P(X,U,7),REMX=+$P(X,U,10) ; show only exams w/ images?
 S REMONLY=0
 I $G(MAGJOB("REMOTE")) D  ; ;show remote cache only?
 . Q:(LSTREQ="H")  S REMONLY=+$G(MAGJOB("REMOTESCREEN"))
 S X=$G(^MAG(2006.69,1,1)),URGORD=$P(X,U)
 S:URGORD="" URGORD="S,U,P,R" S URGORD=$TR(URGORD,",") ; "Priority" sort
 S HDR=$S(LSTREQ="U":"UNREAD",LSTREQ="R":"RECENT",LSTREQ="P":"PENDING",LSTREQ="A":"UNREAD and RECENT",LSTREQ="N":"NEWLY INTERP",LSTREQ="H":"HISTORY",1:"")_" Exams"_" for IMAGING TYPES: "
 S LISTYP=$S(LSTREQ="U":"E",LSTREQ="R":"D^T",LSTREQ="A":"E^D^T",LSTREQ="P":"W",LSTREQ="N":"",LSTREQ="H":"",1:"E")
 S REPLY="0^4~Compiling list of Radiology Exams (ACTIVE)."
 I $G(BKGPROC),(LSTREQ="R") K ^TMP($J,"NEWINT") S ^TMP($J,"NEWINT")=+$G(^XTMP("MAGJ2","RECENT",0))
 I LSTREQ="N" D BLDACT2 G BLDACTVZ
 I LSTREQ="H" D HISTBLD^MAGJLS3A G BLDACTVZ
 D BLDACT1
BLDACTVZ ;
 I 'MAGRACNT S:(REPLY["Compiling") REPLY="0^2~No Exams Found"
 E  D
 . I IMTYPS="ALL" S HDR=HDR_" ALL"
 . E  S Y="" F I=0:1 S Y=$O(HDRLST(Y)) Q:Y=""  S HDR=HDR_$S('I:"",1:", ")_Y
 . S REPLY=MAGRACNT_U_"1~"_HDR
 S @MAGLST@(0,1)=REPLY,^(2)=""
 K ^TMP($J,"MAGRAEX"),^("RAE1")
 S MAGGRY=MAGLST
 Q
BLDACT1 ; Compile exams by Status codes
 D BLDSTAT^MAGJLS3A
 F  S LISCAT=$P(LISTYP,U),LISTYP=$P(LISTYP,U,2,9) Q:LISCAT=""  D
 . I IMTYPS="ALL" S TYP="" D  Q
 . . F  S TYP=$O(STAT(LISCAT,TYP)) Q:TYP=""  D IMGTYP(LISCAT,TYP)
 . E  I +IMTYPS D IMGTYLST(LISCAT,IMTYPS) Q
 . E  S REPLY="0^4~Invalid Imaging Type"
 Q
BLDACT2 ; Add recently interpreted exams to the "Recent" compile data
 ; 1st, compile these into their own list
 N CNT,INDX,RAST,STATCHK,RECLIST,REC,X1,X2
 S X=$G(^XTMP("MAGJ2","RECENT",0)),INDX=+$P(X,U,2)
 F  S INDX=$O(^XTMP("MAGJ2","RECENT",INDX)) Q:'INDX  S X=^(INDX) D
 . S RADFN=$P(X,U),RADTI=$P(X,U,2),RACNI=$P(X,U,3),(RAST,STATCHK)=$P(X,U,4)
 . D GETEXAM2^MAGJUTL1(RADFN,RADTI,RACNI,0,.MAGRET)
 . I MAGRET D SVMAG2A()
 . S $P(^XTMP("MAGJ2","RECENT",0),U,2)=INDX
 ; copy the above records to the "RECENT" curlist
 S RECLIST=+$$CURLIST^MAGJLS2("LS9992")
 I 'RECLIST S RECLIST=+$G(^XTMP("MAGJ2","BKGND","LS9992",0))
 I 'RECLIST Q  ; Recent list not being compiled--skip it!
 F CNT=1:1:MAGRACNT S X1=@MAGLST@(CNT,1),X2=^(2) D  ; MAGLST described at BLDACTV
 . S REC=^XTMP("MAGJ2","LS9992",RECLIST,0,1)+1
 . S ^XTMP("MAGJ2","LS9992",RECLIST,REC,1)=X1,^(2)=X2
 . S $P(^XTMP("MAGJ2","LS9992",RECLIST,0,1),U)=REC
 Q
 ;
SVMAG2A(PIPE3) ;used by subroutine at tag BLDACTV
 ; load return array @MAGLST@(n, ...
 ; Note: ^TMP("MAGRAEX" is set by the subroutine Getexam2^Magjutl1
 ; PIPE3 optional; contains data that is passed through the system; e.g.
 ;   the HISTORY List receives data from the client which is augmented
 ;   and passed back to the client
 ;Set outside this subrtn:STATCHK,RAST,LSTREQ,REMONLY,BKGPROC,MAGRACNT,MAGLST
 ;
 N MAGDT,SORTDT,IMGCNT,ONL,XX,XX2,Y,RARPT,KEY,RASTCAT,Y2
 N REMOTE,MODALITY,DAYCASE,EXCAT,ORD,URG,URG1,PREOP,LASTSSN,CURPRIO,STATUS
 N REMOTE2,LRFLAG,TECH,REGDT,REGDTSRT,PTID,STATPRIORITY
 S PIPE3=$G(PIPE3,"")
 S URG="",PREOP=""   ; <*> Need below until RAO7PC1A returns URG
 S X=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 S ORD=$P(X,U,11)
 I ORD S Y=$G(^RAO(75.1,ORD,0)),URG=$P(Y,U,6),PREOP=$P(Y,U,12)
 S XX=$G(^TMP($J,"MAGRAEX",1,1)),XX2=$G(^(2))
 I $G(STATCHK),(STATCHK=$P(XX,U,11))
 E  I LSTREQ="H" S RAST=$P(XX,U,11)
 E  Q       ;  index '= stored status
 S RARPT=$P(XX,U,10),STATPRIORITY="" ; STATPRIORITY always null from the compiler (place-holder only)
 D IMGINFO^MAGJUTL2(RARPT,.Y)
 S IMGCNT=$P(Y,U),ONL=$P(Y,U,2),MAGDT=$P(Y,U,3),REMOTE=$P(Y,U,4),MODALITY=$P(Y,U,5),PLACE=$P(Y,U,6),KEY=$P(Y,U,7)
 S REMOTE2=REMOTE
 I IMGSONLY,'IMGCNT,'(LSTREQ="P") Q  ;only list exams w/ imgs, except PENDING
 I REMONLY,'REMOTE,'$G(BKGPROC) Q  ; only list remote exams
 S:PLACE PLACE=$P($G(^MAG(2006.1,PLACE,0)),U,9)
 I MAGDT="" S MAGDT=$P(XX,U,7)
 S SORTDT=MAGDT
 S MAGDT=$$FMTE^XLFDT(MAGDT,"5Z")
 S REGDTSRT=$P(XX,U,7),REGDT=$$FMTE^XLFDT(REGDTSRT,"5Z")
 ; XX 1 RADFN   RADTI    RACNI   RANME    RASSN  <-- from GETEXAM
 ;    6 RADATE  RADTE    RACN    RAPRC     RARPT
 ;   11 RAST    DAYCASE  RAELOC   RASTP     RASTORD
 ;   16 RADTPRT RACPT    IMTYPABB
 ;XX2 1 REQLOCABB  REQLOCNM  RdRIST  COMPLIC  RAD_DIV
 ;    6 SITE_CODE  RISTISME  PROCMOD  REQLOCT  REQWARD
 ;   11 RASTCAT   LRFLAG   TECH
 S:'URG URG=9  ;  request urgency default to Routine
 I URG=9,(PREOP]"") S URG=8  ; dummy val for Pre-Op
 S URG1=$S(URG=1:"Stat",URG=2:"Urg",URG=8:"PreOp",1:"Rout"),X=$E(URG1),URG1=$F(URGORD,X)-1_"-"_URG1
 I PREOP]"",(URG'=8) S URG1=URG1_"/Pre" ; show PreOp & another priority
 S SORTMAG=$S(+IMGCNT:"A",1:"B") ; sort index: has/not images
 S DAYCASE=$P(XX,U,12),RASTORD=$P(XX,U,15),STATUS=$P(XX,U,11),RASTCAT=$P(XX2,U,11),LRFLAG=$P(XX2,U,12),TECH=$P(XX2,U,13)
 S EXCAT="",CURPRIO=0
 I STATUS]"" D
 . S EXCAT=RASTCAT
 . I RASTORD<2!(EXCAT="W")!('IMGCNT) S CURPRIO=0 ; Cancelled/Waiting/No images: Ignore exam
 . E  I EXCAT="E" S CURPRIO=1  ; Examined="Current" exam
 . E  S CURPRIO=2  ; must be a "prior" exam
 . I CURPRIO,'(ONL="Y") S CURPRIO=3 ; images on jukebox
 . I RASTORD=9 S EXCAT="C" ; Complete
 . E  I EXCAT="D"!(EXCAT="T") S EXCAT="I" ; just display one value meaning Interpreted
 ; PTID is Initial w/ last 4 of SSN for VA (Z9999), or MRN for IHS (1.N number)
 ; LASTSSN is either last 4 digits of SSN, or last 4 of whatever number came in, or nil
 S X=$P(XX,U,5) ; SSN in VA, MRN in IHS
 I X?3N1"-"2N1"-"4N S LASTSSN=$P(X,"-",3),PTID=$E($P(XX,U,4))_LASTSSN
 E  S PTID=X D
 . I X?1N.N S X=10000+X,T=$L(X),LASTSSN=$E(X,T-3,T)
 . E  S LASTSSN=""
 ; build output string in Y & Y2
 S Y=DAYCASE_U_U_$P(XX,U,4)_U_PTID
 S Y=Y_U_URG1_U_$E($P(XX,U,9),1,30)_U_MAGDT_U_$E($P(XX,U,14),1,10)_U_IMGCNT
 S Y=Y_U_ONL_U_$E($P(XX,U,13),1,15)_U_REMOTE
 S Y=Y_U_SORTMAG_U_SORTDT_U_MODALITY_U_RAST_U_$$RAIMTYP(RAST)
 S RISTISME=$P(XX2,U,7)
 S Y2=$P(XX2,U,1,3)_U_LASTSSN_U_$P(XX2,U,5)_U_PLACE_U_RISTISME_U_$P(XX2,U,8,9)_U_$P(XX,U,17)_U_$P(XX2,U,10)
 ; add 4 "place holders" for fields that are only in the History list
 S Y2=Y2_U_U_U_U
 S Y2=Y2_U_TECH_U_REGDT_U_REGDTSRT ; p101 adds 3 new fields
 S Y2=Y2_U_"|"_$P(XX,U,1,3)_U_RARPT
 S Y2=Y2_"|"_PIPE3_"|"_EXCAT_"^^^"_MODALITY_U_$P(XX,U,17)_U_CURPRIO_U_RARPT_U_KEY_U_REMOTE2_U_LRFLAG_U_STATPRIORITY
 ; * Note: Keep Pipe piece 4, above, in sync with lstout^magjls2b & magjlst1 *
 S MAGRACNT=MAGRACNT+1
 S @MAGLST@(MAGRACNT,1)=Y,^(2)=Y2  ; save output for one exam
 I $G(BKGPROC),(LSTREQ="R") S ^TMP($J,"NEWINT",$P(XX,U,1,3))=""
 Q
 ;
RAIMTYP(RAST) ; return Imaging Type Abbrev for Status Code
 N X S X="" I RAST]"" D
 . S X=$G(RAIMTYP(RAST)) Q:X]""
 . S X=$P($G(^RA(72,RAST,0)),U,7)
 . I X S X=$P($G(^RA(79.2,X,0)),U,3)_"~"_X  ; abb~ien
 . S RAIMTYP(RAST)=X   ; save for future use
 Q X
 ;
IMGTYLST(LISCAT,LST) ; get exams for list of image types for input LISCAT
 N TYP
 F  Q:'(LST?1.N.E)  S TYP=+$P(LST,U),LST=$P(LST,U,2,99) D:TYP IMGTYP(LISCAT,TYP)
 Q
 ;
IMGTYP(LISCAT,IMGTY) ; process statuses for one Image Type for LISCAT
 I '$D(^RA(79.2,IMGTY,0)) S REPLY="0^4~Invalid Imaging Type" Q
 N LST
 I $D(STAT)<10 D BLDSTAT^MAGJLS3A
 S (STAT,LST)=""
 S LASTDT=$P(STAT(LISCAT),U)
 F  S STAT=$O(STAT(LISCAT,IMGTY,STAT)) Q:STAT=""  S LST=LST_$S(LST="":"",1:U)_STAT,HDRLST(STAT(LISCAT,IMGTY))=""
 I LST]"" D STATLST(LST)
 Q
 ;
STATLST(LST) ; get exams for a list of status codes
 F  Q:'(LST?1.N.E)  S STAT=+$P(LST,U),LST=$P(LST,U,2,99) D:STAT STAT(STAT)
 Q
 ;
STAT(RAST) ; get exams for one status code
 ; uses File #70) "AS" index of active exams
 ;
 N RASTP
 I $D(^RA(72,RAST)) S RASTP=$P(^(RAST,0),U)
 E  S REPLY="0^4~Invalid Exam Status" Q
 I '$D(^RADPT("AS",RAST)) S REPLY="0^2~No exams on file with Exam Status "_RASTP Q
 S RADFN=0,STATCHK=RAST
 F  S RADFN=$O(^RADPT("AS",RAST,RADFN)) Q:RADFN'>0  S RADTI=0 D
 . F  S RADTI=$O(^RADPT("AS",RAST,RADFN,RADTI)) Q:RADTI'>0!(RADTI>LASTDT)  S RACNI=0 D
 . . F  S RACNI=$O(^RADPT("AS",RAST,RADFN,RADTI,RACNI)) Q:RACNI'>0  D
 . . . D GETEXAM2^MAGJUTL1(RADFN,RADTI,RACNI,0,.MAGRET)
 . . . Q:'MAGRET  ; no exam returned
 . . . D SVMAG2A()
 Q
 ;
END Q  ; 
