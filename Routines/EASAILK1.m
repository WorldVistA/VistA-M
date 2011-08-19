EASAILK1 ;ALB/BRM,ERC - Patient Address Inquiry ; 10/2/07 3:27pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**13,29,39,70**;Mar 15, 2001;Build 26
 ;
PATADDR ;view patient address
 ;
 N PATNAM,IENS,ZTSAVE
 N DTOUT,DUOUT,DIRUT,DIROUT,%ZIS,DIC,DA,DIQ,DLAYGO,Y,X
 ;
 ; prompt user for patient name and device
 S DIC="^DPT(",DIC(0)="AEMQ" D ^DIC
 Q:($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)!(Y=-1))
 S %ZIS="Q"
 S IENS=+Y_",",PATNAM=$P(Y,"^",2)
 S ZTSAVE("IENS")="",ZTSAVE("PATNAM")=""
 D EN^XUTMDEVQ("QUE^EASAILK1","PATIENT ADDRESS INQUIRY",.ZTSAVE,.%ZIS)
 Q
QUE ;
 N DGC,CONOK,PATOK,TMPOK,FLD,CONARR,TMPARR,PATARR,CONERR,TMPERR,PATERR
 N CONSTR,TMPSTR,PATSTR,TYPE,CONFARR,TEMPARR
 ;
PAT ;patient address
 N PATOK
 D GETS^DIQ(2,IENS,".111:.121","E","PATARR","PATERR")
 W !?12,"Patient Name: ",?26,PATNAM
 ;
 ; exit if error occurs during DIQ call
 I $D(PATERR) W !!?11,"There is invalid data in the Permanent Address",!?11,"Please use Registration options to edit",!! G CON
 ;
 ; exit if there is no address for patient
 S FLD="",PATOK=0
 D OK(.PATARR,.PATOK)
 I 'PATOK W !!?11,"*** No Permanent Address On File For This Patient ***",!! G CON
 ;set a string of the field numbers needed for the patient address
 S PATSTR=".111^.112^.113^.114^.115^.1112^.1173^.121^.118^.119^.12^^^.1171^.1172"
 N STRARR
 D STRG(PATSTR,.STRARR) ;place the fld numbers into an array
 S TYPE="Patient"
 S DGC=1
 ;display the patient address information
 D DISP(TYPE,.PATARR,.STRARR)
 ;
CON ;confidential address
 N CONARR,CONERR,CONOK,DGJ
 S CONOK=0
 D GETS^DIQ(2,IENS,".141*;.14105;.1411:.142","IE","CONARR","CONERR")
 I $D(CONERR) S CONOK=-1 G TMP
 S FLD=""
 D OK(.CONARR,.CONOK) ;checking for presence of confid address array
 I $G(CONARR(2,IENS,.14105,"E"))'="YES" S CONOK=0 G TMP
 ;treat null end date as if in the future
 I DT'<$G(CONARR(2,IENS,.1417,"I")),$G(CONARR(2,IENS,.1418,"I"))']"" G CON2
 I DT>$G(CONARR(2,IENS,.1418,"I")) S CONOK=0 G TMP ;if date range in the past, don't display
 I DT<$G(CONARR(2,IENS,.1417,"I")) S CONOK=0 G TMP ;if date range in the future, dont display
CON2 ;
 S DGJ=""
 S CONOK=0 ;now check for active E/E confid address
 F  S DGJ=$O(CONARR(2.141,DGJ)) Q:DGJ']""  D
 . I CONARR(2.141,DGJ,.01,"E")["ELIG" D
 . . I CONARR(2.141,DGJ,1,"E")="YES" S CONOK=1
 I 'CONOK G TMP
 ;set string of the field numbers needed for the confidential address
 S CONSTR=".1411^.1412^.1413^.1414^.1415^.1416^.14116^^.14112^^.14113^.1417^.1418^.14114^.14115"
 N CONFARR
 D STRG(.CONSTR,.CONFARR) ;place field numbers into an array
 ;
TMP ;temporary address
 N TMPARR,TMPERR,TMPOK
 S TMPOK=0
 D GETS^DIQ(2,IENS,".12105;.1211:.1219;.1221:.1223","IE","TMPARR","TMPERR")
 I $D(TMPERR) S TMPOK=-1 G OPT
 S FLD=""
 D OK(.TMPARR,.TMPOK) ;check for presence of temp address array
 I 'TMPOK G OPT
 I $G(TMPARR(2,IENS,.12105,"E"))'="YES" S TMPOK=0 G OPT
 ;treat null end date as if in the future
 I DT'<$G(TMPARR(2,IENS,.1217,"I")),($G(TMPARR(2,IENS,.1218,"I")))']"" G TMP2
 I DT>$G(TMPARR(2,IENS,.1218,"I")) S TMPOK=0 ;if date range in the past, don't display
TMP2 ;
 I 'TMPOK G OPT
 N TEMPARR
 ;set string of the field numbers needed for the temporary address
 S TMPSTR=".1211^.1212^.1213^.1214^.1215^.12112^.1223^^.12113^^.12114^.1217^.1218^.1221^.1222"
 D STRG(.TMPSTR,.TEMPARR) ;place field numbers into an array
 ;
OPT ;let user decide to see confid. a/o temp address if disp. on screen
 N DGELIG,DGEND,DGOPT,DGPROMPT,DIR
 S DGEND=0
 S DGOPT=$S(CONOK=1&(TMPOK=1):3,CONOK=1&(TMPOK=0):2,TMPOK=1&(CONOK=0):1,1:"")
 I DGOPT']"" S DGOPT=$S(CONOK=-1&(TMPOK=-1):4,CONOK=-1:5,TMPOK=-1:6,1:"")
 I $G(DGOPT)="" W !?5,PATNAM_" has no Temporary or Eligibility/Enrollment",!?5,"Confidential Address." W !! G END
 I $G(DGOPT)>3 D
 . W !?11,"There is invalid data in the "_$S(DGOPT=4:"Temporary and Confidential ",DGOPT=5:"Confidential ",1:"Temporary ")_"address"_$S(DGOPT=4:"es.",1:".")
 . W !?11,"Please use Registration options to edit.",!!
 I $E(IOST,1,2)["C-" D
 . S DIR(0)="YAO",DIR("B")="Yes"
 . S DGELIG="Elig/Enroll Confidential"
 . S DGPROMPT=$S(DGOPT=3:DGELIG_" and Temp",DGOPT=2!(CONOK=1):DGELIG,DGOPT=1!(TMPOK=1):"Temporary",1:"")
 . I $G(DGPROMPT)="" S DGEND=1 Q
 . S DIR("A")="  Would you like to see the "_DGPROMPT_" Address"_$S(DGOPT=3:"es",1:"")_"? "
 . D ^DIR K DIR
 . I Y'=1 S DGEND=1
 I DGEND=1 G END
 S DGC=2
 ;
 ;if displayed on screen offer to show temp and confid addresses and
 ;do a page break for readability.
 I DGC>1 D
 . I $E(IOST,1,2)["C-" W @IOF
 . W !!?12,"Patient Name: ",?26,PATNAM
 ;display the addresses that are populated
 I CONOK=1 S TYPE=" Confid" D DISP(TYPE,.CONARR,.CONFARR)
 I TMPOK=1 S TYPE="   Temp" D DISP(TYPE,.TMPARR,.TEMPARR)
 I 'CONOK W !?8,"Patient "_PATNAM_" has no Eligibility/Enrollment",!?8,"Confidential Address."
 I 'TMPOK W !?8,"Patient "_PATNAM_" has no Temporary Address."
 W !
 G END
 ;
OK(ARR,OK) ;check for presence of an array
 F  S FLD=$O(ARR(2,IENS,FLD)) Q:'FLD!(OK)  S:$G(ARR(2,IENS,FLD,"E"))]"" OK=1
 Q
 ;
STRG(STR,STRARR) ;set the field string into an array
 N DGD
 F DGD=1:1:15  S STRARR(DGD)=$P(STR,U,DGD)
 Q
 ;
 ;display address information
DISP(TYPE,ARR,STR) ;
 N DGCNTRY,DGUSA
 S DGUSA=0 ;I country=USA or "" display state/zip, E prov/postal code
 S:$G(ARR(2,IENS,$G(STR(7)),"E"))="USA" DGUSA=1
 S:$G(ARR(2,IENS,$G(STR(7)),"E"))']"" DGUSA=1
 W !?9,TYPE_" Address: ",?26,$S($G(ARR(2,IENS,$G(STR(1)),"E"))]"":ARR(2,IENS,STR(1),"E"),1:"UNKNOWN STREET ADDRESS")
 W:$G(ARR(2,IENS,$G(STR(2)),"E"))]"" !?26,ARR(2,IENS,STR(2),"E")
 W:$G(ARR(2,IENS,STR(3),"E"))]"" !?26,ARR(2,IENS,STR(3),"E")
 I DGUSA D  ;US address or null country which defaults to US
 . W !?26,$S($G(ARR(2,IENS,STR(4),"E"))]"":ARR(2,IENS,STR(4),"E"),1:"UNKNOWN CITY")_", "
 . W $S($G(ARR(2,IENS,STR(5),"E"))]"":ARR(2,IENS,STR(5),"E"),1:"UNKNOWN STATE")_" "
 . W:$G(ARR(2,IENS,STR(6),"E"))]"" ARR(2,IENS,STR(6),"E")
 I 'DGUSA D  ;foreign address
 . W !?26,""
 . W:$G(ARR(2,IENS,STR(15),"E"))]"" ARR(2,IENS,STR(15),"E")_" "
 . W $S($G(ARR(2,IENS,STR(4),"E"))]"":ARR(2,IENS,STR(4),"E"),1:"UNKNOWN CITY")_", "
 . W $S($G(ARR(2,IENS,STR(14),"E"))]"":ARR(2,IENS,STR(14),"E"),1:"UNKNOWN PROVINCE")_" "
 I $G(ARR(2,IENS,STR(7),"E"))]"" D
 . S DGCNTRY=ARR(2,IENS,STR(7),"E")
 . S DGCNTRY=$$COUNTRY^DGADDUTL(.DGCNTRY)
 . W !?26,DGCNTRY
 I TYPE["Patient" W !?3,"Bad Address Indicator: ",?26,$G(ARR(2,IENS,STR(8),"E"))
 W !?1,TYPE_" Add Change Date: ",?26,$G(ARR(2,IENS,STR(9),"E"))
 I TYPE["Patient" W !?3,"Pat Add Change Source: ",?26,$G(ARR(2,IENS,STR(10),"E"))
 I TYPE["Patient" W:$G(ARR(2,IENS,STR(10),"E"))="VAMC" !?1,TYPE_" Add Change Site: ",?26,$G(ARR(2,IENS,STR(11),"E"))
 I TYPE'["Patient" W:$G(ARR(2,IENS,STR(11),"E"))]"" !?1,TYPE_" Add Change Site: ",?26,$G(ARR(2,IENS,STR(11),"E"))
 I TYPE'["Patient" W !?2,TYPE_" Add Start Date: ",?26,$G(ARR(2,IENS,STR(12),"E"))
 I TYPE'["Patient" W !?4,TYPE_" Add End Date: ",?26,$G(ARR(2,IENS,STR(13),"E"))
 W !
 Q
 ;
END ; common exit point - reset device and prompt user for another name
 K %ZIS D ^%ZISC,HOME^%ZIS
 G PATADDR
 Q
