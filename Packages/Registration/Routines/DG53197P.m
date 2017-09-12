DG53197P ;ALB/JDS
 ;;5.3;Patient File;**197**;Aug 13, 1993
 S ^DD(2,.01,"DEL",999999,0)="D DEL^DPTLK2"
 N A S A=$$NEWCP^XPDUTL("DGNAME","POST^DG53197P","")
 Q
POST N Q,G,A,B,C,NAME,Q,DIE,DA,XPDIDTOT,DGUP
 S A=$$PARCP^XPDUTL("DGNAME"),Q="""",XPDIDTOT=27,DGUP=A
 S G="^DPT(""B"","_Q_A_Q_")" D MES^XPDUTL("Checking for Patients with space before comma")
 F  S G=$Q(@G) Q:G'[("B"_Q)  S A=$P(G,Q,4,5) Q:$A(A)>90  S:(DGUP'=$E(A)) B=$$UPCP^XPDUTL("DGNAME",$E(A,1,2)) D:(DGUP'=$E(A)) UPDATE^XPDID($A(A)-64) S DGUP=$E(A) I A[" ," D
 .S DA=+$P(A,Q_",",2),NAME=$P($G(^DPT(DA,0)),U)
 .I NAME[" ," D MES^XPDUTL(NAME) S NAME=$P(NAME," ,")_","_$P(NAME," ,",2,9) K DR S DR=".01////^S X=NAME",DIE=2 D ^DIE D MES^XPDUTL("Change to "_$P($G(^DPT(DA,0)),U))
