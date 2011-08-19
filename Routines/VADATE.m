VADATE ;ALB/MLI - GENERIC DATE ROUTINE ; 1 DEC 88 @1000
 ;;5.3;Registration,;**749**;Aug 13, 1993;Build 10
 ;
 I $D(VADAT("F")),$S(VADAT("F")<1:1,VADAT("F")>2:1,1:0) K VADAT("F")
 I '$D(VADAT("W")) S VANOW=$$NOW^XLFDT
 S VA=$S('$D(VADAT("W")):VANOW,1:VADAT("W")),(VA,VADATE("I"))=$S($D(VADAT("S")):VA,'$D(VADAT("T")):$E(VA,1,12),1:$P(VA,".",1))
 S:'$D(VADAT("H")) (VA(1),VA(2),VA(3))=1 I $D(VADAT("H")) F I=1:1:3 S VA(I)=$S(VADAT("H")[I:1,1:0)
 S VAM=$S('$E(VA,4,5):"",'VA(2):"",$S('$D(VADAT("F")):1,VADAT("F")=2:1,1:0):$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",+$E(VA,4,5)),1:$E(VA,4,5)),VAY=$S(VA(3):(1700+$E(VA,1,3)),1:""),VAD=$S(VA(1)&$E(VA,6,7):$E(VA,6,7),1:"")
 I $P(VA,".",2)]"" S VA=$P(VA,".",2),VAT=$E(VA_"000000",1,2)_":"_$E(VA_"000000",3,4) S:$D(VADAT("S")) VAT=VAT_":"_$E(VA_"000000",5,6)
 I '$D(VADAT("F")) S VADATE("E")=VAM_$S(VAM]""&(VAD!VAY):" ",1:"")_$S(VAD:$J(+VAD,2),1:"")_$S(VAD&VAY:",",1:"")_VAY_$S($D(VAT):"@"_VAT,1:"") G QUIT
 S VADEL=$S('$D(VADAT("D")):"-",1:VADAT("D")) I VADAT("F")=1 S VADATE("E")=$S('VA(2):"",VAM]"":VAM,1:"00")_$S(VA(1)&VA(2):VADEL,1:"")_$S('VA(1):"",VAD]"":VAD,1:"00")_$S((VA(1)!VA(2))&VA(3):VADEL,1:"")
 I VADAT("F")=2 S VADATE("E")=$S('VA(1):"",VAD]"":VAD,1:"00")_$S(VA(1)&VA(2):VADEL,1:"")_$S('VA(2):"",VAM]"":VAM,1:"XXX")_$S((VA(1)!VA(2))&VA(3):VADEL,1:"")
 S VADATE("E")=VADATE("E")_$S(VA(3):$E(VAY,3,4),1:"")_$S($D(VAT):"@"_VAT,1:"")
QUIT I $D(VADAT("J")),VADAT("J")?.N F I=$L(VADATE("E"))+1:1:VADAT("J") S VADATE("E")=" "_VADATE("E")
 K %DT,VA,VAD,VADEL,VAM,VAT,VAX,VAY,VANOW Q
KVAR K VADAT,VADATE Q
