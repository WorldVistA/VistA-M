IBDECLN ;ALB/AAS - Clean up Data Qualifiers and Package interfaces ; 23-JUN-97
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**14,36**;APR 24, 1997
 ;
UPDATE(TALK) ; -- update both qualifiers and package interface file
 ; -- do the qualifiers first to rename bad ones
 ;
 ; -- input Talk, 1=send messages through mes^xpdutl (default is 1)
 ;                0=no messages
 ;
 S:$G(TALK)="" TALK=1
 S TALK=$TR(TALK,"yesnomaybe","YESNOMAYBE")
 S:$G(TALK)="YES" TALK=1
 S TALK=+$G(TALK)
 D CLNQLF(TALK),CLNPI(TALK)
 D CLNSEL^IBDECLN1(TALK)
 Q
 ;
CLNPI(TALK) ;
 ; -- update/delete Allowable Qualifiers in Package Interface file
 N I,J,K,L,X,Y,CNT,CNT1,CNT2,CNT3,CNT4,ENTRY,PI,QLF,NODE,FILE
 N IEN,PROBLEM,QLFNODE,DATA,QLFNUM,NNODE,ONODE,NLEN,TOT
 K ^TMP($J,"IBDE CLN")
 S (CNT,CNT1,CNT2,CNT3,CNT4)=0
 ;
 S (X(1),X(3))="  "
 S X(2)=">>> Now checking the PACKAGE INTERFACE file for inappropriate data qualifiers."
 D:TALK MES^XPDUTL(.X)
 ;
 ; -- build array of input package interfaces and qualifiers
 ;    sent out with version 3.0
 S I=0
 F I=1:1 S ENTRY=$P($T(OUTPUT+I^IBDECLN2),";;",2) Q:ENTRY=""  D
 . I $E(ENTRY)="~" Q
 . I $E(ENTRY)'="+" D  Q
 .. S PI=$E($P(ENTRY,":",1),1,30)
 .. S DATA=$P(ENTRY,":",2)
 .. S ^TMP($J,"IBDE CLN",PI,12)=DATA
 . I $E(ENTRY)="+" D  Q
 .. S QLF=$E($P(ENTRY,":",1),2,99)
 .. S QLFNUM=+$O(^IBD(357.98,"B",$E(QLF,1,30),0))
 .. Q:QLFNUM=0
 .. S DATA=QLFNUM_$P(ENTRY,":",2)
 .. S ^TMP($J,"IBDE CLN",PI,"QLF",QLF)=DATA
 ;
 ; -- now go through the supported list of Package Interface entries
 ;    and make sure that the main PCE DIM data is correct (node 12)
 ;
 S PI=""
 F  S PI=$O(^TMP($J,"IBDE CLN",PI)) Q:PI=""  D
 . S (J,K)=0
 . F  S J=$O(^IBE(357.6,"B",PI,J)) Q:'J  D
 .. S NNODE=$G(^TMP($J,"IBDE CLN",PI,12))
 .. Q:NNODE=""
 .. S ONODE=$G(^IBE(357.6,J,12))
 .. S NLEN=$L(NNODE)
 .. I $E(ONODE,1,NLEN)'=NNODE D DEL(TALK,PI,J,K,20,NNODE,ONODE)
 ;
 ; -- now go through the qualifiers for the package interface
 ;    and make sure that only supported qualifiers are listed, 
 ;    no duplicates, and that the data is correct.
 ;
 S PI=""
 S (CNT1,CNT3)=0
 F  S PI=$O(^TMP($J,"IBDE CLN",PI)) Q:PI=""  D
 . S (J,K)=0
 . F  S J=$O(^IBE(357.6,"B",PI,J)) Q:'J  D
 .. N CNT1,ONODE,NNODE,PIQLF
 .. S K=0
 .. F  S K=$O(^IBE(357.6,J,13,K)) Q:K=""  D
 ... ;
 ... S ONODE=$G(^IBE(357.6,J,13,K,0)) Q:ONODE=""
 ... S FILE=$P($P(ONODE,"^",1),";",2)
 ... Q:FILE'="IBD(357.98,"
 ... S IEN=+ONODE
 ... S QLF=$P($G(^IBD(357.98,IEN,0),"UNKNOWN"),"^",1)
 ... S PIQLF(QLF)=""
 ... ;
 ... ; -- now if there is a duplicate, delete the duplicate
 ... S NNODE=$G(^TMP($J,"IBDE CLN",PI,"QLF",QLF))
 ... I NNODE="" D DEL(TALK,PI,J,K,1) Q
 ... S CNT1(PI,QLF)=$G(CNT1(PI,QLF))+1
 ... I CNT1(PI,QLF)>1 D DEL(TALK,PI,J,K,2) Q
 ... ;
 ... S NLEN=$L(NNODE)
 ... I $E(ONODE,1,NLEN)'=NNODE D DEL(TALK,PI,J,K,21,NNODE,ONODE)
 .. ; --check to see if all allowable qualifiers exist if not, add
 .. S QLF="" F  S QLF=$O(^TMP($J,"IBDE CLN",PI,"QLF",QLF)) Q:QLF']""  D
 ... N FILE,DATA,IBDFDA,QLFNODE,NIEN,ERROR
 ... Q:$D(PIQLF(QLF))
 ... S FILE=357.613,IBDFDA(1)=J
 ... S QLFNODE=$G(^TMP($J,"IBDE CLN",PI,"QLF",QLF))
 ... S DATA(.01)=$P(QLFNODE,"^")
 ... Q:DATA(.01)=""
 ... S NIEN=$$ADD^IBDFDBS(FILE,.IBDFDA,.DATA,.ERROR)
 ... D:+NIEN>0 DEL(TALK,PI,J,NIEN,22,QLFNODE)
 ;
 G:'TALK END
 ;
 ; -- Find out if Problem is in PCE DIM NODE in 357.6
 ;    if so, then user is warned to contact customer service
 ;    to be manually corrected
 D PROBLEM^IBDECLN1(.PROBLEM)
 I PROBLEM>0 D
 . S X(1)="  ",X(2)=" >> WARNING: The following interfaces use the PROBLEM node to transmit data"
 . D:TALK MES^XPDUTL(.X)
 . S I=0 ;skip the zero node, contains PI stuff
 . F  S I=$O(PROBLEM(I)) Q:I=""  D:TALK MES^XPDUTL("    Package Interface "_PROBLEM(I))
 . D:TALK MES^XPDUTL("    Contact Customer Support for assistance updating the package interface file.")
 ;
 ;
SUM ; -- summary of package interface file check
 K X
 S TOT=2
 S X(1)=" "
 S X(2)=" >> Summary of the Package Interface Check:"
 ;
 I CNT<1,CNT2<1,CNT3<1,CNT4<1 D
 . S TOT=TOT+1,X(TOT)="    No required changes were found."
 ;
 I CNT>0 D
 . S TOT=TOT+1
 . S X(TOT)="    A total of "_CNT_" qualifier"_$S(CNT=1:" was",1:"s were")_" removed from Package Interface Entries."
 ;
 ;
 I CNT2>0 D
 . S TOT=TOT+1
 . S X(TOT)="    The PCE DIM data fields for "_CNT2_" Package Interface"_$S(CNT2=1:" was",1:"s were")_" updated."
 ;
 I CNT3>0 D
 . S TOT=TOT+1
 . S X(TOT)="    The PCE DIM data fields for "_CNT3_" Allowable Qualifier"_$S(CNT3=1:" was",1:"s were")_" updated."
 ;
 I CNT4>0 D
 . S TOT=TOT+1
 . S X(TOT)="    A total of "_CNT4_" Allowable Qualifier"_$S(CNT4=1:" was",1:"s were")_" added."
 I PROBLEM>0 D
 . S TOT=TOT+1,X(TOT)="    Contact Customer Support for assistance updating the package interface file."
 ;
 D:TALK MES^XPDUTL(.X)
 ;
END K ^TMP($J,"IBDE CLN")
 Q
 ;
DEL(TALK,PI,J,K,REASON,NNODE,ONODE) ; -- delete inappropriate entries
 ;
 ;  reasons for deletion or warnings
 ;  1- invalid qualifier
 ;  2- duplicate qualifier
 ;  9- bad qualifier, not deleted, user warned
 ;  20-node ^IBE(357.6,IEN,12) not correct
 ;  21-node ^IBE(357.6,IEN,13,allow qual,0) not correct
 ;
 N I,X,Y,DA,DIC,DIK
 I (REASON=1!(REASON=2)) S CNT=CNT+1
 S CNT(PI)=+$G(CNT(PI))+1
 I CNT(PI)=1 D
 . S X(1)=" ",X(2)="    The Package Interface "_PI_" had: "
 . D:TALK MES^XPDUTL(.X) N X
 D:(TALK&(REASON=1)) MES^XPDUTL("       an invalid qualifier of "_QLF_" deleted.")
 D:(TALK&(REASON=2)) MES^XPDUTL("       a duplicate qualifier of "_QLF_" deleted.")
 I TALK&(REASON=9) D MES^XPDUTL("       a bad qualifier of "_QLF_" not deleted, PCE DIM NODE='PROBLEM'") Q  ;don't delete, save for manual update
 ;
 I REASON<10 S DA=K,DA(1)=J,DIK="^IBE(357.6,"_DA(1)_",13," D ^DIK Q
 ;
 I TALK&(REASON=20) D
 . N X
 . S X(1)="       The PCE Device Interface Data Updated."
 . S X(2)="          Old Data: "_ONODE
 . S X(3)="          New Data: "_NNODE
 . D:TALK MES^XPDUTL(.X)
 . S CNT2=CNT2+1
 . S ^IBE(357.6,J,12)=NNODE
 ;
 I TALK&(REASON=21) D
 . N X
 . S X(1)="       The PCE Device Interface Data for the Data Qualifier "_QLF_" was updated."
 . S X(2)="          Old Data: "_ONODE
 . S X(3)="          New Data: "_NNODE
 . D:TALK MES^XPDUTL(.X)
 . S CNT3=CNT3+1
 . S ^IBE(357.6,J,13,K,0)=NNODE
 ;
 I TALK&(REASON=22) D
 . S CNT4=CNT4+1
 . D MES^XPDUTL("       "_QLF_" was added.")
 . S ^IBE(357.6,J,13,K,0)=NNODE
 Q
 ;
CLNQLF(TALK) ;
 ; -- update codes in AICS DATA QUALIFIERS file (357.98)
 ;    according to version 3.0
 N I,J,K,L,X,Y,CNT,CNT1,CNT2,CNT3,ENTRY,NAME,CODE,NEWNAME,IBQUIT,DIC,DIE,DIK,DA,DR
 S (CNT,CNT1)=0,CNT2=1
 ;
 S (X(1),X(3))="  "
 S X(2)=">>> Now checking the AICS DATA QUALIFIERS file for inappropriate entries."
 D:TALK MES^XPDUTL(.X)
 ;
 ; -- Go through AICS Data Qualifiers and set up correctly
 F I=1:1:28 S ENTRY=$P($T(DATA+I),";;",2) Q:ENTRY=""  D
 . S CNT=CNT+1
 . S NAME=$P(ENTRY,"^",1)
 . S CODE=$P(ENTRY,"^",2)
 . S J=""
 . F  S J=$O(^IBD(357.98,"B",NAME,J)) Q:J=""  D
 .. I $P($G(^IBD(357.98,J,0)),"^",2)=CODE Q
 .. ;
 .. ; -- don't change Active=1 and Inactive=0 if Problem
 .. I $P($G(^IBE(357.6,J,12)),"^",1)="PROBLEM",NAME="ACTIVE"!(NAME="INACTIVE") D  Q:IBQUIT
 ... S IBQUIT=0
 ... I NAME="ACTIVE",($P($G(^IBD(357.98,J,0)),"^",2)=1) D
 ....S IBQUIT=1
 ....D MES^XPDUTL("    The qualifier ACTIVE with a code of 1 needs to be changed but is used.")
 ... I NAME="INACTIVE",($P($G(^IBD(357.98,J,0)),"^",2)=0) D
 ....S IBQUIT=1
 ....D MES^XPDUTL("    The qualifier of INACTIVE with a code of 0 needs to be changed but is used.")
 ..
 .. ; -- keep track of what was changed
 .. S CNT(NAME)=$G(CNT(NAME))+1
 .. S CNT1=CNT1+1,CNT2=CNT2+1
 .. S CNT3(CNT2)="    The Entry "_$G(^IBD(357.98,J,0))_" changed to ZZBAD-"_ENTRY
 .. ;
 .. ; -- see if it's used
 .. S K=0 F  S K=$O(^IBE(357.6,K)) Q:'K  I $D(^IBE(357.6,K,13)) D
 ... S L=0 F  S L=$O(^IBE(357.6,K,13,L)) Q:'L  I $P($G(^IBE(357.6,K,13,L,0)),"^",1)=(J_";IBD(357.98,") D
 .... S CNT2=CNT2+1
 .... S CNT3(CNT2)="       and was used by Package File entry "_$P($G(^IBE(357.6,K,0)),"^",1)
 .. ;
 .. ; -- finally, make the change
 .. S NEWNAME=$E("ZZBAD-"_$P(^IBD(357.98,J,0),"^",1),1,30)
 .. S DIE="^IBD(357.98,",DA=J,DR=".01////^S X=NEWNAME;.02////^S X=CODE"
 .. N I,J,K,L,X,Y D ^DIE K DIE,DA,DR
 ;
 ;
 ; -- reindex the file
 S DIK="^IBD(357.98,"
 D IXALL^DIK
 ;
 ; summary of the aics data qualifiers check
 ;
 K X
 S X(1)=" ",X(2)=" >> Summary of the AICS Data Qualifiers Check:"
 D:TALK MES^XPDUTL(.X)
 K X
 I $G(CNT1)>0 M X=CNT3 S X(1)="    The number of changes made was "_CNT1
 I CNT1=0 S X(1)="    No required changes were found.",X(2)=" "
 I CNT1>1 S (X(CNT2+1),X(CNT2+3))=" ",X(CNT2+2)=" >> Done updating the AICS DATA QUALIFIERS file"
 D:TALK MES^XPDUTL(.X)
 Q
 ;
DATA ;;
 ;;NONE APPLICABLE^ 
 ;;PRIMARY^P^P
 ;;SECONDARY^S^S
 ;;ACTIVE^A^A
 ;;INACTIVE^I^I
 ;;HISTORICAL^H
 ;;ADD TO PROBLEM LIST^1^ADD
 ;;SERVICE CONNECTED^1^SC
 ;;AGENT ORANGE RELATED^1^AO
 ;;IONIZING RADIATION RELATED^1^IR
 ;;ENVIRONMENTAL CONTAMINANTS RELATED^1^EC
 ;;MILITARY SEXUAL TRAUMA^1^MST
 ;;ABNORMAL RESULT^A^ABNORM
 ;;NORMAL RESULT^N^NORM
 ;;POOR UNDERSTANDING^1^POOR
 ;;FAIR UNDERSTANDING^2^FAIR
 ;;GOOD UNDERSTANDING^3^GOOD
 ;;UNDERSTANDING NOT ASSESSED^4^N/A
 ;;PATIENT ED REFUSED^5^REFUSED
 ;;MINIMAL SEVERITY^M^MINIMAL
 ;;MODERATE SEVERITY^MO^MODERATE
 ;;HEAVY SEVERITY^H^SEVERE
 ;;YES^1^YES
 ;;NO^0^NO
 ;;CONTRAINDICATED^1^CONTRA.
 ;;GIVEN^0^GIV
 ;;REFUSED^1^REFUSED
 ;;NON-SERVICE CONNECTED^0^NSC
 ;;NO CLASSIFICATIONS^1^NO CLASSIF
 ;;
