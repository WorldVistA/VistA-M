GMTSUCUM ;SLC/PKR - Utility for UCUM codes. ;02/03/2022
 ;;2.7;Health Summary;**115**;Oct 20, 1995;Build 190
 ;
 ;   API                   ICR#
 ;UCUMDATA^LEXMUCUM        6225
 ;
 ;===================
UCUMFIELDS(IDEN,FIELDS) ;Given an identifier, which can be an IEN, a
 ;Description, or a UCUM and a semicolon separated list of fields return
 ;the fields as a semicolon separated string. Return -1 is the UCUM entry
 ;does not exist. The fields that can be returned are: COMMENTS, DESCRIPTIION,
 ;IEN, ROW, UCUM CODE,
 N FIELD,FIELDSTRING,IEN,IND,NFIELDS,UCUMDATA
 S NFIELDS=$L(FIELDS,";")
 I NFIELDS=0 Q 0
 D UCUMDATA^LEXMUCUM(IDEN,.UCUMDATA)
 S IEN=$O(UCUMDATA(""))
 I $D(UCUMDATA(IEN,"ERROR")) Q -1_";"_UCUMDATA(IEN,"ERROR")
 S FIELD=$P(FIELDS,";",1)
 S FIELDSTRING=UCUMDATA(IEN,FIELD)
 F IND=2:1:NFIELDS D
 . S FIELD=$P(FIELDS,";",IND)
 . S FIELDSTRING=FIELDSTRING_";"_UCUMDATA(IEN,FIELD)
 Q FIELDSTRING
 ;
