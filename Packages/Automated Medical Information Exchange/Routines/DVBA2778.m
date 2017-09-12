DVBA2778 ;DLS/DEK - PATCH DRIVER ; 10/21/04
 ;;2.7;AMIE;**78**;Apr 10, 1995
 ; DBIA#  External Reference(s)
 ;  2053  FILE^DIE
 ; 10141  BMES^XPDUTL, MES^XPDUTL
SET S (C,I,J)=0,K=396.18 Q
PRE D SET,DEACT,KILL Q
POST D SET,FIXUP,KILL Q
KILL D:J B(">>>   Review the following errors   <<<"),SHO
 K C,I,J,K,NM,IEN,FD,^TMP("DIERR",$J),^TMP("DVBA",$J)
 Q
B(X) S X=" "_$G(X)
 I '$D(XPDNM) W !!,X Q
 D BMES^XPDUTL(X)
 Q
DEACT ;Deactivate forms
 F  S I=$O(^DVB(K,I)) Q:'I  D
 .S IEN=I_","
 .D CD(3041125,3)
 Q
CD(D,F) ;Change data
 S FD(K,IEN,F)=D
 S FD(K,IEN,7)=$S(F=2:1,1:0)
 S:F=2 FD(K,IEN,3)="@"
 D FILE^DIE(,"FD")
 I $D(^TMP("DIERR",$J)) D
 .S J=J+1
 .M ^TMP("DVBA",$J,J)=^TMP("DIERR",$J)
 Q
FIXUP ;Adjust zero-node
 F  S I=$O(^DVB(K,I)) Q:'I  S C=C+1
 S I=$O(^DVB(K,"A"),-1),$P(^DVB(K,0),U,3,4)=I_U_C
 ;Adjust forms
 F I=0:0 S I=$O(^DVB(K,I)) Q:'I  D
 .S NM=^(I,0),C=$P(NM,"~",2),IEN=I_","
 .D:C=78 CD(3041205,2)
 Q
SHO I $D(XPDNM) D  Q
 .K C
 .M C=^TMP("DVBA",$J)
 .D MES^XPDUTL(.C)
 S C=$Q(^TMP("DVBA",$J))
 F  Q:C=""  D
 .W !?3,@(C)
 .S C=$Q(@C)
 Q
