MCAR7H ; HIRMFO/REL-DelMar Holter ;3/3/00  09:56
 ;;2.3;Medicine;**24**;09/13/1996
OBX ; Process OBX
 S X=$G(MSG(NUM)) I $E(X,1,3)'="OBX" S ERRTX="OBX not found when expected" G ^MCAR7X
 S SEG("OBX")=X
 S FIL=691.6 D PROC^MCAR7A ; Set Procedure entry
 S LN=0,^MCAR(691.6,DA,7,0)="^^0^0^"_DT_"^"
NEXT S X=$P(MSG(NUM),"|",6),X=$P(X,"^",1) I X'="" S LN=LN+1,^MCAR(691.6,DA,7,LN,0)=" "_X
 S NUM=NUM+1 I $E($G(MSG(NUM)),1,3)="OBX" G NEXT
 S $P(^MCAR(691.6,DA,7,0),"^",3,4)=(LN_"^"_LN)
 ; Re-index record
 S DIK="^MCAR(691.6," D IX1^DIK
 D GENACK^MCAR7X
 Q
