RMPRPCEG ;HCIOFO/RVD - Prosthetics/PCE GET 2319/SET ICD9; 06/28/01
 ;;3.0;PROSTHETICS;**62**;Feb 09, 1996
 ;
 ;
 ;RMDFN - IEN of the patient.
 ;returns the IEN of patient transaction from file #660.
G60(RMDFN) ;select the 2319 transaction.
 D NEWVAR
 S RMDOUT=0
 S DIC("A")="Enter Patient Transaction for PCE Entry: "
 S DIC("?")="Enter a 2319 transaction where this suspense entry is being closed.."
 S DIC="^RMPR(660,",DIC(0)="AEQMN"
 S DIC("S")="I ($P(^RMPR(660,+Y,0),U,2)=RMDFN),('$D(^RMPR(660,+Y,10)))"
 D ^DIC
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT) S RMDOUT=0 G GETX
 S RMDOUT=+Y
 S:Y<1 RMDOUT=0
GETX ;exit
 Q RMDOUT
 ;
 ;RMDFN - IEN of the patient.
 ;returns the IEN of the Patient Suspense entry from file #668.
G68(RMDFN) ;select the suspense transaction.
 D NEWVAR
 S RMDOUT=0
AS68 W !
 S DIC("A")="Enter Patient Suspense Entry: "
 S DIC("?")="Enter a Suspense Entry for the Patient 2319 Record..."
 S DIC="^RMPR(668,",DIC(0)="AEQMN"
 S DIC("S")="I ($P(^RMPR(668,+Y,0),U,2)=RMDFN),(($P(^(0),U,10)=""O"")!($P(^(0),U,10)=""P"")),($D(^(8))),($P(^(8),U,3)),('$D(^(11)))"
 S DIC("W")="S R8=$G(^RMPR(668,+Y,0)),RN=$E($P(^DPT(RMDFN,0),U,1),1,10) W ?38,RN,?50,$P(R8,U,10),""  DESC: "",$G(^RMPR(668,+Y,2,1,0))"
 D ^DIC
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT) S RMDOUT=X G G68X
 S RMDOUT=+Y
G68X ;exit
 Q RMDOUT
 ;
SETICD ;entry for post init #62
 W !!,"Setting ICD9 pointer in file #668:"
 S DIE="^RMPR(668,"
 F I=0:0 S I=$O(^RMPR(668,I)) Q:I'>0  I $D(^RMPR(668,I,8)) D
 .S RMPR8=$G(^RMPR(668,I,8))
 .S RI=$P(RMPR8,"^",2)
 .Q:$P(RMPR8,"^",3)
 .K RIC,RB,RE
 .F K=1:1:$L(RI) S RX=$E(RI,K,K) S:RX="(" RB=K S:RX=")" RE=K I $G(RB),$G(RE) S RIC=$E(RI,RB+1,RE-1) Q:RIC>1  K RB,RE
 .S RMIECD=""
 .I $D(RIC),RIC'="" D
 ..S RMIECD=$O(^ICD9("BA",RIC,0))
 ..I '$G(RMIECD) S RMIECD=$O(^ICD9("BA",RIC_" ",0))
 .I $G(RMIECD) S DA=I,DR="1.6////^S X=RMIECD" D ^DIE
 .W "."
 W !!,"DONE setting ICD9 pointer to file #668."
 K DIE,DR,DA,RMPR8,I,K,J,RB,RE,RIC,RMIECD,RI,RX
 I $D(^RMPR(661.1,3025,0)),$P(^RMPR(661.1,3025,0),U,1)="C1116" S $P(^RMPR(661.1,3025,0),U,8)=1
 ;update HCPCS to a new CPT Code
 W !!,"Updating CPT Codes.."
 S DIE="^RMPR(661.1,"
 F RI=1:1 Q:$P($T(TAB+RI),";",3)="END"  S RD=$T(TAB+RI) D
 .S RMHCPC=$P(RD,";",3),RMCPT=$P(RD,";",5)
 .S DA=$P(RD,";",4)
 .I RMHCPC'=$P(^RMPR(661.1,DA,0),U,1) W !!,"** HCPCS ",RMHCPC," has incorrect IEN in file #661.1, please investigate!!!" Q
 .S DR="2///^S X=RMCPT"
 .D ^DIE
 K DA,DIE,DR,RMHCPC,RMCPT,RI
 W !!,"Done Updating CPT Codes!!",!
 Q
 ;
TAB ;list of HCPCS need to be updated.
 ;;K0280;1389;105120
 ;;E0240;2051;101067
 ;;A9010;2429;103242
 ;;A9040;2524;103356
 ;;A9070;2525;101873
 ;;SI102;2806;105228
 ;;SI103;2807;105357
 ;;SI213;2836;105126
 ;;SI302;2848;104713
 ;;SI303;2849;104713
 ;;SI304;2850;104713
 ;;SI305;2851;104713
 ;;SI306;2852;104713
 ;;SI405;2859;104713
 ;;SI516;2881;105799
 ;;SI517;2882;105800
 ;;SI518;2883;105799
 ;;SI519;2884;105357
 ;;SI199;2902;104713
 ;;SI299;2903;104713
 ;;SI399;2904;104713
 ;;SI499;2905;104713
 ;;SI599;2906;104713
 ;;END
 ;
NEWVAR N DA,DIE,DIC,Y,R8
 Q
