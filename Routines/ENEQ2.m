ENEQ2 ;WIRMFO/DH,SAB-Edit or Display Equipment Records ;4.15.97
 ;;7.0;ENGINEERING;**14,25,29,35,39**;Aug 17, 1993
 ;
EQED ;Edit Record Entry Point
 S ENEQ("MODE")="E"
 S ENEDNX=$D(^XUSEC("ENEDNX",DUZ))
 S ENEDPM=$D(^XUSEC("ENEDPM",DUZ))
 G SELEQ
 ;
EQDS ;Display Record Entry Point
 S ENEQ("MODE")="D"
 G SELEQ
 ;
SELEQ ; select (and process) equipment for edit or display
 ; input
 ;   ENEQ("MODE") - switch: 'E' for edit or 'D" for display
 ;   also when ENEQ("MODE")="E"
 ;     ENEDNX - flag, true if user holds key ENEDNX
 ;     ENEDPM - flag, true if user holds key ENEDPM
 N IOINLOW,IOINHI D ZIS^ENUTL
 S ENEQ("LVL")=0
 S END=0
 ; select and process equipment
 F  D GETEQ^ENUTL Q:Y<1  S ENDA=+Y D EQP Q:END
 ; clean up
 K:ENEQ("MODE")="E" ENEDNX,ENEDPM
 K DIC,END,ENDA,ENEQ,Y
 Q
 ;
EQP ; process one equipment item (display or edit)
 ; input
 ;   ENDA - ien of equipment item
 ;   ENEQ("MODE") - switch: 'E' for edit or 'D' for Display
 ;   ENEQ("LVL") - recursion level
 ;   IOINHI - bold escape code
 ;   IOINLOW - unbold escape code
 ;   END - flag, true when entire process should stop
 ;   also when ENEQ("MODE")="E"
 ;     ENEDPM - flag; true if user holds ENEDPM key
 ;     ENEDNX - flag; true if user holds ENEDNX key
 ; output
 ;   END - flag, true when entire process should stop
 ;
 Q:END
 ; lock equipment
 L +^ENG(6914,ENDA):3 I '$T D  G EQPX
 . W $C(7),!,"Record being edited by someone else. Try later."
 . S DIR(0)="E" D ^DIR K DIR S:$D(DTOUT) END=1
 ; call DJ screen handler
 I ENEQ("MODE")="D" S DJSC="ENEQ1D",DJDIS=1
 I ENEQ("MODE")="E" S DJSC=$S($P($G(^ENG(6914,ENDA,0)),U,4)'="NX"!ENEDNX:"ENEQ1",1:"ENEQNX1")
 S (DJDN,DA)=ENDA
 D EN^ENJ W IOINLOW
 ; PM Data edit (edit mode only)
 I ENEQ("MODE")="E",ENEDPM D
 . S DIR(0)="Y",DIR("A")="Want to enter/edit PM data",DIR("B")="NO"
 . D ^DIR K DIR S:$D(DTOUT) END=1 Q:'Y
 . S DIE="^ENG(6914,",DA=ENDA,ENXP=1 D XNPMSE^ENEQPMP
 . K ENXP
 ; display comments & spex (display mode only)
 I ENEQ("MODE")="D",$O(^ENG(6914,ENDA,5,0))!$O(^ENG(6914,ENDA,10,0)) D
 . W @IOF,"   ***ENTRY NUMBER:",ENDA,"***"
 . ; show COMMENTS (if any)
 . I $O(^ENG(6914,ENDA,5,0)) D WP(ENDA,"COMMENTS",5)
 . ; show SPEX (if any)
 . I '$G(END1),$O(^ENG(6914,ENDA,10,0)) D WP(ENDA,"SPEX",10)
 . ; pause
 . I '$G(END1) S DIR(0)="E" D ^DIR K DIR S:$D(DTOUT) END=1
 . K END1
 ; unlock equip
 L -^ENG(6914,ENDA)
 ; check for components
 I 'END,$O(^ENG(6914,"AE",ENDA,0)) D
 . ; ask if components should be listed
 . S DIR(0)="Y",DIR("B")="NO"
 . S DIR("A")="Equipment has components. Do you want a list (Y/N)"
 . D ^DIR K DIR S:$D(DTOUT) END=1 Q:'Y
 . ; increment recursion level
 . S ENEQ("LVL")=ENEQ("LVL")+1
 . ; build list
 . K ^TMP("ENC",$J,ENEQ("LVL"))
 . S (ENCDA,ENL)=0
 . F  S ENCDA=$O(^ENG(6914,"AE",ENDA,ENCDA)) Q:'ENCDA  D
 . . S ENL=ENL+1
 . . S ^TMP("ENC",$J,ENEQ("LVL"),ENCDA)=""
 . S ^TMP("ENC",$J,ENEQ("LVL"),0)=ENDA_U_ENL
 . ; display list
 . D LISTC
 . ; kill saved list
 . K ^TMP("ENC",$J,ENEQ("LVL"))
 . ; decrement recursion level
 . S ENEQ("LVL")=ENEQ("LVL")-1
EQPX ; clean up
 W @IOF
 K DA,DIE,DIROUT,DIRUT,DR,DTOUT,DUOUT
 K DJDIS,DJD0,DJDN,DJLG,DJSC,DJSW2
 K ENCDA,ENL
 Q
 ;
WP(ENDA,ENFIELD,ENNODE) ; display word-processing field
 ; input
 ;   ENDA    - ien of equipment
 ;   ENFIELD - name of field being displayed
 ;   ENNODE  - node where field is located in file 6914
 ; output
 ;   END    - (optional) true if user timed-out
 ;   END1   - (optional) true if user entered '^' or timed-out
 N ENI
 K ^UTILITY($J,"W") S DIWL=1,DIWR=76,DIWF="W"
 W !!,IOINHI,ENFIELD_":",IOINLOW
 S ENI=0 F  S ENI=$O(^ENG(6914,ENDA,ENNODE,ENI)) Q:'ENI  D  Q:$G(END1)
 . I $Y>19 D  Q:$G(END1)
 . . S DIR(0)="E" D ^DIR K DIR S:$D(DTOUT) END=1 S:'Y END1=1 Q:$G(END1)
 . . W @IOF,"   ***ENTRY NUMBER:",ENDA,"***"
 . . W !!,IOINHI,ENFIELD_" (continued):",IOINLOW
 . S X=^ENG(6914,ENDA,ENNODE,ENI,0) D ^DIWP
 I '$G(END1) D ^DIWW
 K ^UTILITY($J,"W"),DIWL,DIWR,DIWF
 Q
 ;
LISTC ; Show/Select-From Component List
 ; input
 ;   ENEQ("LVL") - recursion level
 ;   ^TMP("ENC",$J,ENEQ("LVL"),0)=parent ien^number of components
 ;   ^TMP("ENC",$J,ENEQ("LVL"),component ien)=""
 ;   END - flag; true if entire process should stop
 ; output
 ;   END - flag; true if entire process should stop
 ;
 ; build screen array from component list
 K ^TMP($J,"SCR")
 S ENCDA=0,ENC=0
 F  S ENCDA=$O(^TMP("ENC",$J,ENEQ("LVL"),ENCDA)) Q:'ENCDA  D
 . S ENC=ENC+1
 . S ENX=ENCDA_U_$E($$GET1^DIQ(6914,ENCDA,3),1,20)
 . S ENX=ENX_U_$E($$GET1^DIQ(6914,ENCDA,6),1,20)
 . S ENX=ENX_U_$E($$GET1^DIQ(6914,ENCDA,24),1,10)
 . S ^TMP($J,"SCR",ENC)=ENX
 S ENX=^TMP("ENC",$J,ENEQ("LVL"),0)
 S ^TMP($J,"SCR")=ENC_U_"Equip. #"_$P(ENX,U)_" Component List"
 S ENX="6;10;Entry#^18;20;Mfgr. Equip. Name"
 S ENX=ENX_"^40;20;Category^62;10;Location"
 S ^TMP($J,"SCR",0)=ENX
LISTC1 ; call list handler
 D EN^ENPLS2
 ; save selected items
 K ^TMP("ENC",$J,ENEQ("LVL"),"ACL")
 S ENC=0,ENJ="" F  S ENJ=$O(ENACL(ENJ)) Q:ENJ=""  D
 . F ENK=1:1 S ENI=$P(ENACL(ENJ),",",ENK) Q:ENI=""  D
 . . S ENY=^TMP($J,"SCR",ENI)
 . . S ^TMP("ENC",$J,ENEQ("LVL"),"ACL",$P(ENY,U))=$P(ENY,U,5)
 . . S ENC=ENC+1
 S:ENC ^TMP("ENC",$J,ENEQ("LVL"),"ACL",0)=ENC
 ; process selected items
 S ENDA=0,END(ENEQ("LVL"))=0
 F  S ENDA=$O(^TMP("ENC",$J,ENEQ("LVL"),"ACL",ENDA)) Q:'ENDA  D  Q:END(ENEQ("LVL"))
 . D EQP Q:END
 . Q:'$O(^TMP("ENC",$J,ENEQ("LVL"),"ACL",ENDA))  ; no more left
 . ; give user chance to break out of this loop or entire process
 . S DIR(0)="FO"
 . S DIR("A")="Press RETURN to continue, '^' to exit, or '^^' to stop"
 . D ^DIR K DIR
 . S:$D(DTOUT)!$D(DIROUT) END=1 S:END!$D(DUOUT) END(ENEQ("LVL"))=1
 K END(ENEQ("LVL"))
 ; restore ENDA to value of parent
 S ENDA=$P($G(^TMP("ENC",$J,ENEQ("LVL"),0)),U)
 ; if items selected then redisplay list
 I 'END,$G(^TMP("ENC",$J,ENEQ("LVL"),"ACL",0))>0 G LISTC
LISTCX ; clean up
 K ^TMP($J,"SCR"),^TMP("ENC",$J,ENEQ("LVL"),"ACL")
 K ENACL,ENC,ENCDA,ENI,ENJ,ENK,ENY,ENX
 Q
 ;ENEQ2
