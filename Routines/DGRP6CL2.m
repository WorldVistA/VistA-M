DGRP6CL2 ;ALB/TMK - REGISTRATION SCREEN 6 FLDS Conflict loc (cont) ; 09/15/2005
 ;;5.3;Registration;**689**;Aug 13, 1993;Build 1
 ;
ISVALID(DGCONF,DGPOSS) ; Configure delimiter for edit/no edit
 ; DGCONF = the conflict location or location multiple entry
 ; DGCONF(DGCONF) is the array returned from CLLST^DGRP6CL call
 ; DGPOSS(DGCONF) is the array returned from CLLST^DGRP6CL call
 ; Assume DFN exists
 ;
 ; RETURNS:
 ; DGCONF(DGCONF,"NOEDIT"))=1 if data is locked (no editing of HEC data or if VIEW only)
 ; DGCONF(DGCONF,"VEDIT"))=1 if the data is valid for entry/edit
 ;                        =2 if data valid but only for edit/delete
 ; Function returns either  [] for editable or <> for not editable.
 ;
 N DG,Z,DGCONF1,DGLOCK
 S DGLOCK=$S('$G(DGRPVV(6,"NOEDIT")):+$P(DGCONF(DGCONF),U,4),1:1)
 S DGCONF1=$E(DGCONF,1,3)
 I DGLOCK S DGCONF(DGCONF,"NOEDIT")=1
 I $G(DGCONF(DGCONF))'=""!$D(DGPOSS(DGCONF)) D
 . Q:DGCONF1="UNK"!DGLOCK  ; Never editable
 . I DGCONF="OEF"!(DGCONF="OIF")!$D(DGPOSS(DGCONF)) S DGCONF(DGCONF,"VEDIT")=$S('$G(DGCONF(DGCONF,1)):1,1:2)
 . I "^OEF^OIF^"[(U_DGCONF1_U) D:DGCONF=DGCONF1&($G(DGCONF(DGCONF,"VEDIT"))=2)  Q
 .. N OK
 .. Q:$G(DGCONF(DGCONF,"VEDIT"))'=2
 .. S OK=0
 .. S Z=DGCONF F  S Z=$O(DGCONF(Z)) Q:Z=""!($E(Z,1,3)'=$E(DGCONF,1,3))  I '$P($G(DGCONF(Z)),U,4) S OK=1 Q
 .. I 'OK S DGCONF(DGCONF,"NOEDIT")=1 K DGCONF(DGCONF,"VEDIT")
 . ;
 . S DGCONF(DGCONF,"VEDIT")=$S('$G(DGCONF(DGCONF,1)):1,1:2)
 ;
 I '$G(DGCONF(DGCONF,"VEDIT")),'DGLOCK D
 . I $S(DGCONF1="OEF"!(DGCONF1="OIF")!(DGCONF1="UNK"):0,1:1) D  Q
 .. S DG=$S(DGCONF="VIET":$G(^DPT(DFN,.321)),1:$G(^DPT(DFN,.322)))
 .. I "NO"'[$TR($$YN(DG,$S(DGCONF="VIET":6,DGCONF="LEB":1,DGCONF="GREN":4,DGCONF="PAN":7,DGCONF="GULF":10,DGCONF="SOM":16,DGCONF="YUG":19,1:""))," ") S DGCONF(DGCONF,"VEDIT")=$S('$G(DGCONF(DGCONF,1)):1,1:2) Q
 .. S DGCONF(DGCONF,"NOEDIT")=1 ;,DGCONF(DGCONF,1)=1
 Q $S($G(DGCONF(DGCONF,"VEDIT")):"[]",1:"<>")
 ;
YN(DGRPX,X) ;Format Yes/No fld in $P(DGRPX,U,X)
 ;
 Q $S($P(DGRPX,"^",X)="Y":"YES",$P(DGRPX,"^",X)="N":"NO ",$P(DGRPX,"^",X)="U":"UNK",1:"   ")
 ;
CL(DFN,LIN) ; Format conflict locations on file for the pt
 N DGCONF,DGCONFX,DGLIM,DGOEIF,DGCT,Z,Z0,Z1,Z2,Z3
 K LIN
 S (DGLIM,DGCT,LIN)=0,LIN(0)=0
 F Z="OEF","OIF","UNK" S LIN(Z)=0
 D CLLST^DGRP6CL(DFN,.DGCONF,"")
 ; Make OEF/OIF/ UNKNOWN OEF/OIF display in reverse date order
 ;  within conflict & only display the first 4 of all the vet's conflicts
 ;  with data
 S Z2=0
 F Z0="OEF","OIF","UNK" S Z1=Z0,Z2=Z2+1 I $D(DGCONF(Z0)) M DGCONF(Z2_Z0)=DGCONF(Z0) F  S Z1=$O(DGCONF(Z1)) Q:Z1=""!(Z1'[Z0)  I DGCONF(Z1) M DGCONF(Z2_Z0_"-"_(9999999-$P(DGCONF(Z1),U)))=DGCONF(Z1) K DGCONF(Z1)
 S DGCONF="" F  S DGCONF=$O(DGCONF(DGCONF)) Q:DGCONF=""  S DGCONFX=$S($E(DGCONF)?1N:$E(DGCONF,2,$L(DGCONF)),1:DGCONF) I DGCONF(DGCONF)'=""!$D(DGPOSS(DGCONFX)) D  I DGCT=5 S DGLIM=1 Q
 . S Z3=$E(DGCONFX,1,3)
 . S Z0=$S(Z3'="UNK":Z3,1:"UNK OEF/OIF"),DGOEIF=$S(Z3="OEF"!(Z3="OIF")!(Z3="UNK"):1,1:0)
 . I DGOEIF Q:DGCONFX'["-"
 . I DGOEIF D
 .. S LIN=LIN+1,LIN(Z3)=LIN(Z3)+1,LIN(LIN)=Z0
 . E  D
 .. S LIN=LIN+1,LIN(LIN)=$S(DGCONFX="VIET":"Vietnam",DGCONFX="LEB":"Lebanon",DGCONFX="GREN":"Grenada",DGCONFX="PAN":"Panama",DGCONFX="GULF":"Gulf War",DGCONFX="SOM":"Somalia",DGCONFX="YUG":"Yugoslavia",1:"")
 . S DGCT=DGCT+1
 . I $L(LIN(LIN))>LIN(0) S LIN(0)=$L(LIN(LIN))
 . S LIN(LIN,1)="("_$S($P(DGCONF(DGCONF),U):$$FMTE^XLFDT($P(DGCONF(DGCONF),U),"5DZ"),1:"date missing")_"-"_$S($P(DGCONF(DGCONF),U,2):$$FMTE^XLFDT($P(DGCONF(DGCONF),U,2),"5DZ"),1:"date missing")_") "
 . S LIN(LIN,1)=$E(LIN(LIN,1)_$J("",25),1,25)
 . S LIN(LIN,1)=LIN(LIN,1)_$S($G(DGCONF(DGCONF,1))=1:"**Not Within MSE",1:"")
 S:'LIN(0) LIN(0)=25
 S Z0=0 F  S Z0=$O(LIN(Z0)) Q:'Z0  S LIN(Z0)=$E(LIN(Z0)_$J("",LIN(0)),1,LIN(0))_LIN(Z0,1) K LIN(Z0,1)
 I DGLIM S LIN(LIN)="++Additional Conflict Locations exist for this patient"
 Q
 ;
