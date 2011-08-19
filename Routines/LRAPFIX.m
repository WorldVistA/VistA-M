LRAPFIX ;AVAMC/REG/CYM -FIX ACCESSION X-REF ;5/31/96  10:28
 ;;5.2;LAB SERVICE;**72**;Sep 27, 1994
 ;
 I $D(^LRO(68,"VR")) D BMES^XPDUTL("Looks like you've already run the AP Accession Number conversion") W $C(7),!!
 I $D(^LRO(68,"VR")) D BMES^XPDUTL("Looks like we're done with the Post Install routines") W !!!
 Q:$D(^LRO(68,"VR"))  D G Q:Y=-1
 S LRDFN=0 F  S LRDFN=$O(^LR(LRDFN)) Q:'LRDFN  D
 . S I="" F  S I=$O(^LR(LRDFN,"AU",I)) Q:I=""  K ^(I)
 S LRDFN=0 F  S LRDFN=$O(^LR(LRDFN)) Q:'LRDFN  F LRSS="SP","CY","EM","AU" D @LRSS
 S ^LRO(68,"VR")=5.2 D BMES^XPDUTL("Your AP Accession Numbers have been converted to their new format") D BMES^XPDUTL("WHEW!!!, What a job!!!") W $C(7),!!!
 Q
SP S LRI=0 F  S LRI=$O(^LR(LRDFN,LRSS,LRI)) Q:'LRI  S Y=^(LRI,0),YR=$E($P(Y,"^",10),1,3),LRAN=$P(Y,"^",6) Q:LRAN[" "  I YR>0,LRAN>0 D
 . I $D(^LR("A"_LRSS_"A",YR,LRAN,LRDFN,LRI)) K ^LR("A"_LRSS_"A",YR,LRAN,LRDFN,LRI)
 .  S $P(^LR(LRDFN,LRSS,LRI,0),"^",6)=LRABV(LRSS)_" "_$E(YR,2,3)_" "_LRAN,^LR("A"_LRSS_"A",YR,LRABV(LRSS),LRAN,LRDFN,LRI)=""
 Q
CY D SP Q
 ;
EM D SP Q
 ;
AU Q:'$D(^LR(LRDFN,"AU"))  S Y=$G(^("AU")),YR=$E(Y,1,3),LRAN=$P(Y,"^",6) I LRAN'>0,YR'>0 Q
 Q:LRAN[" "  K:$D(^LR("AAUA",YR,LRAN,LRDFN)) ^(0) I YR,LRAN S $P(^LR(LRDFN,"AU"),"^",6)=LRABV(LRSS)_" "_$E(YR,2,3)_" "_LRAN,^LR("AAUA",YR,LRABV(LRSS),LRAN,LRDFN)=""
 Q
G K DIC S DIC=68,DIC(0)="Z" F X="SURGICAL PATHOLOGY","CYTOPATHOLOGY","EM","AUTOPSY" D A
 K DIC Q
A D ^DIC S LRSS=$P(Y(0),U,2),LRABV=$P(Y(0),U,11) I LRABV=""!(LRSS="") W $C(7),!!,"Must have a lab section and an abbreviation for ",$P(Y,U) S Y=-1 Q
 S LRABV(LRSS)=LRABV Q
