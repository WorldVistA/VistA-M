SCMCRT1A ;ALB/SCK - PCM TEAM PROFILE REPORT OUTPUT ; 10/30/95
 ;;5.3;Scheduling;**41**;AUG 13, 1993
 ;;1T1; Primary Care Management
 ;
 Q
 ;
TMRPT(SCBRK) ;
 N PAGE,SCTEAM,SCPOST,SCWPND,SCWP,LINECNT
 I '$D(^TMP("PCMTP",$J)) D NOREP G EXIT
 U IO
 S (PAGE,LINECNT,END)=0
 ;D HDR Q:END
 ;
 S SCTEAM=""
 F  S SCTEAM=$O(^TMP("PCMTP",$J,SCTEAM)) Q:SCTEAM=""  D:+SCBRK NEWPAGE  D  G:END EXIT
 . N SCWPND
 . D PRINT1(^TMP("PCMTP",$J,SCTEAM,0))
 . S SCWP="",SCWPND=""
 . F  S SCWP=$O(^TMP("PCMTP",$J,SCTEAM,"D",SCWP)) Q:SCWP=""  D  Q:END
 .. S SCWPND(SCWP)=^TMP("PCMTP",$J,SCTEAM,"D",SCWP)
 . IF $D(SCWPND) D PRINTW(.SCWPND)
 . D PRINT2(SCTEAM,^TMP("PCMTP",$J,SCTEAM,0))
 . S SCPOST=""
 . D PRINTCP Q:END
 . F  S SCPOST=$O(^TMP("PCMTP",$J,SCTEAM,"P",SCPOST)) Q:SCPOST=""  D  Q:END
 .. D PRINTP(SCPOST,^TMP("PCMTP",$J,SCTEAM,"P",SCPOST))
 . W !!
 ;
EXIT ;
 D ^%ZISC
 Q
 ;
PRINT1(SCNODE) ;
 N X,X1
 I $Y+5>IOSL D HDR Q:END
 N SCSERV
 S SCSERV=$P($G(SCNODE),U,6)
 S X=$$SPACE(5)_"Team Name: "_$P($G(SCNODE),U)
 S X=X_$$SPACE(45-$L(X))_"Service/Section: "_$E($P($G(^DIC(49,SCSERV,0)),U),1,20)
 W !,X
 ;
 S X=$$SPACE(5)_"Team Telephone: "_$P($G(SCNODE),U,2)
 W !,X
 Q
 ;
PRINTCP ;
 I $Y+8>IOSL D HDR Q:END
 S X=$$SPACE(56)_"Provides     Patients"
 W !,X
 S X=$$SPACE(5)_"Position"_$$SPACE(19)_"Standard Role"_$$SPACE(13)_"Care"_$$SPACE(10)_"Allowed"
 W !,X
 S X=$$SPACE(5)_"--------"_$$SPACE(19)_"-------------"_$$SPACE(13)_"--------"_$$SPACE(6)_"-------"
 W !,X
 Q
 ;
PRINT2(SCIEN,SCNODE) ;
 N X
 I $Y+8>IOSL D HDR Q:END
 N SCPRP,SCMAX,SCINST
 S SCPRP=$P($G(SCNODE),U,3)
 S SCMAX=$P($G(SCNODE),U,8)
 S SCINST=$P($G(SCNODE),U,7)
 S X=$$SPACE(5)_"Team Settings:"
 W !!,X
 ;
 S X=$$SPACE(6)_"Status: "_$S(+$$ACTHISTB^SCAPMCU2(404.58,SCIEN)=1:"ACTIVE",1:"INACTIVE")
 S X=X_$$SPACE(45-$L(X))_"Purpose: "_$E($P($G(^SD(403.47,SCPRP,0)),U),1,20)
 W !,X
 ;
 S X=$$SPACE(6)_"Maximum Patients: "_$S(SCMAX]"":SCMAX,1:0)
 S X=X_$$SPACE(45-$L(X))_"Institution: "_$E($P($G(^DIC(4,SCINST,0)),U),1,20)
 W !,X
 ;
 S X=$$SPACE(5)_$S($P($G(SCNODE),U,5)=1:"This team can provide primary care.",1:"This is not a primary care team")
 W !!,X
 ;
 S X=$$SPACE(5)_$S($P($G(SCNODE),U,10)=1:"This team is closed to further patients.",1:"This team is still accepting patients.")
 W !,X
 Q
 ;
PRINTW(SCDES) ;
 N NC,DIWL,DIWR,DIWF,WP
 I $Y+5>IOSL D HDR Q:END
 K ^UTILITY($J,"W")
 S WP=$$SPACE(5)_"Team Description:"
 W !!,WP
 S DIWL=10,DIWR=80,DIWF="C60"
 S NC=""
 F  S NC=$O(SCDES(NC)) Q:NC=""  D  D ^DIWW
 . S X=SCDES(NC)
 . D ^DIWP
 ;
 S X=""
 F  S X=$O(^UTILITY($J,"W",DIWL,X)) Q:X=""  D
 . S WP=$$SPACE(5)_^UTILTIY($J,"W",DIWL,1,0)
 . W !,WP
 W !
 K ^UTILITY($J,"W")
 Q
 ;
PRINTP(SCPOS,SCPNODE) ;
 N X
 I $Y+5>IOSL D HDR Q:END
 S X=$$SPACE(4)_$S($P(SCPNODE,U,5)=1:">",1:" ")_$E(SCPOS,1,28)
 S X=X_$$SPACE(31-$L(X))_$E($P(SCPNODE,U,2),1,25)
 S X=X_$$SPACE(56-$L(X))_$P(SCPNODE,U,3)
 S X=X_$$SPACE(70-$L(X))_$P(SCPNODE,U,4)
 W !,X
 Q
 ;
NOREP ;
 W !!,"No Information for the Team Profile report"
 Q
 ;
RPTHDR ;
 S X=$$SPACE(5)_"Primary Care Management Team Profile Report"
 W !,X
 S X=$$SPACE(5)_"Report Date: "_$P($$NOW^VALM1,"@")
 S X=X_$$SPACE(70-$L(X))_"Page: "_PAGE
 W !,X,!!
 Q
 ;
HDR ;
 IF $E(IOST,1,2)="C-" W !,"Press RETURN to continue or '^' to exit: " R X:DTIME S END='$T!(X="^")  Q:END
 ;
HDR1 W:'($E(IOST,1,2)'="C-"&'PAGE) @IOF
HDR2 S PAGE=PAGE+1
 D RPTHDR
 Q
 ;
LINE() ;
 N X
 S $P(X,"=",80)=""
 Q X
 ;
SPACE(SCNUM) ;
 N X
 S $P(X," ",SCNUM)=""
 Q X
 ;
WRITE(DEV,STR) ;
 W @STR
 Q
 ;
NEWPAGE ;
 W @IOF
 D HDR2
 Q
