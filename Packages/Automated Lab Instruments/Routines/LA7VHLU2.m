LA7VHLU2 ;DALOI/JMC - HL7 Segment Utility ;July 16, 2008
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,61,64,68,74**;Sep 27, 1994;Build 229
 ;
 Q
 ;
GETSEG(LA76249,LA7NODE,LA7ARR) ; Returns the next segment from file 62.49
 ;   during processing of an inbound message. The following variables
 ;   are used for the processing.
 ;
 ; Call with  LA76249 - Entry in 62.49 where message is
 ;            LA7NODE - Current ien of "150" wp field
 ;
 ; Returns     LA7ARR - Data is returned in LA7ARR(0) and
 ;                      LA7ARR(n) if segment greater than 245 chars.
 ;             LA7END - flag that end of message has been reached
 ;
 N LA7I,LA7END,LA7QUIT
 K LA7ARR
 S LA76249=+$G(LA76249),LA7NODE=$G(LA7NODE,0),(LA7END,LA7QUIT)=0
 ;
 S LA7NODE=$O(^LAHM(62.49,LA76249,150,LA7NODE))
 I 'LA7NODE S LA7END=1
 E  D
 . S LA7ARR(0)=$G(^LAHM(62.49,LA76249,150,LA7NODE,0)),LA7I=0
 . F  S LA7NODE=$O(^LAHM(62.49,LA76249,150,LA7NODE)) Q:'LA7NODE  D  Q:LA7QUIT
 . . I $G(^LAHM(62.49,LA76249,150,LA7NODE,0))="" S LA7QUIT=1 Q
 . . S LA7I=LA7I+1,LA7ARR(LA7I)=$G(^LAHM(62.49,LA76249,150,LA7NODE,0))
 ;
 Q LA7END
 ;
 ;
FINDSITE(LA7Z,LA7TYPE,LA7SEM) ; Look up an institution in file #4
 ;
 ; Call with LA7Z = value to lookup 
 ;                  VA: "VA"(optional) followed by 3-5 character VA site number
 ;                  Non-VA uses 3-5 character site assigned identifier
 ;          LA7TYPE = 1 (host facility)
 ;                    2 (collection facility)
 ;
 ;           LA7SEM = 0 (log error message)
 ;                    1 (suppress error message)
 ;
 ; Returns     LA7Y = ien of entry in INSTITUTION file (#4).
 ;
 N LA7X,LA7Y
 ;
 S LA7TYPE=$G(LA7TYPE),LA7Z=$G(LA7Z),LA7Y="",LA7SEM=$G(LA7SEM,1)
 ;
 ; If VA facility then strip off "VA" before lookup
 I $E(LA7Z,1,2)="VA" S LA7X=$E(LA7Z,3,$L(LA7Z))
 E  S LA7X=LA7Z
 ;
 ; Lookup in INSTITUTION file (#4)
 ; If appears to be a VA station number
 I LA7Z?1(3N,3.4N2U,3N1U1N) S LA7Y=$$IDX^XUAF4("VASTANUM",LA7Z)
 ; If appears to be a DoD DMIS number
 I LA7Z?4N S LA7Y=$$IDX^XUAF4("DMIS",LA7Z)
 ; If appears to be a IHS ASUFAC number
 I LA7Z?6N S LA7Y=$$IDX^XUAF4("ASUFAC",LA7Z)
 ; Else try anything
 I 'LA7Y S LA7Y=$$FIND1^DIC(4,"","OMX",LA7X)
 ;
 ; If unable to find in INSTITUTION file (#4) then try looking in
 ; SHIPPING CONFIGURATION file (#62.9) using non-VA identifier.
 ; Check that entry is not a VA facility
 I LA7Y'>0,LA7X]"" D
 . N LA7J,LA7K
 . S LA7J=0
 . F  S LA7J=$O(^LAHM(62.9,LA7J)) Q:'LA7J  D  Q:LA7Y
 . . S LA7J(0)=$G(^LAHM(62.9,LA7J,0))
 . . I $P(LA7J(0),"^",4)'=1 Q  ; Not active
 . . I $P(LA7J(0),"^",12)'=LA7X Q
 . . S LA7K=$S(LA7TYPE=1:$P(LA7J(0),"^",3),LA7TYPE=2:$P(LA7J(0),"^",2),1:"")
 . . I LA7K,$$NVAF(LA7K) S LA7Y=LA7K
 ;
 ; No entry found
 I 'LA7SEM,LA7Y'>0 D
 . N LA7SITE
 . S LA7SITE=$S(LA7TYPE=1:"Host",LA7TYPE=2:"Collection",1:"type")_" site: "_$S(LA7Z]"":LA7Z,1:"Blank-no value")
 . N LA7X,LA7Y,LA7Z
 . D CREATE^LA7LOG(25)
 ;
 Q LA7Y
 ;
 ;
RETFACID(LA7Z,LA7TYPE,LA7SEM) ; (RET)urn (FAC)ility (ID)entifier
 ;
 ; Call with LA7Z = ien of entry in INSTITUTION file (#4).
 ;
 ;          LA7TYPE = 1 (host facility)
 ;                    2 (collecting facility)
 ;
 ;           LA7SEM = 0 (log error message)
 ;                    1 (suppress error message)
 ;
 ; Returns     LA7Y = VA site number
 ;                    non-VA site identifier
 ;
 N I,LA7NVAF,LA7X,LA7Y
 S LA7Y="",LA7SEM=$G(LA7SEM,1)
 ;
 ; Check identifiers on file.
 ; If DoD use DMIS code since some DoD also have VA station number.
 S LA7NVAF=$$NVAF(LA7Z)
 I LA7NVAF=0 S LA7Y=$$ID^XUAF4("VASTANUM",LA7Z)
 I LA7NVAF=1 S LA7Y=$$ID^XUAF4("DMIS",LA7Z)
 I LA7NVAF=2 S LA7Y=$$ID^XUAF4("ASUFAC",LA7Z)
 ;
 ; If unable to find in INSTITUTION file (#4) then try looking in
 ; SHIPPING CONFIGURATION file (#62.9) using non-VA identifier.
 I LA7Y="" D
 . N LA7J
 . S LA7J=0
 . F  S LA7J=$O(^LAHM(62.9,LA7J)) Q:'LA7J  D
 . . S LA7J(0)=$G(^LAHM(62.9,LA7J,0))
 . . I $P(LA7J(0),"^",4)'=1 Q  ; Not active
 . . I LA7TYPE=1,LA7Z=$P(LA7J(0),"^",3) S LA7Y=$P(LA7J(0),"^",12)
 . . I LA7TYPE=2,LA7Z=$P(LA7J(0),"^",2) S LA7Y=$P(LA7J(0),"^",12)
 . I LA7Y'="" S LA7Y=$$UP^XLFSTR(LA7Y)
 ;
 ; No entry found
 I 'LA7SEM,LA7Y="" D
 . N LA7SITE
 . S LA7SITE=$S(LA7TYPE=1:"Host",LA7TYPE=2:"Collection",1:"type")_" site: "_$$GET1^DIQ(4,LA7Z_",",.01)
 . N LA7X,LA7Y
 . D CREATE^LA7LOG(25)
 ;
 Q LA7Y
 ;
 ;
FNDOLOC(LRUID) ; Find ordering location
 ; Call with LRUID = Accession's UID
 ; Returns    LA7Y = ordering location^ordering institution
 ;
 N LRAA,LRAD,LRAN,LA7X,LA7Y,X,Y
 ;
 S LA7Y=""
 S X=$Q(^LRO(68,"C",LRUID))
 I $QS(X,3)'=LRUID Q LA7Y
 S LA7X=$P($G(^LRO(68,$QS(X,4),1,$QS(X,5),1,$QS(X,6),0)),"^",13)
 I 'LA7X Q LA7Y
 D GETS^DIQ(44,LA7X_",",".01;3","EI","LA7Y")
 S LA7Y=LA7X_"^"_LA7Y(44,LA7X_",",.01,"E")_"^"_LA7Y(44,LA7X_",",3,"I")_"^"_LA7Y(44,LA7X_",",3,"E")
 Q LA7Y
 ;
 ;
CHKICN(LA7X) ; Lookup patient using ICN
 ; Call with LA7X = patient's ICN
 ; Returns   LA7Y = patient's DFN^full ICN
 ;                  -1^error message
 ;
 ; Note - until MPI can handle full ICN (number,"V" and checksum) as lookup value
 ; then confirm if full ICN passed in with full ICN from MPI.
 ;
 N LA7Y,LA7Z
 ;
 S (LA7Y,LA7Z)=""
 S LA7X(1)=$P(LA7X,"V")
 S LA7X(2)=$P(LA7X,"V",2)
 I LA7X(2)="" S LA7Y=$$GETDFN^MPIF001(LA7X(1))
 E  D
 . S LA7Y=$$GETDFN^MPIF001(LA7X(1))
 . S LA7Z=$$GETICN^MPIF001(LA7Y)
 . I LA7X'=LA7Z S LA7Y="-1^Not a valid ICN"
 ;
 Q LA7Y_"^"_LA7Z
 ;
 ;
NVAF(LA7X) ; Set flag sending to non-VA facility.
 ; Used to code certain segments for other systems, i.e. CHCS-DOD.
 ; Call with LA7X = ien of institution in file #4
 ; Returns   LA7Y = 0 (VA facility)
 ;                  1 (DoD facility - Army, Navy, Air Force, Coast Guard)
 ;                  2 (Indian Health Service)
 ;                  3 (Other - non US Government)
 ;
 N LA7Y
 S LA7Y=""
 I LA7X S LA7Y=$$GET1^DIQ(4,LA7X_",",95,"I")
 S LA7Y=$S(LA7Y="N":1,LA7Y="AF":1,LA7Y="ARMY":1,LA7Y="USCG":1,LA7Y="I":2,LA7Y="O":3,1:0)
 Q LA7Y
 ;
 ;
FACDNS(LA74,LA7FS,LA7ECH,LA7LV) ; Build facility DNS identifier
 ; Call with LA74 = pointer to entry in INSITUTION file (#4)
 ;          LA7FS = HL field separator
 ;         LA7ECH = HL encoding characters
 ;          LA7LV = field (1)/ component (2) level in message
 ;
 ; Returns   LA7Y = STA#~STA-NAME~DNS
 ;
 N LA7DN,LA7FAC,LA7NVAF,LA7Y
 S LA7Y=""
 ;
 ; Retrieve saved valued
 I $D(^TMP($J,"LA7VHLU","INST-DNS",LA74,LA7FS_LA7ECH,LA7LV)) S LA7Y=^TMP($J,"LA7VHLU","INST-DNS",LA74,LA7FS_LA7ECH,LA7LV)
 ;
 ; Retrieve station # or DMIS code for VA/DoD facilities, ASUFAC for IHS facilities.
 ; Others leave blank for now (Jun 2005)
 ; Retrieve domain name for this institution.
 ; Build component and save for other parts of message building
 I LA7Y="" D
 . S LA7FAC="",LA7NVAF=$$NVAF(LA74)
 . I LA7NVAF<3 S LA7FAC=$$ID^XUAF4($S(LA7NVAF=1:"DMIS",LA7NVAF=2:"ASUFAC",1:"VASTANUM"),LA74)
 . S LA7Y=LA7FAC
 . S LA7DN=$$WHAT^XUAF4(LA74,60)
 . I LA7DN'="" S LA7DN=$$CHKDATA^LA7VHLU3(LA7DN,LA7FS_LA7ECH),LA7Y=LA7FAC_$S(LA7LV=1:$E(LA7ECH),1:$E(LA7ECH,4))_LA7DN_$S(LA7LV=1:$E(LA7ECH),1:$E(LA7ECH,4))_"DNS"
 . S ^TMP($J,"LA7VHLU","INST-DNS",LA74,LA7FS_LA7ECH,LA7LV)=LA7Y
 ;
 Q LA7Y
 ;
 ;
RESFID(LA7PRDID,LA7SFAC,LA7CS) ; Resolve facility id to file #4 INSTIUTION file entry.
 ; Call with LA7PRDID = Producer's ID field
 ;            LA7SFAC = sending facility
 ;              LA7CS = component encoding character
 N LA74,LA7I,LA7X,LA7Y
 ;
 S LA7X=$P(LA7PRDID,LA7CS,2),LA74=""
 ;
 F LA7I=1,4 D  Q:LA74
 . I $P(LA7PRDID,LA7CS,LA7I+2)="99VA4" S LA74=$$LKUP^XUAF4($P(LA7PRDID,LA7CS,LA7I))
 . I $P(LA7PRDID,LA7CS,LA7I+2)="DNS" S LA74=$$LKUP^XUAF4($P(LA7PRDID,LA7CS,LA7I))
 . I $P(LA7PRDID,LA7CS,LA7I+2)?1(1"L-CL",1"CLIA",1"99VACLIA") S LA74=$$IDX^XUAF4("CLIA",$P(LA7PRDID,LA7CS,LA7I))
 . I 'LA74 S LA74=$$LKUP^XUAF4($P(LA7PRDID,LA7CS,LA7I+1))
 . I 'LA74 S LA74=$$FINDSITE($P(LA7PRDID,LA7CS,LA7I),1,1)
 I 'LA74 S LA74=$$FINDSITE($P(LA7SFAC,LA7CS),1,1)
 ;
 Q LA74
 ;
 ;
RESPL(LA7X) ; Resolve performing lab from file #63 designation
 ;
 ; Call with LA7X = lab data reference (entry in file #63, #.12 multiple)
 ;
 ; Returns   LA7Y = file #4 ien of performing lab associated with the result ^ ien of entry in "PL" multiple
 ;
 N LA7I,LA7J,LA7K,LA7Z,LA7QUIT,LRDFN
 S LRDFN=$P(LA7X,","),LA7Y="",LA7Z=LA7X
 ;
 ; Found a direct hit on this item
 D CHKNODE
 ;
 ; Walk up tree to find any performing lab at a higher level
 I LA7Y="" D
 . S LA7QUIT=0
 . I $P(LA7X,",",2)'="CH" D CHCHK Q
 . I $P(LA7X,",",2)?1(1"MI",1"SP",1"CY",1"EM",1"AU") D MIAPCHK Q
 ;
 Q LA7Y
 ;
 ;
CHCHK ; Find performing lab for a CH subscript reference
 ;
 S LA7Z=$P(LA7X,";") D CHKNODE
 ;
 Q
 ;
 ;
MIAPCHK ; Find performing lab for a MI and AP subscript reference
 ;
 I $P(LA7X,";",2)'="" S LA7Z=$P(LA7X,";")
 ;
 S LA7J=$L(LA7Z,",")
 F LA7K=LA7J:-1:4 D  Q:LA7Y
 . S LA7Z=$P(LA7Z,",",1,LA7K)
 . D CHKNODE Q:LA7Y
 . I $P(LA7Z,",",LA7K)>0 S $P(LA7Z,",",LA7K)=0 D CHKNODE
 ;
 I LA7Y="",$P(LA7X,",",2)="MI",$P(LA7X,",",4)=99 F I=1,5,8,11,16 S $P(LA7Z,",",4)=I D CHKNODE Q:LA7Y
 ;
 Q
 ;
 ;
CHKNODE ; Check if node exists and return file #4 ien
 ;
 S LA7I=$O(^LR(LRDFN,"PL","B",LA7Z,0))
 I LA7I S LA7Y=$P(^LR(LRDFN,"PL",LA7I,0),"^",2)_"^"_LA7I
 Q
