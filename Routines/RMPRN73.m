RMPRN73 ;HINES/HNC -NPPD CALCULATIONS - CONT; 02/14/01
 ;;3.0;PROSTHETICS;**57,70,72,77**;Feb 09, 1996
 ;
 ;DBIA # 801 - for this routine, the agreement covers the field
 ;             #.05 Short Description, file #441
 ;
 ;DBIA #10060 - Fileman read of file #200
 ;RVD patch 77 - defined the WHO variable.
CODE N I,NULINE
 ;
 ; read in NPPD new
 F I=1:1 S NULINE=$P($T(DES+I^RMPRN72),";;",2) Q:$E(NULINE)="R"  D
 . S $P(^TMP($J,"N",STN,$P(NULINE,";",1)),U,15)=$P(NULINE,";",2)
 . S ^TMP($J,"RMPRCODE",$P(NULINE,";",1))=$P(NULINE,";",2)
 . Q
 S $P(^TMP($J,"RMPRCODE"),U,1)=I-1 ;store number of new lines
 ;
 ; read in NPPD repair
 F I=0:1 S NULINE=$P($T(REP+I^RMPRN72),";;",2) Q:$E(NULINE)'="R"  D
 . S $P(^TMP($J,"R",STN,$P(NULINE,";",1)),U,15)=$P(NULINE,";",2)
 . S ^TMP($J,"RMPRCODE",$P(NULINE,";",1))=$P(NULINE,";",2)
 . Q
 S $P(^TMP($J,"RMPRCODE"),U,2)=I ;store number of repair lines
 Q
HOLD ;hold screen
 K DIR I IOST["C-" W !! S DIR(0)="E" D ^DIR S:+Y'>0 FL=1
 Q
HDR W @IOF S PAGE=PAGE+1
 W !,LN,!,CODE
 W ?10,^TMP($J,"RMPRCODE",CODE)
 W ?35,DATE(3)," - ",DATE(4)
 W ?70,"Page: ",PAGE
 W !,LN,!
 I IOM<119 W "NAME",?10,"SSN",?16,"HCPCS",?22,"QTY",?27,"TYPE",?32,"COST",?42,"DATE",?48,"ITEM",?62,"HCPCS DES",?76,"WHO",!,LN
 I IOM>119 W "NAME",?10,"SSN",?16,"HCPCS",?22,"QTY",?27,"TYPE",?32,"COST",?42,"DATE",?48,"ITEM",?80,"HCPCS DES",?112,"WHO",?117,"#",!,LN
 Q
DESP ;desplay detail records
 S FL=""
 S CODE=""
 F  S CODE=$O(^TMP($J,CODE)) Q:CODE="N"  G:FL=1 EXIT D
 .D HDR
 .S RDX=0
 .F  S RDX=$O(^TMP($J,CODE,RDX)) D:RDX'>0 HOLD Q:RDX'>0  Q:FL=1  D
 ..S DFN=$P(^RMPR(660,RDX,0),U,2) Q:DFN=""
 ..D DEM^VADPT
 ..I $Y+6>IOSL,IOST["C-" K DIR W !! S DIR(0)="E" D ^DIR S:+Y'>0 FL=1 Q:+Y'>0  D HDR
 ..I $Y+6>IOSL,IOST'["C-" D HDR
 ..W !,$E($P(VADM(1),",",1),1,9)
 ..W ?10,$P(VADM(2),"-",3)
 ..S TYPE=$P(^RMPR(660,RDX,0),U,4)
 ..S QTY=$P(^RMPR(660,RDX,0),U,7)
 ..S HCPCS=$P(^RMPR(661.1,$P(^RMPR(660,RDX,1),U,4),0),U,1)
 ..S HCPCSD=$P(^RMPR(661.1,$P(^RMPR(660,RDX,1),U,4),0),U,2)
 ..S WHO=$$GET1^DIQ(200,$P($G(^RMPR(660,RDX,0)),U,27),1)
 ..I $G(RDX) S OPEN=$P(^RMPR(660,RDX,0),U,12)
 ..I OPEN="" S OPEN="*"
 ..E  S OPEN=" "
 ..S COST=^TMP($J,CODE,RDX)
 ..S SOURCE=$P(^RMPR(660,RDX,0),U,14)
 ..S DATE=$P(^RMPR(660,RDX,0),U,1),DATE=$E(DATE,4,5)_"/"_$E(DATE,6,7)
 ..S ITEM=$P(^PRC(441,$P(^RMPR(661,$P(^RMPR(660,RDX,0),U,6),0),U,1),0),U,2)
 ..I IOM<119 W ?16,HCPCS,?22,QTY,?27,TYPE,?29,SOURCE,?32,OPEN,COST,?42,DATE,?48,$E(ITEM,1,11),?61,"|",?62,$E(HCPCSD,1,12),?76,WHO
 ..I IOM>118 W ?16,HCPCS,?22,QTY,?27,TYPE,?29,SOURCE,?32,OPEN,COST,?42,DATE,?48,$E(ITEM,1,29),?79,"|",?80,$E(HCPCSD,1,30),?112,WHO,?117,RDX
 Q
DESPR ;repair dispaly
 ;
 S CODE="R1"
 F  S CODE=$O(^TMP($J,CODE)) Q:CODE["RMPR"  Q:FL=1  D
 .D HDR
 .S RDX=0
 .F  S RDX=$O(^TMP($J,CODE,RDX)) D:RDX'>0 HOLD Q:RDX'>0  Q:FL=1  D
 ..S DFN=$P(^RMPR(660,RDX,0),U,2) Q:DFN=""
 ..D DEM^VADPT
 ..Q:FL=1
 ..I $Y+6>IOSL,IOST["C-" K DIR W !! S DIR(0)="E" D ^DIR S:+Y'>0 FL=1 Q:+Y'>0  D HDR
 ..I $Y+6>IOSL,IOST'["C-" D HDR
 ..W !,$E($P(VADM(1),",",1),1,9)
 ..W ?10,$P(VADM(2),"-",3)
 ..S TYPE=$P(^RMPR(660,RDX,0),U,4)
 ..S QTY=$P(^RMPR(660,RDX,0),U,7)
 ..S SOURCE=$P(^RMPR(660,RDX,0),U,14)
 ..I $P(^RMPR(660,RDX,0),U,17)'="" S HCPCS="#SHIP",ITEM="SHIPPING"
 ..I $P(^RMPR(660,RDX,0),U,26)'="" S HCPCS="#PICK",ITEM="PICKUP/DEL"
 ..S:$G(HCPCS)'["#" HCPCS=$P(^RMPR(661.1,$P(^RMPR(660,RDX,1),U,4),0),U,1)
 ..S:$G(HCPCS)'["#" HCPCSD=$P(^RMPR(661.1,$P(^RMPR(660,RDX,1),U,4),0),U,2)
 ..I $G(HCPCS)["#S" S HCPCSD="SHIPPING"
 ..I $G(HCPCS)["#P" S HCPCSD="PICKUP/DEL",SOURCE="C"
 ..I $G(RDX) S OPEN=$P(^RMPR(660,RDX,0),U,12)
 ..S WHO=$$GET1^DIQ(200,$P($G(^RMPR(660,RDX,0)),U,27),1)
 ..I OPEN="" S OPEN="*"
 ..E  S OPEN=" "
 ..S COST=^TMP($J,CODE,RDX)
 ..;S SOURCE=$P(^RMPR(660,RDX,0),U,14)
 ..S DATE=$P(^RMPR(660,RDX,0),U,1),DATE=$E(DATE,4,5)_"/"_$E(DATE,6,7)
 ..S:$G(HCPCS)'["#" ITEM=$P(^PRC(441,$P(^RMPR(661,$P(^RMPR(660,RDX,0),U,6),0),U,1),0),U,2)
 ..I IOM<119 W ?16,HCPCS,?22,QTY,?27,TYPE,?29,SOURCE,?32,OPEN,COST,?42,DATE,?48,$E(ITEM,1,12),?62,$E(HCPCSD,1,12),?76,WHO
 ..I IOM>118 W ?16,HCPCS,?22,QTY,?27,TYPE,?29,SOURCE,?32,OPEN,COST,?42,DATE,?48,$E(ITEM,1,29),?79,"|",?80,$E(HCPCSD,1,30),?112,WHO,?117,RDX
 ..K ITEM,HCPCSD,HCPCS
 Q
EXIT ;
 Q
 ;END
