GMRA2PRE ;HIRMFO/FPT-Pre-init for GMRA*4*2 ;7/24/96  08:43
 ;;4.0;Adverse Reaction Tracking;**2**;Mar 29, 1996
 ;
 ; This pre-init for patch #2 does the following:
 ; 1) deletes the Soundex cross-reference on File 120.82 Field #.01,
 ; 2) fixes bad data in File 120.86
 ;
 D DEL01,ERR
 Q
 ;
DEL01 ; Delete ^DD(120.8,.01 and ^GMRD(120.8,"SOUND")
 ; This field will be restored in the installation process without
 ; the soundex cross-reference
 S DA=.01,DA(1)=120.82,DIK="^DD(120.82," D ^DIK
 K ^GMRD(120.82,"SOUND"),DA,DIK
 Q
ERR ; Delete patient assessment entry in file 120.86 if second piece is 1
 ; and there are no active entries (i.e., not entered-in-error) in
 ; file 120.8 for the patient.
 ; In File 120.86, fix missing .01 value, delete erroneous 5th piece and
 ; fix 2nd piece.
 S GMRALOOP=0
 F  S GMRALOOP=$O(^GMR(120.86,GMRALOOP)) Q:GMRALOOP'>0  D
 .S GMRANODE=$G(^GMR(120.86,GMRALOOP,0)) ;get zero node
 .S GMRAPRA=$P(GMRANODE,U,2) ;pt reaction assessment
 .I $P(GMRANODE,U,5)]"" S $P(^GMR(120.86,GMRALOOP,0),U,5)="" ;clean out 5th piece
 .I $P(GMRANODE,U,1)="" S $P(^GMR(120.86,GMRALOOP,0),U,1)=GMRALOOP,DA=GMRALOOP,DIK="^GMR(120.86,",DIK(1)=".01" D EN^DIK K DIK(1) ;put in missing name pointer
 .I GMRAPRA=1 I $$NKASCR^GMRANKA(GMRALOOP) S DA=GMRALOOP,DIK="^GMR(120.86," D ^DIK W:$E(IOST)="C" "." Q  ;delete 120.86 entries if assessment=1, but nka
 .I GMRAPRA'=0,GMRAPRA'=1 D  ;look for garbage in pt reaction assessment
 ..S GMRANKA=$$NKASCR^GMRANKA(GMRALOOP) ;pt has reactions (0) or nka (1)
 ..I GMRANKA=1 S DA=GMRALOOP,DIK="^GMR(120.86," D ^DIK W:$E(IOST)="C" "." Q  ;delete 120.86 entry if nka
 ..I GMRANKA=0 S $P(^GMR(120.86,GMRALOOP,0),U,2)=1 ;set pt assessment=1
 ..Q
 .Q 
 K DA,DIK,GMA,GMRALOOP,GMRANKA,GMRANODE,GMRAPRA
 Q
