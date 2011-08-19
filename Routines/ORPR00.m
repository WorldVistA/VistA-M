ORPR00 ; slc/dcm - Prints Charming ;5/10/01  10:10
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**5,11,69,99,95**;Dec 17, 1997
EN ;Formatter
 N ORIOF,D,DA,D0,DI,DIC,DE,DQ,DIE,DR,DTOUT,DUOUT,Y,ORFMT,DLAYGO,ORK,%,%Y,%X,Y,I
 S DIC="^ORD(100.23,",DIC(0)="AEMQL",DLAYGO=100.23
 D ^DIC I Y<0 G OUT
 S (ORFMT,DA)=+Y,DIE="^ORD(100.23,",DR="[OR PRINT FORMAT EDIT]"
 D ^DIE
 I '$D(^ORD(100.23,ORFMT,0)) G OUT
ASK W !!," OK to compile print format"
 S %=1 D YN^DICN
 Q:%=-1
 I %=0 W !,"Answer YES to incorporate changes made into the compiled code." G ASK
 Q:%=2
 S ORK=0 F  S ORK=$O(^ORD(100.22,ORK)) Q:ORK'>0  I $D(^(ORK,0)),$L($P(^(0),"^",4)) S @$P(^(0),"^",4)=$P(^(0),"^",3)
 D CMPL
 W !!,"|||||------------------------    Column Numbers    ------------------------|||||"
 W !,"0---+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8"
 W !,"1        0         0         0         0         0         0         0         0"
 S ORIOF=IOF,IOF="!"
 D PRINT(ORFMT,1,1)
 W !
 S IOF=ORIOF
 D CMPL^ORPR010(ORFMT)
 G EN
OUT ;Clean-up before exit
 S ORK=0 F  S ORK=$O(^ORD(100.22,ORK)) Q:ORK'>0  I $D(^(ORK,0)),$L($P(^(0),"^",4)) K @$P(^(0),"^",4)
 Q
CMPL ;Compile print code for output
 N X,I,ORROW,ORK,ORVAR,ORFL,ORAN,ORV,ORCL,OROJ,ORPT
 Q:'$D(^ORD(100.23,ORFMT,0))  S X=^(0)
 S ORROW=$S($P(X,"^",2):$P(X,"^",2),1:6)
 K ^ORD(100.23,ORFMT,2)
 S ORK=0 F  S ORK=$O(^ORD(100.23,ORFMT,1,ORK)) Q:ORK'>0  I $D(^(ORK,0)) S X=^(0) D
 . S ^TMP("OR",$J,"FMT",+$P(X,"^",2),+$P(X,"^",3),$P(X,"^"))=$P(X,"^",4,7)
 S ORAN=1,(ORFL,ORV)=0
 F ORK=1:1:ORROW S:ORK>1 ORFL=1 D
 . I '$D(^TMP("OR",$J,"FMT",ORK)) S ^ORD(100.23,ORFMT,2,ORAN,0)="W !",ORAN=ORAN+1 Q
 . S ORCL=0 F  S ORCL=$O(^TMP("OR",$J,"FMT",ORK,ORCL)) Q:ORCL'>0  S ORPT=$O(^(ORCL,"")),OROJ=^(ORPT) D STUF
 I $O(ORVAR(0)) S ORAN=ORAN+1 S I=0,X="X" D
 .F  S I=$O(ORVAR(I)) Q:I<1  S X=X_","_ORVAR(I)
 .S ^ORD(100.23,ORFMT,2,ORAN,0)="K "_X
 S ^ORD(100.23,ORFMT,2,0)="^^"_ORAN_"^"_(ORAN+1)_"^"_DT
 I '$D(DIFROM) W !!?3,"... '",$P(^ORD(100.23,ORFMT,0),"^"),"' format has been compiled."
 K ^TMP("OR",$J,"FMT")
 Q
STUF ;
 I $P(^ORD(100.22,+ORPT,0),"^",6),$D(^(1)),$L(^(1)) S ^ORD(100.23,ORFMT,2,ORAN,0)=^ORD(100.22,+ORPT,1),ORAN=ORAN+1 Q  ;Direct execute (not compiled)
 N ORDEF,ORFUN,ORPRM,ORTL
 S ORVAR="DT",ORDEF=""
 S:$D(^ORD(100.22,+ORPT,0)) ORVAR=$P(^(0),"^",4),ORDEF=$P(^(0),"^",2),ORFUN=$P(^(0),"^",5) I $D(^(1)),$L(^(1)) S ORV=ORV+1,ORVAR(ORV)=ORVAR
 I ORFUN="WORD"!(ORFUN="TEXT")!(ORFUN="TEXTWRAP")!(ORFUN="TMPWRAP"),(@ORVAR="WORD")!(@ORVAR="TEXT") S @ORVAR="^ORD(100.22,"_+ORPT_",2)"
 S ORTL=$S(ORVAR="ORFREE":"",$P(OROJ,"^")="NONE":"",$P(OROJ,"^")]"":$P(OROJ,"^"),1:ORDEF),ORPRM=""""_$P(OROJ,"^",3)_"""",ORTL=""""_ORTL_""""
 I $P(OROJ,"^",4),$L(ORVAR),ORVAR'="ORFREE" S ORTL="$S($L($G("_ORVAR_")):"_ORTL_",1:"""")"
 S ^ORD(100.23,ORFMT,2,ORAN,0)="W"_$S(ORVAR["ORTX":":$L($G("_ORVAR_")) ",1:" ")_$S(ORFL:"!",1:"")_"?"_(ORCL-1)_","_ORTL_","_$S(ORVAR="ORFREE":""""_$P(OROJ,"^",2)_"""",$L(ORFUN):"$$"_ORFUN_"^ORU($G("_ORVAR_"),"_ORPRM_")",1:"$G("_ORVAR_")")
 S ORAN=ORAN+1,ORFL=0
 Q
PRINT(FMT,NUM,TEST,SNUM,ORSCREEN) ;
 ;FMT=Format ptr in ^ORD(100.23,FMT
 ;NUM=# of times to print
 ;TEST=1 using test data
 ;$D(SNUM) Suppresses form feed
 ;ORSCREEN=Mumps code envoked when item is screened
 ;^TMP("ORP:",$J,... may be used by a print field
 Q:'$G(FMT)  Q:'$D(^ORD(100.23,FMT,0))
 N ORKI,ORK,X,ORTEST
 K ^TMP("ORP:",$J)
 S ORTEST=$G(TEST)
 S:'$D(NUM) NUM=1 S:'$D(TEST) TEST=0
 I 'TEST,$D(^ORD(100.23,FMT,3)),$L(^(3)) X ^(3) I '$T W:$E(IOST,1,2)="C-" !,"This item has been screened from printing." X:$L($G(ORSCREEN)) ORSCREEN H 2 Q
 F ORKI=1:1:NUM Q:$G(OREND)  D
 . I 'TEST S ORK=0 F  S ORK=$O(^ORD(100.23,FMT,1,ORK)) Q:ORK'>0  I $D(^(ORK,0)) S X=+^(0) D
 .. I $G(ORIFN),$D(^ORD(100.22,+X,0)),$P(^(0),"^",7),$P(^(0),"^",7)'=$P($G(^OR(100,ORIFN,0)),"^",14) Q
 .. I $D(^ORD(100.22,+X,1)),'$P(^(0),"^",6) X ^(1)
 . W:'$G(SNUM)!($E(IOST,1,2)="C-") @IOF W $C(13)
 . S ORK=0 F  S ORK=$O(^ORD(100.23,FMT,2,ORK)) Q:ORK'>0  X ^ORD(100.23,FMT,2,ORK,0) Q:$G(OREND)
 . K ^TMP("ORP:",$J)
 . I $G(SNUM),NUM>1 W @IOF
 I $P(^ORD(100.23,FMT,0),"^",5),$G(NUM)<2 W @IOF
 Q
RECMPL ;Recompile all print formats
 N IFN,ORK,X,ORFMT K ^TMP("OR",$J,"FMT")
 S IFN=0
 F  S IFN=$O(^ORD(100.23,IFN)) Q:IFN<1  S ORFMT=IFN D
 . S ORK=0 F  S ORK=$O(^ORD(100.22,ORK)) Q:ORK'>0  I $D(^(ORK,0)),$L($P(^(0),"^",4)) S @$P(^(0),"^",4)=$P(^(0),"^",3)
 . D CMPL
 . D CMPL^ORPR010(ORFMT)
 D OUT
 Q
TEST(FMT,ORIFN,OACTION,ORVP,LOC,GIOM) ;Test display of a print format
 Q:'$G(FMT)
 W @IOF
 N X,IOM,IOF,TEST,OREND,ORPDAD
 Q:'$D(^OR(100,$G(ORIFN),0))  S X=^(0)
 S:'$G(OACTION) OACTION=1
 S:'$D(ORVP) ORVP=$P(X,"^",2)
 S:'$D(LOC) LOC=+$P(X,"^",10)
 S:'$G(GIOM) GIOM=79
 S IOM=GIOM,IOF="!",TEST=0
 D PRINT(FMT)
 Q
22 ;Remove Print fields and Print format entries above #1000
 N Y,DIK,ORK,DA
 X ^%ZOSF("UCI") Q:Y="DEV,CUR"  Q:Y="OEX,ROX"
 S DIK="^ORD(100.22,"
 F ORK=1000:0 S ORK=$O(^ORD(100.22,ORK)) Q:ORK<1  S DA=ORK D ^DIK
 S DIK="^ORD(100.23,"
 F ORK=1000:0 S ORK=$O(^ORD(100.23,ORK)) Q:ORK<1  S DA=ORK D ^DIK
 Q
