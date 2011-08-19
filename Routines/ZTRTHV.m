ZTRTHV ;ISCSF/HVB - RTHIST SUMMARY (VAX DSM) ;01/18/95  13:47
 ;;7.3;TOOLKIT;;Apr 25, 1995
A D ^%ZIS Q:POP  U IO
 S (NODE,SUB)="" F  S NODE=$O(^RTH(NODE)) Q:NODE=""  D HDR F  S SUB=$O(^RTH(NODE,SUB)) Q:SUB=""  S %H=^(SUB,"STIME") D YX^%DTC,HDR:$E(IOST)="P"&($Y>IOSL) D
 .S SECS=$P(^RTH(NODE,SUB,"ETIME"),",",1)-$P(^("STIME"),",",1)*86400+$P(^("ETIME"),",",2)-$P(^("STIME"),",",2)
 .W !,$J(NODE,7),$J(SUB,4),?12,$TR(Y," :"),?29,$J(SECS\60_":"_$S($L(SECS#60)=2:SECS#60,1:0_(SECS#60)),6)
 .W $J(^RTH(NODE,SUB,"ROUREF")*10/SECS+.5\1/10,7,1),$J(^("MAPROU")*10/SECS+.5\1/10,7,1),$J(^("Global Gets")*10/SECS+.5\1/10,7,1),$J(^("Global Sets")*10/SECS+.5\1/10,7,1),$J(^("Global Kills")*10/SECS+.5\1/10,7,1)
 .W $J(^RTH(NODE,SUB,"Logical Reads")*10/SECS+.5\1/10,8,1),$J(^("Physical Reads")*10/SECS+.5\1/10,7,1),$J(^("Logical Writes")*10/SECS+.5\1/10,7,1),$J(^("Physical Writes")*10/SECS+.5\1/10,7,1)
 .W $J(^RTH(NODE,SUB,"TOTIME")*10/SECS+.5\1/10,7,1) W:$D(^("DDP","[TOTAL","XMTS")) $J(^("XMTS")*10/SECS+.5\1/10,7,1)
 D ^%ZISC Q
HDR W #!,$J("NODE",7),$J("#",4),$J("STARTDATE @ STIME",18),$J("ET ",6),$J("ROUREF",7),$J("MAPROU",7),$J("GLOGET",7),$J("GLOSET",7),$J("GLOKIL",7),$J("LOGRD",8),$J("PHYSRD",7),$J("LOGWT",7),$J("PHYSWT",7),$J("ROUPCT",7),$J("DDPXMT",7),! Q
