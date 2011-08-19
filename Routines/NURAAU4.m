NURAAU4 ;HIRMFO/MD-DRIVER FOR ACUITY COUNTS...(count) ;2/27/98  14:21
 ;;4.0;NURSING SERVICE;**9**;Apr 25, 1997
HSKEEP2 ; SET VARIABLES AND CHECK FOR DISRUPTED PROCESS
 S U="^",OUTSW=0 F X=1:1:4 S OUTSW(X)=0
 ; CHECK STATUS OF DATE NODE -- NUROUTSW='1' (stop job), '0' (run job)
 S DATENODE=$G(^DIC(213.9,1,"DATE"))
 I +$G(DATENODE)>DT S NUROUTSW=1 Q
 I +$G(DATENODE)=DT,$P(DATENODE,U,2)=1 S OUTSW=1 ;day shift completion
 I +$G(DATENODE)=DT,$P(DATENODE,U,6)=1 S OUTSW(1)=1 ;evening shift completion
 I +$G(DATENODE)=DT,$P(DATENODE,U,10)=1 S OUTSW(2)=1 ;night shift completion
 I +$G(DATENODE)=DT,$P(DATENODE,U,9)=1 S OUTSW(3)=1 ;separation/activation job completion
 I +DATENODE=DT,OUTSW,OUTSW(1),OUTSW(2),OUTSW(3) S OUTSW(4)=1 Q  ; quit if processing is up-to-date
 I 'OUTSW S DFN(0)=$S($P(DATENODE,U,4)>0:$P(DATENODE,U,4)-1,1:0),NWARD(0)=$S($P(DATENODE,U,3)>0:$P(DATENODE,U,3)-1,1:0) ;get last day shift patient and ward processed
 E  S (NWARD(0),DFN(0))=0
 I 'OUTSW(1) S DFN(1)=$S($P(DATENODE,U,8)>0:$P(DATENODE,U,8)-1,1:0),NWARD(1)=$S($P(DATENODE,U,7)>0:$P(DATENODE,U,7)-1,1:0) ; get last evening shift patient and ward processed
 E  S (NWARD(1),DFN(1))=0
 I 'OUTSW(2) S DFN(2)=$S($P(DATENODE,U,12)>0:$P(DATENODE,U,12)-1,1:0),NWARD(2)=$S($P(DATENODE,U,11)>0:$P(DATENODE,U,11)-1,1:0) ;get last night shift patient and ward processed
 E  S (NWARD(2),DFN(2))=0
 S $P(^DIC(213.9,1,"DATE"),U,2,12)=0_U_NWARD(0)_U_DFN(0)_U_U_0_U_NWARD(1)_U_DFN(1)_U_0_U_0_U_NWARD(2)_U_DFN(2)
 Q
