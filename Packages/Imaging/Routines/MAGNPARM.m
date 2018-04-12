MAGNPARM ;WOIFO/NST - Utilities for RPC calls ; 10 Aug 2017 4:16 PM
 ;;3.0;IMAGING;**185**;Mar 19, 2002;Build 92;Aug 02, 2012
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
 ;*****  Changes value for named parameter
 ;       
 ; RPC: MAGN PARAM SET LIST
 ; 
 ; Input Parameters
 ; ================
 ; 
 ; [MAGPARAM("PARAM")]  - default "MAG USER PREF"
 ; [MAGPARAM("ENTITY")] - default "USR.`DUZ"
 ; [MAGPARAM("USER")]   - default DUZ 
 ;  MAGPARAM("INSTANCEnnn")
 ;  MAGPARAM("VALUEnnn")
 ;
 ; Return Values
 ; =============
 ; if error MAGRY = Failure status ^ Error message^
 ; if success MAGRY = Success status
 ;
SPARLIST(MAGRY,MAGPARAM) ; RPC [MAGN PARAM SET LIST]
 N PARAM,VALUE,ENT,INST,ERR,USR,II,JJ
 ;
 K MAGRY
 S ERR=0
 S PARAM=$G(MAGPARAM("PARAM"),"MAG USER PREF")
 S USR=$G(MAGPARAM("USER"),DUZ)
 S ENT=$G(MAGPARAM("ENTITY"),"USR.`"_USR)
 S II="INSTANCE"
 F  S II=$O(MAGPARAM(II)) Q:II'["INSTANCE"  D  Q:ERR
 . S INST=MAGPARAM(II)
 . Q:INST=""
 . D EN^XPAR(ENT,PARAM,INST,"@",.ERR)  ; clean up first
 . S JJ="VALUE"_$P(II,"INSTANCE",2)
 . S VALUE=$G(MAGPARAM(JJ))
 . I VALUE="@" Q  ; we already deleted the value
 . F  S JJ=$O(MAGPARAM(JJ)) Q:JJ=""  D
 . . S VALUE(+$P(JJ,"_",2),0)=MAGPARAM(JJ)  ; Add word-processing text if any
 . . Q
 . D EN^XPAR(ENT,PARAM,INST,.VALUE,.ERR)
 . Q
 I ERR=0 S MAGRY=$$SETOKVAL^MAGNU002("")
 E  S MAGRY=$$SETERROR^MAGNU002($P(ERR,"^",2))
 Q
 ;
 ;*****   Get a parameter list values
 ;       
 ; RPC: MAGN PARAM GET LIST
 ; 
 ; Input Parameters
 ; ================
 ; 
 ; [MAGPARAM("PARAM")] - parameter name - default "MAG USER PREF"
 ; [MAGPARAM("FORMAT")]  - I|Q|E|B - default "I" (internal)
 ; [MAGPARAM("ENTITY")]  - Default "ALL"
 ; 
 ; Return Values
 ; =============
 ; if error MAGRY(0) = Failure status ^ Error message^
 ; if success MAGRY(0) = Success status ^ ^counter
 ;            MAGRY(1..n) = instance ^ value
 ;
GPARLIST(MAGRY,MAGPARAM) ; RPC [MAGN PARAM GET LIST] 
 N INST,CNT,ERR,TMP,PARAM,FMT,ENT
 ;
 K MAGRY
 S PARAM=$G(MAGPARAM("PARAM"),"MAG USER PREF")
 S FMT=$G(MAGPARAM("FORMAT"),"I")
 S ENT=$G(MAGPARAM("ENTITY"),"ALL")
 D GETLST^XPAR(.TMP,ENT,PARAM,FMT,.ERR)
 ; 
 I $G(ERR) S @MAGRY@(0)=$$SETERROR^MAGNU002($P(ERR,"^",2)) Q
 ;
 S CNT=0
 S INST=""
 F  S INST=$O(TMP(INST)) Q:INST=""  D
 . S CNT=CNT+1,MAGRY(CNT)=INST_"^"_TMP(INST)
 . Q
 S MAGRY(0)=$$SETOKVAL^MAGNU002(CNT)
 Q
 ;
 ;*****   Get a value of an instance
 ;       
 ; RPC: MAGN PARAM GET VALUE
 ; 
 ; Input Parameters
 ; ================
 ; 
 ; [MAGPARAM("PARAM")] - parameter name - default "MAG USER PREF"
 ; [MAGPARAM("ENTITY")]  - Default "ALL"
 ;  MAGPARAM("INSTANCE")  
 ; 
 ; Return Values
 ; =============
 ; if error MAGRY(0) = Failure status ^ Error message^
 ; if success MAGRY(0) = Success status ^ ^ value
 ;            MAGRY(1..n) = value line 1..n
GET1(MAGRY,MAGPARAM) ; RPC [MAGN PARAM GET VALUE]
 N I,OUT,PARAM,ENT,INST,ERR
 ;
 K MAGRY
 S PARAM=$G(MAGPARAM("PARAM"),"MAG USER PREF")
 S ENT=$G(MAGPARAM("ENTITY"),"ALL")
 S INST=$G(MAGPARAM("INSTANCE"),"")
 I INST="" S MAGRY(0)=$$SETERROR^MAGNU002("The Instance value is missing") Q 
 D GETWP^XPAR(.OUT,ENT,PARAM,INST,.ERR)
 I $G(ERR) S MAGRY(0)=$$SETERROR^MAGNU002($G(ERR)) Q
 I '$D(OUT) S MAGRY(0)=$$SETERROR^MAGNU002("Instance not found") Q 
 S MAGRY(0)=$$SETOKVAL^MAGNU002($G(OUT))
 S I=""
 F  S I=$O(OUT(I)) Q:'I  D
 . S MAGRY(I)=$G(OUT(I,0))
 . Q
 Q
