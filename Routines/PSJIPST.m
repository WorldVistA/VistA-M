PSJIPST ;BIR/CML3-POST INIT DRIVER ;11 DEC 97 / 3:11 PM 
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
 D MES^XPDUTL(" ")
 S PSJIPSTF=1 D NOW^%DTC D YX^%DTC S PSJMESSG="POST-INIT STARTED AT "_Y_" ...." D MES^XPDUTL(PSJMESSG)
 ;
 ;Set flags and skip conversions if virgin install.
 I $D(PSGINITF) D
 .D NOW^%DTC S ^PS(59.7,1,20.5)=%_"^"_%_"^"_%_"^"_% D:XPDQUES("POS1")=1 VIRGIN
 D ^PSJIPSTA
 ;
 ; Connect movement event driver
 D:'$P($G(^PS(59.7,1,20.5)),U,2) START^PSJIPST1
 ;
 ; Do Unit Dose Order Sets conversion
 D:'$P($G(^PS(59.7,1,20.5)),U,4) 111^PSJIPST3
 ;
UPF ; update package file, if necessary .... took this code out
DONE ;
 F X="AUDDD","AUDAPM","ALCNVRT" S ^PS(55,X)=+$P($T(PSJIPST+1),";",3)
 ;
 ; Queue 5.0 order conversion.
 ; called from OERR now
 ;D:('$P($G(^PS(59.7,1,20.5)),U,2))&('$D(PSGINITF)) ENORDER^PSJIPST1,ENIVKV^PSGSETU
 ;
 ; Queue 5.0 pick list conversion.
 D:'$P($G(^PS(59.7,1,20.5)),U,3) ENPL^PSJIPST1
 ; Queue 5.0 Unit Dose Verification conversion.
 D:'$P($G(^PS(59.7,1,20.5)),U) ENPVNV^PSJIPST2
 D SNMM,ENUPO
 D MES^XPDUTL(" ")
 D NOW^%DTC S $P(^PS(59.7,1,20),"^",1,3)=+$P($T(PSJIPST+1),";",3)_"^"_%_"^"_DUZ,Y=% D YX^%DTC S PSJMESSG="POST-INSTALL COMPLETED AT "_Y_" ...." D MES^XPDUTL(PSJMESSG)
 ; fill in ^XTMP zero nodes
 N PSJDATE1,PSJDATE2
 D NOW^%DTC S PSJDATE1=X,X1=X,X2=7 D C^%DTC S PSJDATE2=X
 S ^XTMP("PSJ NEW PERSON",0)=PSJDATE2_"^"_PSJDATE1_"^"_"List of changed User Names in IV orders"
 Q
 ;
VIRGIN ; Queue process to mark all drugs as UD items (Virgin install only).
 K ZTSAVE,ZTSK S ZTRTN="ENMUD^PSJIPST1",ZTDTH=$H,ZTDESC="MARK ALL DISPENSE DRUGS AS UNIT DOSE ITEMS (INPATIENT MEDS POST-INSTALL)",ZTIO="" D ^%ZTLOAD
 S PSJMESSG="... the process to mark all ACTIVE drugs in your local drug file as Unit Dose items is"_$S($D(ZTSK):"",1:"NOT")_" queued." D MES^XPDUTL(PSJMESSG)
 I $D(ZTSK) D MES^XPDUTL(" (to start NOW). YOU WILL RECEIVE A MAILMAN MESSAGE WHEN THE TASK HAS COMPLETED.")
 Q
 ;
SNMM ;
 N PSG,XMY S XMSUB="INPATIENT MEDICATIONS "_$P($T(PSJIPST+1),";",3)_" INSTALL COMPLETED",XMY("MIMS,M@ISC-BIRM.VA.GOV")="",XMDUZ=DUZ,XMTEXT="PSG(",%H=$H D YX^%DTC
 S PSG(1,0)=" "
 S PSG(2,0)="  "_$P($$SITE^VASITE(),"^",2)_" HAS RUN THE INPATIENT MEDICATION V"_$P($T(PSJIPST+1),";",3)_" INSTALL"
 S PSG(3,0)="TO COMPLETION AS OF "_Y_"."
 N DIFROM D ^XMD K SITE Q
 ;
ENUPO ; update options when conversions done
 ;  get list of Pick List options IENs, these will not be enabled until
 ;  the end of the pick list conversion
 S PSJOPLIS="|"_+$O(^DIC(19,"B","PSJU PLDEL",0))_"|"
 S PSJOPLIS=PSJOPLIS_+$O(^DIC(19,"B","PSJU PLAPS",0))_"|"
 S PSJOPLIS=PSJOPLIS_+$O(^DIC(19,"B","PSJU PLPRG",0))_"|"
 S PSJOPLIS=PSJOPLIS_+$O(^DIC(19,"B","PSJU PLDP",0))_"|"
 S PSJOPLIS=PSJOPLIS_+$O(^DIC(19,"B","PSJU EUD",0))_"|"
 S PSJOPLIS=PSJOPLIS_+$O(^DIC(19,"B","PSJU PL",0))_"|"
 S PSJOPLIS=PSJOPLIS_+$O(^DIC(19,"B","PSJU RET",0))_"|"
 S PSJOPLIS=PSJOPLIS_+$O(^DIC(19,"B","PSJU PLRP",0))_"|"
 S PSJOPLIS=PSJOPLIS_+$O(^DIC(19,"B","PSJU PLATCS",0))_"|"
 S PSJOPLIS=PSJOPLIS_+$O(^DIC(19,"B","PSJU PLUP",0))_"|"
 D MES^XPDUTL("...removing the 'OUT OF ORDER' message from the Inpatient Medications options...")
 S Q1="PSJ" F  S Q1=$O(^DIC(19,"B",Q1)) Q:$E(Q1,1,3)'="PSJ"  F Q2=0:0 S Q2=$O(^DIC(19,"B",Q1,Q2)) Q:'Q2  D
 .S DIE="^DIC(19,",DA=Q2,DR="2///@" D:PSJOPLIS'[("|"_Q2_"|") ^DIE
 D MES^XPDUTL("...removing the 'DISABLE' message from the Inpatient Medications protocols...")
 S Q1="PSJ" F  S Q1=$O(^ORD(101,"B",Q1)) Q:$E(Q1,1,3)'="PSJ"  F Q2=0:0 S Q2=$O(^ORD(101,"B",Q1,Q2)) Q:'Q2  S DIE="^ORD(101,",DA=Q2,DR="2///@" D ^DIE
 ; if package is reinstalled and Pick list conversion has finished
 ; the options will be reactivated again
 D:$P($G(^PS(59.7,1,20.5)),U,3) ACTPK^PSJIPST2
 D PURG
 K DA,DIE,DR,PSJOPLIS,Q1,Q2,X,Y
 Q
PURG ; Place PURGE options as OUT OF ORDER     
 ; take this out later!!!!!!!  keeps users from using the purge options
 N NAME,IEN
 F NAME="PSJU PO PURGE","PSJI PURGE","PSJI PURGE ORDERS" S IEN=$O(^DIC(19,"B",NAME,0)) S DIE="^DIC(19,",DA=IEN,DR="2////TEMPORARILY UNAVAILABLE" D ^DIE K DIE
 Q
