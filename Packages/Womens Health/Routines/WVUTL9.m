WVUTL9 ;HCIOFO/FT-Women's Health Utility Routine; ;3/18/03  15:44
 ;;1.0;WOMEN'S HEALTH;**3,7,9,10,17**;Sep 30, 1998
 ;
 ; This routine uses the following IAs:
 ; #10035 - ^DPT references        (supported)
 ; #10056 - ^DIC(5 references      (supported)
 ; #10061 - ^VADPT calls           (supported)
 ; #10103 - ^XLFDT calls           (supported)
 ;
DCM(SITE) ; Default case manager check
 ; If there is a default case manager return 1 else 0.
 I 'SITE Q 0
 I $P($G(^WV(790.02,SITE,0)),U,2) Q 1
 Q 0
 ;
NODCM ; No Default Case Manager message
 W !,"Sorry, but a DEFAULT CASE MANAGER must be assigned for your facility"
 W !,"before a patient can be entered into the Women's Health database.",!
 W !,"Please use the EDIT SITE PARAMETERS option on the FILE MAINTENANCE"
 W !,"menu to designate a DEFAULT CASE MANAGER.",!
 D DIRZ^WVUTL3
 Q
 ;
AGE(DFN) ;EP
 ;---> YIELD PATIENT'S AGE IN YEARS.
 ;---> REQUIRED VARIABLE: DFN=IEN PATIENT FILE
 ; Different from AGE^WVUTL1. This EP returns age at date of death.
 N X,X1,X2
 Q:'$G(DFN) "NO PATIENT"
 S X2=$$DOB^WVUTL1(DFN)
 Q:'+X2 "UNKNOWN"
 S X1=DT
 I $$DECEASED^WVUTL1(DFN) S X1=+^DPT(DFN,.35)
 D ^%DTC
 Q $P(X/365.25,".")_"y/o"
 ;
GAPPT(DFN) ; Get future appointments from SDA^VADPT
 ; Returns ^UTILITY("VASD",$J,#,"I") <-internal values
 ;         ^UTILITY("VASD",$J,#,"E") <-external vlaues
 ; piece 1: appointment date/time
 ;       2: clinic
 ;       3: status
 ;       4: type
 Q:'$G(DFN)
 N VASD,VAERR
 S VASD("F")=$$NOW^XLFDT,VASD("W")=1 ;get active/kept appts 
 D SDA^VADPT
 Q
KAPPT(DFN) ; Kill APPOINTMENTS multiple
 Q:'$G(DFN)
 N DA,DIK
 S DA=0,DA(1)=DFN
 F  S DA=$O(^WV(790,DFN,2,DA)) Q:'DA  D
 .S DIK="^WV(790,"_DFN_",2,"
 .D ^DIK
 .Q
 Q
SAPPT(DFN) ; Set APPOINTMENTS multiple
 Q:'$G(DFN)
 Q:'$D(^WV(790,DFN))
 N DA,DIC,DLAYGO,LOOP,X
 S LOOP=0,DIC="^WV(790,"_DFN_",2,",DIC(0)="L",DA(1)=DFN,DLAYGO=790
 I '$D(^UTILITY("VASD",$J))  D  Q  ;no appts passed from SDA^VADPT
 .S X="No Future Appointments"
 .D ^DIC
 .Q
 F  S LOOP=$O(^UTILITY("VASD",$J,LOOP)) Q:'LOOP  D
 .S X=$G(^UTILITY("VASD",$J,LOOP,"E"))
 .Q:X=""
 .S X=$P(X,U,1)_"   Clinic: "_$P(X,U,2)
 .D ^DIC
 .Q
 Q
KILLUG ; Kill Utility Global created by SDA^VADPT call
 K ^UTILITY("VASD",$J)
 Q
IEN(WVFILE,WVALUE) ; Return ien of entry
 ; input: WVFILE - File number
 ;        WVALUE - value of the .01 field
 I 'WVFILE!(WVALUE="") Q 0
 Q +$O(^WV(WVFILE,"B",WVALUE,0))
 ;
GADD(DFN) ; Get COMPLETE ADDRESS with ADD^VADPT
 ; Returns VAPA array
 Q:'$G(DFN)
 D ADD^VADPT
 Q
KADD(DFN) ; Kill COMPLETE ADDRESS multiple
 Q:'$G(DFN)
 N DA,DIK
 S DA=0,DA(1)=DFN
 F  S DA=$O(^WV(790,DFN,3,DA)) Q:'DA  D
 .S DIK="^WV(790,"_DFN_",3,"
 .D ^DIK
 .Q
 Q
SADD(DFN) ; Set COMPLETE ADDRESS multiple
 Q:'$G(DFN)
 Q:'$D(^WV(790,DFN))
 N DA,DIC,DLAYGO,LOOP,WVERR,WVSTATE,X
 S LOOP=0,DIC="^WV(790,"_DFN_",3,",DIC(0)="L",DA(1)=DFN,DLAYGO=790
 I '$D(VAPA)  D  Q  ;no address passed from ADD^VADPT
 .S X="No Address on file"
 .D ^DIC
 .Q
 ; look for confidential address
 I $G(VAPA(12))'=1 D RA Q  ;no confidential address, use regular address
 I $P($G(VAPA(22,2)),U,3)="Y" D CC Q  ;category 2 - appointments
 I $P($G(VAPA(22,4)),U,3)="Y" D CC Q  ;category 4 - medical records
 D RA
 Q
RA ; get regular address
 F LOOP=1,2,3 D
 .S X=$G(VAPA(LOOP))
 .Q:X=""
 .S:$E(X)'?1N X=" "_X
 .D ^DIC
 .Q
 S WVSTATE=""
 I $P(VAPA(5),U,1) D
 .S WVSTATE=$$GET1^DIQ(5,$P(VAPA(5),U,1),1,"E","","WVERR")
 .Q
 S X=VAPA(4)_", "_WVSTATE_"  "_VAPA(6)
 Q:X=",   "
 D ^DIC
 Q
CC ; get Confidential Communication address
 F LOOP=13,14,15 D
 .S X=$G(VAPA(LOOP))
 .Q:X=""
 .S:$E(X)'?1N X=" "_X
 .D ^DIC
 .Q
 S WVSTATE=""
 I $P(VAPA(17),U,1) D
 .S WVSTATE=$$GET1^DIQ(5,$P(VAPA(17),U,1),1,"E","","WVERR")
 .Q
 S X=$P(VAPA(16),U,1)_", "_WVSTATE_"  "_$P(VAPA(18),U,1)
 Q:X=",   "
 D ^DIC
 Q
KVAR ; Kill off VADPT variables used
 D KVAR^VADPT
 Q
ELIG(WVDFN) ; Get patient's eligibilty code.
 ;  Input: patient DFN
 ; Output: internal^external values
 N DFN,I,VAEL,VAERR,X,Y
 S DFN=WVDFN
 D ELIG^VADPT ;get elibility code
 Q $G(VAEL(1)) ;VAEL(1)=internal^external
 ;
HELP(WVDA,WVA,WVB) ; Display message for eligiblity codes
 ; WVDA - the FILE 790.02 ien
 ; WVA  - the node number where the eligibilty codes are stored
 ; WVB  - the package name associated with those eligibility codes
 Q:'$O(^WV(790.02,WVDA,WVA,0))  ;no eligibility codes for lab data
 N WVMSG
 S WVMSG(1)="The ELIGIBILITY CODE(S) defined for "_WVB_" will be deleted when you"
 S WVMSG(2)="exit and save your changes."
 D HLP^DDSUTL(.WVMSG)
 Q
DELETE(WVDA) ; Delete eligibility codes, if necessary
 ; task as a background job?
 Q:'WVDA
 N WVLAV,WVLSP,WVNODE,WVRAV,WVRSP,X,Y
 S WVNODE=$G(^WV(790.02,WVDA,0))
 Q:WVNODE=""
 S WVRSP=$P(WVNODE,U,10) ;import mams from radiology
 S WVRAV=$P(WVNODE,U,25) ;include all non-veterans (rad)
 S WVLSP=$P(WVNODE,U,24) ;import tests from lab
 S WVLAV=$P(WVNODE,U,26) ;include all non-veterans (lab)
 ; Delete eligibility codes related to radiology if 
 ; 1)     import mams from radiology = YES, or
 ; 2) include all non-veterans (rad) = YES, or
 ; 3) include all non-veterans (rad) = null
 I WVRSP'=1!(WVRAV=1)!(WVRAV="") D
 .N DA,DIK
 .S DA(1)=WVDA,DA=0,DIK="^WV(790.02,DA(1),5,"
 .F  S DA=$O(^WV(790.02,DA(1),5,DA)) Q:'DA  D ^DIK
 .Q
 ; Delete eligibility codes related to laboratory if 
 ; 1)          import tests from lab = YES, or
 ; 2) include all non-veterans (lab) = YES, or
 ; 3) include all non-veterans (lab) = null
 I WVLSP'=1!(WVLAV=1)!(WVLAV="") D
 .N DA,DIK
 .S DA(1)=WVDA,DA=0,DIK="^WV(790.02,DA(1),6,"
 .F  S DA=$O(^WV(790.02,DA(1),6,DA)) Q:'DA  D ^DIK
 .Q
 Q
