MCAR7E ; HIRMFO/REL-Olympus/CMore Endoscopy ;7/24/00  11:16
 ;;2.3;Medicine;**24**;09/13/1996
OBX ; Process OBX
 S X=$G(MSG(NUM)) I $E(X,1,3)'="OBX" S ERRTX="OBX not found when expected" G ^MCAR7X
 S SEG("OBX")=X
UPDATE ; Update File
 S FIL=699 D PROC^MCAR7A ; Set Procedure entry
 ; Process Note
 S LN=0,J=0,^MCAR(699,DA,33,0)="^^0^0^"_DT_"^"
 I MCAPP="OLYMPUS" S SEP="^" G OLY
 I MCAPP="PENTAX" S SEP="^" G PEN
 I MCAPP="CMore"  S SEP="~"
CMO ; Process CMore
 S LINE=$P(MSG(NUM),"|",6)
U1 I LINE[SEP D C1 G U1
 S J=J+1 I $G(MSG(NUM,J))="" D:LINE'="" C1 G U2
 S LINE=LINE_MSG(NUM,J) S:LINE["|" LINE=$P(LINE,"|",1) G U1
C1 S LN=LN+1,%=$P(LINE,SEP,1),LINE=$P(LINE,SEP,2,999)
 S:%="" %=" " S ^MCAR(699,DA,33,LN,0)=% Q
OLY ; Process Olympus
 F  S LINE=$P($G(MSG(NUM)),"|",6) Q:LINE=""  D U3 S NUM=NUM+1
 G U2
PEN ; Process Pentax data
 N LN
 S LN=0
 F  S LINE=$P($G(MSG(NUM)),"|",6) Q:'$D(MSG(NUM))  D  S NUM=NUM+1
 .S LN=LN+1
 .S ^MCAR(699,DA,33,LN,0)=LINE
 .Q
 G U2
U2 S $P(^MCAR(699,DA,33,0),"^",3,4)=(LN_"^"_LN)
 S:EXAM="" EXAM="Endoscopy" S PIEN=$O(^MCAR(697.2,"B",EXAM,0))
 I PIEN="" S:EXAM2'="" PIEN=$O(^MCAR(697.2,"B",EXAM2,0))
 I PIEN="" D
 .K DIC S (DIC,DLAYGO)=697.2,DIC(0)="L",X=$C(34)_EXAM_$C(34)
 .S DIC("DR")="1///MCAR(699;1.1///.02;3///G;4///ENDO;5///MCARGP;6///GI;7///"_EXAM_";11///1;12///MCKEYGI;13///1;15///1;1001///P"
 .D ^DIC S PIEN=+Y K DIC,DLAYGO Q
 S $P(^MCAR(699,DA,0),"^",12)=PIEN
 ; Re-index record
 S DIK="^MCAR(699," D IX1^DIK
 D GENACK^MCAR7X
 Q
U3 ; Add a line
 S J=0 D NJ
U4 S %=$L(LINE)+1 I %<80 G:NEXT="" ST D  G U4
 .S LINE=LINE_$E(NEXT,1,125),NEXT=$E(NEXT,126,999) D:NEXT="" NJ
 .Q
 F %=79:-1:1 Q:$E(LINE,%)=" "
 D ST G U4
NJ S J=J+1,NEXT=$P($G(MSG(NUM,J)),"|",1) Q
ST S LN=LN+1,^MCAR(699,DA,33,LN,0)=$E(LINE,1,%-1),LINE=$E(LINE,%+1,999) Q
