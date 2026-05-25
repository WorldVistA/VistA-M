IBACCWLSPKUP ;EDE/TPF - ACC (Automated Community Care) Encounters - Special Lookup Prompt for ACC DIVISION ROLLUP ; 12-SEP-2023
 ;;2.0;INTEGRATED BILLING;**770**;21-MAR-2024;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
 ;CALLED FROM IBACCWLSORT
 ;EP - SPECIAL LOOKUP FOR #364.99 ACC DIVISION ... FILE
SPECLKUP(RETURN) ;EP - SPECIAL LOOKUP RTN FOR ACC DIVISION ROLLUP
 N ALL,DIR,DIV,DUOUT,DIROUT,DTOUT,ERROR,FIELDS,FLAGS,IBTARGET,IDENTIFIER,IENS,LISTRETURN,SPMAXNUMBER,PART,PREVX,RETURNIEN,SCREEN,SETOFCODES,SPECINT,X
 N HELP  ;TPF XINDEX
 ; 
 S DIR(0)="FO^3:7^K:X'?1(3N,3N2A,4N2A,3A,1""-"".E) X"   ;3N OR 3N2A  OR 3A  ;,1.3AN  ,1"-".E
 I ("^528^636^589^657^"[(U_$P($$SITE^VASITE,U,3)_U)) D SETDIRUP($P($$SITE^VASITE,U,3),.SETOFCODES) S DIR("PRE")="D SPEC^IBACCWLSPKUP(.SPECINT)" S DIR(0)="SO^"_SETOFCODES  ;FOR ALL INTEGRATED SITES   ;TPF;IB*2*770v11
 ;
 S DIR("A")="DIVISION/STATION/FACILITY GROUP"
 I '$D(IBDIV) S DIR("B")="ALL"
 E  S DIR("A")="Another DIVISION/STATION/FACILITY GROUP" K DIR("B")
 S DIR("?",1)="Enter the Station Number, Division number or a Facility Group number which you"
 S DIR("?",2)="wish to appear in your worklist."
 S DIR("?",3)=""
 S DIR("?",4)="A Station or Division Number can be three to seven alphanumeric characters"
 S DIR("?",5)="e.g. 333, 333AB, 333ABC, 6369AA."
 S DIR("?",6)=" "
 S DIR("?",7)="A Facility Group number is three Alpha characters that represents a billing"
 S DIR("?",8)="bucket where the bills from several stations and/or divisions are billed."
 S DIR("?",9)="If you wish to list the ACC Encounters for a specific Facility Group, just enter"
 S DIR("?",10)="the Facility Group e.g. CIA, CHE or NMX and all the Station Numbers"
 S DIR("?",11)="within that Facility Group will be included in your worklist."
 S DIR("?",12)=""
 S DIR("?",13)="If you enter ALL, all Stations and Divisions will be included in your worklist."
 S DIR("?",14)=" "
 S DIR("?",15)="If you enter 333 the station 333 will be included in your worklist."  ;TPF;IB*2*770v9
 S DIR("?",16)="If you enter -333 the station 333 will not be included in your worklist."   ;TPF;IB*2*770v9
 S DIR("?",17)=" "
 S DIR("?",18)="If you enter -ALL, your worklist filter will be cleared and you will be"   ;TPF;IB*2*770v9
 S DIR("?",19)="allowed to build a new worklist filter."                                 ;TPF;IB*2*770v9
 S DIR("?",20)=" "
 S DIR("?",21)="Enter ""^"" to clear your worklist filter and return to the"   ;TPF;IB*2*770v9
 S DIR("?",22)="MINIMUM # OF DAYS ON THE WORKLIST prompt."
 S DIR("?",23)=" "
 S DIR("?")="Press <Enter> when you are finished."
 ;
 S HELP=2
 ;
 D ^DIR
 ;
 I $G(SPECINT)'="" S X=SPECINT
 I X="",'$D(IBDIV) S RETURN="1^ESCAPE",RETURN(1)=$G(X) Q   ;TPF;IB*2*770v9
 I X="",$D(IBDIV) S RETURN="1^FINISHED",RETURN(1)=$G(X) Q   ;TPF;IB*2*770v9
 ;
 I X="ALL" D  Q   ;TPF;IB*2*770v9
 .W !!,"You have chosen to include all Stations and Divisions in your worklist."
 .K IBDIV
 .S RETURN="1^FINISHED",RETURN(1)=$G(X)
 ;
 I $D(DUOUT)!$D(DIROUT)!$D(DTOUT)!(X="-ALL")!(X="") D  Q:$G(RETURN)
 .I '$D(IBDIV) S RETURN="1^ESCAPE",RETURN(1)=$G(X) D  Q  ;TPF;IB*2*770v9
 ..W !!,"There were no selections in the worklist inclusion list."  ;IB*2*770v9
 ..W !!,"If you wish to exit enter a ""^"""
 .I X'="-ALL",(X'="") W !,"If you exit now you will lose the worklist inclusion list!"
 .E  I X="-ALL" W !,"Your worklist filter will be cleared and you will need to enter new",!,"filter criteria."  ;TPF;IB*2*770v9
 .S PREVX=X
 .N Y,DIR,DUOUT,DIROUT,DTOUT
 .S DIR(0)="YO"
 .S DIR("A")="ARE YOU SURE"
 .S DIR("B")="N"
 .D ^DIR
 .;
 .I PREVX=U S RETURN="1^ESCAPE" S VALMQUIT=1 Q  ;TPF;IB*2*770v29;EBILL-5297
 .Q:$D(DUOUT)!$D(DIROUT)!$D(DTOUT)!(X="N")
 .K IBDIV
 .I PREVX=U S RETURN="1^ESCAPE" S VALMQUIT=1 Q  ;TPF;IB*2*770v29;EBILL-5297
 .I PREVX="-ALL" S RETURN="0^NOT FINISHED"
 .S RETURN="0^ESCAPE"
 ;
 I $G(ALL)[("ALL") S RETURN="0^ALL" Q
 I $E(X)="-" D DEL(X,.IBDIV) S RETURN="0^-" Q
 S IBTARGET=Y
 ;
 S SCREEN=""
 ;
 S INDEX="M"
 I IBTARGET?3N S INDEX="B"         ;S SCREEN="I $P(^(0),U)=IBTARGET"
 I IBTARGET?3N2A S INDEX="B"       ;S SCREEN="I $P(^(0),U)=IBTARGET"
 I IBTARGET?3A S INDEX="C",SCREEN="I '$P(^(0),U,5)"   ;WCJ;v13;EBILL-3797;screen deactivated stations
 ;
 S IENS=""
 S FIELDS="@;.01;.02;.03;.04"
 S FLAGS="O"       ;ERRORS IN DATA RETURNED AS NULL AND PROCESSING CONTINUES. EXACT MATCH IF POSSIBLE
 S SPMAXNUMBER=""
 S IDENTIFIER=""
 K RETURN,ERROR
 ;
 D FIND^DIC(364.99,IENS,FIELDS,FLAGS,IBTARGET,SPMAXNUMBER,INDEX,SCREEN,IDENTIFIER,"RETURN","ERROR")
 ;
 S RETURNIEN=0
 F  S RETURNIEN=$O(RETURN("DILIST","ID",RETURNIEN)) Q:'RETURNIEN  D
 .S DIV=RETURN("DILIST","ID",RETURNIEN,.01)
 .I $D(IBDIV(DIV)) W !,"This Division/Station/Facility Group "_DIV_" has already been selected!" Q
 .S IBFIRST=0
 .S IBDIV(DIV)=""
 ;
 D CURIBDIV(.IBDIV,0)
 ;
 Q
 ;
CURIBDIV(IBDIV,HELP) ;EP - DISPLAY CURRENT WORKLIST FILTER ARRAY
 ;HELP = THE LAST # IN THE S DIR("?",16) ARRAY
 I '$D(IBDIV) D  Q
 .W !!,"There are no Stations/Divisions/Facility Groups in your worklist filter!"
 ;
 W !!,"The following Stations/Divisions/Facility Groups will be included"
 W !,"in your worklist:"
 W !
 ;I HELP S HELP=HELP+1 S DIR("?",HELP)=" ",HELP=HELP+1,DIR("?",HELP)="The following Stations will be included in your worklist:"
 N STAT,STATIEN
 S STAT=0
 F  S STAT=$O(IBDIV(STAT)) Q:'STAT  D
 .S STATIEN=$O(^DIC(4,"D",STAT,0))  ;ICR #10090 (Supported)
 .W !,STAT," "
 .I STATIEN W $P($G(^DIC(4,STATIEN,0)),U)  ;ICR #10090 (Supported)
 .;
 W !!
 Q
 ;
DEL(DELSTAT,IBDIV) ;EP - DELETE ITEMS FROM WORKLIST FILTER ARRAY
 ;
 N FACGRP,IEN,NAME
 S DELSTAT=$$UP^XLFSTR($E(DELSTAT,2,8))
 I DELSTAT'?3A K IBDIV(DELSTAT) W !!,"Station/Division Number "_DELSTAT_" will not appear on your worklist!",! D CURIBDIV(.IBDIV,0) Q
 S FACGRP=$E(DELSTAT,1,8)
 W !!,"Facility Group "_DELSTAT_" will not appear on your worklist!",!
 S IEN=0
 F  S IEN=$O(^IBA(364.99,"C",FACGRP,IEN)) Q:'IEN  D
 .S NAME=$P($G(^IBA(364.99,IEN,0)),U)
 .K IBDIV(NAME)
 ;
 D CURIBDIV(.IBDIV,0)
 ;
 Q
 ;
PAUSE ;EP - RETURN TO CONT 
 N DIR
 S DIR(0)="E"
 D ^DIR
 Q
 ;
SPECLKPXREF(X,TYPE) ;EP - XREF FOR FACILITY GROUP RESTRICTIONS
 ;
 N SITE
 ;or help on global specifications DO HELP^%G
 ;^IBA(364.99,"AC" -- NOTE: translation in effect
 ;^IBA(364.99,"AC","S X","ALB")=1
 ;                      "ALT")=6   
 ;TYPE= KILL OR SET
 I TYPE="S" D
 .S FACGRP=X
 .S SITE=$P(^IBA(364.99,DA,0),U)
 .Q:"^528^636^589^657^"'[(U_$E(SITE,1,3)_U)
 .;
 .S ^IBA(364.99,"E",$E(SITE,1,3),FACGRP,DA)=""
 ;
 I TYPE="K" D
 .K ^IBA(364.99,"E",X)
 ;
 Q
 ;
 ;D SETXREF^IBACCSPECLKUP
SETXREF ;EP
 N DA,DIK
 S DIK="^IBA(364.99,"
 S DIK(1)=".02^E"
 S DA=0
 F  S DA=$O(^IBA(364.99,DA)) Q:'DA  D
 .D EN1^DIK
 ;
 Q
 ;
 ;#364.99  ACC DIVISION ROLLUP
 ;D SETDIRUP^IBACCWLSPKUP($P($$SITE^VASITE,U,3),.SETOFCODES)  ;TPF;IB*2*770v9
SETDIRUP(VASITE,SETOFCODES) ;EP - SET DIR(0) UP WITH SET OF CODES FOR EACH INTEGRATED SITE USING "E" X-REF ;TPF;IB*2*770v9
 ;
 N FACGRP,INTSITE,INSTSTATNUM,MORE,OFFNAME,STATNAME,STATNUM
 K SETOFCODES
 ;
 S FACGRP=""
 F  S FACGRP=$O(^IBA(364.99,"E",VASITE,FACGRP)) Q:FACGRP=""  D  ;TPF;IB*2*770v9
 .S INTSITE=$O(^IBA(364.99,"C",FACGRP,0))
 .S STATNUM=$P($G(^IBA(364.99,INTSITE,0)),U)  ;="636^NWI
 .S INSTSTATNUM=$$RUST^IBACCROWFT(STATNUM)   ;WCJ;v10
 .S STATIEN=$O(^DIC(4,"D",INSTSTATNUM,""))  ;WCJ;v10 ;ICR #10090 (Supported)
 .Q:'STATIEN
 .S OFFNAME=$P($G(^DIC(4,STATIEN,99)),U,3)   ;OFFICIAL VA NAME: VA HEALTHCARE NETWORK UPSTATE ;ICR #10090 (Supported)
 .S STATNAME=$P($G(^DIC(4,STATIEN,0)),U)_" ("_INSTSTATNUM_")" ;ICR #10090 (Supported)
 .S SETOFCODES=$G(SETOFCODES)_FACGRP_":"_STATNAME
 .S MORE=$O(^IBA(364.99,"E",VASITE,FACGRP)) I MORE'="" S SETOFCODES=SETOFCODES_";"  ;TPF;IB*2*770v9
 S SETOFCODES=$G(SETOFCODES)_";ALL:ALL AVAILABLE FACILITY GROUPS"  ;TPF;IB*2*770v9
 ;
 Q
 ;
 ;VA FILEMAN V22.2 DEVELOPER'S GUIDE SECTION 2.3.47.3
 ;THIS IS DONE TO HANDLE USER ENTERING A THREE CHAR 'FACILITY GROUP"  
SPEC(SPECINT) ;EP - SPECIAL PRE-VALIDATION TRANSFORM FOR INTEGRATED SITES
 ;
 S SPECINT=""
 I X?1"-"3A S SPECINT=X S X="" Q
 I X?1"-".E I '$D(IBDIV($E(X,2,999))) W !,$E(X,2,999)_" NOT IN CURRENT SELECTION LIST" Q
 I X?1"-".E S SPECINT=X S X="" Q
 ; 
 Q
