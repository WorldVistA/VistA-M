FBUCPAY ;ALBISC/TET - PAYMENT DRIVER ;4/30/93  11:34
 ;;3.5;FEE BASIS;**7**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
ASK ;ask to whom payment should be made, vendor and veteran (to narrow selection)
 S DIR(0)="SMO^1:PATIENT;2:VENDOR",DIR("A")="Select to whom payment should be made" D ^DIR K DIR G END:$D(DIRUT),ASK:'+Y!($G(Y(0))']"")
 S FBPAY=+Y ;1 for patient, 2 for vendor
GET ;get claim for payment, only approved dispositioned claims, non cnh program, ven and vet must match
 K FBVEN,FBVET
VET ;get vet info
 S DIR(0)="162.7,2O",DIR("A")="Select VETERAN" D ^DIR K DIR G END:$D(DIRUT),VET:+Y'>0 S FBVET=+Y
VEN ;get vendor info
 S DIR(0)="162.7,1O",DIR("A")="Select FEE VENDOR" D ^DIR K DIR G END:$D(DUOUT)!($D(DTOUT)),VEN:+Y'>0 S FBVEN=+Y
LOOKUP ;select claim
 S FBIX="APMS",FBIEN=FBVET,FBO="40^70^90^" D DISP7^FBUCUTL5(FBIX,FBIEN,FBO) ;lookup by patient, dispostioned claim only
 ;delete entries from array which don't meet criteria:  program=7(cnh), vendor'=fbven, disposition not approved or approved to stabilization
 S (FBCNT,FBI)=0 F  S FBI=$O(^TMP("FBAR",$J,FBI)) Q:'FBI  S FBZ=$G(^FB583(+^(FBI),0)) D
 .I $S($P(FBZ,U,2)=7:1,$P(FBZ,U,3)'=FBVEN:1,$P(FBZ,U,11)'=1&($P(FBZ,U,11)'=4):1,1:0) D:$$GO(FBI)  K ^TMP("FBAR",$J,FBI) S $P(^("FBAR"),";")=+^TMP("FBAR",$J,"FBAR")-1 Q
 ..S FBZ=$P(^(FBI+1),";")_";  "_$$EXTRL^FBMRASVR($P($P(^(FBI),U),";",2))_U_$P($P(^(FBI+1),U),";",2)_U_$P(^(FBI),U,3,8),$P(FBZ,U,7)="  "_$$EXTRL^FBMRASVR($P(FBZ,U,7)),^TMP("FBAR",$J,FBI+1)=FBZ K FBZ
 .S FBCNT=FBCNT+1 I FBI'=FBCNT S ^TMP("FBAR",$J,FBCNT)=^TMP("FBAR",$J,FBI) K ^TMP("FBAR",$J,FBI)
 D DISPX^FBUCUTL1(1,1) ;display/make selection
 K ^TMP("FBAR",$J) G END:FBOUT!('+$G(FBARY)) ;nothing selected so go to end
LOOP ;loop thru selection and make payments
 N FBDA,FBI,FBNODE,FBP,FBPL,FBW,FBZ D PARSE^FBUCUTL4(FBARY)
 S (FBOUT,FBI)=0 F  S FBI=$O(^TMP("FBARY",$J,FBI)) Q:'FBI  S FBNODE=$G(^(FBI)),FBDA=+$P(FBNODE,";"),FBZ=$G(^FB583(FBDA,0)) D  ;D:$D(FBMESS) WRITE G END:FBOUT,ASK
 .I +$G(FBARY)>1 D LINE^FBUCUTL4(FBNODE,FBI,FBPL,FBW)
 .N FBI,FTP,DUOUT,DTOUT S FBOUT=0 D PAY(FBVET,FBPAY,FBZ)
 D END G ASK
 ;
PAY(FBVET,FBPAY,FBZ) ;determine payments
 I '($P(FBZ,U,11)=1!($P(FBZ,U,11)=4)) W *7 S FBMESS="Unauthorized claim must be Approved or Approved to Stabilization" D WRITE S FBMESS=" in order to make a payment." D WRITE S FBOUT=1 Q
 S (DFN,D0)=FBVET,FBPROG(1)=+$P(FBZ,U,2),FBSUBMIT=$P(FBZ,U,23),FBAAPTC=$S(FBPAY=2:"V",1:"R"),FBAIEN=+$P(FBZ,U,27) ;,FBAAPTC=$S(FBSUBMIT["DPT(":"R",FBSUBMIT["FBAAV(":"V",FBSUBMIT["VA(200,":"O",1:0)
 I FBPROG(1)=7 W *7,! S FBMESS="Fee program is community nursing home." D WRITE S FBMESS="Payments should not be authorized." D WRITE S FBOUT=1 Q
 I FBPROG(1)=6 S DIR(0)="YO",DIR("A")="Is this an ancillary payment",DIR("B")="No" D ^DIR K DIR S:$D(DIRUT) FBOUT=1 Q:$G(FBOUT)  S FBANC=+Y
 S FBPROG="I $P(^(0),""^"",9)[""FB583(""&($P(^(0),""^"",3)="_FBPROG(1)_")"
 S X=FBAIEN,CNT=X,CNT(CNT)=X D 2^FBAAUTL1 I $D(DUOUT)!(FTP']"") S FBOUT=1 Q
 I 'FBAIEN W *7 S FBMESS="No authorization associated with this 583!" D WRITE S FBOUT=1 Q
 ;I FB583'=FBDA W *7 S FBMESS="Authorization does not pertain to the selected unauthorized claim." D WRITE S FBOUT=1 Q
 I FBTYPE'=FBPROG(1) W *7 S FBMESS="Authorization Fee program differs from Fee program in Unauthorized Claim." D WRITE S FBOUT=1 Q
 S FBV583=FB583_";FB583("
 D CR Q:FBOUT
 D HOME^%ZIS W @IOF,!?25,"< UNAUTHORIZED CLAIM >",!! S DIC="^FB583(",DA=FB583,DR="",DIQ(0)="C" D EN^DIQ W ! K DIC,DIQ,DR,DA,CNT,X
 D CR Q:FBOUT
 D  ;G 2:FBPROG(1)=2,3:FBPROG(1)=3,6:FBPROG(1)=6,7:FBPROG(1)=7
 .;payment for outpatinet
 .I FBPROG(1)=2 D EN583^FBAACO Q
 .;payments for pharmacy
 .I FBPROG(1)=3 D ^FBAAPIE Q
 .;payments for civil hospital
 .I FBPROG(1)=6 S FBI7078=FB583_";FB583(",$P(FBZ(0),"^",4)=$P(FBZ,U,5),FBRESUB="" D EN583^FBCHEP:'FBANC,EN583^FBCHCO:FBANC Q
 .;payments for community nursing home
 .I FBPROG(1)=7 W *7,! S FBMESS="Fee program is community nursing home." D WRITE S FBMESS="Payments should not be authorized." D WRITE
 Q
END ;kill variables and quit
 K FB,FBAABDT,FBAAEDT,FBAAOUT,FBAAPTC,FBAIEN,FBANC,FBASSOC,FBARY,FBCNT,FBDA,FBD1,FBFDC,FBI,FBIEN,FBIX,FBI7078,FBMST,FBO,FBOUT
 K FBRESUB,FBTTYPE,FBDMRA,FBMESS,FBPAY,FBPOV,FBPSA,FBPROG,FBPT,FBSUBMIT,FBTP,FBTT,FBTYPE,FBVEN,FBVET,FBV583,FBZ,FB583,FB7078,FTP
 K CNT,DFN,D0,DTOUT,DUOUT,DIC,DIR,DIRUT,DTOUT,DUOUT,TA,X,Y,^TMP("FBARY",$J)
 Q
WRITE ;write message
 W !?5,FBMESS
 Q
CR ;ask carriage return to continue
 S DIR(0)="E" D ^DIR K DIR I $D(DUOUT)!($D(DTOUT)) S FBOUT=1
 Q
 ;
GO(X) ;X=counter from ^TMP("FBAR",$J,X)
 I '$G(X) Q 0
 Q $S($P($G(^TMP("FBAR",$J,X)),U,3,8)']"":0,'$G(^TMP("FBAR",$J,X+1)):0,$P($G(^TMP("FBAR",$J,X+1)),U,3,8)]"":0,1:1)
