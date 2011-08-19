RANMUTL1 ;HISC/SWM-Nuclear Medicine utilites ;8/6/97  08:48
 ;;5.0;Radiology/Nuclear Medicine;**65**;Mar 16, 1998;Build 8
 ;
 ;Supported IA #10103 reference to FMTE^XLFDT
 ;
SELIMG ; Select Imaging Type, if exists; code is from RAUTL7
 ; Prompts user to select Imaging Type(s).
 ; Creates ^TMP($J,"RA I-TYPE",Imaging Type name,Imaging Type IEN)=""
 N RA,RAIMGNUM,RAONE S RA="",RAONE=$$IMG1^RAUTL7()
 ; .... chk if only 1 img type is available
 I $P(RAONE,"^")]"",('$D(^TMP($J,"RA D-TYPE"))) S RAQUIT=0 D  Q
 . S ^TMP($J,"RA I-TYPE",$P(RAONE,"^"),$P(RAONE,"^",2))=""
 . Q
 ; .... chk if only 1 img type within selectable division is available
 ; raimgnum = number of selectable img types
 I $D(^TMP($J,"RA D-TYPE")) D
 . D SETUP1 S RAIMGNUM=$$IMGNUM^RAUTL7A()
 . Q
 I $D(^TMP($J,"RA D-TYPE")),(RAIMGNUM=1) D  S RAQUIT=0 Q
 . N RA0,RA1
 . S RA1=+$O(^TMP($J,"DIV-IMG",0)),RA0=$P($G(^RA(79.2,RA1,0)),"^")
 . S ^TMP($J,"RA I-TYPE",RA0,RA1)=""
 . Q
 S RADIC="^RA(79.2,",RADIC(0)="QEAMZ",RAUTIL="RA I-TYPE"
 S RADIC("A")="Select Imaging Type: ",RADIC("B")="All"
 I $D(^TMP($J,"RA D-TYPE")) D
 . S RADIC("S")="I $D(^TMP($J,""DIV-IMG"",+Y)),($D(RACCESS(DUZ,""IMG"",+Y)))"
 . Q
 ; why do we need to check the alternative ?  DIVLOC+3 prevents this
 ; alternative from occurring.
 E  S RADIC("S")="I $D(RACCESS(DUZ,""IMG"",+Y))"
 W !! D EN1^RASELCT(.RADIC,RAUTIL) K %W,%Y1,DIC,RADIC,RAUTIL,X,Y
 Q
SELRADIO ; Setup ^TMP($J,"RA EITHER",ien file 50)
 S RAINPUT=""
 K DIR,X,Y S DIR(0)="YA",DIR("B")="Yes"
 S DIR("A")="Do you wish to include all Radiopharms ? "
 S DIR("?",1)="Enter 'Yes' to select all Radiopharms."
 S DIR("?")="Enter 'No' to select a subset of Radiopharms."
 W ! D ^DIR K DIR Q:$D(DIRUT)
 S RAINPUT=+Y K DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q:RAINPUT
 S RADIC="^PSDRUG(",RADIC(0)="QEAMZ"
 S RADIC("A")="Select Radiopharm: "
 W !! D EN2^RAPSAPI(.RADIC,"RA EITHER") K %W,%Y1,DIC,RADIC,RAUTIL,X,Y
 Q
SELADMIN ; Setup ^TMP($J,"RA EITHER",ien file 50)
 S RAINPUT=""
 K DIR,X,Y S DIR(0)="YA",DIR("B")="Yes"
 S DIR("A")="Do you wish to include all who administered dose ? "
 S DIR("?",1)="Enter 'Yes' to select all who administered dose."
 S DIR("?")="Enter 'No' to select some who administered dose."
 W ! D ^DIR K DIR Q:$D(DIRUT)
 S RAINPUT=+Y K DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q:RAINPUT
 S RADIC="^VA(200,",RADIC(0)="QEAMZ",RAUTIL="RA EITHER"
 S RADIC("A")="Select Person Who Admin Dose: "
 ; passed parameters to circumvent person's inactive date
 ; only the 4th param, 0, is really used to choose staff/resid/tech
 S RADIC("S")="I $$VALADM^RADD1(1,+Y,1,0)" ;
 W !! D EN1^RASELCT(.RADIC,RAUTIL) K %W,%Y1,DIC,RADIC,RAUTIL,X,Y
 Q
SELDATES ; Define RADTBEG and RADTEND
 S RAPOP=0 W !!,"**** Date Range Selection ****"
 W ! S %DT="APEXT"
 S %DT("A")="   Beginning DATE : "
 S %DT("B")="T-1"
 D ^%DT S:Y<0 RAPOP=1 Q:Y<0  S (%DT(0),RADTBEG)=Y
 W ! S %DT="APEXT"
 S %DT("A")="   Ending    DATE : "
 S %DT("B")="T-1@24:00"
 D ^%DT K %DT S:Y<0 RAPOP=1 Q:Y<0  S RADTEND=Y
 S RADTBEG("X")=$$FMTE^XLFDT(RADTBEG,1) ; for display in header
 S RADTEND("X")=$$FMTE^XLFDT(RADTEND,1)
 S:$P(RADTEND,".",2)="" RADTEND=RADTEND_".9999"
 Q
SELSORT ; select sort order
 W ! S RAPOP=0,RASORT=0
 S DIR("A")="Sort Exam Date/Time before "_$S(RATITLE["Usage":"Radiopharm",1:"Who Admin Dose")_" ? : "
 S DIR(0)="YAO",DIR("B")="NO" D ^DIR
 I $D(DIRUT)!($D(DUOUT)) S RAPOP=1 Q
 S RASORT=Y ; 1=YES, 0=NO
 Q
SETUP1 ; Setup ^TMP($J,"DIV-IMG",Imaging Type IEN)=""
 ; based upon ^TMP($J,"RA D-TYPE",Division name)
 ;  RACCESS "DIV-IMG"
 ; elements. 
 N RAX,RAY,RAZ S RAX=""
 F  S RAX=$O(^TMP($J,"RA D-TYPE",RAX)) Q:RAX']""  D
 . I $D(RACCESS(DUZ,"DIV-IMG",RAX)) D
 .. S RAY="" F  S RAY=$O(RACCESS(DUZ,"DIV-IMG",RAX,RAY)) Q:RAY']""  D
 ... Q:$P($G(^RA(79.2,+$O(^RA(79.2,"B",RAY,0)),0)),U,5)'="Y"  ;file 79.2's RADIOPHARM..USED
 ... S RAZ=+$O(^RA(79.2,"B",RAY,0)),^TMP($J,"DIV-IMG",RAZ)=""
 ... Q
 .. Q
 . Q
 Q
