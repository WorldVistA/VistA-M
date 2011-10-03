RAORDS ;HISC/CAH,DAD AISC/RMO-Select Patient's Requests ;6/7/00  16:34
 ;;5.0;Radiology/Nuclear Medicine;**15,21**;Mar 16, 1998
 Q:'$D(RADFN)  D HOME^%ZIS K ^TMP($J,"RAORDS"),RAOUT,RAORDS
 K ^TMP($J,"PRO-ORD"),^TMP($J,"PRO-REG")
 ; ^tmp($j,"pro-ord",proc-ien,order-ien) -- outstanding orders
 ; ^tmp($j,"pro-reg",proc-ien,order-ien) -- actually regist'd procs
 S ^TMP($J,"RAORDS","Unknown")=""
 S (RACNT,RASEQ,RAPARENT)=0,RAOSTSYM="dc^c^h^^p^^^s"
 K RAOSTSNM S X(1)=^DD(75.1,5,0) F I=1:1 S RAOSTS=$P(RAOVSTS,";",I) Q:RAOSTS=""  S X=$P($P(X(1),RAOSTS_":",2),";"),RAOSTSNM=$S('$D(RAOSTSNM):X,1:RAOSTSNM_", "_X)
 F RALP=1:1 S RAOSTS=$P(RAOVSTS,";",RALP) Q:RAOSTS=""  F RAOIFN=0:0 S RAOIFN=$O(^RAO(75.1,"AS",RADFN,RAOSTS,RAOIFN)) Q:'RAOIFN  I $D(^RAO(75.1,RAOIFN,0)) S RAORD0=^(0) D SETUTL
 I '$D(^TMP($J,"RAORDS"))!('RACNT) W !!?5,"No requests available to select for this patient.",! G Q
 F RAOURG=0:0 S RAOURG=$O(^TMP($J,"RAORDS",RAOURG)) Q:'RAOURG!($D(RAOSEL))  F RAODTI=0:0 S RAODTI=$O(^TMP($J,"RAORDS",RAOURG,RAODTI)) Q:'RAODTI!($D(RAOSEL))  D CHKORD
 ;
Q K ^TMP($J,"RAORDS"),RACNT,RACNT1,RADASH,RADUP,RAERR,RAI,RALCTN,RALOC
 K RALP,RANUM,RAOASTS,RAODTE,RAODTI,RAOFNS,RAOIFN,RAOIFNS,RAORD0,RAOSEL
 K RAOSTS,RAOSTSNM,RAOSTSYM,RAOURG,RAOVSTS,RAPHY,RAPAR,RAPRC,RAREQ
 K RASEL,RASEQ,RAX
 Q
 ;
SETUTL ; Check if option is to be screened.  If yes, apply the screen.
 I $P($G(^RAMIS(71,+$P(RAORD0,U,2),0)),U,6)="P",$O(^RAMIS(71,+$P(RAORD0,U,2),4,0))'>0 Q  ; Parent without descendents
 I $D(RAVSTFLG)#2,$P($G(^RAMIS(71,+$P(RAORD0,U,2),0)),U,6)="P" Q  ; Cannot choose parent in add exams option
 I $D(RASCREEN) D  Q:'$D(^TMP($J,"RA L-TYPE",RALCTN))
 . S RALCTN=+$P(RAORD0,"^",20)
 . S:'RALCTN RALCTN="Unknown" Q:RALCTN="Unknown"
 . S RALCTN=$S($D(^RA(79.1,RALCTN,0)):+$P(^(0),"^"),1:"Unknown")
 . Q:RALCTN="Unknown"
 . S RALCTN=$S($D(^SC(RALCTN,0)):$P(^(0),"^"),1:"Unknown")
 . Q
 S RACNT=RACNT+1,^TMP($J,"RAORDS",$S('$P(RAORD0,"^",6):9,1:$P(RAORD0,"^",6)),9999999.9999-$S($P(RAORD0,"^",21):$P(RAORD0,"^",21),1:$P(RAORD0,"^",16)),RAOIFN,RACNT)=RAORD0
 ; store order's indiv procedures
 I $P($G(^RAMIS(71,+$P(RAORD0,U,2),0)),U,6)'="P" S ^TMP($J,"PRO-ORD",$S($P(RAORD0,U,2):$P(RAORD0,U,2),1:0),RAOIFN)="" Q
 ; for parent orders, must store each descendant's proc ien
 S RA6=+$P(RAORD0,U,2),RA7=0
 F  S RA7=$O(^RAMIS(71,RA6,4,RA7)) Q:'RA7  S ^TMP($J,"PRO-ORD",+$P($G(^(RA7,0)),U),RAOIFN)="DESC"
 Q
 ;
CHKORD F RAOIFN=0:0 S RAOIFN=$O(^TMP($J,"RAORDS",RAOURG,RAODTI,RAOIFN)) Q:'RAOIFN!($D(RAOSEL))  F RACNT1=0:0 S RACNT1=$O(^TMP($J,"RAORDS",RAOURG,RAODTI,RAOIFN,RACNT1)) Q:RACNT1'>0!($D(RAOSEL))  S RAORD0=^(RACNT1) D PRTORD
 Q
 ;
PRTORD D HD:'(RASEQ#8) Q:$D(RAOSEL)  S RASEQ=RASEQ+1,RAOIFNS(RASEQ)=RAOIFN,RAPRC=$S($D(^RAMIS(71,+$P(RAORD0,"^",2),0)):$P(^(0),"^"),1:"Unknown"),RAODTE=9999999.9999-RAODTI
 S RAPHY=$S($D(^VA(200,+$P(RAORD0,"^",14),0)):$P(^(0),"^"),1:"Unknown"),RALOC=$S($D(^SC(+$P(RAORD0,"^",22),0)):$P(^(0),"^"),1:"Unknown")
 N RA6 S RA6=$S($P($G(^RAMIS(71,+$P(RAORD0,U,2),0)),U,6)="P"&($P($G(^(0)),U,18)="Y"):"+",1:"") ;parent proc and single rpt
 W !,$J(RASEQ,2),?4,$P(RAOSTSYM,"^",+$P(RAORD0,"^",5)),?8,$E($P($P(^DD(75.1,6,0),RAOURG_":",2),";"),1,7),?16,RA6
 W ?17,$E(RAPRC,1,25),?44,$E(RAODTE,4,5)_"/"_$E(RAODTE,6,7)_"/"_(1700+$E(RAODTE,1,3)),?56,$E(RAPHY,1,11),?69,$E(RALOC,1,11)
 W !?17,"(",$S($P(RAORD0,U,20)="":"UNKNOWN",1:$E($P($G(^SC(+$G(^RA(79.1,+$P(RAORD0,U,20),0)),0)),U),1,23)),")"
 D ASKSEL:RACNT=RASEQ
 Q
 ;
HD D ASKSEL:RASEQ Q:$D(RAOSEL)  W @IOF,!?16,"**** Requested Exams for ",$E(RANME,1,20)," ****",?65,$J(RACNT,3),?70,"Requests"
 W !?4,"St",?8,"Urgency",?17,"Procedure / (Img. Loc.)",?44,"Desired",?56,"Requester",?69,"Req'g Loc",!?4,"--",?8,"-------",?17,"-------------------------",?44,"----------",?56,"-----------",?69,"-----------"
 Q
 ;
ASKSEL K RADUP,RAORDS S (RAERR,RAI,RANUM)=0
 W:$D(RAOPT("REG")) !!,"(Use  Pn  to replace request 'n' with a Printset procedure.)"
 W:'$D(RAOPT("REG")) !
 W !,"Select Request(s) 1-",RASEQ,$S($D(RAOFNS):" to "_RAOFNS,1:"")," or '^' to Exit:  ",$S(RASEQ<RACNT:"Continue",1:"Exit"),"// " R X:DTIME S:'$T X="^",RAOUT="" S:X["^" RAOSEL=0 Q:X["^"!(X="")
 S RAX=X I RAX["?" W !!?3,"Please select the request(s) you want separated by commas or a range",!?3,"of numbers separated by a dash, or a combination of commas and dashes." D HLPSEL G ASKSEL
PARSE I $$UP^XLFSTR(RAX)?1"P".N D DPAR Q  ; detail-to-parent
 S RAI=RAI+1,RAPAR=$P(RAX,",",RAI) Q:RAPAR=""  I RAPAR?.N1"-".N S RADASH="" F RASEL=$P(RAPAR,"-"):1:$P(RAPAR,"-",2) D CHKSEL Q:RAERR
 I '$D(RADASH) S RASEL=RAPAR D CHKSEL
 K RADASH G ASKSEL:RAERR,PARSE
 ;
CHKSEL I $D(RADASH),+$P(RAPAR,"-",2)<+$P(RAPAR,"-") S RAERR=1 Q
 I RASEL'?.N W !?3,*7,"Item ",RASEL," is not a valid selection." S RAERR=1 Q
 I '$D(RAOIFNS(RASEL)) W !?3,*7,"Item ",RASEL," is not a valid selection." S RAERR=1 Q
 I $D(RADUP(RASEL)) W !?3,*7,"Item ",RASEL," was already selected." S RAERR=1 Q
 I $D(^RAO(75.1,+(RAOIFNS(RASEL)),0)),RAOVSTS'[$P(^(0),"^",5) W !?3,*7,"Item ",RASEL," does not have a valid status for this option.",!?3,"Valid statuses are ",RAOSTSNM,"." S RAERR=1 Q
 I RAPARENT,$P($G(^RAMIS(71,+$P($G(^RAO(75.1,+RAOIFNS(RASEL),0)),U,2),0)),U,6)="P",('$D(RAOPT("ORDERPRINTPAT"))) D  S RAERR=1,RAPARENT=0 Q  ; Two parents chosen
 . ; check NOT valid during 'Print Selected Requests by Patient' option!
 . W !!?3,*7,"Only one parent type procedure may be chosen at a time."
 . W !?3,"(You have already chosen ",$P($G(^RAMIS(71,RAPARENT,0)),U),".)"
 . Q
 S RANUM=RANUM+1,RADUP(RASEL)="",RAORDS(RANUM)=RAOIFNS(RASEL),RAOSEL=RANUM
 I $P($G(^RAMIS(71,+$P($G(^RAO(75.1,+RAOIFNS(RASEL),0)),U,2),0)),U,6)="P" D
 . S RAPARENT=+$P($G(^RAO(75.1,+RAOIFNS(RASEL),0)),U,2)
 . Q
 Q
 ;
HLPSEL I $D(RAOSTSNM) W !!?3,"The request(s) must have one of the following statuses",$S($D(RAOFNS):" to "_RAOFNS,1:""),":",!?6,RAOSTSNM
 I RAX["??" W !!?3,"Status Symbols:  'dc' - discontinued   'c' - complete   'h' - on hold",!?20,"'p'  - pending        ' ' - active     's' - scheduled"
 Q
DPAR ; convert detail proc to parent
 S RASEL=$E(RAX,2,$L(RAX)) ; remove leading 'P'
 S:RASEL="" RASEL="P" ;set to 1 char so chksel will reject it
 D CHKSEL
 ; if order's proc is a parent, then --
 ;   1-kill raords to skip exam^rareg1
 ;   2-don't kill raosel so chkord loop would stop
 I RAPARENT W !!?3,*7,"Only Detailed, Series, and Broad procedures can be selected !",! K RAORDS Q
 Q:RAX="P"  ;entry is only a single P, so don't flag
 S RADPARFL=1 ; flag
