VBECDCX ;hoifo/gjc-data conversion & pre-implementation data extract;Nov 21, 2002
 ;;2.0;VBEC;;Jun 05, 2015;Build 4
 ;
 ;Medical Device #:
 ;Note: The food and Drug Administration classifies this software as a
 ;medical device.  As such, it may not be changed in any way.
 ;Modifications to this software may result in an adulterated medical
 ;device under 21CFR820, the use of which is considered to be a
 ;violation of US Federal Statutes.  Acquiring and implementing this
 ;software through the Freedom of Information Act requires the
 ;implementer to assume total responsibility for the software, and
 ;become a registered manufacturer of a medical device, subject to FDA
 ;regulations.
 ;
 ;Call to $$NEWERR^%ZTER is supported by IA: 1621
 ;Call to NAMECOMP^XLFNAME is supported by IA: 3065
 ;Execution of ^%ZOSF("TEST") is supported by IA: 10096
 ;Direct global read of ^DPT(DFN,0) supported by IA: 10035
 ;
 ; This routine was originally created to handle data extracts from
 ; VistA's Lab Data (#63) file.
 ;
PAT(DFN,LRDFN) ; build the primary patient identifier string.
 ; convert specific patient attributes from VistA to SQL tables.
 ; Values to covert and maximum string lengths:
 ; LRDFN=ien of the patient record in the Lab Data (#63) file (12)
 ; DFN=ien of the patient in the Patient (#2) file (12)
 ; LRNAM=LRNAM("FAMILY")^LRNAM("GIVEN")^LRNAM("MIDDLE")^LRNAM("SUFFIX")
 ; LRNAM(patient name) subcomponents above concatenated (30)
 ; LRSEX(sex)='M' or 'F', (1)
 ; LRDOB(date of birth)='mm/dd/yy<sp>time' time optional, (18)
 ; LRSSN(ssn)='123456789' (9)
 ; LRICN(ICN)='100072010000' (12)
 ; $P(LRBO,U) (blood type)='AB' (2)
 ; $P(LRBLD,U,2) (RH type)='N' or 'P' (1)
 ;
 ; Output:
 ;  LRSTR=DFN^LRNAM^LRSEX^LRDOB^^^LRSSN^LRICN^$P(LRBLD,U)^$P(LRBLD,U,2)
 ;  LRNAM=LRNAM("FAMILY")^LRNAM("GIVEN")^LRNAM("MIDDLE")^LRNAM("SUFFIX")
 ;
 ; initialize the error trap
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERR^VBECDCU1"
 E  S X="D ERR^VBECDCU1",@^%ZOSF("TRAP")
 ;initialize the global that keeps track of data elements by LRDFN
 ;increment the subscript tracking data elements at the record level
 S VBECRTOT=+$$CNT^VBECDCU("VBEC FINIS",$J)+1
 K X S $P(X,"0^",28)="",^TMP("VBEC FINIS",$J,VBECRTOT,0)=X K X
 ;
 S DPT(0)=$G(^DPT(DFN,0)),DPTNAME=$P(DPT(0),U),LRSTR="",U="^"
 D NAMECOMP^XLFNAME(.DPTNAME) S LRSEX=$P(DPT(0),U,2)
 ;
 I DPTNAME("FAMILY")["MERGING INTO" D  Q
  . S VBECMRG=$P($P(DPTNAME("FAMILY"),"`",2)," ")
  . K LRARY S LRARY(.01)=2,LRARY(.02)=DFN,LRARY(.03)=2,LRARY(.04)=VBECMRG,LRARY(.09)=$P($T(ERRMSG+3^VBECDC02),";",4)
  . D LOGEXC^VBECDC02(VBECIEN,.LRARY) K LRARY ; log this exception regardless of the task
  . Q
 ;
 S LRDOB=$P(DPT(0),U,3) ;return the internal FM value for DOB
 ;
 S LRSSN=$$STRIP^VBECDCX1($P(DPT(0),U,9))
 S DPTNAME=$$STRIP^VBECDCX1($G(DPTNAME("FAMILY")))_U_$$STRIP^VBECDCX1($G(DPTNAME("GIVEN")))_U_$$STRIP^VBECDCX1($G(DPTNAME("MIDDLE")))_U_$$STRIP^VBECDCX1($G(DPTNAME("SUFFIX")))
 ;obtain patient's ICN
 S LRICN=$$ICN^VBECDCU(DFN),LRSTR=LRDFN_U_DFN_U_DPTNAME_U_LRSEX_U_LRDOB_U_U_U_$E(LRSSN,1,9)_U_LRICN
 ; obtain ABO GROUP (#.05) & RH TYPE (#.06) from Lab Data (#63) file
 S LRBLD=$$BLUT^VBECDCU(LRDFN)
 S LRSTR=LRSTR_U_LRBLD
 ;tabulate data elements per LAB DATA record
 S:LRDFN $P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U)=LRDFN
 S:DFN $P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,2)=DFN
 S:$G(DPTNAME("FAMILY"))'="" $P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,3)=1
 S:$G(DPTNAME("GIVEN"))'="" $P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,4)=1
 S:$G(DPTNAME("MIDDLE"))'="" $P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,5)=1
 S:$G(DPTNAME("SUFFIX"))'="" $P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,6)=1
 S:LRSEX'="" $P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,7)=1
 S:LRDOB'="" $P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,8)=1
 S:LRSSN'="" $P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,9)=1
 S:LRICN'="" $P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,10)=1
 S:$P(LRBLD,U)'="" $P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,11)=1
 S:$P(LRBLD,U,2)'="" $P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,12)=1
 ;tabulate data elements for all LAB DATA records except LRDFN & DFN
 F I=3:1:12 S $P(^TMP("VBEC FINIS",$J,0),U,I)=$P(^TMP("VBEC FINIS",$J,0),U,I)+$P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,I)
 ;
 K I S CNT=$$CNT^VBECDCU("VBEC63 PAT",$J),CNT=CNT+1
 S ^TMP("VBEC63 PAT",$J,CNT,0)=LRSTR_$C(13)
 D ANTI(DFN,LRDFN,"AP"),ANTI(DFN,LRDFN,"AA"),ANTI(DFN,LRDFN,"AI")
 D TRD(DFN,LRDFN),BBC^VBECDCX1(DFN,LRDFN)
 S $P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,28)=$C(13)
 D KILL
 Q
 ;
ANTI(DFN,LRDFN,LRCHAR) ; extract 'RBC ANTIGENS PRESENT/ABSENT' or 'ANTIBODIES
 ; IDENTIFIED' data from the legacy Blood Bank application.  Notice the
 ; practice of swapping out the VistA ien for the antibodies equivalent
 ; SQL GUID.
 ; Input: DFN=patient DFN
 ;      LRDFN=lab patient ien in the Lab Data (#63) file
 ;     LRCHAR=char, 'AP' for antigens present, 'AI' for antigens
 ;            identified and 'AA' for antibodies absent
 S LRD1=0,LRN=$S(LRCHAR="AP":1,LRCHAR="AA":1.5,1:1.7)
 S LRS=$S(LRCHAR="AP":"VBEC63 ANTIP",LRCHAR="AA":"VBEC63 ANTIA",1:"VBEC63 AI")
 S:LRN=1 LRPCE=13 S:LRN=1.5 LRPCE=16 S:LRN=1.7 LRPCE=19
 F  S LRD1=$O(^LR(LRDFN,LRN,LRD1)) Q:'LRD1  D
 .S LRD=$G(^LR(LRDFN,LRN,LRD1,0)) Q:LRD=""
 .I LRN'=1.7 S LRSTR=LRDFN_U_DFN_U_LRD1_U_$$STRIP^VBECDCX1($$SWAP^VBECDCU(61.3,$P(LRD,U)))_U_LRCHAR_U_$$STRIP^VBECDCX1($P(LRD,U,2)) ; antigens present/absent
 .I LRN=1.7 S LRSTR=LRDFN_U_DFN_U_LRD1_U_$$STRIP^VBECDCX1($$SWAP^VBECDCU(61.3,$P(LRD,U)))_U_LRCHAR_U_$$STRIP^VBECDCX1($P(LRD,U,2)) ; antibodies
 .S CNT=$$CNT^VBECDCU(LRS,$J)
 .S CNT=CNT+1,^TMP(LRS,$J,CNT,0)=LRSTR_$C(13)
 .S:LRN=1 LRPCE=13 S:LRN=1.5 LRPCE=16 S:LRN=1.7 LRPCE=19
 .;
 .;total up the number of times antigens present/absent & antibodies
 .;identified in addition to their respective comments appear in patient
 .;specific data
 .D ANTIAB^VBECDCX1
 .;
 .Q
 ;total up the number of times antigens present/absent & antibodies
 ;identified in addition to their respective comments appear for ALL
 ;patient data
 F I=LRPCE:1:LRPCE+2 S $P(^TMP("VBEC FINIS",$J,0),U,I)=$P(^TMP("VBEC FINIS",$J,0),U,I)+$P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,I)
 ;
 K CNT,I,LRD,LRD1,LRN,LRPCE,LRS,LRSTR
 Q
 ;
TCTRC(DFN,LRDFN,LRD1) ; save off the transfusion or transfusion
 ; reaction comments.  called from both TRANS & TRANSR
 ; from TRANS
 ; Input: DFN=patient DFN
 ;      LRDFN=lab patient ien in the Lab Data (#63) file
 ;       LRD1=second level subscript; equivalent to FileMan's D1
 S (LRD2,Z)=0,LRSUB="VBEC63 TRC"
 ;indicate the number of occurences of transfusion reaction records
 F  S LRD2=$O(^LR(LRDFN,1.9,LRD1,1,LRD2)) Q:'LRD2  D
 .S Z=Z+1 S:Z=1 $P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,24)=1
 .S LRTRCMT=$$STRIP^VBECDCX1($P($G(^LR(LRDFN,1.9,LRD1,1,LRD2,0)),U))
 .Q:'($P(LRD1,"."))  ;RLM 05/10/07
 .S LRSTR="",LRSTR=LRDFN_U_DFN_U_$P(LRD1,".")_U_LRD2_U_LRTRCMT
 .S CNT=$$CNT^VBECDCU(LRSUB,$J)
 .S CNT=CNT+1,^TMP(LRSUB,$J,CNT,0)=LRSTR_$C(13)
 .D TRCMNT^VBECDCX1
 .Q
 K LRD2,LRSTR,LRSUB,LRTRCMT,Z
 Q
 ;
TRD(DFN,LRDFN) ; Extract transfusion reaction date data; date/time, reaction
 ; type, person entering reaction 
 ; Input: DFN=patient DFN
 ;      LRDFN=lab patient ien in the Lab Data (#63) file
 ;FILE 63 data here
 S LRD1=0 F  S LRD1=$O(^LR(LRDFN,1.9,LRD1)) Q:'LRD1  D
 .S LRD=$G(^LR(LRDFN,1.9,LRD1,0)) Q:LRD=""
 .S VBTRD=$$SWAP^VBECDCU(65.4,$P(LRD,U,2)) Q:VBTRD=""
 .Q:'($P(LRD1,"."))  ;RLM 05/03/07
 .S LRSTR=LRDFN_U_DFN_U_$P(LRD1,".")_U_$$DATE^VBECDCU($P(LRD,U))_U_VBTRD
 .;
 .S CNT=$$CNT^VBECDCU("VBEC63 TRD",$J)
 .S CNT=CNT+1,^TMP("VBEC63 TRD",$J,CNT,0)=LRSTR_$C(13)
 .D TRDTAB^VBECDCX1
 .D TCTRC(DFN,LRDFN,LRD1) ; get transfusion reaction comments
 .Q
 ;
 ;File 65 data here
 S CNT=$$CNT^VBECDCU("VBEC63 TRD",$J)
 S VBTRA="" F  S VBTRA=$O(^TMP($J,"VBEC_TR_REACT",DFN,VBTRA)) Q:VBTRA=""  D
 . Q:'$P($G(^LRD(65,VBTRA,6)),"^",5)  ;Q:'$P(^LRD(65,VBTRA,6),"^",8)
 . S VBTRD=$P(^LRD(65,VBTRA,6),"^",8)
 . S VBTRD=$$SWAP^VBECDCU(65.4,VBTRD) Q:VBTRD=""  ;S:VBTRD="" VBTRD="J"
 . S VBECTRDD=$P($G(^LRD(65,VBTRA,4)),"^",2),VBECTRDD=$S(VBECTRDD="":DT,1:$$DATE^VBECDCU(VBECTRDD))
 . S CNT=CNT+1,^TMP("VBEC63 TRD",$J,CNT,0)=LRDFN_"^"_DFN_"^65^"_VBECTRDD_"^"_VBTRD_$C(13)
 . S LRD="1^1" D TRDTAB^VBECDCX1
 ;
 ;
 ;total up the number of instances of transfusion reaction related data
 ;including transfusion reaction comment character counts for ALL
 ;records.
TRTOT ;
 F I=22:1:25 S $P(^TMP("VBEC FINIS",$J,0),U,I)=$P(^TMP("VBEC FINIS",$J,0),U,I)+$P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,I)
 K LRD,LRD1,LRSTR
 Q
 ;
KILL ; kill variables
 K CNT,DPT,DPTNAME,LRBLD,LRDATE,LRICN,LRMTH,DPTNAME,LRSEX,LRSSN,LRSTR
 Q
