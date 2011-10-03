FBNHEP2 ;AISC/GRR-ENTER NURSING HOME PAYMENT ;12:05 PM  13 Jun 1990;
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
NOBAT W !!,*7,"You do not have an open CNH Batch.  You must have an open",!,"CNH type Batch before you can enter a payment!",!
 D Q
 Q
 ;
GETBAT S FBOUT=0,DIC="^FBAA(161.7,",DIC(0)="AEQM",DIC("S")="I $P(^(0),U,3)=""B9""&($P(^(0),U,5)=DUZ)&($P(^(0),U,15)="""")&($G(^(""ST""))=""O"")" W ! D ^DIC K DIC
 I X=""!(X="^") S FBOUT=1 Q
 G GETBAT:Y<0 S FBBAT=+Y,FBCNH=1
 Q
Q K FBYY,FBMM,FBDAYS,FBPAYDT,FBENDDT,Z,Y,DIC,FBRIFN,CNT,%DT,FBAABDT,FBAAEDT,FBAAPTC,FBDEFP,FBER,FBERR,FBHZ,FBINA,FBIRAT,FBPIFN,FBPREV,FBPROG,FBPRTR,FBSRAT,FBTRDYS,FBTYPE,FBVCAR,I,IFN,VAL,X,DA,DIE,DR,FBAAID,FBAAIN,FBNL,FBI7078,FBBAT,FBOUT
 K DAT,F,FBAUT,FBDX,FBEDT,FBI,FBMULT,FBRR,FBTDT,FBXX,FTP,PI,PTYPE,T,ZZ,FB7078,FBAAOUT,FBASSOC,FBLOC,FBPOV,FBPSA,FBPT,FBTT,FBVEN,TA,FBCNH
 Q
 ;
CKRAT ;check rates and fill gaps if needed
 K FB S FBERR=0 N I,J,FBVIEN,FBCHFDT,FBCHTDT,FBCIEN,FBCNUM,FBDDT,FBEXDT,FBEXNDT,FBFND,FBRFDT,FBRTDT,FBRT,FBUNR S I=0
 F  S I=$O(^FBAA(161.23,"AC",FB7078,I)) Q:'I  I $D(^FBAA(161.23,I,0)) S J=^(0) D
 .S FBRT($P(J,U))=$P(J,U,5)_"^"_$P(J,U,2)
 S FBRFDT=0,FBCHFDT=$S(FBAABDT<FBPAYDT:$E(FBPAYDT,1,5)_"01",1:FBAABDT),(FBCHTDT,FBDDT)=FBENDDT,I=DFN,FBVIEN=IFN
 D GETRAT^FBNHRAT,CKFRDT^FBNHRAT
 I $D(FBUNR) S FBERR=1 D ERR K FB Q
 D GETRAT
 Q
GETRAT N I,J,FBCK S I=0
 F  S I=$O(^FBAA(161.23,"AC",FB7078,I)) Q:'I  I $D(^FBAA(161.23,I,0)) S J=^(0) D
 .S FB($P(J,U,2))=$P(J,U,5)_"^"_$P(J,U)
 I $O(FB(FBPAYDT+.9))="" S FBERR=1 D ERR Q
 Q
 ;
CALC ;get dollar amount to pay when no movements in month.
 ;FBPAYS=# of days in month
 ;FBTRDYS=# of treatment days
 ;FBPAYDT=month of payment
 ;FBENDDT=last day of payment month or last day of authorization
 S FBDEFP=0 N FBCT S FBCT=0
 I $G(FBDAYS) S FBTRDYS=$S(FBTRDYS>FBDAYS:FBDAYS,1:FBTRDYS)
 S X=$S(FBAABDT>(FBPAYDT):FBAABDT-1,1:FBPAYDT)
 S Y=$O(FB(X)) I FBENDDT'>Y S FBDEFP=FBTRDYS*+FB(Y) Q
RATE S X1=$O(FB(X)),FBCT=FBCT+1 I 'X1 S FBERR=1 Q
 S FBX1=($S(X1>(FBENDDT-$G(FBENDFLG)):(FBENDDT-$G(FBENDFLG)),1:X1)-X) S:FBCT'>0 FBX1=FBX1+1 S FBDEFP=FBDEFP+(FBX1*$P(FB(X1),U)) S X=X1
 I FBENDDT>X G RATE
 Q
 ;
ERR W !,"Insufficient Authorization Rate data on file for patient: ",$$NAME^FBCHREQ2(DFN) ;,!,"Use the Edit Authorization option prior to entering payment.",!!
 W !,"Take the appropriate action prior to entering a payment:"
 W !?3,"Use the Edit Authorization option to modify the authorization period or",!?3,"assure a contract with valid rates exists for the payment period before",!?8,"continuing with this payment entry.",!!
 Q
 ;calculate dollars when at least one movement in month.
CALC1 S (I,J,Z,FBDEFP)=0
 F  S J=$O(FBZZ(J)) Q:'J  D
 .S I=$O(FBZZ(0)) Q:'I  D
 ..F  Q:'$D(FBZZ(I))  S X=$P(FBZZ(I),"^"),Y=$O(FB(X-.1)),X1=$O(FB(X-.1)) Q:'Y  D
 ...I $P(FBZZ(I),"^",2)>Y S Z=1 D DEFP S Z=0 S $P(FBZZ(I),"^")=Y+1 Q
 ...S Y=$P(FBZZ(I),"^",2) D DEFP K FBZZ(I)
 K I,J,X,Y,X1 Q
 ;
DEFP S FBDEFP=FBDEFP+(($S(FBAABDT=FBAAEDT:1,1:Y-X)+$P(FBZZ(I),"^",3)+Z)*+FB(X1))
 Q
 ;
DAYS S (I,FBTRDYS)=0 K FBPREV,FBHI
 S FBBEG=FBPAYDT+1
 F  S I=$O(FBZ(I)) Q:'I  D
 .I '$D(FBPREV),$P(FBZ(I),U,2) S FBBEG=$S($P(FBZ(I),U)>FBPAYDT:$P(FBZ(I),U),1:FBPAYDT),FBPREV=1
 .I '$P(FBZ(I),U,2),$S('$D(FBHI):1,1:$P(FBZ(+FBHI),U,2)) S FBEND=$P(FBZ(I),U),FBTRDYS=FBTRDYS+($S(FBEND-FBBEG:FBEND-FBBEG,((FBAABDT<FBAAEDT)&(+$E(FBAAEDT,6,7)=1)):0,1:1))+$P(FBZ(I),U,2) S FBZZ(I)=FBBEG_"^"_FBEND
 .I $D(FBHI),$P(FBZ(I),U,2) S FBBEG=$P(FBZ(I),U)
 .S FBHI=I
 I FBENDDT>$P(FBZ(FBHI),U),$P(FBZ(FBHI),U,2) S FBTRDYS=FBTRDYS+($S(FBENDDT-FBBEG:FBENDDT-FBBEG,1:1))+1,$P(FBZZ(FBHI),U,3)=1 I '+FBZZ(FBHI) S $P(FBZZ(FBHI),"^",1,2)=FBBEG_"^"_FBENDDT
 I FBENDDT=$P(FBZ(FBHI),U),$P(FBZ(FBHI),U,2) S FBTRDYS=FBTRDYS+1 I '+$G(FBZZ(FBHI)) S $P(FBZZ(FBHI),"^",1,2)=FBBEG_"^"_FBENDDT
 Q
CHECK N FBCK,FBCK1
 S FBCK=$S(FBABD<FBPAYDT:($E(FBPAYDT,1,5)_"01"),1:FBABD),FBCK1=$O(FB(FBCK-.1)) I $P(FB(FBCK1),"^",2)>FBCK S FBERR=1 D ERR Q
 Q
