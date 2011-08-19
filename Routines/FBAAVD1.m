FBAAVD1 ;AISC/DMK/GRR-COMMUNITY NURSING HOME VENDOR DISPLAY ; 1/15/10 2:06pm
 ;;3.5;FEE BASIS;**9,111**;JAN 30, 1995;Build 17
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 I $Y+11>IOSL D  Q:'Y
 . I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR I 'Y Q
 . W @IOF,!,$J("Name:",13),?15,$E(Z(1),1,30),?48,"ID Number: ",Z(2)
 . S Y=1 ; continue
 W !?23,">>> CNH INFORMATION <<<",!
 W !,$J("Total Beds:",13),?15,$P(V,"^",8),?37,"Inspected/Accredited:",?59,$S($P(V,"^",4)="I":"Inspected by VA",$P(V,"^",4)="A":"Accredited by JCAH",$P(V,"^",4)="B":"Inspect. & Accred.",1:"")
 Q:'$D(^FBAA(161.21,"C",DA))
 S FBX=$$CNH(DA,1)
 W !,$J("Contract #:",13),?15,$P(FBX,U)
 W ?40,$J("Medicare/Medicaid:",13),?59,$S($P(V,"^",5)=1:"Not Cert. for either",$P(V,"^",5)=2:"Cert. for Medicare",$P(V,"^",5)=3:"Cert. for Medicaid",$P(V,"^",5)=4:"Cert. for both",1:"")
 W !,$J("Effect. DT:",13),?15,$$DATX^FBAAUTL($P(FBX,U,2))
 W ?42,"Last Assessment:",?59,$$DATX^FBAAUTL($P(V,"^",6))
 W !,$J("End Date:",13),?15,$$DATX^FBAAUTL($P(FBX,U,3))
 S FBCNUM=$P(FBX,U) K FBX
 W !
 S FBVIEN=DA D DISPLAY K FBVIEN
 Q
 ;
CNH(X,Z) ;retrieve latest vendor contract
 ;X=IEN for vendor
 ;returns contract number
 ;if Z=1 returns array C#^effect dt^expire dt
 N Y
 I $S('$G(X):1,'$D(^FBAAV(+X,0)):1,1:0) Q ""
 S Y=$P($G(^FBAA(161.21,+$O(^(+$O(^FBAA(161.21,"ACR",X,-DT-.9)),0)),0)),U,1,3)
 I Y="" S Y=$P($G(^FBAA(161.21,+$O(^(+$O(^FBAA(161.21,"AC",X,DT)),0)),0)),U,1,3)
 Q $S($G(Z):Y,1:$P(Y,U))
 ;
RATE(X,FBCNRTS) ;retrieve rates
 ;X=contract number
 ;FBCNRTS = optional array, contains the associated rates.
 ;returns the number of rates associated with a contract.  
 N I,CNT
 I $S('$D(X):1,X']"":1,'$D(^FBAA(161.21,"B",X)):1,1:0) Q ""
 S X=$O(^FBAA(161.21,"B",X,0))
 S (I,CNT)=0,Y="" F  S I=$O(^FBAA(161.22,"AC",X,I)) Q:'I  I $D(^FBAA(161.22,I,0)) S CNT=CNT+1 D
 .S FBCNRTS(CNT)=$P(^FBAA(161.22,I,0),"^",2)
 Q CNT
 ;
DISPLAY ;
 ;will display rates on screen for selection
 ;if FBRATE is passed in the display will allow user
 ;selection and return 'FBRATE' equal to the dollar amount
 ;FBCNUM=contract number
 ;must pass in IEN of vendor in 161.2 as FBVIEN
 I $S('$G(FBVIEN):1,'$D(^FBAAV(FBVIEN,0)):1,1:0) S FBX="" Q
 I $S($G(FBCNUM)']"":1,'$D(^FBAA(161.21,"B",FBCNUM)):1,1:0) S FBX="" Q
 N I,J
 N FBCONRTS,FBX S FBX=$$RATE(FBCNUM,.FBCONRTS) I $G(FBX)<0 S FBRATE="" Q
 S J="" F I=1:1 S J=$G(FBCONRTS(I)) Q:'J  S X=J,X2="2$" D COMMA^%DTC S J=X D
 .W:I#2 !?10,$S($D(FBRATE):I_")"_J,1:"RATE "_I_":"_J)
 .W:I#2=0 ?40,$S($D(FBRATE):I_")"_J,1:"RATE "_I_":"_J)
 Q:'$D(FBRATE)
 W ! S DIR(0)="N^1:"_(I-1) D ^DIR K DIR I $D(DIRUT) S FBRATE="" Q
 ;S FBRATE=$P(FBX,U,Y)
 S FBRATE=$G(FBCONRTS(Y))
 Q
