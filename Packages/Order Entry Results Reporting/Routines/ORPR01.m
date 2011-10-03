ORPR01 ; slc/dcm/rv - Some day my prints will come ;09/13/06  13:30
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**11,69,92,260**;Dec 17, 1997;Build 26
LBL ;Print Labels
 W !,"Print how many labels? 1// "
 R X:DTIME
 S:X="" X=1
 Q:X["^"
 I X'?1N.N!(X>10!(X<1)) W !,"Enter a number between 1 and 10" G LBL
 D P2("L",X)
 Q
LBL1(SNUM,ORTIMES) ;
 ;SNUM=1 to suppress form feed, passed to PRINT^ORPR00
 ;ORTIMES=# of copies
 N ORX,OR3,ORPK,ORTCNT,ORPKG
 D GET(ORIFN),R1(3,$G(ORTIMES))
 Q
CHT ;Print Chart copies
 I '$L(ORL) N OR4 S OR4="" D LOC^ORUTL I +$G(OREND) S OREND="" Q
 D P2("C")
 Q
WRK ;Print Work copies
 I '$L(ORL) N OR4 S OR4="" D LOC^ORUTL I +$G(OREND) S OREND="" Q
 D P2("W")
 Q
SRV ;Print Service copies
 D P2("S")
 Q
REQ ;Print Requisitions
 D P2("R")
 Q
REQ1(SNUM,ORSCREEN) ;
 ;SNUM=1 to suppress form feed, passed to PRINT^ORPR00
 N ORX,OR3,ORPK,ORTCNT,ORPKG
 D GET(ORIFN),R1(4,,$G(ORSCREEN))
 Q
R1(PIECE,ORTIMES,ORSCREEN) ;
 ;PIECE=4 for requisitions
 ;PIECE=3 for labels
 ;ORTIMES=# of copies
 ;ORSCREEN=Mumps screen to pass to PRINT^ORPR00
 N P,ORFMT,ORIGVIEW,ORDLG
 Q:'$G(PIECE)
 S P=$P(ORX,"^",14),ORDLG=+$P(ORX,"^",5)
 I 'P Q
 S ORIGVIEW=1,ORFMT=$$GET^XPAR("SYS",$S(PIECE=3:"ORPF WARD LABEL FORMAT",PIECE=4:"ORPF WARD REQUISITION FORMAT",1:""),P,"I")
 I PIECE=4,(P=$O(^DIC(9.4,"B","DIETETICS",0))),(ORDLG'=$O(^ORD(101.41,"B","FHW SPECIAL MEAL",0))) S ORFMT=0
 I ORFMT<1 W !?2,$C(7),"Cannot print",!?2,$S(PIECE=3:"Labels",PIECE=4:"Requisitions",1:"")_" not set up for orders in the "_$P(^DIC(9.4,P,0),"^")_" package." D READ^ORUTL Q
 D CPRINT(ORIFN,$G(ORTIMES),$G(ORSCREEN))
 Q
CPRINT(ORIFN,ORTIMES,ORSCREEN) ; Printit
 N X
 I +$G(ORFMT)'>0 Q
 I $G(ORTCNT) D
 . I $P($G(^ORD(100.23,ORFMT,0)),"^",4) S ORTCNT=ORTCNT\$P(^(0),"^",4)+1 Q
 . S ORTCNT=ORTCNT\75+1
 S X=($P(^ORD(100.23,ORFMT,0),"^",2)+$P($G(^OR(100,+ORIFN,2,0)),U,4))
 I '$G(ORFIRST1),($Y+X+$S($G(ORTCNT)>0:ORTCNT-1,1:0)>(ORIOSL-3)) D  Q:+$G(OREND)
 . I $G(ORFOOT) D FOOT(ORFOOT)
 . I $G(ORHEAD) D HEAD(ORHEAD)
 . I '$G(ORHEAD),'$G(ORFOOT) W @ORIOF
 D PRINT^ORPR00(ORFMT,$S($G(ORTIMES):ORTIMES,1:1),0,$G(SNUM),$G(ORSCREEN))
 Q
HEAD(FMT) ;
 Q:+$G(OREND)
 S IOF=ORIOF
 D PRINT^ORPR00(FMT,1)
 S IOF="!"
 Q
FOOT(FMT) ; Print Footer
 Q:+$G(OREND)
 S:IOF?1"!"."!" $P(IOF,"!",$S(ORIOSL>200:200,ORIOSL-$Y>1:ORIOSL-$Y,1:2))=""
 D PRINT^ORPR00(FMT,1)
 I $E(IOST)="C" D
 . N DIR
 . S DIR(0)="FO^1:1",DIR("A")="Press RETURN to continue or '^' to exit"
 . S DIR("?")="Enter '^' to quit present report or '^^' to quit to menu"
 . D ^DIR
 . I $S($D(DIROUT):1,$D(DUOUT):1,$D(DTOUT):1,1:0) S OREND=1
 S IOF=ORIOF
 Q
GET(ORIFN) ;Get stuff
 N I,ORTX,X
 S ORX=^OR(100,ORIFN,0),OR3=$G(^(3)),ORPK=$G(^(4)),ORPKG=$P(ORX,"^",14)
 S ORTCNT=0,I=0
 D TEXT^ORQ12(.ORTX,ORIFN) F  S I=$O(ORTX(I)) Q:I<1  S X=ORTX(I),ORTCNT=ORTCNT+$L(X)
 Q
P2(REPORT,ORTIMES) ;Sort 'n print
 ;REPORT=type of report (L=labels, R=requisitions, S=service copies,
 ;                       C=chart copies, W=work copies)
 ;ORTIMES=# of copies
 Q:'$L($G(REPORT))
 N NQUE
 S NQUE=$S(REPORT="S":1,1:""),REPORT=$S(REPORT="C":"1^^^^",REPORT="L":"^1^^^",REPORT="R":"^^1^^",REPORT="S":"^^^1^",REPORT="W":"^^^^1",1:"")
 Q:'$L(REPORT)
 I '$G(ORNMBR) S ORNMBR=$$ORDERS^ORCHART("jive") I 'ORNMBR S VALMBCK="" Q
 Q:'$O(^TMP("OR",$J,"CURRENT","IDX",0))
 N ORAL,ORIFN,ORSEQ,OACTION,ORIDX
 K ^TMP("OREPRINT",$J)
 D FULL^VALM1
 S VALMBCK="R"
 F ORIDX=1:1:($L(ORNMBR,",")-1) S ORSEQ=$P(ORNMBR,",",ORIDX) Q:+$G(OREND)  D
 . I +ORSEQ>0,$D(^TMP("OR",$J,"CURRENT","IDX",ORSEQ)) S ORIFN=+^TMP("OR",$J,"CURRENT","IDX",ORSEQ),OACTION=$P($P(^(ORSEQ),"^"),";",2),^TMP("OREPRINT",$J,ORIDX)=ORIFN_";"_OACTION
 I $O(^TMP("OREPRINT",$J,0)) D PRINT^ORPR02(ORVP,"^TMP(""OREPRINT"",$J)",,ORL,REPORT,"1^^^^1^1^1",NQUE,$G(ORTIMES))
 K ^TMP("OREPRINT",$J)
 Q
