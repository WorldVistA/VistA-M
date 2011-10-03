PXAPIEED ;ISL/dee - PCE's API to ask standalone encounter or add then edit it or to delete a standalone ; 8/14/00 2:47pm
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**1,147**;Aug 12, 1996
 Q
 ;
ENCEDIT(WHAT,PACKAGE,SOURCE,DFN,BEGINDT,ENDDT,HLOC,SCREEN,APPOINT,PROMPT,COSTATUS) ;--Ask for encounter the edit it of delete it
 ;
 ; >0           = VISIT IEN
 ; D^Visit IEN  = User selected to delete and the visit ien that was deleted
 ; -1           = nothing was done (user did not select visit or ^-out)
 ; -2^text      = error of some kind^simple text message
 ; -3^text      = error in deleting^simple text message
 ;
 N VISITIEN,PXRESULT,PXRETURN,PXVISIT,PXBEGDT,PXX
 I $G(DFN)<1 S DFN=$$ASKPAT^PXBAPI1()
 Q:DFN<1 -1
 D 2^VADPT I +VADM(6) D  Q:$D(DUOUT)!$D(DIRUT) -1
 . S DIR(0)="E",DIR("A")="Enter RETURN to continue or '^' to exit"
 . S DIR("A",2)="WARNING "_VADM(7) D ^DIR
 S PXBEGDT=$S($$SWITCHD^PXAPI>BEGINDT:$$SWITCHD^PXAPI,1:BEGINDT)
 S VISITIEN=$$VISITLST^PXAPI(DFN,PXBEGDT,ENDDT,HLOC,SCREEN,APPOINT,PROMPT,COSTATUS)
 I $P(VISITIEN,"^",1)="D" D
 . S PXRESULT=$$DELVFILE^PXAPI("ALL",$P(VISITIEN,"^",2),"","",1,1)
 . I PXRESULT=1 S PXRETURN=VISITIEN
 . E  I PXRESULT=0 S PXRETURN="-3^ONLY PARTLY DELETED"
 . E  I PXRESULT=-1 S PXRETURN=-1
 . E  I PXRESULT<-1 S PXRETURN="-3^ERROR IN TRYING TO DELETE"
 E  I VISITIEN>0!(VISITIEN="A") D
 . S PXVISIT=$S(VISITIEN>0:VISITIEN,1:"")
 . S PXRESULT=$$INTV^PXAPI(WHAT,PACKAGE,SOURCE,VISITIEN,$S(VISITIEN="A":HLOC,1:""),DFN,"",$$SWITCHD^PXAPI)
 . I PXRESULT'<0 S PXRETURN=PXVISIT
 . E  I PXRESULT=-1 S PXRETURN=-1
 . E  I PXRESULT<-1 S PXRETURN="-2^ERROR IN TRYING TO DO INTERVIEW"
 E  S PXRETURN=VISITIEN
 Q PXRETURN
 ;
LOPENCED(WHAT,PACKAGE,SOURCE,DFN,BEGINDT,ENDDT,HLOC,SCREEN,APPOINT,PROMPT,COSTATUS) ;
 ;
 ; Returns:
 ;  0           = all oky doky
 ; -1           = nothing was done (user did not select visit or ^-out)
 ; -2^text      = error of some kind^simple text message
 ; -3^text      = error in deleting^simple text message
 ;
 N PXRETURN,PXRESULT
 S PXRESULT=-1
 F  D  Q:PXRETURN<0
 . S PXRETURN=$$ENCEDIT(WHAT,PACKAGE,SOURCE,DFN,BEGINDT,ENDDT,HLOC,SCREEN,APPOINT,PROMPT,COSTATUS)
 . I PXRETURN'<0 S PXRESULT=0
 Q $S(PXRETURN<-1:PXRETURN,1:PXRESULT)
 ;
