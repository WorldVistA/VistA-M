RA26PST1 ;HIRMFO/CRT - Post-init number one (patch 26) ;5/19/99
VERSION ;;5.0;Radiology/Nuclear Medicine;**26**;Mar 16, 1998
 ;
EN1 ; *** Add "ACT" node for Rad Reports file 74 to add security ***
 ; *** restrictions. ***
 ;
 N RATXT
 ;
 I '$D(^DD(74,0,"ACT")) D
 .S RATXT(1)="Editing RAD/NUC MED REPORTS file #74"
 .S RATXT(2)="to add patient related safeguards..."
 .D MES^XPDUTL(.RATXT)
 .S ^DD(74,0,"ACT")="N DFN S DFN=$P(^RARPT(+Y,0),""^"",2) S Y=DFN D ^DGSEC"
 ;
END ; *** End ***
 ;
 D BMES^XPDUTL(" ")
 Q
