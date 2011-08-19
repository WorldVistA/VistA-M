PRCHNPO1 ;SF-ISC/RSD/RHD-CONT. OF NEW PO ;6/9/96  19:48
V ;;5.1;IFCAP;**16,79,100,108**;Oct 20, 2000;Build 10
 ;Per VHA Directive 2004-038, this routine should not be modified.
 I ('$G(PRCHPC)!($G(PRCHPC)=2)),'$G(PRCHPHAM) D
 .S PRCH=0,DIE="^PRC(442,",DR="[PRCHDISCNT]",(D0,DA,DA(1))=PRCHPO
 .I $G(PRCHDELV) S DR="[PRCHPROMPT]"
 .D ^DIE
 F I=1:1 S PRCH=$O(^PRC(442,PRCHPO,3,PRCH)) Q:PRCH=""!(PRCH'>0)  S PRCHCN=$S($P(^(PRCH,0),U,5)]"":$P(^(0),U,5),1:".OM"),PRCHAC=$P(^(0),U,1),PRCHACT=$P(^(0),U,4),PRCHP=$P(^(0),U,2) D SET Q:'$D(PRCHPO)
 G ERR^PRCHNPO:'$D(PRCHPO) S $P(^PRC(442,PRCHPO,0),U,14)=$P(^PRC(442,PRCHPO,0),U,14)+I-1,PRCHLCNT=$P(^(0),U,14),Y=$G(^PRC(440,PRCHV,2)),PRCHN("LSA")=$P(Y,U,5),PRCHN("MB")=$S(PRCHDT:$P(Y,U,3),1:$P(Y,U,6))
 S PRCHBO=$S(PRCHDT:1.1,1:1) K PRCHB
 S X="",PRCH="" F I=0:0 S PRCH=$O(PRCH("AM",PRCH)) Q:PRCH=""  S X=X+$P(PRCH("AM",PRCH),U,2)
 ;Comment line below for PRC*5.1*79, new FPDS report for Austin
 ;G:($G(PRCHPC)!$G(PRCHDELV)) EST
 I $G(PRCHPC)=1 G EST ;skip for Simplified PC orders, PRC*5.1*79
 I PRCHDT I (X+PRCHEST>25000&("467B"'[PRCHSC))!("013"[PRCHSC)!(PRCHN("MP")=12)!(PRCHN("MP")=5)!(PRCHN("SFC")=1) G E2
 I $O(^PRC(440,PRCHV,PRCHBO,0)) S PRCHB(0)="^442.16PA^"_$P(^(0),U,3,4) F I=0:0 S I=$O(^PRC(440,PRCHV,PRCHBO,I)) Q:'I  S:$P(^PRCD(420.6,+I,0),"^",5)'="N" PRCHB(I)=I
 I PRCHDT,'$D(PRCHB) D ER3^PRCHNPO6 G ERR^PRCHNPO
 D EN6^PRCHNPO2 G ERR^PRCHNPO:'$D(PRCHPO)
 ;
 ;Clean up node 25 to place new FPDS data, PRC*5.1*79.
E2 S DR=$S($G(PRCHPC)=2:"[PRCHAMT89 NEW]",$D(PRCHDELV):"[PRCHAMT89 NEW]",$D(PRCHPHAM):"[PRCHAMT89 NEW]",PRCHDT:"[PRCHAMT89]",1:"[PRCHAMT]")
 K ^PRC(442,PRCHPO,9),^PRC(442,PRCHPO,25) S $P(^PRC(442,PRCHPO,0),U,15,16)="0^0"
 ;
 I PRCHDT D FPDS^PRCHFPD2 G:'PRCHFPDS EST
 S PRCHY=0 I PRCHEST>0,PRCHEC>0 S PRCHY=PRCHEST/PRCHEC,Y=$P(PRCHY,".",2) I $L(Y)>2 S PRCHY=$P(PRCHY,".",1)+$J("."_Y,2,2)
 S PRCH=0 F PRCHI=1:1 S PRCH=$O(PRCH("AM",PRCH)) Q:PRCH=""  D TYPE S PRCHAMT=PRCH("AM",PRCH),PRCHCN=$S(PRCH=".OM":"",1:PRCH),DIE("NO^")="NO" W ?40,"AMOUNT: ",PRCHAMT S PRCHAMT=""""_PRCHAMT_"""" D ^DIE
 ;New tasks for FPDS data collection, PRC*5.1*79.
 ;Look at the entry actions for POs created by a Purchasing Agent, a PC
 ;user and a Delivery Orders user and call the required input template.
 ;PRC*5.1*100 - If the user times out and does not complete the input
 ;template for the new FPDS, don't allow electronic sig. Check the last
 ;field required for the PO, based on the source code and menu.
 I '$D(PRCHPC)&("25"[PRCHSC) D  G:$G(PRCHER)=1 ERR^PRCHNPO
 . S DR="[PRCH NEW PO FPDS]" D ^DIE
 . I '$D(^PRC(442,PRCHPO,25)) S PRCHER=1 Q
 . I $P(^PRC(442,PRCHPO,25),U,6)="" S PRCHER=1 Q
 . ;Fund agency code & fund agency office code can be empty in pairs only.
 . I +$P(^PRC(442,PRCHPO,25),U,7)>0,$P(^PRC(442,PRCHPO,25),U,8)="" S PRCHER=1 Q
 ;
 ;For FPDS purposes, consider any PO with any of the following source
 ;codes as a delivery order (including direct delivery POs)from a PA:
 ;If the user times out, don't allow electronic sig., PRC*5.1*100.
 I ("467B"[PRCHSC)&($D(^PRC(442,PRCHPO,14)))!($G(PRCHPC)=3) D  G:$G(PRCHER)=1 ERR^PRCHNPO
 . S DR="[PRCH NEW PO FPDS]" D ^DIE
 . I '$D(^PRC(442,PRCHPO,25)) S PRCHER=1 Q
 . I $P(^PRC(442,PRCHPO,25),U,15)'="" D POP Q
 . E  S PRCHER=1
 ;
 ;Get eligible Detailed purchase card orders. If the user times out,
 ;don't allow electronic signature, PRC*5.1*100.
 I $G(PRCHPC)=2 D  G:$G(PRCHER)=1 ERR^PRCHNPO
 . S DR="[PRCH NEW PC FPDS]" D ^DIE
 . I '$D(^PRC(442,PRCHPO,25)) S PRCHER=1 Q
 . S PRCHSC=$P(^PRCD(420.8,+PRCHSC,0),U,1)
 . I ("2"[PRCHSC)&($P(^PRC(442,PRCHPO,25),U,6)="") S PRCHER=1 Q
 . ;Fund agency code & fund agency office code can be empty in pairs only.
 . I ("2"[PRCHSC)&(+$P(^PRC(442,PRCHPO,25),U,7)>0),$P(^PRC(442,PRCHPO,25),U,8)="" S PRCHER=1 Q
 . I ("6B"[PRCHSC)&($P(^PRC(442,PRCHPO,25),U,13)="") S PRCHER=1 Q
 ;
 ;Get delivery orders from the separate Delivery Orders menu. If the
 ;user times out, don't allow electronic sig.; PRC*5.1*100.
 I $G(PRCHDELV)=1!($G(PRCHPHAM)=1) D  G:$G(PRCHER)=1 ERR^PRCHNPO
 . S DR="[PRCH NEW DEL FPDS]" D ^DIE
 . I '$D(^PRC(442,PRCHPO,25)) S PRCHER=1 Q
 . I $P(^PRC(442,PRCHPO,25),U,15)'="" D POP Q
 . E  S PRCHER=1
 ;
 ;End of changes for PRC*5.1*79.
 K DIE F I=0:0 Q:'$D(PRCHPO)  S I=$O(^PRC(442,PRCHPO,9,I)) Q:'I  D ER2^PRCHNPO6:$P(^(I,0),"^",2)="",ER3^PRCHNPO6:'$O(^(1,0))
 ;PRC*5.1*100 - Quit if user fails to populate any required field in
 ;node 9 (amount, type code, pref. program, etc.) or just times out.
 ;
 N J,K,L S K=+$P(^PRC(442,PRCHPO,9,0),U,3)
 F L=1:1:K D  G:$G(PRCHER)=1 ERR^PRCHNPO
 . F J=1,2,4,5 D
 .. I $P(^PRC(442,PRCHPO,9,L,0),"^",J)="" S PRCHER=1
 ;End of changes for PRC*5.1*100.
 ;
EST G ERR^PRCHNPO:'$D(PRCHPO) I 'PRCHEST,PRCHESTL S $P(^PRC(442,PRCHPO,0),U,18)=""
 D EN2^PRCHNPO7 I PRCHEST D EST^PRCHNPO6
 I $P($G(^PRC(442,PRCHPO,23)),U,11)="",PRCHSTAT'=22 S (X,Y)=5,DA=PRCHPO D UPD^PRCHSTAT
 I $G(PRCHPC)=2!$G(PRCHDELV) S (D0,DA)=PRCHPO D ^PRCHSF
 I '$G(PRCPROST) S %=1,%B="",%A="     Review "_$S($G(PRCHPC):"Purchase Card",$G(PRCHDELV):"Delivery",1:"Purchase")_" Order " D ^PRCFYN I %=1 S D0=PRCHPO D ^PRCHDP1
 I PRCHSTAT=22 S (D0,DA)=PRCHPO D ^PRCHSF G Q^PRCHNPO4
 G ^PRCHNPO4
 ;
SET G:PRCHAC="Q" PCTQ
 I PRCHAC[":" S PRCHAC=$P(PRCHAC,":",1)_":1:"_$P(PRCHAC,":",2)
 ;
PCT S PRCHAMT=0,Y="F J="_PRCHAC_" S PRCHN=J D PCT1 G:$D(PRCHER) Q" X Y Q:'$D(PRCHPO)
 S PRCHAMT=PRCHAMT*100+.5\1/100,$P(PRCH("AM",PRCHCN),U,2)=$P(PRCH("AM",PRCHCN),U,2)-PRCHAMT
 S $P(^PRC(442,PRCHPO,3,PRCH,0),U,3)=PRCHAMT,$P(^(0),U,6)=I+PRCHLCNT
 Q
 ;
PCT1 I $D(^PRC(442,PRCHPO,2,"B",PRCHN)) S GTFLAG="" D  G:GTFLAG=1 ER^PRCHNPO6 G:GTFLAG=2 ER1^PRCHNPO6
 .S PRCHN=$O(^PRC(442,PRCHPO,2,"B",PRCHN,0)),PRCHD=+$P($G(^PRC(442,PRCHPO,2,PRCHN,2)),U,1) I PRCHD'>0 S GTFLAG=1 Q
 .I $S(PRCHCN=".OM"&($P(^(2),U,2)=""):0,PRCHCN=$P(^(2),U,2):0,1:1) S GTFLAG=2 Q
 .S PRCHDA=0
 .I $E(PRCHP,1)="$" S PRCHDA=$P(PRCHP,"$",2)/PRCHACT
 .E  S PRCHDA=$J(PRCHD*(PRCHP/100),0,2)
 .S PRCHAMT=PRCHAMT+PRCHDA,$P(^PRC(442,PRCHPO,2,PRCHN,2),U,6)=PRCHDA
 Q
 ;
PCTQ S (PRCHAMT,PRCHCN,PRCHX)=0,PRCHACT=PRCHLCNT F K=0:0 S PRCHCN=$O(PRCH("AM",PRCHCN)) Q:PRCHCN=""  S PRCHAC=$E($P(PRCH("AM",PRCHCN),U,3),1,$L($P(PRCH("AM",PRCHCN),U,3))-1) D PCT Q:'$D(PRCHPO)  S PRCHX=PRCHX+PRCHAMT
 Q:'$D(PRCHPO)  S $P(^PRC(442,PRCHPO,3,PRCH,0),U,3)=PRCHX
 Q
 ;
POP ;Set up place of performance for PRC*5.1*79, new FPDS. If station is the
 ;place of perf. for PO, send the state abbrev. and zip code, otherwise
 ;send the vendor's state and zip code. Applies to all Delivery POs.
 ;For Guaranteed Delivery orders, we have to choose the VAMC since users
 ;are not asked for a SHIP TO location - PRC*5.1*100.
 N PRCST,PRCSTL,PRCSZP,PRCPOP,PRCLOC,PRCROOT,PRCVAMC
 I $P(^PRC(442,PRCHPO,25),"^",15)="Y" D
 . I $P(^PRC(442,PRCHPO,0),"^",2)=4 D POP1 Q
 . S PRCLOC=$P(^PRC(442,PRCHPO,1),U,3) ;ship to location
 . S PRCST=$P(^PRC(411,PRC("SITE"),1,PRCLOC,0),"^",6)  ;station's state
 . S PRCSTL=$P(^DIC(5,PRCST,0),"^",2)
 . S PRCSZP=$P(^PRC(411,PRC("SITE"),1,PRCLOC,0),"^",7) ;station's zip
 . S PRCPOP=PRCSTL_PRCSZP,$P(^PRC(442,PRCHPO,25),"^",16)=PRCPOP
 . Q
 I $P(^PRC(442,PRCHPO,25),"^",15)="N" D
 . S PRCST=$P(^PRC(440,PRCHV,0),"^",7) ;vendor's state
 . S PRCSTL=$P(^DIC(5,PRCST,0),"^",2)
 . S PRCSZP=$E($P(^PRC(440,PRCHV,0),"^",8),1,5) ;vendor's zip
 . S PRCPOP=PRCSTL_PRCSZP,$P(^PRC(442,PRCHPO,25),"^",16)=PRCPOP
 Q
 ;
POP1 ;Set up for Guaranteed Delivery orders - users are not asked for a SHIP
 ;TO location during PO creation - PRC*5.1*100.
 S PRCROOT=$G(^PRC(411,PRC("SITE"),0)),PRCVAMC=$G(^(3)) ; local VAMC
 S PRCST=$P(PRCVAMC,"^",4)
 S PRCSTL=$P(^DIC(5,PRCST,0),"^",2) ;station's state
 S PRCSZP=$E($P(PRCVAMC,"^",5),1,5) ;station's zip
 S PRCPOP=PRCSTL_PRCSZP,$P(^PRC(442,PRCHPO,25),"^",16)=PRCPOP
 Q
 ;End of changes for new FPDS
 ;
TYPE I PRCHI=PRCHEC,PRCHEST'=(PRCHY*PRCHEC) S PRCHY=PRCHY+(PRCHEST-(PRCHY*PRCHEC))
 I PRCHY>0 S PRCH("AM",PRCH)=$P(PRCH("AM",PRCH),U,1)_U_($P(PRCH("AM",PRCH),U,2)+PRCHY)_U_$P(PRCH("AM",PRCH),U,3)
 ;When Source Code is not 5 then display a list of Possible Type Codes
 I PRCHSC'=5 D
 . W !,$S(PRCH'=".OM":"CONTRACT/BOA: "_PRCH,1:""),"  Possible ",$S(PRCHDT:"Method/Type Codes: ",1:"Type Codes: ")
 . I 'PRCHDT S I=0 F Y=0:0 S Y=$O(^PRCD(420.6,Y)) S:Y>100 Y="" Q:'Y  D EN7^PRCHNPO2 I $T W:I "," W $P(^PRCD(420.6,Y,0),"^",1) S I=I+1
 . I PRCHDT S I=0 F Y=100:0 S Y=$O(^PRCD(420.6,Y)) S:Y>120 Y="" Q:'Y  D PROC^PRCHFPDS I $T W:I "," W $P(^PRCD(420.6,Y,0),U,1) S I=I+1
 . Q
 ;
 S PRCHX=$P(PRCH("AM",PRCH),U,3),K=0
 I PRCHX]"" W !?1,"ITEM: " W:PRCHX'[":1:" PRCHX I PRCHX[":1:" F J=0:0 S PRCHX=$P(PRCHX,":1:",1)_":"_$P(PRCHX,":1:",2,99) I PRCHX'[":1:" W PRCHX Q
 S:$P(PRCH("AM",PRCH),U,2)]"" PRCH("AM",PRCH)=$P(PRCH("AM",PRCH),U,2)
 Q
 ;
Q L  K PRCH,PRCHAC,PRCHACT,PRCHAM,PRCHAMT,PRCHB,PRCHBO,PRCHCN,PRCHCNT,PRCHD,PRCHDA,PRCHDT,PRCHEC,PRCHER,PRCHES,PRCHEST,PRCHFPDS,PRCHI,PRCHL0,PRCHL1,PRCHL2,PRCHL3,PRCHLCNT,PRCHLI
 K PRCHN,PRCHP,PRCHPO,PRCHSC,PRCHV,PRCHX,PRCHY,DIC,DIE,DR,D0,DA,X,Y
 Q
