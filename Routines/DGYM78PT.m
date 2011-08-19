DGYM78PT ;ALB/MLI - Post-install routine for DG*5.3*78 ; 3/4/96@925
 ;;5.3;Registration;**78**;Aug 13, 1993
 ;
 ; This post-install routine will check the Medical Center Division
 ; file to ensure that each entry has a unique pointer to the
 ; Institution file.  It will also delete the .001 field in the
 ; Eligibility code file (#8) if one exists.
 ;
EN ; begin processing
 D ELIG
 D DIV
 Q
 ;
 ;
ELIG ; look for .001 field in file 8...delete if there
 N DA,DIK
 I $D(^DD(8,.001)) D
 . D BMES^XPDUTL(">>> .001 Field of Eligibility code file found and deleted...")
 . S DIK="^DD(8,",DA=.001,DA(1)=8
 . D ^DIK
 Q
 ;
 ;
DIV ; search for problems with medical center division/institution relationship
 N CT,I,X
 D BMES^XPDUTL(">>> Searching for entries in the Medical Center Division file that")
 D MES^XPDUTL("    don't have a pointer to the Institution file...")
 S (CT,I)=0 F  S I=$O(^DG(40.8,I)) Q:'I  D
 . S X=$G(^DG(40.8,I,0))
 . I $G(^DIC(4,+$P(X,"^",7),0))']"" D
 . . D DIVNAME(I)
 . . S CT=CT+1
 I 'CT D MES^XPDUTL("       All divisions ok.  No problems found!")
 ;
 ;
 D BMES^XPDUTL(">>> Searching for entries in the Medical Center Division file that")
 D MES^XPDUTL("    point to the same Institution file entry...")
 S (CT,I)=0 F  S I=$O(^DG(40.8,"AD",I)) Q:'I  D
 . S X=$O(^DG(40.8,"AD",I,0))
 . I '$O(^DG(40.8,"AD",I,X)) Q  ; no duplicate pointers
 . S J=0 F  S J=$O(^DG(40.8,"AD",I,J)) Q:'J  D
 . . S CT=CT+1
 . . D DIVNAME(J)
 I 'CT D MES^XPDUTL("       All divisions ok.  No problems found!")
 Q
 ;
 ;
DIVNAME(IEN) ; print out division with institution pointer
 ;
 ; input - IEN as IEN of the entry in the Medical Center Division file.
 ;
 N X,Y
 S X=$G(^DG(40.8,+IEN,0)),Y=$P($G(^DIC(4,+$P(X,"^",7),0)),"^",1)
 S STRING=$S($P(X,"^",1)]"":$P(X,"^",1),1:"UNKNOWN DIVISION")_" (IEN #"_IEN_")"
 S STRING=STRING_" points to "_$S(Y]"":Y_" institution (IEN #"_+$P(X,"^",7)_")",1:"no institution")
 D MES^XPDUTL(STRING)
 Q
