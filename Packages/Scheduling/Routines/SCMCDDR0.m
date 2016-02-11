SCMCDDR0 ;ALB/ART - FileMan FIND^DIC DBS Call for PCMM Web RPCs ;01/22/2014
 ;;5.3;Scheduling;**603**;Aug 13, 1993;Build 79
 ;
 ;This routine was copied from DDR0.  PCMM/R needs a new RPC that has .11 APP PROXY ALLOWED set to Yes
 ;
 ;Public, Supported ICRs
 ; #2051 - Database Server API: Lookup Utilities (DIC)
 ;
 ;DDR0 ;SF/DCM-FileMan Delphi Components' RPCs ;4/28/98  10:52
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 QUIT
 ;
FINDC(SCDATA,SC) ; -- broker callback to get list data
 N SCFILE,SCIENS,SCFLDS,SCFLAGS,SCVAL,SCMAX,SCXREF,SCSCRN,SCID,SCROOT,SCERR,SCRSLT,SCOPT,SCOUT,DIERR
 ; -- parse array to parameters
 D PARSE(.SC)
 S SCOUT=""
 D FIND^DIC(SCFILE,SCIENS,SCFLDS,SCFLAGS,SCVAL,SCMAX,SCXREF,SCSCRN,SCID,SCOUT,"SCERR")
 I $G(SCFLAGS)["P" D
 . Q:'$D(^TMP("DILIST",$J))
 . N COUNT S COUNT=^TMP("DILIST",$J,0) Q:'COUNT  D 1
 . I XWBAPVER>1 S ^(.3)="[MAP]",^TMP("DILIST",$J,.4)=^TMP("DILIST",$J,0,"MAP")
 . K ^TMP("DILIST",$J,0) S ^(.5)="[BEGIN_diDATA]",^(COUNT+1)="[END_diDATA]"
 . Q
 I $G(SCFLAGS)'["P" D
 . Q:'$D(^TMP("DILIST",$J))
 . N COUNT S COUNT=^TMP("DILIST",$J,0) Q:'COUNT
 . D 1,UNPACKED
 . Q
 D 3,4
 Q
1 Q:'$P(COUNT,U,3)
 S ^TMP("DILIST",$J,.1)="[Misc]",^(.2)="MORE"
 Q
3 I $D(DIERR) D ERROR
 Q
4 S SCDATA=$NA(^TMP("DILIST",$J))
 Q
PARSE(SC) ; -- array parsing
 S SCFILE=$G(SC("FILE"))
 S SCIENS=$G(SC("IENS"))
 S SCFLDS=$G(SC("FIELDS"))
 S SCFLAGS=$G(SC("FLAGS"))
 S SCMAX=$G(SC("MAX"),"*")
 S SCVAL=$G(SC("VALUE"))
 S SCXREF=$G(SC("XREF"))
 S SCSCRN=$G(SC("SCREEN"))
 S SCID=$G(SC("ID"))
 S SCROOT=$G(SC("ROOT"))
 S SCOPT=$G(SC("OPTIONS"))
 Q
ERROR ;
 N I S I=1
 D Z("[BEGIN_diERRORS]")
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
 . S HD=HD_U_TXTCNT_U_$G(FILE)_U_$G(IENS)_U_$G(FIELD)_U_$G(D) D Z(HD)
 . S B=0 F  S B=$O(PARAM(B)) Q:'B  S %=PARAM(B) D Z(%)
 . S B=0 F  S B=$O(TEXT(B)) Q:'B  S %=TEXT(B) D Z(%)
 . Q
 D Z("[END_diERRORS]")
 Q
Z(%) ;
 S ^TMP("DILIST",$J,"ZERR",I)=%,I=I+1
 Q
UNPACKED ;
 K ^TMP("DILIST",$J,0)
 S ^TMP("DILIST",$J,.5)="[BEGIN_diDATA]" K ^TMP("DILIST",$J,1)
 S ^TMP("DILIST",$J,2,.1)="BEGIN_IENs",^(COUNT+1)="END_IENs"
 I SCFLDS]"",$D(^TMP("DILIST",$J,"ID")) D
 . N Z,FLD,FLDCNT S Z=0,FLD="",FLDCNT=0
 . F  S Z=$O(^TMP("DILIST",$J,"ID",1,Z)) Q:'Z   S FLD=FLD_Z_";",FLDCNT=FLDCNT+1
 . Q:'FLDCNT
 . S ^TMP("DILIST",$J,"ID",0)="BEGIN_IDVALUES",^(.1)=FLD_U_FLDCNT,^(COUNT+1)="END_IDVALUES"
 E  D
 . N Z S Z=0 F  S Z=$O(^TMP("DILIST",$J,"ID",Z)) Q:'Z  K ^TMP("DILIST",$J,"ID",Z)
 I $G(SCOPT)["WID",$D(^TMP("DILIST",$J,"ID","WRITE")) D
 . N Z,N,I,IEN,WIDCNT S (N,I)=0
 . M Z=^TMP("DILIST",$J,"ID","WRITE") K ^TMP("DILIST",$J,"ID","WRITE")
 . S ^TMP("DILIST",$J,"ID","WID",0)="BEGIN_WIDVALUES",N=N+1
 . F  S I=$O(Z(I)) Q:'I  S IEN=$G(^TMP("DILIST",$J,2,I)) D
 . . N J S (J,WIDCNT)=0 F  S J=$O(Z(I,J)) Q:'J  S WIDCNT=WIDCNT+1
 . . S ^TMP("DILIST",$J,"ID","WID",N)="WID"_U_IEN_U_WIDCNT,N=N+1
 . . N J S J=0 F J=1:1:WIDCNT S ^TMP("DILIST",$J,"ID","WID",N)=Z(I,J),N=N+1
 . S ^TMP("DILIST",$J,"ID","WID",N)="END_WIDVALUES"
 I $G(SCOPT)'["WID" K ^TMP("DILIST",$J,"ID","WRITE")
 S ^TMP("DILIST",$J,"IDZ")="[END_diDATA]"
 Q
