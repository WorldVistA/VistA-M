RMPFQP3 ;DDC/KAW-PRINT VA FORM 10-2477a [ 03/12/98  7:46 AM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;**10**;;JUN 16, 1995
 ; input: RMPFX
 ;output: None
 F KX=1:1:RMPFCNT D PRINT
 G END
PRINT Q:'$D(RMPFX)  Q:'RMPFX  Q:'$D(^RMPF(791810,RMPFX,0))  S RMPFTYP=$P(^(0),U,2)
 D ^RMPFQP1 S DFN=$P(^RMPF(791810,RMPFX,0),U,4)
 D ^RMPFDT5,^RMPFDD2,HEAD,HEAD1,ELG,P1 G END:$D(RMPFOUT)
 W !,"9. Currently Authorized Hearing Aid(s)"
 S X=$O(^RMPF(791810,RMPFX,301,0)) I X,$D(^(X,0)) S Y=$P(^(0),U,8) I Y D DD^%DT W " as of: ",Y
 D LINE
 W !?2,"Manfacturer",?16,"|",?22,"Model",?32,"|",?34,"Serial Number",?48,"|",?50,"Furnished By",?64,"|",?67,"Date Issued"
 D LINE
 I $D(^RMPF(791810,RMPFX,301,0)) D AUTH^RMPFQP4 G NEXT
 F I=1:1:4 W !,?16,"|",?32,"|",?48,"|",?64,"|" D LINE
NEXT I $Y>19 D CONT^RMPFQP2
 W !,"10. Clinic Action Taken    __  VETERAN DOES NOT REQUIRE NEW HEARING AID"
 W !?27,"__  VETERAN DOES NOT REQUIRE HEARING AID"
 W !?27,"__  ITEM(S) LISTED BELOW WERE ISSUED TO VETERAN"
 D LINE
 D CONT^RMPFQP2 G END:$D(RMPFOUT) D LINE:IOST?1"C-".E
CLINIC W !,?16,"|",?27,"|",?44,"|",?57,"| Battery",?67,"| Serial No."
 W !,"Natl. Stock No.",?16,"|",?20,"Make",?27,"|",?33,"Model"
 W ?44,"| Serial No.",?57,"|  Type",?67,"| Replaced"
 D LINE
 D MOD^RMPFQP1
 D CONT^RMPFQP2 G END:$D(RMPFOUT) D LINE:IOST?1"C-".E
 I $Y>58 D CONT
 W !,"11. Type of Fitting",?28,":",?32,RMPFTF
 D LINE
 I $Y>58 D CONT
 I RMPFTYP=11 S RMPFUS="*** LOANER AID ***"
 W !,"12. Authorized Usage of Aids:",?32,RMPFUS
 D LINE
 I $Y>58 D CONT
 W !,"13. Issued aids to be replaced to clinic stock by DDC:",?56
 I RMPFHAT="S" W RMPFDDC
 E  W "N/A"
 D LINE
 I $Y>58 D CONT
 W !,"14. Signature of Issuing Audiologist",?38,"|",?49,"Title",?65,"|15. Order Date"
 W !?38,"|",?65,"|"
 I $D(RMPFX) D ARRAY^RMPFDT2 S X=0 F  S X=$O(RMPFO(X)) Q:'X  I $D(^RMPF(791810,RMPFX,101,X,90)),$P(^(90),U,12) S Y=$P(^(90),U,12) I Y,$D(^VA(200,Y,0)) S RMPFADP=$P(^(0),U,1),RMPFAD=Y
 S T="Audiologist" I RMPFAD,$D(^VA(200,RMPFAD,0)) S X=$P(^(0),U,9) I X,$D(^DIC(3.1,X,0)) S T=$P(^(0),U,1)
 S T=$E(T,1,26),L=$L(T)
 W !?4,$P(RMPFADP,",",2)_" "_$P(RMPFADP,",",1),?38,"|",?39+((26-L)\2),T,?65,"|",?68,RMPFODP
 D LINE
 I $Y>58 D CONT
 W !,"16. I certify that I have",?37,"Signature of Veteran",?65,"|17. Date"
 W !?4,"received the item(s)",?65,"|"
 W !?4,"listed under 10 above ->",?65,"|"
 D LINE
 W !,"VA Form 10-2477a"
 W !,"SEP 1991"
 D CONT^RMPFQP2 I IOST?1"P-".E W @IOF
 D:$D(IO("S")) ^%ZISC
END D KIL^RMPFQP4 Q
P1 S AD="A" G P2:'$D(RMPFX)
 I $D(^RMPF(791810,RMPFX,1)) S S1=^(1) I $P(S1,U,5)'=""&($P(S1,U,6)'="") D  G P3
 .S C=1 K RMPFA
 .F I=1:1:3 I $P(S1,U,I)'="" S RMPFA(C)=$P(S1,U,I),C=C+1
 .S RMPFA(C)=$P(S1,U,4)_", "_$P(^DIC(5,$P(S1,U,5),0),U,2)_"  "_$P(S1,U,6)
 .Q
P2 S:$D(RMPFT) AD="T"
P3 W !,"1. Extended Audiology Clinic",?38,"|  2. Issuing Audiology Clinic"
 W !?3,"Station No. ",RMPFRSTA,?38,"|",?44,"Station No. ",RMPFSTAP
 W !?38,"|"
 F I=1:1:4 W ! W:$D(RMPFR(I)) ?3,$E(RMPFR(I),1,35) W ?38,"|" W:$D(RMPFS(I)) ?44,$E(RMPFS(I),1,36)
 D LINE
 W !,"3. Veteran's Name and Address ",?38,"|  4. Eligibility Status(es) ",?71,$J($E(RMPFELS,1,9),9)
 W !,?38,"|" I RMPFELD W ?70,$E(RMPFELD,4,5)_"-"_$E(RMPFELD,6,7)_"-"_($E(RMPFELD,1,3)+1700)
 S RMPFNAM=$P(RMPFNAM,",",2)_" "_$P(RMPFNAM,",",1)
 W !?3,$E(RMPFNAM,1,32),?38,"|",?44,RMPFF
 F I=1:1:4 I $D(@("RMPF"_AD_"(I)"))!$D(RMPFF(I+1)) W ! W:$D(@("RMPF"_AD_"(I)")) ?3,$E(@("RMPF"_AD_"(I)"),1,32) W ?38,"|" W:$D(RMPFF(I+1)) ?44,$E(RMPFF(I+1),1,36)
 D LINE
 D CONT^RMPFQP2 Q:$D(RMPFOUT)  D LINE:IOST?1"C-".E
 W !,"5. Soc. Security No.",?20,"| 6. VA Claim No.",?38,"| 7. Date of Birth",?59,"| 8. Disability Code"
 W !?20,"|",?38,"|",?59,"|"
 W !?3,RMPFSSN,?20,"|",?25,RMPFCL,?38,"|",?43,RMPFDOB,?59,"|"
 W ?64,RMPFDC
 D LINE
 Q
LINE W !,"--------------------------------------------------------------------------------"
 Q
HEAD W:$Y>0 @IOF W !?25,"DEPARTMENT OF VETERANS AFFAIRS"
 W !?21,"AUDIOLOGICAL SERVICES ACKNOWLEDGEMENT"
 D LINE Q
HEAD1 W:$D(RMPFSTP) !,"Order Status: *** ",RMPFSTP," ***"
 W ?59,"Printed: ",RMPFDAT
 D LINE Q
ELG S RMPFF="" Q:'$D(RMPFX)  S X=$P($G(^RMPF(791810,RMPFX,2)),U,2)
 I X,$D(^RMPF(791810.4,X,0)) S RMPFF=$P(^(0),U,1)
 Q
CONT Q:IOST'["P-"
 D HEAD,HEAD1 W !!,"cont." D LINE Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
