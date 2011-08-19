ECINCPT ;ALB/JAM-Procedure Codes with Inactive CPTs Report ; 08/01/05
 ;;2.0; EVENT CAPTURE ;**72**;8 May 96
 ; Routine to report National/Local Procedure Codes with Inactive CPT 
 ; Codes Report
EN ;entry point
 N ZTIO,ZTDESC,ZTRTN,ECPG,ECOUT
 S ZTIO=ION
 S ZTDESC="NATIONAL/LOCAL PROCEDURE CODES WITH INACTIVE CPT"
 S ZTRTN="START^ECINCPT"
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE)
 I POP Q
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 Q
START ; Routine execution
 N ECI,EC0,ECPT,ECN,ECD,ECPI,ECDT,ECPG,ECOUT,ECRDT
 S (ECI,ECOUT)=0,ECPG=1
 S %H=$H S ECRDT=$$HTE^XLFDT(%H,1)
 D HEADER
 F  S ECI=$O(^EC(725,ECI)) Q:'ECI  D  I ECOUT Q
 .S EC0=$G(^EC(725,ECI,0)),ECPT=$P(EC0,"^",5)
 .Q:EC0=""  Q:ECPT=""
 .S ECN=$P(EC0,"^",2),ECD=$P(EC0,"^"),ECPI=$$CPT^ICPTCOD(ECPT)
 .Q:+ECPI<1  Q:$P(ECPI,"^",7)
 .S ECDT=$TR($$FMTE^XLFDT($P(ECPI,"^",8),"2F")," ","0")
 .I ($Y+3)>IOSL D PAGE Q:ECOUT  D HEADER
 .W !,ECN,?10,ECD,?60,$P(ECPI,"^",2),?68,ECDT
 I 'ECOUT D PAGE
 Q
HEADER ;
 W:$E(IOST,1,2)="C-"!(ECPG>1) @IOF
 W !!,"NATIONAL/LOCAL PROCEDURE CODES WITH INACTIVE CPT CODES"
 W ?68,"Page: ",ECPG,!?25,"Run Date : ",ECRDT,!
 W "National",?60,"CPT",?68,"Inactive",!
 W "Number",?10,"National Name",?60,"Code",?68,"Date",!
 S ECPG=ECPG+1
 F I=1:1:80 W "-"
 Q
PAGE ;
 N SS,JJ
 I $D(ECPG),$E(IOST,1,2)="C-" D
 . S SS=22-$Y F JJ=1:1:SS W !
 . S DIR(0)="E" W ! D ^DIR K DIR I 'Y S ECOUT=1
 Q
