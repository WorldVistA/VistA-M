LA7HDR1 ;DALOI/JMC - LAB HDR ORU (Observation Result) message builder (cont'd) ;July 28, 2008
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**68**;Sep 27, 1994;Build 56
 ;
 ; Reference to variable DIQUIET supported by DBIA #2098
 ;
 Q
 ;
 ;
HDRLOAD ; Load patient's historical lab results to HDR (Health Data Repository).
 ; Called from tasked option LA7TASK HDR LOAD
 N DIQUIET,GBL
 N LA7101,LA761,LA76248,LA76249,LA76249P
 N LA7CODE,LA7CNT,LA7DT,LA7ECH,LA7ERR,LA7FS,LA7ID,LA7INTYP,LA7MID,LA7MTYP,LA7NOMSG,LA7NTESN,LA7NVAF,LA7OBRSN,LA7OBXSN,LA7PIDSN,LA7RSITE,LA7QUIT,LA7SC,LA7SPEC
 N LRDFN,LRIDT,LRSS,LRSSLST,LRUID,SITE
 ;
 ; Prevent FileMan from issuing any unwanted WRITE(s).
 S DIQUIET=1,DT=$$DT^XLFDT
 ;
 ; Find entry in #62.48 and check if it's active.
 S (LA7RSITE,SITE)="LA7HDR",LA76248=$O(^LAHM(62.48,"B",LA7RSITE,0))
 ; No entry in 62.48 - *** Need to add error logging ****
 I 'LA76248 Q
 I '$P(^LAHM(62.48,LA76248,0),"^",3) Q  ; not active
 S LA7INTYP=+$P(^LAHM(62.48,LA76248,0),"^",9)
 ;
 S (LA7CNT,LA7CNT(1),LA7ERR,LA7NVAF,LA7QUIT)=0,LA7MTYP="ORU",LA7NOMSG=2
 I LA7EVENT="" S LA7EVNT="LA7 LAB RESULTS AVAILABLE (EVN)"
 ; Setup search and subscript list
 S (LA7SC,LA7SPEC)="*"
 D SCLIST^LA7QRY2(LA7SC,.LRSSLST)
 ; Check start/end dates
 I '$G(LA7SDT) S LA7SDT=$$FMADD^XLFDT(DT,-730,0,0,0)
 I '$G(LA7EDT) S LA7EDT=DT
 I LA7SDT>LA7EDT S X=LA7SDT,LA7SDT=LA7EDT,LA7EDT=X
 ;
 S GBL="^TMP(""HLS"","_$J_")"
 ; Limit number of messages built this session.
 S LA7LIMIT=$G(LA7LIMIT,1000)
 ;
 I $D(^XTMP("LA7HDR","LRDFN")) S LRDFN=$P(^XTMP("LA7HDR","LRDFN"),"^")
 E  S LRDFN=0
 I LRDFN'=+LRDFN Q
 F  S LRDFN=$O(^LR(LRDFN)) Q:'LRDFN  D  Q:LA7QUIT
 . I $$S^%ZTLOAD("Processing LRDFN "_LRDFN_" for HDR Historical") S (LA7QUIT,ZTSTOP)=1,LRDFN=LRDFN-1 Q
 . S LA7CNT(1)=LA7CNT(1)+1
 . I '(LA7CNT(1)#100) H 1 ; take a "rest" - allow OS to swap out process
 . S X=^LR(LRDFN,0) Q:$P(X,"^",2)'=2
 . S DFN=$P(X,"^",3),LA7ID=SITE_"-O-"_$$GET1^DIQ(2,DFN_",",.01)
 . K ^TMP("LA7-QRY",$J),^TMP("LA7VS",$J)
 . D BCD^LA7QRY2 S LA7QUIT=0 Q:'$D(^TMP("LA7-QRY",$J))
 . S LA76249=$$INIT6249^LA7VHLU,^TMP("LA7VS",$J,LA76249)=LA76249
 . D INITHL^LA7VHLU(LA7EVNT)
 . I $G(HL) S LA7QUIT=1,LRDFN=LRDFN-1 Q
 . D BUILDMSG^LA7QRY1,GEN^LA7VHLU,UPDT6249^LA7VORM1
 . S LA7CNT=LA7CNT+1,LA7QUIT=$S(LA7CNT<LA7LIMIT:0,1:1)
 ;
 ; Update XTMP entry, save last LRDFN processed for next session.
 S ^XTMP("LA7HDR",0)=$$FMADD^XLFDT(DT,90,0,0,0)_"^"_DT_"^Lab historical results feed to HDR"
 S ^XTMP("LA7HDR","LRDFN")=LRDFN
 ;
 D EXIT
 Q
 ;
 ;
RECOVER ; Recover failed transmissions or message building
 ;
 N DIR,DIRUT,DTOUT,DUOUT,FIRST,LA76248,LA7CNT,LA7PROD,LA7QUIT,LA7TYPE,LA7UID,LA7X,LA7Y,LAST,LRAA,LRACC,LRAD,LRAN,LRDFN,LREXMPT,LRIDT,LRSPEC,LRSS,X,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 S (LA7CNT,LA7QUIT)=0
 ;
 S LA76248=$O(^LAHM(62.48,"B","LA7HDR",0))
 I 'LA76248 W !,"No entry LA7HDR in file #62.48" Q
 I '$P(^LAHM(62.48,LA76248,0),"^",3) D  Q
 . S DIR(0)="EA"
 . S DIR("A")="Enter RETURN to continue:"
 . S DIR("A",1)="Entry LA7HDR is not active in file #62.48"
 . D ^DIR
 ;
 S LA7PROD=$$PROD^XUPROD(0)
 ;
 S DIR(0)="SO^1:Range of Accessions;2:Selected Accessions"
 S DIR("A")="Selection Method",DIR("B")=1
 D ^DIR
 I $D(DIRUT) Q
 S LA7TYPE=+Y
 ;
 ; Get list of accession numbers, set flags used by LRWU4.
 S LRACC=1,LREXMPT=1
 I LA7TYPE=1 D
 . D ^LRWU4
 . I LRAN<1 S LA7QUIT=1 Q
 . S FIRST=LRAN,X=$O(^LRO(68,LRAA,1,LRAD,1,":"),-1)
 . S DIR(0)="NO^"_LRAN_":"_X_":0",DIR("B")=LRAN
 . S DIR("A",1)="",DIR("A")="Recover accessions from "_LRAN_" to"
 . D ^DIR K DIR
 . I $D(DIRUT) S LA7QUIT=1 Q
 . S LRAN=FIRST-1,LAST=Y
 . F  S LRAN=$O(^LRO(68,LRAA,1,LRAD,1,LRAN)) Q:'LRAN!(LRAN>LAST)  D SETTMP
 I LA7TYPE=2 F  D  Q:LA7QUIT!(LRAN<1)
 . D ^LRWU4
 . I $D(DTOUT)!($D(DUOUT)) S LA7QUIT=1 Q
 . I LRAN<1 S:'$D(^TMP("LA7S-RTM",$J)) LA7QUIT=1 Q
 . D SETTMP
 I LA7QUIT Q
 ;
 I '$D(^TMP("LA7S-RTM",$J)) D  Q
 . S DIR("A",1)="No accessions found to retransmit."
 . S DIR("A")="Enter RETURN to continue or '^' to exit"
 . S DIR(0)="E"
 . D ^DIR
 ;
 S DIR("A")="Ready to retransmit"
 S DIR("A",1)="Found "_LA7CNT_" accessions that can be retransmitted."
 S DIR(0)="YO",DIR("B")="NO"
 D ^DIR K DIR
 I Y'=1 K ^TMP("LA7S-RTM",$J) Q
 D EN^DDIOL("Working","","!")
 ;
 K LA7Y
 S LA7CNT=0,LA7UID=""
 F  S LA7UID=$O(^TMP("LA7S-RTM",$J,LA7UID)) Q:LA7UID=""  D
 . K LA7X,ZTSAVE
 . S LA7X=^TMP("LA7S-RTM",$J,LA7UID),LA7CNT=LA7CNT+1
 . S ZTRTN="BUILD^LA7HDR",ZTDTH=$H,ZTIO="",ZTDESC="Tasked Lab HL7 HDR ORU Build"
 . S ZTSAVE("LRAA")=$P(LA7X,"^"),ZTSAVE("LRAD")=$P(LA7X,"^",2),ZTSAVE("LRAN")=$P(LA7X,"^",3)
 . S ZTSAVE("LRDFN")=$P(LA7X,"^",4),ZTSAVE("LRSS")=$P(LA7X,"^",5),ZTSAVE("LRIDT")=$P(LA7X,"^",6),ZTSAVE("LA7MTYP")="ORU"
 . I $P(LA7X,"^",5)="CH" S ZTSAVE("LRSPEC")=$P(LA7X,"^",7)
 . D ^%ZTLOAD
 . I $G(ZTSK) D
 . . I LA7CNT>101 Q
 . . I LA7CNT=101 S LA7Y(101)="*** Too many accessions to list (>100), list truncated... ***" Q
 . . S LA7Y(LA7CNT)="Task# "_ZTSK_" queued for processing accession "_LA7UID
 . E  S LA7Y(LA7CNT)="*** Tasking of retransmission failed for accession "_LA7UID_" ***"
 S LA7Y(.1)="...Done",LA7X(1,"F")=""
 S LA7Y(.2)=LA7CNT_" accession"_$S(LA7CNT>1:"s",1:"")_" scheduled for retransmitting of results!"
 D EN^DDIOL(.LA7Y)
 K ^TMP("LA7S-RTM",$J)
 ;
 Q
 ;
 ;
SETTMP ;
 ;
 S LA7UID=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3)),"^")
 I LA7UID="" Q
 S LRDFN=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,0)),"^")
 ; Quit if not a file #2 patient.
 I $P($G(^LR(LRDFN,0)),"^",2)'=2 Q
 ; Quit if test patient on a production account.
 I $$TESTPAT^VADPT($P($G(^LR(LRDFN,0)),"^",3)),LA7PROD Q
 S LRSS=$P($G(^LRO(68,LRAA,0)),"^",2),LRIDT=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,3)),"^",5)
 I LRSS?1(1"CH",1"MI") S LRSPEC=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,5,1)),"^")
 E  S LRSPEC=""
 S LA7CNT=LA7CNT+1,^TMP("LA7S-RTM",$J,LA7UID)=LRAA_"^"_LRAD_"^"_LRAN_"^"_LRDFN_"^"_LRSS_"^"_LRIDT_"^"_LRSPEC
 Q
 ;
 ;
EXIT ;
 K LA7LIMIT
 D CLEANUP^LA7QRY,EXIT^LA7VORM1
 K @GBL,^TMP("LA7VS",$J)
 Q
