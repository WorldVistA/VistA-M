MAGJUTL5 ;WOIFO/JHC - VistARad RPCs ; 15-DEC-2010 6:11 PM
 ;;3.0;IMAGING;**65,76,101,90,115**;Mar 19, 2002;Build 1912;Dec 17, 2010
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
 ; adapted from MAGGTU4
GETVER(SVRVER,SVRTVER,ALLOWCL) ;
 ; The Server Version SVRVER is hardcoded to match the Client
 ; so this Routine must be edited/distributed with a new Client
 ; released Client will have the T version that the server expects
 ;
 ;--- Synchronize the below information with that in MAGJTU4V.
 ;
 S SVRVER="3.0.115",SVRTVER=4  ; <*> Edit this line for each patch/T-version
 ;
 S ALLOWCL="|3.0.101|3.0.90|"  ; back-compatible with P101 & P90 client
 Q
 ;
CHKVER(MAGRY,CLVER,PLC,SVERSION) ;
 ; Input CLVER is the version of the Client
 ;    format: Major.Minor.Patch.Build# (Build #=T-ver) eg 3.0.18.132
 ; 3 possible return codes in MAGRY:
 ;   2^n~msg : Client displays a message and continues
 ;   1^1~msg : Client continues without displaying a message
 ;   0^n~msg : Client displays a message then Aborts
 ; PLC returns 2006.1 pointer
 ;
 S CLVER=$G(CLVER),PLC="",MAGRY=""
 N SV,ST,CV,CT,CP,ALLOWV,TESTFLAG,SVSTAT
 ; SVERSION = Full Server Version -> (3.0.18.132 or 3.0.18); test has 4, release has 3 parts
 ; SV = Server Version -> (3.0.18); only 1st 3 parts
 ; ST = Server T Version -> defined to always match client part-4
 ; CV = Client Version, w/out build #
 ; CT = Client T Version alone
 ; CP = Client Patch alone
 ; ALLOWV = Hard coded string of allowed clients for this KIDS.
 ; TESTFLAG = 1/0  -- 1=Test vs of server code; 0=Release vs
 ;Below is placeholder for future enhancement:
 ;I $P(CLVER,"|",2)="RIV" D  Q
 ;. S MAGJOB("RIV")=1
 ;. ; Allowing |RIV clients always
 ;. S MAGRY="1^1~Allowing Remote Image Connection"
 ;
 I $G(DUZ(2)) S PLC=$$PLACE^MAGBAPI(DUZ(2))
 ;  Quit if we don't have a valid DUZ(2) or valid PLACE: ^MAG(2006.1,PLC)
 I 'PLC S MAGRY="0^4~Error verifying Imaging Site (Place) -- Contact Imaging support." Q
 ;
 D GETVER(.SV,.ST,.ALLOWV)
 S CLVER=$P(CLVER,"|")
 S CV=$P(CLVER,".",1,3),CT=+$P(CLVER,".",4),CP=+$P(CLVER,".",3)
 ;
 D VERSTAT(.SVSTAT,SV)
 I 'SVSTAT S MAGRY(0)=SVSTAT Q  ; KIDS status for this version indeterminate
 S TESTFLAG=(+SVSTAT=1)
 S SVERSION=SV
 I TESTFLAG S SVERSION=SV_"."_ST
 ; Check Version differences:
 I (CV'=SV) D  Q
 . I '(ALLOWV[("|"_CV_"|")) D  Q
 . . S MAGRY="0^4~VistARad Workstation software version "_CLVER_" is not compatible with the VistA server version "_SVERSION_".  Contact Imaging support. (CNA)"
 . ; Warn the Client, allow to continue
 . I TESTFLAG S MAGRY="2^3~VistARad Workstation software version "_CLVER_" is running with VistA server TEST Version "_SVERSION_" --  VistARad will Continue, but contact Imaging Support if problems occur. (Pdif)"
 . E  S MAGRY="2^3~VistARad Workstation software version "_CLVER_" is running with VistA server Version "_SVERSION_" --  VistARad will Continue, but contact Imaging Support to install Released Version. (RPdif)"
 . Q
 ; Versions are the Same: If T versions are not, warn the Client if needed.
 ; Released Client (of any version) will have the T version that the server
 ; expects, and no warning will be displayed.
 I CT,(CT'=ST) D  Q
 . I TESTFLAG S MAGRY="2^3~VistARad Workstation software vs. "_CLVER_" is running with VistA server TEST vs. "_SVERSION_" --  VistARad will Continue, but contact Imaging Support " D
 . . I CT<ST S MAGRY=MAGRY_"to install updated client software.  (Tdif-1)"
 . . E  S MAGRY=MAGRY_"to update the Server software.  (Tdif-2)"
 . E  S MAGRY="2^3~VistARad Workstation software vs. "_CLVER_" is running with VistA server vs. "_SVERSION_" --  VistARad will Continue, but contact Imaging Support to install Released Version. (RVdif)"
 . Q
 ; Client and Server Versions are the same
 S MAGRY="1^1~Version Check OK. Server: "_SVERSION_" Client: "_CLVER Q
 Q
 ;
P32STOP(RET) ; logic to indicate P32 should no longer function, once the RELEASED P76 is installed
 ; This is invoked from magjutl3, P76 version, if a P32 client is launched
 ; RET=1/0 ^ text -- 0 = OK to run P32; 1 = Not OK
 N SV,ST,ALLOWV,SVSTAT,RELEASED
 S RET="0^P32 supported" ; init return to allow p32 to function
 D GETVER(.SV,.ST,.ALLOWV)
 D VERSTAT(.SVSTAT,SV)
 I 'SVSTAT S RET="0^Error, but on side of caution, allow running." Q  ; KIDS status for this version indeterminate
 S RELEASED=(+SVSTAT=2)
 I RELEASED!(SV'="3.0.76") S RET="1^P32 support over"  ; don't allow P32 to function
 Q
 ;
VERSTAT(MAGRY,MAGVER) ;
 ; Returns the status of an Imaging Version
 ; Input:
 ;   MAGVER - Version number in format  MAG*3.0*59 or 3.0.59
 ; Return: MAGRY = 0/1/2 -- see below; 0: abort; else, OK to proceed
 ;
 N VERI,TVER,MAGERR
 I +MAGVER S MAGVER="MAG*"_$P(MAGVER,".",1,2)_"*"_$P(MAGVER,".",3)
 S VERI=$$FIND1^DIC(9.6,"","O",MAGVER,"","","MAGERR")
 I 'VERI S MAGRY="0^4~There is No KIDs Install record."
 E  D
 . S TVER=$$GET1^DIQ(9.6,VERI_",","ALPHA/BETA TESTING")
 . I TVER="YES" S MAGRY="1^Alpha/Beta Version"
 . E  I TVER="NO" S MAGRY="2^Released Version"
 . E  S MAGRY="0^4~KIDs Install Status is unknown--contact Customer Support."
 Q       ;
END ;
