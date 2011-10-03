GMTSDEM ; SLC/DLT,KER - Demographics ; 12/11/2002
 ;;2.7;Health Summary;**28,49,55,56,60,73**;Oct 20, 1995
 ;                 
 ; External References
 ;   DBIA 10061  OAD^VADPT
 ;   DBIA 10061  OPD^VADPT
 ;   DBIA 10061  SVC^VADPT
 ;   DBIA 10061  ADD^VADPT
 ;   DBIA 10061  DEM^VADPT
 ;   DBIA 10061  ELIG^VADPT
 ;   DBIA  2967  ^DIC(31,
 ;   DBIA 10035  ^DPT( (file #2)
 ;                     
DEMOG ; Demographic (VADPT)
 N I,VA,VADM,VAERR,VAOA,VASV,VAPA,VAPD,VAEL,SCD,SCDS,SCDP,FROM,GMI,TO,IX,X,Z
 D ADR,PER,SVC,BOS,COMB,ELIG,SC,SCDD,MT
 D NOK^GMTSDEM2,CD^GMTSDEMP(+($G(DFN)))
 D INS^GMTSDEM2,TF^GMTSDEMB(+($G(DFN)))
 D SRC^GMTSDEMB,END
 Q
DEMO(DFN) ;
 K ^TMP("GMTSDEMO",$J,+($G(DFN)))
 N GMTSDEMX,I,VA,VADM,VAERR,VAOA,VASV,VAPA,VAPD,VAEL,SCD,SCDS,SCDP,FROM,GMI,TO,IX,X,Z
 S GMTSDEMX="" D DEMOG D:$D(GMTSTEST) ST
 Q
ADR ; Patient Address
 Q:$D(GMTSQIT)  D:$D(GMTSDEMX) NAM Q:$D(GMTSQIT)  N %,%H,VA,VAPA,VAERR D ADD^VADPT
 D WRT("Address",$S($L(VAPA(1)):VAPA(1),1:"Not available"),"Phone",VAPA(8),1) Q:$D(GMTSQIT)
 I VAPA(2)'="" D WRT(($J("",21)_VAPA(2)),,,,0) Q:$D(GMTSQIT)
 I VAPA(3)'="" D WRT(($J("",21)_VAPA(3)),,,,0) Q:$D(GMTSQIT)
 I VAPA(4)'="" D  Q:$D(GMTSQIT)
 . N STR S STR=VAPA(4)_", " S:VAPA(5)'="" STR=STR_$P($G(VAPA(5)),"^",2)_"  "
 . S:VAPA(6)'="" STR=STR_VAPA(6) D WRT("",STR,"County",$P(VAPA(7),"^",2),1)
 D WRT(" ",,,,0)
 Q
NAM ; Name/SSN/DOB/Sex
 N VAPTYP,VAHOW,VAROUT,VADM D DEM^VADPT
 D WRT("Name",$G(VADM(1)),"SSN",$E($P($G(VADM(2)),"^",2),1,11),1)
 D WRT("Date of Birth",$$EDT^GMTSU($P($G(VADM(3)),"^",1)),,,1)
 Q
PER ; Personal
 Q:$D(GMTSQIT)  N %,%H,VA,VADM,VAERR,VAPD D DEM^VADPT,OPD^VADPT
 I VADM(10)'=""!(VADM(4)'="") D  Q:$D(GMTSQIT)
 . D WRT("Marital Status",$P($G(VADM(10)),"^",2),"Age",$P($G(VADM(4)),"^",1),1)
 I VADM(9)'=""!(VADM(5)'="") D  Q:$D(GMTSQIT)
 . D WRT("Religion",$P($G(VADM(9)),"^",2),"Sex",$P($G(VADM(5)),"^",2),1)
 D RACE^GMTSDEM2 I VAPD(6)'="" D  Q:$D(GMTSQIT)
 . D WRT("Occupation",$P($G(VAPD(6)),"^",1),,,1)
 Q
SVC ; Service
 Q:$D(GMTSQIT)  N %,%H,VAEL,VAERR D ELIG^VADPT
 I $P(VAEL(2),"^",1) D  Q:$D(GMTSQIT)
 . D WRT("Period of Service",$P($G(VAEL(2)),"^",2),,,1)
 Q
BOS ; Branch of Service
 Q:$D(GMTSQIT)  N %,%H,VAEL,VAERR,VASV,GMTSI,FROM,TO
 D SVC^VADPT F GMTSI=6,7,8 D
 . Q:'$D(VASV(GMTSI))  Q:+(VASV(GMTSI))=0
 . S FROM=$$EDT^GMTSU($P(VASV(GMTSI,4),U,1))
 . S TO=$$EDT^GMTSU($P(VASV(GMTSI,5),U,1))
 . S:$L(FROM)&('$L(TO)) TO="UNKNOWN"
 . D:GMTSI=6 WRT("Branch of Service",($P(VASV(GMTSI,1),U,2)_" "_FROM_" TO "_TO),,,1)
 . D:GMTSI'=6 WRT("",($P(VASV(GMTSI,1),U,2)_" "_FROM_" TO "_TO),,,1)
 Q
COMB ; Service Connected Disabilities
 Q:$D(GMTSQIT)  N %,%H,VAEL,VAERR,VASV D ELIG^VADPT,SVC^VADPT
 I $P(VAEL(2),U) D  Q:$D(GMTSQIT)
 . D WRT("Combat",$S(VASV(5):"YES",1:"NO"),"POW",$S(VASV(4):"YES",1:"NO"),1)
 Q
ELIG ; Eligibility
 Q:$D(GMTSQIT)  N Z,I,%,%H,VAEL,VAERR D ELIG^VADPT
 I $P(VAEL(1),"^",1) D  Q:$D(GMTSQIT)
 . D WRT("Eligibility",$P(VAEL(1),"^",2),$S(VAEL(8)'="":"Status",1:""),$P(VAEL(8),"^",2),1)
 I $O(VAEL(1,0)) D  Q:$D(GMTSQIT)
 . S I=0 F Z=0:0 D  Q:$D(GMTSQIT)  Q:I=""
 . . Q:$D(GMTSQIT)  S I=$O(VAEL(1,I)) Q:I=""
 . . D WRT("",$P(VAEL(1,I),"^",2),,,1)
 Q
SC ; Service Connected Percent
 Q:$D(GMTSQIT)  N %,%H,VAEL,VAERR D ELIG^VADPT
 D:VAEL(3) WRT("S/C %",$P(VAEL(3),"^",2),,,1)
 Q
SCDD ; Service Connected Disabilities/Diagnosis
 Q:$D(GMTSQIT)  N SCD,SCDP,SCDS,IX,GMTSC S (IX,GMTSC)=0
 F  S IX=$O(^DPT(DFN,.372,IX)) Q:$D(GMTSQIT)  Q:+IX=0  D SCDP  Q:$D(GMTSQIT)
 Q
SCDP ; Service Connected Diagnosis
 Q:$D(GMTSQIT)  N SCD,SCDS,SCDP S SCD=^DPT(DFN,.372,IX,0)
 S SCDS=$S($P(SCD,"^",1):$P(^DIC(31,$P(SCD,"^",1),0),"^",1),1:"")
 S SCDP=$P(SCD,"^",2)_"% "_$S($P(SCD,"^",3):"SC",1:"")
 S GMTSC=+($G(GMTSC))+1
 I +($G(GMTSC))'>1 D  Q:$D(GMTSQIT)
 . S STR="   S/C Disabilities: "_SCDS,STR=STR_$J("",(61-$L(STR)))_SCDP
 . D WRT(STR,,,,0)
 I +($G(GMTSC))>1 D
 . S STR=$J("",21)_SCDS,STR=STR_$J("",(61-$L(STR)))_SCDP
 . D WRT(STR,,,,0)
 Q
MT ; Means Test
 Q:$D(GMTSQIT)  N %,%H,VAEL,VAERR D ELIG^VADPT
 D:VAEL(9)'="" WRT("Means Test",$P(VAEL(9),"^",2),,,1)
 Q
NOK ; Next of Kin
 Q:$D(GMTSQIT)  N %,%H,VAOA S VAOA("A")=1 D OAD^VADPT
 Q:VAOA(9)=""  I VAOA(9)'="" D  Q:$D(GMTSQIT)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W ?16,"NOK: ",VAOA(9)
 . W:VAOA(10)'="" ?51,"Relation: ",VAOA(10) W !
 I VAOA(1)'="" D  Q:$D(GMTSQIT)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W:VAOA(1)]"" ?21,VAOA(1)
 . W:VAOA(8)'="" ?54,"Phone: ",VAOA(8) W !
 I VAOA(2)'="" D  Q:$D(GMTSQIT)
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W ?21,VAOA(2),!
 I VAOA(3)'="" D  Q:$D(GMTSQIT)
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W ?21,VAOA(3),!
 I VAOA(4)'="" D  Q:$D(GMTSQIT)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W ?21,VAOA(4) W:VAOA(5) ", ",$P(VAOA(5),U,2)
 . W:VAOA(6) "  ",VAOA(6) W !
 Q
IEN ; Ineligible for Care Data
 Q:$D(GMTSQIT)  N STR,REM,WRD,%,%H,VAEL,VAERR,GMTSDT D ELIG^VADPT
 I +($P(VAEL(5,1),U,1))>0 D
 . S GMTSDT=$$EDT^GMTSU($P(VAEL(5,1),U,1))
 . Q:$D(GMTSQIT)  D WRT("Ineligible date",GMTSDT,,,1)
 . Q:$D(GMTSQIT)  S STR=$P(VAEL(5,2),U,2)_"  "_VAEL(5,3)_", "_$P(VAEL(5,4),U,2)
 . D WRT("Inelig. TWX source",STR,,,1)
 . Q:$D(GMTSQIT)  S STR=$G(VAEL(5,5))
 . F WRD=1:1 Q:$L(STR)'>58  D
 . . S REM=$P(STR," ",($L(STR," ")-WRD),$L(STR," "))
 . . S STR=$P(STR," ",1,($L(STR," ")-(WRD+1)))
 . D:$L(STR) WRT(($J("",21)_STR),,,,0)
 . D:$L(REM) WRT(($J("",21)_REM),,,,0)
 . D:$L(VAEL(5,6)) WRT("Reason",$E(VAEL(5,6),1,58),,,1)
 Q
 ;                      
WRT(CH1,CD1,CH2,CD2,FMT) ; Write/Save Demographic Line
 ;          
 ;   Input
 ;     CH1 - Column 1 Header or Preformated Line
 ;     CD1 - Column 1 Data
 ;     CH2 - Column 2 Header
 ;     CD2 - Column 2 Data
 ;     FMT - Format in Columns  1=Yes 0=No
 ;          
 ;   If the variable GMTSDEMX exist, then the data will 
 ;   be saved in a global array instead of written to the
 ;   screen.  Global array:
 ;          
 ;     ^TMP("GMTSDEMO",$J,DFN,#)=<demographic text>
 Q:$D(GMTSQIT)  N STR,BL,COL1,COL2,LN,LNLGTH
 S LN=+($O(^TMP("GMTSDEMO",$J,+($G(DFN))," "),-1))+1,CH1=$G(CH1),CD1=$G(CD1),CH2=$G(CH2),CD2=$G(CD2),FMT=$G(FMT)
 S:+FMT'>0 STR=CH1
 I +FMT>0 D
 . S LNLGTH=59
 . S:CH2="" LNLGTH=78
 . S BL=$J("",(19-$L(CH1))),CH1=BL_CH1_$S($L(CH1)>0:": ",1:"  ")
 . S BL=$J("",(((LNLGTH-$L(CH1))-$L(CH2))-2))
 . S CD1=$E(CD1,1,$L(BL)),COL1=CH1_CD1
 . S BL=$J("",((59-$L(COL1))-$L(CH2)))
 . S CH2=BL_CH2_$S($L(CH2)>0:": ",1:"  "),COL2=CH2_$E(CD2,1,17)
 . S STR=COL1_COL2
 I '$D(GMTSDEMX) D CKP^GMTSUP Q:$D(GMTSQIT)  W $G(STR),!
 S:$D(GMTSDEMX) ^TMP("GMTSDEMO",$J,+($G(DFN)),LN)=STR
 Q
 ;                        
ST ; Show ^TMP Global Array
 W !! N NN,NC S NN="^TMP(""GMTSDEMO"","_$J_","_+($G(DFN))_")",NC="^TMP(""GMTSDEMO"","_$J_","_+($G(DFN))_"," F  S NN=$Q(@NN) Q:NN=""!(NN'[NC)  W !,@NN
 Q
END ; Clean-up and quit
 K I,VA,VADM,VAERR,VAOA,VASV,VAPA,VAPD,VAEL,SCD,SCDS,SCDP,FROM
 K GMI,TO,IX,X,Z Q
