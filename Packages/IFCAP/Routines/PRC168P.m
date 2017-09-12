PRC168P ;VMP/RB - PRCFA SUPERVISOR key setting/audit ;03/01/12
 ;;5.1;IFCAP;**168**;Oct 20, 2000;Build 3
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;;
 Q
START ;
 ;   Post install to set key PRCFA SUPERVISOR terminate setting
 ;   to 'NO" and audit to look for terminated employees having
 ;   PRCFA SUPERVISOR key.
 ;
 Q:$D(^XTMP("PRC168P"))
SETUP D NOW^%DTC S RMSTART=%,(T1,T2,T3)=0
 S ^XTMP("PRC168P","START COMPILE")=RMSTART
 S ^XTMP("PRC168P","END COMPILE")="RUNNING"
 S ^XTMP("PRC168P",0)=$$FMADD^XLFDT(RMSTART,120)_"^"_RMSTART
SET S CPOKEY=$O(^DIC(19.1,"B","PRCFA SUPERVISOR",0)) D:CPOKEY  I 'CPOKEY W !!,"** NO PRCFA SUPERVISOR KEY DEFINED AS IFCAP SECURITY KEY **" G EXIT
 . S R0=^DIC(19.1,CPOKEY,0)
 . S ^XTMP("PRC168P","KEY",0)=$P(R0,U,4)_U_"n"
 . S DA=CPOKEY,DIE="^DIC(19.1,",DR=".04///n" D ^DIE
AUDIT ;FIND EMPLOYEES IN ^VA(200) W/ KEY PRCFA SUPERVISOR
 S IEN=0,U="^"
1 S IEN=$O(^VA(200,IEN)) G EXIT:IEN=""!(IEN]"@")
 S R0=$G(^VA(200,IEN,0)) I R0="" S STS="X",T3=T3+1 D 3 G 1
2 S VAKEY=$O(^VA(200,IEN,51,"B",CPOKEY,0)) G 1:VAKEY=""!(VAKEY]"@")  D
 . S KR0=$G(^VA(200,IEN,51,VAKEY,0)) Q:$P(KR0,U)'=VAKEY
 . I $P(R0,U,11) S STS="T",T1=T1+1 D  D 3 Q
 .. S DA=VAKEY,DA(1)=IEN,DIK="^VA(200,"_DA(1)_",51," D ^DIK
 . S STS="A",T2=T2+1 D 3
 G 1
3 S ^XTMP("PRC168P",STS,IEN,0)=$P(R0,U)_U_$P(R0,U,11)
 Q
EXIT ;
 D NOW^%DTC S RMEND=%
 S ^XTMP("PRC168P","END COMPILE")=RMEND_U_T1_U_T2_U_T3
 W !!,"Number of TERMINATED employees with key PRCFA SUPERVISOR still assigned: ",T1
 W !!,"Number of ACTIVE employees with key PRCFA SUPERVISOR still assigned: ",T2
 W !!,"Number of employees with *NO* node 0 information: ",T3
 K RMEND,RMSTART,%,DR,DA,DIE,DIK,IEN,IENKEY,VAKEY,CPOKEY,T1,T2,T3,STS,R0,KR0
 Q
