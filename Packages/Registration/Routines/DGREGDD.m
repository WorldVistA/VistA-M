DGREGDD ;ALB/REW,TMK - REGISTRATION PATIENT FILE MUMPS X-REFS ; 28-MAR-06
 ;;5.3;Registration;**583**;Aug 13, 1993;Build 20
 ;
 ; Calls to ^XUAF4: DBIA2171
 ;
SET(DFN,X) ; XREF SET STATEMENT FOR PATIENT, CLAIM FOLDER LOCATION (#2,.314)
 ; TRIGGERS THE FREE TEXT VALUE OF FLD .312 TO STATION#_STATION NAME
 Q:'$G(DFN)!($G(X)="")
 N DGROOT,DGNM,DGST,DGX,DGZ,Y
 S DGST=$$STA^XUAF4(X)
 D F4^XUAF4(DGST,.DGZ)
 S DGX="",DGNM=$G(DGZ("NAME"))
 S:DGST DGX=$E(DGST_DGNM,1,40)
 S DGROOT(2,DFN_",",.312)=DGX
 D FILE^DIE(,"DGROOT")
 Q
 ;
KILL(DFN) ; XREF KILL STATEMENT FOR PATIENT, CLAIM FOLDER LOCATION (#2,.314)
 ; TRIGGERS THE FREE TEXT VALUE OF FIELD .312 TO NULL (deletes it)
 Q:'$G(DFN)
 N DGROOT,X,Y
 S DGROOT(2,DFN_",",.312)="@"
 D FILE^DIE(,"DGROOT")
 Q
 ;
CFLTF(DGI) ;CLAIM FOLDER LOCATION screen of INSTITUTIONS with specific types
 ; DGI = facility (pointer to file 4)
 ; Returns 1 if valid facility type for facility ien DGI
 ; Returns 0 if invalid facility type for facility ien DGI
 N DGARR,DGX,OK,X,Y,Z
 S OK=0
 I $G(DGI)="" G CFLTFQ
 F Z="RO","RO&IC","RO-OC","RPC","M&ROC","M&ROC(M&RO)" S DGARR(Z)=""
 D F4^XUAF4($$STA^XUAF4(+DGI),.DGX,"A")
 I $G(DGX("TYPE"))'="",$D(DGARR(DGX("TYPE"))) S OK=1
CFLTFQ Q OK
 ;
PFTF(DGI) ;PREFERRED FACILITY screens of INSTITUTIONS for valid facility types
 ; DGI = facility (pointer to file 4)
 ; Returns 1 if valid facility type for facility
 ; Returns 0 if invalid facility type for facility
 N DGARR,OK,X,Y,Z
 S OK=0
 I $G(DGI)="" G PFTFQ
 F Z="CBOC","HCS","HEALTHCARE","M&ROC","MOC","MORC","NETWORK","NHC","OC","OCMC","OCS","OPC","ORC","RO-OC","SATELLITE","SOC","VAMC","VANPH","VA ROSEBERG" S DGARR(Z)=""
 D F4^XUAF4($$STA^XUAF4(+DGI),.DGX,"A")
 I $G(DGX("TYPE"))'="",$D(DGARR(DGX("TYPE"))) S OK=1
PFTFQ Q OK
 ;
