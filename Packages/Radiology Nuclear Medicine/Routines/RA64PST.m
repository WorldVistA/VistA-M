RA64PST ;Hines OI/GJC - Post-init Driver, patch 64 ;01/05/06  06:32
VERSION ;;5.0;Radiology/Nuclear Medicine;**64**;Mar 16, 1998;Build 5
 ;
EN ; entry point for the post-install logic
 N RACHK
 S RACHK=$$NEWCP^XPDUTL("POST1","EN1^RA64PST")
 ; Add the correct calendar year scaling factors to the correct
 ; imaging type records in the IMAGING TYPE (#79.2) file.
 Q
 ;
EN1 ; Add the scaling facors to the correct IMAGING TYPE file records.
 N RAI,RAX K RAMSG
 F RAI=1:1 S RAX=$T(FACTORS+RAI) Q:RAX=""  D
 .S RAIEN=+$O(^RA(79.2,"B",$P(RAX,";",3),0))
 .I 'RAIEN D  Q
 ..S RATXT(1)="'"_$P(RAX,";",3)_"' not found as an imaging type record,"
 ..S RATXT(2)="wRVU scaling factors not filed."
 ..D BMES^XPDUTL(.RATXT) K RATXT
 ..Q
 .I '$D(^RA(79.2,"C",$P(RAX,";",4),RAIEN))#2 D  Q
 ..S RATXT(1)="'"_$P(RAX,";",4)_"' not found as the abbreviation for imaging type record:"
 ..S RATXT(2)="'"_$P(RAX,";",3)_"'."
 ..S RATXT(3)="wRVU scaling factors not filed."
 ..D BMES^XPDUTL(.RATXT) K RATXT
 ..Q
 .Q:$D(^RA(79.2,RAIEN,"CY","B",$P(RAX,";",5)))\10  ;been there, done that
 .S RAFDA(79.22,"+812,"_RAIEN_",",.01)=$P(RAX,";",5)
 .S RAFDA(79.22,"+812,"_RAIEN_",",2)=$P(RAX,";",6)
 .S RATXT(1)="Filing scaling wRVU factors for: '"_$P(RAX,";",3)_"'"
 .D UPDATE^DIE("E","RAFDA","","RAMSG(1)") K RAFDA
 .S RATXT(2)="The filing of data was "_$S($D(RAMSG(1,"DIERR"))#2:"un",1:"")_"successful."
 .S RATXT(3)=" " D BMES^XPDUTL(.RATXT) K RAMSG,RATXT
 .Q
XIT ;clean up symbol table; exit
 K RAIEN
 Q
 ;
FACTORS ;I-type name;I-type abbreviation;calendar year;scaled wRVU value
 ;;ANGIO/NEURO/INTERVENTIONAL;ANI;2006;0.61
 ;;CT SCAN;CT;2006;0.70
 ;;GENERAL RADIOLOGY;RAD;2006;1.21
 ;;MAGNETIC RESONANCE IMAGING;MRI;2006;0.70
 ;;NUCLEAR MEDICINE;NM;2006;1.57
