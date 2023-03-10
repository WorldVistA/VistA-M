SDTMPSTN ;TMP/DRF - TMP Missing Station Report;Mar 15, 2022
 ;;5.3;Scheduling;**812**;SEP 26, 2018;Build 17
 Q
 ;
BEGIN ;Report Begin & Title
 W #,"CLINICS THAT ARE MISSING STATION NUMBER",!!
 D ACT I Y="^" Q
 D ASKTYPE I Y="^" Q
 ;
IO ;Ask IO device and Queue
 S %ZIS="PQM" D ^%ZIS I POP D END Q
 I $D(IO("Q")) D QUE,END Q
 ;
LOOP ;Begin Report
 S FND=0,PGNO=0
 S CL=0 F  S CL=$O(^SC(CL)) Q:'CL  D
 . S I=$G(^SC(CL,"I"))
 . I $P(I,U,1)>0,+$P(I,U,2)=0,ACT="A" Q  ;Eliminate inactive clinics
 . I +$P(I,U,1)=0,ACT="I" Q  ;Eliminate active clinics
 . S CL0=$G(^SC(CL,0))
 . S PSTOP=$P(CL0,"^",7),SSTOP=$P(CL0,"^",18),CLTYP=$P(CL0,"^",3),NCNT=$P(CL0,"^",17)
 . I ASKTYPE'="A",CLTYP'=ASKTYPE Q  ;Not the requested clinic type
 . S STN=$$STATION^SDTMPHLA(CL)
 . I STN="" D LINE
 I 'FND W "NO CLINICS MISSING STATION NUMBER WERE FOUND",!
 D END
 Q
 ;
TYPE(CLTYP) ;Clinic Type
 I CLTYP="C" Q "CLINIC"
 I CLTYP="M" Q "MODULE"
 I CLTYP="W" Q "WARD"
 I CLTYP="Z" Q "OTHER LOCATION"
 I CLTYP="N" Q "NON-CLINIC STOP"
 I CLTYP="F" Q "FILE AREA"
 I CLTYP="I" Q "IMAGING"
 I CLTYP="OR" Q "OPERATING ROOM"
 Q ""
 ;
HEADER ;
 W #
 S PGNO=PGNO+1
 W ?2,"CLINICS THAT ARE MISSING STATION NUMBER",?71,"DATE: ",$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3),?122,"PAGE: ",PGNO,!
 W ?2,"CLINIC TYPE: ",$S(ASKTYPE="A":"ALL",1:$$TYPE(ASKTYPE)),!
 W ?2,$S(ACT="B":"BOTH ACTIVE AND INACTIVE CLINICS",ACT="I":"INACTIVE CLINICS",1:"ACTIVE CLINICS"),!
 W ?2,"CLINIC",?10,"CLINIC NAME",?42,"ABR",?54,"TYPE",?71,"INST",?79,"DIV",?96,"PRI SC",?103,"SEC SC",?111,"NCNT",?116,"STATION",!
 W ?2,"-------",?10,"-------------------------------",?42,"-----------",?54,"----------------",?71,"-------",?79,"----------------",?96,"------",?103,"------",?111,"----",?116,"-------",!
 Q
 ;
LINE ;Write a single clinic record
 S FND=FND+1
 I FND#60=1 D HEADER
 N CLNM,CLABR,CLTYP,CLINS,CLDIV
 S CLNM=$P(CL0,U,1),CLABR=$P(CL0,U,2),CLTYP=$P(CL0,U,3),CLINS=$P(CL0,U,4),CLDIV=$P(CL0,U,15)
 I CLTYP]"" S CLTYP=$$TYPE(CLTYP)
 S DIV="" I CLDIV S DIV=$$GET1^DIQ(40.8,CLDIV_",",.01,"I")
 W ?2,CL,?10,CLNM,?42,CLABR,?54,CLTYP,?71,CLINS,?79,DIV,?96,PSTOP,?103,SSTOP,?111,NCNT,?116,STN,!
 Q
 ;
QUE ;Run job in background
 S ZTRTN="LOOP^SDTMPSTN",ZTDESC="TMP CLINICS THAT ARE MISSING STATION NUMBER"
 D ^%ZTLOAD W:$D(ZTSK) !,"Task #",ZTSK," Started."
 D HOME^%ZIS K IO("Q"),ZTSK,ZTDESC,ZTQUEUED,ZTRTN
 D END
 Q
 ;
END ;Clean up and Quit
 D:'$D(ZTQUEUED) ^%ZISC
 K ACT,ASKTYPE,DIR,DIV,CL,CL0,FND,I,NCNT,PGNO,PSTOP,SSTOP,STN,STOP1,STOP2,CLABR,CLDIV,CLINS,CLNM,CLTYP,POP,Y,ZTDESC,ZTQUEUE,ZTRTN,ZTSK
 Q
 ;
ACT ;View active, inactive or both clinics
 S DIR(0)="SA^A:ACTIVE;I:INACTIVE;B:BOTH^",DIR("B")="B"
 S DIR("A")="List which clinics - (A)ctive, (I)nactive or (B)oth ? "
 D ^DIR
 S ACT=Y
 Q
 ;
ASKTYPE ;Ask clinic type
 S DIR(0)="SA^C:CLINIC;M:MODULE;W:WARD;Z:OTHER LOCATION;N:NON-CLINIC STOP;F:FILE AREA;I:IMAGING;R:OPERATING ROOM;A:ALL^",DIR("B")="C"
 S DIR("A")="List which clinic types - (C)linic, (M)odule, (W)ard, (Z)Other Location, (N)on-Clinic Stop, (F)ile Area, (I)maging, Operating (R)oom or (A)ll ? "
 D ^DIR
 I Y="R" S Y="OR"
 S ASKTYPE=Y
 Q
