LAKERM2 ;SLC/RWF/DLG - BUILD A KERMIT FILE TO SEND THRU LSI ;7/20/90  09:25 ;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;;Sep 27, 1994
 ;Call with X=data, LAKTYPE=record type, TSK=instrument #
 ;Files the records in ^LA(TSK,"O",n)
 Q
L1 S:'$D(LAKRM) LAKRM=94,LAKSEQ=0 S:LAKTYPE="S" LAKSEQ=0
 I LAKTYPE'="S" D POUND:X["#",QCTRL:X?.E1C.E
 F IX2=0:0 D L2 Q:X']""
 Q
L2 S LAKSPK=$C(LAKSEQ+32)_LAKTYPE_$E(X,1,+LAKRM),X=$E(X,LAKRM+1,299)
 D SPACK^LAKERMIT S LAKSEQ=LAKSEQ+1#64
 L ^LA(TSK) S O=^LA(TSK,"O")+1,^("O")=O,^("O",O)=LAKSPK L
 Q
POUND F I=2:1 S I=$F(X,"#",I) Q:I<1  S X=$E(X,1,I-2)_"#"_$E(X,I-1,999)
 Q
QCTRL F I=2:1 Q:I>$L(X)  I $A(X,I)<32 S X=$E(X,1,I-1)_"#"_$C($A(X,I)+32)_$E(X,I+1,999)
 Q
START ;A call is made to here once to do setup.
 S LAKTYPE="S",X="~} @-#N1" D L1
 Q
END ;At the end of data a call is made to here.
 S LAKTYPE="Z",X="" D L1 S LAKTYPE="B",X="" D L1,SEND L  G QUIT
 Q
SEND L ^LA(TSK,"P") Q:$S($D(^LA(TSK,"P")):$P(^("P"),"^",2),1:"QUIT")'="QUIT"  Q:'$D(^LA(TSK,"O",0))  Q:^LA(TSK,"O")'>^LA(TSK,"O",0)
 S ^LA(TSK,"P")="KERMIT^OUT",^("P3")=0,T=TSK L ^LA("Q") S Q=^LA("Q")+1,^("Q")=Q,^("Q",Q)=T L
 Q
DATA ;A call is made to here for each record in the load list.
 S LAKTYPE="D" D L1 Q
 Q
NEXT ;Finish old file start new.
 I LAKTYPE'="S" S LAKTYPE="Z" D L1
 S LAKTYPE="F",X="S "_LRFILE D L1
 Q
QUIT K C,CHKSUM,LAKRM,LAKSEQ,LAKSPK,LAKTYPE,X,O
 Q
