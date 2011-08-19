PSULR1 ;BIR/PDW - PBM LAB EXTRACT ;12 AUG 1999
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ; Extract & setup crosswalk for drug codes and "CH" nodes
 ; Reference to File # 60  supported by DBIA 2523
 ; Reference to ^LAM       supported by DBIA 2522
EN ;EP  Tasking Entry Point for generating LAB mail messages, Summaries, & Prints
 ;
CODES ; Table for Building Class * Work Load codes * Lab Tests crosswalk
 D SETCODES^PSULR0
 ; Builds ^XTMP(PSULRSUB,"CODES",VA DRUG CLASS,LAB NODE LOCATION)=LAB TEST
 ; Builds PSUFLAG("BLOOD":"SERUM":"PLASMA") array
 S:'$D(PSUJOB) PSUJOB=$J
 S:'$D(PSULRJOB) PSULRJOB=PSUJOB
 S:'$D(PSULRSUB) PSULRSUB="PSULR_"_PSULRJOB
 ;    Initialize Flag type array
 F X="BLOOD","SERUM","PLASMA" S PSUFLAG(X)=""
 ;
 ;    Loop Drug Class Codes & WorkCodes    3.2.8.7
 S X="AN500" F Y=83405,81062 S PSULRX(X,Y)="" D GET
 S X="CV200" F Y=82565 S PSULRX(X,Y)="" D GET
 S X="CV350" F Y=83017,83013,84480,82466,84455,84465 S PSULRX(X,Y)="" D GET
 S X="CV800" F Y=82565,84140 S PSULRX(X,Y)="" D GET
 S X="GA301" F Y=82565 S PSULRX(X,Y)="" D GET
 S X="HS502" F Y=84330,85053,84455,84465,85052 S PSULRX(X,Y)="" D GET
 ;
 Q
 ;   Follow wrk code into tests 3.2.8.9
GET ;EP   Get the appropriate Work Load entry
 ;
 S PSUY=Y_".0000 " D WALK
 F  S PSUY=$O(^LAM("C",PSUY)) Q:(+PSUY\1'=+Y)  D WALK
 Q
WALK ;EP Do the crosswalk to get the tests associated with workload
 S Z=$O(^LAM("C",PSUY,0))
 ;    3.2.8.9
 I '$D(^LAM(Z,7,"B")) Q
 ;    3.2.8.10
 ;
 S PSUWKDA=Z
 ;    Loop Multiple & Work on over to file 60 & check site/specimen
 S Z="" F  S Z=$O(^LAM(PSUWKDA,7,"B",Z)) Q:Z=""  D
 . S PSULRDA=+Z
 . K PSUSPECM
 . D GETM^PSUTL(60,PSULRDA,"100*^.01;6","PSUSPECM")
 . S DA=0,PSUFLAG=0 F  S DA=$O(PSUSPECM(DA)) Q:DA'>0  S W=PSUSPECM(DA,.01) I $D(PSUFLAG(W)) S PSUFLAG=1 Q
 . Q:'PSUFLAG
 . ;  store DrugCode, WrkCode, Lab IEN = Location
 . S PSULOC=$$VAL^PSUTL(60,PSULRDA,5),PSULOC=$P(PSULOC,";",2)
 . ;S ^XTMP(PSULRSUB,"CODES",X,+Y,PSULRDA)=PSULOC ; Trace Construction
 . S ^XTMP(PSULRSUB,"CODES",X,PSULOC)=$$VAL^PSUTL(60,PSULRDA,.01)_U_PSUSPECM(DA,6)
