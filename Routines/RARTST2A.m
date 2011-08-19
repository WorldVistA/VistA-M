RARTST2A ;HISC/CAH,FPT,GJC AISC/MJK,RMO-Reports Distribution ;11/24/97  12:12
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ;
DIV ; Division selection
 ; save all Med Center Divisions (40.8) by pntr to file 4
 D LIST^DIC(40.8,"",.07,"I","*","","","","","","RA408")
 Q:'$D(RA408("DILIST","ID"))  ; quit if no data
 S RAI=0 F  S RAI=$O(RA408("DILIST","ID",RAI)) Q:RAI'>0  D
 . ; for all entries in 40.8, save off the Institution File Pointer data
 . ; (Inst. File Pntr data is subscript) set the local array equal to the
 . ; appropriate ien in 40.8 - Example: RA4('ien file 4')='ien file 40.8'
 . S:$G(RA408("DILIST","ID",RAI,.07))]"" RA4($G(RA408("DILIST","ID",RAI,.07)))=$G(RA408("DILIST",2,RAI))
 . S:$G(RA408("DILIST",2,RAI))]"" RAF408(RA408("DILIST",2,RAI))=""
 . Q
 K RAPRMPT S I1=$P($G(^RABTCH(74.3,RAB,0)),"^")
 I I1="CLINIC REPORTS"!(I1="WARD REPORTS")!(I1="REQUESTING PHYSICIAN") S RAPRMPT="  Requesting Division: "
 E  S RAPRMPT="  Exam Division: "
 K RADIV S (C,I1)=0 F I=0:0 S I=$O(^RA(79,I)) Q:'I  S C=C+1,I1=I Q:C>1
 I C=1,$D(RA4(I1)) S RADIV=I1 K C,I,I1 G IMAG
 I $D(RAMDIV),$D(RA4(+RAMDIV)) S DIC("B")=+RAMDIV
 W !!,"Division Selection:",!,"-------------------"
 S DIC(0)="AEMQZ",DIC="^DIC(4,",DIC("A")=RAPRMPT
 S DIC("S")="I $D(RA4(+Y))" ; only institutions linked to Med Center Divs
 D ^DIC K DIC("A"),DIC("B"),DIC("S"),RAPRMPT S RADIV=+Y
 K C,I,I1,RA408,RAI Q:RADIV'>0
 S I=0 F  S I=$O(RA4(I)) Q:I'>0  D
 . S I(0)=$G(RA4(I))
 . I I'=RADIV K RA4(I),RAF408(I(0))
 . Q
 K I
 ;
IMAG ;imaging type selection
 K RAIMAG I $D(RAOMA) D  Q:'$D(RAIMAG)
 . S RAIMAG=$$IMG^RARTST3()
 . ; allow the users to select all i-types regardless of division
 . ; if i-types have been selected, RAIMAG is set to one, else 0
 . K:'RAIMAG RAIMAG
 . Q
 E  D  Q:'$D(RAIMAG)
 . W !!,"Imaging Type Selection:",!,"-----------------------"
 . S DIR(0)="PA^79.2:AEMQ",DIR("A")="Select Imaging Type: "
 . S:$D(RAMLC) DIR("B")=$P($$IMAG^RASITE(+$P(RAMLC,U,6)),U,2)
 . D ^DIR K DIR Q:Y'>0!$D(DIRUT)  S RAIMAG(+Y)=""
 . Q
 I $D(^RABTCH(74.3,"B","REQUESTING PHYSICIAN",RAB))#2 D  G LOC
 . S RASRT(0)="Patient",RASRT="P"
 . Q
 ;
SORT W !!,"Sort Sequence Selection:",!,"------------------------"
 K RASRT S RARD(1)="Terminal Digits^sort reports by terminal digit of SSN",RARD(2)="SSN^sort reports by SSN",RARD(3)="Patient^sort reports by patient's name",RARD("A")="Select Sequence: ",RARD("B")=3
 D SET^RARD K RARD Q:"^"[X  S RASRT=$E(X),RASRT(0)=X
 ;
LOC I $G(RARTST1)=1 D  Q:"^"[RALOCSRT  ; *** [RA RPTDISTQUE] option only ***
 . W !!,"First Sort Selection:",!,"---------------------"
 . K DIR S DIR(0)="YO",DIR("B")="Yes"
 . S DIR("A")="  Sort by patient location before "_RASRT(0)
 . S DIR("?",1)="Enter YES to sort the report by patient location, then by "_RASRT(0)_"."
 . S DIR("?",2)="Enter NO to sort the report by "_RASRT(0)_", with no sort by location."
 . S DIR("?")="Choose either YES or NO."
 . D ^DIR K DIR S RALOCSRT=$S($D(DIRUT):U,1:Y)
 . Q
 E  S RALOCSRT=1
 ;
PRINT K RAPRT W !!,"Print/Reprint Reports Selection:",!,"--------------------------------"
 S RARD(1)="UNPRINTED^print verified reports that have not been printed",RARD(2)="REPRINT^reprint previously printed reports",RARD("B")=1 D SET^RARD K RARD Q:"^"[X
 S RAPRT=X Q:$E(RAPRT)="U"
 ;
DATE K RABEG,RAEND W !!,"Date Range Selection:",!,"---------------------"
 S %DT("B")="T@1201AM",%DT="APRETX",%DT("A")="  Beginning DATE/TIME of Initial Print : " D ^%DT I Y<0 K RAPRT Q
 S (%DT(0),RABEG)=Y
 W ! S %DT("B")="NOW",%DT="APRETX",%DT("A")="  Ending    DATE/TIME of Initial Print : " D ^%DT K %DT I Y<0 K RAPRT Q
 W ! S RAEND=Y Q
RPTST(RARPT) ; Report's Print Status, called from 8^RARTST1.
 ; This code replaces the call to the compiled template routine.
 ; Input: RARPT -> ien of the Report in file 74
 N I,RA74,RAEXFLD,RAY3,X,Y W !,$$REPEAT^XLFSTR("-",IOM),!!
 S RA74(0)=$G(^RARPT(RARPT,0)) W "Report   : ",$P(RA74(0),"^")
 S (X,Y)=+$P(RA74(0),"^",2),Y=$S($D(^DPT(Y,0))#2:$P(^(0),"^"),1:"")
 W ?25,"Patient: ",$E(Y,1,30) W:X ?65,$$SSN^RAUTL(X)
 S Y=+$O(^RADPT(X,"DT",(9999999.9999-$P(RA74(0),"^",3)),"P","B",$P(RA74(0),"^",4),0))
 S RAY3=$G(^RADPT(X,"DT",(9999999.9999-$P(RA74(0),"^",3)),"P",Y,0))
 S RAEXFLD="PROC" D ^RARTFLDS W !,"Procedure: ",$E(X,1,30)
 W ?45,"Verified: ",$$FMTE^XLFDT($P(RA74(0),"^",7),"1P")
 W !!?4,"Routing Queue",?24,"Date Printed",?44,"Printed By",?62,"Ward/Clinic"
 W !?4,"-------------",?24,"------------",?44,"----------",?62,"-----------"
 S I=0 F  S I=$O(^RABTCH(74.4,"B",RARPT,I)) Q:I'>0  D
 . S X=$G(^RABTCH(74.4,I,0)),Y=+$P(X,"^",11)
 . S Y=$S($D(^RABTCH(74.3,Y,0))#2:$P(^(0),"^"),1:"")
 . W !,$E(Y,1,20),?24,$E($$FMTE^XLFDT($P(X,"^",4),1),1,18)
 . S Y=+$P(X,"^",3),Y=$S($D(^VA(200,Y,0))#2:$P(^(0),"^"),1:"")
 . W ?44,$E(Y,1,17),?62
 . W:+$P(X,"^",6) $E($$GET1^DIQ(42,+$P(X,"^",6),.01),1,18)
 . W:+$P(X,"^",8) $E($$GET1^DIQ(44,+$P(X,"^",6),.01),1,18)
 . Q
 W !!,$$REPEAT^XLFSTR("=",IOM),!
 Q
