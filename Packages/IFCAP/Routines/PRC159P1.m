PRC159P1 ;VMP/RB-PURGE ALL DUPLICATE PRC(442,"AB" ORDER DATE REFERENCES 
 ;;5.1;IFCAP;**159**;Oct 01, 2009;Build 9
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;  Pre install routine in patch PRC*5.1*159 that will purge duplicate
 ;  entries in cross reference ^PRC(442,"AB") that were left 
 ;  unkilled when the order was edited on a subsequent date.
 ;;
 Q
START ;Kill off extraneous index xref left behind when using CHANGE EXISTING TRANSACTION NUMBER option
 N RMSTART,IEN442,RMEND,R0,R1,TOT,TOT1,TOT3,TOT4,TOT5,PRCODT,PRCODT0
 I $D(^XTMP("PRC159P1")) Q
 D NOW^%DTC S RMSTART=%
 S ^XTMP("PRC159P1","START COMPILE")=RMSTART
 S ^XTMP("PRC159P1","END COMPILE")="RUNNING"
 S ^XTMP("PRC159P1",0)=$$FMADD^XLFDT(RMSTART,120)_"^"_RMSTART
 S U="^",PRCODT=0,(TOT,TOT1,TOT3,TOT4,TOT5)=0
1 S PRCODT=$O(^PRC(442,"AB",PRCODT)),IEN442=0 G 5:PRCODT=""
2 S IEN442=$O(^PRC(442,"AB",PRCODT,IEN442)) G 1:IEN442=""
 S TOT=TOT+1
 I '$D(^PRC(442,IEN442,0)) D  G 2
 . S TOT4=TOT4+1
 . K ^PRC(442,"AB",PRCODT,IEN442)
 . S ^XTMP("PRC159P1","M0",IEN442,PRCODT)=""
 I '$D(^PRC(442,IEN442,1)) D  G 2
 . S TOT5=TOT5+1
 . K ^PRC(442,"AB",PRCODT,IEN442)
 . S ^XTMP("PRC159P1","M1",IEN442,PRCODT)=""
 S R0=$G(^PRC(442,IEN442,0)),R1=$G(^PRC(442,IEN442,1)),PRCODT0=$P(R1,U,15)
 I PRCODT'=PRCODT0 D
 . S TOT1=TOT1+1
 . K ^PRC(442,"AB",PRCODT,IEN442)
 . S ^XTMP("PRC159P1","D",IEN442,PRCODT)=PRCODT0
 G 2
 ;Insures that all file 442 entries have an 'AB' x-ref
5 S IEN442=0
6 S IEN442=$O(^PRC(442,IEN442)) G EXIT:IEN442=""
 I '$D(^PRC(442,IEN442,1)) G 6
 S R0=$G(^PRC(442,IEN442,0)),R1=$G(^PRC(442,IEN442,1)),PRCODT0=$P(R1,U,15)
 I 'PRCODT0 G 6
 I '$D(^PRC(442,"AB",PRCODT0,IEN442)) D
 . S TOT3=TOT3+1
 . S ^PRC(442,"AB",PRCODT0,IEN442)=""
 . S ^XTMP("PRC159P1","S",IEN442,PRCODT0)=$P(R0,U)
 G 6
EXIT ;
 D NOW^%DTC S RMEND=%
 S ^XTMP("PRC159P1","TOTALS")=TOT_U_TOT1_U_TOT3_U_TOT4_U_TOT5
 S ^XTMP("PRC159P1","END COMPILE")=RMEND
 W !!,"Number of assigned 'AB' cross references: ",TOT
 W !!,"Number of purged 'AB' x-ref with undefined node 0 in file 442: ",TOT4
 W !!,"Number of purged 'AB' x-ref with undefined node 1 in file 442: ",TOT5
 W !!,"Number of purged 'AB' x-ref with diff node 1 P.O. Date: ",TOT1
 W !!,"Number of created 'AB' x-ref for 442 orders missing P.O. Date x-ref: ",TOT3
 K %
 Q
