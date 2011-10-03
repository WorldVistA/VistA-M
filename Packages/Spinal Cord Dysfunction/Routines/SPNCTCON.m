SPNCTCON ;WDE/SD CONTINUUM OF CARE MAIN STARTING POINT ;6/27/02  05:15
 ;;2.0;Spinal Cord Dysfunction;**19,20**;01/02/1997
 ;
 ; 
CON ;Starting point called from the option
 ;patient is asked and then spnct is set to 1
 ;  the patients dfn is passed back in SPNFDFN
 D PAT1541^SPNFMENU
 Q:SPNFEXIT=1
 Q:$D(SPNFDFN)=""
 S SPNFEXIT=0,SPNEXIT=0
 S SPNDFN=SPNFDFN
 S SPNCT=4  ;continuum of care
 D OTHER^SPNCTBLD(SPNCT,SPNDFN)  ;build utility with in patient
 D EN^SPNCTSHW(SPNDFN)
 ;        ;^ was entered or they are finished with the group
 I SPNSEL'="A" D ZAP Q
 I SPNCT=1 D IN^SPNCTAA
ZAP ;
 Q
