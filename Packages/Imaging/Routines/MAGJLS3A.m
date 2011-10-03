MAGJLS3A        ;WIRMFO/JHC VRAD Exam lists ; 29 Apr 2005  10:00 AM
 ;;3.0;IMAGING;**18**;Mar 07, 2006
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
 ; EPs:
 ; BLDSTAT--Subrtn for exams list compile
 ; HISTBLD -- HISTORY List exams
 ;
BLDSTAT ; build list of Exam Status codes: STAT(CATEGORY,IMAG_TYP,STAT)=STATNM
 ; called from magjls3
 N X,CAT,TYP,STNM K STAT S CAT="",STAT=0
 F  S CAT=$O(^RA(72,"AVC",CAT)) Q:CAT=""  D
 . S X=$S(CAT="E":3,1:2),X=$P($G(^MAG(2006.69,1,0)),U,X)
 . S:'X X=$S(CAT="E":30,1:6) S X=$H-X+1,X=$$HTFM^XLFDT(X),X=9999999.9999-X
 . S STAT(CAT)=X
 . F  S STAT=$O(^RA(72,"AVC",CAT,STAT)) Q:'STAT  D
 .. S TYP=$P($G(^RA(72,STAT,0)),U,7),STNM=$P(^(0),U) S:TYP="" TYP="~"
 .. S STAT(CAT,TYP)=$P($G(^RA(79.2,TYP,0)),U,3),STAT(CAT,TYP,STAT)=STNM
 Q
 ;
HISTBLD ;Compile HISTORY List
 ; Adds records to History List file; initiated by RPC call MAGJ HISTORYLIST/txid=1
 ; called from magjls3
 N CNT,INDX,RAST,STATCHK,RECLIST,EXID,PIPE3
 S X=$G(^XTMP("MAGJ2","HISTORY",DUZ,DUZ(2),0)),INDX=+$P(X,U,2)   ;  High_IEN ^ Last_Proc_IEN
 F  S INDX=$O(^XTMP("MAGJ2","HISTORY",DUZ,DUZ(2),0,"ADD",INDX)) Q:'INDX  S X=^(INDX) D
 . S EXID=$P(X,"|",2),PIPE3=$P(X,"|",3)
 . S RADFN=$P(EXID,U),RADTI=$P(EXID,U,2),RACNI=$P(EXID,U,3),(RAST,STATCHK)=""
 . D GETEXAM2^MAGJUTL1(RADFN,RADTI,RACNI,0,.MAGRET)
 . I MAGRET D SVMAG2A^MAGJLS3(PIPE3)
 . S $P(^XTMP("MAGJ2","HISTORY",DUZ,DUZ(2),0),U,2)=INDX
 Q
 ;
END Q  ; 
