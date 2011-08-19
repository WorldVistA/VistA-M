PXRMV2IC ; SLC/PKR - Version 2.0 init routine. ;02/18/2004
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 Q
 ;
 ;===============================================================
COND ;Put "~" back to space in condition and store the internal condition
 ;and v list
 N COND,DA,IEN,IND,TEXT
 D BMES^XPDUTL("Converting conditions")
 S IEN=0
 F  S IEN=+$O(^PXD(811.9,IEN)) Q:IEN=0  D
 . S TEXT=" Working on reminder "_IEN
 . D BMES^XPDUTL(TEXT)
 . S IND=0
 . F  S IND=+$O(^PXD(811.9,IEN,20,IND)) Q:IND=0  D
 .. S COND=$P($G(^PXD(811.9,IEN,20,IND,3)),U,1)
 .. I COND="" Q
 .. S COND=$TR(COND,"~"," ")
 .. S $P(^PXD(811.9,IEN,20,IND,3),U,1)=COND
 .. S DA(1)=IEN,DA=IND
 .. D KICOND^PXRMCOND(COND,.DA,811.9)
 .. D SICOND^PXRMCOND(COND,.DA,811.9)
 . D USAGE(IEN)
 ;
 S IEN=0
 F  S IEN=+$O(^PXRMD(811.5,IEN)) Q:IEN=0  D
 . S TEXT=" Working on term "_IEN
 . D BMES^XPDUTL(TEXT)
 . S IND=0
 . F  S IND=+$O(^PXRMD(811.5,IEN,20,IND)) Q:IND=0  D
 .. S COND=$P($G(^PXRMD(811.5,IEN,20,IND,3)),U,1)
 .. I COND="" Q
 .. S COND=$TR(COND,"~"," ")
 .. S $P(^PXRMD(811.5,IEN,20,IND,3),U,1)=COND
 .. S DA(1)=IEN,DA=IND
 .. D KICOND^PXRMCOND(COND,.DA,811.5)
 .. D SICOND^PXRMCOND(COND,.DA,811.5)
 Q
 ;
 ;===============================================================
USAGE(IEN) ;Make sure the Usage field is uppercase.
 N USAGE
 S USAGE=$P($G(^PXD(811.9,IEN,100)),U,4)
 S USAGE=$$UP^XLFSTR(USAGE)
 S $P(^PXD(811.9,IEN,100),U,4)=USAGE
 Q
 ;
