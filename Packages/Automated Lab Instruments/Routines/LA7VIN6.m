LA7VIN6 ;DALOI/JMC - PROCESS ORU OBX FOR AP ;11/18/11  14:01
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 ; Continuation of LA7VIN1 and is only called from there.
 ; It is called to process OBX segments for AP subscript tests.
 ;
 ; ZEXCEPT is used to identify variables which are external to a specific TAG
 ;         used in conjunction with Eclipse M-editor.
 ;
 Q
 ;
 ;
PROCESS ; File AP ^LAH for a given concept (LA76247)
 ;
 ;ZEXCEPT: DSOBX5,LA74,LA76247,LA76248,LA7CS,LA7ECH,LA7FS,LAPSUBID,OBX3,OBX4,OBX5
 ;
 N SUBID,PSUBID,LAX,CNCPTOR
 S SUBID=$G(OBX4)
 S SUBID=$$UNESC^LA7VHLU3(SUBID,LA7FS_LA7ECH)
 S SUBID=$$TRIM^XLFSTR(SUBID)
 S SUBID=$$MAKEISO^LRVRMI1(LA74,SUBID)
 S PSUBID=$$TRIM^XLFSTR($G(LAPSUBID))
 S PSUBID=$$MAKEISO^LRVRMI1(LA74,PSUBID)
 I SUBID="" S SUBID=PSUBID
 ;
 ; Need to override the concept?
 S CNCPTOR=0
 I OBX5[LA7CS,+DSOBX5=-1 D
 . S LAX=$P(DSOBX5,"^",5)
 . I LAX,LAX'=LA76247 S CNCPTOR=1,LA76247=LAX
 ;
 ; Override LOINC codes to handle fact that some generic codes can be applied to more than one storage location.
 ;
 ; Check if VA SP Frozen Section and use VA NLT to find concept - SP FROZEN SECTION and SP MICROSCOPIC DESCRIPTION use same LOINC code.
 I LA76247=56,$G(OBX3(6))="99VA64",$P(OBX3(4),".")="88569" D
 . N X
 . S X=$$HL2LAH^LA7VHLU6(OBX3(4),OBX3(5),OBX3(6),OBX3(8),LA76248,"SP")
 . I X>0 S LA76247=+X
 ;
 D SET(LA76247)
 Q
 ;
 ;
SET(R6247) ;
 ;
 ;ZEXCEPT: LA74,LA7ECH,LA7FS,LA7ISQN,LA7KILAH,LA7QUIT,LA7RLNC,LA7RNLT,LA7RO,LA7SS,LA7VTYP,LWL,OBX,OBX3,OBX5,OBX11
 ;
 N I,ISQN2,ISQN3,NODE,REC,RSZ,SUB,VAL,X,Y
 ;
 D SETSUB
 ;
 ; If SUB=-1 then something went wrong
 ; Error: No filing method found for OBX3
 I SUB<0 D  Q
 . N LA7VOBX3
 . S LA7VOBX3=OBX3
 . D CREATE^LA7LOG(202)
 . S LA7KILAH=1,LA7QUIT=2
 ;
 ;
 ; Need to develop logic to handle specimen multiple - JMC/13 Nov 2009.
 I SUB?1(1"50") Q
 ;
 S NODE=SUB
 ; WP subscript
 K ISQN3
 S (REC,ISQN2)=+$O(^LAH(LWL,1,LA7ISQN,LA7SS,SUB,"A"),-1)
 ;
 ; These reports store one more level in (need ISQN2 in NODE)
 I R6247?1(1"59",1"62",1"69",1"78") D
 . I ISQN2<1 S ISQN2=1
 . S NODE=NODE_","_ISQN2
 . S ISQN3=+$O(^LAH(LWL,1,LA7ISQN,LA7SS,SUB,ISQN2,1,"A"),-1)
 ;
 S NODE=NODE_",0"
 D LAH(NODE,1,LA74)
 S X=$P(LA7RO,"^",3)
 D LAH(NODE,2,X)
 D LAH(NODE,3,LA7RLNC)
 D LAH(NODE,4,LA7RNLT)
 D LAH(NODE,5,OBX11)
 ;
 ; Suppl Rpt Release Date from OBR-22
 I R6247?1(1"59",1"62",1"69",1"78") D LAH(NODE,6,$G(LA7RSDT))
 ;
 ; file WP nodes
 I LA7VTYP="FT" D
 . K X,Y,VAL
 . S X(1)=OBX5
 . D UNESCFT^LA7VHLU3(.X,LA7FS_LA7ECH,.Y)
 . S X=""
 . F  S X=$O(Y(X)) Q:'X  D  ;
 . . D REPT2ARR^LA7VHLU7(Y(X,0),LA7FS_LA7ECH,.VAL)
 . ;
 ;
 I LA7VTYP'="FT" D
 . K VAL
 . D REPT2ARR^LA7VHLU7(OBX5,LA7FS_LA7ECH,.VAL)
 ; resize array so it fits on global node
 K RSZ
 D RSZARR(.VAL,.RSZ,245)
 K VAL
 S I=0
 I $D(ISQN3) S REC=ISQN3
 F  S I=$O(RSZ(I)) Q:'I  D
 . S REC=REC+1
 . ; need to reset NODE depending on levels needed
 . S NODE=SUB_","_REC_",0"
 . I "^59^62^69^78^"[("^"_R6247_"^") S NODE=SUB_","_ISQN2_",1,"_REC_",0"
 . D LAH(NODE,-1,RSZ(I))
 ;
 K RSZ
 D NTE
 Q
 ;
 ;
LAH(LANODE,LAP,LAVAL) ; Convenience method
 ;
 Q:LAVAL=""
 D LAH^LAGEN(+$G(LWL),+$G(LA7ISQN),LA7SS,LANODE,LAP,LAVAL)
 Q
 ;
 ;
NTE ; Convenience method
 ;
 ;ZEXCEPT: ISQN2,R6247
 D NTE^LA7VIN71(R6247,ISQN2)
 Q
 ;
 ;
RSZARR(IN,OUT,LEN) ; Resizes the values of an array
 ; ie resize string lengths to fit on global nodes
 N I,II,J,X
 S LEN=+$G(LEN)
 Q:LEN<1
 S (I,II)=0
 F  S I=$O(IN(I)) Q:'I  D
 . I $L(IN(I))'>LEN S II=II+1 S OUT(II)=IN(I) Q
 . S X=IN(I)
 . S II=$O(OUT("A"),-1)
 . F  Q:X=""  S II=II+1 S OUT(II)=$E(X,1,LEN) S X=$E(X,LEN+1,$L(X))
 Q
 ;
 ;
SETSUB ; Set SUB to subcript for this concept.
 ;
 ;ZEXCEPT: R6247,SUB
 S SUB=-1
 ;
 ; SP subscript
 I R6247=50 S SUB=.1 Q
 I R6247=51 S SUB=.2 Q
 I R6247=52 S SUB=.3 Q
 I R6247=53 S SUB=.4 Q
 I R6247=54 S SUB=.5 Q
 I R6247=55 S SUB=1 Q
 I R6247=56 S SUB=1.1 Q
 I R6247=57 S SUB=1.3 Q
 I R6247=58 S SUB=1.4 Q
 I R6247=59 S SUB=1.2 Q
 I R6247=62 S SUB=1.2 Q
 I R6247=80 S SUB=99 Q
 ;
 ; CY subscript
 I R6247=63 S SUB=.2 Q
 I R6247=64 S SUB=1 Q
 I R6247=65 S SUB=1.1 Q
 I R6247=66 S SUB=.4 Q
 I R6247=67 S SUB=.3 Q
 I R6247=68 S SUB=.5 Q
 I R6247=69 S SUB=1.2 Q
 I R6247=81 S SUB=99 Q
 I R6247=83 S SUB=1.4 Q
 ;
 ; EM subscript
 I R6247=71 S SUB=.2 Q
 I R6247=72 S SUB=1 Q
 I R6247=73 S SUB=1.1 Q
 I R6247=74 S SUB=.4 Q
 I R6247=75 S SUB=.5 Q
 I R6247=76 S SUB=.3 Q
 I R6247=78 S SUB=1.2 Q
 I R6247=82 S SUB=99 Q
 I R6247=84 S SUB=1.4 Q
 ;
 Q
