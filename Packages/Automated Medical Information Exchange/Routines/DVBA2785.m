DVBA2785 ;DLS/DEK - PATCH DRIVER ; 2/4/05
 ;;2.7;AMIE;**85**;Apr 10, 1995
 ; DBIA#  External Reference(s)
 ;  2051  $$FIND1^DIC
 ;  2053  FILE^DIE
 ; 10141  BMES^XPDUTL, MES^XPDUTL
S S (C,I,J)=0,K=396.18,PA=3050120,PD=3050115,PN="85",PP=78 Q
B D S,DF,K Q  ;Pre-Init (Before)
A D S,AD,K Q  ;Post-Init (After)
K D:J L(">>>   Review the following errors   <<<"),M
 K C,I,J,K,N,LN,PA,PD,PN,PP,NM,FD
 Q
L(X) ;Log
 S X=" "_$G(X)
 I $D(XPDNM) D BMES^XPDUTL(X) Q
 W !!,X
 Q
M ;Messages
 I $D(XPDNM) D
 .K C
 .M C=^TMP("DVBA",$J)
 .D MES^XPDUTL(.C)
 E  D
 .S C=$Q(^TMP("DVBA",$J))
 .F  Q:C=""  D
 ..W !?3,@(C)
 ..S C=$Q(@C)
 K ^TMP("DIERR",$J),^TMP("DVBA",$J),^TMP($J,"DVBA")
 Q
DF ;Deactivate Forms
 F  S I=$O(^DVB(K,I)) Q:'I  D CD(3,I)
 Q
CD(F,IEN) ;Change Data
 S IEN=IEN_","
 S FD(K,IEN,F)=$S(F=2:PA,1:PD)
 I F=3 D
 .S N=$G(^DVB(K,+IEN,2))
 .S:N=""!(PD<$P(N,U)) FD(K,IEN,2)="@"
 I F=2 D
 .S FD(K,IEN,3)="@",N=$G(^DVB(K,+IEN,0))
 .Q:$P(N,"~",2)=PP
 .D WP($G(^DVB(K,+IEN,1,1,0)))
 S FD(K,IEN,7)=$S(F=2:1,1:0)
 D FILE^DIE(,"FD")
 Q:'$D(^TMP("DIERR",$J))
 S J=J+1
 M ^TMP("DVBA",$J,J)=^TMP("DIERR",$J)
 Q
WP(T) Q:T=""
 S ^TMP($J,"DVBA",1)=$P(T," ",1,4)
 D WP^DIE(K,IEN,1,,"^TMP($J,""DVBA"")")
 Q:'$D(^TMP("DIERR",$J))
 S J=J+1
 M ^TMP("DVBA",$J,J)=^TMP("DIERR",$J)
 Q
DL(DA,DIE,DR) ;
 S DA=$$FIND1^DIC(K,,"O",DA)
 D:DA ^DIE
 Q
AD ;Adjust Data
 D DL("COLD INJURY PROTOCOL~85T1",K,".01///@")
 F I=0:0 S I=$O(^DVB(K,I)) Q:'I  D
 .S N=$P(^(I,0),"~",2),C=C+1
 .D:N=PN CD(2,I)
 S I=$O(^DVB(K,"A"),-1),$P(^DVB(K,0),U,3,4)=I_U_C
 ;Name-specific adjustments
 F I=1:1 S LN=$P($T(NS+I),";;",2) Q:LN=""  D
 .S NM=$P(LN,U),FD=$P(LN,U,2)
 .S C=$$FIND1^DIC(K,,"O",NM)
 .D:C CD(FD,C)
NS Q
 ;;GENERAL MEDICAL EXAMINATION~78^2
 ;;INITIAL EVALUATION FOR POST-TRAUMATIC STRESS DISORDER (PTSD)~78^2
 ;;MENTAL DISORDERS (EXCEPT PTSD AND EATING DISORDERS)~78^2
 ;;REVIEW EXAMINATION FOR POST-TRAUMATIC STRESS DISORDER (PTSD)~78^2
 ;;AUDIO~78^2
 ;;AUDIO~85^3
 ;;AUDIO~85T1^3
 ;;COLD INJURY PROTOCOL~85^3
 ;;
