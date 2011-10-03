RAPSET1 ;HISC/FPT,GJC AISC/MJK-Set Sign-on parameters ;5/22/97  14:22
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
DIS W !!,LINE,!,"Welcome, you are signed on with the following parameters:"
 W !!?35,"Printer Defaults",!?1,"Version  : ",$G(^DD(70,0,"VR")),?35,"----------------",!?1,"Division : ",$E($S($D(^DIC(4,+RAMDIV,0)):$P(^(0),"^"),1:"Unknown"),1,20)
 W ?35,"Flash Card  : " W:RAFLH $E($P(RAMLC,"^",3)_"  "_$S($D(^%ZIS(1,+RAFLH,1)):$P(^(1),"^"),1:""),1,30) W:'RAFLH "None"
 W !?1,"Location : ",$E($S('$D(^RA(79.1,+RAMLC,0)):"Unknown",$D(^SC(+^(0),0)):$P(^(0),"^"),1:"Unknown"),1,20),?49,$S($P(RAMLC,"^",2):$P(RAMLC,"^",2)_" card/visit",$P(RAMDV,"^",2):"1 card/exam",1:"No cards")
 W !?1,"Img. Type: ",$S($D(^RA(79.2,+$P(RAMLC,"^",6),0)):$E($P(^(0),"^"),1,20),1:"Unknown"),?35,"Jacket Label: " W:RAJAC $E($P(RAMLC,"^",5)_"  "_$S($D(^%ZIS(1,+RAJAC,1)):$P(^(1),"^"),1:""),1,30) W:'RAJAC "None"
 W !?1,"User     : ",$S($D(^VA(200,+DUZ,0)):$P(^(0),"^"),1:"Unknown"),?49,$S($P(RAMLC,"^",4):$P(RAMLC,"^",4)_" labels/visit",1:"")
 W ! I $P($G(^RA(79.1,+$P(RAMLC,"^"),0)),"^",19) W ?1,"** INACTIVE LOCATION **"
 W ?35,"Report      : " W:RARPT $E($P(RAMLC,"^",10)_"  "_$S($D(^%ZIS(1,+RARPT,1)):$P(^(1),"^"),1:""),1,30) W:'RARPT "None"
 I $P($G(^RA(79.2,+$P(RAMLC,"^",6),0)),"^",5)="Y" D
 . N RADOSE,RADSE
 . W !?35,"Dosage      : " W:$P(RALOC,"^",23)']"" "None"
 . I $P(RALOC,"^",23) D
 .. D GETS^DIQ(3.5,$P(RALOC,"^",23)_",",".01;.02","","RADOSE")
 .. S RADSE=RADOSE(3.5,$P(RALOC,"^",23)_",",.01)_"  "_RADOSE(3.5,$P(RALOC,"^",23)_",",.02)
 .. W $E(RADSE,1,30)
 . Q
 W !,LINE
 ;
Q ; Kill and quit
 I $D(RASWLOC),($D(XQUIT)),(XQUIT']"") K XQUIT ; RA LOC SWITCH option
 K %ZIS,RAI,DEV,DEVI,DIC,DIV,DUOUT,I,LINE,LOC,RADEV,RADIV,RAFLH
 K RAJAC,RALOC,RARPT,X,Y,POP,DISYS
 Q
 ;
SET K RALONE G ^RAPSET:'$D(RAMDIV)!('$D(RAMDV))!('$D(RAMLC))!('$D(RAIMGTY)) Q
 ;
KILL K RACCESS,RAMDIV,RAMDV,RAIMGTY,RAMLC
 Q
SETVARS(X) ; Set variables integral to package operation.
 ; This code is used in lieu of the Entry Actions for many of the
 ; Radiology/Nuclear Medicine options.
 ; Problems Resolved: '^' jump, independently invoking options
 ; 'X=0' ---> Silent, creates RACCESS array.
 ; 'X=1' ---> Interactive, calls ^RAPSET (prompts for sign-on location)
 D @$S(X=1:"^RAPSET",1:"VARACC^RAUTL6(DUZ)") K %,%W,%Y,%Y1,C,POP
 Q
SW(RAXAMI,RALOGI) ; During 'Case No. Exam Edit' the user picked an exam
 ; that has a different imaging type than the imaging type of our
 ; sign-on location.  This subroutine askes the user if they want to
 ; switch locations.  RAMASK set in CHECK^RACNLU (saves off 'Y'
 ; 0 node of exam)
 ; Input Variables: RAXAMI-> imaging type of the exam
 ;                  RALOGI-> sign-on location imaging type
 ;
 ; Output Variable: 1 if location switch invalid, 0 if valid switch.
 S:RAXAMI="" RAXAMI="UNKNOWN" S:RALOGI="" RALOGI="UNKNOWN"
 W !!?7,"Current Imaging Type: ",RALOGI,!?5,"Procedure Imaging Type: ",RAXAMI
 W !!,"You must switch to a location of ",RAXAMI," imaging type."
 N RA7002 S RA7002=$G(^RADPT(+$P(RAMASK,"^"),"DT",+$P(RAMASK,"^",2),0))
 S:$D(RACCESS(DUZ,"LOC",+$P(RA7002,"^",4))) ^DISV(DUZ,"^RA(79.1,")=+$P(RA7002,"^",4)
 I '$D(RACCESS(DUZ,"LOC",+$G(^DISV(DUZ,"^RA(79.1,")))) D
 . N I S I=0 F  S I=$O(RACCESS(DUZ,"LOC",I)) Q:I'>0  D
 .. S:$D(^RA(79.1,"BIMG",+$P(RA7002,"^",2),I)) ^DISV(DUZ,"^RA(79.1,")=I
 .. Q
 . Q
 Q:'$D(^RA(79.1,"BIMG",+$P(RA7002,"^",2),+$G(^DISV(DUZ,"^RA(79.1,")))) "1^Sorry, you don't have access privileges to edit cases of this imaging type."
 K RAMLC S RASWLOC="" D SET^RAPSET1 K RASWLOC
 Q $S($$GET1^DIQ(79.1,+$G(RAMLC)_",",6,"E")'=RAXAMI:"1^No matches for this sign-on location!",1:0)
