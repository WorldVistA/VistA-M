ENXTIPS ;WIRMFO/SAB-Patch Post-init (EN*7*38) ;10/21/96
 ;;7.0;ENGINEERING;**38**;Aug 17, 1993
 N ENDA,ENEQ,ENY
 ; move asset value from FD turn-in documents to new Orig. Asset Value
 ; loop thru FD Documents
 D BMES^XPDUTL("  Populate ORIGINAL ASSET VALUE from FD-T Documents...")
 S ENDA=0 F  S ENDA=$O(^ENG(6915.5,ENDA)) Q:'ENDA  D
 . S ENY=$G(^ENG(6915.5,ENDA,100))
 . Q:$P(ENY,U)'="T"  ; not for turn-in
 . Q:$P(ENY,U,2)'>0  ; no asset value recorded
 . S ENEQ=$P($G(^ENG(6915.5,ENDA,0)),U) Q:'ENEQ  ; missing equipment IEN
 . ; update original asset value when blank
 . I $P($G(^ENG(6914,ENEQ,3)),U,15)="" S $P(^(3),U,15)=$P(ENY,U,2)
 D MES^XPDUTL("  Completed post-init.")
 Q
 ;ENXTIPS
