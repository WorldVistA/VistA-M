SDTMPUT0 ;MS/SJA - TELEHEALTH SEARCH UTILITY ;Dec 17, 2020
 ;;5.3;Scheduling;**773,779,812,817,821**;Aug 13, 1993;Build 9
 ;Reference to ^DGCN(391.91 supported by IA #4943
 ;
 N II,ARR,CNT,CODE,DEA,DFN,FAC,F407,S407,ICNHA,SIEN,MPI,NODE1,NODE8,NODE99,FICN,SDCL,NODE0,DIV,MCD,INST,INSF
 N LTZ,SDASH,CTRY,TZEX,SDSL,SDRE,SDIN,SDNO,STP1,STP2,OPT,VADM,XX,ZD
 S $P(SDASH,"=",81)=""
EN W @IOF W ?22,"Telehealth Inquiries",!!
 K DIRUT,DUOUT,DIR
 S DIR(0)="SA^C:Clinic;M:Medical Center Division;I:Institution;P:Patient Information;N:Patient ICN;L:List Stop Codes;S:Stop Code Lookup;SN:Station Number (Time Sensitive);R:Clinic Schedule Queuing Report;Q:QUIT"
 S DIR("A",1)="      Select one of the following:"
 S DIR("A",2)=""
 S DIR("A",3)="          C         Clinic"
 S DIR("A",4)="          M         Medical Center Division"
 S DIR("A",5)="          I         Institution"
 S DIR("A",6)="          P         Patient Information"
 S DIR("A",7)="          N         Patient ICN"
 S DIR("A",8)="          L         List Telehealth Stop Codes"
 S DIR("A",9)="          S         Telehealth Stop Code Lookup"
 S DIR("A",10)="          SN        Station Number (Time Sensitive)"
 S DIR("A",11)="          R         Clinic Schedule Queuing Report"
 S DIR("A",12)=""
 S DIR("A")="Search Option or (Q)uit: "
 D ^DIR K DIR I Y="Q"!$D(DTOUT)!$D(DIRUT) G END
 S OPT=Y W !
 D @OPT
 G EN
 ;
C ; Search by clinic
 K DIC,SDCL,SDNO,NOD0,PNODE,DIV,SDSL,MCD,INST,INSF,LTZ,CTRY,TZEX,CHAR4,CHAR4DSC
 S DIC="^SC(",DIC(0)="AEMQZ",DIC("S")="I $P(^(0),""^"",3)=""C"",'$G(^(""OOS""))"
 S DIC("A")="Select CLINIC: " D ^DIC K DIC("S"),DIC("A") Q:"^"[X  I +Y'>0 G:+Y<0 C
 S SDCL=Y
 S SDNO="",NODE0=$G(^SC(+SDCL,0)),DIV=$P(NODE0,U,15)
 S SDSL=$G(^SC(+SDCL,"SL")),MCD=$G(^DG(40.8,DIV,0)),INST=$P(MCD,U,7)
 S INSF=$G(^DIC(4,INST,8)),LTZ=$P(INSF,U),CTRY=$P(INSF,U,2),TZEX=$P(INSF,U,3)
 S CHAR4=$$CHAR4^SDESUTIL($P(SDCL,U,2)) S CHAR4DSC=$S(CHAR4="":"",1:CHAR4_"-"_$$CHAR4DSC^SDTMPUTL(CHAR4))
 W !!,SDASH,!
 W !,"Clinic",?18,": ",$TR(SDCL,"^","-")
 W !,"Default Provider",?18,": " I $P(NODE0,U,13) W $P(NODE0,U,13),"-",$P(^VA(200,$P(NODE0,U,13),0),U)
 W !,"Provider",?18,": "
 S II=0 F  S II=$O(^SC(+SDCL,"PR",II)) Q:'II  D
 . I $D(^SC(+SDCL,"PR",II,0)) S PNODE=^SC(+SDCL,"PR",II,0) W ?20,+PNODE,"-",$P(^VA(200,+PNODE,0),U),?50,$S($P(PNODE,U,2):" << Default >>",1:""),!
 W:'$O(^SC(+SDCL,"PR",0)) ! W "Medical Division",?18,": ",DIV,"-",$$GET1^DIQ(40.8,DIV,.01)
 W !,"Institution",?18,": ",INST,"-",$$GET1^DIQ(4,INST,.01)
 W !,"Station Number",?18,": ",$$GET1^DIQ(4,INST_",",99,"E")
 W !,"Stop Code",?18,": ",$P(NODE0,U,7),"-",$$GET1^DIQ(40.7,$P(NODE0,U,7),.01)," (",$$GET1^DIQ(40.7,$P(NODE0,U,7),1),")"
 W !,"Credit Stop Code",?18,": ",$P(NODE0,U,18),"-",$$GET1^DIQ(40.7,$P(NODE0,U,18),.01)," (",$$GET1^DIQ(40.7,$P(NODE0,U,18),1),")"
 W !,"CHAR4",?18,": ",CHAR4DSC ;821
 W !,"Country",?18,": ",CTRY,"-",$$GET1^DIQ(779.004,CTRY,.01)
 W !,"Location Timezone",?18,": ",LTZ,"-",$$GET1^DIQ(1.71,LTZ,.01)
 W !,"Timezone Exception",?18,": ",TZEX
 W !,"Overbooks per day",?18,": ",$P(SDSL,U,7)
 W !,"Spec Instructions",?18,":"
 D SI
 D ACT
 W !,SDASH,!! G C
 Q
 ;
M ; Search by Medical Center Division
 K DEA,DIC,ZD,MCD,INST,INSF,LTZ,CTRY,TZEX
 S DIC="^DG(40.8,",DIC(0)="AEMQ" D ^DIC K DIC
 Q:"^"[X  I +Y'>0 W !,$C(7),"Division not found. Please try again."  G M
 S ZD=+Y
 S MCD=$G(^DG(40.8,ZD,0)),INST=$P(MCD,U,7)
 S INSF=$G(^DIC(4,INST,8)),LTZ=$P(INSF,U),CTRY=$P(INSF,U,2),TZEX=$P(INSF,U,3)
 S DEA=$G(^DIC(4,INST,"DEA"))
 W !!,SDASH,!
 W !,"Medical Division",?18,": ",ZD,"-",$$GET1^DIQ(40.8,ZD,.01)
 W !,"Facility Number",?18,": ",$P(MCD,U,2)
 W !,"Institution",?18,": ",INST,"-",$$GET1^DIQ(4,INST,.01)
 W !,"Facility DEA #",?18,": ",$P(DEA,U)
 W !,"Facility Exp. date",?18,": ",$$FMTE^XLFDT($P(DEA,U,2),2)
 W !,SDASH,!! G M
 Q
 ;
I ; search by Institution
 K DEA,DIC,FAC,NOD0,NODE1,NODE8,II,ARR,LTZ,CTRY,TZEX,NODE99
 S DIC="^DIC(4,",DIC(0)="AEMNQ" D ^DIC  K DIC Q:Y<1 0
 Q:"^"[X  I +Y'>0 W !,$C(7),"Institution not found. Please try again." G I
 S FAC=Y
 S NODE0=$G(^DIC(4,+Y,0)),NODE1=$G(^DIC(4,+Y,1))
 S NODE8=$G(^DIC(4,+Y,8)),LTZ=$P(NODE8,U),CTRY=$P(NODE8,U,2),TZEX=$P(NODE8,U,3)
 S NODE99=$G(^DIC(4,+Y,99)),DEA=$G(^DIC(4,+FAC,"DEA"))
 W !!,SDASH,!
 W !,"Name",?18,": ",$TR(FAC,"^","-")
 W !,"City",?18,": ",$P(NODE1,U,3)
 W !,"State",?18,": ",$P(NODE0,U,2),"-",$$GET1^DIQ(5,$P(NODE0,U,2),.01)
 W !,"District",?18,": ",$P(NODE0,U,3)
 W !,"VA region IEN",?18,": ",$P(NODE0,U,7)
 W !,"Location Timezone",?18,": ",LTZ,"-",$$GET1^DIQ(1.71,LTZ,.01)
 W !,"Timezone Exception",?18,": ",TZEX
 W !,"Country",?18,": ",CTRY,"-",$$GET1^DIQ(779.004,CTRY,.01)
 W !,"Station #",?18,": ",$P(NODE99,U)
 W !,"Facility DEA #",?18,": ",$P(DEA,U)
 W !,"Facility Exp. date",?18,": ",$$FMTE^XLFDT($P(DEA,U,2),2)
 S II=0 F  S II=$O(^DIC(4,+FAC,7,II)) Q:'II  K ARR D GETS^DIQ(4.014,II_","_+FAC,".01;1","E","ARR") D
 . W !,"Association",?18,": ",II_"-"_ARR(4.014,II_","_+FAC_",",.01,"E")
 . W ?40,"  Parent",": ",II_"-"_ARR(4.014,II_","_+FAC_",",1,"E")
 W !,SDASH,!! G I
 Q
 ;
P ; search by patient
 K DIC,DFN,MPI,XX,ICNHA,VADM,SDDOD,SDDODN
 S DIC="^DPT(",DIC(0)="AEMQ",DIC("A")="Select Patient: " D ^DIC K DIC
 Q:"^"[X  I +Y'>0 W !,$C(7),"Patient not found. Please try again." G P
 S DFN=+Y D 2^VADPT S MPI=$G(^DPT(DFN,"MPI"))
 S SDDOD=0,SDDOD=$O(^DGCN(391.91,"AKEY2",DFN,"USDOD",SDDOD))
 I SDDOD S SDDODN=$P(^DGCN(391.91,SDDOD,2),U,2)
 W !,SDASH
 W !,"Number (IEN)",?18,": ",DFN
 W !,"Name",?18,": ",VADM(1)
 W !,"Sex",?18,": ",$P(VADM(5),U,2)
 W !,"Date of Birth",?18,": ",$P(VADM(3),U,2)
 W !,"SSN",?18,": ",$P(VADM(2),U,2)
 W !,"DOD Number",?18,": ",$G(SDDODN)
 W !,"Full ICN",?18,": ",$P(MPI,U,10)
 W !,"Integrated Control: ",$P(MPI,U)
 W !,"ICN Checksum",?18,": ",$P(MPI,U,2)
 D ICN W !,"Full ICN History  :" S XX=0 F  S XX=$O(ICNHA(XX)) Q:'XX  W ?20,$G(ICNHA(XX)),!
 W "Deceased Date",?18,": ",$P($P(VADM(6),U,2),"@"),!
 D SC
 W !,SDASH G P
 Q
 ;
N ; search by ICN
 W !,"Select ICN: " R SDICN:DTIME
 I SDICN=""!(SDICN="^") D SDCLN Q
 I SDICN="?"!(SDICN="??") D SDHELP G N
 I '$D(^DPT("AFICN",SDICN)) W $C(7)," ??" G N
 S DFN="",SDCNT=0 F  S DFN=$O(^DPT("AFICN",SDICN,DFN)) Q:DFN=""  S SDCNT=SDCNT+1 D:SDCNT=1 SDINQ D:SDCNT>1 SDINQ,SDMSG
 W !,"Records Found: ",SDCNT,!
 G N
 Q
 ;
S ; Telehealth stop code
 K DIC,CODE,STP1,STP2,F407,S407
 S DIC="^SD(40.6,",DIC(0)="AEMNQ" D ^DIC K DIC
 Q:"^"[X  I +Y'>0 W !,$C(7),"Telehealth Stop Code not found. Please try again." G S
 S CODE=$P(Y,U,2),STP1=$E(CODE,1,3),STP2=$E(CODE,4,6)
 S F407=$O(^DIC(40.7,"C",STP1,0)) S:STP2 S407=$O(^DIC(40.7,"C",STP2,0))
 W !!,SDASH,!
 W !,"Stop Code: ",STP1," > ",$P($G(^DIC(40.7,F407,0)),U)
 I $G(STP2) W !,"Stop Code: ",STP2," > ",$P($G(^DIC(40.7,S407,0)),U)
 W !,SDASH,!! K X,Y G S
 Q
 ;
L ; list Telehealth stop codes
 K DIC,CNT,II,STP1,STP2,F407,S407
 S CNT=0 W !!,SDASH,!
 S II=0 F  S II=$O(^SD(40.6,"B",II)) Q:'II  D
 . S CNT=CNT+1,STP1=$E(II,1,3),STP2=$E(II,4,6)
 . S F407=$O(^DIC(40.7,"C",STP1,0)) S:STP2 S407=$O(^DIC(40.7,"C",STP2,0))
 . I STP2 W !,"Stop Code: ",STP1_STP2 D  Q
 . . W !,?11,STP1," > ",$P($G(^DIC(40.7,F407,0)),U)
 . . W !,?11,STP2," > ",$P($G(^DIC(40.7,S407,0)),U)
 . W !,"Stop Code: ",STP1," > ",$P($G(^DIC(40.7,F407,0)),U)
 W !,SDASH
 W !,"Total number of Telehealth Stop code: ",CNT,!!
 S DIR(0)="EA",DIR("A")="Press <Enter> to continue" D ^DIR K DIR
 Q
 ;
SN ; Search by Station Number
 K DIC,NODE0,II K ^TMP($J)
N1 S DIC="^VA(389.9,",DIC(0)="AEMQ" D ^DIC K DIC I Y>0 S ^TMP($J,+Y)="",DIC("A")="Another one:" G N1
 I $D(DTOUT)!($D(DUOUT))!('$O(^TMP($J,0))) Q
 W !!,SDASH
 F II=0:0 S II=$O(^TMP($J,II)) Q:'II  W ! D
 . S NODE0=$G(^VA(389.9,II,0))
 . W !,"Number: ",II,?35,"Reference Number: ",$P(NODE0,U)
 . W !,?2,"Effective Date: " I $P(NODE0,U,2) W $$FMTE^XLFDT($P(NODE0,U,2),1)
 . W ?35,"Medical Center Division: " I $P(NODE0,U,3) W $P(NODE0,U,3)_"-",$$GET1^DIQ(40.8,$P(NODE0,U,3),.01)
 . W !,?2,"Station Number: ",$P(NODE0,U,4),?35,"Inactive: ",$S($P(NODE0,U,6):"Yes",1:"No")
 . W !,?2,"Is Primary Division: ",$S($P(NODE0,U,5):"Yes",1:"No")
 . W !
 K ^TMP($J)
 W !!,SDASH,! G SN
 Q
 ;
ICN ; full ICN history
 K ICNHA
 I '$D(^DPT(DFN,"MPIFICNHIS")) S ICNHA(1)="NO ICN HISTORY" Q
 S (SIEN,CNT)=0
 F  S SIEN=$O(^DPT(DFN,"MPIFICNHIS",SIEN)) Q:'SIEN  D
 . S FICN=$P($G(^DPT(DFN,"MPIFICNHIS",SIEN,0)),"^") I FICN'="" S CNT=CNT+1,ICNHA(CNT)=FICN
 I CNT=0 S ICNHA(1)="NO ICN HISTORY" Q
 S ICNHA=CNT
 Q
 ;
ACT ; inactive clinic
 I $D(^SC(+SDCL,"I")) S SDRE=+$P(^("I"),U,2),SDIN=+^("I") I SDRE'=SDIN I SDIN'>DT&(SDRE=0!(SDRE>DT)) D
 . S Y=SDIN D DTS^SDUTL W !!,?4,"**** Clinic is inactive ",$S(SDRE:"from ",1:"as of "),Y S Y=SDRE D:Y DTS^SDUTL W $S(SDRE:" to "_Y,1:"")," ****" K SDIN,SDRE S SDNO=1
 I 'SDNO,$D(SDIN),SDIN>DT,SDRE'=SDIN W !,?4,"**** Clinic will be inactive ",$S(SDRE:"from ",1:"as of ") S Y=SDIN D DTS^SDUTL W Y S Y=SDRE D:Y DTS^SDUTL W $S(SDRE:" to "_Y,1:"")," ****" K SDIN,SDRE
 Q
 ;
END K ARR,CNT,CODE,CTRY,DFN,FAC,F407,S407,ICNHA,SIEN,II,MPI,NODE1,NODE8,NODE99,FICN,SDCL,NODE0,DIV,MCD,INST,INSF
 K LTZ,SDASH,STP1,STP2,TZEX,SDSL,SDRE,SDIN,SDNO,OPT,VADM,XX,ZD
 Q
 ;
SC ;SERVICE CONNECTED MESSAGE/IOFO - BAY PINES/TEH
 N VAEL
 I +$P($G(^DPT(DFN,.3)),U,2)>49 D
 . W !,?7,"********** THIS PATIENT IS 50% OR GREATER SERVICE-CONNECTED **********",!
 D 2^VADPT
 W !,"PATIENT'S SERVICE CONNECTION AND RATED DISABILITIES:"
 I $$GET1^DIQ(2,DFN_",",.301,"E")="YES"&($P(VAEL(3),"^",2)'="") D
 . W !,"SC Percent: "_$P(VAEL(3),"^",2)_"%"
 I $$GET1^DIQ(2,DFN_",",.301,"E")="NO"&($P(VAEL(3),"^",2)="") D
 . W !,"Service Connected: No"
 ;Rated Disabilities
 N SDSER,SDRAT,SDREC,NN,NUM
 S (NN,NUM)=0
 F  S NN=$O(^DPT(DFN,.372,NN)) Q:'NN  D
 . S SDREC=$G(^DPT(DFN,.372,NN,0)) I SDREC'="" D
 . . S SDRAT="" S NUM=$P($G(SDREC),"^",1) I NUM>0 S SDRAT=$$GET1^DIQ(31,NUM_",",.01)
 . . S SDSER="" S SDSER=$S($P(SDREC,"^",3)="1":"SC",1:"NSC")
 . . W !,"    "_SDRAT_"  ("_SDSER_" - "_$P(SDREC,"^",2)_"%)"
 ;
 W !,"Primary Eligibility Code: "_$P(VAEL(1),"^",2)
 I $P($G(^DPT(DFN,.372,0)),"^",4)<1 W !,"No Service Connected Disabilities Listed"
 Q
 ;
SDINQ ;Print inquiry
 D 2^VADPT S MPI=$G(^DPT(DFN,"MPI"))
 S SDDOD=0,SDDOD=$O(^DGCN(391.91,"AKEY2",DFN,"USDOD",SDDOD))
 I SDDOD S SDDODN=$P(^DGCN(391.91,SDDOD,2),U,2)
 W !,SDASH
 W !,"Full ICN",?18,": ",$P(MPI,U,10)
 W !,"Number (IEN)",?18,": ",DFN
 W !,"Name",?18,": ",VADM(1)
 W !,"Sex",?18,": ",$P(VADM(5),U,2)
 W !,"Date of Birth",?18,": ",$P(VADM(3),U,2)
 W !,"SSN",?18,": ",$P(VADM(2),U,2)
 W !,"DOD Number",?18,": ",$G(SDDODN)
 W !,"Integrated Control: ",$P(MPI,U)
 W !,"ICN Checksum",?18,": ",$P(MPI,U,2)
 D ICN W !,"Full ICN History  :" S XX=0 F  S XX=$O(ICNHA(XX)) Q:'XX  W ?20,$G(ICNHA(XX)),!
 W "Deceased Date",?18,": ",$P($P(VADM(6),U,2),"@"),!
 D SC
 W !,SDASH,!
 Q
 ;
SDMSG ;Print warning for multiple ICN
 W !,$C(7)
 W "More than one Patient ICN exists in this VistA System, please contact your",!
 W "local Health Administration Services.  If this is related to an INTRAfacility",!
 W "action, enter a Service Now ticket with your local HAS Office. If this is",!
 W "related to an INTERfacility action, enter an IAM Toolkit Request at",!
 W "http://vaww.vhadataportal.domain.ext/PolicyAdmin/HealthcareIdentityManagement.aspx",!
 Q
 ;
SDCLN ;Clean up variables
 K SDCNT,DFN,ICNHA,FICN,MPI,SDICN,VA,VADM,XX,SDDOD,SDDODN
 Q
 ;
SDHELP ;Help text
 W !,"   Enter the local or national Integration Control Number (ICN)",!
 W "   assigned to the patient.",!
 Q
 ;
SI ;Parse and display special instructions
 N N,I,E,S
 S N=+$P($G(^SC(+SDCL,"SI",0)),U,3)
 I N=0 Q
 F I=1:1:N S X=$G(^SC(+SDCL,"SI",I,0)) D
  . I X="" Q
  . I $L(X)<61 W ?20,X W:I<N ! Q 
  . S E=48 F  S E=$F(X," ",E) Q:E=0!(E>60)  S S=E
  . W ?20,$E(X,1,S-1),!,?22,$E(X,S,99)
  . I I<N W !
 Q
 ;
R ;Clinic schedule queuing report
 D BEGIN^SDTMPPRC
 Q
