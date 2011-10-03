RAUTL3 ;HISC/CAH,FPT,GJC AISC/SAW-Utility for Callable Entry Points ;4/1/97  10:04
 ;;5.0;Radiology/Nuclear Medicine;**26**;Mar 16, 1998
EN1 ;ENTRY POINT FOR AMIE CALL
 ;Requires four input variables
 ;    DFN = Patient internal entry number
 ;  Date range for report in Fileman internal format
 ;    RABDT = Beginning Date (time optional)
 ;    RAEDT = Ending Date (time optional)
 ;  Exam locations (from file 44, Hospital Location) that are to be
 ;    included in the report
 ;    RAHLOC = A string of internal entry numbers for locations
 ;               Each location separated by ^ and RAHLOC must begin
 ;               and end with an ^ (e.g., RAHLOC=^3^ or RAHLOC=^56^75^)
 ;               These are REQUESTING locations, not imaging locations
 ;
 I '$D(DFN)!('$D(RAHLOC))!('$D(RABDT))!('$D(RAEDT)) W !!,"Required variables are not defined.  Unable to continue.",*7 Q
 S RAMIE=1 F RAPTR=RABDT-.0000001:0 S RAPTR=$O(^RADPT(DFN,"DT","B",RAPTR)) Q:RAPTR'>0!(RAPTR>RAEDT)  S RAPTR1=$O(^(RAPTR,0)) I RAPTR1 F RAPTR2=0:0 S RAPTR2=$O(^RADPT(DFN,"DT",RAPTR1,"P",RAPTR2)) Q:RAPTR2'>0  I $D(^(RAPTR2,0)) S RAEX=^(0) D CHK
 K RACNI,RAEX,RAII,RAK,RAMDIV,RAMDV,RAMLC,RAMIE,RANUM,RAPT1,RAPTR,RAPTR1,RAPTR2,RASSN,RAST Q
CHK I $P(RAEX,U,17),RAHLOC[(U_$P(RAEX,U,22)_U) S RAST=$S($D(^RARPT($P(RAEX,"^",17),0)):^(0),1:"") I "VR"[$P(RAST,"^",5) S RARPT=$P(RAEX,"^",17),RAPT1=1 D ^RARTR F RAK=0:0 S RAK=$O(^RA(78.7,RAK)) Q:RAK'>0  I $D(^(RAK,0)) K @$P(^(0),"^",5)
 Q
SIGNON  ;Check the # of reports to either pre-verify of verify.
 Q:'$D(DUZ)#2  N RA74,X0,X1,Y1 S (X0,X1,Y1)=0
 ; first, tabulate # (Y1) of reports to pre-verify (if any)
 F  S X0=$O(^RARPT("ARES",DUZ,X0)) Q:X0'>0  D
 . S RA74=$G(^RARPT(X0,0))
 . Q:$$STUB^RAEDCN1(X0)  ; skip stub report 031501
 . Q:$P(RA74,"^",5)="V"  ; skip if already verified
 . S:$P(RA74,"^",12)']"" Y1=Y1+1
 . Q
 S:Y1 X0="!*** You have "_Y1_" imaging report"_$S(Y1>1:"s",1:"")_" to pre-verify. ***"
 D:Y1 SET^XUS1A(X0)
 ; next tabulate # (X1) of reports to verify (if any)
 S X0=0 F  S X0=$O(^RARPT("ASTF",DUZ,X0)) Q:X0'>0  D
 . S RA74=$G(^RARPT(X0,0))
 . Q:$$STUB^RAEDCN1(X0)  ; skip stub report 031501
 . Q:$P(RA74,"^",5)="V"  ; skip if already verified
 . S X1=X1+1
 Q:X1'>0
 S X0="!*** You have "_X1_" imaging report"_$S(X1>1:"s",1:"")_" to verify. ***"
 D SET^XUS1A(X0)
 Q
UPDT(RANODE) ; Delete blank lines for Rad/Nuc Med Word Processing fields.
 ; These 'blank' consist of nothing more than spaces.
 ; 'RANODE' is the data node to be examined: i.e, for Clinical History
 ; in Rad/Nuc Med Orders (75.1) RANODE="^RAO(75.1,"_DA_",H,"
 ; -or in Rad/Nuc Med Reports (74) RANODE="^RARPT(DA_",R,"
 ; 
 N RA0,RACNT,RAI,RATCNT,RAXIT,RAY
 S (RACNT,RATCNT,RAXIT)=0 S RAI=999999999
 S RAY=$G(@(RANODE_"0)")),RAY(4)=+$P(RAY,"^",4) Q:'RAY(4)
 F  S RAI=$O(@(RANODE_RAI_")"),-1) Q:RAI'>0  D  Q:RAXIT
 . S RA0=$G(@(RANODE_RAI_",0)"))
 . I RA0?1.999" " D
 .. K @(RANODE_RAI_",0)") S RACNT=RACNT+1
 . E  S RAXIT=1
 . Q
 I RACNT D
 . S RATCNT=RAY(4)-RACNT
 . S @(RANODE_"0)")="^^"_RATCNT_"^"_RATCNT_"^"_$S($D(DT)#2:DT,1:$$DT^XLFDT())
 . Q
 Q
