MAGQE1 ;WOIFO/RMP - Support for MAG Enterprise ; 02/18/2005  09:19
 ;;3.0;IMAGING;**27,29,30,20,39**;Mar 19, 2002;Build 2010;Mar 08, 2011
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
SDATE(FDAY,ORDER) ; Find first image before/after specified date
 ; EdM: In a future patch, this function must be replaced by a cross-reference.
 N I1,I2
 I $G(ORDER)'="R" Q 0
 S I1=$O(^MAG(2005," "),-1)+1 S I2=$O(^MAG(2005.1," "),-1)+1
 Q $S(I1>I2:I1,1:I2)
 ;
BPV(PLACE) ;
 N BPWS,D0,NODE,INDEX,WS,RD
 K BPWS
 S RD=$$FMADD^XLFDT($$NOW^XLFDT,-180,"","","")
 S WS="" F  S WS=$O(^MAG(2006.8,"C",PLACE,WS)) Q:WS=""  D
 . S D0=$O(^MAG(2006.8,"C",PLACE,WS,""))
 . Q:$P($G(^MAG(2006.8,D0,0)),"^",12)'="1"
 . S NODE=$G(^MAG(2006.8,D0,1))
 . Q:(+$P(NODE,U,5))<RD  ;  last execution date is greater than 6 months or null
 . D:$P(NODE,"^",2)>0
 . . S INDEX=$P(NODE,"^",2)_"^"_$P(NODE,"^",4)
 . . S BPWS(INDEX)=$G(BPWS(INDEX))+1
 . . S $P(BPWS(INDEX),"^",2)=$P(NODE,"^",3)
 . . Q
 . Q
 D:$D(BPWS) LLOAD^MAGQE5(.BPWS,"BP VERS NUM DATE: ")
 Q
 ;
IWSV(PLACE) ; Image workstation versions
 N D0,IDX,OS,RD,WSC,WSD,WSV,X
 S RD=$$FMADD^XLFDT($$NOW^XLFDT,-180,"","","")
 S D0=0 F  S D0=$O(^MAG(2006.81,"C",PLACE,D0)) Q:'D0  D
 . S X=^MAG(2006.81,D0,0) Q:$P(X,"^",3)<RD
 . S OS=$P($G(^MAG(2006.81,D0,1)),"^",2)
 . S:OS?.N OS=$P($G(^MAG(2006.81,D0,1)),"^",3)
 . S IDX=$P(X,"^",9) D:IDX'=""  ; Display Station
 . . S:OS'="" IDX=IDX_"^"_OS S WSD(IDX)=$G(WSD(IDX))+1
 . . Q
 . S IDX=$P(X,"^",13) D:IDX'=""  ; Capture Station
 . . S:OS'="" IDX=IDX_"^"_OS S WSC(IDX)=$G(WSC(IDX))+1
 . . Q
 . S IDX=$P(X,"^",15) D:IDX'=""  ; VistARad Station
 . . S:OS'="" IDX=IDX_"^"_OS S WSV(IDX)=$G(WSV(IDX))+1
 . . Q
 . Q
 D LLOAD^MAGQE5(.WSD," WS DIS VERS: ")
 D LLOAD^MAGQE5(.WSC," WS CAP VERS: ")
 D LLOAD^MAGQE5(.WSV," WS VR VERS: ")
 Q
 ;
DICOMV() ; Version of DICOM
 N D0,DCMG,RD,T,VER,X
 S RD=$$FMADD^XLFDT($$NOW^XLFDT,-30,"","","")
 S X="" F  S X=$O(^MAG(2006.83,"B",X)) Q:X=""  D
 . S D0=$O(^MAG(2006.83,"B",X,"")) Q:'D0
 . S T=$G(^MAG(2006.83,D0,0)) Q:$P(T,"^",2)<RD
 . S VER=$P(T,"^",3) S:VER="" VER="?"
 . S DCMG(VER)=$G(DCMG(VER))+1
 . Q
 D:$D(DCMG) LLOAD^MAGQE5(.DCMG,"DICOM Gateway Version: ")
 Q
 ;
VSTAV() ;
 N VER
 S VER=$$VERSION^XPDUTL("IMAGING")
 S:$T(LAST^XPDUTL)'="" VER=VER_"^"_$$LAST^XPDUTL("IMAGING",VER)
 Q VER
 ;
SNS(PLACE) ;
 N D1,RESULT
 S RESULT=$P(^MAG(2006.1,PLACE,0),"^",2)
 S D1=0 F  S D1=$O(^MAG(2006.1,PLACE,4,D1)) Q:'D1  D
 . S RESULT=RESULT_"^"_$P($G(^MAG(2006.1,PLACE,4,D1,0)),"^",1)
 . Q
 Q RESULT
 ;
