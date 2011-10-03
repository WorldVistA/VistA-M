VAQUIN01 ;ALB/JFP - REQUEST PDX RECORD - (API);3JUL91
 ;;1.5;PATIENT DATA EXCHANGE;**43**;NOV 17, 1993
 ; Programmer entry point for sending PDX requests.
 ;
 ; This API can be used for both request and unsolicited.
 ; It also utilizes time and occurrence limits for Health Summary
 ; which are pieces on the segment root array.  These pieces need 
 ; to be set by the developer.  If these are not included the defaults
 ; in the sites PDX parameter file will be used.
 ;
PDX(VAQOPT,VAQDFN,VAQNM,VAQISSN,VAQIDOB,DOMROOT,SEGROOT,NOTROOT) ; EP
 ;Input:   VAQOPT  - REQ = request, UNS = unsolicited
 ;         VAQDFN  - IFN of patient in patient file
 ;         VAQNM   - name of patient
 ;         VAQISSN  - patient social security number (no dashes)
 ;         VAQIDOB   - patients date of birth (external format)
 ;         DOMROOT - array of domains (full global reference)
 ;                   (ie: PXB.ISC-ALBANY.VA.GOV)=Institution name or null
 ;         SEGROOT - array of segments (full global reference)
 ;                   (ie: PDX*MIN)=P1^P2
 ;                   P1 = TIME LIMIT
 ;                   P2 = OCCURRENCE LIMIT
 ;         NOTROOT - array of who to notify (only used for request)
 ;         TLIMIT  - time limit for health summary (ie: 1D,12M,5Y)
 ;         OLIMIT  - occurrence limit for health summary, up to 5 digits
 ;
 ;Output:  0       - ok
 ;         -1^error text
 ; -- Initialize 
 N POP,ERR,VAQ0,Y,XMITARR,X,VAQDOM,VAQPID,VAQRQDT,PARMNODE,FACDA,DOMDA
 N VAQRQSIT,VAQRQADD,VAQDZ,VAQDZN,VAQPR,DA,DR,VAQDT,SEG
 N VAQAUSIT,VAQNOTI
 N OLDEF,TLDEF,TLMT,OLMT
 ; -- CHECK INPUT PARAMETERS
 S POP=0
 Q:('$D(VAQOPT)) "-1^option required"
 I (VAQOPT'="REQ")&(VAQOPT'="UNS") Q "-1^option required"
 Q:('$D(DOMROOT)) "-1^reference to domain required for processing"
 Q:($O(@DOMROOT@(""))="") "-1^domain data required for processing"
 Q:('$D(SEGROOT)) "-1^reference to segment required for processing"
 Q:($O(@SEGROOT@("")))="" "-1^segment data required for processing"
 ;
 S:'$D(VAQDFN) VAQDFN=""
 I VAQDFN="" D  Q:POP=1 ERR
 .I '$D(VAQNM) S POP=1,ERR="-1^Name is required if DFN is null" QUIT
 .I '$D(VAQISSN) S POP=1,ERR="-1^SSN is required if DFN is null" QUIT
 .I '$D(VAQNM)&'$D(VAQISSN) S POP=1,ERR="-1^name and SSN is required if DFN=null" QUIT
 .I (VAQNM="")&(VAQISSN="") S POP=1,ERR="-1^name and SSN is required if DFN=null" QUIT
 .S:'$D(VAQIDOB) VAQIDOB=""
 I VAQDFN'="" D  Q:POP=1 ERR
 .I VAQDFN<1 S POP=1,ERR="-1^DFN can not be less than 1" QUIT
 .I '$D(^DPT(VAQDFN)) S POP=1,ERR="-1^DFN is not in data base" QUIT
 .S VAQ0=$G(^DPT(VAQDFN,0))
 .S VAQNM=$P(VAQ0,U,1)
 .S (VAQISSN)=$P(VAQ0,U,9)
 .S (Y,VAQIDOB)=$P(VAQ0,U,3) X ^DD("DD") S VAQIDOB=Y
 I (VAQNM="")&(VAQISSN="") Q "-1^name or SSN is required"
 ;
 S XMITARR="^TMP(""TRANARR"","_$J_")"
 K @XMITARR
 D PRELOAD^VAQREQ06
 S VAQDOM=""
 F  S VAQDOM=$O(@DOMROOT@(VAQDOM)) Q:VAQDOM=""  D XMIT
 S X=$$GENTASK^VAQADM5(XMITARR)
 I +X=-1 S ERR="-1^"_$P(X,U,2) Q ERR
 K @XMITARR
 QUIT 0
 ;
XMIT ; -- Make an entry in the 'PDX TRANSACTION' FILE
 S X="+" ; -- auto number
 S DIC="^VAT(394.61,",DIC(0)="L",DLAYGO=394.61
 D ^DIC K DIC,X,DLAYGO
 Q:Y<0
 S (VAQPR,DA)=+Y,VAQDT=$P(Y,U,2)
 ; -- FILL IN REST OF FIELDS OF 'TRANSACTION' FILE
 I VAQOPT="REQ" D LDREQ^VAQREQ06
 I VAQOPT="UNS" D LDUNS^VAQREQ06
 I $D(@SEGROOT) D MSEG
 I (VAQOPT="REQ")&($D(NOTIROOT)) D:$D(@NOTROOT) MNOTI
 S @XMITARR@(VAQPR)="" ; -- Load an array of newly entered transactions
 ; -- Update workload file
 S X=$$WORKDONE^VAQADS01($S(VAQOPT="REQ":"RQST",VAQOPT="UNS":"SEND",1:""),VAQPR,$G(DUZ))
 QUIT
 ;
MSEG ; -- Loads the data segment multiple
 S PARAMND=$G(^VAT(394.81,1,"LIMITS")) ; -- Sets defaults from PDX param
 S TLDEF=$P(PARAMND,U,1)
 S OLDEF=$P(PARAMND,U,2)
 ;
 S DIE="^VAT(394.61,",SEG=""
 F  S SEG=$O(@SEGROOT@(SEG))  Q:SEG=""  D
 .S HSCOMPND=$$HLTHSEG^VAQDBIH1(SEG,0)
 .I $P(HSCOMPND,U,1)=0 S (TLMT,OLMT)="" ; -- Not health summary segment
 .I $P(HSCOMPND,U,1)'=0 D
 ..S SEGND=$G(@SEGROOT@(SEG))
 ..S TLMT=$P(SEGND,U,1),OLMT=$P(SEGND,U,2)
 ..I (TLMT="")&($P(HSCOMPND,U,2)=1) S TLMT=TLDEF
 ..I (OLMT="")&($P(HSCOMPND,U,3)=1) S OLMT=OLDEF
 ..I $P(HSCOMPND,U,2)=0 S TLMT=""
 ..I $P(HSCOMPND,U,3)=0 S OLMT=""
 .S DR(2,394.618)=".02///"_TLMT_";.03///"_OLMT
 .S DR="80///"_SEG
 .D ^DIE
 K DIE,DR,DLAYGO
 QUIT
 ;
MNOTI ; -- Loads the notify muliple
 S DIE="^VAT(394.61,",DLAYGO=394.61,NOTI=""
 F  S NOTI=$O(@NOTROOT@(NOTI))  Q:NOTI=""  D
 .S DR="71///"_NOTI
 .D ^DIE
 K DIE,DR,DLAYGO
 QUIT
 ;
