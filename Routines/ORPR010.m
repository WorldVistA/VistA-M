ORPR010 ; slc/dcm - Silence of the prints
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**11,99**;Dec 17, 1997
GET(ORHOOT,FMT,ORIFN,OACTION,ORVP,LOC,GIOM,DISP) ;Get display of a print format
 Q:'$G(FMT)
 I $G(DISP) W @IOF
 N X,IOM,IOF,TEST,OREND,ORPDAD
 Q:'$D(^OR(100,$G(ORIFN),0))  S X=^(0)
 S:'$G(OACTION) OACTION=1
 S:'$D(ORVP) ORVP=$P(X,"^",2)
 S:'$D(LOC) LOC=+$P(X,"^",10)
 S:'$G(GIOM) GIOM=79
 S IOM=GIOM,IOF="!",TEST=0
 I $G(DISP) D PRINT^ORPR00(FMT)
 N GCNT,CCNT
 S GCNT=1,CCNT=0
 D SHUSH(FMT,.ORHOOT,,.GCNT)
 Q
SHUSH(FMT,ORHOOT,NUM,GCNT) ;
 ;FMT=Format ptr in ^ORD(100.23,FMT
 ;NUM=# of times to print
 ;^TMP("ORP:"_$J,... may be used by a print field
 Q:'$G(FMT)  Q:'$D(^ORD(100.23,FMT,0))  Q:'$L($G(ORHOOT))
 N ORKI,ORK,X,ORTEST,OREND,ORPDAD,ORSILENT
 S ORSILENT=1 ;ORSILENT tells print utility not to display
 K ^TMP("ORP:"_$J)
 S OREND=0
 S:'$D(NUM) NUM=1
 I $D(^ORD(100.23,FMT,3)),$L(^(3)) X ^(3) I '$T Q  ;Screen check!
 F ORKI=1:1:NUM Q:OREND  D
 . S ORK=0 F  S ORK=$O(^ORD(100.23,FMT,1,ORK)) Q:ORK'>0  I $D(^(ORK,0)) S X=+^(0) D
 .. I $G(ORIFN),$D(^ORD(100.22,+X,0)),$P(^(0),"^",7),$P(^(0),"^",7)'=$P($G(^OR(100,ORIFN,0)),"^",14) Q
 .. I $D(^ORD(100.22,+X,1)),'$P(^(0),"^",6) X ^(1)
 . S ORK=0 F  S ORK=$O(^ORD(100.23,FMT,4,ORK)) Q:ORK'>0  X ^ORD(100.23,FMT,4,ORK,0) Q:OREND  I $G(ORPICKUP) D  K ORPICKUP
 .. S I=0 F  S I=$O(@Y@(I)) Q:'I  D LN^ORU4 S @ORHOOT@(GCNT,0)=@Y@(I,0)
 . K ^TMP("ORP:"_$J)
 Q
CMPL(ORFMT) ;Compile Silent formatting code
 N ORROW,ORFL,ORK,OROUT,ORV,ORVAR,OROJ,ORCL,ORPT,I,X,CCNT,GCNT,ORPDAD
 Q:'$G(ORFMT)  Q:'$D(^ORD(100.23,ORFMT,0))  S ORROW=$S($P(^(0),"^",2):$P(^(0),"^",2),1:6)
 S ORK=0 F  S ORK=$O(^ORD(100.22,ORK)) Q:ORK'>0  I $D(^(ORK,0)),$L($P(^(0),"^",4)) S @$P(^(0),"^",4)=$P(^(0),"^",3)
 K ^ORD(100.23,ORFMT,4)
 S (CCNT,GCNT,ORFL,ORK,ORV)=0,OROUT="^ORD(100.23,ORFMT,4)"
 F  S ORK=$O(^ORD(100.23,ORFMT,1,ORK)) Q:ORK'>0  I $D(^(ORK,0)) S X=^(0) D
 . S ^TMP("OR",$J,"FMT",+$P(X,"^",2),+$P(X,"^",3),$P(X,"^"))=$P(X,"^",4,7)
 F ORK=1:1:ORROW S:ORK>1 ORFL=1 D
 . I '$D(^TMP("OR",$J,"FMT",ORK)) D LN^ORU4 S @OROUT@(GCNT,0)="D LN^ORU4" Q
 . S ORCL=0 F  S ORCL=$O(^TMP("OR",$J,"FMT",ORK,ORCL)) Q:ORCL'>0  S ORPT=$O(^(ORCL,"")),OROJ=^(ORPT) D STUF
 I $O(ORVAR(0)) S I=0,X="X" D
 . F  S I=$O(ORVAR(I)) Q:I<1  S X=X_","_ORVAR(I)
 . D LN^ORU4 S @OROUT@(GCNT,0)="K "_X
 S @OROUT@(0)="^^"_GCNT_"^"_GCNT_"^"_DT
 S ORK=0 F  S ORK=$O(^ORD(100.22,ORK)) Q:ORK'>0  I $D(^(ORK,0)),$L($P(^(0),"^",4)) K @$P(^(0),"^",4)
 K ^TMP("OR",$J,"FMT")
 Q
STUF ;
 I $P(^ORD(100.22,+ORPT,0),"^",6),$D(^(1)),$L(^(1)) D LN^ORU4 S @OROUT@(GCNT,0)=^ORD(100.22,+ORPT,1) Q  ;Direct execute (not compiled)
 N ORDEF,ORFUN,ORTL,ORPRM,X,X1
 S ORVAR="DT",ORDEF=""
 S:$D(^ORD(100.22,+ORPT,0)) ORVAR=$P(^(0),"^",4),ORDEF=$P(^(0),"^",2),ORFUN=$P(^(0),"^",5)
 I $D(^(1)),$L(^(1)) S ORV=ORV+1,ORVAR(ORV)=ORVAR
 S ORTL=$S(ORVAR="ORFREE":"",$P(OROJ,"^")="NONE":"",$P(OROJ,"^")]"":$P(OROJ,"^"),1:ORDEF),ORPRM=""""_$P(OROJ,"^",3)_"""",ORTL=""""_ORTL_""""
 I $P(OROJ,"^",4),$L(ORVAR),ORVAR'="ORFREE" S ORTL="$S($L($G("_ORVAR_")):"_ORTL_",1:"""")"
 I ORFL D LN^ORU4 S @OROUT@(GCNT,0)="D LN^ORU4"
 D LN^ORU4
 S @OROUT@(GCNT,0)="S:'$D(@ORHOOT@(GCNT,0)) @ORHOOT@(GCNT,0)="""""
 D LN^ORU4
 S @OROUT@(GCNT,0)="S X=$$S^ORU4("_(ORCL-1)_",.CCNT,"_ORTL_"_"_$S(ORVAR="ORFREE":""""_$P(OROJ,"^",2)_"""",$L(ORFUN):"$$"_ORFUN_"^ORU4($G("_ORVAR_"),"_ORPRM_",.ORHOOT,"_(ORCL-1)_",.GCNT,.CCNT)",1:"$G("_ORVAR_")")_",.CCNT)"
 D LN^ORU4
 S @OROUT@(GCNT,0)="I $D(@ORHOOT@(GCNT,0)),$D(X) S @ORHOOT@(GCNT,0)=@ORHOOT@(GCNT,0)_X"
 S ORFL=0
 Q
OUT(OROOT) ;Display output
 N I,X
 Q:'$D(OROOT)  Q:'$O(@OROOT@(0))
 F I=1:1 S X=$G(@OROOT@(I,0)) W !,X Q:'$O(@OROOT@(I))
 Q
TEST(IFN,DISP) ;Test
 Q:'IFN
 N FMT
 S FMT=0
 F  S FMT=$O(^ORD(100.23,FMT)) Q:'FMT  D
 . N DAVE S DAVE="DAVE"
 . W !,FMT,?15,$P(^ORD(100.23,FMT,0),"^")
 . D GET(.DAVE,FMT,IFN,1),OUT("DAVE"):$G(DISP)
 Q
