DICATTUD ;SFISC/MKO - USER DEFINED DATA TYPES ;25OCT2016
 ;;22.2;VA FileMan;**2**;Jan 05, 2016;Build 139
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
BEGIN D EN(A,DA,N,O) I $G(DTOUT) K DTOUT G CHECK^DICATT ;Come from DICATT (roll-and-scroll mode)
 G ^DICATT1
 ;
 ;
 ;
SCREENMN ;Come from DICATTD (ScreenMan mode)
 N L,M,C,Z,DIZ,DIALLVAL,DIVAL,DTOUT
 D CLRMSG^DDS
 D EN(DICATTA,DICATTF,X,DICATT4]"") I $G(DTOUT) QUIT
 S DICATT2N=$P(DIZ,U),DICATT3N="" I $$ESTORE^DICATT1(DICATT2N) D UNED^DDSUTL(20.5,"DICATT",1,2) ;don't allow 'MULTIPLE'
 S DICATT5N=C,DICATTLN=L
 S DICATTMN="" D PUT^DDSVALF(98,"DICATT",1,DICATTMN) ;HERE IS THE HELP-PROMPT, NULLED OUT FOR NOW
 QUIT
 ;
 ;
 ;
 ;
 ;
 ;In: N  = data type number
 ;    O  = 0 : if new field
 ;    A  = file #
 ;    DA = field #
 ;
 ;Out: DICATTPM array (to be merged into ^DD(file#,field#)
 ;     e.g., DICATTPM(101,4,0)="4^",  DICATTPM(101,4,31)="DPT("  says that POINTER property is "DPT("
 ;     L = Maximum internal length
 ;     M = Help text
 ;  M(2) = 1 : user changed a default on an old field
 ;     C = Old input transform (5-99)
 ; DIZ,Z = dataTypeAbbrev_t#, where # is the data type number
 ;
 ;Variables used:
 ; DIVAL = obtained property value
 ; DIVALS(abbrev) = array of property values (already obtained)
 ; DIVALS("DIDEF") = default property value presented to user
 ; DICHANGE = 1 : if user changed a default value (set in PROP)
 ;
EN(A,DA,N,O) ;
 K DICATTPM,M(2),DTOUT
 N DIMETH,DIORD,DIPROP,DIVALS,DICHANGE,DDS
 M DICATTPM(101)=^DD(A,DA,101),DICATTPM(201)=^DD(A,DA,201) ;GRAB THE EXISTING VALUES OF THE PROPERTIES AND METHODS
 ;
 ;Loop through properties in Data Type file, by ORDER, and get values
 S DIORD=""
 F  S DIORD=$O(^DI(.81,N,101,"AC",DIORD)) Q:'DIORD!$D(DUOUT)!$D(DTOUT)  D
 .S DIPROP=$O(^DI(.81,N,101,"AC",DIORD,"")) Q:'DIPROP  D PROPMETH("P",N,DIPROP,.DIVALS)
 ;If user ^-d or timed out, go back to delete field and reprompt
 I $D(DUOUT)!$D(DTOUT) K DUOUT,DICATTPM S DTOUT=1 Q
 ;Loop through methods in Data Type file
 S DIMETH=0
 I DUZ(0)="@" F  S DIMETH=$O(^DI(.81,N,201,DIMETH)) Q:'DIMETH  D:$G(^(DIMETH,31))="" PROPMETH("M",N,DIMETH,.DIVALS)
DONE ;
 ;Set L and M
 K M
 S L=$$PROP4TYP^DIETLIBF("INTERNAL LENGTH",N) S:'L L=30 ;$G(DIVALS("MAXL"),30)
 ;S:$G(DIVALS("HELP"))]"" M=DIVALS("HELP")
 ;I $G(DICHANGE),O S M(2)=1
 ;
 ;Put input transform in C; don't need to store in ^DD(file#,field#,201)
 ;Set Z and DIZ
 S C="Q" ;$G(DICAT201(1,1),"Q") K DICAT201(1)
 S Z=$$GET1^DIQ(.81,N,"INTERNAL REPRESENTATION") S:Z="" Z="F"
 S (DIZ,Z)=Z_"t"_N_U
 QUIT
 ;
 ;
 ;
PROPMETH(PROPMETH,N,DIPROP,DIVALS) ;For DATA TYPE N, get a PROPERTY (PROPMETH="P") or METHOD
 N DIPROMPT,DIVAL,DIEXEC,DIDD,DIGL
 K DIVALS("DIDEF")
 S DIDD=$S(PROPMETH="M":.87,1:.86),DIGL=$S(PROPMETH="M":201,1:101) ;CHANGED FROM '102'
 ;If there's an Executable Default, get value
 I $G(^DI(.81,N,DIGL,DIPROP,31.2))'?."^" D
 . S DIEXEC=1
 . S DIVAL=$G(^DD(A,DA,DIGL,DIPROP,2)) ;DIGL WILL BE 201, NOT 102
 . ;I 'O!$G(DICHANGE),^DI(.81,N,101,DIPROP,31.2)["|" S DIVAL=$$PARSE^DIETLIB(^(31.2),.DIVALS)
 . S DIVALS("DIDEF")=DIVAL
 ;
 ;Otherwise, get regular default
 E  S (DIVAL,DIVALS("DIDEF"))=$$GETDEF(N,DIPROP,.DIVALS)
 ;
 ;Should user be prompted for value?
 S DIPROMPT=$G(^DI(.81,N,DIGL,DIPROP,31))="" ;PROMPT IF THERE IS NO VALUE
 I $G(^DI(.81,N,DIGL,DIPROP,10))'?."^" X $$PARSE^DIETLIB(^(10)) S DIPROMPT=$T
 ;
 ;If so, prompt for DIVAL
 I DIPROMPT D
 . ;If there's Get Code, execute it
 . I $G(^DI(DIDD,DIPROP,51))'?."^" D
 .. D XCODEM^DIETLIB(^DI(DIDD,DIPROP,51),.DIVALS,.DIVAL)
 .. S:$D(DIVAL)[0 DUOUT=1
 . ;
 . ;Otherwise, use ^DIR to get value of property
 . E  S DIVAL=$$DIR(DIPROP,.DIVALS)
 . Q:$D(DUOUT)!$D(DTOUT)
 . S:DIVAL'=DIVALS("DIDEF") DICHANGE=1
 ;
 Q:$D(DUOUT)!$D(DTOUT)
 D SAVE(DIPROP,.DIVAL,.DIVALS,.DIGL,$G(DIEXEC))
 Q
 ;
DIR(DIPROP,DIVALS) ;Do a ^DIR read to get value for property or method
 N I,J,X,Y,DIR,DIRUT,DIROUT
 ;
 ;Get DIR(0) from the PROPERTY or METHOD, (convert |abbr| to values)
 S DIR(0)=$$PARSE^DIETLIB($G(^DI(DIDD,DIPROP,42)),.DIVALS)
 Q:DIR(0)="" ""
A ;Put Prompt into DIR("A")
 S I=0
 S J=1,DIR("A",1)=$P($G(^DI(DIDD,DIPROP,0)),U)
 F  S I=$O(^DI(DIDD,DIPROP,43,I)) Q:'I  D:$D(^(I,0))#2
 . S J=J+1
 . S DIR("A",J)=^DI(DIDD,DIPROP,43,I,0)
 I J S DIR("A")=DIR("A",J) K DIR("A",J)
H ;Put Help into DIR("?")
 S (I,J)=0
 I $G(^DI(DIDD,DIPROP,11))]"" S J=1,DIR("?",1)=^(11)
 F  S I=$O(^DI(DIDD,DIPROP,44,I)) Q:'I  D:$D(^(I,0))#2
 . S J=J+1
 . S DIR("?",J)=^DI(DIDD,DIPROP,44,I,0)
 I J S DIR("?")=DIR("?",J) K DIR("?",J)
B ;Put default into DIR("B")
 S I=$G(DICATTPM(DIGL,DIPROP,31)) ;get the current VALUE
 I I="" S I=$G(DIVALS("DIDEF")) ;or get the DEFAULT from node 33 of the PROPERTY for this DATA TYPE
 I I]"" D  S DIR("B")=I
 .I DIGL=101 D
 ..N T S T=+$G(^DI(.86,DIPROP,41)) ;get the TYPE
 ..I T=1 S I=$$DATE^DIUTL(I)
 ..I T=3 S I=$P($P($P(DIR(0),U,2),I_":",2),";")
 ;S:$G(DIVALS("DIDEF"))]"" DIR("B")=DIVALS("DIDEF")
 S:$G(^DI(DIDD,DIPROP,45))]"" DIR("S")=^(45)
 S:$G(^DI(DIDD,DIPROP,46))]"" DIR("T")=^(46)
 D ^DIR
 Q Y
 ;
 ;
SAVE(DIPROP,DIVAL,DIVALS,DICAT101,DIEXEC) ;Save the value of the property
 ; in DIVALS(abbr) and DICAT101
 ;DIVAL is the value of the property
 ;DIEXEC = 1 : if value is an executable
 ;
 ;Returns:
 ;  DIVALS(abbr)= array property values
 ;  DICATTPM(DIGL,prop#,0)=prop#^abbrev
 ;  DICATTPM(DIGL,prop#,31)=value
 ;   or         2)=executable value
 ;  DICATTPM(DIGL,prop#,3,n,0) = descendent node n of DIVAL
 ;
 N DIABBR
 ;
 ;Set the DIVALS array
 S DIABBR=$P(^DI(DIDD,DIPROP,0),U,2)
 S:DIABBR]"" DIVALS(DIABBR)=DIVAL
 ;
 ;Set the DICATTPM array
 I DIVAL]"" D
 .N I,Z S Z=0 F I=1:1 S Z=$O(DICATTPM(DIGL,Z)) Q:'Z
 .S DICATTPM(DIGL,0)="^."_DIGL_"01P^"_DIPROP_"^"_I ;remember that DIGL=101 or 201
 . S DICATTPM(DIGL,DIPROP,0)=DIPROP_U_DIABBR
 . S DICATTPM(DIGL,DIPROP,31+$G(DIEXEC))=DIVAL
 . I $D(DIVAL)>9 S I="" F  S I=$O(DIVAL(I)) Q:I=""  D
 .. I $D(DIVAL(I))#2 S DICATTPM(DIGL,DIPROP,3,I,0)=DIVAL(I)
 .. E  I $D(DIVAL(I,0))#2 S DICATTPM(DIGL,DIPROP,3,I,0)=DIVAL(I,0)
 .. E  Q
 ;
 ;Execute the post action
 ;X:$G(^DI(.81,N,101,DIPROP,61))'?."^" $$PARSE^DIETLIB(^(61))
 Q
 ;
 ;
GETDEF(N,DIPROP,DIVALS) ;Get defaults for a property.
 ;May come from the ^DD or the data type file.
 N DIDEF
 ;
 ;Get value from ^DD
 S DIDEF=$S(DIPROP=3:$G(^DD(A,DA,3)),1:$G(^DD(A,DA,101,DIPROP,31)))
 ;
 ;For existing fields, return default from ^DD(file#,field#)
 ;if the user hasn't changed any property values
 I O,'$G(DICHANGE) Q DIDEF
 ;
 ;Otherwise, look at default from Data Type file.
 ;For existing fields where default contains no |abbr|,
 ;return value from DD.
 ;
 ;Default
 S DIDEF=$G(^DI(.81,N,101,DIPROP,33))
 ;Q:$G(^DI(.81,N,101,DIPROP,31))]"" $S(^(31)'["|"&O:DIDEF,1:$$PARSE^DIETLIB(^(31),.DIVALS))
 ;
 ;Build Default
 ;Q:$G(^DI(.81,N,101,DIPROP,31.1))]"" $S(^(31.1)'["|"&O:DIDEF,1:$$XCODE^DIETLIB(^(31.1),.DIVALS)) ;NOT THERE ANY MORE
 ;
 Q DIDEF
