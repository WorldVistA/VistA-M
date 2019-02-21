EASAILK1 ;ALB/BRM,ERC,JAM - Patient Address Inquiry ;18 Jul 2017  4:03 PM
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**13,29,39,70,151**;Mar 15, 2001;Build 70
 ;
 ;*151*; JAM - Add Residential Address and modify Permanent, Confidential, and Temporary address field labels and reformat the output
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
 W !?23,"Patient Name: ",?37,PATNAM
 ; exit if error occurs during DIQ call
 ; EAS*1.0*151; JAM; Change label to Permanent Mailing Address 
 I $D(PATERR) W !!?11,"There is invalid data in the Permanent Mailing Address",!?11,"Please use Registration options to edit",!! G CON
 ;
 ; exit if there is no address for patient
 S FLD="",PATOK=0
 D OK(.PATARR,.PATOK)
 ; EAS*1.0*151; JAM; Change label to Permanent Mailing Address 
 I 'PATOK W !!?11,"*** No Permanent Mailing Address On File For This Patient ***",!! G CON
 ;set a string of the field numbers needed for the patient address
 S PATSTR=".111^.112^.113^.114^.115^.1112^.1173^.121^.118^.119^.12^^^.1171^.1172"
 N STRARR
 D STRG(PATSTR,.STRARR) ;place the fld numbers into an array
 ; EAS*1.0*151; JAM; Change TYPE to "Permanent Mailing" (from "Patient")  
 S TYPE="Permanent Mailing"
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
 ; EAS*1.0*151; JAM; Add Residential Address
 I $D(TMPERR) S TMPOK=-1 G RES
 S FLD=""
 D OK(.TMPARR,.TMPOK) ;check for presence of temp address array
 I 'TMPOK G RES
 I $G(TMPARR(2,IENS,.12105,"E"))'="YES" S TMPOK=0 G RES
 ;treat null end date as if in the future
 I DT'<$G(TMPARR(2,IENS,.1217,"I")),($G(TMPARR(2,IENS,.1218,"I")))']"" G TMP2
 I DT>$G(TMPARR(2,IENS,.1218,"I")) S TMPOK=0 ;if date range in the past, don't display
TMP2 ;
 ; EAS*1.0*151; JAM; Add Residential Address
 I 'TMPOK G RES
 N TEMPARR
 ;set string of the field numbers needed for the temporary address
 S TMPSTR=".1211^.1212^.1213^.1214^.1215^.12112^.1223^^.12113^^.12114^.1217^.1218^.1221^.1222"
 D STRG(.TMPSTR,.TEMPARR) ;place field numbers into an array
 ;
 ; EAS*1.0*151; JAM; Add Residential Address 
RES ;gather residential address
 N RESARR,RESERR,RESOK,RESSTR
 S RESOK=0
 D GETS^DIQ(2,IENS,".1151:.11582","IE","RESARR","RESERR")
 ;D GETS^DIQ(2,IENS,".115*;.14105;.1411:.142","IE","CONARR","CONERR")
 I $D(RESERR) S RESOK=-1 G OPT
 S FLD=""
 D OK(.RESARR,.RESOK) ;checking for presence of residential address array
 ;treat null end date as if in the future
 I DT'<$G(RESARR(2,IENS,.1161,"I")),$G(RESARR(2,IENS,.1162,"I"))']"" G RES2
 I DT>$G(RESARR(2,IENS,.1162,"I")) S RESOK=0 G OPT ;if date range in the past, don't display
 I DT<$G(RESARR(2,IENS,.1161,"I")) S RESOK=0 G OPT ;if date range in the future, dont display
RES2 ;
 I 'RESOK G OPT
 ;set string of the field numbers needed for the residential address
 S RESSTR=".1151^.1152^.1153^.1154^.1155^.1156^.11573^^.1158^.11582^.11581^.1161^.1162^.11571^.11572"
 N RESIDARR
 D STRG(.RESSTR,.RESIDARR) ;place field numbers into an array
 ;
OPT ;let user decide to see confid. a/o temp address, residential address if disp. on screen
 N DGELIG,DGEND,DGOPT,DGPROMPT,DIR,DGRET
 S DGEND=0
 ; EAS*1.0*151; JAM; Add Residential Address to address choices
 I RESOK'=1 D
 .S DGOPT=$S(CONOK=1&(TMPOK=1):3,CONOK=1&(TMPOK=0):2,TMPOK=1&(CONOK=0):1,1:"")
 E  D
 .S DGOPT=$S(CONOK=1&(TMPOK=1):4,CONOK=1&(TMPOK=0):5,TMPOK=1&(CONOK=0):6,1:7)
 I DGOPT']"" S DGOPT=$S(CONOK=-1&(TMPOK=-1):8,CONOK=-1:9,TMPOK=-1:10,1:"")
 ; EAS*1.0*151; JAM; Change label to Confidential and add Residential Address 
 I $G(DGOPT)="" W !?5,PATNAM_" has no Temporary, Confidential or ",!?5,"Residential Address." W !! G END
 I $G(DGOPT)>7 D
 . W !?11,"There is invalid data in the "_$S(DGOPT=8:"Temporary and Confidential ",DGOPT=9:"Confidential ",10:"Temporary ")_"address"_$S(DGOPT=8:"es.",1:".")
 . W !?11,"Please use Registration options to edit.",!!
 I $E(IOST,1,2)["C-" D
 . S DIR(0)="YAO",DIR("B")="Yes"
 . ; EAS*1.0*151; JAM; - change labels from "Elig/Enroll Confidential" to "Conf Mailing" and "Temporary" to "Temp Mailing"
 . ;  and add Residential Address (add logic to test for residential address and add to prompt)
 . S DGELIG="Conf Mailing"
 . S DGPROMPT=$S(DGOPT=3:DGELIG_" and Temp Mailing",DGOPT=2:DGELIG,DGOPT=1:"Temporary Mailing",DGOPT=4:DGELIG_", Temp Mailing and Residential",DGOPT=5:DGELIG_" and Residential",1:"")
 . I $G(DGPROMPT)="" S DGPROMPT=$S(DGOPT=6:"Temporary Mailing and Residential",DGOPT=7:"Residential",1:"")
 . I $G(DGPROMPT)="" S DGEND=1 Q
 . S DIR("A")="Would you like to view the "_DGPROMPT_" Address"_$S((DGOPT>2&(DGOPT<7)):"es",1:"")_"? "
 . D ^DIR K DIR
 . I Y'=1 S DGEND=1
 I DGEND=1 G END
 S DGC=2
 ;
 ;if displayed on screen offer to show addresses and do a page break for readability.
 I DGC>1 D
 . I $E(IOST,1,2)["C-" W @IOF
 . W !!?23,"Patient Name: ",?37,PATNAM
 ;display the addresses that are populated
 ; EAS*1.0*151; JAM; Modify address labels to Confid Mailing and Temp Mailing and add Residential address
 I CONOK=1 S TYPE="   Confid Mailing" D DISP(TYPE,.CONARR,.CONFARR)
 I TMPOK=1 S TYPE="     Temp Mailing" D DISP(TYPE,.TMPARR,.TEMPARR)
 ; DGOPT=4 means all 3 addresses are present, so we should paginate the display prior to displaying residential address
 I DGOPT=4 I $G(IOST)["C-" R !,"Enter <RETURN> to continue.",DGRET:DTIME W !
 I RESOK=1 S TYPE="      Residential" D DISP(TYPE,.RESARR,.RESIDARR)
 ; EAS*1.0*151; JAM; Modify messages to "Confidential Mailing Address" and "Temporary Mailing" and add Residential Address message
 I 'CONOK W !?8,"Patient "_PATNAM_" has no Confidential Mailing Address."
 I 'TMPOK W !?8,"Patient "_PATNAM_" has no Temporary Mailing Address."
 I 'RESOK W !?8,"Patient "_PATNAM_" has no Residential Address."
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
 W !?10,TYPE_" Address: ",?37,$S($G(ARR(2,IENS,$G(STR(1)),"E"))]"":ARR(2,IENS,STR(1),"E"),1:"UNKNOWN STREET ADDRESS")
 W:$G(ARR(2,IENS,$G(STR(2)),"E"))]"" !?37,ARR(2,IENS,STR(2),"E")
 W:$G(ARR(2,IENS,STR(3),"E"))]"" !?37,ARR(2,IENS,STR(3),"E")
 I DGUSA D  ;US address or null country which defaults to US
 . W !?37,$S($G(ARR(2,IENS,STR(4),"E"))]"":ARR(2,IENS,STR(4),"E"),1:"UNKNOWN CITY")_", "
 . W $S($G(ARR(2,IENS,STR(5),"E"))]"":ARR(2,IENS,STR(5),"E"),1:"UNKNOWN STATE")_" "
 . W:$G(ARR(2,IENS,STR(6),"E"))]"" ARR(2,IENS,STR(6),"E")
 I 'DGUSA D  ;foreign address
 . W !?37,""
 . W:$G(ARR(2,IENS,STR(15),"E"))]"" ARR(2,IENS,STR(15),"E")_" "
 . W $S($G(ARR(2,IENS,STR(4),"E"))]"":ARR(2,IENS,STR(4),"E"),1:"UNKNOWN CITY")_", "
 . W $S($G(ARR(2,IENS,STR(14),"E"))]"":ARR(2,IENS,STR(14),"E"),1:"UNKNOWN PROVINCE")_" "
 I $G(ARR(2,IENS,STR(7),"E"))]"" D
 . S DGCNTRY=ARR(2,IENS,STR(7),"E")
 . S DGCNTRY=$$COUNTRY^DGADDUTL(.DGCNTRY)
 . W !?37,DGCNTRY
 ; EAS*1.0*151; JAM; TYPE is modified from "Patient" to "Permanent Mailing" and new address type "Residential"
 I TYPE["Permanent" W !?14,"Bad Address Indicator: ",?37,$G(ARR(2,IENS,STR(8),"E"))
 W !?2,TYPE_" Add Change Date: ",?37,$G(ARR(2,IENS,STR(9),"E"))
 I TYPE["Permanent" W !,"Permanent Mailing Add Change Source: ",?37,$G(ARR(2,IENS,STR(10),"E"))
 I TYPE["Residential" W !,TYPE_" Add Change Source: ",?37,$G(ARR(2,IENS,STR(10),"E"))
 I TYPE["Permanent" W:$G(ARR(2,IENS,STR(10),"E"))="VAMC" !?2,TYPE_" Add Change Site: ",?37,$G(ARR(2,IENS,STR(11),"E"))
 I TYPE'["Permanent" W:$G(ARR(2,IENS,STR(11),"E"))]"" !?2,TYPE_" Add Change Site: ",?37,$G(ARR(2,IENS,STR(11),"E"))
 I TYPE'["Permanent",TYPE'["Residential" W !?3,TYPE_" Add Start Date: ",?37,$G(ARR(2,IENS,STR(12),"E"))
 I TYPE'["Permanent",TYPE'["Residential" W !?5,TYPE_" Add End Date: ",?37,$G(ARR(2,IENS,STR(13),"E"))
 W !
 Q
 ;
END ; common exit point - reset device and prompt user for another name
 K %ZIS D ^%ZISC,HOME^%ZIS
 G PATADDR
 Q
