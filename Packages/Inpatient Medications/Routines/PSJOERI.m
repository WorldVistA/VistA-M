PSJOERI ;BIR/LDT-CPRS ORDER UPDATE FOR INPATIENT MEDS ; 7/30/08 7:51am
 ;;5.0; INPATIENT MEDICATIONS ;**86,108,204**;16 DEC 97;Build 3
 ;
 ; Reference to ^PS(55 is supported by DBIA 2191
 ; Reference to ^%DTC is supported by DBIA 10000
 ; Reference to ^DIE is supported by DBIA 10018
 ;
ENR(DFN,ON,PSJWARD) ;
 I $G(DFN)=""!($G(ON)="")!(+$G(PSJWARD)'>0) Q
 I PSJWARD'=+PSJWARD Q
 D NOW^%DTC S PSJNOW=%
 I ON["V" D  Q
 . I '$D(^PS(55,DFN,"IV",+ON)) Q
 . I $P(^PS(55,DFN,"IV",+ON,0),"^",17)'="D" Q
 . I $P(^PS(55,DFN,"IV",+ON,0),"^",12)="" Q
 . N DA,DR,DIE,DIK,PSIVREA,PSIVALCK,PSIVOPT,PSIVAL,PSIVALT,X,Y
 . S P(3)=$P($G(^PS(55,DFN,"IV",+ON,0)),"^",3)
 . S X=$G(^PS(55,DFN,"IV",+ON,"ADC")) I X K ^PS(55,"ADC",X,DFN,+ON),^PS(55,DFN,"IV",+ON,"ADC")
 . S PSIVACT=1,DR="100///A;.03////"_+$P($G(^PS(55,DFN,"IV",+ON,2)),U,7)_";9////^S X=PSJWARD;109///@;116///@;121///@",DIE="^PS(55,"_DFN_",""IV"",",DA=+ON,DA(1)=DFN
 .;PSJ*5.0*204
 . I $P($G(^PS(55,DFN,"IV",+ON,4)),"^",18)=1 S DR="100////H;.03////"_+$P($G(^PS(55,DFN,"IV",+ON,2)),U,7)_";9////^S X=PSJWARD;109///@;116///@;121///@"
 . N CHKIT S CHKIT=$G(^PS(55,DFN,"IV",+ON,2)) I $P(CHKIT,U,6)["P",($P(CHKIT,U,9)="R") S DR=DR_";114///@;123///@"
 . D ^DIE
 . D IRA(1),EN1^PSJHL2(DFN,"SC",ON,"AUTO REINSTATED (CPRS)")
 I ON["U" D  Q
 . I '$D(^PS(55,DFN,5,+ON)) Q
 . I $P(^PS(55,DFN,5,+ON,0),"^",9)'="D" Q
 . I $P(^PS(55,DFN,5,+ON,4),"^",11)="" Q
 . N DA,DR,DIE,PSGFD,X,Z
 . S PSGFD=$P($G(^PS(55,DFN,5,+ON,2)),"^",3)
 . S DR="28////A;34////^S X=PSGFD;68////^S X=PSJWARD",Z=$G(^PS(55,DFN,5,+ON,4)),$P(Z,U,11)="",$P(Z,"^",15,17)="^^" S ^(4)=Z
 .;PSJ*5.0*204
 . I $P($G(^PS(55,DFN,5,+ON,4)),"^",18)=1 S DR="28////H;34////^S X=PSGFD;68////^S X=PSJWARD"
 . N CHKIT S CHKIT=$G(^PS(55,DFN,5,+ON,0)) I $P(CHKIT,U,26)["P",($P(CHKIT,U,27)="R") S DR=DR_";105///@;107///@"
 . S DIE="^PS(55,"_DFN_",5,",DA(1)=DFN,DA=+ON D ^DIE
 . S X=$P(^PS(55,DFN,5,+ON,0),"^",20),$P(^(0),"^",20)="" K:X ^PS(55,"AUDDD",X,DFN,+ON) ;Removed cross reference after reinstate order.
 . D URA(1),EN1^PSJHL2(DFN,"SC",ON,"AUTO REINSTATED (CPRS)")
 Q
IRA(STAT) ;
 S ON55=ON,P(17)="A",PSIVREA="AI",PSIVALCK="STOP",(PSIVOPT,PSIVALT)=1,PSJUNDC=1,PSIVAL="AUTO REINSTATED (CPRS)"
 D LOG^PSIVORAL
 Q
URA(STAT) ;
 S PSGAL("C")=18560 D ^PSGAL5
 Q
