LA7VORC ;DALOI/JMC - LAB ORC Segment message builder ;Aug 27, 2007
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,64,68**;Sep 27, 1994;Build 56
 ;
 Q
 ;
ORC1(LA7TYP) ; Build ORC-1 sequence - Order control
 ; Call with LA7TYP = order type from table 0119
 ;
 Q LA7TYP
 ;
 ;
ORC2(LA7VAL,LA7FS,LA7ECH) ; Build ORC-2 sequence - Placer order number
 ; Call with  LA7VAL = accession number/UID
 ;            LA7VAL("NMSP") = application namespace (optional)
 ;            LA7VAL("SITE") = placer facility
 ;             LA7FS = HL field separator
 ;            LA7ECH = HL encoding characters
 ;            
 N LAXY,LA7Y
 ;
 S $P(LA7Y,$E(LA7ECH),1)=$$CHKDATA^LA7VHLU3(LA7VAL,LA7FS_LA7ECH)
 I $G(LA7VAL("NMSP"))'="" S $P(LA7Y,$E(LA7ECH),2)=LA7VAL("NMSP")
 I $G(LA7VAL("SITE"))'="" D
 . S LA7X=$$FACDNS^LA7VHLU2(LA7VAL("SITE"),LA7FS,LA7ECH,1)
 . S $P(LA7Y,$E(LA7ECH),3)=$P(LA7X,$E(LA7ECH),2)
 . S $P(LA7Y,$E(LA7ECH),4)=$P(LA7X,$E(LA7ECH),3)
 Q LA7Y
 ;
 ;
ORC3(LA7VAL,LA7FS,LA7ECH) ; Build ORC-3 sequence - Filler order number
 ; Call with  LA7VAL = accession number/UID
 ;            LA7VAL("NMSP") = application namespace (optional)
 ;            LA7VAL("SITE") = placer facility
 ;             LA7FS = HL field separator
 ;            LA7ECH = HL encoding characters
 ;            
 N LA7X,LA7Y
 ;
 S $P(LA7Y,$E(LA7ECH),1)=$$CHKDATA^LA7VHLU3(LA7VAL,LA7FS_LA7ECH)
 I $G(LA7VAL("NMSP"))'="" S $P(LA7Y,$E(LA7ECH),2)=LA7VAL("NMSP")
 I $G(LA7VAL("SITE"))'="" D
 . S LA7X=$$FACDNS^LA7VHLU2(LA7VAL("SITE"),LA7FS,LA7ECH,1)
 . S $P(LA7Y,$E(LA7ECH),3)=$P(LA7X,$E(LA7ECH),2)
 . S $P(LA7Y,$E(LA7ECH),4)=$P(LA7X,$E(LA7ECH),3)
 ;
 Q LA7Y
 ;
 ;
ORC4(LA7VAL,LA7FS,LA7ECH) ; Build ORC-4 sequence - Placer group number
 ; Call with  LA7VAL = LEDI - shipping manifest number
 ;             LA7FS = HL field separator
 ;            LA7ECH = HL encoding characters
 ; Returns ORD-4 sequence
 ;
 N LA7Y
 ;
 S $P(LA7Y,$E(LA7ECH),1)=$$CHKDATA^LA7VHLU3(LA7VAL,LA7FS_LA7ECH)
 ;
 Q LA7Y
 ;
 ;
ORC5(LA7VAL,LA7FS,LA7ECH) ; Build ORC-5 sequence - Order status
 ; Call with  LA7VAL = order status
 ;             LA7FS = HL field separator
 ;            LA7ECH = HL encoding characters
 ; Returns ORC-5 sequence
 ;
 N LA7Y
 ;
 I LA7VAL="CM" S LA7Y="CM"
 ;
 Q LA7Y
 ;
 ;
ORC7(LA7DUR,LA7DURU,LA76205,LA7FS,LA7ECH) ; Build ORC-7 sequence - Quantity/Timing
 ; Call with  LA7DUR = collection duration
 ;           LA7DURU = duration units (pointer to #64.061)
 ;           LA76205 = test urgency
 ;             LA7FS = HL field separator
 ;            LA7ECH = HL encoding characters
 ;
 ; Returns ORC-7 sequence
 ;
 N LA7X,LA7Y
 S LA7Y=""
 ;
 I LA7DUR'="",LA7DURU D
 . S LA7X=$$GET1^DIQ(64.061,LA7DURU_",",2) ; duration units
 . S $P(LA7Y,$E(LA7ECH,1),3)=$$CHKDATA^LA7VHLU3(LA7X_LA7DUR,LA7FS_LA7ECH)
 ;
 I LA76205 D
 . S LA7X=$$GET1^DIQ(64.061,+$$GET1^DIQ(62.05,LA76205_",",4,"I")_",",2) ; Urgency
 . S $P(LA7Y,$E(LA7ECH,1),6)=$$CHKDATA^LA7VHLU3(LA7X,LA7FS_LA7ECH)
 ;
 Q LA7Y
 ;
 ;
ORC9(LA7DT) ; Build ORC-9 sequence - date/time of transaction
 ; Call with LA7DT = order date/time
 ;
 ; Returns ORC-9 sequence
 ;
 S LA7DT=$$CHKDT^LA7VHLU1(LA7DT)
 Q $$FMTHL7^XLFDT(LA7DT)
 ;
 ;
ORC12(LA7DUZ,LA7DIV,LA7FS,LA7ECH,LA7IDTYP) ; Build ORC-12 sequence - Ordering provider
 ; Call with   LA7DUZ = DUZ of ordering provider
 ;             LA7DIV = Facility (division) of provider
 ;              LA7FS = HL field separator
 ;             LA7ECH = HL encoding characters
 ;           LA7IDTYP = id type to return (0:DUZ 1:VPID 2:NPI)
 ;           
 ; Returns ORC-12 sequence
 ; Also used to build OBR-16 sequence
 ;
 S LA7IDTYP=+$G(LA7IDTYP)
 Q $$XCN^LA7VHLU9(LA7DUZ,LA7DIV,LA7FS,LA7ECH,0,LA7IDTYP)
 ;
 ;
ORC13(LA7J,LA7FS,LA7ECH) ; Build ORC-13 sequence - Enterer's location
 ; Call with  LA7J = variable pointer to file #4 or #44
 ;           LA7FS = HL field separator
 ;          LA7ECH = HL encoding characters
 ;
 ; Returns ORC-13 sequence
 ;
 N LA74,LA744,LA7X,LA7Y,LA7Z
 ;
 S (LA74,LA744,LA7Y)=""
 ;
 ; Pointer to file #44
 I $P(LA7J,";",2)="SC(" D
 . S LA744=$P(LA7J,";")
 . S LA74=$$GET1^DIQ(44,LA744_",",3,"I")
 ;
 ; Pointer to file #4
 I $P(LA7J,";",2)="DIC(4," S LA74=$P(LA7J,";")
 ;
 ; Build 1st component (point of care), 6th component (person location type)
 I LA744 D
 . S LA7Z=$$GET1^DIQ(44,LA744_",",.01)
 . S $P(LA7Y,$E(LA7ECH,1),1)=$$CHKDATA^LA7VHLU3(LA7Z,LA7FS_LA7ECH)
 . S LA7Z=$$GET1^DIQ(44,LA744_",",2,"I")
 . S $P(LA7Y,$E(LA7ECH,1),6)=$S(LA7Z="C":"C",LA7Z="W":"N",1:"D")
 ;
 ; Build 4th component (facility), demote delimiter from component to sub-component
 I LA74 D
 . S LA7Z=$$FACDNS^LA7VHLU2(LA74,LA7FS,LA7ECH,2)
 . I $P(LA7Z,$E(LA7ECH,4),2)'="" S $P(LA7Y,$E(LA7ECH,1),4)=LA7Z Q
 . S LA7Z=$$INST^LA7VHLU4(LA74,LA7FS,LA7ECH)
 . I $P(LA7Z,$E(LA7ECH,1),3)="99VA4" S $P(LA7Z,$E(LA7ECH,1),3)="L"
 . S $P(LA7Y,$E(LA7ECH,1),4)=$TR(LA7Z,$E(LA7ECH,1),$E(LA7ECH,4))
 ;
 Q LA7Y
 ;
 ;
ORC17(LA74,LA7FS,LA7ECH) ; Build ORC-17 sequence - Entering organization
 ; Call with   LA74 = ien of institution in file #4
 ;                    if null/undefined then use Kernel Site file.
 ;            LA7FS = HL field separator
 ;           LA7ECH = HL encoding characters
 ;
 ; Returns ORC-17 sequence (ID^text^99VA4)
 ;
 Q $$INST^LA7VHLU4(LA74,LA7FS,LA7ECH)
 ;
 ;
ORC21(LA74,LA7FS,LA7ECH) ; Build ORC-21 sequence - Ordering facility name
 ; Call with   LA74 = ien of institution in file #4
 ;            LA7FS = HL field separator
 ;           LA7ECH = HL encoding characters
 ;
 ; Returns ORC-21 sequence
 ;
 Q $$XON^LA7VHLU4(4,LA74,0,LA7FS,LA7ECH)
 ;
 ;
ORC22(LA74,LA7DT,LA7FS,LA7ECH) ; Build ORC-22 sequence - Ordering facility address
 ; Call with   LA74 = ien of institution in file #4
 ;                    if null/undefined then use Kernel Site file.
 ;            LA7DT = "as of" date in FileMan format
 ;            LA7FS = HL field separator
 ;           LA7ECH = HL encoding characters
 ;
 ; Returns ORC-22 sequence
 ;
 Q $$XAD^LA7VHLU4(4,LA74,LA7DT,LA7FS,LA7ECH)
 ;
 ;
ORC23(LA74,LA7DT,LA7FS,LA7ECH) ; Build ORC-23 sequence - Ordering facility phone number
 ; Call with   LA74 = ien of institution in file #4
 ;                    if null/undefined then use Kernel Site file.
 ;            LA7DT = "as of" date in FileMan format
 ;            LA7FS = HL field separator
 ;           LA7ECH = HL encoding characters
 ;
 ; Returns ORC-23 sequence
 ;
 N LA7Y
 ;
 S LA7Y=""
 ;
 Q LA7Y
 ;
 ;
ORC24(LA7200,LA7DT,LA7FS,LA7ECH) ; Build ORC-24 sequence - Ordering provider address
 ; Call with LA7200 = ien of provider in file #200
 ;            LA7DT = "as of" date in FileMan format
 ;            LA7FS = HL field separator
 ;           LA7ECH = HL encoding characters
 ;
 ; Returns ORC-24 sequence
 ;
 N LA7Y
 ;
 S LA7Y=""
 ;
 Q LA7Y
