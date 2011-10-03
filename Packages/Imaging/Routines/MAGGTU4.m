MAGGTU4 ;WOIFO/GEK/SG/NST - VERSION CHECKS FOR IMAGING CLIENTS ; 25 May 2010 12:33 PM
 ;;3.0;IMAGING;**8,48,63,45,46,59,96,95,72,93,94**;Mar 19, 2002;Build 1744;May 26, 2010
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
 ;***** SETS ABSTRACT AND/OR JUKEBOX QUEUES
 ; RPC: MAG ABSJB
 ;
 ; .MAGRES       Reference to a local variable where the result is
 ;               returned to.
 ;
 ; .MAGIN        IENs of images to be processed
 ;                 ^01: IEN of the image that needs an abstract
 ;                      created
 ;                 ^02: IEN of the image that needs to be copied
 ;                      to the jukebox
 ;
 ; Return Values
 ; =============
 ;
 ; Result code and corresponding message are returned in the MAGRES
 ; parameter:
 ;
 ; MAGRES                Result descriptor
 ;                         ^01: Result code:
 ;                                0  Error
 ;                                1  Success
 ;                         ^02: Message
 ;
ABSJB(MAGRES,MAGIN) ;RPC [MAG ABSJB]
 D ABSJB^MAGGTU71(.MAGRES,.MAGIN)
 Q
 ;
 ;***** CLIENT/SERVER VERSION CHECKS
 ; RPC: MAG4 VERSION CHECK
 ;
 ; .MAGRES       Reference to a local array where results are
 ;               returned to.
 ;
 ; CLVER         Client application descriptor
 ;                 |01: Version (Major.Minor.Patch.Build)
 ;                 |02: empty or "RIV" for remote image view clients
 ;                 |03: Client name ("CAPTURE", "CLUTILS", "DISPLAY",
 ;                      "TELEREADER", or "VISTARAD")
 ;
 ;               For example, the Clinical Display client Version
 ;               3.0 Patch 8 Build (test version) 21 will pass
 ;               "3.0.8.21||DISPLAY" as the value of this parameter.
 ;
 ; Input Variables
 ; ===============
 ;   MAGJOB
 ;
 ; Output Variables
 ; ================
 ;   MAGJOB
 ;
 ; Return Values
 ; =============
 ;
 ; Result code and message are returned into the MAGRES(0).
 ; The subsequent nodes may contain additional lines of the
 ; message text.
 ;
 ; MAGRES(0)             Result descriptor
 ;                         ^01: Result code:
 ;                                0  The client will display the
 ;                                   message and continue.
 ;                                1  The client will continue without
 ;                                   displaying any message.
 ;                                2  The client will display the
 ;                                   message and then terminate.
 ;                         ^02: Message
 ;
 ; MAGRES(i)             Additional line of the message text
 ;
 ; Notes
 ; =====
 ;
 ; Ver 2.5P9 (2.5.24.1) is the first GUI client (Delphi) that makes
 ; this call.
 ;
CHKVER(MAGRES,CLVER) ;RPC [MAG4 VERSION CHECK]
 N MAGVCD        ; Version control data
 ;
 N CLNAME,CVRC,RC
 S (CVRC,RC)=0
 D
 . N I,N,TMP
 . ;--- Parse the client application descriptor
 . S N=$L(CLVER,"|"),CLNAME=$P(CLVER,"|",3)
 . F I=2:1:N  S TMP=$P(CLVER,"|",I)  S:TMP'="" MAGJOB(TMP)=1
 . S CLVER=$P(CLVER,"|")
 . I CLNAME=""  D  Q:RC<0
 . . ;--- Only the client version was sent before the MAG*3.0*59
 . . I CLVER'["|"  S CLNAME="DISPLAY"  Q
 . . ;--- Currently, the client application name must be provided
 . . S RC=$$ERROR^MAGUERR(-24,,CLNAME)
 . . Q
 . ;
 . ;--- Check the client version
 . S CVRC=$$CHKVER1^MAGGTU41(.MAGVCD,CLNAME,.CLVER)
 . I CVRC<0  S RC=CVRC  Q
 . ;
 . ;--- Load and format the message
 . S RC=$$MESSAGE(CLNAME,CLVER,CVRC)
 . Q
 ;---
 I RC<0  D ERROR^MAGGTU41(.MAGRES,RC)  Q
 D WARNING^MAGGTU41(.MAGRES,CLNAME,CLVER,CVRC)
 Q
 ;
 ;+++++ LOADS AND FORMATS THE MESSAGE IN THE MAGRES ARRAY
 ;
 ; CLNAME        Client name
 ;
 ; CLVER         Client application version (Major.Minor.Patch.Build)
 ;
 ; CVRC          Version check code returned by the $$CHKVER1^MAGGTU41
 ;
 ; Input Variables
 ; ===============
 ;   DUZ, MAGVCD
 ;
 ; Output Variables
 ; ================
 ;   MAGRES
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see $$ERROR^MAGUERR)
 ;            0  The client will display a warning and continue
 ;            1  The client will continue
 ;            2  The client will display a warning and terminate
 ;
MESSAGE(CLNAME,CLVER,CVRC) ;
 N BETA,CV,DLG,DLG1,MAGPRMS,PLC,RC,SVSTAT,TMP
 K MAGRES
 ;
 ;--- If this is a remote connection, allow it.
 I $D(MAGJOB("RIV"))  D  Q 1
 . S MAGRES(0)="1^"_$$EZBLD^DIALOG(20050005.013)
 . Q
 ;
 ;--- Get IEN of the Imaging site parameters
 Q:'$G(DUZ(2)) $$ERROR^MAGUERR(-26,,"DUZ(2)")
 S PLC=$$PLACE^MAGBAPI(DUZ(2))
 I 'PLC  D  Q $$ERROR^MAGUERR(-27,,TMP)
 . S TMP=$P($G(^DIC(4,DUZ(2),0)),U)_" ["_DUZ(2)_"]"
 . Q
 ;
 ;--- Quit if the site has VERSION CHECKING=0 (OFF) in
 ;--- the IMAGING SITE PARAMETERS file (#2006.1)
 ; Patch 94 - don't check for VERSION CHECKING
 ;I '$$VERCHKON(PLC)  D  Q 1
 ;. S MAGRES(0)="1^"_$$EZBLD^DIALOG(20050005.014)
 ;. Q
 ;
 ;--- Is this server version alpha/beta or released?
 D VERSTAT(.SVSTAT,MAGVCD(CLNAME,"SV"))
 I '$G(SVSTAT)  S MAGRES(0)="2^"_$P(SVSTAT,U,2)  Q 2
 S BETA=(+SVSTAT=2)
 ;
 ;--- Initilize message parameters
 S (MAGPRMS("CV"),CV)=$P(CLVER,".",1,3)  ; Client Major.Minor.Patch
 S MAGPRMS("CP")=$P(CLVER,".",3)         ; Client patch number
 S MAGPRMS("CST")=$G(MAGVCD(CLNAME,"ST",CV)) ; Supported client build
 S MAGPRMS("CT")=$P(CLVER,".",4)         ; Client build number
 S MAGPRMS("ST")=MAGVCD(CLNAME,"ST")     ; Server build number
 S MAGPRMS("SV")=MAGVCD(CLNAME,"SV")     ; Server Major.Minor.Patch
 S MAGPRMS("SVSTAT")=$P(SVSTAT,U,2)      ; Server version status
 ;
 S DLG=20050005.001,RC=1
 D:CVRC
 . ;--- Latest version but old build (T-version)
 . I CVRC=1  D  Q
 . . S RC=0,DLG=$S(BETA:20050005.008,1:20050005.007)
 . . Q
 . ;--- Supported version
 . I CVRC=2  D  Q
 . . S RC=$S(BETA:1,1:0),DLG=$S(BETA:20050005.012,1:20050005.011)
 . . S:$P(CV,".")=2 DLG1=20050005.005
 . . Q
 . ;--- Supported version but old build (T-version)
 . I CVRC=3  D  Q
 . . S RC=$S(BETA:0,1:2),DLG=$S(BETA:20050005.01,1:20050005.009)
 . . Q
 . ;--- Client is not supported
 . I CVRC=4  D  Q
 . . S RC=$S(BETA:0,1:2),DLG=$S(BETA:20050005.004,1:20050005.003)
 . . S:$P(CV,".")=2 DLG1=20050005.006
 . . Q
 ;
 ;--- Load and format the message
 D BLD^DIALOG(DLG,.MAGPRMS,,"MAGRES")
 ; check for "version nag message" only if the server is not in alpha/beta
 I 'BETA D
 . I RC'=0 Q  ; the application will terminate or will not show the nag message 
 . I '$$NAGMSGON(PLC) S RC=1  ; do not show the nag message
 . Q
 S MAGRES(0)=RC_U_$G(MAGRES(1))  K MAGRES(1)
 D:$G(DLG1)&(RC'=1) BLD^DIALOG(DLG1,,,"MAGRES")
 ;---
 Q RC
 ;
 ;+++++ RETURNS STATUS OF THE VERSION CHECKING FOR THE SITE
 ;
 ; PLC           IEN of the Imaging site parameters (file #2006.1)
 ;
 ; Return Values
 ; =============
 ;            0  No version checking
 ;            1  Version checking is enabled
 ;
VERCHKON(PLC) ;
 Q +$P(^MAG(2006.1,PLC,"KEYS"),U,5)
 ;
 ;+++++ RETURNS STATUS OF THE VERSION NAG MESSAGE FOR THE SITE
 ;
 ; PLC           IEN of the Imaging site parameters (file #2006.1)
 ;
 ; Return Values
 ; =============
 ;            0  No nag message
 ;            1  Display nag message
 ;
NAGMSGON(PLC) ;
 Q +$$GET1^DIQ(2006.1,PLC,132,"I")
 ;
 ;***** RETURNS THE STATUS OF IMAGING VERSION
 ; RPC: MAG4 VERSION STATUS
 ;
 ; .MAGRES       Reference to a local variable where the result is
 ;               returned to.
 ;
 ; MAGVER        Version number (e.g. MAG*3.0*59 or 3.0.59)
 ;
 ; Return Values
 ; =============
 ;
 ; Status code and description are returned into the variable
 ; referenced by the MAGRES parameter. Below is the list of
 ; possible values:
 ;
 ;            0^There is no KIDS Install Record.
 ;            1^Unknown Release Status.
 ;            2^Alpha/Beta Version.
 ;            3^Released Version.
 ;
VERSTAT(MAGRES,MAGVER) ;RPC [MAG4 VERSION STATUS]
 N TVER,MAGERR,VERI
 S:+MAGVER MAGVER="MAG*"_$P(MAGVER,".",1,2)_"*"_$P(MAGVER,".",3)
 ;--- Search for the installation record
 S VERI=$$FIND1^DIC(9.6,,"MO",MAGVER,,,"MAGERR")
 I 'VERI  D  Q
 . S MAGRES="0^There is no KIDS Install Record for """_MAGVER_"""."
 ;--- Check the alpha/beta testing status
 S TVER=$$GET1^DIQ(9.6,VERI_",","ALPHA/BETA TESTING",,,"MAGERR")
 I TVER="YES"  S MAGRES="2^Alpha/Beta Version."  Q
 I TVER="NO"   S MAGRES="3^Released Version."    Q
 S MAGRES="1^Unknown Release Status."
 Q
 ;
 ;***** IMPLEMENATION OF THE 'MAG CLIENT VERSION REPORT' OPTION
WSCVCROP ;
 N DA,DIR,DIRUT,DTOUT,DUOUT,MAGSORT,X,Y
 N MAGLLGDT  ; Workstation Last Login date
 N MAGWNMB ; Workstation name contains
 N MAGALLW  ; Include all workstations in the report
 ;
 ; Get Last login date
 K DIR
 S DIR(0)="N^1:9999:0"
 S DIR("A")="Last login date is within this many days"
 S DIR("?")="Enter the number of days prior to today"
 S DIR("B")=30
 D ^DIR  Q:$G(DIRUT)!($G(Y)="")
 S MAGLLGDT=$P($$FMADD^XLFDT($$NOW^XLFDT,-Y),".")  ; just get the date
 ;
 ; Get Workstation start with
 K DIR
 S DIR(0)="FO^"
 S DIR("A")="Workstation name contains text"
 S DIR("?")="Enter text that the workstation name must contain to be included in the search."
 D ^DIR Q:$G(Y)="^"
 S MAGWNMB=Y
 ;
 ;--- Include all workstations in the report
 K DIR
 S DIR(0)="Y^"
 S DIR("A")="Include all workstations in the report"
 S DIR("B")="N"
 D ^DIR  Q:$G(DIRUT)!($G(Y)="")
 S MAGALLW=Y
 ;
 ;--- Let the user select the report sort mode
 K DIR
 S DIR(0)="SO^"
 S DIR(0)=DIR(0)_"V:Site-Client-Version-Workstation Name;"
 S DIR(0)=DIR(0)_"W:Site-Workstation Name-Client;"
 S DIR("A")="Report Sort Mode"
 S DIR("B")="W"
 D ^DIR  Q:$G(DIRUT)!($G(Y)="")
 S MAGSORT=Y
 ;
 ;--- Let the user select the device and queue the report
 W !  S %ZIS="Q"  D ^%ZIS  Q:$G(POP)
 I $D(IO("Q"))  D  K IO("Q")
 . N ZTCPU,ZTDESC,ZTDTH,ZTIO,ZTKIL,ZTPRI
 . N ZTRTN,ZTSAVE,ZTSK,ZTSYNC,ZTUCI
 . S ZTRTN="WSCVCRPT^MAGGTU42"
 . S ZTDESC="Imaging Workstations and Clients Report"
 . S ZTSAVE("MAGSORT")=MAGSORT
 . S ZTSAVE("MAGWNMB")=MAGWNMB
 . S ZTSAVE("MAGLLGDT")=MAGLLGDT
 . S ZTSAVE("MAGALLW")=MAGALLW
 . D ^%ZTLOAD,HOME^%ZIS
 . Q
 E  U IO  D WSCVCRPT^MAGGTU42
 ;---
 Q
