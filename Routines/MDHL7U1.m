MDHL7U1 ; HOIFO/WAA -Routine utilities for CP PROCESSING OBX ; 7/26/00
 ;;1.0;CLINICAL PROCEDURES;**11**;Apr 01, 2004;Build 67
 ;
PATHCHK(X,Y) ; Check the OBX to see if it is a path then set the path.
 ;
 S Y=0
 ; Add the OBX report type of RP Reference Pointer
 I $S($P(X,"|",3)="ST":0,$P(X,"|",3)="TX":0,$P(X,"|",3)="RP":0,1:1) Q
 I X["//" S X=$TR(X,"/","\")
 I X["\E\" D
 . N Y,Z
 . S Z=""
 . F I=1:1:$L(X) S Y=$E(X,I) D:Y="\"  S Z=Z_Y
 . . I $E(X,I+1)="E",$E(X,I+2)="\" S I=I+2
 . . Q
 . S X=Z
 . Q
 I X'["\\" Q
 S Y("FPATH")=$P(X,"|",6)
 I Y("FPATH")'["\\" S Y("FPATH")=$P(X,"|",4)
 S Y("FPATH")="\\"_$P(Y("FPATH"),"\\",2)
 S Y("FILE")=$P(Y("FPATH"),"\",($L(Y("FPATH"),"\")))
 I $P(Y("FILE"),".",2)="" Q
 S Y("PATH")=$P(Y("FPATH"),"\",1,($L(Y("FPATH"),"\")-1))
 S Y=1
 Q
REX(DA) ; Reindex the 703.1 entry
 Q:'$D(^MDD(703.1,DA,0))
 S DIK="^MDD(703.1," D IX1^DIK
 Q
UNC ;;PROCESS UNC;.301
 N CNT
 S CNT=0
 F  S CNT=$O(^TMP($J,"MDHL7A",CNT)) Q:CNT<1  D
 . N LINE,PATH,DA,DIK
 . S LINE=^TMP($J,"MDHL7A",CNT) Q:LINE=""
 . I $P(LINE,"|",1)'="OBX" Q
 . D PATHCHK(LINE,.PATH)
 . Q:'PATH
 . S MDDZ=$$UPDATE^MDHL7U(MDIEN) ; Create the entry in the multi.
 . Q:'MDDZ
 . S ^MDD(703.1,MDIEN,.1,MDDZ,0)=$P(MDATT(PROC),";",6)
 . S ^MDD(703.1,MDIEN,.1,MDDZ,.1)=PATH("FPATH")
 . Q
 Q
URL ;;PROCESS URL;.303
 N CNT
 S CNT=0
 F  S CNT=$O(^TMP($J,"MDHL7A",CNT)) Q:CNT<1  D
 . N LINE,PATH
 . S LINE=^TMP($J,"MDHL7A",CNT) Q:LINE=""
 . I $P(LINE,"|",1)'="OBX" Q
 . D PATHCHK(LINE,.PATH)
 . I PATH S MDDZ=$$UPDATE^MDHL7U(MDIEN) ; Create the entry in the multi.
 . Q:'MDDZ
 . S ^MDD(703.1,MDIEN,.1,MDDZ,0)=$P(MDATT(PROC),";",6)
 . S ^MDD(703.1,MDIEN,.1,MDDZ,.1)=PATH("FPATH")
 . Q
 Q
DDL ;;PROCESS DLL;.304
 N CNT
 S CNT=0
 F  S CNT=$O(^TMP($J,"MDHL7A",CNT)) Q:CNT<1  D
 . N LINE,PATH
 . S LINE=^TMP($J,"MDHL7A",CNT) Q:LINE=""
 . I $P(LINE,"|",1)'="OBX" Q
 . D PATHCHK(LINE,.PATH)
 . I PATH S MDDZ=$$UPDATE^MDHL7U(MDIEN) ; Create the entry in the multi.
 . Q:'MDDZ
 . S ^MDD(703.1,MDIEN,.1,MDDZ,0)=$P(MDATT(PROC),";",6)
 . S ^MDD(703.1,MDIEN,.1,MDDZ,.1)=PATH("FPATH")
 . Q
 Q
UUEN ;;PROCESS UUENCODE;.305
 N CNT,CNT2,MDDZ
 S (CNT,CNT2)=0
 S MDDZ=$$UPDATE^MDHL7U(MDIEN) ; Create the entry in the multi.
 Q:'MDDZ
 S ^MDD(703.1,MDIEN,.1,MDDZ,0)=$P(MDATT(PROC),";",6)
 S ^MDD(703.1,MDIEN,.1,MDDZ,.1)=$G(FTYPE,"")
 F  S CNT=$O(^TMP($J,"MDHL7","UUENCODE",CNT)) Q:CNT<1  D
 . N LINE
 . S LINE=^TMP($J,"MDHL7","UUENCODE",CNT)
 . S ^MDD(703.1,MDIEN,.1,MDDZ,.2,CNT,0)=LINE
 . S CNT2=CNT
 . Q
 D NOW^%DTC
 S ^MDD(703.1,MDIEN,.1,MDDZ,.2,0)="^^"_CNT2_"^"_CNT2_"^"_$P(%,".")_"^"
 Q
XML ;;PROCESS XML;.306
 N CNT
 S CNT=0
 F  S CNT=$O(^TMP($J,"MDHL7A",CNT)) Q:CNT<1  D
 . N LINE,PATH
 . S LINE=^TMP($J,"MDHL7A",CNT) Q:LINE=""
 . I $P(LINE,"|",1)'="OBX" Q
 . D PATHCHK(LINE,.PATH)
 . I PATH S MDDZ=$$UPDATE^MDHL7U(MDIEN) ; Create the entry in the multi.
 . Q:'MDDZ
 . S ^MDD(703.1,MDIEN,.1,MDDZ,0)=$P(MDATT(PROC),";",6)
 . S ^MDD(703.1,MDIEN,.1,MDDZ,.1)=PATH("FPATH")
 . Q
 Q
XMS ;;PROCESS XMS;.307
 N CNT
 S CNT=0
 F  S CNT=$O(^TMP($J,"MDHL7A",CNT)) Q:CNT<1  D
 . N LINE,PATH
 . S LINE=^TMP($J,"MDHL7A",CNT) Q:LINE=""
 . I $P(LINE,"|",1)'="OBX" Q
 . D PATHCHK(LINE,.PATH)
 . I PATH S MDDZ=$$UPDATE^MDHL7U(MDIEN) ; Create the entry in the multi.
 . Q:'MDDZ
 . S ^MDD(703.1,MDIEN,.1,MDDZ,0)=$P(MDATT(PROC),";",6)
 . S ^MDD(703.1,MDIEN,.1,MDDZ,.1)=PATH("FPATH")
 . Q
 Q
