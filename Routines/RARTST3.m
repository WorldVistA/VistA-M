RARTST3 ;HISC/CAH,FPT,GJC AISC/RMO-Distribution Reports ;11/24/97  12:16
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ;
SELECT ; Called from 6^RARTST1 (Clinic Dist. List) & 7^RARTST1 (Ward Dist List)
 ; variables passed in: DIC, RAB & RAWC.
 K BY,FR,RADIC,RAINPUT,RAQUIT,RAUTIL,TO
 S RADIC=DIC,RADIC(0)="QEAMZ",RADIC("A")="Select "_RAWC_": "
 S RAINPUT=1,RAUTIL="RA "_RAWC K ^TMP($J,RAUTIL)
 D EN1^RASELCT(.RADIC,RAUTIL,"",RAINPUT)
 I RAQUIT K RADIC,RAINPUT,RAQUIT,RAUTIL GOTO Q ; clean up, exit option
 S FR=$O(^TMP($J,RAUTIL,"")),TO=$O(^TMP($J,RAUTIL,""),-1)
 ;----------------------------------------------------------------------
 K ^TMP($J,RAUTIL),RADIC,RAINPUT,RAQUIT,RAUTIL
 K DIC,DIE,DR,D0,DA,DHIT,DIS,L,DHD,D,DIK,C,DIR,DIU,DIWL,DO
 S RARD("A")="Report Selection: ",RARD(1)="PRINTED^",RARD(2)="UNPRINTED^",RARD("B")=2 W !!,"Printed/Unprinted Report Selection",!,"----------------------------------",! D SET^RARD K RARD G Q:X="^"
 S DHD=$S(X="UNPRINTED":"Unprinted",1:"Printed")_" Reports by "_RAWC,FLDS="[RA "_X_" REPORTS]",BY="[RA "_$S(RAWC="Clinic":"CLINIC",1:"WARD")_" BY PRINT DATE]"
 S:X="UNPRINTED" FR="@,A,"_FR,TO="@,Z,"_TO I X="PRINTED" D DATE^RAUTL S:RAPOP X="^" G Q:X="^" S FR=BEGDATE_",A,"_FR,TO=ENDDATE+.9999_",Z,"_TO
 S DIS(0)="I $P($G(^RABTCH(74.4,D0,0)),U,11)=RAB S (RARPT,Y)=+^(0),RARDIFN=D0,RAY3=$G(^RABTCH(74.4,RARDIFN,0)) I RAY3]"""" S RADFN=+$P($G(^RARPT(RARPT,0)),U,2) D UPDLOC^RAUTL10 I $D(RAPRTOK)"
DIP S L=0,DIC="^RABTCH(74.4," W ! D EN1^DIP K DHD,L,DIC,FLDS,BY,FR,IOP,TO,DIS(0),RAPRTOK,RABTY,RACN,RADATE,RADTE,RARPT,RACNI,RADFN,RADTI,RAY3
Q K RAWC,RAB,BEGDATE,ENDDATE,RAWC,DIC,Y,RAB,X,RARDIFN,RAPOP
 K DISH,F,O,X1,W
 K BY,DHD,DDH,DISYS,FLDS,FR,I,J,POP,TO
 Q
DATX(X) ;external output function for date format
 ;Called by: [RA ALL UNPRINTED REPORTS] Print Template
 ;INPUT = FM internal date format (time optional)
 ;OUTPUT = date/time with slashes
 ;'RARPTFLG' is set in the subroutine '5+1^RARTST1'.
 N B,E,Y,YY S Y=$P(X,".",2),B=-1,E=0,YY="" I +Y,($L(Y)#2) S Y=Y_0
 I $L(Y)=2 S Y=Y_"00"
 I Y]"" F  S B=B+2,E=E+2,YY=YY_$E(Y,B,E) Q:E=($L(Y))  S YY=YY_":"
 Q $S(X'=+X:"",1:$E(X,4,5)_"/"_$S($E(X,6,7)="00":$E(X,2,3),1:$E(X,6,7)_"/"_$E(X,2,3)_$S('Y!($D(RARPTFLG)):"",1:"@"_YY)))
 ;
IMG() ; Allows the user to select one-many-all i-types.   Builds the
 ; local 'RAIMG(' array for all user selected imaging types.
 ; RAIMAG=$S(If 'RAIMAG' array properly defined:1,Else:0)
 K RAIMAG N RADIC,RAUTIL,RAX,RAY S RAX=""
 S RADIC="^RA(79.2,",RADIC(0)="QEAMZ",RADIC("A")="Select Imaging Type: "
 S RADIC("B")="All",RAUTIL="RA DIST I-TYPE" W !!
 D EN1^RASELCT(.RADIC,RAUTIL,"RAY") K ^TMP($J,RAUTIL)
 Q:'($D(RAY)\10) 0 ; no i-type data
 F  S RAX=$O(RAY(RAX)) Q:RAX=""  S RAIMAG(+$O(RAY(RAX,0)))=""
 Q:+$O(RAIMAG(0))=0 0
 Q 1
