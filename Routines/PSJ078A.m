PSJ078A ;BIR/JCH-Check for stop date problems ;28-NOV-01
 ;;5.0; INPATIENT MEDICATIONS ;**78**;16 DEC 97
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
 K ZTSAVE,ZTSK S ZTRTN="ENQN^PSJ078A",ZTDESC="Inpatient Orders Check (INPATIENT MEDS)",ZTIO="" D ^%ZTLOAD
 W !!,"The check of existing Pharmacy orders is",$S($D(ZTSK):"",1:" NOT")," queued",!
 I $D(ZTSK) D
 . W " (to start NOW).",!!,"YOU WILL RECEIVE A MAILMAN MESSAGE WHEN TASK #"_ZTSK_" HAS COMPLETED.  IF"
 . W !,"ERRORS ARE DETECTED, YOU WILL RECEIVE A SECOND MESSAGE INDICATING CLEANUP"
 . W !,"HAS COMPLETED."
 Q
ENQN ; Check of existing Pharmacy orders.
 N PSJBEG,PSJPDFN,PSJORD,PSJSTOP,PSJNVDT,CREAT,EXPR,OCNT,PSJND0,PSJND2,START
 N PSJSTRT
 D NOW^%DTC S PSJSTART=$E(%,1,12),CREAT=$E(%,1,7)
 S EXPR=$$FMADD^XLFDT(CREAT,30,0,0,0),OCNT=0
 K ^XTMP("PSJ"),^XTMP("PSJ XREF")
 ;
 ;process data nodes
 S PSJPDFN=0 F  S PSJPDFN=$O(^PS(55,PSJPDFN)) Q:'PSJPDFN  D
 . F TYP="IV",5 D
 .. S ORD=0 F  S ORD=$O(^PS(55,PSJPDFN,TYP,ORD)) Q:'ORD  D
 ... Q:$TR($P($G(^PS(55,PSJPDFN,TYP,ORD,0)),"^",2,8),"^")=""
 ... I TYP="IV" D
 .... S PSJND0=$G(^PS(55,PSJPDFN,"IV",ORD,0))
 .... S PSJSTRT=$P(PSJND0,"^",2),PSJSTOP=$P(PSJND0,"^",3)
 .... S PSJNVDT=$P($G(^PS(55,PSJPDFN,"IV",ORD,4)),"^",2)
 ... I TYP=5 D
 .... S ND2=$G(^PS(55,PSJPDFN,TYP,ORD,2)),PSJSTRT=$P(ND2,"^",2)
 .... S PSJSTOP=$P(ND2,"^",4)
 .... S PSJNVDT=$P($G(^PS(55,PSJPDFN,5,ORD,4)),"^",2)
 ... I PSJSTOP=""!($P(PSJSTOP,".",2)="")!(PSJSTOP'=+PSJSTOP)!($L(PSJSTOP)<5) D  Q
 .... S ^XTMP("PSJ",PSJPDFN,TYP,ORD)=PSJSTRT,OCNT=OCNT+1
 ... I PSJSTRT=""!($P(PSJSTRT,".",2)="")!(PSJSTRT'=+PSJSTRT)!($L(PSJSTRT)<5) D  Q
 .... S ^XTMP("PSJ",PSJPDFN,TYP,ORD)=PSJSTRT,OCNT=OCNT+1
 ... I PSJNVDT]"",PSJNVDT'=+PSJNVDT D
 .... S ^XTMP("PSJ",PSJPDFN,TYP,ORD)=PSJNVDT,OCNT=OCNT+1
 S:$D(^XTMP("PSJ")) ^XTMP("PSJ",0)=EXPR_"^"_CREAT
 D SENDMSG
 I $D(^XTMP("PSJ")) D CLEAN
 D XREFS^PSJ078B
 ;
DONE ;
 K DAYS,MINS,HOURS,PSG,PSJSTART,X,XMDUZ,XMSUB,XMTEXT,XMY,Y,ZTDESC,ZTDTH,ZTIO,ZTREQ,ZTRTN,ZTSAVE,ZTSK S ZTREQ="@"
 Q
 ;
SENDMSG ;Send mail message when check is complete.
 K PSG,XMY S XMDUZ="MEDICATIONS,INPATIENT",XMSUB="PSJ*5*78 INPATIENT MEDS STOP DATE ORDER CHECK COMPLETED",XMTEXT="PSG(",XMY(DUZ)="" D NOW^%DTC S Y=% X ^DD("DD")
 S PSG(1,0)="  The check of existing Pharmacy orders for use with Inpatient",PSG(2,0)="Medications 5.0 completed as of "_Y_"."
 S X=$$FMDIFF^XLFDT(%,PSJSTART,3) S:$L(X," ")>1 DAYS=+$P(X," "),X=$P(X," ",2) S HOURS=+$P(X,":"),MINS=+$P(X,":",2)
 S PSG(3,0)=" ",PSG(4,0)="This process checked orders for patients in "_$S($G(DAYS):DAYS_" day"_$E("s",DAYS'=1)_", ",1:"")_HOURS_" hour"_$E("s",HOURS'=1),PSG(5,0)="and "_MINS_" minute"_$E("s",MINS'=1)_"."
 S PSG(6,0)=OCNT_" pharmacy orders were found with invalid stop dates."
 D ^XMD
 Q
 ;
CLEAN ;
 N PSJPDFN,PSJORD,PSJND,PSJND2,PSJSTRT,PSJLOG,Y,PSJOSTP
 N PSJFOL,AD,AEN,BEG,END,DFN,PO,FSTOP,FSTRT,PCNT,FOLL0,PREV2,RFO
 N OPSJSTP,OPSJSTRT,TYP,OI,OINAME,BLANK,PSGTMP
 S PSJPDFN=0,BEG=1,END=0,PCNT=6,$P(BLANK," ",40)="",AEN=0
 F  S PSJPDFN=$O(^XTMP("PSJ",PSJPDFN)) Q:'PSJPDFN  D
 . F TYP="IV",5 D
 .. S DFN=PSJPDFN K VADM D DEM^VADPT
 .. S PSJORD=0
 .. F  S PSJORD=$O(^XTMP("PSJ",PSJPDFN,TYP,PSJORD)) Q:'PSJORD  D
 ... S PSJND=$G(^PS(55,PSJPDFN,$S(TYP=5:5,1:"IV"),PSJORD,0))
 ... S PSJND4=$G(^PS(55,PSJPDFN,$S(TYP=5:5,1:"IV"),PSJORD,4))
 ... I $TR(PSJND,"^","")="" Q
 ... N PSJST,PSJPREV,PSJSTP,PSJSTRT,PSJFOL,OPSJSTP,OPSJSTRT
 ... K OINAME,FSTRT,FSTOP,STRTCHG,STOPCHG,FOLL2,FOLSTRT,PREVFO,PREV0
 ... K OI,FOLL0
 ... I TYP=5 D
 .... S PSJST=$P(PSJND,"^",7)  ;Schedule Type for UD(different than IV)
 .... S PSJFOL=+$P(PSJND,"^",26)
 .... S PSJPREV=+$P(PSJND,"^",25),PSJND2=$G(^PS(55,PSJPDFN,5,PSJORD,2))
 .... S (PSJSTP,OPSJSTP)=$P(PSJND2,"^",4)
 .... S (PSJSTRT,OPSJSTRT)=$P(PSJND2,"^",2)
 .... S PSJNVDT=$P(PSJND4,"^",2)
 .... S OI=$P($G(^PS(55,PSJPDFN,5,PSJORD,.2)),"^")
 .... S OINAME=$S(OI:$P($G(^PS(50.7,OI,0)),"^"),1:"OI NOT FOUND")
 .... I PSJFOL D
 ..... S FOLL0=$G(^PS(55,PSJPDFN,5,PSJFOL,0)),FOLPO=$P(FOLL0,"^",25)
 ..... S FOLL2=$G(^PS(55,PSJPDFN,5,PSJFOL,2)),FOLSTRT=$P(FOLL2,"^",2)
 .... I PSJPREV D
 ..... S PSJOSTP=$P($G(^PS(55,PSJPDFN,5,PSJPREV,2)),"^",4)
 ..... S PREV0=$G(^PS(55,PSJPDFN,5,PSJPREV,0)),PREVFO=$P(PREV0,"^",26)
 ..... S PREVRFO=$P(PREV0,"^",27)
 ... I TYP="IV" D
 .... S PSJST=$P(PSJND,"^",4),(PSJSTRT,OPSJSTRT)=$P(PSJND,"^",2)
 .... S (PSJSTP,OPSJSTP)=$P(PSJND,"^",3)
 .... S OI=$P($G(^PS(55,PSJPDFN,"IV",PSJORD,.2)),"^")
 .... S OINAME=$S(OI:$P($G(^PS(50.7,OI,0)),"^"),1:"")
 .... S PSJND2=$G(^PS(55,PSJPDFN,"IV",PSJORD,2))
 .... S PSJNVDT=$P(PSJND4,"^",2)
 .... S AD=$O(^PS(55,PSJPDFN,"IV",PSJORD,"AD",0))
 .... I OINAME="",AD]"" S AEN=$P($G(^PS(55,PSJPDFN,"IV",PSJORD,"AD",AD,0)),"^") D
 ..... S OINAME=$P($G(^PS(52.6,+AEN,0)),"^")
 ..... S:OINAME="" OINAME="OI NOT FOUND"
 .... S PSJPREV=+$P(PSJND2,"^",5),PSJFOL=$P(PSJND2,"^",6)
 .... I PSJFOL S FOLL0=$G(^PS(55,PSJPDFN,"IV",+PSJFOL,0)) D
 ..... S FOLL2=$G(^PS(55,PSJPDFN,"IV",+PSJFOL,2))
 ..... S FOLPO=$P(FOLL2,"^",5),FOLSTRT=$P(FOLL0,"^",2)
 .... I PSJPREV S PREV2=$G(^PS(55,PSJPDFN,"IV",PSJPREV,2)) D
 ..... S PSJOSTP=$P($G(^PS(55,PSJPDFN,"IV",PSJPREV,0)),"^",3)
 ..... S PREVFO=$P(PREV2,"^",6),PREVRFO=$P(PREV2,"^",9)
 ... ; 
 ... ;If there's a null start date, check if the previous order was
 ... ; renewed to cause this order to be created and if the stop date
 ... ; is there, use it
 ... ;If there's a null stop date, check if this order has a following
 ... ; order, and if the start date is there, use it
 ... ;Check to be sure the dates (even if acquired from a previous or 
 ... ; following order) has a time on it; if not, make it midnight
 ... ;Check for trailing zeroes by forcing numeric
 ... ;Check for any other odd format with length < 5
 ... I PSJSTRT="",$G(PSJOSTP) I (+$G(PREVFO)=+PSJORD) D
 .... S PSJSTRT=+PSJOSTP,STRTCHG=1
 ... I PSJSTRT'[".",$L(PSJSTRT)>7 S PSJSTRT=$E(PSJSTRT,1,7),STRTCHG=1
 ... I PSJSTRT,$P(PSJSTRT,".",2)="" S $P(PSJSTRT,".",2)=1,STRTCHG=1
 ... I PSJSTRT,(PSJSTRT'=+PSJSTRT) S PSJSTRT=+PSJSTRT,STRTCHG=1
 ... I PSJSTP="",$G(FOLSTRT) I (+$G(FOLPO)=PSJORD) D
 .... S PSJSTP=FOLSTRT,STOPCHG=1
 ... I PSJSTP'[".",$L(PSJSTP)>7 S PSJSTP=$E(PSJSTP,1,7),STOPCHG=1
 ... I PSJSTP,$P(PSJSTP,".",2)="" S $P(PSJSTP,".",2)=24,STOPCHG=1
 ... I PSJSTP,(PSJSTP'=+PSJSTP) S PSJSTP=+PSJSTP,STOPCHG=1
 ... ; Prepare message with results
 ... I 'PSJSTRT!'PSJSTP!($G(STOPCHG))!($G(STRTCHG)) D
 .... S PCNT=PCNT+1,PSGTMP=$E(VADM(1),1,25)_$E(BLANK,1,27-$L(VADM(1)))
 .... S PSGTMP=PSGTMP_$P(VADM(2),"^")
 .... S PSG(PCNT,0)=PSGTMP_"  "_$S(TYP=5:"Unit Dose",1:"IV")
 .... S Y=PSJSTRT X ^DD("DD") S FSTRT=Y,Y=PSJSTP X ^DD("DD") S FSTOP=Y
 .... I $G(STOPCHG)!$G(STRTCHG) D
 ..... S OINAME=$G(OINAME),FSTRT=$G(FSTRT),FSTOP=$G(FSTOP),PCNT=PCNT+1
 ..... S PSG(PCNT,0)=" "_$E(OINAME,1,20)_$E(BLANK,1,22-$L(OINAME))
 ..... S PSG(PCNT,0)=PSG(PCNT,0)_"Start: "_FSTRT_"  Stop: "_FSTOP
 ..... I $G(STOPCHG),PSJST="" S PCNT=PCNT+1 D
 ...... S PSG(PCNT,0)=" Missing "_$S(TYP=5:"Schedule Type",1:"IV Type")
 ...... S PSG(PCNT,0)=PSG(PCNT,0)_" DATE(S) NOT CORRECTED. "
 ...... S PSG(PCNT,0)=PSG(PCNT,0)_" Order: "_PSJORD
 .... I 'PSJSTRT!'PSJSTP S PCNT=PCNT+1 D
 ..... I $G(STOPCHG)!$G(STRTCHG) S OINAME=""
 ..... S PSGTMP=" "_$E(OINAME,1,20)_$E(BLANK,1,22-$L(OINAME))_" Can't determine "_$S('PSJSTRT:"start date",1:"")
 ..... S PSGTMP=PSGTMP_$S('PSJSTRT&('PSJSTP):" or ",1:"")_$S('PSJSTP:"stop date",1:"")_". Order: "_PSJORD
 ..... S PSG(PCNT,0)=PSGTMP
 ... ;
 ... ; Update ^PS(55 and indices
 ... I TYP=5 D:$G(STRTCHG) UDSTART^PSJ078B D:$G(STOPCHG) UDSTOP^PSJ078B
 ... I TYP="IV" D:$G(STRTCHG) IVSTART^PSJ078B D:$G(STOPCHG) IVSTOP^PSJ078B
 ... S END=END+1
 ... I '(END#500) D CLEANMSG(BEG,END) K PSG S PCNT=2,BEG=END+1
 D CLEANMSG(BEG,END) Q
 ;
CLEANMSG(BEG,END)         ;
 K XMY S XMDUZ="MEDICATIONS,INPATIENT"
 S XMSUB="PSJ*5*78 INPATIENT MEDS STOP DATE ORDER ("_BEG_"-"_END_") CLEANUP COMPLETED"
 S XMTEXT="PSG(",XMY(DUZ)="" D NOW^%DTC S Y=% X ^DD("DD")
 S PSG(1,0)="  The cleanup of Inpatient Medication orders ("_BEG_"-"_END_") with invalid dates ",PSG(2,0)="completed as of "_Y_"."
 D ^XMD
 Q
