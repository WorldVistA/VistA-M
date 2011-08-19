ECRDSSA ;ALB/RPM - DSS Unit Activity Report ; 2 Sep 2008
 ;;2.0; EVENT CAPTURE ;**95,104**;8 May 96;Build 7
 ;
EN ;Get location(s), DSS Unit(s), sort type, start & end dates, device
 ;
 N ECLOC,ECDSSU,ECSRT,ECSTDT,ECENDDT
 I '$$ASKLOC^ECRUTL G ENQ
 I '$$ASKDSS^ECRUTL G ENQ
 I '$$ASKSRT(.ECSORT) G ENQ
 I '$$STDT^ECRUTL G ENQ
 I '$$ENDDT^ECRUTL(ECSTDT) G ENQ
 I $$ASKDEV D STRPT^ECRDSSA
ENQ Q
 ;
STRPT ;Main entry point
 N ECCRT  ;is CRT?
 N ECPAGE  ;page cnt
 S ECPAGE=0
 S ECCRT=$S($E(IOST,1,2)="C-":1,1:0)
 U IO
 K ^TMP("ECRPT",$J)
 D FNDREC(ECSORT)
 D PRINT(ECSORT)
 K ^TMP("ECRPT",$J)
 Q
 ;
FNDREC(ECSRT) ;Loop through "ADT" xref of EVENT CAPTURE PATIENT (#721) file
 ;  Input:
 ;    ECSRT - sort type
 ;
 ;  Output: none
 ;
 N ECNT   ;record cnt
 N ECL     ;location cnt
 N ECD     ;DSS unit cnt
 N ECDFN   ;DFN
 N ECLOCF  ;Location IEN
 N ECDSSF  ;DSS unit IEN
 N ECDT    ;date index
 N ECREC   ;"0" node
 S ECNT=0
 ;
 S ECL=0
 F  S ECL=$O(ECLOC(ECL)) Q:'ECL  S ECLOCF=+$P(ECLOC(ECL),U) D
 . S ^TMP("ECRPT",$J,ECLOCF)=0  ;initialize location counter
 . S ECD=0
 . F  S ECD=$O(ECDSSU(ECD)) Q:'ECD  S ECDSSF=+$P(ECDSSU(ECD),U) D
 . . S ^TMP("ECRPT",$J,ECLOCF,ECDSSF)=0  ;initialize DSS Unit counter
 . S ECDFN=0
 . F  S ECDFN=+$O(^ECH("ADT",ECLOCF,ECDFN)) Q:'ECDFN  D
 . . S ECD=0
 . . F  S ECD=$O(ECDSSU(ECD)) Q:'ECD  S ECDSSF=+$P(ECDSSU(ECD),U) D
 . . . S ECDT=ECSTDT
 . . . F  S ECDT=+$O(^ECH("ADT",ECLOCF,ECDFN,ECDSSF,ECDT)) Q:'ECDT!(ECDT>ECENDDT)  D
 . . . . S ECIEN=0
 . . . . F  S ECIEN=+$O(^ECH("ADT",ECLOCF,ECDFN,ECDSSF,ECDT,ECIEN)) Q:'ECIEN  D
 . . . . . I $P($G(^ECH(ECIEN,0)),U,7)=ECDSSF D BLDTMP(ECIEN,ECSRT,.ECNT)
 Q
 ;
BLDTMP(ECIEN,ECSRT,ECCNT) ;add record to list
 ;  Input:
 ;    ECIEN - pointer to EVENT CAPTURE PATIENT (#721) file
 ;    ECSRT - sort type
 ;    ECCNT - record counter
 ;
 ;  Output:
 ;    ^TMP("ECRPT",$J,location,DSS unit,sort key1,sort key2,count)
 ;
 N ECLOCA  ;location
 N ECDSS  ;DSS unit
 N ECIENS  ;IENS
 N ECKEY  ;sort key array
 N ECREC  ;record string
 N ECERR  ;FM error
 N ECDT  ;date
 I +$G(ECIEN)>0,$$GETKEYS(ECSRT,ECIEN,.ECKEY) D
 . S ECCNT=+$G(ECCNT)+1
 . S ECIENS=ECIEN_","
 . S ECREC=""
 . D GETS^DIQ(721,ECIENS,"1;2;3;6;8;9;10;20;29","IE","ECREC","ECERR")
 . S ECLOCA=+$G(ECREC(721,ECIENS,3,"I"))
 . S ECDSS=+$G(ECREC(721,ECIENS,6,"I"))
 . S ECREC=ECREC_$E($G(ECREC(721,ECIENS,1,"E")),1,30)_"^"  ;pt name
 . S ECREC=ECREC_$E($$GETSSN(ECIEN),1,10)_"^"              ;ssn
 . S ECREC=ECREC_$E($G(ECREC(721,ECIENS,29,"I")),1)_"^"    ;in/out
 . S ECREC=ECREC_$E($G(ECREC(721,ECIENS,2,"I")),1,13)_"^"  ;dt/tm
 . S ECDT=$P($G(ECREC(721,ECIENS,2,"I")),".",1)
 . S ECREC=ECREC_$E($$GETPROC($G(ECREC(721,ECIENS,8,"I"))),1,5)_"^"   ;proc code
 . S ECREC=ECREC_$E($$GETPRNM($G(ECREC(721,ECIENS,8,"I")),ECDT),1,10)_"^"  ;proc name
 . S ECREC=ECREC_$E($G(ECREC(721,ECIENS,9,"I")),1,2)_"^"   ;vol
 . S ECREC=ECREC_$E($$GETPROV(ECIEN),1,30)_"^"  ;provider
 . S ECREC=ECREC_$E($G(ECREC(721,ECIENS,20,"E")),1,7)      ;dx
 . S ^TMP("ECRPT",$J,ECLOCA,ECDSS,ECKEY(1),ECKEY(2),ECNT)=ECREC
 . S ^TMP("ECRPT",$J,ECLOCA)=$G(^TMP("ECRPT",$J,ECLOCA))+1
 . S ^TMP("ECRPT",$J,ECLOCA,ECDSS)=$G(^TMP("ECRPT",$J,ECLOCA,ECDSS))+1
 Q
 ;
PRINT(ECSRT) ;loop results array and format output
 ;  Input:
 ;    ECSRT - sort type
 ;
 ;  Output: none
 ;
 N ECCLOC  ;current location
 N ECPLOC  ;previous location
 N ECLOCNM  ;location name
 N ECCDSS  ;current DSS unit
 N ECPDSS  ;previous DSS unit
 N ECDSSNM  ;DSS unit name
 N ECCNT   ;record count
 N ECDAT   ;procedure date/time
 N ECRDT   ;run date
 N ECFDT   ;from date
 N ECTDT   ;to date
 N ECKEY1  ;sort key 1
 N ECKEY2  ;sort key 2
 N ECSRTBY  ;sort type text
 N ECQUIT  ;user quit indicator
 N ECREC   ;tmp record data
 I '$D(^TMP("ECRPT",$J)) G PRINTQ
 S ECRDT=$$FMTE^XLFDT($$NOW^XLFDT,"5DZ")
 S ECFDT=$$FMTE^XLFDT($P(ECSTDT+.0001,"."),"5DZ")
 S ECTDT=$$FMTE^XLFDT($P(ECENDDT,"."),"5DZ")
 S ECSRTBY=$S(ECSRT="P":"Patient Name",ECSRT="R":"Provider Name",ECSRT="S":"Patient SSN",1:"")
 S (ECCLOC,ECPLOC,ECQUIT)=0
 F  S ECCLOC=$O(^TMP("ECRPT",$J,ECCLOC)) Q:'ECCLOC!(ECQUIT)  D
 . I ECCLOC'=ECPLOC D  ;location changed
 . . S ECPLOC=ECCLOC
 . . S ECLOCNM=$$GETLOCN(ECCLOC,.ECLOC)
 . . I $O(^TMP("ECRPT",$J,ECCLOC,0))>0 D:ECPAGE>0 PAUSE Q:ECQUIT  D HDR(ECLOCNM,ECRDT,ECFDT,ECTDT,ECSRTBY)
 . I $G(^TMP("ECRPT",$J,ECCLOC))=0 D  Q
 . . W !!,"    ** No records found on Location that match selection criteria"
 . S (ECCDSS,ECPDSS)=0
 . F  S ECCDSS=$O(^TMP("ECRPT",$J,ECCLOC,ECCDSS)) Q:'ECCDSS!(ECQUIT)  D
 . . I ECCDSS'=ECPDSS D  Q:ECQUIT  ;dss unit changed
 . . . S ECPDSS=ECCDSS
 . . . S ECDSSNM=$$GETDSSN(ECCDSS,.ECDSSU)
 . . . I $Y>(IOSL-10) D PAUSE Q:ECQUIT  D HDR(ECLOCNM,ECRDT,ECFDT,ECTDT,ECSRTBY)
 . . . D DSSHDR(ECCDSS,ECDSSNM)
 . . I $G(^TMP("ECRPT",$J,ECCLOC,ECCDSS))=0 D  Q
 . . . W !,"** No records found on DSS Unit that match selection criteria"
 . . S ECKEY1=""
 . . F  S ECKEY1=$O(^TMP("ECRPT",$J,ECCLOC,ECCDSS,ECKEY1)) Q:ECKEY1=""!(ECQUIT)  D
 . . . S ECKEY2=""
 . . . F  S ECKEY2=$O(^TMP("ECRPT",$J,ECCLOC,ECCDSS,ECKEY1,ECKEY2)) Q:ECKEY2=""!(ECQUIT)  D
 . . . . S ECCNT=0
 . . . . F  S ECCNT=$O(^TMP("ECRPT",$J,ECCLOC,ECCDSS,ECKEY1,ECKEY2,ECCNT)) Q:'ECCNT!(ECQUIT)  D
 . . . . . I $Y>(IOSL-7) D PAUSE Q:ECQUIT  D HDR(ECLOCNM,ECRDT,ECFDT,ECTDT,ECSRTBY),DSSHDR(ECCDSS,ECDSSNM) W " (cont'd)"
 . . . . . S ECREC=^TMP("ECRPT",$J,ECCLOC,ECCDSS,ECKEY1,ECKEY2,ECCNT)
 . . . . . W !,$P(ECREC,U,1)  ;name
 . . . . . W ?31,$P(ECREC,U,2)  ;ssn
 . . . . . W ?42,$P(ECREC,U,3)  ;inpt/outpt
 . . . . . S ECDAT=$$FMTE^XLFDT($P(ECREC,U,4),"2MZ")
 . . . . . W ?44,$P(ECDAT,":")_$P(ECDAT,":",2)  ;dt/tm
 . . . . . W ?58,$P(ECREC,U,5)  ;proc code
 . . . . . W ?64,$P(ECREC,U,6)  ;proc name
 . . .  .. W ?75,$P(ECREC,U,7)  ;vol
 . . . . . W ?78,$P(ECREC,U,8)  ;provider
 . . . . . W ?109,$P(ECREC,U,9)  ;dx
 I 'ECQUIT D PAUSE
PRINTQ Q
 ;
HDR(ECLOCN,ECRDT,ECFDT,ECTDT,ECSRT) ;Report header
 ;  Input:
 ;    ECLOCN - location name
 ;    ECRDT - run date
 ;    EDFDT - from date
 ;    EDTDT - to date
 ;    ECSRT - sort text
 ;
 ;  Output:  none
 ;
 I ECCRT!(ECPAGE) W @IOF
 S ECPAGE=ECPAGE+1
 W !,?11,"EVENT CAPTURE DSS UNIT ACTIVITY REPORT"
 W ?58,"Run Date: ",ECRDT
 W ?109,"Page: ",ECPAGE
 W !!,?13,"For Location ",ECLOCN
 W !,?13,"From "_ECFDT_" through "_ECTDT
 W !,?13,"Sorted by ",ECSRT
 W !!?4,"Patient",?31,"SSN",?40,"I/O",?45,"Date/Time",?58,"Proc",?64,"Procedure",?75,"Vol",?80,"Primary",?109,"Primary"
 W !?58,"Code",?64,"Name",?80,"Provider",?109,"Diagnosis"
 Q
 ;
DSSHDR(ECDSS,ECDSSNM) ;DSS header
 ;  Input:
 ;    ECDSS - DSS unit
 ;    ECDSSNM - DSS unit name
 ;
 ;  Output:  none
 ;
 W !!,"DSS Unit: ",ECDSSNM," (IEN #",ECDSS,")"
 Q
 ;
PAUSE ;page break
 N DIR,DIRUT,DUOUT
 D FOOTER
 Q:'ECCRT
 I IOSL<30 F  W ! Q:$Y>(IOSL-7)
 W !
 S DIR(0)="E"
 D ^DIR
 I $D(DIRUT)!($D(DUOUT)) S ECQUIT=1
 Q
 ;
FOOTER ;page footer
 W !!?4,"Volume totals may represent days, minutes, numbers of procedures"
 W !?4,"and/or a combination of these."
 Q
 ;
GETLOCN(ECLOCA,ECLOC) ;get location name
 ;  Input:
 ;    ECLOCA - location
 ;    ECLOC - array of selected locations
 ;
 ;  Output:
 ;   Function value - returns location name on success; "" on failure
 ;
 N ECI
 N ECLOCNM
 S ECLOCNM=""
 I +$G(ECLOCA)>0 D
 . S ECI=0
 . F  S ECI=$O(ECLOC(ECI)) Q:'ECI!(ECLOCNM'="")  D
 . . I $P(ECLOC(ECI),U)=ECLOCA S ECLOCNM=$P(ECLOC(ECI),U,2)
 Q ECLOCNM
 ;
GETDSSN(ECDSS,ECDSSU) ;-get DSS unit name
 ;  Input:
 ;    ECDSS - DSS unit
 ;    ECDSSU - array of selected DSS units
 ;
 ;  Output:
 ;   Function value - returns DSS unit name on success; "" on failure
 ;
 N ECI
 N ECDSSNM
 S ECDSSNM=""
 I +$G(ECDSS)>0 D
 . S ECI=0
 . F  S ECI=$O(ECDSSU(ECI)) Q:'ECI!(ECDSSNM'="")  D
 . . I $P(ECDSSU(ECI),U)=ECDSS S ECDSSNM=$P(ECDSSU(ECI),U,2)
 Q ECDSSNM
 ;
GETKEYS(ECSRT,ECIEN,ECKEYS) ;get sort keys based on sort type
 ;  Input:
 ;    ECSRT - (required) sort type indicator (P, S, R)
 ;    ECIEN - (required) pointer to EVENT CAPTURE PATIENT (#721) file
 ;    
 ;  Output:
 ;    ECKEYS - (pass by reference) array of sort keys
 ;    Function value - returns 1 on success;0 on failure
 ;
 N ECRSLT  ;function value
 S ECRSLT=0
 S (ECKEYS(1),ECKEYS(2))=""
 I $G(ECSRT)'="",+$G(ECIEN)>0 D
 . I ECSRT="P" D
 . . S ECKEYS(1)=$$GET1^DIQ(721,ECIEN_",",1)  ;name
 . . S ECKEYS(2)=$E($$GETSSN(ECIEN),1,9)  ;ssn
 . I ECSRT="R" D
 . . S ECKEYS(1)=$$GETPROV(ECIEN)  ;provider
 . . I ECKEYS(1)="" S ECKEYS(1)=" "  ;missing provider sorts to top
 . . S ECKEYS(2)=$$GET1^DIQ(721,ECIEN_",",1)  ;name
 . I ECSRT="S" D
 . . S ECKEYS(1)=$E($$GETSSN(ECIEN),1,9)  ;ssn
 . . S ECKEYS(2)=$$GET1^DIQ(721,ECIEN_",",1)  ;name
 . I ECKEYS(1)'="",ECKEYS(2)'="" S ECRSLT=1
 Q ECRSLT
 ;
GETSSN(ECIEN) ;get patient SSN
 ;  Input:
 ;    ECIEN - (required) pointer to EVENT CAPTURE PATIENT (#721) file
 ;    
 ;  Output:
 ;    Function value - returns patient's SSN on success; "" on failure
 ;
 N DFN,VADM,VAERR  ;VADPT variables
 I +$G(ECIEN)>0 D
 . S DFN=$$GET1^DIQ(721,ECIEN_",",1,"I")
 . D DEM^VADPT
 Q $P($G(VADM(2)),U)
 ;
GETPROV(ECIEN) ;get primary provider
 ;This function retrieves the primary provider for a given Event
 ;Capture record.  Searches the PROVIDER MULTIPLE (#42) field first
 ;and falls back to the PROVIDER (#10) field.
 ;  Input:
 ;    ECIEN -(required) pointer to EVENT CAPTURE PATIENT (#721) file
 ;
 ;  Output:
 ;   Function value - returns provider's name on success; "" on failure
 ;
 N ECPROV  ;provider name
 S ECPROV=""
 I $G(ECIEN)'="",$D(^ECH(ECIEN)) D
 . ;try PROVIDER MULTIPLE
 . I '$$GETPPRV^ECPRVMUT(ECIEN,.ECPROV) D  ;api returns "0" on success
 . . S ECPROV=$P(ECPROV,U,2)
 . E  D  ;try PROVIDER
 . . S ECPROV=$$GET1^DIQ(721,ECIEN_",",10)
 Q ECPROV
 ;
GETPRNM(ECVIEN,ECDT) ;get procedure name
 ;  Input:
 ;    ECVIEN - variable pointer to CPT (#81) file or EC PROC file
 ;    
 ;  Output:
 ;    Function value - returns procedure name on success; "" on failure
 ;
 N ECIEN   ;IEN part of variable pointer
 N ECFILE  ;file part of variable pointer
 S ECIEN=$P(ECVIEN,";",1)
 S ECFILE=$P(ECVIEN,";",2)
 Q $S(ECFILE["ICPT(":$P($$CPT^ICPTCOD(ECIEN,ECDT),U,3),ECFILE["EC(725":$$GET1^DIQ(725,ECIEN_",",.01),1:"")
 ;
GETPROC(ECVIEN) ;get procedure code
 ;  Input:
 ;    ECVIEN - varialbe pointer to CPT (#81) file or EC PROC file
 ;
 ;  Output:
 ;   Function value - returns procedure code on success; "" on failure
 ;
 N ECIEN  ;IEN part of variable pointer
 N ECFILE  ;file part of variable pointer
 S ECIEN=$P(ECVIEN,";",1)
 S ECFILE=$P(ECVIEN,";",2)
 Q $S(ECFILE["ICPT(":$$GET1^DIQ(81,ECIEN_",",.01),ECFILE["EC(725":$$GET1^DIQ(725,ECIEN_",",1),1:"")
 ;
ASKSRT(ECTYP) ;Ask report sort type
 ;  Input:  none
 ;  
 ;  Output:
 ;    ECTYP - (pass by reference) Sort type
 ;            (P: Patient Name,S: SSN,R: Provider Name)
 ;    Function value - returns 1 on success; 0 on failure
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y  ;^DIR variables
 S DIR(0)="SA^P:PATIENT NAME;S:SSN;R:PROVIDER NAME"
 S DIR("A")="Sort within each DSS Unit by: "
 S DIR("B")="SSN"
 D ^DIR
 S ECTYP=$P(Y,U)
 Q $S($D(DUOUT):0,$D(DTOUT):0,$D(DIROUT):0,1:1)
 ;
ASKDEV() ;Ask output device
 ;  Input:  none
 ;
 ; Output:  1 if report is printed
 ;          0 if report is queued (or exited)
 ;
 N ECX,ZTDESC,ZTRTN,ZTSAVE
 S ECX=1
 K %ZIS S %ZIS="QMP"
 D ^%ZIS
 S:POP ECX=0
 I ECX&($D(IO("Q"))) D
 . S ZTRTN="STRPT^ECRDSSA",ZTDESC="DSS UNIT ACTIVITY REPORT"
 . S (ZTSAVE("ECLOC("),ZTSAVE("ECDSSU("),ZTSAVE("ECSRT"))=""
 . S (ZTSAVE("ECSTDT"),ZTSAVE("ECENDDT"))=""
 . D ^%ZTLOAD
 . D HOME^%ZIS
 . S ECX=0
 Q ECX
