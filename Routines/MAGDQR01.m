MAGDQR01 ;WOIFO/EdM - Imaging RPCs for Query/Retrieve ; 14 Oct 2008 3:45 PM
 ;;3.0;IMAGING;**51,54,66**;Mar 19, 2002;Build 1836;Sep 02, 2010
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
FIND(OUT,TAGS,RESULT,OFFSET,MAX) ; RPC = MAG CFIND QUERY
 N ERROR,I,N,P,REQ,T,V,X,ZTDESC,ZTDTH,ZTRTN,ZTSAVE,ZTSK
 ;
 S RESULT=$G(RESULT),OFFSET=$G(OFFSET)
 S ERROR=0
 ;
 I 'RESULT D  Q
 . ; TAGS(i) = tag | VR | flag | value
 . S I="" F  S I=$O(TAGS(I)) Q:I=""  D
 . . S X=TAGS(I),T=$P(X,"|",1) Q:T=""
 . . S T=$TR(T,"abcdef","ABCDEF"),$P(TAGS(I),"|",1)=T
 . . S V=$P(X,"|",4,$L(X)+2) S:V="*" V=""
 . . S:$TR(V,"UNKOW","unkow")="<unknown>" V=""
 . . S L=$L(V,"\") S:V="" L=0
 . . S REQ(T)=L F P=1:1:L S REQ(T,P)=$P(V,"\",P)
 . . Q
 . S X=0,T="" F  S T=$O(REQ(T)) Q:T=""  D  Q:X
 . . S P="" F  S P=$O(REQ(T,P)) Q:P=""  S:REQ(T,P)'="" X=1
 . . Q
 . D:'X ERR("No permission to query whole database.")
 . S T="" F  S T=$O(REQ(T)) Q:T=""  D:REQ(T)<-1 ERR("Missing required tag """_T_""".")
 . I ERROR D ERRLOG Q
 . ;
 . ; Convert DICOM name to VA name
 . ;
 . S T="0010,0010"
 . S P="" F  S P=$O(REQ(T,P)) Q:P=""  S REQ(T,P)=$$DCM2VA(REQ(T,P))
 . ;
 . ; Initialize Result Set
 . ;
 . L +^MAGDQR(2006.5732,0):1E9 ; Background process MUST wait
 . S X=$G(^MAGDQR(2006.5732,0))
 . S $P(X,"^",1,2)="DICOM QUERY RETRIEVE RESULT^2006.5732"
 . S RESULT=$O(^MAGDQR(2006.5732," "),-1)+1
 . S $P(X,"^",3)=RESULT
 . S $P(X,"^",4)=$P(X,"^",4)+1
 . S ^MAGDQR(2006.5732,0)=X
 . S ^MAGDQR(2006.5732,RESULT,0)=RESULT_"^IP^"_$$NOW^XLFDT()
 . S ^MAGDQR(2006.5732,"B",RESULT,RESULT)=""
 . L -^MAGDQR(2006.5732,0)
 . ;
 . ; Queue up actual query
 . ;
 . S ZTRTN="QUERY^MAGDQR02"
 . S ZTDESC="Perform DICOM Query, result-set="_RESULT
 . S ZTDTH=$H
 . S ZTSAVE("RESULT")=RESULT
 . S T="" F  S T=$O(REQ(T)) Q:T=""  D
 . . S ZTSAVE("REQ("""_T_""")")=REQ(T)
 . . S P="" F  S P=$O(REQ(T,P)) Q:P=""  S ZTSAVE("REQ("""_T_""","_P_")")=REQ(T,P)
 . . Q
 . D ^%ZTLOAD,HOME^%ZIS
 . D:'$G(ZTSK) ERR("TaskMan did not Accept Request")
 . S:$G(ZTSK) $P(^MAGDQR(2006.5732,RESULT,0),"^",4)=ZTSK
 . I ERROR D ERRLOG Q
 . D LOG("TaskMan","","0,"_RESULT_",Query Started through TaskMan")
 . Q
 ;
 I OFFSET<0 D  Q  ; All done, clean up result-set
 . D LOG("CleanUp","","1,Result Set Cleaned Up")
 . Q:'$D(^MAGDQR(2006.5732,RESULT))
 . L +^MAGDQR(2006.5732,0):1E9 ; Background process MUST wait
 . S X=$G(^MAGDQR(2006.5732,0))
 . S $P(X,"^",1,2)="DICOM QUERY RETRIEVE RESULT^2006.5732"
 . S:$P(X,"^",4)>0 $P(X,"^",4)=$P(X,"^",4)-1
 . S ^MAGDQR(2006.5732,0)=X
 . K ^MAGDQR(2006.5732,RESULT)
 . K ^MAGDQR(2006.5732,"B",RESULT)
 . L -^MAGDQR(2006.5732,0)
 . Q
 ;
 I 'OFFSET D  Q:V'="OK"  ; Is the query done?
 . S X=$G(^MAGDQR(2006.5732,RESULT,0))
 . S V=$P(X,"^",2) Q:V="OK"
 . I V="X" D LOG("NoResult","","-2,No result returned") S V="OK" Q
 . S ZTSK=$P(X,"^",4) D STAT^%ZTLOAD
 . I $G(ZTSK(2))'["Inactive" S OUT(1)="-1,TaskMan still active" Q
 . I ZTSK(2)["Finished" S V="OK" Q
 . D LOG("TaskManAbort",ZTSK(2),"-13,TaskMan aborted: "_ZTSK(2))
 . Q
 ;
 S:'$G(MAX) MAX=100
 S I=OFFSET,N=1 F  S I=$O(^MAGDQR(2006.5732,RESULT,1,I)) Q:'I  D  Q:N>MAX
 . S OFFSET=I
 . S N=N+1,OUT(N)=$G(^MAGDQR(2006.5732,RESULT,1,I,0))
 . Q
 I N=1 D  Q
 . S N=0,I=" " F  S I=$O(^MAGDQR(2006.5732,RESULT,1,I),-1) Q:'I  D  Q:'I
 . . S X=$G(^MAGDQR(2006.5732,RESULT,1,I,0)) Q:X'["0000,0902^Result #"
 . . S N=$P(X," # ",2),I=0
 . . Q
 . D LOG("Done",N,"0,No more results.")
 . Q
 I N=2,OFFSET=1 D LOG("Error",$P(OUT(2),"^",2),"")
 S OUT(1)=(N-1)_","_OFFSET_",result(s)."
 Q
 ;
DCM2VA(NAME) N I,P
 ; P66T70: Normalize PN VR from legacy comma to current carat before processing
 D:NAME'=""
 . S NAME=$TR(NAME,"abcdefghijklmnopqrstuvwxyz,","ABCDEFGHIJKLMNOPQRSTUVWXYZ^")
 . ; Ignore prefixes and suffices
 . F I=1:1:3 D
 . . S P(I)=$P(NAME,"^",I)
 . . F  Q:$E(P(I),1)'=" "   S P(I)=$E(P(I),2,$L(P(I)))
 . . F  Q:$E(P(I),$L(P(I)))'=" "   S P(I)=$E(P(I),1,$L(P(I))-1)
 . . Q
 . S NAME=P(1)_","_P(2) S:P(3)'="" NAME=NAME_" "_P(3)
 . S:$E(NAME,$L(NAME))="," NAME=NAME_"*"
 . Q
 Q NAME
 ;
VA2DCM(NAME) N I,P
 ; P66T70: Prepare name for return to caller with consistent comma delimiter
 ; Also strip leading, trailing, interior spaces
 D:NAME'=""
 . S P(1)=$P(NAME,",",1),P(2)=$P(NAME,",",2)
 . F I=1,2 D
 . . F  Q:$E(P(I),1)'=" "  S P(I)=$E(P(I),2,$L(P(I)))
 . . F  Q:$E(P(I),$L(P(I)))'=" "  S P(I)=$E(P(I),1,$L(P(I))-1)
 . . Q
 . S:P(2)[" " P(3)=$P(P(2)," ",2,999),P(2)=$P(P(2)," ",1)
 . F I=1:1:3 D:$D(P(I))
 . . F  Q:$E(P(I),1)'=" "  S P(I)=$E(P(I),2,$L(P(I)))
 . . F  Q:P(I)'["  "  S P(I)=$P(P(I),"  ",1)_" "_$P(P(I),"  ",2,999)
 . . Q
 . S NAME=P(1)_","_P(2) S:$D(P(3)) NAME=NAME_","_P(3)
 . Q
 Q NAME
 ;
ERR(X) S ERROR=ERROR+1,ERROR(ERROR)=X
 Q
 ;
ERRLOG N I,O
 S O=1,I="" F  S I=$O(ERROR(I)) Q:I=""  S O=O+1,OUT(O)=ERROR(I)
 D LOG("Error","",(-O)_",Errors encountered")
 Q
 ;
ERRSAV N I,O
 S $P(^MAGDQR(2006.5732,RESULT,0),"^",2,3)="OK^"_$$NOW^XLFDT()
 K ^MAGDQR(2006.5732,RESULT,1)
 S O=0,I="" F  S I=$O(ERROR(I)) Q:I=""  D
 . S O=O+1,^MAGDQR(2006.5732,RESULT,1,O,0)="0000,0902^"_ERROR(I)
 . Q
 Q
 ;
LOG(TYP,DETAIL,TXT) N D1,D2,D3,LOC,X
 D:'$G(DT) DT^DICRW
 S D1=$O(^MAGDAUDT(2006.5733,"B",DT,""))
 S:'D1 D1=$$ADD($NA(^MAGDAUDT(2006.5733)),"QUERY/RETRIEVE STATISTICS",2006.57633,DT,1)
 ;
 S LOC=$G(DUZ(2)) S:'LOC LOC=$$KSP^XUPARAM("INST")
 S D1=$O(^MAGDAUDT(2006.5733,DT,1,"B",LOC,""))
 S:'D1 D1=$$ADD($NA(^MAGDAUDT(2006.5733,DT,1)),"",2006.576331,LOC,1)
 ;
 S D2=$O(^MAGDAUDT(2006.5733,DT,1,D1,1,"B",TYP,""))
 S:'D2 D2=$$ADD($NA(^MAGDAUDT(2006.5733,DT,1,D1,1)),"",2006.576332,TYP,0)
 L +^MAGDAUDT(2006.5733,DT,1,D1,1,D2):1E9 ; Background job MUST wait
 S X=$G(^MAGDAUDT(2006.5733,DT,1,D1,1,D2,0))
 S $P(X,"^",2)=$P(X,"^",2)+1
 S ^MAGDAUDT(2006.5733,DT,1,D1,1,D2,0)=X
 L -^MAGDAUDT(2006.5733,DT,1,D1,1,D2)
 ;
 D:DETAIL'=""
 . S D3=$O(^MAGDAUDT(2006.5733,DT,1,D1,1,D2,1,"B",DETAIL,""))
 . S:'D3 D3=$$ADD($NA(^MAGDAUDT(2006.5733,DT,1,D1,1,D2,1)),"",2006.576333,DETAIL,0)
 . L +^MAGDAUDT(2006.5733,DT,1,D1,1,D2,1,D3):1E9 ; Background job MUST wait
 . S X=$G(^MAGDAUDT(2006.5733,DT,1,D1,1,D2,1,D3,0))
 . S $P(X,"^",2)=$P(X,"^",2)+1
 . S ^MAGDAUDT(2006.5733,DT,1,D1,1,D2,1,D3,0)=X
 . L -^MAGDAUDT(2006.5733,DT,1,D1,1,D2,1,D3)
 . Q
 ;
 S OUT(1)=TXT
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
 ;
