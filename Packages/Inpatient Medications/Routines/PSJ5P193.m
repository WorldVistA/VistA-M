PSJ5P193 ;NCD - Check for null start date/times ; 2/4/09 11:26am
 ;;5.0; INPATIENT MEDICATIONS ;**193**;;Build 16
 ;
 ; Reference to ^PS(55 is supported by DBIA# 2191.
 ;Reference to ^PS(50.7 is supported by DBIA# 2180.
 ;Reference to ^PS(52.6 is supported by DBIA# 1231.
 ;Reference to ^%DTC is supported by DBIA# 10000.
 ;Reference to ^%ZTLOAD is supported by DBIA# 10063.
 ;Reference to ^VADPT is supported by DBIA# 10061.
 ;Reference to ^XLFDT is supported by DBIA# 10103.
 ;Reference to ^XMD is supported by DBIA# 10070.
 ;Reference to ^DD is supported by DBIA# 10017.
 ;
ENVN ; Begin check of existing orders
 I $G(DUZ)="" W !,"Your DUZ is not defined.  It must be defined to run this routine." Q
 K ZTSAVE,ZSTK
 S ZTIO="",ZTRTN="START^PSJ5P193",ZTDESC="START DATE CLEAN UP",ZTSAVE("DUZ")="",ZTDTH=$H D ^%ZTLOAD
 W !!,"The check of existing Pharmacy orders is",$S($D(ZTSK):"",1:" NOT")," queued",!
 I $D(ZTSK) D
 . W " (to start NOW).",!!,"YOU WILL RECEIVE A MAILMAN MESSAGE WHEN TASK #"_ZTSK_" HAS COMPLETED.  IF"
 . W !,"ERRORS ARE DETECTED, THE VERIFYING PHARMACIST WILL RECEIVE A MESSAGE INDICATING CLEANUP"
 . W !,"HAS COMPLETED."
 Q
START ;Check of existing Pharmacy orders.
 N XPSJSTDT,XPSJDFN,XPSJON,XPSJLGDT,XPSJSTRT,XPSJSTP,XCNT,XCNTTOT,X,X1,X2,Y,PSJBEG,PSJSTART,CREAT,EXPR,START
 S (XPSJSTDT,XPSJDFN,XPSJON,XCNT,XCNTTOT)=0
 D NOW^%DTC S PSJSTART=$E(%,1,12),CREAT=$E(%,1,7),EXPR=$$FMADD^XLFDT(CREAT,30,0,0,0)
 K ^XTMP("PSJ5P193",$J)
 ;process the stop date crossreference to find orders
 ;with stop dates no more than 30 days old
 S %H=$H-31_",86400" D YMD^%DTC S START=X
 S PSJBEG=START
 F  S PSJBEG=$O(^PS(55,"AUD",PSJBEG)) Q:'PSJBEG  D
 . F  S XPSJDFN=$O(^PS(55,"AUD",PSJBEG,XPSJDFN)) Q:XPSJDFN=""  D
 . . F  S XPSJON=$O(^PS(55,"AUD",PSJBEG,XPSJDFN,XPSJON)) Q:XPSJON=""  D
 . . . S XCNTTOT=XCNTTOT+1 I '(XCNTTOT#1000) H .1
 . . . S XPSJND2=$G(^PS(55,XPSJDFN,5,XPSJON,2)),XPSJSTRT=$P(XPSJND2,"^",2) ;start date/time
 . . . S XPSJLGDT=$P(^PS(55,XPSJDFN,5,XPSJON,0),"^",16) ;login date/time
 . . . I XPSJSTRT="" S ^XTMP("PSJ5P193",$J,XPSJDFN,"U",XPSJON)=XPSJSTRT_"^"_XPSJLGDT,XCNT=XCNT+1
 S PSJBEG=START,(XPSJDFN,XPSJON)=0
 F  S PSJBEG=$O(^PS(55,"AIV",PSJBEG)) Q:'PSJBEG  D
 . F  S XPSJDFN=$O(^PS(55,"AIV",PSJBEG,XPSJDFN)) Q:XPSJDFN=""  D
 . . F  S XPSJON=$O(^PS(55,"AIV",PSJBEG,XPSJDFN,XPSJON)) Q:XPSJON=""  D
 . . . S XPSJN0=$G(^PS(55,XPSJDFN,"IV",XPSJON,0)),XPSJSTRT=$P(XPSJN0,"^",2),XPSJLGDT=$P(^PS(55,XPSJDFN,"IV",XPSJON,2),"^")
 . . . I XPSJSTRT="" S ^XTMP("PSJ5P193",$J,XPSJDFN,"I",XPSJON)=XPSJSTRT_"^"_XPSJLGDT,XCNT=XCNT+1
 I $D(^XTMP("PSJ5P193")) S ^XTMP("PSJ5P193",$J,0)=EXPR_"^"_CREAT
 D SENDMSG
 I $D(^XTMP("PSJ5P193",$J)) D CLEAN
END K X,X1,X2,XMDUZ,XMSUB,XMTEXT,XMY,Y,ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
SENDMSG ;Send mail message when check is complete.
 K PSG
 N DIFROM,XMDUZ,XMSUB,XMTEXT,XMY
 S XMDUZ="INPATIENT,MEDICATIONS",XMSUB="INPATIENT MEDS ORDER CHECK COMPLETED",XMTEXT="PSG(",XMY(DUZ)="" D NOW^%DTC S Y=% X ^DD("DD")
 S PSG(1,0)="The check of existing Pharmacy orders for use with Inpatient",PSG(2,0)="Medications 5.0 completed as of "_Y_"."
 S X=$$FMDIFF^XLFDT(%,PSJSTART,3) S:$L(X," ")>1 DAYS=+$P(X," "),X=$P(X," ",2) S HOURS=+$P(X,":"),MINS=+$P(X,":",2)
 S PSG(3,0)=" ",PSG(4,0)="This process checked orders for patients in "_$S($G(DAYS):DAYS_" day"_$E("s",DAYS'=1)_", ",1:"")_HOURS_" hour"_$E("s",HOURS'=1),PSG(5,0)="and "_MINS_" minute"_$E("s",MINS'=1)_"."
 S PSG(6,0)=XCNT_" pharmacy order"_$S(XCNT'=1:"s were ",1:" was ")_" found with invalid start dates."
 D ^XMD
 Q
 ;
CLEAN ;
 N DFN,X,XPCNT,BLANK,TYP,OI,OINAME,VADM,BEG,END,FSTRT,FSTOP,XPER,XPSJSEND
 K PSG
 S (XPSJDFN,XPSJON)=0,XPCNT=2,$P(BLANK," ",40)="",BEG=1,END=0
 F  S XPSJDFN=$O(^XTMP("PSJ5P193",$J,XPSJDFN)) Q:XPSJDFN=""  F TYP="U","I" D
 . S DFN=XPSJDFN K VADM D DEM^VADPT
 . F  S XPSJON=$O(^XTMP("PSJ5P193",$J,XPSJDFN,TYP,XPSJON)) Q:XPSJON=""  D
 . . I '$D(^PS(55,XPSJDFN,$S(TYP="U":5,1:"IV"),XPSJON)) Q
 . . K OINAME,FSTRT,FSTOP,XPER
 . . S X=^XTMP("PSJ5P193",$J,XPSJDFN,TYP,XPSJON),XPSJSTRT=$P(X,"^"),XPSJLGDT=$P(X,"^",2),XPSJLGTM=$P(XPSJLGDT,".",2)
 . . I TYP="U" S OI=$P($G(^PS(55,XPSJDFN,5,XPSJON,.2)),"^"),OINAME=$P($G(^PS(50.7,OI,0)),"^")
 . . I TYP="I" S AD=$O(^PS(55,XPSJDFN,"IV",XPSJON,"AD",0)) I AD]"" S AIEN=$P($G(^(AD,0)),"^"),OINAME=$P(^PS(52.6,AIEN,0),"^")
 . . ;check if the login time is between midnight and 1:00AM
 . . ;if it's not then can't proceed with the correction
 . . ;this is a new condition
 . . I XPSJSTRT="",XPSJLGDT#1*100'<1 D  Q
 . . .  S XPCNT=XPCNT+1,PSG(XPCNT,0)=$E(VADM(1),1,30)_$E(BLANK,1,32-$L(VADM(1)))_$P(VADM(2),"^")_"  "_$S(TYP="U":"Unit Dose",1:"IV")
 . . .  S XPCNT=XPCNT+1,PSG(XPCNT,0)="can't determine start date.  Order: "_XPSJON
 . . I TYP="U" D
 . . . ;S XPER=$G(^PS(55,XPSJDFN,5,XPSJON,4))
 . . . ;I $P(XPER,"^",3)'="" S XPSJSEND($J,$P(XPER,"^",3))=""  ;get the verifying pharmacist
 . . . S $P(^PS(55,XPSJDFN,5,XPSJON,2),"^",2)=XPSJLGDT
 . . . K ^PS(55,"AUDS",0,XPSJDFN,XPSJON)
 . . . K DIK,DA S DA=XPSJON,DA(1)=XPSJDFN,DIK="^PS(55,"_DA(1)_",5,",DIK(1)="10^AUDS" D EN^DIK
 . . I TYP="I" D
 . . . ;S XPER=$G(^PS(55,XPSJDFN,"IV",XPSJON,4))
 . . . ;I $P(XPER,"^",4)'="" S XPSJSEND($J,$P(XPER,"^",4))="" ;get the verifying pharmacist
 . . . S $P(^PS(55,XPSJDFN,"IV",XPSJON,0),"^",2)=XPSJLGDT
 . . . K ^PS(55,"AIVS",0,XPSJDFN,XPSJON)
 . . . K DIK,DA S DA=XPSJON,DA(1)=XPSJDFN,DIK="^PS(55,"_DA(1)_",""IV"",",DIK(1)=".02^AIVS" D EN^DIK
 . . I TYP="U" S XPSJND2=$G(^PS(55,XPSJDFN,5,XPSJON,2)),XPSJSTRT=$P(XPSJND2,"^",2),XPSJSTP=$P(XPSJND2,"^",4)
 . . I TYP="I" S XPSJND0=$G(^PS(55,XPSJDFN,"IV",XPSJON,0)),XPSJSTRT=$P(XPSJND0,"^",2),XPSJSTP=$P(XPSJND0,"^",3)
 . . S Y=XPSJSTRT X ^DD("DD") S FSTRT=Y
 . . S Y=XPSJSTP X ^DD("DD") S FSTOP=Y
 . . S XPCNT=XPCNT+1,PSG(XPCNT,0)=$E(VADM(1),1,25)_$E(BLANK,1,27-$L(VADM(1)))_$P(VADM(2),"^")_"  "_$S(TYP="U":"Unit Dose",1:"IV")
 . . S OINAME=$G(OINAME),FSTRT=$G(FSTRT),FSTOP=$G(FSTOP)
 . . S XPCNT=XPCNT+1,PSG(XPCNT,0)=" "_$E(OINAME,1,25)_$E(BLANK,1,28-$L(OINAME))_"Start: "_FSTRT_"  Stop: "_FSTOP
 . . S END=END+1 I '(END#500) D CLEANMSG(BEG,END) K PSG S XPCNT=2,BEG=END+1
 D CLEANMSG(BEG,END)
 Q
 ;
CLEANMSG(BEG,END) N DIFROM,XMDUZ,XMSUB,XMTEXT,XMY,LOOP
 S XMDUZ="INPATIENT,MEDICATIONS",XMSUB="INPATIENT MEDS ORDER "_$S(END>0:BEG_"-"_END_" ",1:"")_"CLEANUP COMPLETED",XMTEXT="PSG("
 S LOOP=""
 F  S LOOP=$O(^XUSEC("PSJ RPHARM",LOOP)) Q:LOOP=""  S XMY(LOOP)="" ;send mailman message to all pharmacist who holds PSJ RPHARM key
 D NOW^%DTC S Y=% X ^DD("DD")
 S PSG(1,0)="The cleanup of Inpatient Medication orders ("_$S(END>0:BEG_"-"_END,1:END)_") of "_XCNT_" orders with invalid ",PSG(2,0)="dates completed as of "_Y_"."
 D ^XMD
 Q
