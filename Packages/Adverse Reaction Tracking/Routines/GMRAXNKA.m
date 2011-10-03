GMRAXNKA ;HIRMFO/WAA- No Known Allergies Conversion ; 8/27/93
 ;;4.0;Adverse Reaction Tracking;;Mar 29, 1996
EN1 ; Data conversion of Patient Allergies file from v3.0 -> v4.0
 ;  This conversion does two things:
 ;    1) Moves those records which represent whether a patient
 ;       has been asked about allergies (NKA nodes) from the
 ;       Patient Allergies (120.8) to Adverse Reaction Assessment 
 ;       (120.86) file.
 ;    2) Converts the set of codes of Comment Type (1.5) sub-field
 ;       of the Comments (26) field from old values to new values.
 ;         Old       New
 ;         ---       ---
 ;          y         V
 ;          n         O
 ;
 K GMRATXT S GMRATXT(1)="Move 120.8 NKA Cross Reference to 120.86...." D BMES^XPDUTL(.GMRATXT) K GMRATXT
 S GMRAPA=0 F  S GMRAPA=$O(^GMR(120.8,GMRAPA)) Q:GMRAPA'>0  D
 . S GMRAPA(0)=$G(^GMR(120.8,GMRAPA,0)) Q:GMRAPA(0)=""
 . S GMAYN=$P(GMRAPA(0),U,22)
 . I $L($P(GMRAPA(0),U,2)) D  ; convert comments.
 . . D COMMENTS(GMRAPA)
 . . Q
 . E  I GMAYN'="" D  ; Move NKA entry out of file 120.8
 . . D NKA(.GMRAPA)
 . . Q
 . Q
 S DA(1)=120.8,DA=.03,DIK="^DD("_DA(1)_"," D ^DIK ; delete .03 field.
 K ^GMR(120.8,"ANKA") ; Kill off any remaining "ANKA" xrefs.
 Q
NKA(GMAPA) ; Move No Known Allergies field from 120.8 file to 120.86 file.
 G:+$G(^GMR(120.8,GMAPA,"ER")) ERR ; if node E/E don't move to 120.86
 N DFN,GMAYNN,GMAX
 S DFN=$P(GMAPA(0),U) G:DFN'>0 ERR ; if no patient, dont move to 120.86
 I '$D(^GMR(120.86,DFN,0)) D  ; Add a new 120.86 file entry.
 . S GMAX=$G(^GMR(120.86,0)) S:GMAX="" GMAX="ADVERSE REACTION ASSESSMENT^120.86P^0^0"
 . S $P(GMAX,U,3,4)=$S(DFN>$P(GMAX,U,3):DFN,1:$P(GMAX,U,3))_U_($P(GMAX,U,4)+1)
 . S ^GMR(120.86,DFN,0)=DFN
 . S DIK="^GMR(120.86,",DA=DFN D IX1^DIK
 . S ^GMR(120.86,0)=GMAX
 . Q
 S GMAYNN=$P($G(^GMR(120.86,DFN,0)),U,2),GMAYN=$P(GMAPA(0),U,22)
 I GMAYNN'="y",GMAYNN=""!(GMAYNN="n"&(GMAYN="y")) D  ; update file 120.86
 . N GMRAYN S GMRAYN=$S($P(GMAPA(0),U,22)="y":"1",1:"0")
 . S DR="1////"_GMRAYN_";2////"_$P(GMAPA(0),U,5)_";3////"_$P(GMAPA(0),U,4)
 . S DIE="^GMR(120.86,"  D ^DIE
 . Q
ERR ; jump here if this NKA node was entered in error, or no patient found
 S DIK="^GMR(120.8,",DA=GMAPA D ^DIK ; delete old entry
 W:'$D(ZTQUEUED)&'$R(100) "."
 Q
COMMENTS(GMAPA) ; Convert comments
 Q:'$D(^GMR(120.8,GMAPA,26,0))  ; no comments to convert
 N GMAPC,GMAX,GMAY,GMAZ
 S GMAPC=0 F  S GMAPC=$O(^GMR(120.8,GMAPA,26,GMAPC)) Q:GMAPC<1  D
 .S GMAY=$G(^GMR(120.8,GMAPA,26,GMAPC,0)) Q:GMAY=""
 .S GMAX=$P(GMAY,U,3) Q:"^y^n^"'[(U_GMAX_U)
 .S GMAZ=$S(GMAX="y":"V",1:"O")
 .S DA(1)=GMAPA,DA=GMAPC,DIE="^GMR(120.8,"_DA(1)_",26,",DR="1.5////"_GMAZ
 .D ^DIE W:'$D(ZTQUEUED)&'$R(50) "."
 .Q
 Q
