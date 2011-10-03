GMRCILKP ;SLC/JFR - LOOK UP IFC BY REMOTE CONS #; 1/2/02 14:34
 ;;3.0;CONSULT/REQUEST TRACKING;**22**;DEC 27, 1997
EN ; start here
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y,GMRCSIT,GMRCO,DFN,GMRCREMC
 N VALMBCK,VALMCNT,GMRCA,GMRCDIF,GMRCDVL,GMRCLOC,GMRCWARD,GMRCX,GMRCDISP
 S DIR(0)="PO^4:EMQ"
 S DIR("S")="I $$STA^XUAF4(+Y)=+$$STA^XUAF4(+Y)"
 S DIR("A")="Choose the facility to which the remote entry belongs"
 D ^DIR
 I $D(DIRUT) Q
 S GMRCSIT=+Y
 K X,Y,DIR
 S DIR(0)="NO^1:9999999"
 S DIR("A")="Select the Remote Consult Entry #"
 D ^DIR
 I $D(DIRUT) Q
 S GMRCREMC=Y
 S GMRCO=$O(^GMR(123,"AIFC",GMRCSIT,GMRCREMC,0))
 I '$G(GMRCO) D  G EN
 . W $C(7),!!
 . W "No Consult on file for the selected site with that remote number!"
 . W !!
 . K DIR
 . S DIR(0)="E" D ^DIR
 . W !,"Select again"
 S DFN=$P(^GMR(123,GMRCO,0),U,2)
 K DIR
 S DIR(0)="S^B:brief;D:detailed"
 S DIR("A")="Display type"
 S DIR("B")="B"
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) Q
 S GMRCDISP=Y
 I GMRCDISP="B" D  G EN
 . N GMRCST,GMRCSS,GMRCPNM,GMRCSN
 . D DEM^GMRCU
 . S GMRCSN=$P(GMRCSN,"-",3)
 . S GMRCPNM=$E(GMRCPNM,1,23)
 . S GMRCST=$$GET1^DIQ(100.01,$P(^GMR(123,GMRCO,0),U,12),.1)
 . S GMRCSS=$E($$SVC^GMRCAU(GMRCO),1,22)
 . W !!,"Local cslt#   To Service",?37,"Status   Patient",?74,"SSN"
 . W !,$$REPEAT^XLFSTR("-",79)
 . W !,GMRCO,?14,GMRCSS,?39,GMRCST,?46,GMRCPNM,?74,GMRCSN,!!
 . K DIR S DIR(0)="E" D ^DIR
 . W !,"Select again"
 . D ^GMRCREXT
 I GMRCDISP="D" D  G EN
 . D DT^GMRCSLM2(GMRCO)
 . I '$D(^TMP("GMRCR",$J,"DT")) W !,"Error finding details!" Q
 . M ^TMP("GMRCR",$J,"DTLIST")=^TMP("GMRCR",$J,"DT")
 . S VALMCNT=$O(^TMP("GMRCR",$J,"DTLIST"," "),-1)
 . D EN^VALM("GMRC DETAILED DISPLAY")
 . D ^GMRCREXT
 Q
