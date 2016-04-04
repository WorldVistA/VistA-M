DMLAI002 ;VEN/SMH-DMLA (LANGUAGE FILE INIT) ; 06-DEC-2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 Q:'DIFQ(.85)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(.85,.05,0)
 ;;=ALTERNATE THREE LETTER CODE^FJ3^^0;5^K:$L(X)>3!($L(X)<3) X
 ;;^DD(.85,.05,3)
 ;;=Answer must be 3 characters in length.
 ;;^DD(.85,.05,21,0)
 ;;=^^4^4^3121101^
 ;;^DD(.85,.05,21,1,0)
 ;;=This is the alternate three letter code for a language. This will only be 
 ;;^DD(.85,.05,21,2,0)
 ;;=used in cases where the language abbreviation is different in English 
 ;;^DD(.85,.05,21,3,0)
 ;;=than in the native language. E.g. GER instead of DEU; for German instead 
 ;;^DD(.85,.05,21,4,0)
 ;;=of Deutsch. This alternate abbreviation can be found in ISO 639-2/B.
 ;;^DD(.85,.05,23,0)
 ;;=^^1^1^3121101^
 ;;^DD(.85,.05,23,1,0)
 ;;=In a future version of Fileman, this field will have an optional key.
 ;;^DD(.85,.05,"DT")
 ;;=3121101
 ;;^DD(.85,.06,0)
 ;;=SCOPE^S^I:Individual;M:Macrolanguage;C:Collective;S:Special;L:Local;^0;6^Q
 ;;^DD(.85,.06,3)
 ;;=Select a language's scope
 ;;^DD(.85,.06,21,0)
 ;;=^^12^12^3121031^
 ;;^DD(.85,.06,21,1,0)
 ;;=Enter the Scope of a Language.
 ;;^DD(.85,.06,21,2,0)
 ;;= 
 ;;^DD(.85,.06,21,3,0)
 ;;=Individual if the language is an individually identifiable language 
 ;;^DD(.85,.06,21,4,0)
 ;;=(e.g. 'Cantonese').
 ;;^DD(.85,.06,21,5,0)
 ;;= 
 ;;^DD(.85,.06,21,6,0)
 ;;=Macrolanguage if the language encopasses several other languages (e.g. 
 ;;^DD(.85,.06,21,7,0)
 ;;='Chinese')
 ;;^DD(.85,.06,21,8,0)
 ;;= 
 ;;^DD(.85,.06,21,9,0)
 ;;=Collective if the language is a language group (e.g. 'Languages, 
 ;;^DD(.85,.06,21,10,0)
 ;;=Sino-Tibetan')
 ;;^DD(.85,.06,21,11,0)
 ;;= 
 ;;^DD(.85,.06,21,12,0)
 ;;=Special and Local are reserved for specific entries.
 ;;^DD(.85,.06,23,0)
 ;;=^^1^1^3121101^
 ;;^DD(.85,.06,23,1,0)
 ;;=The current version of this file does not distribute data for this field.
 ;;^DD(.85,.06,"DT")
 ;;=3121101
 ;;^DD(.85,.07,0)
 ;;=TYPE^S^L:Living;C:Constructed;A:Ancient;H:Historical;E:Extinct;^0;7^Q
 ;;^DD(.85,.07,.1)
 ;;=Historical Status
 ;;^DD(.85,.07,3)
 ;;=Select a choice.
 ;;^DD(.85,.07,21,0)
 ;;=^^12^12^3121101^^
 ;;^DD(.85,.07,21,1,0)
 ;;=Living means that the language is spoken today (e.g. English).
 ;;^DD(.85,.07,21,2,0)
 ;;= 
 ;;^DD(.85,.07,21,3,0)
 ;;=Constructed means that the language is artificial (e.g. Esperanto).
 ;;^DD(.85,.07,21,4,0)
 ;;= 
 ;;^DD(.85,.07,21,5,0)
 ;;=Ancient means that the language is very old and not spoken any more (e.g.
 ;;^DD(.85,.07,21,6,0)
 ;;=Ancient Egyptian).
 ;;^DD(.85,.07,21,7,0)
 ;;= 
 ;;^DD(.85,.07,21,8,0)
 ;;=Historical means that the language was being used in the Medieval times 
 ;;^DD(.85,.07,21,9,0)
 ;;=and is not spoken any more (e.g. Old High German).
 ;;^DD(.85,.07,21,10,0)
 ;;= 
 ;;^DD(.85,.07,21,11,0)
 ;;=Extinct means that the language was being used recently but has died out 
 ;;^DD(.85,.07,21,12,0)
 ;;=(e.g. Cornish).
 ;;^DD(.85,.07,23,0)
 ;;=^^1^1^3121101^
 ;;^DD(.85,.07,23,1,0)
 ;;=The current version of this file does not distribute data for this field.
 ;;^DD(.85,.07,"DT")
 ;;=3121101
 ;;^DD(.85,.08,0)
 ;;=LINGUISTIC CATEGORY^*P.85'^DI(.85,^0;8^S DIC("S")="I $P(^(0),U,6)=""C""" D ^DIC K DIC S DIC=$G(DIE),X=+Y K:Y<0 X
 ;;^DD(.85,.08,3)
 ;;=Select a choice.
 ;;^DD(.85,.08,12)
 ;;=Only collective languages are selectable
 ;;^DD(.85,.08,12.1)
 ;;=S DIC("S")="I $P(^(0),U,6)=""C"""
 ;;^DD(.85,.08,21,0)
 ;;=^^1^1^3121101^^
 ;;^DD(.85,.08,21,1,0)
 ;;=Enter a language collection to which this language belongs.
 ;;^DD(.85,.08,23,0)
 ;;=^^1^1^3121101^
 ;;^DD(.85,.08,23,1,0)
 ;;=The current version of this file does not distribute data for this field.
 ;;^DD(.85,.08,"DT")
 ;;=3121101
 ;;^DD(.85,.09,0)
 ;;=MEMBER OF LANGUAGE SET^*P.85'^DI(.85,^0;9^S DIC("S")="I $P(^(0),U,6)=""M""" D ^DIC K DIC S DIC=$G(DIE),X=+Y K:Y<0 X
 ;;^DD(.85,.09,3)
 ;;=Enter a choice.
 ;;^DD(.85,.09,12)
 ;;=You may only select Macrolanguages
 ;;^DD(.85,.09,12.1)
 ;;=S DIC("S")="I $P(^(0),U,6)=""M"""
 ;;^DD(.85,.09,21,0)
 ;;=^^3^3^3121101^
 ;;^DD(.85,.09,21,1,0)
 ;;=If this language is a dialect of a macrolanguage, select the 
 ;;^DD(.85,.09,21,2,0)
 ;;=macrolanguage to which it belongs. (E.g. Cantonese is a dialect of 
 ;;^DD(.85,.09,21,3,0)
 ;;=Chinese; thus Chinese is Cantonese's macrolanguage.)
 ;;^DD(.85,.09,23,0)
 ;;=^^1^1^3121101^
 ;;^DD(.85,.09,23,1,0)
 ;;=The current version of this file does not distribute data for this field.
 ;;^DD(.85,.09,"DT")
 ;;=3121101
 ;;^DD(.85,1,0)
 ;;=ALTERNATE NAME^.8501^^1;0
 ;;^DD(.85,10,0)
 ;;=DESCRIPTION^.8502^^10;0
 ;;^DD(.85,10,"DT")
 ;;=3121031
 ;;^DD(.85,10.1,0)
 ;;=ORDINAL NUMBER FORMAT^K^^ORD;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.85,10.1,3)
 ;;=This is Standard MUMPS code.
 ;;^DD(.85,10.1,9)
 ;;=@
 ;;^DD(.85,10.1,21,0)
 ;;=^^6^6^2941121^^^^
 ;;^DD(.85,10.1,21,1,0)
 ;;=MUMPS code used to transfer a number in Y to its ordinal equivalent in
 ;;^DD(.85,10.1,21,2,0)
 ;;=this language. The code should set Y to the ordinal equivalent without
 ;;^DD(.85,10.1,21,3,0)
 ;;=altering any other variables in the environment.  Ex. in English:
 ;;^DD(.85,10.1,21,4,0)
 ;;=       Y=1     becomes         Y=1ST
 ;;^DD(.85,10.1,21,5,0)
 ;;=       Y=2     becomes         Y=2ND
 ;;^DD(.85,10.1,21,6,0)
 ;;=       Y=3     becomes         Y=3RD  etc.
 ;;^DD(.85,10.1,"DT")
 ;;=2940307
 ;;^DD(.85,10.2,0)
 ;;=DATE/TIME FORMAT^K^^DD;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.85,10.2,3)
 ;;=This is Standard MUMPS code.
 ;;^DD(.85,10.2,9)
 ;;=@
 ;;^DD(.85,10.2,21,0)
 ;;=^^6^6^2941121^^^
 ;;^DD(.85,10.2,21,1,0)
 ;;=MUMPS code used to transfer a date or date/time in Y from FileMan internal
 ;;^DD(.85,10.2,21,2,0)
 ;;=format, to printable format equivalent to English MMM DD,YYYY@HH.MM.SS.
 ;;^DD(.85,10.2,21,3,0)
 ;;=The code should set Y to the output, without altering any other variables
 ;;^DD(.85,10.2,21,4,0)
 ;;=in the environment.  Ex. in English:
 ;;^DD(.85,10.2,21,5,0)
 ;;= 
 ;;^DD(.85,10.2,21,6,0)
 ;;=       Y=2940612.031245        becomes         Y=JUN 12,1994@03:12:45
 ;;^DD(.85,10.2,"DT")
 ;;=2940307
 ;;^DD(.85,10.21,0)
 ;;=DATE/TIME FORMAT (FMTE)^K^^FMTE;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.85,10.21,3)
 ;;=This is Standard MUMPS code.
 ;;^DD(.85,10.21,9)
 ;;=@
 ;;^DD(.85,10.21,21,0)
 ;;=^^22^22^2941122^
 ;;^DD(.85,10.21,21,1,0)
 ;;=MUMPS code used to transfer a date or date/time in Y from FileMan internal
 ;;^DD(.85,10.21,21,2,0)
 ;;=format, to printable format based on the various outputs from routine
 ;;^DD(.85,10.21,21,3,0)
 ;;=FMTE^DILIBF.  This is an extrinsic function.  Coming in to this MUMPS
 ;;^DD(.85,10.21,21,4,0)
 ;;=code, in addition to the internal date in Y, a third parameter will be
 ;;^DD(.85,10.21,21,5,0)
 ;;=defined to contain flags equivalent to the flag passed as the second input
 ;;^DD(.85,10.21,21,6,0)
 ;;=parameter to FMTE^DILIBF. The code should set Y to the output, without
 ;;^DD(.85,10.21,21,7,0)
 ;;=altering any other variables in the environment.  The output should be
 ;;^DD(.85,10.21,21,8,0)
 ;;=formatted based on these flags:
 ;;^DD(.85,10.21,21,9,0)
 ;;= 
 ;;^DD(.85,10.21,21,10,0)
 ;;= 1    MMM DD, YYYY@HH:MM:SS
 ;;^DD(.85,10.21,21,11,0)
 ;;= 2    MM/DD/YY@HH:MM:SS     no leading zeroes on month,day
 ;;^DD(.85,10.21,21,12,0)
 ;;= 3    DD/MM/YY@HH:MM:SS     no leading zeroes on month,day
 ;;^DD(.85,10.21,21,13,0)
 ;;= 4    YY/MM/DD@HH:MM:SS
 ;;^DD(.85,10.21,21,14,0)
 ;;= 5    MMM DD,YYYY@HH:MM:SS  no space before year,no leading zero on day
 ;;^DD(.85,10.21,21,15,0)
 ;;= 6    MM-DD-YYYY @ HH:MM:SS spaces separate time 
 ;;^DD(.85,10.21,21,16,0)
 ;;= 7    MM-DD-YYYY@HH:MM:SS   no leading zeroes on month,day
 ;;^DD(.85,10.21,21,17,0)
 ;;= 
 ;;^DD(.85,10.21,21,18,0)
 ;;=letters in the flag
 ;;^DD(.85,10.21,21,19,0)
 ;;= S    return always seconds
 ;;^DD(.85,10.21,21,20,0)
 ;;= U    return uppercase month names
 ;;^DD(.85,10.21,21,21,0)
 ;;= P    return time as am,pm
 ;;^DD(.85,10.21,21,22,0)
 ;;= D    return only date part
 ;;^DD(.85,10.21,"DT")
 ;;=2940624
 ;;^DD(.85,10.22,0)
 ;;=TIME^K^^TIME;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.85,10.22,3)
 ;;=This is Standard MUMPS code for the output of time only.
 ;;^DD(.85,10.22,9)
 ;;=@
 ;;^DD(.85,10.22,21,0)
 ;;=^^2^2^2960318^
 ;;^DD(.85,10.22,21,1,0)
 ;;=The code stored here will be used to get formatted output of the time
 ;;^DD(.85,10.22,21,2,0)
 ;;=part belonging to a FileMan Date/Time value.
 ;;^DD(.85,10.22,"DT")
 ;;=2960318
 ;;^DD(.85,10.3,0)
 ;;=CARDINAL NUMBER FORMAT^K^^CRD;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.85,10.3,3)
 ;;=This is Standard MUMPS code.
 ;;^DD(.85,10.3,9)
 ;;=@
 ;;^DD(.85,10.3,21,0)
 ;;=^^5^5^2941121^^
 ;;^DD(.85,10.3,21,1,0)
 ;;=MUMPS code used to transfer a number in Y to its cardinal equivalent in
 ;;^DD(.85,10.3,21,2,0)
 ;;=this language. The code should set Y to the cardinal equivalent without
 ;;^DD(.85,10.3,21,3,0)
 ;;=altering any other variables in the environment.  Ex. in English:
 ;;^DD(.85,10.3,21,4,0)
 ;;=       Y=2000     becomes         Y=2,000
 ;;^DD(.85,10.3,21,5,0)
 ;;=       Y=1234567  becomes         Y=1,234,567
 ;;^DD(.85,10.3,"DT")
 ;;=2940308
 ;;^DD(.85,10.4,0)
 ;;=UPPERCASE CONVERSION^K^^UC;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.85,10.4,3)
 ;;=This is Standard MUMPS code.
 ;;^DD(.85,10.4,9)
 ;;=@
 ;;^DD(.85,10.4,21,0)
 ;;=^^4^4^2941121^
 ;;^DD(.85,10.4,21,1,0)
 ;;=MUMPS code used to convert text in Y to its upper-case equivalent in
 ;;^DD(.85,10.4,21,2,0)
 ;;=this language. The code should set Y to the external format without
 ;;^DD(.85,10.4,21,3,0)
 ;;=altering any other variables in the environment.  In English, changes
 ;;^DD(.85,10.4,21,4,0)
 ;;=   abCdeF      to: ABCDEF
 ;;^DD(.85,10.4,"DT")
 ;;=2940308
 ;;^DD(.85,10.5,0)
 ;;=LOWERCASE CONVERSION^K^^LC;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.85,10.5,3)
 ;;=This is Standard MUMPS code.
 ;;^DD(.85,10.5,9)
 ;;=@
 ;;^DD(.85,10.5,21,0)
 ;;=^^4^4^2941121^
 ;;^DD(.85,10.5,21,1,0)
 ;;=MUMPS code used to convert text in Y to its lower-case equivalent in  
 ;;^DD(.85,10.5,21,2,0)
 ;;=this language. The code should set Y to the external format without
 ;;^DD(.85,10.5,21,3,0)
 ;;=altering any other variables in the environment.  In English, changes:
 ;;^DD(.85,10.5,21,4,0)
 ;;=    ABcdEFgHij         to:  abcdefghij
 ;;^DD(.85,10.5,"DT")
 ;;=2940308
 ;;^DD(.85,20.2,0)
 ;;=DATE INPUT^K^^20.2;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.85,20.2,3)
 ;;=This is Standard MUMPS code.
 ;;^DD(.85,20.2,9)
 ;;=@
 ;;^DD(.85,20.2,"DT")
 ;;=2940714
 ;;^DD(.8501,0)
 ;;=ALTERNATE NAME SUB-FIELD^^.01^1
 ;;^DD(.8501,0,"DT")
 ;;=3121101
 ;;^DD(.8501,0,"IX","B",.8501,.01)
 ;;=
 ;;^DD(.8501,0,"NM","ALTERNATE NAME")
 ;;=
 ;;^DD(.8501,0,"UP")
 ;;=.85
 ;;^DD(.8501,.01,0)
 ;;=ALTERNATE NAME^MFJ60^^0;1^K:$L(X)>60!($L(X)<1) X
 ;;^DD(.8501,.01,1,0)
 ;;=^.1
 ;;^DD(.8501,.01,1,1,0)
 ;;=.8501^B
 ;;^DD(.8501,.01,1,1,1)
 ;;=S ^DI(.85,DA(1),1,"B",$E(X,1,30),DA)=""
 ;;^DD(.8501,.01,1,1,2)
 ;;=K ^DI(.85,DA(1),1,"B",$E(X,1,30),DA)
 ;;^DD(.8501,.01,1,2,0)
 ;;=.85^F
 ;;^DD(.8501,.01,1,2,1)
 ;;=S ^DI(.85,"F",$E(X,1,30),DA(1),DA)=""
 ;;^DD(.8501,.01,1,2,2)
 ;;=K ^DI(.85,"F",$E(X,1,30),DA(1),DA)
 ;;^DD(.8501,.01,1,2,3)
 ;;=WHOLE FILE CROSS REFERENCE FOR ALTERNATE NAME
 ;;^DD(.8501,.01,1,2,"%D",0)
 ;;=^^1^1^3121101^
 ;;^DD(.8501,.01,1,2,"%D",1,0)
 ;;=Whole file cross-reference for ALTERNATE NAME multiple.
 ;;^DD(.8501,.01,1,2,"DT")
 ;;=3121101
 ;;^DD(.8501,.01,3)
 ;;=Answer must be 1-60 characters in length.
 ;;^DD(.8501,.01,21,0)
 ;;=^^2^2^3121101^^
 ;;^DD(.8501,.01,21,1,0)
 ;;=This field contains other synonyms for a language.
 ;;^DD(.8501,.01,21,2,0)
 ;;=E.g. for Greek, synonyms include Ellinika and Romaic.
 ;;^DD(.8501,.01,"DT")
 ;;=3121101
 ;;^DD(.8502,0)
 ;;=DESCRIPTION SUB-FIELD^^.01^1
 ;;^DD(.8502,0,"DT")
 ;;=3121031
 ;;^DD(.8502,0,"NM","DESCRIPTION")
 ;;=
 ;;^DD(.8502,0,"UP")
 ;;=.85
 ;;^DD(.8502,.01,0)
 ;;=DESCRIPTION^Wx^^0;1
 ;;^DD(.8502,.01,3)
 ;;=Enter an optional language description
 ;;^DD(.8502,.01,"DT")
 ;;=3121031
 ;;^UTILITY("KX",$J,"IX",.85,.85,"B",0)
 ;;=.85^B^Regular new-style B Index^R^^F^IR^I^.85^^^^^LS
 ;;^UTILITY("KX",$J,"IX",.85,.85,"B",1)
 ;;=S ^DI(.85,"B",X,DA)=""
 ;;^UTILITY("KX",$J,"IX",.85,.85,"B",2)
 ;;=K ^DI(.85,"B",X,DA)
 ;;^UTILITY("KX",$J,"IX",.85,.85,"B",2.5)
 ;;=K ^DI(.85,"B")
 ;;^UTILITY("KX",$J,"IX",.85,.85,"B",11.1,0)
 ;;=^.114IA^1^1
 ;;^UTILITY("KX",$J,"IX",.85,.85,"B",11.1,1,0)
 ;;=1^F^.85^.01^^1^F
 ;;^UTILITY("KX",$J,"IX",.85,.85,"B",11.1,1,3)
 ;;=
 ;;^UTILITY("KX",$J,"IX",.85,.85,"C",0)
 ;;=.85^C^Regular new style index on two letter language codes^R^^F^IR^I^.85^^^^^LS
 ;;^UTILITY("KX",$J,"IX",.85,.85,"C",1)
 ;;=S ^DI(.85,"C",X,DA)=""
 ;;^UTILITY("KX",$J,"IX",.85,.85,"C",2)
 ;;=K ^DI(.85,"C",X,DA)
 ;;^UTILITY("KX",$J,"IX",.85,.85,"C",2.5)
 ;;=K ^DI(.85,"C")
 ;;^UTILITY("KX",$J,"IX",.85,.85,"C",11.1,0)
 ;;=^.114IA^1^1
 ;;^UTILITY("KX",$J,"IX",.85,.85,"C",11.1,1,0)
 ;;=1^F^.85^.02^^1^F
 ;;^UTILITY("KX",$J,"IX",.85,.85,"D",0)
 ;;=.85^D^Regular new-style index for three letter abbreviations for languages^R^^F^IR^I^.85^^^^^LS
 ;;^UTILITY("KX",$J,"IX",.85,.85,"D",1)
 ;;=S ^DI(.85,"D",$E(X,1,30),DA)=""
 ;;^UTILITY("KX",$J,"IX",.85,.85,"D",2)
 ;;=K ^DI(.85,"D",$E(X,1,30),DA)
 ;;^UTILITY("KX",$J,"IX",.85,.85,"D",2.5)
 ;;=K ^DI(.85,"D")
 ;;^UTILITY("KX",$J,"IX",.85,.85,"D",11.1,0)
 ;;=^.114IA^1^1
 ;;^UTILITY("KX",$J,"IX",.85,.85,"D",11.1,1,0)
 ;;=1^F^.85^.03^30^1^F
 ;;^UTILITY("KX",$J,"IX",.85,.85,"E",0)
 ;;=.85^E^(Pseudo-)Mnemonic index for the Alternate three letter code^MU^^F^IR^I^.85^^^^^LS
 ;;^UTILITY("KX",$J,"IX",.85,.85,"E",.1,0)
 ;;=^^6^6^3121031^
 ;;^UTILITY("KX",$J,"IX",.85,.85,"E",.1,1,0)
 ;;=This will add entries to the D index for the three letter code a la the 
 ;;^UTILITY("KX",$J,"IX",.85,.85,"E",.1,2,0)
 ;;=mnemonic style.
 ;;^UTILITY("KX",$J,"IX",.85,.85,"E",.1,3,0)
 ;;= 
 ;;^UTILITY("KX",$J,"IX",.85,.85,"E",.1,4,0)
 ;;=If you need re-cross-reference this field, you need to kill of the 
 ;;^UTILITY("KX",$J,"IX",.85,.85,"E",.1,5,0)
 ;;=entries in the regular D index, set the D index, and then set this index 
 ;;^UTILITY("KX",$J,"IX",.85,.85,"E",.1,6,0)
 ;;=to update the D with the mnemonic xrefs.
 ;;^UTILITY("KX",$J,"IX",.85,.85,"E",1)
 ;;=S ^DI(.85,"D",X,DA)=1
 ;;^UTILITY("KX",$J,"IX",.85,.85,"E",2)
 ;;=K ^DI(.85,"D",X,DA)
