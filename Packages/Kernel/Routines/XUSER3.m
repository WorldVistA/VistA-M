XUSER3 ;ISF/RWF - New Person File Utilities ;02/01/2022
 ;;8.0;KERNEL;**688**;Jul 10, 1995;Build 58
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
VALN1DEA(X,F) ;Check for a valid DEA# in the NEW DEA FIELD OF FILE #200, 53.21, .01
 ;Returns 0 for NOT Valid, 1 for Valid
 ;F = 1 for Facility DEA check.
 S F=$$FACILITY(X)
 I $D(X) I $L(X)>9 K X D EN^DDIOL($C(7)_"Exceeds maximum length (9).")
 I $D(X) I $L(X)<9 K X D EN^DDIOL($C(7)_"Less than minimum length (9).")
 I $D(X) I '(X?2U7N) K X D EN^DDIOL($C(7)_"Invalid format. Must be 2 upper case letters followed by 7 digits.")
 S F=$G(F)
 I $D(X),'F,$D(DA(1)),$D(^VA(200,"PS4",X)),$O(^(X,0))'=DA(1) D EN^DDIOL($C(7)_"Provider DEA number is already associated to another profile. Please check the number entered.") K X
 I $D(X),'$$DEANUM(X) D EN^DDIOL($C(7)_"DEA number is invalid.  Please check the number entered.") K X
 I $D(X),'F,$D(DA(1)),$E(X,2)'=$E($P(^VA(200,DA(1),0),"^")) D EN^DDIOL($C(7)_"DEA number doesn't match provider's last name. Please verify the information.") D VALN1P
 Q $D(X)
 ;
VALN1P  ; PAUSE AFTER CHECK SECOND LETTER MESSAGE
 N DIR,X,Y
 S DIR("A")="Type <Enter> to continue",DIR(0)="E" D ^DIR
 Q
 ;
VALN2DEA(X,F,DEADA) ;Check for a valid DEA# in the (NEW) DEA NUMBERS FILE #8991.9
 ;Returns 0 for NOT Valid, 1 for Valid
 ;F = 1 for Facility DEA check.
 I $D(X) I $L(X)>9 K X D EN^DDIOL($C(7)_"Exceeds maximum length (9).")
 I $D(X) I $L(X)<9 K X D EN^DDIOL($C(7)_"Less than minimum length (9).")
 I $D(X) I '(X?2U7N) K X D EN^DDIOL($C(7)_"Invalid format. Must be 2 upper case letters followed by 7 digits.")
 S F=$G(F)
 S DEADA=$G(DEADA)
 I $D(X),'$$DEANUM(X) D EN^DDIOL($C(7)_"DEA number is invalid.  Please check the number entered.") K X
 Q $D(X)
 ;
DEANUM(X) ;Check DEA # Numeric Part
 N VA1,VA2
 S VA1=$E(X,3)+$E(X,5)+$E(X,7)+(2*($E(X,4)+$E(X,6)+$E(X,8)))
 S VA1=VA1#10,VA2=$E(X,9)
 Q VA1=VA2
 ;
FACILITY(X) ;
 N DNDEAIEN
 S DNDEAIEN=$O(^XTV(8991.9,"B",X,0)) Q:'DNDEAIEN 0
 Q $$GET1^DIQ(8991.9,DNDEAIEN,.07,"I")=1
 ;
SUFCHK(X,DA) ;Check for a unique suffix. Called from Sub-File #200.5321 field #.02
 N RESPONSE S RESPONSE=0
 G:'$D(X) SUFCHKQ G:'$D(DA) SUFCHKQ G:'$D(DA(1)) SUFCHKQ
 N NPDEATXT S NPDEATXT=$$GET1^DIQ(200.5321,DA_","_DA(1),.01) G:NPDEATXT="" SUFCHKQ
 I $D(^VA(200,"F",NPDEATXT,X)) D EN^DDIOL($C(7)_"That Suffix is in use.  ","","!,?5") S RESPONSE=1
SUFCHKQ ; Unique Suffix Quit Tag
 Q RESPONSE
