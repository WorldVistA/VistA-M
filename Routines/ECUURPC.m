ECUURPC ;ALB/JAM - Event Capture Data Entry Broker Utilities ; 5 May 2008
 ;;2.0; EVENT CAPTURE ;**25,42,49,94,95,76,104**;8 May 96;Build 7
 ;
ECHELP(RESULTS,ECARY) ;
 ;
 ;Broker call returns the entries from HELP FILE #9.2
 ;        RPC: EC GETSCNHELP
 ;INPUTS   ECARY - Contains the following elements
 ;          HLPDA  - Help Frame Name
 ;
 ;OUTPUTS  RESULTS - Array of help text in the HELP FRAM File (#9.2)
 ;
 N HLPDA,DIC,X,Y
 S HLPDA=$G(ECARY) I HLPDA="" Q
 D SETENV^ECUMRPC K ^TMP($J,"ECHELP")
 S DIC="^DIC(9.2,",DIC(0)="MN",X=HLPDA
 D ^DIC M ^TMP($J,"ECHELP")=^DIC(9.2,+Y,1)
 I $D(^TMP($J,"ECHELP")) D
 . S $P(^TMP($J,"ECHELP",0),U)=$P(^DIC(9.2,+Y,0),U,2)
 S RESULTS=$NA(^TMP($J,"ECHELP"))
 Q
FNDIEN(RESULTS,ECARY) ;find IEN
 ;Broker call returns the IEN from a file
 ;        RPC: EC GETIEN
 ;INPUTS   ECARY - Contains the following data elements
 ;          FIL  - File number
 ;          TXT  - .01 description
 ;
 ;OUTPUTS  RESULTS - File IEN
 ;
 N TXT,FIL,DIC,X,Y
 D SETENV^ECUMRPC
 S FIL=$P(ECARY,U),TXT=$P(ECARY,U,2) I TXT=""!(FIL="") Q
 S DIC=FIL,DIC(0)="MN",X=TXT
 I FIL=81.3 S DIC("S")="I +$P($$MOD^ICPTMOD(Y,""I""),U,7)=1"
 D ^DIC I Y=-1 Q
 S RESULTS=+Y
 Q
ECDATE(RESULTS,ECARY) ;
 ;
 ;Broker call returns an Fileman internal date
 ;        RPC: EC GETDATE
 ;INPUTS   ECARY - Contains the following elements
 ;          DTSTR  - Date String
 ;          FLG    - Date Flag (optional)
 ;
 ;OUTPUTS  RESULTS - A valid Fileman date format^External format
 ;
 N ECDTSTR,DIC,X,Y,DTSTR,FLG
 D SETENV^ECUMRPC
 S DTSTR=$P(ECARY,U),FLG=$P(ECARY,U,2) I DTSTR="" Q
 S X=DTSTR,%DT="XT"_$S(FLG="R":"R",1:""),%DT(0)="-NOW" D ^%DT
 I +Y<1 S RESULTS="0^Invalid Date/Time" Q
 S RESULTS=Y D D^DIQ
 S RESULTS=RESULTS_U_Y
 Q
PATCH(RESULTS,ECARY)    ;
 ;
 ;Broker call returns 1 if patch X is installed
 ;        RPC: EC GETPATCH
 ;INPUTS   ECARY - contains the patch number
 ;
 ;OUTPUTS  RESULTS 1 OR 0
 ;
 I ECARY="" Q
 D SETENV^ECUMRPC
 S RESULTS=$$PATCH^XPDUTL(ECARY)
 Q
VERSRV(RESULTS,ECARY,VERSION)   ; Return server version of option name and 
 ; minimum GUI client version.
 ;
 ;Server/client version consist of 4 pieces, namely
 ;    major version.minor version.release.build  (ex. 2.0.10.1)
 ;
 ;Broker call returns server version of option name
 ;        RPC: EC GETVERSION
 ;INPUTS   ECARY - contains the option name
 ;         VERSION - EC GUI client version ;stay in partition for session
 ;
 ;OUTPUTS  RESULTS version number OR null ("")
 ;           current server version^minimum client version
 ;
 S ECCLVER=$G(VERSION)
 I $G(ECARY)="" Q
 N ECLST,ECMINV
 S ECMINV="2.1.2.1"  ;Minimum version of EC GUI client
 D FIND^DIC(19,"",1,"X",ECARY,1,,,,"ECLST")
 I 'ECLST("DILIST",0) S RESULTS="" Q
 S RESULTS=ECLST("DILIST","ID",1,1)
 S RESULTS=$P(RESULTS,"version ",2)_U_ECMINV
 Q
