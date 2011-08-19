FBARCH0 ; HINOIFO/RVD - ARCH IMPORT ELIGIBILITY AND UTILITY ; 01/08/11 12:30pm
 ;;3.5;FEE BASIS;**119**;JAN 30, 1995;Build 3
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;Integration Agreements:
 ; ^DPT( - #2070, 10035
 ; ^DIE - #2053
 ; ^VASITE -#10112
 ; ^XUAF4 - #2171
 ; ^DIC(4 - #10090
 ; ^MPIF001 - #2701
 ; @XPDGREF - 2433
 ; DT^DILF - #2054
 Q
START ;input SAS data file
 ;the imported file is located in certain directory
 N X,FBDIR,FBVMS,FBFILE
 S FBDIR="SYS$USER:[DAYO]"   ;for testing, use your own default directory
 W !!,"Enter VMS directory :"_FBDIR_"//" R X:DTIME
 Q:X="^"  S:X'="" FBDIR=X
 R !!,"Enter VMS file name :",FBVMS:DTIME
 Q:"^"[FBVMS
 S FBFILE=FBDIR_FBVMS
 W !!,"Full name of input file is ",FBFILE,!
 S DIR(0)="Y",DIR("A",1)="Import ARCH ELIGIBILITY file.",DIR("A",2)=" "
 S DIR("A")="Do you want to import data from "_FBFILE
 S DIR("B")="No"
 D ^DIR K DIR I 'Y W !!?5,"Nothing Done." D CLEANUP Q
 D OPEN^%ZISH("FILE",FBDIR,FBVMS,"R")
 I POP W !?3,"** This file cannot be opened. **" G ABEND
 S FBTAB="^",FBCOUNT=0,FBREAD=0
 ;S FBTAB=$C(9)
 W !,"Loading data into Fee Basis Patient file (#161)."
 ;
R1 ;A(1) = Integration Control Number (ICN)
 ;DBIA # 2701 - Master Patient Index
 ;A(2) = a field for validity check
 ;A(3) = eligibility code: 1 = yes, 0 = no
 ;if theres no A(3), it assumes it's a 1 for yes
 U IO R X:DTIME I $$STATUS^%ZISH G EOF
 K A,DFN,FBARCH,FBICN,FBDTE S FBREAD=FBREAD+1
 F I=1:1:3 S A(I)=$P(X,FBTAB,I)
 ;S FBTXT=A(1)_" *** "_A(2) ;for testing
 I $L(A(1))'=17 D  G R1 ; skip header record, only record start with a 10 digits ICN.
 . W !,"First field is "_A(1)_", record is not imported"
 . Q
 I A(1)="" D  G R1 ; skip null record
 . W !,"First field is null, record is not imported"
 . Q
 ;only process if data (ICN) belongs to the station & second check is valid
 S FBICN=$P(A(1),"V"),FBCHK=$P(A(1),"V",2)
 D DT^DILF("E",A(2),.FBDTE)
 S DFN=$$GETDFN^MPIF001(FBICN)
 S FBARCH=$S($G(A(3)):1,A(3)=0:0,1:1)
 I $G(DFN),$D(^DPT(DFN,"MPI")),$P(^("MPI"),U,2)=FBCHK D SETREC S FBCOUNT=FBCOUNT+1 I '(FBCOUNT#10) U 0 W "."
 G R1
 ;
EOF D CLOSE^%ZISH("FILE")
 S FBTXT=FBREAD_" records read, "_FBCOUNT_" records loaded." D DISP
 D CLEANUP
 Q
 ;
SETREC ;update Fee Basis Patient record (file #161) for ARCH elilibility
 N FBDATA,FBIEN,FBIEN2,FBI11
 S DA=DFN
 I '$D(^FBAAA(DFN,0)) K DD,DO S (X,DINUM)=DFN,DIC="^FBAAA(",DIC(0)="LM",DLAYGO=161 D FILE^DICN K DIC,DA,DD,DO,DLAYGO
 ;update eligibility if different
 I $D(^FBAAA(DFN,"ARCHFEE")) S FBI11=$O(^FBAAA(DFN,"ARCHFEE"," "),-1) Q:($P(^FBAAA(DFN,"ARCHFEE",FBI11,0),U,2)=FBARCH)
 S FBIEN2="+2,"_DFN
 S FBDATA(161.011,FBIEN2_",",.01)=FBDTE
 S FBDATA(161.011,FBIEN2_",",2)=FBARCH
 D UPDATE^DIE("","FBDATA")
 K FBDATA
 Q
 ;
ABEND U 0 W !,"Processing abended."
 D CLEANUP
 Q
 ;
DISP ;display one-line text either interactively or within KIDS installation
 I '$D(XPDNM)#2 U 0 W !?5,FBTXT
 E  D BMES^XPDUTL(FBTXT)
 Q
 ;
PRET ;entry point for a pre-transport routine, instead of
 ;using a global.  ARCH data should be in ^XTMP("FEEARCH") for transport
 ;
 M @XPDGREF@("^XTMP(""FEEARCH"")")=^XTMP("FEEARCH")
 Q
 ;
POST ;entry to import SAS data to VISTA Fee Basis Patient File (#161) using pre-transport rou.
 ;only process if data (ICN) belongs to the station & second check is valid
 N FBV,FBCOUNT,FBI,FBICN,FBDTE,FBCHK,DFN,FB4,FB47,FBA,FBSTA
 ;only install ARCH data to 5 VISNs (1,6,15,18 & 19)
 S FBV="VISN "
 F FBI=FBV_1,FBV_6,FBV_15,FBV_18,FBV_19 Q:FBI=""  S FB4=$O(^DIC(4,"B",FBI,0)) D
 .D CHILDREN^XUAF4("FBA","`"_FB4,"VISN")
 S FBSTA=+$$SITE^VASITE()
 Q:'$D(FBA("C",FBSTA))
 ;
 D MES^XPDUTL(" ")
 D MES^XPDUTL("Populating ARCH ELIGIBILITY in file (#161).....")
 ;
 K ^TMP("FEEARCH",$J)
 M ^TMP("FEEARCH",$J)=@XPDGREF@("^XTMP(""FEEARCH"")")
 S XPDIDTOT=$P(^TMP("FEEARCH",$J,0),U,4),FBCOUNT=0
 S FBI=0
 F  S FBI=$O(^TMP("FEEARCH",$J,FBI)) Q:'FBI  D
 . S FBCOUNT=FBCOUNT+1 I '(FBCOUNT#100) D UPDATE^XPDID(FBCOUNT)
 . K FBICN,FBDTE,FBCHK,FBTMP,DFN
 . S FBTMP=$G(^TMP("FEEARCH",$J,FBI,0))
 . S FBICN=$P(FBTMP,U),FBARCH=$P(FBTMP,U,2),FBDTE=$P(FBTMP,U,3),FBCHK=$P(FBTMP,U,4)
 . S DFN=$$GETDFN^MPIF001(FBICN)
 . I $G(DFN),$D(^DPT(DFN,"MPI")),$P(^("MPI"),U,2)=FBCHK D SETREC
 D UPDATE^XPDID(XPDIDTOT)
 Q
 ;
PST1 ;entry point if data is imported through a global
 S FBCOUNT=0
 S FBTXT="Importing the ARCH Eligibility to Fee Basis Patient File.."
 D DISP
 F I=0:0 S I=$O(^FBARCH(161.1,I)) Q:I'>0  D
 .K FBICN,FBDTE,FBCHK
 .S FBICN=$P(^FBARCH(161.1,I,0),U),FBARCH=$P(^(0),U,2),FBDTE=$P(^(0),U,3),FBCHK=$P(^(0),U,4)
 .S DFN=$$GETDFN^MPIF001(FBICN)
 .I $G(DFN),$D(^DPT(DFN,"MPI")),$P(^("MPI"),U,2)=FBCHK D SETREC S FBCOUNT=FBCOUNT+1
 S FBTXT="Done importing ARCH data to Fee Basis Patient File!!!!!"
 D DISP
 Q
 ;
TMP ;set-up ARCH data to ^XTMP("FEEARCH" temporary global for kids transport
 ;ICN = piece 1
 ;ARCH ELIGIBILITY DATE = piece 2
 S FBDIR="SYS$USER:[DAYO]"  ;use this as a default for testing
 W !!,"Enter VMS directory :"_FBDIR_"//" R X:DTIME
 Q:X="^"  S:X'="" FBDIR=X
 R !!,"Enter VMS file name :",FBVMS:DTIME
 Q:"^"[FBVMS
 S FBFILE=FBDIR_FBVMS
 W !!,"Full name of input file is ",FBFILE,!
 D OPEN^%ZISH("FILE",FBDIR,FBVMS,"R")
 I POP W !?3,"** This file cannot be opened. **" G ABEND
 S FBTAB="^",FBCOUNT=0,FBREAD=0
LOOP U IO R X:DTIME I $$STATUS^%ZISH S ^XTMP("FEEARCH",0)="^^^"_FBCOUNT G EOF
 K A,FBICN,FBDTE,FBCHK,FBARCH S FBREAD=FBREAD+1
 I '(FBREAD#500) U 0 W "."
 F I=1:1:3 S A(I)=$P(X,FBTAB,I)
 I $L(A(1))'=17 G LOOP ; skip header record, only record start with a 10 digits ICN +7 chksum
 I A(1)="" G LOOP ; skip null record
 S FBICN=$P(A(1),"V"),FBCHK=$P(A(1),"V",2)
 S FBARCH=$S($G(A(3)):1,A(3)=0:0,1:1)
 D DT^DILF("E",A(2),.FBDTE)
 S FBCOUNT=FBCOUNT+1 S ^XTMP("FEEARCH",FBCOUNT,0)=FBICN_U_FBARCH_U_FBDTE_U_FBCHK
 G LOOP
 Q
 ;
CLEANUP ;
 K A,F
 Q
 ;
ELIG(DFN,FBBDT,FBEDT,FBDATA) ;this function returns if pt is ARCH eligible or NOT
 ; input: = DFN - patient IEN (pointer to file #161)
 ;          FBBDT - beginning dt
 ;          FBEDT - ending dt
 ; output: FBDATA = 1 if eligible and FBDATA()=DFN^0 or 1^date of eligibility
 ;          from most recent to the oldest
 ;  FBDATA = 0 if not eligibile
 ;
 N FBI,FBDAT,FBEL,FBHDT,FBCNT,FBELDT,FBSAV1,FBSAV2,FBJ
 S (FBHDT,FBEL,FBELDT,FBCNT,FBDATA)=0
 S FBBDT=$S(FBBDT>0:FBBDT,1:0)
 S FBEDT=$S(FBEDT>0:FBEDT,1:9999999)
 Q:(FBEDT<FBBDT) FBDATA
 Q:'$D(^FBAAA(DFN,"ARCHFEE")) FBDATA
 S FBI=$O(^FBAAA(DFN,"ARCHFEE","B"," "),-1)
 S FBJ=$O(^FBAAA(DFN,"ARCHFEE","B",FBI,0)),FBDAT=$G(^FBAAA(DFN,"ARCHFEE",FBJ,0))
 I (FBEDT=FBI)!(FBEDT>FBI) D
 .S FBEL=$P(FBDAT,U,2)
 .S FBCNT=FBCNT+1 S FBDATA(FBCNT)=FBEL_U_FBI,FBDATA=FBEL
 F  S FBI=$O(^FBAAA(DFN,"ARCHFEE","B",FBI),-1) Q:FBI'>0  D
 .S FBJ=$O(^FBAAA(DFN,"ARCHFEE","B",FBI,0)),FBDAT=$G(^FBAAA(DFN,"ARCHFEE",FBJ,0))
 .Q:(FBEDT<FBI)
 .S FBEL=$P(FBDAT,U,2),FBCNT=FBCNT+1
 .S FBDATA(FBCNT)=FBEL_U_FBI
 ;
 S:$G(FBDATA(1)) FBDATA=$P(FBDATA(1),U)
 Q FBDATA
 ;
LIST(FBBDT,FBEDT) ;this function returns a list of ARCH patients w/in the date range.
 ; input: = FBBGT - beggingin dt
 ;          FBEDT - ending dt
 ; output:= number of ARCH eligible pt and ^TMP($J,"ARCHFEE",#)=DFN^0 or 1^date of eligibility
 ;          from the OLDEST to the MOST RECENT
 ; FBJ - internal entry number of file #161 which is DINUM to Patient File (2)
 N FBCOUNT,FBI,FBJ,FBEDAT,FBHDAT,FBELDA,FBELDT,FBEL,FBHDT,FBH
 K ^TMP($J,"ARCHFEE") S (FBI,FBCOUNT,FBELDTS)=0
 Q:'$D(^FBAAA("ARCH")) FBCOUNT
 S FBBDT=$S(FBBDT>0:FBBDT,1:0)
 S FBEDT=$S(FBEDT>0:FBEDT,1:9999999)
 Q:(FBEDT<FBBDT) FBCOUNT
 F  S FBI=$O(^FBAAA("ARCH",FBI)) Q:FBI=""  D
 .F FBJ=0:0 S FBJ=$O(^FBAAA("ARCH",FBI,FBJ)) Q:FBJ'>0  D
 ..S FBDFI=$O(^FBAAA("ARCH",FBI,FBJ,0))
 ..S FBEDAT=$G(^FBAAA(FBJ,"ARCHFEE",FBDFI,0)),FBELDT=$P(FBEDAT,U)
 ..Q:(FBEDT<FBELDT)
 ..S FBCOUNT=FBCOUNT+1
 ..S ^TMP($J,"ARCHFEE",FBCOUNT)=FBJ_U_$P(FBEDAT,U,2)_U_FBELDT
 Q FBCOUNT
 ;
PARSE(FB) ; parse - remove double quotes and trailing blanks if any
 N I,B
 Q:FB="" FB
 S:$E(FB,1)="""" FB=$E(FB,2,$L(FB))
 S:$E(FB,$L(FB))="""" FB=$E(FB,1,($L(FB)-1))
 Q:$E(FB,$L(FB))'=" " FB ; Last char is non-blank
 F I=$L(FB):-1:1 Q:$E(FB,I)'=" "  S B=$E(FB,1,I-1)
 S FB=B
 Q FB
