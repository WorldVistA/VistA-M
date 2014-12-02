MAGVAF03 ;WOIFO/NST/BT - Utilities for RPC calls ; 15 May 2012 9:15 AM
 ;;3.0;IMAGING;**118**;Mar 19, 2002;Build 4525;May 01, 2013
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
 ;*****  Returns all records for a file in list format
 ; Input Parameters
 ; ================
 ;  
 ;   FILE - FileMan file number ( example 2006.917)
 ;   IENS - (Optional) Identify which records in a subfile to list. (example IENS = ",67,"
 ; 
 ; Return values
 ; =============
 ; 
 ; if error found during execution
 ;   MAGRY(0) = Failure status ^ Error getting the list
 ; if success
 ;   MAGRY(0)    = "Success status ^^#CNT" - where #CNT is a number of records returned
 ;   MAGRY(1)    = "^" delimited string with all field names in FILE
 ;   MAGRY(2..n) = "^" delimited string with values of fields listed in MAGRY(1) 
 ;
GALLLST(MAGRY,FILE,IENS) ;
 N OUT,ERR,MAGRESA
 N J,I,CNT,X,FIELDS,FLDSARR,FLDSARRW
 N RESDEL
 N IRECCNT ;Record count for internal values
 N ERECCNT ;Record count for external values
 K MAGRY
 S RESDEL=$$RESDEL^MAGVAF02()  ; Result delimiter
 S FIELDS=$$GETFLDS^MAGVAF01(.FLDSARR,.FLDSARRW,FILE,"")
 ;
 ; Retrieve all external values to check for valid pointer or referential integrity problems
 D LIST^DIC(FILE,IENS,"@;"_FIELDS,"","","","","","","","OUT","ERR")
 I $D(ERR("DIERR")) D  Q  ; Error getting the list with external values
 . D MSG^DIALOG("A",.MAGRESA,245,5,"ERR")
 . S MAGRY(0)=$$FAILED^MAGVAF02()_RESDEL_"Error getting the list: "_MAGRESA(1)
 . Q
 S ERECCNT=$P($G(OUT("DILIST","0")),"^",1)
 ;
 ; Retrieve all Internal values to return to the caller
 K OUT,ERR
 D LIST^DIC(FILE,IENS,"@;"_FIELDS,"I","","","","","","","OUT","ERR")
 I $D(ERR("DIERR")) D  Q  ; Error getting the list with internal values
 . D MSG^DIALOG("A",.MAGRESA,245,5,"ERR")
 . S MAGRY(0)=$$FAILED^MAGVAF02()_RESDEL_"Error getting the list: "_MAGRESA(1)
 . Q
 S IRECCNT=$P($G(OUT("DILIST","0")),"^",1)
 ;
 I IRECCNT'=ERECCNT D  Q
 . S MAGRY(0)=$$FAILED^MAGVAF02()_RESDEL_"Error getting the list: File #"_FILE_" has cross reference problem" Q
 ;
 S CNT=1
 S I=""
 F  S I=$O(OUT("DILIST","ID",I)) Q:I=""  D
 . S CNT=CNT+1
 . S $P(MAGRY(CNT),"^",1)=OUT("DILIST",2,I)
 . F J=1:1:$L(FIELDS,";") D
 . . S X=OUT("DILIST","ID",I,$P(FIELDS,";",J))
 . . I $$ISFLDDT^MAGVAF01(FILE,$P(FIELDS,";",J)) S X=$$FM2IDF^MAGVAF01(X)  ; the field is Date type - convert to IDF format
 . . S $P(MAGRY(CNT),RESDEL,J+1)=X
 . . Q
 . Q
 ;
 S MAGRY(0)=$$OK^MAGVAF02()_RESDEL_RESDEL_(CNT-1)
 S MAGRY(1)="IEN"
 S I=""
 F  S I=$O(FLDSARR(I)) Q:I=""  S MAGRY(1)=MAGRY(1)_RESDEL_FLDSARR(I)
 Q
 ;*****  Returns all records for a file in XML format
 ; Input Parameters
 ; ================
 ;  
 ;   FILE - FileMan file number ( example 2006.917)
 ;   IENS - (Optional) Identify which subfile to list. (example IENS = ",67,"
 ;   
 ; if error found during execution
 ;   MAGRY(0) = "Failure status ^Error getting the list"
 ; if success
 ;   MAGRY(0)    = Success status ^^Total of lines
 ;   MAGRY(1)    = <file name + "s">
 ;   MAGRY(2)    =   <file name>
 ;   MAGRY(2..m) =      <field name=value>
 ;   MAGRY(n+1)  =   </ file name >
 ;   ...
 ;   MAGRY(n+2)  = </ file name + "s">
 ;
GALLXML(MAGRY,FILE,IENS) ;
 N OUT,ERR,MAGRESA
 N I,J,L,CNT,X,Y,WP,WPTYPE,QT,RESDEL
 N FILENM,FIELDS,FLDSARR,FLDSARRW
 K MAGRY
 S QT=$C(34)
 S RESDEL=$$RESDEL^MAGVAF02()
 S FIELDS=$$GETFLDS^MAGVAF01(.FLDSARR,.FLDSARRW,FILE,"") ; Get fields
 D LIST^DIC(FILE,IENS,"@;"_FIELDS,"I","","","","","","","OUT","ERR")
 I $D(ERR("DIERR")) D  Q
 . D MSG^DIALOG("A",.MAGRESA,245,5,"ERR")
 . S MAGRY(0)=$$FAILED^MAGVAF02()_RESDEL_"Error getting the list: "_MAGRESA(1) Q  ; Error getting the list
 S FILENM=$TR($$GETFILNM^MAGVAF01(FILE)," ") ; file name without blanks
 S CNT=0
 S CNT=CNT+1,MAGRY(1)="<"_FILENM_"S>"
 S I=""
 F  S I=$O(OUT("DILIST","ID",I)) Q:I=""  D
 . S CNT=CNT+1,MAGRY(CNT)="<"_FILENM
 . S CNT=CNT+1,MAGRY(CNT)="PK="_QT_OUT("DILIST",2,I)_QT
 . S J=""
 . F  S J=$O(OUT("DILIST","ID",I,J)) Q:J=""  D
 . . S X=OUT("DILIST","ID",I,J)
 . . I $$ISFLDDT^MAGVAF01(FILE,J) S X=$$FM2IDF^MAGVAF01(X)  ; the field is Date type - convert to IDF format
 . . S CNT=CNT+1,MAGRY(CNT)=$TR(FLDSARR(J)," /\<>&%")_"="_QT_X_QT
 . ; Now get the Word-Processing fields
 . S J=""
 . K WP
 . F  S J=$O(FLDSARRW(J)) Q:J=""  D
 . . I $$ISFLDWP^MAGVAF01(.WPTYPE,FILE,J) D
 . . . S X=$$GET1^DIQ(FILE,OUT("DILIST",2,I),J,"","WP")
 . . . S:$D(WP) CNT=CNT+1,MAGRY(CNT)=$TR(FLDSARRW(J)," /\<>&%")_"="_QT
 . . . S L=""
 . . . F  S L=$O(WP(L)) Q:L=""  D
 . . . . S CNT=CNT+1,MAGRY(CNT)=WP(L)
 . . . . Q
 . . . S MAGRY(CNT)=MAGRY(CNT)_QT
 . . . Q
 . . Q
 . S MAGRY(CNT)=MAGRY(CNT)_" >"
 . Q
 S CNT=CNT+1,MAGRY(CNT)="</"_FILENM_">"
 S CNT=CNT+1,MAGRY(CNT)="</"_FILENM_"S>"
 S MAGRY(0)=$$OK^MAGVAF02()_RESDEL_RESDEL_CNT
 Q
 ;
 ; ****  Get a multiple values for a field and return the result in XML format
 ; 
 ; Input parameters
 ; ================
 ; 
 ; FILE = FileMan number of the file (e.g. 2006.913)
 ; IENS = IEN of the record  (e.g. "1," where 1 is an IEN)
 ; MFIELDID = Field number of the multiple field (e.g. 2)
 ;
 ; Return Values
 ; =============
 ; if error found during execution
 ;   MAGRY(0) = "Failure status ^Error getting values"
 ; if success
 ;   MAGRY(0) = Success status ^^Total lines
 ;   MAGRY (1.n) = values in format
 ;   
 ;   e.g
 ;    <KEYS>
 ;    <KEY VALUE="" LEVEL=""/>
 ;     ...
 ;    <KEY VALUE="" LEVEL=""/>
 ;    </KEYS>
 ;    
 ;    where 
 ;      KEY    = the name of multiple field
 ;      VALUE and LEVEL = field names in sub-file
 ;       
GETMVAL(MAGRY,FILE,MFIELDID,IENS) ;
 N I,J,X
 N OUT,ERR,MAGRESA
 N FLDSARR,FLDSARRW,MFIELDNM,SUBFILE,FIELDS
 N CNT,QT,RESDEL
 S QT=$C(34)
 S RESDEL=$$RESDEL^MAGVAF02()
 S MFIELDNM=$$GETFLDNM^MAGVAF01(FILE,MFIELDID) ; name of multiple field
 S SUBFILE=$$GETSUBFL^MAGVAF01(FILE,MFIELDID)  ; sub-file for the multiple fields
 S FIELDS=$$GETFLDS^MAGVAF01(.FLDSARR,.FLDSARRW,SUBFILE,"I") ; sub-file fields names
 S FIELDS=MFIELDID_"*"
 I IENS'="" D  Q:$D(ERR("DIERR"))
 . D GETS^DIQ(FILE,IENS,FIELDS,"","OUT","ERR")
 . I $D(ERR("DIERR")) D
 . . D MSG^DIALOG("A",.MAGRESA,245,5,"ERR")
 . . S MAGRY(0)=$$FAILED^MAGVAF02()_RESDEL_"Error getting values: "_MAGRESA(1) Q  ; Error getting the list
 . . Q
 . Q
 ; Output the data
 S I=""  ; IENs
 S J=""  ; Fields in the sub-file
 S CNT=0
 S CNT=CNT+1,MAGRY(CNT)="<"_MFIELDNM_"S>"
 F  S I=$O(OUT(SUBFILE,I)) Q:I=""  D
 . S CNT=CNT+1,MAGRY(CNT)="<"_MFIELDNM
 . F  S J=$O(OUT(SUBFILE,I,J)) Q:J=""  D
 . . I $$ISFLDDT^MAGVAF01(SUBFILE,J) S X=$$FM2IDF^MAGVAF01(OUT(SUBFILE,I,J))  ; the field is Date type - convert to IDF format
 . . E  S X=OUT(SUBFILE,I,J)
 . . S MAGRY(CNT)=MAGRY(CNT)_" "_$TR(FLDSARR(J)," /\<>&%")_"="_QT_X_QT
 . . Q
 . S MAGRY(CNT)=MAGRY(CNT)_" />"
 . Q
 . S CNT=CNT+1,MAGRY(CNT)="/>"
 S CNT=CNT+1,MAGRY(CNT)="</"_MFIELDNM_"S>"
 S MAGRY(0)=$$OK^MAGVAF02()_RESDEL_RESDEL_CNT
 Q
 ;
 ;
 ; ****  Get a record from a file by "B" index value 
 ;      (in most of the cases it is value of .01 field) and return the result in XML format
 ; 
 ; Input parameters
 ; ================
 ; 
 ; FILE = FileMan number of the file (e.g. 2006.913)
 ; IENS = IEN in sub-file  (e.g. "1," where 1 is an IEN)
 ; VAL = value in "B" index (in most of the cases it is value of .01 field)
 ; WPASLINE = 0 (WP value as it was stored) / 1 (WP value as a single line) 
 ;
 ; Return Values
 ; =============
 ; if error found during execution
 ;   MAGRY(0) = Failure status^Error getting values
 ; if success
 ;   MAGRY(0) =  Success status^^Total lines
 ;   MAGRY (1.n) = values in XML format
 ;   
GXMLBYID(MAGRY,FILE,IENS,VAL,WPASLINE) ;
 N FIELDS,FLDSARR,FLDSARRW,FILENM
 N OUT,ERR,MAGRESA,WP,WPTYPE
 N I,J,L,X,CNT
 N QT,RESDEL
 K MAGRY
 S RESDEL=$$RESDEL^MAGVAF02()
 S QT=$C(34)
 S FILENM=$TR($$GETFILNM^MAGVAF01(FILE)," ") ; File name without blank
 S FIELDS=$$GETFLDS^MAGVAF01(.FLDSARR,.FLDSARRW,FILE,"I") ; file fields names
 D FIND^DIC(FILE,IENS,"@;"_FIELDS,"BQX",VAL,"","","","","OUT","ERR")
 I $D(ERR("DIERR")) D  Q
 . D MSG^DIALOG("A",.MAGRESA,245,5,"ERR")
 . S MAGRY(0)=$$FAILED^MAGVAF02()_RESDEL_"Error getting values: "_MAGRESA(1) Q  ; Error getting the list
 . Q
 ; Output the data
 S CNT=0
 S CNT=CNT+1,MAGRY(CNT)="<"_FILENM_"S>"
 S I=""  ; IENs
 S J=""  ; Fields in the file
 F  S I=$O(OUT("DILIST","ID",I)) Q:I=""  D
 . S CNT=CNT+1,MAGRY(CNT)="<"_FILENM
 . S CNT=CNT+1,MAGRY(CNT)="PK="_QT_OUT("DILIST",2,I)_QT
 . S J=""
 . F  S J=$O(OUT("DILIST","ID",I,J)) Q:J=""  D
 . . S X=OUT("DILIST","ID",I,J)
 . . I $$ISFLDDT^MAGVAF01(FILE,J) S X=$$FM2IDF^MAGVAF01(X)  ; the field is Date type - convert to IDF format
 . . S CNT=CNT+1,MAGRY(CNT)=$TR(FLDSARR(J)," /\<>&%")_"="_QT_X_QT
 . . Q
 . ; Now get the Word-Processing fields
 . S J=""
 . K WP
 . F  S J=$O(FLDSARRW(J)) Q:J=""  D
 . . I $$ISFLDWP^MAGVAF01(.WPTYPE,FILE,J) D  Q
 . . . S X=$$GET1^DIQ(FILE,OUT("DILIST",2,I),J,"","WP")
 . . . I $D(WP) D
 . . . . S CNT=CNT+1,MAGRY(CNT)=$TR(FLDSARRW(J)," /\<>&%")_"="_QT
 . . . . I WPASLINE S MAGRY(CNT)=MAGRY(CNT)_$$TRHTML^MAGVAF04($$STRWP^MAGVAF01(.WP))  ; Get as a single line
 . . . . E  D  ; Get WP value as it was stored
 . . . . . S L=""
 . . . . . F  S L=$O(WP(L)) Q:L=""  D
 . . . . . . S CNT=CNT+1,MAGRY(CNT)=$$TRHTML^MAGVAF04(WP(L))
 . . . . . . Q
 . . . . . Q
 . . . . S MAGRY(CNT)=MAGRY(CNT)_QT
 . . . . Q
 . . . Q
 . . Q
 . S MAGRY(CNT)=MAGRY(CNT)_" >"
 . S CNT=CNT+1,MAGRY(CNT)="</"_FILENM_" >"
 . Q
 S CNT=CNT+1,MAGRY(CNT)="</"_FILENM_"S>"
 S MAGRY(0)=$$OK^MAGVAF02()_RESDEL_RESDEL_CNT
 Q
 ;
 ; Input Parameters
 ; ================ 
 ; MAGRY
 ;   MAGRY(0)=1^^CNT
 ;   MAGRY(3)=<FILENAME
 ;   ...
 ;   MAGRY(n)=</FILENAME>
 ;   
 ; Output Values
 ; =============
 ; 
 ; MAGRY(0)=1^^(CNT+1)
 ; MAGRY(1)="<?xml version=""1.0"" encoding=""utf-8""?>"
 ; MAGRY(2)=<FILENAMES>
 ; ....
 ; MAGRY(n+1)=</FILENAMES>
 ;
SETFTUCH(MAGRY) ; Set first two lines and the last one
 I '$$ISOK^MAGVAF02(MAGRY(0)) Q
 ; Add first lines
 N RES,I
 S MAGRY(1)=$$XML1LINE^MAGVAF02()
 S MAGRY(2)=MAGRY(3)_"S>"
 S I=$O(MAGRY(""),-1)+1
 S MAGRY(I)="</"_$P(MAGRY(3),"<",2,999)_"S>"
 S RES=MAGRY(0)
 D SETVAL^MAGVAF02(.RES,I)
 S MAGRY(0)=RES
 Q
 ;
 ;++++ Create an empty XML result by file number
 ; Input Parameters
 ; ================
 ; FILE - FileMan file number
 ; 
 ; Return Values
 ; ==============
 ; MAGRY(0)=1^^3
 ; MAGRY(1)="<?xml version=""1.0"" encoding=""utf-8""?>"
 ; MAGRY(2)=<FILENAMES>
 ; MAGRY(3)=</FILENAMES>
 ; 
 ; where FILENAME is the name of the file passed
 ; 
EMPTYXML(MAGRY,FILE) ; Create an empty XML result by file number
 N FILENM
 S FILENM=$TR($$GETFILNM^MAGVAF01(FILE)," ") ; File name without blank
 S CNT=0
 S MAGRY(0)=$$OK^MAGVAF02()_$$RESDEL^MAGVAF02()_$$RESDEL^MAGVAF02()_3
 S MAGRY(1)=$$XML1LINE^MAGVAF02()
 S MAGRY(2)="<"_FILENM_"S>"
 S MAGRY(3)="</"_FILENM_"S>"
 Q
 ;
 ; ****  Get a record from a file by IEN 
 ;       and return the result in XML format
 ; 
 ; Input parameters
 ; ================
 ; 
 ; FILE = FileMan number of the file (e.g. 2006.913)
 ; PK = IEN in the file
 ; WPASLINE = 0 (WP value as it was stored) / 1 (WP value as a single line) 
 ;
 ; Return Values
 ; =============
 ; if error found during execution
 ;   MAGRY(0) = Failure status^Error getting values
 ; if success
 ;   MAGRY(0) =  Success status^^Total lines
 ;   MAGRY (1.n) = values in XML format
 ;   
GXMLBYPK(MAGRY,FILE,PK,WPASLINE) ;
 N FIELDS,FLDSARR,FLDSARRW,FILENM
 N OUT,ERR,MAGRESA,WP,IENS
 N J,L,X,CNT,WPTYPE
 N QT,RESDEL
 K MAGRY
 S RESDEL=$$RESDEL^MAGVAF02()
 S QT=$C(34)
 S FILENM=$TR($$GETFILNM^MAGVAF01(FILE)," ") ; File name without blank
 S FIELDS=$$GETFLDS^MAGVAF01(.FLDSARR,.FLDSARRW,FILE,"") ; file fields names
 S IENS=PK_","
 D GETS^DIQ(FILE,PK_",",FIELDS,"I","OUT","ERR")
 I $D(ERR("DIERR")) D  Q
 . D MSG^DIALOG("A",.MAGRESA,245,5,"ERR")
 . S MAGRY(0)=$$FAILED^MAGVAF02()_RESDEL_"Error getting values: "_MAGRESA(1) Q  ; Error getting the list
 . Q
 ; Output the data
 S CNT=0
 S J=""  ; Fields in the file
 S CNT=CNT+1,MAGRY(CNT)="<"_FILENM
 S CNT=CNT+1,MAGRY(CNT)="PK="_QT_PK_QT
 S J=""
 F  S J=$O(OUT(FILE,IENS,J)) Q:J=""  D
 . S X=OUT(FILE,IENS,J,"I")
 . I $$ISFLDDT^MAGVAF01(FILE,J) S X=$$FM2IDF^MAGVAF01(X)  ; the field is Date type - convert to IDF format
 . S CNT=CNT+1,MAGRY(CNT)=$TR(FLDSARR(J)," /\<>&%")_"="_QT_X_QT
 . Q
 ; Now get the Word-Processing fields
 S J=""
 K WP
 F  S J=$O(FLDSARRW(J)) Q:J=""  D
 . I $$ISFLDWP^MAGVAF01(.WPTYPE,FILE,J) D  Q
 . . S X=$$GET1^DIQ(FILE,IENS,J,"","WP")
 . . I $D(WP) D
 . . . S CNT=CNT+1,MAGRY(CNT)=$TR(FLDSARRW(J)," /\<>&%")_"="_QT
 . . . I WPASLINE S MAGRY(CNT)=MAGRY(CNT)_$$TRHTML^MAGVAF04($$STRWP^MAGVAF01(.WP))  ; Get as a single line
 . . . E  D  ; Get WP value as it was stored
 . . . . S L=""
 . . . . F  S L=$O(WP(L)) Q:L=""  D
 . . . . . S CNT=CNT+1,MAGRY(CNT)=$$TRHTML^MAGVAF04(WP(L))
 . . . . . Q
 . . . . Q
 . . . S MAGRY(CNT)=MAGRY(CNT)_QT
 . . . Q
 . . Q
 . Q
 S MAGRY(CNT)=MAGRY(CNT)_" >"
 S CNT=CNT+1,MAGRY(CNT)="</"_FILENM_" >"
 S MAGRY(0)=$$OK^MAGVAF02()_RESDEL_RESDEL_CNT
 Q
