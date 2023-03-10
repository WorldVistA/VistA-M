KBANTCLN ; VEN/SMH - Clean Taskman Environment ;2019-10-01  2:11 PM
 ;;nopackage;0.2
 ; License: Public Domain
 ; Author not responsible for use of this routine.
 ; Author coyly recommends not using this on production accounts.
 ;
 ; This routine cleans up Taskman globals for a new environment.
 W "WARNING: DO NOT RUN THIS ON A PRODUCTION ENVIRONMENT.",!
 ;
 N VOL,UCI,SITENUMBER,SITENAME,FQDN
 R "VOL: ",VOL,!
 R "UCI: ",UCI,!
 R "SITE NUMBER: ",SITENUMBER,!
 R "SITE NAME: ",SITENAME,!
 R "SITE DOMAIN: ",FQDN,!
 D START(VOL,UCI,SITENUMBER,SITENAME,FQDN)
 QUIT
 ;
START(VOL,UCI,SITENUMBER,SITENAME,FQDN,SOFTCLN)
 I $G(VOL)="" S VOL="ROU"
 I $G(UCI)="" S UCI="VAH"
 I $G(SITENUMBER)="" S SITENUMBER=999
 I $G(SITENAME)="" S SITENAME="DEMO SYSTEM"
 I $G(FQDN)="" S FQDN="LOCALHOST"
 I $G(SOFTCLN)="" S SOFTCLN=0
 S IO=$P,U="^"
 D ZTMGRSET(VOL,UCI)
 D DINIT(SITENUMBER,SITENAME)
 D ZUSET
 D MSP
 D TASKMAN(SOFTCLN)
 D DEVCLEAN
 D XU522
 QUIT
 ;
ZTMGRSET(VOL,UCI) ; Silent ZTMGRSET Replacement
 ; NB: OS 3 is Cache
 ;     OS 8 is GT.M/Unix
 ;
 K ^%ZOSF
 N ZTOS
 N ZTMODE S ZTMODE=1
 N SCR S SCR=" I 1"
 N %S,%D
 I $L($SY,":")=2 D  ; D 3^ZTMGRSET
 . S ZTOS=3
 . N I,X F I=1:2 S Z=$P($T(Z+I^ZOSFONT),";;",2) Q:Z=""  S X=$P($T(Z+1+I^ZOSFONT),";;",2,99) S ^%ZOSF(Z)=X
 . S ^%ZOSF("GSEL")="K ^CacheTempJ($J),^UTILITY($J) D ^%SYS.GSET M ^UTILITY($J)=CacheTempJ($J)"
 . S ^%ZOSF("OS")="OpenM-NT^18"
 . S %S="ZOSVONT^ZTBKCONT^ZIS4ONT^ZISFONT^ZISHONT^XUCIONT"
 . D DES^ZTMGRSET,MOVE^ZTMGRSET
 . S %S="ZISTCPS^ZTMDCL",%D="%ZISTCPS^%ZTMDCL"
 . D MOVE^ZTMGRSET
 . D RUM^ZTMGRSET
 ;
 ;
 ;
 I $P($SY,",")=47 D  ; 8^ZTMGRSET
 . S ZTOS=8
 . N I,X F I=1:2 S Z=$P($T(Z+I^ZOSFGUX),";;",2) Q:Z=""  S X=$P($T(Z+1+I^ZOSFGUX),";;",2,99) S ^%ZOSF(Z)=X
 . S ^%ZOSF("OS")="GT.M (Unix)^19"
 . S ^%ZOSF("TMP")="/tmp/"
 . ;
 . S %ZE=".m" D init^%RSEL
 . S %S="ZOSVGUX^^ZIS4GTM^ZISFGTM^ZISHGUX^XUCIGTM"
 . D DES^ZTMGRSET,MOVE^ZTMGRSET
 . S %S="ZOSV2GTM^ZISTCPS",%D="%ZOSV2^%ZISTCPS"
 . D MOVE^ZTMGRSET
 . ;
 S %S="DIDT^DIDTC^DIRCR",%D="%DT^%DTC^%RCR"
 D MOVE^ZTMGRSET
 D ALL^ZTMGRSET
 D GLOBALS^ZTMGRSET
 S (^%ZOSF("MGR"),^%ZOSF("PROD"))=UCI_","_VOL
 S ^%ZOSF("VOL")=VOL
 D MES^ZTMGRSET("ALL DONE",1)
 Q
 ;
DINIT(SITENUMBER,SITENAME) ; Silent Dinit Replacement
 S ^DD("SITE")=SITENAME
 S ^DD("SITE",1)=SITENUMBER
 D
 . I $P($SY,",")=47 S ^DD("OS")=$$FIND1^DIC(.7,,"QX","GT.M(UNIX)")
 . I $L($SY,":")=2  S ^DD("OS")=$$FIND1^DIC(.7,,"QX","CACHE/OpenM")
 D:$T(NOASK^DINIT)]"" NOASK^DINIT
 ;
 ; Fix ZSAVE bug causing END tag in TIUXRC2 to appear twice - % not newed (https://groups.google.com/forum/#!topic/hardhats/FEeTqYJZVSQ)
 I $P($T(+2^DI),";",3)="22.0" S $P(^DD("OS",19,"ZS"),"%I")="N %,"
 QUIT
 ;
ZUSET ;
 D POST^ZUSET
 QUIT
 ;
TASKMAN(SOFTCLN) ; Taskman Stuff --> Ends at TEND
CONST ; Constant Integers
 N KMAXJOB S KMAXJOB=30  ; Maximum M processes on the system
 ;
ENV ; We get environment variables here.
 S U="^"
 ;
 N Y D GETENV^%ZOSV ; Y=UCI^VOL^NODE^BOX LOOKUP
 N UCI S UCI=$P(Y,U)
 N VOL S VOL=$P(Y,U,2)
 N NODE S NODE=$P(Y,U,3) ; Cache Namespace on Cache; $gtm_sysid on GT.M.
 N BOX S BOX=$P(Y,U,4) ; VOL:NODE
 ;
KSP ; Kernel System Parameters cleanup. Fall through.
 N KBANI S KBANI=0
 N GREFC S GREFC=$$ROOT^DILFD(8989.304,",1,",1) ; Closed File Root for Volume Multiple
 N GREFO S GREFO=$$ROOT^DILFD(8989.304,",1,",0) ; Open File Root for Volume Multiple
 F  S KBANI=$O(@GREFC@(KBANI)) Q:'KBANI  D
 . N DA,DIK S DA(1)=1,DA=KBANI,DIK=GREFO D ^DIK ; Kill each entry in Vol subfile
 ;
 ; DEBUG.ASSERT - Make sure that the file is empty
 I $D(@GREFC)#10 S $EC=",U1,"
 ; DEBUG.ASSERT
 ;
 N KBANFDA
 S KBANFDA(8989.304,"+1,1,",.01)=VOL
 S KBANFDA(8989.304,"+1,1,",2)=30 ; 30 jobs by default.
 ;
 N KBANERR ; For errors
 D UPDATE^DIE("E",$NA(KBANFDA),"",$NA(KBANERR)) ; File data
 I $D(KBANERR) S $EC=",U1," ; if error filing, crash
 ;
 ; DEFAULT AUTO SIGN-ON -> Turn off. Causes problems with internet machines.
 K KBANFDA,KBANERR
 S KBANFDA(8989.3,1_",",218)="d"
 ;
 ; DNS
 S KBANFDA(8989.3,1_",",51)="9.9.9.9"
 ;
 ; Primary HFS Directory
 N OS S OS=$$VERSION^%ZOSV(1)
 S KBANFDA(8989.3,1_",",320)=$S(OS["NT":^%SYS("TempDir"),1:"/tmp/")   ; $I
 ;
 D FILE^DIE(,$NA(KBANFDA),$NA(KBANERR))
 I $D(KBANERR) S $EC=",U1," ; if error filing, crash
 ;
F14P5 ; 14.5 clean-up. Fall through.
 D KF(14.5) ; Bye bye file 14.5
 ;
 N KBANFDA
 S KBANFDA(14.5,"+1,",.01)=VOL ; Volume Set
 S KBANFDA(14.5,"+1,",.1)="GENERAL PURPOSE VOLUME SET" ; Type
 S KBANFDA(14.5,"+1,",1)="NO"  ; Inhibit Logons?
 S KBANFDA(14.5,"+1,",2)=""    ; Link Access?
 S KBANFDA(14.5,"+1,",3)="NO"  ; Out of Service?
 S KBANFDA(14.5,"+1,",4)="NO"  ; Required Volume Set
 S KBANFDA(14.5,"+1,",5)=UCI   ; Taskman Files UCI
 S KBANFDA(14.5,"+1,",6)=""   ; Taskman Files Volume Set
 S KBANFDA(14.5,"+1,",7)=""    ; Replacement Volume Set
 S KBANFDA(14.5,"+1,",8)=0     ; Days to keep old tasks
 S KBANFDA(14.5,"+1,",9)="Yes" ; Signon/Production Volume Set
 ;
 N KBANERR ; For errors
 D UPDATE^DIE("E",$NA(KBANFDA),"",$NA(KBANERR)) ; File data
 I $D(KBANERR) S $EC=",U1," ; if error filing, crash
 ;
F14P6 ; 14.6 clean-up. Fall through
 D KF(14.6) ; Bye bye file 14.6
 ;
F14P7 ; 14.7 clean-up. Fall through
 D KF(14.7) ; Bye bye file 14.7
 ;
 N KBANFDA
 S KBANFDA(14.7,"+1,",.01)=BOX    ;BOX-VOLUME PAIR (RF), [0;1]
 S KBANFDA(14.7,"+1,",1)=""       ;RESERVED (S), [0;2]
 S KBANFDA(14.7,"+1,",2)=""       ;LOG TASKS? (S), [0;3]
 S KBANFDA(14.7,"+1,",3)=""       ;DEFAULT TASK PRIORITY (NJ2,0), [0;4]
 S KBANFDA(14.7,"+1,",4)=""       ;TASK PARTITION SIZE (NJ3,0), [0;5]
 S KBANFDA(14.7,"+1,",5)=0        ;SUBMANAGER RETENTION TIME (NJ3,0), [0;6] TODO: Better values for Cache
 S KBANFDA(14.7,"+1,",6)=.80*$$KRNMAXJ(VOL)\1      ;TASKMAN JOB LIMIT (RNJ4,0), [0;7] 80 % OF Kernel Job Limit
 S KBANFDA(14.7,"+1,",7)=0        ;TASKMAN HANG BETWEEN NEW JOBS (NJ2,0), [0;8]
 S KBANFDA(14.7,"+1,",8)="G"      ;MODE OF TASKMAN (RS), [0;9]
 S KBANFDA(14.7,"+1,",9)=""       ;VAX ENVIROMENT FOR DCL (F), [0;10]
 S KBANFDA(14.7,"+1,",10)=""      ;OUT OF SERVICE (RS), [0;11]
 S KBANFDA(14.7,"+1,",11)=0       ;MIN SUBMANAGER CNT (NJ2,0), [0;12]
 S KBANFDA(14.7,"+1,",12)=""      ;TM MASTER (P14.7'), [0;13]
 S KBANFDA(14.7,"+1,",13)=""      ;Balance Interval (NJ3,0), [0;14]
 S KBANFDA(14.7,"+1,",21)=""      ;LOAD BALANCE ROUTINE (F), [2;E1,75]
 S KBANFDA(14.7,"+1,",31)=1       ;Auto Delete Tasks (S), [3;1]
 S KBANFDA(14.7,"+1,",32)=1       ;Manager Startup Delay (NJ3,0), [3;2]
 ;
 N KBANERR ; For errors
 D UPDATE^DIE("",$NA(KBANFDA),"",$NA(KBANERR)) ; File data (Internal Format)
 I $D(KBANERR) S $EC=",U1," ; if error filing, crash
 ;
 I SOFTCLN D SOFTCLN QUIT
 ;
ZTSK K ^%ZTSK  ; ^%ZTSK clean-up
ZTSCH K ^%ZTSCH ; ^%ZTSCH clen-up
 ;
F19P2 ; 19.2 clean-up; Fall through.
 N GREFC S GREFC=$$ROOT^DILFD(19.2,"",1) ; Closed File Root for Option Scheduling
 N GREFO S GREFO=$$ROOT^DILFD(19.2,"",0) ; Open File Root for Option Scheduling
 ;
 ; Walk through entries
 N KBANI S KBANI=0
 F  S KBANI=$O(@GREFC@(KBANI)) Q:'KBANI  D
 . N DA,DIK S DA=KBANI,DIK=GREFO D ^DIK ; Kill each entry
 ;
 N KBANI,OPT
 N KBANFDA
 F KBANI=1:1 S OPT=$T(F19P2OPT+KBANI) Q:$P(OPT,";;",2)="<<END>>"  D
 . N NODE S NODE=$P(OPT,";;",2)    ; Node
 . N OS S OS=$P(NODE,U,4)          ; M VM (Open-NT or GT.M)
 . I $L(OS),^%ZOSF("OS")'[OS QUIT  ; If OS is defined and it's not ours, quit
 . ;
 . N NAME S NAME=$P(NODE,U)
 . N STARTUP,TIME
 . D
 . . N N2 S N2=$P(NODE,U,2)
 . . S STARTUP=$S(N2="S":"STARTUP",1:"")
 . . S TIME=$S(N2'="S":N2,1:"")
 . ;
 . N RESCHFREQ S RESCHFREQ=$P(NODE,U,3)
 . N OS S OS=$P(NODE,U,4)
 . ;
 . S KBANFDA(19.2,"+"_KBANI_",",.01)=NAME       ; NAME (R*P19'), [0;1]
 . S KBANFDA(19.2,"+"_KBANI_",",2)=TIME         ; QUEUED TO RUN AT WHAT TIME (DX), [0;2]
 . S KBANFDA(19.2,"+"_KBANI_",",6)=RESCHFREQ    ; RESCHEDULING FREQUENCY (FX), [0;6]
 . S KBANFDA(19.2,"+"_KBANI_",",9)=$G(STARTUP)  ; SPECIAL QUEUEING (SX), [0;9]
 ;
 N KBANERR ; For errors
 D UPDATE^DIE("E",$NA(KBANFDA),"",$NA(KBANERR)) ; File data (External Format)
 I $D(KBANERR) S $EC=",U1," ; if error filing, crash
 ;
TEND QUIT  ; Taskman END
 ;
MSP ; Mailman Site Parameters Clean-up
 N KBANFDA S KBANFDA(4.3,"1,",7.5)="@" ; CPU/VOL in MSP
 N KBANERR
 D FILE^DIE("",$NA(KBANFDA),$NA(KBANERR))
 I $D(KBANERR) S $EC=",U1,"
 QUIT
 ;
DEVCLEAN ; Device Cleanup
 D DEVVOL
 D DEVNULL
 D DEVHFS
 D DEVTTY
 D DEVPTS
 D DEVZERO
 QUIT
 ;
DEVVOL ; Delete Volume field for each device.
 N KBANI S KBANI=0
 N KBANFDA
 F  S KBANI=$O(^%ZIS(1,KBANI)) Q:'KBANI  S KBANFDA(3.5,KBANI_",",1.9)="@"
 N KBANERR
 D FILE^DIE("",$NA(KBANFDA),$NA(KBANERR))
 I $D(KBANERR) S $EC=",U1,"
 QUIT
 ;
DEVNULL ; Fix up null devices
 D FIND^DIC(3.5,,,"PQM","NULL")
 ;
 ; Remove old nulls
 N Z,FDA
 N KBANI F KBANI=0:0 S KBANI=$O(^TMP("DILIST",$J,KBANI)) Q:'KBANI  S Z=^(KBANI,0) D
 . N IEN S IEN=$P(Z,U)
 . S FDA(3.5,IEN_",",.01)="ZZNULL"
 D FILE^DIE(,$NA(FDA))
 ;
 ; Find correct null (if present)
 N NULL
 I $P(^%ZOSF("OS"),U,2)=19 S NULL="/dev/null" ; GT.M
 I $P(^%ZOSF("OS"),U,2)=18,$$VERSION^%ZOSV(1)'["NT" S NULL="/dev/null"   ; Cache non-NT
 I $P(^%ZOSF("OS"),U,2)=18,$$VERSION^%ZOSV(1)["NT"  S NULL="//./NUL" ; Cache NT
 D FIND^DIC(3.5,,,"PQM",NULL)
 ;
 I +^TMP("DILIST",$J,0)>1 D
 . N KBANI F KBANI=1:0 S KBANI=$O(^TMP("DILIST",$J,KBANI)) Q:'KBANI  S Z=^(KBANI,0) D
 .. N IEN S IEN=$P(Z,U)
 .. S FDA(3.5,IEN_",",.01)="ZZNULL"
 . D FILE^DIE(,$NA(FDA))
 ;
 S FDA(3.5,"?+1,",.01)="NULL"         ; NAME
 S FDA(3.5,"?+1,",.02)="BIT BUCKET"   ; LOCATION
 S FDA(3.5,"?+1,",1)=NULL             ; $I
 S FDA(3.5,"?+1,",1.95)="@"           ; SIGN-ON/SYSTEM DEVICE
 S FDA(3.5,"?+1,",2)="TERMINAL"       ; TYPE
 S FDA(3.5,"?+1,",3)="P-OTHER"        ; SUBTYPE
 S FDA(3.5,"?+1,",51)="@"             ; OPEN COUNT
 N ERR
 D UPDATE^DIE("E",$NA(FDA),,$NA(ERR))
 I $D(DIERR) ZWRITE ERR
 QUIT
 ;
DEVHFS ; Fix up HFS device
 N OS S OS=$$VERSION^%ZOSV(1)
 N HFSSUBTYPE S HFSSUBTYPE=$$FIND1^DIC(3.2,,"PQX","P-HFS/80/99999")
 I 'HFSSUBTYPE S HFSSUBTYPE=$$FIND1^DIC(3.2,,"PQX","P-OTHER")
 N OPENPAR S OPENPAR=$S($P(^%ZOSF("OS"),U,2)=19:"(nowrap:stream:newversion)",$P(^%ZOSF("OS"),U,2)=18:"""NWS""") ; Yes, crash if not 18 or 19.
 ;
 N FDA
 S FDA(3.5,"?+1,",.01)="HFS"          ; NAME
 S FDA(3.5,"?+1,",.02)="Host File Device"   ; LOCATION
 S FDA(3.5,"?+1,",1)=$S(OS["NT":"c:\hfs.dat",1:"/tmp/hfs.dat")   ; $I
 S FDA(3.5,"?+1,",1.95)="@"           ; SIGN-ON/SYSTEM DEVICE
 S FDA(3.5,"?+1,",2)="HOST FILE SERVER"       ; TYPE
 S FDA(3.5,"?+1,",3)="`"_HFSSUBTYPE   ; SUBTYPE
 S FDA(3.5,"?+1,",51)="@"             ; OPEN COUNT
 S FDA(3.5,"?+1,",4)="@"              ; ASK DEVICE
 S FDA(3.5,"?+1,",5)="@"              ; ASK PARAMETERS
 S FDA(3.5,"?+1,",5.1)="YES"          ; ASK HOST FILE
 S FDA(3.5,"?+1,",5.2)="@"            ; ASK HFS I/O OPERATION
 S FDA(3.5,"?+1,",19)=OPENPAR         ; OPEN PARAMETERS
 ;
 N ERR
 D UPDATE^DIE("E",$NA(FDA),,$NA(ERR))
 I $D(DIERR) ZWRITE ERR
 QUIT
 ;
DEVTTY ; Fix TTY
 N OS S OS=$$VERSION^%ZOSV(1)
 N dI S dI=$S(OS["Linux":"/dev/tty",OS["NT":"|TRM|",1:"/dev/tty")
 N ttyIEN s ttyIEN=$$FIND1^DIC(3.5,,"MQ",dI)
 ;
 N FDA,IENS
 i ttyIEN S IENS=ttyIEN_","
 e  s IENS="+1,"
 S FDA(3.5,IENS,.01)="CONSOLE"
 S FDA(3.5,IENS,.02)="Computer Console"     ; LOCATION
 S FDA(3.5,IENS,1)=dI                       ; $I
 S FDA(3.5,IENS,2)="VIRTUAL TERMINAL"       ; TYPE
 S FDA(3.5,IENS,4)=1                        ; ASK DEVICE
 N VTIEN S VTIEN=$$FIND1^DIC(3.2,,"XQ","C-VT220")
 I 'VTIEN S VTIEN=$$FIND1^DIC(3.2,,"XQ","C-VT100")
 S FDA(3.5,IENS,3)="`"_VTIEN
 N ERR,IEN
 i ttyIEN D FILE^DIE("E",$NA(FDA),$NA(ERR)) i 1
 e  D UPDATE^DIE("E",$NA(FDA),$NA(IEN),$NA(ERR)) S IENS=IEN(1)_","
 I $D(DIERR) ZWRITE ERR B
 ;
 N FDA,ERR
 S FDA(3.5,IENS,1.95)=1           ; SIGN-ON/SYSTEM DEVICE
 D FILE^DIE(,$NA(FDA),$NA(ERR))
 I $D(DIERR) ZWRITE ERR B
 QUIT
 ;
DEVPTS ; Fix PTS
 N OS S OS=$$VERSION^%ZOSV(1)
 N dI S dI=$S(OS["Linux":"/dev/pts",OS["NT":"|TNT|",OS["CYGWIN":"/dev/cons",OS["Darwin":"/dev/ttys",1:"/dev/pts")
 N ptyIEN s ptyIEN=$$FIND1^DIC(3.5,,"MQ",dI)
 ;
 i ptyIEN S IENS=ptyIEN_","
 e  s IENS="+1,"
 N FDA
 S FDA(3.5,IENS,.01)="VIRTUAL TERMINAL"
 S FDA(3.5,IENS,.02)="Virtual Terminal"     ; LOCATION
 S FDA(3.5,IENS,1)=dI                       ; $I
 S FDA(3.5,IENS,2)="VIRTUAL TERMINAL"       ; TYPE
 S FDA(3.5,IENS,4)=1                        ; ASK DEVICE
 N VTIEN S VTIEN=$$FIND1^DIC(3.2,,"XQ","C-VT220")
 I 'VTIEN S VTIEN=$$FIND1^DIC(3.2,,"XQ","C-VT100")
 S FDA(3.5,IENS,3)="`"_VTIEN
 N ERR,IEN
 i ptyIEN D FILE^DIE("E",$NA(FDA),$NA(ERR)) i 1
 e  D UPDATE^DIE("E",$NA(FDA),$NA(IEN),$NA(ERR)) S IENS=IEN(1)_","
 I $D(DIERR) ZWRITE ERR B
 ;
 N FDA,ERR
 S FDA(3.5,IENS,1.95)=1           ; SIGN-ON/SYSTEM DEVICE
 D FILE^DIE(,$NA(FDA),$NA(ERR))
 I $D(DIERR) ZWRITE ERR B
 QUIT
 ;
DEVZERO ; Fix ZERO Device
 ; (only needed for Unit Tests from Bash and Web Server)
 ; GT.M Sets $Principal to 0 in HEREDOCS and jobbed off processes
 N zeroIEN s zeroIEN=$$FIND1^DIC(3.5,,"MQX",0)
 ;
 i zeroIEN S IENS=zeroIEN_","
 e  s IENS="+1,"
 N FDA
 if 'zeroIEN do
 . S FDA(3.5,IENS,.01)="SLAVE DEVICE"
 . S FDA(3.5,IENS,.02)="SLAVE"              ; LOCATION
 . S FDA(3.5,IENS,1)=0                      ; $I
 . S FDA(3.5,IENS,2)="TERMINAL"             ; TYPE
 . S FDA(3.5,IENS,4)=1                      ; ASK DEVICE
 . S FDA(3.5,IENS,3)="`"_$$FIND1^DIC(3.2,,"XQ","P-OTHER") ; TERMINAL TYPE
 . N ERR,IEN
 . D UPDATE^DIE("E",$NA(FDA),$NA(IEN),$NA(ERR)) S IENS=IEN(1)_","
 . I $D(DIERR) ZWRITE ERR B
 N FDA,ERR
 S FDA(3.5,IENS,1.95)=1           ; SIGN-ON/SYSTEM DEVICE
 D FILE^DIE(,$NA(FDA),$NA(ERR))
 I $D(DIERR) ZWRITE ERR B
 QUIT
 ;
XU522 ; Disable Old CAPRI Log-in
 D EN^XPAR("SYS","XU522",1,"Y")
 QUIT
 ;
 ;
F19P2OPT ; Map: Option Name; Startup or time to schedule; resched freq; OS-specific
 ;;XWB LISTENER STARTER^S
 ;;XUSER-CLEAR-ALL^S
 ;;XUDEV RES-CLEAR^S
 ;;XOBV LISTENER STARTUP^S
 ;;XMMGR-START-BACKGROUND-FILER^S
 ;;HL AUTOSTART LINK MANAGER^S
 ;;HL TASK RESTART^S
 ;;XMAUTOPURGE^T+1@0010^1D
 ;;XMCLEAN^T+1@0015^1D
 ;;XQBUILDTREEQUE^T+1@0020^1D
 ;;XQ XUTL $J NODES^T+1@0025^1D
 ;;XUERTRP AUTO CLEAN^T+1@0030^1D
 ;;XUTM QCLEAN^T+1@0035^1D
 ;;XMMGR-PURGE-AI-XREF^T+1@0040^1D
 ;;HL PURGE TRANSMISSIONS^T+1@0045^1D
 ;;<<END>>
 ;;
SOFTCLN ; [Private] Soft clean tasks -- don't delete them as in a brand new system
 K ^%ZTSCH("ER")
 K ^%ZTSCH("STATUS")
 K ^%ZTSCH("MON")
 K ^%ZTSCH("WAIT")
 K ^%ZTSCH("SYNC")
 K ^%ZTSCH("STARTUP")
 K ^%ZTSCH("DEVTRY")
 K ^%ZTSCH("IO")
 K ^%ZTSCH("LINK")
 K ^%ZTSCH("SUB")
 N X,Y
 S X=0 F  S X=$O(^%ZTSK(X)) Q:'X  D
 . I '$D(^%ZTSK(X,0)) QUIT
 . N Y S Y=^%ZTSK(X,0)
 . S $P(Y,"^",4)=UCI
 . S $P(Y,"^",11)=UCI
 . S $P(Y,"^",12)=VOL
 . S $P(Y,"^",14)=UCI
 . S ^%ZTSK(X,0)=Y
 QUIT
 ;
KF(FN,IENS) ; Kill File; Private Procedure
 ; FN = File Number; pass by value. Required.
 ; IENS = IENs; pass by value. Optional.
 ; NB: Will not work for files under ^DIC as this deletes their definition as well
 N GREF S GREF=$$ROOT^DILFD(FN,$G(IENS),1) ; Close File Root
 Q:GREF["^DIC"  ; Don't delete files stored in ^DIC
 Q:GREF=""      ; No invalid files.
 N % S %=@GREF@(0) ; Save off zero node
 S $P(%,U,3,4)="" ; remove last touched and newest record markers
 K @GREF ; bye
 S @GREF@(0)=% ; restore zero node
 QUIT
KRNMAXJ(VOL) ; Max Jobs on this volume in the Kernel; Private $$
 N X S X=$O(^XTV(8989.3,1,4,"B",VOL,0))
 N J S J=$S(X>0:^XTV(8989.3,1,4,X,0),1:"ROU^^1")
 Q $P(J,U,3)
