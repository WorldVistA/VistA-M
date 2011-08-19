LA7VIN4 ;DALOI/JMC - Process Incoming UI Msgs, continued ; 7/27/07 11:24am
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,64,67,66**;Sep 27, 1994;Build 30
 ;This routine is a continuation of LA7VIN1 and is only called from there.
 Q
 ;
OBR ; Process OBR segments
 N I,LA7CUP,LA7ENTRY,LA7IDE,LA7INST,LA7PDUZ,LA7TRAY,LA7X,LA7Y
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
 ; Pull info from placer field #2 (OBR-19)
 S LA7X=$$P^LA7VHLU(.LA7SEG,20,LA7FS)
 S LA7X=$$UNESC^LA7VHLU3(LA7X,LA7FS_LA7ECH)
 S LA7TRAY=+$P(LA7X,"^",1) ;Tray
 S LA7CUP=+$P(LA7X,"^",2) ; Cup
 ; If POC interface set cup to file #62.49 ien
 I LA7INTYP>19,LA7INTYP<30 S LA7CUP=LA76249
 S LA7AA=$P(LA7X,"^",3) ;  Accession Area
 S LA7AD=$P(LA7X,"^",4) ;  Accession Date
 S LA7AN=$P(LA7X,"^",5) ;  Accession Entry
 S LA7ACC=$P(LA7X,"^",6) ;  Accession
 S LA7UID=$P(LA7X,"^",7) ;  Unique ID
 I LA7UID'?1(10UN,15UN) S LA7UID=""
 ;
 ; Sequence Number
 ; If point of care interface (20-29) then use file #62.49 ien as IDE
 S LA7IDE=$P(LA7X,LA7CS,8)
 I LA7INTYP>19,LA7INTYP<30 S LA7IDE=LA76249
 ;
 ; UID might come as Sample ID
 I LA7UID="",LA7SID?1(10UN,15UN) S LA7UID=LA7SID
 ;
 ; Try to figure out LA7AA LA7AD LA7AN by using the unique ID (UID)
 ; accession may have rolled over, use UID to get current accession info.
 I LA7UID]"" D
 . N X
 . S X=$Q(^LRO(68,"C",LA7UID))
 . I $QS(X,3)'=LA7UID S LA7UID="" Q  ; UID not on file.
 . S LA7AA=+$QS(X,4),LA7AD=+$QS(X,5),LA7AN=+$QS(X,6)
 . D SETID^LA7VHLU1(LA76249,LA7ID,LA7UID)
 ;
 ; If still not known, compute from default accession date and area.
 ; Calculate accession date based on accession transform.
 I LA7AA<1!(LA7AD<1)!(LA7AN<1) D
 . N X
 . S LA7AA=+$P(LA7624(0),"^",11)
 . S X=$P($G(^LRO(68,LA7AA,0)),U,3)
 . S LA7AD=$S(X="D":DT,X="M":$E(DT,1,5)_"00",X="Y":$E(DT,1,3)_"0000",X="Q":$E(DT,1,3)_"0000"+(($E(DT,4,5)-1)\3*300+100),1:DT)
 . S LA7AN=+LA7SID
 . I LA7AN>0 D SETID^LA7VHLU1(LA76249,LA7ID,LA7AN) Q
 . D SETID^LA7VHLU1(LA76249,LA7ID,$S($G(LA7PNM)]"":LA7PNM,$G(LA7SSN)]"":LA7SSN,1:"NO ID"))
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
 S LA7SPTY=$$P^LA7VHLU(.LA7SEG,16,LA7FS)
 ;
 ; Check if using HL7 table 0070
 S LA7X=$P($P(LA7SPTY,LA7CS),$E(LA7ECH,4),3)
 I LA7X=""!(LA7X="HL70070") S LA7SPEC=$P($P(LA7SPTY,LA7CS),$E(LA7ECH,4))
 ;
 I $O(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,5,0)) D
 . N X
 . S X=$O(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,5,0))
 . ; specimen^collection sample
 . S X(0)=$G(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,5,X,0))
 . S LA761=$P(X(0),"^") ; specimen
 . S LA762=$P(X(0),"^",2) ; collection sample
 . ; HL7 code
 . I LA761 S LA70070=$$GET1^DIQ(61,LA761_",","LEDI HL7:HL7 ABBR")
 ;
 ; Log error when specimen source does not match accession's specimen
 I LA70070'="",LA7SPEC'="",LA70070'=LA7SPEC D
 . ; Ignore if specimen related to lab control file #62.3
 . I $P($G(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,0)),"^",2)=62.3 Q
 . N LA7OBR
 . S LA7OBR(15)=LA7SPEC ; backward compatible with old code
 . S LA7ERR=22,LA7QUIT=2
 . D CREATE^LA7LOG(LA7ERR)
 ;
 ; Don't continue if flag set to skip this segment
 I LA7QUIT Q
 ;
 ; Placer's ordering provider (id^duz^last name, first name, mi [id])
 I $G(LA7POP)="" D
 . S LA7POP="",LA7X=$$P^LA7VHLU(.LA7SEG,17,LA7FS)
 . I LA7X="" Q
 . S LA7POP=$$XCNTFM^LA7VHLU4(LA7X,LA7ECH)
 . I LA7POP="^^" S LA7POP=""
 ;
 ; Create entry in LAH for supported subscripts.
 I LA7MTYP="ORR",$G(LA7OTYPE)'="OK","CHMI"[LA7SS D
 . D LAGEN
 . I $G(LA7ISQN)="" D CREATE^LA7LOG(14) Q
 . S LA7I=$O(^TMP("LA7 ORDER STATUS",$J,""),-1),LA7I=LA7I+1
 . I LA7ONLT="" S X=$$P^LA7VHLU(.LA7SEG,5,LA7FS),LA7X=$P(X,LA7CS),LA7X(0)=$P(X,LA7CS,2)
 . E  S LA7X=LA7ONLT,LA7X(0)=LA7ONLT(0)
 . S X=LA7LWL_"^"_LA7ISQN_"^"_LA7X_"^"_LA7X(0)_"^"_LA76248_"^"_LA76249_"^"_LA7OTYPE_"^^"_$P($G(LA7SM),"^",2)
 . S ^TMP("LA7 ORDER STATUS",$J,LA7I)=X
 . I $G(LA7OCR)'="" S ^TMP("LA7 ORDER STATUS",$J,LA7I,"OCR")=$TR(LA7OCR,LA7CS,"^")
 . I $G(LA7MSATM)'="" S ^TMP("LA7 ORDER STATUS",$J,LA7I,"MSA")=LA7MSATM
 ;
 I LA7MTYP="ORU","CHMI"[LA7SS D
 . D LAGEN
 . I $G(LA7ISQN)<1 D CREATE^LA7LOG(14) Q
 . I LA7INTYP=10,LA7SAC?1(1"A",1"G") D
 . . S LA7I=$O(^TMP("LA7 ORDER STATUS",$J,""),-1),LA7I=LA7I+1,LA7SAC(0)=LA7I
 . . I LA7ONLT="" S X=$$P^LA7VHLU(.LA7SEG,5,LA7FS),LA7X=$P(X,LA7CS),LA7X(0)=$P(X,LA7CS,2)
 . . E  S LA7X=LA7ONLT,LA7X(0)=LA7ONLT(0)
 . . S X=LA7LWL_"^"_LA7ISQN_"^"_LA7X_"^"_LA7X(0)_"^"_LA76248_"^"_LA76249_"^"_$G(LA7OTYPE)_"^"_LA7SAC_"^"_$P($G(LA7SM),"^",2)
 . . S ^TMP("LA7 ORDER STATUS",$J,LA7I)=X
 ;
 I LA7INTYP=10,$G(LA7SM)'="",$G(LA7UID)'="" D SMUPDT
 Q
 ;
 ;
LAGEN ; Sets up variables for call to ^LAGEN,  build entry in LAH
 ; requires LA7INST,LA7TRAY,LA7CUP,LA7AA,LA7AD,LA7AN,LA7LWL
 ; returns LA7ISQN=subscript to store results in ^LAH global
 ;
 I LA7ENTRY="LOG" D
 . I LA7INTYP>19,LA7INTYP<30 Q
 . I '$D(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,0)) D CREATE^LA7LOG(13)
 I LA7ENTRY="LLIST" S:'LA7CUP LA7CUP=LA7IDE ;cup=sequence number
 ;
 K LA7ISQN,LADT,LAGEN
 K TRAY,CUP,LWL,WL,LROVER,METH,LOG,IDENT,ISQN
 ;
 S LA7ISQN=""
 S TRAY=+$G(LA7TRAY) S:'TRAY TRAY=1
 S CUP=+$G(LA7CUP) S:'CUP CUP=1
 ;
 S LWL=LA7LWL
 I '$D(^LRO(68.2,+LWL,0)) D  Q
 . D CREATE^LA7LOG(19)
 ;
 ; Set accession area to area of specimen, allow multiple areas on same instrument.
 S WL=LA7AA
 I '$D(^LRO(68,+WL,0)) D  Q
 . D CREATE^LA7LOG(20)
 S LROVER=$P(LA7624(0),"^",12)
 S METH=$P(LA7624(0),"^",10)
 S LOG=LA7AN
 S IDENT=$P($G(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,0)),"^",6) ;identity field
 S IDE=+LA7IDE
 S LADT=LA7AD
 ;
 ; If POC interface call special entry point
 D
 . N LRDFN ; Protect LRDFN - call into LAGEN can set to 0
 . I LA7INTYP>19,LA7INTYP<30 S IDE=LA76249 D POC^LAGEN Q
 . D @(LA7ENTRY_"^LAGEN") ;this disregards the CROSS LINK field in 62.4
 S LA7ISQN=$G(ISQN)
 ;
 I LA7ISQN<1 Q
 ;
 ; Build/store patient demographics array
 N I,J,LA7OBRA,LA7PIDA,X,Y
 S J="DFN^DOB^ICN^LOC^LRDFN^LRTDFN^PNM^SEX^SSN"
 S J(0)="DFN^LA7DOB^LA7ICN^LA7LOC^LRDFN^LRTDFN^LA7PNM^LA7SEX^LA7SSN"
 F I=1:1 S X=$P(J,"^",I) Q:X=""  D
 . S Y=$P(J(0),"^",I)
 . I $G(@Y)'="" S LA7PIDA(X)=@Y
 I $D(LA7PIDA) D POI^LAGEN(LA7LWL,LA7ISQN,"PID",.LA7PIDA)
 ;
 ; Build/store order info array
 N LA7ONLTS
 I LA7POP'="" S LA7POP=$P(LA7POP," [")
 S X=$G(^LAH(LA7LWL,1,LA7ISQN,.1,"OBR","ORDNLT"))
 I X'="",LA7ONLT'="",X'[LA7ONLT S LA7ONLTS=X_"^"_LA7ONLT
 E  S LA7ONLTS=LA7ONLT
 S J="EOL^FID^ORCDT^ORDNLT^ORDP^ORDSPEC^PON^SID^PEB^PVB"
 S J(0)="LA7EOL^LA7FID^LA7CDT^LA7ONLTS^LA7POP^LA7SPEC^LA7PON^LA7SID^LA7PEB^LA7PVB"
 F I=1:1 S X=$P(J,"^",I) Q:X=""  D
 . S Y=$P(J(0),"^",I)
 . I $G(@Y)'="" S LA7OBRA(X)=@Y
 I $D(LA7OBRA) D POI^LAGEN(LA7LWL,LA7ISQN,"OBR",.LA7OBRA)
 ;
 ; Store interface type with results
 D LATYP^LAGEN(LA7LWL,LA7ISQN,LA7INTYP)
 ; 
 ; Store #62.49 ien with results
 D LAMSGID^LAGEN(LA7LWL,LA7ISQN,LA76249)
 ;
 ; Store method name with LAH entry
 D METH^LAGEN(LA7LWL,LA7ISQN,METH)
 ;
 ; Set flag if POC interface to start POC processing routine when
 ; finished - tasked by LA7VIN before shutdown
 I LA7INTYP>19,LA7INTYP<30 S LA7INTYP("LWL",LA7LWL)=""
 ;
 Q
 ;
 ;
SMUPDT ; Update shipping manifest in shipping event file #62.85
 N LA7DATA,LA7NCS,LA7TST,LA7USID
 ;
 S LA7USID=$$P^LA7VHLU(.LA7SEG,5,LA7FS) ; Universal Service ID (OBR-4)
 S LA7TST=$P(LA7USID,LA7CS,1) ; Test code
 S LA7NCS=$P(LA7USID,LA7CS,3) ; Name of coding system
 S LA7TST(2)=$P(LA7USID,LA7CS,4) ; Alternate test code
 S LA7NCS(2)=$P(LA7USID,LA7CS,6) ; Alternate coding system
 ;
 ; Determine ordered test, check primary and alternate
 S LA7OTST=$$DOT^LA7SMU1(LA7TST,LA7NCS,LA7UID,$P(LA7SM,"^"))
 I 'LA7OTST,LA7TST(2)'="" S LA7OTST=$$DOT^LA7SMU1(LA7TST(2),LA7NCS(2),LA7UID,$P(LA7SM,"^"))
 ;
 ; Flag the Results Received Event in #62.85
 I LA7MTYP="ORU" D
 . S LA7DATA="SM70"_"^"_LA7MEDT_"^"_$G(LA7OTST)_"^"_$P(LA7SM,"^",2)
 . D SEUP^LA7SMU(LA7UID,"2",LA7DATA)
 ;
 ; Flag the Test Received Event in #62.85
 I LA7MTYP="ORR" D
 . S LA7DATA="SM55"_"^"_LA7MEDT_"^"_$G(LA7OTST)_"^"_$P(LA7SM,"^",2)
 . D SEUP^LA7SMU(LA7UID,"2",LA7DATA)
 Q
