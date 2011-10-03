GMTSDEMB ; SLC/DLT,KER - Brief Demographic Component  ; 12/11/2002
 ;;2.7;Health Summary;**29,49,55,56,60**;Oct 20, 1995
 ;                    
 ; External References
 ;   DBIA  2056  $$GET1^DIQ (file #4)
 ;   DBIA 10061  ADD^VADPT
 ;   DBIA 10061  DEM^VADPT
 ;   DBIA 10061  ELIG^VADPT
 ;   DBIA  2990  TFL^VAFCTFU1
 ;   DBIA 10103  $$FMTE^XLFDT
 ;   DBIA  2171  $$LKUP^XUAF4
 ;                  
DEMOG ; Brief Demographics (VADPT)
 N I,IX,VA,VAEL,VADM,VAPA,GMTSS,GMTSOUT,GMTSR D ELIG^VADPT,ADD^VADPT,DEM^VADPT
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ?12,"Address: "_$S($L(VAPA(1)):VAPA(1),1:"Not available"),?53," Phone:",?61,VAPA(8),!
 I VAPA(2)'="" D CKP^GMTSUP Q:$D(GMTSQIT)  W ?21,VAPA(2),!
 I VAPA(3)'="" D CKP^GMTSUP Q:$D(GMTSQIT)  W ?21,VAPA(3),!
 I VAPA(4)'="" D CKP^GMTSUP Q:$D(GMTSQIT)  W ?21,VAPA(4),", ",$P(VAPA(5),"^",2),"  ",VAPA(6),!
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ?8,"Eligibility: ",?21,$P(VAEL(1),"^",2)
 I VADM(4)'="" D CKP^GMTSUP Q:$D(GMTSIT)  W ?56,"Age: ",$P(VADM(4),"^",1),!
 I VAEL(9)'="" D CKP^GMTSUP Q:$D(GMTSQIT)  W ?9,"Means Test: ",$P(VAEL(9),"^",2)
 I VADM(5)'="" D CKP^GMTSUP Q:$D(GMTSQIT)  W ?56,"Sex: ",$P(VADM(5),"^",2),!
 D RACE^GMTSDEM2
 D CD^GMTSDEMP(DFN) Q:$D(GMTSQIT)  D TF(DFN) Q:$D(GMTSQIT)  D SRC
 K I,IX,VA,VAEL,VAPA
 Q
TF(X) ; Treating Facilities
 Q:$D(GMTSQIT)  N DFN,GMTSC,GMTSDS,GMTSI,GMTSIEN,GMTSIT,GMTSS
 N GMTSTA,GMTSTF,GMTSTF2,GMTSTFC,GMTSTY,GMTSTFT
 S GMTSTFC=0,DFN=+($G(X)),U="^" D TFL^VAFCTFU1(.GMTSTF,+($G(DFN)))
 S (GMTSLP,GMTSC,GMTSI,GMTSS)=0
 F  S GMTSI=$O(GMTSTF(GMTSI)) Q:+GMTSI=0  D
 . S GMTSTFT=$G(GMTSTF(GMTSI))
 . S:+($G(GMTSTF(GMTSI)))=776!(+($G(GMTSTF(GMTSI)))=200) $P(GMTSTFT,"^",2)="DEPT. OF DEFENSE"
 . S GMTSTF2((99999999-(+($P($P($G(GMTSTF(GMTSI)),"^",3),".",1)))),+($$LKUP^XUAF4($P($G(GMTSTF(GMTSI)),"^",2))))=GMTSTFT
 S (GMTSC,GMTSI)=0 F  S GMTSI=$O(GMTSTF2(GMTSI)) Q:+GMTSI=0  D  Q:$D(GMTSQIT)
 . S GMTSIEN="" F  S GMTSIEN=$O(GMTSTF2(GMTSI,GMTSIEN)) Q:GMTSIEN=""  D  Q:$D(GMTSQIT)
 . . S GMTSTA=$P($G(GMTSTF2(GMTSI,GMTSIEN)),"^",1)
 . . S GMTSIT=$P($G(GMTSTF2(GMTSI,GMTSIEN)),"^",2) Q:'$L(GMTSIT)
 . . Q:GMTSIT="NO ICN"
 . . S GMTSDS=$P($P($G(GMTSTF2(GMTSI,GMTSIEN)),"^",3),".",1)
 . . S:+GMTSDS>0 GMTSLP=1 S:+GMTSDS'>0 GMTSDS="",GMTSLP=0 Q:+GMTSLP=0
 . . S:+GMTSDS>0 GMTSDS=$TR($$FMTE^XLFDT(GMTSDS,"5DZ"),"@"," ")
 . . S:GMTSDS="" GMTSDS="--/--/----" S:+GMTSLP>0 GMTSC=GMTSC+1
 . . I GMTSC=1 D  Q:$D(GMTSQIT)
 . . . N STR
 . . . D WRT^GMTSDEM("",,,,0) Q:$D(GMTSQIT)
 . . . S STR="  Treating Facility                 Type         Station     Last Seen"
 . . . D WRT^GMTSDEM(STR,,,,0) Q:$D(GMTSQIT)
 . . . S STR="  ----------------------------      -----------  -------     ----------"
 . . . D WRT^GMTSDEM(STR,,,,0) Q:$D(GMTSQIT)
 . . Q:$D(GMTSQIT)
 . . S GMTSTY=$$GET1^DIQ(4,(+GMTSIEN_","),13,"E")
 . . S:+GMTSTA<0 (GMTSTA,GMTSDS)=""
 . . S:GMTSIT="NO ICN" GMTSIT="Not available"
 . . S STR="  "_$G(GMTSIT)
 . . S STR=STR_$J("",(36-$L(STR)))_$G(GMTSTY)
 . . S STR=STR_$J("",(49-$L(STR)))_$J($G(GMTSTA),6)
 . . S STR=STR_$J("",(61-$L(STR)))_$G(GMTSDS)
 . . D WRT^GMTSDEM(STR,,,,0)
 . . S GMTSTFC=GMTSTFC+1
 Q
SRC ; Source of Info
 Q:$D(GMTSQIT)  N GMTSS,GMTSR,GMTSN,GMTST S GMTSR=0
 ;   National Health Summary Type
 S GMTSN=$S(+($G(^GMT(142,+($G(GMTSTYP)),"VA")))>0:1,1:0)
 ;   Health Summary Type Name
 S GMTST=$P($G(^GMT(142,+($G(GMTSTYP)),0)),"^",1)
 ;   Remote Data View HS Type
 S:GMTSN>0&(GMTST["REMOTE") GMTSR=1
 ;   Demographics Array
 S:$D(GMTSDEMX) GMTSR=1
 S GMTSS=$$SITE^GMTSU2 I GMTSR>0,$L(GMTSS) D  Q:$D(GMTSQIT)
 . D WRT^GMTSDEM("",,,,0) N STR
 . S STR="  Source of Info: "_GMTSS D WRT^GMTSDEM(STR,,,,0)
 Q
