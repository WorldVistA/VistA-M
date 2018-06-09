MAGNAN02 ;WOIFO/NST - IMAGING ANNOTATION UTILITY RPCS ; 20 Oct 2017 11:43 AM
 ;;3.0;IMAGING;**185**;Mar 19, 2002;Build 92;Aug 02, 2012
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
 ;***** RETURNS THE LIST OF STUDY ANNOTATIONS
 ;
 ; RPC: MAGN ANNOT GET STUDY
 ;
 ; .MAGOUT       Reference to a local variable where the results
 ;               are returned to.
 ; .MAGPARAM     List of studies to being annotated
 ; [MAGFLAGS]
 ;    D - include deleted annotations 
 ;    U - include all user's annotations
 ;    W - include word processing fields
 ;
 ; Return Values
 ; =============
 ; if error found during execution
 ;   MAGOUT(0) = Failure status^Error getting values
 ; if success
 ;   MAGOUT(0) =  Success status^^Total lines
 ;   MAGOUT(1) = header with name of the fields
 ;   MAGOUT(3) = "^" delimited pairs with internal and external values of the fields listed in MAGOUT(1) 
 ;   MAGOUT(n) = "WordProcesingFieldxxx^line value"
 ;   MAGOUT(m) = "MultipleField000^fields header"
 ;   MAGOUT(m..m+1) = "MultipleField001^fields values listed in MAGOUT(m)" 
 ;
GET(MAGOUT,MAGPARAM,MAGFLAGS) ;RPC [MAGN ANNOT GET STUDY]
 N CNT,ERR,MAGI,MAGNXE,CNT
 N FILE,FIELDS,STUDYID,STUDYIEN
 S MAGFLAGS=$G(MAGFLAGS)
 S MAGOUT(0)=$$SETERROR^MAGNU002("")
 S FILE=2005.003
 S FIELDS="**"
 S MAGI=""
 S CNT=0
 S ERR=0
 F  S MAGI=$O(MAGPARAM(MAGI)) Q:'MAGI  D  Q:ERR
 . S STUDYID=MAGPARAM(MAGI)
 . S STUDYIEN=$$FIND1^DIC(FILE,"","X",STUDYID,"","","MAGNXE")
 . I $$ISERROR^MAGNU002(.MAGOUT,.MAGNXE) S ERR=1 Q
 . I 'STUDYIEN S MAGOUT(0)=$$SETERROR^MAGNU002("Study "_STUDYID_" not found") S ERR=1 Q
 . D GRECBYPK^MAGNAU03(.MAGOUT,2005.003,STUDYIEN,MAGFLAGS,.CNT)
 . Q
 Q
 ;
 ;***** RETURNS THE LIST OF PSTATE ANNOTATIONS
 ;
 ; RPC: MAGN ANNOT GET PSTATE
 ;
 ; .MAGOUT       Reference to a local variable where the results
 ;               are returned to.
 ; .MAGPARAM     List of presentation state UID
 ;
 ; Return Values
 ; =============
 ; if error found during execution
 ;   MAGRY(0) = Failure status^Error getting values
 ; if success
 ;   MAGRY(0) =  Success status^^Total lines
 ;   MAGRY(1) = header with name of the fields
 ;   MAGRY(3) = "^" delimited pairs with internal and external values of the fields listed in MAGRY(1) 
 ;   MAGRY(n) = "WordProcesingFieldxxx^line value"
 ;   MAGRY(m) = "MultipleField000^fields header"
 ;   MAGRY(m..m+1) = "MultipleField001^fields values listed in MAGRY(m)" 
 ;
GETPSTAT(MAGOUT,MAGPARAM)  ;RPC [MAGN ANNOT GET PSTATE]
 N CNT,CNTG,ERR,MAGI,MAGTMP,FILE,FIELDS
 N PSTATEID,PSTATIEN,STUDYIEN
 K MAGOUT
 S MAGOUT(0)=$$SETERROR^MAGNU002("")
 S FILE=2005.0031
 S FIELDS="**"
 S MAGI=""
 S ERR=0
 S CNT=0
 S CNTG=0
 F  S MAGI=$O(MAGPARAM(MAGI)) Q:'MAGI  D  Q:ERR
 . S PSTATEID=MAGPARAM(MAGI)
 . S STUDYIEN=$O(^MAG(2005.003,"C",PSTATEID,0))
 . I 'STUDYIEN K MAGOUT S MAGOUT(0)=$$SETERROR^MAGNU002("Study not found for presentation ID: "_PSTATEID),ERR=1 Q
 . S PSTATIEN=$O(^MAG(2005.003,"C",PSTATEID,STUDYIEN,0))
 . K MAGTMP
 . D GRECBYPK^MAGNAU03(.MAGTMP,2005.0031,PSTATIEN_","_STUDYIEN,"DUW",.CNT)
 . I '$$ISOK^MAGNU002(MAGTMP(0)) K MAGOUT M MAGOUT=MAGTMP S ERR=1 Q
 . S CNTG=CNTG+1
 . D MERGE(.MAGOUT,.MAGTMP,.CNT,CNTG)
 . Q
 S:'ERR MAGOUT(0)=$$SETOKVAL^MAGNU002(CNT)
 Q
 ;
MERGE(MAGOUT,MAGTMP,CNT,CNTG)  ; Merge one result set to final result list
 N J
 S MAGTMP(1)="ANNOTATION GROUP000"_"^"_MAGTMP(1)
 S MAGTMP(2)="ANNOTATION GROUP"_$TR($J(CNTG,3)," ",0)_"^"_MAGTMP(2)
 S J=$S($D(MAGOUT(1)):1,1:0)  ; Start from line 1 
 F  S J=$O(MAGTMP(J)) Q:'J  D
 . S CNT=CNT+1
 . S MAGOUT(CNT)=MAGTMP(J)
 . Q
 Q
