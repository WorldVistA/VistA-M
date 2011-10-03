FBUCOUT ;ALBISC/TET - OUTPUTS ;7/18/2001
 ;;3.5;FEE BASIS;**32**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
ASK ;ask search/sort questions
 ; ask if report for just mill-bill (1725) or just non-mill bill claims
 S FB1725R=$$ASKMB^FBUCUTL9 I FB1725R="" G END
 S DIR(0)="SM^1:PATIENT;2:VENDOR",DIR("A")="Sort by" D ^DIR K DIR G END:$D(DIRUT),ASK:'+Y!($G(Y(0))']"") S FLDS="[FBUC STATUS BY "_Y(0)_"]"
 D DISP92^FBUCUTL5,DISPX^FBUCUTL1(1) ;set array,display
 G END:FBOUT,ASK:'+FBARY S FBI=0 F  S FBI=$O(^TMP("FBARY",$J,FBI)) Q:'FBI  S FBARY(+$G(^TMP("FBARY",$J,FBI)))=""
 S DIS(0)="I $D(FBARY(+$P($G(^FB583(D0,0)),U,24)))"
 ; if just mill bill or non-mill bill then set screen and title
 I FB1725R="M" D
 . S DIS(1)="I $P($G(^FB583(D0,0)),U,28)=1"
 . S DHD="STATUS LISTING OF MILL BILL (1725) CLAIMS"
 I FB1725R="N" D
 . S DIS(1)="I $P($G(^FB583(D0,0)),U,28)'=1"
 . S DHD="STATUS LISTING OF UNAUTH. NON-MILL BILL CLAIMS"
 S L=0,DIC="^FB583(",BY=FLDS,FR="?,@,@,,@,@,@",TO="?,,,,,,"
 S FBDT=DT,FBZLOW=FBDT,FBZHI=$$CDTC^FBUCUTL(FBDT,30)
 D EN1^DIP
 ;set up variable fbexp
 ;set up dip variables, call dip
END ;kill and quit
 K FBARY,FBDT,FBEXP,FBI,FBOUT,FBZLOW,FBZHI,BY,DIC,DIR,DIRUT,DIS,DTOUT,DUOUT,FLDS,FR,L,TO,Y,^TMP("FBAR",$J),^TMP("FBARY",$J),FB1725R,DHD
 Q
CODE(X) ;dispostion code of disposition if status order is 40,70 or 90
 ; 40=dispositioned,70=appeal dispositioned,90=bva appeal dispositioned
 I '+X Q ""
 Q $P($$PTR^FBUCUTL("^FB(162.91,",X),U,3)
 ;
