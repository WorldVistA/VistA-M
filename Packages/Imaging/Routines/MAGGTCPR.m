MAGGTCPR ;WOIFO/GEK - RPC Calls for Patient DHCP Reports ; [ 06/20/2001 08:56 ]
 ;;3.0;IMAGING;;Mar 01, 2002
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
DGRPD(MAGRPTY,DFN) ;RPC Call to  Generate Patient Profile
 ;
 ; -- MAGRPTY  -- is the name of the global holding the report.
 ; -- @MAGRPTY@(0)-- if = 0 then error occurred
 ; -- DFN := Patient File IEN
 ;  the variable MAGRPTY is referenced by CLOSE^MAGGTU5 to load 
 ;  the report from the VMS file WS.DAT into the referenced global;
 ;
 S MAGRPTY=$NA(^TMP($J,"WSDAT"))
 K @MAGRPTY
 S @MAGRPTY@(0)="0^-Cannot Open Workstation Redirection Device"
 S IOP="IMAGING WORKSTATION",%ZIS=0 D ^%ZIS Q:POP  ;Redirect Output Here
 U IO
 D EN^DGRPD
 D:IO'=IO(0) ^%ZISC
 S @MAGRPTY@(0)="1^OK"
 Q
HSUM(MAGRPTY,MAGGZ) ;RPC Call to Get Health Summary for Patient
 ; MAGGZ    ->   DFN  ^  HS Type (IEN)
 ;
 N Y,X,GMTSTYP,GMTSTITL
 IF $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTCPR"
 E  S X="ERRA^MAGGTCPR",@^%ZOSF("TRAP")
 S MAGRPTY=$NA(^TMP($J,"WSDAT"))
 K @MAGRPTY
 S @MAGRPTY@(0)="0^Health Summary Report NOT successful"
 S IOP="IMAGING WORKSTATION",%ZIS=0 D ^%ZIS Q:POP
 S GMTSTYP=$P(MAGGZ,U,2),DFN=$P(MAGGZ,U)
 S GMTSTITL=$$GET1^DIQ(142,GMTSTYP,".02","I")
 U IO
 D SELTYP1^GMTS,EN^GMTS1
 D END^GMTS K GMTSEG,GMTSEGI,GMTSEGC ; MOD GEK 5\13\96
 D:IO'=IO(0) ^%ZISC
 S @MAGRPTY@(0)="1^OK"
 Q
HSLIST(MAGRY,ZY) ;RPC Call To do a lookup using LIST^DIC to return
 ;  the List of Health Summary Types for a user to select from.
 ; MAGRY is the Array to return.
 ; ZY is NOT USED
 ; Kernel uses Y, we have to New it because calls to DIC etc
 ;            also use it and change it, and kill it.
 N Y,XI,Z,FI,MAGIEN,INFO
 N FILE,IENS,FLDS,FLAGS,VAL,NUM,FROM,PART,INDEX,SCR,IDENT,TROOT
 S (FILE,IENS,FLDS,FLAGS,VAL,NUM,FROM,PART,INDEX,SCR,IDENT,TROOT)=""
 ;
 ;  Format
 ;LIST^DIC(FILE,IENS,FIELDS,FLAGS,NUMBER,
 ;  [.]FROM,[.]PART,INDEX,[.]SCREEN,IDENTIFIER,TARGET_ROOT,MSG_ROOT)
 ;
 K ^TMP("DILIST",$J) ; is this necessary ?
 K ^TMP("DIERR",$J) ; This is.
 S FILE=142,NUM=9000,FROM="",PART="",FLDS="@;.01",INDEX="B"
 D LIST^DIC(FILE,IENS,FLDS,FLAGS,NUM,FROM,PART,INDEX,SCR,IDENT,TROOT)
 ;
 I '$D(^TMP("DILIST",$J,2)) D  Q
 . S MAGRY(XI)="0^NO Health Summary Types Found in VistA"
 S INFO=^TMP("DILIST",$J,0)
 S XI="" F  S XI=$O(^TMP("DILIST",$J,2,XI)) Q:XI=""  S MAGIEN=^(XI) D
 . S Z=".01",X=^TMP("DILIST",$J,"ID",XI,Z)
 . F  S Z=$O(^TMP("DILIST",$J,"ID",XI,Z)) Q:Z=""  S X=X_"   "_^(Z)
 . S MAGRY(XI)=X_"^"_MAGIEN
 ;
 S MAGRY(0)=$P(INFO,"^")_U_"Found "_$P(INFO,"^")_" entr"_$S((+INFO=1):"y",1:"ies")
 I $P(INFO,"^",3)>0 S MAGRY(0)=MAGRY(0)_" there are more"
 Q
DISSUM(MAGRPTY,DFN) ; Discharge summary
 S MAGRPTY=$NA(^TMP($J,"WSDAT"))
 S @MAGRPTY@(0)="0^NOT YET IMPLEMENTED"
 Q
ERRA S @MAGRPTY@(0)="0^"_$$EC^%ZOSV
 D @^%ZOSF("ERRTN")
 Q
