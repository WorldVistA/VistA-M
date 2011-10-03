PRCPRLAS ;WISC/RFJ-last procurement source for item report          ;22 Jul 91
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 N %,PRCPINV,X W !?2,"START WITH NSN: FIRST// @    <<-- ENTER '@' TO PRINT ITEMS WITHOUT A NSN"
 S PRCPINV=$$INVNAME^PRCPUX1(PRCP("I")),DIC="^PRCP(445,",L=0,FLDS="[PRCP REPORT:LAST SOURCE]",BY=".01,1,@.01:5;""NSN""",FR=PRCPINV_",?",TO=PRCPINV_",?",DIOEND="D END^PRCPUREP" D EN1^DIP Q
 ;
GETLAS ;called from print template PRCP REPORT:LAST SOURCE
 ;gets last procurement source for FCP
 I '$G(PRCP("I"))!('$D(PRC("SITE"))) Q
 N %,D,L,PRCPD,PRCPFCP,PRCPLIDA,PRCPQ,V,V1
 S PRCPFCP=+$$FCPDA^PRCPUX1(PRC("SITE"),PRCP("I"))
 S (%,D,L)=0 F  S %=$O(^PRC(441,D1,4,PRCPFCP,1,%)) Q:%=""  S X=$P($G(^PRC(442,%,1)),"^",15) I X>D S D=X,L=%
 I D=0 D  Q
 .   S V=+$P($G(^PRC(441,D1,0)),"^",4),V1=$P($G(^PRC(440,V,0)),"^") Q:V1=""
 .   W !?4,"LAST VENDOR",?24,"[#V]",!?4,$E(V1,1,18),?24,"[#",V,"]"
 S V=$P($G(^PRC(442,L,1)),"^"),V1=$P($G(^PRC(440,V,0)),"^")
 S PRCPLIDA=$O(^PRC(442,L,2,"AE",D1,0)) Q:PRCPLIDA=""  S PRCPD=$G(^PRC(442,L,2,PRCPLIDA,0)),(%,PRCPQ)=0 F  S %=$O(^PRC(442,L,2,PRCPLIDA,3,%)) Q:%=""!(%'?.N)  S PRCPQ=$P($G(^(%,0)),"^",2)
 W !?4,"LAST VENDOR",?24,"[#V]",?33,"P.O. #",?41,"UNIT per RECPT",?58,"UNIT PRICE",?72,"QTY RECD",!?4,$E(V1,1,18),?24,"[#",V,"]",?33,$P($P($G(^PRC(442,L,0)),"^"),"-",2)
 W ?41,$J($$UNITVAL^PRCPUX1($P(PRCPD,"^",12),$P(PRCPD,"^",3)," per "),11),?58,$J($P(PRCPD,"^",9),10,3),?70,$J(PRCPQ,10) Q
