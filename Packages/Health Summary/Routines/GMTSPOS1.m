GMTSPOS1 ;SLC/SBW - Smart routine installer and Comp. Disabler ;22/MAR/95
 ;;2.7;Health Summary;**129**;Oct 20, 1995;Build 8
 ;Per VHA Directive 2004-038, this routine should not be modified
PSO ; Controls Outpatient Pharmacy install
 N GMPSOVER
 ;If Health Summary is absent, then quit
 I '$L($T(^PSOHCSUM)) Q
 S GMPSOVER=$$VERSION^XPDUTL("PSO")
 D PSOINST(GMPSOVER)
 Q
PSOINST(VERSION) ; Install routine corresponding to HS version in
 ;                 target account
 ; If the patch is already installed, then quit w/o overwriting
 N DIE,DIF,GMMSG,X,XCN,XCNP
 I VERSION'<6.0 Q
 W !,"** Installing GMTSPSO routine for Outpatient Pharmacy component. **"
 W !,"   Outpatient Pharmacy version ",VERSION," is installed in this account.",!
 S X="GMTSPSZO",XCNP=0,DIF="^UTILITY(""GMTSPSZO""," X ^%ZOSF("LOAD") W !,"Renaming GMTSPSZO as GMTSPSO."
 S X="GMTSPSO",XCN=2,DIE="^UTILITY(""GMTSPSZO""," X ^%ZOSF("SAVE") K ^UTILITY("GMTSPSZO") W "  Done.",!
 Q
 ;******************************************************
 ; Entry points for SOWK & SOWKINST removed with patch GMTS*2.7*129
 ;******************************************************
MED ; Controls Medicine 2.0 install and disable 2.2 components
 N X,GMMSG
 ;Checks conditions for auto-disable of Medicine 2.2 components
 I $$VERSION^XPDUTL("MC")<2.2 D
 . S GMMSG="Medicine 2.2 Package not yet installed or available"
 . F X="MEDICINE ABNORMAL BRIEF","MEDICINE BRIEF REPORT","MEDICINE FULL CAPTIONED","MEDICINE FULL REPORT" D DISABLE^GMTSPOST
 . ;If Medicine 2.2 not installed, restore 2.0 medicine routines
 . W !,"** Installing GMTSMCPS routine for Medicine 2.0 component. **"
 . D MED2INST
 I $$VERSION^XPDUTL("MC")>2.19 D M22INST
 Q
MED2INST ; Install GMTSMCPS routine for med 2.0
 N DIE,DIF,GMMSG,X,XCN,XCNP
 S X="GMTSMCPZ",XCNP=0,DIF="^UTILITY(""GMTSMCPZ""," X ^%ZOSF("LOAD") W !,"Renaming GMTSMCPZ as GMTSMCPS."
 S X="GMTSMCPS",XCN=2,DIE="^UTILITY(""GMTSMCPZ""," X ^%ZOSF("SAVE") K ^UTILITY("GMTSMCPZ") W "  Done.",!
 Q
M22INST ; Install GMTSMCPS routine for med 2.2
 W !,"** Installing GMTSMCPS routine for Medicine 2.2 components. **"
 N DIE,DIF,GMMSG,X,XCN,XCNP
 S X="GMTSMCZZ",XCNP=0,DIF="^UTILITY(""GMTSMCZZ""," X ^%ZOSF("LOAD") W !,"Renaming GMTSMCZZ as GMTSMCPS."
 S X="GMTSMCPS",XCN=2,DIE="^UTILITY(""GMTSMCZZ""," X ^%ZOSF("SAVE") K ^UTILITY("GMTSMCZZ") W "  Done.",!
 Q
 ;******************************************************
PL ; Controls Problem List 2.0 install
 ; Checks conditions for auto-disable of Problem List components
 N X,GMMSG
 I $$VERSION^XPDUTL("GMPL")<2 D
 . S GMMSG="Problem List 2.0 Package not yet installed or available"
 . F X="PROBLEM LIST ACTIVE","PROBLEM LIST INACTIVE","PROBLEM LIST ALL" D DISABLE^GMTSPOST
 I $$VERSION^XPDUTL("GMPL")>1.99 D
 . W !,"** Installing GMPLHS routine for Problem List components. **"
 . D PLINST
 Q
PLINST ; Install GMPLHS routine
 N DIE,DIF,GMMSG,X,XCN,XCNP
 W !,"Renaming GMTSPLSZ as GMPLHS."
 S X="GMTSPLSZ",XCNP=0,DIF="^UTILITY(""GMTSPLSZ""," X ^%ZOSF("LOAD") W "."
 S X="GMPLHS",XCN=2,DIE="^UTILITY(""GMTSPLSZ""," X ^%ZOSF("SAVE") K ^UTILITY("GMTSPLSZ") W "  Done."
 Q
