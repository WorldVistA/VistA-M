LRUC ;DALISC/CYM  GET LOCATIONS BY DIVISION ; 9/13/1999
 ;;5.2;LAB SERVICE;**72,247**;Sep 27, 1994
 ; Called from input transform of LOCATION field (#65.03,.04)
 S DIC="^SC(",DIC(0)="EQMZ",DIC("S")="I '$P(^(0),U,15)!(DUZ(2)=+$$SITE^VASITE(DT,+$P(^(0),U,15)))"
 D ^DIC K DIC
 I Y>0 S X=$P(Y,U,2) Q
GET D EN^DDIOL("You must choose a location","","!,?5,$C(7)")
 D EN^DDIOL("Do you want to see the entire HOSPITAL LOCATION File?","","!,?3")
 S %=1 D YN^LRU I %=1 D
 . S DIC="^SC(",DIC(0)="AEQMZ",DIC("S")="I '$P(^(0),U,15)!(DUZ(2)=+$$SITE^VASITE(DT,+$P(^(0),U,15)))"
 . D ^DIC K DIC
 I Y=-1 K X Q
 I Y>0 S X=$P(Y,U,2) Q
 Q
EN D EN^DDIOL("Please choose a location within your division","","!,?3,$C(7)")
 D EN^DDIOL("Type in at least two characters of your choice","","!,?3")
 D EN^DDIOL("    OR type in ^ to exit","","!,?5")
 Q
