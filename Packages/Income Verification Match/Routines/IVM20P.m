IVM20P ;ALB/CPM - IVM V2.0 POST INITIALIZATION ; 23-JUN-94
 ;;Version 2.0 ; INCOME VERIFICATION MATCH ;; 21-OCT-94
 ;
 D ENPAR ;         add parameter entry if necessary
 D MG ;            add IVM TRANSMISSIONS group, if necessary
 D MG1 ;           add IVM MESSAGES group
 D HL7^IVM20P1 ;   add/update HL7 parameters
 D MTCT ;          add new MT Changes Types to #408.42
 D IB ;            add new IB Action Status to #350.21
 D ^IVMONIT ;      install protocols
 D ^IVM20P2 ;      install list templates
 D ^IVM20P3 ;      update ^XUTL("XQORM" for IB protocols
 D SETPRIM ;       flag all Means Tests as the primary test
 D BULL^IVM20P1 ;  alert the IVM Center of the installation
 D PARDATE ;       set install date in #301.9
 ;
 ; Installation has completed - display final messages
 ;
 D NOW^%DTC S IVMEDT=$H
 W !!,">>> Initialization Complete at " S Y=% D DT^DIQ
 I $D(IVMBDT) D
 .S IVMDAY=+IVMEDT-(+IVMBDT)*86400 ;additional seconds of over midnight
 .S X=IVMDAY+$P(IVMEDT,",",2)-$P(IVMBDT,",",2)
 .W !,"    Elapse time for initialization was: ",X\3600," Hours,  ",X\60-(X\3600*60)," Minutes,  ",X#60," Seconds"
 ;
 W !!,"The installation of Income Verification Match Version 2.0 has completed."
 W !!,"Please be sure that the IVM nightly job (option IVM BACKGROUND JOB) is"
 W !,"scheduled to run.  If it is not, it should be scheduled to run early"
 W !,"each morning."
 W !!,"Be sure that it is not scheduled twice!!"
 ;
 W !!,"Remember to re-compile the cross reference routines for the INTEGRATED"
 W !,"BILLING ACTION (#350) and ANNUAL MEANS TEST (#408.31) files, using DIKZ,"
 W !,"on all of your systems."
 ;
 K IVMMIEN,IVMDIEN,IVMBDT,IVMEDT,IVMDAY,X,I
 Q
 ;
 ;
ENPAR ; Add an entry in the IVM SITE PARAMETER (#301.9) file.
 Q:$D(^IVM(301.9,1))  ; entry already exists
 W !!,">>> Creating an entry in the IVM SITE PARAMETER (#301.9) file... "
 S DIC="^IVM(301.9,",DIC(0)="",X=$P($$SITE^VASITE,"^",3)
 K DD,DO D FILE^DICN
 K %,DA,DIC,DIE,X,Y
 Q
 ;
MG ; Add mailgroup for IVM transmissions
 S X="IVM TRANSMISSIONS"
 S DIC="^XMB(3.8,",DIC(0)="L",DLAYGO=3.8
 D ^DIC S (DA,IVMMIEN)=+Y I '$P(Y,U,3) G MGQ
 W !!,">>> Adding IVM TRANSMISSIONS mailgroup for network transmissions..."
 S DIE=DIC,DR="4////PU;5////^S X=DUZ;7////n;3///^S X=""Contains members to receive IVM HL7 transmissions"";12///^S X=""S.HL SERVER@""_$S(IVMPROD:"""",1:""B"")_""IVM.VA.GOV"";"
 D ^DIE
MGQ K DA,DIC,DIE,DLAYGO,X,Y
 Q
 ;
MG1 ; Add mailgroup for IVM Messages
 S X="IVM MESSAGES"
 S DIC="^XMB(3.8,",DIC(0)="L",DLAYGO=3.8
 D ^DIC S (DA,IVMGPTR)=+Y I '$P(Y,U,3) G MG1Q
 W !!,">>> Adding IVM MESSAGES mailgroup for sending results of data transmissions..."
 S DIE=DIC,DR="4////PU;5////^S X=DUZ;7////n" D ^DIE
 S ^XMB(3.8,IVMGPTR,2,0)="^^3^3^"_DT_"^^^"
 S ^XMB(3.8,IVMGPTR,2,1,0)="This mail group will receive messages pertaining to erroneous data"
 S ^XMB(3.8,IVMGPTR,2,2,0)="transmitted to the IVM Center and for data to be uploaded from the IVM"
 S ^XMB(3.8,IVMGPTR,2,3,0)="Center."
 ;
 ; - update pointer in file #301.9
 S $P(^IVM(301.9,1,0),"^",2)=IVMGPTR
MG1Q K DA,DIC,DIE,DLAYGO,X,Y,IVMGPTR
 Q
 ;
MTCT ; Add entries to the MEANS TEST CHANGES TYPE (#408.42) file.
 I $O(^DG(408.42,"B","MEANS TEST UPLOAD",0)),$O(^DG(408.42,"B","UPLOADED MEANS TEST DELETION",0)) Q
 W !!,">>> Adding new entries to the MEANS TEST CHANGES TYPE (#408.42) file... "
 F IVMX="MEANS TEST UPLOAD","UPLOADED MEANS TEST DELETION" D
 .Q:$O(^DG(408.42,"B",IVMX,0))
 .S DIC="^DG(408.42,",DIC(0)="",DLAYGO=408.42,X=IVMX K DD,DO D FILE^DICN
 K %,DA,DIC,DLAYGO,IVMX,X,Y
 Q
 ;
PARDATE ; Set today's date into the parameter file.
 I '$P(^IVM(301.9,1,0),"^",6) S $P(^IVM(301.9,1,0),"^",6)=DT
 Q
 ;
IB ; Add new hold status in file #350.21.
 Q:$D(^IBE(350.21,21))
 W !!,">>> Adding a new status in the IB ACTION STATUS (#350.21) file... "
 S X="HOLD - REVIEW",DIC(0)="",DINUM=21,DLAYGO=350.21,DIC="^IBE(350.21,"
 D FILE^DICN S IBN=+Y
 I Y<0 W !,"    Unable to add new status!  Please contact your ISC." G IBQ
 S ^IBE(350.21,IBN,0)="HOLD - REVIEW^ON HOLD (REVIEW)^REVIEW^0^0^1"
 S DA=IBN,DIK="^IBE(350.21," D IX1^DIK
IBQ K X,DIC,DINUM,DLAYGO,DA,DIK
 Q
 ;
SETPRIM ; Set primary and source fields to 1 for all existing means tests.
 Q:+$G(^DD(301.5,0,"VR"))'<2
 W !!,">>> Initializing new ANNUAL MEANS TEST file (#408.31) fields for",!,"    existing entries as follows:"
 W !,"      SOURCE OF INCOME TEST (#.23) = VAMC (value = 1)",!,"      PRIMARY INCOME TEST FOR YEAR? (#2)= YES (value = 1)",!
 S DIE="^DGMT(408.31,",DR=".23////1;2////1"
 S DGMTI=0 F DGMTC=1:1 S DGMTI=$O(^DGMT(408.31,DGMTI)) Q:'DGMTI  S DA=DGMTI D ^DIE W:'(DGMTC#1000) "."
 K DA,DR,DIE,DGMTI,DGMTC
 Q
