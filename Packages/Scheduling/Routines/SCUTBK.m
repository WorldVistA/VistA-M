SCUTBK ;ALB/MJK - Scheduling Broker Utilities ;[ 03/21/95  4:13 PM ]
 ;;5.3;Scheduling;**41,130**;AUG 13, 1993
 ;
 Q
 ;
CHK ; -- all broker callbacks pass thru here
 Q
 ;
LISTC(SCDATA,SC) ; -- broker callback to get list data
 N SCFILE,SCIENS,SCFIELDS,SCMAX,SCFROM,SCPART,SCXREF,SCREEN,SCID,SCVAL,SCROOT,SCERR,SCRSLT,SCFLD
 D CHK
 ; -- parse array to parameters
 D PARSE(.SC)
 S SCFLAGS=$G(SCFLAGS)_"PS"
 ;
 ; -- get specific field criteria  - screen code (below) left as reminder
 ;IF $G(SC("DDFILE")),$G(SC("DDFIELD")),$D(^DD(SC("DDFILE"),SC("DDFIELD"),12.1)) D
 ;. N DIC X ^(12.1) S:$D(DIC("S")) SCREEN=DIC("S")
 ;
 ; -- need to get from kernel broker somehow...
 D TMP
 ;
 D LIST^DIC(SCFILE,SCIENS,SCFIELDS,SCFLAGS,SCMAX,.SCFROM,SCPART,SCXREF,SCREEN,SCID,"^TMP(""SCRSLT"",$J)","SCERR")
 ;
 N Y,I,N
 ;
 S N=0
 IF $G(SCFROM)]"" D
 . D SET("[Misc]")
 . D SET("MORE"_U_SCFROM_U_SCFROM("IEN"))
 ;
 D SET("[Data]")
 S I=0 F  S I=$O(^TMP("SCRSLT",$J,"DILIST",I)) Q:'I  D SET(^TMP("SCRSLT",$J,"DILIST",I,0))
 ;
 IF $D(SCERR) D
 . D SET("[Errors]")
 ;
 M SCDATA=Y
 Q
 ;
SET(X) ;
 S N=N+1
 S Y(N)=X
 Q
 ;
PARSE(SC) ; -- array parsing
 S SCFILE=$G(SC("FILE"))
 S SCIENS=$G(SC("IENS"))
 S SCFIELDS=$G(SC("FIELDS"))
 S SCFLAGS=$G(SC("FLAGS"))
 S SCMAX=$G(SC("MAX"),"*")
 M SCFROM=SC("FROM")
 S SCPART=$G(SC("PART"))
 S SCXREF=$G(SC("XREF"))
 S SCREEN=$G(SC("SCREEN"))
 S SCID=$G(SC("ID"))
 S SCROOT=$G(SC("ROOT"))
 ; -- for find
 S SCVAL=$G(SC("VALUE"))
 Q
 ;
FILEC(SCDATA,SCMODE,SCROOT,SCIENS) ;
 N SCRTN,SCFDA,SCERR,N,I
 D CHK
 D FDASET(.SCROOT,.SCFDA)
 ; -- set up placeholder DINUM's if any
 ; -- NOTE:  Can't use until multiple arrays can be passed by broker
 ;S I="" F  S I=$O(SCIENS(I)) Q:I=""  S SCRTN(+I)=+SCIENS(I)
 IF SCMODE="ADD" D
 . D UPDATE^DIE("","SCFDA","SCRTN","SCERR")
 ELSE  D
 . D FILE^DIE("","SCFDA","SCERR")
 S N=0
 ;
 D SETF("[Data]")
 ; -- send back info on entry #'s for placeholders
 S I=0 F  S I=$O(SCRTN(I)) Q:'I  D SETF("+"_I_U_SCRTN(I))
 ;
 IF $D(SCERR) D
 . D SETF("[Errors]")
 . D SETF("An error has occurred.")
 Q
 ;
SETF(X) ;
 S N=N+1
 S SCDATA(N)=X
 Q
 ;
FDASET(SCROOT,SCFDA) ;
 N SCFILE,SCIEN,SCFIELD,SCVAL,SCERR,I
 ;
 S I=0
 F  S I=$O(SCROOT(I)) Q:'I  S X=SCROOT(I) D
 . S SCFILE=$P(X,U)
 . S SCFIELD=$P(X,U,2)
 . S SCIEN=$P(X,U,3)
 . S SCVAL=$P(X,U,4)
 . D FDA^DILF(SCFILE,SCIEN_",",SCFIELD,"",SCVAL,"SCFDA","SCERR")
 Q
 ;
TMP ; -- temporary envrionment variables sets until kernel tools arrives
 IF '$G(DUZ) D
 . S DUZ=.5,DUZ(0)="@",U="^",DTIME=300
 . D NOW^%DTC S DT=X
 Q
 ;
VALC(SCDATA,SC) ; -- calls Database Validator
 N SCFILE,SCIENS,SCFIELD,SCVALUE,SCVAL,SCRSLT,SCERR
 D CHK
 S SCFLAGS="E"
 S SCFILE=$G(SC("FILE"))
 S SCIENS=$G(SC("IENS"))
 S SCFIELD=$G(SC("FIELD"))
 S SCVAL=$G(SC("VALUE"))
 ;
 ; -- need to get from kernel broker somehow...
 D TMP
 ;
 D VAL^DIE(SCFILE,SCIENS,SCFIELD,SCFLAGS,SCVAL,.SCRSLT,"","SCERR")
 ;
 N Y,N
 S N=0
 D SET("[FILLER]")
 D SET("[Data]")
 D SET($G(SCRSLT,U))
 D SET($G(SCRSLT(0)))
 ;
 IF $D(SCERR) D
 . D SET("[Errors]")
 M SCDATA=Y
 Q
