PRCH128P ;VMP/RB - FIX ^DD(443.61,8) & ^DD(442.01,8) FSC FIELD#8 ENTRY ;03/09/10
 ;;5.1;IFCAP;**128**;03/31/10;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;;
 Q
FIXDD ;
 ;1. Post install to delete node 9 from ^DD(443.61,8) (FSC) to insure
 ;   the field update in patch cleans up node ^DD(443.61,8,9). This
 ;   is a field under subfile Item (443.61).
 ;2. Post install to delete node 9 from ^DD(442.01,8) (FSC) to insure
 ;   the field update in patch cleans up node ^DD(442.01,8,9). This
 ;   is a field under subfile Item (442.01).
 ;
KILL K ^DD(443.61,8,9),^DD(442.01,8,9)
 Q
