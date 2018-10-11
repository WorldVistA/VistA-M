DVBCUTL8 ;ALB/GTS-AMIE C&P APPT LINK FILE MNT RTNS 2 ; 10/20/94  3:30 PM
 ;;2.7;AMIE;**193**;Apr 10, 1995;Build 84
 ;
 ;** NOTICE: This routine is part of an implementation of a Nationally
 ;**         Controlled Procedure.  Local modifications to this routine
 ;**         are prohibited per VHA Directive 10-93-142
 ;
 ;** Version Changes
 ;   2.7 - New routine (Enhc 13)
 Q
 ;
FIXLK ;** Re-attach unlinked appt to new appt
 ;
 ;** ^TMP("DVBC",$J,) must have nodes:
 ;**    ORIGINAL APPT DATE, CURRENT APPT DATE, VETERAN CANCELLATION,
 ;**    VETERAN REQ APPT DATE, APPOINTMENT STATUS = appt to be linked
 ;
 N REQDT,SAVY
 S:$D(Y) SAVY=Y
 S REQDT=$$GETDTE^DVBCMKLK(DVBADA) ;**Set REQDT
 S:$D(SAVY) Y=SAVY
 S DIR("A",1)="Adjusting C&P appointment link for 2507 request dated "_REQDT_"."
 S DIR("A",2)=" "
 S DIR(0)="FAO^1:1",DIR("A")="Hit Return to continue." D ^DIR K DIR,X,Y
 N ORIGAPPT,CURRAPPT,VETCANC,APPTSTAT,APPTNODE,VETDTE,INITAPPT
 S VETDTE=""
 S ORIGAPPT=^TMP("DVBC",$J,"ORIGINAL APPT DATE")
 S CURRAPPT=^TMP("DVBC",$J,"CURRENT APPT DATE")
 S VETCANC=^TMP("DVBC",$J,"VETERAN CANCELLATION")
 S:$D(^TMP("DVBC",$J,"VETERAN REQ APPT DATE")) VETDTE=^TMP("DVBC",$J,"VETERAN REQ APPT DATE")
 S APPTSTAT=^TMP("DVBC",$J,"APPOINTMENT STATUS")
 K DA,DIE,DR
 ;
 ;** Only one current appt date/time for vet can exist in 396.95
 S DA="" S DA=DVBAOLDA
 S APPTNODE=^DVB(396.95,DA,0) ;**APPTNODE 396.95 rec before mods
 S DIE="^DVB(396.95,",DR=""
 ;
 ;** If 396.95 initial appt lost, set to original appt
 I $P(APPTNODE,U,1)="",($P(APPTNODE,U,2)'="") S INITAPPT=$P(APPTNODE,U,2)
 I $P(APPTNODE,U,1)="" S DR=".01////^S X=INITAPPT;"
 I $P(APPTNODE,U,4)'=1 S DR=DR_".02////^S X=ORIGAPPT;"
 S DR=DR_".03////^S X=CURRAPPT;"
 I $P(APPTNODE,U,4)'=1 S DR=DR_".04////^S X=VETCANC;"
 I VETCANC=1 S DR=DR_".05////^S X=VETDTE;" ;**Update last vet req date
 S DR=DR_".07////^S X=APPTSTAT"
 D ^DIE K DIE,DA,DR
 Q
 ;
ADDLK ;** Add link from 2507 to appt
 ;
 ;** ^TMP("DVBC",$J,) nodes:
 ;**    ORIGINAL APPT DATE, CURRENT APPT DATE, VETERAN CANCELLATION,
 ;**    VETERAN REQ APPT DATE, APPOINTMENT STATUS = appt to be linked
 ;
 N REQDT,SAVY
 S:$D(Y) SAVY=Y
 S REQDT=$$GETDTE^DVBCMKLK(DVBADA) ;**Set REQDT
 S:$D(SAVY) Y=SAVY
 S DIR("A",1)="Adding new C&P appointment link for 2507 request dated "_REQDT_"."
 S DIR("A",2)=" "
 S DIR(0)="FAO^1:1",DIR("A")="Hit Return to continue." D ^DIR K DIR,X,Y
 N ORIGAPPT,CURRAPPT,VETCANC,APPTSTAT,APPTNODE,VETDTE
 S VETDTE=""
 S ORIGAPPT=^TMP("DVBC",$J,"ORIGINAL APPT DATE")
 S CURRAPPT=^TMP("DVBC",$J,"CURRENT APPT DATE")
 S VETCANC=^TMP("DVBC",$J,"VETERAN CANCELLATION")
 S:$D(^TMP("DVBC",$J,"VETERAN REQ APPT DATE")) VETDTE=^TMP("DVBC",$J,"VETERAN REQ APPT DATE")
 S APPTSTAT=^TMP("DVBC",$J,"APPOINTMENT STATUS")
 K DA,DIC,X,DD,DO
 S X=^TMP("DVBC",$J,"INITIAL APPT DATE")
 S DIC="^DVB(396.95,",DIC(0)="L",DIC("DR")=""
 S DIC("DR")=DIC("DR")_".02////^S X=ORIGAPPT;.03////^S X=CURRAPPT;"
 S DIC("DR")=DIC("DR")_".04////^S X=VETCANC;.05////^S X=VETDTE;"
 S DIC("DR")=DIC("DR")_".06////^S X=DVBADA;.07////^S X=APPTSTAT"
 D FILE^DICN
 I +Y'>0 DO
 .S DIR("A",1)="The C&P appointment link was not properly added.  Please investigate the"
 .S DIR("A",2)="appointment scheduled for "_ORIGAPPT_" for "_$P(^DPT(DVBADFN,0),U,1)
 .S DIR("A",3)=" "
 .S DIR(0)="FAO^1:1",DIR("A")="Hit Return to continue." D ^DIR K DIR,X,Y
 K DIC,DA,X,Y
 Q
 ;
STYLE(REQDA) ;** Return indication of 2507 status matching integ report type
 N STATIND,REQSTAT,STYLEIND,PARAMDA
 S STATIND=0 ;**Leave set to zero if STYLEIND=4
 S REQSTAT=$$RSTAT($P(^DVB(396.3,REQDA,0),U,18))
 S PARAMDA=0
 S PARAMDA=$O(^DVB(396.1,PARAMDA))
 S STYLEIND=$P(^DVB(396.1,PARAMDA,0),U,15)
 I STYLEIND="1" S:"P^S"[REQSTAT STATIND=1
 I STYLEIND="2" S:"R^C"[REQSTAT STATIND=1
 I STYLEIND="3" S STATIND=1
 Q +STATIND
 ;
SELLNK(REQDA) ;** Return IEN from 396.95 for link to modify
 N SELDA
 D LNKARY^DVBCUTA3(REQDA,DVBADFN) ;**Set up link array
 I '$D(TMP("DVBC LINK")) DO
 .S SELDA=0,DVBANOLK=""
 .D NOLNK^DVBCLKT2
 I $D(TMP("DVBC LINK")) DO
 .I '$D(DVBAAPT) DO
 ..S Y=$P(SDATA,U,3)
 ..X ^DD("DD")
 ..S DVBAAPT=Y
 ..S DVBAAPST=""
 .D LINKDISP^DVBCUTA1
 .I $D(DVBAAPST) K DVBAAPT,DVBAAPST
 K Y
 Q +SELDA
 ;
 ;AJF; Request Status Conversion
RSTAT(RSP) ;**Return Request Status Code from 396.33
 ;RSP - IEN for file 396.33
 Q:'$D(RSP) ""
 Q:'+RSP ""
 Q:'$D(^DVB(396.33,RSP,0)) ""
 Q $P(^DVB(396.33,RSP,0),"^",2)
 ;
 ;AJF; Request Status Conversion
RTSTAT(RSP) ;**Return Status (External) from 396.33
 ;RSP - IEN for file 396.33
 Q:'$D(RSP) ""
 Q:'+RSP ""
 Q:'$D(^DVB(396.33,RSP,0)) ""
 Q $P(^DVB(396.33,RSP,0),"^",1)
 ;
 ;AJF ; Reroute function
REROST(RTN,RSP) ;**Returns 1 if this Request is able to be rerouted
 ;RPC: DVBA CAPRI GET REROUTE
 ;RSP - IEN for file 396.3
 ;RTN - Return value 1 for yes  0 for no
 Q:'$D(RSP) 0
 Q:'+RSP 0
 Q:'$D(^DVB(396.3,RSP,0)) 0
 N CSITE,RSTA,FSITE
 S RTN=0
 S CSITE=$P($$SITE^VASITE,"^",3)
 S FSITE=$S('$D(^DVB(396.3,RSP,6,1,2)):CSITE,1:$P(^DVB(396.3,RSP,6,1,2),"^",4))
 S RSTA=$P(^DVB(396.3,RSP,0),"^",18)
 I CSITE=FSITE S:RSTA=1!(RSTA=2)!(RSTA=12) RTN=1
 S RTN=RTN_"^"_CSITE
 Q
 ;
CDIV(RTN,SITE) ;AJF ; Provides list from CAPRI DIVISION EXAM (396.15
 ;RPC DVBA CAPRI GET DIVISION
 ;RTN - Return list of active divisions "^" Division IEN
 ;
 N CNT,DN,DVP,DV0,FNUM
 S I=0,RTN(1)="No active CAPRI Divisions"
 F  S I=$O(^DVB(396.15,I)) Q:I="B"!(I="")  D
 . Q:$P($G(^DVB(396.15,I,3)),"^")="Y"
 . S CNT=$G(CNT)+1,DVP=$P(^DVB(396.15,I,0),"^")
 . Q:DVP=""
 . S DV0=$G(^DG(40.8,DVP,0))
 . S DN=$P(DV0,"^",1),FNUM=$P(DV0,"^",2)
 . S RTN(CNT)=DN_"  "_FNUM_"^"_I
 Q
 ;
CDIVC(RTN,DIV) ;AJF; Provides comments for GUI
 ; RPC: DVBA CAPRI GET DIV COMMENT
 ; RTN - Return comment
 ; DIV - Division IEN
 N I
 S I=0,RTN(1)="No Division comment available "
 Q:'$D(DIV)
 Q:'+DIV
 F  S I=$O(^DVB(396.15,DIV,2,I)) Q:I=""  D
 .Q:'$D(^DVB(396.15,DIV,2,I,0))
 . S RTN(I)=^DVB(396.15,DIV,2,I,0)
 Q
CDIVE(RTN,DIV) ;AJF ; Provides list of active exams
 ; RPC: DVBA CAPRI GET DIV EXAM
 ; RTN - Return exam 
 ; DIV - Division IEN
 N C2,C3,EN,CNT
 S (C2,CNT)=0,RTN(1)="No exam found"
 Q:'$D(DIV)
 Q:'+DIV
 F  S C2=$O(^DVB(396.15,DIV,1,C2)) Q:C2="B"!(CNT=100)  D
 . Q:"DEFAULT "'[$E(^DVB(396.15,DIV,1,C2,0),1,7)
 . S C3=0
 . F  S C3=$O(^DVB(396.15,DIV,1,C2,3,C3)) Q:C3=""!(CNT=100)  D
 .. Q:'$D(^DVB(396.15,DIV,1,C2,3,C3,0))
 .. Q:$G(^DVB(396.15,DIV,1,C2,3,C3,2))'="Y"
 .. S EN=$P(^DVB(396.15,DIV,1,C2,3,C3,0),"^")
 .. S EN=$$EXTERNAL^DILFD(396.1514,.01,,EN,)
 .. S CNT=CNT+1,RTN(CNT)=EN
 Q
 ;
ARC(RTN) ;AJF ;7/15/2016 Returns all active Reroute Code
 ; RPC: DVBA CAPRI GET REROUTE CODE
 ; RTN - Return exam 
 ; 
 N CT,C1,R0,R2
 S CT=0
 F  S CT=$O(^DVB(396.55,CT)) Q:CT="B"  D
 . S R0=^DVB(396.55,CT,0)
 . Q:$P(R0,"^",2)="I"
 . S C1=$G(C1)+1
 . S RTN(C1)=CT_"^"_$P(R0,"^")
 Q
 ;
RINFO(RTN,RIEN) ;AJF; Returns reroute information for a given 2507 Request
 ;RPC: DVBA CAPRI REROUTE INFO
 ;Input
 ; RIEN: 2507 Request IEN
 ;
 ;Output
 ;  REROUTE TO^REROUTE DATE^REROUTE STATUS^STATUS DATE^REROUTED FROM^ REROUTE REASON ^ REJECT REASON
 ;  ^ 0 for site A/ 1 for site B or C
 ;
 N RTD,RTF,RTO,RTS,RTSD,RRD,RRD,J1,J2,J10,J20,J4
 N REJR,RRW1,RRW2,RUSR,RDIV,RTDIV,RFDIV,CST,CRQ
 I RIEN="" S RTN="0^Missing 2507 Request IEN" Q
 I '$D(^DVB(396.3,RIEN,0)) S RTN="0^Not a valid 2507 Request IEN" Q
 I '$D(^DVB(396.3,RIEN,6,0)) S RTN="0^This 2507 Request has not been Rerouted" Q
 ;
 S J1=$O(^DVB(396.3,RIEN,6,99999),-1)
 S J2=$O(^DVB(396.3,RIEN,6,J1,1,99999),-1)
 I J2="" S RTN="0^This 2507 Request has not been Rerouted" Q
 S J10=^DVB(396.3,RIEN,6,J1,0),J20=^DVB(396.3,RIEN,6,J1,1,J2,0)
 S J4=$G(^DVB(396.3,RIEN,6,J1,2))
 S REJR=$G(^DVB(396.3,RIEN,6,J1,1,J2,1))
 S RTD=$$EXTERNAL^DILFD(396.34,.01,,$P(J10,"^",1))
 S RTO=$$EXTERNAL^DILFD(396.34,.02,,$P(J10,"^",7))
 S RTF=$$EXTERNAL^DILFD(396.34,3,,$P(J10,"^",4))
 S RTSD=$$EXTERNAL^DILFD(396.341,.01,,$P(J20,"^",1))
 S RTS=$$EXTERNAL^DILFD(396.341,1,,$P(J20,"^",2))
 S RRR=$$EXTERNAL^DILFD(396.34,4,,$P(J10,"^",5))
 S RRD=$G(^DVB(396.3,RIEN,6,J1,1))
 S RTDIV=$$EXTERNAL^DILFD(396.3,24,,$P(^DVB(396.3,RIEN,1),"^",4))
 S RFDIV=$$EXTERNAL^DILFD(396.34,8,,$P(J10,"^",9))
 ;
 S CSITE=+$$SITE^VASITE,CRQ=$P(^DVB(396.3,RIEN,0),"^",18),RRW1=0
 I CSITE=$P(J4,"^",1)&(CSITE=$P(J4,"^",3)) S RRW1=1
 S RRW2=$S(RRW1:1,CSITE=$P(J4,"^",3):0,1:1)
 S CST=$S(RRW2=0:0,CRQ=14:1,CRQ=11:1,1:0)
 ;
 S RTN(1)=RTO_"^"_RTD_"^"_RTS_"^"_RTSD_"^"_RTF_"^"_RRR_"^"_CST_"^"_RFDIV_"^"_RTDIV
 S RTN(2)=RRD
 S RTN(3)=REJR
 ;
 Q
RPRO(RTN,RIEN,RRST,RRR) ; AJF; 7/25/2016; Update Reroute Status
 ;RPC: DVBA CAPRI REROUTE STATUS
 ;Input:
 ;  RIEN = 2507 Request IEN
 ;  RRST = Reroute status
 ;  RRR = Reject Reason
 ;
 ;Output:
 ;  RTN = 0 for Failure
 ;        1 for Success
 ;
 N OSITE,OIEN,DA,DR,DIE,REJM,NSITE,RRUP,J1,J2,DIV1,DIV2
 I RIEN="" S RTN="0^Missing 2507 Request IEN" Q
 I '$D(^DVB(396.3,RIEN,0)) S RTN="0^Not a valid 2507 Request IEN" Q
 I '$D(^DVB(396.3,RIEN,6,0)) S RTN="0^This 2507 Request has not been rerouted" Q
 ;
 S RRR=$G(RRR)
 S J1=$O(^DVB(396.3,RIEN,6,99999),-1)
 S J2=$O(^DVB(396.3,RIEN,6,J1,99999),-1)
 I J2="" S RTN="0^This 2507 Request has not been rerouted" Q
 S RRIEN=J1,RRDT=$$NOW^XLFDT()
 S RRUP=$$UPRS(RIEN,RRIEN,RRDT,RRST,RRR)
 ;
 S R0=^DVB(396.3,RIEN,6,J1,0)
 S R1=^DVB(396.3,RIEN,6,J1,2)
 S CSITE=$P($$SITE^VASITE,"^",3),OSITE=$P(R1,"^",4),OIEN=$P(R0,"^",2),NSITE=$P(R1,"^",2)
 S DIV1=$P(R0,"^",9),DIV2=$P($G(^DVB(396.3,RIEN,1)),"^",4)
 I CSITE=OSITE,CSITE=NSITE,RRST="R" D
 . S DIE="^DVB(396.3,"_RIEN_",6,",DA=J1,DA(1)=RIEN
 . S DR="8////"_DIV2
 . D ^DIE ;set Reroute fields
 . K DIE,DA
 ; Check to see if this the original site
 I CSITE=OSITE D
 . I RRST="A" S DR="6////"_RRDT_";17////13" Q
 . I RRST="R" S DR="17////1",REJM=1 D EXSET(RIEN,"O") S ^DVB(396.3,"AR",RRDT,RIEN)=""
 I CSITE'=OSITE D
 . I RRST="A" S DR="17////2" Q
 . I RRST="R" S DR="6////"_RRDT_";17////12" D EXSET(RIEN,"T")
 I CSITE=OSITE,CSITE=NSITE D
 . I RRST="A" S DR="17////2" Q
 . I RRST="R" S DR="17////1;24////"_DIV1,^DVB(396.3,"AR",RRDT,RIEN)=""
 S DA=RIEN,DIE="^DVB(396.3,"
 D ^DIE
 ;
 ; Send Reject Message to DVBA C 2507 Reroute Group
 D:RRST="R" MSG^DVBAB1C(RIEN)
 ; 
 I CSITE=OSITE S RTN="1^Reroute status updated" Q
 ;
 S OIEN=$P(R0,"^",2)
 S RTN="1^Reroute status updated^"_OSITE_"^"_OIEN
 ; 
 Q 
 ;
 ;
UPRR(RIEN,RRDT) ;AJF ; 7/30/2016; Update Reroute information
 ;create Reroute entry for 2507 Request in sub-file 396.33
 N DIC,X,Y,DA,DTOUT,DUOUT,DLAYGO,DO
 S DIC="^DVB(396.3,"_RIEN_",6,",DA(1)=RIEN
 S DIC(0)="L",DLAYGO=396.3
 S X=RRDT  ;.01 2507 REQUEST REROUTE DATE
 D FILE^DICN K DLAYGO
 ;
 ;
 Q Y_"^"_RRDT
 ;
UPRS(RIEN,RRIEN,RRDT,RRST,RRR) ; Update the status
 N DIC,X,Y,DA,DO,DTOUT,DUOUT,DLAYGO
 S RRR=$G(RRR)
 S DIC="^DVB(396.3,"_RIEN_",6,"_RRIEN_",1,"
 S DA(1)=RIEN,DA(2)=RRIEN
 S DIC(0)="FL",DLAYGO=396.3
 S X=RRDT  ;.01 2507 REQUEST REROUTE DATE
 S DIC("DR")="1////"_RRST_";2////"_RRR
 D FILE^DICN
 S R2=Y
 Q Y
 ;
EXSET(RIEN,EST) ;Set Exam status
 Q:RIEN=""!(EST="")
 N DA,DIE,DR,JJ
 F JJ=0:0 S JJ=$O(^DVB(396.4,"C",RIEN,JJ)) Q:JJ=""  D
 . I $P(^DVB(396.4,JJ,0),U,4)="X" Q
 . I $P(^DVB(396.4,JJ,0),U,4)="C" Q
 . S DA=JJ,DIE="^DVB(396.4,",DR=".04////"_EST
 . D ^DIE
 Q
