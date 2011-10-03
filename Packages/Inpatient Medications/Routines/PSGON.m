PSGON ;BIR/CML3-SELECT ORDERS ; 16 Dec 98 / 10:08 AM
 ;;5.0; INPATIENT MEDICATIONS ;**2,22,54**;16 DEC 97
ENCHK ;
 K PSGODDD S PSGODDD=1,PSGODDD(1)="" W:X="-" "  (ALL)" I X="ALL"!(X="-") S X="1-"_PSGLMT
 E  S:$E(X)="-" X=1_X S:$E(X,$L(X))="-" X=X_PSGLMT
 F Q=1:1:$L(X,",") S X1=$P(X,",",Q) D SET Q:'$D(X)
 Q
 ;
SET ;
 I $S(X1>PSGLMT:1,X1<1:1,X1?.N:0,1:X1'?1.N1"-"1.N) K X Q
 I X1'["-" S X2=X1 G SET1
 F X2=$P(X1,"-"):1:$P(X1,"-",2) D SET1 Q:'$D(X)
 Q
 ;
SET1 ;
 S X2=+X2 I $S(X2<1:1,X2>PSGLMT:1,$D(PSGEFN):'$D(PSGEFN(X2)),1:0) K X Q
 I PSGODDD(PSGODDD) F QQ=+$G(PSGOESF):1:PSGODDD I ","_$G(PSGODDD(QQ))[(","_X2_",") Q
 I  Q
 I $L(PSGODDD(PSGODDD))+$L(X2)>244 S PSGODDD=PSGODDD+1,PSGODDD(PSGODDD)=""
 S PSGODDD(PSGODDD)=PSGODDD(PSGODDD)_X2_"," ;Q
 Q
 ;
ENASR ; action/select read
 ;S ACTION=$S($D(PSGPRF):0,PSGONC:1,PSGONV:1,$G(PSGONF):1,1:PSGONR>0)
 S ACTION=0
RD1 ;W !!,$S($D(PSGPRF):"View",1:"Select"),$S(ACTION:" ACTION or",1:"")," ORDER",$S(PSGLMT>1:"S (1-"_PSGLMT,1:" (1"),"): " R X:DTIME W:'$T $C(7) S:'$T X="^" I "^"[X K ACTION Q
 W !!,$S($D(PSGPRF):"View",1:"Select"),$S(ACTION:" ACTION or",1:"")," ORDER",$S(PSGLMT>1:"S (1-"_PSGLMT,1:" (1"),"): " R X:DTIME W:'$T $C(7) S:'$T X="^" I X["^" K ACTION S X="^" Q
 I X="" K ACTION Q
 I X="DC",ACTION,PSGONC W "  (DISCONTINUE)" S X="D" Q
 I X="DC" W $C(7),"  ??" G RD1
 I $P("DISCONTINUE",X)="",ACTION,PSGONC W $P("DISCONTINUE",X,2) S X="D" Q
 I $P("DISCONTINUE",X)="" W $C(7),"  ??" G RD1
 I $P("RENEW",X)="",ACTION,PSGONR W $P("RENEW",X,2) S X="R" Q
 I $P("RENEW",X)="" W $C(7),"  ??" G RD1
 I $P("VERIFY",X)="",ACTION,PSGONV W $P("VERIFY",X,2) S X="V" Q
 I $P("VERIFY",X)="" W $C(7),"  ??" G RD1
 I $P("FINISH",X)="",ACTION,$G(PSGONF) W $P("FINISH",X,2) S X="F" Q
 I $P("FINISH",X)="" W $C(7)," ??" G RD1
 I $S(X="ALL":1,X["-":1,1:X) D ENCHK Q:$D(X)  W $C(7),"  ??" G RD1
 I X?1."?" D H1 G RD1
 W $C(7),"  ??" G RD1
 ;
H1 ;
 D FULL^VALM1 W !!?2 I ACTION  D
 .W "Select ACTION to take on order",$E("s",PSGONR>1!(PSGONC>1)!(PSGONV>1)!($G(PSGONF)>1)),!,". Select -",! W:PSGONC ?9,"D for DISCONTINUE",! W:PSGONR ?9,"R for RENEW",! W:PSGONV ?9,"V for VERIFY",! W:$G(PSGONF) ?9,"F for FINISH",!
 W !,"Select ORDER",$S(PSGLMT>1:"S (1-"_PSGLMT,1:" (1"),") to view",$S('$D(PSGPRF):" and/or on which to take action",1:""),"." D:X?2."?" H2
 N DIR S DIR(0)="E" D ^DIR I $D(VALM("LINES")) D RE^VALM4
 Q
 ;
ENWO ; which orders
 S PSGLMT=$S(PSGONW="R":PSGONR,PSGONW="V":PSGONV,1:PSGONC)
RDW ;
 W !!,$S(PSGONW="V":"VERIFY which orders",PSGONW="R":$S($P(PSJSYSP0,"^",3):"RENEW which orders",1:"MARK which orders for RENEWAL"),1:$S($P(PSJSYSP0,"^",5):"DISCONTINUE which orders",1:"MARK which orders for DISCONTINUATION"))," (1-",PSGLMT,"): "
 R X:DTIME W:'$T $C(7) S:'$T X="^" I "^"[X Q
 I X?1."?" W !!?2,"Select order",$E("s",PSGLMT>1)," to ",$S(PSGONW="V":"verify",PSGONW="R":$S($P(PSJSYSP0,"^",3):"renew.",1:"mark for renewal."),1:$S($P(PSJSYSP0,"^",5):"discontinue.",1:"mark for discontinuation.")) D:X?2."?" H2 G RDW
 D ENCHK I '$D(X) W $C(7),"  ??" G RDW
 Q
 ;
H2 ;
 N X S X=$S($D(PSGEFN):"field",1:"order") W !!?2,"Select ",X,"s either singularly separated by commas (1,2,3), by a range of",!,X,"s separated by a dash (1-3), or a combination (1,2,4-6).  To select all"
 W !,X,"s, enter 'ALL' or a dash ('-').  You can also enter '-n' to select the"
 W !,"first ",X," through the 'nth' ",X," or enter 'n-' to select the 'nth' ",X,!,"through the last ",X,".  If an ",X," is selected more than once, only the first",!,"selection is used (Entering '1,2,1' would return '1,2'.)."
 W:$D(PSGEFN) !!,?2,"Fields numbers are as follows:"
 I '$D(P("PON")) D
 .Q:'$D(PSGEFN)
 .N PS S PS=$S($G(PSJORD)["P":1,$G(PSJORD)["U":2,1:2)
 .W !?3,"*(1) Orderable Item",!,?3,$S(PS=1:" ",PS=2:"*"),"(2) Dosage Ordered"
 .W !?3,$S(PS=1:" ",PS=2:"*"),"(3) Start",!?3,"*(4) Med Route",!?3,$S(PS=1:" ",PS=2:"*"),"(5) Stop"
 .W !?3," (6) Schedule Type",!?3," (7) Self Med",!?3,"*(8) Schedule"
 .W !?3," (9) Admin Times",!?3,"*(10) Provider",!?3," (11) Special "
 .W "Instructions",!?3," (12) Dispense Drug"
 E  D
 .Q:'$D(PSGEFN)
 .N PS S PS=$S($G(PSJORD)["P":1,$G(PSJORD)["V":2,1:2)
 .W !?3,$S($G(P("OT"))="F":"*",PS=1:" ",PS=2:"*"),"(1) Additives",!?3,$S($G(P("OT"))="F":"*",P(4)="P":" ",PS=1:" ",PS=2:"*"),"(2) Solutions",!?3,$S(P(4)="P":" ",PS=1:" ",PS=2:"*"),"(3) Infusion Rate"
 .W !?3,$S(PS=1:" ",PS=2:"*"),"(4) Start",!?3,"*(5) Med Route",!?3,$S(PS=1:" ",PS=2:"*"),"(6) Stop"
 .W !?3,"*(7) Schedule",!?3," (8) Admin Times",!?3,"*(9) Provider"
 .I $G(P(4))="P"!($G(P("DTYP"))=0) D
 ..W !?3,"*(10) Orderable Item",!?3," (11) Other Print",!?3," (12) Remarks"
 .E  W !?3," (10) Other Print",!?3," (11) Remarks"
 W ! K DIR S DIR(0)="E" D ^DIR K DIR
 Q
 ;
ENEFA ;
 N Q,X1,X2 I '$D(PSGEFN) K Y S Y="" Q
 ;
EFA ;
 K Y S Y="" R !!,"Select FIELDS TO EDIT: ",X:DTIME E  W $C(7) S X="^" Q
 I "^"[X Q
 ;I X?1."?" D:$D(P("PON")) H2,@("DISPLAY^PSJLIFN") D:'$D(P("PON")) FULL^VALM1,EFH G EFA
 I X="??"&('$D(P("PON"))) D FULL^VALM1,H2 G EFA
 I X?1."?" D FULL^VALM1 D:'$D(P("PON")) EFH D:$D(P("PON")) H2,@("DISPLAY^PSJLIFN") G EFA
 ;* I X?1."?" D EFH D:X?2."?" H2,READ^PSJUTL,@($S('$D(PSJDTYP):"ENW^PSGOEEW",PSJDTYP="OU":"ENW^PSJOEEW",PSJDTYP="O":"^PSIVORV1",1:"EN^PSIVORV2")) G EFA
 I X="-"!($P("ALL",X)="") W $S(X="-":"  (ALL)",1:$P("ALL",X,2)) F Q=0:0 S Q=$O(PSGEFN(Q)) Q:'Q  S Y=Y_Q_","
 I  G FDONE
 S:$E(X)="-" X=+PSGEFN_X S:$E($L(X))="-" X=X_$P(PSGEFN,":",2)
 F Q=1:1:$L(X,",") S X1=$P(X,",",Q) D FS Q:'$D(X)
 I '$D(X) W $C(7),"  ??" G EFA
 ;
FDONE ;
 I '$D(Y) W $C(7)," ??" G EFA
 S:Y Y=$E(Y,1,$L(Y)-1) Q
 ;
FS ;
 I $S(X1?1.N1"-"1.N:0,X1'?1.N:1,'$D(PSGEFN(X1)):1,1:","_Y[X1) K X Q
 I X1'["-" S Y=Y_X1_"," Q
 S X2=+X1,Y=Y_X2_"," F  S X2=$O(PSGEFN(X2)) K:$S(X="":1,","_Y[X2:1,1:X2>$P(X1,"-",2)) Y Q:'$D(Y)  S Y=Y_X2_"," Q:X2=$P(X1,"-",2)
 Q
ENEFA2 ;
 I '$D(PSGEFN) K Y S Y="" Q
 S Y=$P(XQORNOD(0),"=",2)
 ; wasn't handling "0#" correctly, will strip off a leading zero on 1-9
 N Q,X1 F Q=1:1:$L(Y,",") S X1=$P(Y,",",Q) D
 .I X1?1"0"1.2N S $P(Y,",",Q)=+X1
 Q
 ;
EFH ;
 W !!?2,"Select the fields you wish to edit, by number.  Only those fields with a",!,"number to the left of the field name are editable."
 Q
