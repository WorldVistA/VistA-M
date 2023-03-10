PXRMUCUM ;SLC/PKR - Utility for UCUM codes. ;04/14/2022
 ;;2.0;CLINICAL REMINDERS;**65**;Feb 04, 2005;Build 438
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
 ;===================
UCDHTEXT ;UCUM DISPLAY executable help text.
 ;;This field specifies how the units are presented when a measurement is 
 ;;displayed in CPRS, Clinical Reminders, and Health Summary. When the value
 ;;is C, the UCUM Code is displayed when the value is D, the Description is
 ;;displayed. When the value is N, no units are displayed.
 ;;**End Text**
 Q
 ;
 ;===================
UCDXHELP(FILENUM,DA) ;UCUM DISPLAY executable help.
 N DONE,DIR0,IND,TEXT,UCUMDATA,UCUMIEN
 S DONE=0
 F IND=1:1 Q:DONE  D
 . S TEXT(IND)=$P($T(UCDHTEXT+IND),";",3)
 . I TEXT(IND)="**End Text**" S TEXT(IND)=" ",DONE=1 Q
 S IND=IND-1
 ;
 ;Get the Description and UCUM Code.
 S UCUMIEN=$$GET^DDSVAL(FILENUM,DA,223)
 I UCUMIEN="" D
 . S IND=IND+1,TEXT(IND)="No units have been choosen yet, once they have, the Description and UCUM Code"
 . S IND=IND+1,TEXT(IND)="can be displayed to help you decide which to use."
 E  D
 . D UCUMDATA^LEXMUCUM(UCUMIEN,.UCUMDATA)
 . S IND=IND+1,TEXT(IND)="The UCUM CODE is: "_UCUMDATA(UCUMIEN,"UCUM CODE")
 . S IND=IND+1,TEXT(IND)="The description is: "_UCUMDATA(UCUMIEN,"DESCRIPTION")
 ;
 D BROWSE^DDBR("TEXT","NR","UCUM DISPLAY field Help")
 I $D(DDS) D REFRESH^DDSUTL S DY=IOSL-7,DX=0 X IOXY S $Y=DY,$X=DX
 Q
 ; 
