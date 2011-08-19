RAMAIN1 ;HISC/CAH,GJC-Radiology Utility File Maintenance ;10/29/97  13:30
 ;;5.0;Radiology/Nuclear Medicine;**15,21**;Mar 16, 1998
 ; This routine is a 'helper' routine for 'RAMAIN'.
DSPLNKS ; This subroutine display the links between the wasted/unwasted
 ; film size types.  This subroutine is called from '4^RAMAIN'.
 ; This subroutine is only accessed if the '^RA(78.4,"AW")' xref
 ; exists.
 N RA,RAFS,RAOUT,X,Y,Z S RAOUT=0
 S X=0 F  S X=$O(^RA(78.4,"AW",1,X)) Q:X'>0  D
 . S RA(0)=$G(^RA(78.4,+X,0)) Q:RA(0)']""
 . S RA(1)=$P(RA(0),U),RA(5)=+$P(RA(0),U,5)
 . S RA(11)=$P($G(^RA(78.4,RA(5),0)),U)
 . I RA(1)]"",(RA(11)]"") D
 .. S RAFS("LW",RA(1))=RA(11),RAFS("LU",RA(11))=RA(1)
 .. Q
 . E  D
 .. S:RA(11)']"" RAFS("UW",RA(1))=""
 .. Q
 . Q
 S X="" F  S X=$O(^RA(78.4,"B",X)) Q:X']""  D
 . I '$D(RAFS("LU",X))&('$D(RAFS("LW",X)))&('$D(RAFS("UW",X))) D
 .. S RAFS("UU",X)=""
 .. Q
 . Q
 I $D(RAFS("LU"))!($D(RAFS("UU")))!($D(RAFS("UW"))) D
 . N X,Y,Y1,Z
 . S X(1)="'Unwasted Film Size'",X(2)="'Corresponding Wasted Film Size'"
 . S X(0)="Relationship between "_X(1)_" and "_X(2)_":"
 . S $P(Y1,"-",($L(X(0))+1))="" D HDR(.X,Y1) ; Print out the list
 . F Z(0)="LU","UU","UW" D  Q:RAOUT
 .. S Z="" F  S Z=$O(RAFS(Z(0),Z)) Q:Z']""!(RAOUT)  D
 ... I Z(0)="LU" D
 .... W !?5,Z
 .... W ?40,$S($G(RAFS(Z(0),Z))]"":$G(RAFS(Z(0),Z)),1:"Error, missing data")
 .... Q
 ... I Z(0)="UU" D
 .... W !?5,Z
 .... W ?40,"unassociated with a 'Wasted Film' type"
 .... Q
 ... I Z(0)="UW" D
 .... W !?5,"*** Error, missing Data ***"
 .... W ?40,Z
 .... Q
 ... D:$Y>(IOSL-4) HDH
 ... Q
 .. Q
 . Q
 I $G(RAOUT)=0 D:($Y>5) HDH
 Q
HDH ; EOS prompt
 S DIR(0)="E" D ^DIR K DIR,DIRUT,DIROUT,DTOUT,DUOUT
 S:'+Y RAOUT=1 Q:RAOUT  D:$D(X)\10&($D(Y1)) HDR(.X,Y1)
 Q
HDR(X,Y1) ; Header
 W @IOF,!?(IOM-$L($G(X(0)))\2),$G(X(0)),!
 W !?5,$G(X(1)),?40,$G(X(2)),!?(IOM-$L(Y1)\2),Y1,!
 Q
1 ; Set-up/Edit the Examination Status file (72).
 N RADATE,RAHDR,RALINE,RANOERR,RAOUT,RAPG
 S RADATE=$$FMTE^XLFDT($$DT^XLFDT(),"")
 S RAHDR="Data Inconsistency Report For Exam Statuses"
 S RANOERR="Exam Status Data Inconsistencies Not Found."
 S $P(RALINE,"=",(IOM+1))="",(RAOUT,RAPG)=0
 N RAIMGTYI,RAIMGTYJ,RAORDXST S RAORDXST=0
 S DIC="^RA(79.2,",DIC(0)="QEAMNZ",DIC("A")="Select an Imaging Type: "
 D ^DIC K DIC G:+Y'>0 Q1
 ; RAIMGTYI=ien of 79.2, RAIMGTYJ=xternal format of the .01
 S RAOUT=0,RAIMGTYI=+Y,RAIMGTYJ=$P(Y,U,2)
 F  D  Q:RAOUT
 . K DINUM,DLAYGO,DO W !
 . S DIC="^RA(72,",DIC(0)="QEALZ",DLAYGO=72
 . S DIC("A")="Select an Examination Status: ",DIC("DR")="7////"_RAIMGTYI
 . S DIC("S")="I +$P(^(0),U,7)=RAIMGTYI"
 . S RADICW(1)="N RA S RA(0)=^(0),RA(3)=$P(RA(0),U,3) "
 . S RADICW(2)="W ?35,""Imaging Type: "",?49,RAIMGTYJ"
 . S RADICW(3)=",!?35,""Order: "",?42,RA(3)"
 . S DIC("W")=RADICW(1)_RADICW(2)_RADICW(3)
 . D ^DIC K DIC,DLAYGO,RADICW
 . I +Y'>0 S RAOUT=1 Q
 . W:$P(Y(0),U,3)=1 !!?5,"* Reminder * ",$P(Y,U,2)," does NOT need data entered for",!?7,"the 'ASK' and 'REQUIRED' fields.  Registration automatically",!?7,"sets cases to this status since its ORDER number is 1.",!
 . S (DA,RAXSTIEN)=+Y,DIE="^RA(72,",DR="[RA STATUS ENTRY]" D ^DIE
 . I $D(DA) S RAEDT72=$G(^RA(72,DA,0)) I $P(RAEDT72,"^",3)="",$$UP^XLFSTR($P(RAEDT72,"^",5))="Y" D
 .. W !!,"`"_$P(RAEDT72,"^")_"' is inactive, but appears on Status Tracking.",!,"This is appropriate if you need to use Status Tracking to process cases in"
 .. W !,"this status to complete.  However, if you have a large number of historic",!,"cases in this status, it will cause response time problems in Status Tracking."
 .. Q
 . K %,%X,%Y,C,D0,DA,DE,DI,DIE,DQ,DR,RAEDT72,RAEXST,X,Y
 . Q
 K %,DTOUT,DUOUT,RAOUT,RAXSTIEN,X,Y
 N RADASH S $P(RADASH,"_",10)="",RADASH=" "_RADASH_" "
 W @IOF
 D XAMORD
 S RAOUT=$$EOS^RAUTL5() Q:RAOUT
 D PRELIM^RAUTL19(RAIMGTYJ) ; check data consistency
Q1 K C,D,DDH,DUOUT,I,POP,RAXSTIEN
 Q
XAMORD ; check order number inconsistency for order # 0,1,9
 I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 W !!?$L(RADASH),"Checking order numbers",!,RADASH,"and Default Next Status used for status progression",RADASH,!?11,"within : ",RAIMGTYJ
 S:'$D(RAOUT)#2 RAOUT=0
 N I,J,RA0,RA2,RAORDXNM F I=0,1,9 D  Q:RAOUT
 . Q:($D(^RA(72,"AA",RAIMGTYJ,I))\10)
 . N RASTAT S RAORDXST=1
 . S RASTAT=$S(I=0:"Cancelled",I=1:"Waiting For Exam",1:"Complete")
 . I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 . W !!?5,"Error: A status with order number '"_I_"' to represent"
 . I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 . W !?5,"'"_RASTAT_"' is MISSING for this imaging type.",$C(7)
 . I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 ; check that the DEFAULT NEXT STATUS has an ORDER no.
 S I=0
 F  S I=$O(^RA(72,"AA",RAIMGTYJ,I)) Q:'I  S J=$O(^(I,0)) I +J S RA0=^RA(72,J,0) D  ;should always have subscript 5 ?
 . Q:$P(RA0,U,3)=9  ;skip check if COMPLETE status
 . S RA2=$G(^RA(72,+$P(RA0,U,2),0))
 . I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 . I RA2="" W !!?5,$P(RA0,U),"'s Default Next Status (",$P(RA2,U),")'s record is missing" S RAORDXST=1 I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 . I $P(RA2,U,3)="" W !!?5,$P(RA0,U),"'s Default Next Status (",$P(RA2,U),") is missing an ORDER no." S RAORDXST=1 I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 .Q
 W:'RAORDXST !!?5,"Required order numbers are in place."
 I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 W !
 ; check that exam status 'COMPLETE','WAITING FOR EXAM' and 
 ; 'CANCELLED' exist
 I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 W !!,RADASH_"Checking Exam Status names"_RADASH,!,?$L(RADASH),"within : ",RAIMGTYJ
 S RAORDXNM=0 F I=0,1,9 D  Q:RAOUT
 . S J=$O(^RA(72,"AA",RAIMGTYJ,I,""))
 . I I=0,($P(^RA(72,J,0),U)="CANCELLED") Q
 . I I=1,($P(^RA(72,J,0),U)="WAITING FOR EXAM") Q
 . I I=9,($P(^RA(72,J,0),U)="COMPLETE") Q
 . I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 . W !!?5,"Warning : The status with order number '"_I_"' was"
 . I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 . W !?5,"named '"_$S(I=0:"CANCELLED",I=1:"WAITING FOR EXAM",1:"COMPLETE")_"', but is now named '",$P(^RA(72,J,0),U),"'",$C(7)
 . S RAORDXNM=1
 Q:(RAOUT!RAORDXNM)
 I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 W !!?5,"Exam Status names check complete"
 Q
