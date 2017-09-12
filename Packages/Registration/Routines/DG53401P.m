DG53401P ;ALB/AEG - CLEAN UP REQUIRED TESTS THAT SHOULD BE NLR
 ;;5.3;Registration;**401**;23-AUG-01
 ;
 ; This routine is a post-installation for DG*5.3*401 and will look
 ; at those patients that have a date of death and a primary means
 ; test on file.  The determination will be made if these tests need
 ; to be changed to NLR status based upon eligibility criteria only 
 ; and will take the necessary action to do so.  An email will be
 ; generated letting the user know which patients had tests changed to
 ; a NO LONGER REQUIRED status.
 ;
EN ; Post-install entry point
 D INIT
 Q
INIT ; Initialize tracking global and associated checkpoints.
 K ^TMP($J),^XTMP("DG-DFN"),^XTMP("DG-DGIDT"),^XTMP("DG-DGMTI")
 N %,I,X,X1,X2
 ; Create Checkpoints
 I $D(XPDNM) D
 .I $$VERCP^XPDUTL("DFN")'>0 D
 ..S %=$$NEWCP^XPDUTL("DFN","",0)
 .I $$VERCP^XPDUTL("DGIDT")'>0 D
 ..S %=$$NEWCP^XPDUTL("DGIDT","",0)
 .I $$VERCP^XPDUTL("DGMTI")'>0 D
 ..S %=$$NEWCP^XPDUTL("DGMTI","",0)
 ;
 ; Initialize tracking global
 F I="DFN","DGIDT","DGMTI" D
 .I $D(^XTMP("DG-"_I)) Q
 .S X1=DT,X2=30 D C^%DTC
 .S ^XTMP("DG-"_I,0)=X_U_$$DT^XLFDT_"^DG*5.3*401 POST INSTALL"
 .S ^XTMP("DG-"_I,0)=^XTMP("DG-"_I,0)_$S(I="DFN":" Patient Records",I="DGIDT":" Means Test Records Reviewed",I="DGMTI":" MT Records corrected",1:" errors")
 I '$D(XPDNM) S (^XTMP("DG-DFN",1),^XTMP("DG-DGIDT",1),^XTMP("DG-DGMTI",1))=0
 ; Check status and if root check point not complete start cleanup.
 I $D(XPDNM) S %=$$VERCP^XPDUTL("DFN") D
 .I '$D(^XTMP("DG-DFN",1)) S ^XTMP("DG-DFN",1)=0
 .I '$D(^XTMP("DG-DGIDT",1)) S ^XTMP("DG-DGIDT",1)=0
 .I '$D(^XTMP("DG-DGMTI",1)) S ^XTMP("DG-DGMTI",1)=0
 I $G(%)="" S %=0
 I %=0 D START
 Q
START ;Main control of action starts here
 D EN1
 I $D(XPDNM) D
 .S %=$$COMCP^XPDUTL("DFN")
 .S %=$$COMCP^XPDUTL("DGIDT")
 .S %=$$COMCP^XPDUTL("DGMTI")
 D BUILD,MAIL,DONE
 Q
EN1 ;
 D BMES^XPDUTL("POST INSTALLATION PROCESSING")
 D MES^XPDUTL("----------------------------")
 D MES^XPDUTL("This post installation will generate an e-mail message")
 D MES^XPDUTL("reporting on Means Test records for deceased patients")
 D MES^XPDUTL("whose eligibility criteria dictate that these tests ")
 D MES^XPDUTL("should be in a 'NO LONGER REQUIRED' status.  These tests")
 D MES^XPDUTL("were not in the correct status for a number of reasons")
 D MES^XPDUTL("and are being corrected.  This process may take a while,")
 D MES^XPDUTL("please be patient.  Thanks!")
 D BMES^XPDUTL("Search engine started at "_$$FMTE^XLFDT($$NOW^XLFDT))
 D BMES^XPDUTL("Each "_"`.`"_" represents approximatly 200 records ")
 N DFN,DGMTI,DGCS,DGIDT,DGCNT,DGNODE,MTIEN,DGDOA,DGDT,DGIDT1,DGMTST
 S DFN=0 F DGCNT=1:1 S DFN=$O(^DPT(DFN)) Q:'+DFN  D
 .I '$D(ZTQUEUED) W:'(DGCNT#200) "."
 .S ^XTMP("DG-DFN",1)=$G(^XTMP("DG-DFN",1))+1
 .D:$P($G(^DPT(DFN,.35)),U)'=""
 ..S DGDOA=$P($G(^DPT(DFN,.35)),U) I DGDOA["." S DGDOA=$P(DGDOA,".",1)
 ..S DGDT="",DGIDT=$S($G(DGDT)>0:-DGDT,1:-DT) S:'$P(DGIDT,".",2) DGIDT=DGIDT_.2359
 ..F  S DGIDT=$O(^DGMT(408.31,"AID",1,DFN,DGIDT)) Q:'DGIDT  D
 ...S ^XTMP("DG-DGIDT",1)=$G(^XTMP("DG-DGIDT",1))+1
 ...F DGMTI=0:0 S DGMTI=$O(^DGMT(408.31,"AID",1,DFN,DGIDT,DGMTI)) Q:'DGMTI  D
 ....S DGIDT1=(DGIDT*-1)
 ....S DGNODE=$G(^DGMT(408.31,DGMTI,0)),DGMTST=$P(DGNODE,U,3)
 ....Q:'+$G(^DGMT(408.31,DGMTI,"PRIM"))
 ....Q:$P($G(DGNODE),U,19)'=1
 ....I DGNODE,$G(^("PRIM")) S MTIEN=DGMTI_U_$P(DGNODE,U)_U_$$MTS^DGMTU(DFN,DGMTST)_U_$P(DGNODE,U,23)
 ....I $G(MTIEN),$P(MTIEN,U,4)'="N" D
 .....S SUCCESS=$$REQ(DFN,DGMTI,DGMTST,DGIDT)
 .....I +SUCCESS=1 S ^TMP($J,"SUCCESS",DFN_"~~"_DGMTI)=DGMTST,^XTMP("DG-DGMTI",1)=$G(^XTMP("DG-DGMTI",1))+1
 .....Q
 ....Q
 ...I $D(XPDNM) S %=$$UPCP^XPDUTL("DGMTI",DGMTI)
 ...Q
 ..I $D(XPDNM) S %=$$UPCP^XPDUTL("DGIDT",DGIDT)
 ..Q
 .I $D(XPDNM) S %=$$UPCP^XPDUTL("DFN",DFN)
 .Q
 Q
REQ(DFN,DGMTI,DGCS,IDT) ; Determine if test is Required
 ;
 ; ** amended copy of EN^DGMTR as check for latest Primary **
 ; ** test is not valid for this cleanup.                  **
 ;
 ; Input:
 ;  DFN     - Patient ID
 ;  DGMTI   - Annual Means Test IEN
 ;  DGCS    - Annual Means Test Status
 ;  IDT     - Means Test Date
 ;
 ; Output:
 ;  DGREQF  - Means Test Require Flag
 ;                   (1 if required and 0 if not required)
 ;  DGDOM1  -  DOM Patient Flag (defined and set to 1 if
 ;                               patient currently on a DOM ward)
 ;
 N DGDOM,DGMT0,DGMTYPT,OLD,DGRGAUTO,DGQSENT,DGMSGF,SUCCESS,DGREQF
 ;
 S (SUCCESS,DGQSENT,DGREQF)=0,(OLD,DGMTYPT,DGMSGF,DGMTMSG)=1
 I $D(^DPT(DFN,.36)) S X=^(.36) D
 . I $P($G(^DIC(8,+X,0)),"^",9)=5!($$SC^DGMTR(DFN)) S DGREQF=1
 . I $P(X,"^",2),$P(X,"^",2)<3 S DGREQF=0
 I DGREQF S:$G(^DPT(DFN,.38)) DGREQF=0
 I DGREQF D DOM^DGMTR S:$G(DGDOM) DGREQF=0
 S DGMT0=$G(^DGMT(408.31,DGMTI,0))
 I DGCS S OLD=$$OLD^DGMTU4(IDT)
 I $P($G(^DPT(DFN,.53)),U)="Y" S DGREQF=0
 ;
 D
 .I 'DGREQF,DGCS,DGCS'=3,'$G(DGDOM) D NOL^DGMTR S SUCCESS=1 Q
 ;
 ;be sure to check whether or not patient is subject to RX copay!
 ;
 D EN^DGMTCOR
 Q SUCCESS
DONE ;
 K ^TMP($J),^UTILITY($J)
 K DGMTMSG
 Q
BUILD ;Build ^UTILITY($J, nodes for use by mailman.
 I '$D(^TMP($J,"SUCCESS")) D
 .S ^UTILITY($J,1)="No means test records found on deceased patients requiring"
 .S ^UTILITY($J,2)="correction."
 I $D(^TMP($J,"SUCCESS")) D
 .S ^UTILITY($J,1)="The following means tests were found for deceased patients"
 .S ^UTILITY($J,2)="that should have been in a 'NO LONGER REQUIRED' status.  These"
 .S ^UTILITY($J,3)="tests were found in a status other than 'NO LONGER REQUIRED'"
 .S ^UTILITY($J,4)="and have been corrected.  This information is based upon"
 .S ^UTILITY($J,5)="the business rules for a 'NO LONGER REQUIRED' status "
 .S ^UTILITY($J,6)="determination to be valid."
 .S ^UTILITY($J,7)=" "
 .S ^UTILITY($J,8)="** SPECIAL NOTE: This report reflects ONLY Current and Previous"
 .S ^UTILITY($J,9)="                 income year tests corrected by DG*5.3*401."
 .S ^UTILITY($J,10)=" "
 .S ^UTILITY($J,11)=$$BLDSTR("PATIENT NAME","SSN","TEST DATE")
 .S ^UTILITY($J,12)=$$BLDSTR("------------","---","---------")
 .N I,DGDFN,DGDFN1,DGSSN,DGMTI,DGMTD,PNAME,OSTAT,NSTAT
 .S (DGDFN,DGDFN1,DGSSN,DGMTI)=""
 .F I=13:1 S DGDFN=$O(^TMP($J,"SUCCESS",DGDFN)) Q:'+DGDFN  D
 ..S DGDFN1=$P($G(DGDFN),"~~",1)
 ..S DGMTI=$P($G(DGDFN),"~~",2)
 ..S PNAME=$P($G(^DPT(DGDFN1,0)),U),P1=PNAME
 ..S DGSSN=$P($G(^DPT(DGDFN1,0)),U,9),P2=DGSSN
 ..S DGMTD=$P($G(^DGMT(408.31,DGMTI,0)),U),P3=DGMTD
 ..Q:P3'>$$LIY(DT)
 ..S ^UTILITY($J,I)=$$BLDSTR(P1,P2,P3)
 ..Q
 .Q
 S ^UTILITY($J,99998)=" "
 I $D(^TMP($J,"SUCCESS")) S ^UTILITY($J,99999)="** - Indicates a Pseudo SSN has been used for this patient."
 Q
MAIL ;Send an email notifying user of what records were successfully
 ;changed to NLR status based upon normal MT criterion.
 N %,DIFROM,Y,XMDUZ,XMSUB,XMTEXT,XMY,XMZ
 S XMY(DUZ)="",XMY(.5)="",XMDUZ="REGISTRATION PACKAGE"
 S XMTEXT="^UTILITY($J,"
 S XMSUB="'NO LONGER REQUIRED' MEANS TEST ON EXPIRED PTS. CLEANUP"
 D ^XMD
 D BMES^XPDUTL("MAIL MESSAGE # < "_XMZ_" > SENT.")
 Q
BLDSTR(P1,P2,P3) ;Build a string from input variables
 ; Input - P1 (Parameter 1) = Patient Name
 ;         P2 (   ""     2) =   ""    SSN
 ;         P3 (   ""     3) =   ""    MT Date
 ;
 ; Output - String built from input variables to be used
 ;          in mailman output.
 ;
 N S1,S2,S3
 S S1=$E(P1,1,15),S1=S1_$J(" ",(20-$L(S1)))
 S S2=P2
 I S2?9N S S2=$E(S2,1,3)_"-"_$E(S2,4,5)_"-"_$E(S2,6,9),S2=S2_$J(" ",(20-$L(S2)))
 I S2?9N.A S S2=$E(S2,1,3)_"-"_$E(S2,4,5)_"-"_$E(S2,6,10)_" **",S2=S2_$J(" ",(20-$L(S2)))
 I S2'?9N S S2=S2_$J(" ",(20-$L(S2)))
 S S3=P3,Y=S3 X ^DD("DD") S S3=Y,S3=S3_$J(" ",(20-$L(S3)))
 Q S1_S2_S3
LIY(DT) ;Determine Last Income year
 N X,%DT,Y,DGINY
 S X="T",%DT="" D ^%DT
 S DGINY=Y,DGINY=$$LYR^DGMTSCU1(DGINY)
 Q (DGINY-10000)
