NURSEXP ;HIRMFO/JH,MD,FT-CHECK AND CLEAN EXPERIENCE SUB-FILE IN FILE 210 ;4/4/97  11:14
 ;;4.0;NURSING SERVICE;;Apr 25, 1997
TXT ;
 ;;This option checks the integrity of the Nurs Staff File's Experience
 ;;sub-file in field 22.5, and makes the following error corrections when
 ;;necessary:
 ;;
 ;;a.  Converts pointer values in the Name field to free text values.
 ;;b.  Removes records with no data or cross-references.
 ;;c.  Rebuilds missing Name entries that have a valid 'B' index entry.
 ;;d.  Converts lower case Name entries to upper case.
 ;;e.  Deletes experience entries missing from the NURS Clinical Background File.
 ;;f.  Deletes duplicate cross references.
 S TXT=$T(TXT) F I=0:1:10 S TXT=$T(TXT+I) W !,$P(TXT,";",3)
 W ! S DIR(0)="E" D ^DIR Q:$G(DIRUT)
 ; RE-CROSSREFERENCE SUB FILE 22.5,
 W @IOF,"Checking Experience sub-file for deficiencies, repairing where necessary.",!
 S II="210.13AI",DA(1)=0 F  S DA(1)=$O(^NURSF(210,DA(1))) Q:DA(1)'>0  S DOUT="" D  W "."
 .  S:$P($G(^NURSF(210,DA(1),20,0)),U,2)'="" $P(^(0),U,2)=II
 .  I $G(^NURSF(210,DA(1),20,0))="" S NOD=0,NOD=$O(^NURSF(210,DA(1),20,NOD)),XRF="",XRF=$O(^NURSF(210,DA(1),20,"B",XRF)) D
 ..  I NOD>0 S ^NURSF(210,DA(1),20,0)="^"_II_"^^" D
 ...  I XRF="",$P($G(^NURSF(210,DA(1),20,NOD,0)),U)="" S DIK="^NURSF(210,DA(1),20," D ^DIK K DIK Q
 ...  I XRF="" S ^NURSF(210,DA(1),20,"B",$P(^NURSF(210,DA(1),20,NOD,0),U),NOD)="" Q
 ..  I NOD'>0 D  Q:DOUT
 ...  I XRF'="" S NURX=$O(^NURSF(210,DA(1),20,"B",XRF,0)),$P(^NURSF(210,DA(1),20,NURX,0),U)=XRF,^NURSF(210,DA(1),20,0)="^"_II_"^^" Q
 ...  Q
 ..  Q
 .  I $G(^NURSF(210,DA(1),20,0))'="" S NOD=0,NOD=$O(^NURSF(210,DA(1),20,NOD)),XRF="",XRF=$O(^NURSF(210,DA(1),20,"B","")) D  Q:DOUT
 ..  I NOD'>0 D  Q:DOUT
 ...  I XRF="" K ^NURSF(210,DA(1),20,0) S DOUT=1 Q  ;KILL ZERO NODE IF NO ENTRY OR XREF
 ...  S $P(^NURSF(210,DA(1),20,XRF,0),U)=$O(^NURSF(210,DA(1),20,"B",XRF,"")) ;Reset .01 field if null and theres a X'REF
 ...  Q
 ..  I NOD>0 D  Q:DOUT
 ...  I XRF="",$P($G(^NURSF(210,DA(1),20,NOD,0)),U)'="" S ^NURSF(210,DA(1),20,"B",$P(^NURSF(210,DA(1),20,NOD,0),U),NOD)="" Q  ;If node and no cross-reference, set XRF
 ...  I XRF="",$P(^NURSF(210,DA(1),20,NOD,0),U)="" K ^NURSF(210,DA(1),20,NOD,0) Q
 ...  I XRF'="",$P(^NURSF(210,DA(1),20,NOD,0),U)="" S $P(^NURSF(210,DA(1),20,NOD,0),U)=XRF
 ...  Q
 ..  Q
 .  S DA=$O(^NURSF(210,DA(1),20,"")) Q:DA=""  S DA=0 F  S DA=$O(^NURSF(210,DA(1),20,DA)) Q:DA'>0  D
 ..  I $E($P(^NURSF(210,DA(1),20,DA,0),U),3)?1.L S NURX=$P(^NURSF(210,DA(1),20,DA,0),U) S $P(^NURSF(210,DA(1),20,DA,0),U)=$$UPPER($P(^NURSF(210,DA(1),20,DA,0),U)) D  ;Converte lower to upper
 ...  K ^NURSF(210,DA(1),20,"B",NURX,DA) S ^NURSF(210,DA(1),20,"B",$P(^NURSF(210,DA(1),20,DA,0),U),DA)=""
 ...  Q
 ..  I $P($G(^NURSF(210,DA(1),20,DA,0)),U)?1.N,$P($G(^NURSF(211.5,$P(^NURSF(210,DA(1),20,DA,0),U),0)),U)'="" S NURX=$P(^NURSF(210,DA(1),20,DA,0),U),$P(^NURSF(210,DA(1),20,DA,0),U)=$P(^NURSF(211.5,$P(^(0),U),0),U) D  ;Convert Pointer to Free Text
 ...  K ^NURSF(210,DA(1),20,"B",NURX,DA) S ^NURSF(210,DA(1),20,"B",$P(^NURSF(210,DA(1),20,DA,0),U),DA)="" ;Replace pointer cross-reference
 ...  Q
 ..  I $P($G(^NURSF(210,DA(1),20,DA,0)),U)?1.N,$G(^NURSF(211.5,$P(^NURSF(210,DA(1),20,DA,0),U),0))="" S DIK="^NURSF(210,DA(1),20," D ^DIK K DIK S DOUT=1 Q  ;Kill Experience field if pointed to nowhere 
 ..  I $P($G(^NURSF(210,DA(1),20,DA,0)),U)?1N.E S DIK="^NURSF(210,DA(1),20," D ^DIK K DIK S DOUT=1 Q  ;Kill entry if erroneous data in .01 field
 ..  Q
 .  S XX="" F I=0:0 S XX=$O(^NURSF(210,DA(1),20,"B",XX)) Q:XX=""  D
 ..  S X=0 F I=0:0 S X=$O(^NURSF(210,DA(1),20,"B",XX,X)) Q:X=""  D
 ...  I $P($G(^NURSF(210,DA(1),20,X,0)),U)'=XX K ^NURSF(210,DA(1),20,"B",XX,X) ;KILL EXCESS XREF's
 ...  Q
 ..  Q
 .  S DIK="^NURSF(210,DA(1),20,",DIK(1)=".01^B" D ENALL^DIK K DIK ;Re-Cross-reference .01 field 
 .  Q
 W !,"Done...",!! D CLOSE^NURSUT1,^NURSKILL
 Q
UPPER(X) ;Convert lower to upper
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
