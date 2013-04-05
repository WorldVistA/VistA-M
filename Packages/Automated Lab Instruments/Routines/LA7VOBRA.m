LA7VOBRA ;DALOI/JMC - LAB OBR segment builder (cont'd) ;03/22/10  17:45
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,64,68,74**;Sep 27, 1994;Build 229
 ;
 ; This routine is an extension of LA7VOBR and should only be called from that routine.
 ;
 ; ZEXCEPT is used to identify variables which are external to a specific TAG
 ;         used in conjunction with Eclipse M-editor.
 Q
 ;
 ;
OBR2 ; Build OBR-2 sequence - placer's specimen id
 ;
 ;ZEXCEPT: LA7ECH,LA7FS,LA7ID,LA7X,LA7Y
 ;
 S LA7ID=$$CHKDATA^LA7VHLU3(LA7ID,LA7FS_LA7ECH)
 S $P(LA7Y,$E(LA7ECH,1),1)=LA7ID
 I $G(LA7ID("NMSP"))'="" S $P(LA7Y,$E(LA7ECH,1),2)=LA7ID("NMSP")
 I $G(LA7ID("SITE"))'="" D
 . S LA7X=$$FACDNS^LA7VHLU2(LA7ID("SITE"),LA7FS,LA7ECH,1)
 . S $P(LA7Y,$E(LA7ECH),3)=$P(LA7X,$E(LA7ECH),2)
 . S $P(LA7Y,$E(LA7ECH),4)=$P(LA7X,$E(LA7ECH),3)
 Q
 ;
 ;
OBR3 ; Build OBR-3 sequence - filler's specimen id
 ;
 ;ZEXCEPT: LA7ECH,LA7FS,LA7ID,LA7X,LA7Y
 ;
 S LA7ID=$$CHKDATA^LA7VHLU3(LA7ID,LA7FS_LA7ECH)
 S $P(LA7Y,$E(LA7ECH,1),1)=LA7ID
 I $G(LA7ID("NMSP"))'="" S $P(LA7Y,$E(LA7ECH,1),2)=LA7ID("NMSP")
 I $G(LA7ID("SITE"))'="" D
 . S LA7X=$$FACDNS^LA7VHLU2(LA7ID("SITE"),LA7FS,LA7ECH,1)
 . S $P(LA7Y,$E(LA7ECH),3)=$P(LA7X,$E(LA7ECH),2)
 . S $P(LA7Y,$E(LA7ECH),4)=$P(LA7X,$E(LA7ECH),3)
 Q
 ;
 ;
OBR4 ; Build OBR-4 sequence - Universal service ID
 ;
 ;ZEXCEPT: LA760,LA764,LA7ALT,LA7COMP,LA7ECH,LA7FS,LA7NLT,LA7TN,LA7Y,LA7Z
 ;
 ;
 S LA764=0,LA7Y=""
 ; specify component position - primary/alternate
 S LA7COMP=0
 ;
 ; Send non-VA test codes as first coding system
 I LA7ALT'="" D
 . N I
 . F I=1:1:3 S $P(LA7Y,$E(LA7ECH),LA7COMP+I)=$$CHKDATA^LA7VHLU3($P(LA7ALT,"^",I),LA7FS_LA7ECH)
 . S LA7COMP=LA7COMP+I
 ;
 ; Send NLT test codes as primary unless non-VA codes then send as alternate code
 I LA7NLT'="" D
 . S LA764=$O(^LAM("E",LA7NLT,0)),LA7Z=""
 . I LA764 S LA7Z=$$GET1^DIQ(64,LA764_",",.01,"I")
 . I LA7Z="" D
 . . N LA7642
 . . S LA764=$O(^LAM("E",$P(LA7NLT,".")_".0000",0))
 . . I LA764 S LA7Z=$$GET1^DIQ(64,LA764_",",.01,"I")
 . . S LA7642=$O(^LAB(64.2,"F","."_$P(LA7NLT,".",2),0))
 . . I LA764,LA7642 S LA7Z=LA7Z_"~"_$$GET1^DIQ(64.2,LA7642_",",.01,"I")
 . S $P(LA7Y,$E(LA7ECH),LA7COMP+1)=$$CHKDATA^LA7VHLU3(LA7NLT,LA7FS_LA7ECH)
 . S $P(LA7Y,$E(LA7ECH),LA7COMP+2)=$$CHKDATA^LA7VHLU3(LA7Z,LA7FS_LA7ECH)
 . S $P(LA7Y,$E(LA7ECH),LA7COMP+3)="99VA64"
 . S LA7COMP=LA7COMP+3
 ;
 ; Send file #60 test name if available and no alternate
 I LA7COMP<4,LA760 D
 . S LA7TN=$$GET1^DIQ(60,LA760_",",.01)
 . S $P(LA7Y,$E(LA7ECH),LA7COMP+1)=LA760
 . S $P(LA7Y,$E(LA7ECH),LA7COMP+2)=$$CHKDATA^LA7VHLU3(LA7TN,LA7FS_LA7ECH)
 . S $P(LA7Y,$E(LA7ECH),LA7COMP+3)="99VA60"
 ;
 Q
 ;
 ;
OBR9 ; Build OBR-9 sequence - collection volume
 ;
 ;ZEXCEPT: LA764061,LA7ECH,LA7FS,LA7IENS,LA7VOL,LA7X,LA7Y
 ;
 ; Collection volume
 S $P(LA7Y,$E(LA7ECH,1))=LA7VOL
 ;
 I LA764061 D
 . S LA7IENS=LA764061_","
 . D GETS^DIQ(64.061,LA7IENS,".01;1","E","LA7Y")
 . ; Collection Volume units code
 . S $P(LA7X,$E(LA7ECH,4),1)=$G(LA7Y(64.061,LA7IENS,.01,"E"))
 . ; Collection Volume units text
 . S $P(LA7X,$E(LA7ECH,4),2)=$$CHKDATA^LA7VHLU3($G(LA7Y(64.061,LA7IENS,1,"E")),LA7FS_LA7ECH)
 . ; LOINC coding system
 . S $P(LA7X,$E(LA7ECH,4),3)="LN"
 . S $P(LA7Y,$E(LA7ECH,1),2)=LA7X
 ;
 Q
 ;
 ;
OBR24 ; Build OBR-24 sequence - diagnostic service id
 ;
 ;ZEXCEPT: LA7SS,LA7X,LA7Y
 ;
 ; Code non-MI subscripts
 I $P(LA7SS,"^")'="MI" D  Q
 . S LA7X=$P(LA7SS,"^")
 . S LA7Y=$S(LA7X="CH":"CH",LA7X="SP":"SP",LA7X="CY":"CP",LA7X="EM":"PAT",LA7X="AU":"PAT",LA7X="BB":"BLB",1:"LAB")
 ;
 ; Code MI subscripts
 S LA7X=$P(LA7SS,"^",2)
 S LA7Y=$S(LA7X=11:"MB",LA7X=14:"PAR",LA7X=18:"MYC",LA7X=22:"MCB",LA7X=33:"VR",1:"MB")
 ;
 Q
 ;
 ;
OBR25 ; Build OBR-25 sequence - Result status
 ;
 ;ZEXCEPT: LA7FLAG,LA7Y
 ;
 S LA7Y=""
 ;
 I LA7FLAG="F" S LA7Y="F"
 I LA7FLAG="P" S LA7Y="P"
 I LA7FLAG="A" S LA7Y="A"
 I LA7FLAG="C" S LA7Y="C"
 I LA7FLAG?1.N S LA7Y=$$GET1^DIQ(64.061,LA7FLAG_",",2)
 ;
 Q
 ;
 ;
OBR26 ; Build OBR-26 sequence - Parent result
 ;
 ;ZEXCEPT: LA7C,LA7ECH,LA7OBX3,LA7OBX4,LA7OBX5,LA7SC,LA7Y
 ;
 S LA7Y=""
 ;
 ; Move component into sub-component position
 ; Translate component character to sub-component character
 S LA7C=$E(LA7ECH,1),LA7SC=$E(LA7ECH,4)
 ;
 ; Parent result observation identifier in 1st component
 I LA7OBX3'="" S $P(LA7Y,$E(LA7ECH,1),1)=$TR(LA7OBX3,LA7C,LA7SC)
 ;
 ; Parent sub-id in 2nd component
 I LA7OBX4'="" S $P(LA7Y,$E(LA7ECH,1),2)=$TR(LA7OBX4,LA7C,LA7SC)
 ;
 ; Parent test result in 3rd component
 I LA7OBX5'="" S $P(LA7Y,$E(LA7ECH,1),3)=$TR(LA7OBX5,LA7C,LA7SC)
 ;
 Q
 ;
 ;
OBR29 ; Build OBR-29 sequence - Parent
 ;
 ;ZEXCEPT: LA7ECH,LA7FON,LA7FS,LA7PON,LA7Y,LA7Z
 ;
 S LA7Y=""
 ;
 I $G(LA7PON)'="" D
 . S LA7Z=$$CHKDATA^LA7VHLU3(LA7PON,LA7FS_LA7ECH)
 . S $P(LA7Y,$E(LA7ECH,1),1)=LA7Z
 ;
 I $G(LA7FON)'="" D
 . S LA7Z=$$CHKDATA^LA7VHLU3(LA7FON,LA7FS_LA7ECH)
 . S $P(LA7Y,$E(LA7ECH,1),2)=LA7Z
 ;
 Q
 ;
 ;
OBRPF ; Build OBR-18,19,20,21 Placer/Filler #1/#2
 ;
 ;ZEXCEPT: LA7ECH,LA7FS,LA7I,LA7X,LA7Y,LA7Z
 ;
 S (LA7Y,LA7Z)="",LA7I=0
 F  S LA7I=$O(LA7X(LA7I)) Q:'LA7I  S $P(LA7Z,"^",LA7I)=LA7X(LA7I)
 S LA7Y=$$CHKDATA^LA7VHLU3(LA7Z,LA7FS_LA7ECH)
 Q
 ;
 ;
OBR32 ; Build OBR-32 sequence - Principle Result Interpreter field
 ;
 ;ZEXCEPT: LA7DIV,LA7DUZ,LA7ECH,LA7FS,LA7INTYP,LA7PRI,LA7X
 ;
 S LA7X=$$XCN^LA7VHLU9(LA7DUZ,LA7DIV,LA7FS,LA7ECH,1,2)
 I $G(LA7INTYP)=30 S $P(LA7PRI,$E(LA7ECH))=$P(LA7X,$E(LA7ECH,4),1,9)
 E  S $P(LA7PRI,$E(LA7ECH))=LA7X
 I LA7DIV S $P(LA7PRI,$E(LA7ECH),7)=$$FACDNS^LA7VHLU2(LA7DIV,LA7FS,LA7ECH,2)
 Q
 ;
 ;
OBR33 ; Build OBR-32 sequence - Assistant Result Interpreter field
 ;
 ;ZEXCEPT: LA7ARI,LA7DIV,LA7DUZ,LA7ECH,LA7FS,LA7INTYP,LA7X
 ;
 ;
 S LA7X=$$XCN^LA7VHLU9(LA7DUZ,LA7DIV,LA7FS,LA7ECH,1,2)
 I $G(LA7INTYP)=30 S $P(LA7ARI,$E(LA7ECH))=$P(LA7X,$E(LA7ECH,4),1,9)
 E  S $P(LA7ARI,$E(LA7ECH))=LA7X
 I LA7DIV S $P(LA7ARI,$E(LA7ECH),7)=$$FACDNS^LA7VHLU2(LA7DIV,LA7FS,LA7ECH,2)
 Q
 ;
 ;
OBR34 ; Build OBR-34 sequence - Technician field
 ;
 ;ZEXCEPT: LA7DIV,LA7DUZ,LA7ECH,LA7FS,LA7INTYP,LA7TECH,LA7X
 ;
 ;
 S LA7X=$$XCN^LA7VHLU9(LA7DUZ,LA7DIV,LA7FS,LA7ECH,1,1)
 I $G(LA7INTYP)=30 S $P(LA7TECH,$E(LA7ECH))=$P(LA7X,$E(LA7ECH,4),1,9)
 E  S $P(LA7TECH,$E(LA7ECH))=LA7X
 I LA7DIV S $P(LA7TECH,$E(LA7ECH),7)=$$FACDNS^LA7VHLU2(LA7DIV,LA7FS,LA7ECH,2)
 Q
 ;
 ;
OBR35 ; Build OBR-35 sequence - Transcriptionist field
 ;
 ;ZEXCEPT: LA7DIV,LA7DUZ,LA7ECH,LA7FS,LA7INTYP,LA7TSPT,LA7X
 ;
 S LA7X=$$XCN^LA7VHLU9(LA7DUZ,LA7DIV,LA7FS,LA7ECH,1,1)
 I $G(LA7INTYP)=30 S $P(LA7TSPT,$E(LA7ECH))=$P(LA7X,$E(LA7ECH,4),1,9)
 E  S $P(LA7TSPT,$E(LA7ECH))=LA7X
 I LA7DIV S $P(LA7TSPT,$E(LA7ECH),7)=$$FACDNS^LA7VHLU2(LA7DIV,LA7FS,LA7ECH,2)
 Q
 ;
 ;
OBR44 ; Build OBR-44
 ;
 ;ZEXCEPT: LA764,LA781,LA7ECH,LA7FS,LA7VAL,LA7X,LA7Y
 ;
 ;
 S (LA7X,LA7Y,LA7Z)=""
 ;
 I LA7VAL="" Q
 ;
 ; Send NLT result code
 S LA764=$O(^LAM("E",LA7VAL,0))
 I LA764 S LA7X=$P($G(^LAM(LA764,0)),"^")
 ;
 ; If suffixed and not defined then build from primary and suffix code.
 I LA7X="" D
 . N LA7642
 . S LA764=$O(^LAM("E",$P(LA7VAL,".")_".0000",0))
 . I LA764 S LA7X=$$GET1^DIQ(64,LA764_",",.01,"I")
 . S LA7642=$O(^LAB(64.2,"F","."_$P(LA7VAL,".",2),0))
 . I LA764,LA7642 S LA7X=LA7X_"~"_$$GET1^DIQ(64.2,LA7642_",",.01,"I")
 ;
 I LA7X'="" S LA7X=$$CHKDATA^LA7VHLU3(LA7X,LA7FS_LA7ECH)
 S $P(LA7Z,$E(LA7ECH,1),1)=LA7VAL
 S $P(LA7Z,$E(LA7ECH,1),2)=LA7X
 S $P(LA7Z,$E(LA7ECH,1),3)="99VA64"
 ;S LA7X=$$GET1^DID(64,"","","PACKAGE REVISION DATA")
 ;S $P(LA7Z,$E(LA7ECH,1),7)=LA7X
 S LA7Y=LA7Z
 ;
 ; Check for and build CPT code in primary, move NLT to alternate
 I LA764="" Q
 I '$D(^LAM("AD",LA764,"CPT")) Q
 S LA7X=$O(^LAM("AD",LA764,"CPT",0)),LA781=""
 I LA7X>0 S LA781=+$P($G(^LAM(LA764,4,LA7X,0)),"^")
 I LA781>0 D
 . S LA7X=$$CPT^ICPTCOD(LA781,DT,1)
 . I LA7X<1 Q
 . S LA7Z=$P(LA7X,"^",2)
 . S $P(LA7Z,$E(LA7ECH,1),2)=$$CHKDATA^LA7VHLU3($P(LA7X,"^",3),LA7FS_LA7ECH)
 . S $P(LA7Z,$E(LA7ECH,1),3)=$S($P(LA7X,"^",5)="C":"C4",$P(LA7X,"^",5)="HCPCS":"HCPCS",1:"L")
 . S LA7Y=LA7Z_$E(LA7ECH,1)_$P(LA7Y,$E(LA7ECH,1),1,3)
 ;. S $P(LA7Y,$E(LA7ECH,1),8)=$P(LA7Y,$E(LA7ECH,1),7)
 ;. S $P(LA7Y,$E(LA7ECH,1),7)=$P(LA7X,"^",6)
 ;
 Q
