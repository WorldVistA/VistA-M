MAGGTMC ;WOIFO/GEK - RPC Calls for Imaging/Medicine procedures ; [ 06/20/2001 08:56 ]
 ;;3.0;IMAGING;**8**;Sep 15, 2004
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
LIST(MAGRY,MAGGZY) ;RPC [MAGGLISTPROC]
 ; Call to return a list of procedures/subspecialities
 ;MAGGZY NOT USED in Version 2.5
 ;  if MAGGZY=1 then add procedure PRINT NAME (full name) in output
 ; returns list of  NAME       PRINT NAME  ^     GLOBAL ^   IEN
 ;  i.e.           "ECG        ELECTROCARDIOGRAM^MCAR(691.5^2"
 IF $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 E  S X="ERRA^MAGGTERR",@^%ZOSF("TRAP")
 N X,Y,Z,I,CT,PRCSTR,MAGKEY,TEMP,MAGPLC
 S CT=0
 ; Now we will check keys for medicine procedures the user is 
 ; allowed to capture to.
 ; We allow site to Use/Not Use the Capture Security Keys based on 
 ;  an entry in the Site Parameters File
 S MAGPLC=$$PLACE^MAGBAPI(DUZ(2))
 S MAGKEY=+$P($G(^MAG(2006.1,MAGPLC,"KEYS")),U)
 I 'MAGKEY D  Q
 . S X="" F  S X=$O(^MCAR(697.2,"B",X)) Q:X=""  D
 . . S I=$O(^MCAR(697.2,"B",X,"")) S Z=X
 . . S Y=^MCAR(697.2,I,0)
 . . Q:'$D(^MAG(2005.03,$P($P(Y,U,2),"(",2)))
 . . S CT=CT+1
 . . S MAGRY(CT)=Z_U_$P(Y,U,8)_U_$P(Y,U,2)_U_I
 D PROCS(.DUZ,.TEMP)
 S (X,CT)=0 F  S X=$O(TEMP(X)) Q:X'?1N.N  D
 . Q:'$D(^XUSEC("MAGCAP MED "_$P(TEMP(X),U,5),DUZ))
 . S CT=CT+1,MAGRY(CT)=TEMP(X)
 Q
PRC(MAGRY,MAGGZY) ;RPC [MAGGPATPROC]
 ;  Call to return a List of Patient Procedures
 ;                in subspeciality, or all
 ; MAGGZY is a '^' delimited string of 4 pieces.
 ;   $p(1) = Internal entry number of the Subspecialty
 ;             i.e. ^MCAR(697.2,IEN)  
 ;   $P(2) = DFN 
 ;   $P(3) = TO DATE (external format) 
 ;   $P(4) = FROM DATE def to TODAY (external format)
 ;             i.e. "43^643^07/03/95"
 ;
 N DIQUIET,Y,X,MCFILE,MAGGFI,MAGGFN,MAGDFN,MAGGPN,MAGGD
 ;
 IF $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 E  S X="ERRA^MAGGTERR",@^%ZOSF("TRAP")
 S DIQUIET=1 D DT^DICRW
 ;  FILE               PATIENT               DATE
 S MAGGFI=+$P(MAGGZY,U),MAGDFN=+$P(MAGGZY,U,2),MAGGD=$P(MAGGZY,U,3)
 ; 
 I '$D(^MCAR(697.2,MAGGFI)) D  Q
 . S MAGRY(0)="0^NO Specialty # exists "_MAGGFI
 S MCFILE=$P(^MCAR(697.2,MAGGFI,0),U,2)   ; GLOBAL i.e.  MCAR(691
 S MAGGFN=$P(^MCAR(697.2,MAGGFI,0),U)     ; NAME   i.e.  ECHO
 S MAGGPN=$P(^DPT(MAGDFN,0),U)            ; PATIENT NAME
 ; Call Medicine API to list procedure for patient in this subspecialty
 D SUB^MCARUTL2(.MAGRY,MAGDFN,MAGGFI)
 Q
PROCS(DUZ,PROCS) ;MAGDUZ=DUZ , PROCS IS CALLED BY REFERENCE
 N IEN,CNT,KEY,NAME,NODE
 S NAME="",CNT=0
 F  S NAME=$O(^MCAR(697.2,"B",NAME)) Q:NAME=""  S IEN=$O(^(NAME,"")) D
 . Q:IEN'?1N.N
 . S NODE=$G(^MCAR(697.2,IEN,0)) Q:NODE=""
 . Q:'$D(^MAG(2005.03,$P($P(NODE,U,2),"(",2)))
 . S CNT=CNT+1
 . S $P(PROCS(CNT),U,1)=NAME ;PROCEDURE NAME
 . S $P(PROCS(CNT),U,2)=$P(NODE,U,8)  ;PRINTNAME
 . S $P(PROCS(CNT),U,3)=$P(NODE,U,2)  ;GLOBAL LOCATION
 . S $P(PROCS(CNT),U,4)=IEN  ;PROC/SUBSPEC FILE IEN
 . S $P(PROCS(CNT),U,5)=$P(NODE,U,4)  ;PROCEDURE TYPE
 Q
