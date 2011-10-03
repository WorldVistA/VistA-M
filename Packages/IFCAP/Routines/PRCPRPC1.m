PRCPRPC1 ;WISC/RFJ,DWA-patient distribution costs (sort) ; 06/23/2009  2:12 PM
 ;;5.1;IFCAP;**27,136**;Oct 20, 2000;Build 6
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ;
SORT ;  sort data
 K ^TMP($J,"PRCPRPCR"),^TMP($J,"PRCPRPCRT")
 S DA=DATESTRT-.00000001
 F  S DA=$O(^PRCP(446.1,DA)) Q:'DA!($P(DA,".")>DATEEND)  S DATA=$G(^(DA,0)),SURGDATA=$G(^(130)) I DATA'="" D
 .   ;  check distribution point
 .   S DISTRPT=+$P(DATA,"^",6)
 .   I 'DISTRPT,'$G(DISTRALL) Q
 .   I $G(DISTRALL),$D(^TMP($J,"PRCPURS3","NO",DISTRPT)) Q
 .   I '$G(DISTRALL),'$D(^TMP($J,"PRCPURS3","YES",DISTRPT)) Q
 .   S DISTRNM=$P($$INVNAME^PRCPUX1(DISTRPT),"-",2) S:DISTRNM="" DISTRNM=" "
 .   ;
 .   ;  check surgical specialty
 .   S SURGSPEC=$P($G(^SRO(137.45,+$P(SURGDATA,"^",3),0)),"^") S:SURGSPEC="" SURGSPEC=" "
 .   I SURGSPEC']PRCPSURS!(PRCPSURE']SURGSPEC) Q
 .   ;
 .   ;  check patient
 .   S DFN=+$P(DATA,"^",3),(PATNAME,SSN)=" " I $$VERSION^XPDUTL("DG"),DFN D DEM^VADPT
 .   S PATNAME=$G(VADM(1)),SSN=$P($G(VADM(2)),"^",2)
 .   I PATNAME']PRCPPATS!(PRCPPATE']PATNAME) Q
 .   ;
 .   ;  check opcode
 .   S OPCODE=$P($$ICPT^PRCPCUT1(+$P(SURGDATA,U),+DATA),"^") I OPCODE="" S OPCODE=" "
 .   I OPCODE']PRCPOPCS!(PRCPOPCE']OPCODE) Q
 .   ;
 .   S INOUTPAT=$P(DATA,"^",4) I INOUTPAT="" S INOUTPAT=" "
 .   S ^TMP($J,"PRCPRPCR",$E(DISTRNM,1,15),$E(SURGSPEC,1,15),INOUTPAT,$E($P(PATNAME,","),1,4)_"-"_$E($P(SSN,"-",3),1,4),OPCODE,DA)=$P(SURGDATA,"^",2)_"^"_$P(SURGDATA,"^",4)_"^"_$P(DATA,"^",5)
 Q
