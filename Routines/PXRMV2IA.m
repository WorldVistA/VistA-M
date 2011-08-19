PXRMV2IA ; SLC/PKR - Version 2.0 init routine. ;11/17/2003
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 Q
 ;
 ;===============================================================
SFNFTC ;Set the found/not found text line counts in the reminder definition.
 N IEN,TEXT
 D BMES^XPDUTL("Storing found/not found text line counts")
 S IEN=0
 F  S IEN=+$O(^PXD(811.9,IEN)) Q:IEN=0  D
 . S TEXT=" Working on reminder "_IEN
 . D BMES^XPDUTL(TEXT)
 . D SNMLA^PXRMFNFT(IEN)
 . D SNMLF^PXRMFNFT(IEN,20)
 . D SNMLF^PXRMFNFT(IEN,25)
 . D SNMLL^PXRMFNFT(IEN)
 Q
 ;
