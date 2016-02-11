SCMCDDR3 ;ALB/ART - FileMan FILE^DIC and UPDATE^DIC DBS Calls for PCMM Web RPCs ;02/04/2015
 ;;5.3;Scheduling;**603**;Aug 13, 1993;Build 79
 ;
 ;This routine was copied from DDR3.
 ;PCMM Web needs a new RPC that has .11 APP PROXY ALLOWED set to Yes
 ;
 ;DDR3 ;ALB/MJK,SF/DCM-FileMan Delphi Components' RPCs ;2/24/98  10:01
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;Public, Supported ICRs
 ; #2053 - Data Base Server API: Editing Utilities (DIE)
 ; #2054 - Data Base Server API: Misc. Library Functions (DILF)
 ;
 QUIT
 ;
FILEC(SCDATA,SCMODE,SCROOT,SCFLAGS,SCIENS) ;  DDR FILER rpc callback
 N SCRTN,SCFDA,SCERR,N,I
 D FDASET(.SCROOT,.SCFDA)
 ; -- set up placeholder DINUM's if any
 ; -- NOTE:  Can't use until multiple arrays can be passed by broker
 I $D(SCROOT("IENs")) M SCIENS=SCROOT("IENs")
 S I="" F  S I=$O(SCIENS(I)) Q:I=""  S SCRTN(+I)=+SCIENS(I)
 IF SCMODE="ADD" D
 . D UPDATE^DIE("","SCFDA","SCRTN","SCERR")
 ELSE  D
 . S SCFLAGS=$S($D(SCFLAGS):SCFLAGS,1:"")
 . D FILE^DIE(SCFLAGS,"SCFDA","SCERR")
 S N=0
 D SET("[Data]")
 ; -- send back info on entry #'s for placeholders
 S I=0 F  S I=$O(SCRTN(I)) Q:'I  D SET("+"_I_","_U_SCRTN(I))
 IF $D(SCERR) D ERROR
 Q
 ;
FDASET(SCROOT,SCFDA) ;
 N SCFILE,SCIEN,SCFIELD,SCVAL,SCERR,I
 S I=0
 F  S I=$O(SCROOT(I)) Q:'I  S X=SCROOT(I) D
 . S SCFILE=$P(X,U)
 . S SCFIELD=$P(X,U,2)
 . S SCIEN=$P(X,U,3)
 . S SCVAL=$P(X,U,4,99)
 . D FDA^DILF(SCFILE,SCIEN_$S($E(SCIEN,$L(SCIEN))'=",":",",1:""),SCFIELD,"",SCVAL,"SCFDA","SCERR")
 Q
 ;
SET(X) ;
 S N=N+1
 S SCDATA(N)=X
 Q
ERROR ;
 D SET("[BEGIN_diERRORS]")
 N A S A=0 F  S A=$O(SCERR("DIERR",A)) Q:'A  D
 . N HD,PARAM,B,C,TEXT,TXTCNT,D,FILE,FIELD,IENS,%
 . S HD=SCERR("DIERR",A)
 . I $D(SCERR("DIERR",A,"PARAM",0)) D
 . . S (B,D)=0 F C=1:1 S B=$O(SCERR("DIERR",A,"PARAM",B)) Q:B=""  D
 . . . I B="FILE" S FILE=SCERR("DIERR",A,"PARAM","FILE")
 . . . I B="FIELD" S FIELD=SCERR("DIERR",A,"PARAM","FIELD")
 . . . I B="IENS" S IENS=SCERR("DIERR",A,"PARAM","IENS")
 . . . S D=D+1,PARAM(D)=B_U_SCERR("DIERR",A,"PARAM",B)
 . S C=0 F  S C=$O(SCERR("DIERR",A,"TEXT",C)) Q:'C  S TEXT(C)=SCERR("DIERR",A,"TEXT",C),TXTCNT=C
 . S HD=HD_U_TXTCNT_U_$G(FILE)_U_$G(IENS)_U_$G(FIELD)_U_$G(D) D SET(HD)
 . S B=0 F  S B=$O(PARAM(B)) Q:'B  S %=PARAM(B) D SET(%)
 . S B=0 F  S B=$O(TEXT(B)) Q:'B  S %=TEXT(B) D SET(%)
 . Q
 D SET("[END_diERRORS]")
 Q
 ;
