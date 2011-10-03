RAIPRE ;HIRMFO/GJC- Pre-init Driver ;11/12/97  11:42
VERSION ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 I +$G(DIFROM)'=+$P($T(VERSION),";",3) S XPDQUIT=1 Q
 Q:$G(^RADPT(0))']""  ; Virgin install, quit!
 N RAIPRE
 S RAIPRE=$$NEWCP^XPDUTL("PREA1","EN1^RAIPRE1")
 ;        Delete the Stop Codes multiple from the Rad/Nuc Med Procedures
 ;        data dictionary.  Delete Stop Code data from the Rad/Nuc Med
 ;        Procedures file.
 ;
 S RAIPRE=$$NEWCP^XPDUTL("PREA2","EN2^RAIPRE1")
 ;        Delete the Principal Clinic field from the Imaging Locations
 ;        data dictionary.  Delete Principal Clinic data from the
 ;        Imaging Locations file.
 ;
 S RAIPRE=$$NEWCP^XPDUTL("PREA4","EN4^RAIPRE1")
 ;        Delete the Common Procedure Group field from the Rad/Nuc Med
 ;        Common Procedure data dictionary.  Delete Common Procedure
 ;        Group data from the Rad/Nuc Med Common Procedure file.
 ;
 S RAIPRE=$$NEWCP^XPDUTL("PREA10","EN10^RAIPRE1")
 ;        Delete the Input Devices multiple from the Imaging Locations
 ;        data dictionary.  Delete Input Devices data from the Imaging
 ;        Locations file.
 ;
 S RAIPRE=$$NEWCP^XPDUTL("PREA11","EN11^RAIPRE1")
 ;        Delete the Device Assignment Explanation field (75) from
 ;        the Imaging Type data dictionary. Delete Device Assignment
 ;        Explanation data from the Imaging Type file.
 ;
 S RAIPRE=$$NEWCP^XPDUTL("PREB1","EN1^RAIPRE2")
 ;        Delete the Allow 'VA' Patient Entry field from the data
 ;        dictionary of the Rad/Nuc Med Division file.  Delete Allow
 ;        'VA' Patient Entry data from the Rad/Nuc Med Division file.
 ;
 S RAIPRE=$$NEWCP^XPDUTL("PREB2","EN2^RAIPRE2")
 ;        Delete the Allow 'NON-VA' Patient Entry field from the data
 ;        dictionary of the Rad/Nuc Med Division file.  Delete Allow
 ;        'NON-VA' Patient Entry data from the Rad/Nuc Med Division file.
 ;
 S RAIPRE=$$NEWCP^XPDUTL("PREB3","EN3^RAIPRE2")
 ;        Delete the Ask 'Requesting Physician' field from the data
 ;        dictionary of the Rad/Nuc Med Division file.  Delete Ask
 ;        'Requesting Physician' data from the Rad/Nuc Med Division file.
 ;
 S RAIPRE=$$NEWCP^XPDUTL("PREB4","EN4^RAIPRE2")
 ;        Delete the following fields from the Rad/Nuc Med Division
 ;        data dictionary: Last DFN Converted (75.1), Conversion Start
 ;        Time (75.1), Conversion Stop Time (75.1), Last DFN Converted
 ;        (70), Conversion Start Time (70) & Conversion Stop Time (70).
 ;        All data associated with these fields will also be deleted.
 ;
 S RAIPRE=$$NEWCP^XPDUTL("PREB5","EN5^RAIPRE2")
 ;        Change the name of 'Radiology Location' in the Label Print
 ;        Fields file (78.7) to 'Imaging Location'.
 ;
 S RAIPRE=$$NEWCP^XPDUTL("PREB7","EN7^RAIPRE2")
 ;        Un-compile the 'RA STATUS CHANGE' and 'RA EXAM EDIT'
 ;        input templates on the Rad/Nuc Med Patient file.
 ;
 S RAIPRE=$$NEWCP^XPDUTL("PREB8","EN8^RAIPRE3")
 ;        See that the "NM" nodes for sub-files 200.072 (Rad/Nuc Med
 ;        Classification) and sub-file 200.074 (Rad/Nuc Med Location
 ;        Access) are correct.  If nodes need to be corrected, delete
 ;        the sub-file and retain the data.
 Q
