MDHL7U ; HOIFO/WAA -Routine utilities for CP ;7/23/01  11:41
 ;;1.0;CLINICAL PROCEDURES;;Apr 01, 2004
 ;
UPDATE(MDIEN) ; Update File
 N DZ
 S DZ=0
UPD1 L +^MDD(703.1,MDIEN,.1,0):1 G:'$T UPD1
 S DZ=$P(^MDD(703.1,MDIEN,.1,0),"^",3)+1
 S $P(^MDD(703.1,MDIEN,.1,0),"^",3,4)=DZ_"^"_DZ
 L -^MDD(703.1,MDIEN,.1,0)
 Q DZ
 ;
ATT(DEV,ARRAY) ; Get the attributes of a device and pass them back in an
 ; array.
 N X
 S ARRAY=0
 I $G(^MDS(702.09,DEV,0))="" D
 . S X=0
 . S X=$O(^MDS(702.09,"B",DEV,X))
 . Q
 E  S X=DEV
 I X>0 D
 . N LINE,I,Z
 . S LINE=$G(^MDS(702.09,X,.3)) Q:LINE=""
 . S Z=""
 . F I=1:1:($L(LINE,U)) S Z=$P(LINE,U,I) I Z=1 D
 . . N TEXT
 . . S TEXT=$T(ATABLE+I)
 . . S ARRAY(I)=TEXT,ARRAY=ARRAY+1
 . . Q
 . Q
 Q
PROC ; Create report entry in file (703.1)
 N DA,DIK
 I DTO=""!(DFN="") Q
 S DA=0 F  S DA=$O(^MDD(703.1,"B",UNIQ,DA)) Q:'DA  I $P($G(^MDD(703.1,DA,0)),"^",5)=DFN Q
 Q:DA
P1 L +^MDD(703.1,0):0 G:'$T P1 D
 .S DA=$P(^MDD(703.1,0),"^",3)+1
 .S $P(^MDD(703.1,0),"^",3,4)=DA_"^"_DA
 .L -^MDD(703.1,0)
 .Q
 I $D(^MDD(703.1,DA)) G P1
 S ^MDD(703.1,DA,0)=UNIQ_"^"_DFN_"^"_$$HL7TFM(DATE)_"^"_INST_"^"_$G(MDD702)_"^"_HLMTIEN_"^^^P"
 S ^MDD(703.1,DA,.1,0)="^703.11S^0^0"
 S MDIEN=DA
 S DIK="^MDD(703.1," D IX1^DIK
 Q
 ;
HL7TFM(MDDATE) ; Convert an HL7 Date to FM
 N MDDT,MDYR
 S MDYR=$E(MDDATE,1,4)
 S MDYR=MDYR-1700
 S MDDT=MDYR_$E(MDDATE,5,8)
 I $L(MDDATE)>8 S MDDT=MDDT_"."_$E(MDDATE,9,14)
 Q MDDT
REINDX ; Re-index record
 S ^MDD(703.1,DA,.1,DZ,.2,0)="^^"_LN_"^"_LN_"^"_DTO
 S DIK="^MDD(703.1," D IX1^DIK
 D:ZCODE="C" GENACK^MDHL7X
 Q
ATABLE ;;This is a table of all the processing routines for devices
 ;;PROCESS UNC;.301;UNC^MDHL7U1;3;
 ;;PROCESS TEXT;.302;TEXT^MDHL7U2;2;
 ;;PROCESS URL;.303;URL^MDHL7U1;4;
 ;;PROCESS DLL;.304;DDL^MDHL7U1;6;
 ;;PROCESS UUENCODE;.305;UUEN^MDHL7U1;5;
 ;;PROCESS XML;.306;XML^MDHL7U1;7;
 ;;PROCESS XMS;.307;XMS^MDHL7U1;8;
