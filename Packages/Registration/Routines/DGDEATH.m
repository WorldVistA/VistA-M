DGDEATH ;ALB/MRL,PJR,DJS-PROCESS DECEASED PATIENTS ;10/27/04 9:45pm
 ;;5.3;Registration;**45,84,101,149,392,545,595,568,563,725,772,863,901,926,939,944,950**;Aug 13, 1993;Build 4
 ;
GET N DGMTI,DATA,DGDWHO,DTOUT,DUOUT,DIRUT,DIROUT,DIR,DIE,DA,DFN,DR,DIC,DGDNEW,DGDSON,DGDOCT,DGUPDATE
 S DGDTHEN="" W !! S (DIE,DIC)="^DPT(",DIC(0)="AEQMZ" D ^DIC G Q:Y'>0 S (DA,DFN)=+Y
 S DGDOLD=$G(^DPT(DFN,.35))
 I $P(DGDOLD,"^",1)="" G CONT
 ; Story 340911 (elz), allow DOD to be deleted regardless (but not edited later on)
 ;I $P(DGDOLD,"^",1)'="" S DGDWHO=$P($G(DGDOLD),"^",5) I DGDWHO="" G CONT
 ;I ((DGDWHO'="")&(DGDWHO<1))!('$D(^VA(200,DGDWHO))) W !!,"YOU MAY NOT EDIT DATE OF DEATH IF IT WAS NOT ENTERED BY A USER AT THIS SITE" S ^DPT(DFN,.35)=DGDOLD G GET
CONT I $D(^DPT(DFN,.1)) W !?3,"Patient is currently in-house.  Discharge him with a discharge type of DEATH." G GET
 I $S($D(^DPT(DFN,.35)):^(.35),1:"") F DGY=0:0 S DGY=$O(^DGPM("ATID1",DFN,DGY)) Q:'DGY  S DGDA=$O(^(DGY,0)) I $D(^DGPM(+DGDA,0)),$P(^(0),"^",17)]"" S DGXX=$P(^(0),"^",17),DGXX=^DGPM(DGXX,0) I "^12^38^"[("^"_$P(DGXX,"^",18)_"^") G DIS
 ; Story 340911 (elz) prompt for DOD, just keep it on hand without filing the data.
 W ! S DIR(0)="2,.351" S:DGDOLD DIR("B")=$$FMTE^XLFDT(+DGDOLD) D ^DIR K DIR("B") S DGDNEW=Y
 ; Story 620595 (elz) remove unwanted fields when deletion is done, changed to FM DB call
 ;I X="@" S DIR("A")="Are you sure you want to delete the Date of Death" S DIR(0)="Y" D ^DIR K DIR("A") I Y S DR=".351///@;.352////@;.353///@;.357///@;.358///@;.354////"_$$NOW^XLFDT_".355////"_DUZ D ^DIE G GET
 I X="@" S DIR("A")="Are you sure you want to delete the Date of Death" S DIR(0)="Y" D ^DIR K DIR("A") I Y D  G GET
 . N DGDR
 . S (DGDR(2,DA_",",.351),DGDR(2,DA_",",.352),DGDR(2,DA_",",.353),DGDR(2,DA_",",.357),DGDR(2,DA_",",.358))="@"
 . S DGDR(2,DA_",",.354)=$$NOW^XLFDT,DGDR(2,DA_",",.355)=DUZ
 . D FILE^DIE("","DGDR")
 I $D(DIRUT) G GET
 ; don't allow edit if not entered at this site
 I '$D(^VA(200,+$P(DGDOLD,"^",5),0)),$P(DGDOLD,"^")'="",$P(DGDOLD,"^")'=Y W !!,"YOU MAY NOT EDIT DATE OF DEATH IF IT WAS NOT ENTERED BY A USER AT THIS SITE" S ^DPT(DFN,.35)=DGDOLD G GET
 S DGDNEW=Y,^TMP("DEATH",$J)=1
SN ; Story 340911 Source of Notification, updated to 1 or 8 (elz)
 ; Story 557815 and 557804 (elz) update screen to new business rule file
 S DGDSON=$P(DGDOLD,"^",3)
 S DIC="^DG(47.76,",DIC(0)="AEMNQ",DIC("A")="SOURCE OF NOTIFICATION: ",DIC("S")="I $D(^DG(47.761,""AS"",Y,1))" S:DGDSON DIC("B")=$P(^DG(47.76,DGDSON,0),"^") D ^DIC K DIC("A"),DIC("B"),DIC("S")
 I DGDNEW,$D(DTOUT)!($D(DUOUT)) W !!,"Death data not filed/updated!" K ^TMP("DEATH",$J) G GET
 I DGDNEW,Y<0 W !,*7,?5,"Source of Notification is REQUIRED!!" G SN
 S $P(DGDNEW,"^",3)=+Y
DOCT ; Story 340911 Supporting document type, added with story (elz)
 S DGDOCT=$P(DGDOLD,"^",7)
 ; jls DG*5.3*939 RM#858372 Update list of entries not to include MVI Only Supporting Documentation Types
 ; Story 557815 and 557804 (elz) update screen to use new business rule file
 I DGDNEW,$$OCK S DIR(0)="2,.357" S:DGDOCT DIR("B")=$P(^DG(47.75,DGDOCT,0),"^") D ^DIR K DIR("B")
 I $D(DTOUT)!($D(DUOUT))!($D(DIROUT)) W !!,"Death data not filed/updated!" K ^TMP("DEATH",$J) G GET
 I $$OCK,Y<1 W !,*7,?5,"Supporting Document Type is REQUIRED!!" G DOCT
 S:$$OCK $P(DGDNEW,"^",7)=+Y,$P(DGDNEW,"^",8)="VDE"
 ; Story 557815 (elz) validate source to document in business rule file
 I DGDNEW,'$D(^DG(47.761,"AD",$P(DGDNEW,"^",3),+Y,1)) W !,*7,?5,"Invalid Document Type for the Source." G DOCT
 S:$$OCK $P(DGDNEW,"^",7)=+Y,$P(DGDNEW,"^",8)="VDE"
 ;
 S DR="",DGUPDATE=0
 F P=1,3,7,8 I $P(DGDOLD,"^",P)'=$P(DGDNEW,"^",P),$L($P(DGDNEW,"^")) S DGUPDATE=1
 I DGUPDATE F P=1,3,7,8 S DR=DR_".35"_P_"////"_$P(DGDNEW,"^",P)_";"
 I $L(DR) S:$P(DGDOLD,"^")'=$P(DGDNEW,"^") DR=DR_".354////"_$$NOW^XLFDT S DIE="^DPT(",^TMP("DEATH",$J)=1 D ^DIE,DISCHRGE
 I $P(DGDOLD,"^",1)'=$P(DGDNEW,"^",1) D XFR
 K ^TMP("DEATH",$J) G GET
 ;
DIS W !,"Patient has a discharge type of Death",!,"Edit the discharge",!
Q K A,DA,DFN,DGDA,DIC,DIE,DR,DGXX,DGY,DGDTHEN,DGDOLD,DGDNEW,DGDONOT Q
XFR ; called from set x-ref of field .351 of file 2
 N DGPCMM,DGFAPT,DGFAPTI,DGFAPT1
 Q:'$D(DFN)
 K DGTEXT D ^DGPATV S DGDEATH=$$GET1^DIQ(2,DFN,.351,"I"),XMSUB="PATIENT HAS EXPIRED",DGCT=0
 D DEMOG
 S DGT=X-.0001,(Y,DGDDT)=X,DG1="" D:DGT]"" ^DGPMSTAT
 S Y=$$FMTE^XLFDT(Y),Y=$S(Y]"":Y,1:"UNKNOWN")
 S DGDONOT=0 D APTT3
 D LINE("")
 D LINE("      Date/Time of Death: "_DEATHVAL_$S(DGDONOT:"",'DG1:"",$D(DGDTHEN):"",1:"  (While an inpatient)"))
 D LINE("")
 I '$D(ADM),DG1,$D(^DGPM(+DGA1,0)) S ADM=+^DGPM($P(^(0),"^",14),0)
 S Y=$$FMTE^XLFDT($S($D(ADM):ADM,1:""))
 D LINE($S($D(DGDTHEN):"",DG1:"     Admission Date/Time: "_Y_$S((DGDDT-ADM)<1:"  (Within 24 hours of hospitalization)",1:""),1:""))
 D LINE("")
 S DGX=$P($G(^DGPM(+$G(DGA1),0)),"^",6),DGX=$P($G(^DIC(42,+DGX,0)),U,1)
 D LINE($S($D(DGDTHEN):"",('DG1):"",$D(DGA1):"             Admitted To: "_$S(DGX]"":DGX,1:"UNKNOWN"),1:"")) K DGX
 D LINE("")
 I DG1&'$D(DGDTHEN) D 
 . D LINE($S($D(DGXFR0):"           Last Transfer: "_$S($D(^DIC(42,+$P(DGXFR0,"^",6),0)):$P(^(0),"^"),1:"UNKNOWN"),1:""))
 . D LINE("")
F N DGARRAY,SDCNT S DGFAPT=DGDEATH,DGFAPTI=""
 S DGARRAY("FLDS")=3,DGARRAY(4)=DFN,DGARRAY("SORT")="P",DGARRAY(1)=DT,DGARRAY(3)="I;R"
 S SDCNT=$$SDAPI^SDAMA301(.DGARRAY)
 ;
 I SDCNT>0 F  S DGFAPT=$O(^TMP($J,"SDAMA301",DFN,DGFAPT)) Q:'DGFAPT  S DGFAPT1=$G(^TMP($J,"SDAMA301",DFN,DGFAPT)) Q:DGFAPT1']""  D  Q:DGFAPTI
 .I $P($P(DGFAPT1,U,3),";")'["C" D LINE("NOTE: Patient has future appointments scheduled!!") S DGFAPTI=1
 S DGSCHAD=0 D SA I DGSCHAD D LINE("NOTE: Patient had scheduled admissions which have been cancelled!!")
 I 'DGVETS D LINE("Patient is a NON-VETERAN."_$S($D(^DIC(21,+$P($G(^DPT(DFN,.32)),"^",3),0)):"  ["_$P(^(0),"^",1)_"]",1:""))
 S DGPCMM=$$PCMMXMY^SCAPMC25(1,DFN,,,0) ;creates xmy array
 S DGCT=$$PCMAIL^SCMCMM(DFN,"DGTEXT",DT)
Q1 S DGB=1 D ^DGBUL S X=DGDEATH
 K DGDEATH,DGSCHAD,DGI,Y,DGDDT,^TMP($J,"SDAMA301") D KILL^DGPATV K ADM,DG1,DGA1,DGCT,DGT,DGXX,DGY,Z Q
SA F DGI=0:0 S DGI=$O(^DGS(41.1,"B",DFN,DGI)) Q:'DGI  I $D(^DGS(41.1,DGI,0)),($P(^(0),"^",13)']""),($P(^(0),"^",17)']"") S $P(^(0),"^",13)=DGDEATH,$P(^(0),"^",14)=+DUZ,$P(^(0),"^",15)=1,$P(^(0),"^",16)=2,DGSCHAD=1
 Q
 ;
DEL ; delete death bulletin
 N DGPCMM,DELBY,DELTM,DTHINFO
 S DFN=+$G(DA) I '$D(^DPT(DFN,0)) Q  ; no patient node
 I +$G(^DPT(DFN,.35)) Q  ; not deletion
 S DGDEATH=X,XMSUB="Patient Death has been Deleted",DGCT=0
 D ^DGPATV
 D LINE("The date of death for the following patient has been deleted.")
 D LINE("")
 D DEMOG
 D LINE("")
 S DGPCMM=$$PCMMXMY^SCAPMC25(1,DFN,,,0) ;creates xmy array
 S DGCT=$$PCMAIL^SCMCMM(DFN,"DGTEXT",DT)
 S DGB=1 D ^DGBUL S X=DGDEATH
 K DGCT,DGDEATH D KILL^DGPATV
 Q
 ;
DEMOG ; list main demographics
 D LINE("                    NAME: "_DGNAME)
 D LINE("                     SSN: "_$P(SSN,"^",2))
 D LINE("                     DOB: "_$P(DOB,"^",2))
 I DGVETS D
 . N DGX
 . S DGX=$G(^DPT(DFN,.31))
 . S DGLOCATN=$$FIND1^DIC(4,"","MX","`"_+$P(DGX,U,4)),DGLOCATN=$S(+DGLOCATN>0:$P($$NS^XUAF4(DGLOCATN),U),1:"NOT LISTED")
 . D LINE("   CLAIM FOLDER LOCATION: "_$S($D(DGLOCATN):DGLOCATN,1:"NOT LISTED"))
 . D LINE("            CLAIM NUMBER: "_$S($P(DGX,"^",3)]"":$P(DGX,"^",3),1:"NOT LISTED"))
 ;D LINE("   COORDINATING MASTER OF RECORD: "_DGCMOR)  ;**863 - MVI_2351 (ptd)
 D GETS^DIQ(2,DFN_",",".351;.353;.354;.355","E","DTHINFO")
 S DEATHVAL=$G(DTHINFO(2,DFN_",",.351,"E"))
 S DEATHVAL=$$FMTE^XLFDT(DEATHVAL),DEATHVAL=$S(DEATHVAL]"":DEATHVAL,1:"UNKNOWN")
 S SOURCE=$G(DTHINFO(2,DFN_",",.353,"E"))
 S DELTM=$G(DTHINFO(2,DFN_",",.354,"E"))
 S DELBY=$G(DTHINFO(2,DFN_",",.355,"E"))
 D LINE("")
 D LINE("             LAST EDITED BY: "_DELBY)
 D LINE("    DATE/TIME LAST MODIFIED: "_DELTM)
 D LINE("     SOURCE OF NOTIFICATION: "_$S(SOURCE="":"UNDEFINED",1:SOURCE))
 ;K DEATHVAL,SOURCE,DELTM,DELBY
 Q
 ;
LINE(X) ; add line contained in X to array
 S DGCT=DGCT+1
 S DGTEXT(DGCT,0)=X
 Q
DSBULL ;
 ;
 I $G(IVMDODUP)=1 Q
 S DFN=DA
 I $D(DGPMDA) D  Q
 .S DISTYPE=$P($G(^DGPM(DGPMDA,0)),"^",18)
 .I $G(^DG(405.2,DISTYPE,0))["DEATH" D
 ..S FDA(2,DFN_",",.353)=1
 ..; Story 940911 (elz) update document type and option used.
 ..S:$$OCK FDA(2,DFN_",",.357)=+$O(^DG(47.75,"B","VAMC EHR INPATIENT DEATH",0)),FDA(2,DFN_",",.358)="VDP"
 ..D FILE^DIE(,"FDA","BWFERR")
 ..D DISCHRGE,XFR
 I $D(^TMP("DEATH",$J)) Q
 D DISCHRGE,XFR
 Q
DKBULL ;
 S DFN=DA
 ; Story 940911 (elz) update document type and option used
 ; Story 620595 (elz) include all needed death fields
 S (FDA(2,DFN_",",.353),FDA(2,DFN_",",.352),FDA(2,DFN_",",.357),FDA(2,DFN_",",.358))="@"
 I $D(^TMP("DEATH",$J)) S FDA(2,DFN_",",.355)=DUZ
 D FILE^DIE(,"FDA",)
 D DEL
 Q
DISCHRGE ;
 ; If the patient is being discharged, determine values needed for 
 ; Source of Notification and Date/Time last entered.
 ;
 I '$D(DGNOW) S DGNOW=$$HTFM^XLFDT($H)
 I $G(DGDAUTO)'=1 S FDA(2,DFN_",",.354)=DGNOW
 S FDA(2,DFN_",",.355)=DUZ
 D FILE^DIE(,"FDA",)
 Q
APTT3 ;Check to exclude "While an Inpatient" from DOD Bulletin
 ; Input:  DFN  Output: DGDONOT
 N DATE,XIEN,TYPE,XDOD,YES
 S DGDONOT=0
 S XDOD=$P($G(^DPT(DFN,.35)),"^",1) I 'XDOD Q
 S XDOD=$P(XDOD,".",1),YES=0,TYPE=""
 I '$D(^DGPM("APTT3",DFN)) Q
 S DATE=$O(^DGPM("APTT3",DFN,XDOD)) I 'DATE Q
 I $P(DATE,".",1)=XDOD S YES=1
 I ($P(DATE,".",1)-1)=XDOD S YES=1
 S XIEN=$O(^DGPM("APTT3",DFN,DATE,"")) I 'XIEN Q
 S TYPE=$P($G(^DGPM(XIEN,0)),"^",4)
 I YES,'((TYPE=27)!(TYPE=32)) S DGDONOT=1
 Q
OCK() ; - Only specific options for fields .357 and .358 Story 340911 (elz)
 N RETURN
 S RETURN=0
 I $P(XQY0,"^")="DG DEATH ENTRY" S RETURN=1
 I $P(XQY0,"^")="DG DISCHARGE PATIENT" S RETURN=1
 ; Story 620595 (elz) add Extended Bed control
 I $P(XQY0,"^")="DG BED CONTROL EXTENDED" S RETURN=1
 Q RETURN
 ;
 ;**926, Story 323008 (JFW)
SDTHELP ;Supporting Document Type Help (XECUTABLE HELP for 2..357)
 D:($G(X)["??")
 .N MPIOUT,MPII,MPIC,MPIDESC,DIWL,DIWR,DIWF,X,SCREEN
 .S SCREEN="I $D(^DG(47.761,""AF"",+Y,1))"
 .S MPII=0,DIWL=1,DIWR=$S($G(IOM)]"":IOM,1:70)
 .D LIST^DIC(47.75,"",".01","P","","","","","",.SCREEN,"MPIOUT")  ;Supported DBIA #2051
 .F  S MPII=$O(MPIOUT("DILIST",MPII)) Q:MPII=""  D
 ..K MPIDESC D GET1^DIQ(47.75,$P(MPIOUT("DILIST",MPII,0),"^")_",","50","E","MPIDESC","")  ;Supported DBIA #2056
 ..W !,$P(MPIOUT("DILIST",MPII,0),"^",2)_" : "
 ..K ^UTILITY($J,"W") S MPIC=0 F  S MPIC=$O(MPIDESC(MPIC)) Q:MPIC=""  D
 ...S X=MPIDESC(MPIC) D ^DIWP  ;Supported DBIA #10011
 ..D ^DIWW  ;Supported DBIA #10029
 Q
