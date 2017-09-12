ECX319PT ;ALB/JAP - Post-Install for ECX*3*19 ;January 28, 1999
 ;;3.0;DSS EXTRACTS;**19**;Dec 22, 1997
 ;
ADD729 ;** Add DSS Production Units to file #729
 ;ECXX is in format: CODE^^LONG DESCRIPTION^SHORT DESCRIPTION
 N ECXDA,DIE,DR,ECX,ECXX,DIC,DA,X,Y,A1,A3,A4
 S ECXDA=$O(^ECX(729,999),-1)
 D MES^XPDUTL(" ")
 I (ECXDA<77)!(ECXDA>100) D  Q
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL(" WARNING: There is a problem in file #729.")
 .I ECXDA<77 D MES^XPDUTL(" Too few records.")
 .I ECXDA>100 D MES^XPDUTL(" Too many records.")
 .D MES^XPDUTL(" Nothing added...")
 .D MES^XPDUTL(" ")
 I ECXDA=100,$P(^ECX(729,100,0),U,1)="5I" D
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL(" It appears that ECX*3*19 has already been installed.")
 .D MES^XPDUTL(" But file #729 will be checked and updated as needed.")
 .D MES^XPDUTL(" ")
 I ECXDA'=100,ECXDA>77,ECXDA<101 D
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL(" There appears to be some problem in file #729.")
 .D MES^XPDUTL(" The file will be updated and should correct this.")
 .D MES^XPDUTL(" ")
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" Adding entries to DSS PRODUCTION UNIT File (#729)...")
 D MES^XPDUTL(" ")
 S $P(^DD(729,.01,0),U,5)=""
 F ECX=1:1 S ECXX=$P($T(NEW729+ECX),";;",2) Q:ECXX="QUIT"  D
 .S ECXDA=$P(ECXX,";",1),ECXX=$P(ECXX,";",2)
 .I $D(^ECX(729,0)),'$D(^ECX(729,ECXDA,0)) D  Q
 ..S A1=$P(ECXX,U,1),A3=$P(ECXX,U,3),A4=$P(ECXX,U,4)
 ..S DINUM=ECXDA
 ..S X=A1,DIC="^ECX(729,",DLAYGO=729,DIC(0)="LX",DIC("DR")="1///^S X=A3;2///^S X=A4"
 ..K DD,DO D FILE^DICN K DLAYGO
 ..D MESS1
 .I $D(^ECX(729,ECXDA,0)) D  Q
 ..S A1=$P(ECXX,U,1),A3=$P(ECXX,U,3)
 ..S ^ECX(729,ECXDA,0)=ECXX
 ..S DIK="^ECX(729,",DA=ECXDA D IX^DIK K DA,DIK
 ..D MESS2
 S $P(^DD(729,.01,0),U,5)="K X"
 S $P(^ECX(729,0),U,3,4)="100^100"
 Q
 ;
MESS1 ;** Add message
 N ECXADMSG
 S ECXADMSG=" "_A1_" - "_A3
 D MES^XPDUTL(ECXADMSG)
 S ECXADMSG="     added as record #"_ECXDA_"."
 D MES^XPDUTL(ECXADMSG)
 D MES^XPDUTL(" ")
 Q
 ;
MESS2 ;** Update message
 N ECXADMSG
 S ECXADMSG=" Record #"_ECXDA_" updated as"
 D MES^XPDUTL(ECXADMSG)
 S ECXADMSG=" "_A1_" - "_A3_"."
 D MES^XPDUTL(ECXADMSG)
 D MES^XPDUTL(" ")
 Q
 ;
NEW729 ;production unit entries to add;;CODE^^LONG DESCRIPTION^SHORT DESCRIPTION
 ;;78;20^^GEM Ward^GEMWARD
 ;;79;21^^Geropsych Ward^GEROPSYWRD
 ;;80;22^^Inpatient GRECC Care^GREC INPT
 ;;81;29^^Hospice Ward^HOSPICEWRD
 ;;82;4A^^Psychiatry Residential Rehab Treatment Centers - General PRRTP^PRRTPGEN
 ;;83;4B^^Psychiatry Residential  Rehab Treatment Centers -  PRRP (PTSD)^PRRPPTSD
 ;;84;4C^^Psychiatry Residential Rehab Treatment Centers - SARRTP (Substance Abuse)^SARRTPSA
 ;;85;4D^^Psychiatry Residential Rehab Treatment Centers - CWTTR-HCMI^CWTTRHCMI
 ;;86;4E^^Psychiatry Residential Rehab Treatment Centers - CWTTR-Substance Abuse^CWTTRSA
 ;;87;4F^^Psychiatry Residential Rehab Treatment Centers - CWTTR-PTSD^CWTTRPTSD
 ;;88;4G^^Psychiatry Residential Rehab Treatment Centers - CWTTR General^PRRTCGEN
 ;;89;51^^Domiciliary (D) Routine^DOM ROUT
 ;;90;52^^Domiciliary - PTSD/PSU^DOM PTSD
 ;;91;53^^Domiciliary - SLU^DOM SLU 
 ;;92;54^^Domiciliary - CWT Inpatient^DOMCWTINP
 ;;93;56^^Domiciliary NHCU^DOM NHCU
 ;;94;57^^Domiciliary ITTP Intensive Transitional Trmt Prog^DOM ITTP
 ;;95;58^^Domiciliary Substance Abuse^DOMSUBABSE
 ;;96;59^^Domiciliary CRTU^DOMCRTU
 ;;97;5A^^Domiciliary Homeless^DOM HMLESS
 ;;98;5E^^Domiciliary Health Maintenance^DOMHLTHMNT
 ;;99;5F^^Domiciliary PSI Residential Rehab (Day) Program (PRRP)^PRRP
 ;;100;5I^^Domiciliary - Rehab^DOMREHAB
 ;;QUIT
