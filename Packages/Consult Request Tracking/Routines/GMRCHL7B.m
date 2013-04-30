GMRCHL7B ;SLC/DCM,MA,JFR - Process data from GMRCHL7A ; 4/29/09 8:53
 ;;3.0;CONSULT/REQUEST TRACKING;**1,5,12,21,17,22,33,66,46**;DEC 27, 1997;Build 23
 ;
 ; This routine invokes IA #3991(ICDAPIU), #2053(DIE), #10006(DIC), #2056(GET1^DIQ)
 ;
NEW(MESSAGE) ;Add new order
 ;GMRCO=^GMR(123,IFN, the new file number in file ^GMR(123,
 ;GMRCORFN=OE/RR file number       GMRCWARD=ward patient is on
 ;GMRCSS=service consult sent to   GMRCAD=date/time of request
 ;GMRCPRI=procedure/request        GMRCURGI=urgency
 ;GMRCERDT=earliest desired date
 ;GMRCATN=attention                GMRCSTS=OE/RR order status
 ;GMRCORNP=patient's provider      GMRCTYPE=request type (request or consult)
 ;GMRCSBR=service rendered on what basis (Inpatient, or Outpatient)
 ;GMRCRFQ=reason for request array - word processing fields
 ;GMRCOTXT=order display text from dialog or orderable item
 ;GMRCPRDG=provisional DX
 ;GMRCPRCD=provisional DX code 
 ;
 ; Output:
 ;    MESSAGE = rejection message if problems encountered while filing
 ;
 ;    check for inactive ICD-9 code in Prov. DX
 I $L($G(GMRCPRCD)) D  I $D(MESSAGE) Q  ; rejected due to inactive code
 . I +$$STATCHK^ICDAPIU(GMRCPRCD,DT) Q  ;code is OK
 . S MESSAGE="Provisional DX code is inactive. Unable to file request."
 ;
 N DIC,DLAYGO,X,Y,DR,DIE,GMRCADUZ,GMRCCP
 S DIC="^GMR(123,",DIC(0)="L",X="""N""",DLAYGO=123 D ^DIC K DLAYGO Q:Y<1
 ; Patch #21 changed GMRCA=1 to GMRCA=2
 S (DA,GMRCO)=+Y,GMRCSTS=5,GMRCA=2,DIE=DIC
 L +^GMR(123,GMRCO):$S($G(DILOCKTM)>0:DILOCKTM,1:5)
 S DR=".02////^S X=DFN;.03////^S X=GMRCORFN;.04////^S X=GMRCWARD;.05////^S X=GMRCFAC;.06////^S X=$G(GMRCOFN);1////^S X=GMRCSS;2////^S X=$G(GMRCWARD);3////^S X=GMRCAD;4////^S X=GMRCPRI;5////^S X=GMRCURGI;7////^S X=$G(GMRCATN)"
 D ^DIE
 ;L -^GMR(123,GMRCO) ;add lock timeout
 I GMRCOTXT=$$GET1^DIQ(123.5,+GMRCSS,.01) S GMRCOTXT=""
 ;Added new field .1 to DR on 7/11/98 to save the order text
 S DR="6////^S X=GMRCPLI;8////^S X=GMRCSTS;9////^S X=GMRCA;10////^S X=GMRCORNP;13////^S X=GMRCTYPE;14////^S X=$G(GMRCSBR);17////^S X=$G(GMRCERDT);30////^S X=$G(GMRCPRDG);.1////^S X=$G(GMRCOTXT)" ;wat/66
 I $D(GMRCPRCD) S DR=DR_";30.1///^S X=GMRCPRCD"
 S GMRCCP=$P($G(^GMR(123.3,+GMRCPRI,0)),U,4) I GMRCCP D   ;file CP 
 . S DR=DR_";1.01///^S X=GMRCCP"
 D  ;check to see if an IFC and add .07 ROUTING FACILITY
 . I $G(GMRCPRI) D  Q  ;see if procedure is mapped
 .. I '$D(^GMR(123.3,+GMRCPRI,"IFC")) Q
 .. N IFC S IFC=$G(^GMR(123.3,+GMRCPRI,"IFC"))
 .. I '+IFC Q  ; no ifc routing site
 .. I '$L($P(^GMR(123.3,+GMRCPRI,"IFC"),U,2)) Q  ;no remote proc name
 .. S DR=DR_";.07////"_+IFC_";.125////P"
 . I '$G(GMRCPRI) D  Q  ;see if service is mapped
 .. I '$D(^GMR(123.5,+GMRCSS,"IFC")) Q
 .. N IFC S IFC=$G(^GMR(123.5,+GMRCSS,"IFC"))
 .. I '+IFC Q  ; no ifc routing site
 .. I '$L($P(IFC,U,2)) Q  ;no remote service name
 .. S DR=DR_";.07////"_+IFC_";.125////P;.131////"_$P(IFC,U,2)
 . Q
 D ^DIE
 I $O(GMRCRFQ(0)) D REASON
 L -^GMR(123,GMRCO)
 S GMRCA=1 D AUDIT0^GMRCHL7U
 I $D(GMRCXMF),$D(GMRCOFN) S $P(^GMR(123,GMRCO,0),"^",21)=GMRCOFN
 I $D(GMRCACTN) S GMRCADUZ(GMRCACTN)=""
 D ALERT^GMRCHL7U(DFN,GMRCSS,GMRCPRI,GMRCO,GMRCURGI,"")
 D PRNT^GMRCUTL1(GMRCSS,GMRCO) ;contains print audit update
 D EXIT
 Q
DC(GMRCO,ACTRL) ;Discontinue request from OERR
 ;Denied request also gets this action. Deny request updates status to dc
 ;GMRCO=IEN of record in file ^GMR(123, i.e., ^GMR(123,DA,
 ;ACTRL=GMRCCTRL=control code defining action -
 ;         DC control code = action DC for discontinued 
 ;         CA control code = action DY for denied
 ;Update the last action taken, order status, and processing activity
 Q:'$L(GMRCO)
 Q:'$D(^GMR(123,+GMRCO,0))
 N GMRCACT,GMRCSVC,GMRCDFN,GMRCFL,GMRCADUZ,GMRCRQR,DA
 S GMRCACT=$O(^GMR(123.1,"D",ACTRL,0))
 S GMRCSTS=$P(^GMR(123.1,GMRCACT,0),"^",2)
 S DIE="^GMR(123,",DA=GMRCO
 S DR="8////^S X=GMRCSTS;9////^S X=GMRCACT" ; upd status + last action
 D ^DIE
 D AUDIT0^GMRCHL7U
 ; send 513 back through service printer if order DC'd
 I $G(ACTRL)="DC",$$DCPRNT^GMRCUTL1(GMRCO,DUZ) D
 . D PRNT^GMRCUTL1(+$P(^GMR(123,GMRCO,0),U,5),GMRCO)
 S GMRCDFN=$P(^GMR(123,+GMRCO,0),"^",2)
 S GMRCFL=$$DCNOTE^GMRCADC(GMRCO,DUZ),GMRCADUZ=""
 S GMRCRQR=+$P($G(^GMR(123,+GMRCO,0)),"^",14)
 I +GMRCRQR,GMRCRQR'=DUZ S GMRCADUZ(GMRCRQR)=""
 S GMRCSVC=$P($G(^GMR(123,+GMRCO,0)),"^",5)
 I +GMRCSVC S GMRCSVC=$S($D(^GMR(123.5,GMRCSVC,.1)):^(.1),1:$P(^GMR(123.5,GMRCSVC,0),"^",1))
 E  S GMRCSVC="Unknown Service: Consult # "_GMRCO
 S GMRCORTX=$S(ACTRL="DC":"Discontinued",1:"Cancelled")
 S GMRCORTX=GMRCORTX_" Consult "_$$ORTX^GMRCAU(GMRCO)
 N NOTYPE S NOTYPE=$S(ACTRL="DC":23,1:30)
 D MSG^GMRCP(GMRCDFN,GMRCORTX,+GMRCO,NOTYPE,.GMRCADUZ,GMRCFL)
 D EXIT
 Q
MODIFY ;Change an order/request when an HL7 'XX' code is received
 ;This is currently not used.
 ;    When Consults sends an XX, CPRS returns NA with a new order ien.
 ;GMRCACT=processing activity - from file ^GMR(123.1,
 S DIE="^GMR(123,",DA=+GMRCO
 S GMRCWARD=$G(GMRCWARD),GMRCPRI=$G(GMRCPRI),GMRCURGI=$G(GMRCURGI),GMRCSTS=$G(GMRCSTS),GMRCTYPE=$G(GMRCTYPE),GMRCSS=$G(GMRCSS)
 S GMRCACT=$O(^GMR(123.1,"D",GMRCTRLC,0))
 S GMRCSTS=$P(^GMR(123.1,GMRCACT,0),"^",2)
 S DIE=123,DR=".04////^S X=$G(GMRCWARD);1////^S X=$G(GMRCSS);4////^S X=$G(GMRCPRI);5////^S X=$G(GMRCURGI);8////^S X=$G(GMRCSTS);9////^S X=GMRCACT"
 D ^DIE
 D AUDIT0^GMRCHL7U
 D EXIT Q
REASON ;load the reason for request into ^GMR(123,IFN,20
 S ^GMR(123,GMRCO,20,0)="^^^"_$S($D(GMRCDA):GMRCDA,1:DT)_"^"
 S L=0,LN=1 F  S L=$O(GMRCRFQ(L)) Q:L=""  S ^GMR(123,GMRCO,20,LN,0)=GMRCRFQ(L),LN=LN+1
 S LN=LN-1,$P(^GMR(123,GMRCO,20,0),"^",3)=LN
 K L,LN
 Q
COMMENT(GMRCARY) ;add comments to the record.  Add the comment header, then the comment lines, and lastly, the number of comment lines to the header
 ;GMRCARY= GMRCNTC array
 S LN=0,^GMR(123,GMRCO,40,DA,1,0)="^^^^"_$P(GMRCDA,".",1)_"^"
 F  S LN=$O(GMRCARY(LN)) Q:LN=""  S ^GMR(123,+GMRCO,40,DA,1,LN,0)=GMRCARY(LN),LN1=LN
 S $P(^GMR(123,+GMRCO,40,DA,1,0),"^",3,4)=LN1_"^"_LN1
 K LN,LN1 Q
 Q
EXIT ;kill off all variables
 K DA,DIC,DIE,DR,GMRCORTX,GMRCADUZ
 Q
