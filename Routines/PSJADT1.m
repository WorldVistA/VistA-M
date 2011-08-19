PSJADT1 ;BIR/CML3-AUTO CANCEL/HOLD UTILITIES ;17 JAN 96 / 10:11 AM
 ;;5.0; INPATIENT MEDICATIONS ;**30,37,51,83**;16 DEC 97
 ;
 ; Reference to ^PS(55 is supported by DBIA# 2191.
 ; Reference to ^PS(59.7 is supported by DBIA# 2181.
 ;
ENUW ; update ward and treating specialty
 D INP^VADPT,NOW^%DTC F Q1=%:0 S Q1=$O(^PS(55,PSGP,5,"AUS",Q1)) Q:'Q1  F Q2=0:0 S Q2=$O(^PS(55,PSGP,5,"AUS",Q1,Q2)) Q:'Q2  D
 .I $D(^PS(55,PSGP,5,Q2,0)) S $P(^(0),"^",23)=+VAIN(4),^PS(55,"AUE",PSGP,Q2)=""
 F ON=0:0 S ON=$O(^PS(55,PSGP,"IV",ON)) Q:'ON  I $D(^(ON,0)) S $P(^(0),"^",22)=+VAIN(4)
 Q
 ;
ENHOLD(PSGOEHA,PSJDEL,PSJPAD,PSGALO) ;
 ; place orders on/off hold
 S X=PSGOEHA W:'$D(DGQUIET) !,"...",$S(X:"plac",1:"tak"),"ing Inpatient Medication orders o",$S(X:"n",1:"ff")," of hold..."
 D NOW^%DTC S PSGDT=+$E(%,1,12),PSGOEHA='PSGOEHA D ENACH^PSGOEHA
 S DFN=PSGP,PSIVNST="H" I 'PSGOEHA D ^PSIVHLD
 I PSGOEHA D START^PSIVHLD
 I 'PSGOEHA S X=PSJDEL,X=$S(X=3:2,X=22:2,X=26:2,1:1),$P(PSJPIND,"^",7)=2,$P(PSJPIND,"^",10)="Transferred "_$P("A^Una",U,X)_"uthorized Absence" Q
 S $P(PSJPIND,"^",7)="",$P(PSJPIND,"^",10)="" G ENUW
 ;
ENDEL(DFN,DGPMP,PSJTMT,PSJDEL) ;
 ;Undo mvmt action if movement is deleted.
 N VAIP S VAIP("D")=+DGPMP D IN5^VADPT Q:VAIP(16)
 ; Add call to PSJADT0 to dc active/non-verified orders for cancelled admissions.
 I PSJDEL=1 D  Q
 . S PSJPAD=+VAIP(13,1),PSGALO=1035
 . N VAIP D IN5^VADPT Q:+VAIP(13,1)>PSJPAD
 . D ENDC^PSJADT0
 I PSJDEL=3 D ENUNDC^PSJADT0(+DGPMP,DFN,VAIP(5),18540) Q
 I PSJDEL=6 D ENUNDC^PSJADT0(+DGPMP,DFN,VAIP(5),18550) Q
 I PSJTMT=4 D ENUNDC^PSJADT0(+DGPMP,DFN,VAIP(5),18550) Q
 I PSJTMT<4 D
 .I $P($G(^PS(55,DFN,5.1)),U,7),$P(^(5.1),U,10)["Transferred" D ENHOLD(0,PSJDEL,+DGPMP,8090)
 .D ENUNDC^PSJADT0(+DGPMP,DFN,VAIP(5),18550)
 I PSJTMT>21,(PSJTMT<27) S X=PSJTMT I $P($G(^PS(59.7,1,22,+VAIP(5),0)),U,$S(X=22!(X=26):4,X=23:2,1:3)) D ENHOLD(1,X,+DGPMP,8590)
 Q
  
