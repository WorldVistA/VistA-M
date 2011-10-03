GMRCGUIB ;SLC/DCM,JFR,MA - GUI actions for consults ;8/19/03 07:31
 ;;3.0;CONSULT/REQUEST TRACKING;**4,12,18,20,17,22,29,30,35,45,53,55,64**;DEC 27, 1997;Build 20
 ; This routine invokes IA #2980
 ;
SETDA() ;set DA of where audit actions are to be filed
 S:'$D(^GMR(123,+GMRCO,40,0)) ^GMR(123,GMRCO,40,0)="^123.02DA^^"
 S DA=$S($P(^GMR(123,+GMRCO,40,0),"^",3):$P(^(0),"^",3)+1,1:1)
 S $P(^GMR(123,+GMRCO,40,0),"^",3,4)=DA_"^"_DA
 Q DA
REASON(GMRCFN,GMRCRQ,GMRCDT) ;Load the reason for the request into ^GMR(123,GMRCO,20
 ;GMRCFN=File 123 IFN; GMRCRQ=Array containing Reason For Request
 ;GMRCDT=Date time of entry
 S ^GMR(123,GMRCFN,20,0)="^^^"_GMRCDT_"^"
 S L=0,LN=1 F  S L=$O(GMRCRQ(L)) Q:L=""  S ^GMR(123,GMRCFN,20,LN,0)=GMRCRQ(L),LN=LN+1
 S LN=LN-1,$P(^GMR(123,GMRCFN,20,0),"^",3)=LN
 K LN,L
 Q
SETCOM(COMMENT,WHO) ;Set comment array into tracking actions
 N GMRCNOW,DR,DIE
 S GMRCNOW=$$NOW^XLFDT
 I $P($G(^GMR(123,+GMRCO,0)),"^",11)=$G(GMRCPA) S GMRCPA=""
 S DIE="^GMR(123,GMRCO,40,",DA(1)=GMRCO,DR=".01////^S X=GMRCNOW;1////^S X=GMRCA;2////^S X=GMRCAD;3////^S X=$G(GMRCORNP);4////^S X=$S($G(WHO):WHO,1:DUZ);6////^S X=$G(GMRCFR);8////^S X=$G(GMRCFF);7////^S X=$G(GMRCPA)"
 D ^DIE
 S ^GMR(123,GMRCO,40,DA,1,0)="^^^^"_GMRCAD_"^"
 S (GMRCND,GMRCND1)=0 F  S GMRCND1=$O(COMMENT(GMRCND1)) Q:GMRCND1=""  S GMRCND=GMRCND+1,^GMR(123,GMRCO,40,DA,1,GMRCND,0)=COMMENT(GMRCND)
 S $P(^GMR(123,GMRCO,40,DA,1,0),"^",3)=GMRCND,$P(^(0),"^",4)=GMRCND,^GMR(123,GMRCO,40,"B",GMRCNOW,DA)=""
 ;
 ; if an IFC, call event handler to generate a msg to remote site
 I $D(^GMR(123,+GMRCO,12)),$D(^(40,DA)) D TRIGR^GMRCIEVT(GMRCO,DA)
 ;
 K GMRCND,GMRCND1
 Q
CMT(GMRCO,GMRCOM,GMRCADUZ,GMRCWHN,GMRCWHO) ;add comment to consult 
 ; GMRCO = IEN from file 123
 ; GMRCOM = array of comments in format GMRCOM(1)="xxxx", GMRCOM(2)="xxx"
 ; GMRCADUZ = array of alert recipients as GMRCADUZ(DUZ)="" (optional)
 ; GMRCWHO = IEN from file 200 who's responsible activity (optional)
 ; GMRCWHN = date time of activity in FM format
 ;
 N DA,GMRCA,GMRCAD,GMRCORTX,GMRCDFN,GMRCTM,GMRCRP,GMRCUPD
 S DA=$$SETDA ; get next activity tracking entry
 S GMRCA=20,GMRCAD=GMRCWHN S:$G(GMRCWHO) GMRCORNP=GMRCWHO
 D SETCOM(.GMRCOM,$G(GMRCWHO))
 D  ;update LAST ACTION field even though no status change
 . N GMRCDR,GMRCSTS
 . S GMRCSTS="",GMRCDR="9////20"
 . D STATUS^GMRCP
 S GMRCDFN=$P(^GMR(123,+GMRCO,0),"^",2)
 S GMRCORTX="Comment Added to Consult "
 I $P($G(^GMR(123,GMRCO,12)),U,5)="P" D
 . S GMRCORTX="Comment Added to remote consult "
 S GMRCORTX=GMRCORTX_$$ORTX^GMRCAU(+GMRCO)
 S GMRCRP=+$P(^GMR(123,GMRCO,0),U,14)
 S GMRCUPD=$$VALID^GMRCAU($P(^GMR(123,+GMRCO,0),U,5),GMRCO,DUZ)
 I GMRCRP=DUZ D  ;alert team if ord. prov. takes the action
 . S GMRCTM=1
 I GMRCUPD>1,GMRCRP'=DUZ D  ; alert ord. prov if update users takes action
 . S GMRCADUZ(GMRCRP)=""
 I '$G(GMRCTM),GMRCUPD<2 D  ;alert both if not ord. prov or update user
 . S GMRCTM=1,GMRCADUZ(GMRCRP)=""
 D MSG^GMRCP(GMRCDFN,GMRCORTX,+GMRCO,63,.GMRCADUZ,$G(GMRCTM))
 Q
SFILE(GMRCO,GMRCA,GMRCSF,GMRCORNP,GMRCDUZ,GMRCOM,GMRCALF,GMRCATO,GMRCAD) ;Process various file update functions from the GUI for a consult
 ; ADMIN COMPLETE or SIGNIFICANT FINDINGS
 ;Input variables:
 ;GMRCO=File 123 IEN of the consult record
 ;GMRCA=pointer to REQUEST ACTION TYPES (#123.1) 10=complete, 4=Sig find.
 ;GMRCSF=Significant Findings flag: 'Y'= significant finding
 ;                                : 'N'= no significant finding
 ;                                : 'U'=unknown significant finding
 ;GMRCORNP=Provider Responsible for action
 ;GMRCDUZ=Person actually doing the action
 ;GMRCOM=An array of comments by reference ARRAY(1)="xxx",ARRAY(2)="xxx"
 ;GMRCALF=Flag to signal that alerts are to be sent; 'N'=NO, 'Y'=YES
 ;GMRCATO=Who alerts are to be sent to; a comma delimited string of DUZ's
 ;GMRCAD =FM date/time of activity
 ;
 ;Output:
 ; GMRCERR=Error Flag: 0 if no error, 1 if error occurred
 ; GMRCERMS - Error message or null
 ;    returned as GMRCERR^GMRCERMS
 ;
 N GMRCERR,GMRCERMS
 L +^GMR(123,GMRCO):5 I '$T S GMRCERR=1,GMRCERMS="Record Locked. File Update Not Accomplished." Q GMRCERR_"^"_GMRCERMS
 S GMRCERR=0,GMRCERMS="",DR="",GMRCORTX=""
 N GMRCADUZ S GMRCADUZ=""
 S GMRCNOW=$$NOW^XLFDT,GMRCSTS=$P(^GMR(123,+GMRCO,0),"^",12),GMRCDFN=$P(^(0),"^",2)
 I '$G(GMRCDUZ) S GMRCDUZ=DUZ
 I '$G(GMRCAD) S GMRCAD=GMRCNOW
 ;Insure comment array contains text for Complete action.
 I GMRCA=10 D  I GMRCERR=1 S GMRCERMS="Comment field must contain a text value!" Q GMRCERR_"^"_GMRCERMS
 . S GMRCERR=1
 . I '$D(GMRCOM) Q
 . N GMRCOM1 S GMRCOM1=""
 . F  S GMRCOM1=$O(GMRCOM(GMRCOM1)) Q:(GMRCOM1=""!(GMRCERR=0))  D
 .. I $TR($G(GMRCOM(GMRCOM1))," ","")'="" S GMRCERR=0 Q
 I +$G(GMRCA),GMRCA=10 D
 .S GMRCSF=$G(GMRCSF,"")
 .S GMRCSTS=2
 .S DR="8////^S X=GMRCSTS;9////^S X=GMRCA;15////^S X=GMRCSF"
 .S GMRCORTX="Completed Consult "_$$ORTX^GMRCAU(+GMRCO)_$S(GMRCSF="Y":" with Sig Findings",GMRCSF="N":" with no Sig Findings",1:"")
 .I $P($G(^GMR(123,+GMRCO,0)),U,14) S GMRCADUZ($P($G(^(0)),U,14))=""
 .Q
 I $G(GMRCALF)=1 D
 .N I
 .F I=1:1  S X=$P(GMRCATO,";",I) Q:X=""  S GMRCADUZ(X)=""
 .Q
 I $L(GMRCA),GMRCA=4 S DR=DR_$S($L(DR):";",1:"")_"9////^S X=GMRCA;15////^S X=GMRCSF" D
 .S GMRCORTX=$S(GMRCSF="Y":"Sig Findings ",GMRCSF="N":"No Sig Findings ",1:"Unknown Sig Findings ")_"for consult "_$$ORTX^GMRCAU(GMRCO)
 .I $P($G(^GMR(123,+GMRCO,0)),U,14) S GMRCADUZ($P($G(^(0)),U,14))=""
 .Q
 I $L(DR) S DIE="^GMR(123,",DA=GMRCO D ^DIE K DIE,DR
 I '$O(GMRCOM(0)) D AUDIT^GMRCP
 I $D(GMRCOM),$O(GMRCOM(0)) D
 .N DA
 .S DA=$$SETDA()
 .D SETCOM(.GMRCOM,GMRCDUZ)
 .Q
 L -^GMR(123,GMRCO)
 ;
 D MSG^GMRCP(GMRCDFN,GMRCORTX,+GMRCO,$S(GMRCA=20:63,1:23),.GMRCADUZ,0)
 ;
 I $S(GMRCA=10:1,(GMRCA=4&($P(^GMR(123,GMRCO,0),U,12)=2)):1,1:0) D
 . D EN^GMRCHL7($P(^GMR(123,GMRCO,0),"^",2),GMRCO,$G(GMRCTYPE),$G(GMRCRB),"RE",GMRCORNP,$G(GMRCVSIT),.GMRCOM,,GMRCAD)
 K DIE,DR,DA,GMRCDT,GMRCNOW,GMRCAD,GMRCORNP,GMRCDUZ,GMRCRSLT,GMRCSTS,GMRCADUZ,GMRCORTX,GMRCDFN
 Q GMRCERR_"^"_GMRCERMS
 ;
SCH(GMRCO,GMRCORNP,GMRCAD,GMRCADUZ,GMRCMT) ;schedule a consult API
 ; Input variables:
 ;GMRCO - The internal file number of the consult from File 123
 ;GMRCORNP - Name of the person who actually 'Received' the consult 
 ;GMRCAD - Actual date time that consult was received into the service.
 ;GMRCADUZ - array of alert recipients as chosen by user (by reference)
 ;   ARRAY(DUZ)="" 
 ;GMRCMT - array of comments if entered (by reference)
 ;   ARRAY(1)="FIRST LINE OF COMMENT"
 ;   ARRAY(2)="SECOND LINE OF COMMENT"
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
 S DFN=$P($G(^GMR(123,GMRCO,0)),"^",2) I DFN="" D  Q GMRCERR_"^"_GMRCERMS
 . S GMRCERR="1",GMRCERMS="Not A Valid Consult - File Not Found."
 . D EXIT^GMRCGUIA
 S GMRCSTS=8,GMRCA=8
 D STATUS^GMRCP I $D(GMRCQUT) D EXIT^GMRCGUIA Q GMRCERR_"^"_GMRCERMS
 I '$O(GMRCMT(0)) D AUDIT^GMRCP
 I $O(GMRCMT(0)) D
 . S DA=$$SETDA
 . D SETCOM(.GMRCMT,GMRCDUZ)
 D EN^GMRCHL7(DFN,GMRCO,"","","SC",GMRCORNP,"","","",GMRCAD)
 D  ;send alerts
 . N TXT
 . S TXT="Scheduled Consult: "_$$ORTX^GMRCAU(GMRCO)
 . I $P(^GMR(123,+GMRCO,0),U,14) S GMRCADUZ($P(^(0),U,14))=""
 . D MSG^GMRCP(DFN,TXT,GMRCO,63,.GMRCADUZ,0)
 D EXIT^GMRCGUIA
 Q GMRCERR_"^"_GMRCERMS
DOCLIST(GMRCAR,GMRCDA,GMRCMED)  ;return list of linked results
 ; Input:
 ;  GMRCAR - array to return list, passed by reference
 ;  GMRCDA - ien from file 123
 ;  GMRCMED- 1 = include med results; 0 = only TIU docs
 ;
 ; Output:
 ;  GMRCAR - array in format
 ;       GMRCAR(0)=zero node of record
 ;       GMRCAR(50,1)="ien;global ref," e.g. 5;TIU(8925, or 3;MCAR(691,
 ;       GMRCAR(50,2)="ien;global ref,"
 ;
 I '$D(^GMR(123,GMRCDA,0)) Q
 S GMRCAR(0)=^GMR(123,GMRCDA,0),$P(GMRCAR(0),U,20)=""
 N RES,CNT S RES="",CNT=1
 F  S RES=$O(^GMR(123,GMRCDA,50,"B",RES)) Q:RES=""  D
 . I '$G(GMRCMED) Q:RES'["TIU(8925"
 . S GMRCAR(50,CNT)=RES
 . I RES["MCAR" D
 .. N ARR,STR
 .. D MEDLKUP^MCARUTL3(.ARR,+$P(RES,"MCAR(",2),+RES)
 .. I '+ARR K GMRCAR(50,CNT) Q
 .. S STR=$P(ARR,U,9)_U_$P(ARR,U,6)_$S($P(ARR,U,10):"^^^^^^^^1",1:"")
 .. S GMRCAR(50,CNT)=GMRCAR(50,CNT)_U_STR
 . S CNT=CNT+1
 Q
