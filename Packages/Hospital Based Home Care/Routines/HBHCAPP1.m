HBHCAPP1 ; LR VAMC(IRMS)/MJT-HBHC called by HBHCAPPT, entry points:  START, ERROR, MAIL, EXIT ; Nov 1999
 ;;1.0;HOSPITAL BASED HOME CARE;**6,8,10,16**;NOV 01, 1993
START ; Initialization
 ; Set File Update in Progress Flag
 S $P(^HBHC(631.9,1,0),U,8)=1
 ; HBHC(634.2 killed to allow file update processing to run daily, any errors found in previous batch that haven't been corrected will be found again
 K ^HBHC(634.2) S ^HBHC(634.2,0)="HBHC VISIT ERROR(S)^634.2P^"
 ; Omit visits prior to 10/1/97, FY 1997 data did not include inpatient appointments, FY 1998 will, auto-queued job will only gather data for 7 days since HBHCFLAG is set in HBHCFILE
 K %DT S X="T"-($S($D(HBHCFLAG):($P(^HBHC(631.9,1,0),U,4)),1:7)) D ^%DT S HBHCBGDT=$S(Y<2970930.9999:2970930.9999,1:Y_.9999)
 D NOW^%DTC S (HBHCNOW,Y)=% X ^DD("DD") S HBHCDAT=Y
 ; Omit future dates from file update
 I $D(HBHCLSDT) S:HBHCLSDT>% HBHCLSDT=%
 ; Auto-queued option will not have HBHCLSDT defined
 I '$D(HBHCLSDT) S HBHCLSDT=%
 S HBHCDTE=HBHCBGDT_U_HBHCLSDT
 ; Cancel appointments in ^HBHC(632), & delete 'filed' records from ^HBHC(634) if outpatient encounter (^SCE(409.68)) entry no longer exists
 D ^HBHCCAN
 Q
ERROR ; Update HBHC Error(s) (634.2) file Error Message (3) & Outpatient Encounter (4) fields
 K DD,DO,DTOUT,DUOUT
 S DIC="^HBHC(634.2,",DIC(0)="L",X=HBHCDPT,DIC("DR")="3///^S X=HBHCMSG;4///^S X=HBHCOEP;5///^S X=HBHCAPDT;6///^S X=HBHCCLN" D FILE^DICN
 K HBHCMSG
 Q
MAIL ; Send mail message
 S TMP(1)="Please run Form Errors Report option for HBHC errors to correct.",XMDUZ="HBHC File Update Mail Group",XMSUB=$P(HBHCDAT,"@")_" HBHC File Update",XMY("INFO:G.HBH")="",XMTEXT="TMP("
 D ^XMD
 Q
EXIT ; Exit module
 D CLEAN^DILF
 ; HBHCFLAG set in ^HBHCFILE, to accommodate retaining these variables if not auto-queued job
 K:'$D(HBHCFLAG) HBHCDAT,HBHCDTE,HBHCNOW
 K DA,DD,DO,DIC,DIK,DTOUT,DUOUT,HBHC,HBHCAPDT,HBHCBGDT,HBHCBXRF,HBHCCLN,HBHCCNT,HBHCCPT,HBHCCPTL,HBHCDFN,HBHCDPT,HBHCDX,HBHCDXL,HBHCFLG,HBHCI,HBHCINFO,HBHCJ,HBHCK,HBHCMSG,HBHCNBR,HBHCOEP,HBHCONE,HBHCPCNT,HBHCPRV,HBHCPRV1,HBHCPRVL
 K HBHCSCE0,HBHCTOT,HBHCTXT,TMP,X,Y,%DT,%
 Q
