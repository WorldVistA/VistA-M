OOPSGUIF ;WIOFO/LLH-RPC routine for OSHA Log ;11/5/01
 ;;2.0;ASISTS;**6,7,11,15**;Jun 03, 2002;Build 9
 ;
OSHA(RESULTS,INPUT,CALL) ; get the data
 ;   Input:  INPUT - contains 4 values, the START AND END DATE, 
 ;                   STATION, and INCLUDE NAME ON REPORT.  The Date of
 ;                   Occ (fld #4) is used to in/exclude claims from the
 ;                   report.  If Include name = Y, then names are
 ;                   printed, else they will not,and if Station='ALL'
 ;                   then all claims are included, if not 'All', then
 ;                   only 1 station is included.
 ;            CALL - Contains the calling menu.  If caller = "U"nion
 ;                   name is excluded from printing.
 ; Output: RESULTS - the results array passes data back to the client.
 N CN,DA,IEN,INCNA,OCC,OOPS,PERSON,SDATE,STDT,STA,ENDDT,EDATE,X,Y
 N GONE,LOST,DOI,CAX,FILL,TYPE
 K ^TMP($J,"OSHA")
 S CN=1,RESULTS(0)="Processing..."
 S STDT=$P($G(INPUT),U),ENDDT=$P($G(INPUT),U,2)
 S STA=$P($G(INPUT),U,3)
 S INCNA=$P($G(INPUT),U,4)
 I (STDT="")!(ENDDT="")!(STA="")!(INCNA="") D  Q
 . S RESULTS(0)="Input parameters missing, cannot run report." Q
 S (SDATE,EDATE)=""
 S X=STDT D ^%DT S SDATE=Y
 S X=ENDDT D ^%DT S EDATE=Y
 ; SDATE made last time in day prior so start date correct
 S SDATE=(SDATE-1)_".9999",EDATE=EDATE_".9999"
 S LP="",IEN=""
 F LP=SDATE:0 S LP=$O(^OOPS(2260,"AD",LP)) Q:(LP'>0)!(LP>EDATE)  D
 . F  S IEN=$O(^OOPS(2260,"AD",LP,IEN)) Q:IEN'>0  D
 .. I $$GET1^DIQ(2260,IEN,88,"I")'="Y" Q
 .. I $$GET1^DIQ(2260,IEN,51,"I")>1 Q
 .. S STATION=$P(^OOPS(2260,IEN,"2162A"),U,9)
 .. I $G(STA)'="A",(STATION'=STA) Q
 .. K OOPS,ARR S DIC="^OOPS(2260,"
 .. S DR=".01;1;3;4;15;30;33;52;63;86;89"
 .. S DA=IEN,DIQ="OOPS",DIQ(0)="IE" D EN^DIQ1
 .. S CAX=OOPS(2260,IEN,52,"I")
 .. S DOI=OOPS(2260,IEN,4,"I"),DOI=$P($$FMTE^XLFDT(DOI,2),"@")
 .. ; PER A. BIERENBAUM, GET OCC DESC 5/13/02
 .. S OCC=$$OCCDESC(IEN)
 .. ; S OCC=OOPS(2260,IEN,63,"E")_$E(OOPS(2260,IEN,15,"E"),1,4)
 .. S GONE=OOPS(2260,IEN,89,"I"),GONE=$S(GONE="Y":"X",1:"")
 .. S LOST=OOPS(2260,IEN,33,"I")
 .. S LOST=$S(LOST="Y":"X^",LOST="N":"^X",1:"^X")
 .. S TYPE=OOPS(2260,IEN,3,"I")
 .. I TYPE>10&(TYPE<15) S PERSON="Privacy Case"
 .. S PERSON=OOPS(2260,IEN,1,"E") I CALL="Union"!(INCNA="N") S PERSON=""
 .. S ARR=OOPS(2260,IEN,.01,"E")_U_DOI_U
 .. S ARR=ARR_PERSON_U_OCC_U_$E(OOPS(2260,IEN,86,"E"),1,35)_U
 .. S ARR=ARR_OOPS(2260,IEN,3,"E")_U_OOPS(2260,IEN,30,"E")_U
 .. S FILL="" I CAX=2 S FILL="^^^"
 .. S ARR=ARR_FILL_GONE_U_LOST
 .. S ^TMP($J,"OSHA",CN)=ARR,CN=CN+1
 S RESULTS=$NA(^TMP($J,"OSHA"))
 Q
NSTICK(RESULTS,INPUT,CALL) ; NeedleStick Log get data logic
 ;   Input:  INPUT - contains 4 values, the START DATE, END DATE, 
 ;                   STATION, and INCLUDE NAME ON REPORT.  The Date of
 ;                   Occurrence (field #4) will be used to include/
 ;                   exclude claims from the report.  If the Include
 ;                   name is = Y then the names will be printed, if no
 ;                   they will not, and if the Station = 'ALL' then any
 ;                   claim will be include, if not 'All', but the
 ;                   station number then only 1 station is included.
 ;            CALL - Contains the calling menu.  This will be used
 ;                   to exclude the name from printing if the caller
 ;                   is 'U'nion.
 ; Output: RESULTS - the results array passes the data back to the
 ;                   client.
 N CN,DA,IEN,INCNA,OCC,PERSON,SDATE,STDT,STA,ENDDT,EDATE,X,Y
 N LOST,DOI,OOPS,TYPE
 K ^TMP($J,"NS")
 S CN=1,RESULTS(0)="Processing..."
 S STDT=$P($G(INPUT),U),ENDDT=$P($G(INPUT),U,2)
 S STA=$P($G(INPUT),U,3)
 S INCNA=$P($G(INPUT),U,4)
 I (STDT="")!(ENDDT="")!(STA="")!(INCNA="") D  Q
 . S RESULTS(0)="Input parameters missing, cannot run report." Q
 S (SDATE,EDATE)=""
 S X=STDT D ^%DT S SDATE=Y
 S X=ENDDT D ^%DT S EDATE=Y
 ; SDATE made last time in day prior so start date correct
 S SDATE=(SDATE-1)_".9999",EDATE=EDATE_".9999"
 S LP="",IEN=""
 F LP=SDATE:0 S LP=$O(^OOPS(2260,"AD",LP)) Q:(LP'>0)!(LP>EDATE)  D
 . F  S IEN=$O(^OOPS(2260,"AD",LP,IEN)) Q:IEN'>0  D
 .. ; exclude deleted, replaced by amendment cases
 .. I $$GET1^DIQ(2260,IEN,51,"I")>1 Q
 .. S STATION=$P(^OOPS(2260,IEN,"2162A"),U,9)
 .. I $G(STA)'="A",(STATION'=STA) Q
 .. ; if Type Incident not = Hollow Bore Needlestick, Sharps Exposure,
 .. ; Exposure to Body Fluids/Splash, Suture Needlestick don't include
 .. S TYPE=$$GET1^DIQ(2260,IEN,3,"I")
 .. I TYPE<11!(TYPE>14) Q
 .. ; now get the data and put in array.
 .. K OOPS,ARR S DIC="^OOPS(2260,"
 .. ; V2_P15 02/19/08 llh - added field 352 to use for lost time
 .. S DR=".01;1;3;4;15;14;29;30;33;37;38;51;52;82;86;108;352"
 .. S DA=IEN,DIQ="OOPS",DIQ(0)="IE" D EN^DIQ1
 .. S DOI=OOPS(2260,IEN,4,"E")
 .. ; PER A. BIERENBAUM, USE OCC DESC 5/13/02
 .. S OCC=$$OCCDESC(IEN)
 .. ; S OCC=$E(OOPS(2260,IEN,15,"E"),1,4)
 .. ; patch 7 remove lost time
 .. ; S LOST=OOPS(2260,IEN,33,"E")
 .. ; V2_P15 02/19/08 llh - now indicating lost time
 .. S LOST="No" I $G(OOPS(2260,IEN,352,"I"))="A" S LOST="Yes"
 .. S INJILL=OOPS(2260,IEN,52,"I")
 .. S INJILL=$S(INJILL=1:"Injury",INJILL=2:"Illness",1:"")
 .. ; patch 7 - only print privacy case in name field - all cases
 .. S PERSON="Privacy Case"
 .. ; S PERSON=OOPS(2260,IEN,1,"E")
 .. I CALL="Union"!(INCNA="N") S PERSON=""
 .. S ARR=IEN_U_OOPS(2260,IEN,.01,"E")_U_DOI_U_PERSON_U_INJILL_U
 .. S ARR=ARR_OOPS(2260,IEN,51,"E")_U_OCC_U_$E(OOPS(2260,DA,14,"E"),1,4)
 .. S ARR=ARR_U_OOPS(2260,IEN,86,"E")_U
 .. S ARR=ARR_OOPS(2260,IEN,3,"E")_U_OOPS(2260,IEN,108,"E")
 .. S ARR=ARR_U_OOPS(2260,IEN,30,"E")_U_$E(OOPS(2260,IEN,29,"E"),1,45)_U
 .. S ARR=ARR_$E(OOPS(2260,IEN,37,"E"),1,50)_U
 .. S ARR=ARR_$E(OOPS(2260,IEN,38,"E"),1,50)_U_OOPS(2260,IEN,82,"E")
 .. ;V2_P15 02/19/08 llh - added lost
 .. S ARR=ARR_U_LOST
 .. S ^TMP($J,"NS",CN)=ARR K ARR
 .. S CN=CN+1
 S RESULTS=$NA(^TMP($J,"NS"))
 Q
OCCDESC(IEN) ;Get Occupation Description
 ;
 ;  Input:  IEN - IEN of the ASISTS Case number to get the Occ Desc
 ; Output:      - will be the Occupation description
 ;
 N INC,FLD
 S INC=$$GET1^DIQ(2260,IEN,52,"I")
 S FLD=$S(INC=1:111,INC=2:208,1:"")
 I 'FLD Q ""
 Q $$GET1^DIQ(2260,IEN,FLD)
DSPUTE ; Reason for Dispute Report - called from DSPUTE^OOPSGUIR
 ; code in DSPUTE^OOPSGUIF requires case to be a CA1
 N BLK36,DIS,DSPCD,F174
 S F174=$$GET1^DIQ(2260,IEN,174,"I")      ; determines lost time or not
 S F174=$S(F174=3:"LT",1:"NLT")
 S DIS=$$GET1^DIQ(2260,IEN,165.2,"I"),DSPCD=$$GET1^DIQ(2260,IEN,347)
 I $G(DIS)="" S DIS="N"
 I DIS="N" S DSPCD="zCase not disputed, no dispute code expected"
 I (DIS="Y"),DSPCD="" S DSPCD="zCase disputed, no dispute code entered"
 ;if data in State the reason in detail question and case controverted
 ;don't count, otherwise report number of entries in free text field
 S BLK36=""
 I DIS="Y",($P($G(^OOPS(2260,IEN,"CA1K",0)),U,3)) D
 .I $$GET1^DIQ(2260,IEN,165.1,"I")="Y" Q
 .S BLK36="zBlk 36 also has text entered"
 S:'$D(ARR(DSPCD,F174)) ARR(DSPCD,F174)=0
 S ARR(DSPCD,F174)=ARR(DSPCD,F174)+1
 I BLK36'="" D
 .S:'$D(ARR(BLK36,F174)) ARR(BLK36,F174)=0
 .S ARR(BLK36,F174)=ARR(BLK36,F174)+1
 Q
