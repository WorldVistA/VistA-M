RAERRPT ;HIRMFO/GJC-Access erroneous Rad/Nuc Med reports ;10/23/97  12:39
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
EN1 ; Beginning entry point
 K ^TMP($J,"RAEX") D SETVARS^RART1
 I $G(RAIMGTY)="" K XQUIT D KILL Q  ; no sign-on imaging loc specified
 S DIC(0)="QEAMZ",DIC("A")="Select Patient: " D ^RADPA G:Y<0 KILL
 S RADFN=+Y,RAPAT=Y(0,0),RAHEAD="**** Patient's Exams ****"
 D ^RAPTLU G:+X'>0 KILL ; user did not select an exam
 S RA74=$P(^TMP($J,"RAEX",X),"^",10) ; ien for file 74
 S ZTDESC="Rad/Nuc Med Erroneous Reports",ZTRTN="START^RAERRPT"
 F I="RA74","RAPAT" S ZTSAVE(I)=""
 D ZIS^RAUTL
 I RAPOP D KILL Q
START ; Start processing data
 S:$D(ZTQUEUED) ZTREQ="@"
 U IO S (RAIEN,RAXIT)=0
 S RAHD="*** Uncorrected Reports for: "_RAPAT_" ***"
 S $P(RALINE,"-",(IOM+1))="",RAPG=0,RADT=$$FMTE^XLFDT(DT,"1D")
 S RAHD1="Run Date: "_RADT D HDH^RAERRPT G:RAXIT KILL
 F  S RAIEN=$O(^RARPT(RA74,"ERR",RAIEN)) Q:RAIEN'>0  D  Q:RAXIT
 . S RAERR(0)=$G(^RARPT(RA74,"ERR",RAIEN,0))
 . W !?3,"Date/Time Uncorrected Report retained: "
 . W $$FMTE^XLFDT($P(RAERR(0),"^"),"1P"),! S RAI=0
 . F  S RAI=$O(^RARPT(RA74,"ERR",RAIEN,"RPT",RAI)) Q:RAI'>0  D  Q:RAXIT
 .. S RAERRPT=$G(^RARPT(RA74,"ERR",RAIEN,"RPT",RAI,0))
 .. I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HDH^RAERRPT
 .. Q:RAXIT  W !,RAERRPT
 .. Q
 . Q
 W ! D ^%ZISC,KILL
 Q
HDH ; Header
 W:$Y @IOF S RAPG=RAPG+1 W !,$$CJ^XLFSTR(RAHD,IOM)
 W !,RAHD1,?$S(IOM=132:121,1:68),"Page: ",RAPG,!,RALINE
 I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAXIT=1
 Q
KILL ; Reset, Kill & quit
 D HOME^%ZIS
 K %W,%X,%XX,%Y,%YY,C,DIC,DIPGM,I,RA74,RACN,RACNI,RADATE,RADFN,RADT
 K RADTE,RADTI,RAERR,RAERRPT,RAHD,RAHD1,RAHEAD,RAI,RAIEN,RALINE,RANME
 K RAPAT,RAPG,RAPOP,RAPRC,RARPT,RASSN,RAST,RAXIT,X,Y,Z
 K POP,RAMES,ZTDESC,ZTRTN,ZTSAVE,DUOUT
 Q
