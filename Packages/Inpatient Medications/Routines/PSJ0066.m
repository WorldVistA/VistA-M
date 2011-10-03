PSJ0066 ;BIR/JLC - Check for null start dates/times ; 28-NOV-01
 ;;5.0; INPATIENT MEDICATIONS ;**66**;16 DEC 97
 ;
 ;Reference to ^DD is supported by DBIA# 10017.
 ;Reference to ^PS(50.7 is supported by DBIA# 2180.
 ;Reference to ^PS(52.6 is supported by DBIA# 1231.
 ;Reference to ^PS(55 is supported by DBIA# 2191.
 ;Reference to ^%DTC is supported by DBIA# 10000.
 ;Reference to ^%ZTLOAD is supported by DBIA# 10063.
 ;Reference to ^VADPT is supported by DBIA# 10061.
 ;Reference to ^XLFDT is supported by DBIA# 10103.
 ;Reference to ^XMD is supported by DBIA# 10070.
 ;
ENNV ; Begin check of existing orders
 I $G(DUZ)="" W !,"Your DUZ is not defined.  It must be defined to run this routine." Q
 K ZTSAVE,ZTSK S ZTRTN="ENQN^PSJ0066",ZTDESC="Inpatient Orders Check (INPATIENT MEDS)",ZTIO="" D ^%ZTLOAD
 W !!,"The check of existing Pharmacy orders is",$S($D(ZTSK):"",1:" NOT")," queued",!
 I $D(ZTSK) D
 . W " (to start NOW).",!!,"YOU WILL RECEIVE A MAILMAN MESSAGE WHEN TASK #"_ZTSK_" HAS COMPLETED.  IF"
 . W !,"ERRORS ARE DETECTED, YOU WILL RECEIVE A SECOND MESSAGE INDICATING CLEANUP"
 . W !,"HAS COMPLETED."
 Q
ENQN ; Check of existing Pharmacy orders.
 N PSJBEG,PSJPDFN,PSJORD,PSJSTRT,CREAT,EXPR,OCNT,PSJND0,PSJND2,START
 D NOW^%DTC S PSJSTART=$E(%,1,12),CREAT=$E(%,1,7),EXPR=$$FMADD^XLFDT(CREAT,30,0,0,0),OCNT=0
 K ^XTMP("PSJ")
 ;process the stop date crossreference to find orders
 ;with stop dates no more than 30 days old
 S %H=$H-31_",86400" D YMD^%DTC S START=X
 S PSJBEG=START
 F  S PSJBEG=$O(^PS(55,"AUD",PSJBEG)) Q:'PSJBEG  D
 . S PSJPDFN=0
 . F  S PSJPDFN=$O(^PS(55,"AUD",PSJBEG,PSJPDFN)) Q:'PSJPDFN  D
 .. S PSJORD=0
 .. F  S PSJORD=$O(^PS(55,"AUD",PSJBEG,PSJPDFN,PSJORD)) Q:'PSJORD  D
 ... S PSJND2=$G(^PS(55,PSJPDFN,5,PSJORD,2)),PSJSTRT=$P(PSJND2,"^",2)
 ... I PSJSTRT=""!($P(PSJSTRT,".",2)="") S ^XTMP("PSJ",PSJPDFN,"U",PSJORD)=PSJSTRT,OCNT=OCNT+1
 S PSJBEG=START
 F  S PSJBEG=$O(^PS(55,"AIV",PSJBEG)) Q:'PSJBEG  D
 . S PSJPDFN=0
 . F  S PSJPDFN=$O(^PS(55,"AIV",PSJBEG,PSJPDFN)) Q:'PSJPDFN  D
 .. S PSJORD=0
 .. F  S PSJORD=$O(^PS(55,"AIV",PSJBEG,PSJPDFN,PSJORD)) Q:'PSJORD  D
 ... S PSJND0=$G(^PS(55,PSJPDFN,"IV",PSJORD,0)),PSJSTRT=$P(PSJND0,"^",2)
 ... I PSJSTRT=""!($P(PSJSTRT,".",2)="") S ^XTMP("PSJ",PSJPDFN,"I",PSJORD)=PSJSTRT,OCNT=OCNT+1
 S:$D(^XTMP("PSJ")) ^XTMP("PSJ",0)=EXPR_"^"_CREAT
 D SENDMSG
 I $D(^XTMP("PSJ")) D CLEAN
DONE ;
 K DAYS,MINS,HOURS,PSG,PSJSTART,X,XMDUZ,XMSUB,XMTEXT,XMY,Y,ZTDESC,ZTDTH,ZTIO,ZTREQ,ZTRTN,ZTSAVE,ZTSK S ZTREQ="@"
 Q
SENDMSG ;Send mail message when check is complete.
 K PSG,XMY S XMDUZ="MEDICATIONS,INPATIENT",XMSUB="INPATIENT MEDS ORDER CHECK COMPLETED",XMTEXT="PSG(",XMY(DUZ)="" D NOW^%DTC S Y=% X ^DD("DD")
 S PSG(1,0)="  The check of existing Pharmacy orders for use with Inpatient",PSG(2,0)="Medications 5.0 completed as of "_Y_"."
 S X=$$FMDIFF^XLFDT(%,PSJSTART,3) S:$L(X," ")>1 DAYS=+$P(X," "),X=$P(X," ",2) S HOURS=+$P(X,":"),MINS=+$P(X,":",2)
 S PSG(3,0)=" ",PSG(4,0)="This process checked orders for patients in "_$S($G(DAYS):DAYS_" day"_$E("s",DAYS'=1)_", ",1:"")_HOURS_" hour"_$E("s",HOURS'=1),PSG(5,0)="and "_MINS_" minute"_$E("s",MINS'=1)_"."
 S PSG(6,0)=OCNT_" pharmacy orders were found with invalid start dates."
 D ^XMD
 Q
 ;
CLEAN ;
 N PSJPDFN,PSJORD,PSJND,PSJND2,PSJST,PSJSTRT,PSJSTP,PSJLOG,Y,PSJOSTP,PSJPREV,AD,AIEN,BEG,END,DFN,FO,FSTOP,FSTRT,PCNT,PREV0,PREV2,RFO,OPSJSTRT,TYP,OI,OINAME,BLANK
 S PSJPDFN=0,BEG=1,END=0,PCNT=2,$P(BLANK," ",40)=""
 F  S PSJPDFN=$O(^XTMP("PSJ",PSJPDFN)) Q:'PSJPDFN  S PSJORD=0 F TYP="U","I" D
 . S DFN=PSJPDFN K VADM D DEM^VADPT
 . F  S PSJORD=$O(^XTMP("PSJ",PSJPDFN,TYP,PSJORD)) Q:'PSJORD  D
 .. I '$D(^PS(55,PSJPDFN,$S(TYP="U":5,1:"IV"),PSJORD)) Q
 .. K OINAME,FSTRT,FSTOP
 .. I TYP="U" D
 ... S PSJND=$G(^PS(55,PSJPDFN,5,PSJORD,0)),PSJST=$P(PSJND,"^",7),PSJPREV=+$P(PSJND,"^",25)
 ... S PSJND2=$G(^PS(55,PSJPDFN,5,PSJORD,2)),(PSJSTRT,OPSJSTRT)=$P(PSJND2,"^",2)
 ... S OI=$P($G(^PS(55,PSJPDFN,5,PSJORD,.2)),"^"),OINAME=$P($G(^PS(50.7,OI,0)),"^")
 ... S PREV0=$G(^PS(55,PSJPDFN,5,PSJPREV,0)),FO=$P(PREV0,"^",26),RFO=$P(PREV0,"^",27)
 ... S PSJOSTP=$P($G(^PS(55,PSJPDFN,5,PSJPREV,2)),"^",4)
 .. I TYP="I" D
 ... S PSJND=$G(^PS(55,PSJPDFN,"IV",PSJORD,0)),(PSJSTRT,OPSJSTRT)=$P(PSJND,"^",2),PSJST=$P(PSJND,"^",17)
 ... S PSJND2=$G(^PS(55,PSJPDFN,"IV",PSJORD,2)),PSJPREV=+$P(PSJND2,"^",5)
 ... S AD=$O(^PS(55,PSJPDFN,"IV",PSJORD,"AD",0)) I AD]"" S AIEN=$P($G(^(AD,0)),"^"),OINAME=$P(^PS(52.6,AIEN,0),"^")
 ... S PREV2=$G(^PS(55,PSJPDFN,"IV",PSJPREV,2)),FO=$P(PREV2,"^",6),RFO=$P(PREV2,"^",9)
 ... S PSJOSTP=$P($G(^PS(55,PSJPDFN,"IV",PSJPREV,0)),"^",3)
 .. ;if there's a null start date, check if the previous order was
 .. ;renewed to cause this order to be created and if the stop date
 .. ;is there, use it
 .. I PSJSTRT="",PSJPREV D
 ... I +FO'=+PSJORD!(RFO'="R") Q
 ... I TYP="U" D
 .... S $P(^PS(55,PSJPDFN,5,PSJORD,2),"^",2)=+PSJOSTP
 .... I OPSJSTRT]"" K ^PS(55,"AUDS",OPSJSTRT,PSJPDFN,PSJORD)
 .... S ^PS(55,"AUDS",+PSJOSTP,PSJPDFN,PSJORD)=""
 ... I TYP="I" D
 .... S $P(^PS(55,PSJPDFN,"IV",PSJORD,0),"^",2)=+PSJOSTP
 .... I OPSJSTRT]"" K ^PS(55,"AIVS",OPSJSTRT,PSJPDFN,PSJORD)
 .... S ^PS(55,"AIVS",+PSJOSTP,PSJPDFN,PSJORD)=""
 .. ;check to be sure the start date on the order exists
 .. ;if it doesn't, can't proceed with the correction
 .. ;this is a new condition
 .. I TYP="U" S PSJND2=$G(^PS(55,PSJPDFN,5,PSJORD,2)),(PSJSTRT,OPSJSTRT)=$P(PSJND2,"^",2) I PSJSTRT'[".",$L(PSJSTRT)>7 S PSJSTRT=$E(PSJSTRT,1,7)
 .. I TYP="I" S PSJND=$G(^PS(55,PSJPDFN,"IV",PSJORD,0)),(PSJSTRT,OPSJSTRT)=$P(PSJND,"^",2) I PSJSTRT'[".",$L(PSJSTRT)>7 S PSJSTRT=$E(PSJSTRT,1,7)
 .. I PSJSTRT="" D  Q
 ... S PCNT=PCNT+1,PSG(PCNT,0)=$E(VADM(1),1,30)_$E(BLANK,1,32-$L(VADM(1)))_$P(VADM(2),"^")_"  "_$S(TYP="U":"Unit Dose",1:"IV")
 ... S PCNT=PCNT+1,PSG(PCNT,0)="can't determine start date.  Order: "_PSJORD
 .. ;check to be sure the start date (even if
 .. ;acquired from a previous order) has a time on it
 .. ;if not, make it midnight
 .. I $P(PSJSTRT,".",2)="" S $P(PSJSTRT,".",2)=24
 .. I TYP="U" D
 ... S $P(^PS(55,PSJPDFN,5,PSJORD,2),"^",2)=+PSJSTRT
 ... K ^PS(55,"AUDS",OPSJSTRT,PSJPDFN,PSJORD)
 ... S ^PS(55,"AUDS",+PSJSTRT,PSJPDFN,PSJORD)=""
 .. I TYP="I" D
 ... S $P(^PS(55,PSJPDFN,"IV",PSJORD,0),"^",2)=+PSJSTRT
 ... K ^PS(55,"AIVS",OPSJSTRT,PSJPDFN,PSJORD)
 ... S ^PS(55,"AIVS",+PSJSTRT,PSJPDFN,PSJORD)=""
 .. I TYP="U" S PSJND2=$G(^PS(55,PSJPDFN,5,PSJORD,2)),PSJSTRT=$P(PSJND2,"^",2),PSJSTP=$P(PSJND2,"^",3)
 .. I TYP="I" S PSJND=$G(^PS(55,PSJPDFN,"IV",PSJORD,0)),(PSJSTRT,OPSJSTRT)=$P(PSJND,"^",2),PSJSTP=$P(PSJND,"^",3)
 .. S Y=PSJSTRT X ^DD("DD") S FSTRT=Y
 .. S Y=PSJSTP X ^DD("DD") S FSTOP=Y
 .. S PCNT=PCNT+1,PSG(PCNT,0)=$E(VADM(1),1,25)_$E(BLANK,1,27-$L(VADM(1)))_$P(VADM(2),"^")_"  "_$S(TYP="U":"Unit Dose",1:"IV")
 .. S OINAME=$G(OINAME),FSTRT=$G(FSTRT),FSTOP=$G(FSTOP)
 .. S PCNT=PCNT+1,PSG(PCNT,0)=" "_$E(OINAME,1,25)_$E(BLANK,1,28-$L(OINAME))_"Start: "_FSTRT_"  Stop: "_FSTOP
 .. S END=END+1 I '(END#500) D CLEANMSG(BEG,END) K PSG S PCNT=2,BEG=END+1
 D CLEANMSG(BEG,END) Q
CLEANMSG(BEG,END)         K XMY S XMDUZ="MEDICATIONS,INPATIENT",XMSUB="INPATIENT MEDS ORDER ("_BEG_"-"_END_") CLEANUP COMPLETED",XMTEXT="PSG(",XMY(DUZ)="" D NOW^%DTC S Y=% X ^DD("DD")
 S PSG(1,0)="  The cleanup of Inpatient Medication orders ("_BEG_"-"_END_") with invalid dates ",PSG(2,0)="completed as of "_Y_"."
 D ^XMD
 Q
