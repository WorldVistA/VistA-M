SDVPT ;alb/mjk - SD Post-Init Driver ; 3/26/93
 ;;5.3;Scheduling;**5**;Aug 13, 1993
 ;
EN ; -- main entry point
 S XQABT4=$H
 I '$D(DGVREL) D VERS^DGVPP G ENQ:'$D(DGVREL)
 S DGVFLD=110 D TIME^DGVPR
 ;
 D LINE^DGVPP,EVTS                   ; protocols
 D LINE^DGVPP,LIST                   ; list templates
 D LINE^DGVPP,COMP                   ; list compiled templates
 D LINE^DGVPP,SC                     ; add/inactivate stop codes
 D EN^SDV53PT                        ; current version tasks
 D LINE^DGVPP,TASKS                  ; restore queued times
 S DGPACK="SD" D LINE^DGVPP,^DGVPT1  ; delete options
 D LINE^DGVPP
 ;
 D TIME^SDUTL S DGTIME=SDTIME,DGVFLD=111 D TIME1^DGVPR
 S $P(^DG(43,1,"SCLR"),U,5)=DGVNEW
 S XQABT5=$H
 S X="SDINITY" X ^%ZOSF("TEST") I $T D ^SDINITY
 W !!,*7,">>> Initialization of Version ",DGVNEWVR," of SD Complete."
ENQ G Q^SDVPP
 ;
EVTS ;Move SD Options to Protocol File
 S X="" D ^SDONIT
 Q
 ;
TASKS ; -- requeue tasked jobs
 I $O(DGTJ(0))'="" W !!,">>> Restoring queued jobs to original state...",! S DGEDIT=1 D RES^DGVPR1 K DGTJ
 K DA,DGI,DIC,DIE,DR,X,Y,DGEDIT
 Q
 ;
COMP ; -- list templates to re-compile
 W !!,">>> Remember to recompile the following templates on all CPU's..."
 W !!?4,"Template",?30,"Routine",?45,"Type",?55,"Routine Used to Recompile",!?4,"--------",?30,"-------",?45,"----",?55,"-------------------------"
 F I=1:1 S J=$P($T(TEMP+I),";;",2) Q:J="QUIT"  W !?4,$P(J,";",1),?30,$P(J,";",2),?45,$S($P(J,";",3)="I":"INPUT",1:"PRINT"),?64,$S($P(J,";",3)="I":"DIEZ",1:"DIPZ")
 W !!,"NOTE:  To recompile all PIMS compiled templates and compiled ",!?7,"cross-references you can call ALL^DGUTL1."
 Q
 ;
TEMP ;
 ;;SDB;SDBT;I
 ;;SDM1;SDM1T;I
 ;;SDAMBT;SDXA;I
 ;;SDXACSE;SDXACSE;I
 ;;SD ENCOUNTER ENTRY;SDAMXOE;I
 ;;SD-AMB-PROC-DISPLAY;SDXAMB;P
 ;;SD-AMB-PROC-LIST;SDXLST;P
 ;;SD-AMB-RAM-DISPLAY;SDXRAM;P
 ;;SDAMVLD;SDAMXLD;P
 ;;SDUL LIST TEMPLATE;SDULXP;P
 ;;QUIT
 ;
LIST ; -- add list templates
 W !!,">>> List Template installation..."
 D ^SDVLT
 Q
 ;
SC ; -- add/inactivate stop codes
 W !!,">>> Adding new clinic stops to CLINIC STOP FILE (#40.7)..."
 W !,"    [NOTE:  These stop codes CANNOT be used UNTIL 10/1/93]",!
 S DIC(0)="L",DIC="^DIC(40.7,"
 F DGX=1:1 K DD,DO,DA S DGXX=$P($T(SCS+DGX),";;",2) Q:DGXX="QUIT"  S DIC("DR")="1////"_$P(DGXX,"^",2)_$S('+$P(DGXX,U,5):"",1:";4////"_$P(DGXX,"^",5)),X=$P(DGXX,"^",1) I '$D(^DIC(40.7,"C",$P(DGXX,"^",2))) D FILE^DICN,MESS
 K DIC,DGXX
 ;
INAC W !!,">>> Inactivating clinic stops in CLINIC STOP CODE FILE (#40.7)..."
 W !,"    [NOTE:  These stop codes CANNOT be used AFTER 9/30/93]",!
 D NOW^%DTC S SDATE=X
 F DGX=1:1 K DD,DO,DA S DGXX=$P($T(INA+DGX),";;",2) Q:DGXX="QUIT"  S DGDA=+$O(^DIC(40.7,"C",DGXX,0)) I $D(^DIC(40.7,DGDA,0)) S DA=DGDA,DR="2////2931001",DIE="^DIC(40.7," D ^DIE,MESI
 K %,%H,%I,DGX,DGDA,DR,DA,DIE,SDATE
 ;
CHANGE W !!,">>> Changing clinic stop names in CLINIC STOP CODE FILE (#40.7)..."
 F DGX=1:1 K DD,DO,DA S DGXX=$P($T(CHNG+DGX),";;",2) Q:DGXX="QUIT"  I '$O(^DIC(40.7,"B",$P(DGXX,U,3),0)) S DGDA=+$O(^DIC(40.7,"B",$P(DGXX,U),0)) I $D(^DIC(40.7,DGDA,0)) S DA=DGDA,DR=".01///"_$P(DGXX,U,3),DIE="^DIC(40.7," D ^DIE,MESC
 K DGX,DGXX,DGDA,DIE,DR,DA Q
 ;
MESI W !?8,"...",$P(^DIC(40.7,DGDA,0),"^"),?40,"(",DGXX,") inactivated as of 10/1/93..."
 Q
 ;
MESS W !?8,"...",X,?40,"(",$P(DGXX,"^",2),") added..."
 Q
 ;
MESC W !?8,"...",$P(DGXX,U)_$P(DGXX,U,2),?44,"changed to ",!?11,$P(DGXX,U,3),"..."
 Q
 ;
SCS ;STOP CODES TO BE ADDED TO FILE
 ;;RADIONUCLIDE THERAPY^144^^^2612.00
 ;;PHARM/PHYSIO NMP STUDIES^145^^^2612.00
 ;;PET^146^^^2612.00
 ;;SCI HOME CARE PROGRAM^215^^^5112.00
 ;;GERIATRIC EVAL. & MGMT. (GEM)^319^^^2110.00
 ;;ALZHEIMER'S/DEMENTIA CLINIC^320^^^2110.00
 ;;GI ENDOSCOPY^321^^^2110.00
 ;;WOMEN'S CLINIC^322^^^2110.00
 ;;PROSTHETIC SERVICES^423^^^2614.00
 ;;SEXUAL TRAUMA COUNSELING^524^^^2311.00
 ;;INCENTIVE THERAPY^573^^^2310.00
 ;;COMPENSATED WORK THERAPY^574^^^2310.00
 ;;VOCATIONAL ASSISTANCE^575^^^2310.00
 ;;DOMICILIARY OUTREACH SERVCIES^725^^^5115.00
 ;;DOM AFTERCARE - COMMUNITY^726^^^5115.00
 ;;DOMICILIARY AFTERCARE - VA^727^^^2750.00
 ;;QUIT
 ;
INA ;STOP CODES TO BE INACTIVATED
 ;;511
 ;;559
 ;;QUIT
 ;
CHNG ;STOP CODES THAT ARE CHANGED
 ;;RECREATION SERVICE^ (202)^RECREATION THERAPY SERVICE
 ;;INCENTIVE THERAPY^ (207)^RMS INCENTIVE THERAPY
 ;;COMPENSATED WORK THERAPY^ (208)^RMS COMPENSATED WORK THERAPY
 ;;VOCATIONAL ASSISTANCE^ (213)^RMS VOCATIONAL ASSISTANCE
 ;;CORRECTIVE THERAPY^ (214)^KINESIOTHERAPY
 ;;CWT/ILH INDIVIDUAL^ (515)^CWT/TR-HCMI
 ;;CWT/ILH SUBSTANCE ABUSE^ (518)^CWT/TR-SUBSTANCE ABUSE
 ;;QUIT
