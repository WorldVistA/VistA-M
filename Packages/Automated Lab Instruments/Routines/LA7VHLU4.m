LA7VHLU4 ;DALOI/JMC - HL7 segment builder utility ;03/15/11  12:28
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,64,68,74**;Sep 27, 1994;Build 229
 ;
 ;
INST(LA74,LA7FS,LA7ECH) ; Build institution field
 ; Call with   LA74 = ien of institution in file #4
 ;                    if null/undefined then use Kernel Site file.
 ;            LA7FS = HL field separator
 ;           LA7ECH = HL encoding characters
 ;
 ; Returns facility that performed the testing (ID^text^99VA4)
 ;
 N LA7NVAF,LA7X,LA7Y,LA7Z
 ;
 S LA74=$G(LA74),LA7ECH=$G(LA7ECH),LA7Y=""
 ;
 ; If no institution, use Kernel Site default
 I LA74="" S LA74=+$$KSP^XUPARAM("INST")
 ;
 ; Check if this field has been built previously for this institution
 I LA74'="",$D(^TMP($J,"LA7VHLU","99VA4",LA74,LA7FS_LA7ECH)) S LA7Y=^TMP($J,"LA7VHLU","99VA4",LA74,LA7FS_LA7ECH)
 ;
 ; Value passed not a pointer - only build 2nd component
 I LA7Y="",LA74'="",LA74'=+LA74 D
 . S $P(LA7Y,$E(LA7ECH,1),2)=$$CHKDATA^LA7VHLU3(LA74,LA7FS_LA7ECH)
 ;
 I LA7Y="",LA74>0,LA74=+LA74 D
 . S LA7NVAF=$$NVAF^LA7VHLU2(LA74)
 . ; Build id - VA station #/DMIS code/IHS ASUFAC
 . I LA7NVAF<3 S LA7Y=$$ID^XUAF4($S(LA7NVAF=1:"DMIS",LA7NVAF=2:"ASUFAC",1:"VASTANUM"),LA74)
 . ; Build name using field #100, otherwise #.01
 . S LA7Z=$$NAME^XUAF4(LA74)
 . S $P(LA7Y,$E(LA7ECH,1),2)=$$CHKDATA^LA7VHLU3(LA7Z,LA7FS_LA7ECH)
 . ;
 . S $P(LA7Y,$E(LA7ECH,1),3)="99VA4"
 ;
 ; Save this field to TMP global to use for subsequent calls.
 S ^TMP($J,"LA7VHLU","99VA4",LA74,LA7FS_LA7ECH)=LA7Y
 ;
 Q LA7Y
 ;
 ;
XAD(LA7FN,LA7DA,LA7DT,LA7FS,LA7ECH) ; Build extended address
 ; Call with LA7FN = Source File number
 ;                   Presently file #2 (PATIENT), #4 (INSTITUTION) or #200 (NEW PERSON)
 ;           LA7DA = Entry in source file
 ;           LA7DT = As of date in FileMan format
 ;           LA7FS = HL field separator
 ;          LA7ECH = HL encoding characters
 ;
 ; Returns extended address
 ;
 N I,LA7X,LA7Y,LA7Z
 S LA7Y=""
 ; Check if this field has been built previously for this institution
 I LA7FN,LA7DA,$D(^TMP($J,"LA7VHLU","99VA4A",LA7FN,LA7DA,LA7FS_LA7ECH)) S LA7Y=^TMP($J,"LA7VHLU","99VA4A",LA7FN,LA7DA,LA7FS_LA7ECH)
 ;
 ; Build from file #2
 I LA7Y="",LA7FN=2,LA7DA D
 . N DFN,VAHOW,VAPA,VAERR,VAROOT,VATEST
 . S DFN=LA7DA
 . I LA7DT S (VATEST("ADD",9),VATEST("ADD",10))=LA7DT
 . D ADD^VADPT
 . I VAERR Q
 . S $P(LA7Y,$E(LA7ECH),1)=$$CHKDATA^LA7VHLU3(VAPA(1),LA7FS_LA7ECH)
 . S $P(LA7Y,$E(LA7ECH),2)=$$CHKDATA^LA7VHLU3(VAPA(2),LA7FS_LA7ECH)
 . S $P(LA7Y,$E(LA7ECH),3)=$$CHKDATA^LA7VHLU3(VAPA(4),LA7FS_LA7ECH)
 . S $P(LA7Y,$E(LA7ECH),4)=$$CHKDATA^LA7VHLU3($P(VAPA(5),"^",2),LA7FS_LA7ECH)
 . S $P(LA7Y,$E(LA7ECH),5)=$$CHKDATA^LA7VHLU3(VAPA(11),LA7FS_LA7ECH)
 . I VAPA(9) S $P(LA7Y,$E(LA7ECH),7)="C"
 . E  S $P(LA7Y,$E(LA7ECH),7)="P"
 . S $P(LA7Y,$E(LA7ECH),9)=$$CHKDATA^LA7VHLU3($P(VAPA(7),"^",2),LA7FS_LA7ECH)
 ;
 ; Get address info from file #4, add 2nd address line
 ;  change state to pointer to file #5
 I LA7Y="",LA7FN=4,LA7DA D
 . S LA7Z=$$PADD^XUAF4(LA7DA)
 . S LA7X=$P(LA7Z,"^"),$P(LA7X,"^",2)=$$WHAT^XUAF4(LA7DA,1.02)
 . F I=1,2 I $P(LA7X,"^",I)'="" S $P(LA7X,"^",I)=$$CHKDATA^LA7VHLU3($P(LA7X,"^",I),LA7FS_LA7ECH)
 . S LA7Z=$P(LA7Z,"^",2,4),$P(LA7Z,"^",2)=$$GET1^DIQ(4,LA7DA_",",.02,"I")
 . S $P(LA7Z,"^")=$$CHKDATA^LA7VHLU3($P(LA7Z,"^"),LA7FS_LA7ECH)
 . S LA7Y=$$HLADDR^HLFNC(LA7X,LA7Z,LA7ECH)
 ;
 I LA7Y="",LA7FN=200,LA7DA D
 . Q
 ;
 ; Save this field to TMP global to use for subsequent calls.
 I LA7Y'="" S ^TMP($J,"LA7VHLU","99VA4A",LA7FN,LA7DA,LA7FS_LA7ECH)=LA7Y
 ;
 Q LA7Y
 ;
 ;
XON(LA7FN,LA7DA,LA7TYP,LA7FS,LA7ECH) ; Build extended composite name/id for organization
 ; Call with LA7FN = Source File number - presently #4 (INSTITUTION)
 ;           LA7DA = Entry in source file
 ;          LA7TYP = type of identifier (0/null=station #, 1=CLIA)
 ;           LA7FS = HL field separator
 ;          LA7ECH = HL encoding characters
 ;
 ;
 N LA7X,LA7Y,LA7Z
 ;
 S LA7Y="",LA7TYP=+$G(LA7TYP)
 ;
 ; Check if this field has been built previously for this institution
 I LA7FN,LA7DA,$D(^TMP($J,"LA7VHLU","99VA4N",LA7FN,LA7DA,LA7TYP,LA7FS_LA7ECH)) S LA7Y=^TMP($J,"LA7VHLU","99VA4N",LA7FN,LA7DA,LA7TYP,LA7FS_LA7ECH)
 ;
 ; Build name using field #100, otherwise #.01
 ; Send facility id in 3rd component if numeric - conform to standard.
 I LA7Y="",LA7FN=4,LA7DA D
 . S LA7Z(1)=$P($$NS^XUAF4(LA7DA),"^"),LA7Z(2)=$$WHAT^XUAF4(LA7DA,100)
 . S $P(LA7Y,$E(LA7ECH,1),1)=$$CHKDATA^LA7VHLU3(LA7Z(1),LA7FS_LA7ECH)
 . S $P(LA7Y,$E(LA7ECH,1),2)="D"
 . S LA7X=$$RETFACID^LA7VHLU2(LA7DA,2,1)
 . I LA7X'="" D
 . . I LA7X?1.N S $P(LA7Y,$E(LA7ECH,1),3)=LA7X
 . . S $P(LA7Y,$E(LA7ECH,1),10)=LA7X
 . S $P(LA7Y,$E(LA7ECH,1),6)="USVHA"
 . S $P(LA7Y,$E(LA7ECH,1),7)="FI"
 . S $P(LA7Y,$E(LA7ECH,1),9)="A"
 . I LA7Z(2)'="" D
 . . S $P(LA7Y,$E(LA7ECH,1),1)=$$CHKDATA^LA7VHLU3(LA7Z(2),LA7FS_LA7ECH)
 . . S $P(LA7Y,$E(LA7ECH,1),2)="L"
 . I LA7TYP=1 D
 . . S LA7X=$$ID^XUAF4("CLIA",LA7DA) Q:LA7X=""
 . . S $P(LA7Y,$E(LA7ECH,1),3)=""
 . . S $P(LA7Y,$E(LA7ECH,1),6)="CLIA"
 . . S $P(LA7Y,$E(LA7ECH,1),7)="LN"
 . . S $P(LA7Y,$E(LA7ECH,1),10)=LA7X
 ;
 ; Save this field to TMP global to use for subsequent calls.
 I LA7Y'="" S ^TMP($J,"LA7VHLU","99VA4N",LA7FN,LA7DA,LA7TYP,LA7FS_LA7ECH)=LA7Y
 ;
 Q LA7Y
 ;
 ;
XCNTFM(LA7X,LA7ECH) ; Resolve XCN data type to FileMan (last name, first name, mi [id])
 ; Call with LA7X = HL7 field containing name
 ;         LA7ECH = HL7 encoding characters
 ;
 ; Returns   LA7Y = ID code^DUZ^FileMan name (DUZ=0 if name not found on local system).
 ; Stub until all calls can be converted to call XCNTFM^LA7VHLU9
 ;
 Q $$XCNTFM^LA7VHLU9(LA7X,LA7ECH)
 ;
 ;
PLTFM(LA7PL,LA7FS,LA7ECH) ; Resolve location from PL (person location) data type.
 ; Call with LA7PL = HL7 field containing person location
 ;           LA7FS = HL field separator
 ;          LA7ECH = HL7 encoding characters
 ;
 ; Returns    LA7Y = file #44 ien^name field (#.01)^division(institution)
 ;
 N LA7X,LA7Y,X,Y
 S LA7X=$P(LA7PL,$E(LA7ECH)),(LA7Y,Y)=""
 I LA7X?1.N S Y=$$GET1^DIQ(44,LA7X_",",.01)
 ;
 ; Check and unescape if needed
 S LA7X=$$UNESC^LA7VHLU3(LA7X,LA7FS_LA7ECH)
 ;
 ; If not ien try as name
 I Y="" D
 . S X=$$FIND1^DIC(44,"","X",LA7X,"B^C")
 . I X S Y=LA7X,LA7X=X
 I Y'="" S LA7Y=LA7X_"^"_Y
 E  I $P(LA7PL,$E(LA7ECH),2)'="" S LA7Y="^"_$$UNESC^LA7VHLU3($P(LA7PL,$E(LA7ECH),2),LA7FS_LA7ECH)
 ;
 ; Process division (institution) - pass 1st sub-component of 4th component
 S LA7X=$P(LA7PL,$E(LA7ECH),4)
 S LA7X=$P(LA7X,$E(LA7ECH,4))
 S LA7X=$$UNESC^LA7VHLU3(LA7X,LA7FS_LA7ECH)
 S Y=""
 I LA7X'="" S Y=$$FINDSITE^LA7VHLU2(LA7X,1,1)
 S $P(LA7Y,"^",3)=Y
 ;
 Q LA7Y
