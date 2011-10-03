PSGPLXR ;BIR/MLM-EXECUTE PICK LIST XREFS ;28 FEB 96 / 2:45 PM
 ;;5.0; INPATIENT MEDICATIONS ;**5,126**;16 DEC 97
 ;
EN535(S1,ACT,XREF,FIELD,OLDV) ; Update "AC","AU" x-ref for 53.5 (PICK LIST FILE)
 S S2=0 D SETVAR F  S S2=$O(^PS(53.5,S1,1,S2)) Q:'S2  D EN5351(S1,S2,ACT,XREF,FIELD,OLDV)
 Q
 ;
EN5351(S1,S2,ACT,XREF,FIELD,OLDV) ; Update "AC","AU" x-refs for 53.51 (PATIENT MULTIPLE)
 N AT,PDD,ND,ON,PD,PL,PT,RB,ST,UP,UP1,WD,X D SETVAR S S3=$O(^PS(53.5,S1,1,S2,1,0))
 D SET
 Q:$S('PL:1,AT="":1,WD="":1,RB="":1,PT="":1,1:0)
 K:$D(^PS(53.5,XREF,PL,AT,WD,RB,PT,"NO ORDERS")) ^("NO ORDERS")
 I ACT="S",(XREF="AC"!UP1) S ^PS(53.5,XREF,PL,AT,WD,RB,PT,"NO ORDERS")="" Q:'S3
 S S3=0 F  S S3=$O(^PS(53.5,S1,1,S2,1,S3)) Q:'S3  D EN5352(S1,S2,S3,ACT,XREF,FIELD,OLDV)
 Q
 ;
EN5352(S1,S2,S3,ACT,XREF,FIELD,OLDV)   ; Update x-refs for 53.52 (ORDER MULTIPLE)
 N AT,PDD,ND,ON,PD,PL,PT,RB,ST,UP,UP1,WD,X D SETVAR
 S S4=0,S4=$O(^PS(53.5,S1,1,S2,1,S3,1,S4)) I S4="" D  Q
 .D SET
 .Q:$S('PL:1,AT="":1,WD="":1,PT="":1,ST="":1,PD="":1,1:0)
 .K:$D(^PS(53.5,XREF,PL,AT,WD,RB,PT,"NO ORDERS")) ^("NO ORDERS")
 .K:$D(^PS(53.5,XREF,PL,AT,WD,RB,PT,ST,PD,"NO DISPENSE DRUG")) ^("NO DISPENSE DRUG")
 .I ACT="S",(XREF="AC"!UP) S ^PS(53.5,XREF,PL,AT,WD,RB,PT,ST,PD,"NO DISPENSE DRUG")="" Q
 .I XREF="AC"!'UP K:$D(^PS(53.5,XREF,PL,AT,WD,RB,PT,ST,PD)) ^(PD)
 S S4=0 F  S S4=$O(^PS(53.5,S1,1,S2,1,S3,1,S4)) Q:'S4  D EN5353(S1,S2,S3,S4,ACT,XREF,FIELD,OLDV)
 Q
 ;
EN5353(S1,S2,S3,S4,ACT,XREF,FIELD,OLDV)   ; Update x-refs for 53.53 (DISPENSE DRUG MULTIPLE)
 N AT,PDD,ND,ON,PD,PL,PT,RB,ST,UP,UP1,WD,X D SETVAR
 D SET
 Q:$S('PL:1,AT="":1,WD="":1,PT="":1,ST="":1,PD="":1,PDD="":1,1:0)
 K:$D(^PS(53.5,XREF,PL,AT,WD,RB,PT,"NO ORDERS")) ^("NO ORDERS")
 I $D(^PS(53.5,XREF,PL,AT,WD,RB,PT,ST,PD,"NO DISPENSE DRUG")) K ^("NO DISPENSE DRUG")
 I ACT="S",(XREF="AC"!UP) S ^PS(53.5,XREF,PL,AT,WD,RB,PT,ST,PD,PDD)="" Q
 I XREF="AC"!'UP K:$D(^PS(53.5,XREF,PL,AT,WD,RB,PT,ST,PD,PDD)) ^(PDD)
 Q
 ;
SET ; Gather data needed to update "AC","AU" xref
 S ND=$G(^PS(53.5,+S1,0)),X=$G(^PS(53.5,S1,1,+S2,0)),PL=+ND
 S AT=$S($L($P(X,U,2)):$P(X,U,2),1:"zz"),WD=$S($P(ND,U,7):"zns",1:$P(X,U,3)),UP1=$P(X,U,5)
 S X=$P($G(^PS(53.5,S1,1,S2,0)),U,4) I X]"",$P(ND,U,6),X'="zz" S X=$S($P(X,"-",2)?1N:0,1:"")_$P(X,"-",2)_"-"_$P(X,"-")
 S RB=$S($P(ND,U,8):"zz",X="":"zz",1:X),PT=$E($P($G(^DPT(S2,0)),U),1,12)_U_S2
 G:'$G(S3) SET2
 S X=$G(^PS(53.5,S1,1,S2,1,S3,0)),ON=+X,ST=$P(X,U,2),UP=$P(X,U,5),X=$P(X,U,6),PD="" I X S PD=$E($P($G(^PS(50.7,X,0)),U),1,7)_U_S3
 G:'$G(S4) SET2
 S X=$G(^PS(53.5,S1,1,S2,1,S3,1,S4,0)),X=+$G(^PS(55,S2,5,ON,1,+X,0)),PDD=$E($P($G(^PSDRUG(+X,0)),U),1,7)_U_S4
SET2 ; if this is a "kill", see if a field and old value was passed in
 Q:(XREF'="AC")!(ACT'="K")!(FIELD="")!(OLDV="")  Q:(@FIELD="zz")!(@FIELD="zns")
 S @FIELD=OLDV
 Q
SETVAR ;
 S FIELD=$G(FIELD),OLDV=$G(OLDV)
 Q
 ;
ENABO(S1,XREF,ACT) ;Set AB/AO xref for Pick List, Ward Group, & Start date.
 N X S X=$G(^PS(53.5,S1,0))
 I ACT="S" D  Q
 .I (XREF="AB")&('$P(X,"^",5)) S ^PS(53.5,XREF,+$P(X,U,2),+$P(X,U,3),S1)="" Q
 .I (XREF="AO")&($P(X,"^",5)=2) S ^PS(53.5,XREF,+$P(X,U,2),+$P(X,U,3),S1)=""
 K ^PS(53.5,XREF,+$P(X,U,2),+$P(X,U,3),S1)
 Q
ENA(S1,ACT) ; Set A xref for Pick List # and Ward Group.
 N X S X=$G(^PS(53.5,S1,0))
 Q:X=""
 I ACT="S" S ^PS(53.5,"A",$P(X,U,2),S1)="" Q
 K ^PS(53.5,"A",$P(X,U,2),S1)
 Q
