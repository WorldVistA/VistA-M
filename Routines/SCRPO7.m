SCRPO7 ;BP-CIOFO/KEITH - Historical Team Assignment Summary (cont.) ; 06 Jul 99  7:41 AM
 ;;5.3;Scheduling;**177**;AUG 13, 1993
 ;
CKTEAM(SCTM) ;Build from team
 ;Input: SCTM=team ifn
 N SCTM0,SCDIV,SCTPC,SCTMAX,SCTEAM,SCDT,SCRATCH,ERR,SCI
 N SCACT,SCII,SCIII,SCINAC,SCPC,SCPNAM,SCTP
 N DFN,SCTMASS,SCTMUNI,SCX,SCPTA,SCY
 F SCI=1:1:12 S SCY(SCI)=""
 S SCTM0=$G(^SCTM(404.51,SCTM,0)) Q:'$L(SCTM0)
 S SCTEAM=$P(SCTM0,U)_U_SCTM  ;team name
 S SCDIV=$P(SCTM0,U,7) Q:'SCDIV  ;division
 I $O(^TMP("SC",$J,"DIV",0)),'$D(^TMP("SC",$J,"DIV",SCDIV)) Q
 S SCDIV=$P($G(^DIC(4,SCDIV,0)),U)_U_SCDIV
 S SCY(1)=$S($P(SCTM0,U,5)=1:"YES",1:"NO")  ;pc team?
 S SCY(2)=$P(SCTM0,U,8)  ;max. patients
 M SCDT=^TMP("SC",$J,"DTR") S SCDT="SCDT"
 S SCRATCH="^TMP(""SCRATCH"",$J,1)" K @SCRATCH,^TMP("SCRPT",$J,2)
 S SCI=$$PTTM^SCAPMC(SCTM,.SCDT,SCRATCH,"ERR")
 S SCI=0 F  S SCI=$O(^TMP("SCRATCH",$J,1,SCI)) Q:'SCI  D
 .S SCX=^TMP("SCRATCH",$J,1,SCI)
 .S DFN=$P(SCX,U) Q:'DFN
 .S DATA=$P(SCX,U,2)_U_$P(SCX,U,6)_U_$P(SCX,U,4,5)
 .S SCPTA=$P(SCX,U,3) Q:'SCPTA
 .F SCII=0,1,2 S ^TMP("SCRPT",$J,SCII,$$RPT(SCII),"TPTS",DFN,SCPTA)=DATA
 ;Count team assignments and uniques
 S DFN=0 F  S DFN=$O(^TMP("SCRPT",$J,2,SCTEAM,"TPTS",DFN)) Q:'DFN  D
 .S SCY(7)=SCY(7)+1,SCPTA=0
 .F  S SCPTA=$O(^TMP("SCRPT",$J,2,SCTEAM,"TPTS",DFN,SCPTA)) Q:'SCPTA  D
 ..S SCY(3)=SCY(3)+1
 ..Q
 .Q
 ;Get team positions
 K @SCRATCH
 S SCI=$$TPTM^SCAPMC(SCTM,.SCDT,,,SCRATCH,"ERR")
 S SCI=0 F  S SCI=$O(^TMP("SCRATCH",$J,1,SCI)) Q:'SCI  D
 .N SCDT2 M SCDT2=SCDT S SCDT2="SCDT2"
 .S SCX=^TMP("SCRATCH",$J,1,SCI)
 .S SCTP=$P(SCX,U) Q:'SCTP
 .S SCPOSN=$P(SCX,U,2)
 .S SCACT=$P(SCX,U,5),SCINAC=$P(SCX,U,6)
 .S:SCACT>SCDT2("BEGIN") SCDT2("BEGIN")=SCACT
 .I SCINAC,SCINAC<SCDT2("END") S SCDT2("END")=SCINAC
 .S SCRATCH="^TMP(""SCRATCH"",$J,2)" K @SCRATCH
 .;Get list of position patients
 .S SCII=$$PTTP^SCAPMC(SCTP,.SCDT2,SCRATCH,"ERR")
 .S SCII=0  F  S SCII=$O(^TMP("SCRATCH",$J,2,SCII)) Q:'SCII  D
 ..S SCX=^TMP("SCRATCH",$J,2,SCII)
 ..S DFN=$P(SCX,U) Q:'DFN
 ..S DATA=$P(SCX,U,2)_U_$P(SCX,U,6)_U_$P(SCX,U,4,5)_U_SCPOSN
 ..S SCPTPA=$P(SCX,U,3) Q:'SCPTPA
 ..S SCPTPA0=$G(^SCPT(404.43,SCPTPA,0)) Q:'$L(SCPTPA0)
 ..S SCPC=$P(SCPTPA0,U,5)>0  ;pc position?
 ..F SCIII=0,1,2 S ^TMP("SCRPT",$J,SCIII,$$RPT(SCIII),"PPTS",SCPC,DFN,SCPTPA)=DATA
 ..Q
 .Q
 ;Count team position assignment assignments and uniques
 F SCI=0,1 S DFN=0 D
 .F  S DFN=$O(^TMP("SCRPT",$J,2,SCTEAM,"PPTS",SCI,DFN)) Q:'DFN  D
 ..S SCY(8+SCI)=SCY(8+SCI)+1,SCPTPA=0
 ..F  S SCPTPA=$O(^TMP("SCRPT",$J,2,SCTEAM,"PPTS",SCI,DFN,SCPTPA)) Q:'SCPTPA  D
 ...S SCY(4+SCI)=SCY(4+SCI)+1
 ...Q
 ..Q
 .Q
 ;check for broken team assignments
 M ^TMP("SCRPT",$J,2,SCTEAM,"PPTS",1)=^TMP("SCRPT",$J,2,SCTEAM,"PPTS",0)
 S DFN=0 F  S DFN=$O(^TMP("SCRPT",$J,2,SCTEAM,"TPTS",DFN)) Q:'DFN  D
 .Q:$D(^TMP("SCRPT",$J,2,SCTEAM,"PPTS",1,DFN))
 .S SCPTA=0,SCY(11)=SCY(11)+1
 .F  S SCPTA=$O(^TMP("SCRPT",$J,2,SCTEAM,"TPTS",DFN,SCPTA)) Q:'SCPTA  D
 ..S DATA=^TMP("SCRPT",$J,2,SCTEAM,"TPTS",DFN,SCPTA)
 ..S SCPNAM=$P(DATA,U) Q:'$L(SCPNAM)
 ..S ^TMP("SCRPT",$J,0,0,"TLIST",SCDIV,SCTEAM,SCPNAM,SCPTA)=DATA
 ..S ^TMP("SCRPT",$J,0,0,"BTA",SCDIV,DFN)=""
 ..S ^TMP("SCRPT",$J,0,0,"BTA",0,DFN)=""
 ..Q
 .Q
 ;check for broken team position assignments
 S DFN=0 F  S DFN=$O(^TMP("SCRPT",$J,2,SCTEAM,"PPTS",1,DFN)) Q:'DFN  D
 .Q:$D(^TMP("SCRPT",$J,2,SCTEAM,"TPTS",DFN))
 .S SCPTPA=0,SCY(12)=SCY(12)+1
 .F  S SCPTPA=$O(^TMP("SCRPT",$J,2,SCTEAM,"PPTS",1,DFN,SCPTPA)) Q:'SCPTPA  D
 ..S DATA=^TMP("SCRPT",$J,2,SCTEAM,"PPTS",1,DFN,SCPTPA)
 ..S SCPNAM=$P(DATA,U) Q:'$L(SCPNAM)
 ..S ^TMP("SCRPT",$J,0,0,"PLIST",SCDIV,SCTEAM,SCPNAM,SCPTPA)=DATA
 ..S ^TMP("SCRPT",$J,0,0,"BTPA",SCDIV,DFN)=""
 ..S ^TMP("SCRPT",$J,0,0,"BTPA",0,DFN)=""
 ..Q
 .Q
 ;count total uniques and open slots
 M ^TMP("SCRPT",$J,2,SCTEAM,"TPTS")=^TMP("SCRPT",$J,2,SCTEAM,"PPTS",1)
 K ^TMP("SCRPT",$J,2,SCTEAM,"PPTS")
 S DFN=0 F  S DFN=$O(^TMP("SCRPT",$J,2,SCTEAM,"TPTS",DFN)) Q:'DFN  D
 .S SCY(10)=SCY(10)+1
 .Q
 S SCY(6)=SCY(2)-SCY(10) S:SCY(6)<0 SCY(6)=0
 K ^TMP("SCRPT",$J,2)
 ;Move team data to report and division totals
 I SCY(1)="YES" D
 .S $P(^TMP("SCRPT",$J,0,0),U)="YES"
 .S $P(^TMP("SCRPT",$J,1,SCDIV),U)="YES"
 .S $P(^TMP("SCRPT",$J,1,SCDIV,"TEAM",SCTEAM),U)="YES"
 .Q
 F SCI=2:1:6 D
 .S $P(^TMP("SCRPT",$J,0,0),U,SCI)=$P($G(^TMP("SCRPT",$J,0,0)),U,SCI)+SCY(SCI)
 .S $P(^TMP("SCRPT",$J,1,SCDIV),U,SCI)=$P($G(^TMP("SCRPT",$J,1,SCDIV)),U,SCI)+SCY(SCI)
 .S $P(^TMP("SCRPT",$J,1,SCDIV,"TEAM",SCTEAM),U,SCI)=$P($G(^TMP("SCRPT",$J,1,SCDIV,"TEAM",SCTEAM)),U,SCI)+SCY(SCI)
 .Q
 F SCI=7:1:12 D
 .S $P(^TMP("SCRPT",$J,1,SCDIV,"TEAM",SCTEAM),U,SCI)=SCY(SCI)
 .Q
 Q
 ;
RPT(X) ;Return report section value
 Q $S(X=1:SCDIV,X=2:SCTEAM,1:0)
 ;
COUNT ;Count division and report uniques
 S SCDIV="" F  S SCDIV=$O(^TMP("SCRPT",$J,1,SCDIV)) Q:SCDIV=""  D
 .K SCY F SCI=7:1:12 S SCY(SCI)=""
 .S DFN=0 F  S DFN=$O(^TMP("SCRPT",$J,1,SCDIV,"TPTS",DFN)) Q:'DFN  D
 ..S SCY(7)=SCY(7)+1
 ..Q
 .F SCI=0,1 S DFN=0 D
 ..F  S DFN=$O(^TMP("SCRPT",$J,1,SCDIV,"PPTS",SCI,DFN)) Q:'DFN  D
 ...S SCY(8+SCI)=SCY(8+SCI)+1
 ...Q
 ..Q
 .M ^TMP("SCRPT",$J,1,SCDIV,"PPTS",1)=^TMP("SCRPT",$J,1,SCDIV,"PPTS",0)
 .M ^TMP("SCRPT",$J,1,SCDIV,"TPTS")=^TMP("SCRPT",$J,1,SCDIV,"PPTS",1)
 .K ^TMP("SCRPT",$J,1,SCDIV,"PPTS")
 .S DFN=0 F  S DFN=$O(^TMP("SCRPT",$J,1,SCDIV,"TPTS",DFN)) Q:'DFN  D
 ..S SCY(10)=SCY(10)+1
 ..Q
 .K ^TMP("SCRPT",$J,1,SCDIV,"TPTS")
 .F SCI="BTA","BTPA" S DFN=0 D
 ..F  S DFN=$O(^TMP("SCRPT",$J,0,0,SCI,SCDIV,DFN)) Q:'DFN  D
 ...S SCY($S(SCI="BTA":11,1:12))=SCY($S(SCI="BTA":11,1:12))+1
 ...Q
 ..K ^TMP("SCRPT",$J,0,0,SCI,SCDIV)
 ..Q
 .F SCI=7:1:12 D
 ..S $P(^TMP("SCRPT",$J,1,SCDIV),U,SCI)=SCY(SCI)
 ..Q
 .Q
 ;count report uniques
 K SCY F SCI=7:1:12 S SCY(SCI)=""
 S DFN=0 F  S DFN=$O(^TMP("SCRPT",$J,0,0,"TPTS",DFN)) Q:'DFN  D
 .S SCY(7)=SCY(7)+1
 .Q
 F SCI=0,1 S DFN=0 D
 .F  S DFN=$O(^TMP("SCRPT",$J,0,0,"PPTS",SCI,DFN)) Q:'DFN  D
 ..S SCY(8+SCI)=SCY(8+SCI)+1
 ..Q
 .Q
 M ^TMP("SCRPT",$J,0,0,"PPTS",1)=^TMP("SCRPT",$J,0,0,"PPTS",0)
 M ^TMP("SCRPT",$J,0,0,"TPTS")=^TMP("SCRPT",$J,0,0,"PPTS",1)
 K ^TMP("SCRPT",$J,0,0,"PPTS")
 S DFN=0 F  S DFN=$O(^TMP("SCRPT",$J,0,0,"TPTS",DFN)) Q:'DFN  D
 .S SCY(10)=SCY(10)+1
 .Q
 K ^TMP("SCRPT",$J,0,0,"TPTS")
 F SCI="BTA","BTPA" S DFN=0 D
 .F  S DFN=$O(^TMP("SCRPT",$J,0,0,SCI,0,DFN)) Q:'DFN  D
 ..S SCY($S(SCI="BTA":11,1:12))=SCY($S(SCI="BTA":11,1:12))+1
 ..Q
 .K ^TMP("SCRPT",$J,0,0,SCI,0)
 .Q
 F SCI=7:1:12 D
 .S $P(^TMP("SCRPT",$J,0,0),U,SCI)=SCY(SCI)
 .Q
 Q
 ;
FOOT ;Summary report footer
 N SCI
 F SCI=1:1:80 W ! Q:$Y>(IOSL-9)
 W !,SCLINE
 W !,"NOTE: This report represents a count of team and team position assignments within the date range selected.  If a date range"
 W !?6,"larger than one day has been selected, the total unique patients and assignments may be greater than the maximum defined"
 W !?6,"for the team, reducing the open slots reflected by this report accordingly.  However, this does not imply that the team"
 W !?6,"had more than its maximum number of patients on any single date."
 W !,SCLINE
 Q
