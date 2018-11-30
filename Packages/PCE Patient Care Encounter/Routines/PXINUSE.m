PXINUSE ;SLC/PKR - PCE data dictionary utilities. ;04/28/2017
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 244
 ;
 ;=========================================
EDINUSE(IEN,DELMSG) ;
 N INUSE
 S INUSE=$S(+$O(^PXRMINDX(9000010.16,"IP",IEN,""))>0:1,1:0)
 I INUSE,DELMSG D EN^DDIOL("This education topic is in use and it cannot be deleted.")
 Q INUSE
 ;
 ;=========================================
EDNINUSE ;Build a list of education topics that are not in use.
 N IEN,INUSE,NAME,NEDU,NL,NOTINUSE,TEXT
 S NAME="",(NEDU,NL,NOTINUSE)=0
 F  S NAME=$O(^AUTTEDT("B",NAME)) Q:NAME=""  D
 . S IEN=$O(^AUTTEDT("B",NAME,""))
 . S NEDU=NEDU+1
 . S INUSE=$$EDINUSE(IEN,0)
 . I INUSE Q
 . S NL=NL+1,TEXT(NL)=NAME_" (IEN="_IEN_")"
 S NOTINUSE=NL
 S NL=NL+1,TEXT(NL)=""
 S NL=NL+1,TEXT(NL)="There are "_NEDU_" education topics."
 S NL=NL+1,TEXT(NL)=" "_(NEDU-NOTINUSE)_" of them are in use."
 S NL=NL+1,TEXT(NL)=" "_NOTINUSE_" of them are not in use."
 D BROWSE^DDBR("TEXT","NR","Education Topics that are NOT IN USE")
 Q
 ;
 ;=========================================
EXINUSE(IEN,DELMSG) ;
 N INUSE
 S INUSE=$S(+$O(^PXRMINDX(9000010.13,"IP",IEN,""))>0:1,1:0)
 I INUSE,DELMSG D EN^DDIOL("This exam is in use and it cannot be deleted.")
 Q INUSE
 ;
 ;=========================================
EXNINUSE ;Build a list of exams that are not in use.
 N IEN,INUSE,NAME,NEX,NL,NOTINUSE,TEXT
 S NAME="",(NEX,NL,NOTINUSE)=0
 F  S NAME=$O(^AUTTEXAM("B",NAME)) Q:NAME=""  D
 . S IEN=$O(^AUTTEXAM("B",NAME,""))
 . S NEX=NEX+1
 . S INUSE=$$EXINUSE(IEN,0)
 . I INUSE Q
 . S NL=NL+1,TEXT(NL)=NAME_" (IEN="_IEN_")"
 S NOTINUSE=NL
 S NL=NL+1,TEXT(NL)=""
 S NL=NL+1,TEXT(NL)="There are "_NEX_" exams."
 S NL=NL+1,TEXT(NL)=" "_(NEX-NOTINUSE)_" of them are in use."
 S NL=NL+1,TEXT(NL)=" "_NOTINUSE_" of them are not in use."
 D BROWSE^DDBR("TEXT","NR","Exams that are NOT IN USE")
 Q
 ;
 ;=========================================
HFINUSE(IEN,DELMSG) ;
 N ETYPE,INUSE
 S ETYPE=$P(^AUTTHF(IEN,0),U,10)
 I ETYPE="C" S INUSE=$S(+$O(^AUTTHF("AC",IEN,""))>0:1,1:0)
 I ETYPE="F" S INUSE=$S(+$O(^PXRMINDX(9000010.23,"IP",IEN,""))>0:1,1:0)
 I INUSE,DELMSG D EN^DDIOL("This health factor is in use and it cannot be deleted.")
 Q INUSE
 ;
 ;=========================================
HFNINUSE ;Determine which health factors are in use and which are not.
 N ETYPE,IEN,INUSE,NAME,NHF,NL,NOTINUSE,TEXT
 S NAME="",(NHF,NL,NOTINUSE)=0
 F  S NAME=$O(^AUTTHF("B",NAME)) Q:NAME=""  D
 . S IEN=$O(^AUTTHF("B",NAME,""))
 . S NHF=NHF+1
 . S INUSE=$$HFINUSE(IEN,0)
 . I INUSE Q
 . S ETYPE=$P(^AUTTHF(IEN,0),U,10)
 . S ETYPE=$S(ETYPE="C":"Category",ETYPE="F":"Factor",1:"Missing")
 . S NL=NL+1,TEXT(NL)=ETYPE_": "_NAME_" (IEN="_IEN_")"
 S NOTINUSE=NL
 S NL=NL+1,TEXT(NL)=""
 S NL=NL+1,TEXT(NL)="There are "_NHF_" health factors."
 S NL=NL+1,TEXT(NL)=" "_(NHF-NOTINUSE)_" of them are in use."
 S NL=NL+1,TEXT(NL)=" "_NOTINUSE_" of them are not in use."
 D BROWSE^DDBR("TEXT","NR","Health Factors that are NOT IN USE")
 Q
 ;
