DIETLIBF ;SFISC/MKO,GFT - LIBRARY FOR FIELD ATTRIBUTES ;25OCT2016
 ;;22.2;VA FileMan;**2**;Jan 05, 2016;Build 139
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 ;The following functions return, for a given file and field,
 ;code to do something, such as validate user input, or validate
 ;the internal form of data. The actual code to perform these
 ;functions may reside under one of several methods, so a list of
 ;methods need to be searched.
 ;
 ;Input to these methods are:
 ;  DDTFILE = File #
 ;  DDTFIELD = Field #
 ;
 ;Returned is:
 ;  Code for method or null
 ;
VALEXT(DDTFILE,DDTFIELD) ;Return code to validate and transform user input  --PERHAPS INTERACTIVELY
 Q $$GETMETH(.DDTFILE,.DDTFIELD,$$VALEXTL)
 ;
VALEXTS(DDTFILE,DDTFIELD) ;Return code to SILENTLY validate and transform user input
 ;Non-interactive
 N D,%
 S %=$$GETMETH(.DDTFILE,.DDTFIELD,$$VALEXTSL) I %["+X" S %="K:X?16.N.E X I $D(X) "_% ;DON'T TRY TO "+" A HUGE NUMBER
 S D=$F(%,"%DT=""E") I D>0 S %=$E(%,1,D-2)_$E(%,D,9999)
 Q "N %T,%DT,C,DIG,DIH,DIU,DIV,DICR,DIQUIET S DIQUIET=1 "_% ;PRESERVE VARIABLES 
 ;
VALINT(DDTFILE,DDTFIELD) ;Return code to validate internal form
 Q $$GETMETH(.DDTFILE,.DDTFIELD,$$VALINTL)
 ;
XHELP(DDTFILE,DDTFIELD) ;Return the executable help of a field
 D DIPA(DDTFILE,DDTFIELD) ;I $D(^DI(.81,+$P($P(^DD(DDTFILE,DDTFIELD,0),U,2),"t",2),101,4,0)) S DIPA("POINTER")=$$GETPROP(DDTFILE,DDTFIELD,"POINTER")
 Q $$GETMETH(.DDTFILE,.DDTFIELD,$$XHELPL)
 ;
OUTPUT(DDTFILE,DDTFIELD) ;Return the executable code to output a field's value.  No arguments means ^DD(DDTFILE,DDTFIELD,0) is already in naked ref
 Q $$GETMETH(.DDTFILE,.DDTFIELD,$$OUTPUTL)
 ;
 ;
 ;
DIPA(DDTFILE,DDTFIELD) ;CREATE DIPA NODES FROM PROPERTIES IN THE FIELD
 N T,P,V,N
 S T=+$P($P(^DD(DDTFILE,DDTFIELD,0),U,2),"t",2) Q:'T  ;ONLY HAPPENS FOR EXTENDED DATA TYPES
 F P=0:0 S P=$O(^DD(DDTFILE,DDTFIELD,101,P)) Q:'P  S V=$G(^(P,31)) I V]"" S N=$P($G(^DI(.86,P,0)),U) I N]"" S DIPA(N)=V ;E.G., DIPA("POINTER")="DIC(5,"
 F P=0:0 S P=$O(^DD(DDTFILE,DDTFIELD,201,P)) Q:'P  S V=$G(^(P,31)) I V]"" S N=$P($G(^DI(.87,P,0)),U) I N]"" S DIPA(N)=V ;E.G., DIPA("CODE TO SET POINTER SCREEN")="I 1"
 Q
 ;
 ;****************************************************************
 ;The following functions return a string of methods to search
 ;
VALEXTL() Q "INTERACTIVE VALIDATE AND INPUT TRANSFORM;VALIDATE AND TRANSFORM INPUT;INPUT TRANSFORM"
VALEXTSL() Q "VALIDATE AND TRANSFORM INPUT;INPUT TRANSFORM"
VALINTL() Q "VALIDATE INTERNAL FORM;INPUT TRANSFORM"
XHELPL() Q "INTERACTIVE EXECUTABLE HELP;XECUTABLE HELP"
OUTPUTL() Q "OUTPUT TRANSFORM"
 ;
 ;****************************************************************
 ;
GETMETH(DDTFILE,DDTFIELD,DDTMETL) ;Look for methods in the ;-delimited string
 ;of method numbers.
 ;Return the code for the first non-null method found.
 ;In:
 ;  DDTFILE  = file #
 ;  DDTFIELD = field #
 ;  DDTMETL  =  ;-delimited list of methods to search for
 ;
 N REF,DDTCOD,DDTMET,DDTP,DDTPC,I
 Q:" "[$G(DDTMETL) ""
 ; The use of the naked reference is needed here, regardless of its obscurity. MSC/DKA 2016-03-04
 I '$G(DDTFILE)!'$G(DDTFIELD) S REF=$NA(^(0)) ;^DD(DDTFILE,DDTFIELD,0) is already in naked ref  -- MAYBE!     LET'S NOT USE THIS 'NAKED' TRICK
 E  S REF=$NA(^DD(DDTFILE,DDTFIELD,0))
 Q:REF'?1"^DD(".E ""
 F DDTPC=1:1:$L(DDTMETL,";") S DDTMET=$P(DDTMETL,";",DDTPC) D:DDTMET]""  Q:$G(DDTCOD)]""
 . S I=+$P($P($G(@REF),U,2),"t",2)
 . S DDTP=$O(^DI(.87,"B",DDTMET,""),-1) I DDTP,$P($G(^DI(.81,I,201,DDTP,31)),";")'?."^" S DDTCOD=^(31) ;Q  ;FIRST TRY TO GET IT FROM THE DEFINITION IN .81
 . I DDTMET="INPUT TRANSFORM" D  Q:$D(DDTCOD)
 ..D DIPA(DDTFILE,DDTFIELD) ;SET UP THE PARAMETERS
 ..S DDTP=$$PROP4TYP("SET OF CODES",I) I DDTP]"" S DDTCOD="D READSET^DIED(.X,"""_DDTP_""")" Q  ;M CODE: D READSET^DIED(.X,$$PROP4TYP^DIETLIBF("SET OF CODES",11)
 ..I "Q"'[$P($G(@REF),U,5,999) S DDTCOD=$P(^(0),U,5,999) ;from regular field, get the old input transform
 . I DDTMET="OUTPUT TRANSFORM",$G(@REF)]"",$G(^(2))'?."^" S DDTCOD=^(2) Q
 . I DDTMET="XECUTABLE HELP",$G(@REF)]"",$G(^(4))'?."^" S DDTCOD=^(4) Q
 Q $G(DDTCOD)
 ;
 ;
%DT(PARAM) ;CREATE CODE TO SET THE %DT VARIABLE FROM PARAMETERS, INCLUDING 'PARAM', WHICH MAY BE "E"
 N EARLY
 S EARLY="",PARAM=$TR(PARAM,"""")
 I $G(DIPA("EARLIEST DATE")) S EARLY=",%DT(0)="_DIPA("EARLIEST DATE")
 I $G(DIPA("TIME REQUIRED")) S PARAM=PARAM_"R"
 I $G(DIPA("SECONDS ALLOWED")) S PARAM=PARAM_"S"
 I $G(DIPA("TIME OF DAY")) S PARAM=PARAM_"T"
 I '$G(DIPA("IMPRECISE DATE")) S PARAM=PARAM_"X"
 Q "SET %DT="""_PARAM_""""_EARLY
 ;
DIC ;SET THE DIC VARIABLE FROM PARAMETERS
 I $G(DIPA("POINTER"))'["(" S Y=-1 Q
 N DIS,DIC,DIFILE ;DIFILE SHOULD REALLY BE NEWED BY ^DIC ITSELF
 X $G(DIPA("CODE TO SET POINTER SCREEN")) ;S DIC("S")
 S DIC="^"_DIPA("POINTER"),DIC(0)="M"_$E("L",$G(DIPA("LAYGO"))) I '$D(DIQUIET) S DIC(0)=DIC(0)_"EQ"
 D ^DIC
 Q
 ;
 ;
GETPROP(DDTFILE,DDTFIELD,DDTPROL) ;Look for PROPERTIES in the ;-delimited string
 ;Return the string for the first non-null property found.
 ;In:
 ;  DDTFILE  = file #
 ;  DDTFIELD = field #
 ;  DDTPROL  =  ;-delimited list of properties to search for
 ;
 N REF
 Q:" "[$G(DDTPROL) ""
 I '$G(DDTFILE)!'$G(DDTFIELD) S REF=$NA(^(0))  ;^DD(DDTFILE,DDTFIELD,0) is already in naked ref
 E  S REF=$NA(^DD(DDTFILE,DDTFIELD,0))
 Q:REF'?1"^DD(".E ""
 N DDTCOD,DDTP,DDTPC,I,DIP
 S I=+$P($P($G(@REF),U,2),"t",2)
 F DDTPC=1:1:$L(DDTPROL,";") S DDTP=$P(DDTPROL,";",DDTPC) I DDTP]"" D  Q:$G(DDTCOD)]""
 .I $D(@REF),$O(^(101,0)) S DIP=$O(^DI(.86,"B",DDTP,""),-1) I DIP,$D(@REF),$G(^(101,DIP,31))]"" S DDTCOD=^(31) Q  ;GET PROPERTY FROM THE FIELD ITSELF
 .S DDTCOD=$$PROP4TYP(DDTP,I)
 Q $G(DDTCOD)
 ;
PROP4TYP(T,I) ;FOR PROPERTY 'T' IN DATA TYPE 'I', RETURN THE VALUE
 S T=$O(^DI(.86,"B",T,""),-1) I T,$G(^DI(.81,I,101,T,31))'?."^" Q ^(31) ;GET IT FROM THE DEFINITION IN .81
 Q ""
 ;
 ;
METH4TYP(T,I) ;FOR METHOD 'T' IN DATA TYPE 'I', RETURN THE VALUE
 S T=$O(^DI(.87,"B",T,""),-1) I T,$G(^DI(.81,I,201,T,31))'?."^" Q ^(31) ;GET IT FROM THE DEFINITION IN .81
 Q ""
