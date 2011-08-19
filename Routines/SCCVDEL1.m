SCCVDEL1 ;ALB/TMP - OLD SCHED VISITS FILE DELETE; [ 03/04/98  09:39 AM ]
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
DELDATA ; -- kill global
 N VALMY,SCCV
 D FULL^VALM1
 W !
 ;
 ; -- check for gaps
 IF '$$GAP^SCCVDEL() G DELDATAQ
 ;
 ; -- check for complete flag
 IF '$$COMPL^SCCVDEL() G DELDATAQ
 ;
 D EN^VALM2($G(XQORNOD(0)))
 S SCCV=0 F  S SCCV=$O(VALMY(SCCV)) Q:'SCCV  D
 . D KILL(+$G(^TMP("SCCV.DELETE.DX",$J,SCCV)))
 D BLD^SCCVDEL
 ;
DELDATAQ ;
 S VALMBCK="R"
 Q
 ;
KILL(FNO) ; -- kill data global
 N SCGLB
 ;
 IF '$G(FNO) W !!,"Invalid file number '",$G(FNO),"' specified." G KILLQ
 ;
 IF FNO'=40.1,FNO'=40.15,FNO'=409.5,FNO'=409.43,FNO'=409.44 W !!,"Invalid file number '",$G(FNO),"' specified." G KILLQ
 ;
 S SCGLB=$$FGLB^SCCVDEL(FNO)
 IF $D(^DIC(FNO)) W !!,"Data global '",SCGLB,"' cannot be KILLed. ^DIC(",FNO,") still exists." G KILLQ
 ;
 IF $D(^DD(FNO)) W !!,"Data global '",SCGLB,"' cannot be KILLed. ^DD(",FNO,") still exists." G KILLQ
 ;
 IF $D(@SCGLB)=0 W !!,"Data global '",SCGLB,"' does not exist. Global does not need to be KILLed." G KILLQ
 ;
 IF $D(@SCGLB) D
 . IF $$PROT(SCGLB) D
 . . S Y=$$LOG^SCCVDEL(FNO,$G(DUZ),"DATA")
 . . IF 'Y D  Q
 . . . W !!,"Cannot kill data global!"
 . . . W !,$P(Y,U,2)
 . . S X="ERR^SCCVDEL1",@^%ZOSF("TRAP")
 . . K @SCGLB
 . . W !!,"Data global '",SCGLB,"' successfully KILLed."
 . ELSE  D
 . . W !!,"Data gloabl '",SCGLB,"' was not KILLed."
 ;
KILLQ D PAUSE^SCCVU
 Q
 ;
PROT(SDGLB) ; -- ask if ok to kill and protection is off
 N DIR,Y
 W !
 S DIR(0)="YA"
 S DIR("A")="Are you sure you want to KILL the '"_SDGLB_"' global? "
 S DIR("B")="No"
 D ^DIR
 IF 'Y S SCOK=0 G PROTQ
 ;
 IF SDGLB="^SDD(409.43)"!(SCGLB="^SDD(409.44)") S SCOK=1 G PROTQ
 ;
 W !
 S DIR(0)="YA"
 S DIR("A")="Are you sure global root KILL protection is turned off? "
 S DIR("B")="No"
 D ^DIR
 IF 'Y S SCOK=0 G PROTQ
 S SCOK=1
PROTQ Q SCOK
 ;
ERR ; -- error trap routine
 ;
 ; -- check for 'protection' error and set $ECODE to null
 ; -- setting of $ECODE to null per Wally Fort instructions on 1/28/99
 IF $$EC^%ZOSV["PROT" D  S $ECODE="" Q
 . W !!,">>> Protection error has occurred. Global has not been KILLed."
 . W !,"    You must removed root-level protection on global."
 D @^%ZOSF("ERRTN")
 Q
