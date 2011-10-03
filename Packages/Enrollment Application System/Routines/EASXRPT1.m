EASXRPT1 ;ALB/AEG - Duplicate Pt. Relation Report ; 7-12-02
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**10**;Mar 15,2001
 ;
PRINT ; Output to selected I/O device.
 U IO
 N USER,RUN,A,B,C,HDR,PG,IY
 K DIR,DIRUT
 S USER=$$GET1^DIQ(200,DUZ_",",.01,"E")
 S FSTP=1
 S RUN="Run Date "_$$FMTE^XLFDT($E($$NOW^XLFDT,1,14),"1P")_" by "_USER
 S HDR(4)="Duplicate PATIENT RELATION file Entries"
 S HDR(5)="** Includes duplicates for both dependent and patient entries"
 F A=1,2 D  Q:$D(DIRUT)
 .S HDR(1)=$S(A=2:"DECEASED PATIENT, NO ACTION REQUIRED",1:"ACTIVE DUPLICATE ENTRIES")
 .F B=1,2 D  Q:$D(DIRUT)
 ..S HDR(2)=$S(B=2:"Non Category C",1:"Category C")
 ..F C=1,2 D  Q:$D(DIRUT)
 ...S HDR(3)=$S(C=2:"CMOR",1:"NON-CMOR")
 ...S PG=0
 ...D HDR,LOOP
 ...Q
 ..Q
 .Q
 D ^%ZISC
 Q
 ;
HDR ; Report Header
 N IX
 S PG=PG+1,HDR(6)="PAGE "_PG
 I '+$G(FSTP) W @IOF
 W !,DAL
 W !,RUN,!
 F IX=1,2,3,4 W !?((IOM-$L(HDR(IX)))\2),HDR(IX)
 W !
 W !,?((IOM-3)-$L(HDR(5)))\2,HDR(5),?((IOM-1)-$L(HDR(6))),HDR(6)
 W !,EQL
 W !,"* - Represents entries without an SSN in the INCOME PERSON file (#408.13)"
 W !,?4,"These entries must be corrected using the Edit an Existing Means Test",!,?4,"Option before merging or deleting."
 I HDR(1)["Deceased" W !!,"NOTE: Corrective action does not apply to deceased duplicates."
 W !!?(COL3),"408.12"
 W !,"SSN",?COL2,"NAME",?(COL3+2),"IEN",?COL4,"DOB",?COL5,"ACT",?COL6,"EFF DATE",?COL7,"TYPE"
 W !,$E(DAL,1,9),?COL2,$E(DAL,1,25),?COL3,$E(DAL,1,7),?COL4,$E(DAL,1,8),?COL5,$E(DAL,1,3),?COL6,$E(DAL,1,8),?COL7,$E(DAL,1,5)
 S FSTP=0
 Q
 ;
LOOP ; Loop thru data and provide output for report.
 N DATA,IEN,FILE,DNODE,PNAME,SEX,DOB,SSN,NODE2,EASACT,TTYPE,EDATE
 S DFN=0
 I '$O(@ROOT(A,B,C)@(DFN)) D  Q
 .W !!,"NO DUPLICATE ENTRIES FOUND"
 .I $E(IOST,1,2)="C-" D PAUSE^EASXDRUT Q:$D(DIRUT)
 .Q
 F  S DFN=$O(@ROOT(A,B,C)@(DFN)) Q:DFN'>0  D  Q:$D(DIRUT)
 .S EASREL=""
 .W !!,"VETERAN: "_$S($$GET1^DIQ(2,DFN_",",.01,"E")]"":$$GET1^DIQ(2,DFN_",",.01,"E"),1:"UNKNOWN")_" - "_$S($$GET1^DIQ(2,DFN_",",.09,"E")]"":$$GET1^DIQ(2,DFN_",",.09,"E"),1:"UNKNOWN SSN")
 .F  S EASREL=$O(@ROOT(A,B,C)@(DFN,EASREL)) Q:EASREL']""  D  Q:$D(DIRUT)
 ..S EASCNT=0
 ..F  S EASCNT=$O(@ROOT(A,B,C)@(DFN,EASREL,EASCNT)) Q:EASCNT'>0  D  Q:$D(DIRUT)
 ...S DATA=$G(@ROOT(A,B,C)@(DFN,EASREL,EASCNT))
 ...S IEN=$P(DATA,U)
 ...S FILE=$P($$GET1^DIQ(408.12,IEN_",",.03,"I"),";",2)_$P($$GET1^DIQ(408.12,IEN_",",.03,"I"),";")
 ...S DNODE=$G(@("^"_FILE_",0)"))
 ...S PNAME=$P(DNODE,U),PNAME=$E(PNAME,1,25)
 ...S SEX=$P(DNODE,U,2),DOB=$$FMTE^XLFDT($P(DNODE,U,3),"2P")
 ...S SSN=$P(DNODE,U,9)
 ...I SSN']"" S SSN=$$GET1^DIQ(2,DFN_",",.09,"E")_"*"
 ...S NODE2=$G(^DGPR(408.12,+$P(DATA,U),"E",+$P($P(DATA,U,3),"~",3),0))
 ...S EASACT=$P(DATA,U,3)
 ...S TTYPE=$P(EASACT,"~",3)
 ...S TTYPE=$S(TTYPE]"":$$GET1^DIQ(408.33,TTYPE_",",.01,"E"),1:"UNK")
 ...S TTYPE=$P(TTYPE," ",1)
 ...S EASACT=$P(EASACT,"~")
 ...S EDATE=$$FMTE^XLFDT($P($P(NODE2,U),"."),"2P")
 ...W !,SSN,?COL2,PNAME,?COL3,$J(IEN,7),?COL4,$J(DOB,8),?COL5,$J($S(EASACT=1:"YES",EASACT=0:"NO",1:EASACT),3),?COL6,$J(EDATE,8),?COL7,TTYPE
 ...I $Y'<(IOSL-3) D PAUSE^EASXDRUT Q:$D(DIRUT)  D HDR
 Q:$D(DIRUT)
 F IY=$Y:1:(IOSL-4) W !
 I $E(IOST,1,2)="C-" D
 .K DIR,DIRUT
 .S DIR(0)="E"
 .D ^DIR
 Q
 ;
