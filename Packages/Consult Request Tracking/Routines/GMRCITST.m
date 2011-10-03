GMRCITST ;SLC/JFR - test IFC setup ; 11/30/01 10:30
 ;;3.0;CONSULT/REQUEST TRACKING;**22**;DEC 27, 1997
EN ; start here
 ;Prompt for choice of consult service or procedure
 ;route to the ROUTING FACILITY and see if it's a GO
 N DIR,X,Y,DIROUT,DIRUT,DTOUT
 S DIR(0)="SO^P:procedure;C:consult service"
 S DIR("A")="Would you like to test a procedure or consult service"
 D ^DIR
 I $D(DIRUT) Q
 W !!
 D RUN(Y)
 W !!
 K DIR,X,Y
 S DIR(0)="YA",DIR("A")="Would you like to test another implementation? "
 D ^DIR
 I Y=1 G EN
 Q
RUN(GMRCTYP) ; check the procedure or service for proper setup
 N DIR,X,Y,DIROUT,DIRUT,DTOUT,SERV,PROC,GMRC773,HLL,LINK,HL
 I GMRCTYP="P" D
 . S DIR(0)="PA^123.3:EMQ"
 . S DIR("A")="Select the GMRC Procedure that you'd like to test: "
 I GMRCTYP="C" D
 . S DIR(0)="PA^123.5:EMQ"
 . S DIR("A")="Select the Consult service that you'd like to test: "
 . S DIR("A")="Select the Consult service that you'd like to test: "
 D ^DIR
 I $G(Y)'>0 W !,"No procedure or service selected." Q
 I GMRCTYP="P" S PROC=+Y I '$$TSTPROC(PROC) Q
 I GMRCTYP="C" S SERV=+Y I '$$TSTSERV(SERV) Q
 ;
 ;send msg
 K ^TMP("HLS",$J)
 D INIT^HLFNC2("GMRC IFC ORM TEST",.HL)
 S ^TMP("HLS",$J,1)=$$ORCTST^GMRCISG1
 I $G(PROC) S ^TMP("HLS",$J,2)=$$OBRTST^GMRCISG1(PROC,"P")
 I $G(SERV) S ^TMP("HLS",$J,2)=$$OBRTST^GMRCISG1(SERV,"C")
 S LINK=$$ROUTE($S($G(PROC):PROC_";GMR(123.3,",1:SERV_";GMR(123.5,"))
 I '$L(LINK) D  Q  ;problem with the HL LOGICAL LINK
 . W !!,"The proper HL LOGICAL link could not be located!"
 . W !,"Can't continue to test.  Contact IRM."
 S HLL("LINKS",1)=LINK
 W !!,"   attempting to connect to remote system...",!
 D DIRECT^HLMA("GMRC IFC ORM TEST","GM",1,.GMRC773)
 I +$P(GMRC773,U,2) D  Q  ;problem with the HL link 
 . W !,"There was a problem communicating with the remote site."
 . W !,"IRM may need to check the HL7 communications."
 N HLNODE,SEG,I  ;process response
 K ^TMP("GMRCIF",$J)
 F I=1:1 X HLNEXT Q:HLQUIT'>0  D
 .S ^TMP("GMRCIF",$J,$P(HLNODE,"|"))=$E(HLNODE,5,999)
 I $P(^TMP("GMRCIF",$J,"MSA"),"|")="AA" D
 . W !!,"Congratulations!  You're configured correctly."
 I $P(^TMP("GMRCIF",$J,"MSA"),"|")="AR" D
 . N ERR,GMRCER
 . W !!,"There is an implementation problem. The remote site indicated:"
 . S ERR=$P(^TMP("GMRCIF",$J,"MSA"),"|",3),GMRCER=+ERR
 . I ERR S ERR="ERR"_ERR_"^GMRCIUTL" S ERR=$T(@ERR),ERR=$P(ERR,";",2)
 . W !,?5,ERR_$S(+GMRCER:" ("_GMRCER_")",1:" (HL7 ERROR)")
 K ^TMP("GMRCIF",$J),^TMP("HLS",$J),HLNEXT,HLQUIT
 Q
 ;
TSTPROC(GMRCPR) ;check procedure and make sure it has required fields for IFC
 ; Input:
 ;  GMRCPR = ien from file 123.3
 ;
 ; Output:
 ;  1 = configured correctly
 ;  0 = one or more fields missing
 ; 
 I '$D(^GMR(123.3,GMRCPR,"IFC")) D  Q 0
 . W !!,"This procedure is not configured for Inter-facility purposes."
 I '$P(^GMR(123.3,GMRCPR,"IFC"),U) D  Q 0
 . W !!,"This procedure has no IFC ROUTING FACILITY entered."
 I '$L($P(^GMR(123.3,GMRCPR,"IFC"),U,2)) D  Q 0
 . W !!,"This procedure has no IFC REMOTE NAME entered."
 Q 1
 ;
TSTSERV(GMRCSS) ;check service and make sure it has required fields for IFC
 ; Input:
 ;  GMRCSS = ien from file 123.5
 ;
 ; Output:
 ;  1 = configured correctly
 ;  0 = one or more fields missing
 ; 
 I '$D(^GMR(123.5,GMRCSS,"IFC")) D  Q 0
 . W !!,"This service is not configured for Inter-facility purposes."
 I '$P(^GMR(123.5,GMRCSS,"IFC"),U) D  Q 0
 . W !!,"This service has no IFC ROUTING FACILITY entered."
 I '$L($P(^GMR(123.5,GMRCSS,"IFC"),U,2)) D  Q 0
 . W !!,"This service has no IFC REMOTE NAME entered."
 Q 1
 ;
ROUTE(GMRCOI) ; get the right HL link for testing
 ;Input: 
 ;  GMRCOI = ien from file 123.3 or 123.5 in var ptr format
 ;
 ;Output:
 ;   the logical link to send the message to in format
 ;     "GMRC IFC SUBSC^VHAHIN"
 ;
 N SITE,GMRCLINK,STA
 I '$G(GMRCOI) Q ""
 I $P(GMRCOI,";",2)[123.3 D
 . S SITE=$P($G(^GMR(123.3,+GMRCOI,"IFC")),U)
 I $P(GMRCOI,";",2)[123.5 D
 . S SITE=$P($G(^GMR(123.5,+GMRCOI,"IFC")),U)
 I '$G(SITE) Q ""
 S STA=$$STA^XUAF4(SITE)
 I '$L(STA) Q ""
 D LINK^HLUTIL3(STA,.GMRCLINK,"I")
 S GMRCLINK=$O(GMRCLINK(0)) I 'GMRCLINK Q "" ; no link for that site
 S GMRCLINK=GMRCLINK(GMRCLINK) I '$L(GMRCLINK) Q "" ;no link name
 Q "GMRC IFC SUBSC^"_GMRCLINK
