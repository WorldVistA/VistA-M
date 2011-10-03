RACNLU ;HISC/CAH,FPT,GJC AISC/MJK,RMO-Case Number Lookup ;11/13/00  09:13
 ;;5.0;Radiology/Nuclear Medicine;**7,15,23**;Mar 16, 1998
CASE N RADIV,RAIMAGE,RANODE
 R !!,"Enter Case Number: ",X:DTIME S:'$T!(X="") X="^" G Q:X="^"
 I X?1A W !?3,*7,"You must enter more than one character of the name!" G CASE
 I X?1A.AP!(X?1A4N)!(X?9N) S RAHEAD="**** Case Lookup by Patient ****",DIC(0)="EMQ" D ^RADPA G CASE:Y<0 S RADFN=+Y G ^RAPTLU
 I X?16.N.E D QUES G CASE
 D SPACE:X=" " G Q:X="^" D QUES:'X&(X'="??") G CASE:X="^" D SEL G CASE:"^"[X!('RACNT) F I=1:1:11 S @$P("RADFN^RADTI^RACNI^RANME^RASSN^RADATE^RADTE^RACN^RAPRC^RARPT^RAST","^",I)=$P(Y,"^",I)
 W:RACNT'=1 !!?1,"Case No.: ",RACN,?16,"Procedure: ",$E(RAPRC,1,30),?58,"Name: ",$E(RANME,1,20)
 I $D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) S ^DISV($S($D(DUZ)#2:DUZ,1:0),"RA","CASE #")=RADFN_"^"_RADTI_"^"_RACNI,Y(0)=^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)
Q K I,RACNT,RADTCN,RAEND,RAFL,RAFST,RAIX,^TMP("MAG",$J,"COL"),^TMP("MAG",$J,"ROW") Q
 ;
SEL K ^TMP($J,"RAEX") S RACNT=0 G ADC:X["-" S RAFST=$S(X:X-.01,1:0),RAEND=$S(X:X,1:99999),X="",RAIX="AE"
 ;S RAXHOLD=X ;don't need MAG calls anymore 111300
 ;I $$IMAGE^RARIC1 D MED^MAGSET3,ERASE^MAGSET3
 ;S X=RAXHOLD K RAXHOLD
 F RACN=RAFST:0 Q:X="^"!(X>0)  S RACN=$O(^RADPT(RAIX,RACN)) Q:RACN'>0!(RACN>RAEND)  F RADFN=0:0 S RADFN=$O(^RADPT(RAIX,RACN,RADFN)) Q:RADFN'>0  S RADTI=$O(^(RADFN,0)),RACNI=$O(^(RADTI,0)) S X="" D PRT Q:X="^"!(X>0)
 G CHK
ADC S RAIX="ADC",RACN=$P(X,"-",2),RADTCN=X,X=""
 F RADFN=0:0 S RADFN=$O(^RADPT(RAIX,RADTCN,RADFN)) Q:RADFN'>0  S RADTI=$O(^(RADFN,0)),RACNI=$O(^(RADTI,0)) S X="" D PRT Q:X="^"!(X>0)
CHK Q:X="^"!(X>0)  I 'RACNT W !?3,*7,"No matches found!" Q
 I RACNT=1 S X=1,Y=^TMP($J,"RAEX",1) D:$D(RAOPT("EDITCN")) CHECK Q
CHK1 Q:'(RACNT#15)  W !,"CHOOSE FROM 1-",RACNT,": " R X:DTIME S:'$T!(X="") X="^" Q:X="^"  I X["?" D HLP G CHK1
 I '$D(^TMP($J,"RAEX",+X)) S X="^" W *7," ??" Q
 S Y=^TMP($J,"RAEX",+X) D:$D(RAOPT("EDITCN")) CHECK Q
PRT S RAFL=0 Q:'$D(^RADPT(RADFN,0))!('$D(^DPT(RADFN,0)))  S RANME=^(0),RASSN=$$SSN^RAUTL,RANME=$P(RANME,"^")
 K RADIV ;this var must be cleared so can detect bad ^RADPT("AE" ;111500
 I $D(^RADPT(RADFN,"DT",RADTI,0)) D  Q:'RAFL
 . S RANODE=$G(^RADPT(RADFN,"DT",RADTI,0))
 . S RADIV=+$P(RANODE,"^",3),RAIMAGE=+$P(RANODE,"^",2)
 . S RADIV=+$G(^RA(79,RADIV,0)),RADIV=$P($G(^DIC(4,RADIV,0)),"^")
 . S:RADIV']"" RADIV="Unknown"
 . S RAIMAGE=$P($G(^RA(79.2,RAIMAGE,0)),"^")
 . S:RAIMAGE']"" RAIMAGE="Unknown"
 . S (Y,RADTE)=+$P(RANODE,"^") D D^RAUTL S RADATE=Y
 . I $D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) S RAFL=1,Y=^(0)
 . Q
 I '$D(RADIV) Q  ;possible corrupted "AE" active case x-ref on ^RADPT
 ; pointing to a non-existent visit node
 ; Note: if $D(ORVP) the screen logic is to be ignored.  We have entered
 ; through OE/RR.  Even if we are not screening, the user may have
 ; already selected various Division(s) and Imaging type(s) which are
 ; in ^TMP($J,"RA D-TYPE" and ^TMP($J,"RA I-TYPE".  If RANOSCRN is
 ; defined, it means no screening by imaging types to which the
 ; user has access privilege.
 I '$D(ORVP),($D(RANOSCRN)),('$D(RADUPSCN)) I $D(^TMP($J,"RA D-TYPE"))!($D(^TMP($J,"RA I-TYPE"))) Q:'$D(^TMP($J,"RA D-TYPE",RADIV))!('$D(^TMP($J,"RA I-TYPE",RAIMAGE)))
 ; If in 'Case No. Exam Edit' option, skip i-type check in the next line
 I '$D(ORVP),('$D(RADUPSCN)),('$D(RAOPT("EDITCN"))) Q:$$IMGTY^RAUTL12("e",RADFN,RADTI)'=RAIMGTY&('$D(RANOSCRN))
 S RAST=+$P(Y,"^",3),RARPT=+$P(Y,"^",17),RAPRC=$S($D(^RAMIS(71,+$P(Y,"^",2),0)):$P(^(0),"^"),1:"Unknown"),RACNT=RACNT+1
 S ^TMP($J,"RAEX",RACNT)=RADFN_"^"_RADTI_"^"_RACNI_"^"_RANME_"^"_RASSN_"^"_RADATE_"^"_RADTE_"^"_RACN_"^"_RAPRC_"^"_RARPT_"^"_RAST
 ;I $$IMAGE^RARIC1 D DISPA^MAGRIC ; don't need MAG calls anymore 111300
 I RACNT=1,$S('$D(RAEND):1,RAEND<99999:1,1:0),$D(RAVW),$O(^RADPT(RAIX,$S(RAIX="ADC":RADTCN,1:RACN),RADFN))'>0 S X=1,Y=^TMP($J,"RAEX",1) Q
 D HD:RACNT=1 W !?1,RACNT,?9,$$LCASE(RADTE,RACN) W:$O(^RARPT(RARPT,2005,0)) ?22,"i" W ?24,$E(RAPRC,1,25),?50,$E(RANME,1,22),?74,$$SSN^RAUTL(RADFN,1) Q:RACNT#15
PRT1 W !,"Type '^' to STOP, or",!,"CHOOSE FROM 1-",RACNT,": " R X:DTIME S:'$T X="^" Q:X="^"!(X="")  I X["?" D HLP G PRT1
 I '$D(^TMP($J,"RAEX",+X)) W *7," ??" S X="^" Q
 S X=+X,Y=^TMP($J,"RAEX",X) Q
 ;
HD W !!,"Choice",?9,"Case No.",?24,"Procedure",?50,"Name",?74,"Pt ID",!,"------",?9,"--------",?24,"---------",?50,"-----------------",?74,"------" Q
 ;
SPACE I $D(^DISV($S($D(DUZ)#2:DUZ,1:0),"RA","CASE #")) S X=^("CASE #") I $D(^RADPT(+$P(X,"^"),"DT",+$P(X,"^",2),"P",+$P(X,"^",3),0)) S RADTX=$P($P(X,"^",2),"."),X=+^(0) S X=$$LCASE(9999999-RADTX,X) W "  ",X K RADTX Q
 S X="^" Q
 ;
QUES W !,"Enter an active case number in the following form '999'..."
 W !?10,"...or enter a completed case number as 'MMDDYY-999'"
 W !?10,"...or enter a patient's name"
 W !?10,"...or enter a patient's 9-digit SSN"
 W !?10,"...or enter the first character of the patient's",!?13,"last name and the last four digits of their SSN."
ASKACT R !!,"Do you wish to see the entire list of active cases? NO// ",X:DTIME S X=$E(X) S:'$T!("Nn"[X) X="^" I "Yy"'[X,X'="^" W:X'="?" *7 W !!?3,"Enter 'YES' to list all active cases, or 'NO' not to." G ASKACT
 S:"Yy"[X X="??" Q
HLP W !!?3,"Enter the number corresponding to the exam you wish to select.",! Q
LCASE(RADT,RACN) ; Pass back the long case number.
 ; Input : RADT -> FM date (internal format)
 ;         RACN -> Case #
 ; Output: long case number i.e, '010197-100'
 Q $TR($TR($$FMTE^XLFDT(RADT,"2FD")," ","0"),"/","")_"-"_RACN
CHECK ; Check if the exam selected is of the same imaging type as the sign-on
 ; location.  Must be in the 'Case No. Exam Edit' option.
 Q:'$D(RAOPT("EDITCN"))  N RAMASK,RARTRN S RAMASK=Y
 I $$IMGTY^RAUTL12("e",$P(Y,"^"),$P(Y,"^",2))'=RAIMGTY D
 . N X S RARTRN=$$SW^RAPSET1($$IMGTY^RAUTL12("e",$P(Y,"^"),$P(Y,"^",2)),RAIMGTY)
 . Q
 W:+$G(RARTRN) !!,$P(RARTRN,"^",2),$C(7)
 S Y=RAMASK
 I +$G(RARTRN) S X="^" K RADFN,RADTI,RACNI,RANME,RASSN,RADATE,RADTE,RACN,RAPRC,RARPT,RAST,RAEND,RAFST,RAIX
 Q
