SDACSCGP ;ALB/TET - Print Computer Generated Appt Types or Stop Codes ;3/18/92  14:26
 ;;5.3;Scheduling;**132,202**;Aug 13, 1993
 ;
 Q
 ;
EN ; -- print either CG stop codes or CG appt types
 ;               ('ag'     or      'acg' cross ref)
 ;
 ;  SDX=X-ref       ACG=Computer Generated not resolved
 ;                  AG =Computer Generated viits, all appointment types.
 ;
READ ;enter here to read
 Q:'$D(SDX)
 D ASK2^SDDIV G EXIT:Y<0
 ;
 S %H=+$H
 D YX^%DTC
 S %DT="AE"
 S %DT("A")="Enter Beginning Date: "
 S %DT("B")=Y
 F  D  Q:X="^"!(Y>0)
 .D ^%DT
 .I Y>DT&(X'="^") D  Q:X="^"!(Y>0)
 ..W !,"You have entered a future or invalid date, please enter a valid date.",!
 ..S Y=-1
 .S:$D(DTOUT) X="^"
 G:X="^" EXIT
 K %DT
 S SDBEG=Y
 D DD^%DT S FR=Y
 ;
 S Y=DT D DD^%DT
 S TO=Y
 S %DT="AE"
 S %DT("A")="Enter Ending Date ("_FR_" - "_TO_") "
 S %DT("B")=Y
 F  D  Q:X="^"!(Y>0)
 .D ^%DT
 .I Y<SDBEG&(X'="^") D  Q
 ..W !,"A date before the begin date is not allowed, please enter a valid date.",!
 ..S Y=-1
 .I Y>DT D  Q
 ..W !,"Future dates are not allowed, please enter a valid date.",!
 ..S Y=-1
 .I Y=-1&(X'="^") D  Q
 ..W !,"You have entered an invalid date, please enter a valid date."
 .S:$D(DTOUT) X="^"
 G:X="^" EXIT
 S SDBEG=SDBEG-.0001
 S SDEND=Y_".9999"
 D DD^%DT S TO=Y
 ;
STOP ; -- one,many,all selection of stop codes
 S VAUTNI=2
 S VAUTSTR="clinic stop code"
 S VAUTVB="SDC"
 S DIC=40.7
 D FIRST^VAUTOMA
 G EXIT:Y<0
 ;
 S DGVAR="SDC#^SDBEG^SDEND^SDX^VAUTD#^TO^FR"
 S DGPGM="QUE^SDACSCGP"
 D ZIS^DGUTQ
 G:POP EXIT
 ;
QUE ; -- entry point
 N SDOE,SDOE0,SDOECG,DFN,SDDIV,SDT,SDSTOP,SDAPTYPR
 S DASH="",$P(DASH,"-",79)=""
 ;
 I '$O(^SCE(SDX,0)) W !!?5,"There are no 'Computer Generated' ",$S(SDX="AG":"Stop Codes.",1:"Appointment Types which need updating.") G EXIT
 ;
 S SDT=SDBEG
 F  S SDT=$O(^SCE(SDX,SDT)) Q:'SDT!(SDT>SDEND)  D
 . S SDOE=0
 . F  S SDOE=$O(^SCE(SDX,SDT,SDOE)) Q:'SDOE  D
 . . S SDOE0=$G(^SCE(SDOE,0))
 . . S SDOECG=$G(^SCE(SDOE,"CG"))
 . . S SDDIV=+$P(SDOE0,U,11)
 . . S DFN=+$P(SDOE0,U,2) D DEM^VADPT
 . . I VAUTD!($D(VAUTD(SDDIV))) D
 . . . S SDSTOP=$P(SDOE0,U,3)
 . . . S SDAPTYPR=+$P(SDOECG,U,2)
 . . . I SDC!($D(SDC(SDSTOP))) D SORT
 ;
PRINT ; -- loop thru division and stop code
 S (PG,SDDIV)=0
 F  S SDDIV=$O(^TMP($J,SDDIV)) G:'SDDIV EXIT D:PG CR G:$D(DIRUT) EXIT D  G:$D(DTOUT)!($D(DUOUT)) EXIT
 . D DIV,HDR
 . S SDSTOP=0
 . F  S SDSTOP=$O(^TMP($J,SDDIV,SDSTOP)) Q:'SDSTOP  D SCHDR S CT=0 D P1 Q:$D(DTOUT)!($D(DUOUT))  D SCFTR Q:$D(DTOUT)!($D(DUOUT))
 ;
 ; -- loop thru tmp global - do write
P1 S SDNAM=0
 F  S SDNAM=$O(^TMP($J,SDDIV,SDSTOP,SDNAM)) Q:SDNAM']""  D
 . S SDSSN=""
 . F  S SDSSN=$O(^TMP($J,SDDIV,SDSTOP,SDNAM,SDSSN)) Q:SDSSN']""  D:$Y+6>IOSL CR,HDR Q:$D(DTOUT)!($D(DUOUT))  D DAT
 Q
 ;
EXIT K CT,D,DA,DASH,DE,DFN,DGPGM,DGVAR,DIC,DIE,DIRUT,DQ,DR,DTOUT,DUOUT,I,L,POP,SDA,SDAPTYP,SDBEG,SDC,SDCSNODE,SDDAT,SDEND,SDI,SDJ,SDNAM,SDSSN,SDUPDT,SDX,SDY,SDZNODE,TYPE,VA,VADM,VAERR,VAUTD,Y
 K FR,PG,TO,SDCSN,SDDIV,SDDIVNAM,SDHDR,SDSTOP,SDSTNUM,SDSTNAM,SDSTZ,VAUTNI,VAUTSTR,VAUTVB,^TMP($J)
 D CLOSE^DGUTQ
 Q
 ;
DAT ; -- get and print data
 S SDDAT=0
 F  S SDDAT=$O(^TMP($J,SDDIV,SDSTOP,SDNAM,SDSSN,SDDAT)) Q:'SDDAT  D
 . N SDIEN
 . S SDIEN=0
 . F  S SDIEN=$O(^TMP($J,SDDIV,SDSTOP,SDNAM,SDSSN,SDDAT,SDIEN)) Q:'SDIEN  D
 . . S SDAPTYPR=$G(^TMP($J,SDDIV,SDSTOP,SDNAM,SDSSN,SDDAT,SDIEN))
 . . S Y=SDDAT X ^DD("DD")
 . . S CT=CT+1
 . . W !,$E(SDNAM,1,20),?25,SDSSN,?45,Y
 . . W:SDX="ACG" ?70,$S(SDAPTYPR=2:"C&P",SDAPTYPR=1:"ELIG",1:"")
 Q
 ;
SORT ; -- set tmp global to sort in alpha order by ssn & date, count sets
 S CT=0
 S SDNAM=$S('VAERR:VADM(1),1:"UNKNOWN")
 S SDSSN=$S('VAERR:VA("PID"),1:"UNKNOWN")
 S SDDIV=$S(+SDDIV:SDDIV,1:"UNKNOWN")
 S SDSTOP=$S(+SDSTOP:SDSTOP,1:"UNKNOWN")
 S ^TMP($J,SDDIV,SDSTOP,SDNAM,SDSSN,+SDOE0,SDOE)=SDAPTYPR
 S CT=CT+1
 Q
 ;
CR ; -- carriage return
 I $D(IOST),$E(IOST,1,2)="C-" S DIR(0)="E" W ! D ^DIR Q:$D(DTOUT)!($D(DUOUT))
 Q
 ;
DIV ; -- get division name for header
 S SDDIVNAM=$S($D(^DG(40.8,+SDDIV,0)):$P(^(0),"^"),1:"UNKNOWN")
 Q
 ;
HDR ; -- page header
 S PG=PG+1
 S SDHDR=$S(SDX="ACG":"APPOINTMENT TYPE",1:"STOP CODES")
 W:$D(IOF) @IOF W !,?IOM-(11+$L(SDDIVNAM))/2,"DIVISION:  ",SDDIVNAM,!,"COMPUTER GENERATED "_SDHDR,?40,FR," TO ",TO,?70,"PAGE  ",PG,!,"PATIENT",?25,"PATIENT ID",?45,"VISIT DATE/TIME"
 W:SDX="ACG" ?70,"REASON"
 W !,DASH,!!
 Q
 ;
SCHDR ; -- stop code header
 S SDSTZ=$S($D(^DIC(40.7,+SDSTOP,0)):^(0),1:"")
 S SDSTNAM=$S(SDSTZ]"":$P(SDSTZ,"^"),1:"UNKNOWN")
 S SDSTNUM=$S(SDSTZ]"":$P(SDSTZ,"^",2),1:"000")
 W !?3,"STOP CODE:  ",SDSTNAM
 Q
 ;
SCFTR ; -- footer
 D:$Y+6>IOSL CR,HDR
 Q:$D(DTOUT)!($D(DUOUT))
 W !!,CT," Computer Generated ",$S(SDX="ACG":"Appointment Types ",1:"Stop Codes "),"for Stop Code, ",SDSTNUM,", ",SDSTNAM,!
 Q
 ;
AG ; -- test ag
 N SDX
 S SDX="AG"
 D EN
 Q
 ;
ACG ; -- test ag
 N SDX
 S SDX="ACG"
 D EN
 Q
 ;
