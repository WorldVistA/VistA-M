PXRMTAXI ;SLC/PKR - APIs returning taxonomy information. ;08/24/2018
 ;;2.0;CLINICAL REMINDERS;**42**;Feb 04, 2005;Build 245
 ;
 ;===============
CODELIST(TAX,UID,CODELIST) ;Return a list of codes in a taxonomy.
 ;TAX is either the IEN or the .01 of the taxonomy.
 ;If UID is true, return the Use In Dialog Codes, otherwise return
 ;all Selected Codes.
 N IEN,IND
 S IEN=$S(+TAX=TAX:TAX,1:+$O(^PXD(811.2,"B",TAX,"")))
 I IEN=0 Q
 I '$D(^PXD(811.2,IEN)) Q
 I UID D  Q
 . N TEMP
 . S IND=0
 . F  S IND=+$O(^PXD(811.2,IEN,30,IND)) Q:IND=0  D
 .. S TEMP=^PXD(811.2,IEN,30,IND,0)
 .. S CODELIST($P(TEMP,U,2),$P(TEMP,U,1))=""
 ;
 N CODE,CODESYS,JND,KND
 S IND=0
 F  S IND=+$O(^PXD(811.2,IEN,20,IND)) Q:IND=0  D 
 . S JND=0
 . F  S JND=+$O(^PXD(811.2,IEN,20,IND,1,JND)) Q:JND=0  D
 .. S CODESYS=$P(^PXD(811.2,IEN,20,IND,1,JND,0),U,1)
 .. S KND=0
 .. F  S KND=+$O(^PXD(811.2,IEN,20,IND,1,JND,1,KND)) Q:KND=0  D
 ... S CODE=$P(^PXD(811.2,IEN,20,IND,1,JND,1,KND,0),U,1)
 ... S CODELIST(CODESYS,CODE)=""
 Q
 ;
 ;===============
TAXLIST(TAXLIST) ;Return a list of all the defined taxonomies.
 N IEN,NAME
 S NAME=""
 F  S NAME=$O(^PXD(811.2,"B",NAME)) Q:NAME=""  D
 . S IEN=$O(^PXD(811.2,"B",NAME,""))
 . S TAXLIST(NAME)=IEN
 Q
 ;
