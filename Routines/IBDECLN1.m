IBDECLN1 ;ALB/AAS - Clean up Data Qualifiers and Package interfaces ; 23-JUN-97
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**14**;APR 24, 1997
 ;
PROBLEM(PROBLEM) ; -- Find out if Problem is in PCE DIM NODE in 357.6
 ;
 ;   pce dim node should not equal problem
 N I,J
 S I=0,PROBLEM=0
 F  S I=$O(^IBE(357.6,I)) Q:'I  D
 . I $P($G(^IBE(357.6,I,12)),"^",1)="PROBLEM" D
 .. S PROBLEM=PROBLEM+1
 .. S PROBLEM(0,I)=""
 .. S PROBLEM(PROBLEM)=$P($G(^IBE(357.6,I,0)),"^",1)_" uses PROBLEM as the PCE DIM NODE"
 . S J=0
 . F  S J=$O(^IBE(357.6,I,13,J)) Q:'J  D
 .. I $P($G(^IBE(357.6,I,13,J,0)),"^",4)="PROBLEM" D
 ... S PROBLEM=PROBLEM+1
 ... S PROBLEM(0,I)=""
 ... S PROBLEM(PROBLEM)=$P($G(^IBE(357.6,I,0)),"^",1)_" uses PROBLEM as the PCE DIM NODE in the Allow. Qual. Multiple."
 ;
 Q
 ;
CLNSEL(TALK) ; -- Clean up selection list entries
 ; -- should be run after running clnqlf, will update the zzbad pointers
 ;
 N I,J,K,L,X,Y,CNT,CNT1,CNT2,NAME,QLF,QLFNAM,PI,PINAM,PINPUT,REALQLF,REALNAM,PROBLEM,SELNAM,BLKNAM,IBQUIT,DIC,DIE,DIK,DA,DR,FRM,FRMNAM,FRMTYPE
 S (CNT,CNT1,CNT2)=0
 ;
 D:TALK MES^XPDUTL("  ")
 D:TALK MES^XPDUTL(">>> Now checking the SELECTION LIST file for inappropriate Data Qualifiers.")
 ;
 ; -- Find out if Problem is in PCE DIM NODE in 357.6
 D PROBLEM(.PROBLEM)
 ;
 ; -- go through selection list file look at data qualifiers in
 ;    subcolumn multiple fields
 S I=0
 F  S I=$O(^IBE(357.2,I)) Q:'I  D
 . S CNT=CNT+1
 . S SELNAM=$P($G(^IBE(357.2,I,0)),"^",1)
 . S BLKNAM=$P($G(^IBE(357.1,+$P($G(^IBE(357.2,I,0)),"^",2),0)),"^",1)
 . S FRM=+$P($G(^IBE(357.1,+$P($G(^IBE(357.2,I,0)),"^",2),0)),"^",2)
 . S FRMNAM=$P($G(^IBE(357,+FRM,0)),"^",1)
 . S FRMTYPE=$P($G(^IBE(357,+FRM,0)),"^",13)
 . S PI=+$P($G(^IBE(357.2,I,0)),"^",11)
 . S PINPUT=+$P($G(^IBE(357.6,PI,0)),"^",13)
 . S PINAM=$P($G(^IBE(357.6,+$P($G(^IBE(357.2,I,0)),"^",11),0)),"^",1)
 . ;
 . S J=0
 . F  S J=$O(^IBE(357.2,I,2,J)) Q:'J  D
 .. S QLF=+$P($G(^IBE(357.2,I,2,J,0)),"^",9)
 .. Q:'QLF
 .. S QLFNAM=$P($G(^IBD(357.98,QLF,0)),"^",1)
 .. ;
 .. Q:$E(QLFNAM,1,6)'="ZZBAD-"
 .. S CNT1=CNT1+1
 .. S REALNAM=$P(QLFNAM,"ZZBAD-",2)
 .. Q:REALNAM=""
 .. S REALQLF=+$O(^IBD(357.98,"B",REALNAM,0))
 .. Q:'REALQLF
 ..;
 ..; -- don't change if uses Problem node
 .. I PROBLEM>0 I $D(PROBLEM(0,PI))!($D(PROBLEM(0,PINPUT))) D  Q
 ... D MES^XPDUTL("  ")
 ... D MES^XPDUTL(" >> The selection list "_SELNAM_" not updated, PCE DIM node set to PROBLEM")
 ..
 ..; -- now update the selection list to the real qualifier
 .. S CNT2=CNT2+1
 .. S $P(^IBE(357.2,I,2,J,0),"^",9)=REALQLF
 ..;
 ..D:TALK MESSAGE
 ;
 ; -- write out summary
 K X
 S X(1)=" ",X(2)=" >> Summary of Selection List Check:"
 D:TALK MES^XPDUTL(.X)
 K X
 S X(1)=" "
 S X(2)=" >> A total of "_CNT_" selection list"_$S(CNT=1:" was",1:"s were")_" checked."
 I CNT1=0 S X(3)="    No problems were found."
 I CNT1>0 S X(3)="    A total of "_CNT1_" problem"_$S(CNT1=1:" was",1:"s were")_" found and "_CNT2_" were corrected."
 D:TALK MES^XPDUTL(.X)
 Q
 ;
MESSAGE ; -- write out what happened
 N K,X,CLIN,CLNLST
 S CLNLST=""
 S CLIN="^TMP(""CLST"",$J)"
 D CLINICS^IBDFU4(FRM,CLIN)
 S X(1)="  "
 S X(2)=">>> Qualifier problem in Encounter form "_FRMNAM
 I FRMTYPE S X(2)=X(2)_" Number "_FRMTYPE
 I @CLIN@(0)=0 S X(3)="    This form was not used by clinics"
 I @CLIN@(0)>0 D
 . S X(3)="    This form is used in the following clinics:"
 . S K=0,J=3 F  S K=$O(@CLIN@(K)) Q:K=""  S CLNLST=CLNLST_", "_K D
 . . Q:$L(CLNLST)>55
 . . S J=J+1,X(J)="        "_CLNLST
 . . S CLNLST=""
 S X(J+1)="       In the "_BLKNAM_" Block"
 S X(J+2)="       In the "_SELNAM_" Selection List"
 S X(J+3)="       the qualifier of "_QLFNAM_" Changed to "_REALNAM
 D:TALK MES^XPDUTL(.X)
 Q
