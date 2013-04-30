LA7VIN4 ;DALOI/JMC - Process Incoming UI Msgs, continued ;11/04/10  18:25
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,64,67,66,74**;Sep 27, 1994;Build 229
 ;
 ; This routine is a continuation of LA7VIN1 and is only called from there.
 ;
 ; ZEXCEPT is used to identify variables which are external to a specific TAG
 ;         used in conjunction with Eclipse M-editor.
 ;
 Q
 ;
OBR ; Process OBR segments
 N I,LA7CUP,LA7ENTRY,LA7FF1,LA7FF2,LA7I,LA7IDE,LA7INST,LA7OK,LA7PDUZ,LA7PF1,LA7PF2,LA7TRAY,LA7X,LA7Y
 ;
 ;ZEXCEPT: A,CH,CY,EM,G,LA70070,LA761,LA762,LA7624,LA76248,LA76249,LA7AA,LA7ACC,LA7AD,LA7AN,LA7ARI,LA7CDT,LA7CS,LA7ECH,LA7ERR,LA7FID,LA7FS,LA7ID,LA7INTYP,LA7ISQN,LA7LWL,LA7MSATM,LA7MTYP
 ;ZEXCEPT: LA7OBR,LA7OBR25,LA7OBR26,LA7OBR29,LA7OBR32,LA7OBR33,LA7OBR34,LA7OCR,LA7ONLT,LA7OTYPE,LA7POP,LA7PRI,LA7QUIT
 ;ZEXCEPT: LA7RSDT,LA7SAC,LA7SAP,LA7SEG,LA7SFAC,LA7SID,LA7SM,LA7SOBR,LA7SPEC,LA7SPTY,LA7SS,LA7TECH,LA7UID,LAPSUBID,MI,N,SP
 ;
 ; OBR Set ID
 S LA7SOBR=$$P^LA7VHLU(.LA7SEG,2,LA7FS)
 ;
 S LA7X=$$P^LA7VHLU(.LA7SEG,19,LA7FS)
 S LA7X=$$UNESC^LA7VHLU3(LA7X,LA7FS_LA7ECH)
 S LA7624=0,LA7INST=$P(LA7X,"^") ; extracting 1st piece
 ; Look up #62.4 entry from instrument name.
 I LA7INST'="" S LA7624=+$O(^LAB(62.4,"B",LA7INST,0))
 ;
 ; If none then use sending application name to look up #62.4 entry.
 I 'LA7624 S LA7624=+$O(^LAB(62.4,"B",LA7SAP,0))
 ;
 ; Instrument name not found in xref
 I 'LA7624 D  Q
 . I LA7INST="" D  Q
 . . S LA7ERR=10,LA7QUIT=2
 . . D CREATE^LA7LOG(LA7ERR)
 . S LA7ERR=11,LA7QUIT=2
 . D CREATE^LA7LOG(LA7ERR)
 S LA7624(0)=$G(^LAB(62.4,LA7624,0))
 S LA7ID=$P(LA7624(0),"^")_"-I-"
 ;
 S LA7LWL=+$P(LA7624(0),"^",4) ;  Load/Work List
 S LA7ENTRY=$P(LA7624(0),"^",6) ;LOG,LLIST,IDENT or SEQN
 S:LA7ENTRY="" LA7ENTRY="LOG"
 ;
 ; Placer(sender)/filler order numbers
 S LA7X=$$P^LA7VHLU(.LA7SEG,3,LA7FS)
 S LA7SID=$P(LA7X,$E(LA7ECH)) F I=2:1:4 S LA7SID(I)=$P(LA7X,$E(LA7ECH),I)
 S LA7X=$$P^LA7VHLU(.LA7SEG,4,LA7FS)
 S LA7FID=$P(LA7X,$E(LA7ECH)) F I=2:1:4 S LA7FID(I)=$P(LA7X,$E(LA7ECH),I)
 ;
 ; Test order code - find order NLT code
 ; If POC interface then see if NLT is used for ordering code
 S LA7X=$$P^LA7VHLU(.LA7SEG,5,LA7FS),LA7ONLT=""
 F I=1,4 D  Q:LA7ONLT'=""
 . I $P(LA7X,LA7CS,I)'?5N1"."4N Q
 . I $P(LA7X,LA7CS,I+2)="99VA64" S LA7ONLT=$P(LA7X,LA7CS,I),LA7ONLT(0)=$P(LA7X,LA7CS,I+1) Q
 . I LA7INTYP>19,LA7INTYP<30,$P(LA7X,LA7CS,I+2)="" S LA7ONLT=$P(LA7X,LA7CS,I),LA7ONLT(0)=$P(LA7X,LA7CS,I+1) Q
 ;
 ; Specimen collection date/time
 S LA7CDT=$$HL7TFM^XLFDT($P($$P^LA7VHLU(.LA7SEG,8,LA7FS),LA7CS),"L")
 ;
 ; Extract filler fields #1&2 and placer fields #1&2
 F LA7I=18:1:21 D
 . S LA7X=$$P^LA7VHLU(.LA7SEG,LA7I+1,LA7FS)
 . S LA7OBR(LA7I)=$$UNESC^LA7VHLU3(LA7X,LA7FS_LA7ECH)
 ;
 ; Pull info from placer field #2 (OBR-19)
 S LA7X=LA7OBR(19)
 S LA7TRAY=+$P(LA7X,"^",1) ;Tray
 S LA7CUP=+$P(LA7X,"^",2) ; Cup
 ; If POC interface set cup to file #62.49 ien
 I LA7INTYP>19,LA7INTYP<30 S LA7CUP=LA76249
 S LA7AA=$P(LA7X,"^",3) ;  Accession Area
 S LA7AD=$P(LA7X,"^",4) ;  Accession Date
 S LA7AN=$P(LA7X,"^",5) ;  Accession Entry
 S LA7ACC=$P(LA7X,"^",6) ;  Accession
 I LA7ACC'="" D SETID^LA7VHLU1(LA76249,LA7ID,LA7ACC,0)
 S LA7UID=$P(LA7X,"^",7) ;  Unique ID
 I $L(LA7UID)<10 S LA7UID=""
 ;
 ; Sequence Number
 ; If point of care interface (20-29) then use file #62.49 ien as IDE
 S LA7IDE=$P(LA7X,LA7CS,8)
 I LA7INTYP>19,LA7INTYP<30 S LA7IDE=LA76249
 ;
 ; UID might come as Sample ID
 I LA7UID="",$L(LA7SID)>9 S LA7UID=LA7SID
 ;
 ; Try to figure out LA7AA LA7AD LA7AN by using the unique ID (UID)
 ; accession may have rolled over, use UID to get current accession info.
 I LA7UID'="" D
 . N X
 . S X=$Q(^LRO(68,"C",LA7UID)) Q:X=""  ; UID not on file
 . I $QS(X,3)'=LA7UID S LA7UID="" Q  ; UID not on file.
 . S LA7AA=+$QS(X,4),LA7AD=+$QS(X,5),LA7AN=+$QS(X,6)
 . D SETID^LA7VHLU1(LA76249,LA7ID,LA7UID,1)
 . D SETID^LA7VHLU1(LA76249,"",LA7UID,0)
 ;
 ; If still not known, compute from default accession date and area.
 ; Calculate accession date based on accession transform.
 I LA7AA<1!(LA7AD<1)!(LA7AN<1) D
 . N X
 . S LA7AA=+$P(LA7624(0),"^",11)
 . S X=$P($G(^LRO(68,LA7AA,0)),U,3)
 . S LA7AD=$S(X="D":DT,X="M":$E(DT,1,5)_"00",X="Y":$E(DT,1,3)_"0000",X="Q":$E(DT,1,3)_"0000"+(($E(DT,4,5)-1)\3*300+100),1:DT)
 . S LA7AN=+LA7SID
 . I LA7AN>0 D SETID^LA7VHLU1(LA76249,LA7ID,LA7AN,1)
 . I LA7SID'="" D SETID^LA7VHLU1(LA76249,LA7ID,LA7SID,0)
 ;
 ; Zeroth node of accession area.
 S LA7AA(0)=$G(^LRO(68,+LA7AA,0))
 ; Accession's subscript
 S LA7SS=$P(LA7AA(0),"^",2)
 ;
 ; Specimen action code
 S LA7SAC=$$P^LA7VHLU(.LA7SEG,12,LA7FS)
 ;
 ; Specimen(topography), collection sample, HL7 specimen source
 S (LA761,LA762,LA70070,LA7SPEC)=""
 S LA7X=$$P^LA7VHLU(.LA7SEG,16,LA7FS)
 D FLD2ARR^LA7VHLU7(.LA7X,LA7FS_LA7ECH)
 M LA7SPTY=LA7X(1)
 ;
 ; Look for HL7 Table 0070 code.
 ; If coding system blank then default to table 0070 as coding system per HL7 standard for OBR-15.
 ; If no code and not a standard code set then ignore (remove).
 F I=1,4 D
 . I $G(LA7SPTY(I))="",$G(LA7SPTY(I+2))'?1(1"99".E,1"L") K LA7SPTY(I),LA7SPTY(I+1),LA7SPTY(I+2),LA7SPTY($S(I=1:7,1:8)) Q
 . I $G(LA7SPTY(I+2))="" S LA7SPTY(I+2)="HL70070"
 . I LA7SPTY(I+2)="HL70070" S LA7SPEC=LA7SPTY(I)
 I LA7SPEC="" S LA7SPEC=$G(LA7SPTY)
 ;
 ; Retrieve related specimen/collection sample from accession
 ; Create specimen array to handle multiple AP specimens on orders.
 S I=0
 F  S I=$O(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,5,I)) Q:'I  D
 . S X=^LRO(68,LA7AA,1,LA7AD,1,LA7AN,5,I,0)
 . I $P(X,"^") D
 . . S LA761($P(X,"^"))="" ;spec array
 . . I LA761="" S LA761=$P(X,"^")
 . I $P(X,"^",2) D
 . . S LA762($P(X,"^",2))="" ;sample array
 . . I LA762="" S LA762=$P(X,"^",2)
 ;
 ; Log error when specimen source does not match accession's specimen
 ; Ignore if specimen related to lab control file #62.3
 S LA7OK=1
 I $P($G(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,0)),"^",2)'=62.3 D
 . N DIERR,LA7MSG
 . F LA7I=1,4 I $G(LA7SPTY(LA7I))'="" D  Q:'LA7OK
 . . I $G(LA7SPTY(LA7I+2))="HL70070" D  Q
 . . . K DIERR,LA7MSG
 . . . S LA70070=$$GET1^DIQ(61,LA761_",","LEDI HL7:HL7 ABBR",,,"LA7MSG")
 . . . I LA70070'="",LA70070'=LA7SPTY(LA7I) S LA7OK=0,LA7OK(0)="HL7 "_LA7SPTY(LA7I)
 . . I $G(LA7SPTY(LA7I+2))="SCT" D OBRSCT Q
 ;
 I 'LA7OK D
 . N LA7MSG
 . S LA7ERR=49,LA7QUIT=2,LA7MSG=LA7OK(0)
 . D CREATE^LA7LOG(LA7ERR)
 ;
 ; Don't continue if flag set to skip this segment
 I LA7QUIT Q
 ;
 ; Placer's ordering provider (id^duz^last name, first name, mi [id])
 I $G(LA7POP)="" D
 . S LA7POP="",LA7X=$$P^LA7VHLU(.LA7SEG,17,LA7FS)
 . I LA7X="" Q
 . S LA7POP=$$XCNTFM^LA7VHLU9(LA7X,LA7ECH)
 . I LA7POP="^^" S LA7POP=""
 ;
 ; Results rpt/status chng -  date/time
 S LA7X=$$P^LA7VHLU(.LA7SEG,23,LA7FS),LA7RSDT=""
 I LA7X'="" S LA7RSDT=$$HL7TFM^XLFDT(LA7X,"L")
 ;
 ; Result status
 S LA7OBR25=$$P^LA7VHLU(.LA7SEG,26,LA7FS)
 ;
 ; Parent result - CM data type.
 ; Save OBX-4 (sub-id) of parent result in LAPSUBID for subsequent usage by OBX/NTE's.
 S LA7OBR26=$$FIELD^LA7VHLU7(26)
 D FLD2ARR^LA7VHLU7(.LA7OBR26)
 S LAPSUBID=$G(LA7OBR26(2))
 ;
 ; Parent
 S LA7OBR29=$$FIELD^LA7VHLU7(29)
 D FLD2ARR^LA7VHLU7(.LA7OBR29)
 ;
 ; Principle Result interpreter
 S LA7OBR32=$$FIELD^LA7VHLU7(32),LA7PRI=""
 D FLD2ARR^LA7VHLU7(.LA7OBR32)
 I $G(LA7OBR32(1))'="" D
 . S LA7X=$TR(LA7OBR32(1),$E(LA7ECH,4),$E(LA7ECH))
 . S LA7PRI=$$XCNTFM^LA7VHLU9(LA7X,LA7ECH)
 . I LA7PRI="^^" S LA7PRI=""
 ;
 ; Assistant Result Interpreter
 S LA7OBR33=$$FIELD^LA7VHLU7(33),LA7ARI=""
 D FLD2ARR^LA7VHLU7(.LA7OBR33)
 I $G(LA7OBR33(1))'="" D
 . S LA7X=$TR(LA7OBR33(1),$E(LA7ECH,4),$E(LA7ECH))
 . S LA7ARI=$$XCNTFM^LA7VHLU9(LA7X,LA7ECH)
 . I LA7ARI="^^" S LA7ARI=""
 ;
 ; Technician
 S LA7OBR34=$$FIELD^LA7VHLU7(34),LA7TECH=""
 D FLD2ARR^LA7VHLU7(.LA7OBR34)
 I $G(LA7OBR34(1))'="" D
 . S LA7X=$TR(LA7OBR34(1),$E(LA7ECH,4),$E(LA7ECH))
 . S LA7TECH=$$XCNTFM^LA7VHLU9(LA7X,LA7ECH)
 . I LA7TECH="^^" S LA7TECH=""
 ;
 ; Create entry in LAH for supported subscripts.
 I LA7MTYP="ORR",$G(LA7OTYPE)'="OK",LA7SS?1(1"CH",1"MI",1"SP",1"CY",1"EM") D
 . D LAGEN^LA7VIN4A
 . I $G(LA7ISQN)="" D CREATE^LA7LOG(14) Q
 . S LA7I=$O(^TMP("LA7 ORDER STATUS",$J,""),-1),LA7I=LA7I+1
 . I LA7ONLT="" S X=$$P^LA7VHLU(.LA7SEG,5,LA7FS),LA7X=$P(X,LA7CS),LA7X(0)=$P(X,LA7CS,2)
 . E  S LA7X=LA7ONLT,LA7X(0)=LA7ONLT(0)
 . S X=LA7LWL_"^"_LA7ISQN_"^"_LA7X_"^"_LA7X(0)_"^"_LA76248_"^"_LA76249_"^"_LA7OTYPE_"^^"_$P($G(LA7SM),"^",2)
 . S ^TMP("LA7 ORDER STATUS",$J,LA7I)=X
 . I $G(LA7OCR)'="" S ^TMP("LA7 ORDER STATUS",$J,LA7I,"OCR")=$TR(LA7OCR,LA7CS,"^")
 . I $G(LA7MSATM)'="" S ^TMP("LA7 ORDER STATUS",$J,LA7I,"MSA")=LA7MSATM
 ;
 I LA7MTYP="ORU",LA7SS?1(1"CH",1"MI",1"SP",1"CY",1"EM") D
 . D LAGEN^LA7VIN4A
 . I $G(LA7ISQN)<1 D CREATE^LA7LOG(14) Q
 . I LA7INTYP=10,LA7SAC?1(1"A",1"G") D
 . . S LA7I=$O(^TMP("LA7 ORDER STATUS",$J,""),-1),LA7I=LA7I+1,LA7SAC(0)=LA7I
 . . I LA7ONLT="" S X=$$P^LA7VHLU(.LA7SEG,5,LA7FS),LA7X=$P(X,LA7CS),LA7X(0)=$P(X,LA7CS,2)
 . . E  S LA7X=LA7ONLT,LA7X(0)=LA7ONLT(0)
 . . S X=LA7LWL_"^"_LA7ISQN_"^"_LA7X_"^"_LA7X(0)_"^"_LA76248_"^"_LA76249_"^"_$G(LA7OTYPE)_"^"_LA7SAC_"^"_$P($G(LA7SM),"^",2)
 . . S ^TMP("LA7 ORDER STATUS",$J,LA7I)=X
 . I LA7INTYP=10,LA7OBR25?1(1"A",1"X") D
 . . S LA7I=$O(^TMP("LA7 ORDER STATUS",$J,""),-1),LA7I=LA7I+1
 . . I LA7ONLT="" S X=$$P^LA7VHLU(.LA7SEG,5,LA7FS),LA7X=$P(X,LA7CS),LA7X(0)=$P(X,LA7CS,2)
 . . E  S LA7X=LA7ONLT,LA7X(0)=LA7ONLT(0)
 . . S X=LA7LWL_"^"_LA7ISQN_"^"_LA7X_"^"_LA7X(0)_"^"_LA76248_"^"_LA76249_"^"_$G(LA7OTYPE)_"^"_LA7SAC_"^"_$P($G(LA7SM),"^",2)_"^"_LA7OBR25
 . . S ^TMP("LA7 ORDER STATUS",$J,LA7I)=X
 . I LA7INTYP=10,LA7SS?1(1"MI",1"SP",1"CY",1"EM") S ^TMP("LA7-PL-NTE",$J,LA7LWL,LA7ISQN,LA7SS)=LA7SFAC
 ;
 I LA7INTYP=10,$G(LA7SM)'="",$G(LA7UID)'="" D SMUPDT^LA7VIN4A
 Q
 ;
 ;
OBRSCT   ; check if SCT doesn't match any specimen in #68
 ;
 ;ZEXCEPT: LA761,LA76248,LA7I,LA7OK,LA7SPTY
 ;
 N LA761SCT,R61,SCTOK
 S (R61,SCTOK)=0
 F  S R61=$O(LA761(R61)) Q:'R61  D
 . I $D(^LAHM(62.48,LA76248,"SCT","AD1",LA7SPTY(LA7I),R61_";LAB(61,")) S SCTOK=1 Q
 . S LA761SCT=$$IEN2SCT^LA7VHLU6(61,R61,DT,"")
 . I LA761SCT>0,$P(LA761SCT,"^")=LA7SPTY(LA7I) S SCTOK=1
 ;
 ; If no topography found on accession with a SCT mapping that matches SCT code then flag as error.
 ; Also if SCT code in message has Lexicon exception then record as a separate error.
 I 'SCTOK D
 . N LA7SCT,LA7X,LA7Z
 . S LA7OK=0,LA7OK(0)="SCTID "_LA7SPTY(LA7I)
 . S LA7Z=$$CODE^LEXTRAN(LA7SPTY(LA7I),"SCT",DT,"LA7SCT")
 . I $P(LA7Z,"^",5) D
 . . S LA7X=$P(LA7Z,"^",6)
 . . D CREATE^LA7LOG(37)
 ;
 Q
