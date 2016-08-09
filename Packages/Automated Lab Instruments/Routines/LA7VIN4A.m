LA7VIN4A ;DALOI/JMC - Process Incoming UI Msgs, continued ;04/19/16  16:17
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74,80,88**;Sep 27, 1994;Build 10
 ;
 ;This routine is a continuation of LA7VIN4 and is only called from there.
 Q
 ;
 ; ZEXCEPT is used to identify variables which are external to a specific TAG
 ;         used in conjunction with Eclipse M-editor.
 ;
LAGEN ; Sets up variables for call to ^LAGEN,  build entry in LAH
 ; requires LA7INST,LA7TRAY,LA7CUP,LA7AA,LA7AD,LA7AN,LA7LWL
 ; returns LA7ISQN=subscript to store results in ^LAH global
 ;
 I LA7ENTRY="LOG" D
 . I LA7INTYP>19,LA7INTYP<30 Q
 . I '$D(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,0)) S LA7ERR=13,LA7AERR=$$CREATE^LA7LOG(LA7ERR,1)
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
 . S LA7ERR=19,LA7AERR=$$CREATE^LA7LOG(LA7ERR,1)
 ;
 ; Set accession area to area of specimen, allow multiple areas on same instrument.
 S WL=LA7AA
 I '$D(^LRO(68,+WL,0)) D  Q
 . S LA7ERR=20,LA7AERR=$$CREATE^LA7LOG(LA7ERR,1)
 S LROVER=$P(LA7624(0),"^",12)
 ;
 ; LEDI(MI & AP) override #62.4 setting so results never overlay unless same message
 I LA7INTYP=10 D
 . I LA7SS'?1(1"MI",1"SP",1"CY",1"EM") Q
 . ; Use same entry in LAH if handling multiple OBR within same message for same accession/test
 . I $P($G(LA7INTYP("ISQN",LWL)),"^",1,3)=(LA76249_"^"_LA7UID_"^"_LA7ONLT) S ISQN=$P(LA7INTYP("ISQN",LWL),"^",4),LROVER=2 Q
 . S LROVER=0
 S METH=$P(LA7624(0),"^",10)
 S LOG=LA7AN
 S IDENT=$P($G(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,0)),"^",6) ;identity field
 S IDE=+LA7IDE
 S LADT=LA7AD
 ;
 ; If auto release then set flag to not overlay data in LAH unless from same message.
 I LA7OBR49="AR" S LROVER=0
 I $G(LA7UID)'="",$D(^TMP("LA7 AR",$J,LA7LWL,1,"AUTOREL-UID",LA7UID)) D
 . N I
 . S I=0
 . F  S I=$O(^TMP("LA7 AR",$J,LA7LWL,1,"AUTOREL-UID",LA7UID,I)) Q:'I  I $D(^TMP("LA7 AR",$J,LA7LWL,1,"AUTOREL-UID",LA7UID,I,LA76249)) S ISQN=I,LROVER=2 Q
 ;
 I LROVER<2 D
 . N LRDFN ; Protect LRDFN - call into LAGEN can set to 0
 . ;
 . ; If POC interface call special entry point
 . I LA7INTYP>19,LA7INTYP<30 S IDE=LA76249 D POC^LAGEN Q
 . ;
 . D @(LA7ENTRY_"^LAGEN") ;this disregards the CROSS LINK field in 62.4
 ;
 S LA7ISQN=$G(ISQN)
 ;
 I LA7ISQN<1 Q
 ; Save entry made in LAH for this load list and message for this accession (UID)
 I LA7INTYP=10 S LA7INTYP("ISQN",LWL)=LA76249_"^"_LA7UID_"^"_LA7ONLT_"^"_LA7ISQN
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
 S J="EOL^FID^ORCDT^ORDNLT^ORDP^ORDSPEC^PON^SID^PEB^PVB^PRI^ARI^TECH"
 S J(0)="LA7EOL^LA7FID^LA7CDT^LA7ONLTS^LA7POP^LA7SPEC^LA7PON^LA7SID^LA7PEB^LA7PVB^LA7PRI^LA7ARI^LA7TECH"
 F I=1:1 S X=$P(J,"^",I) Q:X=""  D
 . S Y=$P(J(0),"^",I)
 . I $G(@Y)'="" S LA7OBRA(X)=@Y
 I $D(LA7OBRA) D POI^LAGEN(LA7LWL,LA7ISQN,"OBR",.LA7OBRA)
 ;
 ; Save placer fields 1/2 and filler fields 1/2
 I LA7SOBR>0 F I=18:1:21 S X=$P("PF1^PF2^FF1^FF2","^",I-17) S ^LAH(LA7LWL,1,LA7ISQN,.1,"OBR",X,LA7SOBR)=LA7OBR(I)
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
