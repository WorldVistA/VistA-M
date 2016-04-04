DINIT011 ; SFISC/TKW,VEN/SMH-DIALOG & LANGUAGE FILE INITS ; 6 DEC 2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1041**
 ;
 F I=1:2 S X=$T(Q+I) Q:X'["^"  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^DIC(.85,0,"GL")
 ;;=^DI(.85,
 ;;^DIC("B","LANGUAGE",.85)
 ;;=
 ;;^DIC(.85,"%",0)
 ;;=^1.005
 ;;^DIC(.85,"%D",0)
 ;;=^^27^27^3121101^
 ;;^DIC(.85,"%D",1,0)
 ;;=The LANGUAGE file is used both to officially identify a language, and to
 ;;^DIC(.85,"%D",2,0)
 ;;=store MUMPS code needed to do language-specific conversions of data such
 ;;^DIC(.85,"%D",3,0)
 ;;=as dates and numbers.
 ;;^DIC(.85,"%D",4,0)
 ;;= 
 ;;^DIC(.85,"%D",5,0)
 ;;=Fileman distributes entries for the following languages:
 ;;^DIC(.85,"%D",6,0)
 ;;= ID Number (.001)       Name (.01)
 ;;^DIC(.85,"%D",7,0)
 ;;=                1       English
 ;;^DIC(.85,"%D",8,0)
 ;;=                2       German
 ;;^DIC(.85,"%D",9,0)
 ;;=                3       Spanish
 ;;^DIC(.85,"%D",10,0)
 ;;=                4       French
 ;;^DIC(.85,"%D",11,0)
 ;;=                5       Finnish
 ;;^DIC(.85,"%D",12,0)
 ;;=                6       Italian
 ;;^DIC(.85,"%D",13,0)
 ;;=                7       Portuguese
 ;;^DIC(.85,"%D",14,0)
 ;;=               10       Arabic
 ;;^DIC(.85,"%D",15,0)
 ;;=               11       Russian
 ;;^DIC(.85,"%D",16,0)
 ;;=               12       Greek
 ;;^DIC(.85,"%D",17,0)
 ;;=               18       Hebrew
 ;;^DIC(.85,"%D",18,0)
 ;;= 
 ;;^DIC(.85,"%D",19,0)
 ;;=The ISO-639-1 and ISO-639-2 compatible language file is distributed in the
 ;;^DIC(.85,"%D",20,0)
 ;;=DMLAINIT routines, shipped with Fileman 22.2.
 ;;^DIC(.85,"%D",21,0)
 ;;= 
 ;;^DIC(.85,"%D",22,0)
 ;;=A pointer to this file from the TRANSLATION multiple on the DIALOG file
 ;;^DIC(.85,"%D",23,0)
 ;;=also allows non-English text to be returned via FileMan calls.
 ;;^DIC(.85,"%D",24,0)
 ;;= 
 ;;^DIC(.85,"%D",25,0)
 ;;=A note to VISTA developers: Although users can select entries by name, 
 ;;^DIC(.85,"%D",26,0)
 ;;=software should use the official two or three letter codes to eliminiate 
 ;;^DIC(.85,"%D",27,0)
 ;;=mistakes resulting from languages that have similar spelling.
 ;;^DIC(.85,"%MSC")
 ;;=3121114.111954
 ;;^DD(.85,0)
 ;;=FIELD^^10^20
 ;;^DD(.85,0,"DDA")
 ;;=N
 ;;^DD(.85,0,"DT")
 ;;=3121101
 ;;^DD(.85,0,"ID",.02)
 ;;=W "   ",$P(^(0),U,2)
 ;;^DD(.85,0,"ID",.03)
 ;;=W "   ",$P(^(0),U,3)
 ;;^DD(.85,0,"IX","F",.8501,.01)
 ;;=
 ;;^DD(.85,0,"NM","LANGUAGE")
 ;;=
 ;;^DD(.85,0,"PT",.007,.001)
 ;;=
 ;;^DD(.85,0,"PT",.008,.001)
 ;;=
 ;;^DD(.85,0,"PT",.009,.001)
 ;;=
 ;;^DD(.85,0,"PT",.4,709.1)
 ;;=
 ;;^DD(.85,0,"PT",.4,1819.1)
 ;;=
 ;;^DD(.85,0,"PT",.847,.01)
 ;;=
 ;;^DD(.85,0,"PT",.85,.08)
 ;;=
 ;;^DD(.85,0,"PT",.85,.09)
 ;;=
 ;;^DD(.85,0,"PT",1.008,.001)
 ;;=
 ;;^DD(.85,0,"PT",200,200.07)
 ;;=
 ;;^DD(.85,0,"PT",8989.3,207)
 ;;=
 ;;^DD(.85,.001,0)
 ;;=ID NUMBER^NJ10,0^^ ^K:+X'=X!(X>9999999999)!(X<1)!(X?.E1"."1.N) X
 ;;^DD(.85,.001,3)
 ;;=Type a number between 1 and 9999999999, 0 decimal digits.
 ;;^DD(.85,.001,21,0)
 ;;=^^3^3^3121031^^
 ;;^DD(.85,.001,21,1,0)
 ;;=A number that is used to uniquely identify a language.  This number
 ;;^DD(.85,.001,21,2,0)
 ;;=corresponds to the Kernel system variable DUZ("LANG"), which is set
 ;;^DD(.85,.001,21,3,0)
 ;;=during Kernel signon to signify which language Fileman should use.
 ;;^DD(.85,.001,23,0)
 ;;=^^31^31^3121031^
 ;;^DD(.85,.001,23,1,0)
 ;;=Entries in this file are standardized, with the contents controlled by 
 ;;^DD(.85,.001,23,2,0)
 ;;=the Fileman Primary Development Team. The ID Number field is used to help 
 ;;^DD(.85,.001,23,3,0)
 ;;=protect referential integrity in VISTA databases during upgrades to the 
 ;;^DD(.85,.001,23,4,0)
 ;;=file. ID Number assignment corresponds to the order in which languages 
 ;;^DD(.85,.001,23,5,0)
 ;;=were added to the file. They were added in segments.
 ;;^DD(.85,.001,23,6,0)
 ;;= 
 ;;^DD(.85,.001,23,7,0)
 ;;=The first segment consists of language numbers 1-7, 10-12, and 18, which 
 ;;^DD(.85,.001,23,8,0)
 ;;=were the first eleven languages added, in order. English is first because 
 ;;^DD(.85,.001,23,9,0)
 ;;=Fileman was originally written in English. German is second because 
 ;;^DD(.85,.001,23,10,0)
 ;;=Marcus Werners of Germany led the effort to create Fileman's dialog 
 ;;^DD(.85,.001,23,11,0)
 ;;=framework, to make translating VISTA into other languages easier. 
 ;;^DD(.85,.001,23,12,0)
 ;;=Spanish, French, Finnish, Italian, and Portuguese follow in the order in 
 ;;^DD(.85,.001,23,13,0)
 ;;=which the Fileman team was approached by potential translators about 
 ;;^DD(.85,.001,23,14,0)
 ;;=adding those languages to the file (though Finnish actually predates all 
 ;;^DD(.85,.001,23,15,0)
 ;;=other translation efforts except English). Arabic was assigned ID Number 
 ;;^DD(.85,.001,23,16,0)
 ;;=10 instead of 8 in recognition of the debt English owes Arabic for 
 ;;^DD(.85,.001,23,17,0)
 ;;=introducing the decimal numbering system to Europe. Russian and Greek 
 ;;^DD(.85,.001,23,18,0)
 ;;=were the next two translations the Fileman team was approached about. I 
 ;;^DD(.85,.001,23,19,0)
 ;;=do not recall why for Hebrew we skipped ahead to ID Number 18, but I'm 
 ;;^DD(.85,.001,23,20,0)
 ;;=sure there was a reason.
 ;;^DD(.85,.001,23,21,0)
 ;;= 
 ;;^DD(.85,.001,23,22,0)
 ;;=Thereafter, languages are added in segments, in order by Name, starting 
 ;;^DD(.85,.001,23,23,0)
 ;;=with ID Number 8. The segments correspond to the ISO 639 language 
 ;;^DD(.85,.001,23,24,0)
 ;;=standards, in order (639-1 languages in segment two, 639-2 in three, and 
 ;;^DD(.85,.001,23,25,0)
 ;;=so on). Each language has one unique record in this file, so wherever a 
 ;;^DD(.85,.001,23,26,0)
 ;;=language in one segment has already been included in an earlier segment, 
 ;;^DD(.85,.001,23,27,0)
 ;;=it is not included in the later segment (e.g., Greek was in segment one, 
 ;;^DD(.85,.001,23,28,0)
 ;;=so it is not also added as a duplicate in segment two).
 ;;^DD(.85,.001,23,29,0)
 ;;= 
 ;;^DD(.85,.001,23,30,0)
 ;;=This segmented approach makes it comparatively easy to upgrade the file 
 ;;^DD(.85,.001,23,31,0)
 ;;=in discrete batches, to keep the update projects manageable.
 ;;^DD(.85,.001,"DT")
 ;;=3121031
 ;;^DD(.85,.01,0)
 ;;=NAME^RFJ60^^0;1^K:$L(X)>60!($L(X)<1) X
 ;;^DD(.85,.01,.1)
 ;;=Language-Name
 ;;^DD(.85,.01,3)
 ;;=Answer must be 1-60 characters in length.
 ;;^DD(.85,.01,21,0)
 ;;=^^10^10^3121031^
 ;;^DD(.85,.01,21,1,0)
 ;;=Enter the English name of the language, not the native name. 
 ;;^DD(.85,.01,21,2,0)
 ;;= 
 ;;^DD(.85,.01,21,3,0)
 ;;=The default is the English name from ISO 639, converted where necessary to
 ;;^DD(.85,.01,21,4,0)
 ;;=ASCII. Where the ISO 639 standards disagree (cf. "Central Khmer" in ISO
 ;;^DD(.85,.01,21,5,0)
 ;;=639-1 to "Khmer" in ISO 639-3), the most recent standard's spelling is
 ;;^DD(.85,.01,21,6,0)
 ;;=used.
 ;;^DD(.85,.01,21,7,0)
 ;;= 
 ;;^DD(.85,.01,21,8,0)
 ;;=However, this use of ISO 639's spelling as a default is overridden in 
 ;;^DD(.85,.01,21,9,0)
 ;;=several different ways to improve consistency across entries and to 
 ;;^DD(.85,.01,21,10,0)
 ;;=reduce selection error.
 ;;^DD(.85,.01,23,0)
 ;;=^^63^63^3121031^
 ;;^DD(.85,.01,23,1,0)
 ;;=This is the English name of the language, not the native name. It 
 ;;^DD(.85,.01,23,2,0)
 ;;=defaults to the English name from ISO 639, mixed case, converted where 
 ;;^DD(.85,.01,23,3,0)
 ;;=necessary to ASCII. Where the ISO 639 standards disagree (cf. "Central 
 ;;^DD(.85,.01,23,4,0)
 ;;=Khmer" in ISO 639-1 to "Khmer" in ISO 639-3), the most recent standard's 
 ;;^DD(.85,.01,23,5,0)
 ;;=spelling is used.
 ;;^DD(.85,.01,23,6,0)
 ;;= 
 ;;^DD(.85,.01,23,7,0)
 ;;=However, this use of ISO 639's spelling as a default is overridden in 
 ;;^DD(.85,.01,23,8,0)
 ;;=several different ways to improve consistency across entries and to 
 ;;^DD(.85,.01,23,9,0)
 ;;=reduce selection error.
 ;;^DD(.85,.01,23,10,0)
 ;;= 
 ;;^DD(.85,.01,23,11,0)
 ;;=For example, for most modern languages, the form of the name that 
 ;;^DD(.85,.01,23,12,0)
 ;;=includes the word "Modern" and the parenthesized dates is an alternate 
 ;;^DD(.85,.01,23,13,0)
 ;;=name, but ISO 639 reverses that with Modern Greek. In this file, we 
 ;;^DD(.85,.01,23,14,0)
 ;;=reassert the pattern by making the ISO 639 name "Greek, Modern (1453-)" 
 ;;^DD(.85,.01,23,15,0)
 ;;=an alternate name and making the name "Greek" instead.
 ;;^DD(.85,.01,23,16,0)
 ;;= 
 ;;^DD(.85,.01,23,17,0)
 ;;=Since most users of these systems are medical professionals rather than 
 ;;^DD(.85,.01,23,18,0)
 ;;=linguists or historians, we emphasize modern languages and group 
 ;;^DD(.85,.01,23,19,0)
 ;;=historical ones away from the modern names to reduce accidents. For 
 ;;^DD(.85,.01,23,20,0)
 ;;=example, "French, Old (842-ca.1400)" as so named in ISO 639-2 is used as 
 ;;^DD(.85,.01,23,21,0)
 ;;=an alternate name for "Old French" in this file, to move the obsolete 
 ;;^DD(.85,.01,23,22,0)
 ;;=form of the language away from the modern one. Thus, "Old" languages, 
 ;;^DD(.85,.01,23,23,0)
 ;;="Ancient" ones, and "Middle" ones will tend to sort together. However, 
 ;;^DD(.85,.01,23,24,0)
 ;;=languages whose names look like historical ones, such as "Old Church 
 ;;^DD(.85,.01,23,25,0)
 ;;=Slavonic", that are still living languages or in active liturgical use 
 ;;^DD(.85,.01,23,26,0)
 ;;=are kept in this form if that is how they are best known.
 ;;^DD(.85,.01,23,27,0)
 ;;= 
 ;;^DD(.85,.01,23,28,0)
 ;;=Also, such forms that include parenthetical dates are changed to remove 
 ;;^DD(.85,.01,23,29,0)
 ;;=the dates and parentheses from the Name field; the original forms and 
 ;;^DD(.85,.01,23,30,0)
 ;;=variants are preserved in the Alternate Name field.
 ;;^DD(.85,.01,23,31,0)
 ;;= 
 ;;^DD(.85,.01,23,32,0)
 ;;=For similar reasons, language collections like "Banda languages" are 
 ;;^DD(.85,.01,23,33,0)
 ;;=renamed as "Languages, Banda" to move them away from individual language 
 ;;^DD(.85,.01,23,34,0)
 ;;=a patient might speak, like "Banda-Banda". The same was preserved from 
 ;;^DD(.85,.01,23,35,0)
 ;;=ISO 639 with creoles and pidgins (such as "Creoles and Pidgins, 
 ;;^DD(.85,.01,23,36,0)
 ;;=Portuguese-Based"), which are collective languages, to kepp them separate 
 ;;^DD(.85,.01,23,37,0)
 ;;=from the individual languages they might be confused with (such as 
 ;;^DD(.85,.01,23,38,0)
 ;;="Portuguese"). However, individual languages like "Haitian Creole" and 
 ;;^DD(.85,.01,23,39,0)
 ;;="Chinook Jargon" whose ISO 639 names makes them sound like language 
 ;;^DD(.85,.01,23,40,0)
 ;;=collections are nevertheless left as is, since these are the names they 
 ;;^DD(.85,.01,23,41,0)
 ;;=are known by and since the distinguishing part of the name does come 
 ;;^DD(.85,.01,23,42,0)
 ;;=first, allowing for unambiguous selection.
 ;;^DD(.85,.01,23,43,0)
 ;;= 
 ;;^DD(.85,.01,23,44,0)
 ;;=Where the language name from ISO 639 is a list of alternative names, as 
 ;;^DD(.85,.01,23,45,0)
 ;;=in "Catalan, Valencian", the dominant name (based on other code sets, 
 ;;^DD(.85,.01,23,46,0)
 ;;=Ethnologue, Wikipedia, e.g. "Catalan") is used as the Name, with the 
 ;;^DD(.85,.01,23,47,0)
 ;;=other name(s) (e.g., "Valencian") added to the Alternate Name field.
 ;;^DD(.85,.01,23,48,0)
 ;;= 
 ;;^DD(.85,.01,23,49,0)
 ;;=As a general rule (except in the case of language collections), ISO 639 
 ;;^DD(.85,.01,23,50,0)
 ;;=names that use commas to invert a language name (like "Sorbian, Upper") 
 ;;^DD(.85,.01,23,51,0)
 ;;=are corrected (like "Upper Sorbian"), and the ISO 639 name is made an 
 ;;^DD(.85,.01,23,52,0)
 ;;=Alternate Name. We do not try to use commas in the Name field to group 
 ;;^DD(.85,.01,23,53,0)
 ;;=together all related languages or dialects, though we do in the Alternate 
 ;;^DD(.85,.01,23,54,0)
 ;;=Name field.
 ;;^DD(.85,.01,23,55,0)
 ;;= 
 ;;^DD(.85,.01,23,56,0)
 ;;=In the Name field, parenthetical comments are generally restricted to 
 ;;^DD(.85,.01,23,57,0)
 ;;=distinguishing between unrelated languages that have the same name, like 
 ;;^DD(.85,.01,23,58,0)
 ;;="Lele (Democratic Republic of Congo)" and "Lele (Papua New Guinea)". The 
 ;;^DD(.85,.01,23,59,0)
 ;;=parenthetical words will be (in order of preference) a country, a people, 
 ;;^DD(.85,.01,23,60,0)
 ;;=or an alternate name of the language, so long as it distinguishes it from 
 ;;^DD(.85,.01,23,61,0)
 ;;=the other identically named languages. To date, we have not had to change 
 ;;^DD(.85,.01,23,62,0)
 ;;=any of the ISO 639 names we've imported to make or correct these 
 ;;^DD(.85,.01,23,63,0)
 ;;=distinctions, but we stand ready to do so to enforce this pattern.
 ;;^DD(.85,.01,"DT")
 ;;=3121031
 ;;^DD(.85,.02,0)
 ;;=TWO LETTER CODE^FJ2^^0;2^K:$L(X)>2!($L(X)<2) X
 ;;^DD(.85,.02,3)
 ;;=Answer must be 2 characters in length.
 ;;^DD(.85,.02,21,0)
 ;;=^^3^3^3121101^^
 ;;^DD(.85,.02,21,1,0)
 ;;=Enter the two-letter code defined for this language in the ISO 639-1
 ;;^DD(.85,.02,21,2,0)
 ;;=standard. Not every language has a two-letter code; for those that do not
 ;;^DD(.85,.02,21,3,0)
 ;;=leave this field blank.
 ;;^DD(.85,.02,23,0)
 ;;=^^1^1^3121101^
 ;;^DD(.85,.02,23,1,0)
 ;;=Future versions of this file wil include an optional key on this field.
 ;;^DD(.85,.02,"DT")
 ;;=3121101
 ;;^DD(.85,.03,0)
 ;;=THREE LETTER CODE^FJ3^^0;3^K:$L(X)>3!($L(X)<3) X
 ;;^DD(.85,.03,3)
 ;;=Answer must be 3 characters in length.
 ;;^DD(.85,.03,21,0)
 ;;=^^2^2^3121101^^^^
 ;;^DD(.85,.03,21,1,0)
 ;;=Enter the three-letter code defined for this language in the ISO 639-2/B
 ;;^DD(.85,.03,21,2,0)
 ;;=standard.
 ;;^DD(.85,.03,23,0)
 ;;=^^2^2^3121101^
 ;;^DD(.85,.03,23,1,0)
 ;;=When this file is upgraded to ISO-639-6, an optional key will be added to 
 ;;^DD(.85,.03,23,2,0)
 ;;=this field.
 ;;^DD(.85,.03,"DT")
 ;;=3121101
 ;;^DD(.85,.04,0)
 ;;=FOUR LETTER CODE^FJ4^^0;4^K:$L(X)>4!($L(X)<4) X
 ;;^DD(.85,.04,3)
 ;;=Answer must be 4 characters in length.
 ;;^DD(.85,.04,21,0)
 ;;=^^1^1^3121101^^^
 ;;^DD(.85,.04,21,1,0)
 ;;=Enter the four letter code associated with the language in ISO-639-6. 
 ;;^DD(.85,.04,23,0)
 ;;=^^3^3^3121101^
 ;;^DD(.85,.04,23,1,0)
 ;;=This field is currently not used in this version of the release (as of
 ;;^DD(.85,.04,23,2,0)
 ;;=Fileman V22.2). In a future version when this file is upgraded to 
 ;;^DD(.85,.04,23,3,0)
 ;;=ISO-639-6, a key will be added to this field.
 ;;^DD(.85,.04,"DT")
 ;;=3121101
