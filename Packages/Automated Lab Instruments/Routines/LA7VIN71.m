LA7VIN71 ;DALOI/JDB - HANDLE ORU OBX FOR MICRO ;03/17/11  13:57
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 ; Continuation of LA7VIN7 and is only called from there.
 ; Process OBX segments for "MI" subscript tests.
 Q
 ;
 ;
PROCESS ;
 ; File MI ^LAH for a given concept (LA76247)
 ; Called from OBX^LA7VIN7 for Micro data
 ; Major variables from LA7VIN7:
 ; DSOBX3,DSOBX5,LA76247,LA7SCT,OBX5,LA7612
 ;
 N SUBID,PSUBID,DDS,DDP,LA7DD,LAX,RMK,CNCPTOR
 S LA7DD=$$GET1^DID($P(DSOBX3,"^",3),$P($P(DSOBX3,"^",4),";"),"","GLOBAL SUBSCRIPT LOCATION")
 S LA7DD("LABEL")=$$GET1^DID($P(DSOBX3,"^",3),$P($P(DSOBX3,"^",4),";"),"","LABEL")
 S DDS=$P(LA7DD,";",1)  ;DD Subscript
 S DDP=$P(LA7DD,";",2)  ;DD Piece
 S:DDS="" DDS=-1
 S:DDP="" DDP=-1
 ;
 S SUBID=$G(OBX4)
 S SUBID=$$UNESC^LA7VHLU3(SUBID,LA7FS_LA7ECH)
 S SUBID=$$TRIM^XLFSTR(SUBID)
 S SUBID=$$MAKEISO^LRVRMI1(LA74,SUBID)
 S PSUBID=$$TRIM^XLFSTR($G(LAPSUBID))
 S PSUBID=$$MAKEISO^LRVRMI1(LA74,PSUBID)
 I SUBID="" S SUBID=PSUBID
 ;
 I 'LA7612 D  ; S LA7612=0 ;#61.2 IEN
 . S LAX=$P(DSOBX5,"^",1)
 . I $P(LAX,";",2)="LAB(61.2," S LA7612=$P(LAX,";",1)
 ;
 ; Need to override the concept?
 S CNCPTOR=0
 I OBX5[LA7CS,+DSOBX5=-1 D
 . S LAX=$P(DSOBX5,"^",5)
 . I LAX,LAX'=LA76247 S CNCPTOR=1,LA76247=LAX
 ;
 ;
 ; Override LOINC codes to handle fact that some generic codes can be applied to more than one storage location.
 ;
 ; Check if URINE or SPUTUM SCREEN and use VA NLT to find concept
 ;  - URINE and SPUTUM SCREEN uses same LOINC code for organsimn identified (positive/negative culture)
 I LA76247=3,$G(OBX3(6))="99VA64",$P(OBX3(4),".")?1(1"93948",1"93949") D
 . N X
 . S X=$$HL2LAH^LA7VHLU6(OBX3(4),OBX3(5),OBX3(6),OBX3(8),LA76248,"MI")
 . I X>0 S LA76247=+X
 ;
 ; COLONY COUNT used for ORGANISM(sub=3,6247=10), FUNGUS/YEAST(sub=9,6247=11) and MYCOBACTERIUM(sub=12,6247=20)
 ; Get previous ^LAH node used by using the whole record subid C xref
 I LA7RLNC="564-5" D
 . N SUB
 . S SUB=$O(^LAH(LWL,1,ISQN,"MI","C",SUBID,0))
 . I SUB>0 S LA76247=$S(SUB=3:10,SUB=9:11,SUB=12:20,1:LA76247)
 ;
 ; Check if VA AFB quantity and use VA NLT to find concept - AFB Stain and AFB Quantity use same LOINC code.
 I LA76247=79,$G(OBX3(6))="99VA64",$P(OBX3(4),".")="87583" D
 . N X
 . S X=$$HL2LAH^LA7VHLU6(OBX3(4),OBX3(5),OBX3(6),OBX3(8),LA76248,"MI")
 . I X>0 S LA76247=+X
 ;
 ; Check if Organism should be stored under Bacteriology section instead of MI section determined by OBX-3 mapping.
 ; Used in cases where a Parasite, Fungus, Mycobacterium, or Virus was reported on a Bacterial culture.
 S LA76247=$$BACTCHK^LA7VHLUB(LA7ONLT,LA7AA,LA7AD,LA7AN,LA76247)
 ;
 ;
 I LA76247=1 D 1^LA7VIN7A Q  ;subscr 2
 I LA76247=3 D 3^LA7VIN7A Q  ;subscr 3
 I LA76247=4 D 4^LA7VIN7B Q  ;subscr 12
 I LA76247=5 D 5^LA7VIN7C Q  ;subscr 17
 I LA76247=6 D  Q  ; subscr 4
 . I 'CNCPTOR D 6^LA7VIN7A()
 . I CNCPTOR D 6^LA7VIN7A($$BLDRMK())
 I LA76247=7 D 7^LA7VIN7A Q  ;subscr 3
 I LA76247=8 D 8^LA7VIN7D Q  ;subscr 6
 I LA76247=9 D 9^LA7VIN7B Q  ;subscr 9
 I LA76247=10 D 10^LA7VIN7A Q  ;subscr 3
 I LA76247=11 D 11^LA7VIN7B Q  ;subscr 9
 I LA76247=12 D 12^LA7VIN7D() Q  ;subscr 7
 I LA76247=13 D 13^LA7VIN7D Q  ;subscr 6
 I LA76247=14 D 14^LA7VIN7D Q  ;subscr 6
 I LA76247=15 D 15^LA7VIN7B() Q  ;subscr 10
 I LA76247=16 D 16^LA7VIN7A Q  ; subscr 1
 I LA76247=17 D 17^LA7VIN7A Q  ; subscr 1
 I LA76247=20 D 20^LA7VIN7B Q  ;subscr 12
 I LA76247=21 D 21^LA7VIN7B Q  ;subscr 12
 I LA76247=22 D 22^LA7VIN7C() Q  ;subscr 13
 I LA76247=30 D 30^LA7VIN7C() Q  ;subscr 18
 ;
 I LA76247>39,LA76247<48 D NODE^LA7VIN7C(LA76247,"") Q
 ;
 I LA76247=79 D 79^LA7VIN7B Q  ;subscr 11
 I LA76247=85 D 85^LA7VIN7B Q  ;subscr 11
 ;
 I LA76247>85,LA76247<91 D NODE^LA7VIN7C(LA76247,"") Q
 ;
 ;
 ; If we get this far then something went wrong
 ; Error: No filing method found for OBX
 D  ;
 . N LA7VOBX3
 . S LA7VOBX3=OBX3
 . D CREATE^LA7LOG(202)
 . S LA7KILAH=1 S LA7QUIT=2
 ;
 Q
 ;
 ;
BLDRMK() ;
 ; Constructs comment/remarks for special situations like
 ; processing an OBX5 with flora normal (which gets filed as a
 ; Bact RPT REMARK).
 ;
 ; If there's an SCT code:
 ;   [SUBID]SCT Text
 ;
 ; If no SCT code:
 ;    If OBX5 contains HL7 component sep, 2nd piece of first tuplet
 ;    else its the full OBX5 text
 ;    [SUBID]OBX5 text
 ;
 N X,TXT,SID
 S X=SUBID
 S:X="" X=$G(PSUBID)
 S:X'="" X="["_X_"]"
 S SID=X
 S TXT=""
 I LA7SCT'="" D  ;
 . N SCT
 . S X=$$CODE^LRSCT(LA7SCT,"SCT",,"SCT")
 . S TXT=$G(SCT("P"))
 . S:TXT="" TXT=$G(SCT("F"))
 . I TXT="" D  ;
 . . N DATA,CODSYS
 . . S DATA=OBX5
 . . D FLD2ARR^LA7VHLU7(.DATA)
 . . D CODSYS^LA7VHLU7(.DATA,.CODSYS,"SCT")
 . . S TXT=$G(CODSYS(2))
 . . K DATA,CODSYS
 . S:TXT="" TXT="SCT:"_LA7SCT
 I LA7SCT="" D  ;
 . I OBX5[LA7CS S TXT=$P(OBX5,LA7CS,2)
 . I TXT="" S TXT=OBX5
 . S TXT=$$UNESC^LA7VHLU3(TXT,LA7FS_LA7ECH)
 Q SID_TXT
 ;
 ;
STRSPLIT(STR,MAXLEN,OUT) ;
 ; Splits a string into substrings no more than MAXLEN long
 ; Useful when storing things such as COMMENT fields
 N I,Y,SUBS
 S SUBS=$L(STR)\MAXLEN
 S:($L(STR)#MAXLEN)>0 SUBS=SUBS+1
 F I=0:1:SUBS-1 S Y=(I*MAXLEN)+1 D  ;
 . S OUT(I+1)=$E(STR,Y,(Y+MAXLEN)-1)
 . S Y=Y+MAXLEN
 Q SUBS
 ;
 ;
NTE(R6247,I,PREFIX) ;
 ; Set variable for HL7 NTE processing
 ; Inputs
 ;   R6247  : #62.47 IEN (Concept)
 ;       I  : Usually either ISQN or ISQN2
 ;   PREFIX : text of prefix (optional)
 S LA7RMK(0,0)=R6247_"^"_I_"^"_$G(PREFIX)
 Q
 ;
 ;
SUBIDERR ;
 ; Error handler when subid (OBX4) is null or unknown
 N LA7VOBX3,LA7VOBX4
 S LA7VOBX3=OBX3
 S LA7VOBX4=OBX4
 D CREATE^LA7LOG(205)
 S LA7KILAH=1 S LA7QUIT=2
 Q
