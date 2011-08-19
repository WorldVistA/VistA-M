MPIFEXT2 ;SFCIO/CMC-EXTENDED PDAT - RPC ;26 JUN 01
 ;;1.0; MASTER PATIENT INDEX VISTA ;**20,28**;30 Apr 99
 ;
 ;Integration Agreements Utilized:
 ;  ^DPT( - #2070
 ;  NOTICE^DGSEC4 - #3027
 ;  PTSEC^DGSEC4 - #3027
 ;  D GETS^DIQ(2,DFN_",",".097","I","MPIFAR") - #3581
 ;
PATINFO(RETN,ICN,SSN,RPC) ;get patient info array
 N MPINODE,MPIFAR,DFN,TICN,TSSN,TEXT,CNTD,PICN,XX,X,XXX
 I $G(ICN)=""&($G(SSN)="") S RETN="-1^NO ICN OR SSN PASSED" Q
 S TICN=ICN,TSSN=SSN,TEXT=""
 I $G(SSN)'="" D
 .S ICN=$$GETICNS^MPIF002(SSN)
 .I RPC=1 S TEXT="MPI(""SSN USED"")="
 .S RETN(1,"SSN USED")=TEXT_""""_SSN_""""
 .; possible to have multiple entries with same SSN
 S PICN=ICN,CNTD=0
 F XX=1:1 S ICN=$P(PICN,"^",XX) Q:ICN=""  D
 .S DFN=$$GETDFN^MPIF001(+ICN),CNTD=CNTD+1
 .I +DFN=-1 S RETN(XX)="-1^NO SUCH ICN "_ICN Q
 .I '$D(^DPT(DFN)) S RETN(XX)="-1^BAD AICN X-REF, PT FILE ENTRY DOESN'T EXIST DFN= "_DFN_" ICN= "_ICN Q
 .; check if this data can be returned and if sensative pt bulletin needed
 .N SENS D PTSEC^DGSEC4(.SENS,DFN,1,"Remote Procedure from MPI^RPC frm MPI ext PDAT infor")
 .N NOT D NOTICE^DGSEC4(.NOT,DFN,"Remote Procedure from MPI^RPC frm MPI ext PDAT infor")
 .I SENS(1)=3!(SENS(1)=4)!(SENS(1)=-1) S RETN(XX)="-1^SENSATIVE PT ISSUE "_SENS(2)_" DFN= "_DFN_" ICN= "_ICN Q
 .I RPC=1 S TEXT="MPI("_DFN_",""DFN"")="
 .S RETN(XX,"DFN")=TEXT_""""_DFN_""""
 .S MPINODE=$$MPINODE^MPIFAPI(DFN)
 .D GETS^DIQ(2,DFN_",",".097","I","MPIFAR")
 .I RPC=1 S TEXT="MPI("_DFN_",""ENTERED PT FILE"")="
 .S RETN(DFN,"ENTERED PT FILE")=TEXT_""""_$$FMTE^XLFDT(MPIFAR(2,DFN_",",.097,"I"),5)_""""
 .K VADM
 .D DEM^VADPT
 .F X=1,2,3,5,6,11,12 D
 ..I X=1 D
 ...I RPC=1 S TEXT="MPI("_DFN_",""NAME"")="
 ...S RETN(DFN,"NAME")=TEXT_""""_VADM(1)_""""
 ..I X=2 D
 ...I RPC=1 S TEXT="MPI("_DFN_",""SEX"")="
 ...S RETN(DFN,"SEX")=TEXT_""""_VADM(5)_""""
 ..I X=3 D
 ...I RPC=1 S TEXT="MPI("_DFN_",""DOB"")="
 ...S RETN(DFN,"DOB")=TEXT_""""_VADM(3)_""""
 ..I X=12 D
 ..I RPC=1 S TEXT="MPI("_DFN_",""RACE"","
 ..S XXX=0
 ..I VADM(12)=0 S RETN(DFN,"RACE",0)=TEXT_XXX_")="_"""NONE""" Q
 ..I VADM(12)>0 F  S XXX=$O(VADM(12,XXX)) Q:XXX=""  S RETN(DFN,"RACE",XXX)=TEXT_XXX_")="_""""_$P($G(VADM(12,XXX)),"^",2)_""""
 ..I X=2 D
 ...I RPC=1 S TEXT="MPI("_DFN_",""SSN"")="
 ...S RETN(DFN,"SSN")=TEXT_""""_VADM(2)_""""
 ..I X=6 D
 ...I RPC=1 S TEXT="MPI("_DFN_",""DOD"")="
 ...S RETN(DFN,"DOD")=TEXT_""""_$$FMTE^XLFDT($P(VADM(6),"^"))_""""
 ..I X=11 D
 ..I RPC=1 S TEXT="MPI("_DFN_",""ETHNIC"")="
 ..I VADM(11)=0 S RETN(DFN,"ETHNIC")=TEXT_"""NONE""" Q
 ..I VADM(11)=1 S RETN(DFN,"ETHNIC")=TEXT_""""_$P($G(VADM(11,1)),"^",2)_""""
 .K VAPA,VADM
 .D ADD^VADPT
 .F X=1,2,3,4,5,6,8,11 D
 ..I X=1 D
 ...I RPC=1 S TEXT="MPI("_DFN_",""ADDRESS"")="
 ...S RETN(DFN,"ADDRESS 1")=TEXT_""""_VAPA(1)_""""
 ..I X=6 D
 ...I RPC=1 S TEXT="MPI("_DFN_",""ZIP"")="
 ...S RETN(DFN,"ZIP")=TEXT_""""_VAPA(6)_""""
 ..I X=2 D
 ...I RPC=1 S TEXT="MPI("_DFN_",""ADDRESS 2"")="
 ...S RETN(DFN,"ADDRESS 2")=TEXT_""""_VAPA(2)_""""
 ..I X=3 D
 ...I RPC=1 S TEXT="MPI("_DFN_",""ADDRESS 3"")="
 ...S RETN(DFN,"ADDRESS 3")=TEXT_""""_VAPA(3)_""""
 ..I X=5 D
 ...I RPC=1 S TEXT="MPI("_DFN_",""STATE"")="
 ...S RETN(DFN,"STATE")=TEXT_""""_$P(VAPA(5),"^",2)_""""
 ..I X=4 D
 ...I RPC=1 S TEXT="MPI("_DFN_",""CITY"")="
 ...S RETN(DFN,"CITY")=TEXT_""""_VAPA(4)_""""
 ..I X=8 D
 ...I RPC=1 S TEXT="MPI("_DFN_",""HOME PHONE #"")="
 ...S RETN(DFN,"HOME PHONE #")=TEXT_""""_VAPA(8)_""""
 .K VAPA,VAEL
 .D ELIG^VADPT
 .I VAEL(4)=1 S VAEL("VET Y/N")="YES"
 .I VAEL(4)'=1 S VAEL("VET Y/N")="NO"
 .F X=1,4,7 D
 ..I X=7 D
 ...I RPC=1 S TEXT="MPI("_DFN_",""CLAIM #"")="
 ...S RETN(DFN,"CLAIM #")=TEXT_""""_VAEL(7)_""""
 ..I X=4 D
 ...I RPC=1 S TEXT="MPI("_DFN_",""VET Y/N"")="
 ...S RETN(DFN,"VET Y/N")=TEXT_""""_VAEL("VET Y/N")_""""
 ..I X=1 D
 ...I RPC=1 S TEXT="MPI("_DFN_",""PRIM ELIG"")="
 ...S RETN(DFN,"PRIM ELIG")=TEXT_""""_$P(VAEL(1),"^",2)_""""
 .K VAEL,VAOA
 .D OAD^VADPT
 .I RPC=1 S TEXT="MPI("_DFN_",""NOK NAME"")="
 .S RETN(DFN,"NOK NAME")=TEXT_""""_VAOA(9)_""""
 .K VAOA
 .S VAOA("A")=1
 .D OAD^VADPT
 .I RPC=1 S TEXT="MPI("_DFN_",""EMERGENCY POC"")="
 .S RETN(DFN,"EMERGENCY POC")=TEXT_""""_VAOA(9)_""""
 .K VAOA
 .S VAOA("A")=2
 .D OAD^VADPT
 .I RPC=1 S TEXT="MPI("_DFN_",""DESIGNEE"")="
 .S RETN(DFN,"DESIGNEE")=TEXT_""""_VAOA(9)_""""
 .K VAOA,VAPD
 .D OPD^VADPT
 .F X=1,2,3,4,5 D
 ..I X=5 D
 ...I RPC=1 S TEXT="MPI("_DFN_",""MMN"")="
 ...S RETN(DFN,"MMN")=TEXT_""""_VAPD(5)_""""
 ..I X=1 D
 ...I RPC=1 S TEXT="MPI("_DFN_",""POBC"")="
 ...S RETN(DFN,"POBC")=TEXT_""""_VAPD(1)_""""
 ..I X=2 D
 ...I RPC=1 S TEXT="MPI("_DFN_",""POBS"")="
 ...S RETN(DFN,"POBS")=TEXT_""""_$P(VAPD(2),"^",2)_""""
 ..I X=3 D
 ...I RPC=1 S TEXT="MPI("_DFN_",""FATHER'S NAME"")="
 ...S RETN(DFN,"FATHER'S NAME")=TEXT_""""_VAPD(3)_""""
 ..I X=4 D
 ...I RPC=1 S TEXT="MPI("_DFN_",""MOTHER'S NAME"")="
 ...S RETN(DFN,"MOTHER'S NAME")=TEXT_""""_VAPD(4)_""""
 .K VAPD,VASV
 .D SVC^VADPT
 .I RPC=1 S TEXT="MPI("_DFN_",""POW STATUS"")="
 .I VASV(4)=1 S VASV(4)="YES"
 .I VASV(4)=0 S VASV(4)="NO"
 .S RETN(DFN,"POW STATUS")=TEXT_""""_VASV(4)_""""
 .I RPC=1 S TEXT="MPI("_DFN_",""LAST SRV BRANCH"")="
 .S RETN(DFN,"LAST SRV BRANCH")=TEXT_""""_$P(VASV(6,1),"^",2)_""""
 .I RPC=1 S TEXT="MPI("_DFN_",""LAST SRV #"")="
 .S RETN(DFN,"LAST SRV #")=TEXT_""""_VASV(6,2)_""""
 .I RPC=1 S TEXT="MPI("_DFN_",""LAST SRV ENT DT"")="
 .S RETN(DFN,"LAST SRV ENT DT")=TEXT_""""_$$FMTE^XLFDT($P(VASV(6,4),"^"))_""""
 .I RPC=1 S TEXT="MPI("_DFN_",""LAST SRV SEP DT"")="
 .S RETN(DFN,"LAST SRV SEP DT")=TEXT_""""_$$FMTE^XLFDT($P(VASV(6,5),"^"))_""""
 .K VASV
 .N MPINODE
 .S MPINODE=$$MPINODE^MPIFAPI(DFN)
 .I RPC=1 S TEXT="MPI("_DFN_",""SUB CONTROL #"")="
 .S RETN(DFN,"SUB CONTROL #")=TEXT_""""_$P(MPINODE,"^",5)_""""
 .I RPC=1 S TEXT="MPI("_DFN_",""SCORE"")="
 .S RETN(DFN,"SCORE")=TEXT_""""_$P(MPINODE,"^",6)_""""
 .I RPC=1 S TEXT="MPI("_DFN_",""SCORE DATE"")="
 .S RETN(DFN,"SCORE DATE")=TEXT_""""_$P(MPINODE,"^",7)_""""
 .I RPC=1 S TEXT="MPI("_DFN_",""LOCAL ICN"")="
 .I $P(MPINODE,"^",4)=1 S RETN(DFN,"LOCAL ICN")=TEXT_"""YES"""
 .I $P(MPINODE,"^",4)="" S RETN(DFN,"LOCAL ICN")=TEXT_"""NO"""
 .N RESULT,SENS
 .S SENS="NO"
 .D PTSEC^DGSEC4(.RESULT,DFN)
 .I RESULT(1)>0 S SENS="YES"
 .I RPC=1 S TEXT="MPI("_DFN_",""SENSATIVE PT"")="
 .S RETN(DFN,"SENSATIVE PT")=TEXT_""""_SENS_""""
 .D ALIAS^MPIFEXT3(.RETN,DFN,RPC)
 .D CMORCH^MPIFEXT3(.RETN,DFN,RPC)
 .D TFLIST^MPIFEXT3(.RETN,DFN,RPC)
 .D SUBLST^MPIFEXT3(.RETN,DFN,RPC)
 D ICNSTAT^MPIFRPC(.RETN,TICN,TSSN,RPC)
 K VA,VAERR
 Q
 ;
