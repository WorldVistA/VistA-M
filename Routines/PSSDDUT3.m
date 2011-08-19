PSSDDUT3 ;BIR/LDT-Pharmacy Data Management DD Utility ; 09/17/97 14:35
 ;;1.0;PHARMACY DATA MANAGEMENT;**35**;9/30/97
 ;
 ; Reference to ENSD^PSGNE3 is supported by DBIA #2150.
 ; Reference to EN^PSGCT is supported by DBIA #2146.
 ; Reference to ENT^PSIVWL is supported by DBIA #2154.
 ;
ADTM ;UNIT DOSE MULTIPLE of PHARMACY PATIENT file (55) field 41
 S PSSHLP(1)="THE TIMES MUST BE TWO (2) OR FOUR (4) DIGITS, SEPARATED WITH"
 S PSSHLP(2)="DASHES ('-'), AND BE IN ASCENDING ORDER. (IE. 01-05-13)"
 D WRITE
 Q
 ;
SPCIN ;UNIT DOSE MULTIPLE of PHARMACY PATIENT file (55) field 8
 S PSSHLP(1)="IF ABBREVIATIONS ARE USED, THE TOTAL LENGTH OF THE EXPANDED"
 S PSSHLP(2)="INSTRUCTIONS ALSO MAY NOT EXCEED 180 CHARACTERS."
 D WRITE
 Q
 ;
SCHTP ;Called from the Unit Dose Multiple of file 55, Schedule Type field 7
 S PSSHLP(1)="CHOOSE FROM:"
 S PSSHLP(1,"F")="!!"
 S PSSHLP(2)="C - CONTINUOUS"
 S PSSHLP(2,"F")="!?3"
 S PSSHLP(3)="O - ONE-TIME"
 S PSSHLP(3,"F")="!?3"
 S PSSHLP(4)="OC - ON CALL"
 S PSSHLP(4,"F")="!?3"
 S PSSHLP(5)="P - PRN"
 S PSSHLP(5,"F")="!?3"
 S PSSHLP(6)="R - FILL ON REQUEST"
 S PSSHLP(6,"F")="!?3"
 D WRITE
 Q
 ;
CHKSI ;Called from Unit Dose Multiple of file (55), Special Instructions
 ;field 8 (Replaces ^PSGSICHK)
 I $S(X'?.ANP:1,X["^":1,1:$L(X)>180) K X Q
 N Y S Y="" F Y(1)=1:1:$L(X," ") S Y(2)=$P(X," ",Y(1)) I Y(2)]"" D CHK1 Q:'$D(X)
 I $D(X),Y]"",X'=$E(Y,1,$L(Y)-1) D EN^DDIOL("EXPANDS TO:","","!?3") F Y(1)=1:1 S Y(2)=$P(Y," ",Y(1)) Q:Y(2)=""  D:$L(Y(2))+$X>78 EN^DDIOL("","","!") D EN^DDIOL(Y(2)_" ","","?0")
 K Y Q
CHK1 ;
 I $L(Y(2))<31,$D(^PS(51,+$O(^PS(51,"B",Y(2),0)),0)),$P(^(0),"^",2)]"",$P(^(0),"^",4) S Y(2)=$P(^(0),"^",2)
 I $L(Y)+$L(Y(2))>180 K X Q
 S Y=Y_Y(2)_" " Q
 ;
EN2 ;Called from Unit Dose multiple of file 55, STOP DATE/TIME field 34
 ;Replaces EN2^PSGDL
 K PSGDLS S ND2=^PS(55,DA(1),5,DA,2) I '$P(ND2,"^",5),'$P(ND2,"^",6) G DONE
 D EN^DDIOL(" ...Dose Limit... ","","?0")
 ;
ENGO ;
 S SCH=$P(ND2,"^")
 S ST=$S($D(PSGDLS):PSGDLS,1:$P(ND2,"^",2))
 S TS=$P(ND2,"^",5),MN=$P(ND2,"^",6)
 I $P(PSJSYSW0,U,5)=2 D
 . S $P(PSJSYSW0,U,5)=1
 . S X="PSGNE3" X ^%ZOSF("TEST") I  S ST=$$ENSD^PSGNE3(ST,TS,ST,"")
 . S $P(PSJSYSW0,U,5)=2
 G MWF:SCH["@",DONE:'TS&'MN
 I 'TS S X="PSGCT" X ^%ZOSF("TEST") I  S AM=MN*PSGDL,X=$$EN^PSGCT(ST,AM) G DONE
 S TM=$E(ST_"00000",9,8+$L($P(TS,"-")))
 F Q=1:1 Q:$P(TS,"-",Q)=""!(TM<$P(TS,"-",Q))
 S X=ST\1,C=0 F Q=Q:1 D:$P(TS,"-",Q)="" ADD S C=C+1 I C=PSGDL S X=X_"."_$P(TS,"-",Q) G DONE
 ;
MWF ; if schedule is similar to monday-wednesday-friday
 S TS=$P(SCH,"@",2),SCH=$P(SCH,"@"),X=$P(ST,"."),C=0 D SCHK G:C=PSGDL DONE F Q=1:1 S X1=$P(ST,"."),X2=Q D C^%DTC S X1=X D DW^%DTC D CHK G:C=PSGDL DONE
SCHK S X1=X D DW^%DTC F Q=1:1:$L(SCH,"-") S WKD=$P(SCH,"-",Q) I WKD=$E(X,1,$L(WKD)) Q
 E  Q
 S TM=$E(ST_"00000",9,8+$L($P(TS,"-"))) F Q=1:1:$L(TS,"-") I TM<$P(TS,"-",Q) S C=C+1 I C=PSGDL S X=X1_"."_$P(TS,"-",Q) Q
 Q
CHK F QQ=1:1:$L(SCH,"-") S WKD=$P(SCH,"-",QQ) I WKD=$E(X,1,$L(WKD)) D TS Q
 Q
TS F Q1=1:1:$L(TS,"-") S C=C+1 I C=PSGDL S X=X1_"."_$P(TS,"-",Q1) Q
 Q
 ;
DONE ;
 K %H,%T,%Y,MN,ND2,ND4,PSGDLS,PSGDL,Q1,QQ,SCH,TM,WKD,TS,X1,X2 Q
 ;
ADD ;
 S X1=$P(X,"."),X2=$S(MN&'(MN#1440):MN\1440,1:1) D C^%DTC S Q=1 Q
 ;
ENDL ;From DD(55.01,.03,0) Replaces call ENDL^PSIVSP
 D EN^DDIOL("   Dose limit ....  ","","?0") S PSIVMIN=P(15)*X,PSIVSD=+P(2)
 I PSIVMIN<0 D EN^DDIOL(" --- There is something wrong with this order !!","","!!") D EN^DDIOL("     Call inpatient supervisor .....") S Y=-1 K PSIVMIN Q
 I P(4)="P"!(P(5))!(P(23)="P"),PSIVMIN=0,"^NOW^STAT^ONCE^"'[("^"_$P(P(9)," ")_"^") D DLP G QDL
 S X="PSIVWL" X ^%ZOSF("TEST") I  D ENT^PSIVWL
QDL I $D(X) S X=Y X ^DD("DD") W $P(Y,"@")," ",$P(Y,"@",2) S Y=X
 Q
DLP ;
 S X=X+1,$P(PSIVSD,".",2)=$P(PSIVSD,".",2)_$E("0000",1,4-$L($P(PSIVSD,".",2))) D CHK3 S X2=0,Y=1 I X<2 S Y=+PSIVSD G QDLP
 I $P(PSIVSD,".",2)>$P(P(11),"-",$L(P(11),"-")) S X2=1 G OV
 G:$P(P(11),"-")>$P(PSIVSD,".",2) OV
 F Y=1:1 S X1=$P(P(11),"-",Y) I X1=$P(PSIVSD,".",2)!($P(PSIVSD,".",2)<X1) Q
OV I P(11)="" D EN^DDIOL(" ???","","$C(7)") D EN^DDIOL("*** You have not defined any administration times !!","","!?15") K X Q
 F Y=Y:1 S:$P(P(11),"-",Y)="" X2=X2+1,Y=0,X=X+1 S X=X-1 Q:X<1
 S X=PSIVSD\1 I X2>0 S X1=PSIVSD D C^%DTC S X=$P(X,".") ; install with version 17.3 of fileman
 S Y=+(X_"."_$P(P(11),"-",Y))
QDLP K X1,X2 Q
 ;
ENI ;^DD(555.01,.03,0)
 K:$L(X)<1!($L(X)>30)!(X["""")!($A(X)=45) X I '$D(X)!'$D(P(4)) Q
 I P(4)="P"!(P(5))!(P(23)="P") Q:'X  S X="INFUSE OVER "_X_" MIN." D EN^DDIOL("   "_X,"","?0") Q
 I X'=+X,($P(X,"@",2,999)'=+$P(X,"@",2,999)!(+$P(X,"@",2,999)<0)) K X Q
 S SPSOL=$O(DRG("SOL",0)) I 'SPSOL K SPSOL,X D EN^DDIOL("  You must define at least one solution !!","","?0") Q
 I X=+X S X=X_" ml/hr" D EN^DDIOL(" ml/hr","","?0") D SPSOL S P(15)=$S('X:0,1:SPSOL\X*60+(SPSOL#X/X*60+.5)\1) K SPSOL Q
 S SPSOL=$P(X,"@",2) S:$P(X,"@")=+X $P(X,"@")=$P(X,"@")_" ml/hr" D EN^DDIOL("   "_+SPSOL_" Label"_$S(SPSOL'=1:"s",1:"")_" per day","","?0") D EN^DDIOL("at an infusion rate of: "_$P(X,"@"),"","!?15") S P(15)=$S('SPSOL:0,1:1440/SPSOL\1) K SPSOL
 Q
SPSOL S SPSOL=0 F XXX=0:0 S XXX=$O(DRG("SOL",XXX)) Q:'XXX  S SPSOL=SPSOL+$P(DRG("SOL",XXX),U,3)
 K XXX Q
CHK3 F Y=1:1 Q:$L(P(11))>240!($P(P(11),"-",Y)="")  S $P(P(11),"-",Y)=$P(P(11),"-",Y)_$E("0000",1,4-$L($P(P(11),"-",Y)))
 Q
 ;
WRITE ;Calls EN^DDIOL to write text
 D EN^DDIOL(.PSSHLP) K PSSHLP Q
 Q
