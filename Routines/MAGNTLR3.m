MAGNTLR3 ;WOIFO/NST - TeleReader Configuration  ; 24 Aug 2010 2:39 PM
 ;;3.0;IMAGING;**106**;Mar 19, 2002;Build 2002;Feb 28, 2011
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
 ;***** Check for thin client settings by User (DUZ)
 ; RPC: MAG3 TR THIN CLIENT ALLOWED 
 ;
 ; Return Values
 ; =============
 ; if error MAGRY = first "^" piece is zero if error occurs
 ; if success MAGRY = "1^0|1" - 0 - not allowed; 1 - allowed
 ;                              
TCALLOW(MAGRY) ; RPC [MAG3 TR THIN CLIENT ALLOWED]
 ; USR^SRV^DIV^SYS
 N SRV,RESULT
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGGTERR"
 ;
 S MAGRY=0
 S SRV=$$GET1^DIQ(200,DUZ,29,"I") ; Get service
 S RESULT=+$$GET^XPAR("USR^SRV.`"_SRV_"^DIV^SYS","MAG TR ALLOW THIN CLIENT",,"I") ; IA# 2263
 S MAGRY=1_"^"_RESULT
 Q
