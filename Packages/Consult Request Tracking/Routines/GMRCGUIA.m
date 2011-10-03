GMRCGUIA ;SLC/DCM,JFR - File Consult actions from GUI ;7/8/03 07:36
 ;;3.0;CONSULT/REQUEST TRACKING;**1,4,12,15,22,35,64**;DEC 27, 1997;Build 20
 ;
 ; This routine invokes IA #2638,#2926
 ;
NEW(DFN,GMRCDA,GMRCLOC,GMRCTYPE,GMRCSVC,GMRCPROV,GMRCURG,GMRCPLI,GMRCNP,GMRCATN,GMRCINOT,GMRCDIAG,GMRCRFQ) ;Add a new consult for a patient.
 ;DFN=Patient ^DPT( file number
 ;GMRCRFQ=Reason For Request, why the consult is being ordered. Passed in as
 ;    an array
 ;GMRCDIAG=Povisional diagnosis; what is suspected to be the problem
 ;GMRCTYPE=Request type -Consult or Procedure
 ;GMRCLOC=Patient location.
 ;GMRCDA=Date Time of Request
 ;GMRCSVC=To Service; consulting service
 ;GMRCLOC=Hospital Location ordering consult
 ;GMRCPR=If a procedure, the procedure ordered (pointer to file 101)
 ;GMRCURG=Urgency of request (stat, routine, etc) from file 101
 ;GMRCPLI=Place of consultation (bedside, consultants choice, etc.) from file 101
 ;GMRCPROV=Sending Provider
 ;GMRCATN=if consult is to go to a specific provider, this provider is identified here.
 ;GMRCINOT=Service provided as Inpatient or Outpatient
 N DIC,DLAYGO,Y,DIE,GMRCADUZ,X,GMRCO,DR
 S DIC="^GMR(123,",DIC(0)="L",X="""N""",DLAYGO=123 D ^DIC K DLAYGO
 S (DA,GMRCO)=+Y,GMRCSTS=5,GMRCA=1,DIE=DIC
 L +^GMR(123,GMRCO):$S($G(DILOCKTM)>0:DILOCKTM,1:5)
 S DR=".02////^S X=DFN;.04////^S X=GMRCLOC;1////^S X=GMRCSVC;3////^S X=GMRCDA;4////^S X=GMRCPR;5////^S X=GMRCURG;6////^S X=GMRCPLI"_$S(GMRCATN]"":"7////^S X=GMRCATN",1:"")
 D ^DIE
 S DR="8////^S X=GMRCSTS;9////^S X=GMRCA;10////^S X=GMRCPROV;11////^S X=GMRCATN;13////^S X=GMRCTYPE;14////^S X=GMRCINOT"_$S($D(GMRCDIAG):"30:////^S X=GMRCDIAG",1:"")
 D ^DIE L -^GMR(123,GMRCO)
 I $O(GMRCRFQ(0)) D REASON^GMRCGUIB(GMRCO,GMRCRFQ,GMRCDA)
 D EN^GMRCHL7(DFN,GMRCDA,GMRCTYPE,$G(GMRCRB),"NW",DUZ,$G(VISIT),"")
 D EXIT
 Q
 ;
RC(GMRCO,GMRCORNP,GMRCAD,GMRCMT,GMRCDUZ) ;Receive consult into service
 ;
 ;Input variables:
 ;GMRCO - The internal file number of the consult from File 123
 ;GMRCORNP - Name of the person who actually 'Received'the consult 
 ;GMRCDUZ - DUZ of person entering the consult as being 'RECEIVED'.
 ;GMRCAD - Actual date time that consult was received into the service.
 ;GMRCMT - array of comments if entered (by reference)
 ;   ARRAY(1)="FIRST LINE OF COMMENT"
 ;   ARRAY(2)="SECOND LINE OF COMMENT"
 ;GMRCDUZ - DUZ of person entering the consult as being 'RECEIVED'
 ;
 ;Output:
 ;GMRCERR - Error Condition Code: 0 = NO error, 1=error
 ;GMRCERMS - Error message or null
 ;  returned as GMRCERR^GMRCERMS
 ;
 N DFN,GMRCSTS,GMRCNOW,GMRCERR,GMRCERMS
 S GMRCERR=0,GMRCERMS="",GMRCNOW=$$NOW^XLFDT
 S:$G(GMRCAD)="" GMRCAD=GMRCNOW
 S:'$G(GMRCDUZ) GMRCDUZ=DUZ
 S DFN=$P($G(^GMR(123,GMRCO,0)),"^",2) I DFN="" S GMRCERR="1",GMRCERMS="Not A Valid Consult - File Not Found." D EXIT Q GMRCERR_"^"_GMRCERMS
 S GMRCSTS=6,GMRCA=21
 D STATUS^GMRCP I $D(GMRCQUT) D EXIT Q GMRCERR_"^"_GMRCERMS
 I '$O(GMRCMT(0)) D AUDIT^GMRCP
 I $O(GMRCMT(0)) D
 . S DA=$$SETDA^GMRCGUIB
 . D SETCOM^GMRCGUIB(.GMRCMT,GMRCDUZ)
 D EN^GMRCHL7(DFN,GMRCO,"","","SC",GMRCORNP,"","")
 D EXIT
 Q GMRCERR_"^"_GMRCERMS
 ;
DC(GMRCO,GMRCORNP,GMRCAD,GMRCACTM,GMRCOM) ;Discontinue or Deny a consult
 ;
 ;Input variables:
 ;GMRCO - Internal file number of consult from File 123
 ;GMRCORNP - Provider who Discontinued or Denied consult
 ;GMRCAD - FM date/time of actual activity.
 ;GMRCACTM - set to "DY" if 'CANCELLED'(old DENY)
 ;           set to "DC" if consult is Discontinued 
 ;GMRCOM - Comment array containing explanation of action
 ;    Passed by reference in the following form :
 ;     ARRAY(1)="xxx xxx xxx"
 ;     ARRAY(2)="XXX XXX"
 ;     ARRAY(3)="XXX XXX xx", etc.
 ;  Comment is a required field when consult is denied or discontinued.
 ;
 ;Output:
 ;GMRCERR=Error Flag: 0 if no error, 1 if error occurred 
 ;GMRCERMS - Error message or null
 ; returned as GMRCERR^GMRCERMS
 ;
 N GMRCDUZ,DFN,GMRCNOW,GMRCSTS,GMRCERR,GMRCERMS,GMRCADUZ,GMRCTRLC
 S GMRCERR=0,GMRCERMS=""
 S GMRCDUZ=DUZ,GMRCERR=0,GMRCERMS="",GMRCNOW=$$NOW^XLFDT
 K GMRCQUT
 S:$G(GMRCAD)="" GMRCAD=GMRCNOW
 S DFN=$P($G(^GMR(123,GMRCO,0)),"^",2) I DFN="" S GMRCERR="1",GMRCERMS="Not A Valid Consult - File Not Found." D EXIT Q GMRCERR_"^"_GMRCERMS
 I '$D(GMRCOM) S GMRCERR=1,GMRCERMS="Comments are required for this action." D EXIT Q GMRCERR_"^"_GMRCERMS
 S GMRCSTS=$P(^ORD(100.01,$P(^GMR(123,GMRCO,0),"^",12),0),U,2)
 I GMRCSTS="dc" S GMRCERR=1,GMRCERMS="Order Has Already Been Discontinued." D EXIT Q GMRCERR_"^"_GMRCERMS
 I GMRCSTS="ca" S GMRCERR=1,GMRCERMS="Order Has Already Been Cancelled." D EXIT Q GMRCERR_"^"_GMRCERMS
 I GMRCSTS="comp" S GMRCERR=1,GMRCERMS="Order Has Already Been Completed." D EXIT Q GMRCERR_"^"_GMRCERMS
 S GMRCA=$S(GMRCACTM="DC":6,1:19),GMRCSTS=$S(GMRCA=6:1,1:13)
 D STATUS^GMRCP I $D(GMRCQUT) D EXIT Q GMRCERR_"^"_GMRCERMS
 I GMRCACTM="DC",$$DCPRNT^GMRCUTL1(GMRCO,DUZ) D PRNT^GMRCUTL1("",GMRCO)
 S DA=$$SETDA^GMRCGUIB D SETCOM^GMRCGUIB(.GMRCOM)
 S GMRCOM(0)=DA
 S GMRCTRLC=$S(GMRCACTM="DC":"OD",1:"OC")
 D EN^GMRCHL7(DFN,GMRCO,$G(GMRCTYPE),$G(GMRCRB),GMRCTRLC,GMRCORNP,$G(GMRCVSIT),.GMRCOM,,GMRCAD)
 S GMRCORTX=$S(GMRCACTM="DY":"Cancelled",1:"Discontinued")_" consult "
 S GMRCORTX=GMRCORTX_$$ORTX^GMRCAU(+GMRCO)
 S GMRCADUZ="",GMRCFL=0
 I GMRCACTM="DC" D
 . S GMRCFL=$$DCNOTE^GMRCADC(GMRCO,DUZ) ;NOTIFY SERVICE ON DC ?
 I +$P($G(^GMR(123,+GMRCO,0)),"^",14),$P(^(0),"^",14)'=DUZ D
 . S GMRCADUZ($P(^(0),"^",14))=""
 ;send notification
 N NOTYPE S NOTYPE=$S(GMRCA=6:23,1:30)
 D MSG^GMRCP(DFN,GMRCORTX,+GMRCO,NOTYPE,.GMRCADUZ,GMRCFL)
 D EXIT
 Q GMRCERR_"^"_GMRCERMS
 ;
FR(GMRCO,GMRCSS,GMRCORNP,GMRCATTN,GMRCURGI,GMRCOM,GMRCAD) ;FWD consult
 ;to another service
 ;
 ;Input variables:
 ;GMRCO=File 123 IEN of the consult record
 ;GMRCSS=service being forwarded to; ptr to REQUEST SERVICES (#123.5)
 ;GMRCORNP=Provider Responsible for action
 ;GMRCATTN=NEW PERSON to whose attention action should be directed
 ;GMRCURGI=urgency from PROTOCOL(#101) file
 ;GMRCOM=Comment array containing explanation of action
 ;    Passed by reference in the following form :
 ;     ARRAY(1)="xxx xxx xxx"
 ;     ARRAY(2)="XXX XXX"
 ;     ARRAY(3)="XXX XXX xx", etc.
 ;GMRCAD=FM date/time of actual activity
 ;
 ;Output:
 ;  GMRCERR=Error Flag: 0 if no error, 1 if error occurred 
 ;  GMRCERMS - Error message or null
 ;     returned as GMRCERR^GMRCERMS
 ;
 N DR,GMRCDUZ,GMRCNOW,GMRCFF,GMRCFR,GMRCADUZ,GMRCURG,GMRCPA,GMRCSEQ,GMRCDOC
 N GMRCERR,GMRCERMS,GMRCIROL,GMRCINM,GMRCIROU
 S GMRCERR=0,GMRCERMS=""
 I $P(^GMR(123,+GMRCO,0),U,12)=9 S GMRCERR=1,GMRCERMS="Invalid action. This consult has partial results."
 S GMRCSEQ=0,GMRCDOC="" F  S GMRCSEQ=$O(^GMR(123,+GMRCO,50,GMRCSEQ)) Q:GMRCSEQ=""  D  Q:+$G(GMRCERR)
 . I $P($G(^GMR(123,+GMRCO,50,GMRCSEQ,0)),";",2)="TIU(8925," S GMRCDOC=$P(^GMR(123,+GMRCO,50,GMRCSEQ,0),";",1)
 . I $G(GMRCDOC)="" Q
 . I $P($G(^TIU(8925,GMRCDOC,0)),U,5)=5 D
 . . S GMRCERMS="Invalid Action. This consult has an unsigned note.",GMRCERR=1
 . I $P($G(^TIU(8925,GMRCDOC,0)),U,5)=6 D
 . . S GMRCERMS="Invalid Action. This consult has an uncosigned note.",GMRCERR=1
 S GMRCSEQ=0,GMRCDOC="" F  S GMRCSEQ=$O(^GMR(123,+GMRCO,40,GMRCSEQ)) Q:GMRCSEQ=""  D  Q:+$G(GMRCERR)
 . I $P($P($G(^GMR(123,+GMRCO,40,GMRCSEQ,0)),U,9),";",2)="TIU(8925," S GMRCDOC=$P($P($G(^GMR(123,+GMRCO,40,GMRCSEQ,0)),U,9),";",1)
 . I $G(GMRCDOC)="" Q
 . I $P($G(^TIU(8925,GMRCDOC,0)),U,5)=5 D
 . . S GMRCERMS="Invalid Action. This consult has an unsigned note.",GMRCERR=1
 . I $P($G(^TIU(8925,GMRCDOC,0)),U,5)=6 D
 . . S GMRCERMS="Invalid Action. This consult has an uncosigned note.",GMRCERR=1
 I GMRCERR=1 D EXIT Q GMRCERR_"^"_GMRCERMS
 S DFN=$P(^GMR(123,+GMRCO,0),U,2)
 S GMRCDUZ=DUZ,GMRCNOW=$$NOW^XLFDT
 S:'$G(GMRCAD) GMRCAD=GMRCNOW  ;Actual FM date/time consult was FWD'd 
 S:'$G(GMRCURGI) GMRCURGI=$P(^GMR(123,GMRCO,0),U,9)
 S GMRCA=17,GMRCSTS=5
 S GMRCFF=$P($G(^GMR(123.5,+GMRCSS,123)),U,9) ;printed to new serv
 S GMRCFR=$P($G(^GMR(123,+GMRCO,0)),"^",5) ;Get current service
 S GMRCPA=$P($G(^GMR(123,+GMRCO,0)),"^",11) ;get current attention 
 S DIE="^GMR(123,",DA=GMRCO,DR=""
 I $D(^GMR(123.5,+GMRCSS,"IFC")) D  ; if fwd to IFC serv, get extra flds
 . S GMRCIROU=$P(^GMR(123.5,+GMRCSS,"IFC"),U) Q:GMRCIROU=""  ;no rout fac
 . S GMRCINM=$P(^GMR(123.5,+GMRCSS,"IFC"),U,2) Q:GMRCINM=""  ;no serv nm
 . S GMRCA=25,GMRCIROL="P"
 . S DR=".07////^S X=GMRCIROU;.125////^S X=GMRCIROL;.131///^S X=GMRCINM;"
 S DR=DR_"1////^S X=$G(GMRCSS);5////^S X=$G(GMRCURGI);8////^S X=$G(GMRCSTS);9////^S X=$G(GMRCA);.1///@"_$S($L($G(GMRCATTN)):";7////^S X=GMRCATTN",1:";7///@")
 L +^GMR(123,GMRCO):3 I '$T K DIE,DA,DR S GMRCERR=1,GMRCERMS="Data Not Filed - File In Use By Another User." D EXIT Q GMRCERR_"^"_GMRCERMS
 D ^DIE L -^GMR(123,GMRCO) K DIE,DA,DR
 S DA=$$SETDA^GMRCGUIB D SETCOM^GMRCGUIB(.GMRCOM)
 S GMRCURG=$P($G(^ORD(101,+GMRCURGI,0)),"^",2)
 D DEM^GMRCU ;sets GMRCRB and other variables
 D TYPE^GMRCAFRD ;sets GMRCTYPE
 D FRMSG^GMRCAFRD ;create XX HL7 message for OE/RR and send alert 
 D EXIT
 Q GMRCERR_"^"_GMRCERMS
 ;
RT(GMRCO,TMPGLOB) ;Set ^TMP("GMRCR",$J,"DT", with results from med and TIU
 ;GMRCO=IEN of consult from file 123
 ;Set TMPGLOB to a ^TMP global other than ^TMP("GMRCR",$J,"MCAR", or ^TMP("GMRCR",$J,"RES", i.e., S TMPGLOB="^TMP(""GMRCR"",$J,""RT"")"'
 Q:'$G(GMRCO)
 K @TMPGLOB
 S GMRCDVL="",$P(GMRCDVL,"-",41)=""
 S GMRCSR=$P(^GMR(123,+GMRCO,0),"^",15),GMRCTUFN=$P(^(0),"^",20)
 S GMRCRTFL=$S('+GMRCSR&('GMRCTUFN):1,1:0)
 ;
 D GETRSLT^GMRCART(TMPGLOB)
 ;
 D EXIT
 Q
EXIT ;kill off variables for exit from actions
 K GMRCA,GMRCDVL,GMRCSR,GMRCRTFL,GMRCFL,GMRCORNP,GMRCQUT,GMRCSTS,GMRCTUFN
 K GMRCRTFL,GMRCADUZ,GMRCORTX
 Q
