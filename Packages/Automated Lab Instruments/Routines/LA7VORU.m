LA7VORU ;DALOI/JMC - Builder of HL7 Lab Results OBR/OBX/NTE ;July 18, 2007
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**27,46,61,64,71,68,74**;Sep 27, 1994;Build 229
 ;
EN(LA) ; called from IN^LA7VMSG(...)
 ; variables
 ; LA("HUID") - Host Unique ID from the local ACCESSION file (#68)
 ; LA("SITE") - Ordering site IEN in the INSTITUTION file (#4)
 ; LA("RUID") - Remote sites Unique ID from ACCESSION file (#68)
 ; LA("ORD") - Free text ordered test name from WKLD CODE file (#64)
 ; LA("NLT") - National Laboratory test code from WKLD CODE file (#64)
 ; LA("LRIDT") - Inverse date/time the lab arrival time (accession date/time)
 ; LA("SUB") - test subscript defined in LABORATORY TEST file (#60)
 ; LA("LRDFN") - IEN in LAB DATA file (#63)
 ; LA("ORD"), LA("NLT"), and LA("SUB") are sent for specific lab results.
 ; LA("AUTO-INST") - Auto-Instrument
 ;
 N LA763,LA7NLT,LA7NVAF,LA7RS,LA7X,PRIMARY
 ;
 S PRIMARY=$$PRIM^VASITE(DT),LA("AUTO-INST")=""
 I $G(PRIMARY)'="" D
 . S PRIMARY=$$SITE^VASITE(DT,PRIMARY)
 . S PRIMARY=$P(PRIMARY,U,3)
 . S LA("AUTO-INST")="LA7V HOST "_PRIMARY
 ;
 I '$O(^LR(LA("LRDFN"),LA("SUB"),LA("LRIDT"),0)) D  Q
 . ; need to add error logging when no entry in 63.
 ;
 ; Check for date report completed.
 S LRDFN=LA("LRDFN"),LRSS=LA("SUB"),LRIDT=LA("LRIDT")
 I '$$OK2SEND^LA7SRR D CREATE^LA7LOG(122) Q
 ;
 ; Get zeroth node of entry in #63.
 S LA763(0)=$G(^LR(LA("LRDFN"),LA("SUB"),LA("LRIDT"),0))
 S LA7NLT=$G(LA("NLT"))
 ;
 S LA7NVAF=$$NVAF^LA7VHLU2(+LA("SITE"))
 S LA7NTESN=0
 D ORC
 ;
 I $G(LA("SUB"))="CH" D CH
 I $G(LA("SUB"))="MI" D MI^LA7VORU1
 I "SPCYEM"[$G(LA("SUB")) D AP^LA7VORU2
 Q
 ;
 ;
CH ; Build segments for "CH" subscript
 ;
 D OBR
 D NTE
 S LA7OBXSN=0
 D OBX
 ;
 Q
 ;
 ;
ORC ; Build ORC segment
 ;
 N LA76205,LA763,LA7696,LA7DATA,LA7PLOBR,LA7SM,LA7X,LA7Y,LADFINST,ORC
 ;
 S LA763(0)=$G(^LR(LA("LRDFN"),LA("SUB"),LA("LRIDT"),0))
 ;
 ; Retrieve placer's OBR information stored in #69.6
 D RETOBR^LA7VHLU(LA("SITE"),LA("RUID"),LA("NLT"),.LA7PLOBR)
 ;
 ; Default institution from Kernel
 S LADFINST=+$$KSP^XUPARAM("INST")
 ;
 S ORC(0)="ORC"
 ;
 ; Order control
 S ORC(1)=$$ORC1^LA7VORC("RE")
 ;
 ; Remote UID
 K LA7X
 M LA7X=LA("RUID")
 S ORC(2)=$$ORC2^LA7VORC(.LA7X,LA7FS,LA7ECH)
 ;
 ; Host UID
 K LA7X
 M LA7X=LA("HUID")
 S ORC(3)=$$ORC3^LA7VORC(.LA7X,LA7FS,LA7ECH)
 ;
 ; Return shipping manifest if found
 S LA7SM="",LA7696=0
 I LA("SITE")'="",LA("RUID")'="" S LA7696=$O(^LRO(69.6,"RST",LA("SITE"),LA("RUID"),0))
 I LA7696 S LA7SM=$P($G(^LRO(69.6,LA7696,0)),U,14)
 I LA7SM'="" D
 . S ORC(4)=$$ORC4^LA7VORC(LA7SM,LA7FS,LA7ECH)
 . D SETID^LA7VHLU1(LA76249,LA7ID,LA7SM,0)
 . D SETID^LA7VHLU1(LA76249,"",LA7SM,0)
 ;
 ; Order status
 ; DoD/CHCS requires ORC-5 valued otherwise will not process message
 I LA7NVAF=1 S ORC(5)=$$ORC5^LA7VORC("CM",LA7FS,LA7ECH)
 ;
 ; Test urgency - lookup ordered test in "ORUT" node
 K LA7X
 I LA("NLT")'="" D
 . S LA7X=$O(^LR(LA("LRDFN"),LA("SUB"),LA("LRIDT"),"ORUT","B",LA("NLT"),""))
 . I LA7X<1 Q
 . S LA76205=$P($G(^LR(LA("LRDFN"),LA("SUB"),LA("LRIDT"),"ORUT",LA7X,0)),"^",2)
 . S ORC(7)=$$ORC7^LA7VORC("","",LA76205,LA7FS,LA7ECH)
 ;
 ; Ordering provider
 K LA7X,LA7Y
 S (LA7X,LA7Y)=""
 ; "CH" and "MI" subscript store requesting provider and requesting div/location.
 I "CHMI"[LA("SUB") D
 . N LA7J
 . S LA7J=$P(LA763(0),"^",13)
 . I $P(LA7J,";",2)="SC(" S LA7Y=$$GET1^DIQ(44,$P(LA7J,";")_",",3,"I")
 . I $P(LA7J,";",2)="DIC(4," S LA7Y=$P(LA7J,";")
 . I LA("SUB")="CH" S LA7X=$P(LA763(0),"^",10)
 . I LA("SUB")="MI" S LA7X=$P(LA763(0),"^",7)
 ;
 ; Other subscripts only store requesting provider
 I "CYEMSP"[LA("SUB") S LA7X=$P(LA763(0),"^",7)
 ;
 ; Send back ordering provider stored in #69.6 if available.
 I LA7INTYP=10,$G(LA7PLOBR("OBR-17"))'="" S LA7X=LA7PLOBR("OBR-17")
 ;
 I LA7Y="" S LA7Y=LADFINST
 S ORC(12)=$$ORC12^LA7VORC(LA7X,LA7Y,LA7FS,LA7ECH,$S($G(LA7INTYP)=30:2,$G(LA7NVAF)=1:0,1:1))
 ;
 ; Enterer's location
 S LA7X=""
 I "CHMI"[LA("SUB") S LA7X=$P(LA763(0),"^",13)
 I LA7X'="" S ORC(13)=$$ORC13^LA7VORC(LA7X,LA7FS,LA7ECH)
 ;
 ; Entering organization
 S ORC(17)=$$ORC17^LA7VORC(LA7Y,LA7FS,LA7ECH)
 ;
 ; Ordering facility/address
 S LA7X=$P($G(^LR(LA("LRDFN"),LA("SUB"),LA("LRIDT"),"ORU")),"^",3)
 I 'LA7X,"CHMI"[LA("SUB") S LA7X=$P(LA763(0),"^",14)
 I LA7X D
 . S ORC(21)=$$ORC21^LA7VORC(LA7X,LA7FS,LA7ECH)
 . S ORC(22)=$$ORC22^LA7VORC(LA7X,$P(LA763(0),"^"),LA7FS,LA7ECH)
 ;
 D BUILDSEG^LA7VHLU(.ORC,.LA7DATA,LA7FS)
 D FILESEG^LA7VHLU(GBL,.LA7DATA)
 ;
 ; Check for flag to only build message but do not file
 I '$G(LA7NOMSG) D
 . D FILE6249^LA7VHLU(LA76249P,.LA7DATA)
 . I LA("HUID")'="" D
 . . D SETID^LA7VHLU1(LA76249,LA7ID,LA("HUID"),0)
 . . D SETID^LA7VHLU1(LA76249,"",LA("HUID"),0)
 . I LA("RUID")'="" D
 . . D SETID^LA7VHLU1(LA76249,LA7ID,LA("RUID"),0)
 . . D SETID^LA7VHLU1(LA76249,"",LA("RUID"),0)
 ;
 Q
 ;
 ;
OBR ;Observation Request segment for Lab Order
 ;
 D OBR^LA7VORUB
 Q
 ;
 ;
OBX ;Observation/Result segment for Lab Results
 ;
 D OBX^LA7VORUA
 Q
 ;
 ;
NTE ; Build NTE segment
 ;
 D NTE^LA7VORUA
 Q
