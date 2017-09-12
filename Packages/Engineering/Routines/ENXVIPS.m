ENXVIPS ;WIRMFO/SAB- POST-INIT ;7/10/97
 ;;7.0;ENGINEERING;**39**;Aug 17, 1993
 ;
 ; Populate new B1 x-ref in CMR file (#6914.1)
 S DIK="^ENG(6914.1,",DIK(1)=".01^B1" D ENALL^DIK K DIK
 ;
 ; only do remaining steps during 1st install
 I $$PATCH^XPDUTL("EN*7.0*39") D BMES^XPDUTL("  Skipping FR Documents step since patch was previously installed.") Q
 ;
 D BMES^XPDUTL("  Sending computed Cost Centers to FAP on FR DOCUMENTs")
 ; send FR Documents (with cost center) for all capitalized equipment
 K ^TMP($J,"BAD")
 S XPDIDTOT=100 ; set total for status bar
 ; loop thru national EIL codes
 S ENEIL("DA")=0
 F  S ENEIL("DA")=$O(^ENG(6914.9,ENEIL("DA"))) Q:'ENEIL("DA")  D
 . S ENEIL=$P($G(^ENG(6914.9,ENEIL("DA"),0)),U)
 . Q:$P($G(^ENG(6914.9,ENEIL("DA"),0)),U,2)=""  ; no cost center
 . S X=$$FREIL^ENFAEIL(ENEIL) ; send FR DOCUMENTs for equipment on EIL
 . I '(ENEIL("DA")#10) D UPDATE^XPDID(ENEIL("DA")) ; update status bar
 ; report any problems
 I $D(^TMP($J,"BAD")) D FRERR^ENFAEIL K ^TMP($J,"BAD")
 Q
 ;ENXVIPS
