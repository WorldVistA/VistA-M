MAGDQRUL ;WOIFO/EdM,MLH - Imaging RPCs for Query/Retrieve - logging utility ; 30 Dec 2011 2:20 PM
 ;;3.0;IMAGING;**118**;Mar 19, 2002;Build 4525;May 01, 2013
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
LOG(TYP,DETAIL,TXT) N D1,D2,D3,LOC,X
 ; check usage
 I $G(TYP)="" S OUT(1)="-1^Audit type not provided" Q
 I '$D(DETAIL) S OUT(1)="-2^Audit detail must be defined" Q
 ;
 D:'$G(DT) DT^DICRW
 S D1=$O(^MAGDAUDT(2006.5733,"B",DT,""))
 S:'D1 D1=$$ADD($NA(^MAGDAUDT(2006.5733)),"QUERY/RETRIEVE STATISTICS",2006.5733,DT,1)
 ;
 S LOC=$G(DUZ(2)) S:'LOC LOC=$$KSP^XUPARAM("INST")
 S D1=$O(^MAGDAUDT(2006.5733,DT,1,"B",LOC,""))
 S:'D1 D1=$$ADD($NA(^MAGDAUDT(2006.5733,DT,1)),"",2006.57331,LOC,1)
 ;
 S D2=$O(^MAGDAUDT(2006.5733,DT,1,D1,1,"B",TYP,""))
 S:'D2 D2=$$ADD($NA(^MAGDAUDT(2006.5733,DT,1,D1,1)),"",2006.57332,TYP,0)
 L +^MAGDAUDT(2006.5733,DT,1,D1,1,D2):1E9 ; Background job MUST wait
 S X=$G(^MAGDAUDT(2006.5733,DT,1,D1,1,D2,0))
 S $P(X,"^",2)=$P(X,"^",2)+1
 S ^MAGDAUDT(2006.5733,DT,1,D1,1,D2,0)=X
 L -^MAGDAUDT(2006.5733,DT,1,D1,1,D2)
 ;
 D:DETAIL'=""
 . S D3=$O(^MAGDAUDT(2006.5733,DT,1,D1,1,D2,1,"B",DETAIL,""))
 . S:'D3 D3=$$ADD($NA(^MAGDAUDT(2006.5733,DT,1,D1,1,D2,1)),"",2006.57333,DETAIL,0)
 . L +^MAGDAUDT(2006.5733,DT,1,D1,1,D2,1,D3):1E9 ; Background job MUST wait
 . S X=$G(^MAGDAUDT(2006.5733,DT,1,D1,1,D2,1,D3,0))
 . S $P(X,"^",2)=$P(X,"^",2)+1
 . S ^MAGDAUDT(2006.5733,DT,1,D1,1,D2,1,D3,0)=X
 . L -^MAGDAUDT(2006.5733,DT,1,D1,1,D2,1,D3)
 . Q
 ;
 S OUT(1)=$G(TXT)
 Q
 ;
ADD(ROOT,F1,F2,VAL,DINUM) N D0,NAM,O,X
 S ROOT=$E(ROOT,1,$L(ROOT)-1)_",",NAM=ROOT_"0)",O=ROOT_""" "")"
 L +@NAM:1E9 ; Background job MUST wait
 S X=$G(@NAM)
 S $P(X,"^",1,2)=F1_"^"_F2
 S D0=$S(DINUM:+VAL,1:$O(@O,-1)+1),$P(X,"^",3)=D0
 S $P(X,"^",4)=$P(X,"^",4)+1
 S @NAM=X
 S @(ROOT_D0_",0)")=VAL
 S @(ROOT_"""B"",$P(VAL,""^"",1),D0)")=""
 L -@NAM
 Q D0
