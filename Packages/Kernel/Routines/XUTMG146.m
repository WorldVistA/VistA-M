XUTMG146 ;SEA/RDS - TaskMan: Globals: X-Refs For File 14.6 ;1/18/91  17:01 ;
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
 Q
 ;
S01 ;set statement for field .01
 I $P(ZT,U,2)]"",$P(ZT,U,3)]"",$P(ZT,U,4)]"" S ^%ZIS(14.6,"AT",X,$P(ZT,U,2),$P(ZT,U,3),$P(ZT,U,4))=""
 I $P(ZT,U,2)]"" S ^%ZIS(14.6,"AV",$P(ZT,U,2),X,DA)=""
 Q
 ;
K01 ;kill statement for field .01
 I $P(ZT,U,2)]"",$P(ZT,U,3)]"",$P(ZT,U,4)]"" K ^%ZIS(14.6,"AT",X,$P(ZT,U,2),$P(ZT,U,3),$P(ZT,U,4))
 I $P(ZT,U,2)]"" K ^%ZIS(14.6,"AV",$P(ZT,U,2),X,DA)
 Q
 ;
 ;-------------------------------------------------------------------
 ;
S15 ;set statement for field 1.5
 I $P(ZT,U)]"",$P(ZT,U,3)]"",$P(ZT,U,4)]"" S ^%ZIS(14.6,"AT",$P(ZT,U),X,$P(ZT,U,3),$P(ZT,U,4))=""
 I $P(ZT,U)]"" S ^%ZIS(14.6,"AV",X,$P(ZT,U),DA)=""
 Q
 ;
K15 ;kill statement for field 1.5
 I $P(ZT,U)]"",$P(ZT,U,3)]"",$P(ZT,U,4)]"" K ^%ZIS(14.6,"AT",$P(ZT,U),X,$P(ZT,U,3),$P(ZT,U,4))
 I $P(ZT,U)]"" K ^%ZIS(14.6,"AV",X,$P(ZT,U),DA)
 Q
 ;
 ;-------------------------------------------------------------------
 ;
S25 ;set statement for field 2.5
 I $P(ZT,U)]"",$P(ZT,U,2)]"",$P(ZT,U,4)]"" S ^%ZIS(14.6,"AT",$P(ZT,U),$P(ZT,U,2),X,$P(ZT,U,4))=""
 I $P(ZT,U,4)]"" S ^%ZIS(14.6,"AV",X,$P(ZT,U,4),DA)=""
 Q
 ;
K25 ;kill statement for field 2.5
 I $P(ZT,U)]"",$P(ZT,U,2)]"",$P(ZT,U,4)]"" K ^%ZIS(14.6,"AT",$P(ZT,U),$P(ZT,U,2),X,$P(ZT,U,4))
 I $P(ZT,U,4)]"" K ^%ZIS(14.6,"AV",X,$P(ZT,U,4),DA)
 Q
 ;
 ;-------------------------------------------------------------------
 ;
S3 ;set statement for field 3
 I $P(ZT,U)]"",$P(ZT,U,2)]"",$P(ZT,U,3)]"" S ^%ZIS(14.6,"AT",$P(ZT,U),$P(ZT,U,2),$P(ZT,U,3),X)=""
 I $P(ZT,U,3)]"" S ^%ZIS(14.6,"AV",$P(ZT,U,3),X,DA)=""
 Q
 ;
K3 ;kill statement for field 3
 I $P(ZT,U)]"",$P(ZT,U,2)]"",$P(ZT,U,3)]"" K ^%ZIS(14.6,"AT",$P(ZT,U),$P(ZT,U,2),$P(ZT,U,3),X)
 I $P(ZT,U,3)]"" K ^%ZIS(14.6,"AV",$P(ZT,U,3),X,DA)
 Q
 ;
 ;
