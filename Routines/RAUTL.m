RAUTL ;HISC/CAH,FPT,GJC AISC/MJK,RMO-Utility Routine ;12/4/97  14:21
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ;
 ;Date range selection.  Time is allowed if RASKTIME is defined
 ;Past date assumed. BEGDATE and ENDDATE are output variables
DATE S RAPOP=0 K BEGDATE,ENDDATE W !!,"**** Date Range Selection ****"
 W ! S %DT="APEX"_$S($D(RASKTIME):"T",1:""),%DT("A")="   Beginning DATE : ",%DT(0)=$S($D(RADDT):"0000101",1:"-NOW") D ^%DT S:Y<0 RAPOP=1 Q:Y<0  S (%DT(0),BEGDATE)=Y
END W ! S %DT="APEX"_$S($D(RASKTIME):"T",1:""),%DT("A")="   Ending    DATE : " D ^%DT K %DT S:Y<0 RAPOP=1 Q:Y<0  S ENDDATE=Y
 Q
DATE1 S RAPOP=0 K BEGDATE,ENDDATE W !!,"**** Date Range Selection ****"
 W ! S %DT="AEX"_$S($D(RASKTIME):"T",1:""),%DT("A")="   Beginning DATE : ",%DT(0)=$S($D(RADDT):"0000101",1:"-NOW") D ^%DT S:Y<0 RAPOP=1 Q:Y<0  S (%DT(0),BEGDATE)=Y
END1 W ! S %DT="AEX"_$S($D(RASKTIME):"T",1:""),%DT("A")="   Ending    DATE : " D ^%DT K %DT S:Y<0 RAPOP=1 Q:Y<0  S ENDDATE=Y
 Q
 ;
 ;Generic device/queuing selector
 ;RAPOP will be >0 if the job was queued, or if device selection failed
 ; $D(RADUPSCN)&$D(RADFLTP) stems from the 'Duplicate Flash Card' option.
ZIS I '$D(ZTDESC) S ZTDESC="Rad/Nuc Med "_$S($D(ZTRTN):ZTRTN,1:"UNKNOWN OPTION")
 S RAMES=$S($D(RAMES):RAMES,1:"W !?5,*7,""Request Queued.""")
 W ! I $D(RASELDEV) W RASELDEV,! K RASELDEV
 S %ZIS="QMP" K:$G(IOP)="Q" %ZIS S:$D(RADUPSCN)&$D(RADFLTP) %ZIS("B")=RADFLTP D ^%ZIS S RAPOP=POP Q:RAPOP  I $D(RAZIS),$E(IOST)'="P" D ^%ZISC S IOP="Q" W *7,!?5,"You must select a printer for this output.",! G ZIS
 G ZIS1:'$D(IO("Q"))
 K IO("Q") S ZTIO=$S($D(ION):ION,1:"") I ZTIO]"" S ZTIO=ZTIO_$S($D(IO("DOC")):";"_IOST_";"_IO("DOC"),1:";"_IOST_";"_IOM_";"_IOSL)
 D ^%ZTLOAD
 I +$G(ZTSK("D"))>0 X:$D(ZTSK) RAMES W:$D(ZTSK) "  Task #: "_$G(ZTSK)
 K RAMES,ZTDESC,ZTSK,ZTIO,ZTSAVE,ZTRTN,RASV,ZTDTH D HOME^%ZIS S RAPOP=1 Q
ZIS1 K RAMES,RASELDEV,ZTDESC,ZTRTN,ZTSAVE Q
 ;
CLOSE I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC Q
 ;
D S Y=$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",$E(Y,4,5))_" "_$S(Y#100:$J(Y#100\1,2)_",",1:"")_(Y\10000+1700)_$S(Y#1:"  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12),1:"") Q
 ;
 ;called to do some user checks
 ;if div param set to ask user instead of auto filing DUZ, prompt for
 ;   access/verify code
 ;if RAKEY is defined, check if user owns this key and set RAPOP=1
 ;   if user doesn't own key
USER S RADUZ=DUZ S:'$D(RAMDV) RAMDV="" I '$P(RAMDV,"^",6) S %="A",%DUZ=DUZ W ! D ^XUVERIFY G USERQ:%=-1 I %'=1 W *7," ??" G USER
USER1 Q:'$D(RAKEY)  Q:$D(^XUSEC(RAKEY,RADUZ))  W !!?3,*7,"Must be a user with the appropriate privileges to continue!"
USERQ S RAPOP=1 Q
 ;
DEV ;EXECUTEABLE HELP FOR DEVICE FIELDS IN FILE 79.1 (IMAGING LOCATIONS)
 D HOME^%ZIS W @IOF,!,"The following is a list of possible devices. You must choose",!,"one of these by entering in the device's full name.",!!,"NOTE: This field is not a pointer field to file 3.5!",!
 W !?3,"Device Name:",?25,"Device Location:",!?3,"------------",?25,"----------------"
 F I=0:0 S I=$O(^%ZIS(1,I)) Q:I'>0  I $D(^(I,0)) W !?3,$P(^(0),"^"),?25,$S($D(^(1)):^(1),1:"") I ($Y+4)>IOSL R !,"(Type ""^"" to stop)",X:DTIME Q:'$T!(X="^")  W @IOF
 Q
 ;
VERIFY ;Ask Access Code
 K RADUZ S %="A",%DUZ=DUZ W ! D ^XUVERIFY S RADUZ=DUZ Q:%=-1!(%=1)  W:%=2 *7,!,"Sorry, that's not your access code.  Try again." W:%=0 !,"Enter your access code or an uparrow to exit." G VERIFY
 ;
A ;Create signature block name using RASIG("PER") as input IEN of file 200
 ;Write signature to node 20 of file 200
 ;(Signature is name in Firstname Lastname format)
 S %X=$P(^VA(200,RASIG("PER"),0),"^"),%X=$P(%X,",",2)_" "_$P(%X,",")_$P(%X,",",3),$P(^VA(200,RASIG("PER"),20),"^",2)=%X K %X Q
 ;
DUZ ;Lookup and set RASIG("PER")=New Person File IFN, set signature block
 ;text in File 200 if necessary, set RASIG("NAME")=signature block text
 S %=1 I $D(DUZ)#2,+DUZ>0,$D(^VA(200,DUZ,0)) S RASIG("PER")=DUZ
 I '$D(RASIG("PER")) S %=0 W:'$D(%INT) !,*7,"YOU ARE NOT IN THE 'NEW PERSON' FILE. CONTACT YOUR IRM SERVICE",! K %INT Q
 I '$D(^VA(200,RASIG("PER"),20)) D A K %INT Q
 I $P(^VA(200,RASIG("PER"),20),"^",2)="" S %X=$P(^VA(200,RASIG("PER"),0),"^"),%X=$P(%X,",",2)_" "_$P(%X,",")_$P(%X,",",3),$P(^(20),"^",2)=%X K %X
 S RASIG("NAME")=$P(^VA(200,RASIG("PER"),20),"^",2) K %INT Q
 ;
SSN(PID,BID,DOD) ;returns full Pt.ID (VA("PID")), BID=1 returns VA("BID")
 ;DOD is defined to internal entry # of eligibility of desired Pt.ID
 N DFN
 I '$D(RADFN) Q "Unknown"
 S:'$D(BID) BID="" S:$D(DOD) VAPTYP=DOD
 S DFN=RADFN D PID^VADPT6 I VAERR K VAERR Q "Unknown"
 S RASSN=$S(BID:VA("BID"),1:VA("PID"))
 K VA("BID"),VA("PID"),VAERR,VAPTYP
 Q RASSN
WARNPRC ; send warning if user changes procedure within exam edit
 ; and the exam has either or both radiopharms and meds
 ; RAY (sub-rec 70.03) comes from rtns RAEDCN or RAEDPT (exam edit)
 ; RAPRIT (ien file 71) comes from rtn RASTED (status tracking)
 Q:'$D(RADFN)!('$D(RADTI))!('$D(RACNI))
 Q:$G(RAY)']""&('$D(RAPRIT))
 N RAMEDS,RADIO,RATAB,RATEXT
 S RAMEDS=0,RADIO=0
 I $G(RAY)]"",$P(RAY,U,2)=RAPRI Q  ;no change in procedure
 I $G(RAPRIT)]"",RAPRIT=RAPRI Q  ;no change in procedure
 S RADIO=$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),U,28) ;ptr fle #70.2
 S RADIO=+$O(^RADPTN(+RADIO,"NUC",0))
 S RAMEDS=+$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"RX",0))
 S RAWHICH=0 ;first assume neither radiopharm nor meds
 I 'RAMEDS,RADIO S RAWHICH=1 ;radiopharm only
 I RAMEDS,'RADIO S RAWHICH=2 ;meds only
 I RAMEDS,RADIO S RAWHICH=3 ;both radiopharm and meds
 G:'RAWHICH WARN0
 W !!?2,"**",?21,"Since you have changed the procedure,",?76,"**"
 S RATAB=$S(RAWHICH=1:26,RAWHICH=2:34,1:21)
 W !?2,"**",?RATAB,"the",$S(RAWHICH#2:" Radiopharmaceuticals",1:""),$S(RAWHICH=3:" and",1:""),$S(RAWHICH>1:" Meds",1:"")," for",?76,"**"
 S RATEXT=$S($G(RAY)]"":$P($G(^RAMIS(71,+$P(RAY,U,2),0)),U),1:$P($G(^RAMIS(71,+$G(RAPRIT),0)),U)),RATAB=80-$L(RATEXT)/2
 W !?2,"**",?RATAB,RATEXT,?76,"**"
 W !?2,"**",?30,"will now be deleted.",?76,"**",!,*7
 Q
WARN0 W !!?2,"**",?17,"You have changed the procedure, but there are",?76,"**"
 W !?2,"**",?14,"no data for Radiopharmaceuticals and Meds to delete.",?76,"**",*7,!
 Q
