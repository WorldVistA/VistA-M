RMPVDRV ; OIT/JDA - SCAMP runtime support; Nov 17, 2024@23:35:37
 ;;1.0;PROSTHETICS VISION 4 SIGHT II;**2**;Jan 31, 2025;Build 38
 ;
 Q
RUN(CALL,DRVNAME) ;primary entry point
 S $EC=""
 S ^TMP($J,"RMPV","DRVNAME")=DRVNAME
 N TMPFILE,OLDIO
 S OLDIO=$IO
 I $G(^TMP($J,"RMPV","SILENT"),1) S IOP="NULL",%ZIS=0 D ^%ZIS I '$G(POP,1) U IO
 D INIT^@DRVNAME
 D  ; scope variables
 . ;N (DUZ,CALL)
 .N %request,%response,%session,DFN,DRVNAME,FILE,OLDIO,REQUEST,SUSP,U,XX,pX,responses,tRedirected ; Protect %response
 .N response,vArray,iter,request,pResponse,element,I,RMPR60,ARG
 .;N INC,REQ,RESP,ARY ;testing only
 .S IOF="""""",IOM=80,U="^"
 .D @CALL
 U OLDIO
 Q
HANDLE(FROMEREF) ; handle special calls like FileMan, etc.
 N RMPVREF S RMPVREF=$NA(^(0)) ; remember naked reference
 N CALLBACK S CALLBACK=$G(^TMP($J,"RMPV","CB",FROMEREF))
 I CALLBACK'="" D @CALLBACK
 I $D(@RMPVREF) ; bring back old naked reference
 Q
WRITECTL(FROMEREF,ARG) ; Write control characters, like 'W !' or 'W $2'
 D CALLIO("WRITECTL")
 Q
WRITEIND(FROMEREF,ARG) ; Write indirect arg, like 'W @VAR'
 D CALLIO("WRITEIND")
 Q
WRITE(FROMEREF,ARG) ; Write regular, like 'W "prompt"' or 'W VAR'
 D CALLIO("WRITE")
 Q
READCTL(FROMEREF,ARG) ; Read control characters, like 'R !'
 D CALLIO("READCTL")
 Q
READIND(FROMEREF,ARG) ; Write indirect arg, like 'R @VAR'
 D CALLIO("READIND")
 Q
READPMT(FROMEREF,ARG) ; Read statements, like 'R "prompt:"'
 D CALLIO("READPMT")
 Q
READ(FROMEREF,ARG) ; Read statements, other
 S ARG="" ;  TODO - handle unhandled reads
 D CALLIO("READ")
 Q
CALLIO(WHAT) ; Input/output handler
 N RMPVREF S RMPVREF=$NA(^(0)) ; remember naked reference
 N CALLBACK S CALLBACK="%"_WHAT_"^"_^TMP($J,"RMPV","DRVNAME")
 D:$L($T(@CALLBACK)) @(CALLBACK_"(FROMEREF,.ARG)")
 I $D(@RMPVREF) ; bring back old naked reference
 Q
