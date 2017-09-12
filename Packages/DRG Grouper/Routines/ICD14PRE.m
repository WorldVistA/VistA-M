ICD14PRE ;SSI/ALA-PREINSTALL PROGRAM ;[ 04/03/97  1:03 PM ]
 ;;14.0;DRG Grouper;;Apr 03, 1997
EN ;  Delete data in temporary files
 S I=0 F  S I=$O(^ICDYZ(80.7,I)) Q:I=""  K ^ICDYZ(80.7,I)
 S I=0 F  S I=$O(^ICDYZ(80.8,I)) Q:I=""  K ^ICDYZ(80.8,I)
 S I=0 F  S I=$O(^ICDYZ(80.9,I)) Q:I=""  K ^ICDYZ(80.9,I)
 K I
 Q
