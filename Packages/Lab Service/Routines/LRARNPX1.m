LRARNPX1 ;SLC/MRH/FHS/JB0 - NEW PERSON CONVERSION FOR ^LAR("Z" ; 1/23/93
 ;;5.2;LAB SERVICE;**59,150**;Sep 27, 1994
 ;
 Q
PROV(LRFLD,X1,LRSB) ;
 ;  X1 = Pointer value of data that pointed to FILE 16
 ;  LRFLD = field number or if in a subfile subfile number,field number
 ;  quits with the new value pointer from file 200 or logs an exception
 ;  in ^XTMP("LR52","global root",LRJOB #,subscript 1,LRZD0,field number)
 ;  =error and quits with the old value concantenated with "ERR"
 ;  LRSB is an array that carries all subscripts from the file in
 ;  which the conversion is being done.
 N X,Y,LRNAM
 S X=$G(X1)
 S LRNAM=$P($G(^VA(200,$O(^VA(200,"A16",X,0)),0)),U)
 I '$L(LRNAM) S LRNAM="Non-existant" D POINT(LRFLD,X,LRNAM,.LRSB) G NOP
 S Y=$O(^VA(200,"A16",X,0)) I 'Y D POINT(LRFLD,X,LRNAM,.LRSB) G NOP
 Q Y
NOP ;
 Q "ERR"_X1
 ;
POINT(LRFLD,Y,LRNAM,LRSB) ;
 ; LRFLD - documented at line tag PROV
 ; Y = value from data the should be entry in ^VA(200,Y))
 ; LRNAM is the externalization of the person/provider pointer from 16
 ; LRSB is an array with subscript identifiers LRSB(0) first level
 ;      LRSB(1) second level ....
 ;
 I '$G(LRZD1) S ^XTMP("LR52",LRFILE,LRJOB,LRZD0,LRSB(0),LRFLD)=Y_U_LRNAM D EXCEPT^LRARNPX0(LRFILE,LRZD0) Q
 I '$G(LRZD2) S ^XTMP("LR52",LRFILE,LRJOB,LRZD0,LRSB(0),LRZD1,LRFLD)=Y_U_LRNAM D EXCEPT^LRARNPX0(LRFILE,LRZD0) Q
 S ^XTMP("LR52",LRFILE,LRJOB,LRZD0,LRSB(0),LRZD1,LRSB(1),LRZD2,LRFLD)=Y_U_LRNAM D EXCEPT^LRARNPX0(LRFILE,LRZD0)
 Q
 ;
OUT ;
 I $D(LRIO) D REQUE Q
 ;
REENT ; re-entry for reque if LRIO is busy from above
 ;
 D HEAD^LRARNPX0(LRFILE)
 I '$O(^XTMP("LR52",LRFILE,LRJOB,0)) W !!?(IOM-$L("****  none found ****"))\2,"**** NONE FOUND ****"
 F LRD0=0:0 S LRD0=$O(^XTMP("LR52",LRFILE,LRJOB,LRD0)) Q:LRD0'>0  S LRD0(0)=$G(^LR(LRD0,0)) F LRSB=".2","AU","BB","CH","CY","EM","MI","SP" D 1
 W @IOF D ^%ZISC
 K LRAC,LRD0,LRD1,LRFILE,LRFLD,LRJOB,LRSB,LRSF,LRST,LRTI,LRTIT,LRVL
 K LRIO,LRNAM,LRZD0,LRZD1,LRZD2,X,X1,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 Q
1 ;
 I LRSB=.2 D 11 Q
WRITE ;
 Q:'$D(^XTMP("LR52",LRFILE,LRJOB,LRD0,LRSB))
 S LRD1=$O(^XTMP("LR52",LRFILE,LRJOB,LRD0,LRSB,0))
 S LRFLD=$O(^XTMP("LR52",LRFILE,LRJOB,LRD0,LRSB,LRD1,0)) Q:LRFLD=""
 S LRVL=$G(^XTMP("LR52",LRFILE,LRJOB,LRD0,LRSB,LRD1,LRFLD))
 I LRFLD["," S LRTIT=$P($G(@("^DD("_LRFLD_",0)")),U)
 I LRFLD'["," S LRTIT=$P($G(@("^DD("_$P(LRFILE,"-",2)_","_LRFLD_",0)")),U)
 S LRD0(0)=$G(^LR(LRD0,0))
 I LRSB="AU" S LRD1(0)=$G(^LR(LRD0,"AU")),LRSF="AUTOPSY" D WRIT1 Q
 I LRSB="BB" S LRD1(0)=$G(^LR(LRD0,"BB",LRD1,0)),LRSF="BLOOD BANK" D WRIT1 Q
 I LRSB="CH" S LRD1(0)=$G(^LR(LRD0,"CH",LRD1,0)),LRSF="CHEM, HEM, TOX, RIA, SER, etc." D WRIT1 Q
 I LRSB="CY" S LRD1(0)=$G(^LR(LRD0,"CY",LRD1,0)),LRSF="CYTOPATHOLOGY" D WRIT1 Q
 I LRSB="EM" S LRD1(0)=$G(^LR(LRD0,"EM",LRD1,0)),LRSF="EM" D WRIT1 Q
 I LRSB="MI" S LRD1(0)=$G(^LR(LRD0,"MI",LRD1,0)),LRSF="MICROBIOLOGY" D WRIT1 Q
 I LRSB="SP" S LRD1(0)=$G(^LR(LRD0,"SP",LRD1,0)),LRSF="SURGICAL PATHOLOGY" D WRIT1 Q
 Q
 ;
11 ;
 Q:'$D(^XTMP("LR52",LRFILE,LRJOB,LRD0,LRSB))
 S LRFLD=$O(^XTMP("LR52",LRFILE,LRJOB,LRD0,LRSB,0)),LRVL=$G(^(LRFLD))
 I LRFLD["," S LRTIT=$P($G(@("^DD("_LRFLD_",0)")),U)
 I LRFLD'["," S LRTIT=$P($G(@("^DD("_$P(LRFILE,"-",2)_","_LRFLD_",0)")),U)
 I ($Y+10)>IOSL D HEAD^LRARNPX0(LRFILE)
 W !!!,"The value ("_+LRVL_") """_$P(LRVL,U,2)_""",",!,"in field "_LRTIT_", could not be repointed.",!,"This occured in: ",LRD0
 Q
WRIT1 ;
 I ($Y+10)>IOSL D HEAD^LRARNPX0(LRFILE)
 W !!!,"The value ("_+LRVL_") """_$P(LRVL,U,2)_""",",!,"in field "_LRTIT_", could not be repointed.",!,"This occured in: ",LRD0,!,"The "_LRSF_": subfile of """,LRSB,"""",?54,"entry: "_LRD1
 Q
 ;
REQUE ; reque task to print out exceptions
 N I
 S ZTIO=LRIO,ZTDESC="Requeue of exception report FILE 63 conversion JOB "_LRJOB,ZTDTH=$H,ZTRTN="REENT^LRARNPX1"
 F I="LRFILE","LRJOB","LRST","LRAC","LRTSK" S ZTSAVE(I)=""
 D ^%ZTLOAD Q
