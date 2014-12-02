LRAUSICD ;AVAMC/REG - AUTOPSY ICD SEARCH ;8/15/95  09:01
 ;;5.2;LAB SERVICE;**72,253,315,422**;Sep 27, 1994;Build 29
 ;
 ; Reference to $$CSI^ICDEX supported by ICR #5747
 ; Reference to $$SINFO^ICDEX supported by ICR #5747
 ; Reference to $$ICDDX^ICDEX supported by ICR #5747
 ;
 S IOP="HOME" D ^%ZIS W @IOF,?20,LRO(68)," SEARCH BY ICD CODE"
ASK W ! D B^LRU Q:Y<0
 N LR,VAR,ICDFMT,ICDSYS
 S Y=$$IMP^ICDEX(30) S LR("I10DTI")=Y X ^DD("DD") S LR("I10DTE")=Y
 I (LRSDT<LR("I10DTI")),(LRLDT'<LR("I10DTI")) D  G ASK
 . W !!,$C(7),"Beginning and Ending dates must both be prior to "_LR("I10DTE")_"(ICD-9)"
 . W !,"or both be on or after "_LR("I10DTE")_"(ICD-10)."
 S ICDFMT=$S(LRSDT<LR("I10DTI"):1,1:2)
 S ICDSYS=+$$SINFO^ICDEX("DIAG",LRLDT)
 S LRSDT=LRSDT-.01,LRLDT=LRLDT+.99
 S DIC("A")="Select ICD Diagnosis: "
 S DIC=80,DIC(0)="AEQMZ" D ^DIC K DIC G:+Y<1 ASK D
 . S N=+Y,I(1)=$P(Y(0),U,1),I=$P($$ICDDX^ICDEX(I(1),LRLDT,,"E"),"^",4)
 S ZTRTN="QUE^LRAUSICD" D BEG^LRUTL Q:POP!($D(ZTSK))
QUE U IO D S^LRU K ^TMP($J) S LRPAT1=0,^TMP($J,0,1)="ICD CODE: "_I(1)_"  "_I,^TMP($J,0)=I(1)_"^"_I_"^"_LRO(68)_"^"_"ICD CODE"
 F X=0:0 S LRSDT=$O(^LR("AAU",LRSDT)) Q:'LRSDT!(LRSDT>LRLDT)  D LRDFN
 D ^LRAUS K ^TMP($J) D END^LRUTL Q
LRDFN S LRDFN=0 F LRPAT1=0:1 S LRDFN=$O(^LR("AAU",LRSDT,LRDFN)) Q:'LRDFN  D SN
 Q
SN Q:$P($P($G(^LR(LRDFN,"AU")),U,6)," ")'=LRABV  Q:'$D(^LR(LRDFN,80,N,0))!('$D(^LR(LRDFN,0))#2)  S LRAU=^("AU"),LRAD=$P(LRAU,"^")
 S LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3),LRPF=^DIC(LRDPF,0,"GL"),LRFLN=+$P(@(LRPF_"0)"),"^",2) Q:'$D(@(LRPF_DFN_",0)"))
 S LRPPT=@(LRPF_DFN_",0)"),LRP=$P(LRPPT,"^"),SSN=$P(LRPPT,"^",9),SEX=$P(LRPPT,"^",2),DOB=$P(LRPPT,"^",3) D SSN^LRU
 S LRYR=$E($P(LRAU,"^"),1,3),LRAC=$P(LRAU,"^",6),LRAN=+$P(LRAC," ",3)
 S X1=$P(LRAU,"^"),X2=DOB D ^%DTC S AGE=X\365.25
 S:AGE<1 AGE="<1"
 S ^TMP($J,LRYR,LRAN)=LRAC_"^"_AGE_"^"_SEX_"^"_LRP_"^"_SSN(1)_"^"_+$E($P(LRAU,"^"),4,5)_"/"_+$E($P(LRAU,"^"),6,7)
 Q
