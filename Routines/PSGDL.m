PSGDL ;BIR/CML3-CALCULATE STOP DATE/TIME WITH DOSE LIMIT ;27 Aug 98 / 8:47 AM
 ;;5.0; INPATIENT MEDICATIONS ;**16,50,64,58,111,170**;16 DEC 97
 ;
 ; Reference to ^PS(55 is supported by DBIA #2191.
 ;
EN ;
 K PSGDLS S ND2=^PS(53.1,DA,2) I $P(ND2,"^",5)!$P(ND2,"^",6) W " ...Dose Limit... " G ENGO
 G DONE
 ;
ENE ;
 S ND2=PSGSCH_"^"_PSGSD_"^^^"_PSGAT_"^"_PSGS0XT G ENGO
 ;
EN1 ;
 S ND2=$P(PSGNEDFD,"^",4)_"^"_PSGNESD_"^^^"_PSGS0Y_"^"_PSGS0XT G ENGO
 ;
EN2 ;
 K PSGDLS S ND2=^PS(55,DA(1),5,DA,2) I '$P(ND2,"^",5),'$P(ND2,"^",6) G DONE
 W " ...Dose Limit... "
 ;
ENGO ;
 S SCH=$P(ND2,"^")
 S ST=$S($D(PSGDLS):PSGDLS,1:$P(ND2,"^",2))
 S TS=$P(ND2,"^",5),MN=$P(ND2,"^",6)
 I $P(PSJSYSW0,U,5)=2 D
 . Q:'TS  S:TS'[$P(ST,".",2) $P(PSJSYSW0,U,5)=1 D
 .. S X=$G(PSGSD),%DT="T" D ^%DT I Y'=-1 N PSGSD S PSGSD=Y
 .. S X=$G(PSGFD),%DT="T" D ^%DT I Y'=-1 N PSGFD S PSGFD=Y
 .. I '$G(PSGSD) N PSGSD S PSGSD=$$DATE^PSJUTL2
 .. I '$G(PSGFD) N PSGFD S PSGFD=$$FMADD^XLFDT(PSGSD,30)
 .. N STRING,ND2,SCH,TS,MN S STRING=$G(PSGSD)_"^"_$G(PSGFD)_"^"_$G(PSGSCH)_"^"_$G(PSGST)_"^"_$G(PSGPDRG)_"^"_$G(PSGAT)
 .. I $G(PSGP) S ST=$$ENQ^PSJORP2(PSGP,STRING) S:'ST ST=$S($D(PSGDLS):PSGDLS,1:$P(ND2,"^",2))
 . S $P(PSJSYSW0,U,5)=2
 G MWF:SCH["@",DONE:'TS&'MN
 I 'TS S AM=MN*PSGDL,X=$$EN^PSGCT(ST,AM) G DONE
 S TM=$E(ST_"00000",9,8+$L($P(TS,"-")))
 F Q=1:1 Q:$P(TS,"-",Q)=""!(TM<$P(TS,"-",Q))
 S X=ST\1,C=0 F Q=Q:1 D:$P(TS,"-",Q)="" ADD S C=C+1 I C=PSGDL S X=X_"."_$P(TS,"-",Q) G DONE
 ;
MWF ; if schedule is similar to monday-wednesday-friday
 S TS=$P(SCH,"@",2),SCH=$P(SCH,"@"),X=$P(ST,"."),C=0 D SCHK G:C=PSGDL DONE F Q=1:1 S X1=$P(ST,"."),X2=Q D C^%DTC S X1=X D DW^%DTC D CHK G:C=PSGDL DONE
SCHK S X1=X D DW^%DTC F Q=1:1:$L(SCH,"-") S WKD=$P(SCH,"-",Q) I WKD=$E(X,1,$L(WKD)) Q
 E  Q
 S TM=$E(ST_"00000",9,8+$L($P(TS,"-"))) F Q=1:1:$L(TS,"-") I TM<$P(TS,"-",Q) S C=C+1 I C=PSGDL S X=X1_"."_$P(TS,"-",Q) Q
 Q
CHK F QQ=1:1:$L(SCH,"-") S WKD=$P(SCH,"-",QQ) I WKD=$E(X,1,$L(WKD)) D TS Q
 Q
TS F Q1=1:1:$L(TS,"-") S C=C+1 I C=PSGDL S X=X1_"."_$P(TS,"-",Q1) Q
 Q
 ;
DONE ;
 K %H,%T,%Y,MN,ND2,ND4,PSGDLS,PSGDL,Q1,QQ,SCH,TM,WKD,TS,X1,X2 Q
 ;
ADD ;
 S X1=$P(X,"."),X2=$S(MN&'(MN#1440):MN\1440,1:1) D C^%DTC S Q=1 Q
 ;
ENPREV ; when "P" is enter at start date
 W "REVIOUS" S (X,Y)=0 I '$D(PSGP)!'$D(PSGPDRG) G:$D(DA)[0 POUT S PSGP=$P($G(^PS(53.1,DA,0)),"^",15),PSGPDRG=+$G(^(.2)),Y=1 I 'PSGP!'PSGPDRG W:'PSGPDRG !?17,"Must have drug from formulary list." G POUT
 F Q=0:0 S Q=$O(^PS(53.1,"AC",PSGP,Q)) Q:'Q  I +$G(^PS(53.1,Q,.2))=PSGPDRG,$D(^PS(53.1,Q,2)),$P(^(2),"^",4)>X S X=$P(^(2),"^",4)
 F Q=0:0 S Q=$O(^PS(55,PSGP,5,"C",PSGPDRG,Q)) Q:'Q  I $D(^PS(55,PSGP,5,Q,2)),$P(^(2),"^",4)>X S X=$P(^(2),"^",4)
 W:'X !?17,"No other order found with this drug."
 ;
POUT ;
 K:'X X K:Y PSGPDRG,PSGP,Q Q
ENDL(SCH,DL) ;validate that dose limit should be allowed with this schedule
 ;and that the dose limit is a whole number
 I $G(SCH)="" Q 1
 I ",ON CALL,ON-CALL,ONCALL,"[(","_SCH_",")!($$ONE^PSJBCMA(DFN,"",SCH)="O") W " Dose limit invalid with this schedule" Q 0
 I DL'?1N.N W " Dose limit must be a whole number" Q 0
 Q 1
