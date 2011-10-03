ORX4 ; SLC/MKB - OE/RR Orders file extract utilities ;9/30/97  14:58
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
VALUE(IFN,ID,INST,FORMAT) ; -- Returns value of prompt by ID
 I '$G(IFN)!('$D(^OR(100,+$G(IFN),0)))!($G(ID)="") Q ""
 N I,Y S I=0,Y="" S:'$G(INST) INST=1
 F  S I=$O(^OR(100,+IFN,4.5,"ID",ID,I)) Q:I'>0  I $P($G(^OR(100,+IFN,4.5,+I,0)),U,3)=INST S PRMT=+$P(^(0),U,2),Y=$G(^(1)) Q
 I $L(Y),$G(PRMT),$G(FORMAT)="E" D  ; get external form of Y
 . N ORDIALOG S ORDIALOG(PRMT,0)=$G(^ORD(101.41,PRMT,1))
 . S ORDIALOG(PRMT,1)=Y,Y=$$EXT^ORCD(PRMT,1)
 Q Y
