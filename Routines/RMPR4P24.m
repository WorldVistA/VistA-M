RMPR4P24 ;PHX/HPL-Print patient PC notification letter ;10/31/1994
 ;;3.0;PROSTHETICS;**3,20,55**;Feb 09, 1996
 ;
 ; ODJ - patch 55 - 1/29/01 - replace hard coded mail route code 121
 ;                            with call to extrinsic for site param.
 ;                            see nois AUG-1097-32118
 ;
EN(RDA) ;SETUP VARIABLES AND PRINT PATIENT NOTIFICATION LETTER
 ;VARIABLE REQUIRED:RDA - ENTRY # IN FILE 664
 N VAHOW
 S NAME=$P(^RMPR(664,RDA,0),U,9),RMPRINIT=NAME,RMPREMP=$$SIG^RMPR31U(NAME)
 I $D(^VA(200,RMPRINIT,.13)) S RMPRPHON=$P(^VA(200,RMPRINIT,.13),U,2)
 I '$D(^VA(200,$P(^RMPR(664,RDA,0),U,9),.13)) S RMPRPHON=RMPR("PHONE")
 S DFN=$P(^RMPR(664,RDA,0),U,2) D ADD^VADPT,DEM^VADPT
 S RMPRITEM=""
 S RMPRITM=0 F LP=1:1 S RMPRITM=$O(^RMPR(664,RDA,1,RMPRITM)) Q:RMPRITM="B"  S RMPRITEM(LP)=$P(^RMPR(664,RDA,1,RMPRITM,0),U,2),RMPRITM(LP)=$P(^RMPR(664,RDA,1,RMPRITM,0),U,1)
 S HEADING="Department of Veterans Affairs"
 W !!!!!,?IOM-$L(HEADING)\2,HEADING
 S RMPRTAB=IOM-$L(RMPR("NAME"))\2 W !,?RMPRTAB,RMPR("NAME")
 S RMPRTAB=IOM-$L(RMPR("ADD"))\2 W !,?RMPRTAB,RMPR("ADD")
 S RMPRTAB=IOM-$L(RMPR("CITY"))\2 W !,?RMPRTAB,RMPR("CITY")
 S RMPRTAB=7 S NAME=VADM(1) S FIXDNAME=$$PARS^RMPRUTL1(NAME)
 W !!,?44,$$FMTE^XLFDT(DT,"D")
 S FIXDNAME=$E(FIXDNAME,2,$L(FIXDNAME)-2)
 W !!,?RMPRTAB,$S($P(VADM(5),U,1)["M":"MR. ",$P(VADM(5),U,1)["F":"MS. ",1:"")_$$UP^XLFSTR(FIXDNAME)
 W ?44,"In reply refer to: ",$P(^DIC(4,RMPR("STA"),99),U,1)_"/"_$$ROU^RMPRUTIL(RMPRSITE),!
 ;display purchase card transaction
 W:VAPA(1)'="" ?RMPRTAB,VAPA(1)
 W:VAPA(2)'="" ?RMPRTAB,VAPA(2)
 W ?44,"Accounting Symbol ",$P(^RMPR(664,RDA,4),U,5),!
 W:VAPA(3)'="" ?RMPRTAB,VAPA(3)
 W:VAPA(4)'="" ?RMPRTAB,VAPA(4)_", "_$P(VAPA(5),"^",2)_"  "_VAPA(6)
 W ?44,"Veteran: ",VADM(1),!
 W ?44,"SSN: ",$P(VADM(2),U,2)
 W !!,?RMPRTAB,"Dear ",$S($P(VADM(5),"^",1)["M":"Mr. ",$P(VADM(5),"^",1)["F":"Ms. ",1:"")_FIXDNAME_","
 W !!,?RMPRTAB+0
 W "This is to notify you that the items listed below were ordered"
 W !,?RMPRTAB,"for you on "
 W $$FMTE^XLFDT($P(^RMPR(664,RDA,0),U,1),"D")_".  Delivery of this equipment is expected"
 W !,?RMPRTAB,$S($P($G(^RMPR(664,RDA,3)),U,2)'="":"on or about "_$$FMTE^XLFDT($P(^RMPR(664,RDA,3),U,2),"D")_".",1:"in 30 days from the order date.")
 W !!,?RMPRTAB,"If you do not receive it within 5 days of the expected date,"
 S LINE="please contact "_RMPREMP_", of my staff, at "_RMPRPHON_"."
 W $$RAP^RMPRUTL1(LINE,RMPRTAB)
ITEMS NEW DA
 W !
 S RMPRLAST=$P(^RMPR(664,RDA,1,0),U,4) F LP=1:1:RMPRLAST D
 .I $D(RMPRITEM(LP)) W !,?RMPRTAB+3,RMPRITEM(LP)
 .E  S RMPRITM=RMPRITM(LP) W !,?RMPRTAB+3,$$ITM^RMPR31U(RMPRITM)
 W !!,?RMPRTAB,"Sincerely,"
 W !!!!!,?RMPRTAB,RMPR("SIG")
 W !,?RMPRTAB,RMPR("SBT")
 W @IOF
 K RMPREMP,RMPRNAME,LINE Q " "
