ORU4 ; slc/dcm - Silent utilities/functions ;12/7/00  13:10
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**11,92**;Dec 17, 1997
 ;Silent versions of functions found in ^ORU
TIME(X,FMT,ORHOOT,ORCL,GCNT,CCNT) ;
 Q $$TIME^ORU($G(X),$G(FMT))
DATE(X,FMT,ORHOOT,ORCL,GCNT,CCNT) ;
 Q $$DATE^ORU($G(X),$G(FMT))
DATETIME(X,FMT,ORHOOT,ORCL,GCNT,CCNT) ;
 Q $$DATETIME^ORU($G(X),$G(FMT))
NAME(X,FMT,ORHOOT,ORCL,GCNT,CCNT) ;
 Q $$NAME^ORU($G(X),$G(FMT))
SSN(X,FMT,ORHOOT,ORCL,GCNT,CCNT) ;
 Q $$SSN^ORU($G(X),$G(FMT))
AGE(X,FMT,ORHOOT,ORCL,GCNT,CCNT) ;
 Q $$AGE^ORU($G(X),$G(FMT))
DOB(X,FMT,ORHOOT,ORCL,GCNT,CCNT) ;
 Q $$DOB^ORU($G(X),$G(FMT))
WORD(OROOT,FMT,ORHOOT,ORCL,GCNT,CCNT) ; Call with X=Word Processing array root, FMT=Wrap Width
 I '$L($G(OROOT)) Q ""
 S:'$G(FMT) FMT=80
 N X,DIWL,DIWF,ORI
 S ORI=0,CCNT=CCNT+1
 F  S ORI=$O(@OROOT@(ORI)) Q:ORI'>0  S X=@OROOT@(ORI,0) S @ORHOOT@(GCNT,0)=$S($D(@ORHOOT@(GCNT,0)):@ORHOOT@(GCNT,0),1:"")_X D:$O(@OROOT@(ORI)) LN
 Q ""
TEXT(OROOT,FMT,ORHOOT,ORCL,GCNT,CCNT) ;Get text unformatted
 I '$L($G(OROOT)) Q ""
 S:'$G(FMT) FMT=80
 S:'$G(ORCL) ORCL=0
 S:'$G(CCNT) CCNT=0
 S:'$G(GCNT) GCNT=1
 N X,ORI,ORTX,ORINDX
 S ORINDX=1,ORI=0,CCNT=CCNT+1
 F  S ORI=$O(@OROOT@(ORI)) Q:ORI'>0  S X=@OROOT@(ORI,0),X=$$FMT^ORPRS09(FMT,ORINDX,X)
 F ORI=0:0 S ORI=$O(ORTX(ORI)) Q:'ORI  S @ORHOOT@(GCNT,0)=$S($D(@ORHOOT@(GCNT,0)):@ORHOOT@(GCNT,0),1:"")_$$S(ORCL,CCNT,ORTX(ORI),.CCNT) D:$O(ORTX(ORI)) LN
 I $G(ORPDAD),$D(ORIFN) D PRT1(ORIFN,OACTION,1,FMT,ORHOOT,.GCNT,.CCNT)
 Q ""
TMPWRAP(OROOT,FMT,ORHOOT,ORCL,GCNT,CCNT) ;Get text formatted
 I '$L($G(OROOT)) Q ""
 S:'$G(FMT) FMT=80
 S:'$G(ORCL) ORCL=0
 S:'$G(CCNT) CCNT=1
 S:'$G(GCNT) GCNT=1
 N X,ORI,ORTX,ORINDX
 S (ORI,ORINDX)=0,CCNT=CCNT+1
 F  S ORI=$O(@OROOT@(ORI)) Q:ORI'>0  S X=$S($L($G(@OROOT@(ORI))):@OROOT@(ORI),$L($G(@OROOT@(ORI,0))):@OROOT@(0),1:""),ORINDX=ORINDX+1,X=$$FMT^ORPRS09(FMT,ORINDX,X)
 F ORI=0:0 S ORI=$O(ORTX(ORI)) Q:'ORI  S @ORHOOT@(GCNT,0)=$S($D(@ORHOOT@(GCNT,0)):@ORHOOT@(GCNT,0),1:"")_$$S(ORCL,CCNT,ORTX(ORI),.CCNT) D:$O(ORTX(ORI)) LN
 I $G(ORPDAD),$D(ORIFN) D PRT1(ORIFN,OACTION,1,FMT,ORHOOT,.GCNT,.CCNT) K ORPDAD ;ORPDAD set by print code
 Q ""
S(X,Y,Z,CCNT) ;Pad over
 ;X=Where to begin placing text; similar to Column # in W ?CL
 ;Y=Current position in string ; similar to $X
 ;Z=Text to be added to string
 ;SP=Return value of formatted text
 ;CCNT=Line position after text is added; call by value
 ;     Initialize and cleanup CCNT before making call
 ;     Multiple calls to $$S pass CCNT as 2nd parameter (Y)
 I '$D(Z) Q ""
 N SP
 S SP=Z I X,Y,X>Y S SP=$E("                                                                                           ",1,X-Y)_Z
 S CCNT=$$INC(CCNT,SP)
 Q SP
INC(X,Y) ;Character position count
 ;X=Current count
 ;Y=Text
 N INC
 S INC=X+$L(Y)
 Q INC
LN ;Increment the array counter & set node position=1
 ;GCNT=Global node counter)
 ;CCNT=Text position on global node
 S GCNT=GCNT+1,CCNT=1
 Q
LINE(OROOT,GIOM) ;Add a blank line to the array
 N X
 S:'$G(GIOM) GIOM=80
 D LN S X="",$P(X," ",GIOM)="",@OROOT@(GCNT,0)=X
 Q
PRT1(ORIFN,OACTION,ORDAD,LENGTH,ORHOOT,GCNT,CCNT) ;For kids sake
 ;ORIFN=Internal order # of parent order
 ;OACTION=Action
 ;LENGTH=column width length
 N ORCHLD,OREND,I
 S (OREND,ORCHLD)=0
 F  S ORCHLD=$O(^OR(100,ORIFN,2,ORCHLD)) Q:ORCHLD<1  D ONE(ORCHLD,OACTION,ORDAD,"         ",$G(LENGTH),ORHOOT,.GCNT,CCNT)
 Q
ONE(ORIFN,OACTION,ORDAD,ORSEQ,LENGTH,OROOT,GCNT,CCNT) ;Single line format
 N ORTX,OREL,ORSTS,ORASTS,ORSTRT,ORSTOP,I,Z,X3,X0
 Q:'$D(^OR(100,ORIFN,3))  S X3=^(3),X0=^(0)
 S ORSEQ=$G(ORSEQ),ORSTS=$P(X3,"^",3),ORSTRT=$P(X0,"^",8),ORSTOP=$P(X0,"^",9),OREL=$S(ORSTS=11:1,1:"")
 S:'$G(LENGTH) LENGTH=45
 I $G(OACTION),$D(^OR(100,ORIFN,8,OACTION,0)) S ORASTS=$P(^(0),"^",15)
 D LN
 S @OROOT@(GCNT,0)=ORSEQ_$S($L(ORSEQ)=1:" ",1:"")_$S($G(ORASTS)!(ORSTS):" "_$P(^ORD(100.01,$S($G(ORASTS):ORASTS,1:ORSTS),.1),"^"),1:" ")
 D TEXT^ORQ12(.ORTX,$S($G(OACTION):ORIFN_";"_OACTION,1:ORIFN),LENGTH)
 F I=0:0 S I=$O(ORTX(I)) Q:'I  D:I>1 LINE(OROOT) S @OROOT@(GCNT,0)=@OROOT@(GCNT,0)_$$S(14,CCNT,ORTX(I),.CCNT)
 S Z=$S($D(ORDAD):$S(ORDAD:2,1:1),1:1)
 I Z=2 S ORSTRT=$$FMTE^XLFDT(ORSTRT,"2M"),ORSTOP=$$FMTE^XLFDT(ORSTOP,"2M") D
 . I (CCNT+9+$L(ORSTRT)+$S($L(ORSTOP):$L(ORSTOP)+8,1:0))>(LENGTH+14) D LN S @OROOT@(GCNT,0)=$$S(14,CCNT,"",.CCNT)
 . S @OROOT@(GCNT,0)=$$S(14,CCNT,"  Start: "_ORSTRT,.CCNT)
 . I $L(ORSTOP) S @OROOT@(GCNT,0)=@OROOT@(GCNT,0)_$$S(CCNT,CCNT,"  Stop: "_ORSTOP,.CCNT)
 Q
