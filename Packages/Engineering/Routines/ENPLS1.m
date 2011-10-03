ENPLS1 ;(WASH ISC)/SAB-DETERMINE PROJECTS ON FYFP ;5/24/95
 ;;7.0;ENGINEERING;**23**;Aug 17, 1993
FYFP(ENSN,ENFY,ENFYB,ENFYE,ENDV,ENRET) ; Five Year Facility Plan Projects
 ; Selects construction and lease projects which are part of the FYFP
 ; based on station, funding years, division, and status.
 ;
 ; required
 ;   ENSN  - station number
 ;   ENFY  - current year of FYFP (budget year - 1)
 ; optional
 ;   ENBYB - beginning offset from current year (default 0)
 ;   ENBYE - ending offset from current year (default F)
 ;   ENDV  - division screen or * for all (default *)
 ;   ENRET - contains array code(s) to return (default L)
 ;     L return projects by number
 ;       ^TMP($J,"L")=count^current year of FYFP
 ;       ^TMP($J,"L",number)=ien
 ;     Y return projects in fiscal year format
 ;       ^TMP($J,"Y",fiscal year or "F",program,number)
 ;         =ien^a/e this year^const this year
 ;     E return projects with equipment over $250K
 ;       ^TMP($J,"E",program,fiscal year,number)=ien
 N ENC,ENDA,ENIDX,ENPN,ENPR,ENPY,ENSTAT,ENSTC,ENSTL,ENX,ENY0,ENYR
 S:$G(ENFYB)="" ENFYB=0
 S:$G(ENFYE)="" ENFYE="F"
 S:$G(ENDV)="" ENDV="*"
 S:$G(ENRET)="" ENRET="L"
 I ENRET["L" K ^TMP($J,"L") S ENC=0
 I ENRET["Y" K ^TMP($J,"Y")
 I ENRET["E" K ^TMP($J,"E")
 Q:$G(ENSN)=""
 Q:$G(ENFY)=""
 I ENFYB="F",ENFYE'="F" Q
 I ENFYE'="F",ENFYB>ENFYE Q
 ; find current and plan year projects
 I ENFYB'="F" F ENYR=ENFY+ENFYB:1:ENFY+$S(ENFYE="F":5,1:ENFYE) D
 . S ENPY=ENYR
 . S ENSTC=$S(ENFY=ENYR:";6;8;9;10;11;12;13;14;15;",ENFY<ENYR:";3;5;6;8;9;10;11;12;",1:"") ; construction status list
 . S ENSTL=$S(ENFY=ENYR:"",ENFY<ENYR:";3;5;",1:"") ; lease status list
 . F ENIDX="F","G","L" D FYIDX
 ; find future year projects
 I ENFYE="F" S ENPY="F" F ENIDX="F","G","L" D
 . S ENSTC=";3;5;6;8;9;10;11;12;" ; construction status list
 . S ENSTL=";3;5;" ; lease status list
 . S ENYR=ENFY+5
 . F  S ENYR=$O(^ENG("PROJ",ENIDX,ENYR)) Q:ENYR=""  D FYIDX
 I ENRET["L",ENC S ^TMP($J,"L")=ENC_U_ENFY
 Q
FYIDX ; Get Projects for a Funding Year A/E or CONST or RENT STARTS
 S ENDA="" F  S ENDA=$O(^ENG("PROJ",ENIDX,ENYR,ENDA)) Q:ENDA=""  D
 . S ENY0=$G(^ENG("PROJ",ENDA,0))
 . S ENPN=$P(ENY0,U) I ENPN="" Q
 . S ENPR=$P(ENY0,U,6)
 . I $P(ENPN,"-")'=ENSN Q
 . I "FG"[ENIDX,"^MA^MI^MM^NR^"'[(U_ENPR_U) Q
 . I "L"[ENIDX,"^LE^"'[(U_ENPR_U) Q
 . I ENDV'="*",ENDV'=$P($G(^ENG("PROJ",ENDA,15)),U) Q
 . S ENSTAT=$P($G(^ENG("PROJ",ENDA,1)),U,3)
 . I "^MA^MI^MM^NR^"[(U_ENPR_U),ENSTC'[(";"_ENSTAT_";") Q
 . I "^LE^"[(U_ENPR_U),ENSTL'[(";"_ENSTAT_";") Q
 . I ENRET["L",'$D(^TMP($J,"L",ENPN)) S ^TMP($J,"L",ENPN)=ENDA,ENC=ENC+1
 . I ENRET["Y" D
 . . S ENX=$G(^TMP($J,"Y",ENPY,ENPR,ENPN))
 . . S $P(ENX,U)=ENDA
 . . S:ENIDX="F" $P(ENX,U,2)=1
 . . S:ENIDX="G" $P(ENX,U,3)=1
 . . S ^TMP($J,"Y",ENPY,ENPR,ENPN)=ENX
 . I ENRET["E",ENPY'="F",ENFY'=ENYR,"GL"[ENIDX,$O(^ENG("PROJ",ENDA,25,0)) S ^TMP($J,"E",ENPR,ENPY,ENPN)=ENDA
 Q
 ;ENPLS1
