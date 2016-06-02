LEXMUCUM ;SLC/PKR - UCUM APIs. ;09/04/2015
 ;;2.0;LEXICON UTILITY;**102**;Sep 23, 1996;Build 20
 ;
 ;==================               
UCUMCODE(IEN) ;Given an IEN return the UCUM CODE.
 N UCUMCODE
 S UCUMCODE=$P($G(^LEX(757.5,IEN,1)),U,1)
 I UCUMCODE="" Q "{unit not defined}^The entry with IEN "_IEN_" does not exist."
 Q $TR(UCUMCODE,"10*","10^")
 ;
 ;==================               
UCUMDATA(IDEN,UCUMDATA) ;Given an identifier, which can be an IEN, a
 ;Description, or a UCUM code return all the fields for that entry.
 N IEN,IENL,UCUMCODE,UPIDEN
 I IDEN=+IDEN S IENL(+IDEN)=""
 S UPIDEN=$$UP^XLFSTR(IDEN)
 I '$D(IENL) S IEN=0 F  S IEN=+$O(^LEX(757.5,"B",IDEN,IEN)) Q:IEN=0  S IENL(IEN)=""
 I '$D(IENL) S IEN=0 F  S IEN=+$O(^LEX(757.5,"UPB",UPIDEN,IEN)) Q:IEN=0  S IENL(IEN)=""
 I '$D(IENL) S IEN=0 F  S IEN=+$O(^LEX(757.5,"C",IDEN,IEN)) Q:IEN=0  S IENL(IEN)=""
 I '$D(IENL) S IEN=0 F  S IEN=+$O(^LEX(757.5,"UPC",UPIDEN,IEN)) Q:IEN=0  S IENL(IEN)=""
 I '$D(IENL) S UCUMDATA("ERROR")="The entry identified by "_IDEN_" does not exist." Q
 S IEN=""
 F  S IEN=$O(IENL(IEN)) Q:IEN=""  D
 . S UCUMDATA(IEN,"IEN")=IEN
 . I '$D(^LEX(757.5,IEN)) S UCUMDATA(IEN,"ERROR")="The entry identified by "_IDEN_" does not exist." Q
 . S UCUMDATA(IEN,"DESCRIPTION")=^LEX(757.5,IEN,0)
 . S UCUMCODE=$P(^LEX(757.5,IEN,1),U,1)
 . S UCUMCODE=$TR(UCUMCODE,"10*","10^")
 . S UCUMDATA(IEN,"UCUM CODE")=UCUMCODE
 . S UCUMDATA(IEN,"ROW")=$P(^LEX(757.5,IEN,1),U,2)
 . S UCUMDATA(IEN,"COMMENTS")=$G(^LEX(757.5,IEN,2))
 Q
 ;
 ;==================               
VERSION(VERDATA) ;Return the version information.
 S VERDATA("NAME")="Table of Example UCUM Codes for Electronic Messaging"
 S VERDATA("VERSION")="Version 1.3"
 S VERDATA("DATE")="09/26/2014"
 Q
 ;
