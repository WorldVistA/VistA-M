SDECF2 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
HRCN(PAT,SITE) ;EP; return chart number for patient at this site
 ;called by ADT ITEMS file
 I $G(PAT)="" Q ""  ;cmi/maw 6/12/2008 PATCH 1009 added for missing pat node in file 44 for appt
 Q $P($G(^AUPNPAT(PAT,41,SITE,0)),U,2)
 ;
HRCND(X) ;EP; add dashes to chart # passed as X
 ;called by ADT ITEMS file
 S X="00000"_X,X=$E(X,$L(X)-5,$L(X))
 S X=$E(X,1,2)_"-"_$E(X,3,4)_"-"_$E(X,5,6)
 Q X
 ;
HRCNT(X) ;EP; return terminal digit format of chart # passed as X
 NEW STYLE ;S STYLE=$$GET1^DIQ(9009020.2,$$DIV^SDECU,.09,"I") I STYLE="" S STYLE="A"
 S STYLE="A"
 S X="00000"_X,X=$E(X,$L(X)-5,$L(X))
 I STYLE="A" S X=$E(X,5,6)_"-"_$E(X,3,4)_"-"_$E(X,1,2)
 E  S X=$E(X,5,6)_"-"_$E(X,1,2)_"-"_$E(X,3,4)
 Q X
 ;
NAMEPRT(DFN,CONVERT) ;EP; return printable name
 ;CONVERT=1 means convert to mixed case letters
 NEW VADM,X
 D DEM^VADPT
 S X=$P($P(VADM(1),",",2)," ")_" "_$P(VADM(1),",")
 I $G(CONVERT) X ^DD("FUNC",14,1)
 Q X
 ;
DEAD(PAT) ;EP; returns 1 if patient has died
 Q $S($G(^DPT(PAT,.35)):1,1:0)
 ;
DOD(PAT) ;EP; returns patient's date of death
 Q $$GET1^DIQ(2,PAT,.351)
