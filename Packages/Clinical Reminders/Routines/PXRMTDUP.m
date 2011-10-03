PXRMTDUP ; SLC/PKR - Update Taxonomy Dialog Selectable codes.;04/04/2003
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;=======================================================
BUILD(TIEN) ;Build the list of selectable codes for one taxonomy.
 N DATEBLT,FILE,NODE,PTR,TEMP
 S TEMP=$G(^PXD(811.3,TIEN,0))
 S DATEBLT=$P(TEMP,U,2)
 ;Make sure the expansion exists.
 I DATEBLT="" D EXPAND^PXRMBXTL(TIEN,"")
 ;Copy the expansion into the selectable lists.
 F FILE=80,81 D
 . S NODE=$S(FILE=80:"SDX",FILE=81:"SPR")
 . S PTR=$S(FILE=80:"ICD9P",FILE=81:"ICPTP")
 . K ^PXD(811.2,TIEN,NODE)
 . M ^PXD(811.2,TIEN,NODE)=^PXD(811.3,TIEN,FILE)
 . M ^PXD(811.2,TIEN,NODE,"B")=^PXD(811.3,TIEN,FILE,PTR)
 . K ^PXD(811.2,TIEN,NODE,PTR)
 Q
 ;
