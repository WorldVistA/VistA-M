SPNLGEAA ;ISC-SF/REM - RETRIEVE DATA FROM FILE 154 ;7/24/95  14:08
 ;;2.0;Spinal Cord Dysfunction;**2**;01/02/1997
 ;;
EXTRACT(RECN,FORMAT,FLAG) ;
 ;RECN...........This is the IEN of file 154.
 ;FORMAT.........This is determines whether the data will be in
 ;               internal or external format. (IS NOT USED IN THIS VERSION)
 ;FLAG...........This is set to 1 and error message text if there is an
 ;error retrieveing the data.
 ;               
 N REC,REC1,REC2,REC3,REC4,NLOIRN,ETRN,RECNN,SPNPHY
 K DIC,DIQ,SPNLDIQ
 I '$D(^SPNL(154,RECN,0)) S FLAG="1^NO ZERO NODE FOR RECORD "_RECN_" IN FILE 154" D END Q
 I '$P($G(^SPNL(154,RECN,"XMT")),U) D END Q
 S DIC="^SPNL(154,",DR=".02;.03;.05;1.1:3.3;999.03",DA=RECN,DIQ="SPNLDIQ",DIQ(0)="EI" D EN^DIQ1 K DIC,DIQ
 I $G(SPNLDIQ(154,DA,.03,"I"))="X" D END Q  ; Patient is dead
 S REC1=$G(SPNLDIQ(154,DA,.02,"I"))_U_$G(SPNLDIQ(154,DA,.05,"I"))_U_$G(SPNLDIQ(154,DA,.03,"I"))_U_""_U
 S SPNPHY="" I $O(^SPNL(154,DA,"REHAB",0)) D
 . S SPNPHY=$O(^SPNL(154,DA,"REHAB","B",""),-1)\1
 . I SPNPHY'?7N S SPNPHY=""
 . Q
 S REC1=REC1_SPNPHY_U_$G(SPNLDIQ(154,DA,999.03,"E"))
 S REC2=$G(SPNLDIQ(154,DA,2.3,"I"))
 S NLOIRN=$G(SPNLDIQ(154,DA,2.1,"I"))
 S REC4=$P($G(^SPNL(154.01,+NLOIRN,0)),U)
 I $O(^SPNL(154,RECN,"E",0)) D
 . S RECNN=0
 . F  S RECNN=$O(^SPNL(154,RECN,"E",RECNN)) Q:RECNN'>0  D
 .. S ETRN=$G(^SPNL(154,RECN,"E",RECNN,0))
 .. S REC3=$P(ETRN,U,2)_U_$P($G(^SPNL(154.03,+$P(ETRN,U),0)),U)_U_$P($G(^(0)),U,2)
 .. I +REC3 D ADDREC
 .. Q
 . Q
END K SPNLDIQ,DA,DR,NLOI
 Q
ADDREC ;
 ; REC = Registration_Date ^ Date_of_Last_Update ^ Registration_Status
 ;       SCD_Service_Connection ^  Last_Physical_Exam ^
 ;       Completeness_of_Injury ^ Information_Source_for_NLOI ^
 ;       Date_of_Onset ^ Etiology ^ Type_of_Cause ^
 ;       Highest_Level_of_Injury
 ;
 S REC=$G(REC1)_U_$G(REC2)_U_$G(REC3)_U_$G(REC4)
 D ADDREC^SPNLGE("AA",REC)
 Q
