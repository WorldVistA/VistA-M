DGUTL ;ALB/MRL - DG UTILITY FUNCTIONS ; 08 JAN 86
 ;;5.3;Registration;**279,570,677**;Aug 13, 1993
 ;
RI ;Reimbursable Insurance
 ; ** NOTE: This procedure appears to be obsolete, but code was modified
 ; for IB/AR Encapsulation anyways.
 S DGINS=$$INSUR^IBBAPI(DFN,"","A")
 Q
 ;
TS ;Table of Contents SET
 I '$D(^UTILITY($J,"DGTC",DGPAG)) S ^UTILITY($J,"DGTC",DGPAG,DGPAG1)="" Q
TP ;Table of Contents PRINT
 I '$D(^UTILITY($J,"DGTC")) Q
 D TH S J=0 F I=0:0 S J=$O(^UTILITY($J,"DGTC",J)),J1=0 Q:J=""  F I1=0:0 S J1=$O(^UTILITY($J,"DGTC",J,J1)) Q:J1=""  S X="",$P(X,".",(IOM-20-$L(J)-$L(J1)))="" W !?10,J,"  ",X,"  ",J1 I $Y>$S($D(IOSL):(IOSL-6),1:62) D TH
 W ! K ^UTILITY($J,"DGTC"),I,I1,J,J1,DGTCH,X,Y Q
TH ;Table of Contents HEADER
 W @IOF,!,"TABLE OF CONTENTS FOR '",$P(DGTCH,U,1),"'",?(IOM-11) S Y=DT X ^DD("DD") W Y,!?10,$P(DGTCH,U,2),?IOM-7-$L($P(DGTCH,U,3)),$P(DGTCH,U,3) S X="",$P(X,"=",IOM)="" W !,X K X Q
C ;Cover Page
 W @IOF S TT=0 F I=0:0 S I=$O(DGCPG(I)) Q:'I  S TT=TT+1,$P(DGCPG(I),U,2)=$S($D(IOM):IOM-$L($P(DGCPG(I),U,1))\2,1:132-$L($P(DGCPG(I),U,1))\2)
 S TT=$S($D(IOSL):IOSL-(TT*2+10)\2,1:66-(TT*2+10)\2) F I=1:1:TT W !
 F I=0:0 S I=$O(DGCPG(I)) Q:'I  W !!?$P(DGCPG(I),U,2),$P(DGCPG(I),U,1)
 I $D(DUZ),$D(^VA(200,+DUZ,0)) S X="Printed by:  "_$P(^(0),U,1),X1=$S($D(IOM):IOM-$L(X)\2,1:132-$L(X)\2) W !!?X1,X
 I $D(^DD("SITE"))#2 S X=^("SITE")_" ("_^("SITE",1)_")",X1=$S($D(IOM):IOM-$L(X)\2,1:132-$L(X)\2) W !!?X1,X
 I $D(DGCPT) X "F I=1:1:$S($D(IOSL):(IOSL-5),1:61)-$Y W !" W DGCPT
 W !! K TT,I,X,X1 Q
H ;Convert $H to Readable Date/Time
 D:'$D(DT) DT^DICRW S DGTIME=$P($H,",",2),DGTIME=DT+(DGTIME\3600/100)+(DGTIME\60#60/10000),DGDATE=DGTIME\1 Q
DIV ;Determine Division
 I $D(^DG(43,1,"GL")),$P(^("GL"),"^",2) S DGDIV="" Q
 S DGDIV=$S($O(^DG(40.8,0))>0:$O(^DG(40.8,0)),1:"") I DGDIV S DGDIV=DGDIV_"^"_$P(^DG(40.8,+DGDIV,0),"^",1)
 Q
DT W:$E(%,4,5) +$E(%,4,5)_"-" W:$E(%,6,7) +$E(%,6,7)_"-" W $E(%,1,3)+1700 W:%["." " ("_$E(%_0,9,10)_":"_$E(%_"000",11,12)_")" Q
EOM ;Required Variable: X - Date should be in internal FM date format
 ;Returned Variable: Y - End of Month in internal FM date format
 S X1=$S($E(X,4,5)=12:$E(X,1,3)+1_"01",1:$E(X,1,5)+1)_"01"_$S($P(X,".",2):"."_$P(X,".",2),1:""),X2=-1 D C^%DTC S Y=X K X
 Q
LO D:'$D(DT) DT^DICRW S:'$D(DTIME) DTIME=300 S U="^" Q
 I '$D(^DG(43,1,0)) W !,"ADT parameters not set up",*7 G H^XUS
 S USER=$S($D(DUZ)#10:DUZ,1:0) I 'USER!('$D(^VA(200,USER,0))) W !!,"Please log off the computer and then back to use this option.",!!,*7 K ^UTILITY("DG",$J) G H^XUS
 K USER Q
 ;
UPPER(X) ; -- convert to uppercase
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
LOWER(X) ;
 N Y,C,Z,I
 S Y=$E(X)_$TR($E(X,2,999),"ABCDEFGHIJKLMNOPQRSTUVWXYZ@","abcdefghijklmnopqrstuvwxyz ")
 F C=" ",",","/" F I=2:1 S Z=$P(Y,C,I,999) Q:Z=""  S Y=$P(Y,C,1,I-1)_C_$TR($E(Z),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")_$E(Z,2,999)
 Q Y
QUES(DFN,DGQCODE) ; EDIT REGISTRATION DATA FOR AMIE USE ONLY
 ;
 ;  INPUT:
 ;     DFN
 ;     DGQCODE = Code for question(s) to be asked
 ;  OUTPUT:
 ;     DGERR   = ERROR VARIABLE
 ;     DGCHANGE= 1 IF DATA MODIFIED 0 O/W
 ;
 N D,D0,DI,DIC,DGCODE,DGDR,DGNODE,DGQNODES,DGPC,DGPTND,DGRPS,DGQ,DGX,DQ,N,X,Y,%Y
 S (DGERR,DGRPS,DGCHANGE)=0
 G:'($G(DFN)&($G(DGQCODE)="ADD1")) QTE
 S DGPC=2,DGCODE="ADD1"
 S DGDR=104
 S DGRPS=1
 S DGQNODES=".11~.13"
 F N=1:1 S DGNODE=$P(DGQNODES,"~",N) Q:DGNODE']""  S DGPTND(DGNODE)=$G(^DPT(DFN,DGNODE))
 D ^DGRPE
 F DGNODE=0:0 S DGNODE=$O(DGPTND(DGNODE)) Q:DGNODE']""  S:$G(^DPT(DFN,DGNODE))'=(DGPTND(DGNODE)) DGCHANGE=1
QTE I 'DGRPS S DGERR=1
QTQ Q
 ;FORM FEED & STOPPING UTILITIES
FIRST() ;First heading of report
 ; RETURNS STOP; 0=GO,1=STOP
 N STOP
 D STOPCHK
 D:$G(STOP) STOPPED
 I '$G(STOP),$E($G(IOST),1,2)="C-" W @IOF
 Q $G(STOP)
 ;
SUBSEQ() ;enter for further headings of report
 ; RETURNS STOP; 0=GO,1=STOP
 N STOP,DIR,X,Y
 D STOPCHK
 I $E($G(IOST),1,2)="C-" S DIR(0)="E" D ^DIR S:$D(DIRUT) STOP=1
 D:$G(STOP) STOPPED
 I '$G(STOP) W @IOF
 Q $G(STOP)
 ;
STOPCHK I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,STOP)=1
 Q
STOPPED ;
 W !?5,"------------- Report stopped at user's request ------------"
 K ZTREQ
 Q
ENDREP I $E(IOST,1,2)'["C-" W:$Y&'$D(IONOFF) @IOF Q
 Q
 ;
ASKDIV(NOTALL) ;Ask for division (one/many/all)
 ; Input: NOTALL - Flag that prevents selection of all divisions
 ;          1 = Don't allow selection of all divisions
 ;          0 = Allow selection of all divisions (default)
 ;Output: Integer indicating if selection was made
 ;          0 = No divisions selected (user quit)
 ;          1 = Divisions selected
 ;        VAUTD will be set as follows:
 ;          VAUTD = 1 if all divisions selected
 ;          VAUTD = 0 if individual divisions selected
 ;          VAUTD(DivPtr) = DivisionName for each division selected
 ; Notes: VAUTD is KILLed in input
 ;
 N FIRSTDIV,MULTIDIV,Y,VAUTNALL
 K VAUTD
 S FIRSTDIV=+$O(^DG(40.80,0))
 I '$D(^DG(40.8,FIRSTDIV,0)) D  G ASKDIVQ
 . W !
 . W $C(7),"***WARNING...MEDICAL CENTER DIVISION FILE IS NOT SET UP***"
 . W !
 S MULTIDIV=+$P($G(^DG(43,1,"GL")),"^",2)
 I 'MULTIDIV S VAUTD=1 G ASKDIVQ
 S (VAUTD,Y)=0
 I +$G(NOTALL) S VAUTNALL=1
 D DIVISION^VAUTOMA
 I Y<0 K VAUTD
ASKDIVQ Q $D(VAUTD)>0
 ;
EMGRES(DFN)     ;DG*5.3*677
 ;This API returns the value of the Emergency Response
 ;Indicator (file 2, field .181), or null if blank
 ;
 ;INPUT:
 ;   DFN - pointer to the Patient File (#2)
 ;
 ;OUTPUT:
 ;   Function value - returns value from E.R.I. field, or null if blank
 ;
 I 'DFN Q ""
 ;
 N RESULT
 S RESULT=$P($G(^DPT(DFN,.18)),U)
 Q RESULT
