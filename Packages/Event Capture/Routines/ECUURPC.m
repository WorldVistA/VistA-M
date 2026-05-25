ECUURPC ;ALB/JAM - Event Capture Data Entry Broker Utilities ;12/4/24  12:04
 ;;2.0;EVENT CAPTURE;**25,42,49,94,95,76,104,124,139,145,152,156,158,161,159,164,165,169,170**;8 May 96;Build 2
 ;
 ; Reference to $$CODEN^ICDEX in ICR #5747
 ; Reference to ^DIC in ICR #10006
 ; Reference to ^TMP supported by SACC 2.3.2.5.1
 ; Reference to ^%DT in ICR #10003
 ; Reference to FIND()^DIC in ICR #2051
 ; Reference to D^DIQ in ICR #10004
 ; Reference to DEVICE^ORWU in ICR #1837
 ; Reference to $$DT^XLFDT in ICR #10103
 ; Reference to $$PATCH^XPDUTL in ICR #10141
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
 ; For lookups on #80, use approved API
 I FIL=80 S RESULTS=+$$CODEN^ICDEX(TXT,80) Q
 ;
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
 ;          FLG    - Date Flag (optional) Set to R if time is required
 ;          FUT    - Future Flag (optional) Set to F to allow date/times through
 ;                   midnight today
 ;
 ;OUTPUTS  RESULTS - A valid Fileman date format^External format
 ;
 N ECDTSTR,DIC,X,Y,DTSTR,FLG,FUT ;145
 D SETENV^ECUMRPC
 S DTSTR=$P(ECARY,U),FLG=$P(ECARY,U,2),FUT=$P(ECARY,U,3) I DTSTR="" Q  ;145
 S X=DTSTR,%DT="XT"_$S(FLG="R":"R",1:""),%DT(0)=$S(FUT="F":"-"_$$DT^XLFDT_.24,1:"-NOW") D ^%DT ;145 Set latest date/time allowed
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
 ; 139,145 Minimum version of EC GUI client - 
 ; 152:2.7,156:2.8,158:2.9,161:2.10,159:2.11,164:2.11.1,165:2.12.0,169:2.12.1,170:2.13.0
 S ECMINV="2.13.0.0"
 D FIND^DIC(19,"",1,"X",ECARY,1,,,,"ECLST")
 I 'ECLST("DILIST",0) S RESULTS="" Q
 S RESULTS=ECLST("DILIST","ID",1,1)
 S RESULTS=$P(RESULTS,"version ",2)_U_ECMINV
 Q
 ;
ECDEVICE(Y,FROM) ; Return a subset of entries from the Device file.
 ; .LST(n)=IEN;Name^DisplayName^Location^RMar^PLen
 ; FROM=text to $O from, DIR=$O direction
 N I,IEN,CNT,SHOW,X,SAVFROM,TEMPY
 S DIR=$P(FROM,U,2),FROM=$P(FROM,U)
 I DIR="" S DIR=1
 S SAVFROM=FROM
 D DEVICE^ORWU(.Y,FROM,DIR)
 M TEMPY=Y
 S FROM=SAVFROM
 D ECPREDEV(FROM,.Y) ;Get the information for the last printer selected
 F I=1:1:19 S Y(I+1)=TEMPY(I)
 Q
 ;
ECPREDEV(FROM,Y) ;This code was based off DEVICE^ORWU
 N X0,X1,X90,X91,X95,IEN ;,XTYPE,XSTYPE,XTIME,ORA,ORPX,POP
 N FOUND,SAVFROM,TMPSHOW
 S SAVFROM=FROM
 S FOUND="",IEN=0
 I FROM["<" D  Q
 .S FOUND=1
 .S FROM=$RE($P($RE(FROM),"<  ",2)),IEN=$O(^%ZIS(1,"B",FROM,0))
 .S X0=$G(^%ZIS(1,IEN,0)),X1=$G(^(1)),X90=$G(^(90)),X91=$G(^(91)),X95=$G(^(95))
 .S SHOW=$P(X0,U) I SHOW'=FROM S SHOW=FROM_"  <"_SHOW_">"
 .S Y(1)=IEN_";"_$P(X0,U)_U_SHOW_U_$P(X1,U)_U_$P(X91,U)_U_$P(X91,U,3)
 F  S FROM=$O(^%ZIS(1,"B",FROM),-1) Q:FOUND  D
 .S IEN=$O(^%ZIS(1,"B",FROM,""),-1)
 .S X0=$G(^%ZIS(1,IEN,0)),X1=$G(^(1)),X90=$G(^(90)),X91=$G(^(91)),X95=$G(^(95))
 .S SHOW=$P(X0,U) I SHOW'=FROM S SHOW=FROM_"  <"_SHOW_">"
 .S TMPSHOW=SHOW_" "_$P(X91,U)
 .I $E(TMPSHOW,1,$L(TMPSHOW)-1)=$E(SAVFROM,1,$L(SAVFROM)-2) S FOUND=1
 S Y(1)=IEN_";"_$P(X0,U)_U_SHOW_U_$P(X1,U)_U_$P(X91,U)_U_$P(X91,U,3)
 Q
