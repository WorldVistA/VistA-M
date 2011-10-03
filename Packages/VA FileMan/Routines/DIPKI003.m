DIPKI003 ; ; 30-MAR-1999
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q:'DIFQ(9.4)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(9.4,913,23,0)
 ;;=^^2^2^2921202^^^^
 ;;^DD(9.4,913,23,1,0)
 ;;=  A call to this routine gets inserted, by DIFROM at the beginning of the
 ;;^DD(9.4,913,23,2,0)
 ;;=NAMESPACE_INIT routine, before the EN entry point.
 ;;^DD(9.4,913,"DT")
 ;;=2940606
 ;;^DD(9.4,913.5,0)
 ;;=*ENVIRONMENT CHECK DONE DATE^D^^PRE;2^S %DT="ESTXR" D ^%DT S X=Y K:Y<1 X
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
 ;;=2940603
 ;;^DD(9.4,914,0)
 ;;=*POST-INITIALIZATION ROUTINE^F^^INIT;1^K:$L(X)>8!($L(X)<3)!'(X?1UP.UN) X
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
 ;;=2940606
 ;;^DD(9.4,914.5,0)
 ;;=*POST-INIT COMPLETION DATE^D^^INIT;2^S %DT="ESTXR" D ^%DT S X=Y K:Y<1 X
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
 ;;=2940603
 ;;^DD(9.4,916,0)
 ;;=*PRE-INIT AFTER USER COMMIT^F^^INI;1^K:$L(X)>8!($L(X)<3) X
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
 ;;=2940606
 ;;^DD(9.4,916.5,0)
 ;;=*PRE-INIT COMPLETION DATE^D^^INI;2^S %DT="ESTXR" D ^%DT S X=Y K:Y<1 X
 ;;^DD(9.4,916.5,21,0)
 ;;=^^3^3^2911209^^
 ;;^DD(9.4,916.5,21,1,0)
 ;;=This is the date/time that the PRE-INIT AFTER USER COMMIT last ran.
 ;;^DD(9.4,916.5,21,2,0)
 ;;=When an INIT is run at a target site, and it contains a PRE-INIT
 ;;^DD(9.4,916.5,21,3,0)
 ;;=AFTER USER COMMIT routine, this field is updated automatically.
 ;;^DD(9.4,916.5,"DT")
 ;;=2940603
 ;;^DD(9.4,919,0)
 ;;=*EXCLUDED NAME SPACE^9.432^^EX;0
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
 ;;=2940603
 ;;^DD(9.4,1920,0)
 ;;=*STATUS^9.444D^^ST;0
 ;;^DD(9.4,1920,21,0)
 ;;=^^1^1^2851008^^^
 ;;^DD(9.4,1920,21,1,0)
 ;;=Information about the Namespace assignment status of this package.
 ;;^DD(9.4,1920,"DT")
 ;;=2940606
 ;;^DD(9.4,1933,0)
 ;;=*KEY VARIABLE^9.455^^1933;0
 ;;^DD(9.4,1933,21,0)
 ;;=^^2^2^2851009^^^
 ;;^DD(9.4,1933,21,1,0)
 ;;=These are the MUMPS variables which the Package would like defined
 ;;^DD(9.4,1933,21,2,0)
 ;;=prior to entry into the routines.
 ;;^DD(9.4,1933,"DT")
 ;;=2940603
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
