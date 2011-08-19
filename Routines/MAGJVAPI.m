MAGJVAPI ;WOIFO/MAT VistARad RPCs for ViX ; 28-Oct-2010 9:09pm
 ;;3.0;IMAGING;**90,115**;Mar 19, 2002;Build 1912;Dec 17, 2010
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
 ;***** Log ViX-enabled Remote Image Access Events 
 ; RPC: MAGJ VIX LOG REMOTE IMG ACCESS
 ; 
 ;   External Calls: ENTRY^MAGLOG()   ; Upd8 IMAGE ACCESS LOG (#2006.95).
 ;                   ACTION^MAGGTAU() ; Upd8 IMAGING WINDOWS SESS'NS (#2006.82)
 ;             
 ;   Internal Calls: LOGRIA01()       ; Validate input, process, return error.
 ; 
 ; .MAGJRY -- Reference to a local variable name for the return value.
 ;
 ;    DATA -- ^01: ACTION ... "VR-RV"_ subset member from ACTION+1^MAGGTAU.
 ;            ^02: RADFN .... IEN of PATIENT file (#2)
 ;            ^03: MAGIEN ... IEN of IMAGE file (#2005)
 ;            ^04: NIMGS .... VRad Image Count
 ;            ^05: REMOTE ... VRad Remote Read Flag
 ;            ^06: MAGJVRV .. VRad Version
 ;            ^07: USERCLS .. VRad User Class
 ;            ^08: VIXTXID .. VRad VIX Transaction ID
 ; Returns ...
 ; ===========
 ;                ______ON_ERROR_______    ___EXPECTED___
 ; MAGJRY    ^01: 0                        1
 ;           ^02: Error message
 ;
 ; Notes
 ; =====
 ; 
 ; DUZ on the remote VistA is initialized during ViX authentication.
 ; "VRad Patient Count" is static at 1 in this context.
 ;
LOGRIA(MAGJRY,DATA) ;
 ;
 ;--- Main.
 N MAGJVERR S MAGJRY="1"
 S MAGJVERR=$$LOGRIA01() I +MAGJVERR S MAGJRY="0^"_$P(MAGJVERR,"^",2)
 Q MAGJRY
 ;
 ;
LOGRIA01() ;
 N TAGG S TAGG="LOGRIA01"
 N MAGIEN,RADFN
 ;
 ;--- Validate RADFN, MAGIEN. On error, set MAGJVERR="1^"_errmsg.
 S MAGJVERR=0 D
 . S RADFN=$P(DATA,U,2) I RADFN="" S MAGJVERR="1^"_TAGG_": NULL (RADFN)." Q
 . S MAGIEN=$P(DATA,U,3) I MAGIEN="" S MAGJVERR="1^"_TAGG_": NULL (MAGIEN)." Q
 . I '$D(^MAG(2005,MAGIEN)) S MAGJVERR="1^"_TAGG_": UNDEFINED SUBSCRIPT ^MAG(2005,"_MAGIEN_"," Q
 . I RADFN'=$P($G(^MAG(2005,MAGIEN,0)),U,7) S MAGJVERR="1^"_TAGG_": INPUT POINTERS UNRELATED ON SYSTEM." Q
 ;
 ;--- Proceed iff no error.
 I MAGJVERR=0 D
 . N ACTION,MAGJTXT,NIMGS,PTCT,REMOTE,USERCLS,VIXTXID,VRADVER,YNRIST
 . S ACTION=$P(DATA,U,1) S:ACTION="" ACTION="Unspecified"
 . S REMOTE=$P(DATA,U,5) S:REMOTE="" REMOTE="Unspecified"
 . S NIMGS=$P(DATA,U,4),VRADVER=$P(DATA,U,6),VIXTXID=$P(DATA,U,8)
 . S USERCLS=$P(DATA,U,7),YNRIST=$S(+USERCLS:1,1:0)
 . ;
 . ;--- Initialize PatientCount.
 . S PTCT=RADFN'=$G(MAGJOB("LASTPT",ACTION))
 . I PTCT S MAGJOB("LASTPT",ACTION)=RADFN
 . S $P(MAGJTXT,U,1)=ACTION ; "VR-RVDODVA" or "VR-RVVAVA"
 . S $P(MAGJTXT,U,2)=RADFN  ; IEN of PATIENT file (#2)
 . S $P(MAGJTXT,U,3)=MAGIEN ; IEN of ^MAG(2005,
 . S $P(MAGJTXT,U,6)=NIMGS  ; Image Count
 . S $P(MAGJTXT,U,7)=PTCT   ; Patient Count
 . S $P(MAGJTXT,U,8)=YNRIST ; Radiologist? (0/1)
 . S $P(MAGJTXT,U,9)=REMOTE ; Remote Read? (0/1)
 . ;
 . ;--- Update the IMAGING WINDOWS SESSIONS file (#2006.82).
 . D ACTION^MAGGTAU(MAGJTXT,1)
 . ;
 . N MAGPACK S MAGPACK="VRAD:"_VRADVER
 . S:REMOTE ACTION=ACTION_"/REM"
 . ;
 . ;--- Update the IMAGE ACCESS LOG file (#2006.95).
 . I VIXTXID'="" D ENTRY^MAGLOG(ACTION,DUZ,MAGIEN,MAGPACK,RADFN,NIMGS,VIXTXID) Q
 . D ENTRY^MAGLOG(ACTION,DUZ,MAGIEN,MAGPACK,RADFN,NIMGS)
 Q MAGJVERR
 ;
 ; MAGJVAPI
