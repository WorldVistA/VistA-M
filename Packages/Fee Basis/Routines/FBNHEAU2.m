FBNHEAU2 ;AISC/dmk - ask rates for cnh authorization ; 1/14/10 8:00pm
 ;;3.5;FEE BASIS;**111**;JAN 30, 1995;Build 17
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
GETRAT S FBERR="",FBMULT=0,FBVIEN=IFN I '$D(^FBAA(161.21,"C",IFN)) S FBERR=1 W !,"Vendor: ",$P(^FBAAV(IFN,0),"^")," has no Contract data on file" Q
 S FBRIFN=$O(^FBAA(161.21,"ACR",IFN,-(FBPAYDT+.9))) I 'FBRIFN W !,"Vendor: ",$P(^FBAAV(IFN,0),"^")," has no current Contract data on file" S FBERR=1 Q
 S FBRIFN=$O(^FBAA(161.21,"ACR",IFN,FBRIFN,0)),FBC(0)=^FBAA(161.21,+FBRIFN,0),FBCNUM=$P(FBC(0),U),FBRIFN(0)=FBC(0)
 S FBEDT=$P(FBC(0),U,2),FBTDT=$P(FBC(0),U,3)
 I FBTDT<FBENDDT D
 .S CNT=0,FBMULT=1
 .F I=FBTDT+.9:0 S I=$O(^FBAA(161.21,"AC",IFN,I)) Q:'I!(I>FBENDDT)  S CNT=CNT+1,FBRIFN(CNT)=^FBAA(161.21,$O(^(I,0)),0)
 I FBPAYDT>FBTDT S FBERR=1 W !,"Vendor: ",$P(^FBAAV(IFN,0),U)," has no current contract on file.",! Q
 ;display rates for selection
 W !!?25,"VENDOR RATE SELECTION",!!
 I FBMULT=0 S FBVIEN=IFN,FBRATE=1 D DISPLAY^FBAAVD1 S FB(0)=FBBEGDT_"^"_$S(FBTDT>FBENDDT:FBENDDT,1:FBTDT)_"^"_FBRATE_"^"_FBCNUM S:'FBRATE FBERR=1
 I FBMULT S I="",FBRATE=0 F  S I=$O(FBRIFN(I)) Q:I=""!(FBERR)  D
 .S FBFR=$$FR(FBPAYDT,$P(FBRIFN(I),U,2)),FBTO=$$TO(FBENDDT,$P(FBRIFN(I),U,3)),FBCNUM=$P(FBRIFN(I),U)
 .W !?14,"For dates ",$$DATX^FBAAUTL(FBFR)_" - "_$$DATX^FBAAUTL(FBTO)_" : ",! S FBRATE=1 D DISPLAY^FBAAVD1 S:'FBRATE FBERR=1 Q:FBERR  D
 .. S FB(I)=FBFR_"^"_FBTO_"^"_FBRATE_"^"_FBCNUM
 ;I FBMULT S FBCHECK=1 D EST K FBCHECK,FBATODT,FBTO,FBDEFP I FBERR D
 ;. W !,*7,"Insufficient contract data on file for current month.",!
 I FBMULT K FBATODT,FBTO
 Q
 ;
FR(X,Y) ;return date that should be used as from date at prompt
 ;x=authorization from date
 ;y=contract from date
 Q $S(X>Y:X,1:Y)
 ;
TO(X,Y) ;return date that is default to date
 ;x=last day of authorization or month
 ;y=last day of contract
 Q $S(X>Y:Y,1:X)
 ;
EST ;calculate estimate amount to post to 1358 for month of authorization
 ;the FB( array contains all rate information currently available
 ;for this patient based on vendor contract information.
 ;FBPAYDT=begin date of autorization
 ;FBENDDT=end date of authorization
 ;FBATODT=either end of month or end of autorization (whichever less)
 S Z=$Q(FB) I Z="" S FBERR=1 D ERROR Q
 I '$D(FBATODT) S FBATODT=$S($E(FBPAYDT,1,5)_"00"+(FBDAYS)>FBENDDT:FBENDDT,1:$E(FBPAYDT,1,5)_"00"+(FBDAYS))
 S FBDEFP=0,X=@Z
 I FBATODT'>$P(X,U,2) S FBDEFP=($$DTC^FBUCUTL(FBATODT,FBPAYDT)+1)*$P(X,U,3) Q
 S FBDEFP=FBDEFP+($$DTC^FBUCUTL($P(X,U,2),$P(X,U))+1*$P(X,U,3))
MORE S Z=$Q(@Z) I Z="" S FBERR=1 D ERROR Q
 S X=@Z,FBTO=$S($P(X,U,2)'>FBATODT:$P(X,U,2),1:FBATODT)
 I FBTO<$P(X,U) S FBERR=1 D ERROR Q
 I FBTO'>$P(X,U,2) S FBDEFP=FBDEFP+($$DTC^FBUCUTL(FBTO,$P(X,U))+1*$P(X,U,3)) Q
 S FBDEFP=FBDEFP+($$DTC^FBUCUTL($P(X,U,2),$P(X,U))+1*$P(X,U,3))
 G MORE
ERROR W:'$D(FBCHECK) *7,!,"Unable to calculate total estimated amount.  Check CNH contracts.",!
 Q
 ;
FILE ;file entries for the patients authorization in file 161.23.
 ;this file contains from and to dates and the rate we paid
 ;during that time frame for the 7078.
 I $Q(FB)="" S FBERR=1 Q
 I '$G(DFN) S FBERR=1 Q
 I '$G(FBAA78) S FBERR=1 Q
 N DA,DIC,DIE,DR,DLAYGO,FBI S FBI=""
 F  S FBI=$O(FB(FBI)) Q:FBI=""  D
 . S X=$P(FB(FBI),U),DIC="^FBAA(161.23,",DIC(0)="L",DLAYGO=161.23 K DD,DO D FILE^DICN I Y<0 S FBERR=1 Q
 .S DA=+Y,DIE=DIC,DR=".02////^S X=$P(FB(FBI),U,2);.03////^S X=FBAA78;.04////^S X=DFN;.05////^S X=$P(FB(FBI),U,3);.06////^S X=$P(FB(FBI),U,4)" D ^DIE
 Q
