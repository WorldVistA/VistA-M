IBCNSU ;ALB/AAS - INSURANCE UTILITY ROUTINE ;19-MAY-93
 ;;2.0;INTEGRATED BILLING;**28,103,371**; 21-MAR-94;Build 57
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
AB(IBCPOL,IBYR,IBASK) ; -- Return entry in Annual Benefits file
 ;  Input:  IBCPOL  = pointer to health insurance policy file
 ;          IBYR    = fileman internal date, Default = dt
 ;          IBASK   = 1 if want to ask okay to add new entry
 ;
 ; Output:  IBCAB   = pointer to Annual Benefits file if added, else null
 ;
 N DIR,IBCAB
 S IBCAB=""
 I $G(IBCPOL)="" G ABQ
 I $G(IBYR)="" S IBYR=DT
 ;S IBYR=$E(IBYR,1,3)_"0000"
 ;
 ; -- try to find entry for policy for year
 S IBCAB=$O(^IBA(355.4,"APY",IBCPOL,-IBYR,0))
 ;
 ; -- if no match add new entry
 I 'IBCAB D
 .I $G(IBASK) S DIR(0)="Y",DIR("A")="Are you adding a new Annual Benefits YEAR",DIR("B")="YES" D ^DIR I $D(DIRUT)!(Y<1) S VALMQUIT="" Q
 .S IBCAB=$$ADDB(IBCPOL,IBYR)
 .Q
ABQ Q IBCAB
 ;
ADDB(IBCPOL,IBYR) ; -- add entries to Annual Benefits file
 ;  Input:  IBCPOL  = pointer to health insurance policy file
 ;          IBYR    = fileman internal date, Default = dt
 ;
 ; Output:  IBCAB   = pointer to Annual Benefits file if added, else null
 ;
 N %DT,IBN1,IBCAB,DIC,DIE,DR,DA,DLAYGO,DO,DD
 S IBCAB=""
 I $G(IBCPOL)="" G ADDBQ
 I $G(IBYR)="" S IBYR=DT
 K DD,DO,DIC,DR S DIC="^IBA(355.4,",DIC(0)="L",DLAYGO=355.4
 ;
 ;S X=$E(IBYR,1,3)_"0000"
 S X=IBYR D FILE^DICN I +Y<0 G ADDBQ
 S (IBCAB,DA)=+Y,DIE="^IBA(355.4,",DR=".02////"_IBCPOL
 D ^DIE K DIC,DIE,DA,DR
ADDBQ Q IBCAB
 ;
CHIP(IBCDFND) ; -- convert node with no hip pointer to one with hip pointer
 ;   Input:  IBCDFND  = zeroth node of insurance type multiple
 ;                    = ^dpt(dfn,.312,ibcdfn,0)
 ;
 ;  Output:  IBCPOL   = pointer to policy file
 ;
 N IBCNS,IBGRP,IBGRNA,IBGRNU
 S IBCNS=+IBCDFND,IBGRNA=$P(IBCDFND,"^",15),IBGRNU=$P(IBCDFND,"^",3),IBGRP=0
 I IBGRNA'=""!(IBGRNU'="") S IBGRP=1
 S IBCPOL=$$HIP(IBCNS,IBGRP,IBGRNA,IBGRNU)
CHIPQ Q IBCPOL
 ;
HIP(IBCNS,IBGRP,IBGRNA,IBGRNU) ; -- find internal entry number in policy file
 ;  Input:  IBCNS  = pointer to ins co file
 ;          IBGRP  = 1 if group policy, 0 if not
 ;          IBGRNA = group name
 ;          IBGRNU = group number
 ;
 ; Output:  IBCPOL = pointer to policy file
 ;
 N %DT
 S IBCPOL=""
 I $G(^DIC(36,+$G(IBCNS),0))="" G HIPQ
 S IBGRP=+$G(IBGRP) ; if undefine, is not a group policy
 I 'IBGRP S IBCPOL=$$ADDH(IBCNS,IBGRP) G HIPQ
 ;
 S:$G(IBGRNU)="" IBGRNU="IB ZZZZZ"
 I IBGRNU'="IB ZZZZZ" S IBCPOL=$O(^IBA(355.3,"AGNU",IBCNS,IBGRNU,0))
 I IBCPOL,$P($G(^IBA(355.3,+IBCPOL,0)),"^",3)=IBGRNA G HIPQ ; match both
 ;
 S:$G(IBGRNA)="" IBGRNA="IB ZZZZZ"
 S IBCPOL=$O(^IBA(355.3,"AGNA",IBCNS,IBGRNA,0))
 I IBCPOL,$P($G(^IBA(355.3,+IBCPOL,0)),"^",4)=IBGRNU G HIPQ ; match both
 ;
 I 'IBCPOL S IBCPOL=$$ADDH(IBCNS,IBGRP) D
 .I IBGRNA="",IBGRNU="" Q
 .S:IBGRNA="IB ZZZZZ" IBGRNA="" S:IBGRNU="IB ZZZZZ" IBGRNU=""
 .S DA=IBCPOL,DIE="^IBA(355.3,",DR=".03////"_$$STRIP(IBGRNA,";")_";.04////"_$$STRIP(IBGRNU,";")
 .D ^DIE K DA,DR,DIC,DIE
HIPQ Q IBCPOL
 ;
ADDH(IBCNS,IBGRP,IBGNA,IBGNU) ; -- add entries to health insurance policy file (355.3)
 ;     Input:  IBCNS  = pointer to ins co file
 ;             IBGRP  = 1 if group policy, 0 if no
 ;
 ;    Output:  IBCPOL = pointer to policy file, if added else null
 ;
 N %DT,IBN1,IBCAB,DIC,DIE,DR,DA,DLAYGO,DO,DD
 S IBCPOL=""
 I $G(IBCNS)="" G ADDHQ
 K DD,DO,DIC,DR S DIC="^IBA(355.3,",DIC(0)="L",DLAYGO=355.3
 ;
 S X=IBCNS D FILE^DICN I +Y<0 G ADDHQ
 S (DA,IBCPOL)=+Y,DIE="^IBA(355.3,",DR=".02////"_+$G(IBGRP)
 I IBGRP=0,$G(DFN) S DR=DR_";.1////"_DFN
 I $D(IBGNU) S DR=DR_";.04///^S X=IBGNU"
 I $D(IBGNA) S DR=DR_";.03///^S X=IBGNA"
 D ^DIE K DA,DR,DIE,DIC
 I $G(IBCNTP)'="" S IBCNTP=IBCNTP+1
ADDHQ Q IBCPOL
 ;
ODELP(DFN,INS) ; -- can an insurance policy be deleted
 ; -- called by ^dd(2.312,0,"del",.01) and by ibcnsm
 ; -- input  dfn: ien of patient in file 2.
 ;           ins: ien of ins. co in file 36
 ;
 ; -- output      1 if no deletion allowed
 ;                 0 if deletion allowed
 N I,X,Y S X=0
 ;
 ; -- do not delete if any uncancelled bills
 S J=0 F  S J=$O(^DGCR(399,"AE",DFN,INS,J)) Q:'J  I $P(^DGCR(399,J,"S"),"^",17)="" S X=1 Q
ODELPQ Q X
 ;
STRIP(X,X1) ; -- strip characters from string
 ;    input:  x  = string
 ;            x1 = character to strip (default is ";"
 N I,X2
 S X2="" S:$G(X1)="" X1=";"
 S X1=$E(X1)
 F I=1:1 S X2=X2_$P(X,X1,I) Q:($P(X,X1,I+1,999)'[X1)
 Q X2
 ;
 ;
DELP(DFN,INS,IBC) ; -- can an insurance policy be deleted
 ; -- called by ^dd(2.312,0,"del",.01) and by ibcnsm
 ; -- input  dfn: ien of patient in file 2.
 ;           ins: ien of ins. co in file 36
 ;           ibc: ien of policy in file 2.312 to do a match
 ;
 ; -- output      1 if no deletion allowed
 ;                0 if deletion allowed
 ;
 N ARR,J,ONEPOL,X
 ;
 ; - check input
 I '$G(DFN)!'$G(INS) S X=1 G DELPQ
 ;
 ; - see if vet has more than one policy with carrier; set flag
 ; - also, if no policy is passed, assume the patient has one policy
 I $G(IBC) D
 .S J=0  F  S J=$O(^DPT("AB",IBC,DFN,J)) Q:'J  S ARR(J)=$G(^DPT(DFN,.312,J,0))
 .S (J,ONEPOL)=0 S J=$O(ARR(J)) I J,'$O(ARR(J)) S ONEPOL=1
 E  S ONEPOL=1
 ;
 ;
 ; -- do not delete if any uncancelled bills
 S (J,X)=0 F  S J=$O(^DGCR(399,"AE",DFN,INS,J)) Q:'J  D  Q:X
 .;
 .N ARRP,POL,K,L,M,MP,S,Z
 .S Z=$G(^DGCR(399,J,0)),M=$G(^("M")),MP=$G(^("MP")),S=$G(^("S"))
 .;
 .; - skip cancelled bills
 .I $P(S,"^",17)'="" Q
 .;
 .; - set flag if the patient has just one policy with the company
 .I ONEPOL S X=1 Q
 .;
 .; - if there are no policy pointers in the claim,
 .I '$P(M,"^",12),'$P(M,"^",13),'$P(M,"^",14),'$P(MP,"^",2) D  Q
 ..;
 ..; - find all policies effective on the event date
 ..S K=0 F  S K=$O(ARR(K)) Q:'K  S POL=ARR(K) D
 ...I $P(POL,"^",8) Q:$P(Z,"^",3)<$P(POL,"^",8)
 ...I $P(POL,"^",4) Q:$P(Z,"^",3)>$P(POL,"^",4)
 ...S ARRP(K)=""
 ..;
 ..; - if there are two such policies, trust user judgement and assume
 ..; - policy is not related to this claim.
 ..S L=$O(ARRP(0)) I L,$O(ARR(L)) Q
 ..;
 ..; - if there is just one policy, and it is the same as the one
 ..; - passed in, do not allow deletion.
 ..I L=IBC S X=1
 .;
 .; - if one of the claim policy pointers is the same as the policy
 .; - passed in, do not allow deletion.
 .I $P(MP,"^",2)=IBC S X=1 Q
 .I $P(M,"^",12)=IBC!($P(M,"^",13)=IBC)!($P(M,"^",14)=IBC) S X=1
 ;
 ;
DELPQ Q X
 ;
DUPADDRL(DATA,IBCNS,FLD1,FLD2) ; Insurance address lines can not be duplicated
 ; DATA - Value being compared
 ; FLD1 - First field to check against
 ; FLD2 - Second field to check against (OPTIONAL)
 ;
 ; Returns 1 if this field is a duplicate of another field.
 ;
 N Z1,Z2
 Q:$G(DATA)="" 0  ; should not happen because this is invoked as an input transform
 Q:'$G(IBCNS) 1  ; stop from editing through fileman
 S DATA=$$UP^XLFSTR($G(DATA)),DATA=$$TRIM^XLFSTR(DATA)
 S Z1=$$GET1^DIQ(36,+$G(IBCNS),+$G(FLD1),"I")
 S Z1=$$UP^XLFSTR(Z1),Z1=$$TRIM^XLFSTR(Z1)
 S Z2=$$GET1^DIQ(36,+$G(IBCNS),+$G(FLD2),"I")
 S Z2=$$UP^XLFSTR(Z2),Z2=$$TRIM^XLFSTR(Z2)
 I DATA=Z1 D CLEAN^DILF Q 1
 I DATA=Z2 D CLEAN^DILF Q 1
 D CLEAN^DILF
 Q 0
 ;
