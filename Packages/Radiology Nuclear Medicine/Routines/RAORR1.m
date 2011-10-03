RAORR1 ;HISC/CAH,FPT,GJC AISC/DMK-Edit a new request from OERR ;11/13/97  15:25
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ;OE/RR Utility routine for Rad/Nuc Med
 I $S('$D(ORIFN):1,'$L(ORIFN):1,1:0) G END
 I $S('$D(ORPK):1,'$D(^RAO(75.1,+ORPK,0)):1,1:0) G END
 G END:'$D(ORVP)!('$D(ORL))!('$D(ORNP))
 S RADFN=+ORVP,RALIFN=+ORL,RAPIFN=+ORNP
SELECT S RAORIFN=ORIFN,RAOIFN=+ORPK D OERR1
 Q
OERR1 ;
 S RAORD0=$S($D(^RAO(75.1,RAOIFN,0)):^(0),1:"") G END:'RAORD0 D SETDIV
 I ORACTION=1 D  ; editing an existing order
 . N RALOC,RAREQER S RAREQER(0)=$P(RAORD0,"^",6) ; Request Urgency before
 . S DA=RAOIFN,DIE="^RAO(75.1,",DR="[RA OERR EDIT]" D ^DIE
 . K DR,DIE S RAORD0=$G(^RAO(75.1,RAOIFN,0)),RALOC=+$P(RAORD0,"^",20)
 . S RAREQER(1)=$P(RAORD0,"^",6) ; Request Urgency after
 . I RAREQER(1)=1!(RAREQER(1)=2&($P($G(^RA(79.1,RALOC,0)),"^",20)="Y")) D
 .. ; If Req. Urgency is STAT (1) -or- [Req. Urgency is URGENT (2) -and-
 .. ; Urgent Request Alerts? set to 'yes'.]
 .. Q:$$ORVR^RAORDU()<3  ; needs OE/RR 3.0 or greater for alerts to fire
 .. D OENO^RAUTL19(RAOIFN)
 .. Q
 . Q
UPDATE ;
 N RAPRGST S RAPRGST=$P(RAORD0,"^",13)
 S RABLNK="",$P(RABLNK," ",40)=""
 K RAMOD F I=0:0 S I=$O(^RAO(75.1,RAOIFN,"M","B",I)) Q:'I  I $D(^RAMIS(71.2,+I,0)) S RAMOD=$S('$D(RAMOD):$P(^(0),"^"),1:RAMOD_", "_$P(^(0),"^"))
 S RASEX=$P($G(^DPT(+RAORD0,0)),"^",2)
 I $$ORVR^RAORDU()=2.5 S (RAPRC,ORETURN("ORTX",1))=$P($G(^RAMIS(71,+$P(RAORD0,"^",2),0)),"^")_"," D
 .I $D(RAMOD) S ORETURN("ORTX",2)="Modifiers: "_$E(RAMOD,1,80)_","
 .S ORETURN("ORTX",3)="Urgency: "_$S($P(RAORD0,"^",6)=1:"STAT",$P(RAORD0,"^",6)=2:"URGENT",1:"ROUTINE")_","
 .I $P(RAORD0,"^",19)]"" S X=$P(RAORD0,"^",19),ORETURN("ORTX",3)=ORETURN("ORTX",3)_" Transport: "_$S(X="a":"AMBULATORY",X="p":"PORTABLE",X="s":"STRETCHER",1:"WHEELCHAIR")_","
 .I $D(RASEX),RASEX'="M" S ORETURN("ORTX",3)=ORETURN("ORTX",3)_" Pregnant: "_$S(RAPRGST="n":"NO",RAPRGST="y":"YES",RAPRGST="u":"UNKNOWN",1:"")
 .S ORETURN("ORIT")=$P(RAORD0,"^",2)_";RAMIS(71,"
 S DIC="^RA(79.2,",DIC(0)="N",X=+$P(^RAMIS(71,+$P(RAORD0,"^",2),0),"^",12) D ^DIC K DIC S ORETURN("ORPURG")=$S(Y<0:30,$D(^RA(79.2,+Y,.1)):+$P(^(.1),"^",6),1:30)
 S ORETURN("ORSTRT")=$P(^RAO(75.1,RAOIFN,0),"^",21)
 D RETURN^ORX
 I $D(ORGY),ORGY=9 D RELEASE
 D END Q
QUE ;
 F RAORIFN=0:0 S RAORIFN=$O(^XUTL("OR",$J,"RA",RAORIFN)) Q:'RAORIFN  F RAOIFN=0:0 S RAOIFN=$O(^(RAORIFN,RAOIFN)) Q:'RAOIFN  S RADIV=^(RAOIFN) D DIV I $D(^RAO(75.1,RAOIFN,0)) S RAORD0=^(0),RADFN=+RAORD0 D ^RAORDQ K ^XUTL("OR",$J,"RA",RAORIFN)
 ;
END K RAOIFN,RAORD0,DA,DIE,DR,RABLNK,RAMOD,RAPRC,DIC,RADFN,RALOCFLG,RADIV,RAFIN,RAL0,RALIFN,RALOC,RANME,RAPIFN,RAREQPRT,RASEX,RAX,VA,RACAT,RAORIFN,RAWARD,RAOIFN0,RAFOERR
 ; RAOEFRR is set in ENADD^RAORD1.  This variable is user to omit exam
 ; information from printing on the request. (If exam data present)
 Q
DIV I $D(RADIV),$D(^RA(79,+RADIV,.1)),$P(^(.1),"^",21)="y" S RALOCFLG="" Q
 I '$D(RADIV) S RADIV=$O(^RA(79,"AL",+$P($G(^RAO(75.1,RAOIFN,0)),"^",20),0)) Q:'RADIV  I $D(^RA(79,+RADIV,.1)),$P(^(.1),"^",21)="y" S RALOCFLG=""
 Q
SETDIV ;set RADIV and RACAT
 S RAL0=$S($D(^SC(RALIFN,0)):^(0),1:0)
 S RADIV=+$$SITE^VASITE(DT,+$P(RAL0,"^",15)) S:RADIV<0 RADIV=0
 S RADIV=$S($D(^RA(79,RADIV,0)):RADIV,1:$O(^RA(79,0)))
 S RACAT=$P($P(^DD(75.1,4,0),$P(RAORD0,"^",4)_":",2),";")
 Q
RELEASE ;called to release an order
 I $D(RADIV),$D(^RA(79,+RADIV,.1)),$P(^(.1),"^",21)="y" S RALOCFLG=""
 I $S('$D(RADIV):1,'RADIV:1,1:0) S RADIV=$O(^RA(79,"AL",+$P($G(^RAO(75.1,RAOIFN,0)),"^",20),0)) Q:'RADIV
 S DA=RAOIFN,DIE="^RAO(75.1,",DR="5////^S X=5" D ^DIE K DIE,DA,DR
 I $$UP^XLFSTR($P($G(^RA(79,+RADIV,.1)),"^",19))="Y" D
 . ; update 'Request Status Times' multiple
 . N DA,DE,DIE,DQ,DR
 . S DA=RAOIFN,DIE="^RAO(75.1,",DR="75///^S X=""""""NOW"""""""
 . S DR(2,75.12)="2////^S X=5;3////^S X="_DUZ D ^DIE
 . Q
 S RAMES="W """"" D ^RAORDQ K ^XUTL("OR",$J,"RA") Q
