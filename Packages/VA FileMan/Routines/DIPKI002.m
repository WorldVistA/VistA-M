DIPKI002 ;VEN/TOAD-PACKAGE FILE INIT ; 04-JAN-2015
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 Q:'DIFQ(9.4)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(9.4,13,21,4,0)
 ;;=This can be either using the old format (1.0, 16.04, etc.) or the new
 ;;^DD(9.4,13,21,5,0)
 ;;=format (18.0T4, 19.1V2, etc.)
 ;;^DD(9.4,13,"DT")
 ;;=2860221
 ;;^DD(9.4,14,0)
 ;;=ADDITIONAL PREFIXES^9.4014^^14;0
 ;;^DD(9.4,14,"DT")
 ;;=2990302
 ;;^DD(9.4,20,0)
 ;;=AFFECTS RECORD MERGE^9.402P^^20;0
 ;;^DD(9.4,20,21,0)
 ;;=^^2^2^2970307^^^
 ;;^DD(9.4,20,21,1,0)
 ;;=This Multipule lists the files that will impact this package if a Record
 ;;^DD(9.4,20,21,2,0)
 ;;=Merge is done on any of the files in the list.
 ;;^DD(9.4,22,0)
 ;;=VERSION^9.49I^^22;0
 ;;^DD(9.4,22,21,0)
 ;;=^^1^1^2930415^^^^
 ;;^DD(9.4,22,21,1,0)
 ;;=The version numbers of this Package.
 ;;^DD(9.4,913,0)
 ;;=ENVIRONMENT CHECK ROUTINE^F^^PRE;1^K:$L(X)>8!($L(X)<3) X
 ;;^DD(9.4,913,.1)
 ;;=DEVELOPERS ROUTINE RUN BEFORE 'INIT' QUESTIONS ASKED
 ;;^DD(9.4,913,3)
 ;;=Enter name of developer's environment check routine (3-8 characters) that runs before any user questions are asked.  This routine should be used for environment check only and should not alter data.
 ;;^DD(9.4,913,21,0)
 ;;=^^4^4^2921202^
 ;;^DD(9.4,913,21,1,0)
 ;;=The name of the developer's routine which is run at the beginning of
 ;;^DD(9.4,913,21,2,0)
 ;;=the NAMESPACE_INIT routine.  This should just check the environment
 ;;^DD(9.4,913,21,3,0)
 ;;=and should not alter any data, since the user has no way to exit out of
 ;;^DD(9.4,913,21,4,0)
 ;;=the INIT process until this program runs to completion.
 ;;^DD(9.4,913,23,0)
 ;;=^^2^2^2921202^^^^
 ;;^DD(9.4,913,23,1,0)
 ;;=  A call to this routine gets inserted, by DIFROM at the beginning of the
 ;;^DD(9.4,913,23,2,0)
 ;;=NAMESPACE_INIT routine, before the EN entry point.
 ;;^DD(9.4,913,"DT")
 ;;=2990407
 ;;^DD(9.4,913.5,0)
 ;;=ENVIRONMENT CHECK DONE DATE^D^^PRE;2^S %DT="ESTXR" D ^%DT S X=Y K:Y<1 X
 ;;^DD(9.4,913.5,3)
 ;;=
 ;;^DD(9.4,913.5,21,0)
 ;;=^^3^3^2921202^
 ;;^DD(9.4,913.5,21,1,0)
 ;;=This is the date/time that the ENVIRONMENT CHECK routine last ran. When an
 ;;^DD(9.4,913.5,21,2,0)
 ;;=INIT is run at a target site, and it contains an ENVIRONMENT CHECK
 ;;^DD(9.4,913.5,21,3,0)
 ;;=routine, this field is updated automatically.
 ;;^DD(9.4,913.5,"DT")
 ;;=2990407
 ;;^DD(9.4,914,0)
 ;;=POST-INITIALIZATION ROUTINE^F^^INIT;1^K:$L(X)>8!($L(X)<3)!'(X?1UP.UN) X
 ;;^DD(9.4,914,.1)
 ;;=DEVELOPERS ROUTINE TO BRANCH TO AT END OF 'INIT' ROUTINE
 ;;^DD(9.4,914,3)
 ;;=Enter the name of the developer's post-initialization routine (3-8 characters).
 ;;^DD(9.4,914,21,0)
 ;;=^^2^2^2900730^^^^
 ;;^DD(9.4,914,21,1,0)
 ;;=The name of the developer's routine which is run immediately after the
 ;;^DD(9.4,914,21,2,0)
 ;;=installation of the package.
 ;;^DD(9.4,914,23,0)
 ;;=^^3^3^2900730^^^
 ;;^DD(9.4,914,23,1,0)
 ;;=  This routine gets inserted by DIFROM at the end of the
 ;;^DD(9.4,914,23,2,0)
 ;;=NAMESPACE_INIT routine, after the INIT has filed all the information,
 ;;^DD(9.4,914,23,3,0)
 ;;=but before the quit statement.
 ;;^DD(9.4,914,"DT")
 ;;=2990407
 ;;^DD(9.4,914.5,0)
 ;;=POST-INIT COMPLETION DATE^D^^INIT;2^S %DT="ESTXR" D ^%DT S X=Y K:Y<1 X
 ;;^DD(9.4,914.5,3)
 ;;=
 ;;^DD(9.4,914.5,21,0)
 ;;=^^3^3^2911209^^
 ;;^DD(9.4,914.5,21,1,0)
 ;;=This is the date/time that the POST-INIT last ran.  When an
 ;;^DD(9.4,914.5,21,2,0)
 ;;=INIT is run at a target site, and it contains a POST-INIT
 ;;^DD(9.4,914.5,21,3,0)
 ;;=routine, this field is updated automatically.
 ;;^DD(9.4,914.5,"DT")
 ;;=2990407
 ;;^DD(9.4,916,0)
 ;;=PRE-INIT AFTER USER COMMIT^F^^INI;1^K:$L(X)>8!($L(X)<3) X
 ;;^DD(9.4,916,.1)
 ;;=DEVELOPERS ROUTINE RUN AFTER 'INIT' QUESTIONS ANSWERED
 ;;^DD(9.4,916,3)
 ;;=Enter name of developer's pre-init routine (3-8 characters) that runs after user has answered all INIT questions.  Can be used for data conversions needed before INIT files new data.
 ;;^DD(9.4,916,21,0)
 ;;=^^4^4^2930303^^^^
 ;;^DD(9.4,916,21,1,0)
 ;;=Name of the developer's routine that runs after the user has answered all
 ;;^DD(9.4,916,21,2,0)
 ;;=of the questions in NAMESPACE_INIT but before the INIT files any new data.
 ;;^DD(9.4,916,21,3,0)
 ;;=Used for data conversions, etc. that the developer needs to do before
 ;;^DD(9.4,916,21,4,0)
 ;;=bringing in new data.
 ;;^DD(9.4,916,23,0)
 ;;=^^3^3^2930303^^^^
 ;;^DD(9.4,916,23,1,0)
 ;;=  A call to this routine gets inserted, by DIFROM, into the
 ;;^DD(9.4,916,23,2,0)
 ;;=NAMESPACE_INIT1 routine, after the user has answered the last
 ;;^DD(9.4,916,23,3,0)
 ;;=question 'ARE YOU SURE EVERYTHING'S OK?', but before filing any data.
 ;;^DD(9.4,916,"DT")
 ;;=2990407
 ;;^DD(9.4,916.5,0)
 ;;=PRE-INIT COMPLETION DATE^D^^INI;2^S %DT="ESTXR" D ^%DT S X=Y K:Y<1 X
 ;;^DD(9.4,916.5,21,0)
 ;;=^^3^3^2911209^^
 ;;^DD(9.4,916.5,21,1,0)
 ;;=This is the date/time that the PRE-INIT AFTER USER COMMIT last ran.
 ;;^DD(9.4,916.5,21,2,0)
 ;;=When an INIT is run at a target site, and it contains a PRE-INIT
 ;;^DD(9.4,916.5,21,3,0)
 ;;=AFTER USER COMMIT routine, this field is updated automatically.
 ;;^DD(9.4,916.5,"DT")
 ;;=2990407
 ;;^DD(9.4,919,0)
 ;;=EXCLUDED NAME SPACE^9.432^^EX;0
 ;;^DD(9.4,919,21,0)
 ;;=^^5^5^2930303^^^
 ;;^DD(9.4,919,21,1,0)
 ;;=By specifying an "excluded name space", the developer will be telling
 ;;^DD(9.4,919,21,2,0)
 ;;=the DIFROM routine not to take OPTIONS, BULLETINS, etc. which begin
 ;;^DD(9.4,919,21,3,0)
 ;;=with these characters.  For example, if "PSZ" is an excluded name space
 ;;^DD(9.4,919,21,4,0)
 ;;=in the "PS" package, DIFROM will not send along OPTIONS, SECURITY KEYS,
 ;;^DD(9.4,919,21,5,0)
 ;;=BULLETINS, or FUNCTIONS that begin with "PSZ".
 ;;^DD(9.4,919,"DT")
 ;;=2990602
 ;;^DD(9.4,1938,0)
 ;;=MAIL GROUP^P3.8'^XMB(3.8,^MG;1^Q
 ;;^DD(9.4,1938,21,0)
 ;;=^^2^2^2990408^
 ;;^DD(9.4,1938,21,1,0)
 ;;=This field points to a mail group that will receive a mail message from
 ;;^DD(9.4,1938,21,2,0)
 ;;=KIDS when a package or patch is installed.
 ;;^DD(9.4,1938,"DT")
 ;;=2990408
 ;;^DD(9.4,1944,0)
 ;;=*BULLETINS^XCmJ30^^ ; ^S (XU,X)=$P(^DIC(9.4,D0,0),U,2) I X?1A.E F D=0:0 S D=$O(^XMB(3.6,"B",X,0)) S:D="" D=-1 X:$D(^XMB(3.6,D,0)) DICMX S X=$O(^XMB(3.6,"B",X)) I $P(X,XU,1)]""!(X="") S X="" Q
 ;;^DD(9.4,1944,9)
 ;;=^
 ;;^DD(9.4,1944,9.01)
 ;;=
 ;;^DD(9.4,1944,9.1)
 ;;=S (XU,X)=$P(^DIC(9.4,D0,0),U,2) I X?1A.E F D=0:0 Q:$P(X,XU,1)]""!(X="")  S D=$O(^XMB(3.6,X,0)) S:D="" D=-1 X:$D(^XMB(3.6,D,0)) DICMX S X=$O(^XMB(3.6,"B",X))
 ;;^DD(9.4,1944,21,0)
 ;;=^^2^2^2851008^
 ;;^DD(9.4,1944,21,1,0)
 ;;=This presents information about any BULLETINs which are distributed
 ;;^DD(9.4,1944,21,2,0)
 ;;=along with the Package.
 ;;^DD(9.4,1944,"DT")
 ;;=2940606
 ;;^DD(9.4,1945,0)
 ;;=*SECURITY KEYS^XCmJ30^^ ; ^S (XU,X)=$P(^DIC(9.4,D0,0),U,2) I X?1A.E F D=0:0 X:$D(^XUSEC(X)) DICMX S X=$O(^XUSEC(X)) I $P(X,XU,1)]""!(X="") S X="" Q
 ;;^DD(9.4,1945,9)
 ;;=^
 ;;^DD(9.4,1945,9.01)
 ;;=
 ;;^DD(9.4,1945,9.1)
 ;;=S (XU,X)=$P(^DIC(9.4,D0,0),U,2) I X?1A.E F D=0:0 X:$D(^XUSEC(X)) DICMX S X=$O(^XUSEC(X)) I $P(X,XU,1)]""!(X="") S X="" Q
 ;;^DD(9.4,1945,21,0)
 ;;=^^2^2^2851008^
 ;;^DD(9.4,1945,21,1,0)
 ;;=This describes the SECURITY KEYs which are distributed along with
 ;;^DD(9.4,1945,21,2,0)
 ;;=the Package.
 ;;^DD(9.4,1945,"DT")
 ;;=2940606
 ;;^DD(9.4,1946,0)
 ;;=*OPTIONS^XCmJ30^^ ; ^S (XU,X)=$P(^DIC(9.4,D0,0),U,2) I X?1A.E F D=0:0 S D=$O(^DIC(19,"B",X,0)) S:D="" D=-1 X:$D(^DIC(19,D,0)) DICMX S X=$O(^DIC(19,"B",X)) I $P(X,XU,1)]""!(X="") S X="" Q
 ;;^DD(9.4,1946,9)
 ;;=^
 ;;^DD(9.4,1946,9.01)
 ;;=
 ;;^DD(9.4,1946,9.1)
 ;;=S (XU,X)=$P(^DIC(9.4,D0,0),U,2) I X?1A.E F D=0:0 Q:$P(X,XU,1)]""!(X="")  S D=$O(^DIC(19,"B",X,0)) S:D="" D=-1 X:$D(^DIC(19,D,0)) DICMX S X=$O(^DIC(19,"B",X))
 ;;^DD(9.4,1946,21,0)
 ;;=^^2^2^2851008^
 ;;^DD(9.4,1946,21,1,0)
 ;;=This lists information concerning the OPTIONs which are distributed
 ;;^DD(9.4,1946,21,2,0)
 ;;=along with the Package.
 ;;^DD(9.4,1946,"DT")
 ;;=2940606
 ;;^DD(9.4,15007,0)
 ;;=SYNONYM^9.415007^^15007;0
 ;;^DD(9.4014,0)
 ;;=ADDITIONAL PREFIXES SUB-FIELD^^.01^1
 ;;^DD(9.4014,0,"DT")
 ;;=2990127
 ;;^DD(9.4014,0,"IX","B",9.4014,.01)
 ;;=
 ;;^DD(9.4014,0,"NM","ADDITIONAL PREFIXES")
 ;;=
 ;;^DD(9.4014,0,"UP")
 ;;=9.4
 ;;^DD(9.4014,.01,0)
 ;;=ADDITIONAL PREFIXES^MFX^^0;1^K:$L(X)>4!($L(X)<2)!'(X?1U1.3UN) X I $D(X) N %,%1,%2 S %="^DIC(9.4)" F %1="C","C2" S %2=$O(@%@(%1,X,0)) I %2>0,%2-DA(1) K X Q
 ;;^DD(9.4014,.01,1,0)
 ;;=^.1
 ;;^DD(9.4014,.01,1,1,0)
 ;;=9.4014^B
 ;;^DD(9.4014,.01,1,1,1)
 ;;=S ^DIC(9.4,DA(1),14,"B",$E(X,1,30),DA)=""
 ;;^DD(9.4014,.01,1,1,2)
 ;;=K ^DIC(9.4,DA(1),14,"B",$E(X,1,30),DA)
 ;;^DD(9.4014,.01,1,2,0)
 ;;=9.4^C2^MUMPS
 ;;^DD(9.4014,.01,1,2,1)
 ;;=S ^DIC(9.4,"C2",X,DA(1),DA)=1
 ;;^DD(9.4014,.01,1,2,2)
 ;;=K ^DIC(9.4,"C2",X,DA(1),DA)
 ;;^DD(9.4014,.01,1,2,3)
 ;;=Keep
 ;;^DD(9.4014,.01,1,2,"%D",0)
 ;;=^.101^2^2^3080603^^^
 ;;^DD(9.4014,.01,1,2,"%D",1,0)
 ;;=This X-ref sets the additional PREFIX into the "C" index
 ;;^DD(9.4014,.01,1,2,"%D",2,0)
 ;;=so the standard lookup will find the pachage with the PREFIX.
 ;;^DD(9.4014,.01,1,2,"DT")
 ;;=2990127
 ;;^DD(9.4014,.01,3)
 ;;=Answer must be 2-4 uppercase characters in length.
 ;;^DD(9.4014,.01,21,0)
 ;;=^^1^1^2990127^
 ;;^DD(9.4014,.01,21,1,0)
 ;;=This multiple is to record additional PREFIXs that a package may have.
 ;;^DD(9.4014,.01,"DT")
 ;;=2990602
 ;;^DD(9.402,0)
 ;;=AFFECTS RECORD MERGE SUB-FIELD^^4^3
