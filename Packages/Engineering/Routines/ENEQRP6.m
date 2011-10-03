ENEQRP6 ;WIRMFO/SAB-PARENT SYSTEM/COMPONENT HIERARCHY REPORT ;6/4/97
 ;;7.0;ENGINEERING;**35,42**;AUG 17, 1993
EN ; main entry point
ASKSYS ; ask system
 S DIR(0)="Y",DIR("A")="Do you want a report for ALL systems"
 S DIR("B")="NO"
 S DIR("?",1)="Enter YES to generate a report for all systems."
 S DIR("?",2)="The computer will identify all the topmost parent systems"
 S DIR("?",3)="by looping through the entire equipment file. A complete"
 S DIR("?",4)="system hierarchy will be printed for each of the topmost"
 S DIR("?",5)="parent systems which includes all of their components."
 S DIR("?",6)="It may take awhile to search the entire equipment file."
 S DIR("?",7)=""
 S DIR("?",8)="Enter NO to generate a report for just one system."
 S DIR("?",9)=""
 S DIR("?")="Enter YES or NO"
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S EN("ALL")=Y
 ;
 I 'EN("ALL") F  D  G:ENDAP="^" EXIT Q:ENDAP]""
 . S ENDAP=""
 . D GETEQ^ENUTL I $D(DTOUT)!$D(DUOUT)!(Y'>0) S ENDAP="^" Q
 . S ENDAP=+Y
 . ; if entry is a component then offer to start with it's parent
 . I $P($G(^ENG(6914,ENDAP,0)),U,3)]"" D  Q:'ENDAP
 . . S ENDA=ENDAP,I=0
 . . F  S X=$P($G(^ENG(6914,ENDA,0)),U,3) Q:X=""!(I>50)  S ENDA=X,I=I+1
 . . W:I>50 $C(7),!!,"Can't determine topmost parent system (>50 deep)."
 . . I ENDAP'=ENDA D  Q:ENDAP="^"
 . . . W !!,"Equipment Entry #",ENDAP," ",$$GET1^DIQ(6914,ENDAP,6)
 . . . W !,"is a component of Entry #",ENDA," ",$$GET1^DIQ(6914,ENDA,6)
 . . . S DIR(0)="Y",DIR("B")="YES"
 . . . S DIR("A")="Would you prefer to report on the parent system"
 . . . S DIR("?")="Answer YES to start with the topmost parent system (includes components)."
 . . . D ^DIR K DIR I $D(DIRUT) S ENDAP="^" Q
 . . . I Y S ENDAP=ENDA
 . ; make sure that selected system has components
 . I '$O(^ENG(6914,"AE",ENDAP,0)) D  Q:'ENDAP
 . . W $C(7),!!,"Equipment Entry #",ENDAP," does not have any components"
 . . S ENDAP=""
 ;
ASKFLD ; ask fields to print
 K ENFLD F I=1:1:2 S ENFLD(I)=""
 W !!,"Select the 1st field (required) to print for each equipment item."
 K DIC S DIC="^DD(6914,",DIC(0)="AQEM",DIC("B")="EQUIPMENT CATEGORY"
 S DIC("S")="I ($P(^(0),U,2)'[""W"")&($P(^(0),U,2)'>0)"
 D ^DIC K DIC I $D(DTOUT)!$D(DUOUT) G EXIT
 I Y'>0 D  G ASKFLD
 . W $C(7),!!,"Select a field or enter '^' to quit."
 S ENFLD(1)=+Y
 S ENFLD(1,"L")=$$GET1^DID(6914,ENFLD(1),"","FIELD LENGTH")
 S ENFLD(1,"N")=$$GET1^DID(6914,ENFLD(1),"","LABEL")
 I ENFLD(1,"L")>20 D  G:$D(DIRUT) EXIT
 . W !!,"Field ",ENFLD(1,"N")," can be ",ENFLD(1,"L")," characters long."
 . W !,"You may want to just print a portion of this field."
 . S DIR(0)="N^1:"_ENFLD(1,"L")
 . S DIR("A")="Number of characters to print",DIR("B")=20
 . D ^DIR K DIR Q:$D(DIRUT)
 . S ENFLD(1,"L")=Y
 ;
 W !!,"Select the 2nd field (optional) to print for each equipment item."
 K DIC S DIC="^DD(6914,",DIC(0)="AQEM"
 S DIC("S")="I ($P(^(0),U,2)'[""W"")&($P(^(0),U,2)'>0)"
 D ^DIC K DIC I $D(DTOUT)!$D(DUOUT) G EXIT
 I Y>0 D  G:$D(DIRUT) EXIT
 . S ENFLD(2)=+Y
 . S ENFLD(2,"L")=$$GET1^DID(6914,ENFLD(2),"","FIELD LENGTH")
 . S ENFLD(2,"N")=$$GET1^DID(6914,ENFLD(2),"","LABEL")
 . I ENFLD(2,"L")>20 D  Q:$D(DIRUT)
 . . W !!,"Field ",ENFLD(2,"N")," can be ",ENFLD(2,"L")," characters long."
 . . W !,"You may want to just print a portion of this field."
 . . S DIR(0)="N^1:"_ENFLD(2,"L")
 . . S DIR("A")="Number of characters to print",DIR("B")=20
 . . D ^DIR K DIR Q:$D(DIRUT)
 . . S ENFLD(2,"L")=Y
 ;
ASKDEV ; ask device
 S %ZIS="QM" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="QEN^ENEQRP6",ZTDESC="Parent System/Component Hierarchy Rpt"
 . S ZTSAVE("ENDAP")="",ZTSAVE("ENFLD(")="",ZTSAVE("EN(")=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
 ;
QEN ; queued entry point
 U IO
 S (END,ENPG)=0 D NOW^%DTC S Y=% D DD^%DT S ENDT=Y
 I 'EN("ALL") S ENDAP("CAT")=$$GET1^DIQ(6914,ENDAP,6)
 K ENDL S $P(ENDL,"-",IOM+1)=""
 K ENBL S $P(ENBL," ",IOM+1)=""
 D HD
 ;
BLDHI ; build hierarchy
 K ^TMP($J)
 S ENRT="^TMP("_$J_","
 S ENMD=1
 I 'EN("ALL") D GETC(ENDAP,"",ENRT) S ENT=1
 I EN("ALL") D  G:END WRAPUP
 . ; loop thru equipment, identify topmost parents, determine hierarchy
 . S ENC=0,ENT=0,ENDA=0
 . F  S ENDA=$O(^ENG(6914,ENDA)) Q:'ENDA  D  Q:END
 . . S ENC=ENC+1
 . . I '(ENC#1000) W:IO=IO(0) "." I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,END)=1 Q
 . . Q:'$O(^ENG(6914,"AE",ENDA,0))  ; not a parent system
 . . Q:$P($G(^ENG(6914,ENDA,0)),U,3)'=""  ; not the topmost parent system
 . . D GETC(ENDA,"",ENRT) S ENT=ENT+1
 ; save total number of topmost parents processed
 S @(ENRT_0_")")="SYSTEM/COMPONENT LIST"_U_DT_U_ENT
 ;
PRTHI ; print hierarchy
 ; compute indent to use for component levels
 S Y=10+2+ENFLD(1,"L") ; ien and spaces and 1st field
 S:ENFLD(2) Y=Y+3+ENFLD(2,"L") ; spaces and 2nd field
 S ENIND=(IOM-Y)\ENMD
 I ENIND>12 S ENIND=12
 I ENIND<2 S ENIND=2
 ;
 S ENNODE=ENRT_0_")"
 F  S ENNODE=$Q(@ENNODE) Q:ENNODE=""  Q:$QS(ENNODE,1)'=$J  D  Q:END
 . S ENLVL=$QL(ENNODE),ENDA=$QS(ENNODE,ENLVL),ENC=+$G(@ENNODE)
 . S ENCOL=ENIND*(ENLVL-2)
 . I $Y+5>IOSL D HD Q:END  D HDSYS
 . S ENV(1)=$E($$GET1^DIQ(6914,ENDA,ENFLD(1)),1,ENFLD(1,"L"))
 . S:ENFLD(2) ENV(2)=$E($$GET1^DIQ(6914,ENDA,ENFLD(2)),1,ENFLD(2,"L"))
 . W !,?ENCOL,ENDA,?ENCOL+ENIND,ENV(1)
 . W:ENFLD(2) $E(ENBL,1,ENFLD(1,"L")-$L(ENV(1))),"   ",ENV(2)
 . I ENC W "  (",ENC," comp.)"
WRAPUP ;
 I END W !!,"REPORT STOPPED BY USER REQUEST"
 E  D
 . W !!,"END OF REPORT"
 . I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 D ^%ZISC
 ;
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="Q"
 K ^TMP($J)
 K DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 K EN,ENC,ENCOL,ENDA,ENDAP,ENFLD,ENIND,ENLVL,ENMD,ENNODE,ENRT,ENT,ENV
 K ENBL,END,ENDL,ENDT,ENPG
 Q
HD ; header
 I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,END)=1 Q
 I $E(IOST,1,2)="C-",ENPG S DIR(0)="E" D ^DIR K DIR I 'Y S END=1 Q
 I $E(IOST,1,2)="C-"!ENPG W @IOF
 S ENPG=ENPG+1
 W !,"PARENT SYSTEM/COMPONENT HIERARCHY",?48,ENDT,?72,"page ",ENPG
 W !,"for "
 I EN("ALL") W "ALL SYSTEMS"
 E  W "SYSTEM with ENTRY #",ENDAP,"  ",ENDAP("CAT")
 W !," print field(s): ",ENFLD(1,"N")
 W:ENFLD(2) " and ",ENFLD(2,"N")
 W !,ENDL
 Q
HDSYS ; header for continued system
 F I=2:1:ENLVL-1 W !,?(ENIND*(I-2)),$QS(ENNODE,I),"  (continued)"
 Q
 ;
GETC(ENDAP,ENPL,ENRT) ; Get All Components Under a Parent System
 ; Input
 ;   ENDAP - ien of parent system (e.g. 1024)
 ;   ENPL  - ien list of parent systems above ENDAP (e.g. 150,7019,10,)
 ;   ENRT  - root of array to store hierarchy in (e.g. X( or ^TMP($J,)
 ;   ENMD  - maximum depth reached
 ; Output
 ;   ENMD  - maximum depth reached
 ;   ^TMP($J,parent ien)=# of components
 ;   ^TMP($J,parent ien,component ien)=""
 N ENDAC,ENC,Y
 ; init component counter
 S ENC=0
 ; loop thru components of parent system ENDAP
 S ENDAC=0 F  S ENDAC=$O(^ENG(6914,"AE",ENDAP,ENDAC)) Q:'ENDAC  D
 . ; check for endless loop
 . I ","_ENPL_ENDAP_","[(","_ENDAC_",") D  Q
 . . W !,"ERROR - ENDLESS LOOP DETECTED - SKIPPING ENTRY"
 . . W !,"  Entry #",ENDAC," already is a parent in ",ENPL_ENDAP_","
 . ; save component
 . S @(ENRT_ENPL_ENDAP_","_ENDAC_")")="",ENC=ENC+1
 . ; see if previous maximum depth exceeded
 . S Y=$L(ENPL_ENDAP_","_ENDAC,",") I Y>ENMD S ENMD=Y
 . ; if component has components then get them also
 . I $O(^ENG(6914,"AE",ENDAC,0)) D GETC(ENDAC,ENPL_ENDAP_",",ENRT)
 ; save parent system component count
 S @(ENRT_ENPL_ENDAP_")")=ENC
 Q
 ;ENEQRP6
