ECRDSSU ;ALB/ESD - DSS Unit Workload Summary Report ; 1 Jul 2008
 ;;2.0; EVENT CAPTURE ;**5,8,10,14,18,47,63,72,95**;8 May 96;Build 26
 ;
EN ;- Get location(s), DSS Unit(s), start & end dates, device
 ;
 N ECLOC,ECDSSU,ECSTDT,ECENDDT
 I '$$ASKLOC^ECRUTL G ENQ
 I '$$ASKDSS^ECRUTL G ENQ
 I '$$STDT^ECRUTL G ENQ
 I '$$ENDDT^ECRUTL(ECSTDT) G ENQ
 I $$ASKDEV D STRPT^ECRDSSU
ENQ Q
 ;
 ;
STRPT ;- Main entry point
 ;
 N ECCRT,ECDSSNM,ECDSSTOT,ECLOCNM,ECQUIT,ECPAGE
 S (ECDSSTOT,ECPAGE,ECQUIT)=0,(ECDSSNM,ECLOCNM)=""
 ; Determine if device is CRT
 S ECCRT=$S($E(IOST,1,2)="C-":1,1:0)
 U IO
 D GETREC
 D LOOP
 I ECQUIT G STRPTQ
 D PRTCAT
 I ECQUIT G STRPTQ
 D DSSCHG
 I ECQUIT G STRPTQ
 I $D(ECGUI) G STRPTQ
 I $D(ZTQUEUED) S ZTREQ="@"
 D ^%ZISC
STRPTQ K ^TMP("ECRPT")
 Q
 ;
 ;
GETREC ;- Loop thru "ADT" x-ref of EC Patient file (#721)
 ;
 N ECD,ECDFN,ECIEN,ECL,ECNT,I,J,ECREC,ECST
 S ECNT=0
 F I=0:0 S I=$O(ECLOC(I)) Q:'I  S ECL=+$P(ECLOC(I),U) D
 . S ECDFN=0
 . F  S ECDFN=+$O(^ECH("ADT",ECL,ECDFN)) Q:'ECDFN  F J=0:0 S J=$O(ECDSSU(J)) Q:'J  S ECD=+$P(ECDSSU(J),U) D
 .. S ECIEN=0
 .. S ECST=ECSTDT
 .. F  S ECST=+$O(^ECH("ADT",ECL,ECDFN,ECD,ECST)) Q:'ECST!(ECST>ECENDDT)  F  S ECIEN=+$O(^ECH("ADT",ECL,ECDFN,ECD,ECST,ECIEN)) Q:'ECIEN  D
 ... S ECREC=$G(^ECH(ECIEN,0))
 ... I ECD=+$P(ECREC,"^",7) D CRETMP
 Q
 ;
 ;
CRETMP ;- Create ^TMP("ECRPT" array w/format:
 ;    ^TMP("ECRPT",$J,location,DSS Unit,category,count)=procedure^volume^
 ;                                                         CPT modifiers
 ;
 N ECTC,ECTP,ECMOD,ECMODS,ECMODF,SEQ
 S ECTC=$S(+$P(ECREC,"^",8)=0:-1,1:+$P(ECREC,"^",8)),ECTP=$P($G(ECREC),"^",9)
 S ECNT=ECNT+1,ECTP=$P(ECTP,";")_";"_$E($P(ECTP,";",2),1)
 ;ALB/JAM - Get Procedure CPT modifiers
 S ECMODS="" I $O(^ECH(ECIEN,"MOD",0))'="" D
 . K ECMOD S ECMODF=$$MOD^ECUTL(ECIEN,"I",.ECMOD) I 'ECMODF Q
 . S SEQ="" F  S SEQ=$O(ECMOD(SEQ)) Q:SEQ=""  D
 . . S ECMODS=ECMODS_$S(ECMODS="":"",1:";")_SEQ
 S ^TMP("ECRPT",$J,+$P(ECREC,"^",4),+$P(ECREC,"^",7),ECTC,ECNT)=ECTP_"^"_+$P(ECREC,"^",10)_"^"_ECMODS
 Q
 ;
LOOP ;- Loop through data
 ;
 N ECCAT,ECNT,ECOCAT,ECDSS,ECLOCAT,ECPR,ECVOL,ECMOD
 S (ECNT,ECDSS,ECLOCAT)=0,(ECCAT,ECOCAT)=""
 I '$D(^TMP("ECRPT",$J)) G LOOPQ
 F  S ECLOCAT=$O(^TMP("ECRPT",$J,ECLOCAT)) Q:'ECLOCAT  D
 . F  S ECDSS=$O(^TMP("ECRPT",$J,ECLOCAT,ECDSS)) Q:'ECDSS  D
 .. Q:ECQUIT
 .. D PRTCAT Q:ECQUIT
 .. D DSSCHG Q:ECQUIT
 .. S ECOCAT=0
 .. D HDR
 .. D LOCNAM,DSSUNAM
 .. W !!,"Location: ",$G(ECLOCNM),!,"DSS Unit: ",$G(ECDSSNM)
 .. F  S ECCAT=$O(^TMP("ECRPT",$J,ECLOCAT,ECDSS,ECCAT)) Q:ECCAT=""  D
 ... D CATCHG
 ... Q:ECQUIT
 ... F  S ECNT=$O(^TMP("ECRPT",$J,ECLOCAT,ECDSS,ECCAT,ECNT)) Q:'ECNT  D
 .... S (ECPR,ECVOL)=0
 .... S ECPR=$P($G(^TMP("ECRPT",$J,ECLOCAT,ECDSS,ECCAT,ECNT)),"^")
 .... S ECVOL=$P($G(^TMP("ECRPT",$J,ECLOCAT,ECDSS,ECCAT,ECNT)),"^",2)
 .... S ECMOD=$P($G(^TMP("ECRPT",$J,ECLOCAT,ECDSS,ECCAT,ECNT)),"^",3)
 .... I '$D(ECTMP(ECLOCAT,ECDSS,ECCAT,ECPR)) S ECTMP(ECLOCAT,ECDSS,ECCAT,ECPR)=ECVOL D:ECMOD'="" SETMOD Q
 .... S ECTMP(ECLOCAT,ECDSS,ECCAT,ECPR)=ECTMP(ECLOCAT,ECDSS,ECCAT,ECPR)+ECVOL D:ECMOD'="" SETMOD
LOOPQ Q
SETMOD ;ALB/JAM - Set CPT modifiers in ECTMP array
 N MOD,I
 F I=1:1 S MOD=$P(ECMOD,";",I) Q:MOD=""  D
 . S ECTMP(ECLOCAT,ECDSS,ECCAT,ECPR,MOD)=$G(ECTMP(ECLOCAT,ECDSS,ECCAT,ECPR,MOD))+ECVOL
 Q
 ;
CATCHG ;- Category change
 ;
 I ECCAT=""&(ECOCAT="") G CATCHGQ
 I ECOCAT="" S ECOCAT=ECCAT G CATCHGQ
 I $G(ECOCAT)'=$G(ECCAT) D
 . D PRTCAT
 . S ECOCAT=ECCAT
CATCHGQ Q
 ;
PRTCAT ;- Print category
 ;
 Q:'$D(ECTMP)
 N ECC,ECCATOT,ECDSS,ECFLG,ECLOC,ECPR,ECPRN,ECSYI,ECSYN,ECCNAM,ECPNAM
 N ECCPT,ECPI
 S (ECCATOT,ECDSS,ECFLG,ECLOC)=0,(ECC,ECCNAM,ECPR)=""
 F  S ECLOC=$O(ECTMP(ECLOC)) Q:'ECLOC  F  S ECDSS=$O(ECTMP(ECLOC,ECDSS)) Q:'ECDSS  F  S ECC=$O(ECTMP(ECLOC,ECDSS,ECC)) Q:ECC=""  F  S ECPR=$O(ECTMP(ECLOC,ECDSS,ECC,ECPR)) Q:ECPR=""  D  I ECQUIT Q
 . S ECCNAM=$S($P($G(^EC(726,$S(ECC<1:0,1:+ECC),0)),"^")'="":$P($G(^EC(726,$S(ECC<1:0,1:+ECC),0)),"^"),1:"None")
 . S ECPRN=$S($P(ECPR,";",2)="E":ECPR_"C(725,",1:ECPR_"CPT(")
 . S ECSYI=+$O(^ECJ("AP",ECLOC,ECDSS,$S(ECC<1:0,1:+ECC),ECPRN,0)),ECSYN=$P($G(^ECJ(ECSYI,"PRO")),"^",2)
 . S ECPI=""
 . S ECCPT=$S($P(ECPR,";",2)="I":+ECPR,1:$P($G(^EC(725,+ECPR,0)),"^",5))
 . I ECCPT'="" S ECPI=$$CPT^ICPTCOD(ECCPT,$P(ECENDDT,".")),ECCPT=$P(ECPI,"^",2)
 . S ECPNAM=$S($P(ECPR,";",2)="E":$G(^EC(725,+$P(ECPR,";"),0)),$P(ECPR,";",2)="I":$P(ECPI,"^",3),1:"") S:$P(ECPR,";",2)="E" ECPNAM=$P(ECPNAM,"^",2)_" "_$P(ECPNAM,"^")
 . Q:ECQUIT
 . I $Y>(IOSL-11) D PAUSE Q:ECQUIT  D HDR
 . W:'ECFLG !!?1,"Category:",!?2,ECCNAM S ECFLG=1
 . W !?3,ECCPT,?9,$E(ECPNAM,1,35),?46,$S(ECSYN]"":$E(ECSYN,1,21),1:""),?69,$J($P($G(ECTMP(ECLOC,ECDSS,ECC,ECPR)),"^"),6)
 . S ECCATOT=ECCATOT+$P($G(ECTMP(ECLOC,ECDSS,ECC,ECPR)),"^")
 . I $O(ECTMP(ECLOC,ECDSS,ECC,ECPR,""))'="" D PRTMOD I ECQUIT Q
 G:ECQUIT PRTCATQ
 I $Y>(IOSL-11) D PAUSE G:ECQUIT PRTCATQ D HDR
 W !?69,"------"
 W !?6,"Total Procedures for ",ECCNAM,?69,$J(ECCATOT,6),!
 S ECDSSTOT=ECDSSTOT+ECCATOT
PRTCATQ K ECTMP
 Q
 ;
PRTMOD ;ALB/JAM - Print CPT modifiers
 N MOD,IEN,MODESC,MODI S IEN=""
 F  S IEN=$O(ECTMP(ECLOC,ECDSS,ECC,ECPR,IEN)) Q:IEN=""  D
 . I $Y>(IOSL-8) D PAUSE Q:ECQUIT  D HDR
 . S MODI=$$MOD^ICPTMOD(IEN,"I",$P(ECENDDT,"."))
 . S MOD=$P(MODI,"^",2) I MOD="" Q
 . S MODESC=$P(MODI,"^",3) I MODESC="" S MODESC="Unknown"
 . W !?7,"- ",MOD," ",$E(MODESC,1,40)," ("
 . W ECTMP(ECLOC,ECDSS,ECC,ECPR,IEN),")"
 Q
 ;
DSSCHG ;- DSS Unit change
 ;
 Q:'$G(ECDSSTOT)
 I ECDSSTOT>0 D
 . I $Y>(IOSL-11) D PAUSE Q:ECQUIT  D HDR
 . W !!?69,"======"
 . W !?6,"Total Procedures for ",$G(ECDSSNM),?69,$J(ECDSSTOT,6)
 . S ECDSSTOT=0,(ECLOCNM,ECDSSNM)=""
 . D PAUSE
 Q
 ;
HDR ;- Report header
 ;
 I ECCRT!(ECPAGE) W @IOF
 S ECPAGE=ECPAGE+1
 W !,?((IOM-32)\2),"DSS UNIT WORKLOAD SUMMARY REPORT"
 W !,?((IOM-40)\2),"Date Range: "_$$FMTE^XLFDT($P((ECSTDT+.0001),"."))_" to "_$$FMTE^XLFDT($P(ECENDDT,"."))
 W !!,"Run Date: "_$$FMTE^XLFDT($$NOW^XLFDT)
 W ?65,"    Page: ",ECPAGE
 W !!?3,"CPT Code",?13,"Description",?46,"Synonym",?69,"Volume"
 W !?7,"CPT Modifier (volume of modifiers use)"
 W !,$TR($J("",79)," ","-")
 Q
 ;
 ;
LOCNAM ;- Get location name
 ;
 N I
 F I=0:0 S I=$O(ECLOC(I)) Q:'I  I $P($G(ECLOC(I)),"^")=ECLOCAT S ECLOCNM=$P(ECLOC(I),"^",2)
 Q
 ;
 ;
DSSUNAM ;- Get DSS Unit name
 ;
 N I
 F I=0:0 S I=$O(ECDSSU(I)) Q:'I  I $P($G(ECDSSU(I)),"^")=ECDSS S ECDSSNM=$P(ECDSSU(I),"^",2)
 Q
 ;
 ;
PAUSE ;- Pause for screen output
 D FOOTER
 Q:'ECCRT
 N DIR,DIRUT,DUOUT
 I IOSL<30 F  W ! Q:$Y>(IOSL-4)
 W ! S DIR(0)="E" D ^DIR I $D(DIRUT)!($D(DUOUT)) S ECQUIT=1
 Q
 ;
 ;
FOOTER ;- Print page footer
 W !!?4,"Volume totals may represent days, minutes, numbers of procedures"
 W !?4,"and/or a combination of these."
 Q
 ;
 ;
ASKDEV() ;- Ask device for printing or queuing report
 ;  Input:     None
 ;
 ; Output:     1 if report is printed
 ;             0 if report is queued (or exited out)
 ;
 N ECX,ZTDESC,ZTRTN,ZTSAVE
 S ECX=1
 K %ZIS S %ZIS="QMP"
 D ^%ZIS
 S:POP ECX=0
 I ECX&($D(IO("Q"))) D
 . S ZTRTN="STRPT^ECRDSSU",ZTDESC="DSS UNIT WORKLOAD SUMMARY REPORT"
 . S (ZTSAVE("ECLOC("),ZTSAVE("ECDSSU("),ZTSAVE("ECSTDT"),ZTSAVE("ECENDDT"))=""
 . D ^%ZTLOAD
 . D HOME^%ZIS
 . S ECX=0
 Q ECX
