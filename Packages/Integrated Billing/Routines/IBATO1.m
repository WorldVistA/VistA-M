IBATO1 ;LL/ELZ - TRANSFER PRICING REPORTS CONT. ; 18-DEC-98
 ;;2.0;INTEGRATED BILLING;**115,266,389**;21-MAR-94;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
PAGE() ; performs page reads and returns 1 if quiting is needed
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="E" D ^DIR
 Q $D(DIRUT)
NUM(X,X2,X3) ; calls to format numbers
 D COMMA^%DTC
 Q $E(X,1,$L(X)-1)
UNIT(IBA,IBD,IBO) ; sets IBD subscripted with units for IBA
 N IBX,IBB S IBB="UNIT"
 I $P(IBA(0),"^",12)["DGPM" D  Q
 . S IBD(1,IBO,IBB)=$$EX^IBATUTL(351.61,1.01,+IBA(1))
 I $P(IBA(0),"^",12)["PSRX(" D  Q
 . S IBD(1,IBO,IBB)=$$EX^IBATUTL(52,.01,+$P(IBA(0),"^",12))
 I $P(IBA(0),"^",12)["RMPR" D  Q
 . S IBD(1,IBO,IBB)="PROSTHETIC"
 S IBX=0 F  S IBX=$O(^IBAT(351.61,IBA,3,IBX)) Q:IBX<1  D
 . S IBX(0)=^IBAT(351.61,IBIEN,3,IBX,0)
 . S IBD(IBX,IBO,IBB)="CPT"_$P($$PROC^IBATUTL(+IBX(0)),U)
 Q
TYPE(IBA,IBO) ; sets IBO with descriptive trans type for IBA
 N IBB,IBC,IBD
 S:'$D(IBA(0)) IBA(0)=^IBAT(351.61,IBA,0)
 S IBB=$P(IBA(0),"^",12)
 I IBB["DGPM(" S IBO="INPATIENT" Q
 I IBB["PSRX(" S IBO="PHARMACY" Q
 I IBB["RMPR(660," S IBO="PROSTHETICS" Q
 D GETGEN^SDOE(+$P(IBA(0),"^",12),"IBC")
 D:$P($G(IBC(0)),"^",3) PARSE^SDOE(.IBC,"EXTERNAL","IBD")
 S IBO=$S($G(IBD(.03))="":"OUTPATINET",1:$E("OUT "_IBD(.03),1,10))
 Q
DES(IBA,IBD,IBO) ; sets IBD subscripted with description for IBA
 N IBX,IBB,IBDATE S IBB="UNIT DESCRIPTION"
 I $P(IBA(0),"^",12)["DGPM" D  Q
 . S IBD(1,IBO,IBB)=$E($$DRGTD^IBACSV(+IBA(1),$P(IBA(0),U,4)),1,18)
 I $P(IBA(0),"^",12)["PSRX(" D  Q
 . S IBD(1,IBO,IBB)=$E($$EX^IBATUTL(351.61,4.01,+IBA(4)),1,18)
 I $P(IBA(0),"^",12)["RMPR(660," D  Q
 . S IBD(1,IBO,IBB)=$E($P($$PIN^IBATUTL(+$P(IBA(0),"^",12)),U,2),1,18)
 S IBDATE=$P($G(^IBAT(351.61,IBIEN,0)),U,4) ; Event Date
 S IBX=0 F  S IBX=$O(^IBAT(351.61,IBA,3,IBX)) Q:IBX<1  D
 . S IBX(0)=^IBAT(351.61,IBIEN,3,IBX,0)
 . S IBD(IBX,IBO,IBB)=$E($P($$PROC^IBATUTL(+IBX(0),IBDATE),U,2),1,18)
 Q
PRICE(IBA,IBD,IBO) ; sets IBD subscripted with price for IBA
 N IBX,IBB S IBB="UNIT PRICE"
 I $P(IBA(0),"^",12)["DGPM" D  Q
 . S IBD(1,IBO,IBB)=$$NUM($P(IBA(1),"^",2),2,9)
 I $P(IBA(0),"^",12)["PSRX(" D  Q
 . S IBD(1,IBO,IBB)=$$NUM($P(IBA(4),"^",3),3,10)
 I $P(IBA(0),"^",12)["RMPR(660," D  Q
 . S IBD(1,IBO,IBB)=$$NUM($P(IBA(4),"^",5),3,10)
 S IBX=0 F  S IBX=$O(^IBAT(351.61,IBA,3,IBX)) Q:IBX<1  D
 . S IBX(0)=^IBAT(351.61,IBIEN,3,IBX,0)
 . S IBD(IBX,IBO,IBB)=$$NUM($P(IBX(0),"^",3),2,9)
 Q
QTY(IBA,IBD,IBO) ; sets IBD subscripted with quantity for IBA
 N IBX,IBB S IBB="QTY"
 I $P(IBA(0),"^",12)["DGPM" D  Q
 . S IBD(1,IBO,IBB)=$$NUM($P(IBA(1),"^",5),0,3)
 I $P(IBA(0),"^",12)["PSRX(" D  Q
 . S IBD(1,IBO,IBB)=$$NUM($P(IBA(4),"^",2),0,3)
 I $P(IBA(0),"^",12)["RMPR(660," D  Q
 . S IBD(1,IBO,IBB)=$$NUM(1,0,3)
 S IBX=0 F  S IBX=$O(^IBAT(351.61,IBA,3,IBX)) Q:IBX<1  D
 . S IBX(0)=^IBAT(351.61,IBIEN,3,IBX,0)
 . S IBD(IBX,IBO,IBB)=$$NUM($P(IBX(0),"^",2),0,3)
 Q
COPAY(IBA) ; compute copay for iba and return
 N IBC,IBT,IBCOPAY
 S IBCOPAY=$$COPAY^IBATUTL($P(IBA(0),"^",2),$P(IBA(0),"^",12),$P($P(IBA(0),"^",9),"."),$P($P(IBA(0),"^",10),"."))
 I IBCOPAY,$P(IBA(0),"^",12)["SCE(" S (IBC,IBT)=0 F  S IBT=$O(^IBAT(351.61,"AH",$P(IBA(0),"^",2),$P(IBA(0),"^",4),IBT)) Q:IBT<1  I $P(^IBAT(351.61,IBT,0),"^",12)["SCE(" S IBC=IBC+1
 I  S IBCOPAY=IBCOPAY/IBC
 Q $$NUM(IBCOPAY,2,7)
 ;
VAR(IBA) ; set up required variables
 N IBX
 F IBX=0,1,4 S IBA(IBX)=$G(^IBAT(351.61,IBA,IBX))
 Q
PRT(IBIEN) ; main entry for report printing
 ;
 N DFN,IBXDATA,IBC,IBF,IBF1,IBF2,IBO,VA,VAERR,IBM
 ;
 D VAR(.IBIEN)
 S DFN=$P(IBIEN(0),"^",2)
 I IBPAGE=0!($Y+5>IOSL)!(IBLAST'=$P(IBIEN(0),"^",11)) S IBLAST=$P(IBIEN(0),"^",11) D PRTH Q:IBQUIT
 W ! S IBC=0
 ;
 ; print single valued data first
 S IBF=0 F  S IBF=$O(IBFIELD(IBF)) Q:IBF<1  D
 . D PRTG(.IBFIELD,.IBF,.IBF1,.IBC)
 . X ^IBAT(351.62,IBF1,1)
 . W IBXDATA,?IBC
 ;
 ; compute multiple valued data
 S IBM=IBC
 S IBF=0 F  S IBF=$O(IBMUL(IBF)) Q:IBF<1  D
 . S IBF1=0,IBF1=$O(IBMUL(IBF,IBF1))
 . X ^IBAT(351.62,IBF1,1)
 ;
 ; print multiple valued data
 S IBF=0 F  S IBF=$O(IBXDATA(IBF)) Q:IBF=""  W:IBC'=IBM ! W ?IBM S IBC=IBM D
 . S IBO=0 F  S IBO=$O(IBXDATA(IBF,IBO)) Q:IBO<1  S IBF1=0 F  S IBF1=$O(IBXDATA(IBF,IBO,IBF1)) Q:IBF1=""  D
 .. S IBF2=0,IBF2=$O(^IBAT(351.62,"B",IBF1,IBF2))
 .. S IBF2=^IBAT(351.62,IBF2,0)
 .. S IBC=IBC+$P(IBF2,"^",2)+1
 .. I IBC>IOM W !?5 S IBC=$P(IBF2,"^",2)+6
 .. W IBXDATA(IBF,IBO,IBF1),?IBC
 ;
 ; clean up
 X ^IBAT(351.62,999,1)
 ;
 Q
EXPRT(IBIEN) ; main entry for excel printing
 ;
 N DFN,IBXDATA,IBF,IBF1,IBF2,IBO,VA,VAERR
 ;
 D VAR(.IBIEN)
 S DFN=$P(IBIEN(0),"^",2)
 ;
 ; do single if no multiple
 I '$D(IBMUL) D EXSING() W ! X ^IBAT(351.62,999,1) Q
 ;
 ; compute multiple valued data
 S IBF=0 F  S IBF=$O(IBMUL(IBF)) Q:IBF<1  D
 . S IBF1=0,IBF1=$O(IBMUL(IBF,IBF1))
 . X ^IBAT(351.62,IBF1,1)
 ;
 ; print multiple valued data
 S IBF=0 F  S IBF=$O(IBXDATA(IBF)) Q:IBF=""  D EXSING(IBF) D
 . S IBO=0 F  S IBO=$O(IBXDATA(IBF,IBO)) Q:IBO<1  S IBF1=0 F  S IBF1=$O(IBXDATA(IBF,IBO,IBF1)) Q:IBF1=""  D
 .. S IBF2=0,IBF2=$O(^IBAT(351.62,"B",IBF1,IBF2))
 .. S IBF2=^IBAT(351.62,IBF2,0)
 .. W $$STRIP(IBXDATA(IBF,IBO,IBF1),IBF2),"|"
 . W !
 ;
 ; clean up
 X ^IBAT(351.62,999,1)
 ;
 Q
STRIP(A,B) ; strips off junk from numbers
 Q $S($P(B,"^",5):+$TR(A,", "),1:A)
 ;
EXSING(IBF) ; print single valued data first
 S IBF=0 F  S IBF=$O(IBFIELD(IBF)) Q:IBF<1  D
 . D PRTG(.IBFIELD,.IBF,.IBF1,.IBC)
 . X ^IBAT(351.62,IBF1,1)
 . W $$STRIP(IBXDATA,IBF1(0)),"|"
 Q
 ;
PRTH ; header
 S IBC=0
 D HEAD^IBATO($P(IBIEN(0),"^",11)) Q:IBQUIT
 W !
 S IBF=0 F  S IBF=$O(IBFIELD(IBF)) Q:IBF<1  D
 . D PRTG(.IBFIELD,.IBF,.IBF1,.IBC)
 . W $P(IBF1(0),"^"),?IBC
 ;
 ; multiple part of header
 S IBF=0 F  S IBF=$O(IBMUL(IBF)) Q:IBF<1  D
 . D PRTG(.IBMUL,.IBF,.IBF1,.IBC)
 . W $P(IBF1(0),"^"),?IBC
 ;
 W ! F IBC=1:1:IOM W "-"
 Q
PRTG(X,Y,Z,C) ; general printing stuff
 S Z=0,Z=$O(X(Y,Z))
 S Z(0)=X(Y,Z)
 I $D(C) S C=C+$P(Z(0),"^",2)+1 I C>IOM W !?5 S C=$P(Z(0),"^",2)+6
 Q
SEL(B) ; selection of which fields B = default
 ; sets up variables IBFIELD and IBMUL
 ; returns max length of output
 ;
 N DTOUT,DUOUT,DIRUT,DIROUT,DIR,W,X,Y,Z,IBR,IBM
 S (IBR,IBM)=0
 ;
AGAIN S DIR(0)="LAO^1:98",DIR("A")="Which fields: "_$S($D(B):B_"//",1:"")
 S DIR("?")="Select what fields you want printed. Ranges must start with a valid number."
 D ^DIR Q:$D(DTOUT)!($D(DUOUT))!($D(DIROUT)) 0
 ;
 ; if default selected set Y
 S:Y="" Y=$G(B)
 ;
 ; validate input
 I '$D(^IBAT(351.62,"AC",+Y)) W *7,"??" G AGAIN
 F X=1:1 Q:$P(Y,",",X)=""  S:'$D(^IBAT(351.62,"AC",$P(Y,",",X))) Y=$P(Y,",",1,X-1)_","_$P(Y,",",X+1,98),X=X-1
 ;
 ; setup variables for output
 F X=1:1 Q:'$P(Y,",",X)  S W=+$P($Q(^IBAT(351.62,"AC",$P(Y,",",X))),",",4),Z=^IBAT(351.62,W,0),IBR=$S($P(Z,"^",3):"IBMUL",1:"IBFIELD"),@(IBR_"("_X_","_W_")")=Z,@IBR=$G(@IBR)+$P(Z,"^",2)+1
 ;
 Q $G(IBFIELD)+$G(IBMUL)
 ;
DISP ; displays fields for selection
 ;
 N IBX,IBL,IBI
 ;
 ; set up lines
 S (IBX,IBL)=0 F  S IBX=$O(^IBAT(351.62,"AC",IBX)),IBL=IBL+1 Q:IBX<1  S:IBX=40 IBL=1 S IBI=+$P($Q(^IBAT(351.62,"AC",IBX)),",",4),IBL(IBL,$S(IBX<40:0,1:40))=^IBAT(351.62,IBI,0)
 ;
 ; display lines
 W @IOF,!,"Select the fields you would like printed on this report, in the order you",!,"want them printed.  Fields with an asterisk (*) are fields that are multiples.",!
 S IBX="" F  S IBX=$O(IBL(IBX)) Q:IBX=""  W ! S IBI="" F  S IBI=$O(IBL(IBX,IBI)) Q:IBI=""  W ?IBI,$P(IBL(IBX,IBI),"^",4),?IBI+4,$S($P(IBL(IBX,IBI),"^",3):"*",1:""),$P(IBL(IBX,IBI),"^")
 ;
 W !
 ;
 Q
