RAIPS119 ;HIOFO/GJC - Post-init one of one ;
VERSION ;;5.0;Radiology/Nuclear Medicine;**119**;Mar 16, 1998;Build 7
 ;
 ;IA - #6203 w/VA FileMan to delete the "RDE" xref & data
 ;  
EN ;entry point
 D RDE
 Q
 ;
RDE ; delete the MUMPS "RDE" cross reference on the RADIATION ABSORBED
 ;DOSE field (70.03 ; node one ;field #: 1.1). Delete all cross
 ;referenced data in "RDE".
 ;
 ;parameters: 
 ;    70 - the file number with the "RDE" index (file-wide)
 ; "RDE" - the name of the index to be deleted
 ;
 N DIERR K ^TMP("DIERR",$J)
 D DELIXN^DDMOD(70,"RDE") ;
 K ^RADPT("RDE") ; Whole Kill
 I $D(DIERR)#2 D
 .S RATXT=$G(^TMP("DIERR",$J,1,"TEXT",1))
 .D:$L(RATXT) MES^XPDUTL(RATXT)
 .K RATXT
 .Q
 K ^TMP("DIERR",$J)
 Q
 ;
