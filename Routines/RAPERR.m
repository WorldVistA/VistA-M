RAPERR ;HISC/CAH-Print Rad/NM Procedures with missing/invalid CPT/Stop codes ;8/30/96  11:00
 ;;5.0;Radiology/Nuclear Medicine;**10**;Mar 16, 1998
START W !!!,"This option prints a list of Radiology/Nuclear Medicine Procedures"
 W !,"with missing or invalid CPT's and DSS ID's, and Imaging Locations"
 W !,"pointing to Hospital Locations with inappropriate set-up parameters."
 W !,"Broad, parent and inactive procedures are not required to have codes."
 W !,"To be valid, DSS ID's must be in the Imaging Stop Codes file 71.5;"
 W !,"CPT's must be nationally active.",!!
 K DIR S DIR(0)="Y",DIR("A")="Include Inactive procedures",DIR("B")="NO" D ^DIR I $D(DTOUT)!($D(DUOUT)) D KILL Q
 S RALL=0 I Y=1 S RALL=1
 K ^TMP($J,"RA I-TYPE") S RAXX=$$IMG^RAUTL12()
 I 'RAXX D KILL Q
 S RADT=$S($D(DT)#2:DT,1:$$DT^XLFDT())
 S ZTRTN="EN1^RAPERR",ZTDESC="Rad/Nuc Med Invalid CPT/Stop Report"
 D ZTSAVE,ZIS^RAUTL K ZTRTN,ZTDESC I RAPOP D KILL Q
EN1 ; Start processing
 U IO K ^TMP($J,"RAP")
 S:$D(ZTQUEUED) ZTREQ="@"
 D FIND,PRT,TOTAL,KILL
 Q
FIND S (RAPROC,RAPROCN,RAICTR,RABCTR,RANOCTR,RAISTP,RANOSTP,RAPAGE)=0,U="^"
 S (RANOAMIS,RANODESC)=0
 F  S RAPROCN=$O(^RAMIS(71,"B",RAPROCN)) Q:'$L(RAPROCN)  S RAPROC=0 F  S RAPROC=$O(^RAMIS(71,"B",RAPROCN,RAPROC)) Q:(RAPROC'?1N.N)!($D(RAOUT))  D
 . S RA71(0)=$G(^RAMIS(71,RAPROC,0))
 . S RA71(12)=+$P(RA71(0),"^",12)
 . S RAITYPE=$P($G(^RA(79.2,RA71(12),0)),"^")
 . S:RAITYPE="" RAITYPE="UNKNOWN"
 . Q:'$D(^TMP($J,"RA I-TYPE",RAITYPE,RA71(12)))#2  ; not user selected
 . S RAINA=$G(^RAMIS(71,RAPROC,"I"))
 . I 'RALL,(RAINA),(RAINA'>RADT) Q
 . K RAMSG S RAX=$G(^RAMIS(71,RAPROC,0)) I '$L(RAX) Q
 . I $P(RAX,U,6)="P",('+$O(^RAMIS(71,RAPROC,4,0))) D
 .. S RANODESC=RANODESC+1
 .. S RAMSG(99)="NO descendents entered"
 .. Q
 . I $P(RAX,U,6)]"",("DS"[$P(RAX,U,6)),('+$O(^RAMIS(71,RAPROC,2,0))) D
 .. S RANOAMIS=RANOAMIS+1
 .. S RAMSG(999)="NO AMIS Code(s) entered"
 .. Q
 . S RACPT=$P(RAX,U,9) I 'RACPT,"BP"'[$P(RAX,U,6) S RAMSG(1)="No CPT entered." S RANOCTR=RANOCTR+1
 . I RACPT S X1=$$NAMCODE^RACPTMSC(RACPT,DT) I $P(X1,"^",2)="" S RAMSG(2)="Broken CPT pointer." S RABCTR=RABCTR+1
 . I RACPT,'$$ACTCODE^RACPTMSC(RACPT,DT) S RAMSG(3)="Invalid CPT "_$P(X1,U) S RAICTR=RAICTR+1
 . S RACTR=0 I $O(^RAMIS(71,RAPROC,"STOP",0)),('$$PCE^RAWORK()) D
 .. S RASTP=0 F  S RASTP=$O(^RAMIS(71,RAPROC,"STOP",RASTP)) Q:'RASTP  S X=$G(^RAMIS(71,RAPROC,"STOP",RASTP,0)) I X S RACTR=RACTR+1 D CK700 I '$D(^RAMIS(71.5,"B",+X))!($P(^DIC(40.7,+X,0),U,3)) D BADSTOP
 . I 'RACTR,"BP"'[$P(RAX,U,6),('$$PCE^RAWORK()) S RAMSG(5)="No stop code(s) entered.",RANOSTP=RANOSTP+1
 . I $D(RAMSG) S RAINACT="" S X1=$G(^RAMIS(71,RAPROC,"I")) I X1 S RAMSG("INACT")="*Procedure inactivated on "_$$FMTE^XLFDT(X1,"D")_$S(X1>RADT:" (future inactivation)",1:"")_"*"
 . I $D(RAMSG) D RATYPE S ^TMP($J,"RAP",RAPROCN,RAPROC)=RAMSG("TYPE")_U_$G(RAMSG("INACT")) S X=0 F  S X=$O(RAMSG(X)) Q:'X  S ^TMP($J,"RAP",RAPROCN,RAPROC,X)=RAMSG(X)
 Q
BADSTOP S:'$D(RAMSG(4)) RAMSG(4)="Invalid Stop Code(s): "
 S RAMSG(4)=RAMSG(4)_" "_$P($G(^DIC(40.7,X,0)),U)
 I $P($G(^DIC(40.7,+X,0)),U,3) S RAMSG(4)=RAMSG(4)_" (Inactive)"
 S RAISTP=RAISTP+1
 Q
CK700 ;Check for a 700-level stop code without any other stop code
 I $P($G(^DIC(40.7,+X,0)),U,2)?1"7"2N,$P(^RAMIS(71,RAPROC,"STOP",0),U,4)'>1 S RAMSG(7)="700-series noncredit Stop Code used without any credit Stop Code"
 Q
PRT D HDG
 S (RAPROCN,RAPROC)=0 F  S RAPROCN=$O(^TMP($J,"RAP",RAPROCN)) Q:RAPROCN=""!($D(RAOUT))  S RAPROC=0 F  S RAPROC=$O(^TMP($J,"RAP",RAPROCN,RAPROC)) Q:'RAPROC!($D(RAOUT))  S RAP=^(RAPROC) D
 . W !!,RAPROCN_" "_$P(RAP,U,2) I $L($P(RAP,U,3)) W !?5,$P(RAP,U,3)
 . S RAI=0 F  S RAI=$O(^TMP($J,"RAP",RAPROCN,RAPROC,RAI)) Q:'RAI!($D(RAOUT))  D
 .. W !?5,$G(^TMP($J,"RAP",RAPROCN,RAPROC,RAI))
 .. I $Y>(IOSL-6) D HDG
 . I $D(RAOUT) Q
 Q
HDG I $E(IOST,1,2)="C-",RAPAGE>0 K DIR S DIR(0)="E" W ! D ^DIR I $D(DUOUT)!($D(DTOUT)) S RAOUT=1 Q
 I (RAPAGE>0)!($E(IOST,1,2)="C-") W @IOF
 S RAPAGE=RAPAGE+1
 W ?16,"RADIOLOGY/NUCLEAR MEDICINE INVALID CPT AND STOP CODES"
 W !,"Run Date: ",$$HTE^XLFDT($H),?70,"Page: ",RAPAGE
 I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAOUT=1
 Q
LINE W !
 Q
RATYPE S X2=$P(RAX,U,6),X2=$S(X2="D":"Detailed,",X2="B":"Broad,",X2="S":"Series,",X2="P":"Parent,",1:"Type missing,") S RAMSG("TYPE")=$P(RAX,U,6)_U_"("_X2
 S X2=+$P(RAX,U,12),X2=$G(^RA(79.2,X2,0)),X2=$P(X2,U,3),RAMSG("TYPE")=RAMSG("TYPE")_" "_$S(X2]"":X2,1:"Imaging type missing")_")"
 Q
TOTAL I $D(RAOUT) Q
 I $Y>(IOSL-17) D HDG Q:$D(RAOUT)
 N A,B S A="Imaging Type(s): ",B="" W !!,A
 F  S B=$O(^TMP($J,"RA I-TYPE",B)) Q:B']""  D  Q:$D(RAOUT)
 . I $Y>(IOSL-4) D HDG Q:$D(RAOUT)  W !!,A
 . W:$X>(IOM-($L(B))) !?($X+$L(A)) W B,?($X+3)
 . Q
 W !!,"TOTAL INVALID CPT CODES:  ",RAICTR
 W !,"TOTAL MISSING CPT CODES:  ",RANOCTR
 W !,"TOTAL BROKEN POINTERS TO CPT CODES:  ",RABCTR
 I '$$PCE^RAWORK() W !,"TOTAL INVALID STOP CODES:  ",RAISTP,!,"TOTAL MISSING STOP CODES:  ",RANOSTP
 W !,"TOTAL PARENT PROCEDURES W/O DESCENDENTS:  ",RANODESC
 W !,"TOTAL SERIES AND/OR DETAILED PROCEDURES W/O AMIS CODES:  ",RANOAMIS
 W !!,"Note:  Remember to review the entries in the Imaging Stop Codes file #71.5",!,"every year in October to make sure they agree with VA HQ rules.  If the entries",!,"in file 71.5 are not accurate, this report will not be accurate.",!
 I $$PCE^RAWORK() D ISTOP^RAPERR1
 Q
KILL ; Kill and quit
 D ^%ZISC K ^TMP($J,"RAP"),^TMP($J,"RA I-TYPE")
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,POP,RA71,RABCTR,RACPT,RACTR,RADT,RAI
 K RAICTR,RAINA,RAINACT,RAISTP,RAITYPE,RALL,RAMES,RAMSG,RANOAMIS,RANOCTR
 K RANODESC,RANOSTP,RAOUT,RAP,RAPAGE,RAPOP,RAPROC,RAPROCN,RASTP,RATYPE
 K RAX,RAXX,X,X1,X2,Y,ZTDESC,ZTRTN,ZTSAVE
 K DISYS,I,RA44,RA791,RAILOC
 Q
ZTSAVE ; Save off variable for the queued process.
 N I F I="RADT","RALL","^TMP($J,""RA I-TYPE""," S ZTSAVE(I)=""
 Q
