PSJ089B ;BIR/MLV-Check for Orderable Items ;02 MAY 02 / 4:29 PM
 ;;5.0; INPATIENT MEDICATIONS ;**89**;16 DEC 97
 ;
 ; Reference to ^PS(55 is supported by DBIA# 2191.
 ;
ENNV ; Begin check of existing orders
 I $G(DUZ)="" W !,"Your DUZ is not defined.  It must be defined to run this routine." Q
 K ZTSAVE,ZTSK S ZTRTN="ENQN^PSJ089B",ZTDESC="Inpatient Orders Check (INPATIENT MEDS)",ZTIO="" D ^%ZTLOAD
 W !!,"The check of existing Pharmacy orders is",$S($D(ZTSK):"",1:" NOT")," queued",!
 I $D(ZTSK) D
 . W " (to start NOW).",!!,"YOU WILL RECEIVE A MAILMAN MESSAGES WHEN TASK #"_ZTSK_" HAS COMPLETED."
 Q
ENQN ; Check of existing Pharmacy orders.
 N ND0,ND2,PSJBEG,PSJPDFN,PSJORD,CREAT,OCNT,PSJCNTX,PSJCNTY,PSJX,PSJOI,BDT,WBDT
 S (PSJCNTX,PSJCNTY)=0
 D NOW^%DTC S PSJSTART=$E(%,1,12),CREAT=$E(%,1,7)
 ; S WBDT to the date before PSJ*5*70 was released.
 S BDT=3020325
 F PSJPDFN=0:0 S PSJPDFN=$O(^PS(55,PSJPDFN)) Q:'PSJPDFN  F WBDT=BDT:0 S WBDT=$O(^PS(55,PSJPDFN,5,"AUS",WBDT)) Q:'WBDT  F PSJORD=0:0 S PSJORD=$O(^PS(55,PSJPDFN,5,"AUS",WBDT,PSJORD)) Q:'PSJORD  I '+$G(^PS(55,PSJPDFN,5,PSJORD,.2))  D
 . S ND0=$G(^PS(55,PSJPDFN,5,PSJORD,0)),ND2=$G(^PS(55,PSJPDFN,5,PSJORD,2))
 . I $P(ND2,U,2)]"",($P(ND2,U,4)]""),($P(ND0,U,21)="") D  Q
 .. NEW XX S XX=$$ACTIVE^PSJORREN(PSJPDFN,PSJORD_"U")
 .. I +XX=2 S $P(^PS(55,PSJPDFN,5,PSJORD,.2),U)=$P(XX,U,2)
 .. I +XX=0,($P(ND0,U,24)="R"),($P(ND0,U,25)["U") D
 ... S $P(^PS(55,PSJPDFN,5,PSJORD,.2),U)=$P($G(^PS(55,PSJPDFN,5,+$P(ND0,U,25),.2)),U)
 .. S PSJOI=+$G(^PS(55,PSJPDFN,5,PSJORD,.2))
 .. I +PSJOI D EN1^PSJHL2(PSJPDFN,"SN",PSJORD_"U") S PSJCNTY=PSJCNTY+1
 .. I '+PSJOI S PSJCNTX=PSJCNTX+1,PSJX(PSJCNTX)=PSJPDFN_U_PSJORD
 D SENDMSG
DONE ;
 K DAYS,MINS,HOURS,PSG,PSJSTART,X,XMDUZ,XMSUB,XMTEXT,XMY,Y,ZTDESC,ZTDTH,ZTIO,ZTREQ,ZTRTN,ZTSAVE,ZTSK S ZTREQ="@"
 Q
SENDMSG ;Send mail message when check is complete.
 K PSG,XMY NEW X
 S XMDUZ="MEDICATIONS,INPATIENT"
 S XMSUB="PSJ*5*89 INPATIENT MEDS ORDERABLE ITEMS ORDER CHECK COMPLETED"
 S XMTEXT="PSG(",XMY(DUZ)=""
 D NOW^%DTC S Y=% X ^DD("DD")
 S PSG(1,0)="The check of existing Pharmacy orders for use with Inpatient"
 S PSG(2,0)="Medications 5.0 completed as of "_Y_"."
 S X=$$FMDIFF^XLFDT(%,PSJSTART,3)
 S:$L(X," ")>1 DAYS=+$P(X," "),X=$P(X," ",2)
 S HOURS=+$P(X,":"),MINS=+$P(X,":",2)
 S PSG(3,0)=" "
 S PSG(4,0)="This process checked orders for patients in "_$S($G(DAYS):DAYS_" day"_$E("s",DAYS'=1)_", ",1:"")_HOURS_" hour"_$E("s",HOURS'=1),PSG(5,0)="and "_MINS_" minute"_$E("s",MINS'=1)_"."
 S PSG(6,0)=" "
 I PSJCNTY S PSG(7,0)="Updated the orders with the appropriate Orderable Items."
 I PSJCNTX=0,'PSJCNTY S PSG(7,0)="There are no Orderable Items missing from the orders."
 I PSJCNTX>0 S PSG(7,0)="The following order(s) are without the Orderable Item.  Please contact the",PSG(8,0)="NATIONAL HELP DESK for assistance:" D
 . S PSG(9,0)="",OCNT=10
 . F X=0:0 S X=$O(PSJX(X)) Q:'X  S PSG(OCNT,0)="DFN: "_+PSJX(X)_"  ORDER #: "_$P(PSJX(X),U,2)_"U",OCNT=OCNT+1
 D ^XMD
 Q
 ;
SET ;
 Q
