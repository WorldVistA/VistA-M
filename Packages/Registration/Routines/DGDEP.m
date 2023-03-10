DGDEP ;ALB/CAW,BAJ,ARF - Dependent Driver ; 8/1/08 12:55pm
 ;;5.3;Registration;**45,688,1014**;Aug 13, 1993;Build 42
 ;
EN ;
 S VALMBCK=""
 D WAIT^DICD,EN^VALM("DGMT DEPENDENTS")
 S VALMBCK="R"
ENQ K DEP,DGCNT,DGDEP,DGIR0,DGINI,DGLN,DGPRI,DGREL,^TMP("DGDEP",$J)
 Q
 ;
PAT ; Patient Lookup
 N DIC,Y
 S DIC="^DPT(",DIC(0)="AEMQZ" D ^DIC I Y'>0 G PATQ
 I ($G(DTOUT)!$G(DUOUT)) G PATQ
 S DFN=+Y
PATQ Q
 ;
HDR ; Header
 N VA,VAERR,SSNV
 D PID^VADPT
 ; Capture and display SSN Verification Status with SSN  BAJ DG*5.3*688 11/22/2005
 D GETSTAT^DGRP1(.SSNV)
 I $G(DGSCR8) D  G HDRQ
 .S X="",VALMHDR(1)="                      FAMILY DEMOGRAPHIC DATA, SCREEN <8>"
 .S VALMHDR(1)=$$SETSTR^VALM1(X,VALMHDR(1),80-$L(X),$L(X))
 .D LISTHDR^DGRPU(2) ;DG*5.3*1014 - ARF - sets patient data in the 2nd and 3rd entries in VALMHDR array
 .;S VALMHDR(2)=$E($P("Patient: "_$G(^DPT(DFN,0)),"^",1),1,30)_" ("_VA("PID")_")"_" "_SSNV ;DG*5.3*1014
 .;S X=$S($D(^DPT(DFN,.1)):"Ward: "_^(.1),1:"Outpatient")  ;DG*5.3*1014 and next line ;DG*5.3*1014 - Ward removed
 .;S VALMHDR(2)=$$SETSTR^VALM1(X,VALMHDR(2),80-$L(X),$L(X)) ;DG*5.3*1014
 S X="",VALMHDR(1)="                     MARITAL STATUS/DEPENDENTS, SCREEN <1>"
 S VALMHDR(2)=$E($P("Patient: "_$G(^DPT(DFN,0)),"^",1),1,30)_" ("_VA("PID")_")"_" "_SSNV
 S X=$S($D(^DPT(DFN,.1)):"Ward: "_^(.1),1:"Outpatient")
 S VALMHDR(2)=$$SETSTR^VALM1(X,VALMHDR(2),80-$L(X),$L(X))
HDRQ Q
 ;
INIT ; Find all dependents
 K DGDEP("DGDEP",$J),^TMP("DGDEP",$J)
 N CNT,DGDATE,DGDDEP0,DGINCP,DGINI,DGIRI,DGWHERE
 D NEW^DGRPEIS1 ; Sets up veteran in person file
 ; Get all active dependents
 D ALL^DGMTU21(DFN,"VSD",$S($G(DGMTDT):DGMTDT,1:DT),"IPR",$G(DGMTI))
 ;
 ; Get all dependents active and inactive
 S (CNT,DGDEP)=0,DGLN=1
 F  S DGDEP=$O(^DGPR(408.12,"B",DFN,DGDEP)) Q:'DGDEP  D
 .N DGDEP0 S CNT=CNT+1
 .S DGDEP0=^DGPR(408.12,DGDEP,0)
 .D GETIENS^DGMTU2(DFN,+DGDEP,$S($G(DGMTDT):DGMTDT,1:DT)) ;Get Annual Income IEN and Income Person IEN
 .S DGWHERE=$P(DGDEP0,U,3)
 .S DGINCP=$G(@("^"_$P(DGWHERE,";",2)_+DGWHERE_",0)"))
 .S DGDEP("DGDEP",$J,$P(DGDEP0,U,2),CNT)=DGINCP
 .S $P(DGDEP("DGDEP",$J,$P(DGDEP0,U,2),CNT),U,20)=DGDEP
 .S $P(DGDEP("DGDEP",$J,$P(DGDEP0,U,2),CNT),U,21)=$S($G(DGINI):DGINI,1:$G(DGINC))
 .S $P(DGDEP("DGDEP",$J,$P(DGDEP0,U,2),CNT),U,22)=$S($G(DGIRI):DGIRI,1:$G(DGINR))
 .N DGEDATE S DGEDATE=0
 .F  S DGEDATE=$O(^DGPR(408.12,DGDEP,"E",DGEDATE)) Q:'DGEDATE  D
 ..S DGDATE=^DGPR(408.12,DGDEP,"E",DGEDATE,0)
 ..S DGDEP("DGDEP",$J,$P(DGDEP0,U,2),CNT,-$P(DGDATE,U))=DGDATE
 D RETDEP^DGDEP0
 S VALMCNT=DGLN-1
 Q
 ;
SET(X) ; Set in array
 ;
 S ^TMP("DGDEP",$J,DGLN,0)=X,^TMP("DGDEP",$J,"IDX",CNT,CNT)=""
 S DGLN=DGLN+1
 Q
