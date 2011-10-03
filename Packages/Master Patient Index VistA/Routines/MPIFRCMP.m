MPIFRCMP ;BPCIO/CMC-PUSHING CMOR TO ANOTHER SITE REMOTELY ;JUNE 23, 2004
 ;;1.0; MASTER PATIENT INDEX VISTA ;**36**;30 Apr 99
 ;
 ; Integration Agreements Utilized:
 ;
 ; ^DGCN(391.91   IA #2751
 ; AVAFC^VAFCDD01 IA #3493
 ;
 ; Create a new request to change CMOR when your site is the CMOR VIA
 ; Remote RPC from the MPI
 ;
EN(RETURN,ICN,NCMOR) ;
 ; RETURN - Array to return the value 1 if successfully created request
 ; or -1^error message
 ; ICN - ICN for the patient that the CMOR is being changed for
 ; NCMOR - Which site should be the new CMOR - Station #
 ;
 N DFN
 S DFN=$$GETDFN^MPIF001(+ICN)
 I +DFN<1 S RETURN="-1^No such ICN at site" Q
 I $$GETVCCI^MPIF001(DFN)<0 S RETURN="-1^Patient doesn't have a CMOR" Q
 I $$GETVCCI^MPIF001(DFN)'=$P($$SITE^VASITE(),"^",3) S RETURN="-1^This site is NOT the CMOR, can't push the CMOR somewhere else." Q
 N TMP,TCNT,TF
 S TF=0
 S TMP=$O(^DGCN(391.91,"APAT",DFN,"")) I $O(^DGCN(391.91,"APAT",DFN,TMP))="" S RETURN="-1^Patient isn't SHARED - CAN'T change CMOR" Q
 ;Pt is shared, but are they shared with another VAMC?
 S TMP="",TCNT=0 F  S TMP=$O(^DGCN(391.91,"APAT",DFN,TMP)) Q:TMP=""  D
 .N TP S TP=$$GET1^DIQ(4,TMP_",",13)
 .Q:TP'="VAMC"&(TP'="OC")&(TP'="M&ROC")&(TP'="RO-OC")
 .; ^ only valid types of TFs that can be a CMOR 
 .S TCNT=TCNT+1
 .I $$STA^XUAF4(TMP)=NCMOR S TF=1
 I TCNT<2 S RETURN="-1^Patient isn't SHARED with another VAMC - CAN'T change CMOR" Q
 I TF=0 S RETURN="-1^Site to be new CMOR is NOT a TF - Can't change CMOR" Q
 ; CHECK IF ALREADY OPEN/PENDING REQUEST
 N ENT,STOP,MPIFNM,REQNM
 S ENT=0,STOP=0 F  S ENT=$O(^MPIF(984.9,"C",DFN,ENT)) Q:ENT=""!(STOP)  D
 .I $P($G(^MPIF(984.9,ENT,0)),"^",6)<4 S STOP=1
 I STOP S RETURN="-1^There is already an open CMOR request for this patient" Q
 N DA,DIE,DR,DIK,Y,DIRUT,REQ,TDA,XX,WHO,PHONE
 S DA=$$ADD^MPIFNEW(),TDA=DA,PHONE=""
 S DIE="^MPIF(984.9,",DR=".04///`"_DFN D ^DIE
 S REQ=$P($G(^MPIF(984.9,DA,0)),"^")
 S XX="CMOR Push by MPI Data Quality Team",WHO=.5,PHONE="MPI DQ Team"
 S DIE="^MPIF(984.9,",DR="1.02///"_XX_";.02///`"_WHO_";.05///"_PHONE D ^DIE
 N TSITE S TSITE=$$IEN^XUAF4(NCMOR)
 S DIE="^MPIF(984.9,",DR=".07///`"_TSITE_";1.03///3;.09///`"_TSITE D ^DIE
 ;update site, type of action and cmor after approval
 ;
 I $$CHK^MPIFEDIT(DA) S RETURN="-1^This request is missing required data." Q
 ;
 S DR=".08////^S X=2;.06////^S X=2",DIE="^MPIF(984.9," D ^DIE S RETURN=1
 ; removed event queue due to delivery issues - this msg must be sent first followed by the actual change cmor msg.
 N ERR,MPIFHL7 S ERR="ERRS",MPIFHL7=""
 D EN^MPIFREQ("CMOR CHANGE REQUEST",DA,.ERR,MPIFHL7)
 ;
 ;NOW CHANGE CMOR AND SEND CHANGE CMOR MESSAGE
 N TEXT,DIR,DR,CMOR,TMP,ERROR
 S TEXT="Auto change - pushed CMOR",ERROR=0
 S DIE="^MPIF(984.9,",DA=TDA,DR=".06///^S X=4;3.01///^S X=TEXT"
 D ^DIE
 S CMOR=$P($G(^MPIF(984.9,TDA,0)),"^",7)
 I CMOR="" D  Q
 .S RETURN="-1^New CMOR Not Defined, PROBLEM WITH REQUEST"
 S TMP=$$CHANGE^MPIF001(DFN,CMOR)
 I +TMP<0 S ^DIE="^MPIF(984.9,",DA=TDA,DR=".06///^S X=1" D ^DIE Q
 D BROAD^MPIFCMOR(DA,.ERROR)
 Q
SYNC(RETURN,ICN) ;
 N DFN
 S DFN=$$GETDFN^MPIF001(ICN)
 I +DFN<0 S RETURN(1)="-1^ICN doesn't exist at this site" Q
 D AVAFC^VAFCDD01(DFN) ; trigger A08 msg
 S RETURN(1)=1
 Q
