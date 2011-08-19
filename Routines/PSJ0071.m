PSJ0071 ;BIR/JLC - Check for mis-matched schedule internal ; 19-FEB-02
 ;;5.0; INPATIENT MEDICATIONS ;**71**;16 DEC 97
 ;
 ; Reference to ^DD is supported by DBIA# 10017.
 ; Reference to ^PS(51.1 is supported by DBIA# 2177.
 ; Reference to ^PS(52.6 is supported by DBIA# 1231.
 ; Reference to ^VA(200 is supported by DBIA# 10060.
 ; Reference to ^VADPT is supported by DBIA# 10061.
 ; Reference to ^XPD is supported by DBIA# 2197.
 ; Reference to ^PS(55 is supported by DBIA# 2191.
 ; Reference to ^%DTC is supported by DBIA# 10000.
 ; Reference to ^%ZTLOAD is supported by DBIA# 10063.
 ; Reference to ^XLFDT is supported by DBIA# 10103.
 ; Reference to ^XMD is supported by DBIA# 10070.
 ;
ENNV ; Begin check of existing orders
 I $G(DUZ)="" W !,"Your DUZ is not defined.  It must be defined to run this routine." Q
 K ZTSAVE,ZTSK S ZTRTN="ENQN^PSJ0071",ZTDESC="Inpatient Orders Check (INPATIENT MEDS)",ZTIO="" D ^%ZTLOAD
 W !!,"The check of existing Pharmacy orders is",$S($D(ZTSK):"",1:" NOT")," queued",!
 I $D(ZTSK) D
 . W " (to start NOW).",!!,"YOU WILL RECEIVE A MAILMAN MESSAGE WHEN TASK #"_ZTSK_" HAS COMPLETED.  IF"
 . W !,"ERRORS ARE DETECTED, YOU WILL RECEIVE A SECOND MESSAGE INDICATING CLEANUP"
 . W !,"HAS COMPLETED."
 Q
ENQN ; Check of existing Pharmacy orders.
 N PSJSTART,CREAT,EXPR,OCNT,IEN,PSJBEG,PSJPDFN,PSJORD,PSJND0,PSJSCH,PSJADM,PSJFRE,PSJSTA,A,PSGST,PSGS0XT,X,DAYS,MINS
 S PSGOES=1,OCNT=0
 D NOW^%DTC S PSJSTART=$E(%,1,12),CREAT=$E(%,1,7),EXPR=$$FMADD^XLFDT(CREAT,30,0,0,0)
 K ^XTMP("PSJ71")
 ;process the IV start date crossreference to find orders
 ;begin with the first date that PSJ*5*50 was installed
 S IEN=$O(^XPD(9.7,"B","PSJ*5.0*50","")),PSJBEG=$P(^XPD(9.7,IEN,1),"^",3)-1
 F  S PSJBEG=$O(^PS(55,"AIVS",PSJBEG)) Q:'PSJBEG  D
 . S PSJPDFN=0
 . F  S PSJPDFN=$O(^PS(55,"AIVS",PSJBEG,PSJPDFN)) Q:'PSJPDFN  D
 .. S PSJORD=0
 .. F  S PSJORD=$O(^PS(55,"AIVS",PSJBEG,PSJPDFN,PSJORD)) Q:'PSJORD  D
 ... S PSJND0=$G(^PS(55,PSJPDFN,"IV",PSJORD,0)),PSJSCH=$P(PSJND0,"^",9),PSJADM=$P(PSJND0,"^",11),PSJFRE=$P(PSJND0,"^",15),PSJSTA=$P(PSJND0,"^",17)
 ... Q:PSJSTA="D"  Q:PSJSCH=""  Q:PSJFRE=""  Q:PSJFRE="O"  K PSGS0XT
 ... I $D(^PS(51.1,"APPSJ",PSJSCH)) D  S A=^PS(51.1,X,0),PSGST=$P(A,"^",5),PSGS0XT=$P(A,"^",3) Q:PSGST="O"  Q:PSGS0XT=PSJFRE  G ERR
 .... S X=0 F  S X=$O(^PS(51.1,"APPSJ",PSJSCH,X)) Q:'X  I $P(^PS(51.1,X,0),"^",2)=PSJADM Q
 .... I 'X S X=$O(^PS(51.1,"APPSJ",PSJSCH,0))
 ... I PSJSCH="ONCE"!(PSJSCH="NOW")!(PSJSCH="ONE TIME")!(PSJSCH="ONETIME")!(PSJSCH="ONE-TIME")!(PSJSCH="1TIME")!(PSJSCH="1 TIME")!(PSJSCH="1-TIME")!(PSJSCH="STAT") Q
 ... Q:PSJSCH["PRN"
 ... S X=PSJSCH D EN^PSGS0 I $G(PSGS0XT)="" S PSGS0XT=1440
 ... I $G(PSGS0XT)=PSJFRE Q
ERR ... S ^XTMP("PSJ71",PSJPDFN,PSJORD)=PSJSCH_"^"_PSJFRE_"^"_$G(PSGS0XT),OCNT=OCNT+1
 S:$D(^XTMP("PSJ71")) ^XTMP("PSJ71",0)=EXPR_"^"_CREAT
 D SENDMSG
 I $D(^XTMP("PSJ71")) D CLEAN
DONE ;
 K DAYS,MINS,HOURS,PSG,PSJSTART,X,XMDUZ,XMSUB,XMTEXT,XMY,Y,ZTDESC,ZTDTH,ZTIO,ZTREQ,ZTRTN,ZTSAVE,ZTSK S ZTREQ="@"
 Q
SENDMSG ;Send mail message when check is complete.
 K PSG,XMY S XMDUZ="MEDICATIONS,INPATIENT",XMSUB="INPATIENT MEDS ORDER CHECK COMPLETED",XMTEXT="PSG(",XMY(DUZ)="" D NOW^%DTC S Y=% X ^DD("DD")
 S PSG(1,0)="  The check of existing Pharmacy orders for use with Inpatient",PSG(2,0)="Medications 5.0 completed as of "_Y_"."
 S X=$$FMDIFF^XLFDT(%,PSJSTART,3) S:$L(X," ")>1 DAYS=+$P(X," "),X=$P(X," ",2) S HOURS=+$P(X,":"),MINS=+$P(X,":",2)
 S PSG(3,0)=" ",PSG(4,0)="This process checked orders for patients in "_$S($G(DAYS):DAYS_" day"_$E("s",DAYS'=1)_", ",1:"")_HOURS_" hour"_$E("s",HOURS'=1),PSG(5,0)="and "_MINS_" minute"_$E("s",MINS'=1)_"."
 S PSG(6,0)=OCNT_" pharmacy orders were found with potential frequency mis-matches."
 D ^XMD
 Q
 ;
CLEAN ;
 S INS=$P(^VA(200,DUZ,0),"^"),PSJPDFN=0,BEG=1,END=0,PCNT=2,$P(BLANK," ",40)=""
 F  S PSJPDFN=$O(^XTMP("PSJ71",PSJPDFN)) Q:'PSJPDFN  S PSJORD=0 D
 . S DFN=PSJPDFN K VADM D DEM^VADPT
 . F  S PSJORD=$O(^XTMP("PSJ71",PSJPDFN,PSJORD)) Q:'PSJORD  D
 .. I '$D(^PS(55,PSJPDFN,"IV",PSJORD)) Q
 .. S A=^XTMP("PSJ71",PSJPDFN,PSJORD),PSJFRE=$P(A,"^",2),PSGS0XT=$P(A,"^",3)
 .. S $P(^PS(55,PSJPDFN,"IV",PSJORD,0),"^",15)=PSGS0XT
 .. D LOG
 .. S PCNT=PCNT+1,PSG(PCNT,0)=$E(VADM(1),1,25)_$E(BLANK,1,27-$L(VADM(1)))_$P(VADM(2),"^")
 .. S AD=$O(^PS(55,PSJPDFN,"IV",PSJORD,"AD",0)) I AD]"" S AIEN=$P($G(^(AD,0)),"^"),OINAME=$P(^PS(52.6,AIEN,0),"^")
 .. S PSJND=$G(^PS(55,PSJPDFN,"IV",PSJORD,0)),PSJSTRT=$P(PSJND,"^",2),PSJSTP=$P(PSJND,"^",3)
 .. S Y=PSJSTRT X ^DD("DD") S FSTRT=Y
 .. S Y=PSJSTP X ^DD("DD") S FSTOP=Y
 .. S OINAME=$G(OINAME)
 .. S PCNT=PCNT+1,PSG(PCNT,0)=" "_$E(OINAME,1,25)_$E(BLANK,1,28-$L(OINAME))_"Start: "_FSTRT_"  Stop: "_FSTOP
 .. S PCNT=PCNT+1,PSG(PCNT,0)=" "
 .. S END=END+1 I '(END#500) D CLEANMSG(BEG,END) K PSG S PCNT=2,BEG=END+1
 D CLEANMSG(BEG,END) Q
CLEANMSG(BEG,END)         K XMY S XMDUZ="MEDICATIONS,INPATIENT",XMSUB="INPATIENT MEDS ORDER ("_BEG_"-"_END_") CLEANUP COMPLETED",XMTEXT="PSG(",XMY(DUZ)="" D NOW^%DTC S Y=% X ^DD("DD")
 S PSG(1,0)="  The cleanup of Inpatient Medication orders with schedule interval problems  ",PSG(2,0)="completed as of "_Y_"."
 D ^XMD
 Q
LOG ; Create field change entry in activity log.
 N %,X,Y S:'$D(^PS(55,PSJPDFN,"IV",PSJORD,"A",0)) ^(0)="^55.04A^^" S PSIVLN=($P(^PS(55,PSJPDFN,"IV",PSJORD,"A",0),"^",3)+1),$P(^(0),"^",3)=PSIVLN,$P(^(0),"^",4)=$P(^(0),"^",4)+1
 D NOW^%DTC S ^PS(55,PSJPDFN,"IV",PSJORD,"A",PSIVLN,0)=PSIVLN_"^E^"_INS_"^PSJ*5*71 SCHEDULE FREQUENCY MISMATCH^"_%
 S ND=$G(^PS(55,PSJPDFN,"IV",PSJORD,"A",PSIVLN,1,0)) S:ND="" ND="^55.151^^"
 S $P(ND,U,3)=$P(ND,U,3)+1,$P(ND,U,4)=$P(ND,U,4)+1,^PS(55,PSJPDFN,"IV",PSJORD,"A",PSIVLN,1,0)=ND,^PS(55,PSJPDFN,"IV",PSJORD,"A",PSIVLN,1,$P(ND,U,3),0)="SCHEDULE INTERVAL^"_PSJFRE_"^"_PSGS0XT K ND
 Q
