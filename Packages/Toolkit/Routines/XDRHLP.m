XDRHLP ;IHS/LAB/OHPRD;help logic for selected fields in 15, 15.1; [ 10/20/92  11:01 AM ]
 ;;7.3;TOOLKIT;;Apr 25, 1995
 ;
 ;this routine is called from files 15 and 15.1 and contains 
 ;executable help prompts
 ;
 Q  ;no entry from top of routine, must use appropriate entry points
 ;
MD04 ;EP;called from .04 field of file 15, merge direction executable help
 S %=$P(^VA(15,DA,0),U,1,2) W !?5,"RECORD1=",$P(@(U_$P($P(%,U,1),";",2)_+%_",0)"),U,1)
 I $G(DUZ("AG"))="I",$P($P(%,U,1),";",2)="DPT(" D
 .S XDRHLP("F")=0,XDRHLP("I")=0
 .F XDRHLP("I")=0:1 S XDRHLP("F")=$O(^AUPNPAT(+%,41,XDRHLP("F"))) Q:XDRHLP("F")'=+XDRHLP("F")  D
 ..W:XDRHLP("I") ! W ?40," ",$J($P(^AUTTLOC(XDRHLP("F"),0),U,7),4)," ",$P(^AUPNPAT(+%,41,XDRHLP("F"),0),U,2),$S($P(^(0),U,3)="":"",1:"("_$P(^(0),U,5)_")")
 ..Q
 .K XDRHLP("F")
 .Q
 W !!,?5,"RECORD2=",$P(@(U_$P($P(%,U,2),";",2)_+$P(%,U,2)_",0)"),U,1)
 I $G(DUZ("AG"))="I",$P($P(%,U,1),";",2)="DPT(" D
 .S XDRHLP("F")=0,XDRHLP("I")=0
 .F XDRHLP("I")=0:1 S XDRHLP("F")=$O(^AUPNPAT(+$P(%,U,2),41,XDRHLP("F"))) Q:XDRHLP("F")'=+XDRHLP("F")  D
 ..W:XDRHLP("I") ! W ?40," ",$J($P(^AUTTLOC(XDRHLP("F"),0),U,7),4)," ",$P(^AUPNPAT(+$P(%,U,2),41,XDRHLP("F"),0),U,2),$S($P(^(0),U,3)="":"",1:"("_$P(^(0),U,5)_")")
 ..Q
 .K XDRHLP
 .Q
 W !
 Q
